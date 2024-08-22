USE company;

show tables;
SELECT * FROM employee;
SELECT * FROM dept_locations;
DESC employee;
DESC departament;

-- Inserir dados na tabela employee
INSERT INTO employee (Fname, Minit, Lname, Ssn, Bdate, Address, Sex, Salary, Super_ssn, Dno) VALUES 
('John','B','Smith', '123456789', '1965-01-09', '731-Fondren-Houston-TX', 'M', 30000, '333445555', 5),
('Franklin', 'T', 'Wong', '333445555', '1955-12-08', '638-Voss-Houston-TX', 'M', 40000, '888665555', 5),
('Alicia', 'J', 'Zelaya', '999887777', '1968-01-19', '3321-Castle-Spring-TX', 'F', 25000, '987654321', 4),
('Jennifer', 'S', 'Wallace', '987654321', '1941-06-20', '291-Berry-Bellaire-TX', 'F', 43000, '888665555', 4),
('Ramesh', 'K', 'Narayan', '666884444', '1962-09-15', '975-Fire-Oak-Humble-TX', 'M', 38000, '333445555', 5),
('Joyce', 'A', 'English', '453453453', '1972-07-31', '5631-Rice-Houston-TX', 'F', 25000, '333445555', 5),
('Ahmad', 'V', 'Jabbar', '987987987', '1969-03-29', '980-Dallas-Houston-TX', 'M', 25000, '987654321', 4),
('James', 'E', 'Borg', '888665555', '1937-11-10', '450-Stone-Houston-TX', 'M', 55000, NULL, 1);

-- Inserir dados na tabela dependent
INSERT IGNORE INTO dependent (Essn, Dependent_name, Sex, Badate, Relationship) VALUES 
('333445555', 'Alice', 'F', '1986-04-05', 'Daughter'),
('333445555', 'Theodore', 'M', '1983-10-25', 'Son'),
('333445555', 'Joy', 'F', '1958-05-03', 'Spouse'),
('987654321', 'Abner', 'M', '1942-02-28', 'Spouse'),
('123456789', 'Michael', 'M', '1988-01-04', 'Son'),
('123456789', 'Alice', 'F', '1988-12-30', 'Daughter'),
('123456789', 'Elizabeth', 'F', '1967-05-05', 'Spouse');

-- Inserir dados na tabela departament
INSERT IGNORE INTO departament (Dname, Dnumber, Mgr_ssn, Mgr_start_date, Dept_create_date) VALUES 
('Research', 5, '333445555', '1988-05-22', '1986-05-22'),
('Administration', 4, '987654321', '1995-01-01', '1994-01-01'),
('Headquarters', 1, '888665555', '1981-06-19', '1980-06-19');

-- Inserir dados na tabela dept_locations
INSERT INTO dept_locations (Dnumber, Dlocation) VALUES 
(1, 'Houston'),
(4, 'Stafford'),
(5, 'Bellaire'),
(5, 'Sugarland'),
(5, 'Houston');

-- Inserir dados na tabela project
INSERT INTO project (Pname, Pnumber, Plocation, Dnum) VALUES 
('ProductX', 1, 'Bellaire', 5),
('ProductY', 2, 'Sugarland', 5),
('ProductZ', 3, 'Houston', 5),
('Computerization', 10, 'Stafford', 4),
('Reorganization', 20, 'Houston', 1),
('Newbenefits', 30, 'Stafford', 4);

-- Inserir dados na tabela works_on
INSERT INTO works_on (Essn, Pno, Hours) VALUES 
('123456789', 1, 32.5),
('123456789', 2, 7.5),
('666884444', 3, 40.0),
('453453453', 1, 20.0),
('453453453', 2, 20.0),
('333445555', 2, 10.0),
('333445555', 3, 10.0),
('333445555', 10, 10.0),
('333445555', 20, 10.0),
('999887777', 30, 30.0),
('999887777', 10, 10.0),
('987987987', 10, 35.0),
('987987987', 30, 5.0),
('987654321', 30, 20.0),
('987654321', 20, 15.0),
('888665555', 20, 0.0);

-- Query Recuperando Gerente e seu Depatarmento
select SSn, Fname, Dname from employee e, departament d where (d.Mgr_ssn = e.Ssn);

-- Query Recuperando Dependentes dos Empregados
select Fname, Dependent_name, Relationship from employee, dependent where Essn = Ssn;

-- Recuperando Departamento Específico
select * from departament where Dname = 'Research';

select Fname, Lname, Address 
from employee, departament 
where Dname= 'Research' and Dnumber=Dno;

-- Recuperar Atributos Especificos Pessoas Projeto e Horas
select Pname, Essn, Fname, Hours 
from project, works_on, employee 
where Pnumber= Pno and Essn = SSn;

-- Retira a Ambiguidade atraves do alias ou AS Statement - AS
select Dname, l.Dlocation as departament_name
from departament as d, dept_locations as l
where d.Dnumber = l.Dnumber;

-- Consulta 1: Qual o departamento com maior número de pessoas?
SELECT d.Dname, COUNT(e.Ssn) AS NumFuncionarios
FROM employee e
JOIN departament d ON e.Dno = d.Dnumber
GROUP BY d.Dname
ORDER BY NumFuncionarios DESC
LIMIT 1;

-- Índice para a Consulta 1
CREATE INDEX idx_employee_dno ON employee(Dno); 
-- Esse índice melhora o desempenho ao contar o número de funcionários por departamento

-- Consulta 2: Quais são os departamentos por cidade?
SELECT d.Dname, dl.Dlocation
FROM departament d
JOIN dept_locations dl ON d.Dnumber = dl.Dnumber;

-- Índice para a Consulta 2
CREATE INDEX idx_dept_locations_dnumber ON dept_locations(Dnumber);
-- Esse índice otimiza o JOIN entre as tabelas `departament` e `dept_locations`.

-- Consulta 3: Relação de empregados por departamento
SELECT d.Dname, e.Fname, e.Lname
FROM employee e
JOIN departament d ON e.Dno = d.Dnumber
ORDER BY d.Dname, e.Lname;

-- Índice para a Consulta 3
CREATE INDEX idx_employee_dno_name ON employee(Dno, Lname);
-- Um índice composto para otimizar a consulta que ordena os resultados por departamento e nome do empregado.


