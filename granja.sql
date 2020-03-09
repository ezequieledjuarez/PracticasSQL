create schema granja;
use granja;
-- compilar primer calle, localidad, provincia, domicilio y despues todo lo demas-- 
CREATE TABLE IF NOT EXISTS Calle (
    idCalle INT NOT NULL,
    nombre VARCHAR(45) NULL,
    PRIMARY KEY (idCalle)
);
  
CREATE TABLE IF NOT EXISTS Localidad (
    idLocalidad INT NOT NULL,
    nombre VARCHAR(45) NULL,
    PRIMARY KEY (idLocalidad)
);

CREATE TABLE IF NOT EXISTS Provincia (
    idProvincia INT NOT NULL,
    nombre VARCHAR(45) NULL,
    PRIMARY KEY (idProvincia)
);

CREATE TABLE IF NOT EXISTS Domicilio (
    id_domicilio INT NOT NULL,
    calle_idCalle INT NULL,
    numero VARCHAR(45) NULL,
    localidad_idLocalidad INT NULL,
    provincia_idProvincia INT NULL,
    FOREIGN KEY (calle_idCalle)
        REFERENCES Calle (idCalle),
    FOREIGN KEY (localidad_IdLocalidad)
        REFERENCES Localidad (idLocalidad),
    FOREIGN KEY (provincia_idProvincia)
        REFERENCES Provincia (idProvincia),
    PRIMARY KEY (id_domicilio)
);
   
CREATE TABLE IF NOT EXISTS Cabaña (
    codigo VARCHAR(45),
    razonSocial VARCHAR(45),
    domicilio INT,
    cuit VARCHAR(45),
    PRIMARY KEY (codigo),
    FOREIGN KEY (domicilio)
        REFERENCES Domicilio (id_domicilio)
);
CREATE TABLE IF NOT EXISTS genetica (
    codigo VARCHAR(45),
    nombre VARCHAR(45) NULL,
    codigo_cabaña VARCHAR(45) NULL,
    FOREIGN KEY (codigo_cabaña)
        REFERENCES cabaña (codigo),
    PRIMARY KEY (codigo)
);

