CREATE DATABASE Database1;
 
USE Database1;
 
CREATE TABLE Profile (
    Profile_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Address VARCHAR(200),
    Age INT,
    Department VARCHAR(100),
    Position VARCHAR(100)
);

INSERT INTO Profile VALUES
(1, 'Juan Dela Cruz', 'Manila', 21, 'IT', 'Student'),
(2, 'Pedro Santos', 'Makati', 22, 'Engineering', 'Developer'),
(3, 'Maria Reyes', 'Quezon City', 20, 'Computer', 'Analyst'),
(4, 'Ana Garcia', 'Pasig', 23, 'IT', 'Programmer'),
(5, 'Jose Ramos', 'Taguig', 24, 'Electronics', 'Technician');
 
SELECT * FROM Profile;

CREATE DATABASE Database2;

CREATE USER 'profile_user'@'localhost'
IDENTIFIED BY 'Profile@123';
 
GRANT ALL PRIVILEGES ON Database1.*
TO 'profile_user'@'localhost';
 
GRANT ALL PRIVILEGES ON Database2.*
TO 'profile_user'@'localhost';
 
FLUSH PRIVILEGES;

USE Database2;
 
SET @encryption_key = 'MySecretKey123';
 
CREATE TABLE Profile_Encrypted (
    Profile_ID VARBINARY(255) PRIMARY KEY,
    Name VARBINARY(255),
    Address VARBINARY(255),
    Age VARBINARY(255),
    Department VARBINARY(255),
    Position VARBINARY(255)
);
 
INSERT INTO Profile_Encrypted
SELECT
    AES_ENCRYPT(CAST(Profile_ID AS CHAR), @encryption_key),
    AES_ENCRYPT(Name, @encryption_key),
    AES_ENCRYPT(Address, @encryption_key),
    AES_ENCRYPT(CAST(Age AS CHAR), @encryption_key),
    AES_ENCRYPT(Department, @encryption_key),
    AES_ENCRYPT(Position, @encryption_key)
FROM Profile;
 
SELECT
    CAST(AES_DECRYPT(Profile_ID, @encryption_key) AS CHAR) AS Profile_ID,
    CAST(AES_DECRYPT(Name, @encryption_key) AS CHAR) AS Name,
    CAST(AES_DECRYPT(Address, @encryption_key) AS CHAR) AS Address,
    CAST(AES_DECRYPT(Age, @encryption_key) AS CHAR) AS Age,
    CAST(AES_DECRYPT(Department, @encryption_key) AS CHAR) AS Department,
    CAST(AES_DECRYPT(Position, @encryption_key) AS CHAR) AS Position
FROM Profile_Encrypted
WHERE CAST(AES_DECRYPT(Profile_ID, @encryption_key) AS CHAR)
IN ('2', '3');
 
SELECT * FROM Profile_Encrypted;
 
















