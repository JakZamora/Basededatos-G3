--MERGE INTO <target table> AS TGT
--USING <SOURCE TABLE> AS SRC  
--  ON <merge predicate>
--WHEN MATCHED [AND <predicate>] -- two clauses allowed:  
--  THEN <action> -- one with UPDATE one with DELETE
--WHEN NOT MATCHED [BY TARGET] [AND <predicate>] -- one clause allowed:  
--  THEN INSERT... –- if indicated, action must be INSERT
--WHEN NOT MATCHED BY SOURCE [AND <predicate>] -- two clauses allowed:  
--  THEN <action>; -- one with UPDATE one with DELETE


CREATE DATABASE Escuelita;
go 
use Escuelita
go

CREATE TABLE StudentsC1(

	 StudentID      INT
    ,StudentName    VARCHAR(50)
    ,StudentStatus  BIT
	);
go

INSERT INTO StudentsC1(StudentID, StudentName, StudentStatus) VALUES(1,'Axel Romero',1)
INSERT INTO StudentsC1(StudentID, StudentName, StudentStatus) VALUES(2,'Sofía Mora',1)
INSERT INTO StudentsC1(StudentID, StudentName, StudentStatus) VALUES(3,'Rogelio Rojas',0)
INSERT INTO StudentsC1(StudentID, StudentName, StudentStatus) VALUES(4,'Mariana Rosas',1)
INSERT INTO StudentsC1(StudentID, StudentName, StudentStatus) VALUES(5,'Roman Zavaleta',1)
go


CREATE TABLE StudentsC2(
    StudentID       INT
    ,StudentName    VARCHAR(50)
    ,StudentStatus  BIT
);
go

INSERT INTO StudentsC2(StudentID, StudentName, StudentStatus) VALUES(1,'Axel Romero Rendón',1)
INSERT INTO StudentsC2(StudentID, StudentName, StudentStatus) VALUES(2,'Sofía Mora Ríos',0)
INSERT INTO StudentsC2(StudentID, StudentName, StudentStatus) VALUES(6,'Mario Gonzalez Pae',1)
INSERT INTO StudentsC2(StudentID, StudentName, StudentStatus) VALUES(7,'Alberto García Morales',1)

go

select * from StudentsC1
Select * from StudentsC2

--REGISTROS QUE NO ESTAN EN ALGUNA TABLA	
Select * from 
StudentsC1 as c1
left join StudentsC2 as c2 
on c1.StudentID = c2.StudentID
where c2.StudentID is null;

select * from StudentsC1 as c1
inner join StudentsC2 as c2
on c1.StudentID = c2.StudentID

---Crear un Store Procedure que inserte y actualice la tabla StudentsC2 mediante los datos de 
--StudentsC1 utilizando consultas left join e inner join 

USE Escuelita;
GO

CREATE PROCEDURE ActualizarInsertarStudentsC2
AS
BEGIN
    -- Actualizar registros existentes en StudentsC2 con datos de StudentsC1
    UPDATE c2
    SET c2.StudentName = c1.StudentName,
        c2.StudentStatus = c1.StudentStatus
    FROM StudentsC2 c2
    INNER JOIN StudentsC1 c1 ON c2.StudentID = c1.StudentID;

    -- Insertar registros de StudentsC1 que no existen en StudentsC2
    INSERT INTO StudentsC2 (StudentID, StudentName, StudentStatus)
    SELECT c1.StudentID, c1.StudentName, c1.StudentStatus
    FROM StudentsC1 c1
    LEFT JOIN StudentsC2 c2 ON c1.StudentID = c2.StudentID
    WHERE c2.StudentID IS NULL;
END;
GO

CREATE OR ALTER PROCEDURE spu_carga_incrementada
as
begin
	begin transaction;

	BEgIN TRY

	END TRY

	BEGIN CATCH

	END CATCH;
END;


--MERGE INTO <target table> AS TGT
--USING <SOURCE TABLE> AS SRC  
--    ON <merge predicate>
--WHEN MATCHED [AND <predicate>] -- two clauses allowed:  
--    THEN <action> -- one with UPDATE one with DELETE
--WHEN NOT MATCHED [BY TARGET] [AND <predicate>] -- one clause allowed:  
--    THEN INSERT... –- if indicated, action must be INSERT
--WHEN NOT MATCHED BY SOURCE [AND <predicate>] -- two clauses allowed:  
--    THEN <action>; -- one with UPDATE one with DELETE

