Select Customer.`name`, COUNT(Customer_Car.CID) as `No. of Cars`
from Customer, Customer_Car
where Customer.CustomerID = Customer_Car.CustID
group by Customer_Car.CustID
having count(Customer_Car.CID)>1;

