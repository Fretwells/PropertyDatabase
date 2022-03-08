Create Procedure sf_Insert_Review
  @Content VARCHAR(500),
  @ReviewDate DATE,
  @Stars INT,
  @UserEmail VARCHAR(50),
  @PropAddress VARCHAR(50),
  @PropCity VARCHAR(50),
  @EventName VARCHAR(50),
  @EventDate DATE
As

Declare @E_ID INT = (
  Select EventID
  From tblEVENT E
    Join tblPROPERTY_USER PU On PU.PropertyUserID = E.PropertyUserID
    Join tblEVENT_TYPE ET On ET.EventTypeID = E.EventTypeID
    Join tblUSER U On U.UserID = PU.UserID
    Join tblPROPERTY P On P.PropertyID = PU.PropertyID
  Where U.UserEmail = @UserEmail
    And P.PropAddress = @PropAddress
    And P.PropCity = @PropCity
    And E.EventDate = @EventDate
    And ET.EventTypeName = @EventName
)

Begin Transaction T1
Insert Into tblREVIEW (EventID, Content, [Date], StarRating)
Values (@E_ID, @Content, @ReviewDate, @Stars)
Commit Transaction T1

Go

Delete From tblREVIEW

Exec sf_Insert_Review
  @Content = 'Great Purchase. I love the house',
  @ReviewDate = '2020-01-01',
  @Stars = 5,
  @UserEmail = 'ww@uw.edu',
  @PropAddress = '911 N 95th St 909',
  @PropCity = 'Seattle',
  @EventName = 'Purchase property',
  @EventDate = '2020-01-01'

Exec sf_Insert_Review
  @Content = 'Fantastic property. The lowest price I ever seen',
  @ReviewDate = '2015-01-01',
  @Stars = 5,
  @UserEmail = 'Tom@gmail.com',
  @PropAddress = '3807 S Cloverdale St',
  @PropCity = 'Seattle',
  @EventName = 'Purchase property',
  @EventDate = '2015-01-01'

Exec sf_Insert_Review
  @Content = 'A bit expensive',
  @ReviewDate = '2018-01-01',
  @Stars = 5,
  @UserEmail = 'CC@gmail.com',
  @PropAddress = '762 Hayes St APT 18',
  @PropCity = 'Seattle',
  @EventName = 'Purchase property',
  @EventDate = '2018-01-01'

Exec sf_Insert_Review
  @Content = 'not a bad rent',
  @ReviewDate = '2020-01-01',
  @Stars = 5,
  @UserEmail = 'Poor@gmail.com',
  @PropAddress = '11348 Durland Ave NE',
  @PropCity = 'Seattle',
  @EventName = 'Rent property',
  @EventDate = '2020-01-01'

Exec sf_Insert_Review
  @Content = 'Bad price',
  @ReviewDate = '2019-01-02',
  @Stars = 1,
  @UserEmail = 'CC@gmail.com',
  @PropAddress = '6224 7th Ave NW',
  @PropCity = 'Seattle',
  @EventName = 'Purchase Property',
  @EventDate = '2019-01-02'

Select * From tblREVIEW