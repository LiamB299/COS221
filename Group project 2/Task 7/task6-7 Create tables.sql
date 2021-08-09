CREATE TABLE Datacenter_Locations (
    Address VARCHAR(30) NOT NULL,
    Location VARCHAR(30),
    PRIMARY KEY(Address, Location)
);

CREATE TABLE Datacenter_ConsumptionInfo (
    NumberOfServers INT,
    RackCount INT,
    EnergyConsumption INT,
    PRIMARY KEY(NumberOfServers)
);

CREATE TABLE Datacenter (
    MTXid VARCHAR(5) NOT NULL,
    Name VARCHAR(30),
    NumberOfServers INT,
    PRIMARY KEY(MTXid),
    FOREIGN KEY(NumberOfServers) REFERENCES Datacenter_ConsumptionInfo(NumberOfServers) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE WareHouse (
    WareHouseNo VARCHAR(5) NOT NULL,
    Warehouse_Capacity INT,
    WareHouse_Name VARCHAR(30),
    WareHouseStatus ENUM('Empty', 'InUse', 'Full'),
    PRIMARY KEY(WareHouseNo)
);

CREATE TABLE DataCenter_Spread (
    MTXid VARCHAR(5) NOT NULL,
    WareHouseNo VARCHAR(5) NOT NULL,
    Address VARCHAR(30),
    PRIMARY KEY(MTXid, WareHouseNo, Address),
    FOREIGN KEY(MTXid) REFERENCES Datacenter(MTXid) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY(WareHouseNo) REFERENCES WareHouse(WareHouseNo) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(Address) REFERENCES Datacenter_Locations(Address) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Room (
    RoomID VARCHAR(5) NOT NULL,
    Capacity INT,
    RoomName VARCHAR(20),
    RoomStatus ENUM('Empty', 'InUse', 'Full'),
    RoomType ENUM('Main', 'BackUp', 'SingleClient', 'Shared', 'StoreRoom', 'Office', 'Waiting', 'Meeting', 'Maintenance'),
    PRIMARY KEY(RoomID)
);

CREATE TABLE Room_sub (
    MTXid VARCHAR(5) NOT NULL,
    RoomID VARCHAR(5) NOT NULL,
    PRIMARY KEY(MTXid, RoomID),
    FOREIGN KEY(MTXid) REFERENCES Datacenter(MTXid) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY(RoomID) REFERENCES Room(RoomID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE PlantSpecialists (
    PlantSpecialist_name VARCHAR(30),
    PlantSpecialist_ID VARCHAR(5) NOT NULL,
    PRIMARY KEY(PlantSpecialist_ID)
);

CREATE TABLE PlantSpecialists_sub (
    MTXid VARCHAR(5) NOT NULL,
    PlantSpecialist_ID VARCHAR(5) NOT NULL,
    PRIMARY KEY(PlantSpecialist_ID, MTXid),
    FOREIGN KEY(MTXid) REFERENCES Datacenter(MTXid) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY(PlantSpecialist_ID) REFERENCES PlantSpecialists(PlantSpecialist_ID) ON UPDATE CASCADE ON DELETE CASCADE
);

/*******************************************************/
CREATE TABLE EqModel_info (
    Model VARCHAR(10),
    Rating VARCHAR(5),
    SerialNumber VARCHAR(12),
    ServiceStatus ENUM('InUse', 'InStorage','ToBeRepaired', 'RequiresMaintenance', 'Defunct'),
    PRIMARY KEY(Model)
);

CREATE TABLE UPS (
    UPS_No INT NOT NULL, 
    UPS_Capacity INT,
    UPS_Utilization INT,
    UPS_Status ENUM('OffLine', 'RequiresMaintenance', "Broken", "Online"),
    PRIMARY KEY(UPS_No)
);

CREATE TABLE Transformers (
    TransformerID VARCHAR(5) NOT NULL,
    TransformerRating VARCHAR(5),
    TransformerUtilization INT,
    PRIMARY KEY(TransformerID)
);

CREATE TABLE EquipmentInfo (
    Equipmentid VARCHAR(5) NOT NULL,
    EqName VARCHAR(20),
    Location VARCHAR(30),
    Model VARCHAR(10),
    CommsProtocol ENUM('Standard 151', 'Standard 221', 'Standard 216'),
    PRIMARY KEY(Equipmentid),
    FOREIGN KEY(Model) REFERENCES EqModel_info(Model) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE EnergyEquipment (
    Equipmentid VARCHAR(5) NOT NULL,
    MTXid VARCHAR(5),
    PRIMARY KEY(Equipmentid),
    FOREIGN KEY(Equipmentid) REFERENCES EquipmentInfo(Equipmentid) ON UPDATE CASCADE ON DELETE CASCADE
    /*FOREIGN KEY(MTXid) REFERENCES Datacenter(MTXid) ON UPDATE CASCADE ON DELETE CASCADE*/
);

CREATE TABLE UPS_Equipment (
	Equipmentid VARCHAR(5) NOT NULL,
	UPS_No INT,
	FOREIGN KEY(Equipmentid) REFERENCES EquipmentInfo(Equipmentid) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(UPS_No) REFERENCES UPS(UPS_No) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Transformer_Equipment (
	Equipmentid VARCHAR(5) NOT NULL,
	TransformerID VARCHAR(5),
	FOREIGN KEY(Equipmentid) REFERENCES EquipmentInfo(Equipmentid) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(TransformerID) REFERENCES Transformers(TransformerID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Rectifier (
    RectID VARCHAR(5) NOT NULL,
    RectCapacity INT,
    RectUtilization INT,
    Rect_ActiveAlarms INT,
    Rect_ServiceDate DATE,
    PRIMARY KEY(RectID)
);

CREATE TABLE Rect_Sub (
    Equipmentid VARCHAR(5) NOT NULL,
    RectID VARCHAR(5) NOT NULL,
    PRIMARY KEY(Equipmentid, RectID),
    FOREIGN KEY(Equipmentid) REFERENCES EquipmentInfo(Equipmentid) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY(RectID) REFERENCES Rectifier(RectID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Generator (
    GenID VARCHAR(5) NOT NULL,
    GenCapacity INT,
    GenUtilization INT,
    Gen_ActiveAlarms INT,
    Gen_ServiceDate DATE,
    PRIMARY KEY(GenID)
);

CREATE TABLE Generator_Sub (
    Equipmentid VARCHAR(5) NOT NULL,
    GenID VARCHAR(5) NOT NULL,
    PRIMARY KEY(Equipmentid, GenID),
    FOREIGN KEY(Equipmentid) REFERENCES EquipmentInfo(Equipmentid) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY(GenID) REFERENCES Generator(GenID) ON UPDATE CASCADE ON DELETE CASCADE
);

/***************************************************************/
CREATE TABLE Rack_models (
    Model VARCHAR(10),
    SerialNumber VARCHAR(12),
    Processor_Vendor VARCHAR(30),
    ProcessorDetails VARCHAR(200), 
    PRIMARY KEY(Model)
);

CREATE TABLE Rack_info (
    RackID VARCHAR(5) NOT NULL,
    RackLabel VARCHAR(5),
    Model VARCHAR(10),
    Utilization INT,
    PRIMARY KEY(RackID),
    FOREIGN KEY(Model) REFERENCES Rack_models(Model) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Server_info (
    ServerID VARCHAR(5) NOT NULL,
    ServerName VARCHAR(30),
    VMCount INT,
    PRIMARY KEY(ServerID)
);

CREATE TABLE Server (
    ServerID VARCHAR(5) NOT NULL,
    RackID VARCHAR(5) NOT NULL,
    ResponsibleStaff VARCHAR(5),
    PRIMARY KEY(ServerID, RackID),
    FOREIGN KEY(ServerID) REFERENCES Server_info(ServerID) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY(RackID) REFERENCES Rack_info(RackID) ON UPDATE CASCADE ON DELETE CASCADE
    /*FOREIGN KEY(ResponsibleStaff) REFERENCES Staff(Empl_ID),*/
);

CREATE TABLE VM_Names (
    ServerID VARCHAR(5) NOT NULL,
    VMName VARCHAR(30),
    PRIMARY KEY(ServerID, VMName),
    FOREIGN KEY(ServerID) REFERENCES Server_info(ServerID) ON UPDATE CASCADE ON DELETE CASCADE
);

/**********************************************************/
CREATE TABLE Project_info (
    ProjectID VARCHAR(5) NOT NULL,
    ProjectName VARCHAR(30),
    PRIMARY KEY(ProjectID)
);

CREATE TABLE Employee_info (
    Address VARCHAR(30),
    Empl_ID VARCHAR(5) NOT NULL,
    PhoneNumber CHAR(10),
    Department VARCHAR(30), /*Name of department*/
    HoursInDataCenter INT,
    Age INT,
    HealthStatus ENUM('Healthy', 'ChronicIllness', 'OnLeave'),
    PRIMARY KEY(Empl_ID)
);

CREATE TABLE Staff_Projects (
    ProjectID VARCHAR(5) NOT NULL,
    Empl_ID VARCHAR(5) NOT NULL,
    PRIMARY KEY(Empl_ID, ProjectID),
    FOREIGN KEY(ProjectID) REFERENCES Project_info(ProjectID) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY(Empl_ID) REFERENCES Employee_info(Empl_ID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Department_Supervisor (
    Department VARCHAR(30), /*Name of department*/
    Supervisor VARCHAR(5),
    PRIMARY KEY(Department, Supervisor),
	FOREIGN KEY(Supervisor) REFERENCES Employee_info(Supervisor) ON UPDATE CASCADE ON DELETE CASCADE
	
);

CREATE TABLE Emergency_Contacts (
    Empl_ID VARCHAR(5) NOT NULL,
    EM_fname VARCHAR(30),
	EM_lname VARCHAR(30),
	EM_phone CHAR(10),
    PRIMARY KEY(Empl_ID),
    FOREIGN KEY(Empl_ID) REFERENCES Employee_info(Empl_ID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Staff_Names (
    Empl_ID VARCHAR(5) NOT NULL,
    fName VARCHAR(30), 
	mName VARCHAR(30),
	sName VARCHAR(30),
    PRIMARY KEY(Empl_ID),
    FOREIGN KEY(Empl_ID) REFERENCES Employee_info(Empl_ID) ON UPDATE CASCADE ON DELETE CASCADE
);

/***********************************************************/

CREATE TABLE Client (
    ClientID VARCHAR(5) NOT NULL,
    Name VARCHAR(30),
    ProjectID VARCHAR(5),
    ResponsibleEmployee VARCHAR(5),
    License ENUM('SmallBusiness', 'Corporate', 'SingleUser', 'MultiCorporate'),
    PRIMARY KEY(ClientID),
    FOREIGN KEY(ProjectID) REFERENCES Project(ProjectID),
    FOREIGN KEY(ResponsibleEmployee) REFERENCES Staff(Empl_ID)
);

CREATE TABLE Contracts (
    ProjectID VARCHAR(5),
    ContractName VARCHAR(30),
    Contract_Start DATE,
    Contract_End DATE,
    Contract_Length INT,
    PRIMARY KEY(ProjectID),
    FOREIGN KEY(ProjectID) REFERENCES Project(ProjectID)
);

CREATE TABLE Client_ContactInfo (
    ClientID VARCHAR(5) NOT NULL,
    ContactDetails VARCHAR(200),
    PRIMARY KEY(ClientID),
    FOREIGN KEY(ClientID) REFERENCES Client(ClientID)
);

CREATE TABLE Client_Servers (
    ClientID VARCHAR(5) NOT NULL,
    ServerID VARCHAR(5),
    PRIMARY KEY(ClientID),
    FOREIGN KEY(ClientID) REFERENCES Client(ClientID),
    FOREIGN KEY(ServerID) REFERENCES Server_info(ServerID)
);
