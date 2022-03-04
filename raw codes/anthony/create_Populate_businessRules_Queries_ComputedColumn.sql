CREATE TABLE tblPROPERTY
(PropertyID INTEGER IDENTITY(1,1) primary key,
NeighborhoodID INT NOT NULL FOREIGN KEY REFERENCES tblNEIGHBORHOOD(NeighborhoodID),
PropertyTypeID INT NOT NULL FOREIGN KEY REFERENCES tblPROPERTY_TYPE(PropertyTypeID),
 PropAddress varchar(50) NOT NULL,
 PropCity varchar(30) NOT NULL,
 PropState varchar(20)NOT NULL,
 PropZipcode varchar(9)NOT NULL,
 PropBuiltyear varchar(4) NOT NULL
 )
 GO

 drop table tblPROPERTY

 Create TABLE tblPROPERTY_TYPE
 (
     PropertyTypeID INTEGER　IDENTITY(1,1) primary key,
     PropertyName varchar(30) NOT NULL,
     PropertyDescr varchar(500) NULL
 )
 GO

Create TABLE tblFEATURE_TYPE
(
    FeatureTypeID INTEGER IDENTITY(1,1) primary key,
    FeatureTypeName varchar(30) not null,
    FeatureTypeDescr varchar(500) null
)
GO

Create TABLE tblFEATURE
(
    
    FeatureID INTEGER IDENTITY(1,1) primary key,
    FeatureTypeID INT NOT NULL FOREIGN KEY REFERENCES tblFEATURE_TYPE(FeatureTypeID),
    FeatureName varchar(30) not null,
    FeatureDescr varchar(500) null
)
GO

Create TABLE tblPROPERTY_FEATURE
(
    
    PropertyFeatureID INTEGER IDENTITY(1,1) primary key,
    PropertyID INT NOT NULL FOREIGN KEY REFERENCES tblPROPERTY(PropertyID),
    FeatureID INT NOT NULL FOREIGN KEY REFERENCES tblFEATURE(FeatureID),
    Quantity INT
)
GO

 drop table tblPROPERTY_FEATURE

 Create TABLE tblAMENITY_TYPE
(
    
    AmenityTypeID INTEGER IDENTITY(1,1) primary key,
    AmenityTypeName varchar(30) not null,
    AmenityTypeDescr varchar(500) null
)
GO

Create TABLE tblAMENITY
(
    
    AmenityID INTEGER IDENTITY(1,1) primary key,
    AmenityTypeID INT NOT NULL FOREIGN KEY REFERENCES tblAMENITY_TYPE(AmenityTypeID),
    AmenityName varchar(30) not null,
    AmenityDescr varchar(500) null
)
GO

Create TABLE tblPROPERTY_AMENITY
(
    
    PropertyAmenityID INTEGER IDENTITY(1,1) primary key,
    PropertyID INT NOT NULL FOREIGN KEY REFERENCES tblPROPERTY(PropertyID),
    AmenityID INT NOT NULL FOREIGN KEY REFERENCES tblAMENITY(AmenityID),
    Quantity INT
)
GO

ALTER TABLE tblEVENT ADD PropertyUserID INT NOT NULL
go
ALTER TABLE tblEVENT ADD FOREIGN KEY (PropertyUserID) REFERENCES tblPROPERTY_USER(PropertyUserID)
go


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

--Write the SQL query to find all properties that have both cooling and heating system built after 2015[Anthony]
SELECT P.PropertyID, P.PropertyName, P.PropAddress
FROM tblPROPERTY P
    JOIN tblPROPERTY_AMENITY PA on P.PropertyID = PA.PropertyID
    JOIN tblAMENITY A on PA.AmenityID = A.AmenityID
    JOIN tblAMENITY_TYPE AT on A.AmenityTypeID = AT.AmenityTypeID
WHERE A.AmenityName LIKE '%Cooling'
AND A.AmenityName LIKE '%Heating'
AND P.PropBuiltYear > '2015'
GROUP BY P.PropertyID, P.PropertyName, P.PropAddress
GO--could use some help

