USE Lab5Baze
GO

-- Profesori

-- Create
GO
CREATE OR ALTER PROCEDURE CreateProfesor(
@NumeProfesor VARCHAR(100),
@PrenumeProfesor VARCHAR(100),
@TelefonProfesor int,
@AdresaProfesor VARCHAR(500))
AS
BEGIN
	IF dbo.ValideazaNumeProfesor(@NumeProfesor) = 0
	BEGIN
		PRINT 'Profesor inexistent!';
		RETURN
	END

	INSERT INTO Profesori(nume, prenume, telefon, adresa)
	VALUES (@NumeProfesor, @PrenumeProfesor, @TelefonProfesor, @AdresaProfesor)
END

-- Read
GO
CREATE OR ALTER PROCEDURE ReadProfesor(@PrenumeProfesor VARCHAR(100))
AS
BEGIN
	IF dbo.ValideazaPrenumeProfesor(@PrenumeProfesor) = 0
	BEGIN
		PRINT 'Prenume inexistent!';
		RETURN
	END
	SELECT * FROM Profesori
	WHERE prenume = @PrenumeProfesor
END

-- Update
GO
CREATE OR ALTER PROCEDURE UpdateProfesor(@NumeProfesor VARCHAR(100), @AdresaProfesor VARCHAR(500))
AS
BEGIN
	IF dbo.ValideazaNumeProfesor(@NumeProfesor) = 0
	BEGIN
		PRINT 'Nume inexistent!';
		RETURN
	END
	ELSE
	BEGIN
		UPDATE Profesori
		SET adresa = @AdresaProfesor
		WHERE nume = @NumeProfesor
		RETURN
	END
END

--Delete
GO
CREATE OR ALTER PROCEDURE DeleteProfesor(@NumeProfesor VARCHAR(100))
AS
BEGIN
	IF dbo.ValideazaNumeProfesor(@NumeProfesor) = 0
	BEGIN
		PRINT 'Nume inexistent!';
		RETURN
	END
	ELSE
	BEGIN
		DELETE FROM Profesori
		WHERE nume = @NumeProfesor
		RETURN
	END
END

-- Validatoare Profesor
GO
CREATE OR ALTER FUNCTION ValideazaNumeProfesor(@NumeProfesor VARCHAR(100))
RETURNS INT
AS
BEGIN
	DECLARE @valid INT
	SET @valid = 0;
	IF @NumeProfesor IN ('Popescu', 'Dumitru', 'Barbulescu')
		SET @valid = 1
	RETURN @valid
END

GO
CREATE OR ALTER FUNCTION ValideazaPrenumeProfesor(@PrenumeProfesor VARCHAR(100))
RETURNS INT
AS
BEGIN
	DECLARE @valid INT
	SET @valid = 0;
	IF @PrenumeProfesor IN ('Anca', 'Mihaela', 'Mihai')
		SET @valid = 1
	RETURN @valid
END

-- RelatieProfesoriCursuri

-- Create
GO
CREATE OR ALTER PROCEDURE CreateProfesorCurs(@cod_prof int, @cod_c int)
AS
BEGIN
	IF dbo.ValideazaIDProfesor(@cod_prof) = 0
	BEGIN
		PRINT 'Profesor inexistent!';
		RETURN
	END

	IF dbo.ValideazaIDCurs(@cod_c) = 0
	BEGIN
		PRINT 'Curs inexistent!';
		RETURN
	END

	IF dbo.ValideazaIDProfesorCurs(@cod_prof, @cod_c) = 1
	BEGIN
		PRINT 'Relatie profesor-curs existenta!';
		RETURN
	END

	INSERT INTO RelatieProfesoriCursuri(cod_prof, cod_c)
	VALUES (@cod_prof, @cod_c)

END

-- Read
GO
CREATE OR ALTER PROCEDURE ReadProfesorCurs (@cod_prof INT)
AS
BEGIN
	IF dbo.ValideazaIDProfesor(@cod_prof) = 0
	BEGIN
		PRINT 'Profesor inexistent!';
		RETURN
	END
	SELECT * FROM RelatieProfesoriCursuri
	WHERE cod_prof = @cod_prof
END

-- Update
GO
CREATE OR ALTER PROCEDURE UpdateProfesorCurs(@cod_prof INT, @cod_c INT)
AS
BEGIN
	IF dbo.ValideazaIDProfesor(@cod_prof) = 0
	BEGIN
		PRINT 'Profesor inexistent!';
		RETURN
	END

	IF dbo.ValideazaIDCurs(@cod_c) = 0
	BEGIN
		PRINT 'Curs inexistent!';
		RETURN
	END

	IF dbo.ValideazaIDProfesorCurs(@cod_prof, @cod_c) = 1
	BEGIN
		PRINT 'Relatie profesor-curs existenta!';
		RETURN
	END

	UPDATE RelatieProfesoriCursuri
	SET cod_c = @cod_c
	WHERE cod_prof = @cod_prof
	RETURN

END

-- Delete
GO
CREATE OR ALTER PROCEDURE DeleteProfesorCurs (@cod_prof INT, @cod_c INT)
AS
BEGIN
	DELETE FROM RelatieProfesoriCursuri
	WHERE cod_prof = @cod_prof AND cod_c = @cod_c
END

-- Validatoare RelatieProfesoriCursuri

GO
CREATE OR ALTER FUNCTION ValideazaIDProfesor(@cod_prof INT)
RETURNS INT
AS
BEGIN
	DECLARE @valid INT 
	SET @valid = 0;
	SELECT @valid = COUNT(*) FROM Profesori
	GROUP BY cod_prof
	HAVING cod_prof = @cod_prof
	RETURN @valid
END