CREATE TABLE IF NOT EXISTS Galpon (
    codigo INT PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS Plantel (
    codigo VARCHAR(45),
    nombre VARCHAR(45),
    edad INT,
    genetica_gallina VARCHAR(45),
    fecha_ingreso VARCHAR(45),
    cantidad INT,
    galpon_codigo INT,
    PRIMARY KEY (codigo),
    FOREIGN KEY (genetica_gallina)
        REFERENCES genetica (codigo),
    FOREIGN KEY (galpon_codigo)
        REFERENCES galpon (codigo)
);
  
CREATE TABLE plantel_x_galpon (
    codigo_galpon INT UNIQUE NOT NULL,
    codigo_plantel VARCHAR(45) NOT NULL,
    cantidad INT,
    PRIMARY KEY (codigo_galpon , codigo_plantel),
    FOREIGN KEY (codigo_galpon)
        REFERENCES galpon (codigo),
    FOREIGN KEY (codigo_plantel)
        REFERENCES plantel (codigo)
);

CREATE TABLE alimento (
    codigo INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(45)
);
  
CREATE TABLE IF NOT EXISTS Planilla (
    id_planilla INT NOT NULL,
    fecha DATETIME,
    codigo_galpon INT,
    produccion INT,
    mortandad INT,
    tipo_alimento INT(45),
    cantidad_alimento INT,
    FOREIGN KEY (tipo_alimento)
        REFERENCES alimento (codigo),
    PRIMARY KEY (id_planilla),
    FOREIGN KEY (codigo_galpon)
        REFERENCES galpon (codigo)
);
  
CREATE TABLE IF NOT EXISTS Producto (
    codigo VARCHAR(45),
    descripcion VARCHAR(45),
    precio DOUBLE,
    cant_huevos INT NULL,
    PRIMARY KEY (codigo)
);
CREATE TABLE IF NOT EXISTS Cliente (
    cuit VARCHAR(45) NOT NULL,
    razon_social VARCHAR(45) NULL,
    domicilio INT NULL,
    FOREIGN KEY (domicilio)
        REFERENCES domicilio (id_domicilio),
    PRIMARY KEY (cuit)
);
  
CREATE TABLE IF NOT EXISTS Factura (
    cod_factura INT AUTO_INCREMENT,
    numero_factura INT,
    fecha DATETIME NULL,
    cuit_cliente VARCHAR(45) NOT NULL,
    codigo_producto VARCHAR(45),
    cant_producto INT NULL,
    precio_producto DOUBLE NULL,
    FOREIGN KEY (cuit_cliente)
        REFERENCES cliente (cuit),
    FOREIGN KEY (codigo_producto)
        REFERENCES producto (codigo),
    PRIMARY KEY (cod_factura)
);
  
CREATE TABLE IF NOT EXISTS ProductoXCliente (
    codigo_producto VARCHAR(45),
    cuit_cliente VARCHAR(45) NOT NULL,
    PRIMARY KEY (cuit_cliente , codigo_producto),
    FOREIGN KEY (cuit_cliente)
        REFERENCES cliente (cuit),
    FOREIGN KEY (codigo_producto)
        REFERENCES producto (codigo)
);

insert into calle values (idCalle,nombre),
(1,"141"),
(2,"Ruta 2"),
(3,"Lujan"),
(4,"Mitre"),
(5,"Pampa"),
(6,"Gral Belgrano"),
(7,"29-sep");

insert into localidad values(idLocalidad,nombre),
(1,"City Bell"),
(2,"Abasto"),
(3,"Lanus"),
(4,"Avellaneda"),
(5,"Villa Elisa");

insert into provincia values (idProvincia,nombre),
(1,"Buenos Aires");

insert into domicilio values (id_domicilio,calle_idCalle,numero,localidad_idLocalidad,provincia_idProvincia),
(1,1,"373",1,1),
(2,2,"KM 45",2,1),
(3,3,"1234",3,1),
(4,4,"2345",4,1),
(5,5,"45",2,1),
(6,6,"10234",5,1),
(7,7,"2368",3,1);


insert into cabaña values (codigo,razonSocial,domicilio,cuit),
("1","Cabaña Camila SA",1,"30-12345678-9"),
("2","Cabaña Lohmann SRL",2,"30-11111111-7");

insert into genetica values (codigo, nombre, codigo_cabaña),
("LB1","Lohmann Brown B-36","1"),
("LW1","Lohmann White W-41","1"),
("CB1","Camila Brown 2789","2"),
("CW1", "Camila White 3456","2");

insert into galpon values (codigo),
(1),
(2),
(3),
(4);

insert into plantel values (codigo, nombre, edad, genetica_gallina, fecha_ingreso,cantidad, galpon_codigo),
("P2","Plantel 2",18,"LB1",2018-08-10,5000,1),
("P1","Plantel 1",20,"CB1",2018-08-10,1500,3),
("P3", "Plantel 3",18,"LW1",2018-08-10,3000,4);

insert into alimento (nombre) values
("F1"),
("F1B"),
("F1A");

insert into planilla values (id_planilla,fecha,codigo_galpon,produccion,mortandad,tipo_alimento,cantidad_alimento),
(1,'2018/08/10',1,1800,10,1,200),
(2,'2018/08/10',2,2600,20,2,300),
(3,'2018/08/10',3,1350,25,1,150),
(4,'2018/08/10',4,2500,15,3,300),
(5,'2018/08/11',1,1850,11,1,200),
(6,'2018/08/11',2,2500,19,2,300),
(7,'2018/08/11',3,1300,10,1,150),
(8,'2018/08/11',4,2600,13,3,300),
(9,'2018/08/12',1,1790,10,1,200),
(10,'2018/08/12',2,2400,20,2,300),
(11,'2018/08/12',3,1250,25,1,150),
(12,'2018/08/12',4,2400,15,3,300),
(13,'2018/08/13',1,1790,12,1,200),
(14,'2018/08/13',2,2400,5,2,300),
(15,'2018/08/13',3,1250,7,1,150),
(16,'2018/08/13',4,2400,9,3,300),
(17,'2018/08/14',1,2400,25,1,200),
(18,'2018/08/14',2,1790,11,2,200),
(19,'2018/08/14',3,2400,7,1,150),
(20,'2018/08/14',4,2500,10,1,300),
(21,'2018/08/14',1,2400,15,2,300),
(22,'2018/08/14',2,2600,20,1,200),
(23,'2018/08/14',3,1300,15,3,200),
(24,'2018/08/15',4,1250,19,2,300),
(25,'2018/08/15',1,2400,20,3,300),
(26,'2018/08/15',2,1850,19,3,150),
(27,'2018/08/15',3,2500,13,1,300),
(28,'2018/08/15',4,1790,5,1,300),
(29,'2018/08/15',1,1350,10,1,300),
(30,'2018/08/15',2,2600,10,2,300),
(31,'2018/08/15',3,1250,12,3,150),
(32,'2018/08/15',4,1800,25,1,150);

insert into producto values (codigo, descripcion,precio,cant_huevos),
("HCD","Docena Huevo Color",80,12),
("HBD","Docena Huevo Blanco",70,12),
("HCM","Maple Huevo Color",180,30),
("HBM","Maole Huevo Blanco",160,30),
("HBC2","Caja Media Docena Huevo Color",50,6),
("HBD2","Caja Media Docena Huevo Blanco",40,6);

insert into cliente values(cuit, razon_social,domicilio),
("20-11111111-1","Ernesto Fernandez",3),
("30-22222222-2","Avicola Santa Fe SRL",4),
("30-33333333-3","Avicola Romero SA",5),
("30-44444444-4","Granja San Martin SRL",6),
("20-22222222-9","José López",7);

insert into factura (numero_factura, fecha, cuit_cliente, codigo_producto, precio_producto, cant_producto) values
(1,'2018-8-10',"20-11111111-1","HBD",70,70),
(1,'2018-8-10',"20-11111111-1","HCM",180,70),
(2,'2018-8-10',"30-22222222-2","HCM",180,50),
(2,'2018-8-10',"30-22222222-2","HBM",160,20),
(2,'2018-8-10',"30-22222222-2","HBC2",50,100),
(2,'2018-8-10',"30-22222222-2","HBD2",40,20),
(3,'2018-8-11',"30-44444444-4","HBM",160,50),
(4,'2018-8-11',"20-22222222-9","HBC2",35,50),
(4,'2018-8-11',"20-22222222-9","HBD2",20,40),
(5,'2018-8-12',"30-33333333-3","HCD",80,150),
(5,'2018-8-12',"30-33333333-3","HBD",70,100),
(5,'2018-8-12',"30-33333333-3","HCM",180,50),
(5,'2018-8-12',"30-33333333-3","HBM",160,50),
(6,'2018-8-12',"20-22222222-9","HBD",70,100),
(6,'2018-8-12',"20-22222222-9","HCM",180,100),
(7,'2018-8-13',"30-33333333-3","HCM",180,50),
(7,'2018-8-13',"30-33333333-3","HBM",160,30),
(7,'2018-8-13',"30-33333333-3","HBC2",50,100),
(7,'2018-8-13',"30-33333333-3","HBD2",40,40),
(8,'2018-8-13',"30-44444444-4","HBM",160,30),
(9,'2018-8-13',"20-11111111-1","HBC2",35,50),
(9,'2018-8-13',"20-11111111-1","HBD2",20,50),
(10,'2018-8-13',"30-22222222-2","HCD",80,20),
(10,'2018-8-13',"30-22222222-2","HBD",70,20),
(10,'2018-8-13',"30-22222222-2","HCM",180,50),
(10,'2018-8-14',"30-22222222-2","HBM",160,100),
(11,'2018-8-14',"20-11111111-1","HBD",70,20),
(11,'2018-8-10',"20-11111111-1","HCM",180,40),
(12,'2018-8-10',"30-22222222-2","HCM",180,100),
(12,'2018-8-10',"30-22222222-2","HBM",160,100),
(12,'2018-8-10',"30-22222222-2","HBC2",50,100),
(12,'2018-8-10',"30-22222222-2","HBD2",40,50),
(13,'2018-8-11',"30-44444444-4","HBM",160,150),
(14,'2018-8-11',"20-22222222-9","HBC2",35,50),
(14,'2018-8-11',"20-22222222-9","HBD2",20,50),
(15,'2018-8-12',"30-33333333-3","HCD",80,70),
(15,'2018-8-12',"30-33333333-3","HBD",70,30),
(15,'2018-8-12',"30-33333333-3","HCM",180,50),
(15,'2018-8-12',"30-33333333-3","HBM",160,20);

insert into plantel_x_galpon values (codigo_galpon, codigo_plantel, cantidad), 
	(1,"P2",2000),
    (2,"P2",3000),
    (3,"P1",1500),
    (4,"P3",3000);
    

-- 1_Listar planteles en granja, indicando su genética y cabaña.
-- Preguntar si tiene que mostrar todos los datos
SELECT * FROM plantel p
INNER JOIN genetica g ON p.genetica_gallina = g.codigo 
INNER JOIN cabaña c ON g.codigo_cabaña = c.codigo;
-- 2_Total de gallinas alojadas en la granja.
SELECT SUM(p.cantidad) as Total_gallinas FROM plantel p;
-- 3_Total de gallinas en cada galpón, indicando a qué plantel corresponden.
SELECT * from plantel_x_galpon p;
-- 4)Porcentaje de gallinas en cada galpón, con respecto al total de gallinas alojadas en la granja
SELECT pg.cantidad as Total_Gallinas, SUM(pg.cantidad) / (SELECT SUM(pg.cantidad) from plantel_x_galpon pg) * 100 as Porcentaje_Gallinas from plantel_x_galpon pg group by pg.codigo_galpon;
-- 5) Porcentaje de gallinas en cada galpón, con respecto al total de gallinas del plantel al que pertenecen.
SELECT pg.cantidad as TOTAL_Gallinas, SUM(pg.cantidad) / (SELECT SUM(pg.cantidad) from plantel_x_galpon pg)*100 as Porcentaje from plantel_x_galpon pg group by pg.codigo_plantel;
	
