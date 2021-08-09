Delete from Server;

Insert into Server values
('1', '1', 'S1', 'L1', 'M10', '2221', NULL, '45', 'AMD', 'VM1,VM2,VM5','3', 'AMD > Intel'),
('2', '1', 'S2', 'L1', 'M10', '2221', NULL, '45', 'AMD', 'VM1,VM2,VM4','3', 'AMD > Intel'),
('3', '1', 'S3', 'L1', 'M10', '2221', NULL, '45', 'AMD', 'VM1,VM2,VM3','3', 'AMD > Intel'),
('4', '2', 'S4', 'L2', 'M10', '2222', NULL, '78', 'Intel', 'VM1,VM2','2', 'AMD > Intel'),
('5', '2', 'S5', 'L2', 'M10', '2222', NULL, '78', 'Intel', 'VM1,VM2','2', 'AMD > Intel'),
('6', '2', 'S6', 'L2', 'M10', '2222', NULL, '78', 'SnapDragon', 'VM1','1', 'AMD > Intel'),
('7', '3', 'S7', 'L3', 'M10', '2223', NULL, '86', 'SnapDragon', 'VM1','1', 'AMD > Intel')
;

/* Insert anomaly */
/* A rack is bought but no servers are setup yet */
Insert into Server values
(NULL, '4', NULL, 'L4', 'M10', '2224', NULL, NULL, 'AMD', NULL, NULL, 'AMD > Intel');

/* Modification anomaly */
/* rack label 1 is changed */
Update Server set RackLabel = 'RL1' where ServerID in ('1','2'); 

Select * from Server;

/* Deletion anomaly */
/* Rack and processor information may be lost on a server deletion */
Delete from Server where ServerID in ('6', '7');

Select * from Server;