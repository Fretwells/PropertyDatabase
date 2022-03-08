CREATE PROCEDURE anthony_insert_Feature
@FName varchar(30),
@FDescr varchar(500),
@FTName varchar(30)


AS
DECLARE @FT_ID INT

SET @FT_ID = (SELECT FeatureTypeID
         FROM tblFEATURE_TYPE
         WHERE FeatureTypeName = @FTName)

BEGIN TRANSACTION H1
INSERT INTO tblFEATURE(FeatureTypeID, FeatureName, FeatureDescr)
VALUES (@FT_ID, @FName, @FDescr)
COMMIT TRANSACTION H1
GO

EXECUTE anthony_insert_Feature
@FName = 'Primary School',
@FDescr ='A school for primary education of children who are five to eleven years of age',
@FTName = 'Proximity'
go

EXECUTE anthony_insert_Feature
@FName = 'Botanical garden',
@FDescr ='A garden dedicated to the collection, cultivation, preservation and display of an especially wide range of plant',
@FTName = 'Shared Space'
go

EXECUTE anthony_insert_Feature
@FName = 'Nature park',
@FDescr ='A designation for a protected natural area by means of long-term land planning, sustainable resource management and limitation of agricultural and real estate developments.',
@FTName = 'Shared Space'
go



EXECUTE anthony_insert_Feature
@FName = 'National park',
@FDescr ='a natural park in use for conservation purposes, created and protected by national governments.',
@FTName = 'Shared Space'
go

EXECUTE anthony_insert_Feature
@FName = 'Carjacking',
@FDescr ='a robbery in which the item taken over is a motor vehicle.',
@FTName = 'Crime'
go

EXECUTE anthony_insert_Feature
@FName = 'Homicide',
@FDescr ='An act of a person killing another person.',
@FTName = 'Crime'
go

EXECUTE anthony_insert_Feature
@FName = 'Homicide',
@FDescr ='An act of a person killing another person.',
@FTName = 'Crime'
go

EXECUTE anthony_insert_Feature
@FName = 'Parking lot',
@FDescr ='A cleared area intended for parking vehicles.',
@FTName = 'Proximity'
go

EXECUTE anthony_insert_Feature
@FName = 'High school',
@FDescr = 'High school is the education students receive in the final stage of secondary education',
@FTName = 'Proximity'
go

EXECUTE anthony_insert_Feature
@FName = 'Middle school',
@FDescr = 'A school providing education between primary school and secondary school.',
@FTName = 'Proximity'
go

EXECUTE anthony_insert_Feature
@FName = 'University',
@FDescr = 'A eneity that provide college education for pupils age 18 and upwards',
@FTName = 'Proximity'
go
 


Select *
from tblFEATURE
Select *
FRom tblFEATURE_TYPE

