-- Write a query to find the average listing price and user age of properties rented or bought by users between 45 and 60 years of age, grouped by rent vs buy.

Select ET.EventTypeName, AVG(E.Price) AvgPrice, AVG(U.Calc_Age) AvgAge
From tblEVENT E
  Join tblEVENT_TYPE ET On ET.EventTypeID = E.EventTypeID
  Join tblPROPERTY_USER PU On PU.PropertyUserID = E.PropertyUserID
  Join tblUSER U On U.UserID = PU.UserID
Where U.Calc_Age Between 45 And 60
Group By ET.EventTypeID, ET.EventTypeName

Select * From tblUser

-- Write the SQL query to find every purchase made by users who were born after 1978

Select P.PropertyID, P.PropAddress
From tblPROPERTY P
  Join tblPROPERTY_USER PU On PU.PropertyID = P.PropertyID
  Join tblUSER U On U.UserID = PU.UserID
  Join tblEVENT E On E.PropertyUserID = PU.PropertyUserID
  Join tblEVENT_TYPE ET On ET.EventTypeID = E.EventTypeID
Where U.BirthDate < '1978-01-01'
  And ET.EventTypeName = 'Purchase property'
