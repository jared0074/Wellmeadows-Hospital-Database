CREATE DATABASE Wellmeadows

Use Wellmeadows
CREATE TABLE Patient (
Patient_Num           Int              not null     unique,
First_Name            Varchar (20)     not null,
Last_Name             Varchar (20)     not null,
Gender                Varchar (10)     not null,
Tel_Num               Varchar (20)     not null,
Address               Varchar (100)    not null,
Marital_Stat          Varchar (20)     not null,
DOB                   Date             not null,
NK_Num                Int              not null,
Staff_Num             Int              not null,
Date_Reg	          Date             not null,
Primary Key (Patient_Num),
)
INSERT INTO Patient VALUES
(102, 'Ariadne','Alford','Female','017-59264642','1 20 Jln Bunga Tanjung 8A Taman Muda 56100 Wilayah Persekutuan Malaysia','Single','1965-12-02',201,615,			'2019-03-15'),
(103, 'Eliana','Hutchinson','Female','019-1453542','1200 Jln 11 Kampung Baru Ampang 68000 Ampang Malaysia','Single','1999-02-01',218,612,							'2019-02-22'),
(104, 'Elsie-May','Webstery','Female','016-4636782','Jalan 1/149E, 57000 Sri Petaling , 57000 Wilayah Persekutuan Malaysia ','Married','1997-04-10',210,609,		'2018-08-17'),
(105, 'Hallie','Mayo','Female','019-2957382','2 31 Jln 3/108C Taman Sungai Besi 57100 Wilayah Persekutuan 57100 Malaysia','Single','1967-09-11',203,613,			'2018-10-23'),
(106, 'Jazmyn','Kaye','Male','012-1048492','32CF Jalan Kosas 1/4 Taman Kosas 68000 Ampang Malaysia','Single','1992-09-02',207,612,									'2018-09-21'),
(107, 'Winston','Britt','Male','017-2345325','3 WISMA HLA JLN RAJA CHULAN Wilayah Persekutuan 50200 Malaysia','Single','1983-07-15',209,611,						'2019-02-20'),
(108, 'Terri','Redman','Male','0112-2390132','2 Century Square Jln Multimedia Century Square 63000 Cyberjaya','Single','1943-03-31',211,613,						'2018-06-15'),
(109, 'Albie','Rossi','Male','017-5929294','18th Floor Plaza MCB CKT Raja Chulan 50200 Wilayah Persekutuan Malaysia','Single','1987-01-29',208,615,					'2019-02-20'),
(110, 'Klara','Galvan','Female','019-8271633','21 Psn Desa Ampang 1 Taman Sri Ampang 68000 Ampang Malaysia','Single','1979-11-11',220,614,							'2018-04-23'),
(111, 'Bianka','Rosario','Female','012-4729472','30-4-01 Jln Radin Anum Taman Seri Petaling 57000 Kuala Lumpur','Single','1954-02-28',217,605,						'2019-01-18'),
(112, 'Katrina','Banks','Female','017-2837392','47 2 Jln 8/146 Bandar Tasik Selatan 57000 Wilayah Persekutuan 57000 Malaysia','Married','1965-09-29',219,611,		'2019-03-21'),
(113, 'Tyrique','Neville','Female','019-0381937','lot 1403a, 14th floor wisma cosway 88 jalan raja chulan, 50200','Single','1962-08-02',215,613,					'2018-10-22'),
(114, 'Chenai','Cortes','Male','016-0261731','SP-10 the Street Mall Persiaran Multimedia 63000 Cyberjaya','Single','1986-05-08',213,601,							'2018-05-30'),
(115, 'Bentley','Bishop','Male','012-3829372','220 Jalan Pasai Sri Petaling 57000 Wilayah Persekutuan Malaysia','Married','1990-03-23',212,610,						'2019-01-23'),
(116, 'Camron','Cruz','Male','015-2828483','31-3 Jln 8/146 Bandar Tasik Selatan 57000 Kuala Lumpur','Single','1996-07-25',204,608,									'2018-12-22'),
(117, 'Ellise','Hirst','Female','013-9503828','A 31 Jln 11 Taman Putra 68000 Ampang Malaysia','Single','1983-12-19',206,613,										'2019-01-05'),
(118, 'Lily-May','Emerson','Female','016-9201002','F-11-2 Endah Villa Condominium, Jalan 2/149B, Sri Petaling','Married','1993-11-16',216,612,						'2019-03-06'),
(119, 'Jimmy','Couch','Male','016-0002221','G 17 Jln Radin Anum 2 Taman Seri Petaling 57000 Wilayah Persekutuan 57000 Malaysia ','Single','1972-09-07',205,606,		'2019-01-20'),
(120, 'Acacia','Richardson','Male','012-3456789','128-3, Jalan Radin Anum 1, Bandar Sri Petaling Wilayah Persekutuan 57100 Malaysia ','Married','1983-10-05',214,608,'2019-02-20')

