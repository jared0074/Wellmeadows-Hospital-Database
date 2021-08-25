-- Create new user 
CREATE LOGIN Kali WITH PASSWORD = 'Kali@123', CHECK_EXPIRATION = ON, CHECK_POLICY = ON;
CREATE USER Kali FROM LOGIN Kali
CREATE LOGIN Baw WITH PASSWORD = 'Baw@123', CHECK_EXPIRATION = ON, CHECK_POLICY = ON;
CREATE USER Baw FROM LOGIN Baw

-- Create role General_Nurse and Director_Doctor
CREATE ROLE General_Nurse
CREATE ROLE Director_Doctor

-- Assign General_Nurse Role to User
ALTER ROLE General_Nurse Add MEMBER Kali

-- Assign Director_Doctor Role to User
ALTER ROLE Director_Doctor Add MEMBER Baw

-- Grant General_Nurse permission in server level
GRANT SELECT,INSERT, UPDATE ON Patient TO General_Nurse
GRANT SELECT,INSERT, UPDATE ON Next_of_Kin TO General_Nurse
GRANT SELECT,INSERT, UPDATE ON In_Patient TO General_Nurse
GRANT SELECT 				ON Appointment TO General_Nurse
GRANT SELECT 				ON Ward TO General_Nurse
GRANT SELECT 				ON Bed TO General_Nurse
GRANT SELECT 				(First_Name, Last_Name, Gender) ON Nurse TO General_Nurse
GRANT SELECT 				(Staff_Num, Doctor_Name, Specialty, Tel_Extension) ON Doctor TO General_Nurse

-- Grant Director_Doctor permission in server level
GRANT SELECT,INSERT,UPDATE,DELETE ON Patient TO Director_Doctor WITH GRANT OPTION
GRANT SELECT,INSERT,UPDATE,DELETE ON Next_of_Kin TO Director_Doctor WITH GRANT OPTION
GRANT SELECT,INSERT,UPDATE,DELETE ON Appointment TO Director_Doctor WITH GRANT OPTION
GRANT SELECT,INSERT,UPDATE,DELETE ON In_Patient TO Director_Doctor WITH GRANT OPTION
GRANT SELECT,INSERT,UPDATE,DELETE ON Out_Patient TO Director_Doctor WITH GRANT OPTION
GRANT SELECT,INSERT,UPDATE,DELETE ON Nurse TO Director_Doctor WITH GRANT OPTION
GRANT SELECT,INSERT,UPDATE,DELETE ON Doctor TO Director_Doctor WITH GRANT OPTION
GRANT SELECT ON Ward TO Director_Doctor WITH GRANT OPTION
GRANT SELECT ON Bed TO Director_Doctor WITH GRANT OPTION

-- Create Audit Database 
CREATE DATABASE AuditDb
GO

USE AuditDb
GO

-- Create Audit Table ServerLogonHistory
CREATE TABLE ServerLogonHistory
(SystemUser VARCHAR(512),
 DBUser VARCHAR(512),
 SPID INT,
 LogonTime DATETIME)

GO

USE master
GO
GRANT CONTROL SERVER TO Kali
GRANT CONTROL SERVER TO Baw

Select * from ServerLogonHistory

-- Create Logon Trigger
Go
CREATE TRIGGER Tr_ServerLogon
ON All SERVER 
FOR LOGON
AS
BEGIN
INSERT INTO AuditDb.dbo.ServerLogonHistory
SELECT SYSTEM_USER,USER,@@SPID,GETDATE()
end

-- Create DML trigger to prevent deletion of next of kin details
Go
ALTER TRIGGER deleteNK
ON Next_of_Kin
INSTEAD OF delete
AS
BEGIN
	select * from deleted
	RAISERROR('Next of Kin cannot be deleted', 16,10)
	select * from Next_of_Kin
END

-- Create DML trigger to prevent deletion of patient details
Go
ALTER TRIGGER deletePatient
ON Patient
INSTEAD OF delete
AS
BEGIN
	select * from deleted
	RAISERROR('Patient cannot be deleted', 16,10)
	select * from Patient
END

-- Create encryption on address column with symetric key
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'Encrypt@123';
CREATE CERTIFICATE addresscert WITH SUBJECT = 'Address Certificate';
CREATE SYMMETRIC KEY address_symmkey WITH   
    ALGORITHM = AES_256 
    ENCRYPTION BY CERTIFICATE addresscert 
GO 
OPEN SYMMETRIC KEY address_symmkey  
    DECRYPTION BY CERTIFICATE addresscert;   
GO  

-- ENCRYPTING address COLUMN FOR NURSE TABLE
ALTER TABLE Nurse
ADD Address_Encrypted varbinary(MAX)

UPDATE Nurse
	SET Address_Encrypted = ENCRYPTBYKEY (Key_GUID('address_symmkey'), Full_Address)
	FROM Nurse
	GO

select * from Doctor

select Address_Encrypted, CONVERT(varchar,DECRYPTBYKEY(Address_Encrypted)) AS decrypted_Address from Nurse

-- ENCRYPTING address COLUMN FOR PATIENT TABLE
ALTER TABLE Patient
ADD Patient_Address_Encrypted varbinary(MAX)

UPDATE Patient
	SET Patient_Address_Encrypted = ENCRYPTBYKEY (Key_GUID('address_symmkey'), Address)
	FROM Patient
	GO

select * from Patient

select Patient_Address_Encrypted, CONVERT(varchar,DECRYPTBYKEY(Patient_Address_Encrypted)) AS decrypted_Address from Patient

-- ENCRYPTING address COLUMN FOR Next_of_Kin TABLE
ALTER TABLE Next_of_Kin
ADD NK_Address_Encrypted varbinary(MAX)

UPDATE Next_of_Kin
	SET NK_Address_Encrypted = ENCRYPTBYKEY (Key_GUID('address_symmkey'), NK_Address)
	FROM Next_of_Kin
	GO

select * from Next_of_Kin

select NK_Address_Encrypted, CONVERT(varchar,DECRYPTBYKEY(NK_Address_Encrypted)) AS decrypted_Address from Next_of_Kin

