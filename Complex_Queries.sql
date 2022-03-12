-- Shane Complex Queries

-- Write a query to find the average listing price and user age of properties rented or bought by users between 20 and 30 years of age, grouped by rent vs buy.

Select ET.EventTypeName, AVG(E.Price) AvgPrice, AVG(U.UserAge) AvgAge
From tblEVENT E
  Join tblEVENT_TYPE ET On ET.EventTypeID = E.EventTypeID
  Join tblPROPERTY_USER PU On PU.PropertyUserID = E.PropertyUserID
  Join tblUSER U On U.UserID = PU.UserID
Where U.UserAge Between 20 And 30
  And (EventTypeName = 'Purchase property' Or EventTypeName = 'Rent Property')
Group By ET.EventTypeID, ET.EventTypeName

Select * From tblUser

-- Write the SQL query to find every purchase made by users who were born after 1978 and have made at least two purchases

Select qryA.PropertyID, qryA.PropAddress, qryB.Buyer, qryB.NumPurchases
From (
  Select P.PropertyID, P.PropAddress, U.UserID
  From tblPROPERTY P
    Join tblPROPERTY_USER PU On PU.PropertyID = P.PropertyID
    Join tblUSER U On U.UserID = PU.UserID
    Join tblEVENT E On E.PropertyUserID = PU.PropertyUserID
    Join tblEVENT_TYPE ET On ET.EventTypeID = E.EventTypeID
  Where U.BirthDate > '1978-01-01'
    And ET.EventTypeName = 'Purchase property'
) As qryA, (
  Select U.UserID, U.FirstName + ' ' + U.LastName As Buyer, COUNT(P.PropertyID) As NumPurchases
  From tblPROPERTY P
    Join tblPROPERTY_USER PU On PU.PropertyID = P.PropertyID
    Join tblUSER U On U.UserID = PU.UserID
    Join tblEVENT E On E.PropertyUserID = PU.PropertyUserID
    Join tblEVENT_TYPE ET On ET.EventTypeID = E.EventTypeID
  Where ET.EventTypeName = 'Purchase property'
  Group By U.UserID, U.FirstName, U.LastName
  Having COUNT(P.PropertyID) > 1
) As qryB
Where qryA.UserID = qryB.UserID

-- Anthony Complex Queries

--Write the SQL query to find all properties that have both cooling and heating system built after 2015[Anthony]
SELECT P.PropertyID, P.PropAddress
FROM tblPROPERTY P
    JOIN tblPROPERTY_AMENITY PA on P.PropertyID = PA.PropertyID
    JOIN tblAMENITY A on PA.AmenityID = A.AmenityID
    JOIN tblAMENITY_TYPE AT on A.AmenityTypeID = AT.AmenityTypeID
WHERE A.AmenityName LIKE '%Cooling'
AND A.AmenityName LIKE '%Heating'
AND P.PropBuiltYear > '2015'
GROUP BY P.PropertyID, P.PropAddress
GO--could use some help

---Write a query to find the neighborhood which has the lowest average age of users who purchase houses in that neighborhood.[Anthony]
SELECT Top(1) N.NeighborhoodName
FROM tblNEIGHBORHOOD N
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
-- Write the SQL query to find how many apartments in each neighborhood have parking spaces.
SELECT COUNT(P.PropertyID) AS Num_Apartment, N.NeighborhoodName
FROM tblPROPERTY P
JOIN tblNEIGHBORHOOD N ON N.NeighborhoodID = P.NeighborhoodID
JOIN tblPROPERTY_TYPE PT ON PT.PropertyTypeID = P.PropertyTypeID
JOIN tblPROPERTY_FEATURE PF ON P.PropertyID = PF.PropertyID
JOIN tblFEATURE F ON F.FeatureID = PF.FeatureID
JOIN tblFEATURE_TYPE FT ON FT.FeatureTypeID = F.FeatureTypeID
WHERE PT.PropertyTypeName = 'Apartment'
AND F.FeatureName = 'Garage'
AND PF.Quantity IS NOT NULL OR PF.Quantity <> 0
GROUP BY N.NeighborhoodName
GO

-- Write the SQL query to find the properties that are hottest(has most reviews) in each neighborhood
SELECT A.PropertyID, A.NeighborhoodName, A.NumReview
FROM
(SELECT P.PropertyID, N.NeighborhoodName, COUNT(R.ReviewID) AS NumReview
    FROM tblPROPERTY P
    JOIN tblPROPERTY_USER PU ON P.PropertyID = PU.PropertyID
    JOIN tblEVENT E ON PU.PropertyUserID = E.PropertyUserID
    JOIN tblREVIEW R ON E.EventID = R.EventID
    JOIN tblNEIGHBORHOOD N ON N.NeighborhoodID = P.NeighborhoodID
    GROUP BY P.PropertyID, N.NeighborhoodName) A,
(SELECT top 1 NeighborhoodName, COUNT(R.ReviewID) AS NumReview
    FROM tblPROPERTY P
    JOIN tblNEIGHBORHOOD N ON N.NeighborhoodID = P.NeighborhoodID
    JOIN tblPROPERTY_USER PU ON P.PropertyID = PU.PropertyID
    JOIN tblEVENT E ON PU.PropertyUserID = E.PropertyUserID
    JOIN tblREVIEW R ON E.EventID = R.EventID
    GROUP BY NeighborhoodName
    ORDER BY COUNT(R.ReviewID) DESC) B
WHERE A.NeighborhoodName = B.NeighborhoodName
AND A.NumReview = B.NumReview

