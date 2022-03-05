-- Shane Computed Columns

-- The number of previous renters of each property
Create Function fn_NumPrevRenters(@PK INT)
Returns INT
As
Begin
Declare @Ret INT = (
  Select Count(Distinct U.UserID)
  From tblUSER U
    Join tblPROPERTY_User PU On PU.UserID = U.UserID
    Join tblPROPERTY P On P.PropertyID = PU.PropertyID
    Join tblEVENT E On E.PropertyUserID = PU.PropertyUserID
    Join tblEVENT_TYPE ET On ET.EventTypeID = E.EventTypeID
  Where P.PropertyID = @PK
    And ET.EventTypeName = 'Rent property'
)
Return @Ret
End

Go

Alter Table tblProperty
Add NumPrevRenters
As (dbo.fn_NumPrevRenters(PropertyID))

Go

-- Track the number of previous buyers of each property

Create Function fn_NumPrevBuyers(@PK INT)
Returns INT
As
Begin
Declare @Ret INT = (
  Select Count(Distinct U.UserID)
  From tblUSER U
    Join tblPROPERTY_User PU On PU.UserID = U.UserID
    Join tblPROPERTY P On P.PropertyID = PU.PropertyID
    Join tblEVENT E On E.PropertyUserID = PU.PropertyUserID
    Join tblEVENT_TYPE ET On ET.EventTypeID = E.EventTypeID
  Where P.PropertyID = @PK
    And ET.EventTypeName = 'Buy property'
)
Return @Ret
End

Go

Alter Table tblProperty
Add NumPrevBuyers
As (dbo.fn_NumPrevBuyers(PropertyID))

Go

-- Anthony Computed Columns

--Create a computed column that calculated The number of properties that a user is listing currently[Anthony]
CREATE FUNCTION fn_count_listing(@PK INT)
RETURNS INT
AS
BEGIN

DECLARE @RET INT = (SELECT COUNT(PropertyUserID) 
                FROM tblEVENT E
                    JOIN tblEVENT_TYPE ET on E.EventTypeID = ET.EventTypeID
                WHERE ET.EventTypeName = 'List for rent'
                AND E.EventTypeID = @PK
                OR ET.EventTypeName = 'List for purchase'
                AND E.EventTypeID = @PK)
RETURN @RET
END
GO

ALTER TABLE tblUSER
ADD CC_count_listing
AS (dbo.fn_count_listing(E.EventTypeID))
GO

---Create a computed column that calculated how many houses is in each neighborhood [Anthony]
CREATE FUNCTION fn_count_houses_per_neighborhood(@PK INT)
RETURNS INT
AS
BEGIN

DECLARE @RET INT = (SELECT COUNT(PropertyID)
                    FROM tblPROPERTY P
                        JOIN tblPROPERTY_TYPE PT on P.PropertyTypeID = PT.PropertyTypeID
                        JOIN tblNEIGHBORHOOD N on P.NeighborhoodID = N.NeighborhoodID
                    WHERE PT.PropertyTypeName = 'Single Family'
                    AND P.PropertyID = @PK)
RETURN @RET
END
GO

Drop FUNCTION fn_count_houses_per_neighborhood
go

ALTER TABLE tblNEIGHBORHOOD
ADD CC_count_house
AS (dbo.fn_count_houses_per_neighborhood(P.PropertyID))
GO

-- William Computed Columns
-- Create a computed column that calculates how many apartment per neighborhood
CREATE FUNCTION fn_Calc_NumApartment_PerHood(@PK INT)
RETURNS INT
AS
BEGIN

DECLARE @RET INT = (SELECT COUNT(*) FROM tblPROPERTY P
                    JOIN tblPROPERTY_TYPE PT ON PT.PropertyTypeID = P.PropertyTypeID
                    WHERE PT.PropertyTypeName = 'Apartment'
                    AND NeighborhoodID = @PK)
RETURN @RET
END
GO

ALTER TABLE tblNEIGHBORHOOD
ADD Calc_NumApartment AS (dbo.fn_Calc_NumApartment_PerHood(NeighborhoodID))
GO

-- Created a computed column that calculates each user’s age
CREATE FUNCTION fn_Calc_Age(@PK INT)
RETURNS INT
AS
BEGIN

DECLARE @RET INT = (SELECT DATEDIFF(YEAR, BirthDate , GETDATE())
                    FROM tblUSER
                    WHERE UserID = @PK)
RETURN @RET
END
GO

ALTER TABLE tblUSER
ADD Calc_Age AS (dbo.fn_Calc_Age(UserID))
GO