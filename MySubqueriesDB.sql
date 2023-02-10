CREATE DATABASE MySubqueriesDB;

USE MySubqueriesDB;

CREATE TABLE employee(
id INT AUTO_INCREMENT NOT NULL,
name VARCHAR(20) NOT NULL,
phone VARCHAR(15) NOT NULL,
PRIMARY KEY(id)
);

CREATE TABLE employee_position(
employee_id INT NOT NULL,
employee_post VARCHAR(30) NOT NULL,
salary DOUBLE NOT NULL,
PRIMARY KEY(employee_id),
FOREIGN KEY (employee_id) REFERENCES employee(id) 
);

CREATE TABLE personal_data(
employee_id INT NOT NULL,
marital_status VARCHAR(20) NOT NULL,
birthday DATE NOT NULL,
adress VARCHAR(30) NOT NULL,
PRIMARY KEY(employee_id),
FOREIGN KEY (employee_id) REFERENCES employee(id) 
);


---------------------------------------------------------
INSERT INTO employee
(name, phone)
VALUES
('Bob','+380985456325'),
('Alan','+380965789652'),
('Mary','+380991111111');

INSERT INTO employee_position
(employee_id, employee_post, salary)
VALUES
(1, 'Director', 100000),
(2, 'Manager', 50000),
(3, 'Worker', 25000);

INSERT INTO personal_data
(employee_id, marital_status, birthday, adress)
VALUES
(1, 'married', '1993-10-08','Kyiv, Sacsaganskogo 9'),
(2, 'not married', '1992-09-09','Kyiv, Korolova 20'),
(3, 'married', '1991-12-10','Kyiv, Korolova 25');

---------------------------------------------------------
SELECT employee.name, employee.phone, 
(SELECT personal_data.adress FROM personal_data WHERE employee.id = personal_data.employee_id) AS adress
FROM employee;

SELECT 
(SELECT employee.name FROM employee WHERE employee.id = personal_data.employee_id) AS name,  
(SELECT employee.phone FROM employee WHERE employee.id = personal_data.employee_id) AS phone,
personal_data.birthday
FROM personal_data
WHERE personal_data.marital_status = 'not married';

SELECT 
(SELECT employee.name FROM employee WHERE employee.id = employee_position.employee_id) AS name,  
(SELECT employee.phone FROM employee WHERE employee.id = employee_position.employee_id) AS phone,
(SELECT personal_data.birthday FROM personal_data WHERE employee_id = employee_position.employee_id) AS birthday
FROM employee_position
WHERE employee_position.employee_post = 'Manager';