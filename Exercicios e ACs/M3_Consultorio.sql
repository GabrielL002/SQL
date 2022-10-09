--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=--
--=X=-- DDL - Criação da base
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=--
CREATE DATABASE M3_consultorio;
GO
USE M3_consultorio;
GO
CREATE TABLE Paciente (
ID INT NOT NULL IDENTITY(1,1)
, Nome VARCHAR(50) NOT NULL
, Telefone INT NULL
, CONSTRAINT PK_Paciente PRIMARY KEY ( ID )
)
GO
CREATE TABLE Sala (
Numero INT NOT NULL
, CONSTRAINT PK_Sala PRIMARY KEY ( Numero )
)
GO
CREATE TABLE Medico (
ID INT NOT NULL IDENTITY(1,1)
, CRM VARCHAR(50) NOT NULL --acrescentado, mas não tenho valores....
, Nome VARCHAR(50) NOT NULL
, Especialidade VARCHAR(30) NULL
, CONSTRAINT PK_Medico PRIMARY KEY ( ID )
)
GO
CREATE TABLE Consulta (
ID INT NOT NULL IDENTITY(1,1)
, ID_Paciente INT NOT NULL
, ID_Medico INT NOT NULL
, NumeroSala INT NOT NULL
, DataHora DATETIME NOT NULL
, Duracao TINYINT NOT NULL
, CONSTRAINT PK_Consulta PRIMARY KEY ( ID )
, CONSTRAINT FK_ConsultaMedico FOREIGN KEY ( Id_medico ) REFERENCES Medico( ID )
, CONSTRAINT FK_ConsultaPaciente FOREIGN KEY ( Id_paciente ) REFERENCES paciente(
ID )
, CONSTRAINT FK_ConsultaSala FOREIGN KEY ( NumeroSala ) REFERENCES Sala( Numero )
)
GO
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=--
--=X=-- DML - Carga da base
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=--
INSERT INTO Paciente( Nome, Telefone )
VALUES ( 'Almir dos Santos', '99923232' )
, ( 'Adamastor Silva', '32324414' )
GO

INSERT INTO Medico( CRM, Nome, Especialidade )
VALUES ( '<não cadastrado>', 'Creusa', 'Dentista' )
, ( '<não cadastrado>', 'Juvenal', 'Psicólogo' )
GO
--salas só existem para garantir integridade referencial em consulta
--poderiam ser substituidas por um check constraint, porém, este dá mais trabalho
---para manutenção ( incluir, retirar salas )
INSERT INTO Sala( Numero )
VALUES ( 9 )
, ( 12 )
GO
INSERT INTO Consulta ( ID_Paciente, ID_Medico, NumeroSala, DataHora, Duracao )
VALUES ( (SELECT id FROM paciente WHERE nome = 'Almir dos Santos')
, (SELECT id FROM medico WHERE nome = 'Creusa')
, 9 --não faz sentido buscar a sala 9 via select
, '20171021 15:00'
, 30
), ( (SELECT id FROM paciente WHERE nome = 'Almir dos Santos')
, (SELECT id FROM medico WHERE nome = 'Juvenal')
, 9 --não faz sentido buscar a sala 9 via select
, '20171023 15:00'
, 15
), ( (SELECT id FROM paciente WHERE nome = 'Adamastor Silva')
, (SELECT id FROM medico WHERE nome = 'Creusa')
, 12 --não faz sentido buscar a sala 9 via select
, '20171026 15:00'
, 60
)
--Conferências:
select * from Paciente
select * from Medico
select * from Sala
select * from Consulta

--Execute as seguintes consultas no banco de dados criado:
--Lista com o nome e telefone dos pacientes cadastrados
--Lista com o numero da sala e a data/hora das consultas realizadas pelo médico ‘Juvenal’ ordenadas por dataHora
--Lista com os nomes dos médicos cuja especialidade = ‘Dentista’
--Lista o nome dos pacientes que foram atendidos entre ‘01/01/2017 e ‘31/12/2017’
--Lista com o Nome do Médico e Paciente, das consultas cuja duração foi igual ou superior à 60 minutos.

select nome, telefone from Paciente
-----------------------------------------------------------
select Consulta.NumeroSala, Consulta.DataHora from Consulta
inner join Medico on Consulta.ID_Medico = Medico.ID
where Medico.Nome = 'Juvenal'
ORDER BY DataHora
-----------------------------------------------------------
select nome from Medico where Especialidade = 'Dentista'
-----------------------------------------------------------
select Paciente.Nome from Paciente
join Consulta on Consulta.ID_Paciente = Paciente.ID
where DataHora between  '01/01/2017' and '31/12/2017'
-----------------------------------------------------------
select Medico.Nome as NomeMedico, Paciente.Nome as NomePaciente from Consulta
join Paciente on Paciente.Id = ID_Paciente
join Medico on Medico.Id = ID_Medico
where Duracao >= 60