--Select* from Patient

CREATE TABLE Next_of_Kin (
NK_Num					Int              not null     unique,
NK_Name					Varchar (25)     not null,
NK_Address				Varchar (100)    not null,
Tel_Num					Varchar (20)     not null,
Relationship_with_PT	Varchar (35)     not null,
Primary Key (NK_Num),
)
INSERT INTO Next_of_Kin VALUES
(201, 'Pauline Macfarlane','368 4 Jln Sg Besi Bt 3 1/2 57100 Wilayah Persekutuan 57100 Malaysia ','012-4281256','Father'),
(202, 'Brendan Shah','6020 Cyberview Garden 63000 Cyberjaya ','013-1273492','Mother'),
(203, 'Zeenat Bentley','91-2, 2nd floor jalan radin tengah bandar baru seri petaling, 57000','017-8245621','Sibling'),
(204, 'Cem Bourne','1262 Jalan 11 Kampung Baru Ampang 68000 Ampang Malaysia','0112-4278656','Guardian'),
(205, 'Sidrah Booth','No 11 Jalan Desa Aman 9 Taman Desa Aman 5Th Mile 56100 KL','019-1467532','Sibling'),
(206, 'Jayne Senior','B6 2 Jln Ampang Utama 2/2 Taman Ampang Utama 68000 Ampang Ampang 68000 Malaysia ','013-3938531','Father'),
(207, 'Jordan Nicholls','Gerai Masjid Seri Petaling 5 Jln Radin Taman Seri Petaling 57000 Wilayah Persekutuan ','017-4088865','Mother'),
(208, 'Denis Wicks','58 Jln 38 Kampung Cheras Baru 56100 Wilayah Persekutuan 56100 Malaysia ','013-2369323','Sibling'),
(209, 'Ehsan Connelly','6020 Cyberview Garden 63000 Cyberjaya','012-4325926','Sibling'),
(210, 'Ferne Dickinson','B74 Kampung Pinang Kem Sungai Besi 57000 Wilayah Persekutuan Malaysia','017-9728483','Spouse'),
(211, 'Willow Alford','14 Lrg Bunga Melati 2A Taman Maju Jaya 56100 Wilayah Persekutuan 56100 Malaysia','0192482222','Father'),
(212, 'Niyah Bauer','2 Century Square Jln Multimedia Century Square  63000 Malaysia Cyberjaya 63','019-2857937','Spouse'),
(213, 'Giselle Workman','37 Jln Manis 4 Taman Segar 56100 Wilayah Persekutuan 56100 Malaysia ','019-2834820','Mother'),
(214, 'Sahil Parkes','7-5, Jalan 8/146 Bandar Tasik Selatan, Sungai Besi 57000 KL Malaysia','0112-2849273','Spouse'),
(215, 'Destiny Hicks','29-1 Jln 20B/146 Taman Desa Tasik 57000 Wilayah Persekutuan 57000 Malaysia','017-2802749','Sibling'),
(216, 'Mariam Dillard','11 Jln Pasai 6 Taman Seri Petaling 57000 Wilayah Persekutuan 57000 Malaysia','013-5840284','Spouse'),
(217, 'Simra Hutchings','Lot 146 Jalan Ampang Bukit Belacan Ampang 68000 Malaysia ','017-9382912','Mother'),
(218, 'Franky Cleveland','No. 1 Jln Indah 26 Taman Cheras Indah Wilayah Persekutuan 56100 Malaysia','019-9283930','Mother'),
(219, 'Ananya Roche','16 Wisma Lim Foo Yong Jln Raja Chulan 50200 Wilayah Persekutuan 50200 Malaysia','0112-9482048','Spouse'),
(220, 'Nikola Strickland','Ground Floor Plaza Ampang Jaya Jln Mewah 5 Taman Ampang Mewah 68000 Ampang ','012-5692974','Sibling')

--SELECT * FROM Next_of_Kin

