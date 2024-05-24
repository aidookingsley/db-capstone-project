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
