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