Create database Escuelita;
Go
use Escuelita;
Go
CREATE TABLE StudentsC1(
    StudentID        INT
    ,StudentName    VARCHAR(50)
    ,StudentStatus    BIT
);
GO

INSERT INTO StudentsC1(StudentID, StudentName, StudentStatus) VALUES(1,'Axel Romero',1)
INSERT INTO StudentsC1(StudentID, StudentName, StudentStatus) VALUES(2,'Sofía Mora',1)
INSERT INTO StudentsC1(StudentID, StudentName, StudentStatus) VALUES(3,'Rogelio Rojas',0)
INSERT INTO StudentsC1(StudentID, StudentName, StudentStatus) VALUES(4,'Mariana Rosas',1)
INSERT INTO StudentsC1(StudentID, StudentName, StudentStatus) VALUES(5,'Roman Zavaleta',1)
GO

CREATE TABLE StudentsC2(
    StudentID        INT
    ,StudentName    VARCHAR(50)
    ,StudentStatus    BIT
);
GO

INSERT INTO StudentsC2(StudentID, StudentName, StudentStatus) VALUES(1,'Axel Romero Rendón',1)
INSERT INTO StudentsC2(StudentID, StudentName, StudentStatus) VALUES(2,'Sofía Mora Ríos',0)
INSERT INTO StudentsC2(StudentID, StudentName, StudentStatus) VALUES(6,'Mario Gonzalez Pae',1)
INSERT INTO StudentsC2(StudentID, StudentName, StudentStatus) VALUES(7,'Alberto García Morales',1)

Go

Select * from StudentsC1
Select * from StudentsC2

select * from
StudentsC1 as c1
left join StudentsC2 as c2
on c1.StudentID = c2.StudentID
where c2.StudentID is null;


select * from
StudentsC1 as c1
inner join
StudentsC2 as c2
on c1.StudentID = c2.StudentID;

--- Crear un store procedure que inserte y actualice la tabla
-- Student2 mediante los datos de Student1 utilizando consultas left join
-- e inner join
GO

CREATE OR ALTER PROCEDURE spu_carga_incremental_Students
AS
begin
    begin transaction;

    BEGIN TRY
       -- SE INSERTAN ESTUDIANTES NUEVOS
       INSERT INTO StudentsC2 (StudentID,StudentName, StudentStatus)
       select C1.StudentID, C1.StudentName, C1.StudentStatus
       from StudentsC1 as c1
       left join StudentsC2 as c2
       on c1.StudentID = c2.StudentID
       where c2.StudentID is null;

       -- SE ACTUALIZAN LOS DATOS QUE HAYAN CAMBIADO EN STUDENT1
       UPDATE C2
       SET C2.StudentName = C1.StudentName,
       C2.StudentStatus = C1.StudentStatus
       from
       StudentsC1 as c1
       inner join
       StudentsC2 as c2
       on c1.StudentID = c2.StudentID;

       COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
    ROLLBACK TRANSACTION
    DECLARE @mensajeError nvarchar(max)
    set @mensajeError = ERROR_MESSAGE()
    Print @mensajeError
    END CATCH;
end;
GO

EXECUTE spu_carga_incremental_Students
go

TRUNCATE TABLE STUDENTsc1
TRUNCATE TABLE STUDENTsc2
GO
--- Crear un store procedure que inserte y actualice la tabla
-- Student2 mediante los datos de Student1 utilizando un MERGE
CREATE OR ALTER PROCEDURE spu_carga_incremental_Students_Merge
AS
begin
    begin transaction;

    BEGIN TRY

       MERGE INTO Studentsc2 as tgt
       USING (
           select StudentID, StudentName, StudentStatus
           from StudentsC1
       ) AS src
       ON (
           tgt.studentid = src.studentid
       )
       -- For updates
       WHEN MATCHED THEN
        UPDATE
        SET tgt.studentName = src.studentName,
            tgt.StudentStatus = src.StudentStatus

        -- For Inserts
        WHEN NOT MATCHED THEN
        Insert (studentid, studentname, studentstatus)
        values(src.studentid, src.studentname,src.studentstatus);

       COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
    ROLLBACK TRANSACTION
    DECLARE @mensajeError nvarchar(max)
    set @mensajeError = ERROR_MESSAGE()
    Print @mensajeError
    END CATCH;
end;
GO

exec spu_carga_incremental_Students_Merge

insert into StudentsC1
values(6, 'Joseph Yañez', 1)

update StudentsC1
set StudentStatus = 0,
StudentName = 'Joseph Ñañu'
where StudentID = 6