CREATE TABLE In_Patient (
In_PT_Num				Int             not null     unique,
Admission_Date			Date            not null,
Expected_Leave_Date     Date            not null,
Actual_Leave_Date       Date            null,
Duration_of_Stay		Int             not null,
Expected_Duration_Stay  Int				not null,
Ward_Num				Int             not null,
Bed_Num					Int             not null,
Patient_Num				Int             not null,
Daily_Activites			VARCHAR(200)	not null,
Activity_Status			BIT				not null,
Primary Key (In_PT_Num),
)
INSERT INTO In_Patient VALUES
(301,	'2019-05-10','2019-05-18','2019-05-12',2	,8	,1	,3		,109,'Feed Antibiotic'				,	0),
(302,	'2019-04-15','2019-04-20','2019-04-18',3	,5	,3	,38		,118,'Psychological test'			,	1),
(303,	'2019-03-15','2019-03-22','2019-04-01',17	,7	,5	,66		,103,'Inject Steroids'				,	0),
(304,	'2018-10-15','2018-10-24','2018-10-24',9	,9	,7	,87		,105,'STD test'						,	0),
(305,	'2018-11-10','2018-11-13','2018-11-13',3	,3	,10	,130	,107,'Rectal Examination'			,	1),
(306,	'2018-11-22','2018-11-23','2018-11-26',4	,1	,9	,115	,102,'CT Scan'						,	0),
(307,	'2019-04-23','2019-04-28','2019-04-28',5	,5	,9	,117	,106,'X-Ray Scan on brain'			,	1),
(308,	'2018-09-01','2018-09-07','2018-09-07',6	,6	,8	,109	,104,'retrograde ejaculation test'	,	0),
(309,	'2019-05-15','2019-05-19',null		  ,15	,4	,11	,155	,108,'Body Checkup'					,	1),
(310,	'2019-05-15','2019-05-25',null		  ,15	,10	,17	,235	,110,'Thyroid function test'		,	1),
(311,	'2019-04-23','2019-05-01','2019-05-02',9	,8	,13	,179	,119,'Ultrasound'					,	0),
(312,	'2019-05-23','2019-06-02',null		  ,7	,10	,12	,162	,112,'Autopsy'						,	0),
(313,	'2018-12-10','2018-12-18','2018-12-14',4	,8	,4	,151	,109,'Dick test'					,	1),
(314,	'2018-08-31','2018-09-07','2018-09-07',7	,7	,1	,1		,113,'Blood transfusion'			,	0),
(315,	'2019-05-28','2019-05-30','2019-05-30',2	,2	,2	,28		,111,'Muscle Training'				,	1),
(316,	'2019-02-22','2019-02-26','2019-02-26',4	,4	,10	,141	,114,'Change Adult Diapers'			,	0),
(317,	'2019-05-25','2019-05-29',null		  ,5	,4	,12	,168	,109,'Oxygen Tank Exchange'			,	0),
(318,	'2019-04-23','2019-04-30','2019-04-30',7	,7	,15	,199	,117,'Extract blood'				,	1),
(319,	'2019-05-10','2019-05-11',null		  ,20	,1	,17	,230	,116,'Urine Collection'				,	0),
(320,	'2019-05-20','2019-05-28',null		  ,10	,8	,16	,215	,109,'Inject Antibiotic'			,	1)

--SELECT * FROM In_Patient

CREATE TABLE Out_Patient(
Out_PT_Num	          Int              not null     unique,
Date_Registered       Date             not null,
Patient_Num	              Int              not null,
primary key (Out_PT_Num),
)
INSERT INTO Out_Patient VALUES
(401,'2019-03-10',105),
(402,'2019-01-20',108),
(403,'2019-02-15',115),
(404,'2018-11-02',120),
(405,'2018-12-24',116),
(406,'2019-04-15',111),
(407,'2018-10-21',102),
(408,'2019-05-01',109),
(409,'2018-08-21',103),
(410,'2018-12-31',113),
(411,'2018-08-10',112),
(412,'2019-05-27',118),
(413,'2019-01-10',102),
(414,'2018-10-21',113),
(415,'2018-11-14',116)

--SELECT * FROM Out_Patient

CREATE TABLE Appointment(
Appointment_Num         Int              not null     unique,
Appointment_Date        Date             not null,
Appointment_Time		Time			 not null,
Appointment_Location    Varchar(10)      null,
Patient_Num             Int              not null,
Staff_Num				Int              not null,
Primary Key (Appointment_Num),
)
INSERT INTO Appointment VALUES
(501,'2019-05-10','08:30:00','E801',109,605),
(502,'2019-03-10','15:00:00','E813',105,613),
(503,'2019-04-15','09:00:00','E805',110,603),
(504,'2019-03-15','12:00:00','E813',103,612),
(505,'2019-01-20','10:00:00','E802',113,601),
(506,'2018-10-15','11:00:00','E812',105,602),
(507,'2019-02-15','12:30:00','E811',115,610),
(508,'2018-11-02','10:00:00','E802',120,608),
(509,'2018-11-10','08:00:00','E815',107,611),
(510,'2018-11-22','09:30:00','E808',102,606),
(511,'2018-12-24','13:00:00','E809',116,604),
(512,'2019-04-15','14:30:00','E811',111,607),
(513,'2019-04-23','11:30:00','E814',106,612),
(514,'2018-09-01','09:00:00','E811',104,609),
(515,'2019-05-15','11:00:00','E812',108,613),
(516,'2019-05-15','12:30:00','E803',110,614),
(517,'2019-04-23','10:00:00','E811',119,606),
(518,'2018-10-21','09:00:00','E813',102,615),
(519,'2019-05-01','13:30:00','E815',105,604),
(520,'2018-08-21','15:00:00','E811',103,606),
(521,'2018-12-31','12:00:00','E806',113,601),
(522,'2019-05-23','11:00:00','E807',112,611),
(523,'2018-12-10','10:30:00','E810',109,602),
(524,'2018-09-07','09:00:00','E804',113,613),
(525,'2019-05-28','10:00:00','E805',111,605),
(526,'2018-08-10','11:30:00','E805',112,608),
(527,'2019-05-27','12:30:00','E803',118,612),
(528,'2019-01-10','15:30:00','E805',102,615),
(529,'2018-10-21','14:00:00','E808',117,614),
(530,'2018-11-14','16:00:00','E814',116,603),
(531,'2019-02-22','14:30:00','E802',114,601),
(532,'2019-05-25','12:00:00','E805',109,615),
(533,'2019-04-23','11:00:00','E808',117,613),
(534,'2019-05-10','09:30:00','E812',116,608),
(535,'2019-05-20','14:00:00','E810',109,606)

