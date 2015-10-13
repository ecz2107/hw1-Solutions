-- ISA
CREATE TABLE Professor (
       ssn int, 
       p_name text,
       type text,
       PRIMARY KEY(ssn),
       CHECK (type in ('junior', 'tenured'))
);

CREATE TABLE Tenured (
       ssn int REFERENCES Professor(ssn), 
       tenure_year int,
       PRIMARY KEY (ssn)
);

CREATE TABLE Junior (
       ssn int REFERENCES Professor(ssn), 
       no_of_years int,
       PRIMARY KEY (ssn)
);

CREATE TABLE Department (
       d_name text,
       d_chair int REFERENCES Tenured(ssn) NOT NULL,
       PRIMARY KEY(d_name)
);

-- aggregation
CREATE TABLE Term (
       semester text,
       year int,
       PRIMARY KEY(semester, year)
);

CREATE TABLE Course (
       c_number int,
       c_capacity int,
       c_name text,
       d_name text REFERENCES Department(d_name) NOT NULL,
       PRIMARY KEY (d_name, c_number)
);

CREATE TABLE Offers (
       o_id int,
       d_name text,
       c_number text,
       semester text,
       year int,
       FOREIGN KEY (d_name, c_number) REFERENCES Course(d_name, c_number),
       FOREIGN KEY (semester, year) REFERENCES Term(semester, year),
       -- a course cannot be offered more than once per semester
       UNIQUE(d_name, c_number, semester, year),
       PRIMARY KEY (o_id)
);

CREATE TABLE Teaches (
       int ssn REFERENCES Professor(ssn),
       int o_id REFERENCES Offers(o_id)
);

CREATE TABLE Affiliated (
       ssn int REFERENCES Professor(ssn),
       d_name text REFERENCES Department(d_name)
);
