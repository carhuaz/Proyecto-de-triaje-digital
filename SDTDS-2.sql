USE SistemaTriajeDigital_2;
GO

-- A. Creación de Roles de Base de Datos
CREATE ROLE Rol_Administrativo;
CREATE ROLE Rol_Enfermero;
CREATE ROLE Rol_Medico;
GO

-- B. Asignación de Permisos al Rol Administrativo
GRANT SELECT, INSERT, UPDATE ON Paciente TO Rol_Administrativo;
GRANT SELECT, INSERT, UPDATE ON HistorialClinico TO Rol_Administrativo;
GO

-- C. Asignación de Permisos al Rol Enfermero
GRANT SELECT ON Paciente TO Rol_Enfermero;
GRANT SELECT ON HistorialClinico TO Rol_Enfermero;
GRANT SELECT, INSERT ON SignosVitales TO Rol_Enfermero;
GRANT SELECT, INSERT ON Triaje TO Rol_Enfermero;
GRANT SELECT, INSERT, UPDATE ON ColaAtencion TO Rol_Enfermero;
GO

-- D. Asignación de Permisos al Rol Médico
GRANT SELECT ON Paciente TO Rol_Medico;
GRANT SELECT ON HistorialClinico TO Rol_Medico;
GRANT SELECT ON SignosVitales TO Rol_Medico;
GRANT SELECT ON Triaje TO Rol_Medico;
GRANT SELECT, UPDATE ON ColaAtencion TO Rol_Medico; -- Para cambiar estado a 'En Atención' o 'Atendido'
GRANT SELECT ON Medico TO Rol_Medico;
GO

-- RESPALDO DE LA BASE DE DATOS -> BACKUP
-- 1. Ejecución de un Respaldo Completo (Full Backup)
BACKUP DATABASE SistemaTriajeDigital_2
TO DISK = 'C:\Backups\SistemaTriajeDigital_2_Full.bak'
WITH FORMAT,
     MEDIANAME = 'SQLServerBackups',
     NAME = 'Full Backup de SistemaTriajeDigital_2';
GO

-- 2. Ejecución de un Respaldo Diferencial (Suponiendo que ya existe el Full)
BACKUP DATABASE SistemaTriajeDigital_2
TO DISK = 'C:\Backups\SistemaTriajeDigital_2_Diff.bak'
WITH DIFFERENTIAL,
     NAME = 'Differential Backup de SistemaTriajeDigital_2';
GO
