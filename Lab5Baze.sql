CREATE DATABASE Lab5Baze;
GO
USE Lab5Baze;

--creare de tabele
CREATE TABLE Parinti
(cod_p INT PRIMARY KEY IDENTITY,
nume VARCHAR(100),
prenume VARCHAR(100),
telefon SMALLINT,
adresa VARCHAR(250)
);
INSERT INTO Parinti(nume, prenume, telefon, adresa) VALUES
('Pop', 'Adina', 0727339123, 'Oradea'), ('Pop','Mihai',0755091463,'Cluj-Napoca'),
('Pop', 'Andrei', 0778153920, 'Floresti'),('Popescu','Mihai', 0749274020, 'Brasov'),
('Ion','Ana', 0736305382, 'Sibiu'), ('Negru', 'Maria',NULL, NULL);

SELECT * FROM Parinti

ALTER TABLE Parinti
ALTER COLUMN telefon INT;

GO
CREATE TABLE Elevi
(cod_e INT PRIMARY KEY IDENTITY,
nume VARCHAR(100),
prenume VARCHAR(100),
varsta SMALLINT,
cod_p INT FOREIGN KEY REFERENCES Parinti(cod_p),
cod_g INT FOREIGN KEY REFERENCES Grupe(cod_g),
cod_prov INT FOREIGN KEY REFERENCES Provenienta(cod_prov)
);
INSERT INTO Elevi(nume, prenume, varsta, cod_p, cod_g, cod_prov) VALUES
('Pop', 'Adelin', 7, 4, 1, 1), ('Pop','Mihaela',10, 5, 1, 3),
('Pop', 'Andreea', 8, 6, 1, 2),('Popescu','Maria', 6, 7, 2, 4),
('Ion','Cristina', 5, 8, 2, 3), ('Negru', 'Andrei', 7, 9, 2, 2);

GO
CREATE TABLE Provenienta
(cod_prov INT PRIMARY KEY IDENTITY,
descriere VARCHAR(500)
);
INSERT INTO Provenienta(descriere) VALUES
('facebook'), ('scoala'), ('parinti'), ('pliante');


GO
CREATE TABLE Grupe
(cod_g INT PRIMARY KEY IDENTITY,
numar INT
);
INSERT INTO Grupe(numar) VALUES
(1), (2), (3), (4), (5);
SELECT * FROM Grupe

GO
CREATE TABLE Ore
(cod_o INT PRIMARY KEY IDENTITY,
ora INT,
cod_g INT FOREIGN KEY REFERENCES Grupe(cod_g)
);
INSERT INTO Ore(ora, cod_g) VALUES
(10, 1),(12, 2),(14, 3),(16, 4),(18, 5);
SELECT * FROM Ore

GO
CREATE TABLE RelatieProfesoriGrupe
(cod_prof INT,
cod_g INT,
PRIMARY KEY(cod_prof, cod_g)
);

ALTER TABLE RelatieProfesoriGrupe
ADD FOREIGN KEY (cod_prof) REFERENCES Profesori(cod_prof);
ALTER TABLE RelatieProfesoriGrupe
ADD FOREIGN KEY (cod_g) REFERENCES Grupe(cod_g);

INSERT INTO RelatieProfesoriGrupe(cod_prof, cod_g) VALUES
(1,1),(1,2),(2,2),(3,2)
INSERT INTO RelatieProfesoriGrupe(cod_prof, cod_g) VALUES
(3,1),(4,1),(4,2)
INSERT INTO RelatieProfesoriGrupe(cod_prof, cod_g) VALUES
(4,3)

GO
CREATE TABLE Profesori
(cod_prof INT PRIMARY KEY IDENTITY,
nume VARCHAR(100),
prenume VARCHAR(100),
telefon INT,
adresa VARCHAR(500)
);
INSERT INTO Profesori(nume, prenume, telefon, adresa) VALUES
('Popescu', 'Elena', 0748392468, 'Constanta'), ('Enache','Carla',0768273017,'Constanta'),
('Popa', 'Madalin', 0757381920, 'Cluj-Napoca'),('Enescu','Anda', 0760371930, 'Tulcea');

GO
CREATE TABLE RelatieProfesoriCursuri
(cod_prof INT,
cod_c INT,
PRIMARY KEY(cod_prof, cod_c),
FOREIGN KEY (cod_prof) REFERENCES Profesori(cod_prof),
FOREIGN KEY (cod_c) REFERENCES Cursuri(cod_c)
);

GO
CREATE TABLE Cursuri
(cod_c INT PRIMARY KEY IDENTITY,
denumire VARCHAR(250),
cod_s INT FOREIGN KEY REFERENCES Sali(cod_s),
cod_m INT FOREIGN KEY REFERENCES Materiale(cod_m)
);
INSERT INTO Cursuri(denumire, cod_s, cod_m) VALUES
('Engleza Incepatori',1, 3),('Engleza Avansati', 2, 4),('Engleza Experimentati', 3, 2);
SELECT * FROM Cursuri;

