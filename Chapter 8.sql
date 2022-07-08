/* ********** SQL FOR MERE MORTALS CHAPTER 8 *********** */
/* ******** INNER JOINS                       ********** */
/* ***************************************************** */

-- “Show me the recipe title, preparation, and recipe class description of
-- all recipes in my database.”
use recipesexample;
select * from recipe_classes;
select RecipeTitle, Preparation, RecipeClassDescription from recipes r
inner join recipe_classes rc
on rc.RecipeClassID = r.RecipeClassID
order by r.RecipeTitle;


-- “I need the recipe type, recipe name, preparation instructions, ingredient
-- names, ingredient step numbers, ingredient quantities, and ingredient
-- measurements from my recipes database, sorted in step number
-- sequence.”
select rc.RecipeClassDescription, r.RecipeTitle,  r.Preparation, i.IngredientName,
ri.RecipeSeqNo, ri.Amount,
 m.MeasurementDescription
from recipes r
inner join recipe_classes rc
on rc.RecipeClassID = r.RecipeClassID
inner join recipe_ingredients ri
on ri.RecipeId = r.RecipeID
INNER JOIN ingredients i
on i.IngredientID = ri.IngredientID
inner join measurements m
on m.MeasureAmountID = i.MeasureAmountID
order by r.RecipeTitle, ri.RecipeSeqNo ASC;

-- “Show me the names of all my recipes and the names of all the ingredients
-- for each of those recipes.”
SELECT r.RecipeTitle, i.IngredientName 
FROM recipes r
inner join recipe_ingredients ri
on ri.RecipeID = r.RecipeID
inner join ingredients i
on i.IngredientID = ri.IngredientID
order by RecipeTitle;

use salesordersmodify;
-- “Display all products and their categories.”
select p.ProductName, c.CategoryDescription 
from products p
inner join categories c
on c.CategoryID = p.CategoryID;


-- “Show me entertainers, the start and end dates of their contracts, and
-- the contract price.”
use entertainmentagencymodify;
show tables;
select e.EntStageName, eg.StartDate, eg.EndDate, eg.ContractPrice 
from entertainers e
inner join engagements eg
on eg.EntertainerID = e.EntertainerID;



/* ******************************************** ****/
/* *** Problems For You To Solve                ****/
/* ******************************************** ****/
/* ***** Sales Orders Database ************* */
-- 1. List customers and the dates they placed an order, sorted in order date
-- sequence. 
use salesordersmodify;
select c.CustFirstName, c.CustLastName, o.OrderDate
from customers c
inner join orders o
on o.CustomerID = c.CustomerID
order by o.OrderDate;

-- 2. List employees and the customers for whom they booked an order.
select distinct e.EmpFirstName, e.EmpLastName, c.CustFirstName, c.CustLastName from orders o
inner join customers c
on c.CustomerID = o.CustomerID
INNER JOIN employees e
on e.EmployeeID = o.EmployeeID
order by e.EmpFirstName, e.EmpLastName, c.CustFirstName, c.CustLastName;

SELECT DISTINCT e.EmpLastName, e.EmpFirstName,
    c.CustLastName, c.CustFirstName
FROM Employees e INNER JOIN Orders o
    ON e.EmployeeID = o.EmployeeID
    INNER JOIN Customers c
    ON o.CustomerID = c.CustomerID
ORDER BY e.EmpLastName, e.EmpFirstName, c.CustLastName, c.CustFirstName;


-- 3. Display all orders, the products in each order, and the amount owed for
-- each product, in order number sequence.
select od.OrderNumber, p.ProductName, o.OrderDate, o.ShipDate, od.QuotedPrice,
(od.QuotedPrice * od.QuantityOrdered) as AmountOwed
from orders o
inner join order_details od
on od.OrderNumber =  o.OrderNumber
inner join products p
on od.ProductNumber = p.ProductNumber
order by o.OrderNumber;

