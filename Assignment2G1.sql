#create DB
CREATE DATABASE `LMT_University`; 

#Create a New schema
CREATE SCHEMA `enrol` ;

USE enrol;

#Address Table
CREATE TABLE `enrol`.`Address` (
  `AddressID` INT NOT NULL AUTO_INCREMENT,
  `StreetAddress` VARCHAR(45) NULL,
  `City` VARCHAR(45) NOT NULL,
  `State` VARCHAR(45) NULL,
  `PostalCode` VARCHAR(45) NULL,
  `Country` VARCHAR(45) NOT NULL,
  `InsertedOn` DATETIME NOT NULL,
  PRIMARY KEY (`AddressID`),
  UNIQUE INDEX `AddressID_UNIQUE` (`AddressID` ASC) VISIBLE);

#Add the data onto it

Drop Table Address;
show global variables like 'local_infile';
set global local_infile=1 -h$LOCALHOST -root -toor -LMT_University ;

LOAD DATA LOCAL INFILE 'c:/Users/claptrap/Downloads/SQL/SQL/Address_Table.csv'
INTO TABLE Address
FIELDS TERMINATED BY ','
    ENCLOSED BY '"'address
LINES TERMINATED BY '\n'
(AddressID, StreetAddress, City,State,PostalCode,Country,InsertedOn);

Select * from Address;

#Create the department tables
CREATE TABLE `enrol`.`Department` (
  `DepartmentID` INT NOT NULL AUTO_INCREMENT,
  `DepartmentName` VARCHAR(45) NOT NULL,
  `DepartmentDescription` VARCHAR(45) NULL,
  `DepartmentCapacity` INT NOT NULL,
  `InsertedOn` DATETIME NOT NULL,
  PRIMARY KEY (`DepartmentID`));
  


#Add the data onto it

LOAD DATA LOCAL INFILE '/Users/terminus/Downloads/SQL/Department_Table.csv'
INTO TABLE Department
FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
LINES TERMINATED BY '\n'
(DepartmentID, DepartmentName, DepartmentDescription,DepartmentCapacity,InsertedOn);

SELECT * From Department;

#Create Lecturer Table
CREATE TABLE `enrol`.`Lecturer` (
  `LecturerID` INT NOT NULL AUTO_INCREMENT,
  `LecturerName` VARCHAR(45) NOT NULL,
  `LecturerHighestQualification` VARCHAR(45) NULL,
  `LecturerAge` VARCHAR(45) NOT NULL,
  `DepartmentID` INT NOT NULL,
  `InsertedOn` DATETIME NULL,
  PRIMARY KEY (`LecturerID`));

#Add the data onto it  
LOAD DATA LOCAL INFILE '/Users/terminus/Downloads/SQL/Lecture_Table.csv'
INTO TABLE Lecturer
FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
LINES TERMINATED BY '\n'
(LecturerID, LecturerName, LecturerHighestQualification,LecturerAge,DepartmentID,InsertedOn);
  
SELECT * From Lecturer;
  
  #Create student table
#department
  CREATE TABLE `enrol`.`Student` (
  `StudentID` INT NOT NULL AUTO_INCREMENT COMMENT 'Student Unique Identifier',
  `StudentFirstName` VARCHAR(45) NOT NULL,
  `StudentLastName` VARCHAR(45) NULL,
  `StudentDOB` DATE NOT NULL,
  `StudentMobile` VARCHAR(45) NULL,
  `StudentRollNo` INT NOT NULL,
  `DepartmentID` INT NOT NULL,
  `AddressID` INT NOT NULL,
  `InsertedOn` DATETIME NOT NULL,
  PRIMARY KEY (`StudentID`));
  
#Add the data onto it  
LOAD DATA LOCAL INFILE '/Users/terminus/Downloads/SQL/Student_Table.csv'
INTO TABLE Student
FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
LINES TERMINATED BY '\n'
(StudentID,StudentFirstName,StudentLastName,StudentDOB,StudentMobile,StudentRollNo,DepartmentID,AddressID,InsertedOn);

