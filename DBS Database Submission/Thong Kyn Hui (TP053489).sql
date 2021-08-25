-- Create new user 
CREATE LOGIN Sofia WITH PASSWORD = 'Sofi@123', CHECK_EXPIRATION = ON, CHECK_POLICY = ON;
CREATE USER Sofia FROM LOGIN Sofia
CREATE LOGIN Ben WITH PASSWORD = 'Ben@123', CHECK_EXPIRATION = ON, CHECK_POLICY = ON;
CREATE USER Ben FROM LOGIN Ben

-- Create role Out_Patient and General_Doctor
CREATE ROLE Out_Patient
CREATE ROLE General_Doctor

-- Assign Out_Patient Role to User
ALTER ROLE Out_Patient Add MEMBER Sofia

-- Assign General_Doctor Role to User
ALTER ROLE General_Doctor Add MEMBER Ben

-- Grant Out_Patient permission in server level
GRANT SELECT (First_Name,Last_Name,Gender) ON Patient TO Out_Patient
GRANT SELECT (Appointment_Num, Appointment_Date, Appointment_Time, Appointment_Location) ON Appointment TO Out_Patient
GRANT SELECT ON Ward TO Out_Patient
GRANT SELECT ON Bed TO Out_Patient
GRANT SELECT (First_Name, Last_Name, Gender) ON Nurse TO Out_Patient
GRANT SELECT (Doctor_Name, Specialty, Tel_Extension) ON Doctor TO Out_Patient

-- Grant General_Doctor permission in server level
GRANT SELECT, INSERT, UPDATE, DELETE ON Appointment TO General_Doctor
GRANT SELECT ON Bed TO General_Doctor
GRANT SELECT (Staff_Num, Doctor_Name, Specialty, Tel_Extension, Position) ON Doctor TO General_Doctor
GRANT SELECT ON In_Patient TO General_Doctor
GRANT SELECT ON Next_of_Kin TO General_Doctor
GRANT SELECT (Nurse_Num, First_Name, Last_Name, Gender, Position) ON Nurse TO General_Doctor
GRANT SELECT ON Out_Patient TO General_Doctor
GRANT SELECT ON Patient TO General_Doctor
GRANT SELECT ON Ward TO General_Doctor

-- TO CREATE PROCEDURE TO CHECK APPOINTMENTS
Go
CREATE PROCEDURE check_appointment
AS
SELECT Appointment.Appointment_Num, Patient.First_Name, Patient.Last_Name,Appointment_Date,Appointment.Appointment_Time, Appointment.Appointment_Location, Doctor.Doctor_Name FROM Appointment
INNER JOIN Doctor
ON Appointment.Staff_Num = Doctor.Staff_Num
INNER JOIN Patient
ON Appointment.Patient_Num = Patient.Patient_Num
GO

-- Grant Stored Procedure Execution to Out_Patient and General_Doctor
GRANT EXECUTE ON dbo.check_appointment TO Out_Patient, General_Doctor

-- Create Logon Trigger to limit connection after office hours
Go
CREATE TRIGGER LimitConnectionAfterOfficeHours
ON ALL SERVER 
FOR LOGON
AS
BEGIN
 IF ORIGINAL_LOGIN() = 'Ben' AND
  (DATEPART(HOUR, GETDATE()) < 8 OR
   DATEPART (HOUR, GETDATE()) > 17)
 BEGIN
  PRINT 'You are not authorized to login after office hours'
  ROLLBACK
 END
END

-- Create DML trigger for insert & update Appointment Time
Go
ALTER TRIGGER check_appointment_time
ON Appointment
INSTEAD OF INSERT,UPDATE
AS
IF exists ( select Appointment_Time from inserted where Appointment_Time NOT BETWEEN '08:00:00' AND '18:00:00' )
	begin 
	print 'Invalid time inserted. Please ensure appointment time is within office hours.'
	INSERT INTO Appointment_Audit
	SELECT Appointment_Num, Appointment_Date, Appointment_Time, Appointment_Location, Patient_Num, Staff_Num, getdate(),
	'Unsuccessful apppointment slot due to appointment time not within office hour' FROM inserted	
