import pkg from 'pg';
import dotenv from 'dotenv';
dotenv.config({ path: './.env' }); 

const { Pool } = pkg;

export const pool = new Pool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASS,     
  database: process.env.DB_NAME,      
  port: process.env.DB_PORT,
});

pool.connect()
  .then(() => console.log('✅ Conectado a PostgreSQL'))
  .catch(err => console.error('❌ Error al conectar a PostgreSQL:', err));
