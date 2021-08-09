Delete from Datacenter_ConsumptionInfo;
Delete from datacenter;
Delete from Datacenter_Locations;
Delete from WareHouse;
Delete from Room;
Delete from Room_sub;
Delete from PlantSpecialists;
Delete from PlantSpecialists_sub;
Delete from DataCenter_Spread;

Insert into Datacenter_ConsumptionInfo values 
('5', '1', '10'),
('10', '1', '20'),
('15', '2', '30')
;

Insert into datacenter values
('1', 'DC1', '5'),
('2', 'DC2', '5'),
('3', 'DC3', '10')
;

Insert into Datacenter_Locations values 
('1 Street', 'US'),
('2 Street', 'UK'),
('3 Street', 'NZ')
;

Insert into WareHouse values
('1','100','W1','InUse'),
('2','100','W2','InUse'),
('3','200','W3','Empty')
;

Insert into Room values 
('1', '10', 'R1', 'InUse', 'Main'),
('2', '10', 'R2', 'InUse', 'Main'),
('3', '10', 'R3', 'Empty', 'BackUp')
;

Insert into Room_sub values
('1','1'),
('2','2'),
('3','3')
;

Insert into PlantSpecialists values
('John', '1'),
('Anne', '2'),
('Jake', '3'),
('Jamie', '4')
;

Insert into PlantSpecialists_sub values 
('1', '1'),
('1', '2'),
('2', '2'),
('3', '3')
;

Insert into DataCenter_Spread values 
('1', '1', '1 Street'),
('1', '2', '1 Street'),
('3', '3', '2 Street')
;

/* insert anomaly */
/* null keys */
Insert into warehouse values 
('4','100','New warehouse','Empty')
;

Insert into room values 
('4', '10', 'NewRoom', 'Empty', 'Main')
; 

Select * from warehouse, room;

/* modification anomaly */
/* Anne is fired, Jamie is hired */
Update PlantSpecialists_sub set PlantSpecialist_ID = '4' where PlantSpecialist_ID in (select PlantSpecialist_ID where PlantSpecialist_name = "Anne");
select * from PlantSpecialists_sub;

/* delete anomaly */
/* deleting a datacenter only deletes a datacenter */
Delete from Room_sub where MTXid='3';
Delete from PlantSpecialists_sub where MTXid='3';
Delete from DataCenter_Spread where MTXid='3';
Delete from datacenter where MTXid='3';

select * from plantspecialists;
select * from DataCenter_Spread;
select * from room_sub;
