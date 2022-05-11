CREATE DATABASE MagazinZoo;
GO
--USE se foloseste pentru a ne conecta la o baza de date
USE MagazinZoo;
/*comentariu
pe mai multe linii*/
CREATE TABLE Animale
(cod_a INT PRIMARY KEY IDENTITY, -- IDENTITY se foloseste pentru a genera in mod automat valori pentru coloana cod_a
nume VARCHAR(100),
specie VARCHAR(140),
pret FLOAT,
data_nasterii DATE
);
--adaugarea unei coloane in tabelul Animale
ALTER TABLE Animale
ADD nr_picioare INT;
--schimbarea tipului de date ale unei coloane
ALTER TABLE Animale
ALTER COLUMN pret INT;
--stergerea unei coloane din tabelul Animale
ALTER TABLE Animale
DROP COLUMN pret;
--stergerea tabelului Animale
DROP TABLE Animale;
--modificarea numelui bazei de date
ALTER DATABASE MagazinZoo
MODIFY Name=AccesoriiAnimale;
--stergerea bazei de date
USE master;
DROP DATABASE AccesoriiAnimale
--Relatie many to many
CREATE DATABASE Biblioteca224;
GO
USE Biblioteca224;
CREATE TABLE Carti
(cod_c INT PRIMARY KEY IDENTITY,
titlu VARCHAR(100),
an_aparitie INT,
nr_pagini INT
);
CREATE TABLE Autori
(cod_a INT PRIMARY KEY IDENTITY,
nume VARCHAR(200),
data_nasterii DATE
);
--tabel de legatura
CREATE TABLE CartiAutori
(cod_c INT FOREIGN KEY REFERENCES Carti(cod_c),
cod_a INT FOREIGN KEY REFERENCES Autori(cod_a),
CONSTRAINT pk_CartiAutori PRIMARY KEY(cod_c, cod_a)
);

