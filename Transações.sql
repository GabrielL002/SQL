use SeguroVeiculo
select *from Apolices

--Iniciar Transa��o
BEGIN TRAN

--verificar se h� alguma  transa��o ativa
select @@TRANCOUNT; --Retorna 1 se tiver ativo e 0 caso contrario

UPDATE Apolices
SET	valorApolice += 1500;
--Supondo que o update deveria ter uma clausula where, nesse caso � so dar um rollback
	
ROLLBACK TRAN
--inicio novamente a transa��o apenas executando o c�digo BEGIN ja digitado, e fa�o o update certo

UPDATE Apolices
SET	valorApolice += 1500
where nContrato = 1000;

--agora so confirmar transa��o
COMMIT TRAN