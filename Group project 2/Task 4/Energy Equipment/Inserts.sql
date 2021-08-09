Delete from energy_equipment;

Insert into energy_equipment values 
('1', 'EQ1', '67W', '56', 'InStorage', 'Standard 151', 'L1', '1', 'M7', '1121','10', '20', '23', '2', '2021-06-21',
    '20', '30', '32', 'Online','30', '20', '43', '4', '2021-06-21', '41', '80KW', '54'),
('2', 'EQ2', '45W', '75', 'InStorage', 'Standard 151', 'L1', '1', 'M7', '1122','11', '20', '23', '2', '2021-06-21',
    '20', '30', '32', 'Online','30', '20', '43', '4', '2021-06-21', '42', '80KW', '54'),
('5', 'EQ5', '76W', '45', 'InStorage', 'Standard 221', 'L1', '1', 'M9', '1125','12', '20', '23', '2', '2021-06-21',
    '20', '30', '32', 'Online','30', '20', '43', '4', '2021-06-21', '43', '80KW', '54'),
('3', 'EQ3', '87W', '75', 'InStorage', 'Standard 216', 'L2', '2', 'M7', '1123','13', '20', '23', '2', '2021-06-21',
    '22', '30', '32', 'Online','31', '20', '43', '4', '2021-06-21', '44', '80KW', '54'),
('4', 'EQ4', '96W', '86', 'InStorage', 'Standard 216', 'L2', '2', 'M9', '1124','14', '20', '23', '2', '2021-06-21',
    '21', '30', '32', 'Online','31', '20', '43', '4', '2021-06-21', '45', '80KW', '45'),
('6', 'EQ6', '23W', '89', 'InStorage', 'Standard 221', 'L3', '3', 'M10', '1126','15', '20', '23', '2', '2021-06-21',
    '20', '30', '32', 'Online','32', '20', '43', '4','2021-06-21', '46', '80KW', '54'),
('7', 'EQ7', '54W', '12', 'InStorage', 'Standard 151', 'L3', '3', 'M10', '1127','16', '20', '23', '2', '2021-06-21',
    '20', '30', '32', 'Online','32', '20', '43', '4','2021-06-21', '47', '80KW', '45')
;

/* Insert Anomaly */
/* Generators, UPSs, Transformers and Rectifiers cannot be added by themselves */
Insert into energy_equipment values 
('8', 'EQ8', '67W', '56', 'InStorage', 'Standard 151', 'L1', '1', 'M7', '1121', NULL, NULL, NULL, NULL, NULL,
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '48', '69KW', '40');
    
/* Update Anomaly */
/* All Model 7s needs to be updated to defunct */
Update energy_equipment set ServiceStatus = 'Defunct' where Equipmentid in ('1', '2');

Select * from energy_equipment;

/* Delete anomaly */
/* Any deletion has the possibly of losing info about Generators, UPSs, Transformers and Rectifiers */
Delete from energy_equipment where UPS_No = '20'; 

Select * from energy_equipment;