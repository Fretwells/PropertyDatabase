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

