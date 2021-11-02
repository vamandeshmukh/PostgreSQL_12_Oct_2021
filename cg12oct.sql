-- PostgreSQL training for CG trainees 12 Oct 2021 Batch 3  

-- tutorials -  https://www.postgresqltutorial.com/ 

CREATE TABLE emp (eid INT, ename VARCHAR(10), salary DECIMAL);

SELECT * FROM emp;

SELECT eid, ename, salary FROM emp;
SELECT ename, salary FROM emp;
SELECT ename FROM emp;

-- INSERT INTO emp (list of the columns) VALUES (list of the values);
INSERT INTO emp (eid, ename, salary) VALUES (101, 'Sonu', 45780);
INSERT INTO emp (eid, ename, salary) VALUES (102, 'Monu', 52140);
INSERT INTO emp (eid, ename, salary) VALUES (103, 'Tonu', 36560);
INSERT INTO emp (eid, ename, salary) VALUES (104, 'Ponu', 60500);
INSERT INTO emp (eid, ename, salary) VALUES (105, 'Gonu', 32000);

COMMIT; 

-- select a specific record - 
-- What is Sonu's salary? 
-- clauses 
SELECT ename, salary FROM emp WHERE ename = 'Sonu';
SELECT * FROM emp WHERE ename = 'Sonu';

SELECT * FROM emp WHERE salary < 40000;

SELECT * FROM emp WHERE salary > 40000 ORDER BY salary;
SELECT * FROM emp WHERE salary > 40000 ORDER BY salary DESC;

-- delete records 

SELECT * FROM emp;

DELETE FROM emp WHERE eid = 104;

-- update 
UPDATE emp SET salary = 55140 WHERE eid = 102;

COMMIT; 

SELECT * FROM emp;
SELECT MAX(salary) FROM emp; 
SELECT MIN(salary) FROM emp; 
SELECT AVG(salary) FROM emp; 
SELECT MAX(salary), MIN(salary), AVG(salary) FROM emp; 

SELECT ROUND(AVG(salary)) FROM emp; 
SELECT ROUND(AVG(salary), 2) FROM emp; 

SELECT current_date;
SELECT current_timestamp;
SELECT now();

-- 

class CustomerData {
	int customerId;
	String customerName;
}

CREATE TABLE customer_data 
	 (customer_id INT, 
	 customer_name VARCHAR(40), 
	 joining_date DATE, 
	 address VARCHAR(255));

SELECT * FROM customer_data;

INSERT INTO customer_data 
	(customer_id, customer_name, joining_date, address) 
	VALUES (101, 'Sonu', '10-Oct-2020', 'Abids Hyderabad 500001');

INSERT INTO customer_data VALUES 
	(102, 'Monu', '10-Oct-2020', 'Abids Hyderabad 500001');

INSERT INTO customer_data VALUES 
	(103, 'Tonu', NULL, 'Abids Hyderabad 500001');

INSERT INTO customer_data VALUES 
	(104, 'Ponu', '12-31-2019', 'Abids Hyderabad 500001');

INSERT INTO customer_data 
	(customer_id, customer_name, joining_date) 
	VALUES (105, 'Sonu', '3-Oct-2020');

-- bad [practice]
INSERT INTO customer_data 
	VALUES (105, 'Sonu', '3-Oct-2020');

-- error 
INSERT INTO customer_data 
	VALUES (105, 'Sonu', '30-Feb-2020', 'Hyd');

commit;

SELECT * FROM customer_data;

INSERT INTO customer_data 
	(customer_id, customer_name, joining_date, address) 
	VALUES (101, 'Sonu', '10-Oct-2020', 'Abids Hyderabad 500001');

INSERT INTO customer_data 
	(customer_name, joining_date, address) 
	VALUES ('Monu', '10-Oct-2020', 'Abids Hyderabad 500001');

-- constraints / integrity constraints 
-- primary key constrint 
-- https://www.postgresqltutorial.com/postgresql-primary-key/

CREATE TABLE customer 
	 (customer_id INT PRIMARY KEY, customer_name VARCHAR(40)); 

SELECT * FROM customer; 

INSERT INTO customer VALUES (101, 'Sonu');
INSERT INTO customer VALUES (102, 'Monu');
COMMIT; 

