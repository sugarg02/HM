
-- OFFLINE ASSIGNMENT

-- Script to Create Vehicle Table

CREATE TABLE Vehicle
(
VehicleID			SMALLINT PRIMARY KEY,
Vehicle_Class		VARCHAR(50) NOT NULL,
Vehicle_Make		VARCHAR(50) NOT NULL,
ShipmentDate		DATE,
Vehicle_Model		VARCHAR(50) NOT NULL,
Capacity			INT
);

-- Script to Create Shipment Table


CREATE TABLE Shipment
(
ShipmentID			INT PRIMARY KEY,
ShipmentTime		TIME,
VehicleID			INT,
From_WarehouseID	SMALLINT,
To_WarehouseID		SMALLINT,
Distance_Covered	INT,
Weight_Carried		INT
);


-- Script to populate Vehicle Data

INSERT INTO Vehicle
VALUES
(1, 'Class 1', 'Ford', 'Ranger', 6000),
(2, 'Class 1', 'Chevrolet', 'Colorado', 6000),
(3, 'Class 1', 'Toyota', 'Tacoma', 6000),
(4, 'Class 3', 'Ford', 'F350', 10000),
(5, 'Class 3', 'Chevrolet', 'Silverado', 10000),
(6, 'Class 5', 'Ford', 'F650', 20000),
(7, 'Class 5', 'Kenworth', 'T270', 20000),
(8, 'Class 5', 'Chevrolet', 'Silverado 6500HD', 20000);


-- Script to Populate Shipment Data

INSERT INTO Shipment
VALUES
(1, '2021-12-01','10:34',1,1,2, 2900,5500),
(2, '2021-12-04','12:20',1,2,1, 3025, 5700),
(3, '2021-12-01','14:04',5,3,5, 950, 9500),
(4, '2021-12-07','11:15',5,5,1, 1900, 9820),
(5, '2021-12-15','09:35',8,4,2, 2100, 19750),
(6, '2021-12-27','10:45',8,2,3, 1150, 18505),
(7, '2022-01-02','15:21',6,1,2, 2950, 17980),
(8, '2022-01-15','10:00',6,2,1, 2847, 19550),
(9, '2022-01-18','16:34',2,3,4, 1200, 5800),
(10, '2022-01-25','13:30',2,4,2, 2250, 5650),
(11, '2022-01-25','10:30',1,1,5, 1850, 5650),
(12, '2022-02-02','14:10',1,5,2, 1200, 5890),
(13, '2022-01-21','11:14',5,4,2, 2150, 9675),
(14, '2022-02-01','10:55',5,2,1, 3150, 9413);
