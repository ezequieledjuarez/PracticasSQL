create schema if not exists atletismo;
use atletismo;

create table pais (
codigo varchar (3) primary key,
nombre varchar (30)
);
create table deportista (
codigo varchar (40) primary key,
nombre varchar (20),
apellido varchar (30),
deportista_codigo varchar (3),
foreign key (deportista_codigo)
references pais(codigo)
);
create table deporte(
codigo varchar (3) primary key,
nombre varchar (40)
);
create table practicar (
practicar_codigoDeportista varchar(40),
practicar_codigoDeporte varchar (3),
primary key (practicar_codigoDeportista, practicar_codigoDeporte),
foreign key (practicar_codigoDeportista)
references deportista(codigo),
foreign key (practicar_codigoDeporte)
references deporte(codigo)
);

insert into pais values('JAM','Jamaica');
insert into pais values('ESP','España');
insert into pais values('USA','Estados Unidos de America');
insert into pais values('AUS','Australia');
insert into pais values('RUS','Rusia');
insert into pais values ('UK','Reino Unido');
insert into deportista values ('BOL','Usain','Bolt','JAM');
insert into deportista values('POW','Asafa','Powell','JAM');
insert into deportista values('CRA','Saul','Craviotto','ESP');
insert into deportista values('TAU','Diana','Taurasi','USA');
insert into deportista values('PHE','Michael','Phelps','USA');
insert into deportista values('MUR','Andy','Murray','UK');
insert into deporte values('ATL','Atletismo');
insert into deporte values('REM','Remo');
insert into deporte values('BAL','Baloncesto');
insert into deporte values('NAT','Natacion');
insert into deporte values('BAD','Badminton');
insert into practicar values('BOL','ATL');
insert into practicar values('CRA','REM');
insert into practicar values('TAU','BAL');
insert into practicar values('PHE','NAT');

select*from deporte;
select*from deportista;
select*from pais;
select*from practicar;
-- 1)Muestra los nombres y apellidos de todos los deportistas, junto al nombre del país al que pertenecen.
select
d.nombre,
d.apellido,
p.nombre
from deportista d inner join pais p
on d.deportista_codigo = p.codigo;
-- 2)Muestra los nombres y apellidos de todos los deportistas, junto al nombre del país al que pertenecen, en caso de que dicho país aparezca en la base de datos. También se deben mostrar los datos de los deportistas cuyo país no se haya introducido aún.
select d.nombre,
d.apellido,
p.nombre
from deportista d right join pais p
on d.deportista_codigo = p.codigo;
-- 3)Muestra los nombres de todos los países, junto a los apellidos de los deportistas de ese país. Deben aparecer también los países de los que no conozcamos ningún deportista.
select p.nombre,
d.nombre,
d.apellido
from deportista d right join pais p 
on d.deportista_codigo = p.codigo;
-- 4)Muestra los nombres y apellidos de todos los deportistas, junto al nombre del deporte que practican (sólo aquellos de los que tengamos constancia que realmente practican algún deporte).
select 
d.nombre,
d.apellido,
de.nombre
from practicar p inner join deportista d
on p.practicar_codigoDeportista = d.codigo
inner join deporte de on
p.practicar_codigoDeporte = de.codigo;
 
-- 5 Muestra los nombres y apellidos de todos los deportistas, junto al nombre del deporte que practican (incluso los que no sepamos cuál es su deporte).
-- 6 Muestra el nombre de todos los deportes, junto con los nombres y apellidos de los deportistas que lo practican (incluso si para algún deporte aún no hemos introducido ningún deportista).


 


