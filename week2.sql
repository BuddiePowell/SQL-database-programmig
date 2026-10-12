# Week 3 template for interactive queries
use EntertainmentAgencyExample;

# Show all the information for agents...

# ... who live in Seattle
select * from Agents
where AgtCity = 'Seattle';

# ... whose zip code is not 98125
select * from Agents
where AgtZipCode != '98125';

# ... whose salary is no more than $30,000
select * from Agents
where Salary <= 30000;

# ... who was hired on or after 06/01/1997 and up to 03/01/1998
select * from Agents
where DateHired between '19970601' and '19980301'; #make sure your date format is recognized

# ... who live in Redmond or Tacoma
select * from Agents
where AgtCity in ('Redmond', 'Tacoma');

# ... who lives on a "Road"
select * from Agents
where AgtStreetAddress like '% road%';

# ... whose salary, plus their commission on $1,000,000 in bookings,
#     is at least $75,000 (3 rows)
select * from Agents
where Salary + (CommissionRate * 1000000) > 75000;

####################################################
# Show all the information for Entertainers who ... 

# ... have provided an email address
select * from Entertainers
where EntEMailAddress is not null;

# ... have a SSN where the first 2 digits of the last 4 numbers are 11
 select * from Entertainers
 where EntSSN  like '%_11'; 
# ... live in Seattle and were entered in the database in 1996 or later
select * from Entertainers
where EntCity = 'Seattle'
and
DateEntered >= '1996-01-01';

# ... have a name that starts with 'J' or live in the 98052 zip code
select * from Entertainers
where EntStageName LIKE '%J' or EntZipCode = '98052';
# ... have a band name that begins with the same letter as the city they live in

# *challenge* ... have provided a web page or an email address, but not both
SELECT * from Entertainers
WHERE (EntWebPage IS NULL and EntEMailAddress IS NOT NULL) or 
	  (EntWebPage IS NOT NULL and EntEMailAddress IS NULL);
# take some time to think of your own conditions,
# then see if you can implement the WHERE clause to match
