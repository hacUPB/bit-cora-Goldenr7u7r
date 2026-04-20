# Actividad 4: Investiga el patrón State

## Análisis del caso de estudio

1. **Identifica los componentes:**
   
    - ¿Cuál es la clase `Context`? ¿Qué miembro utiliza para mantener el estado actual?
      
    - ¿Cuál es la interfaz `State`? ¿Qué métodos importantes define? (Piensa en `update`, `onEnter`, `onExit`).
  
      <img width="649" height="248" alt="image" src="https://github.com/user-attachments/assets/5a5e412c-3011-4256-bf4c-9edfd690c7f2" />

      La interfaz `State` es la clase `State`, donde se definen los métodos `update`, `onEnter` y `onExit`
      
    - Enumera las clases `ConcreteState`. ¿Qué comportamiento específico encapsula cada una?

         - `NormalState`
           
           <img width="630" height="195" alt="image" src="https://github.com/user-attachments/assets/46c0bfdc-fb7a-4455-9b26-0992513b5e77" />
           
           <img width="975" height="281" alt="image" src="https://github.com/user-attachments/assets/01fd4f83-6b11-449d-ae03-0f330c426f13" />
           
         - `AttractState`
     
           <img width="786" height="118" alt="image" src="https://github.com/user-attachments/assets/9cd0e3b9-bf5a-4a6b-ba3e-51751f1c2951" />
           
         - `RepelState`
     
           <img width="530" height="293" alt="image" src="https://github.com/user-attachments/assets/246dd07f-2817-4495-8524-0939ee4985ac" />
           
         - `StopState`
     
           <img width="519" height="207" alt="image" src="https://github.com/user-attachments/assets/ed78e4ac-5859-453f-af0d-726db9bc92ed" />





1. **Delegación del comportamiento:**
   
    - Observa el método `Particle::update()`. ¿Cómo delega la lógica de actualización al estado actual?
      
    - Compara el código dentro de `NormalState::update()`, `AttractState::update()`, `RepelState::update()` y `StopState::update()`. ¿Cómo encapsula cada clase un comportamiento diferente?
      
2. **Transiciones de estado:**
   
    - ¿Cómo cambia una `Particle` de un estado a otro? ¿Qué método es responsable de gestionar la transición? (Busca `setState`).
      
    - ¿Qué sucede dentro de `Particle::setState()`? ¿Por qué son importantes los métodos `onEnter` y `onExit` de la interfaz `State` (aunque no todos los estados concretos los usen extensivamente en este ejemplo)? ¿Qué gestionan `onEnter` y `onExit` en `NormalState`?
      
    - ¿Qué evento externo (mediado por el patrón Observer, que ya analizaste) desencadena la llamada a `setState` en una `Particle`?
