/* ********** SQL FOR MERE MORTALS CHAPTER 4 *********** */
/* ************ CREATING A SIMPLE QUERY              *** */
/* ***************************************************** */

/* ******************************************** ****/
/* *** Sample Statements                        ****/
/* ******************************************** ****/
/* ****** Sales Orders Database ************ */

use salesordermodify;

-- “Which cities do our customers live in?”
select distinct CustCity from customers;

-- “Show me a current list of our employees and their phone numbers.”
select EmpFirstName, EmpLastName, EmpPhoneNumber from employees;

use schoolschedulingmodify;

-- “Show me a list of subjects, the category each belongs to, and the code
-- we use in our catalog. But I’d like to see the name first, followed by the
-- category, and then the code.” 
select SubjectName, CategoryID, SubjectCode from subjects;


use bowlingleagueexample;
-- “Which cities are represented by our bowling league membership?”
select distinct BowlerCity from bowlers;

use schoolschedulingmodify;
-- “List the categories of classes we offer and show them in alphabetical order.”
select * from categories order by CategoryDescription;


use salesordersmodify;
-- “Show me the names of all our vendors.” 
select vendname from vendors;

-- “What are the names and prices of all the products we carry?” 
select distinct ProductName, RetailPrice from products;

-- “Which states do our customers come from?”
select distinct custstate from customers;

use entertainmentagencymodify;
-- “List all entertainers and the cities they’re  based in, and sort the
-- results by city and name in ascending order.”
select EntStageName, EntCity from entertainers order by EntCity ASC, EntStageName ASC;

-- “Give me a unique list of engagement dates. I’m not concerned with
-- how many engagements there are per date.”
select distinct StartDate from engagements;

use schoolschedulingmodify;
-- “Can we view complete class information?”
select * from classes;

-- Give me a list of the buildings on campus and the number of floors for
-- each building. Sort the list by building in ascending order.”
select BuildingName, NumberOfFloors from buildings order by BuildingName ASC;

USE bowlingleagueexample;
-- “Where are we holding our tournaments?”
select distinct TourneyLocation from tournaments;

-- “Give me a list of all tournament dates and locations. I need the dates
-- in descending order and the locations in alphabetical order.”
select TourneyDate, TourneyLocation 
from tournaments 
order by TourneyDate DESC, TourneyLocation ASC;

use recipesexample;
-- “What types of recipes do we have, and what are the names of the
-- recipes we have for each type? Can you sort the information by type
-- and recipe name?”
select RecipeClassID, RecipeTitle
from recipes
ORDER BY RecipeClassID ASC, RecipeTitle ASC;

-- “Show me a list of unique recipe class IDs in the recipes table.”
SELECT DISTINCT RecipeClassID from recipes;

-- EXCERCISE-- 
USE salesordersmodify;
-- “Show me all the information on our employees.”
select * from employees;

-- 2. Show me a list of cities, in alphabetical order, where
-- our vendors are located, and include the names of the vendors
-- we work with in each city.
select VendCity, VendName from vendors
order by VendCity ASC;

/* ***** Entertainment Agency Database ***** */

-- 1. Give me the names and phone numbers of all our agents, and
-- list them in last name/first name order.
use entertainmentagencymodify;

select AgtFirstName, AgtLastName, AgtPhoneNumber
from agents
order by AgtLastName, AgtFirstName;

-- 2. Give me the information on all our engagements.
select * from engagements;

-- 3. List all engagements and their associated start dates.
-- Sort the records by date in descending order and by 
-- engagement in ascending order.
select EngagementNumber, StartDate 
from engagements
order by StartDate DESC, EngagementNumber ASC;

/* ***** School Scheduling Database ******** */
USE schoolschedulingmodify;
-- 1. "Show me a complete list of all the subjects we offer."
select * from subjects;

-- 2. "What kinds of titles are associated with our faculty?"
select distinct Title from faculty;

-- 3. "List the names and phone numbers of all our staff, and sort them by last
-- name and first name."
select StfFirstName, StfLastName, StfPhoneNumber
from staff
order by StfLastName ASC, StfFirstName ASC;

/* ***** Bowling League Database *********** */
use bowlingleaguemodify;
-- 1. List all of the teams in alphabetical order.
select TeamName from teams order by TeamName;

-- 2. Show me all the bowling score information for each of our members.
select * from bowler_scores

-- 3. Show me a list of bowlers and their addresses, and sort it in alphabetical
-- order." 
select BowlerFirstName, BowlerLastName, BowlerAddress 
from bowlers
order by BowlerFirstName ASC, BowlerLastName ASC;

/* ***** Recipes Database ****************** */

-- 1. Show me a list of all the ingredients we currently keep track of
USE recipesexample;
select distinct ingredients.IngredientName from ingredients;

-- 2. Show me all the main recipe information, and sort it by the name of the
-- recipe in alphabetical order.
select * from recipe;
select * from recipes 
where RecipeClassID = 1
order by RecipeTitle asc;