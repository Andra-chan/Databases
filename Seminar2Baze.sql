CREATE DATABASE Seminar2_224;
GO
USE Seminar2_224;
CREATE TABLE Persoane
(cod_p INT PRIMARY KEY IDENTITY,
nume VARCHAR(100),
prenume VARCHAR(100),
localitate VARCHAR(80)
);
INSERT INTO Persoane(nume,prenume,localitate) VALUES
('Pop', 'Adina', 'Oradea'), ('Pop','Mihai','Cluj-Napoca'),
('Pop', 'Andrei', 'Floresti'),('Popescu','Mihai', 'Brasov'),
('Ion','Ana','Sibiu'), ('Negru', 'Maria', NULL);

SELECT * FROM Persoane;

UPDATE Persoane SET localitate= 'Bucuresti'
WHERE cod_p = 3;

SELECT * FROM Persoane;

DELETE FROM Persoane WHERE prenume = 'Mihai';

SELECT * FROM Persoane;

SELECT nume FROM Persoane;

SELECT DISTINCT nume FROM Persoane;

INSERT INTO Persoane( nume, prenume, localitate) VALUES
('Popescu', 'Ion', 'Craiova');

INSERT INTO Persoane( nume, prenume, localitate) VALUES
('Popescu', 'Ion', 'Craiova');

SELECT * FROM Persoane;

SELECT nume, prenume FROM Persoane;

SELECT DISTINCT nume, prenume FROM Persoane;
--interogare care contine o coloana cu valoare calculata
SELECT nume, prenume, cod_p, cod_p+1 AS [cod_p++] FROM Persoane;

SELECT * FROM Persoane;

SELECT * FROM Persoane WHERE localitate IS NOT NULL;
--afisam persoanele care au numele Pop sau Ion
SELECT * FROM Persoane WHERE nume IN ('Pop', 'Ion');
SELECT * FROM Persoane WHERE nume = 'Pop' OR nume = 'Ion';

--relatie one to many
CREATE TABLE Categorii
(cod_c INT PRIMARY KEY IDENTITY,
nume VARCHAR(100)
);
CREATE TABLE Produse
(cod_p INT PRIMARY KEY IDENTITY,
denumire VARCHAR(100),
pret FLOAT,
cod_c INT FOREIGN KEY REFERENCES Categorii(cod_c)
);

INSERT INTO Categorii (nume) VALUES ('mancare'), ('bautura'), ('haine'), ('carti');
INSERT INTO Produse(denumire, pret, cod_c) VALUES ('lava cake', 19, 1),
('tiramisu',20,1), ('burger',23,1), ('cola',5,2), ('apa plata',4.5,2),
('rochie', 140, 3), ('buchet de trandafiri', 200, NULL);

SELECT * FROM Categorii;
SELECT * FROM Produse;
--apar doar inregistrarile care au potrivire in celalalt tabel
SELECT * FROM Categorii C INNER JOIN Produse P ON C.cod_c=P.cod_c;
--apar toate inregistrarile din tabelul din partea stanga, indiferent daca au 
--sau nu potriviri in tabelul din partea dreapta
SELECT * FROM Categorii C LEFT JOIN Produse P ON C.cod_c=P.cod_c;
--apar toate inregistrarile din tabelul din partea dreapta, indiferent daca au 
--sau nu potriviri in tabelul din partea stanga
SELECT * FROM Categorii C RIGHT JOIN Produse P ON C.cod_c=P.cod_c;
--apar toate inregistrarile din cele doua tabele, chiar daca nu au potriviri
--in celalalt tabel
SELECT * FROM Categorii C FULL JOIN Produse P ON C.cod_c=P.cod_c;

--pentru fiecare cod_c se afiseaza numarul produselor si suma acestora
SELECT cod_c, COUNT(cod_p) AS [nr_produse], SUM(pret) AS [pret total categorie]
FROM Produse
GROUP BY cod_c;
--pentru fiecare cod_c se afiseaza numarul produselor si suma acestora pentru
-- toate valorile cod_c care au numarul produselor > 1
SELECT cod_c, COUNT(cod_p) AS [nr_produse], SUM(pret) AS [pret total categorie]
FROM Produse
GROUP BY cod_c
HAVING COUNT(cod_p) > 1;

--afisam categoriile care au produse
SELECT nume FROM Categorii WHERE cod_c IN (SELECT cod_c FROM Produse);
--varianta cu JOIN
SELECT DISTINCT C.nume FROM Categorii C INNER JOIN Produse P ON C.cod_c=P.cod_c;
--varianta cu EXISTS
SELECT C.nume FROM Categorii C WHERE EXISTS(SELECT * FROM Produse P
WHERE C.cod_c=P.cod_c);
--afisam categoriile care nu au produse
SELECT nume FROM Categorii WHERE cod_c NOT IN (SELECT cod_c FROM Produse
WHERE cod_c IS NOT NULL);
--varianta cu NOT EXISTS
SELECT C.nume FROM Categorii C WHERE NOT EXISTS(SELECT * FROM Produse P
WHERE C.cod_c=P.cod_c);
--varianta cu EXCEPT
SELECT nume FROM Categorii
EXCEPT
SELECT C.nume FROM Categorii C INNER JOIN Produse P ON C.cod_c=P.cod_c;
