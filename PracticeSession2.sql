DROP TABLE IF EXISTS Invoice;
DROP TABLE IF EXISTS Service_Request;
DROP TABLE IF EXISTS Service;
DROP TABLE IF EXISTS Staff;
DROP TABLE IF EXISTS Payment;
DROP TABLE IF EXISTS Reservation;
DROP TABLE IF EXISTS Room;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Hotel;

create database hotel_management;
use hotel_management;
show databases;

CREATE TABLE Hotel (Hotel_ID INT PRIMARY KEY AUTO_INCREMENT, Hotel_Name VARCHAR(100), Location VARCHAR(100),Contact_Details VARCHAR(50));
desc Hotel;
select * from hotel;
-- Create table for Customer
CREATE TABLE Customer (Customer_ID INT PRIMARY KEY AUTO_INCREMENT,Name VARCHAR(100),Address VARCHAR(255),Phone_Number VARCHAR(15),Email VARCHAR(100),ID_Proof VARCHAR(50));
desc Customer;
select * from customer;
-- Create table for Room
CREATE TABLE Room (Room_ID INT PRIMARY KEY AUTO_INCREMENT,Room_Type VARCHAR(50),Room_Number INT,Room_Status ENUM('Available', 'Occupied', 'Maintenance'),Price DECIMAL(10,2),Hotel_ID INT,FOREIGN KEY (Hotel_ID) REFERENCES Hotel(Hotel_ID));
desc Room;
select * from room;

-- Create table for Reservation
CREATE TABLE Reservation (Reservation_ID INT PRIMARY KEY AUTO_INCREMENT,Check_In_Date DATE,Check_Out_Date DATE,Customer_ID INT,Room_ID INT,FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID),FOREIGN KEY (Room_ID) REFERENCES Room(Room_ID));
desc Reservation;
select * from reservation;
-- Create table for Payment
CREATE TABLE Payment (Payment_ID INT PRIMARY KEY AUTO_INCREMENT,Payment_Date DATE,Payment_Method ENUM('Cash', 'Credit Card', 'Debit Card', 'Online'),Amount DECIMAL(10,2),Reservation_ID INT,FOREIGN KEY (Reservation_ID) REFERENCES Reservation(Reservation_ID));
desc Payment;
select * from  payment;
-- Create table for Staff
CREATE TABLE Staff (Staff_ID INT PRIMARY KEY AUTO_INCREMENT,Name VARCHAR(100),Role VARCHAR(50),Salary DECIMAL(10,2),Contact_Number VARCHAR(15),Hotel_ID INT,FOREIGN KEY (Hotel_ID) REFERENCES Hotel(Hotel_ID));
desc Staff;
select * from staff;
-- Create table for Service
CREATE TABLE Service (Service_ID INT PRIMARY KEY AUTO_INCREMENT,Service_Type VARCHAR(100),Service_Description TEXT,Service_Cost DECIMAL(10,2));
desc Service;
select * from service;
-- Create table for Service Request (linking Customers, Staff, and Services)
CREATE TABLE Service_Request (Request_ID INT PRIMARY KEY AUTO_INCREMENT,Service_Date DATE,Service_ID INT,Customer_ID INT,Staff_ID INT,FOREIGN KEY (Service_ID) REFERENCES Service(Service_ID),FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID),FOREIGN KEY (Staff_ID) REFERENCES Staff(Staff_ID));
desc Service_Request;
select * from service_request;
-- Create table for Invoice (related to Payment and Customer)
CREATE TABLE Invoice (Invoice_ID INT PRIMARY KEY AUTO_INCREMENT,Invoice_Date DATE,Total_Amount DECIMAL(10,2),Customer_ID INT,Payment_ID INT,FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID),FOREIGN KEY (Payment_ID) REFERENCES Payment(Payment_ID));
desc Invoice;
select  * from invoice;
DELIMITER //
CREATE FUNCTION GetStayDuration(checkin DATE, checkout DATE) RETURNS INT
BEGIN
    RETURN DATEDIFF(checkout, checkin);
END //
DELIMITER ;

DELIMITER //

CREATE FUNCTION UpperCaseCustomerName(cust_name VARCHAR(100)) 
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    RETURN UPPER(cust_name);
END //


CREATE TRIGGER UpdateRoomStatusAfterCheckout
AFTER UPDATE ON Reservation
FOR EACH ROW
BEGIN
    IF NEW.Check_Out_Date < CURDATE() THEN
        UPDATE Room SET Room_Status = 'Available' WHERE Room_ID = NEW.Room_ID;
    END IF;
