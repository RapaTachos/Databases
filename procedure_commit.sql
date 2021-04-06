
USE guest;
DROP TABLE IF EXISTS ACCOUNT;

CREATE TABLE ACCOUNT 
(
  AccountId INT PRIMARY KEY,
  Value INT 
);

INSERT INTO ACCOUNT(AccountId, Value)
VALUES (1, 100), 
       (2, 200), 
       (3, 300), 
       (4, 400), 
       (5, 500);

DROP PROCEDURE IF EXISTS transfer;

DELIMITER $
CREATE PROCEDURE transfer(IN id1 INT, IN id2 INT, IN amount INT, OUT done BOOLEAN) 
BEGIN
  START TRANSACTION;

  UPDATE ACCOUNT 
  SET Value = Value - amount 
  WHERE AccountId = id1; 

  UPDATE ACCOUNT 
  SET Value = Value + amount 
  WHERE AccountId = id2;

  COMMIT;
  SET done = TRUE;
END $

DELIMITER ;

