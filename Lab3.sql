#question 3a: the realtionship between Agents and entertainer relationship is because both of the tables have the agentID.

#Question 3b:  Yes a band memeber can be apart of more than one band, because since some of the band memebers switch around in the table, aka Many to Many relationship.

#Question 3c: Yes a Engagement can be be played for multiple customers because when looking at both of the tables table, 
#it has the customerengagement for the engagement and customer ID is in both of the tables

#Question 3d: Musical_Prefreances, Musical_Stylings and Entertainer_Styles are all in a many to many relationship. 
#because they all have StyleSmall in there either as a Primary key, or an index
use EntertainmentAgencyExample;
#query3.1

SELECT 
    EntStageName AS StageName, 
    EndDate
FROM 
    Entertainers 
INNER JOIN 
    Engagements ON Engagements.EntertainerID = Entertainers.EntertainerID
ORDER BY 
    StageName, 
    EndDate;
    
SELECT DISTINCT 
    EntFirstName AS EntertainerFirstName, 
    EntLastName AS EntertainerLastName, 
    CustFirstName AS CustomerFirstName, 
    CustLastName AS CustomerLastName
FROM 
    Engagements
INNER JOIN 
    Entertainers ON Engagements.EntertainerID = Entertainers.EntertainerID
INNER JOIN 
    Customers ON Engagements.CustomerID = Customers.CustomerID;