--SELECT * FROM Appointment

CREATE TABLE Doctor (
Staff_Num			Int             not null     unique,
Doctor_Name         Varchar(25)     not null,
Specialty           Varchar(30)     not null,
Tel_Extension       Int             not null,
Position			VARCHAR(15)		not null,
Salary				Int				not null,
Primary Key  (Staff_Num),
)
INSERT INTO Doctor VALUES
(601, 'Helen Cho' ,'Cardiologists', 6601						,'General',4000),
(602, 'Sumaiya Olson' ,'Anesthesiologists', 6602				,'General',3500),
(603, 'Chanel Beech' ,'Emergency Medicine Specialists ', 6603	,'General',4000),
(604, 'Annette Feeney' ,'Neurologists', 6604					,'General',3000),
(605, 'Maciej Castro' ,'Ophthalmologists ', 6605				,'General',4500),
(606, 'Brent Mclean' ,'Pathologists ', 6606						,'General',5000),
(607, 'Antoni Mueller' ,'Pediatricians ', 6607					,'General',4000),
(608, 'Sullivan Johnson' ,'Physiatrists ', 6608					,'General',4000),
(609, 'Alissia Forrest' ,'Podiatrists ', 6609					,'General',3500),
(610, 'Nicky Rocha' ,'Radiologists ', 6610						,'General',4000),
(611, 'Nahla Ramsey' ,'General Surgeons ', 6611					,'General',5000),
(612, 'Irene Benson' ,'Urologists ', 6612						,'General',4000),
(613, 'Elise Stanton' ,'Endocrinologists ', 6613				,'General',3000),
(614, 'Tom Flores' ,'Gastroenterologists ', 6614				,'General',4000),
(615, 'Kirstin Mccall' ,'Geriatric Medicine Specialists ', 6615	,'Director',7000)

--SELECT * FROM Doctor

