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

DROP PROCEDURE 
go


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

Select * from tblAMENITY
GO
