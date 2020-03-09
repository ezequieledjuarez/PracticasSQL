-- Tp Anual, integrantes Fontan Julio, Juarez Ezequiel, Juarez Walter, Longo Martín, Ovejero Nahuel.
create schema if not exists terminal_automotriz;
use terminal_automotriz;

create table modelo (
id_modelo varchar(10) not null,
nombre varchar (45),
primary key(id_modelo)
);

create table linea_montaje(
id_linea int not null,
codigo_estacion varchar(5),
primary key (id_linea)
);

create table tarea(
id_tarea int not null,
nombre varchar (45),
primary key(id_tarea)
);

create table estacion_trabajo(
id_estacion varchar(10) not null,
estacion_idtarea int not null,
estacion_idlinea int not null,
primary key (id_estacion),
foreign key (estacion_idtarea)
	references tarea(id_tarea),
foreign key (estacion_idlinea)
references linea_montaje(id_linea)
);

create table insumo(
codigo varchar(10) not null,
nombre varchar (45),
descripcion varchar (255),
precio decimal (8,2),
primary key (codigo)
);

create table calle(
id_calle int not null,
nombre varchar (45),
primary key (id_calle)
);

create table localidad(
id_localidad int not null,
nombre varchar (45),
primary key (id_localidad)
);

create table provincia (
id_provincia int not null,
nombre varchar (45),
primary key (id_provincia)
);

create table domicilio (
id_domicilio int not null,
domicilio_id_calle int,
domicilio_id_localidad int,
domicilio_id_provincia int,
primary key (id_domicilio),
foreign key (domicilio_id_calle)
references calle(id_calle),
foreign key (domicilio_id_localidad)
references localidad(id_localidad),
foreign key (domicilio_id_provincia)
references provincia(id_provincia)
);

create table concesionaria(
codigo varchar (10) not null,
ventas_realizadas int,
concesionaria_id_domicilio int,
primary key (codigo),
foreign key (concesionaria_id_domicilio)
	references domicilio(id_domicilio)
);

create table proveedor(
id_proveedor varchar(10),
nombre_proveedor varchar (45),
proveedor_id_domicilio int,
primary key (id_proveedor),
foreign key (proveedor_id_domicilio)
references domicilio(id_domicilio)
);

create table pedido(
id_pedido varchar (10) not null,
cantidad int,
concesionaria_pedido varchar (10),
fecha_pedido datetime,
primary key (id_pedido),
foreign key (concesionaria_pedido) 
references concesionaria(codigo)
);


create table modelos_pedidos(
pedido_id_pedido varchar (10),
pedido_id_modelo varchar (15),
primary key (pedido_id_pedido, pedido_id_modelo),
foreign key (pedido_id_pedido)
references pedido(id_pedido),
foreign key (pedido_id_modelo)
references modelo(id_modelo)
);

create table automovil (
numero_chasis varchar(45) not null,
auto_id_modelo varchar(10),
linea_montaje_id_linea int,
auto_pedido varchar(45),
primary key (numero_chasis),
foreign key (linea_montaje_id_linea)
references linea_montaje(id_linea),
foreign key (auto_id_modelo)
references  modelo(id_modelo),
foreign key (auto_pedido)
references pedido(id_pedido)
);
create table orden_tarea(
fecha_ingreso datetime,
fecha_egreso datetime,
tipo_tarea int not null,
orden_estacion varchar(10),
chasis_auto varchar (45),
primary key (orden_estacion, chasis_auto),
foreign key (tipo_tarea)
references tarea(id_tarea),
foreign key (orden_estacion)
references estacion_trabajo(id_estacion),
foreign key (chasis_auto)
references automovil(numero_chasis)
);

create table insumo_estacion(
id_insumo_estacion int not null,
codigo_insumo varchar(10),
codigo_id_estacion varchar(10),
cantidad int,
codigo_id_linea int,
primary key (id_insumo_estacion),
foreign key (codigo_insumo)
references insumo(codigo),
foreign key (codigo_id_estacion)
references estacion_trabajo (id_estacion),
foreign key (codigo_id_linea)
references linea_montaje(id_linea)
);