SELECT * From Student;

# =======09
# =======a
select * from Student;

# ======b
SELECT * from Department;

# =======c
select * from Lecturer;

# =====d 
select * from Address;

# =====e
select StudentFullName, StudentDOB, StudentMobile from Student where StudentFullName = StudentFirstName + ‘‘ + StudentLastName;
   
# =======f
select StudentID, StudentFirstName, StudentLastName, StudentDOB, StudentMobile from Student where StudentRollNo=7 or AddressID=7;
   
# ====g
 select * from Student where StudentFirstName like 'B%';
 
 # ===h  
select * from Student where StudentFirstName like 'A%' and StudentFirstName like '%A';
 
# ===i 
select count(*) from Student where DepartmentID =6;

#===j
select DateDiff(year,GetDate(),StudentDOB), StudentFullName, StudentAge, StudentMobile from Student where StudentFullName= StudentFirstName + ‘‘ + StudentLastName;

#====k 
select DateDiff(year,GetDate(),StudentDOB), StudentFullName, StudentAge, StudentMobile from Student where StudentAge>23 AND StudentFullName= StudentFirstName + ‘‘ + StudentLastName;

# =====l 
select DateDiff(year,GetDate(),StudentDOB) as StudentAge, StudentFullName, StudentMobile from Student where StudentAge(21,23) AND StudentFullName= StudentFirstName + ‘‘ + StudentLastName;

# =====m 
Select LecturerID, LecturerName, LecturerHighestQualification, LecturerAge from Lecturer;

# ======n 
Select LecturerID, LecturerName, LecturerHighestQualification, LecturerAge from Lecturer where HighestQualification("MS","PhD");

# ======o
Select * from Lecturer where DepartmentID =2;

# ======p
Select * from Lecturer where LecturerName like 'R%';

# =====q 
Select * from Lecturer where LecturerName like 'R%' or LectureName like '%R';

# =====r
Select upper(LecturerName) from Lecturer;

# =====s
select substring(LecturerName,1,5) as LectureString, LecturerID, LecturerHighestQualification from Lecturer;

# =====t
select LecturerID, LecturerName, LecturerHighestQualification, datediff(year, getdate(),LecturerAge) from Lecturer ;

# =====u
select DepartmentID, DepartmentName, DepartmentDescription, DepartmentCapacity from Department;

# =====v
select * from Lecturer where DepartmentName= "ECE";

# =====w
select DepartmentName, DepartmentDescription, DepartmentCapacity from Department where DepartmentCapacity>60;

# =====x
SELECT AddressID, StreetAddress, City, State, PostalCode, Country from Address;

# =====y
select AddressID, StreetAddress, City, State, PostalCode, Country from Address where Country="Poland";

# ====z
select * from address where State=NULL;

# =====aa
select * from Address where PostalCode!=NULL; 

# =====bb
select * from Address where City ="Honda" and Country="Colombia";

# =======10
# ====a
select distinct(DOB) from Student;

# =====b
select distinct(DepartmentName) from Department;

# =====c
select distinct(Country) from Address;

# ====d
select distinct(State) from Address;

# ====e
select distinct(City) from Address;

# ====f
select LecturerID, LecturerName, LecturerHighestQualification, datediff(year,getdate(),LecturerAge) as LecturerYearService from Lecturer;

# ====g
   
   select LecturerID, LecturerName, LecturerHighestQualification, LecturerType 
   (case 
   when LecturerYearService< 5 then 'Begining Level Experience'
   when LecturerYearService>= 5 and LecturerYearService<10 then 'Mid Level experience' 
   else 'Experienced'
   End)
   from Lecturer;

# =======11
# ======a
Select * from student s join department d on s.DepartmentID = d.DepartmentID;

# ======b
Select * from student s join address a on s.AddressID = a.AddressID;

# ======c
Select * from Department d join Lecturer l on d.DepartmentID = l.DepartmentID;

