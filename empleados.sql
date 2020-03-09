create schema if not exists empleados;
use empleados;

 create table departamento(
	codigo int auto_increment,
    nombre varchar (100),
    presupuesto double,
    primary key(codigo)
 );
 alter table departamento
 add column gastos double;
 
 create table empleado(
	codigo int auto_increment,
    nif varchar(100),
    nombre varchar(100),
    apellido1 varchar(100),
    apellido2 varchar(100) null,
    codigo_departamento int,
    primary key (codigo),
    foreign key (codigo_departamento)
    references departamento(codigo)
 );
 
 insert into departamento values
 (1,"Desarrollo",120000,6000),
 (2,"Sistemas",150000,21000),
 (3,"Recursos Humanos",280000,25000),
 (4,"Contabilidad",110000,3000),
 (5,"I+D",375000,380000),
 (6,"Proyectos",0,0),
 (7,"Publicidad",0,1000);
 
 insert into empleado values
 (1,"32481596F","Aarón","Rivero","Gomez",1),
 (2,"Y5575632D","Adela","Salas","Diaz",2),
 (3,"R6970642B","Adolfo","Rubio","Flores",3),
 (4,"77705545E","Adrian","Suarez", null,4),
 (5,"17087203C","Marcos","Loyola","Mendez",5),
 (6,"38382980m","Maria","Santana","Moreno",1),
 (7,"80576669X","Pilar","Ruiz",null,3),
 (8,"71651431Z","Pepe","Ruiz","Santana",3),
 (9,"56399183D","Juan","Gomez","Lopez",2),
 (10,"46384486H","Diego","Flores","Salas",5),
 (11,"67389283A","Marta","Herrera","Gil",1),
 (12,"41234836R","Irene","Salas","Flores",null),
 (13,"82635162B","Juan Antonio", "Saez", "Guerrero",null);
 
-- Consultas sobre una tabla

-- 1_Lista el primer apellido de todos los empleados.

select apellido1 from empleado;

-- 2_Lista el primer apellido de los empleados eliminando los apellidos que estén repetidos.

select apellido1 from empleado
group by apellido1;
-- 3_Lista todas las columnas de la tabla empleado.
select * from empleado;

-- 4_Lista el nombre y los apellidos de todos los empleados.

select nombre, apellido1, apellido2 from empleado;

-- 5_Lista el código de los departamentos de los empleados que aparecen en la tabla empleado.

select codigo_departamento from empleado;
-- 6_Lista el código de los departamentos de los empleados que aparecen en la tabla empleado, eliminando los códigos que aparecen repetidos.

select codigo_departamento from empleado
group by codigo_departamento;

-- 7_Lista el nombre y apellidos de los empleados en una única columna.
select nombre  from empleado
UNION ALL
select apellido1 from empleado
UNION ALL
select apellido2 from empleado;

-- 8_Lista el nombre y apellidos de los empleados en una única columna, convirtiendo todos los caracteres en mayúscula.
select upper(nombre) from empleado
UNION ALL
select upper(apellido1) from empleado
UNION ALL
select upper(apellido2) from empleado;

-- 9_Lista el nombre y apellidos de los empleados en una única columna, convirtiendo todos los caracteres en minúscula.
select lower(nombre) from empleado
UNION ALL
select lower(apellido1)from empleado
UNION ALL
select lower(apellido2) from empleado;
-- 10_Lista el código de los empleados junto al nif, pero el nif deberá aparecer en dos columnas, una mostrará únicamente los dígitos del nif y la otra la letra.

select codigo, substring(nif,1,8) as Codigo_Numerico,substring(nif,9) as Letra from empleado;

-- 11_Lista el nombre de cada departamento y el valor del presupuesto actual del que dispone. Para calcular este dato tendrá que restar al valor del presupuesto inicial (columna presupuesto) los gastos que se han generado (columna gastos). Tenga en cuenta que en algunos casos pueden existir valores negativos. Utilice un alias apropiado para la nueva columna columna que está calculando.

select nombre, (presupuesto - gastos ) as Presupuesto_Actual from departamento;

-- 12_Lista el nombre de los departamentos y el valor del presupuesto actual ordenado de forma ascendente.

