# Weeks 11/12 Lab Solution

use EntertainmentAgencyExample;

# Query 1: Show all entertainers and engagements (start/end date) 
# that were played for customers whose last name
# does not start with 'B' or 'H'
# Use a list subquery to filter the engagements.
# 79 rows expected

select EntStageName, StartDate, EndDate
from Entertainers
inner join Engagements 
   using (EntertainerID)
where CustomerID not in (
    select CustomerID 
    from Customers
    where CustLastName like 'B%' 
       or CustLastName like 'H%'
)
order by StartDate;

# Query 2: Show each musical style, the number of entertainers
# who play each style, and the percentage relative to the 
# total number of entertainers (e.g. # who play jazz / # of entertainers)

select StyleName,
       count(*) as `Num Entertainers`,
       concat(round(100* count(*) / 
						 (select count(*) from Entertainers), 1), '%') as `Pct Entertainers`
from Musical_Styles
inner join Entertainer_Styles 
		using (StyleID)
group by StyleName
order by StyleName;

# Query 3: Show all entertainers who have played at least (>=) as 
# many engagements that started in 2017 as Modern Dance
# This is a great example of using common table expressions.
with EngagementStats (EntStageName, NumEngagements) as (
		select EntStageName, count(*)
		from Entertainers
		inner join Engagements
			 using (EntertainerID)
		where StartDate <= '20171231'
		group by EntStageName
)
select * 
from EngagementStats
where NumEngagements >= (
    select NumEngagements 
    from EngagementStats
    where EntStageName = 'Modern Dance'
)
order by NumEngagements desc;
	
# Query 4: List all agents and the number of 
# engagements they have booked, sorted from least to most.
# Your numbers should match the table below, paying special
# attention to the first row.
select concat(AgtFirstName, ' ', AgtLastName) as Agent,
       (select count(*) from Engagements as E
        where E.AgentID = A.AgentID) as `# Booked`
from Agents as A
order by `# Booked` asc;

# Query 5: The outer join below shows all Entertainers who have
# never played an engagement in Seattle Rewrite the query to use NOT EXISTS
# to eliminate the outer join.

# ORIGINAL
select EntStageName
from Entertainers as Ent
left outer join (
    Engagements as Eng
    inner join Customers as C
        on (Eng.CustomerID = C.CustomerID and C.CustCity = 'Seattle')
) on (Ent.EntertainerID = Eng.EntertainerID)
where Eng.EngagementNumber is null
order by EntStageName;

# USING NOT EXISTS
select EntStageName
from Entertainers as Ent
where not exists (
    select * 
    from Engagements as Eng
    inner join Customers
        using (CustomerID)
		where CustCity = 'Seattle'
    and Ent.EntertainerID = Eng.EntertainerID
)
order by EntStageName;

# Query 6 Show all bands, including the names of all members of the band,
# that includes at least one member of the Viescas family.

# Using IN and a nested list subquery
# In order to show all band members, we must filter on Entertainers,
# not on Members. 
select EntStageName, 
       concat(MbrFirstName, ' ', MbrLastName) as Member
from Entertainers
inner join Entertainer_Members 
    using (EntertainerID)
inner join Members
    using (MemberID)
where EntertainerID in (
    select EntertainerID
    from Entertainer_Members
    inner join Members
       using (MemberID)
		where MbrLastName = 'Viescas'
)
order by EntStageName, Member;

# Using EXISTS and a correlated subquery
select EntStageName, 
       concat(MbrFirstName, ' ', MbrLastName) as Member
from Entertainers as E
inner join Entertainer_Members 
    using (EntertainerID)
inner join Members
    using (MemberID)
where exists (
    select *
    from Entertainer_Members as EM
    inner join Members
       using (MemberID)
		where MbrLastName = 'Viescas'
      and EM.EntertainerID = E.EntertainerID
)
order by EntStageName, Member;
