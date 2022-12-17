Use SeguroVeiculo;

SELECT * FROM Apolices;

--Operadores Relacionais
SELECT * FROM Apolices
WHERE valorApolice >= 50000;
---------------------------------------
SELECT *FROM Apolices
WHERE valorApolice >= 30000
ORDER BY valorApolice DESC;

--Operadores Logicos
SELECT *FROM Apolices
WHERE idSeguradora = 1 and valorApolice >= 50000;
----------------------------------------------------
SELECT *FROM Apolices
WHERE NOT idCidade = 5;

--Operadores Aritimeticos
SELECT nContrato, valorApolice, valorApolice * 1.1 as [Reajuste Anual]
FROM Apolices

--Operadores Compostos
BEGIN TRAN
	UPDATE Apolices
	SET valorApolice *= 1.1
COMMIT TRAN