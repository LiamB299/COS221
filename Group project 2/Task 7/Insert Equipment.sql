Delete from EqModel_info;
Delete from UPS;
Delete from Transformers;
Delete from EquipmentInfo;
Delete from EnergyEquipment;
Delete from Rectifier;
Delete from Rect_Sub;
Delete from Generator;
Delete from Generator_Sub;

Insert into EqModel_info values 
('M1', '3', '1221', 'InUse'),
('M2', '4', '1222', 'Defunct'),
('M3', '4', '1224', 'ToBeRepaired'),
('M4', '5', '1225', 'Defunct'),
('M5', '4', '1227', 'InUse'),
('M6', '5', '1226', 'ToBeRepaired')
;


Insert into UPS values 
('1', '5', '66', 'Online'),
('2', '12', '88', 'Online'),
('3', '8', '67', 'Offline'),
('4', '9', '77', 'Online')
;


Insert into Transformers values 
('1','4','82'),
('2','5','94'),
('3','5','92'),
('4','3','67'),
('5','2','44')
;

/* NULL means the model belongs to transformer, ups etc. */
Insert into EquipmentInfo values 
('1', 'EQ1', 'L1', 'M1', 'Standard 151'),
('2', 'EQ2', 'L1', 'M2', 'Standard 221'),
('3', 'EQ3', 'L2', 'M3', 'Standard 216'),
('4', 'EQ4', 'L2', 'M4', 'Standard 216'),
('5', 'EQ5', 'L3', NULL, 'Standard 221')
;

/* double null means it it is not a transformer nor a UPS */
Insert into EnergyEquipment values 
('1', '1'),
('2', '1'),
('3', '1'),
('4', '1'),
('5', '1')
;

Insert into UPS_Equipment values 
('4','2')
;


Insert into Transformer_Equipment values 
('3','1'),
('5','2')
;


Insert into Rectifier values 
('1', '12', '66', '3', '2021-08-19'),
('2', '11', '76', '1', '2021-08-21'),
('3', '10', '88', '3', '2021-08-12'),
('4', '9', '90', '2', '2021-08-01')
;


Insert into Rect_Sub values 
('2', '1')
;


Insert into Generator values 
('1', '12', '66', '3', '2021-08-19'),
('2', '11', '76', '1', '2021-08-21'),
('3', '10', '88', '3', '2021-08-12'),
('4', '9', '90', '2', '2021-08-01')
;


Insert into Generator_Sub values 
('1', '3')
;

/* insert anomaly */
/* add a new rectifier and give it an equipment id */
Insert into EquipmentInfo values 
('6', 'EQ6', 'L3', NULL, 'Standard 221')
;

Insert into EnergyEquipment values 
('6', '1')
;

Insert into Rectifier values 
('5', '18', '90', '2', '2021-08-25')
;

Insert into Rect_Sub values 
('6','5')
;

/* modification anomaly */
/* General Model 4s are defunct */
Update EqModel_info set ServiceStatus = 'Defunct' where Model = 'M4';

Select * from eqmodel_info;


/* deletion anomaly */
/* Deletions do affect any other enities data */
Delete from EquipmentInfo where EquipmentID in (select EquipmentID from generator_sub where GenID = '3');
Delete from Generator where GenID = '3';

Select * from EquipmentInfo;
Select * from Generator;