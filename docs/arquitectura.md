Diseño Arquitectónico del Sistema
1.-Arquitectura seleccionada

El sistema Vitalité Massage Center se desarrolla bajo una arquitectura en N-capas (Layered Architecture).
Este modelo divide la aplicación en capas independientes, cada una con responsabilidades específicas, lo que permite una estructura mantenible, segura y escalable.

Las capas definidas son:

Capa de Presentación: interfaz React.js y ChatBot Dialogflow.

Capa de Negocio: controladores, middleware y servicios de Express.

Capa de Datos: conexión y operaciones en PostgreSQL.

Capa Transversal: seguridad, validaciones, autenticación, configuración.

2.-Diagrama lógico de la arquitectura en N-capas

El siguiente diagrama muestra la estructura lógica del sistema, destacando las capas principales y la comunicación entre ellas.

flowchart TB
  subgraph Front["Capa de Presentación (Frontend React.js)"]
    UI["Interfaz de Usuario<br/>Componentes y Páginas React"]
  end

  subgraph API["Capa de Integración (API REST Express)"]
    Routes["Rutas /api/..."]
  end

  subgraph Business["Capa de Negocio (Aplicación)"]
    Controllers["Controladores: usuarios, reservas, servicios, promociones"]
    Middleware["Middleware: autenticación, validaciones"]
    Utils["Utilidades: token, helpers"]
  end

  subgraph Data["Capa de Datos (PostgreSQL)"]
    Models["Modelos: userModel, serviceModel, bookingModel, promoModel"]
    DB["Esquemas: mod_appweb, mod_gestion, mod_chatbot"]
  end

  UI -->|"Axios / HTTPS"| Routes
  Routes --> Controllers
  Controllers --> Models
  Models --> DB
  Controllers --> Middleware
  Controllers --> Utils

Descripción:

Cada capa tiene una responsabilidad clara.

Las solicitudes del usuario pasan del frontend al backend, donde se ejecuta la lógica de negocio.

La información se obtiene o guarda en PostgreSQL, dividido en tres esquemas para cada módulo.

Los middleware y utilidades se aplican de forma transversal (autenticación, validación, seguridad).

3.-Diagrama físico de despliegue del sistema

El siguiente diagrama muestra cómo se distribuyen los componentes del sistema en los distintos entornos físicos (cliente, servidor y nube).

flowchart TB
  U["👩‍🦰 Usuario final<br/>(Navegador o móvil)"]
  F["🌐 Frontend React.js<br/>(Interfaz web en navegador)"]
  B["⚙️ Backend Node.js + Express<br/>(Servidor API REST en localhost o nube)"]
  DB["💾 PostgreSQL<br/>(Base de datos con esquemas mod_appweb, mod_gestion, mod_chatbot)"]
  D["🤖 Dialogflow ES<br/>(ChatBot en la nube de Google)"]

  U -->|"HTTPS / HTTP"| F
  F -->|"Petición REST / JSON"| B
  B -->|"Consultas SQL (TCP 5432)"| DB
  D -->|"Webhook HTTPS"| B
  B -->|"Respuestas JSON"| F

Descripción:

El usuario accede al Frontend React.js, alojado localmente o en un hosting.

El frontend se comunica con el Backend Node.js + Express mediante peticiones HTTPS/REST.

El backend maneja la lógica del negocio y consulta la base de datos PostgreSQL.

El ChatBot Dialogflow se integra mediante un webhook HTTPS, registrando consultas y respuestas del usuario.

4.-Conclusión

La adopción de la arquitectura en N-capas garantiza una correcta separación de responsabilidades, facilitando el mantenimiento, la escalabilidad y la integración con servicios externos como Dialogflow.
Esta organización cumple con los principios de la ingeniería de software moderna y los atributos de calidad definidos en la norma ISO/IEC 25010: eficiencia de desempeño