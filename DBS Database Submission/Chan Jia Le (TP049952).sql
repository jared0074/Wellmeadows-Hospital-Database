--MODIFY WRONGLY INSERTED DATA
UPDATE In_Patient
SET Bed_Num = 49
WHERE In_PT_Num = 313

--TOTAL BED BASED ON WARD
SELECT COUNT (Bed_Num) AS TOTAL FROM Bed 
GROUP BY Ward_Num

--TOTAL BED OCCUPIED BY IN_PATIENT BASED ON WARD
SELECT COUNT (Bed_Num),Ward_Num AS TOTAL FROM In_Patient 
GROUP BY Ward_Num

Use Wellmeadows

--TO CREATE PROCEDURE TO CHECK WARD AVAILABILITY
CREATE PROCEDURE check_bed
AS
SELECT  Bed.Ward_Num, Ward.Ward_Name , COUNT (Bed.Bed_Num) AS AVAILABLE_BED FROM Bed
LEFT JOIN In_Patient
ON Bed.Bed_Num = In_Patient.Bed_Num
INNER JOIN Ward
ON Bed.Ward_Num = Ward.Ward_Num
WHERE In_Patient.Ward_Num IS NULL
GROUP BY Bed.Ward_Num,Ward.Ward_Name
GO

-- TO CREATE PROCEDURE TO CHECK APPOINTMENTS
CREATE PROCEDURE check_appointment
AS
SELECT Appointment.Appointment_Num, Patient.First_Name, Patient.Last_Name,Appointment_Date,Appointment.Appointment_Time, Appointment.Appointment_Location, Doctor.Doctor_Name FROM Appointment
INNER JOIN Doctor
ON Appointment.Staff_Num = Doctor.Staff_Num
INNER JOIN Patient
ON Appointment.Patient_Num = Patient.Patient_Num
GO

-- TO CREATE PROCEDURE TO CHECK NURSE IN CHARGE OF WARDS
CREATE PROCEDURE check_pic_ward @Ward_Name nvarchar(30)
AS
SELECT Nurse.First_Name,Nurse.Last_Name,Nurse.Position, Ward.Ward_Name,Ward.Tel_Extension_Num from Nurse
INNER JOIN Ward
ON Nurse.Ward_Num = Ward.Ward_Num
WHERE Ward.Ward_Name = @Ward_Name
GO

-- TO CREATE PROCEDURE TO CHECK IN_PATIENT LIST
CREATE PROCEDURE check_in_pt_list
AS
SELECT Patient.First_Name,Patient.Last_Name, Ward.Ward_Name, Ward.Tel_Extension_Num, Doctor.Doctor_Name AS Doc_In_Charge, Next_of_Kin.NK_Name from Patient
INNER JOIN In_Patient
ON Patient.Patient_Num = In_Patient.Patient_Num
INNER JOIN Ward
ON In_Patient.Ward_Num = Ward.Ward_Num
INNER JOIN Doctor
ON Patient.Staff_Num = Doctor.Staff_Num
INNER JOIN Next_of_Kin
ON Patient.NK_Num = Next_of_Kin.NK_Num
GO

-- TO CREATE PROCEDURE TO SEARCH WHETHER INPUT IS IN OUTPATIENT LIST
CREATE PROCEDURE search_patient_in_out_pt @Patient_Num int 
AS
SELECT Patient.* FROM Patient 
INNER JOIN Out_Patient
ON Patient.Patient_Num = Out_Patient.Patient_Num
WHERE Patient.Patient_Num = @Patient_Num
GO

/* Creating User Role */
CREATE ROLE In_Patient
CREATE ROLE Head_Nurse


/* Granting Permissions to In Patient Role */
GRANT SELECT (First_Name,Last_Name,Gender) ON Patient TO In_Patient
GRANT SELECT (Appointment_Num, Appointment_Date, Appointment_Time, Appointment_Location)ON Appointment TO In_Patient
GRANT SELECT ON Ward TO In_Patient
GRANT SELECT ON Bed TO In_Patient
GRANT SELECT (First_Name, Last_Name, Gender, Ward_Num)ON Nurse TO In_Patient
GRANT SELECT (Doctor_Name, Specialty, Tel_Extension)ON Doctor TO In_Patient


