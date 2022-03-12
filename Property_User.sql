CREATE PROCEDURE ww_Insert_Property_User
@P_Add varchar(50),
@P_City varchar(30),
@U_Email varchar(50),
@B_Date Date,
@E_Date Date

AS
DECLARE @U_ID INT = (SELECT UserID FROM tblUSER
                    WHERE UserEmail = @U_Email),

        @P_ID INT = (SELECT PropertyID FROM tblPROPERTY
                    WHERE PropAddress = @P_Add
                    AND PropCity = @P_City)

BEGIN TRANSACTION T1
INSERT INTO tblPROPERTY_USER (UserID, PropertyID, BeginDate, EndDate)
VALUES
(@U_ID, @P_ID, @B_Date, @E_Date)
COMMIT TRANSACTION T1
GO

EXECUTE ww_Insert_Property_User
@P_Add = '911 N 95th St 909',
@P_City = 'Seattle',
@U_Email = 'ww@uw.edu',
@B_Date = '2020-01-01',
@E_Date = NULL
GO

EXECUTE ww_Insert_Property_User
@P_Add = '5607 15th Ave NE',
@P_City = 'Seattle',
@U_Email = 'MJ@gmail.com',
@B_Date = '2020-01-01',
@E_Date = NULL
GO

EXECUTE ww_Insert_Property_User
@P_Add = '11348 Durland Ave NE',
@P_City = 'Seattle',
@U_Email = 'Poor@gmail.com',
@B_Date = '2020-01-01',
@E_Date = '2022-01-01'
GO


EXECUTE ww_Insert_Property_User
@P_Add = '3807 S Cloverdale St',
@P_City = 'Seattle',
@U_Email = 'Tom@gmail.com',
@B_Date = '2015-01-01',
@E_Date = NULL
GO


EXECUTE ww_Insert_Property_User
@P_Add = '762 Hayes St APT 18',
@P_City = 'Seattle',
@U_Email = 'CC@gmail.com',
@B_Date = '2018-01-01',
@E_Date = '2019-01-01'
GO

EXECUTE ww_Insert_Property_User
@P_Add = '6224 7th Ave NW',
@P_City = 'Seattle',
@U_Email = 'CC@gmail.com',
@B_Date = '2019-01-02',
@E_Date = NULL
GO

Exec dbo.ww_Insert_Property_User
  "1090 E Watertower St #150, Meridian, ID 83642",
  "Meridian",
  "MJ@gmail.com",
  "2022-03-02",
  "2023-03-02"
Go

Exec dbo.ww_Insert_Property_User
  "201 Municipal Dr, Nampa, ID 83687",
  "Nampa",
  "Poor@gmail.com",
  "2021-03-02",
  "2023-03-02"
Go
