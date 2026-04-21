-- ============================================
-- LIMPIEZA INICIAL
-- ============================================
DROP SCHEMA IF EXISTS mod_chatbot CASCADE;
DROP SCHEMA IF EXISTS mod_appweb CASCADE;
DROP SCHEMA IF EXISTS mod_gestion CASCADE;
DROP SCHEMA IF EXISTS mod_auditoria CASCADE;

-- ============================================
-- CREACIÓN DE ESQUEMAS
-- ============================================
CREATE SCHEMA IF NOT EXISTS mod_gestion;
CREATE SCHEMA IF NOT EXISTS mod_appweb;
CREATE SCHEMA IF NOT EXISTS mod_chatbot;
CREATE SCHEMA IF NOT EXISTS mod_auditoria;

-- ============================================
-- SCHEMA: mod_gestion (Módulo 3: Gestión de Contenidos)
-- ============================================
CREATE TABLE mod_gestion.servicios (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    duracion INT,                
    precio NUMERIC(10,2) NOT NULL,
    imagen_url TEXT
);

CREATE TABLE mod_gestion.promociones (
    id SERIAL PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    descripcion TEXT,
    descuento NUMERIC(5,2),
    fecha_inicio DATE,
    fecha_fin DATE,
    servicio_id INT REFERENCES mod_gestion.servicios(id) ON DELETE SET NULL
);

-- ============================================
-- SCHEMA: mod_appweb (Módulo 1: Aplicación Web)
-- ============================================
CREATE TABLE mod_appweb.roles (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE mod_appweb.usuarios (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    telefono VARCHAR(20),
    rol_id INT REFERENCES mod_appweb.roles(id) DEFAULT 2,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE mod_appweb.reservas (
    id SERIAL PRIMARY KEY,
    usuario_id INT REFERENCES mod_appweb.usuarios(id),
    servicio_id INT REFERENCES mod_gestion.servicios(id),
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    estado VARCHAR(20) DEFAULT 'pendiente',
    tipo_pago VARCHAR(20) DEFAULT 'en_sitio',
    total NUMERIC(10,2),
    promocion_id INT REFERENCES mod_gestion.promociones(id),
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE mod_appweb.pagos (
    id SERIAL PRIMARY KEY,
    reserva_id INT REFERENCES mod_appweb.reservas(id) ON DELETE CASCADE,
    metodo VARCHAR(50),
    monto NUMERIC(10,2),
    fecha_pago TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    estado VARCHAR(20) DEFAULT 'completado'
);

-- ============================================
-- SCHEMA: mod_chatbot (Módulo 2: ChatBot mediante Dialogflow)
-- ============================================
CREATE TABLE mod_chatbot.historial_chatbot (
    id SERIAL PRIMARY KEY,
    usuario_id INT REFERENCES mod_appweb.usuarios(id) ON DELETE CASCADE,
    consulta TEXT NOT NULL,
    respuesta TEXT,
    categoria VARCHAR(100),
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE mod_chatbot.recomendaciones (
    id SERIAL PRIMARY KEY,
    usuario_id INT REFERENCES mod_appweb.usuarios(id) ON DELETE CASCADE,
    servicio_id INT REFERENCES mod_gestion.servicios(id),
    motivo TEXT,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- SCHEMA: mod_auditoria (Módulo 4: Auditoría del Sistema)
-- ============================================
CREATE TABLE mod_auditoria.auditoria_eventos (
    id SERIAL PRIMARY KEY,
    usuario_id INT REFERENCES mod_appweb.usuarios(id) ON DELETE SET NULL,
    accion VARCHAR(150) NOT NULL,
    descripcion TEXT,
    tabla_afectada VARCHAR(100),
    id_registro_afectado INT,
    fecha_evento TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ip_origen VARCHAR(50)
);

COMMENT ON TABLE mod_auditoria.auditoria_eventos IS
'Registra las acciones relevantes de los usuarios dentro del sistema para asegurar trazabilidad.';

CREATE TABLE mod_auditoria.auditoria_errores (
    id SERIAL PRIMARY KEY,
    usuario_id INT REFERENCES mod_appweb.usuarios(id) ON DELETE SET NULL,
    modulo VARCHAR(100),
    descripcion_error TEXT NOT NULL,
    severidad VARCHAR(20) DEFAULT 'media',
    fecha_error TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ruta_endpoint TEXT,
    detalle_tecnico TEXT
);

COMMENT ON TABLE mod_auditoria.auditoria_errores IS
'Registra los errores del sistema ocurridos durante la ejecución de procesos o solicitudes.';