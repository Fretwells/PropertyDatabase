-- Shane Business Rules

-- You can only have one user who rents/owns the property at any given time.

Create Function fn_IsOccupiedByOnlyOne()
Returns INT
As
Begin
Declare @Ret INT = 0
If Exists (
  Select *
  From tblPROPERTY_USER PU
    Join tblPROPERTY P On P.PropertyID = PU.PropertyID
    Join tblUSER U On U.UserID = PU.UserID
    Join tblEvent E On E.PropertyUserID = PU.PropertyUserID
    Join tblEvent_Type ET On ET.EventTypeID = E.EventTypeID
  Where (ET.EventTypeName = 'Purchase property' Or ET.EventTypeName = 'Rent property')
    And GETDATE() Between PU.BeginDate And PU.EndDate
  Group By P.PropertyID
  Having COUNT(Distinct U.UserID) > 1
) Set @Ret = 1
Return @Ret
End

Go

Alter Table tblEvent
Add Constraint IsOccupiedByOnlyOne
Check (dbo.fn_IsOccupiedByOnlyOne() = 0)

Go

-- Listers cannot list a property as both for sale and for rent.

Create Function fn_IsListedSingleType()
Returns INT
As
Begin
Declare @Ret INT = 0
If Exists (
  Select *
  From tblEVENT_TYPE ET
    Join tblEVENT E On E.EventTypeID = ET.EventTypeID
    Join tblPROPERTY_USER PU On PU.PropertyUserID = E.PropertyUserID
    Join tblProperty P On P.PropertyID = PU.PropertyID
  Where E.EventName = 'List for rent'
     Or E.EventName = 'List for purchase'
  Group By P.PropertyID
  Having COUNT(Distinct E.EventID) > 1
) Set @Ret = 1
Return @Ret
End

Go

Alter Table tblProperty
Add Constraint IsListedSingleType
Check (dbo.fn_IsListedSingleType() = 0)

Go

-- Anthony Business Rules

--Business rule: Users below the age of 18 are not valid users

CREATE FUNCTION fn_No_User_below_18()
RETURNS INT
AS
BEGIN

DECLARE @RET INT = 0
    IF EXISTS(SELECT *
             FROM tblUSER
             WHERE BirthDate > DATEADD(day, -18*365, GETDATE()))
        BEGIN
            SET @RET = 1
        END
RETURN @RET
END
GO

ALTER TABLE tblUSER
ADD CONSTRAINT ck_no_User_below_18
CHECK(dbo.fn_No_User_below_18() = 0)
GO

---Business rule: Users’ monthly income must be larger than the price[Anthony]

CREATE FUNCTION fn_income_LargerThan_Price()
RETURNS INT
AS
BEGIN

DECLARE @RET INT = 0
    IF EXISTS(SELECT *
            FROM tblUSER U
                JOIN tblPROPERTY_USER PU on U.UserID = PU.UserID
                JOIN tblEVENT E on PU.PropertyUserID = E.PropertyUserID
                JOIN tblEVENT_TYPE ET on E.EventTypeID = ET.EventTypeID
            WHERE ET.EventTypeName = 'Rent property'
            AND U.MonthlyIncome < E.Price
            OR ET.EventTypeName = 'Purchase property'
            AND E.Price > U.MonthlyIncome * 50)
        BEGIN
            SET @RET = 1
        END
RETURN @RET
END
GO

ALTER TABLE tblEVENT
ADD CONSTRAINT ck_income_LargerThan_Price
CHECK(dbo.fn_income_LargerThan_Price() = 0)
GO

-- William Business Rules

