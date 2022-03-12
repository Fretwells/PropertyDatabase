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