-- 6)Listado de las genéticas de las que no hay planteles en ningún galpón.
SELECT * FROM genetica g WHERE g.codigo NOT IN(SELECT g.codigo from plantel p where p.genetica_gallina=g.codigo);
SELECT * FROM genetica g WHERE NOT EXISTS(SELECT g.codigo from plantel p where p.genetica_gallina=g.codigo);

-- 7) Total de alimento entregado a los galpones, acumulado por tipo
SELECT SUM()
-- 8) Total de alimento entregado a los galpones, acumulado por tipo y que superen el promedio de las entregas

-- 9) Total de alimento entregado a los galpones, acumulado por tipo y que superen el promedio de las entregas del tipo.
-- CONSULTA PARA VER LOS DATOS	
-- 10) Total de ventas entre fechas.

-- 11) Total de ventas entre fechas, por producto.

-- 12) Detalle de ventas (número factura, fecha, total facturado) entre fechas.
-- Hay que revisar si lo que pide es lo que muestra o la SUMa de los totales por fecha 
-- 13)Detalle de ventas (número factura, fecha, total facturado) entre fechas cuyo total supere el promedio del total de ventas entre dichas fechas.
-- CONSULTA PARA AVERIGUAR LOS PROMEDIOS ENTRE FECHAS

-- 14)Detalle de ventas realizadas en la localidad de Lanús.
use granja
	select f.cod_factura, f.numero_factura, f.codigo_producto, f.cant_producto, f.cuit_cliente
    from factura f where  f.cuit_cliente in (select c.cuit from cliente c
    INNER JOIN domicilio d ON c.domicilio = d.id_domicilio
			INNER JOIN localidad l ON d.localidad_idLocalidad = l.idLocalidad
				WHERE l.idLocalidad=3);
                
                SELECT 
    f.numero_factura,
    f.fecha,
    SUM(f.precio_producto * f.cant_producto)
