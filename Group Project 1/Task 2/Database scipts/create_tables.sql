CREATE SCHEMA Municipality_Elections;

CREATE TABLE Staff (
    work_id CHAR(13) NOT NULL,
    initials VARCHAR(8),
    surname VARCHAR(20),
    password VARCHAR(15),
    mgr_id CHAR(13),
    PRIMARY KEY(work_id),
    FOREIGN KEY(mgr_id) REFERENCES Staff(work_id)
);

CREATE TABLE Municipality (
    municipal_code VARCHAR(7) NOT NULL,
    type_of_mun ENUM("Local", "Metro"),
    province VARCHAR(20),
    seat VARCHAR(25),
    PRIMARY KEY(municipal_code)
);

CREATE TABLE Districts (
    Municipal_codes VARCHAR(7) NOT NULL,
    PRIMARY KEY(Municipal_codes)
);

CREATE TABLE Metro (
    name VARCHAR(60) NOT NULL,
    municipal_code VARCHAR(7),
    PRIMARY KEY(name),
    FOREIGN KEY(municipal_code) REFERENCES Municipality(municipal_code)
);

CREATE TABLE Local(
    name VARCHAR(60) NOT NULL,
    municipal_code VARCHAR(7),
    PRIMARY KEY(name),
    FOREIGN KEY(municipal_code) REFERENCES Municipality(municipal_code)
);

CREATE TABLE Voter (
    id_no CHAR(13) NOT NULL,
    address VARCHAR(25),
    age INTEGER,
    municipal_code VARCHAR(7),
    password VARCHAR(15),
    has_voted BIT(1),
    permitted_to_vote BIT(1),
    PRIMARY KEY(id_no),
    FOREIGN KEY(municipal_code) REFERENCES Municipality(municipal_code)
);

CREATE TABLE Party (
    party_no CHAR(5) NOT NULL,
    name VARCHAR(25), 
	permitted BIT(1),
	password VARCHAR(15),
    PRIMARY KEY(party_no)
);

CREATE TABLE Candidate (
    candidate_no CHAR(10) NOT NULL,
	municipal_code CHAR(7),
    is_ward BIT(1),
	is_pr BIT(1),
	registered BIT(1),
    PRIMARY KEY(candidate_no),
	FOREIGN KEY(municipal_code) references Municipality(municipal_code)
);

CREATE TABLE Ward (
    id_no CHAR(13) NOT NULL,
	p_num CHAR(5),
    cand_no CHAR(10),
    fname VARCHAR(20),
    sname VARCHAR(30),
	password VARCHAR(15),
    PRIMARY KEY(id_no),
    FOREIGN KEY(cand_no) REFERENCES Candidate(candidate_no),
	FOREIGN KEY(p_num) REFERENCES Party(party_no)
);

CREATE TABLE Proportional_Representatives (
    cand_no CHAR(5) NOT NULL,
    Dist_nom BIT(1),
    Ward_nom Bit(1),
    PRIMARY KEY(cand_no),
    FOREIGN KEY(cand_no) REFERENCES Candidate(candidate_no)
);

CREATE TABLE PR_Dist (
    cand_no CHAR(5) NOT NULL,
    party_no CHAR(5),
    PRIMARY KEY(cand_no),
    FOREIGN KEY(cand_no) REFERENCES Candidate(candidate_no),
    FOREIGN KEY(party_no) REFERENCES Party(party_no)
);

CREATE TABLE PR_ward (
    cand_no CHAR(5) NOT NULL,
    party_no CHAR(5),
    PRIMARY KEY(cand_no),
    FOREIGN KEY(cand_no) REFERENCES Candidate(candidate_no),
    FOREIGN KEY(party_no) REFERENCES Party(party_no)
);

CREATE TABLE Elections (
    municipal_code VARCHAR(7),
    data_of_vote DATE,
    ward_candidate CHAR(5) NOT NULL,
    pr_ward CHAR(5) NOT NULL,
    pr_district CHAR(5),
    FOREIGN KEY(municipal_code) REFERENCES Municipality(municipal_code)
);