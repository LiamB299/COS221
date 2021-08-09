create table Cars (
	CarID integer not null,
    Description varchar(25),
    YearModel year,
    primary key (CarID),
    check (CarID > 0),
    check (YearModel > 1901)
);

create table Customer (
	CustomerID integer NOT NULL,
    Name varchar(20),
    Surname varchar(20),
    Title varchar(4),
    Address varchar(35),
    primary key (CustomerID)
);

CREATE TABLE Motorbikes (
    BikeID INTEGER NOT NULL,
    Type varchar(25),
    YearModel YEAR,
    PRIMARY KEY (BikeID),
    CHECK (YearModel > 1901)
);

CREATE TABLE Customer_Bike (
    CustID INT,
    BID INTEGER,
    RentedDate DATE,
    FOREIGN KEY (CustID) REFERENCES Customer(CustomerID) 
		on update cascade 	on delete set null,
    FOREIGN KEY (BID) REFERENCES Motorbikes(BikeID)
		on update cascade 	on delete set null
);

CREATE TABLE Customer_Car (
    CustID INTEGER,
    CID INTEGER,
    RentedDate DATE,
    FOREIGN KEY (CustID) REFERENCES Customer(CustomerID)
		on update cascade 	on delete set null,
    FOREIGN KEY (CID) REFERENCES Cars(CarID)
		on update cascade 	on delete set null
);

CREATE TABLE Returned_Car (
    CustID INTEGER,
    CID INTEGER,
    ReturnedDate DATE,
    FOREIGN KEY (CustID) REFERENCES Customer(CustomerID)
		on update cascade 	on delete set null,
    FOREIGN KEY (CID) REFERENCES Cars(CarID)
		on update cascade 	on delete set null
);

CREATE TABLE Returned_Bike (
    CustID INTEGER,
    BID INTEGER,
    ReturnedDate DATE,
    FOREIGN KEY (CustID) REFERENCES Customer(CustomerID)
		on update cascade 	on delete set null,
    FOREIGN KEY (BID) REFERENCES Motorbikes(BikeID)
		on update cascade 	on delete set null
);