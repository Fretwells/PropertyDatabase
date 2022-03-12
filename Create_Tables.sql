CREATE TABLE tblUSER
(UserID INTEGER IDENTITY(1,1) primary key,
LastName varchar(50) not null,
FirstName varchar(50) not null,
UserEmail varchar(50) not null,
PhoneNumber INTEGER null,
BirthDate DATE not null,
MonthlyIncome INTEGER not null)
GO

CREATE TABLE tblEVENT
(EventID INTEGER  IDENTITY(1,1) primary key,
Price INTEGER,
EventDate Date)
GO

CREATE TABLE tblEVENT_TYPE
(EventTypeID INTEGER  IDENTITY(1,1) primary key,
EventTypeName varchar(50) not null,
EventTypeDescr varchar(500) null)
GO

CREATE TABLE tblREVIEW
(ReviewID INTEGER  IDENTITY(1,1) primary key,
Content varchar(500) not null,
Date DATE not null,
StarRating INTEGER not null)
GO

CREATE TABLE tblPROPERTY_USER
(PropertyUserID INTEGER  IDENTITY(1,1) primary key,
BeginDate DATE not null,
EndDate DATE null)
GO

CREATE TABLE tblPROPERTY_AMENITY
(PropertyAmenityID INTEGER  IDENTITY(1,1) primary key,
PropertyID INT not null,
AmenityID INT not null,
Quantity INT not null)
GO

CREATE TABLE tblAmenity
(AmenityID INTEGER  IDENTITY(1,1) primary key,
AmenityTypeID INT not null,
AmenityName varchar(50) not null)
GO

CREATE TABLE tblAmenity_Type
(AmenityTypeID INTEGER  IDENTITY(1,1) primary key,
AmenityTypeName varchar(50) not null,
AmenityTypeDescr varchar(500) not null)
GO

ALTER TABLE tblAMENITY
ADD CONSTRAINT FK_AMENITY_AMENITY_TYPE
FOREIGN KEY (AmenityTypeID)
REFERENCES tblAMENITY_TYPE (AmenityTypeID)
GO

ALTER TABLE tblPROPERTY_USER
ADD UserID INT not null
CONSTRAINT FK_tblPROPERTY_USER_UserID
FOREIGN KEY(UserID) REFERENCES tblUSER (UserID)
GO

ALTER TABLE tblPROPERTY_USER
ADD PropertyID INT not null 
CONSTRAINT FK_tblPROPERTY_USER_PropertyID
FOREIGN KEY (PropertyID)
REFERENCES tblPROPERTY (PropertyID)
GO

ALTER TABLE tblEVENT
ADD EventTypeID INT not null
CONSTRAINT FK_tblEVENT_EVENTTYPEID
FOREIGN KEY (EventTypeID)
REFERENCES tblEVENT_TYPE(EventTypeID)
GO

ALTER TABLE tblEVENT
ADD PropertyUserID INT not null
CONSTRAINT FK_tblEVENT_PROPERTY_USER
FOREIGN KEY (PropertyUserID)
REFERENCES tblPROPERTY_USER(PropertyUserID)
GO

ALTER TABLE tblREVIEW
ADD EventID INT not null
CONSTRAINT FK_EVENT_REVIEW
FOREIGN KEY (EventID)
REFERENCES tblEVENT(EventID)
GO