create table insumo_proveedor(
codigo_insumo varchar(10),
codigo_proveedor varchar(10),
primary key (codigo_insumo, codigo_proveedor),
foreign key (codigo_insumo)
references insumo(codigo),
foreign key (codigo_proveedor)
references proveedor(id_proveedor)
);


insert into modelo values
("1","Volt"),
("2","Bolt-EV");

insert into linea_montaje values
(1,"VO1"),
(2,"BO2");

insert into provincia values
(1,"Buenos Aires"),
(2,"Santa Fe"),
(3,"Entre Ríos");

insert into localidad values
(1,"Lanús"),
(2,"Lomas de Zamora"),
(3,"Avellaneda"),
(4,"Rivadavia"),
(5,"Sunchales"),
(6,"Colón"),
(7,"Villa Elisa");

insert into calle values
(1,"Hipolito Yrigoyen"), -- Lanus
(2,"9 de Julio"), -- Lanus
(3,"Laprida"), -- Lomas
(4,"Boedo"), -- Lomas
(5,"Mitre"), -- Avellaneda
(6,"Irigoyen Freire"), -- Rivadavia
(7,"Primera Junta"), -- Rivadavia
(8,"Juan de Garay"), -- Sunchales
(9,"Rocamora"), -- Colon
(10,"Chacabuco"), -- Villa Elisa
(11,"Cepeda"); -- Villa Elisa

insert into domicilio values
(1,1,1,1),
(2,2,1,1),
(3,3,2,1),
(4,4,2,1),
(5,5,3,1),
(6,6,4,2),
(7,7,4,2),
(8,8,5,2),
(9,9,6,3),
(10,10,7,3),
(11,11,7,3);

insert into concesionaria values
("CH1",3,2),
("CH2",2,7),
("CH3",1,11),
("CH4",9,10);

insert into pedido values
("014",6,"CH1","2019-10-30"),
("015",4,"CH1","2019-11-4"),
("031","8","CH2","2019-12-8"),
("032",4,"CH2","2019-10-20"),
("018",1,"CH3","2019-11-15"),
("019",3,"CH3","2019-12-8");

insert into modelos_pedidos values
("014","1"),
("015","2"),
("031","2"),
("032","2"),
("018","1"),
("019","1");

insert into automovil values
("123ABC",1,1,"018"),

("234CDE",1,1,"019"),
("345EFG",1,1,"019"),
("456FGH",1,1,"019"),

("112PQR",1,1,"014"),
("113PQR",1,null,"014"),
("114PQR",1,null,"014"),
("115PQR",1,null,"014"),
("116PQR",1,null,"014"),
("117PQR",1,null,"014"),

("567HIJ",2,2,"032"),
("678IJK",2,2,"032"),
("789JKL",2,2,"032"),
("890LMN",2,2,"032"),

("012MNO",2,2,"015"),
("021MNO",2,null,"015"),
("210MNO",2,null,"015"),
("120MNO",2,null,"015"),

("098MNO",2,null,"031"),
("987MNO",2,null,"031"),
("876MNO",2,null,"031"),
("765MNO",2,null,"031"),
("654MNO",2,null,"031"),
("432MNO",2,null,"031"),
("999MNO",2,null,"031"),
("111MNO",2,null,"031");




insert into tarea values
(1, "chasis"),
(2, "pintura"),
(3, "Tren delantero y trasero"),
(4, "lectricidad"),
(5, "motorizacion y banco de prueba");

insert into estacion_trabajo values	
("V1",1,1),
("V2",2,1),
("V3",3,1),
("V4",4,1),
("V5",5,1),
("B1",1,1),
("B2",2,2), 
("B3",3,2),
("B4",4,2),
("B5",5,2); 