CREATE TABLE Nurse (
Nurse_Num          Int              not null     unique,
First_Name         Varchar(20)      not null,
Last_Name          Varchar(20)      not null,
Tel_Num            Varchar(20)      not null,
DOB                Date             not null,
Full_Address       Varchar (100)    not null,
Gender             Varchar (10)     not null,
Position           Varchar (20)     not null,
Salary             Int              not null,
Staff_Num          Int              null,
Ward_Num           Int              null,
stat			   Varchar(10)		not null,
Primary Key  (Nurse_Num),
)
INSERT INTO Nurse VALUES
(701, 'Alysha', 'Vinson','012-4521253','1987-05-23','8/1,Jln 3/146 Bandar Tasik Selatan Wilayah Persekutuan 57000 KL','Female','General Nurse',3000,601,2						,'Active'),
(702, 'Kenya' , 'Frame' ,'012-7678311','1988-05-31','1035A Jln 9 Kampung Baru Salak Selatan Wilayah Persekutuan 57100 KL','Female','General Nurse',3000,608,2					,'Active'),
(703, 'Khadijah' , 'Higgs' ,'017-4234451','1977-02-27','30 Shahzan Tower Jln Raja Chulan Wilayah Persekutuan 50200 KL','Male','Head Nurse',5000,603,2							,'Active'),
(704, 'Tamia','Summers','0112-2343253','1970-03-21','lot 89, jalan enggang ampang/ulu kelang industrial estate 54200 KL','Female','Head Nurse',5000,602,1						,'Active'),
(705, 'Inez','Hope','018-3356436','1975-12-14','21 Psn Desa Ampang 1 Taman Sri Ampang 68000 Selangor','Female','Head Nurse',5000,605,5											,'Active'),
(706, 'GUto','Gardner','019-6843574','1971-01-20','28A Lrg 2/1A Kampung Tasek Tambahan 68000 Ampang 68000 Selangor','Male','Head Nurse',5000,615,15								,'Active'),
(707, 'Jagdeep','Crossley','013-2749374','1983-03-19','47-4 Jln 8/146 Bandar Tasik Selatan 57000 KL','Male','General Nurse',3000,612,1											,'Active'),
(708, 'Ruby-Mae', 'Bourne','017-2474932','1981-04-24','No. 24-26-28 Ground Floor Jalan Wawasan 2/4 Bandar Baru Ampang 68000 Selangor','Female','General Nurse',3000,603,1		,'Active'),
(709, 'Tyreese', 'Sullivan','013-5712393','1983-03-29','No. 8-2, Jalan Radin Anum, Taman Sri Petaling 57000 KL','Male','General Nurse',3000,614,3								,'Active'),
(710, 'Meghan', 'Brown','012-9823744','1984-09-04','Lot 3-1, Incubator 3, Technology Park Malaysia 57000 KL','Female','Head Nurse',3000,601,17									,'Active'),
(711, 'Connagh', 'Goodman','019-2837321','1989-10-27','No. 50 2nd Floor Jln Radin Tengah Taman Sri Petaling 57000 Kuala Lumpur Selangor','Male','General Nurse',3000,602,4		,'Active'),
(712, 'Eliana', 'Knights','0112-7299183','1980-01-25','57-2 Jalan Sulaiman 3 Taman Putra Sulaiman 68000 Ampang Malaysia','Female','General Nurse',3000,610,3					,'Active'),
(713, 'Alexandru', 'Phelps','013-2891382','1977-02-08','49 Jalan Bunga Melati 6 Taman Seraya 68000 Ampang Malaysia','Female','General Nurse',3000,611,5							,'Active'),
(714, 'Jacques', 'Stuart','012-5435332','1997-04-01','D1 Gerai JKKK Jalan Baru 14000 Bukit Mertajam Pulau Pinang Malaysia','Female','General Nurse',3000,603,6					,'Active'),
(715, 'Irfan', 'Dougherty','017-9837294','1981-05-02','A 10 Jln 30A/146 Taman Desa Tasik 57000 Wilayah Persekutuan 57000 Malaysia','Female','Head Nurse',3000,613,3				,'Active'),
(716, 'Tommie', 'Wynn','017-5387478','1972-07-14','19 1 Jalan Radin Anum 1 Taman Seri Petaling Wilayah Persekutuan 57000 Malaysia','Female','General Nurse',3000,614,6			,'Active'),
(717, 'Alivia', 'Irwin','017-8847387','1978-11-17','B74 Kampung Pinang Kem Sungai Besi 57000 Wilayah Persekutuan Malaysia','Male','General Nurse',3000,607,5					,'Active'),
(718, 'Anand', 'Rutledge','017-3284930','1979-12-08','No. 1, Jalan 1/149E, Bandar Baru Sri Petaling 57000 KL','Male','General Nurse',3000,611,4									,'Active'),
(719, 'Holli', 'Gregory','013-4827921','1985-10-04','A 12 Jln Watan 4 Taman Sri Watan 68000 Ampang Ampang 68000 Malaysia Ampang','Female','General Nurse',3000,614,7			,'Active'),
(720, 'Kiki', 'Enriquez','012-5234526','1982-11-02','3/F Blok M1 Fawina Court Taman Ampang Hilir 68000 Ampang Malaysia','Female','Head Nurse',3000,615,4						,'Active'),
(721, 'Ella-Mai', 'Meyers','017-1893429','1984-12-05','B6 2 Jln Selaman 1 Dataran Palma 68000 Ampang Ampang 68000 Malaysia Ampang','Male','General Nurse',3000,615,10			,'Active'),
(722, 'Cienna', 'Coffey','017-7353283','1988-08-11','11 Lrg Durian Taman Cheras 56100 Wilayah Persekutuan 56100 Malaysia','Female','General Nurse',3000,604,9					,'Active'),
(723, 'Troy', 'Devlin','0112-1302840','1991-01-20','Jalan 5/125D, Desa Petaling, Wilayah Persekutuan 57100 KL','Female','General Nurse',3000,611,8								,'Active'),
(724, 'Nazim', 'Whittle','017-1090472','1982-03-19','No 20 Jalan 8/95B Taman Cheras Utama 56100 Wilayah Persekutuan Malaysia','Female','General Nurse',3000,612,14				,'Active'),
(725, 'Mateusz', 'Salt','019-9392940','1985-05-02','128-3, Jalan Radin Anum 1, Bandar Sri Petaling Wilayah Persekutuan 57000 KL','Male','Head Nurse',3000,615,16				,'Active'),
(726, 'Keiran', 'Sampson','013-8923773','1978-07-12','23, Jalan Sulaiman 3, Taman Putra Sulaiman, 68000 Ampang Selangor','Female','General Nurse',3000,604,17					,'Active'),
(727, 'Alysia', 'Hough','012-5238959','1975-10-31','45 1 Jln 8/146 Bandar Tasik Selatan 57000 Wilayah Persekutuan 57000 Malaysia','Female','General Nurse',3000,601,7			,'Active'),
(728, 'Quinn', 'Shaffer','017-1569304','1979-12-25','55A-1B Jalan Pandan Cahaya 2/3 Pandan Cahaya 68000 Ampang Malaysia','Female','General Nurse',3000,607,8					,'Active'),
(729, 'Kailan', 'Bonilla','013-0943720','1989-05-05','No. 605 Kampung Tasik Permai 68000 Ampang Ampang 68000 Malaysia','Female','General Nurse',3000,612,17						,'Active'),
(730, 'Josef', 'Oakley','013-8027284','1982-04-19','7-5, Jalan 8/146 Bandar Tasik Selatan, Sungai Besi Wilayah Persekutuan 57000 KL','Female','General Nurse',3000,613,14		,'Active'),
(731, 'Hayley', 'Vance','019-9211724','1983-01-06','40-1, Jalan 1/149D, Taman Sri Petaling Wilayah Persekutuan 57000 KL','Female','Head Nurse',3000,610,8						,'Active'),
(732, 'Kaden', 'Thomson','017-1877294','1985-09-05','Jalan U/p 1/3, Ukay Perdana, 68000 Ampang KL','Female','General Nurse',3000,611,9											,'Active'),
(733, 'Faiza', 'Hickman','018-8823909','1987-05-21','Batu 3 1/2, Off Jalan Cheras, Wilayah Persekutuan 56100 Cheras KL','Female','General Nurse',3000,604,10					,'Active'),
(734, 'Lilly-May', 'Robson','012-3573953','1989-09-02','23B Jln Wawasan Ampang 2/2 Bandar Baru Ampang 68000 Ampang KL','Male','Head Nurse',3000,608,7							,'Active'),
(735, 'Oskar', 'Chadwick','012-2345236','1992-02-22','26 Jln Sungai Besi Batu 7 1/2 57000 Wilayah Persekutuan 57000 KL','Female','Head Nurse',3000,605,6						,'Active'),
(736, 'Amir', 'Riley','017-4578903','1988-03-06','Block 58-12-12 Flat Sri Sabah Batu 3 1/2 Jalan Cheras 56100 Wilayah Persekutuan Malaysia','Female','General Nurse',3000,613,11,'Active'),
(737, 'Isla-Mae', 'Goddard','013-0193853','1975-01-31','No. 8-2, Jalan Radin Anum, Taman Sri Petaling Wilayah Persekutuan 57000 KL','Male','Head Nurse',3000,614,14				,'Active'),
(738, 'Jared', 'Chan','013-4020303','1999-04-23','C-26-7, Vista-Komanwel C, 57000 Bukit Jalil KL','Male','General Nurse',3000,605,15											,'Active'),
(739, 'Macauly', 'Langley','012-5235754','1982-09-28','21,Endah Villa Condominium, Jalan 2/149B, Sri Petaling Wilayah Persekutuan 57000 KL','Male','Head Nurse',3000,609,12		,'Active'),
(740, 'Amira', 'Acosta','018-4459232','1978-06-01','1 Jalan Memanda 9 Taman Dato 68000 Selangor','Female','General Nurse',3000,608,16											,'Active'),
(741, 'Nathanael', 'Schultz','017-3849920','1982-07-09','Lorong 6A/91, Taman Shameline Perkasa, Off Jalan Cheras 56100 Cheras KL','Female','General Nurse',3000,606,13			,'Active'),
(742, 'Homer', 'Schaefer','013-3726439','1987-08-17','20 Jalan Tib 3/3, Taman Industri Bolton, 68100 Batu Caves Selangor','Male','General Nurse',3000,605,11					,'Active'),
(743, 'Emmy', 'Obrien','017-2842192','1989-02-01','SP-5 the Street Mall Persiaran Multimedia 63000 Cyberjaya','Female','Head Nurse',3000,610,9									,'Active'),
(744, 'Grant', 'Malone','013-1592939','1990-09-06','55 Jln 2/16 Bandar Baru Selayang 68100 Selayang Batu Caves 68100 Malaysia','Female','General Nurse',3000,612,12				,'Active'),
(745, 'Clifford', 'Grimes','017-8304829','1992-11-04','Enterprise House 1, Technology Park Malaysia, Lebuhraya Puchong - Sungei Besi 57000 KL','Female','General Nurse',3000,609,15,'Active'),
(746, 'Yash', 'Daugherty','019-2813829','1991-05-31','87, Jalan 10/91, Taman Shamelin Perkasa 56100 Cheras KL','Female','Head Nurse',3000,613,13						,'Active'),
(747, 'Aya', 'Partridge','013-1838292','1985-06-30','32 Jln Sibu 8 Taman Wahyu 68100 Wilayah Persekutuan 68100 Malaysia','Female','General Nurse',3000,602,16			,'Active'),
(748, 'Jaden', 'Oneill','017-5894020','1981-03-08','3rd Floor Century Square Block 2 Jln Multimedia Century Square 63000 Cyberjaya ','Male','Head Nurse',3000,606,10	,'Active'),
(749, 'Dawn', 'Woodward','019-2817392','1979-07-04','19C 19Th Floor Menara Pgrm 8 Jalan Pudu Ulu Cheras Wilayah Persekutuan 56100 KL','Male','General Nurse',3000,607,13,'Active'),
(750, 'Spike', 'Hudson','012-5383029','1984-09-12','1 Jln Kerja Ayer Lama 68000 Ampang Ampang 68000 Malaysia Ampang 68000 Malaysia','Female','General Nurse',3000,606,12,'Active'),
(751, 'Jordon', 'Arnold','012-2818495','1982-12-05','No. 7, Jalan Manis 4, Taman Segar 57000 KL','Male','Head Nurse',3000,609,11										,'Active')

