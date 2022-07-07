use salesordersmodify;
select OrderNumber, OrderDate, ShipDate, (ShipDate - OrderDate) AS DaysElapsed from orders;

/* ***** Sales Orders Database ************* */
-- 1. What if we adjusted each product price by reducing it 5 percent?
select ProductNumber, ProductName, round(RetailPrice * 0.95,2) as ReducedPrice from products;

-- 2. Show me a list of orders made by each customer in descending date order.
-- (Hint: You might need to order b more than one column for the information to
-- display properly.)
select * from orders
order by CustomerID ASC, OrderDate DESC, OrderNumber ASC;

-- 3. Compile a complete list of vendor names and addresses in vendor name
-- order.

SELECT VendName, concat(VendStreetAddress, ' ' ,VendState, ' ', VendCity, ' ', VendZipCode) as VenderDetails, VendPhoneNumber
from vendors
order by VendName;

/* ***** Entertainment Agency Database ***** */
-- 1. Give me the names of all our customers by city.
-- (Hint: You'll have to use an ORDER BY clause on one of the columns.)

use entertainmentagencymodify;

select concat(CustFirstName," ", CustLastName) as CustName, CustCity from customers
order by CustCity, CustName;

-- 2. List all entertainers and their Web sites.
select EntStageName, EntWebPage from entertainers
order by EntStageName;

-- 3. Show the date of each agent's first six-month performance review.
-- (Hint: You'll need to use date arithmetic to answer this request. Be sure to
-- refer to appendix C.)
-- Note: PostGre casts date + interval calculations to timestamps, so we need to
-- CAST back to a DATE time to preserve formatting

-- SELECT AgentID, AgtLastName, AgtFirstName, DateHired,
--     CAST(DateHired + '1 month'::interval * 6 AS DATE) AS SixMonthReviewDate
-- FROM agents
-- ORDER BY AgentID;

select AgentID, AgtLastName, AgtFirstName, date_add(DateHired, interval 6 month) as SixMonthReviewDate
from agents
order by AgentID;

/* ***** School Scheduling Database ******** */
-- 1. Give me a list of staff members, and show them in descending order of
-- salary.
use schoolschedulingmodify;

select concat(StfFirstName, " ", StfLastName) as StfName, Salary from staff
order by Salary DESC, StfName;

-- 2. Can you give me a staff member phone list?
select concat(StfFirstName, " ", StfLastName) as StfName, concat(StfAreaCode,"-", StfPhoneNumber) as PhoneNumber
from staff
order by StfName;

-- 3. List the names of all our students, and order them by the cities they live
-- in.
select concat(StudFirstName, " ", StudLastName) as StudName from students
order by StudCity,StudName;

/* ***** Bowling League Database *********** */

-- 1. Show next year's tournament date for each tournament location.
-- (Hint: Add 364 days to get the same day of the week, and be sure to refer to
-- Appendix C.
use bowlingleaguemodify;

select TourneyLocation, DATE_ADD(TourneyDate, INTERVAL 364 DAY) AS TourneyNexrDate 
from tournaments
order by TourneyLocation;

-- 2. List the name and phone number for each member of the league.
select concat(BowlerLastName," ", BowlerFirstName) as BowlerName, BowlerPhoneNumber
from bowlers
order by BowlerName;

-- 3. Give me a listing of each team's lineup.
-- (Hint: Base this query on the Bowlers table.)
select concat(BowlerLastName," ", BowlerFirstName) as BowlerName, TeamId
from bowlers
order by TeamID, BowlerName;