-- 4. Show me the vendors and the products they supply to us for products that
-- cost less than $100.
select * from vendors;
select p.ProductName, v.VendName, pv.WholesalePrice
from products p 
inner join product_vendors pv
on pv.ProductNumber = p.ProductNumber
inner join vendors v
on v.VendorID =  pv.VendorID
where pv.WholesalePrice < 100;

-- 5. Show me customers and employees who have the same last name.
select concat(c.CustFirstName,' ', c.CustLastName) as CustName, 
concat(e.EmpFirstName,' ', e.EmpLastName ) as EmpName
from employees e
inner join customers c
where c.CustLastName = e.EmpLastName;

-- 6. Show me customers and employees who live in the same city.
select concat(c.CustFirstName," ", c.CustLastName) as CustName,
concat(e.EmpFirstName," ", e.EmpLastName) as EmpName
from customers c
inner join employees e
on c.CustCity = e.EmpCity;


/* ***** Entertainment Agency Database ***** */
-- 1. Display agents and the engagement dates they booked, sorted by booking
-- start date.
use entertainmentagencymodify;
select AgtFirstName, AgtLastName, e.StartDate
from agents a
inner join engagements e
on a.AgentID = e.AgentID
order by e.StartDate;

-- 2. List customers and the entertainers they booked.
select distinct concat(c.CustFirstName," ", c.CustLastName) as CustName, e.EntStageName 
from customers c
inner join engagements eg
on eg.CustomerID = c.CustomerID
inner join entertainers e
on e.EntertainerID = eg.EntertainerID
order by CustName, e.EntStageName;

-- 3. Find the agents and entertainers who live in the same postal code.
select concat(AgtFirstName," ", AgtLastName) as AgentName,
EntStageName, AgtZipCode
from agents
inner join entertainers
on AgtZipCode = EntZipCode
order by AgentName, EntStageName;

/* ***** School Scheduling Database ******** */
-- 1. Display buildings and all the classrooms in each building.
use schoolschedulingmodify;
select b.BuildingName, c.ClassRoomID from buildings b
inner join class_rooms c
on c.BuildingCode = b.BuildingCode;

-- 2. List students and all the classes in which they are currently enrolled.
select s.StudFirstName, s.StudLastName, sub.SubjectCode, sub.SubjectName
from students s
inner join student_schedules ss
on ss.StudentID = s.StudentID
inner join classes c
on c.ClassID = ss.ClassID
inner join subjects sub
on sub.SubjectID= c.SubjectID
where ss.ClassStatus = 1;

-- 3. List the faculty staff and the subject each teaches
select concat(StfFirstName," ", StfLastname) as StfName,
sub.SubjectName from staff s
inner join faculty_subjects fs
on fs.StaffID = s.StaffID
inner join subjects sub
on sub.SubjectID = fs.SubjectID
where s.Position = 'Faculty'
order by StfName, sub.SubjectName;

-- 4. Show me the students who have a grade of 85 or better in art and who also
-- have a grade of 85 or better in any computer course.
-- art 6 comp 4 
-- select concat(s.StudFirstName," ", s.StudLastName) as studname, ss.grade, cat.CategoryDescription  
SELECT * FROM (SELECT DISTINCT * from students s
inner join student_schedules ss
on ss.studentid = s.studentid
inner join classes c
on c.ClassID = ss.classid
inner join subjects sub
on sub.subjectid = c.subjectid
inner join categories cat
on cat.categoryid = sub.categoryid
where cat.categoryid = 'ART' and ss.grade >= 85) TBL
inner join (
select DISTINCT * 
from students s
inner join student_schedules ss
on ss.studentid = s.studentid
inner join classes c
on c.ClassID = ss.classid
inner join subjects sub
on sub.subjectid = c.subjectid
inner join categories cat
on cat.categoryid = sub.categoryid
where cat.categoryid IN ('CSC','CIS') and ss.grade >= 85) TBL2;