insert into orden_tarea values
('2020/11/5''08:00','2020/11/7',1, "V1", "112PQR"),
('2020/11/7',null, 2,"V2","112PQR" ),
('2020/11/2''08:00','2020/11/4', 1,"V1","123ABC" ),
('2020/11/4','2020/11/6', 2,"V2","123ABC"),
('2020/11/7',null, 3,"V3","123ABC"),
('2020/10/28''08:00','2020/11/1',	1,"V1","234CDE"),
('2020/11/2','2020/11/4', 2,"V2","234CDE"),
('2020/5/11','2020/11/16',	3,"V3","234CDE"),
('2020/11/16','2020/11/21', 4,"V4","234CDE"),
('2020/11/21','2020/11/28', 5,"V5","234CDE"),
('2020/10/25''08:00','2020/10/26', 1,"V1","345EFG"),
('2020/10/27','2020/10/30', 2,"V2","345EFG"),
('2020/11/11','2020/11/4',	3,"V3","345EFG"),
('2020/11/4','2020/11/11', 4,"V4","345EFG"),
('2020/11/12','2020/11/19', 5,"V5","345EFG"),
('2020/10/22''12:00','2020/10/24', 1,"V1","456FGH"),
('2020/10/24','2020/10/27', 2,"V2","456FGH"),
('2020/10/27','2020/10/30', 3,"V3","456FGH"),
('2020/10/30','2020/11/3', 4,"V4","456FGH"),
('2020/11/4','2020/11/11', 5,"V5","456FGH"),
('2020/11/2''06:00','2020/11/3', 1,"B1","567HIJ"),
('2020/10/28','2020/11/30', 1,"B1","678IJK"),
('2020/11/1','2020/11/4', 2,"B2","678IJK"),
('2020/5/11','2020/10/11', 3,"B3","678IJK"),
('2020/11/11','2020/11/19', 4,"B4","678IJK"),
('2020/11/20','2020/11/30', 5,"B5","678IJK" ),
('2020/10/25''08:00','2020/10/26', 1,"B1","789JKL"),
('2020/10/27','2020/11/1', 2,"B2","789JKL"),
('2020/11/1','2020/11/4', 3,"B3","789JKL"),
('2020/11/11','2020/11/15', 4,"B4","789JKL"),
('2020/11/15','2020/11/21', 5,"B5","789JKL"),
('2020/10/22''08:00','2020/10/24', 1,"B1","890LMN"),
('2020/10/24','2020/10/26', 2,"B2","890LMN"),
('2020/10/27','2020/11/1', 3,"B3","890LMN"),
('2020/11/1', '2020/11/10', 4,"B4","890LMN"),
('2020/11/10','2020/11/11', 5,"B5","890LMN"),
('2020/10/3''14:00','2020/10/4', 1,"B1","012MNO"),
('2020/10/4','2020/10/7', 2,"B2","012MNO"),
('2020/10/7','2020/10/10', 3,"B3","012MNO"),
('2020/10/11','2020/10/15', 4,"B4","012MNO"),	
('2020/10/15','2020/10/22', 5,"B5","012MNO");
insert into insumo values
("A1", "Fibra de Carbono",	"Carrocería ligera", 150),
("A2","Acero","Puertas, techos y paneles",1000),
("A3", "Hule",	"Gomas marca Piedra de Fuego", 1500),
("A4", "Vidrio" , "Vidrio tipo transparente", 250),
("B1", "Aluminio", "Infraestructura liviana" ,20000),
("B2", "Plástico",	"Manijas, tapetes",125),
("B3",	"Hule", "Gomas marca Puente de Piedra", 1400),
("B4",	"Vidrio Polarizado","Vidrio tipo polarizado",450),
("C1",	"Wash", "Pimer Mejora la adherencia en superficies no ferrosas"	,200),
("C2",	"Clasicas Pro", "Pintura de color",150),
("C3",	"Gravedad","Acrilica",215),
("C4",	"Chavo","Poliuretano",300),
("D1",	"Aceite de linaza","Disolvente"	,50),
("D2",	"Masi","Pintura base agua", 220),
("D3",	"CrepuscuLatex",	"Pintura mate"	,500),
("D4",	"Abrigo de piel",	"Pintura metalizada"	,750),
("E1",	"Semieje","Transmisiòn mecànica",2000),
("E2",	"Extremo","Pivot entre la transmisiòn y la masa de rueda",5000),
("E3",	"Barra estabilizadora",	"Equilibra la diferencia de pesos",3500),
("E4",	"Homocinetica",	"Encargada de articular el semieje",4000),
("F1",	"Parrilla de suspensión"	,"Tipo boomerang",12000),
("F2",	"Rotula", "Enlace entre los movimientos de direccion, suspension y el movimiento direccional de las ruedas",2000),
("F3",	"Cazoleta", "Contribuye a la direccionalidad del vehiculo",2500),
("F4",	"Cremallera", "Sostiene el espiral y a la vez filtra las vibraciones del conjunto de suspensión con respecto a la carrocería",1250),
("G1",	"Controlador", "Comprueba el correcto funcionamiento",15),
("G2",	"Caja de fusibles", "Forma parte de la seguridad electrica",7500),
("G3",	"Batería", "Provee electricidad al auto",3000),
("G4",	"Motor de Arranque", "Motor electrico que mantiene el motor alimentado",18000),
("H1",	"Calefactor","Provee calefaccion al auto",900),
("H2",	"Alternador","Mantiene la baterìa cargada",500),
("H3",	"Distibuidor","Eje electromecanico encargado de llevar voltaje a la bujìas",1275),
("H4",	"Faro", "Iluminaciòn",100),
("I1",	"Base de motores", "Base de motores", 4200),
("I2",	"Consola de comando y control",	"Consola de comando y control",30000),
("I3",	"Intercambiador de mezcla de calor", "Intercambiador de mezcla de calor",3900),
("I4",	"Motor asìncrono","Motor de induccion de corriente alterna",5500),
("J1",	"Dinas",	"Dinanometros",3000),
("J2", "Cargador embarcado", "Absorbe la electricidad de forma alterna directamente desde la red externa y la transforma en corriente continua", 1240),
("J3",	"Batería", "Almacena la electricidad del auto", 2000),
("J4", "Convert", "Convertidor", 5000);

