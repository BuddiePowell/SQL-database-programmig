use SchoolSchedulingExample;

# 5.1 
SELECT s.SubjectID,
       s.SubjectCode,
       s.SubjectName
FROM Subjects AS s
LEFT JOIN Faculty_Subjects AS fs
  ON (s.SubjectID = fs.SubjectID)
WHERE  fs.StaffID IS NULL;

# 5.2 
select BuildingName, 
       ClassRoomID,
			 SubjectName
from Buildings
left outer join Class_Rooms 
   using (BuildingCode)
left outer join Classes 
   using (ClassRoomID)
left outer join Subjects 
   using (SubjectID);

# 5.3 

select concat(stf.StfFirstName, ' ', stf.StfLastName) as `Faculty`,
       sub.SubjectName,
       c.SemesterNumber
from Staff AS stf
left outer join (
   Faculty_Classes as fc
   inner join Classes as c 
      on (c.ClassID = fc.ClassID and SaturdaySchedule = 1)
   inner join Subjects as sub using (SubjectID)
) using (StaffID)
where Position = 'Faculty'
order by `Faculty` asc;

# 5.4

select distinct CategoryDescription
from Categories as c
inner join Subjects as s1 
   on (c.CategoryID = s1.CategoryID 
       and s1.SubjectName like '%Fundamentals%')
inner join Subjects as s2 
   on (c.CategoryID = s2.CategoryID 
       and s2.SubjectName like '%Intermediate%')
order by CategoryDescription;

# 5.5 - How many students have never with drawn from a class?

select
    concat(s.StudLastName, ', ', s.StudFirstName) as StudFullName
from
    Students as s
left outer join
    (
        select
            ss.StudentID
        from
            Student_Schedules as ss
        inner join
            Student_Class_Status as scs
            on ss.ClassStatus = scs.ClassStatus
        where
            scs.ClassStatusDescription = 'Withdrew'
    ) as wid
    on wid.StudentID = s.StudentID
where
    wid.StudentID is null;