select tbl.studentid, tbl.studname
from (SELECT DISTINCT s.studentid, concat(s.studfirstname, " ", s.studlastname) studname
from students s
inner join student_schedules ss
on ss.studentid = s.studentid
inner join classes c
on c.ClassID = ss.classid
inner join subjects sub
on sub.subjectid = c.subjectid
where sub.categoryid = 'ART' and ss.grade >= 85) tbl
INNER JOIN (
select DISTINCT s.studentid
from students s
inner join student_schedules ss
on ss.studentid = s.studentid
inner join classes c
on c.ClassID = ss.classid
inner join subjects sub
on sub.subjectid = c.subjectid
where sub.categoryid IN ('CSC','CIS') and ss.grade >= 85) tbl2
on tbl.studentid = tbl2.studentid;

/* ***** Bowling League Database *********** */
-- 1. List the bowling teams and all the team members.
use bowlingleaguemodify;
select t.teamname, concat(b.bowlerlastname, b.bowlerfirstname) bowlername
from teams t
inner join bowlers b
on b.teamid = t.teamid
order by t.teamname, bowlername;

-- 2. Display the bowlers, the matches they played in, and the bowler game
-- scores.
select concat(b.bowlerlastname, " ", b.bowlerfirstname) bowlername, bs.matchid, bs.rawscore, bs.gamenumber 
from bowlers b
inner join bowler_scores bs
on bs.bowlerid = b.bowlerid;

-- 3. Find the bowlers who live in the same ZIP code.
select concat(b.bowlerlastname, " " ,b.bowlerfirstname) bowler1,  
concat(b1.bowlerlastname, " ", b1.bowlerfirstname) bowler2, b.bowlerzip
from bowlers b
inner join bowlers b1
on b.bowlerid != b1.bowlerid
and b.bowlerzip = b1.bowlerzip;

SELECT Bowlers1.BowlerFullName Bowler1,
    Bowlers2.BowlerFullName Bowler2, Bowlers2.BowlerZip
FROM (SELECT BowlerID,
        concat(BowlerFirstName , ' ' , BowlerLastName) BowlerFullName,
        BowlerZip
        FROM Bowlers) AS Bowlers1
INNER JOIN
    (SELECT BowlerID,
        concat(BowlerFirstName , ' ' , BowlerLastName) BowlerFullName,
        BowlerZip
        FROM Bowlers) AS Bowlers2
ON Bowlers1.BowlerZip = Bowlers2.BowlerZip AND
    Bowlers1.BowlerID != Bowlers2.BowlerID;
    
/* ***** Recipes Database ****************** */
-- 1. List all the recipes for salads.
use recipesexample;
select r.RecipeTitle from recipes r
inner join recipe_classes rc
on rc.RecipeClassID = r.RecipeClassID
where rc.RecipeClassID = 4;

-- 2. List all recipes that contain a dairy ingredient.
select distinct r.RecipeTitle 
from recipes r
inner join recipe_ingredients ri
on r.RecipeID = ri.RecipeID
inner join ingredients i 
on i.IngredientID = ri.IngredientID
inner join ingredient_classes ic
on ic.IngredientClassID = i.IngredientClassID
where ic.IngredientClassDescription like '%Dairy%';

-- 3. Find the ingredients that use the same default measurement amount.
select distinct m.MeasurementDescription, i.IngredientName, i2.IngredientName
from ingredients i
inner join ingredients i2
on i.IngredientID != i2.IngredientID
and i.MeasureAmountID = i2.MeasureAmountID
inner join measurements m
on m.MeasureAmountID = i.MeasureAmountID
order by m.MeasurementDescription, i.IngredientName, i2.IngredientName;

-- 4. Show me the recipes that have beef and garlic.
select beef.RecipeTitle from
(select r.recipeid ,r.RecipeTitle
from recipes r
inner join recipe_ingredients ri
on ri.RecipeID = r.RecipeID
inner join ingredients i
on i.IngredientID = ri.IngredientID
where i.IngredientName = 'Beef') beef
join
(select r.RecipeID
from recipes r
inner join recipe_ingredients ri
on ri.RecipeID = r.RecipeID
inner join ingredients i
on i.IngredientID = ri.IngredientID
where i.IngredientName = 'garlic') garlic
on beef.recipeid = garlic.recipeid;


