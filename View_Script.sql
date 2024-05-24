CREATE VIEW OrdersView AS
 SELECT O.OrderID, O.Quantity, O.TotalCost
 FROM LittleLemonDB.Orders AS O
 WHERE O.Quantity > 2;
SELECT * FROM OrdersView;