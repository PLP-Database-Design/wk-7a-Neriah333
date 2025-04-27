-- Question 1
-- Create a new table ProductDetail_1NF to store the data in 1NF
CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(255),
    Product VARCHAR(255)
);

-- Use INSERT and SELECT with string splitting to populate ProductDetail_1NF
INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product)
SELECT OrderID, CustomerName, TRIM(value) AS Product
FROM ProductDetail
CROSS APPLY STRING_SPLIT(Products, ',');

-- Verify the result (optional)
SELECT * FROM ProductDetail_1NF;

-- Drop the original table (optional, if you want to replace it)
-- DROP TABLE ProductDetail;


-- Question 2
-- Create a new table Customers to store customer information (OrderID, CustomerName)
CREATE TABLE Customers (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(255)
);

-- Populate the Customers table with distinct OrderID and CustomerName pairs
INSERT INTO Customers (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

-- Create a new table OrderProducts to store the relationship between orders and products (OrderID, Product, Quantity)
CREATE TABLE OrderProducts (
    OrderID INT,
    Product VARCHAR(255),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Customers(OrderID)
);

-- Populate the OrderProducts table with OrderID, Product, and Quantity information
INSERT INTO OrderProducts (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;

-- Verify the results (optional)
SELECT * FROM Customers;
SELECT * FROM OrderProducts;


