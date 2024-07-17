-- Las transacciones son fundamentales para asegurar la consistencia 
--y la integridad de los datos

-- Transaccion: es una unidad de trabajo que se ejecuta de manera completamente exitosa
--o no se ejecuta en absoluto

--Begin Transaction : inicia una nueva transaccion
-- commit transaction : confirma todos los cambios realizados
--durante la transaccion
--Rollback Transaction: REvierte todos los cambios realizados
--durante la transaccion 

use Northwind

select * from Categories

begin transaction 

insert into Categories (CategoryName, Description)
values ('Categoria11', 'Los remediales')

rollback transaction

commit transaction

- Ejercicio 1. Realizar una venta dentro de la bd Northwind 
-- usando transacciones y store procedures

CREATE OR ALTER PROCEDURE sp_nuevaVenta
	@CustomerID nchar(5),
    @EmployeeID int,
    @OrderDate datetime,
    @RequiredDate datetime,
    @ShippedDate datetime,
    @ShipVia int,
    @Freight money = null,
    @ShipName nvarchar(40)=null,
    @ShipAddress nvarchar(60)=null,
    @ShipCity nvarchar(15)=null,
    @ShipRegion nvarchar(15)=null,
    @ShipPostalCode nvarchar(15) = null,
    @ShipCountry nvarchar(15) = null,
    @ProductID int,
    @UnitPrice money,
    @Quantity smallint,
    @Discount real
AS
BEGIN
Begin transaction
	begin try
	--Insertar en la tabla order
	INSERT INTO Northwind.dbo.Orders
           ([CustomerID]
           ,[EmployeeID]
           ,[OrderDate]
           ,[RequiredDate]
           ,[ShippedDate]
           ,[ShipVia]
           ,[Freight]
           ,[ShipName]
           ,[ShipAddress]
           ,[ShipCity]
           ,[ShipRegion]
           ,[ShipPostalCode]
           ,[ShipCountry])
     VALUES
           (@CustomerID,
           @EmployeeID,
           @OrderDate,
           @RequiredDate,
           @ShippedDate, 
           @ShipVia, 
           @Freight,
           @ShipName, 
           @ShipAddress, 
           @ShipCity, 
           @ShipRegion, 
           @ShipPostalCode, 
           @ShipCountry);

		   -- Obtener el ID insertado de la orden
		   Declare @orderId int
		   set @orderId = SCOPE_IDENTITY();

		   -- INSERTAR EN DETALLE_ORDEN EL PRODUCTO
		   -- OBTENER EL PRECIO DEL PRODUCTO A INSERTAR
		   DECLARE @PrecioVenta money 
		   select @PrecioVenta = UnitPrice from Products
		   where ProductID = @ProductID
		   --INSERTAR EN LA TABLA ORDER DETAILS
		   INSERT INTO Northwind.dbo.[Order Details]
           ([OrderID]
           ,[ProductID]
           ,[UnitPrice]
           ,[Quantity]
           ,[Discount])
     VALUES
           (@orderId,
           @ProductID,
           @Quantity, 
           @PrecioVenta, 
           @Discount);

	--Actualizar la tabla productos el campos unitsinstocks
	update products 
	set UnitsInStock = UnitsInStock - @Quantity
	where @ProductID = @ProductID

	commit transaction 

	end try
	begin catch
	rollback transaction
		Declare @mensajeError varchar(400)
		set @mensajeError = ERROR_MESSAGE()
		print @mensajeError
	end catch


END
GO;
use Northwind
select * from Products


exec sp_nuevaVenta 
