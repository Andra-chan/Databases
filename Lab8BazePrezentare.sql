USE Lab5Baze
GO

-- Profesori
EXEC CreateProfesor 'Barbulescu', 'Mihai', '0712345678', 'adresa1'
EXEC CreateProfesor 'Dumitru', 'Mihaela', '0712345678', 'adresa2'
EXEC CreateProfesor 'Popescu', 'Anca', '0712345678', 'adresa3'
EXEC CreateProfesor 'Mihaila', 'Andra', '0712345678', 'adresa4'

EXEC ReadProfesor 'Mihaela'
EXEC ReadProfesor 'Mihai'
EXEC ReadProfesor 'Andra'

EXEC UpdateProfesor 'Barbulescu', 'adresaB'
EXEC UpdateProfesor 'Mihaila' , 'adresaI'

EXEC DeleteProfesor 'Barbulescu'
EXEC DeleteProfesor 'Mihaila'
EXEC ReadProfesor 'Mihai'

-- Cursuri
EXEC CreateCurs 1, 1, 'Engleza Incepatori'
INSERT INTO Sali(numar) VALUES (1), (2), (3), (4)
EXEC CreateCurs 1, 1, 'Engleza Incepatori'
INSERT INTO Preturi(suma) VALUES (10), (200), (400)
INSERT INTO Materiale(cod_pret, denumire) VALUES (1, 'pix'), (2, 'tabla'), (3, 'carti')
EXEC CreateCurs 1, 1, 'Engleza Incepatori'
EXEC CreateCurs 2, 2, 'Engleza Avansati'
EXEC CreateCurs 3, 3, 'Engleza Incepatori'
EXEC CreateCurs 4, 3, 'Engleza Incepatori'

EXEC ReadCurs 'Engleza'
EXEC ReadCurs 'Engleza Incepatori'

EXEC UpdateCurs 'Engleza Avansati', 7
EXEC UpdateCurs 'Engleza Avansati', 1
EXEC UpdateCurs 'Engleza', 6

EXEC DeleteCurs 'Engleza', 4
EXEC DeleteCurs 'Engleza Incepatori', 7
EXEC DeleteCurs 'Engleza Avansati', 2

-- RelatieProfesoriCursuri
EXEC CreateProfesorCurs 2, 1
EXEC CreateProfesorCurs 2, 2
EXEC CreateProfesorCurs 3, 2
EXEC CreateProfesorCurs 3, 4
EXEC CreateProfesorCurs 6, 3
EXEC CreateProfesorCurs 3, 6

EXEC ReadProfesorCurs 2
EXEC ReadProfesorCurs 4

EXEC UpdateProfesorCurs 1, 3
EXEC UpdateProfesorCurs 5, 2
EXEC UpdateProfesorCurs 1, 5

EXEC DeleteProfesorCurs 1, 2
EXEC DeleteProfesorCurs 5, 2
EXEC DeleteProfesorCurs 1, 5

SELECT * FROM ViewProfesoriCursuri
SELECT * FROM ViewCursuriProfesori

SELECT * FROM Cursuri
SELECT * FROM Profesori
SELECT * FROM RelatieProfesoriCursuri