--SELECT * FROM Nurse

CREATE TABLE Ward (
Ward_Num			Int              not null     unique,
Ward_Name			Varchar(20)      not null,
Tel_Extension_Num   Int              not null,
Bed_Quantity        Int              not null,
Ward_Gender         Varchar(10)      not null,
Primary Key  (Ward_Num),
)
INSERT INTO Ward VALUES
(1,  'Emergency'       , 7711, 17,   'Male'),
(2,  'Paediatric'      , 7712, 13, 'Female'),
(3,  'Orthopaedic'      , 7713, 13, 'Female'),
(4,  'Cardiology'      , 7714, 12,   'Male'),
(5,  'Neurology'       , 7715, 16,   'Male'),
(6,  'Neonatal'        , 7716, 15, 'Female'),
(7,  'Cardiovascular'  , 7717, 14,   'Male'),
(8,  'Oncology'        , 7718, 12,   'Male'),
(9,  'Obstetrics'      , 7719, 16,   'Male'),
(10, 'Gynaecology'     , 7720, 14, 'Female'),
(11, 'Colloquially'    , 7721, 14,   'Male'),
(12, 'Maternity'       , 7722, 16, 'Female'),
(13, 'Dentistry'       , 7723, 14, 'Female'),
(14, 'Dermatology'     , 7724, 12,   'Male'),
(15, 'Psychiatric'     , 7725, 14, 'Female'),
(16, 'Rehabilitation'  , 7726, 15,   'Male'),
(17, 'Surgery'         , 7727, 13, 'Female')

