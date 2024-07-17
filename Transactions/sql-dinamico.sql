use Northwind

--Store Procedure que visualice los resultados de cualquier tabla  en northwind

--Select * from [Tabla]


USE Northwind;
GO

CREATE PROCEDURE VisualizarTabla
    @NombreTabla NVARCHAR(128)
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);

    SET @sql = N'SELECT * FROM ' + QUOTENAME(@NombreTabla);

    EXEC sp_executesql @sql;
END;
GO

EXEC VisualizarTabla @NombreTabla = 'Customers';


