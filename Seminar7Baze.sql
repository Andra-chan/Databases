create database Seminar7
go
use Seminar7
go
create table Programari_medic(
cod int primary key identity,
nume_medic varchar(100),
nume_pacient varchar(100),
sectie varchar(100),
nr_sala int,
data_programarii date);

insert into Programari_medic(nume_medic, nume_pacient, sectie, nr_sala, data_programarii) values 
('medic1', 'pacient1', 'sectie1', 1, '2022-01-14'),
('medic2', 'pacient2', 'sectie2', 2, '2022-01-11'),
('medic3', 'pacient3', 'sectie3', NULL, '2022-01-18')

select cod, nume_medic, nume_pacient, sectie, nr_sala, denumire_sala = CASE
nr_sala
when 1 then 'Prima sala'
when 2 then 'A doua sala'
else 'Nespecificat'
end from Programari_medic

select cod, nume_medic, nume_pacient, sectie, nr_sala, data_programarii = CASE
when data_programarii < '2022-01-12' then 'programare relativ veche'
when data_programarii between '2022-01-12' and '2022-01-14' THEN 'programare recenta'
when data_programarii IS NULL THEN 'programare  care nu are data'
else 'programare noua'
end from Programari_medic
