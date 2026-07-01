CREATE DATABASE SistemaTriajeDigital_2;
GO

USE SistemaTriajeDigital_2;
GO

-- 1. Usuarios del sistema
CREATE TABLE Usuario (
    UsuarioID INT PRIMARY KEY IDENTITY(1,1),
    NombreCompleto VARCHAR(150) NOT NULL,
    DNI CHAR(8) UNIQUE NOT NULL,
    Rol VARCHAR(50) CHECK (Rol IN ('Medico', 'Enfermero', 'Administrativo')),
    NombreUsuario VARCHAR(50) UNIQUE NOT NULL,
    Contrasena VARCHAR(255) NOT NULL,
    Estado BIT DEFAULT 1
);
GO

-- 2. Especialidades médicas
CREATE TABLE Especialidad (
    EspecialidadID INT PRIMARY KEY IDENTITY(1,1),
    NombreEspecialidad VARCHAR(100) NOT NULL
);
GO

-- 3. Información específica del Médico
CREATE TABLE Medico (
    MedicoID INT PRIMARY KEY IDENTITY(1,1),
    UsuarioID INT UNIQUE FOREIGN KEY REFERENCES Usuario(UsuarioID),
    Colegiatura VARCHAR(20) UNIQUE NOT NULL,
    EspecialidadID INT FOREIGN KEY REFERENCES Especialidad(EspecialidadID),
    Consultorio VARCHAR(10)
);
GO

-- 4. Datos del Paciente
CREATE TABLE Paciente (
    PacienteID INT PRIMARY KEY IDENTITY(1,1),
    DNI CHAR(8) UNIQUE NOT NULL,
    Nombres VARCHAR(100) NOT NULL,
    Apellidos VARCHAR(100) NOT NULL,
    FechaNacimiento DATE,
    Genero CHAR(1),
    Telefono VARCHAR(15)
);
GO

-- 5. NUEVA: Historial Clínico
CREATE TABLE HistorialClinico (
    HistorialID INT PRIMARY KEY IDENTITY(1,1),
    PacienteID INT UNIQUE FOREIGN KEY REFERENCES Paciente(PacienteID),
    EnfermedadesCronicas VARCHAR(MAX) NULL,
    Alergias VARCHAR(MAX) NULL,             
    GrupoSanguineo VARCHAR(5) NULL,           
    AntecedentesFamiliares VARCHAR(MAX) NULL, 
    FechaCreacion DATETIME DEFAULT GETDATE()
);
GO

-- 6. Registro de Signos Vitales
CREATE TABLE SignosVitales (
    SignosID INT PRIMARY KEY IDENTITY(1,1),
    PacienteID INT FOREIGN KEY REFERENCES Paciente(PacienteID),
    Temperatura DECIMAL(4,2),
    PresionArterial VARCHAR(10),
    FrecuenciaCardiaca INT,
    FrecuenciaRespiratoria INT,
    SaturacionOxigeno INT,
    FechaRegistro DATETIME DEFAULT GETDATE()
);
GO

-- 7. Evaluación de Triaje
CREATE TABLE Triaje (
    TriajeID INT PRIMARY KEY IDENTITY(1,1),
    PacienteID INT FOREIGN KEY REFERENCES Paciente(PacienteID),
    UsuarioID INT FOREIGN KEY REFERENCES Usuario(UsuarioID),
    Sintomas TEXT,
    Prioridad VARCHAR(20) CHECK (Prioridad IN ('Grave', 'Moderado', 'Leve')),
    FechaTriaje DATETIME DEFAULT GETDATE(),
    Observaciones VARCHAR(MAX)
);
GO

-- 8. Gestión de Cola y Atención Médica
CREATE TABLE ColaAtencion (
    ColaID INT PRIMARY KEY IDENTITY(1,1),
    TriajeID INT FOREIGN KEY REFERENCES Triaje(TriajeID),
    MedicoID INT NULL FOREIGN KEY REFERENCES Medico(MedicoID),
    EstadoAtencion VARCHAR(20) DEFAULT 'En Espera' 
        CHECK (EstadoAtencion IN ('En Espera', 'En Atención', 'Atendido')),
    TurnoPrioridad INT,
    HoraLlamada DATETIME NULL,
    HoraFinAtencion DATETIME NULL,
    FechaActualizacion DATETIME DEFAULT GETDATE()
);
GO