select nombre, (presupuesto-gastos)Presupuesto_Actual from departamento
order by Presupuesto_Actual asc;

-- 13_Lista el nombre de todos los departamentos ordenados de forma ascendente.

select nombre from departamento
order by nombre asc;
-- 14_Lista el nombre de todos los departamentos ordenados de forma desscendente.

select nombre from departamento
order by nombre desc;
-- 15_Lista los apellidos y el nombre de todos los empleados, ordenados de forma alfabética tendiendo en cuenta en primer lugar sus apellidos y luego su nombre.

select nombre, apellido1, apellido2 from empleado
order by apellido1, apellido2, nombre asc;

-- 16_Devuelve una lista con el nombre y el presupuesto, de los 3 departamentos que tienen mayor presupuesto.

select nombre, presupuesto from departamento
order by presupuesto desc
limit 3;
-- 17_Devuelve una lista con el nombre y el presupuesto, de los 3 departamentos que tienen menor presupuesto.

select nombre, presupuesto from departamento
order by presupuesto asc
limit 3;

-- 18_Devuelve una lista con el nombre y el gasto, de los 2 departamentos que tienen mayor gasto.

select nombre, gastos from departamento
order by gastos desc
limit 2;

-- 19_Devuelve una lista con el nombre y el gasto, de los 2 departamentos que tienen menor gasto.

select nombre, gastos from departamento
order by gastos asc
limit 2;
-- 20_Devuelve una lista con 5 filas a partir de la tercera fila de la tabla empleado. La tercera fila se debe incluir en la respuesta. La respuesta debe incluir todas las columnas de la tabla empleado.

select * from empleado
limit 2,5;

-- 21_Devuelve una lista con el nombre de los departamentos y el presupuesto, de aquellos que tienen un presupuesto mayor o igual a 150000 euros.

select nombre, presupuesto from departamento
where presupuesto >= 150000;

-- 22_Devuelve una lisa con el nombre de los departamentos y el gasto, de aquellos que tienen menos de 5000 euros de gastos.

select nombre, gastos from departamento 
where gastos < 5000;

-- 23_Devuelve una lista con el nombre de los departamentos y el presupesto, de aquellos que tienen un presupuesto entre 100000 y 200000 euros. Sin utilizar el operador BETWEEN.

select nombre, presupuesto from departamento
where presupuesto >100000 and presupuesto <200000;

-- 24_Devuelve una lista con el nombre de los departamentos que no tienen un presupuesto entre 100000 y 200000 euros. Sin utilizar el operador BETWEEN.

select nombre, presupuesto from departamento 
where presupuesto >200000 or presupuesto<100000;

-- 25_Devuelve una lista con el nombre de los departamentos que tienen un presupuesto entre 100000 y 200000 euros. Utilizando el operador BETWEEN.

select nombre, presupuesto from departamento
where presupuesto between 100000 and 200000;

-- 26_Devuelve una lista con el nombre de los departamentos que no tienen un presupuesto entre 100000 y 200000 euros. Utilizando el operador BETWEEN.

select nombre, presupuesto from departamento
where presupuesto between 0 and 100000 or presupuesto > 200000;


-- 27_Devuelve una lista con el nombre de los departamentos, gastos y presupuesto, de aquellos departamentos donde los gastos sean mayores que el presupuesto del que disponen.

select nombre, gastos, presupuesto from departamento
where gastos > presupuesto;

-- 28_Devuelve una lista con el nombre de los departamentos, gastos y presupuesto, de aquellos departamentos donde los gastos sean menores que el presupuesto del que disponen.

select nombre, gastos, presupuesto from departamento
where gastos < presupuesto;

-- 29_Devuelve una lista con el nombre de los departamentos, gastos y presupuesto, de aquellos departamentos donde los gastos sean iguales al presupuesto del que disponen.

select nombre, gastos, presupuesto from departamento
where gastos = presupuesto;

-- 30_Lista todos los datos de los empleados cuyo segundo apellido sea NULL.

select * from empleado
where apellido2 is null;
-- 31_Lista todos los datos de los empleados cuyo segundo apellido no sea NULL.

select * from empleado
where apellido2 is not null;
-- 32_Lista todos los datos de los empleados cuyo segundo apellido sea López.

