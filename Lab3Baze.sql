use master
if exists(select name from sys.databases where name = 'spital')
	drop database spital
create database spital
go
use spital

create table medici(
	id smallint primary key,
	nume varchar(30),
	prenume varchar(30),
	adresa varchar(200)
);
go

create table pacienti(
	id smallint primary key identity(1,1),
	nume varchar(30),
	prenume varchar(30),
	adresa varchar(200)
);
go

create table programari(
	id smallint primary key,
	data_programarii datetime,
	id_medic smallint foreign key references medici(id) on update no action on delete no action,
	id_pacient smallint foreign key references medici(id) on update cascade on delete cascade
);
go

create table carti_autori(
	id_medic smallint foreign key references medici(id) on update no action on delete no action,
	id_pacient smallint foreign key references medici(id) on update cascade on delete cascade,
	primary key(id_medic, id_pacient)
);
