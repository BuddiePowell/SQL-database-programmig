use SchoolSchedulingExample;
SELECT SubjectCode as 'Code',  
 SubjectName as 'Course Name',
 SubjectEstClassSize as 'Estimated Size' 
from Subjects
order by SubjectEstClassSize desc

limit 10;
