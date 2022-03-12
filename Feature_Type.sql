Create Procedure sf_insertFeatureType
  @name VarChar(30),
  @descr VarChar(500)
As
Begin
Begin Transaction
Insert Into tblFEATURE_TYPE(FeatureTypeName, FeatureTypeDescr)
Values (@name, @descr)
Commit Transaction
End

Go

Delete From tblFEATURE_TYPE

Exec sf_insertFeatureType
  "Proximity",
  "Denotes a building or attraction that is close to the property"

Exec sf_insertFeatureType
  "Security",
  "A community security enhancement"

Exec sf_insertFeatureType
  "Shared Space",
  "A space shared between community members"

Exec sf_insertFeatureType
  "Crime",
  "A crime that has occurred near the property"

Exec sf_insertFeatureType
  "Nature",
  "The type of flora or fauna present in the community"

Select * From tblFEATURE_TYPE