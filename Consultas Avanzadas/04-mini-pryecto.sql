create database repasojoin;

use repasojoin;

create table proveedor(
    proveedorID int not null identity(1,1),
    nombre varchar (50) not null,
    limite_credito money not null,
    constraint pk_proveedor
    primary key (proveedorID)
);

create table producto(
productoID int not null identity(1,1),
nombre varchar(100) not null,
existencia int not null,
precio money not null,
proveedor int,
constraint pk_producto
primary key (ProductoID),
constraint pk_producto_proveedor 
foreign key (proveedor)
references proveedor (proveedorID)
);

insert into proveedor (nombre, limite_credito) 
values ('proveedor1', 100000),
('proveedor2', 200000),
('proveedor3', 300000),
('proveedor4', 400000),
('proveedor5', 500000);

insert into producto (nombre, existencia, precio, proveedor)
values ('producto1', 34, 45, 1),
('producto2', 34, 45, 1),
('producto3', 34, 45, 2),
('producto4', 34, 45, 3),
('producto5', 34, 45, 5);

SELECT *
FROM proveedor 

SELECT pr.productoID ,pr.nombre as 'Nombre_Producto', pr.precio as [precio],
pr.existencia as [Existencia], p.proveedorID , p.nombre as 'proveedor'
from proveedor as [p]
left JOIN
producto as [pr]
on p.proveedorID = pr.proveedor;

SELECT pr.productoID ,pr.nombre as 'Nombre_Producto', pr.precio as [precio],
pr.existencia as [Existencia], p.proveedorID , p.nombre as 'proveedor'
from proveedor as [p]
RIGHT JOIN
producto as [pr]
on p.proveedorID = pr.proveedor;

insert into producto (nombre, precio, existencia, proveedor)
values ('producto5', 78.8,222 null); 

update proveedor
set nombre = 'Proveedor5'
WHERE proveedorID = 5

SELECT * from proveedor

insert into proveedor (nombre, limite_credito)
values ('proveedor 6', 450000);

DELETE from proveedor
Where proveedorID = 8;

update proveedor 
set nombre = 'Proveedor 6'
WHERE  proveedorID = 4

-- Consultas inner join 

-- Seleccionar todos los productos que tienen proveedor 

select pr.nombre as 'Nombre_Producto', pr.precio as [precio], 
pr.existencia as [Existencia], p.nombre as 'Proveedor'
From proveedor as [p]
inner join 
producto as [pr]
on p.provid = pr.proveedor;

-- Consulta Let Join 

-- Mostrar todos los proveedores y sus respectivos productos 

select pr.prodid ,pr.nombre as 'Nombre_Producto', pr.precio as [precio], 
pr.existencia as [Existencia], p.provid , p.nombre as 'Proveedor'
From proveedor as [p]
left join 
producto as [pr]
on p.provid = pr.proveedor;


update proveedor
set nombre = 'Proveedor6'
where provid = 5;

select * from proveedor

update proveedor
set nombre = 'Proveedor5'
where provid = 5;

insert into proveedor (nombre, limite_credito)
values('Proveedor 6', 45000);

delete from proveedor
where provid =  7;

update proveedor
set nombre='Proveedor6'
where provid = 6;


-- Utilizando rigth join 

select pr.prodid ,pr.nombre as 'Nombre_Producto', pr.precio as [precio], 
pr.existencia as [Existencia], p.provid , p.nombre as 'Proveedor'
From proveedor as [p]
Right join 
producto as [pr]
on p.provid = pr.proveedor;

insert into producto (nombre, precio, existencia, proveedor)
values('producto5', 78.8,22, null);

-- Full Join
select pr.prodid ,pr.nombre as 'Nombre_Producto', pr.precio as [precio], 
pr.existencia as [Existencia], p.provid , p.nombre as 'Proveedor'
From proveedor as [p]
full join 
producto as [pr]
on p.provid = pr.proveedor;

-- Seleccionar todos los proveedores que no tienen asignado productos
select  p.provid as 'Numero de Proveedor' , p.nombre as 'Proveedor'
From proveedor as [p]
left join 
producto as [pr]
on p.provid = pr.proveedor
where pr.prodid is null;

-- Seleccionar todos los productos que no tienen proveedor

select  pr.nombre, pr.precio, pr.Existencia
From proveedor as [p]
right join 
producto as [pr]
on p.provid = pr.proveedor
where p.provid is null
