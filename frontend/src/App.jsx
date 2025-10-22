import { useState } from 'react'
import reactLogo from './assets/react.svg'
import viteLogo from '/vite.svg'
import './App.css'

function App() {
  const [count, setCount] = useState(0)

  return (
    <div style={{ textAlign: "center", marginTop: "80px" }}>
      <h1>Vitalité Massage Center</h1>
      <p>Bienvenido a la interfaz inicial del sistema 🌿</p>
    </div>
  )
}

export default App