insert into proveedor values
("A1","Pintureria Max",1),
("B1","Chasis Perez",3),
("B2","Class Auto",4),
("B3","Recicladora Dorrego",5),
("B4","El Rey de la Goma",6),
("C1","Semi-Extremo",7),
("C2","Distribuidores Mendez",8),
("C3","Arrancadero",9),
("C4","Creca",10),
("D1","Full Electricos",9);



insert into insumo_estacion values
(1,"A1","V1",50,1),
(2,"A2","V1",48,1),
(3,"A3","V1",25,1),
(4,"A4","V1",10,1),
(5,"B1","B1",45,2),
(6,"A2","B1",52,2),
(7,"B2","B1",8,2),
(8,"B3","B1",35,2),
(9,"C1","V2",70,1),
(10,"C2","V2",65,1),
(11,"C3","V2",40,1),
(12,"C4","V2",35,1),
(13,"D1","B2",80,2),
(14,"D2","B2",40,2),
(15,"D3","B2",10,2),
(16,"C4","B2",16,2),
(17,"E1","V3",90,1),
(18,"E2","V3",20,1),
(19,"E3","V3",10,1),
(20,"E4","V3",10,1),
(21,"F1","B3",90,2),
(22,"F1","B3",20,2),
(23,"F3","B3",10,2),
(24,"F4","B3",10,2),
(25,"G1","V4",12,1),
(26,"G2","V4",8,1),
(27,"G3","V4",6,1),
(28,"G4","V4",20,1),
(29,"H1","B4",16,2),
(30,"H2","B4",16,2),
(31,"G3","B4",8,2),
(32,"H4","B4",10,2),
(33,"I1","V5",35,1),
(34,"I2","V5",20,1),
(35,"I3","V5",15,1),
(36,"I4","V5",10,1),
(37,"J1","B5",10,2),
(38,"J2","B5",30,2),
(39,"I3","B5",20,2),
(40,"J4","B5",16,2);

