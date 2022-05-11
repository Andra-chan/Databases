USE Lab5Baze
GO

CREATE TABLE Versiune
(version_id INT PRIMARY KEY DEFAULT 0)
GO

SELECT * FROM Versiune

INSERT INTO Versiune(version_id)
VALUES (0)
GO

CREATE OR ALTER PROCEDURE DO1
AS
	DECLARE @v INT
	SELECT TOP 1 @v = version_id
	FROM Versiune

	IF @v = 0
	BEGIN
		ALTER TABLE Materiale
		ALTER COLUMN denumire VARCHAR(500) NOT NULL 

		UPDATE Versiune SET version_id = 1
		PRINT 'denumire in Materiale is now varchar(500).'
		PRINT 'Database is now at version 1.'
	END
GO

CREATE OR ALTER PROCEDURE UNDO1
AS
	DECLARE @v INT
	SELECT TOP 1 @v = version_id
	FROM Versiune

	IF @v = 1
	BEGIN
		ALTER TABLE Materiale
		ALTER COLUMN denumire VARCHAR(250)

		UPDATE Versiune SET version_id = 0
		PRINT 'denumire in Materiale is now varchar(250).'
		PRINT 'Database is now at version 0.'
	END
GO

CREATE OR ALTER PROCEDURE DO2
AS
	DECLARE @v INT
	SELECT TOP 1 @v = version_id
	FROM Versiune

	IF @v = 1
	BEGIN
		ALTER TABLE Grupe
		ADD CONSTRAINT default_numar DEFAULT 1 FOR numar

		UPDATE Versiune SET version_id = 2
		PRINT 'numar in Grupe is now default 1.'
		PRINT 'Database is now at version 2.'
	END
GO

CREATE OR ALTER PROCEDURE UNDO2
AS
	DECLARE @v INT
	SELECT TOP 1 @v = version_id
	FROM Versiune

	IF @v = 2
	BEGIN
		ALTER TABLE Grupe
		DROP CONSTRAINT default_numar

		UPDATE Versiune SET version_id = 1
		PRINT 'numar in Grupe has no default anymore.'
		PRINT 'Database is now at version 1.'
	END
GO

CREATE OR ALTER PROCEDURE DO3
AS
	DECLARE @v INT
	SELECT TOP 1 @v = version_id
	FROM Versiune

	IF @v = 2
	BEGIN
		CREATE TABLE Centre(
		centru_id INT PRIMARY KEY,
		cod_g INT,
		locatie VARCHAR(100) NOT NULL)

		UPDATE Versiune SET version_id = 3
		PRINT 'Centre table has been created.'
		PRINT 'Database is now at version 3.'	
	END
GO

CREATE OR ALTER PROCEDURE UNDO3
AS
	DECLARE @v INT
	SELECT TOP 1 @v = version_id
	FROM Versiune

	IF @v = 3
	BEGIN
		DROP TABLE Centre

		UPDATE Versiune SET version_id = 2
		PRINT 'Centre table has been dropped.'
		PRINT 'Database is now at version 2.'
	END
GO

CREATE OR ALTER PROCEDURE DO4
AS
	DECLARE @v INT
	SELECT TOP 1 @v = version_id
	FROM Versiune

	IF @v = 3
	BEGIN
		ALTER TABLE Centre
		ADD manager VARCHAR(250) NOT NULL

		UPDATE Versiune SET version_id = 4
		PRINT 'manager column is now added in Centre table.'
		PRINT 'Database is now at version 4.'
	END
GO

CREATE OR ALTER PROCEDURE UNDO4
AS
	DECLARE @v INT
	SELECT TOP 1 @v = version_id
	FROM Versiune

	IF @v = 4
	BEGIN
		ALTER TABLE Centre
		DROP COLUMN manager

		UPDATE Versiune SET version_id = 3
		PRINT 'manager column is now dropped from Centre table.'
		PRINT 'Database is now at version 3.'
	END
GO

CREATE OR ALTER PROCEDURE DO5
AS
	DECLARE @v INT
	SELECT TOP 1 @v = version_id
	FROM Versiune

	IF @v = 4
	BEGIN
		ALTER TABLE Centre
		ADD CONSTRAINT fk_cursuri_centre FOREIGN KEY(cod_g) REFERENCES Grupe(cod_g)

		UPDATE Versiune SET version_id = 5
		PRINT 'Added constraint fk_cursuri_centre.'
		PRINT 'Database is now at version 5.'
	END
GO

CREATE OR ALTER PROCEDURE UNDO5
AS
	DECLARE @v INT
	SELECT TOP 1 @v = version_id
	FROM Versiune

	IF @v = 5
	BEGIN
		ALTER TABLE Centre
		DROP CONSTRAINT fk_cursuri_centre

		UPDATE Versiune SET version_id = 4
		PRINT 'Removed constraint fk_cursuri_centre.'
		PRINT 'Database is now at version 4.'
	END
GO

CREATE PROCEDURE EXECUTE_ALL
AS
	EXEC DO1
	EXEC DO2
	EXEC DO3
	EXEC DO4
	EXEC DO5
	EXEC UNDO5
	EXEC UNDO4
	EXEC UNDO3
	EXEC UNDO2
	EXEC UNDO1
GO

EXEC EXECUTE_ALL
GO

CREATE OR ALTER PROCEDURE MAIN
@new_version INT
AS
	DECLARE @old_version INT
	DECLARE @text VARCHAR(50)
	SELECT TOP 1 @old_version = version_id
	FROM Versiune

	IF @new_version <0 OR @new_version > 5
	BEGIN
		PRINT 'Invalid input!'
	END
	ELSE
	BEGIN
		IF @old_version < @new_version
		BEGIN
			SET @old_version = @old_version + 1
			WHILE @old_version <= @new_version
			BEGIN
				SET @text = 'DO' + CONVERT(VARCHAR(5), @old_version)
				EXEC @text
				SET @old_version = @old_version + 1
			END
		END
		ELSE
		BEGIN
			IF @old_version > @new_version
			BEGIN
				WHILE @old_version > @new_version
				BEGIN
					SET @text = 'UNDO' + CONVERT(VARCHAR(5), @old_version)
					EXEC @text
					SET @old_version = @old_version - 1
				END
			END
		END
	END
GO

EXEC MAIN 0





