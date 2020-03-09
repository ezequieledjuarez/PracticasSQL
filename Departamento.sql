create schema if not exists departamento;
use departamento;
create table departamento (
	codDepto varchar(4)primary key,
    nombreDpto varchar(20),
	ciudad varchar(15),
	codDirector varchar(12)
    );
    
create table empleado(
	dniEmp int primary key not null,
    nomEmp varchar(30),
    sexEmp char(1),
    fechaNac datetime,
    fechaInc datetime,
    salarioEmp float,
    comision float,
	cargoE varchar(15),
    jefeId varchar(12),
    empleado_codDepto varchar(4),
    foreign key (empleado_codDepto) 
		references departamento(codDepto)
    );
    
    insert into departamento values ('AB12', 'Gerencia','Avellaneda','Eze94');
    insert into departamento values ('CD34', 'Mantenimieto', 'Puerto Madero', 'Edu90');
    insert into empleado values (14500140,'Jorge','M','1959/7/28','2005/1/1',25000,2500,'Cochero','QU41','AB12');
    insert into empleado values(13501011,'Luisa','F','1957/8/11','2000/2/2',30000,3000,'Portera','QU41','AB12');
    insert into empleado values(40200100,'Joaquin','M','1998/2/28','2012/12/4',35000,3500,'Seguridad','QU41','AB12');
    insert into empleado  values(35191581,'Gisela','F','1994/2/8','2013/12/30',40000,4000,'Secretaria','QU41','AB12');
    insert into empleado values(7717009,'Graciela','F','1952/10/19','1990/5/9',45000,4500,'Encargada','QU41','AB12');
    insert into empleado values(34104016,'Mariano','M','1992/12/2','2018/2/5',25000,2500,'Cochero','CE10','CD34');
    insert into empleado values(38466771,'Yanela','F','1996/6/18','2018/2/5',30000,3000,'Portera','CE10','CD34');
    insert into empleado values(25417765,'Aldo','M','1973/9/13','1999/1/1',35000,3500,'Seguridad','CE10','CD34');
    insert into empleado values(42005764,'Bianca','F','2000/5/6','2019/2/6',40000,4000,'Secretaria','CE10','CD34');
    insert into empleado values(27177571,'Rosana','F','1975/7/8','1999/5/8',45000,4500,'Encargada','CE10','CD34');
    
    -- Consultas
    -- 1)1. Obtener los datos completos de los empleados.
    select * from empleado;
    -- 2. Obtener los datos completos de los departamentos.
    select*from departamento;
    -- 3)Obtener los datos de los empleados con cargo ‘Secretaria’.
    select * from empleado where cargoE = "Secretaria";
    -- 4)Obtener el nombre y salario de los empleados.
    select 
    e.nomEmp,
    e.salarioEmp
    from empleado e;
    -- 5)Obtener los datos de los empleados de seguridad, ordenado por nombre.
    select * from empleado where cargoE = "Seguridad" order by nomEmp;
    select 
    e.nomEmp,
    e.salarioEmp
    from empleado e
    order by nomEmp;
    -- 6) Listar el nombre de los departamentos.
    select nombreDpto
    from departamento;

    -- 7) Obtener el nombre y cargo de todos los empleados, ordenado por salario.
    select 
    e.comision,
    e.salarioEmp
    from empleado e 
    inner join
    departamento d on e.empleado_codDepto = d.codDepto
    order by salarioEmp;
    -- 8)  Listar los salarios y comisiones de los empleados del departamento 2000, ordenado por comisión.
    select
    e.comision,
    e.salarioEmp
    from empleado e
    where  empleado_codDepto = "AB12"
    order by comision;
    -- 9)Listar todas las comisiones.
	select 
    e.comision
    from empleado e;
    -- 10) Obtener el valor total a pagar que resulta de sumar a los empleados del departamento 3000 una bonificación de 500.000, en orden alfabético del empleado
	select 
    nomEmp,
    salarioEmp,
    (salarioEmp + 500) as 'pago total'
    from empleado 
    where empleado_codDepto = "CD34"
    order by nomEmp;
-- 11)Obtener la lista de los empleados que ganan una comisión superior a su sueldo.
	select * from empleado
    where comision>salarioEmp;
-- 12)Listar los empleados cuya comisión es menor o igual que el 30% de su sueldo
	select * from empleado
    where comision <= salarioEmp*0.3;
-- 13)Elabore un listado donde para cada fila, figure ‘Nombre’ y ‘Cargo’ antes del valor respectivo para cada empleado.
	select 
    nomEmp as 'Nombre',
    cargoE as 'Cargo'
    from empleado;
-- 14)Hallar el salario y la comisión de aquellos empleados cuyo número de documento de identidad es superior al ‘19.709.802’.
	select
    dniEmp,
    salarioEmp,
    comision
    from empleado where dniEmp>19709802;
