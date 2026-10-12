use EntertainmentAgencyExample;
#Query 6.1
SELECT
    E.EntStageName AS `Stage Name`,
    CONCAT(E.EntStreetAddress, ', ', E.EntCity, ', ', E.EntState, ', ', E.EntZipCode) AS `Full Address`,
    COALESCE(EntWebPage, 'Not Available') AS `Website URL`,
    DATEDIFF(CURDATE(), E.DateEntered) AS `Days in Database`
FROM
    Entertainers as E
ORDER BY
    E.EntStageName ASC;
    
    # Query 6.2
 SELECT
    EntStageName AS 'Entertainer',
    DATE_FORMAT(MIN(StartDate), '%M %d, %Y') AS 'First Engagement',
    DATE_FORMAT(MAX(StartDate), '%M %d, %Y') AS 'Last Engagement',
    CONCAT('$', FORMAT(AVG(ContractPrice), 2)) AS 'Average Contract'
FROM
    Engagements
INNER JOIN
    Entertainers ON Engagements.EntertainerID = Entertainers.EntertainerID
GROUP BY
    EntStageName
ORDER BY
    AVG(ContractPrice) DESC;
# Query 6.3
SELECT 
    CONCAT(LEFT(a.AgtFirstName, 1), '. ', a.AgtLastName) AS 'Agent Name',
    DATE_FORMAT(e.StartDate, '%M') AS 'Engagement Start Month',
    CEILING(DATEDIFF(e.EndDate, e.StartDate) / 7.0) AS 'Engagement Span (Weeks)',
    e.ContractPrice * a.CommissionRate AS 'Agent Earnings',
    CASE
        WHEN a.CommissionRate <= 0.04 THEN 'Budget'
        WHEN a.CommissionRate > 0.04 AND a.CommissionRate <= 0.05 THEN 'Standard'
        ELSE 'Premium'
    END AS 'Commission Category'
FROM 
    Agents as a
LEFT  OUTER JOIN 
    Engagements as e ON a.AgentID = e.AgentID
ORDER BY 
    a.AgtLastName ASC, 
    `Agent Earnings` DESC;

#Query 6.4
#The puroposue of this query is to Assess the popularity of genres among entertainers 
# by examining the number of entertainers 
# per genre and their average number of engagements. 
# This information can help identify which musical 
# styles are trending and which ones may need more promotional efforts.

SELECT 
    MS.StyleName AS Genre,
    COUNT(DISTINCT ES.EntertainerID) AS NumberOfEntertainers,
    AVG(E.ContractPrice) AS AverageEarnings
FROM 
    Musical_Styles MS
INNER JOIN 
    Entertainer_Styles ES ON MS.StyleID = ES.StyleID
Left outer JOIN 
    Entertainers EN ON ES.EntertainerID = EN.EntertainerID
inner JOIN 
    Engagements E ON EN.EntertainerID = E.EntertainerID
WHERE 
    ES.StyleStrength = 1 -- Assuming StyleStrength = 1 indicates the entertainer's preferred genre
GROUP BY 
    MS.StyleName
ORDER BY 
    NumberOfEntertainers DESC, 
    AverageEarnings DESC;

#Query 6.5 
# The purposue of this query is to evaluate each of the agent's performance 
# by the number of unique customers they have served and the total 
# revenue generated, offering insight into effective client management 
# and potential areas for agent development.

SELECT 
    CONCAT(A.AgtFirstName, ' ', A.AgtLastName) AS AgentName,
    COUNT(DISTINCT C.CustomerID) AS UniqueCustomers,
    SUM(E.ContractPrice) AS TotalRevenue,
    CASE 
        WHEN AVG(A.CommissionRate) <= 0.04 THEN 'Budget'
        WHEN AVG(A.CommissionRate) > 0.04 AND AVG(A.CommissionRate) <= 0.05 THEN 'Standard'
        ELSE 'Premium'
    END AS CommissionCategory
FROM 
    Agents as A
Inner join
    Engagements as E ON A.AgentID = E.AgentID
Left Outer Join 
    Customers as C ON E.CustomerID = C.CustomerID
GROUP BY 
    AgentName
ORDER BY 
    TotalRevenue DESC;