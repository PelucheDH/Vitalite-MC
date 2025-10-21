-- Crear base de datos
CREATE DATABASE vitalite;

-- Conectarse a la BD
\c vitalite;

-- ======================
-- TABLA: Roles
-- ======================
CREATE TABLE roles (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT NULL
);

-- Insertar roles iniciales
INSERT INTO roles (nombre) VALUES ('admin'), ('cliente');

-- ======================
-- TABLA: Usuarios
-- ======================
CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(200) NOT NULL,
    telefono VARCHAR(20),
    rol_id INT REFERENCES roles(id) DEFAULT 2, -- 2 = cliente
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ======================
-- TABLA: Servicios
-- ======================
CREATE TABLE servicios (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    duracion INT, -- en minutos
    precio DECIMAL(8,2) NOT NULL,
    estado BOOLEAN DEFAULT TRUE -- activo/inactivo
);

-- ======================
-- TABLA: Reservas
-- ======================
CREATE TABLE reservas (
    id SERIAL PRIMARY KEY,
    usuario_id INT REFERENCES usuarios(id) ON DELETE CASCADE,
    servicio_id INT REFERENCES servicios(id) ON DELETE CASCADE,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    estado VARCHAR(20) DEFAULT 'pendiente', -- pendiente, confirmada, cancelada
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Índices para mejorar consultas
CREATE INDEX idx_reservas_usuario ON reservas(usuario_id);
CREATE INDEX idx_reservas_servicio ON reservas(servicio_id);