END //

CREATE OR REPLACE FUNCTION GetCustomerContactss(customer_id INT)
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
    DECLARE contact_info VARCHAR(255);
    SELECT CONCAT(Phone_Number, ' | ', Email) INTO contact_info 
    FROM Customer 
    WHERE Customer_ID = customer_id
    LIMIT 1; -- Ensures only one result is returned
    RETURN contact_info;
END;


DELIMITER ;

SELECT 
    GetCustomerContacts(Customer.Customer_ID) AS ContactInfo
FROM Customer;


SELECT UpperCaseCustomerName(Customer.Name) AS UpperCaseName
FROM Customer;

SELECT Customer.Name, GetStayDuration(Reservation.Check_In_Date, Reservation.Check_Out_Date) AS StayDuration
FROM Customer
JOIN Reservation ON Customer.Customer_ID = Reservation.Customer_ID;


CREATE VIEW ReservationSummary AS
SELECT Customer.Name, Room.Room_Number, Reservation.Check_In_Date, Reservation.Check_Out_Date, Payment.Amount
FROM Reservation
JOIN Customer ON Reservation.Customer_ID = Customer.Customer_ID
JOIN Room ON Reservation.Room_ID = Room.Room_ID
JOIN Payment ON Reservation.Reservation_ID = Payment.Reservation_ID;

SELECT Customer.Name, Room.Room_Number, Reservation.Check_In_Date, Reservation.Check_Out_Date
FROM Customer
INNER JOIN Reservation ON Customer.Customer_ID = Reservation.Customer_ID
INNER JOIN Room ON Reservation.Room_ID = Room.Room_ID;

INSERT INTO Hotel (Hotel_Name, Location, Contact_Details) VALUES
('Ocean View Hotel', 'Beach City', '123-456-7890'),
('Mountain Inn', 'Hilltop', '234-567-8901'),
('Urban Luxury Suites', 'Downtown City', '345-678-9012'),
('Riverside Resort', 'Riverside', '456-789-0123'),
('City Center Hotel', 'City Center', '567-890-1234'),
('Seaside Escape', 'Coastal Town', '678-901-2345'),
('Cozy Mountain Lodge', 'Hilltop', '789-012-3456'),
('Heritage Palace', 'Old Town', '890-123-4567'),
('Desert Oasis Hotel', 'Desert Valley', '901-234-5678'),
('Garden View Inn', 'Suburbia', '012-345-6789'),
('Skyline Hotel', 'Uptown', '123-456-7891'),
('Palace Retreat', 'Royal City', '234-567-8902'),
('Blue Waters Hotel', 'Coastal City', '345-678-9013'),
('Green Valley Inn', 'Nature Town', '456-789-0124'),
('Grand Mountain Hotel', 'Hilltop Village', '567-890-1235');

INSERT INTO Customer (Name, Address, Phone_Number, Email, ID_Proof) VALUES
('John Doe', '123 Elm St', '111-222-3333', 'john.doe@email.com', 'Passport'),
('Jane Smith', '456 Oak St', '222-333-4444', 'jane.smith@email.com', 'Driver License'),
('Alice Johnson', '789 Pine St', '333-444-5555', 'alice.j@email.com', 'Aadhar'),
('Michael Brown', '321 Maple St', '444-555-6666', 'michael.b@email.com', 'Voter ID'),
('Sarah Taylor', '654 Cedar St', '555-666-7777', 'sarah.t@email.com', 'Passport'),
('David Wilson', '987 Birch St', '666-777-8888', 'david.w@email.com', 'Driver License'),
('Emily Davis', '159 Spruce St', '777-888-9999', 'emily.d@email.com', 'Aadhar'),
('Brian Miller', '753 Willow St', '888-999-0000', 'brian.m@email.com', 'Voter ID'),
('Lisa Garcia', '258 Fir St', '999-000-1111', 'lisa.g@email.com', 'Passport'),
('Kevin Lee', '147 Redwood St', '000-111-2222', 'kevin.l@email.com', 'Driver License'),
('Laura Walker', '369 Aspen St', '111-222-3334', 'laura.w@email.com', 'Aadhar'),
('Jason Martinez', '486 Hemlock St', '222-333-4445', 'jason.m@email.com', 'Voter ID'),
('Amy Anderson', '369 Beech St', '333-444-5556', 'amy.a@email.com', 'Passport'),
('Tom White', '753 Poplar St', '444-555-6667', 'tom.w@email.com', 'Driver License'),
('Nina Black', '159 Sequoia St', '555-666-7778', 'nina.b@email.com', 'Aadhar');

