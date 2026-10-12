use EntertainmentAgencyExample;

# Query 6.1

CH04_Building_Listselect EntStageName, 
       SUM(ContractPrice) as `Earnings`,
       COUNT(*) as `Num Engagements`
from Entertainers
inner join Engagements 
    using (EntertainerID)
group by EntStageName
order by SUM(ContractPrice) desc
limit 5;

# Query 6.2a and 6.2b

# 6.2a using DISTINCT
select distinct StyleName
from Customers as c
inner join Musical_Preferences as mp
    on (c.CustomerID = mp.CustomerID and mp.PreferenceSeq = 1)
inner join Musical_Styles as ms
    using (StyleID)
order by StyleName;

# 6.2b, using GROUP BY
select StyleName
from Customers as c
inner join Musical_Preferences as mp
    on (c.CustomerID = mp.CustomerID and mp.PreferenceSeq = 1)
inner join Musical_Styles as ms
    using (StyleID)
group  by StyleName
order by StyleName;

# Query 6.3 

select MbrFirstName, MbrlastName, Gender
from Members 
inner join Entertainer_Members 
   using (MemberID)
group by MbrFirstName, MbrlastName, Gender
having count(*) > 2
order by MbrLastName;

# Query 6.4

select EntStageName, count(*), avg(ContractPrice)
from Entertainers
inner join Entertainer_Styles using (EntertainerID)
inner join Musical_Styles using (StyleID)
inner join Engagements using (EntertainerID)
where StyleName IN ('Country', 'Folk', 'Classic Rock & Roll')
group by EntStageName
having (count(*) >= 8 and avg(ContractPrice) > 1500);