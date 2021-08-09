/* this query retuns nothing otherwise */
insert into Customer_Bike 
values ('7','7', '2020/11/11');


select Customer.`name`
from Motorbikes, Customer_Bike as a, Customer_Bike as b, Customer
where Motorbikes.Type="Kawasaki ZX-10R SE"
and Motorbikes.BikeID = a.BID
and b.RentedDate = a.RentedDate
and b.BID != a.BID
and not exists (
	select 1 from Returned_Bike where b.CustID = Returned_Bike.CustID and b.BID = Returned_Bike.BID
)
and b.CustID=Customer.CustomerID;