select * from empleado
where apellido2 = "Lopez";
-- 33_Lista todos los datos de los empleados cuyo segundo apellido sea Díaz o Moreno. Sin utilizar el operador IN.

select * from empleado
where apellido2 = "Diaz" or apellido2 = "Moreno";

-- 34_Lista todos los datos de los empleados cuyo segundo apellido sea Díaz o Moreno. Utilizando el operador IN.
select * from empleado
where apellido2 in ("Diaz","Moreno");

-- 35_Lista los nombres, apellidos y nif de los empleados que trabajan en el departamento 3.

select nombre, apellido1, apellido2, nif from empleado
where codigo_departamento = 3;

-- 36_Lista los nombres, apellidos y nif de los empleados que trabajan en los departamentos 2, 4 o 5.

select nombre, apellido1, apellido2, nif from empleado
where codigo_departamento in(2,4,5);

-- Consultas multitablas utilizando sintaxis sql1 y sql2

-- 1_Devuelve un listado con los empleados y los datos de los departamentos donde trabaja cada uno.

select * from empleado e 
inner join departamento d on d.codigo = e.codigo_departamento;

-- 2_Devuelve un listado con los empleados y los datos de los departamentos donde trabaja cada uno. Ordena el resultado, en primer lugar por el nombre del departamento (en orden alfabético) y en segundo lugar por los apellidos y el nombre de los empleados.

select * from empleado e
inner join departamento d on d.codigo = e.codigo_departamento
order by d.nombre, e.apellido1, e.apellido2, e.nombre asc;

-- 3_Devuelve un listado con el código y el nombre del departamento, solamente de aquellos departamentos que tienen empleados.

select d.codigo, d.nombre from departamento d 
inner join empleado e on d.codigo = e.codigo_departamento
group by d.nombre;

-- 4_Devuelve un listado con el código, el nombre del departamento y el valor del presupuesto actual del que dispone, solamente de aquellos departamentos que tienen empleados. El valor del presupuesto actual lo puede calcular restando al valor del presupuesto inicial (columna presupuesto) el valor de los gastos que ha generado (columna gastos).

select d.codigo, d.nombre, (presupuesto - gastos) as Presupuesto_actual from departamento d
inner join empleado e on e.codigo_departamento = d.codigo
group by d.codigo;
-- 5_Devuelve el nombre del departamento donde trabaja el empleado que tiene el nif 38382980M.

select d.nombre from departamento d
inner join empleado e on e.codigo_departamento = d.codigo
where e.nif = "38382980M";

-- 6_Devuelve el nombre del departamento donde trabaja el empleado Pepe Ruiz Santana.

select d.nombre from departamento d
inner join empleado e on e.codigo_departamento = d.codigo
where e.nombre = "Pepe";

-- 7_Devuelve un listado con los datos de los empleados que trabajan en el departamento de I+D. Ordena el resultado alfabéticamente.

select * from empleado e
inner join departamento d on e.codigo_departamento = d.codigo
where d.nombre = "I+D"
order by e.apellido1, e.apellido2, e.nombre asc;

-- 8_Devuelve un listado con los datos de los empleados que trabajan en el departamento de Sistemas, Contabilidad o I+D. Ordena el resultado alfabéticamente.

select * from empleado e
inner join departamento d on d.codigo = e.codigo_departamento
where d.nombre = "Sistemas" or d.nombre = "Contabilidad" or d.nombre = "I+D"
order by e.apellido1, e.apellido2, e.nombre asc;

-- 9_Devuelve una lista con el nombre de los empleados que tienen los departamentos que no tienen un presupuesto entre 100000 y 200000 euros.

select e.nombre, e.apellido1, e.apellido2 from empleado e
inner join departamento d on d.codigo = e.codigo_departamento
where d.presupuesto < 100000 or d.presupuesto > 200000;

-- 10_Devuelve un listado con el nombre de los departamentos donde existe algún empleado cuyo segundo apellido sea NULL. Tenga en cuenta que no debe mostrar nombres de departamentos que estén repetidos.
select d.nombre from departamento d
inner join empleado e on e.codigo_departamento = d.codigo
where e.apellido2 is null;
-- Consultas multitabla (Composición externa)

