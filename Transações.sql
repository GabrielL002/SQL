use SeguroVeiculo
select *from Apolices

--Iniciar Transação
BEGIN TRAN

--verificar se há alguma  transação ativa
select @@TRANCOUNT; --Retorna 1 se tiver ativo e 0 caso contrario

UPDATE Apolices
SET	valorApolice += 1500;
--Supondo que o update deveria ter uma clausula where, nesse caso é so dar um rollback
	
ROLLBACK TRAN
--inicio novamente a transação apenas executando o código BEGIN ja digitado, e faço o update certo

UPDATE Apolices
SET	valorApolice += 1500
where nContrato = 1000;

--agora so confirmar transação
COMMIT TRAN