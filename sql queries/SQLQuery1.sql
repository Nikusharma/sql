
DELIMITER $$

CREATE FUNCTION profitType(profit int)
RETURNS VARCHAR(30) DETERMINISTIC

BEGIN
DECLARE message VARCHAR(30)
IF profit <= -500 THEN
	SET message = 'Huge Loss';
ELSEIF profit BETWEEN -500 AND 0 THEN
	SET message = 'Bearable Loss';
ELSEIF profit BETWEEN 0 AND 500 THEN
	SET message = 'Decent Profit';
ELSE
	SET message = 'Great Profit';
END IF;

RETURN message;

END;

$$ 
DELIMITER;