GO
CREATE TABLE Sali
(cod_s INT PRIMARY KEY IDENTITY,
numar SMALLINT
);
INSERT INTO Sali(numar) VALUES
(1), (2), (3), (4), (5);

GO
CREATE TABLE Materiale
(cod_m INT PRIMARY KEY IDENTITY,
denumire VARCHAR(250),
cod_pret INT FOREIGN KEY REFERENCES Preturi(cod_pret)
);
INSERT INTO Materiale(denumire, cod_pret) VALUES
('marker', 5),('tableta', 2),('karaoke', 3),('manuale', 1),('pixuri', 4);
SELECT * FROM Materiale

GO
CREATE TABLE Preturi
(cod_pret INT PRIMARY KEY IDENTITY,
suma INT
);

--1.Ce cursuri costa mai mult de 100 de lei
--m-m, mai mult de 2 tabele, distinct, group by, having
SELECT DISTINCT C.denumire, P.suma
FROM Cursuri C
JOIN Materiale M ON M.cod_m = C.cod_m
INNER JOIN Preturi P ON P.cod_pret = M.cod_pret
GROUP BY C.denumire, P.suma
HAVING P.suma>100;

--2.Ce profesori predau la grupa nr 2
--m-m, mai mult de 2 tabele, distinct, where, group by, having
SELECT DISTINCT P.nume, P.prenume, G.numar
FROM Profesori P
JOIN RelatieProfesoriGrupe R ON P.cod_prof = R.cod_prof
INNER JOIN Grupe G ON G.cod_g = R.cod_g
WHERE R.cod_g >1 AND G.numar = 2 --WHERE se executa inainte de grupare
GROUP BY P.nume, P.prenume, G.numar
--HAVING G.numar = 2;

--3.Fiecare curs, in cate sali se realizeaza
--where, group by, having
SELECT cod_c, COUNT(cod_s) AS[nr_sali]
FROM Cursuri 
GROUP BY cod_c
HAVING COUNT(cod_s) >0;

--4.Ce grupe au aflat de centru de la scoala
--mai mult de 2 tabele, where
SELECT G.numar, P.descriere
FROM Grupe G
JOIN Elevi E ON G.cod_g = E.cod_g
INNER JOIN Provenienta P ON P.cod_prov = E.cod_prov
WHERE P.descriere = 'scoala';

--5.Ce profesor preda la ora 14
--mai mult de 2 tabele, where
SELECT P.nume, P.prenume
FROM Profesori P
JOIN RelatieProfesoriGrupe R ON P.cod_prof = R.cod_prof
INNER JOIN Grupe G ON G.cod_g = R.cod_g
INNER JOIN Ore O ON O.cod_g = G.cod_g
WHERE O.ora = 14;

--6.Ce parinti isi au copiii in grupa 2
--mai mult de 2 tabele, where
SELECT P.nume, P.prenume
FROM Parinti P
JOIN Elevi E ON P.cod_p = E.cod_p
INNER JOIN Grupe G ON G.cod_g = E.cod_g
WHERE G.numar = 2;

--7.Ce profesori predau Engleza Incepatori la ce grupe
--mai mult de 2 tabele
SELECT DISTINCT G.numar, C.denumire, P.nume
FROM Grupe G
JOIN RelatieProfesoriGrupe RPG ON RPG.cod_g = G.cod_g
INNER JOIN Profesori P ON P.cod_prof = RPG.cod_prof
INNER JOIN RelatieProfesoriCursuri RPC ON RPC.cod_prof =P.cod_prof
INNER JOIN Cursuri C ON C.cod_c = RPC.cod_c
WHERE denumire = 'Engleza Incepatori';

--8.Ce profesori predau ce curs in sala 2
--mai mult de 2 tabele
SELECT P.nume, P.prenume, C.denumire
FROM Profesori P
JOIN RelatieProfesoriCursuri RPG ON P.cod_prof = RPG.cod_prof
INNER JOIN Cursuri C ON C.cod_c = RPG.cod_c
INNER JOIN Sali S ON S.cod_s = C.cod_s
WHERE S.numar = 2;

--9.Elevii ai carui parinte nu au adresa introdusa
SELECT nume, prenume, adresa FROM Parinti WHERE cod_p IN(SELECT cod_p From Elevi
WHERE adresa IS NULL);

--10.Elevii care au aflat de centru de pe facebook si eu mai putin de 8 ani
SELECT E.nume, E.prenume
FROM Elevi E 
JOIN Provenienta P ON E.cod_prov = P.cod_prov
WHERE P.descriere = 'facebook'
GROUP BY E.nume, E.prenume
HAVING SUM(E.varsta) < 8;