-- 15) Muestra los empleados cuyo nombre empiece entre las letras J y Z (rango).Liste estos empleados y su cargo por orden alfabético.
	select
    nomEmp,
    cargoE
    from empleado
    where lower(nomEmp)>'j' and lower(nomEmp)<'z'
    order by nomEmp;
-- 16) Listar el salario, la comisión, el salario total (salario + comisión), documento de identidad del empleado y nombre, de aquellos empleados que tienen comisión superior a 3.000, ordenar el informe por el número del documento de identidad
select
salarioEmp,
comision,
(salarioEmp + comision) as 'salario total',
dniEmp,
nomEmp
from empleado
where comision>3000
order by dniEmp;
-- 17)Listado similar al anterior para empleados sin comisión
select 
salarioEmp,
comision,
(salarioEmp+comision)as 'salario total',
dniEmp,
nomEmp
from empleado
where comision = null
order by dniEmp;
-- 18)Hallar empleados cuyo nombre no contengab la cadena 'la'
select nomEmp
from empleado
where lower(nomEmp) not like '%la%';
-- 19)Obtener los nombres de los departamentos que no sean “Ventas” ni “Investigación” NI ‘MANTENIMIENTO’.
select nombreDpto
from departamento
where lower(nombreDpto) not in ('Ventas', 'Investigacion','Mantenimieto');

-- 20) Obtener el nombre y el departamento de los empleados con cargo ‘Secretaria’ o ‘Vendedor’, que no trabajan en el departamento de “PRODUCCION”, cuyo salario es superior a $1.000.000, ordenados por fecha de incorporación.
-- REVISAR
select e.nomEmp,
e.cargoE,
d.nombreDpto
from empleado e, departamento d
where e.cargoE = "Secretaria" or "Vendedor" and  d.nombreDpto<>"AB12" and e.salarioEmp>30000
order by e.fechaInc;

-- 21)Obtener información de los empleados cuyo nombre tiene exactamente 4 caracteres
select nomEmp as nombre
from empleado
where char_length(nomEmp) = 4;
-- 22)Obtener información de los empleados cuyo nombre tiene al menos 11 caracteres
select nomEmp as nombre
from empleado
where char_length(nomEmp)<11;
-- 23)Listar los datos de los empleados cuyo nombre inicia por la letra ‘M’, su salario es mayor a $800.000 o reciben comisión y trabajan para el departamento de ‘Gerencia’
select e.nomEmp as 'nombre',
e.salarioEmp as 'salario',
d.nombreDpto
from empleado e, departamento d 
where locate("M", nomEmp) <> "M" -- Devuelve solo el que contiene M, si se pone = devuelve todos los que no contienen M
and salarioEmp>800
and nombreDpto<>"Gerencia";
-- 24)Obtener los nombres, salarios y comisiones de los empleados que reciben un salario situado entre la mitad de la comisión la propia comisión.
select nomEmp,
salarioEmp,
comision
from empleado
where salarioEmp  between (comision/2) and comision;

-- 25) Mostrar el salario mas alto de la empresa
select nomEmp,
max(salarioEmp)
from empleado;

-- 26)Mostrar cada una de las comisiones y el número de empleados que las reciben. Solo si tiene comision.
select comision, count(*) as cantidadEmpleados
from empleado e
group by comision;

-- 27) Mostrar el nombre del último empleado de la lista por orden alfabético.
select
max(nomEmp)
from empleado;

-- 28)Mostrar el salario mas alto, el mas bajo y la diferencia entre ellos
select
max(salarioEmp) as 'maximo',
min(salarioEmp)as 'minimo',
max(salarioEmp) - min(salarioEmp) as 'diferencia'
from empleado;

-- 29)Mostrar el número de empleados de sexo femenino y de sexo masculino, por departamento.
select 
empleado_codDepto, sexEmp, count(*)
from empleado 
group by empleado_codDepto, sexEmp;

-- 30)Hallar el salario promedio por departamento
select
salarioEmp, empleado_codDepto, avg(salarioEmp) as 'promedio'
from empleado e
group by empleado_codDepto;

-- 31)Mostrar la lista de los empleados cuyo salario es mayor o igual que el promedio de la empresa. Ordenarlo por departamento.
select nomEmp, salarioEmp, empleado_codDepto
from empleado 
where salarioEmp >= (select avg(salarioEmp) from empleado)
order by empleado_codDepto;

-- 32)Hallar los departamentos que tienen más de tres empleados. Mostrar el número de empleados de esos departamentos.
select empleado_codDepto, count(*)
from empleado
group by empleado_codDepto;

-- 34) Hallar los departamentos que no tienen empleados
select empleado_codDepto, count(*) as 'Depto vacio'
from empleado
group by empleado_codDepto
having count(*) = 0;

-- 35)
select empleado_codDepto, sum(salarioEmp) as 'Suma salarios'
from empleado e
group by empleado_codDepto;