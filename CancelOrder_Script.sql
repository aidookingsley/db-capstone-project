-- Seting a custom delimiter
DELIMITER //

-- Creating a stored procedure
CREATE PROCEDURE CancelOrder(IN order_id INT)
BEGIN
 DELETE FROM Orders
 WHERE Orders.OrderID = order_id;
 SELECT CONCAT("Order ", order_id, " has been canceled ");
END //


-- Resetting the delimiter
DELIMITER ;

-- Calling the stored procedure
CALL CancelOrder(3);
DROP PROCEDURE IF EXISTS CancelOrder;