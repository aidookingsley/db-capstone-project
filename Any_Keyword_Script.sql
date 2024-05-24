 SELECT m.ItemName
 FROM Menu m
 WHERE m.MenuID = ANY (
 SELECT MenuID FROM OrdersMenu
 GROUP BY MenuID
 HAVING SUM(Quantity) > 2
);