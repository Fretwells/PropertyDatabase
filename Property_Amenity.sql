CREATE PROCEDURE anthony_insert_Property_amenity
@Quant int,
@PAddress varchar(50),
@AName VARCHAR(30),
@PZip varchar(9)

AS
DECLARE @P_ID INT, @A_ID INT

SET @P_ID = (SELECT PropertyID
         FROM tblPROPERTY
         WHERE PropAddress = @PAddress
         AND PropZipCode = @PZip)

SET @A_ID = (SELECT AmenityID
          FROM tblAMENITY
          WHERE AmenityName = @AName)

BEGIN TRANSACTION H1
INSERT INTO tblPROPERTY_AMENITY(PropertyID, AmenityID, Quantity)
VALUES (@P_ID, @A_ID, @Quant)
COMMIT TRANSACTION H1
GO

drop procedure anthony_insert_Property_amenity
go

EXECUTE anthony_insert_Property_amenity
@Quant = 2,
@PAddress = '762 Hayes St APT 18',
@AName = 'Bedroom',
@PZip = '98109'
go

EXECUTE anthony_insert_Property_amenity
@Quant = 1,
@PAddress = '762 Hayes St APT 18',
@AName = 'Bathroom',
@PZip = '98109'
go

EXECUTE anthony_insert_Property_amenity
@Quant = 1,
@PAddress = '762 Hayes St APT 18',
@AName = 'Garage',
@PZip = '98109'
go

EXECUTE anthony_insert_Property_amenity
@Quant = 1,
@PAddress = '762 Hayes St APT 18',
@AName = 'Dishwasher',
@PZip = '98109'
go

EXECUTE anthony_insert_Property_amenity
@Quant = 1,
@PAddress = '762 Hayes St APT 18',
@AName = 'Radiant wall heating',
@PZip = '98109'
go

EXECUTE anthony_insert_Property_amenity
@Quant = 2,
@PAddress = '6224 7th Ave NW',
@AName = 'Bedroom',
@PZip = '98107'
go

EXECUTE anthony_insert_Property_amenity
@Quant = 1,
@PAddress = '6224 7th Ave NW',
@AName = 'Bathroom',
@PZip = '98107'
go

EXECUTE anthony_insert_Property_amenity
@Quant = 1,
@PAddress = '6224 7th Ave NW',
@AName = 'Floor mounted air conditioner',
@PZip = '98107'
go

EXECUTE anthony_insert_Property_amenity
@Quant = 1,
@PAddress = '6224 7th Ave NW',
@AName = 'Garage',
@PZip = '98107'
go

EXECUTE anthony_insert_Property_amenity
@Quant = 1,
@PAddress = '6224 7th Ave NW',
@AName = 'Dishwasher',
@PZip = '98107'
go

