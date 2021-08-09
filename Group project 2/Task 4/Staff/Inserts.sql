Delete from Staff;

Insert into Staff values 
('Liam', 'M', 'Burgess', '1 STREET', '1', '1234567891', 'Engineering', 'J', 'P', 'Loft', 'P1', 'Diagnostics', '600', '3', '22', 'Healthy'),
('John', 'M', 'Cena', '2 STREET', '2', '1234567891', 'Staff', 'M', 'N', 'Sham', 'P2', 'Cleaning', '600', '1', '22', 'OnLeave'),
('H', 'G', 'Wells', '3 STREET', '3', '1234567891', 'Management', 'S', 'X', 'Desi', 'P3', 'Managing John', '600', NULL, '22', 'ChronicIllness'),
('F', 'S', 'Fitz', '4 STREET', '4', '1234567891', 'Management', 'J', 'E', 'Dumino', 'P4', 'Training', '600', NULL, '22', 'Healthy')
;

Select * from Staff;

/* Insert anomaly */
/* Projects may only exist when associated with staff member */
Insert into Staff values 
(NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'P4', 'New Project', NULL, NULL, NULL, NULL)
;

/* Update anomaly */
/* The supervisor changes from Wells to Fitz*/
Update Staff set Supervisor = '4' where Empl_ID = '1';

Select * from Staff;

/* Delete anomaly */
/* Any project */
Delete from staff where Empl_ID = '1';

Select * from Staff;

