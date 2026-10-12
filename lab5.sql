use EntertainmentAgencyExample;
#Query 5.1
#select agent first name,  agent last name
# and entertainer ID aka Unique Entertainers who belong to Karen Smith  
SELECT 
    A.AgtFirstName,
    A.AgtLastName,
    COUNT(DISTINCT Eng.EntertainerID) AS "Unique Entertainers"
FROM 
    Engagements as Eng
INNER JOIN 
    Agents as A ON Eng.AgentID = A.AgentID
WHERE 
    A.AgtFirstName = 'Karen' AND A.AgtLastName = 'Smith'
GROUP BY 
    A.AgtFirstName, A.AgtLastName;

#Query 5.2
#Show the total earnings and number of engagements for all entertainers.
# Display the highest earning entertainers first.
SELECT 
    E.EntStageName AS "Entertainer",
    SUM(ContractPrice) AS "Total Earnings"
FROM 
    Entertainers as E
left outer JOIN 
    Engagements as Eng using (EntertainerID)
GROUP BY 
    E.EntStageName
ORDER BY 
    "Total Earnings" desc;
    
    # Query 5.3a
    #Using concat combinine first name and last name of customers, rename stylename as prefered music
    # inner join Musical Prefreances as mp using the CustomerID 
    # inner join musical styles as MS on Style ID and the sequance prefrenace to '1'
    # group them by "Prefered Music" aka StyleName
SELECT GROUP_CONCAT(CustFirstName, ' ', CustLastName) AS Customer, StyleName AS Prefered_Music
FROM Customers AS c
INNER JOIN Musical_Preferences AS mp
ON c.CustomerID = mp.CustomerID
INNER JOIN Musical_Styles AS ms
ON mp.StyleID = ms.StyleID
WHERE PreferenceSeq = 1
GROUP BY Prefered_Music;

#Query 5.3b
# Select unique customer first name. Customer last name and style name from customers table
#inner join the Musical Prefrences table using customerID
#Inner join musical styles table using StyleID
#Where Prefreed Seq is 1 and order it by Prefered music
SELECT DISTINCT CustFirstName, CustLastName,
    ms.StyleName AS "Prefered_Music"
FROM 
    Customers as c
INNER JOIN 
    Musical_Preferences as mp using (CustomerID)
INNER JOIN 
    Musical_Styles ms ON mp.StyleID = ms.StyleID
WHERE 
    mp.PreferenceSeq = 1
ORDER BY 
    "Prefered_Music";

# Query 5.4
#Select first name, last name of the band memeber and their gender
#Inner join Entertainer_Memebers table as EM with the MemeberID
# group the results by MemeberID, Gender, Firstname and Last Name
#Count unique entertainerID which is greater than 2
#Order the results by Band member first name and band member last name
SELECT 
    M.MbrFirstName AS "First Name",
    M.MbrLastName AS "Last Name",
    M.Gender
FROM 
    Members as M
INNER JOIN 
    Entertainer_Members as EM ON M.MemberID = EM.MemberID
GROUP BY 
    M.MemberID, M.MbrFirstName, M.MbrLastName, M.Gender
HAVING 
    COUNT(DISTINCT EM.EntertainerID) > 2
ORDER BY 
    M.MbrFirstName, M.MbrLastName;

# Query 5.5
#Select the Stage name, Style name, the count of engagments 
#aka number of engagements and avg contract price from the Entertainers table
#Inner join the Entainter_Styles table using EntertainerID
# inner join musical_styles on styleID
#inner join engagements table using EntertainerID 
# where Music style is in "Country", "Folk", "Jazz"
# group by Stagename and Style name
# having EntertainerID is >= 8 and avg contract price is greater than 1500
# Order by Stage Name
SELECT
    E.EntStageName,
    MS.StyleName,
    COUNT(Eng.EntertainerID) AS NumberOfEngagements,
    AVG(Eng.ContractPrice) AS AverageContractRate
FROM
    Entertainers as E
INNER JOIN
    Entertainer_Styles as ES ON E.EntertainerID = ES.EntertainerID
INNER JOIN
    Musical_Styles as MS ON ES.StyleID = MS.StyleID
INNER JOIN
    Engagements as Eng ON E.EntertainerID = Eng.EntertainerID
WHERE
    MS.StyleName IN ('Country', 'Folk', 'Jazz')
GROUP BY
    E.EntStageName, MS.StyleName
HAVING
    COUNT(Eng.EntertainerID) >= 8 AND AVG(Eng.ContractPrice) > 1500
ORDER BY
    E.EntStageName;