INSERT INTO Room (Room_Type, Room_Number, Room_Status, Price, Hotel_ID) VALUES
('Single', 101, 'Available', 100.00, 1),
('Double', 102, 'Occupied', 150.00, 1),
('Suite', 201, 'Available', 250.00, 2),
('Deluxe', 202, 'Occupied', 300.00, 3),
('Executive Suite', 301, 'Available', 350.00, 4),
('Standard', 302, 'Available', 80.00, 5),
('Family Suite', 401, 'Occupied', 200.00, 6),
('Cabin', 402, 'Available', 120.00, 7),
('Presidential Suite', 501, 'Occupied', 500.00, 8),
('Basic Room', 502, 'Available', 60.00, 9),
('Luxury Suite', 601, 'Occupied', 400.00, 10),
('Honeymoon Suite', 602, 'Available', 450.00, 11),
('Penthouse', 701, 'Occupied', 600.00, 12),
('Budget Room', 702, 'Available', 50.00, 13),
('Mountain View Room', 801, 'Occupied', 180.00, 14);

INSERT INTO Reservation (Check_In_Date, Check_Out_Date, Customer_ID, Room_ID) VALUES
('2024-10-01', '2024-10-05', 1, 1),
('2024-10-02', '2024-10-06', 2, 2),
('2024-10-03', '2024-10-07', 3, 3),
('2024-10-04', '2024-10-10', 4, 4),
('2024-10-05', '2024-10-08', 5, 5),
('2024-10-06', '2024-10-09', 6, 6),
('2024-10-07', '2024-10-11', 7, 7),
('2024-10-08', '2024-10-12', 8, 8),
('2024-10-09', '2024-10-13', 9, 9),
('2024-10-10', '2024-10-14', 10, 10),
('2024-10-11', '2024-10-15', 11, 11),
('2024-10-12', '2024-10-16', 12, 12),
('2024-10-13', '2024-10-17', 13, 13),
('2024-10-14', '2024-10-18', 14, 14),
('2024-10-15', '2024-10-19', 15, 15);

INSERT INTO Payment (Payment_Date, Payment_Method, Amount, Reservation_ID) VALUES
('2024-09-30', 'Credit Card', 400.00, 1),
('2024-10-01', 'Cash', 600.00, 2),
('2024-10-02', 'Debit Card', 1000.00, 3),
('2024-10-03', 'Credit Card', 1800.00, 4),
('2024-10-04', 'Cash', 1050.00, 5),
('2024-10-05', 'Credit Card', 240.00, 6),
('2024-10-06', 'Debit Card', 480.00, 7),
('2024-10-07', 'Cash', 2000.00, 8),
('2024-10-08', 'Credit Card', 240.00, 9),
('2024-10-09', 'Debit Card', 304.00, 10),
('2024-10-10', 'Cash', 900.00, 11),
('2024-10-11', 'Credit Card', 500.00, 12),
('2024-10-12', 'Debit Card', 250.00, 13),
('2024-10-13', 'Online', 400.00, 14),
('2024-10-14', 'Cash', 350.00, 15);

INSERT INTO Staff (Name, Role, Salary, Contact_Number, Hotel_ID) VALUES
('Michael Brown', 'Receptionist', 30000.00, '444-555-6666', 1),
('Sarah Taylor', 'Housekeeping', 25000.00, '555-666-7777', 2),
('David Wilson', 'Manager', 50000.00, '666-777-8888', 3),
('Emily Davis', 'Concierge', 40000.00, '777-888-9999', 4),
('Brian Miller', 'Front Desk', 32000.00, '888-999-0000', 5),
('Lisa Garcia', 'Housekeeping', 23000.00, '999-000-1111', 6),
('Kevin Lee', 'Chef', 45000.00, '000-111-2222', 7),
('Laura Walker', 'Receptionist', 30000.00, '111-222-3333', 8),
('Jason Martinez', 'Manager', 50000.00, '222-333-4444', 9),
('Amy Anderson', 'Chef', 42000.00, '333-444-5555', 10),
('Tom White', 'Concierge', 39000.00, '444-555-6666', 11),
('Nina Black', 'Front Desk', 31000.00, '555-666-7777', 12),
('Anna Scott', 'Housekeeping', 23000.00, '666-777-8888', 13),
('Sam Green', 'Manager', 55000.00, '777-888-9999', 14),
('Rebecca Blue', 'Chef', 43000.00, '888-999-0000', 15);

