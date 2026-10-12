#query 4.1
use EntertainmentAgencyExample;
select MbrFirstName, MbrLastName, C.CustFirstName, C.CustLastName
from Customers as C
inner join Members as Mbr ON CustLastName = MbrLastName;

#query 4.2
SELECT 
    E.EntStageName
FROM 
    Entertainers as E
JOIN 
    Entertainer_Styles as ES1 ON E.EntertainerID = ES1.EntertainerID
JOIN 
    Musical_Styles as MS1 ON ES1.StyleID = MS1.StyleID AND MS1.StyleName = 'Standards'
JOIN 
    Entertainer_Styles as ES2 ON E.EntertainerID = ES2.EntertainerID
JOIN 
    Musical_Styles as MS2 ON ES2.StyleID = MS2.StyleID AND MS2.StyleName = 'Show Tunes';

#query 4.3 
SELECT 
    Ent.EntStageName
FROM 
    Entertainers AS Ent
LEFT OUTER JOIN 
    (SELECT 
        Eng.EntertainerID
     FROM 
        Engagements AS Eng
     INNER JOIN 
        Customers AS Cust Using (CustomerID)
     WHERE 
        Cust.CustFirstName = 'Sarah' AND Cust.CustLastName = 'Thompson') AS EngThompson
ON 
    Ent.EntertainerID = EngThompson.EntertainerID
WHERE 
    EngThompson.EntertainerID IS NULL;
    
#Query 4.4 
SELECT
    E.EntStageName AS "Band Name",
    C.CustFirstName, C.CustLastName,
    A.AgtFirstName, A.AgtLastName,
    Eng.StartDate AS "Start Date",
    ContractPrice AS "Contract Price"
FROM
    Engagements as Eng
INNER JOIN Entertainers as E using (EntertainerID)
INNER JOIN Customers as C using (CustomerID)
INNER JOIN Agents as A using (AgentID)
WHERE
    Eng.StartDate between '20180201' AND '20180228'
ORDER BY
    Eng.StartDate ASC;
    
    # Qurey 4.5
SELECT
    E.EntStageName AS "Band Name",
    MS.StyleName AS "Top Musical Style",
    M.MbrFirstName AS "First Name",
    M.MbrLastName AS "Last Name",
    M.Gender
FROM
    Entertainers E
INNER JOIN
    Entertainer_Styles ES ON E.EntertainerID = ES.EntertainerID
INNER JOIN
    Musical_Styles MS ON ES.StyleID = MS.StyleID
LEFT JOIN
    Entertainer_Members EM ON E.EntertainerID = EM.EntertainerID
LEFT JOIN
    Members M ON EM.MemberID = M.MemberID AND M.Gender = 'M'
WHERE
    ES.StyleStrength = 1
ORDER BY
    E.EntStageName DESC
LIMIT 25;