---Write a query to find the neighborhood which has the lowest average age of users who purchase houses in that neighborhood.[Anthony]
SELECT Top(1) N.NeighborhoodName
FROM tbleNEIGHBORHOOD N
    JOIN tblPROPERTY P on N.NeighborhoodID = P.NeighborhoodID
    JOIN tblPROPERTY_USER PU on P.PropertyID = PU.PropertyID
    JOIN tblUSER U on PU.UserID = U.UserID
    JOIN tblEVENT E on PU.PropertyUserId = E.PropertyUserID
    JOIN tblEVENT_TYPE ET on E.EventTypeID = ET.EventTypeID
WHERE ET.EventTypeName = 'Renting'
GROUP BY N.NeighborhoodName
ORDER BY AVG(U.MonthlyIncome)
GO -- could also use some help






SELECT *
FROM tblPROPERTY_TYPE
GO

ALTER TABLE tblPROPERTY_TYPE
ADD PropertyTypeName varchar(50)

ALTER TABLE tblPROPERTY_TYPE
ADD PropertyTypeDescr varchar(500)

select *
from tblPROPERTY
go
select *
from tblNEIGHBORHOOD
GO
select*
from tblPROPERTY_TYPE
Go
CREATE PROCEDURE anthony_insert_Property
@PAdderss varchar(50),
@PCity varchar(30),
@PState varchar(20),
@PZipcode varchar(9),
@PBuiltYear char(4),
@NName varchar(30),
@PTName varchar(50)

AS
DECLARE @N_ID INT, @PT_ID INT

SET @N_ID = (SELECT NeighborhoodID
         FROM tblNEIGHBORHOOD
         WHERE NeighborhoodName = @NName)

SET @PT_ID = (SELECT PropertyTypeID
          FROM tblPROPERTY_TYPE
          WHERE PropertyTypeName = @PTName)

BEGIN TRANSACTION H1
INSERT INTO tblPROPERTY(NeighborhoodID, PropertyTypeID, PropAddress, PropCity, PropState, PropZipcode, PropBuiltyear)
VALUES (@N_ID, @PT_ID, @PAdderss, @PCity, @PState, @PZipcode, @PBuiltYear)
COMMIT TRANSACTION H1
GO

DROP PROCEDURE anthony_insert_Property
go

--https://www.zillow.com/homedetails/3807-S-Cloverdale-St-Seattle-WA-98118/2077548865_zpid/


EXECUTE anthony_insert_Property
@PAdderss = '911 N 95th St 909',
@PCity = 'Seattle',
@PState = 'WA',
@PZipcode = '98103',
@PBuiltYear = '1999',
@NName = 'Greenwood',
@PTName = 'Townhouse'
GO

EXECUTE anthony_insert_Property
@PAdderss = '11348 Durland Ave NE',
@PCity = 'Seattle',
@PState = 'WA',
@PZipcode = '98125',
@PBuiltYear = '1921',
@NName = 'Olympic Hill',
@PTName = 'Single Family'
GO

EXECUTE anthony_insert_Property
@PAdderss = '3807 S Cloverdale St',
@PCity = 'Seattle',
@PState = 'WA',
@PZipcode = '98118',
@PBuiltYear = '2020',
@NName = 'Rainier Valley',
@PTName = 'Townhouse'
GO


EXECUTE anthony_insert_Property
@PAdderss = '3807 S Cloverdale St',
@PCity = 'Seattle',
@PState = 'WA',
@PZipcode = '98118',
@PBuiltYear = '2020',
@NName = 'Rainier Valley',
@PTName = 'Townhouse'
GO

--https://www.zillow.com/homedetails/762-Hayes-St-APT-18-Seattle-WA-98109/49101737_zpid/
EXECUTE anthony_insert_Property
@PAdderss = '762 Hayes St APT 18',
@PCity = 'Seattle',
@PState = 'WA',
@PZipcode = '98109',
@PBuiltYear = '1977',
@NName = 'Queen Anne',
@PTName = 'Condominium'
GO

