INSERT INTO Customer (CustomerID, Name, Surname, Title, Address)
VALUES 
    ('1',	'Mohammed',	'Abraham',	'Mr',	'2 Jean Drive'),
    ('2',	'Abby',	'Smith',	'Ms',	'514 Mackenzie St'),
    ('3',	'Refiloe',	'Molete',	'Mrs',	'6 Joker St'),
    ('4',	'Corlize',	'van Heerden',	'Ms',	'12 Lotus Ave'),
    ('5',	'Simone',	'Fourie', 'Dr',	'2 Duncan St'),
    ('6',	'Samantha',	'Hanna',	'Mrs',	'34 Lynwood St'),
    ('7',	'Rebecca',	'Duncan',	'Ms',	'111 Bondev Drive'),
    ('8',	'Gary',	'Lou',	'Mr',	'5555 Rands St'),
    ('9',	'Ronald',	'Wang',	'Prof',	'6S Quinton Ave'),
    ('10',	'Fatima',	'Vallee',	'Ms',	'987 Sabie Road'),
    ('11',	'Mande',	'Moloi',	'Dr',	'9 Lira St'),
    ('12',	'Sphesihle',	'Mangena',	'Ms',	'3333 Warden St'),
    ('13',	'Daniel',	'Alberts',	'Mrs',	'3 Peso St'),
    ('14',	'Jason',	'Mackenzie',	'Mr',	'98 Theo St'),
    ('15',	'Michael',	'Nouwens',	'Mr',	'18 De Villiers St');

INSERT INTO Cars (CarID, Description, YearModel)
VALUES
    ('1',	'Red Mercedez AMG',	'2020'),
    ('2',	'White BMW X5',	'2017'),
    ('3',	'Grey Mini Cooper JCW',	'2020'),
    ('4',	'Silver Toyota Corona',	'2015'),
    ('5',	'Yellow Honda Jazz Sport',	'2021'),
    ('6',	'Blue Nissan Amra',	'2018'),
    ('7',	'Orange Toyota Hilux',	'2020');

INSERT INTO Motorbikes (BikeID, Type, YearModel)
VALUES
    ('1',	'Micah V4S',	'2021'),
    ('2',	'BMW S1000RR',	'2020'),
    ('3',	'Honda Fireblade SP',	'2018'),
    ('4',	'Yamaha YZF-R1M',	'2015'),
    ('5',	'Kawasaki Ninja H2',	'2017'),
    ('6',	'Kawasaki ZX-10R SE',	'2019'),
    ('7',	'Yamaha YZF-R1',	'2020');

INSERT INTO Returned_Bike (CustID, BID, ReturnedDate)
VALUES 
    ('4',	'2',	'2020/12/14'),
    ('9',	'4',	'2020/08/06'),
    ('15',	'6',	'2021/02/14'),
    ('14',	'7',	'2021/01/11');

INSERT INTO Returned_Car (CustID, CID, ReturnedDate)
VALUES
    ('4',	'2',	'2020/12/14'),
    ('8',	'3',	 '2020/02/16'),
    ('9',	'4',		'2020/08/06'),
    ('4',	'7',		'2020/12/14');

INSERT INTO Customer_Car (CustID, CID, RentedDate)
VALUES
    ('1',	'1',	'2021/11/11'),
    ('4',	'2',	'2020/11/09'),
    ('8',	'3',	'2020/02/14'),
    ('9',	'4',	'2020/06/06'),
    ('14',	'5',	'2021/11/11'),
    ('1',	'6',	'2021/01/01'),
    ('4',	'7',	'2020/11/09');

INSERT INTO Customer_Bike (CustID, BID, RentedDate)
VALUES
    ('1',	'1',	'2021/11/11'),
    ('4',	'2',	'2020/12/10'),
    ('8',	'3',	'2020/08/14'),
    ('9',	'4',	'2020/07/06'),
    ('14',	'5',	'2021/11/11'),
    ('15',	'6',	'2020/11/11'),
    ('14',	'7',	'2020/11/11');
    
select * from Customer;