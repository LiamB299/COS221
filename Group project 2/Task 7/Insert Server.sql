Delete from Rack_models;
Delete from Rack_info;
Delete from Server_info;
Delete from Server;
Delete from VM_Names;

Insert into Rack_models values
('M1', '121', 'AMD', 'AMD > Intel'),
('M2', '122', 'Intel', 'AMD > Intel'),
('M3', '123', 'Custom', 'Custom?')
;

Insert into Rack_info values
('1', 'L1', 'M1', '100'),
('2', 'L2', 'M2', '60'),
('3', 'L3', 'M3', '40'),
('4', 'L4', 'M1', '80')
;

Insert into Server_info values
('1', 'S1', '2'),
('2', 'S2', '3'),
('3', 'S3', '1'),
('4', 'S4', '3')
;

Insert into Server values
('1', '1', '1'),
('2', '1', '1'),
('3', '2', '1'),
('3', '3', '2')
;

Insert into VM_Names values
('1', 'Java'),
('1', 'Stelaris'),
('2', 'Ubuntu'),
('2', 'Oracle'),
('2', 'Java'),
('3', 'Oracle'),
('4', 'Java'),
('4', 'Stelaris'),
('4', 'Ubuntu')
;

/* insert anomaly */
/* new rack, not associated with any server */
Insert into Rack_info values
('5', 'L5', 'M3', '30')
;

/* modification anomaly */
/* Rack Label 1 is changed */
Update Rack_info set racklabel = 'L6' where rackID = '1';
Select * from rack_info;

/* deletion anomaly */
/* Delete server but retain rack and processor info */
/* cascade might be restrict and make delete fail, change with alter table...*/
Delete from Server_info where ServerID = '3';
/* rack 3 should still exist*/
Select * from rack_info;
