SELECT C.CustomerID, C.CustomerName, O.OrderID, O.TotalCost
 FROM Orders O
 INNER JOIN Customers C ON O.CustomerID = C.CustomerID
 WHERE O.TotalCost > 50;