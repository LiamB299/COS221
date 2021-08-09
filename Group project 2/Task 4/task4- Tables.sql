CREATE TABLE DATACENTER (
    Name VARCHAR(30),
    Location VARCHAR(30),
    Address VARCHAR(30),
	PlantSpecialist_one_id VARCHAR(5),
	PlantSpecialist_one_name VARCHAR(30),
	/*can be N many PlantSpecialists due to being a complex attribute*/
    EnergyConsumption INT,
    NumberOfServers INT,
    RackCount INT,
    MTXid VARCHAR(5) NOT NULL,
    RoomID VARCHAR(5) NOT NULL,
    Capacity INT,
    Status ENUM('Empty', 'InUse', 'Full'),
    RoomType ENUM('Main', 'BackUp', 'SingleClient', 'Shared', 'StoreRoom', 'Office', 'Waiting', 'Meeting', 'Maintenance'),
    RoomName VARCHAR(30),
    WareHouseNo VARCHAR(5) NOT NULL, /*can be unique depending on context...*/
    WareHouseCapacity INT,
    WarehouseName VARCHAR(30), 
    WareHouseStatus ENUM('Empty', 'InUse', 'Full'),
    PRIMARY KEY(MTXid, RoomID, WareHouseNo)
    /*for demo purposes these are disabled*/
    /*FOREIGN KEY(PlantSpecialist_one) references Staff(Empl_id)*/
    /*FOREIGN KEY(MTXid) REFERENCES DATACENTER(MTXid)*/
);

CREATE TABLE ENERGY_EQUIPMENT(
    Equipmentid VARCHAR(5) NOT NULL,
    EqName VARCHAR(20),
    Rating VARCHAR(5), /*Can be an int if agreed on rating for all equipment*/
    Utilization INT,
    ServiceStatus ENUM('InUse', 'InStorage','ToBeRepaired', 'RequiresMaintenance', 'Defunct'),
    CommsProtocol ENUM('Standard 151', 'Standard 221', 'Standard 216'),
    Location VARCHAR(30),
    MTXid VARCHAR(5),
    Model VARCHAR(10),
    SerialNumber VARCHAR(12), /*potential back up key*/
    RectID VARCHAR(5),
    RectCapacity INT,
    RectUtilization INT,
    Rect_ActiveAlarms INT,
    Rect_ServiceDate DATE,
    UPS_No INT NOT NULL, 
    UPS_Capacity INT,
    UPS_Utilization INT,
    UPS_Status ENUM('OffLine', 'RequiresMaintenance', "Broken", "Online"),
    GenID VARCHAR(5) NOT NULL,
    GenCapacity INT,
    GenUtilization INT,
    Gen_ActiveAlarms INT,
    Gen_ServiceDate DATE,
    TransformerID VARCHAR(5) NOT NULL,
    TransformerRating VARCHAR(5),
    TransformerUtilization INT,
    PRIMARY KEY(Equipmentid),
    FOREIGN KEY(MTXid) REFERENCES DATACENTER(MTXid)
); 

CREATE TABLE SERVER ( 
    ServerID VARCHAR(5) UNIQUE NOT NULL,
    RackID VARCHAR(5) NOT NULL,
    ServerName VARCHAR(30),
    RackLabel VARCHAR(5),
    Model VARCHAR(10),
    SerialNumber VARCHAR(12),
    ResponsibleStaff VARCHAR(5), /*ID of some employee*/
    Server_Utilization INT,
    Processor_Vendor VARCHAR(30),
    VMNames SET('VM1','VM2','VM3','VM4','VM5'), /*can be composite*/
    VMCount INT,
    ProcessorDetails VARCHAR(200), /*can be composite*/
    PRIMARY KEY(ServerID),
    FOREIGN KEY(ResponsibleStaff) REFERENCES STAFF(Empl_ID)
);

CREATE TABLE STAFF(
    fName VARCHAR(30), /*can be composite*/
	mName VARCHAR(30),
	sName VARCHAR(30),
    Address VARCHAR(30),
    Empl_ID VARCHAR(5) NOT NULL,
    PhoneNumber CHAR(10),
    Department VARCHAR(30), /*Name of department*/
	EM_fname VARCHAR(30),
	EM_lname VARCHAR(30),
	EM_phone CHAR(10),
    ProjectID VARCHAR(5), /*if null or empty it means they are not working on any projects, could be maintenance?*/
    ProjectName VARCHAR(30),
    HoursInDataCenter INT,
    Supervisor VARCHAR(5), /*If null is supervisor*/
    Age INT,
    HealthStatus ENUM('Healthy', 'ChronicIllness', 'OnLeave'), 
    PRIMARY KEY(Empl_ID)
);

/* Our Identified missing table */
CREATE TABLE Client (
    Client_ID VARCHAR(5) NOT NULL,
    License ENUM('SmallBusiness', 'Corporate', 'SingleUser', 'MultiCorporate'),
    ContactDetails SET('CD1', 'CD2', 'CD3', 'CD4', 'CD5'), 
    Name VARCHAR(30),
	ContractName VARCHAR(30),
    Contract_Start DATE,
    Contract_End DATE,
    Contract_Length INT,
	ServerIDs VARCHAR(5),
    ProjectID VARCHAR(5),
    ResponsibleEmployee VARCHAR(5), /*Supervisor ID*/
    PRIMARY KEY(Client_ID)
    /*FOREIGN KEY(ResponsibleEmployee) REFERENCES STAFF(Empl_ID)*/
);