--SELECT * FROM Ward

CREATE TABLE Bed (
Bed_Num            Int              not null     unique,
Ward_Num           Int              not null,
Primary Key (Bed_Num),
)
INSERT INTO Bed VALUES
(1,1),(2,1),(3,1),(4,1),(5,1),(6,1),(7,1),(8,1),(9,1),(10,1),(11,1),(12,1),(13,1),(14,1),(15,1),(16,1),(17,1),
(18,2),(19,2),(20,2),(21,2),(22,2),(23,2),(24,2),(25,2),(26,2),(27,2),(28,2),(29,2),(30,2),
(31,3),(32,3),(33,3),(34,3),(35,3),(36,3),(37,3),(38,3),(39,3),(40,3),(41,3),(42,3),(43,3),
(44,4),(45,4),(46,4),(47,4),(48,4),(49,4),(50,4),(51,4),(52,4),(53,4),(54,4),(55,4),
(56,5),(57,5),(58,5),(59,5),(60,5),(61,5),(62,5),(63,5),(64,5),(65,5),(66,5),(67,5),(68,5),(69,5),(70,5),(71,5),
(72,6),(73,6),(74,6),(75,6),(76,6),(77,6),(78,6),(79,6),(80,6),(81,6),(82,6),(83,6),(84,6),(85,6),(86,6),
(87,7),(88,7),(89,7),(90,7),(91,7),(92,7),(93,7),(94,7),(95,7),(96,7),(97,7),(98,7),(99,7),(100,7),
(101,8),(102,8),(103,8),(104,8),(105,8),(106,8),(107,8),(108,8),(109,8),(110,8),(111,8),(112,8),
(113,9),(114,9),(115,9),(116,9),(117,9),(118,9),(119,9),(120,9),(121,9),(122,9),(123,9),(124,9),(125,9),(126,9),(127,9),(128,9),
(129,10),(130,10),(131,10),(132,10),(133,10),(134,10),(135,10),(136,10),(137,10),(138,10),(139,10),(140,10),(141,10),(142,10),
(143,11),(144,11),(145,11),(146,11),(147,11),(148,11),(149,11),(150,11),(151,11),(152,11),(153,11),(154,11),(155,11),(156,11),
(157,12),(158,12),(159,12),(160,12),(161,12),(162,12),(163,12),(164,12),(165,12),(166,12),(167,12),(168,12),(169,12),(170,12),(171,12),(172,12),
(173,13),(174,13),(175,13),(176,13),(177,13),(178,13),(179,13),(180,13),(181,13),(182,13),(183,13),(184,13),(185,13),(186,13),
(187,14),(188,14),(189,14),(190,14),(191,14),(192,14),(193,14),(194,14),(195,14),(196,14),(197,14),(198,14),
(199,15),(200,15),(201,15),(202,15),(203,15),(204,15),(205,15),(206,15),(207,15),(208,15),(209,15),(210,15),(211,15),(212,15),
(213,16),(214,16),(215,16),(216,16),(217,16),(218,16),(219,16),(220,16),(221,16),(222,16),(223,16),(224,16),(225,16),(226,16),(227,16),
(228,17),(229,17),(230,17),(231,17),(232,17),(233,17),(234,17),(235,17),(236,17),(237,17),(238,17),(239,17),(240,17)

