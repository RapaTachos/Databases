DROP FUNCTION IF EXISTS getDepartment;
DELIMITER $
CREATE FUNCTION getDepartment(staff_id INT)
RETURNS INT
BEGIN
  DECLARE dep_id INT;
  SET dep_id = NULL;

  SELECT D.DepId INTO dep_id
  FROM DEPARTMENT D  JOIN STAFF S1
  WHERE (D.Manager= S1.StaffId OR D.Manager = S1.Supervisor)
          AND S1.StaffId = staff_id;



  RETURN dep_id;
END $
DELIMITER ;
