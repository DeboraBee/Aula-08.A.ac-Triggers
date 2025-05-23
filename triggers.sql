-- Questão 1--
CREATE TRIGGER dbo.credits_earned
ON dbo.takes
AFTER INSERT AS
IF (ROWCOUNT_BIG() = 0)
RETURN;
BEGIN
	UPDATE dbo.student
    SET tot_cred = tot_cred + (SELECT credits FROM dbo.course INNER JOIN inserted ON course.course_id = inserted.course_id) 
    WHERE student.id = (SELECT DISTINCT ID FROM inserted);	
END

SELECT ID, count(*) AS qtd_courses FROM takes 
GROUP BY ID
ORDER BY qtd_courses;
