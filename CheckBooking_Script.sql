-- Seting a custom delimiter
DELIMITER //

CREATE PROCEDURE CheckBooking(IN bookingDate DATE, IN tableNumber INT)
BEGIN
    DECLARE isBooked INT;

    SELECT COUNT(*)
    INTO isBooked
    FROM LittleLemonDB.Bookings
    WHERE TableNumber = tableNumber AND DATE(BookingDate) = bookingDate;

    IF isBooked > 0 THEN
        SELECT CONCAT('Table ', tableNumber, ' is already booked.') AS Message;
    ELSE
        SELECT CONCAT('Table ', tableNumber ,' is available.') AS Message;
    END IF;
END //

DELIMITER ;

DROP PROCEDURE IF EXISTS CheckBooking;

-- Call the CheckBooking stored procedure
CALL CheckBooking('2022-11-12', 3);
CALL CheckBooking('2022-10-10', 1);

SELECT * FROM Bookings;