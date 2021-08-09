/* Easy to read sub-query method */

select `Type`
from Motorbikes, Customer_Bike
where BikeID = BID and YearModel="2020" and CustID in ( 
	select CustomerID
	from Customer
	where Surname="Mackenzie"
); 

/* Cross referencing method */

Select Motorbikes.Type
from Motorbikes, Customer as a, Customer as b, Customer_Bike
where Motorbikes.YearModel = "2020"
and a.Surname = "Mackenzie"
and b.CustomerID = a.CustomerID
and Customer_Bike.CustID = b.CustomerID
and Customer_Bike.BID = Motorbikes.BikeID;

/* join method */
select type
from Motorbikes
inner join Customer_Bike on BID= BikeID
inner join Customer on CustomerID = CustID
where surname = "Mackenzie"
and YearModel = "2020"