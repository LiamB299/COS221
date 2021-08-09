Select Customer.`Name`
from Customer, Customer_Bike
where CustomerID = Customer_Bike.CustID and CustomerID not in (
	Select Customer.CustomerID
	from Customer, Customer_Car
	where CustomerID = Customer_Car.CustID
	group by CustomerID
)
group by CustomerID
having count(Customer_Bike.CustID)>0;

/***********************************/

Select distinct Customer.`Name`
from Customer, Customer_Bike
where CustomerID = Customer_Bike.CustID 
and CustomerID not in (
	Select CustID
	from Customer_Car	
); 

/*****************************/

Select Customer.Name
from Customer, Customer_Bike
where not exists (
	select 1 from Customer_Car where Customer_Car.CustID = Customer.CustomerID 
)
and Customer.CustomerID = Customer_Bike.CustID

/*exists (
	select 1 from Customer_Bike where Customer_Bike.CustID = Customer.CustomerID
)*/