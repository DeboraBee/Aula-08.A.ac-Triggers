-- Questão 1, trigger que atualiza o valor de créditos de um aluno após a retirada de um curso da sua lista. --
CREATE TRIGGER dbo.lost_credits
ON dbo.takes
AFTER delete AS
IF (ROWCOUNT_BIG() = 0)
RETURN;
BEGIN
	UPDATE dbo.student
    SET tot_cred = tot_cred - (SELECT credits FROM dbo.course INNER JOIN deleted ON course.course_id = deleted.course_id) 
    WHERE student.id = (SELECT DISTINCT ID FROM deleted);	
END
