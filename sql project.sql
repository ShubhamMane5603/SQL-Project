-- 1.	(Easy) Creating the schema and required tables using sql script or using MySQL workbench UI
-- a.	Create a schema named Travego. 
CREATE SCHEMA Travego;
-- b.	Create the tables mentioned above with the mentioned column names. 
create database project;
create table Passenger(
    Passenger_id int primary key ,
	Passenger_name  varchar(20),
  	Category varchar(20),
	Gender	 varchar(20),
    Boarding_City	varchar(20),
	Destination_City varchar(20),
	Distance   int,
	Bus_Type   varchar(20)
);
create table price
(id int primary key,
Bus_type varchar(20),
Distance int,	
Price int 
);


-- c.	Insert the data in the newly created tables using sql script or using MySQL UI. 
insert into passenger(Passenger_id,Passenger_name,Category,Gender,Boarding_City,Destination_City,Distance,Bus_Type)
values
(1	,"Sejal"	,"AC",	"F"	,	"Bengaluru",	"Chennai",	350	,"Sleeper"),
(2	,"Anmol",	"Non-AC",	"M",	"Mumbai	",	"Hyderabad",	700,"Sitting"),
(3	,"Pallavi",	"AC",	"F",	"Panaji",	"Bengaluru",600	,"Sleeper"),
(4	,"Khusboo", 	"AC"	,"F"	,"Chennai",	"Mumbai",	1500,	"Sleeper"),
(5	,"Udit",	"Non-AC","M"	,"Trivandrum",	"Panaji"	,1000	,"Sleeper"),
(6	,"Ankur",	"AC"	,"M",	"Nagpur",	"Hyderabad"	,500	,"Sitting"),
(7,	"Hemant",	"Non-AC	","M"	,"Panaji","Mumbai"	,	700,	"Sleeper"),
(8,	"Manish",	"Non-AC",	"M",	"Hyderabad","Bengaluru",500,	"Sitting"),
(9	,"Piyush","AC",	"M","Pune","Nagpur",	700	,"Sitting");



Insert into price (id,Bus_type,Distance,Price)
values
(1,	"Sleeper",350,770),
(2,	"Sleeper",500,"	1100"),
(3	,"Sleeper"	,600	,1320),
(4,"Sleeper",700,1540),
(5,"Sleeper"	,1000,2200),
(6,"Sleeper",1200,2640),
(7,	"Sleeper",1500,	2700),
(8,	"Sitting",	500,620),
(9,"Sitting",600,744),
(10,"Sitting",700,868),
(11,"Sitting"	,1000,1240),
(12,"Sitting",1200,1488),
(13,"Sitting",1500,	1860);


-- 2.	(Medium) Perform read operation on the designed table created in the above task using SQL script. 
-- a.	How many females and how many male passengers traveled a minimum distance of 600 KMs?
select Gender,count(gender) 
from passenger
inner join
price
on passenger.Passenger_id = price.id
where price.Distance >=600
group by Gender;

-- b.	Find the minimum ticket price of a Sleeper Bus. 
select min(price) as minimum_ticket_price_of_a_Sleeper_Bus
from price
where price.Bus_type = "Sleeper"
group by price.Bus_Type;

-- c.	Select passenger names whose names start with character 'S' 
select Passenger_id,Passenger_name
from passenger 
WHERE LEFT(passenger_name, 1) = 'S';


-- d.	Calculate price charged for each passenger displaying Passenger name, Boarding City, Destination City, Bus_Type, Price in the output
select a.passenger_name,a.boarding_city,a.destination_city,a.bus_type,b.price from passenger a
left join
price b
on a.distance=b.distance and a.bus_type=b.bus_type
group by passenger_name;
-- or
select Passenger_name, Boarding_City, Destination_City, a.Bus_type,b.Price 
from Passenger a , Price b where (a.Bus_Type = b.Bus_Type and a.Distance = b.Distance);




-- e.	What are the passenger name(s) and the ticket price for those who traveled 1000 KMs Sitting in a bus?  
select passenger.Passenger_name,price.Price 
from passenger
inner join
price
on passenger.Passenger_id = price.price
where passenger.Distance = 1000 and passenger.Bus_type = "Sitting";  

									
-- f.	What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to Panaji?
                                       
SELECT Bus_Type, Distance, Price AS Bus_Price
FROM price
WHERE Distance =
(select Distance from passenger where Boarding_City in ('bengaluru', 'panaji') and Destination_City in ('panaji','bengaluru'));

                                                     -- or

SELECT passenger.Passenger_name,price.price
FROM passenger  
inner JOIN
price  
ON passenger.Passenger_id = price.id
WHERE passenger.Boarding_City = 'Panaji'
AND passenger.destination_city = 'Bangalore'
AND passenger.Passenger_name = "Pallavi" 
ANd price.Bus_type in ("Sitting","Sleeper");



-- g.	List the distances from the "Passenger" table which are unique (non-repeated distances) in descending order. 
select  distinct(distance) from passenger
order by Distance desc;


-- h.	Display the passenger name and percentage of distance traveled by that passenger from the total distance traveled by all passengers without using user variables 
select p.passenger_name, 
p.distance/(select sum(p.Distance) from passenger p) * 100 as Distance_percentage
from passenger P;

