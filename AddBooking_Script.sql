DELIMITER //

CREATE PROCEDURE AddBooking(
    IN booking_ID INT,
    IN customer_ID INT,
    IN booking_Date DATE,
    IN table_Number INT
)
BEGIN
    INSERT INTO LittleLemonDB.Bookings (BookingID, BookingDate, TableNumber, CustomerID, StaffID)
    VALUES (booking_ID, booking_Date, tableNumber, customerID, NULL);
    SELECT CONCAT('New booking Added');
END //

DELIMITER ;

-- Call the AddBooking stored procedure
CALL AddBooking(8, 6, '2023-05-06', 1);
DROP PROCEDURE IF EXISTS AddBooking;
select * from Bookings;