insert into insumo_proveedor( codigo_proveedor,codigo_insumo) values
("D1","G1"),
("D1","G2"),
("D1","G3"),
("D1","G4"),
("D1","H1"),
("D1","H2"),
("D1","H3"),
("D1","H4"),
("D1","I1"),
("D1","I2"),
("D1","I3"),
("D1","I4"),
("D1","J1"),
("D1","J2"),
("D1","J3"),

("C4","F3"),
("C4","F4"),

("C3","F1"),
("C3","F2"),
("C3","G2"),
("C3","G4"),

("C2","E3"),
("C2","E4"),
("C2","G1"),
("C2","G3"),

("C1","E1"),
("C1","E2"),

("B4","B3"),
("B4","A3"),

("B3","B1"),
("B3","B2"),

("B2","A3"),
("B2","A4"),
("B2","B1"),
("B2","B2"),

("B1","A1"),
("B1","A2"),
("B1","B3"),
("B1","B4"),

("A1","C1"),
("A1","C2"),
("A1","C3"),
("A1","C4"),
("A1","D1"),
("A1","D2"),
("A1","D3"),
("A1","D4"),
("A1","B4"),
("A1","B3");


-- 1). Listar cantidad mensual de automóviles fabricados discriminados por modelo, con el
-- objeto de analizar si es necesario agregar líneas de montaje para un modelo en
-- particular.
  select m.nombre,month(ot.fecha_egreso)as Mes,count(a.numero_chasis)as automoviles_fabricados from tarea t
inner join orden_tarea ot on t.id_tarea = ot.tipo_tarea
inner join automovil a on ot.chasis_auto = a.numero_chasis
inner join modelo m on a.auto_id_modelo = m.id_modelo
where ot.tipo_tarea = 5 and ot.fecha_egreso is not null
group by m.nombre, Mes;


-- 2) Listar cantidad mensual de automóviles pedidos discriminados por modelo y
 -- concesionaria solicitante.
 select* from pedido;
  select m.nombre,c.codigo,p.cantidad,month(ot.fecha_egreso)as Mes,count(a.numero_chasis)as automoviles_fabricados from tarea t
inner join orden_tarea ot on t.id_tarea = ot.tipo_tarea
inner join automovil a on ot.chasis_auto = a.numero_chasis
inner join modelo m on a.auto_id_modelo = m.id_modelo
inner join modelos_pedidos mp on m.id_modelo = mp.pedido_id_modelo
inner join pedido p on mp.pedido_id_pedido = p.id_pedido
inner join concesionaria c on p.concesionaria_pedido =c.codigo 
where ot.tipo_tarea = 5 and ot.fecha_egreso is not null
group by m.nombre, Mes,c.codigo,p.cantidad;

select sum(p.cantidad) as Cantidad_autos, p.concesionaria_pedido as Solicitante, 
month(p.fecha_pedido) as Mes_pedido, m.nombre as Modelo_pedido from pedido p
inner join modelos_pedidos mp on mp.pedido_id_pedido = id_pedido
inner join modelo m on m.id_modelo = mp.pedido_id_modelo
group by p.concesionaria_pedido,mp.pedido_id_modelo ;


-- 3). Emitir listados de concesionarios, indicando si han realizado pedidos alguna vez
select 'CODIGO DE CONCESIONARIAS' as lista , 
c.codigo from concesionaria c
union
select 'CONCESINARIA QUE HICIERON PEDIDOS',c.codigo from concesionaria c
where c.codigo in (select p.concesionaria_pedido from pedido p);

select codigo from concesionaria;
select p.concesionaria_pedido as Solicitante from pedido p where exists (
select concesionaria_pedido)
group by concesionaria_pedido;

select c.codigo from concesionaria c
where c.codigo in (select p.concesionaria_pedido from pedido p);
select c.codigo from concesionaria c
where c.codigo not in (select p.concesionaria_pedido from pedido p);
-- 4)Emitir listados de modelos.
select * from modelo;

-- 5).Emitir listado de automóviles, indicando número de chasis, modelo y fecha hora de
 -- entrada a fabricación.
 select a.numero_chasis, m.nombre, ot.fecha_ingreso from orden_tarea ot
 inner join automovil a on ot.chasis_auto = a.numero_chasis
 inner join modelo m on a.auto_id_modelo = m.id_modelo
 group by a.numero_chasis;
 