--https://www.zillow.com/homedetails/6224-7th-Ave-NW-Seattle-WA-98107/48824487_zpid/
EXECUTE anthony_insert_Property
@PAdderss = '6224 7th Ave NW',
@PCity = 'Seattle',
@PState = 'WA',
@PZipcode = '98107',
@PBuiltYear = '1909',
@NName = 'Ballard',
@PTName = 'Single Family'
GO
--https://www.zillow.com/homedetails/311-NE-40th-St-UNIT-B-Seattle-WA-98105/2065735607_zpid/
EXECUTE anthony_insert_Property
@PAdderss = '311 NE 40th St UNIT B',
@PCity = 'Seattle',
@PState = 'WA',
@PZipcode = '98105',
@PBuiltYear = '2015',
@NName = 'Northlake',
@PTName = 'Apartment'
GO
--https://www.zillow.com/homedetails/6315-22nd-Ave-NW-6315-Seattle-WA-98107/2065739065_zpid/
EXECUTE anthony_insert_Property
@PAdderss = '6315 22nd Ave NW #6315',
@PCity = 'Seattle',
@PState = 'WA',
@PZipcode = '98107',
@PBuiltYear = '2015',
@NName = 'Ballard',
@PTName = 'Apartment'
GO
--https://www.zillow.com/homedetails/6315-22nd-Ave-NW-6315-Seattle-WA-98107/2065739065_zpid/
EXECUTE anthony_insert_Property
@PAdderss = '1121 10th Ave E',
@PCity = 'Seattle',
@PState = 'WA',
@PZipcode = '98102',
@PBuiltYear = '2013',
@NName = 'Capitol Hill',
@PTName = 'Single Family'
GO

DELETE FROM tblPROPERTY WHERE PropertyID = 77
go

BEGIN TRANSACTION H1
INSERT INTO tblPROPERTY(NeighborhoodID, PropertyTypeID, PropAddress, PropCity, PropState, PropZipcode, PropBuiltyear)
VALUES (9, 6, '911 N 95th St #909', 'Seattle', 'WA', '98103', '1999')
COMMIT TRANSACTION H1
GO

BEGIN TRANSACTION 
INSERT INTO tblNEIGHBORHOOD(NeighborhoodName)
VALUES('Ballard')
COMMIT TRANSACTION
GO

DELETE FROM tblNEIGHBORHOOD WHERE NeighborhoodName = 'Greenwood' AND NeighborhoodID = 10
GO

DELETE FROM tblPROPERTY_TYPE WHERE PropertyTypeName = 'Townhouse' AND PropertyTypeID = 7
GO

SELECT *
FROM tblPROPERTY01
GO

BEGIN TRANSACTION 
INSERT INTO tblPROPERTY_TYPE(PropertyTypeName, PropertyTypeDescr)
VALUES('Townhouse', 'A townhouse is a cross between a single-family home and acondo. They’re typically two or three stories tall and share walls with the next-doorproperties, but they don’t have any units above or below them.')
COMMIT TRANSACTION
GO

ALTER TABLE tblPROPERTY
ALTER COLUMN PropBuiltyear varchar(4);
go

ALTER TABLE tblNEIGHBORHOOD
DROP
go

UPDATE tblNEIGHBORHOOD SET NeighborhoodID = 8 WHERE NeighborhoodName = 'Greenwood';
GO

ALTER TABLE tblNEIGHBORHOOD AUTO_INCREMENT = number;
go
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

DROP PROCEDURE 
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

CREATE TABLE tblPROPERTY01
(PropertyID INTEGER IDENTITY(1,1) primary key,
NeighborhoodID INT NOT NULL FOREIGN KEY REFERENCES tblNEIGHBORHOOD(NeighborhoodID),
PropertyTypeID INT NOT NULL FOREIGN KEY REFERENCES tblPROPERTY_TYPE(PropertyTypeID),
 PropAddress varchar(50) NOT NULL,
 PropCity varchar(30) NOT NULL,
 PropState varchar(20)NOT NULL,
 PropZipcode varchar(9)NOT NULL,
 PropBuiltyear varchar(4) NOT NULL
 )
 GO

Alter Table tblPROPERTY01
Add NumPrevRenters
As (dbo.fn_NumPrevRenters(PropertyID))

Go

Alter Table tblPROPERTY01
Add NumPrevBuyers
As (dbo.fn_NumPrevBuyers(PropertyID))
Go

DROP TABLE tblPROPERTY01
GO

ALTER TABLE tblPROPERTY   
DROP CONSTRAINT    
GO  

Select *
from tblPROPERTY_AMENITY
go

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


Select * from tblAMENITY
GO

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