# ======d
Select * from student s join department d
join Lecturer l on s.DepartmentID = d.DepartmentID and d.DepartmentID = l.DepartmentID;

# ======e
Select * from student s join department d
join Address a join Lecturer l on s.DepartmentID = d.DepartmentID and s.AddressID = a.AddressID;

# ======f
Select * from Student s, Address a, Department d, Lecturer l where s.AddressID=a.AddressID And s.DepartmentID=d.DepartmentID And d.DepartmentID=l.DepartmentID;

# ======g
Select * from student s join department d
join Address a join Lecturer l on s.DepartmentID = d.DepartmentID and s.AddressID = a.AddressID and d.DepartmentID = l.DepartmentID
And d.DepartmentName in ('ME' or 'ECE') ;

# ======h
Select * from student s join department d
join Lecturer l on s.DepartmentID = d.DepartmentID and d.DepartmentID = l.DepartmentID
And l.LecturerHighestQualification in ('MS' or 'PhD') ;

# =====i
select * from student s join department d
join Address a on s.DepartmentID = d.DepartmentID and s.AddressID = a.AddressID
And a.Country='Thailand';

# =====j
Select count(s.StudentID), d.DepartmentName from Student s, Department d
group by d.DepartmentName;

# =====k
Select count(l.LecturerID), d.DepartmentName from Lecturer l, Department d
group by d.DepartmentName;

# =====l
Select count(s.StudentID), a.Country from Student s, Address a
group by a.Country;

# =======12
#a
CREATE TABLE StudCopy AS SELECT * FROM Student;

#b
CREATE TABLE DeptCopy AS SELECT * FROM Department where 1=0;

#c
CREATE TABLE DeptCopy AS SELECT * FROM Department;
#d
CREATE TABLE AddrCopy AS SELECT * FROM Address where 1=0;
#e
CREATE TABLE AddrCopy AS SELECT * FROM Address;
#f
CREATE TABLE LecturerCopy AS SELECT * FROM Lecturer;

#  ========13
#a
TRUNCATE TABLE LecturerCopy;

#b
SET SQL_SAFE_UPDATES = 0;
DELETE FROM enrol.student 
WHERE enrol.student.DepartmentID = 1 ;
SET SQL_SAFE_UPDATES = 1;

select * from student;
#c
SET Country = Address.Country;
SELECT student.StudentID, address.AddressID, address.Country
FROM student 
INNER JOIN address ON student.studentID=address.AddressID;
DELETE FROM student
WHERE Country= 'Indonesia';

#d
SET Country = Address.Country;
SELECT student.StudentID, address.AddressID, address.City
FROM student 
INNER JOIN address ON student.studentID=address.AddressID;
DELETE FROM student
WHERE City= 'Nanshi';

#e
SET Country = Address.Country;
SELECT student.StudentID, address.AddressID, address.State
FROM student
INNER JOIN address ON student.studentID=address.AddressID;
DELETE FROM address
WHERE State = 'Bretagne';

#  ========14
#a
SET SQL_SAFE_UPDATES = 0;
UPDATE enrol.student
SET StudentMobile = 'Updated'
WHERE DepartmentID ='4';
SET SQL_SAFE_UPDATES = 1;

#b
SET SQL_SAFE_UPDATES = 0;
UPDATE enrol.student
SET DepartmentID = 3
WHERE StudentID =42;
SET SQL_SAFE_UPDATES = 1;

#c works
SET SQL_SAFE_UPDATES = 0;
update Lecturer 
set LecturerHighestQualification ='PHd'
where LecturerHighestQualification ='PhD';
SET SQL_SAFE_UPDATES = 1;

#d
SET SQL_SAFE_UPDATES = 0;
UPDATE enrol.address 
set PostalCode=00000 
where PostalCode IS NULL;
SET SQL_SAFE_UPDATES = 1;

#e
SET SQL_SAFE_UPDATES = 0;
Update enrol.Student
Set StudentLastName = 'Paul' 
where StudentFirstName = 'Jerry';
SET SQL_SAFE_UPDATES = 1;