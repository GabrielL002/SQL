/*
	Exemplo de como utilizar as instru��es OUTPUT
	deleted = antigo
	inserted = novo
*/

BEGIN TRAN
--aumento de 10% para salarios até 3000
	UPDATE Funcionario
	SET salario *= 1.1
	OUTPUT
		deleted.idMatricula,
		deleted.NomeFuncionario,
		deleted.salario as [Salario Anterior],
		inserted.Salario as [Novo Salario]
	WHERE salario <= 3000

COMMIT
--Apos a transação ter sido confirmada ou cancelada, o SQL elimina todos os dados da tabela deleted e inserted
	