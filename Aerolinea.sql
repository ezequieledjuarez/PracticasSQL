create schema if not exists vuelos;
use vuelos;


CREATE TABLE marca (
    codigo INT NOT NULL PRIMARY KEY,
    nombre VARCHAR(45) NOT NULL,
    pais_De_Origen VARCHAR(45)
);

CREATE TABLE avion (
    marca_codigo INT,
    modelo VARCHAR(45),
    matricula VARCHAR(45) PRIMARY KEY,
    f_servicio DATETIME,
    FOREIGN KEY (marca_codigo)
        REFERENCES marca (codigo)
);

CREATE TABLE calle (
    nombre VARCHAR(100),
    id_calle INT PRIMARY KEY
);
    
CREATE TABLE localidad (
    nombre VARCHAR(100),
    id_localidad INT PRIMARY KEY
);
    
CREATE TABLE provincia (
    nombre VARCHAR(100),
    id_provincia INT PRIMARY KEY
);

CREATE TABLE domicilio (
	calle_id_calle INT,
    provincia_id_provincia INT,
    localidad_id_localidad INT,
    numero INT,
    FOREIGN KEY (localidad_id_localidad)
        REFERENCES localidad (id_localidad),
    FOREIGN KEY (provincia_id_provincia)
        REFERENCES provincia (id_provincia),
    FOREIGN KEY (calle_id_calle)
        REFERENCES calle (id_calle),
    id_domicilio INT PRIMARY KEY
);

CREATE TABLE piloto (
	piloto_id_domicilio INT,
   apellido VARCHAR(45),
    nombre VARCHAR(45),
    dni INT,
    cuil VARCHAR(45) PRIMARY KEY,
    fecha_Ingreso DATETIME,
    FOREIGN KEY (piloto_id_domicilio)
        REFERENCES domicilio (id_domicilio)
);

CREATE TABLE aeropuerto (
    codigo VARCHAR(45) NOT NULL PRIMARY KEY,
    nombre VARCHAR(100),
    ciudad VARCHAR(100)
);
    
CREATE TABLE pasajero (
    pasajero_id_domicilio INT,
    FOREIGN KEY (pasajero_id_domicilio)
        REFERENCES domicilio (id_domicilio),
    apellido VARCHAR(100),
    nombre VARCHAR(100),
    dni INT NOT NULL PRIMARY KEY,
    pvf BOOLEAN
);

CREATE TABLE vuelo (
    codigo VARCHAR(45) PRIMARY KEY,
    vuelo_matricula VARCHAR(45),
    aero_origen VARCHAR(45),
    aero_llegada VARCHAR(45),
    fecha_salida DATETIME,
    fecha_llegada DATETIME,
    piloto_cuil VARCHAR(45),
    FOREIGN KEY (vuelo_matricula)
        REFERENCES avion (matricula),
    FOREIGN KEY (aero_origen)
        REFERENCES aeropuerto (codigo),
    FOREIGN KEY (aero_llegada)
        REFERENCES aeropuerto (codigo),
    FOREIGN KEY (piloto_cuil)
        REFERENCES piloto (cuil)
);

	
CREATE TABLE pasajeros_vuelo (
    vuelo_codigo varchar(45),
    pasajero_dni INT,
    PRIMARY KEY (vuelo_codigo , pasajero_dni),
    FOREIGN KEY (vuelo_codigo)
        REFERENCES vuelo (codigo),
    FOREIGN KEY (pasajero_dni)
        REFERENCES pasajero (dni)
);

insert into marca values (1,"Cessna","Estados Unidos");
insert into marca values(2,"Beechcraft","Estados Unidos");
insert into marca values (3,"Fokker","Alemania");

insert into avion values(1,"Citation","LV-ABC",'2010/12/12');
insert into avion values(2,"Batron","LV-CDE",'2011/10/1');
insert into avion values (3,"F-27","LV-FGH",'11/05/4');
insert into avion values (1, "Citation","LV-IJK",'2014/06/7');
insert into avion values(2,"King Air","LV-LMN",'2012/07/8');

insert into calle values ("Ituzaingo",1);
insert into calle values("Roca",2);
insert into calle values("Campichuelo",3);
insert into calle values("Meeks",4);
insert into calle values("Mamberti",5);
insert into calle values("Amenabar",6);
insert into calle values("Capello",7);
insert into calle values("San Martin",8);
insert into calle values("Azara",9);
insert into calle values("Sarmiento",10);
insert into calle values("Rivadavia",11);
insert into calle values("Martinto",12);
insert into calle values("Bolaños",13);
insert into calle values("Loria",14);

insert into provincia values ("Buenos Aires",1); 
insert into provincia values ("CABA",2);

insert into localidad values("CABA",1);
insert into localidad values("Lomas de Zamora",2);
insert into localidad values("Lanus",3);
insert into localidad values("Avellaneda",4);

