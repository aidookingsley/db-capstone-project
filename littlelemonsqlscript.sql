USE LittleLemonDB;

-- Populate Address table
INSERT INTO LittleLemonDB.Address (Country, City, PostalCode)
VALUES
    ('United States', 'New York', '10152'),
    ('United Kingdom', 'London', 'EC1A 2AY'),
    ('Canada', 'Toronto', 'M4B 2J8'),
    ('Australia', 'Sydney', '2564'),
    ('France', 'Paris', '70123');
    
-- Populate Customers table
INSERT INTO LittleLemonDB.Customers (CustomerName, Email, PhoneNumber, AddressID)
VALUES
    ('Ade Ofosua', 'ade.ofosua@email.com', '1234567890', 1),
    ('Joe Smith', 'joe.smith@email.com', '9876543210', 2),
    ('Kingsley Aidoo', 'kingsley.aidoo@email.com', '5512355555', 3),
    ('Priscilla Dansoa', 'priscilla.dansoa@email.com', '1112223333', 4),
    ('Chris William', 'chris.william@email.com', '4445556666', 5);
    
-- Populate Staff table
INSERT INTO LittleLemonDB.Staff (Role, Salary)
VALUES
    ('Manager', 800.00),
    ('Chef', 650.00),
    ('Waiter', 500.00),
    ('Bartender', 400.00),
    ('Hostess', 300.00);
    
-- Populate Bookings table
INSERT INTO LittleLemonDB.Bookings (BookingDate, TableNumber, CustomerID, StaffID)
VALUES
    ('2023-05-01 19:00:00', 1, 1, 5),
    ('2023-05-02 20:30:00', 2, 2, 3),
    ('2023-05-03 18:00:00', 3, 3, 5),
    ('2023-05-04 21:00:00', 4, 4, 3),
    ('2023-05-05 19:30:00', 5, 5, 5);
    

-- Populate Orders table
INSERT INTO LittleLemonDB.Orders (OrderDate, Quantity, TotalCost, CustomerID)
VALUES
    ('2023-05-01 19:30:00', 2, 60.00, 1),
    ('2023-05-02 21:00:00', 3, 55.00, 2),
    ('2023-05-03 18:30:00', 1, 40.00, 3),
    ('2023-05-04 21:30:00', 4, 100.00, 4),
    ('2023-05-05 20:00:00', 2, 80.00, 5);
    

-- Populate DeliveryStatus table
INSERT INTO LittleLemonDB.DeliveryStatus (DeliveryDate, Status, OrderID)
VALUES
    ('2023-05-01 20:00:00', 'Delivered', 1),
    ('2023-05-02 21:30:00', 'Delivered', 2),
    ('2023-05-03 19:00:00', 'Delivered', 3),
    ('2023-05-04 22:00:00', 'Delivered', 4),
    ('2023-05-05 20:30:00', 'Delivered', 5);

-- Populate Menu table
INSERT INTO LittleLemonDB.Menu (ItemName, Price, Category)
VALUES
    ('Margherita Pizza', 12.99, 'Main Course'),
    ('Caesar Salad', 8.99, 'Starter'),
    ('Spaghetti Bolognese', 14.99, 'Main Course'),
    ('Tiramisu', 6.99, 'Dessert'),
    ('Mojito', 9.99, 'Drink');

-- Populate OrdersMenu table
INSERT INTO LittleLemonDB.OrdersMenu (OrderID, MenuID, Quantity)
VALUES
    (1, 3, 1),
    (1, 4, 1),
    (2, 3, 2),
    (2, 4, 1),
    (3, 1, 1),
    (4, 2, 2),
    (4, 1, 1),
    (4, 2, 1),
    (5, 3, 2);

DESC Staff;


CREATE TABLE LittleLemonDB.OrdersMenuNew (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT,
    MenuID INT,
    Quantity INT,
    UNIQUE (OrderID, MenuID)
);

INSERT INTO LittleLemonDB.OrdersMenuNew (OrderID, MenuID, Quantity)
SELECT OrderID, MenuID, Quantity FROM LittleLemonDB.OrdersMenu;

DROP TABLE LittleLemonDB.OrdersMenu;

ALTER TABLE LittleLemonDB.OrdersMenuNew RENAME TO LittleLemonDB.OrdersMenu;


-- Drop the table if it exists
DROP TABLE IF EXISTS LittleLemonDB.OrdersMenu;

-- Create the table with the correct primary key
CREATE TABLE LittleLemonDB.OrdersMenu (
    OrderID INT,
    MenuID INT,
    Quantity INT,
    PRIMARY KEY (OrderID, MenuID)
);

-- Insert the data
INSERT INTO LittleLemonDB.OrdersMenu (OrderID, MenuID, Quantity)
VALUES
    (1, 1, 1),
    (1, 2, 1),
    (2, 3, 2),
    (2, 4, 1),
    (3, 1, 1),
    (4, 2, 2),
    (4, 3, 1),
    (4, 4, 1),
    (5, 5, 2);


CREATE VIEW OrdersView AS
 SELECT O.OrderID, O.Quantity, O.TotalCost
 FROM LittleLemonDB.Orders AS O
 WHERE O.Quantity > 2;
SELECT * FROM OrdersView;


SELECT C.CustomerID, C.CustomerName, O.OrderID, O.TotalCost
 FROM Orders O
 INNER JOIN Customers C ON O.CustomerID = C.CustomerID
 WHERE O.TotalCost > 50;
 
 
 SELECT m.ItemName
 FROM Menu m
 WHERE m.MenuID = ANY (
 SELECT MenuID FROM OrdersMenu
 GROUP BY MenuID
 HAVING SUM(Quantity) > 2
);


-- Setting a custom delimiter
DELIMITER //

-- Creating a stored procedure
CREATE PROCEDURE GetMaxQuantity()
BEGIN
 SELECT MAX(Quantity) AS 'Get Max Quantity'
 FROM Orders;
END //

-- Resetting the delimiter to the default
DELIMITER ;

-- Calling the stored procedure
CALL GetMaxQuantity();


PREPARE GetOrderDetail FROM
 'SELECT OrderID, Quantity, TotalCost
 FROM Orders
 WHERE CustomerID = ?';

SET @id = 1;
EXECUTE GetOrderDetail USING @id;

-- Seting a custom delimiter
DELIMITER //

-- Creating a stored procedure
CREATE PROCEDURE CancelOrder(IN order_id INT)
BEGIN
 DELETE FROM Orders
 WHERE Orders.OrderID = order_id;
END //

-- Resetting the delimiter
DELIMITER ;

-- Calling the stored procedure
CALL CancelOrder(3);

