-- Shane Complex Queries

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

-- Anthony Complex Queries

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

-- William Complex Queries
