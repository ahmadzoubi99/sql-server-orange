-- Create Users table
CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(50) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(255) NOT NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    DateOfBirth DATE,
    ProfilePicture NVARCHAR(255),
    CreatedAt DATETIME2 DEFAULT GETDATE()
);

-- Create Messages table
CREATE TABLE Messages (
    MessageID INT IDENTITY(1,1) PRIMARY KEY,
    SenderID INT NOT NULL,
    ReceiverID INT NOT NULL,
    MessageContent NVARCHAR(MAX) NOT NULL,
    SentAt DATETIME2 DEFAULT GETDATE(),
    Seen BIT DEFAULT 0, -- 0 for not seen, 1 for seen
    Deleted BIT DEFAULT 0, -- 0 for not deleted, 1 for deleted
    CONSTRAINT FK_Messages_Sender FOREIGN KEY (SenderID) REFERENCES Users(UserID),
    CONSTRAINT FK_Messages_Receiver FOREIGN KEY (ReceiverID) REFERENCES Users(UserID)
);

-- Create Services table
CREATE TABLE Services (
    ServiceID INT IDENTITY(1,1) PRIMARY KEY,
    ServiceName NVARCHAR(100) NOT NULL UNIQUE,
    Description NVARCHAR(MAX),
    Price DECIMAL(10,2) NOT NULL
);

-- Create UserServices table
CREATE TABLE UserServices (
    UserServiceID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL,
    ServiceID INT NOT NULL,
    PurchaseDate DATETIME2 DEFAULT GETDATE(),
    CONSTRAINT FK_UserServices_User FOREIGN KEY (UserID) REFERENCES Users(UserID),
    CONSTRAINT FK_UserServices_Service FOREIGN KEY (ServiceID) REFERENCES Services(ServiceID)
);

-- Create Payments table
CREATE TABLE Payments (
    PaymentID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL,
    ServiceID INT NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    PaymentDate DATETIME2 DEFAULT GETDATE(),
    PaymentMethod NVARCHAR(50) NOT NULL,
    CONSTRAINT FK_Payments_User FOREIGN KEY (UserID) REFERENCES Users(UserID),
    CONSTRAINT FK_Payments_Service FOREIGN KEY (ServiceID) REFERENCES Services(ServiceID)
);


INSERT INTO Users (Username, PasswordHash, Email, FirstName, LastName, DateOfBirth, ProfilePicture)
VALUES 
('ahmad99', '123', 'ahmad@gmail.com', 'ahmad', 'alzoubi', '1990-01-01', 'path/to/profile1.jpg'),
('anas97', '345', 'anas@gmail.com', 'anas', 'ali', '1992-02-02', 'path/to/profile2.jpg'),
('baraa', '8888', 'baraa@gmail.com', 'baraa', 'salih', '1994-03-03', 'path/to/profile3.jpg'),
('user4', 'hash4', 'user4@example.com', 'Bob', 'Brown', '1996-04-04', 'path/to/profile4.jpg'),
('user5', 'hash5', 'user5@example.com', 'Charlie', 'Davis', '1998-05-05', 'path/to/profile5.jpg'),
('user6', 'hash6', 'user6@example.com', 'Eva', 'Miller', '2000-06-06', 'path/to/profile6.jpg');

INSERT INTO Messages (SenderID, ReceiverID, MessageContent, Seen, Deleted)
VALUES 
(1, 2, 'Hello anas!', 0, 0),
(2, 1, 'Hi ahmad!', 1, 0),
(3, 4, 'Hello Bob!', 0, 0),
(4, 3, 'Hi baraa!', 1, 0),
(5, 6, 'Hello Eva!', 0, 0),
(6, 5, 'Hi Charlie!', 1, 0);


INSERT INTO Services (ServiceName, Description, Price)
VALUES 
('Premium Membership', 'Access to premium features', 9.99),
('Ad-Free Experience', 'No advertisements', 4.99),
('Extra Storage', 'Additional storage space', 1.99),
('Priority Support', 'Faster response time for support', 2.99),
('Custom Themes', 'Personalize your interface', 3.99),
('Advanced Analytics', 'In-depth usage statistics', 5.99);


INSERT INTO UserServices (UserID, ServiceID)
VALUES 
(1, 1),
(1, 2),
(2, 3),
(3, 4),
(4, 5),
(5, 6);

INSERT INTO Payments (UserID, ServiceID, Amount, PaymentMethod)
VALUES 
(1, 1, 9.99, 'Credit Card'),
(1, 2, 4.99, 'Credit Card'),
(2, 3, 1.99, 'PayPal'),
(3, 4, 2.99, 'Credit Card'),
(4, 5, 3.99, 'Credit Card'),
(5, 6, 5.99, 'PayPal');

select * from users;


UPDATE Users
SET Email = 'ahmadalzoubi99@gmail.com'
WHERE UserID = 1;

UPDATE Users
SET FirstName = 'ali'
WHERE UserID = 2;


UPDATE Services
SET Price = 8.99
WHERE ServiceID = 1;

UPDATE Services
SET Description = 'Updated Description'
WHERE ServiceID = 2;


UPDATE Services
SET Price = 8.99
WHERE ServiceID = 1;

UPDATE Services
SET Description = 'Updated Description'
WHERE ServiceID = 2;



UPDATE UserServices
SET ServiceID = 6
WHERE UserServiceID = 1;

UPDATE UserServices
SET UserID = 2
WHERE UserServiceID = 2;


UPDATE Payments
SET Amount = 10.99
WHERE PaymentID = 1;

UPDATE Payments
SET PaymentMethod = 'Debit Card'
WHERE PaymentID = 2;


DELETE FROM Users
WHERE UserID = 5;

DELETE FROM Users
WHERE UserID = 6;


DELETE FROM Messages
WHERE MessageID = 5;

DELETE FROM Messages
WHERE MessageID = 6;


DELETE FROM UserServices
WHERE UserServiceID = 5;

DELETE FROM UserServices
WHERE UserServiceID = 6;


DELETE FROM Payments
WHERE PaymentID = 5;


DELETE FROM Payments
WHERE PaymentID = 6;


EXEC sp_rename 'Users', 'AppUsers';


EXEC sp_rename 'Services', 'AppServices';


ALTER TABLE AppUsers
ALTER COLUMN Username NVARCHAR(100);

EXEC sp_rename 'AppUsers.Username', 'UserName', 'COLUMN';


ALTER TABLE AppServices
ALTER COLUMN ServiceName NVARCHAR(150);

EXEC sp_rename 'AppServices.ServiceName', 'ServiceTitle', 'COLUMN';