-- 6) Listado similar al anterior, indicando en qué estado se encuentra. Si aún no entró a
-- la línea de montaje el estado es “A fabricar”. Si se encuentra terminado, el estado es
-- “Terminado”. En cualquier otro caso, el estado es el nombre de la estación en la que
-- se encuentra.
 select 'TERMINADO' as estado, a.numero_chasis, m.nombre, ot.fecha_ingreso, ot.fecha_egreso from orden_tarea ot
 inner join automovil a on ot.chasis_auto = a.numero_chasis
 inner join modelo m on a.auto_id_modelo = m.id_modelo
 where ot.tipo_tarea = 5 and ot.fecha_egreso is not null
 union
 select t.nombre as ESTADO,a.numero_chasis, m.nombre, ot.fecha_ingreso, ot.fecha_egreso
 from  tarea t inner join orden_tarea ot on t.id_tarea = ot.tipo_tarea 
 inner join automovil a on ot.chasis_auto = a.numero_chasis
 inner join modelo m on a.auto_id_modelo = m.id_modelo
 where ot.tipo_tarea < 5 and ot.fecha_egreso is null;

-- 6) Listado similar al anterior, indicando en qué estado se encuentra. Si aún no entró a
-- la línea de montaje el estado es “A fabricar”. Si se encuentra terminado, el estado es
-- “Terminado”. En cualquier otro caso, el estado es el nombre de la estación en la que
-- se encuentra.
 
 select 'TERMINADO' as estado, a.numero_chasis,m.nombre, ot.fecha_ingreso, ot.fecha_egreso from orden_tarea ot
 inner join automovil a on ot.chasis_auto = a.numero_chasis
 inner join modelo m on a.auto_id_modelo = m.id_modelo
 where ot.tipo_tarea = 5 and ot.fecha_egreso is not null
 
 union
 
 select t.nombre as ESTADO,a.numero_chasis, m.nombre, ot.fecha_ingreso, ot.fecha_egreso
 from  tarea t inner join orden_tarea ot on t.id_tarea = ot.tipo_tarea 
 inner join automovil a on ot.chasis_auto = a.numero_chasis
 inner join modelo m on a.auto_id_modelo = m.id_modelo
 where ot.tipo_tarea < 5 and ot.fecha_egreso is null
 
 union
 
 select 'A FABRICAR' as ESTADO,a.numero_chasis, m.nombre, ot.fecha_ingreso, ot.fecha_egreso
 from orden_tarea ot right join automovil a on ot.chasis_auto = a.numero_chasis
 inner join modelo m on a.auto_id_modelo = m.id_modelo where 
 a.linea_montaje_id_linea is null;


-- 7) Listado similar al anterior, filtrado por pedido para el que se fabrican. Se debe
-- agregar el número de pedido al listado
  select 'TERMINADO' as estado, a.numero_chasis,a.auto_pedido as Pedido, m.nombre, ot.fecha_ingreso, ot.fecha_egreso from orden_tarea ot
 inner join automovil a on ot.chasis_auto = a.numero_chasis
 inner join modelo m on a.auto_id_modelo = m.id_modelo
 where ot.tipo_tarea = 5 and ot.fecha_egreso is not null
 union
 select t.nombre as ESTADO,a.numero_chasis,a.auto_pedido, m.nombre, ot.fecha_ingreso, ot.fecha_egreso
 from  tarea t inner join orden_tarea ot on t.id_tarea = ot.tipo_tarea 
 inner join automovil a on ot.chasis_auto = a.numero_chasis
 inner join modelo m on a.auto_id_modelo = m.id_modelo
 where ot.tipo_tarea < 5 and ot.fecha_egreso is null
 ;

