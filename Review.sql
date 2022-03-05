CREATE PROCEDURE sf_Insert_Review
@Con varchar(500),
@Date Date,
@S_Rate INT,
@U_Email varchar(50),
@P_Add varchar(50),
@P_City varchar(50),
@E_Date Date,
@E_Name varchar(50)


AS

DECLARE @E_ID INT = (SELECT EventID FROM tblEVENT E
                JOIN tblPROPERTY_USER PU ON PU.PropertyUserID = E.PropertyUserID
                JOIN tblEVENT_TYPE ET ON ET.EventTypeID = E.EventTypeID
                JOIN tblUSER U ON U.UserID = PU.UserID
                JOIN tblPROPERTY P ON P.PropertyID = PU.PropertyID
                    WHERE U.UserEmail = @U_Email
                    AND P.PropAddress = @P_Add
                    AND P.PropCity = @P_City
                    AND E.EventDate = @E_Date
                    AND ET.EventTypeName = @E_Name)

BEGIN TRANSACTION T1
INSERT INTO tblREVIEW (EventID, Content, Date, StarRating)
VALUES
(@E_ID, @Con, @Date, @S_Rate)
COMMIT TRANSACTION T1
GO

EXEC sf_Insert_Review
@Con = 'Great Purchase. I love the house',
@Date = '2020-01-01',
@S_Rate = 5 ,
@U_Email = 'ww@uw.edu',
@P_Add = '911 N 95th St 909',
@P_City = 'Seattle',
@E_Name = 'Purchase property',
@E_Date = '2020-01-01'

EXEC sf_Insert_Review
@Con = 'Fantastic property. The lowest price I ever seen',
@Date = '2015-01-01',
@S_Rate = 5 ,
@P_Add = '3807 S Cloverdale St',
@P_City = 'Seattle',
@U_Email = 'Tom@gmail.com',
@E_Name = 'Purchase property',
@E_Date = '2015-01-01'

EXEC sf_Insert_Review
@Con = 'A bit expensive',
@Date = '2018-01-01',
@S_Rate = 5 ,
@P_City = 'Seattle',
@U_Email = 'CC@gmail.com',
@E_Name = 'Purchase property',
@P_Add = '762 Hayes St APT 18',
@E_Date = '2018-01-01'

EXEC sf_Insert_Review
@Con = 'not a bad rent',
@Date = '2020-01-01',
@S_Rate = 5 ,
@P_Add = '11348 Durland Ave NE',
@P_City = 'Seattle',
@U_Email = 'Poor@gmail.com',
@E_Name = 'Rent property',
@E_Date = '2020-01-01'

EXEC sf_Insert_Review
@Con = 'Bad price',
@Date = '2019-01-02',
@S_Rate = 1 ,
@P_Add = '6224 7th Ave NW',
@P_City = 'Seattle',
@U_Email = 'CC@gmail.com',
@E_Name = 'Purchase Property',
@E_Date = '2019-01-02'