-- try - 
INSERT INTO customer VALUES (101, 'Sonu');
-- ERROR:  duplicate key value violates unique constraint "customer_pkey"
-- DETAIL:  Key (customer_id)=(101) already exists.
-- SQL state: 23505

INSERT INTO customer VALUES (NULL, 'Sonu');
-- ERROR:  null value in column "customer_id" violates not-null constraint
-- DETAIL:  Failing row contains (null, Sonu).
-- SQL state: 23502

COMMIT; 
SELECT * FROM customer; 

fk_cust (cust_id INT PRIMARY KEY, cust_name varchar(40) aadhaar INT UNIQUE NOT NULL);

-- foreign key constrint 
-- https://www.postgresqltutorial.com/postgresql-foreign-key/

CREATE TABLE deps (did INT PRIMARY KEY, dname VARCHAR(10), city VARCHAR(10));
SELECT * FROM deps;
CREATE TABLE emps (eid INT PRIMARY KEY, ename VARCHAR(10), did INT REFERENCES deps(did));
SELECT * FROM emps;
COMMIT; 

INSERT INTO deps VALUES (10, 'HR', 'Hyd');
INSERT INTO deps VALUES (20, 'Admin', 'Blr');
INSERT INTO deps VALUES (30, 'MKTG', 'Che');
COMMIT; 

INSERT INTO emps VALUES (101, 'Sonu', 10);
INSERT INTO emps VALUES (102, 'Monu', 10);
INSERT INTO emps VALUES (103, 'Tonu', 20);
INSERT INTO emps VALUES (104, 'Ponu', 30);
INSERT INTO emps VALUES (105, 'Gonu', 30);
COMMIT; 

SELECT * FROM deps;
SELECT * FROM emps;

-- try 
INSERT INTO emps VALUES (106, 'Lonu', 40);
-- ERROR:  insert or update on table "emps" violates foreign key constraint "emps_did_fkey"
-- DETAIL:  Key (did)=(40) is not present in table "deps".
-- SQL state: 23503

COMMIT; 

SELECT * FROM deps;
SELECT * FROM emps;

-- Review and learn other constraints 
-- https://www.postgresqltutorial.com/postgresql-not-null-constraint/
-- https://www.postgresqltutorial.com/postgresql-unique-constraint/

-- on delete pk-fk options 
DELETE FROM deps WHERE DID = 20;
-- ERROR:  update or delete on table "deps" violates foreign key constraint "emps_did_fkey" on table "emps"
-- DETAIL:  Key (did)=(20) is still referenced from table "emps".
-- SQL state: 23503
COMMIT; 

-- try and learn -  
-- ON DELETE SET NULL
-- ON DELETE CASCADE
-- ON UPDATE SET NULL
-- ON UPDATE CASCADE

-- JOIN 

SELECT * FROM emps;
SELECT * FROM deps;

-- In which dept does Sonu work? 
-- In which city does Sonu work? 
-- answer - JOIN 

SELECT * FROM emps, deps;
SELECT * FROM emps, deps WHERE ename = 'Sonu';

-- JOIN QUERY 
SELECT ename, dname 
FROM emps
JOIN deps ON emps.did = deps.did 
WHERE ename = 'Sonu';

COMMIT; 

-- try - 
SELECT ename, dname, did  
FROM emps
JOIN deps ON emps.did = deps.did 
WHERE ename = 'Sonu';
-- ERROR:  column reference "did" is ambiguous
-- LINE 1: SELECT ename, dname, did  
--                             ^
-- SQL state: 42702
-- Character: 22

SELECT ename, emps.did, dname
FROM emps
JOIN deps ON emps.did = deps.did 
WHERE ename = 'Sonu';

SELECT emps.ename, emps.did, deps.dname
FROM emps
JOIN deps ON emps.did = deps.did 
WHERE emps.ename = 'Sonu';

-- query optimizaiton using table aliases 
SELECT e.ename, e.did, d.dname
FROM emps e
JOIN deps d ON e.did = d.did 
WHERE e.ename = 'Sonu';

-- load sample database 
-- https://www.postgresqltutorial.com/postgresql-sample-database/