GO
CREATE OR ALTER FUNCTION ValideazaIDCurs(@cod_c INT)
RETURNS INT
AS
BEGIN
	DECLARE @valid INT 
	SET @valid = 0;
	SELECT @valid = COUNT(*) FROM Cursuri
	GROUP BY cod_c
	HAVING cod_c = @cod_c
	RETURN @valid
END

GO
CREATE OR ALTER FUNCTION ValideazaIDProfesorCurs(@cod_prof INT, @cod_c INT)
RETURNS INT
AS
BEGIN
	DECLARE @valid INT 
	SET @valid = 0;
	SELECT @valid = COUNT(*) FROM RelatieProfesoriCursuri
	GROUP BY cod_prof, cod_c
	HAVING cod_prof = @cod_prof AND cod_c = @cod_c
	RETURN @valid
END

-- Cursuri

-- Create
GO
CREATE OR ALTER PROCEDURE CreateCurs(
@cod_s INT,
@cod_m INT,
@denumire VARCHAR(250))
AS
BEGIN
	IF dbo.ValideazaIDSala(@cod_s) = 0
	BEGIN
		PRINT 'Sala inexistenta!';
		RETURN
	END

	IF dbo.ValideazaIDMaterial(@cod_m) = 0
	BEGIN
		PRINT 'Material inexistent!';
		RETURN
	END

	INSERT INTO Cursuri(cod_s, cod_m, denumire)
	VALUES (@cod_s, @cod_m, @denumire)
END

-- Read
GO
CREATE OR ALTER PROCEDURE ReadCurs(@denumire VARCHAR(250))
AS
BEGIN
	IF dbo.ValideazaDenumireCurs(@denumire) = 0
	BEGIN
		PRINT 'Curs inexistent!';
		RETURN
	END

	SELECT * FROM Cursuri
	WHERE denumire = @denumire
END

-- Update
GO
CREATE OR ALTER PROCEDURE UpdateCurs(@denumire VARCHAR(250), @cod_s INT)
AS
BEGIN
	IF dbo.ValideazaDenumireCurs(@denumire) = 0
	BEGIN
		PRINT 'Curs inexistent!';
		RETURN
	END

	IF dbo.ValideazaIDSala(@cod_s) = 0
	BEGIN
		PRINT 'Sala inexistenta!';
		RETURN
	END

	ELSE
	BEGIN
		UPDATE Cursuri
		SET denumire = @denumire
		WHERE cod_s = @cod_s
		RETURN
	END
END

-- Delete
GO
CREATE OR ALTER PROCEDURE DeleteCurs(@denumire VARCHAR(250), @cod_s INT)
AS
BEGIN
	IF dbo.ValideazaDenumireCurs(@denumire) = 0
	BEGIN
		PRINT 'Curs inexistent!';
		RETURN
	END

	IF dbo.ValideazaIDSala(@cod_s) = 0
	BEGIN
		PRINT 'Sala inexistenta!';
		RETURN
	END
	ELSE
	BEGIN
		DELETE FROM Cursuri
		WHERE denumire = @denumire AND cod_s = @cod_s
		RETURN
	END
END

-- Validatoare Cursuri
GO
CREATE OR ALTER FUNCTION ValideazaDenumireCurs(@denumire VARCHAR(100))
RETURNS INT
AS
BEGIN
	DECLARE @valid INT
	SET @valid = 0;
	IF @denumire IN ('Engleza Incepatori', 'Engleza Avansati')
		SET @valid = 1
	RETURN @valid
END

GO
CREATE OR ALTER FUNCTION ValideazaIDSala(@cod_s INT)
RETURNS INT
AS
BEGIN
	DECLARE @valid INT 
	SET @valid = 0;
	SELECT @valid = COUNT(*) FROM Sali
	GROUP BY cod_s
	HAVING cod_s = @cod_s
	RETURN @valid
END

GO
CREATE OR ALTER FUNCTION ValideazaIDMaterial(@cod_m INT)
RETURNS INT
AS
BEGIN
	DECLARE @valid INT 
	SET @valid = 0;
	SELECT @valid = COUNT(*) FROM Materiale
	GROUP BY cod_m
	HAVING cod_m = @cod_m
	RETURN @valid
END

-- Views

CREATE NONCLUSTERED INDEX I_ProfesoriCursuri ON
RelatieProfesoriCursuri(cod_prof ASC)

CREATE NONCLUSTERED INDEX I2_Cursuri ON
Cursuri(denumire ASC)

ALTER INDEX I_ProfesoriCursuri ON  RelatieProfesoriCursuri DISABLE
ALTER INDEX I_ProfesoriCursuri ON  RelatieProfesoriCursuri REBUILD

-- DROP INDEX RelatieProfesoriCursuri.I_ProfesoriCursuri
-- DROP INDEX Cursuri.I2_Cursuri

-- Profesorii care predau la cursul de Engleza Incepatori si au numele Popescu
GO
CREATE OR ALTER VIEW ViewProfesoriCursuri AS
	SELECT p.nume, p.prenume
	FROM Profesori p
	INNER JOIN RelatieProfesoriCursuri pc on pc.cod_prof = p.cod_prof
	INNER JOIN Cursuri c on c.cod_c = pc.cod_c
	WHERE p.nume = 'Popescu' AND c.denumire = 'Engleza Incepatori'
GO

-- Cursurile de Engleza Avansati cu profesorii cu prenumele Mihai
GO
CREATE OR ALTER VIEW ViewCursuriProfesori AS
	SELECT p.nume, p.prenume
	FROM Profesori p
	INNER JOIN RelatieProfesoriCursuri pc on pc.cod_prof = p.cod_prof
	INNER JOIN Cursuri c on c.cod_c = pc.cod_c
	WHERE c.denumire = 'Engleza Avansati' AND p.prenume = 'Mihaela'
GO