insert into domicilio values(1,1,3,123,1);
insert into domicilio values(2,2,1,4561,2);
insert into domicilio values(3,1,4,6532,3);
insert into domicilio values(4,1,2,562,4);
insert into domicilio values(5,1,3,2356,5);
insert into domicilio values(6,2,1,2345,6);
insert into domicilio values(7,1,2,1589,7);
insert into domicilio values(6,2,1,356,8);
insert into domicilio values(4,1,2,1296,9);
insert into domicilio values(8,1,4,3652,10);
insert into domicilio values(8,2,1,2235,11);
insert into domicilio values(9,1,2,1254,12);
insert into domicilio values(10,1,3,500,13);
insert into domicilio values(11,2,1,2351,14);
insert into domicilio values(12,1,3,663,15);
insert into domicilio values(13,1,3,1256,16);
insert into domicilio values(14,1,2,333,17);

insert into pasajero values (1,"Barragan", "Alejo", 11111111, true);
insert into pasajero values (2,"Andrès", "Alfredo", 22222222, true );
insert into pasajero values ( 3,"Chaves", "Barbara", 33333333, false);
insert into pasajero values (4,"Chimbo", "Brisa", 44444444, true);
insert into pasajero values (5,"Chudoba", "camila", 55555555, false);
insert into pasajero values (6,"Cires", "Carlos", 66666666, true);
insert into pasajero values (7,"Cusato", "Carlos Sebastián", 77777777, false);
insert into pasajero values (8,"Dominguez", "Christian", 88888888, true);
insert into pasajero values (9,"Escullini", "Cristian", 99999999, true);
insert into pasajero values (10,"Feijoo", "Cristian", 10111213, true);

insert into piloto values(11,"Juarez",	"Federico Bernardo",12345678,"20-12345678-8",'1994/10/1');
insert into piloto values(12,"Lacoste","Franco",34567890,"20-34567890-1",'2003/7/1');
insert into piloto values(13,"Laime" ,"Mariana",45678901,"27-45678901-1",'2001/4/1');
insert into piloto values(14,"Lopez","Germán Ignacio",56789123,"20-56789123-3",'2013/5/1');
insert into piloto values(15,"Martinez","Giuliano",67891234,"20-67891234-4",'2010/7/1');
insert into piloto values(16,"Medina","Adriana",78912345,"27-78912345-5"	,'2015/8/1');
insert into piloto values(17,"Melgarejo","Jair Alberto",90123456,"20-90123456-6",'2011/3/1');

insert into aeropuerto values("BUE","Aeroparque Jorge Newbery","CABA");
insert into aeropuerto values("MDQ","Astor Piazolla","Mar Del Plata");
insert into aeropuerto values("BRC","Teniente Luis Candelaria","San Carlos de Bariloche");	

insert into vuelo values ("TT1234", "LV-ABC", "BUE", "BRC", '2018/5/1''20:00', '2018/5/1''23:45', "20-12345678-8");

insert into pasajeros_vuelo values ("TT1234", 44444444);
insert into pasajeros_vuelo values ("TT1234", 55555555);
insert into pasajeros_vuelo values ("TT1234", 66666666);


insert into vuelo values ("TT3456","LV-CDE","BUE","MDQ",'2018/5/2''10:00','2018/5/2''12:00', "27-78912345-5");

insert into pasajeros_vuelo values ("TT3456", 99999999);
insert into pasajeros_vuelo values ("TT3456",77777777);
insert into pasajeros_vuelo values ("TT3456",88888888);


insert into vuelo values ("TT1235","LV-ABC","BRC","BUE",'2018/5/2''7:00:00','2018/5/2''10:50:00',"20-12345678-8");

insert into pasajeros_vuelo values ("TT1235", 44444444);
insert into pasajeros_vuelo values ("TT1235",55555555);


insert into vuelo values ("TT1256","LV-FGH","BUE", "MDQ", '2018/5/2' '8:00:00','2018/5/2''10:05:00',"27-45678901-1");

insert into pasajeros_vuelo values ("TT1256", 11111111);
insert into pasajeros_vuelo values ("TT1256", 22222222);
insert into pasajeros_vuelo values ("TT1256", 33333333);


insert into vuelo values ("TT5632","LV-IJK","MDQ","BUE", '2018/5/3''07:00','2018/5/3''09:15',"20-56789123-3");


insert into pasajeros_vuelo values ("TT5632", 77777777);
insert into pasajeros_vuelo values ("TT5632", 88888888);
insert into pasajeros_vuelo values ("TT5632", 99999999);


insert into vuelo values ("TT3333","LV-LMN","BUE","BRC",'2018/5/3''7:00:00','2018/5/3''10:50:00',"20-12345678-8");


insert into pasajeros_vuelo values ("TT3333", 99999999);
insert into pasajeros_vuelo values ("TT3333",77777777);
insert into pasajeros_vuelo values ("TT3333",88888888);

insert into vuelo values ("TT1257","LV-FGH","BUE","MDQ", '2018/5/4''8:00:00','2018/5/4''10:05:00',"27-45678901-1");


insert into pasajeros_vuelo values ("TT1257", 22222222);