/* Granting Permissions to In Head Nurse Role */
GRANT SELECT, INSERT, UPDATE ON Patient TO Head_Nurse WITH GRANT OPTION
GRANT SELECT, INSERT, UPDATE ON Next_of_Kin TO Head_Nurse WITH GRANT OPTION
GRANT SELECT, INSERT, UPDATE, DELETE ON Appointment TO Head_Nurse WITH GRANT OPTION
GRANT SELECT, INSERT, UPDATE ON In_Patient TO Head_Nurse WITH GRANT OPTION
GRANT SELECT, UPDATE (Ward_Name, Tel_Extension_Num, Bed_Quantity, Ward_Gender) ON Ward TO Head_Nurse WITH GRANT OPTION
GRANT SELECT, UPDATE ON Bed TO Head_Nurse WITH GRANT OPTION
GRANT SELECT, INSERT, UPDATE ON Nurse TO Head_Nurse WITH GRANT OPTION
GRANT SELECT (Staff_Num,Doctor_Name,Specialty,Tel_Extension, Position) ON Doctor TO Head_Nurse

/* Grant Stored Procedure Execution to In patient and Head Nurse */
GRANT EXECUTE ON dbo.check_appointment TO In_Patient, Head_Nurse
GRANT EXECUTE ON dbo.check_bed TO In_Patient, Head_Nurse
GRANT EXECUTE ON dbo.check_in_pt_list TO In_Patient, Head_Nurse
GRANT EXECUTE ON dbo.check_pic_ward TO In_Patient, Head_Nurse
GRANT EXECUTE ON dbo.search_patient_in_out_pt TO Head_Nurse


/* In Patient User */
CREATE LOGIN JiaLeChan WITH PASSWORD = 'J@red3036', CHECK_EXPIRATION = ON, CHECK_POLICY = ON;
CREATE USER JiaLeChan FROM LOGIN JiaLeChan
CREATE LOGIN Jane WITH PASSWORD = 'J@ne8988', CHECK_EXPIRATION = ON, CHECK_POLICY = ON;
CREATE USER Jane FROM LOGIN Jane


/* Head Nurse User */
CREATE LOGIN TehSinBei WITH PASSWORD = 'T$hx3036', CHECK_EXPIRATION = ON, CHECK_POLICY = ON;
CREATE USER TehSinBei FROM LOGIN TehSinBei
CREATE LOGIN Rex WITH PASSWORD = 'R$$x1256', CHECK_EXPIRATION = ON, CHECK_POLICY = ON;
CREATE USER Rex FROM LOGIN Rex

/*Assigning Role to User*/
ALTER ROLE In_Patient Add MEMBER JiaLeChan
ALTER ROLE In_Patient Add MEMBER Jane

ALTER ROLE Head_Nurse Add MEMBER TehSinBei
ALTER ROLE Head_Nurse Add MEMBER Rex

Use master
/* LIMITING USER TO ONLY HAVE 2 QUERY SESSIONS ON THE SERVER Limiting */
CREATE TRIGGER Limit_User_Connection_TR ON ALL SERVER
	FOR LOGON
	AS
		BEGIN
			DECLARE @login NVARCHAR(100);
			SET @login = ORIGINAL_LOGIN();
			IF
			(
				SELECT COUNT(*)
				FROM sys.dm_exec_sessions
				WHERE is_user_process = 1
					AND original_login_name = @login
					AND program_name = 'Microsoft SQL Server Management Studio - Query'
			) > 2
				BEGIN
					PRINT 'You are Not Allowed to Have More Than 2 SQL Query Connection - Login by' + @login + 'Failed';
					ROLLBACK;
				END;
		END;

-- TRY LOGON TRIGGER ON USER JiaLeChan
GRANT VIEW SERVER STATE TO JiaLeChan

