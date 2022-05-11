CREATE DATABASE Petreceri
GO
USE Petreceri

CREATE TABLE Tip
(id INT IDENTITY PRIMARY KEY,
nume VARCHAR(50) NOT NULL,
descriere VARCHAR(150)
);
GO
CREATE TABLE Petreceri
(id INT IDENTITY PRIMARY KEY,
nume VARCHAR(50) NOT NULL,
buget INT CHECK(buget>0),
data_petrecere DATE,
locatie VARCHAR(100),
tip INT FOREIGN KEY REFERENCES Tip(id)
);

GO
CREATE OR ALTER PROCEDURE AdaugaTip(@nume_tip VARCHAR(50), @descriere VARCHAR(150))
as
begin
	INSERT INTO Tip(nume, descriere) VALUES (@nume_tip, @descriere);
end

GO
EXEC AdaugaTip 'Gratar', 'Bere rece'
EXEC AdaugaTip 'LaCiubar', 'Apa calda, domle'
EXEC AdaugaTip 'Boardgames night', 'Lame'

SELECT * FROM Tip

GO
CREATE OR ALTER PROCEDURE AdaugaPetrecere(@nume_petrecere VARCHAR(50), 
@buget INT, @data DATE, @locatie VARCHAR(100), @nume_tip VARCHAR(50))
AS
BEGIN
	DECLARE @tip_cautat INT = 0;
	SELECT TOP 1 @tip_cautat = id FROM Tip
	WHERE nume = @nume_tip;

	IF(@tip_cautat = 0)
		RAISERROR('Nu am gasit petrecerile!',11, 1);
	ELSE
		INSERT INTO Petreceri(nume,buget,data_petrecere,locatie,tip) VALUES (@nume_petrecere, @buget,
	@data, @locatie, @tip_cautat);
END
GO

EXEC AdaugaPetrecere 'MegaDiscoCostinesti',1,'2021-12-10','Costinesti','Gratar'
EXEC AdaugaPetrecere 'Tematica',100,'2022-3-12','Acasa','Spooky'

SELECT * FROM Petreceri

GO
CREATE OR ALTER PROCEDURE CalculeazaBuget(@nume_tip VARCHAR(50), @buget_total INT OUTPUT)
AS
BEGIN
DECLARE @id_tip INT = 0;
SELECT TOP 1 @id_tip = id FROM Tip
WHERE nume = @nume_tip

SELECT @buget_total = SUM(buget) FROM Petreceri
WHERE id = @id_tip

END
GO

DECLARE @buget_total INT = 0;
EXEC CalculeazaBuget 'Gratar', @buget_total = @buget_total OUTPUT
PRINT @buget_total

