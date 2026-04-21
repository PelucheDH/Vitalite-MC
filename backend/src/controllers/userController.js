import bcrypt from 'bcrypt';
import { pool } from '../config/db.js';

// ✅ REGISTRO
export const registerUser = async (req, res) => {
  try {
    const { nombre, email, password, telefono, rol_id } = req.body;

    // Comprobar si ya existe el email
    const exists = await pool.query('SELECT * FROM usuarios WHERE email = $1', [email]);
    if (exists.rows.length > 0) {
      return res.status(400).json({ message: 'El correo ya está registrado' });
    }

    // Encriptar contraseña
    const hashedPassword = await bcrypt.hash(password, 10);

    // Insertar en la BD
    const result = await pool.query(
      `INSERT INTO usuarios (nombre, email, password, telefono, rol_id)
       VALUES ($1, $2, $3, $4, $5) RETURNING id, nombre, email, telefono, rol_id, fecha_registro`,
      [nombre, email, hashedPassword, telefono, rol_id || 2]
    );

    res.status(201).json({
      message: 'Usuario registrado correctamente ✅',
      usuario: result.rows[0],
    });
  } catch (error) {
    console.error('❌ Error en registro:', error);
    res.status(500).json({ message: 'Error en el servidor' });
  }
};

// ✅ LOGIN
export const loginUser = async (req, res) => {
  try {
    const { email, password } = req.body;

    const result = await pool.query('SELECT * FROM usuarios WHERE email = $1', [email]);
    if (result.rows.length === 0) {
      return res.status(404).json({ message: 'Usuario no encontrado' });
    }

    const usuario = result.rows[0];
    const validPassword = await bcrypt.compare(password, usuario.password);

    if (!validPassword) {
      return res.status(401).json({ message: 'Contraseña incorrecta' });
    }

    delete usuario.password; 

    res.json({
      message: 'Inicio de sesión exitoso ✅',
      usuario,
    });
  } catch (error) {
    console.error('❌ Error en login:', error);
    res.status(500).json({ message: 'Error en el servidor' });
  }
};