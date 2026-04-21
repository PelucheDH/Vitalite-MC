import express from "express";
import cors from "cors";
import dotenv from "dotenv";
import { pool } from "./config/db.js";
import userRoutes from "./routes/userRoutes.js"; 

dotenv.config({ quiet: true });

const app = express();
const PORT = 4000;

app.use(cors());
app.use(express.json());

app.use("/api/users", userRoutes); 

app.get("/", (req, res) => {
  res.send("Backend de Vitalité funcionando 🚀");
});

app.listen(PORT, () => {
  console.log(`Servidor corriendo en http://localhost:${PORT}`);
});
