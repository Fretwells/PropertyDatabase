Create Procedure sf_InsertFeature
  @TypeName VARCHAR(30),
  @FeatureName VARCHAR(30),
  @FeatureDescr VARCHAR(500)
As
Begin
Declare @FTypeID INT = (
  Select FeatureTypeID
  From tblFEATURE_TYPE
  Where FeatureTypeName = @TypeName
)

Begin Transaction
Insert Into tblFeature(FeatureTypeID, FeatureName, FeatureDescr)
Values (@FTypeID, @FeatureName, @FeatureDescr)
Commit Transaction
End

Exec sf_InsertFeature
@TypeName = 'Shared Space',
@FeatureName = 'Botanical garden',
@FeatureDescr ='A garden dedicated to the collection, cultivation, preservation and display of an especially wide range of plant'

Exec sf_InsertFeature
@TypeName = 'Shared Space',
@FeatureName = 'Nature park',
@FeatureDescr ='A designation for a protected natural area by means of long-term land planning, sustainable resource management and limitation of agricultural and real estate developments.'

Exec sf_InsertFeature
@TypeName = 'Shared Space',
@FeatureName = 'National park',
@FeatureDescr ='A natural park in use for conservation purposes, created and protected by national governments.'

Exec sf_InsertFeature
@TypeName = 'Crime',
@FeatureName = 'Carjacking',
@FeatureDescr ='a robbery in which the item taken over is a motor vehicle.'

Exec sf_InsertFeature
@TypeName = 'Crime',
@FeatureName = 'Homicide',
@FeatureDescr ='An act of a person killing another person.'

Exec sf_InsertFeature
@TypeName = 'Proximity',
@FeatureName = 'Parking lot',
@FeatureDescr ='A cleared area intended for parking vehicles.'

Exec sf_InsertFeature
@TypeName = 'Proximity',
@FeatureName = 'High school',
@FeatureDescr = 'High school is the education students receive in the final stage of secondary education'

Exec sf_InsertFeature
@TypeName = 'Proximity',
@FeatureName = 'Middle school',
@FeatureDescr = 'A school providing education between primary school and secondary school.'

Exec sf_InsertFeature
@TypeName = 'Proximity',
@FeatureName = 'Primary School',
@FeatureDescr ='A school for primary education of children who are five to eleven years of age'

Exec sf_InsertFeature
@TypeName = 'Proximity',
@FeatureName = 'University',
@FeatureDescr = 'An institution that provide college education for pupils age 18 and upwards'