Use Wellmeadows
/* CREATING AUDITING TABLE FOR NURSE*/
CREATE TABLE NurseAudit
(
Nurse_Num int not null,
First_Name varchar(20),
Last_Name varchar(20),
Tel_Num varchar(20),
DOB varchar(20),
Full_Address varchar(100),
Gender varchar(10),
Position varchar(20),
Staff_Num int,
Ward_Num int,
Salary int,
Date_modi date,
Descrription varchar(100),
Trigger_acc varchar(50)
)

ALTER TABLE NurseAudit
DROP COLUMN Status

/* TRIGGER TO CHECK INSERTED AND UPDATED DETAILS OF NURSE SALARY BASED ON ROLE */
CREATE TRIGGER check_salary_insert
ON Nurse
INSTEAD OF INSERT, UPDATE
AS
	IF EXISTS (SELECT Salary FROM INSERTED WHERE Salary NOT BETWEEN 2000 AND 4500 AND Position = 'General Nurse')
	BEGIN
		PRINT 'Salary of General Nurse Must Be Between 2000 to 4500'
		INSERT INTO NurseAudit
		SELECT Nurse_Num, First_Name, Last_Name, Tel_Num, DOB, Full_Address, Gender, Position, Staff_Num, Ward_Num, Salary, getdate(),
		CONCAT('Unsuccessful Salary Insertion or Modification on ', Nurse_Num, ' Position: ',Position), ORIGINAL_LOGIN() FROM inserted
		Select * FROM inserted
	END
	ELSE IF EXISTS (SELECT Salary FROM INSERTED WHERE Salary NOT BETWEEN 5000 AND 8500 AND Position = 'Head Nurse')
	BEGIN
		PRINT 'Salary of Head Nurse Must Be Between 5000 to 8500'
		INSERT INTO NurseAudit
		SELECT Nurse_Num, First_Name, Last_Name, Tel_Num, DOB, Full_Address, Gender, Position, Staff_Num, Ward_Num, Salary, getdate(),
		CONCAT('Unsuccessful Salary Insertion or Modification on ', Nurse_Num, ' Position: ',Position), ORIGINAL_LOGIN() FROM inserted
	END
	ELSE IF EXISTS (SELECT Salary FROM INSERTED WHERE Salary BETWEEN 2000 AND 4500 AND Position = 'General Nurse')
	BEGIN
		Print 'Successful Insertion or Modification'
		INSERT INTO NurseAudit
		SELECT Nurse_Num, First_Name, Last_Name, Tel_Num, DOB, Full_Address, Gender, Position, Staff_Num, Ward_Num, Salary, getdate(),
		CONCAT('Successful Salary Insertion or Modification on ', Nurse_Num, ' Position: ',Position), ORIGINAL_LOGIN() FROM inserted
		-- CHECK IS DELETE FROP EXISTING RECORD
		IF EXISTS (SELECT * FROM deleted)
		BEGIN
			DELETE FROM Nurse WHERE Nurse_Num = (SELECT Nurse_Num FROM deleted)
		END 
		INSERT INTO Nurse SELECT Nurse_Num, First_Name, Last_Name, Tel_Num, DOB, Full_Address, Gender, Position,Salary, Staff_Num, Ward_Num,Stat FROM inserted

	END
	ELSE IF EXISTS (SELECT Salary FROM INSERTED WHERE Salary BETWEEN 5000 AND 8500 AND Position = 'Head Nurse')
	BEGIN
		Print 'Successful Insertion or Modification'
		INSERT INTO NurseAudit
		SELECT Nurse_Num, First_Name, Last_Name, Tel_Num, DOB, Full_Address, Gender, Position, Staff_Num, Ward_Num, Salary, getdate(),
		CONCAT('Successful Salary Insertion or Modification on ', Nurse_Num, ' Position: ',Position), ORIGINAL_LOGIN() FROM inserted
		
		IF EXISTS (SELECT * FROM deleted)
		BEGIN
			DELETE FROM Nurse WHERE Nurse_Num = (SELECT Nurse_Num FROM deleted)
		END 
		INSERT INTO Nurse SELECT Nurse_Num, First_Name, Last_Name, Tel_Num, DOB, Full_Address, Gender, Position,Salary, Staff_Num, Ward_Num,Stat FROM inserted
		END
