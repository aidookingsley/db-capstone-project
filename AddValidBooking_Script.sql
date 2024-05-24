DELIMITER //

CREATE PROCEDURE AddValidBooking(
    IN bookingDate DATE,
    IN tableNumber INT)
BEGIN
	DECLARE isBooked INT;
    
    -- Start Transaction
    START TRANSACTION;
    
    -- Check if the table is already booked on the given date
    SELECT COUNT(*) INTO isBooked
    FROM LittleLemonDB.Bookings
    WHERE TableNumber = tableNumber AND DATE(BookingDate) = bookingDate;
    
    -- If the table is booked, then roll back the transaction
    IF isBooked > 0 THEN
		ROLLBACK;
        SELECT CONCAT('Table ', tableNumber, ' is already booked on ', (bookingDate), '- booking cancelled') AS Message;
	 ELSE
        -- If the table is not booked, insert the new booking and commit the transaction
        INSERT INTO LittleLemonDB.Bookings (BookingDate, TableNumber, CustomerID, StaffID)
        VALUES (bookingDate, tableNumber, customerID, staffID);
        COMMIT;
        SELECT CONCAT('Booking for table ', tableNumber, ' on ', bookingDate, ' has been successfully added.') AS Message;
	END IF;
END //

DELIMITER ;

DROP PROCEDURE IF EXISTS AddValidBooking;

-- Call the AddValidBooking stored procedure
CALL AddValidBooking('2022-12-17', 6 );
CALL AddValidBooking('2023-05-04 10:00:00', 2);


    
    
    