FROM
    factura f
WHERE
    f.cuit_cliente IN (SELECT 
            c.cuit
        FROM
            cliente c
                INNER JOIN
            domicilio d ON c.domicilio = d.id_domicilio
                INNER JOIN
            localidad l ON d.localidad_idlocalidad = l.idLocalidad
        WHERE
            l.idLocalidad = 3)
GROUP BY f.numero_factura;
-- 15) Detalle de producción y ventas de la granja: se deberá mostrar fecha, tipo (producción o
-- venta), cantidad en docenas de huevos (positiva si es producción, negativa si es venta). No
-- es necesario agrupar por ningún atributo.
select 'Produccion', sum(p.produccion/12) as Lista  , p.fecha from planilla p group by p.fecha having (produccion) > 50
union
select 'Ventas', sum(f.cant_producto*-1) , f.fecha from factura f group by f.fecha having (cant_producto) > 400;

-- Resultado de producción y ventas de la granja: se deberá mostrar fecha, resultado (en
-- docenas). Positivo si la producción superó a las ventas, negativo en caso contrario


select 	max(ventas.cant_ventas), 
		min(ventas.cant_ventas), 
        avg(ventas.cant_ventas) 
        from (select f.numero_factura, count(f.numero_factura) as cant_ventas from factura f group by f.numero_factura) as ventas
	