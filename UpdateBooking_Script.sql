DELIMITER //

CREATE PROCEDURE UpdateBooking(
    IN booking_ID INT,
    IN booking_Date DATE
)
BEGIN
    UPDATE LittleLemonDB.Bookings
    SET BookingDate = booking_Date
    WHERE BookingID = booking_ID;
END //

DELIMITER ;

-- Call the procedure UpdateBooking
CALL UpdateBooking(1, '2022-12-01');

