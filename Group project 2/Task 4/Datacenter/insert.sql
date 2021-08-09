Delete from datacenter;

Insert into datacenter values 
('DC1', 'US', '1 STREET', '1', 'John', '70', '40', '10', '1', '55', '20', 'InUse', 'Main', 'ServerRoom', '12', '60', 'WareHouse', 'Full'),
('DC2', 'UK', '2 STREET', '2', 'Elle', '45', '50', '12', '2', '60', '20', 'Full', 'Main', 'ServerRoom_two', '3', '60', 'WareHouse_two', 'InUse'),
('DC3', 'US', '1 STREET', '1', 'John', '58', '50', '12', '3', '55', '20', 'InUse', 'Main', 'ServerRoom', '12', '60', 'WareHouse', 'Full'),
('DC4', 'US', '1 STREET', '1', 'John', '68', '60', '15', '4', '70', '20', 'Empty', 'Main', 'ServerRoom_three', '11', '60', 'WareHouse_three', 'InUse'),
('DC5', 'UK', '2 STREET', '2', 'Elle', '86', '70', '18', '5', '58', '20', 'InUse', 'Main', 'ServerRoom_four', '4', '60', 'WareHouse_four', 'InUse'),
('DC6', 'NZ', '4 STREET', '3', 'Lennon', '78', '80', '20', '6', '78', '20', 'InUse', 'Office', 'OfficeRoom', '13', '60', 'WareHouse_office', 'Empty'),
('DC7', 'NZ', '4 STREET', '3', 'Lennon', '45', '50', '12', '7', '78', '20', 'InUse', 'Office', 'OfficeRoom', '14', '60', 'WareHouse_office', 'Empty')
;

/* insert anomaly */
/* type 1 - irregular insert data */
/* Wrong names for warehouse, rooms and mtx */
Insert into datacenter values 
('DC8', 'US', '1 STREET', '1', 'Johno', '70', '40', '10', '8', '55', '20', 
	'InUse', 'Main', 'ServerRoom_one', '12', '60', 'WareHouse_one', 'Full')
;

/* type 2 - null values */
/* cannot add a warehouse or room because of the NULL constraint on MTXid */
Insert into datacenter values 
(NULL, 'US', '1 STREET', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '13', '80', 'WareHouse_New', 'Empty'),
(NULL, 'US', '1 STREET', NULL, NULL, NULL, NULL, NULL, NULL, '87', '40', 'InUse', 'BackUp', 'NewRoom', NULL, NULL, NULL, NULL)
;

Select * from datacenter;

/* Modification anomaly */
/* inept user update */
/* John is retired and Adam is hired */
/*Update datacenter set PlantSpecialist_one_id = '4', PlantSpecialist_one_name='Adam' where WareHouseNo = '12'; */
Update datacenter set PlantSpecialist_one_id = '4', PlantSpecialist_one_name='Adam' where MTXid in ('1','3');

Select * from datacenter;

/* Delete anomaly */
/* Lose server room three and warehouse three's info when the record tuple for datacenter DC4 is removed */
Delete from datacenter where Name = 'DC4';

Select * from datacenter;