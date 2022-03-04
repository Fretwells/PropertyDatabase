CREATE PROCEDURE anthony_insert_Amenity
@AName varchar(30),
@ADescr varchar(500),
@ATName varchar(30)


AS
DECLARE @AT_ID INT

SET @AT_ID = (SELECT AmenityTypeID
         FROM tblAMENITY_TYPE
         WHERE AmenityTypeName = @ATName)

BEGIN TRANSACTION H1
INSERT INTO tblAMENITY(AmenityTypeID, AmenityName, AmenityDescr)
VALUES (@AT_ID, @AName, @ADescr)
COMMIT TRANSACTION H1
GO

EXECUTE anthony_insert_Amenity
@AName = 'Dishwasher',
@ADescr ='A machine for dishwashing',
@ATName = 'Appliances'
go

EXECUTE anthony_insert_Amenity
@AName = 'Swimming pool',
@ADescr ='A pool of water for recreational activities',
@ATName = 'Private Outdoors'
go


EXECUTE anthony_insert_Amenity
@AName = 'Radiant floor heating',
@ADescr ='Warming up the room  through radiant heating coming from the floor',
@ATName = 'Climate'
go

EXECUTE anthony_insert_Amenity
@AName = 'Radiant wall heating',
@ADescr ='Warming up the room through radiant heating coming from the walls',
@ATName = 'Climate'
go

EXECUTE anthony_insert_Amenity
@AName = 'Wall hanging air conditioner',
@ADescr ='regulating the temperature through a wall hanging machine',
@ATName = 'Climate'
go

EXECUTE anthony_insert_Amenity
@AName = 'Floor mounted air conditioner',
@ADescr ='regulating the temperature through a floor hanging machine',
@ATName = 'Climate'
go

EXECUTE anthony_insert_Amenity
@AName = 'Lawn',
@ADescr ='An area of grass where children can play in',
@ATName = 'Private Outdoors'
go

EXECUTE anthony_insert_Amenity
@AName = 'Bedroom',
@ADescr ='A room dedicated for resting',
@ATName = 'Specialized Room'
go

EXECUTE anthony_insert_Amenity
@AName = 'Bathroom',
@ADescr ='A room dedicated for personal hygiene activities',
@ATName = 'Specialized Room'
go

EXECUTE anthony_insert_Amenity
@AName = 'Garage',
@ADescr ='A room dedicated for personal vehicle parking',
@ATName = 'Specialized Room'
go

EXECUTE anthony_insert_Amenity
@AName = 'Storey',
@ADescr ='Any level part of a building with a floor that could be used by people',
@ATName = 'House Metric'
go

EXECUTE anthony_insert_Amenity
@AName = 'Living Room',
@ADescr ='A room/space dedicated for sharing between residence',
@ATName = 'Specialized Room'
go

SELECT *
FROM tblAMENITY

SELECT *
FROM tblAMENITY_TYPE
SELECT *
FROM tblFEATURE_TYPE

UPDATE tblAMENITY
SET AmenityTypeID = 3
WHERE AmenityID = 2
GO
