select distinct `Name`
from Customer
where CustomerID not in (
	select CustID 
    from Customer_Car
);

/*******************/

select `name`
from Customer
left outer join Customer_Car 
on CustID = CustomerID 
where CustID is null;

/******************/

select `Name`
from Customer
where not exists (select 1 from Customer_Car where  CustID = CustomerID );