End
IF exists ( select Appointment_Time from inserted where Appointment_Time  BETWEEN '08:00:00' AND '18:00:00' )
	begin 
	print 'Successful appointment time slot booked.'
	INSERT INTO Appointment_Audit
	SELECT Appointment_Num, Appointment_Date, Appointment_Time, Appointment_Location, Patient_Num, Staff_Num, getdate(),
	'Successful appointment time slot booked.' FROM inserted
	INSERT INTO Appointment
	SELECT Appointment_Num, Appointment_Date, Appointment_Time, Appointment_Location, Patient_Num, Staff_Num FROM inserted
End

-- Create Appointment_Audit Table
CREATE TABLE Appointment_Audit
(
Appointment_Num Int,            
Appointment_Date Date,            
Appointment_Time Time,			 
Appointment_Location Varchar(10),      
Patient_Num Int,              
Staff_Num Int,              
Date_Modified Date,
Description	Varchar(100),
)

-- Try inserting appointment with invalid appointment time
INSERT INTO Appointment VALUES
(544,'2019-05-10','20:00:00','E801',109,605)
SELECT * FROM Appointment_Audit
SELECT * FROM Appointment WHERE Appointment_Num = 543

-- Create DML trigger to prevent deletion of doctor details
Go
ALTER TRIGGER delete_doctor
ON Doctor
INSTEAD OF delete
AS
BEGIN
	RAISERROR('Doctor details cannot be deleted', 16,10)
	INSERT INTO Doctor_Audit
	SELECT Staff_Num, Doctor_Name, getdate(), 'Attempted deletion on doctor details' FROM deleted
END

CREATE TABLE Doctor_Audit
(
Staff_Num Int,
Doctor_Name Varchar(25),
Date_Modified Date,
Descripton Varchar(100),
)

-- Attempt to delete doctor
DELETE FROM Doctor
WHERE Staff_Num = 601

SELECT * FROM Doctor_Audit

-- Create encryption on telephone number column with symetric key
-- Create Master Key
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'Encrypt@123';
-- Create Certificate
CREATE CERTIFICATE telcert WITH SUBJECT = 'Tel Certificate';
-- Create Symmetric Key
CREATE SYMMETRIC KEY tel_symmkey WITH   
    ALGORITHM = AES_256 
    ENCRYPTION BY CERTIFICATE telcert 
GO 

-- ENCRYPTING Tel_Num COLUMN FOR NURSE AND PATIENT TABLE
OPEN SYMMETRIC KEY tel_symmkey  
    DECRYPTION BY CERTIFICATE telcert;   
GO

ALTER TABLE Nurse
ADD Tel_Num_Encrypted varbinary(MAX)

ALTER TABLE Patient
ADD Tel_Num_Encrypted varbinary(MAX)


UPDATE Nurse
	SET Tel_Num_Encrypted = ENCRYPTBYKEY (Key_GUID('tel_symmkey'), Tel_Num)
	FROM Nurse
	GO

UPDATE Patient
	SET Tel_Num_Encrypted = ENCRYPTBYKEY (Key_GUID('tel_symmkey'), Tel_Num)
	FROM Patient
	GO

-- Checking result of encryption
select Nurse_Num, First_Name, Tel_Num_Encrypted from Nurse
select Patient_Num, First_Name, Tel_Num_Encrypted from Patient

-- Checking result of encryption after closing symmetric key
CLOSE SYMMETRIC KEY tel_symmkey
select Tel_Num_Encrypted, CONVERT(varchar,DECRYPTBYKEY(Tel_Num_Encrypted)) AS decrypted_Tel_Num from Nurse
select Tel_Num_Encrypted, CONVERT(varchar,DECRYPTBYKEY(Tel_Num_Encrypted)) AS decrypted_Tel_Num from Patient