GO

ALTER TABLE Nurse
DROP COLUMN Stat

/* CREATE A NEW COLUMN STATUS */
ALTER TABLE Nurse
	ADD Stat varchar (10)


/* TRIGGER TO RESTRICT DELETION OF NURSE ACCOUNT AND SET IT INTO INACTIVE */
CREATE TRIGGER stop_del_nurse
ON Nurse
INSTEAD OF DELETE
AS
BEGIN
	RAISERROR ('Nurse Account Should Not Be Deleted, System will change the status into inactive',14,11)
	INSERT INTO NurseAudit
	SELECT Nurse_Num, First_Name, Last_Name, Tel_Num, DOB, Full_Address, Gender, Position, Staff_Num, Ward_Num, Salary, getdate(),
	CONCAT('Attempted Deletion on ', Nurse_Num, ' Position: ',Position), ORIGINAL_LOGIN() FROM deleted

	UPDATE Nurse
	SET Stat = 'Inactive'
	FROM Nurse as s INNER JOIN deleted as d
	ON s.Nurse_Num = d.Nurse_Num
END

SELECT * FROM Nurse


/* TRY UPDATING WITH ERROR SALARY*/
UPDATE Nurse
SET Salary = 1000
WHERE Nurse_Num = 701

/* TRY UPDATING WITH VALID SALARY*/
UPDATE Nurse
SET Salary = 4500
WHERE Nurse_Num = 701


/* TRY INSERTING WITH INVALID RESULT */
INSERT INTO Nurse VALUES
(753, 'Well','Done','0124168988','1951-05-23','32, Try Medan Kurau 2, Wherre', 'Female','Head Nurse',2000,601,2,'Active')

/* TRY INSERTING WITH VALID RESULT */
INSERT INTO Nurse VALUES
(759, 'Well','Done','0124168988','1951-05-23','32, Try Medan Kurau 2, Wherre', 'Female','Head Nurse',7000,601,2,'Active')
SELECT * FROM Nurse

/* TRY DELETING A NURSE RECORD*/
DELETE FROM Nurse
WHERE Nurse_Num = 701

/* CHECK TABLE */
SELECT * FROM Nurse 
SELECT * FROM NurseAudit


/*CREATING MASTER KEY*/
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'ENCRYPT@123'; 

/* CREATING ASSYMETRIC KEY THAT IS PROTECTED BY MASTER KEY */
Create ASymmetric Key fld_ASymKey1 WITH ALGORITHM = RSA_2048;

/* CREATING SYMMETRIC KEY PROTECTED BY THE ASSYMETRIC KEY */
CREATE SYMMETRIC KEY Encrypted_Key WITH   
    ALGORITHM = AES_256 
    ENCRYPTION BY ASYMMETRIC KEY fld_ASymKey1

/*CHECK ENCRYPTION HIEARCHY*/
select * from sys.symmetric_keys 
select * from sys.asymmetric_keys 
select * from sys.key_encryptions 

/* ENCRYPTING SALARY COLUMN FOR NURSE AND DOCTOR TABLE*/
ALTER TABLE Nurse
ADD Salary_Encrypted varbinary(MAX)
ALTER TABLE Doctor
ADD Salary_Encrypted varbinary(MAX)

/* EXECUTE WHEN MISTAKEN DELETION OF SALARY */
ALTER TABLE Nurse
Add Salary int
ALTER TABLE Doctor
Add Salary int

UPDATE Nurse
	SET Salary = CONVERT(nvarchar,DECRYPTBYKEY(Salary_Encrypted))
	FROM Nurse
	GO

UPDATE Doctor
	SET Salary = CONVERT(nvarchar,DECRYPTBYKEY(Salary_Encrypted))
	FROM Doctor
	GO