INSERT INTO Service (Service_Type, Service_Description, Service_Cost) VALUES
('Room Cleaning', 'Daily room cleaning service', 30.00),
('Laundry', 'Laundry service for guests', 20.00),
('Food Delivery', 'In-room dining service', 50.00),
('Spa', 'Relaxing spa services', 100.00),
('Airport Shuttle', 'Transportation to and from the airport', 25.00),
('Guided Tour', 'City guided tours', 60.00),
('Event Planning', 'Planning and coordinating events', 150.00),
('Gym Access', 'Access to hotel gym facilities', 15.00),
('Swimming Pool', 'Access to hotel swimming pool', 10.00),
('Bike Rental', 'Bicycles available for rent', 20.00);

INSERT INTO Service_Request (Service_Date, Service_ID, Customer_ID, Staff_ID) VALUES
('2024-10-01', 1, 1, 1),
('2024-10-02', 2, 2, 2),
('2024-10-03', 3, 3, 3),
('2024-10-04', 4, 4, 4),
('2024-10-05', 5, 5, 5),
('2024-10-06', 6, 6, 6),
('2024-10-07', 7, 7, 7),
('2024-10-08', 8, 8, 8),
('2024-10-09', 9, 9, 9),
('2024-10-10', 10, 10, 10),
('2024-10-11', 1, 11, 11),
('2024-10-12', 2, 12, 12),
('2024-10-13', 3, 13, 13),
('2024-10-14', 4, 14, 14),
('2024-10-15', 5, 15, 15);

INSERT INTO Invoice (Invoice_Date, Total_Amount, Customer_ID, Payment_ID) VALUES
('2024-10-01', 400.00, 1, 1),
('2024-10-02', 600.00, 2, 2),
('2024-10-03', 1000.00, 3, 3),
('2024-10-04', 1800.00, 4, 4),
('2024-10-05', 1050.00, 5, 5),
('2024-10-06', 240.00, 6, 6),
('2024-10-07', 480.00, 7, 7),
('2024-10-08', 2000.00, 8, 8),
('2024-10-09', 240.00, 9, 9),
('2024-10-10', 304.00, 10, 10),
('2024-10-11', 900.00, 11, 11),
('2024-10-12', 500.00, 12, 12),
('2024-10-13', 250.00, 13, 13),
('2024-10-14', 400.00, 14, 14),
('2024-10-15', 350.00, 15, 15);


SELECT GetStayDuration('2024-10-01', '2024-10-05') AS StayDuration;

SELECT * FROM ReservationSummary
WHERE Name = 'John Doe';

-- a
SELECT CONCAT(Name, ' (', Phone_Number, ')') AS CustomerContact
FROM Customer;

-- b
SELECT UPPER(Name) AS CustomerName
FROM Customer;

-- c
SELECT Name, LENGTH(Email) AS EmailLength
FROM Customer;

-- d
SELECT AVG(Price) AS AverageRoomPrice
FROM Room;

-- e
SELECT COUNT(*) AS TotalReservations
FROM Reservation;

-- f
SELECT SUM(Amount) AS TotalPayments
FROM Payment;

-- g
SELECT Name
FROM Customer
WHERE Name LIKE 'A%';

-- h
SELECT *
FROM Reservation
WHERE Check_Out_Date > '2024-10-10';

-- i
SELECT *
FROM Reservation
WHERE Check_In_Date BETWEEN '2024-10-01' AND '2024-10-15';

-- j
SELECT Name, Email
FROM Customer
ORDER BY Name ASC;

-- k
SELECT DISTINCT Room_Type
FROM Room;

-- l
SELECT Customer.Name, Reservation.Check_In_Date, Reservation.Check_Out_Date
FROM Reservation
JOIN Customer ON Reservation.Customer_ID = Customer.Customer_ID;

-- m
SELECT Room.Room_Number, COUNT(Reservation.Reservation_ID) AS ReservationCount
FROM Reservation
JOIN Room ON Reservation.Room_ID = Room.Room_ID
GROUP BY Room.Room_Number
HAVING ReservationCount > 3;
 

SELECT Customer.Name, Reservation.Check_In_Date, Room.Room_Number
FROM Customer
INNER JOIN Reservation ON Customer.Customer_ID = Reservation.Customer_ID
INNER JOIN Room ON Reservation.Room_ID = Room.Room_ID;