--SELECT * FROM Bed

--Addition of all Foreign Keys
Alter table Patient
Add Foreign Key (Staff_Num) References Doctor

Alter table Patient
Add Foreign Key (NK_Num) References Next_of_Kin

Alter table In_Patient
Add Foreign Key (Ward_Num) References Ward

Alter table In_Patient
Add Foreign Key (Bed_Num) References Bed

Alter table In_Patient
Add Foreign Key (Patient_Num) References Patient

Alter table Out_Patient
Add Foreign Key (Patient_Num) References Patient

Alter table Appointment
Add Foreign key (Patient_Num) References Patient

Alter table Appointment
Add Foreign key (Staff_Num) References Doctor

Alter table Nurse
Add Foreign key (Staff_Num) References Doctor

Alter table Nurse
Add Foreign key (Ward_Num) References Ward

Alter table Bed
Add Foreign key (Ward_Num) References Ward


--Backup Restore Strategy
-- create Database Master Key 
Use master
GO
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'Backup@123';
GO

select * from sys.symmetric_keys 

CREATE CERTIFICATE BackupEncryption
    WITH SUBJECT = 'Backup Certificate';
GO

select * from sys.certificates

BACKUP CERTIFICATE BackupEncryption 
TO FILE = 'C:\Users\ghsoo\Desktop\Year 3 Sem 2\DBS\4 DBS Assignment\BackupEncryption.cert'
WITH PRIVATE KEY (
FILE = 'C:\Users\ghsoo\Desktop\Year 3 Sem 2\DBS\4 DBS Assignment\BackupEncryption.key',
ENCRYPTION BY PASSWORD = '@P@SS_WORD123')

--Backup database without encryption and compression
BACKUP DATABASE Wellmeadows
TO DISK = 'C:\Users\ghsoo\Desktop\Year 3 Sem 2\DBS\4 DBS Assignment\Wellmeadows_withoutEncrypt.bak'

--Backup database with encryption and compression
BACKUP DATABASE Wellmeadows
TO DISK = 'C:\Users\ghsoo\Desktop\Year 3 Sem 2\DBS\4 DBS Assignment\Wellmeadows_withEncrypt.bak'
WITH COMPRESSION,
ENCRYPTION (ALGORITHM = AES_256, SERVER CERTIFICATE = BackupEncryption)

--Dropping the database to showcase strategy
DROP DATABASE Wellmeadows;
GO
DROP CERTIFICATE BackupEncryption;
GO

CREATE CERTIFICATE BackupEncryption
FROM FILE = 'C:\Users\ghsoo\Desktop\Year 3 Sem 2\DBS\4 DBS Assignment\BackupEncryption.cert'
WITH PRIVATE KEY (FILE = 'C:\Users\ghsoo\Desktop\Year 3 Sem 2\DBS\4 DBS Assignment\BackupEncryption.key',
DECRYPTION BY PASSWORD = '@P@SS_WORD123');
GO

RESTORE DATABASE Wellmeadows
FROM DISK = 'C:\Users\ghsoo\Desktop\Year 3 Sem 2\DBS\4 DBS Assignment\Wellmeadows_withEncrypt.bak';
GO