/* USING THE SYMMETRIC KEY TO ENCRYPT THE SALARY COLUMN */
OPEN SYMMETRIC KEY Encrypted_Key
	DECRYPTION BY ASYMMETRIC Key fld_ASymKey1

UPDATE Nurse
	SET Salary_Encrypted = ENCRYPTBYKEY (Key_GUID('Encrypted_Key'),convert(nvarchar,Salary))
	FROM Nurse
	GO

UPDATE Doctor
	SET Salary_Encrypted = ENCRYPTBYKEY (Key_GUID('Encrypted_Key'),convert(nvarchar,Salary))
	FROM Doctor
	GO

	
/* REMOVING NOT ENCRYPTED SALARY COLUMN (IF WANTED) */
ALTER TABLE Nurse
DROP COLUMN Salary

ALTER TABLE Doctor
DROP COLUMN Salary


/* CHECK RESULT OF THE ENCRYPTED OUTPUT*/
SELECT Nurse_Num, First_Name,Last_Name, Salary_Encrypted FROM Nurse
SELECT Staff_Num,Doctor_Name, Salary_Encrypted FROM Doctor


/* CLOSING THE SYMMETRIC KEY TO SEE OUTPUT OF DECRYPTION WITHOUT KEY*/
CLOSE SYMMETRIC KEY Encrypted_Key


/* OPENING THE KEY TO ENCRYPT OR DECRYPT THE COLUMNS*/
OPEN SYMMETRIC KEY Encrypted_Key
	DECRYPTION BY ASYMMETRIC Key fld_ASymKey1


/* QUERY RESULT OF DECRYPTED SALARY*/
Select Salary_Encrypted,CONVERT(nvarchar,DECRYPTBYKEY(Salary_Encrypted)) AS decrypted_salary from Nurse
Select Doctor_Name,Salary_Encrypted,CONVERT(nvarchar,DECRYPTBYKEY(Salary_Encrypted)) AS decrypted_salary from Doctor





/* BACKUP DATABASE WITHOUT ENCRYPTION */
USE master
GO

BACKUP DATABASE Wellmeadows
TO DISK = 'C:\Backup\Wellmeadows.bak'
WITH COMPRESSION
GO

/*RESTORE DATABASE WITHOUT ENCRYPTION*/
RESTORE DATABASE Wellmeadows
FROM DISK = 'C:\Backup\Wellmeadows.bak';
GO

/* BACKUP WITH ENCRYPTION*/
USE master
GO

CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'ENCRYPT@123'; 

CREATE CERTIFICATE Well_Back_Cert WITH SUBJECT = 'Database Backup Certificate';
GO

BACKUP CERTIFICATE Well_Back_Cert 
TO FILE = 'C:\Backup\Well_Back_Cert.cert'
WITH PRIVATE KEY (
FILE = 'C:\Backup\Well_Back_Cert.key',
ENCRYPTION BY PASSWORD = 'J@red1234')
GO

BACKUP DATABASE Wellmeadows
TO DISK = 'C:\Backup\Wellmeadows.bak'
WITH COMPRESSION,
ENCRYPTION (ALGORITHM = AES_256, SERVER CERTIFICATE = Well_Back_Cert);

/* DROPING CERT AND DATABASE FOR RESTORATION*/
USE master;
GO 

DROP CERTIFICATE Well_Back_Cert
GO

DROP DATABASE Wellmeadows;
GO

/* RESTORE THE DATABASE USING THE CERTIFICATION AND PASSWORD*/
CREATE CERTIFICATE Well_Back_Cert
FROM FILE = 'C:\Backup\Well_Back_Cert.cert'
WITH PRIVATE KEY (FILE = 'C:\Backup\Well_Back_Cert.key',
DECRYPTION BY PASSWORD = 'J@red1234');
GO

RESTORE DATABASE Wellmeadows_withoutEncrypt
FROM DISK = 'C:\Backup\Wellmeadows_withoutEncrypt.bak';
GO