select 'TERMINADO' as estado, a.numero_chasis,a.auto_pedido as Pedido, m.nombre, ot.fecha_ingreso, ot.fecha_egreso from orden_tarea ot
 inner join automovil a on ot.chasis_auto = a.numero_chasis
 inner join modelo m on a.auto_id_modelo = m.id_modelo
 where ot.tipo_tarea = 5 and ot.fecha_egreso is not null
 
 union
 
 select t.nombre as ESTADO,a.numero_chasis,a.auto_pedido, m.nombre, ot.fecha_ingreso, ot.fecha_egreso
 from  tarea t inner join orden_tarea ot on t.id_tarea = ot.tipo_tarea 
 inner join automovil a on ot.chasis_auto = a.numero_chasis
 inner join modelo m on a.auto_id_modelo = m.id_modelo
 where ot.tipo_tarea < 5 and ot.fecha_egreso is null
 
 union
 
 select 'a fabricar' as ESTADO,a.numero_chasis,a.auto_pedido, m.nombre, ot.fecha_ingreso, ot.fecha_egreso
 from orden_tarea ot right join automovil a on ot.chasis_auto = a.numero_chasis
 inner join modelo m on a.auto_id_modelo = m.id_modelo where 
 a.linea_montaje_id_linea is null;


-- 8) Listado similar al 4, filtrado por concesionaria para la que se fabrican. Se debe
-- agregar el nombre de concesionaria al listado
select c.codigo,m.nombre from concesionaria c
inner join pedido p on c.codigo = p.concesionaria_pedido
inner join modelos_pedidos mp on p.id_pedido = mp.pedido_id_pedido
inner join modelo m on mp.pedido_id_modelo = m.id_modelo
group by c.codigo, m.nombre;
-- 9) Emitir listado de compras necesarias para fabricar los automóviles pendientes (que
-- aún no hayan entrado a fabricación)

-- falta todo
select count(numero_chasis)*ie.cantidad as Sin_Terminar, a.auto_id_modelo from automovil a 
where a.linea_montaje_id_linea = all(select ie.codigo_id_linea from insumo_estacion ie);

select ie.cantidad,ie.codigo_id_estacion from insumo_estacion ie
inner join insumo i on ie.codigo_insumo = i.codigo
where ie.codigo_id_estacion like'V%'
union
select ie.cantidad ,codigo_id_estacion from insumo_estacion ie
inner join insumo i on ie.codigo_insumo = i.codigo
where ie.codigo_id_estacion like'B%';

select count(numero_chasis)*ie.cantidad as Faltante, i.nombre, lm.codigo_estacion from automovil a
inner join linea_montaje lm on a.linea_montaje_id_linea=lm.id_linea
inner join insumo_estacion ie on ie.codigo_id_linea = lm.id_linea
inner join insumo i on ie.codigo_insumo = i.codigo
group by lm.id_linea, i.codigo;

select count(numero_chasis)*ie.cantidad as Faltante, i.nombre, lm.codigo_estacion from automovil a
inner join linea_montaje lm on a.linea_montaje_id_linea=lm.id_linea
inner join insumo_estacion ie on ie.codigo_id_linea = lm.id_linea
inner join insumo i on ie.codigo_insumo = i.codigo
where lm.id_linea=1
group by lm.id_linea, i.codigo
union
select count(numero_chasis)*ie.cantidad as Faltante, i.nombre, lm.codigo_estacion from automovil a
inner join linea_montaje lm on a.linea_montaje_id_linea=lm.id_linea
inner join insumo_estacion ie on ie.codigo_id_linea = lm.id_linea
inner join insumo i on ie.codigo_insumo = i.codigo
where lm.id_linea=2
group by lm.id_linea, i.codigo;

-- 10) Emitir listados de pedidos pendientes (que no hayan entrado en la estación inicial o
-- que no hayan salido de la estación final), con detalle de los modelos faltantes y sus
-- cantidades. Los campos a listar son: número de pedido, modelo, cantidad faltante


select count(a.numero_chasis) as Faltante,p.id_pedido,m.nombre from orden_tarea ot
right join automovil a on ot.chasis_auto = a.numero_chasis
right join modelo m on a.auto_id_modelo = m.id_modelo
right join pedido p on a.auto_pedido = p.id_pedido
where a.linea_montaje_id_linea is null
group by p.id_pedido;