CREATE VIEW ReservationSummary AS
SELECT Customer.Name, Room.Room_Number, Reservation.Check_In_Date, Reservation.Check_Out_Date, Payment.Amount
FROM Reservation
JOIN Customer ON Reservation.Customer_ID = Customer.Customer_ID
JOIN Room ON Reservation.Room_ID = Room.Room_ID
JOIN Payment ON Reservation.Reservation_ID = Payment.Reservation_ID;

select * from ReservationSummary;

CREATE VIEW AvailableRooms AS
SELECT Room.Room_Number, Room.Room_Type, Room.Price
FROM Room
WHERE Room.Room_Status = 'Available';

SELECT * FROM AvailableRooms;

SELECT Room.Room_Number, Customer.Name, Reservation.Check_In_Date
FROM Room
RIGHT JOIN Reservation ON Room.Room_ID = Reservation.Room_ID
RIGHT JOIN Customer ON Reservation.Customer_ID = Customer.Customer_ID;

SELECT Customer.Name, Reservation.Check_In_Date, Room.Room_Number
FROM Customer
LEFT JOIN Reservation ON Customer.Customer_ID = Reservation.Customer_ID
LEFT JOIN Room ON Reservation.Room_ID = Room.Room_ID;

SELECT Customer.Name, Reservation.Check_In_Date, Room.Room_Number
FROM Customer
INNER JOIN Reservation ON Customer.Customer_ID = Reservation.Customer_ID
INNER JOIN Room ON Reservation.Room_ID = Room.Room_ID;


DELIMITER //
CREATE PROCEDURE AddCustomer(
    IN cust_name VARCHAR(100), 
    IN cust_address VARCHAR(255), 
    IN cust_phone VARCHAR(15), 
    IN cust_email VARCHAR(100), 
    IN cust_id_proof VARCHAR(50)
)
BEGIN
    INSERT INTO Customer (Name, Address, Phone_Number, Email, ID_Proof)
    VALUES (cust_name, cust_address, cust_phone, cust_email, cust_id_proof);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE MakeReservation(
    IN checkin DATE, 
    IN checkout DATE, 
    IN customer_id INT, 
    IN room_id INT
)
BEGIN
    INSERT INTO Reservation (Check_In_Date, Check_Out_Date, Customer_ID, Room_ID)
    VALUES (checkin, checkout, customer_id, room_id);
    
    -- Update room status to Occupied
    UPDATE Room SET Room_Status = 'Occupied' WHERE Room_ID = room_id;
END //
DELIMITER ;

CALL MakeReservation('2024-10-20', '2024-10-25', 1, 101);

DELIMITER //
CREATE PROCEDURE ProcessPayment(
    IN res_id INT, 
    IN pay_method ENUM('Cash', 'Credit Card', 'Debit Card', 'Online'), 
    IN pay_amount DECIMAL(10,2)
)
BEGIN
    INSERT INTO Payment (Payment_Date, Payment_Method, Amount, Reservation_ID)
    VALUES (CURDATE(), pay_method, pay_amount, res_id);
END //
DELIMITER ;
CALL ProcessPayment(1, 'Credit Card', 5000.00);



CALL AddCustomer('John Doe', '123 Main St', '1234567890', 'johndoe@mail.com', 'Passport');


DELIMITER //
CREATE TRIGGER UpdateRoomStatusAfterCheckout
AFTER UPDATE ON Reservation
FOR EACH ROW
BEGIN
    -- Check if the checkout date is less than the current date
    IF NEW.Check_Out_Date < CURDATE() THEN
        -- Update the room status to 'Available'
        UPDATE Room 
        SET Room_Status = 'Available'
        WHERE Room_ID = NEW.Room_ID;
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER PreventOccupiedRoomDeletion
BEFORE DELETE ON Room
FOR EACH ROW
BEGIN
    -- Prevent deletion if the room status is 'Occupied'
    IF OLD.Room_Status = 'Occupied' THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Cannot delete a room that is currently occupied';
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER GenerateInvoiceAfterPayment
AFTER INSERT ON Payment
FOR EACH ROW
BEGIN
    DECLARE total_amount DECIMAL(10,2);
    SET total_amount = NEW.Amount;
    INSERT INTO Invoice (Invoice_Date, Total_Amount, Customer_ID, Payment_ID)
    VALUES (CURDATE(), total_amount, (SELECT Customer_ID FROM Reservation WHERE Reservation_ID = NEW.Reservation_ID), NEW.Payment_ID);
END //
DELIMITER ;

