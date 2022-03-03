Create Procedure usp_insertFeatureType
  @name VarChar(30),
  @descr VarChar(500)
As
Begin
Begin Transaction
Insert Into tblFEATURE_TYPE(FeatureTypeName, FeatureTypeDescr)
Values (@name, @descr)
Commit Transaction
End

Delete From tblFEATURE_TYPE

Exec usp_insertFeatureType
  "Proximity",
  "Denotes a building or attraction that is close to the property"

Exec usp_insertFeatureType
  "Security",
  "A community security enhancement"

Exec usp_insertFeatureType
  "Shared Space",
  "A space shared between community members"

Exec usp_insertFeatureType
  "Crime",
  "A crime that has occurred near the property"

Exec usp_insertFeatureType
  "Nature",
  "The type of flora or fauna present in the community"

Select * From tblFEATURE_TYPE