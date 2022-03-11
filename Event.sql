CREATE PROCEDURE ww_Insert_Event
@U_Email varchar(50),
@P_Add varchar(50),
@P_City varchar(50),
@ET_Name varchar(50),
@P INT,
@E_Date Date
AS

DECLARE @PU_ID INT = (SELECT PropertyUserID FROM tblPROPERTY_USER PU
                    JOIN tblUSER U ON PU.UserID = U.UserID
                    JOIN tblPROPERTY P ON P.PropertyID = PU.PropertyID
                    WHERE U.UserEmail = 'CC@gmail.com'
                    AND P.PropAddress = '762 Hayes St APT 18'
                    AND P.PropCity = 'Seattle'),

        @ET_ID INT = (SELECT EventTypeID FROM tblEVENT_TYPE
                    WHERE EventTypeName = @ET_Name)

BEGIN TRANSACTION T1
INSERT INTO tblEVENT (PropertyUserID, EventTypeID, Price, EventDate)
VALUES (@PU_ID, @ET_ID, @P, @E_Date)
COMMIT TRANSACTION T1
GO

EXEC ww_Insert_Event
@U_Email = 'ww@uw.edu',
@P_Add = '911 N 95th St 909',
@P_City = 'Seattle',
@ET_Name = 'Purchase property',
@P = 300000,
@E_Date = '2020-01-01'
GO

EXEC ww_Insert_Event
@U_Email = 'MJ@gmail.com',
@P_Add = '5607 15th Ave NE',
@P_City = 'Seattle',
@ET_Name = 'Become Lister',
@P = NULL,
@E_Date = '2020-01-01'
GO

EXEC ww_Insert_Event
@U_Email = 'MJ@gmail.com',
@P_Add = '5607 15th Ave NE',
@P_City = 'Seattle',
@ET_Name = 'List for purchase',
@P = 1000000,
@E_Date = '2020-01-01'
GO

EXEC ww_Insert_Event
@P_Add = '11348 Durland Ave NE',
@P_City = 'Seattle',
@U_Email = 'Poor@gmail.com',
@ET_Name = 'Rent property',
@P = 50,
@E_Date = '2020-01-01'
GO

EXEC ww_Insert_Event
@P_Add = '3807 S Cloverdale St',
@P_City = 'Seattle',
@U_Email = 'Tom@gmail.com',
@ET_Name = 'Purchase property',
@P = 500000,
@E_Date = '2015-01-01'
GO

EXEC ww_Insert_Event
@P_Add = '762 Hayes St APT 18',
@P_City = 'Seattle',
@U_Email = 'CC@gmail.com',
@ET_Name = 'Purchase property',
@P = 1500000,
@E_Date = '2018-01-01'
GO

EXEC ww_Insert_Event
@P_Add = '762 Hayes St APT 18',
@P_City = 'Seattle',
@U_Email = 'CC@gmail.com',
@ET_Name = 'Become Lister',
@P = NULL,
@E_Date = '2019-01-01'
GO

EXEC ww_Insert_Event
@P_Add = '762 Hayes St APT 18',
@P_City = 'Seattle',
@U_Email = 'CC@gmail.com',
@ET_Name = 'List for Purchase',
@P = 2000000,
@E_Date = '2019-01-01'
GO

EXEC ww_Insert_Event
@P_Add = '6224 7th Ave NW',
@P_City = 'Seattle',
@U_Email = 'CC@gmail.com',
@ET_Name = 'Purchase Property',
@P = 1000000,
@E_Date = '2019-01-02'
GO

Exec dbo.ww_Insert_Event
  "MJ@gmail.com",
  "1090 E Watertower St #150, Meridian, ID 83642",
  "Meridian",
  "Purchase property",
  150000,
  "2022-03-02"
Go

Exec dbo.ww_Insert_Event
  "Poor@gmail.com",
  "201 Municipal Dr, Nampa, ID 83687",
  "Nampa",
  "Purchase property",
  15000,
  "2021-03-02"
Go
