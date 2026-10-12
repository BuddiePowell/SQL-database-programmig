#Query 2.1
USE SchoolSchedulingExample;
# Select FirstName, LastName, City and State 
# from the students table
SELECT StudFirstName, StudLastName, StudCity, StudState FROM Students
# select the students that live in 
# Dallas, Portland, San Antionio or Seattle
WHERE Studcity = 'Dallas'
OR Studcity = 'Portland'
OR Studcity = 'San Antonio'
OR  StudCity = 'Seattle'; 
# Query 2.2
USE SchoolSchedulingExample;
# Select the unique last names of all the staff
# From the Staff Table
SELECT DISTINCT StfLastName FROM Staff
Select the Staff where their last names are between the letters
WHERE StfLastname BETWEEN 'S' AND 'Z'
ORDER BY StfLastName ASC;

#Query2.3
USE SchoolSchedulingExample;
#Select everything from the Subjects table
SELECT
    *
FROM
    Subjects
    #Where categoryID is BUS, no prereq 
    #and the est class size is below 40
WHERE
    CategoryID = 'BUS'
        AND SubjectPreReq IS NULL
        AND SubjectEstClassSize < 40;
        
 #Query 2.4       
USE SchoolSchedulingExample;
# Select everything from Faculty
SELECT
*
FROM 
Faculty
#Where title is professor and tenunred = 1
where Title like '%Professor' and Tenured = '1'
#Order by title then status 
order by 'Title', 'Status';

#Query 2.5
USE SchoolSchedulingExample;
Select  StudLastName, StudBirthDate from Students
Where StudMaritalStatus = 'M'
or StudBirthDate BETWEEN '19900601' AND '19950101'
AND StudMajor = '3' 
or StudMajor = '4'; 

#Query 2.6

use SchoolSchedulingExample;
#select the last name and city of students
Select StudLastName, StudCity, StudState From Students
#Student Last Name begins with K 
# and Student City is Portland and State is Oregon
Where StudLastName LIKE 'K%' and StudCity = 'PortLand';