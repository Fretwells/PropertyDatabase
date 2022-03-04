CREATE PROCEDURE anthony_insert_Property_Feature
@Quant int,
@PAddress varchar(50),
@FName VARCHAR(30),
@PZip varchar(9)

AS
DECLARE @P_ID INT, @F_ID INT

SET @P_ID = (SELECT PropertyID
         FROM tblPROPERTY
         WHERE PropAddress = @PAddress
         AND PropZipCode = @PZip)

SET @F_ID = (SELECT FeatureID
          FROM tblFEATURE
          WHERE FeatureName = @FName)

BEGIN TRANSACTION H1
INSERT INTO tblPROPERTY_FEATURE(PropertyID, FeatureID, Quantity)
VALUES (@P_ID, @F_ID, @Quant)
COMMIT TRANSACTION H1
GO

Select * from tblFEATURE
GO
Select * from tblPROPERTY_FEATURE
GO

EXECUTE anthony_insert_Property_Feature
@Quant = 2,
@PAddress = '6315 22nd Ave NW #6315',
@FName = 'Nature park',
@PZip = '98107'
GO

EXECUTE anthony_insert_Property_Feature
@Quant = 1,
@PAddress = '311 NE 40th St UNIT B',
@FName = 'University',
@PZip = '98105'
GO

EXECUTE anthony_insert_Property_Feature
@Quant = 1,
@PAddress = '1121 10th Ave E',
@FName = 'Botanical garden',
@PZip = '98102'
GO

EXECUTE anthony_insert_Property_Feature
@Quant = 1,
@PAddress = '1121 10th Ave E',
@FName = 'High school',
@PZip = '98102'
GO

EXECUTE anthony_insert_Property_Feature
@Quant = 1,
@PAddress = '3807 S Cloverdale St',
@FName = 'Carjacking',
@PZip = '98118'
GO


EXECUTE anthony_insert_Property_Feature
@Quant = 3,
@PAddress = '3807 S Cloverdale St',
@FName = 'parking lot',
@PZip = '98118'
GO


EXECUTE anthony_insert_Property_Feature
@Quant = 1,
@PAddress = '3807 S Cloverdale St',
@FName = 'Carjacking',
@PZip = '98118'
GO

EXECUTE anthony_insert_Property_Feature
@Quant = 15,
@PAddress = '1121 10th Ave E',
@FName = 'Homicide',
@PZip = '98102'
GO

EXECUTE anthony_insert_Property_Feature
@Quant = 27,
@PAddress = '311 NE 40th St UNIT B',
@FName = 'Carjacking',
@PZip = '98105'
GO

EXECUTE anthony_insert_Property_Feature
@Quant = 27,
@PAddress = '311 NE 40th St UNIT B',
@FName = 'Carjacking',
@PZip = '98105'
GO

EXECUTE anthony_insert_Property_Feature
@Quant = 3,
@PAddress = '311 NE 40th St UNIT B',
@FName = 'Burglary',
@PZip = '98105'
GO

EXECUTE anthony_insert_Property_Feature
@Quant = 2,
@PAddress = '6315 22nd Ave NW #6315',
@FName = 'Primary School',
@PZip = '98107'
GO