insert into vuelo values ("TT3457","LV-CDE","MDQ", "BUE" ,'2018/5/04''10:00', '2018/5/04''12:00',"27-78912345-5");

insert into pasajeros_vuelo values ("TT3457", 99999999);
insert into pasajeros_vuelo values ("TT3457",77777777);
insert into pasajeros_vuelo values ("TT3457",88888888);


insert into vuelo values ("TT5633","LV-IJK","BUE","MDQ",'2018/5/05''7:00', '2018/5/05''9:15',"20-56789123-3");

insert into pasajeros_vuelo values ("TT5633", 77777777);
insert into pasajeros_vuelo values ("TT5633", 88888888);
insert into pasajeros_vuelo values ("TT5633", 99999999);

select p.apellido,p.nombre,p.dni from pasajero p;

SELECT -- que muestra
    p.apellido,
    p.nombre,
    p.dni,
    c.nombre,
    d.numero,
    l.nombre,
    pr.nombre
FROM -- de donde voy a traer los datos
    pasajero p
		INNER JOIN
    domicilio d ON p.pasajero_id_domicilio = d.id_domicilio
        INNER JOIN
    calle c ON d.calle_id_calle = c.id_calle
        INNER JOIN
    localidad l ON d.localidad_id_localidad = l.id_localidad
        INNER JOIN
    provincia pr ON d.provincia_id_provincia = pr.id_provincia;


SELECT -- que muestra
    p.apellido,
    p.nombre,
    p.dni,
    c.nombre,
    d.numero,
    l.nombre,
    pr.nombre
FROM -- de donde voy a traer los datos
    pasajero p
		INNER JOIN
    domicilio d ON p.pasajero_id_domicilio = d.id_domicilio
        INNER JOIN
    calle c ON d.calle_id_calle = c.id_calle
        INNER JOIN
    localidad l ON d.localidad_id_localidad = l.id_localidad
        INNER JOIN
    provincia pr ON d.provincia_id_provincia = pr.id_provincia
	where p.pvf=true
    order by p.apellido,p.nombre;

SELECT 
	m.nombre,
    a.modelo,
    a.matricula,
    a.f_servicio,
    m.pais_De_Origen
    
FROM
    avion a
        INNER JOIN
    marca m ON a.marca_codigo = m.codigo;

 
SELECT 
	m.nombre,
    a.modelo,
    a.matricula,
    a.f_servicio,
    m.pais_De_Origen
    
FROM
    avion a
        INNER JOIN
    marca m ON a.marca_codigo = m.codigo
    where m.pais_De_Origen="Alemania";

SELECT
v.codigo,
a.matricula,
a.modelo,
m.nombre,
v.aero_origen,
v.aero_llegada,
v.fecha_salida,
v.fecha_llegada,
v.piloto_cuil
FROM
vuelo v
INNER JOIN
avion a ON v.vuelo_matricula= a.matricula
INNER JOIN
marca m ON a.marca_codigo=m.codigo;

SELECT
v.codigo,
m.nombre,
a.modelo,
a.matricula,
v.aero_origen,
v.aero_llegada,
v.fecha_salida,
v.fecha_llegada,
v.piloto_cuil
FROM
vuelo v
INNER JOIN	
avion a ON v.vuelo_matricula = a.matricula
INNER JOIN
marca m ON a.marca_codigo = m.codigo
WHERE 
v.aero_origen = "BUE"
ORDER BY 
v.fecha_salida;

Select 
v.aero_origen,
v.aero_llegada,
v.fecha_salida,
v.fecha_llegada
FROM
vuelo v
where v.aero_origen = "BUE" and v.aero_llegada = "MDQ";

SELECT
v.codigo,
v.aero_origen,
v.aero_llegada,
v.fecha_salida,
v.fecha_llegada
FROM
vuelo v
WHERE v.aero_origen = "BUE" and v.aero_llegada = "MDQ";

SELECT 
v.codigo,
p.apellido,
p.nombre,
p.dni 
FROM 
pasajeros_vuelo pv
INNER JOIN
vuelo v ON pv.vuelo_codigo = v.codigo
INNER JOIN
pasajero p ON pv.pasajero_dni = p.dni;


SELECT count(*) AS cantidad from vuelo
where aero_origen = "BUE" and aero_llegada = "BRC";

SELECT count(*) AS cantidad from vuelo
where aero_origen = "MDQ";

SELECT 
    v.aero_origen, COUNT(*) AS cantidad
FROM
    vuelo v
GROUP BY aero_origen;

SELECT 
   d.localidad_id_localidad, l.nombre, count(*)
FROM
    pasajero p
        INNER JOIN
    domicilio d ON p.pasajero_id_domicilio = d.id_domicilio
        INNER JOIN
    localidad l ON d.localidad_id_localidad = l.id_localidad
GROUP BY  d.localidad_id_localidad, l.nombre;

SELECT 
  p.dni, count(*)
FROM
    pasajero p
        INNER JOIN
    domicilio d ON p.pasajero_id_domicilio = d.id_domicilio
        INNER JOIN
    localidad l ON d.localidad_id_localidad = l.id_localidad;