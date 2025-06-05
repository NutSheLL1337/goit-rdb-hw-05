Use mydb;
SELECT order_id, (SELECT customer_id FROM orders) as customers
FROM order_details;

SELECT 
    od.*, 
    (
        SELECT o.customer_id
        FROM orders o
        WHERE o.id = od.order_id
    ) AS customer_id
FROM order_details od;


SELECT *
FROM order_details od
WHERE od.order_id IN (
    SELECT o.id
    FROM orders o
    WHERE o.shipper_id = 3
);

-- 3. Напишіть SQL запит, вкладений в операторі FROM, який буде обирати рядки з умовою quantity>10 з таблиці order_details. 
-- Для отриманих даних знайдіть середнє значення поля quantity — групувати слід за order_id.

SELECT order_id, AVG(quantity)
FROM (SELECT * FROM order_details od WHERE od.quantity>10) AS orders_with_quantity
group by order_id;

WITH Temp as (SELECT * FROM order_details od WHERE od.quantity>10)
SELECT order_id, AVG(quantity)
FROM Temp
group by order_id;


-- 5. Створіть функцію з двома параметрами, яка буде ділити перший параметр на другий. 
-- Обидва параметри та значення, що повертається, повинні мати тип FLOAT.
-- Використайте конструкцію DROP FUNCTION IF EXISTS. Застосуйте функцію до атрибута quantity таблиці order_details . 
-- Другим параметром може бути довільне число на ваш розсуд.

DROP FUNCTION IF EXISTS Calculate_divide;
DELIMITER //
CREATE FUNCTION Calculate_divide(first_number FLOAT, second_number FLOAT)
RETURNS INT
DETERMINISTIC 
NO SQL
BEGIN
    DECLARE result FLOAT;
    SET result = first_number / second_number;
    RETURN result;
END //
DELIMITER ;
SELECT Calculate_divide(quantity, 3)
FROM order_details; 
