

-- DECLARACION DE VARIABLES

DECLARE @x int = -4

if @x>0
begin
    print 'El numero es positivo'
end
ELSE
begin
    print 'El numero es negativo'
end

declare @i INT
set @i = 1

while @i<=10
begin
    print 'El primer valor es: '+ cast(@i as varchar)
    set @i= @i + 1
end


-- Crear un sp 

CREATE PROCEDURE procedure_ciclo
AS
begin
    declare @i INT
    set @i = 1

    while @i<=10
    begin
        print 'El primer valor es: '+ cast(@i as varchar)
        set @i= @i + 1
    end 
end;


declare @ii int  =1 

while @ii <=2
begin
    exec procedure_ciclo
    set @ii = @ii + 1
end


drop procedure procedure_ciclo


alter procedure sp_suma1
@n1 as int, 
@n2 as int
AS
  begin  

    declare @suma int 
    set @suma = @n1 + @n2

    print 'La suma es: ' + cast(@suma as varchar)

  end  

execute sp_suma1 40, 30

-- SP reporte de Ventas por cliente 

use northwind;


select c.CompanyName as 'Nombre del Cliente', 
sum(od.Quantity * od.UnitPrice) as 'Total'
from customers as c
inner join Orders as o 
on c.CustomerID = o.customerid
inner join [Order Details] as od
on od.OrderID = o.OrderID
where DatePart(year,o.OrderDate) = 1996
group by c.CompanyName;


Create or alter procedure sp_ventasporcliente
   -- Parametros
   @year as int
AS
BEGIN

select c.CompanyName as 'Nombre del Cliente', 
sum(od.Quantity * od.UnitPrice) as 'Total'
from customers as c
inner join Orders as o 
on c.CustomerID = o.customerid
inner join [Order Details] as od
on od.OrderID = o.OrderID
where DatePart(year,o.OrderDate) = @year
group by c.CompanyName;
 
END

-- Ejecutar sp

exec sp_ventasporcliente 1997

execute sp_ventasporcliente 1996

exec sp_ventasporcliente @year = 1998


-- Ejercicio 1:  Relaizar un store procedure que muestre un reporte de ventas, 
-- por cliente y producto (Agrupado), de un rango de fechas. 

-- Ejercicio 2: Realizar un Store Procedure que inserte un cliente nuevo 

Create or alter procedure agregar_cliente
-- Parametros de entrada 

     @CustomerID nchar(5),
     @CompanyName nvarchar(40),
     @ContactName nvarchar(30)=null,
     @ContactTitle nvarchar(30)=null,
     @Address nvarchar(60) = null,
     @City nvarchar(15) = null,
     @Region nvarchar(15) = null,
     @PostalCode nvarchar(10) = null,
     @Country nvarchar(15) = null,
     @Phone nvarchar(24) = null,
     @Fax nvarchar(24) = null


AS
BEGIN
   INSERT INTO [dbo].[Customers]
           ([CustomerID]
           ,[CompanyName]
           ,[ContactName]
           ,[ContactTitle]
           ,[Address]
           ,[City]
           ,[Region]
           ,[PostalCode]
           ,[Country]
           ,[Phone]
           ,[Fax])
     VALUES (@CustomerID
           , @CompanyName
           ,@ContactName
           ,@ContactTitle
           ,@Address
           ,@City
           ,@Region
           ,@PostalCode
           ,@Country
           ,@Phone
           ,@Fax)  

END;
go

select * from Customers


begin transaction 

exec agregar_cliente  
     @CustomerID = 'GTIG3',
     @CompanyName = 'PATITO DE HULE',
     @ContactName = 'Edith Campos',
     @ContactTitle = 'Tutora',
     @Address = 'Calle del Infierno',
     @City = 'Tula',
     @Region = 'Sur',
     @PostalCode = '42800',
     @Country = 'Mexico',
     @Phone = '33-345678'


     select * from customers 
     where CustomerID = 'GTIG3'