-- 1_Devuelve un listado con todos los empleados junto con los datos de los departamentos donde trabajan. Este listado también debe incluir los empleados que no tienen ningún departamento asociado.

select * from empleado e
left join departamento d on d.codigo = e.codigo_departamento;

-- 2_Devuelve un listado donde sólo aparezcan aquellos empeados que no tienen ningún departamento asociado.

select * from empleado e
where e.codigo_departamento is null;

-- 3_Devuelve un listado donde sólo aparezcan aquellos departamentos que no tienen ningún empleado asociado.

select * from departamento d
left join empleado e on e.codigo_departamento = d.codigo
where e.codigo_departamento is null;

-- 4_Devuelve un listado con todos los empleados junto con los datos de los departamentos donde trabajan. El listado debe incluir los empleados que no tienen ningún departamento asociado y los departamentos que no tienen ningún empleado asociado. Ordene el listado alfabéticamente por el nombre del departamento.

select * from empleado e
left join departamento d on e.codigo_departamento = d.codigo
order by d.nombre asc;

-- 5_Devuelve un listado con los empleados que no tienen ningún departamento asociado y los departamentos que no tienen ningún empleado asociado. Ordene el listado alfabéticamente por el nombre del departamento.

select * from empleado e
left join departamento d on d.codigo = e.codigo_departamento
where e.codigo_departamento is null
UNION
select * from departamento d 
left join empleado e on d.codigo = e.codigo_departamento
where e.codigo_departamento is null
;

-- Consultas resumen
-- 1_Calcula la suma del presupuesto de todos los departamentos.-- 2_Calcula la media del presupuesto de todos los departamentos.
-- 3_Calcula el valor mínimo del presupuesto de todos los departamentos.
-- 4_Calcula el nombre del departamento y el presupuesto que tiene asignado, del departamento con menor presupuesto.
-- 5_Calcula el valor máximo del presupuesto de todos los departamentos.
-- 6_Calcula el nombre del departamento y el presupuesto que tiene asignado, del departamento con mayor presupuesto.
-- 7_Calcula el número total de empleados que hay en la tabla empleado.
-- 8_Calcula el número de empleados que no tienen NULL en su segundo apellido.
-- 9_Calcula el número de empleados que hay en cada departamento. Tienes que devolver dos columnas, una con el código del departamento y otra con el número de empleados que tiene asignados.
-- 10_Calcula los códigos de los departamentos que tienen más de 2 empleados.
-- 11_Calcula el número de empleados que trabajan en cada uno de los departamentos. El resultado de esta consulta también tiene que incluir aquellos departamentos que no tienen ningún empleado asociado.
-- 12_Calcula el número de empleados que trabajan en los departamentos que tienen un presupuesto mayor a 200000 euros.

-- Subconsultas con operadores basicos de comparacion

-- 1_Devuelve un listado con todos los empleados que tiene el departamento de Sistemas. (Sin utilizar INNER JOIN).
-- 2_Devuelve el nombre del departamento con mayor presupuesto y la cantidad que tiene asignada.
-- 3_Devuelve el nombre del departamento con menor presupuesto y la cantidad que tiene asignada.

-- subconsultas con all any
-- 4_Devuelve el nombre del departamento con mayor presupuesto y la cantidad que tiene asignada. Sin hacer uso de MAX, ORDER BY ni LIMIT.
-- 5_Devuelve el nombre del departamento con menor presupuesto y la cantidad que tiene asignada. Sin hacer uso de MIN, ORDER BY ni LIMIT.
-- 6_Devuelve los nombres de los departamentos que tienen empleados asociados. (Utilizando ALL o ANY).
-- 7_Devuelve los nombres de los departamentos que no tienen empleados asociados. (Utilizando ALL o ANY).

-- subconsultas con in not in
-- 8_Devuelve los nombres de los departamentos que tienen empleados asociados. (Utilizando IN o NOT IN).
-- 9_Devuelve los nombres de los departamentos que no tienen empleados asociados. (Utilizando IN o NOT IN).

-- subconsultas con exists not exists
-- 10_Devuelve los nombres de los departamentos que tienen empleados asociados. (Utilizando EXISTS o NOT EXISTS).
-- 11_Devuelve los nombres de los departamentos que tienen empleados asociados. (Utilizando EXISTS o NOT EXISTS).
