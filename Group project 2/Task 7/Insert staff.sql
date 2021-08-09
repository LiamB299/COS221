Delete from Project_info;
Delete from Employee_info;
Delete from Staff_Projects;
Delete from Department_Supervisor;
Delete from Emergency_Contacts;
Delete from Staff_Names;

Insert into Project_info values 
('1', 'P1'),
('2', 'P2'),
('3', 'P3'),
('4', 'P4')
;

Insert Employee_info values
('1 Street', '1', '1234567890', 'Data', '60', '33', 'Healthy'),
('2 Street', '2', '1234567890', 'Data', '60', '33', 'Healthy'),
('3 Street', '3', '1234567890', 'Staff', '60', '33', 'ChronicIllness'),
('4 Street', '4', '1234567890', 'Management', '60', '33', 'OnLeave')
;

Insert into Staff_Projects values
('1','1'),
('1','2'),
('2','3')
;

Insert into Department_Supervisor values
('Data', '4')
;

Insert into Emergency_Contacts values
('1','Liam', 'Burgess', '0124567891'),
('2','John', 'Burgess', '0124567891'),
('3','Aimeee', 'Burgess', '0124567891'),
('4','Jason', 'Burgess', '0124567891')
;

Insert into Staff_Names values
('1', 'L', 'M', 'Burg'),
('2', 'M', 'H', 'Des'),
('3', 'E', 'W', 'Crys'),
('4', 'W', 'X', 'Marsh')
;

/* Insert anomaly */
/* Projects are now independent */
Insert into Project_info values 
('5', 'New Project');

Select * from project_info;

/* Modification anomaly */
/* Supervisor changes */
Update Department_Supervisor set supervisor = '3' where supervisor = '4' and department = 'data';

Select * from department_supervisor;

/* Delete anomaly */
/* deleting a staff member does not affect projects */
Delete from employee_info where Empl_ID='3';
/* project 2 should still exist*/
Select * from project_info;
Select * from employee_info;
