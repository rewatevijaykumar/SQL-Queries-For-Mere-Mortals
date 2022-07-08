/* ********** SQL FOR MERE MORTALS CHAPTER 6 *********** */
/* ******** Filtering Your Data               ********** */
/* ***************************************************** */

/* ******************************************** ****/
/* *** Defining Search Conditions               ****/
/* ******************************************** ****/
-- “What are the names of our customers who live in the state of
-- Washington?”
use salesordersmodify;
select CustFirstName, CustLastName from customers
where CustState = 'WA';

-- “Show me the first and last names of all the agents who were hired on
-- March 14, 1977.”
select AgtFirstName, AgtLastName
from agents
where DateHired = '1977-03-14';

-- “Give me a list of vendor names and phone numbers for all our vendors,
-- with the exception of those here in Bellevue.”
select VendName, VendPhoneNumber
from vendors
where VendCity <> 'Bellevue';

-- “Are there any orders where the ship date was accidentally posted earlier
-- than the order date?”
select OrderNumber 
from orders
where ShipDate < OrderDate;

-- “Are there any classes that earn more than four credits?”
select ClassID
from classes
where Credits > 4; 

-- “I need the names of everyone we’ve hired since January 1, 1989.”
select FirstName, LastName 
from employees
where DateHired >= '1989-01-01';

-- “Show me a list of products with a retail price of fifty dollars or less.”
select ProductName
from products
where RetailPrice <= 50;

-- “Which staff members were hired in July 1986?”
select FirstName, LastName
from staff
where DateHired between '1986-07-01' and '1986-07-31';

USE schoolschedulingmodify;
-- “Give me a list of students—along with their phone numbers—whose
-- last names begin with the letter B.”
select StudFirstName, StudLastName, StudPhoneNumber
from students
where StudLastName like 'B%';

-- “Show me all engagements that are scheduled to occur on October 10,
-- 2017.”
select EngagementNumber, StartDate, EndDate
from engagements
where '2017-10-10' between StartDate and EndDate;

/* ******************************************** ****/
/* *** Problems For You To Solve                ****/
/* ******************************************** ****/
/* ***** Sales Orders Database ************* */
use salesordersmodify;
-- “Give me the names of all vendors based in Ballard, Bellevue, and
-- Redmond.”
select VendName, VendCity
from vendors
where VendCity in ('Ballard','Bellevue','Redmond');

-- “Show me an alphabetized list of products with a retail price of
-- $125.00 or more.”
select ProductName, RetailPrice
from products
where RetailPrice >= 125
order by ProductName, RetailPrice;

-- “Which vendors do we work with that don’t have a Web site?”
select VendName 
from vendors
where VendWebPage is null
order by VendName;

/* ***** Entertainment Agency Database ***** */
-- 1. Let me see a list of all engagements that occurred during October 2017.
use entertainmentagencymodify;
select EngagementNumber 
from engagements
where StartDate >= '2017-10-01' 
and EndDate <= '2017-10-31';

-- 2. Show me any engagements in October 2017 that start between noon and 5pm.
select EngagementNumber
from engagements
where StartDate >= '2017-10-01' 
and EndDate <= '2017-10-31'
and StartTime between '12:00:00' and '17:00:00';
select * from engagements;

-- 3. List all the engagements that start and end on the same day.
select EngagementNumber, StartDate, EndDate from engagements
where StartDate = EndDate;

/* ***** School Scheduling Database ******** */
-- 1. Show me which staff members use a post office box as their address.
use schoolschedulingmodify;
select StfFirstName, StfLastName, StfStreetAddress
from staff
where StfStreetAddress like '%box%'
order by StfFirstName, StfLastName;

-- 2. Can you show me which students live outside of the Pacific Northwest?
select StudFirstName, StudLastName,StudCity from students
where StudCity not in ('WA','OR','ID')
order by StudFirstName, StudLastName;

-- 3. List all subjects that have a subject code starting 'MUS.'
select SubjectID, SubjectCode, SubjectName 
from subjects
where SubjectCode like 'MUS%';

-- 4. Produce a list of the ID numbers all the Associate Professors who are
-- employed full time.
select StaffID, Title, Status
from faculty
where Title = 'Associate Professor' and Status = 'Full Time';

/* ***** Bowling League Database *********** */
-- 1. Give me a list of the tournaments held during September 2017
use bowlingleaguemodify;
select TourneyDate, TourneyLocation 
from tournaments
where TourneyDate between '2017-09-01' and '2017-09-30';

-- 2. What are the tournament schedules for Bolero, Red Rooster, and Thunderbird
-- Lanes?
select * from tournaments
where TourneyLocation in ('Bolero Lanes', 'Red Rooster Lanes', 'Thunderbird Lanes')
order by TourneyLocation, TourneyDate;

-- 3. List the bowlers who live on the Eastside (you know--Bellevue, Bothell,
-- Duvall, Redmond, and Woodinville) and who are on teams 5, 6, 7, or 8.
select * from bowlers
where BowlerCity in ('Bellevue', 'Bothell','Duvall', 'Redmond', 'Woodinville') 
and TeamID between 5 and 8
order by BowlerCity, TeamID;

/* ***** Recipes Database ****************** */
-- 1. List all recipes that are main courses (recipe class is 1) and that have
-- notes.
use recipesexample;
select RecipeTitle, Preparation, Notes 
from recipes
where RecipeClassID = 1 and Notes is not null
order by RecipeTitle;

-- 2. Display the first five recipes.
select RecipeID, RecipeTitle, Notes
from recipes
order by RecipeID
limit 5;
