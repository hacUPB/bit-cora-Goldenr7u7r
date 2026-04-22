# Actividad 4: Investiga el patrón State

## Análisis del caso de estudio

1. **Identifica los componentes:**
   
    - ¿Cuál es la clase `Context`? ¿Qué miembro utiliza para mantener el estado actual?
  
      La clase `Context` es `Particle`. Mantiene el estado actual mediante el miembro `State * state`.
      
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

      En `Particle::update()`, la partícula no implementa directamente la lógica de movimiento, sino que llama a `state->update(this)`.
      
    - Compara el código dentro de `NormalState::update()`, `AttractState::update()`, `RepelState::update()` y `StopState::update()`. ¿Cómo encapsula cada clase un comportamiento diferente?
  
      Cada clase de estado implementa su propio método `update()` con una lógica distinta. `NormalState` mueve la partícula con su velocidad normal; `AttractState` la hace acercarse al mouse; `RepelState` la hace alejarse del mouse; y `StopState` reduce poco a poco su velocidad hasta detenerla.
      
2. **Transiciones de estado:**
   
    - ¿Cómo cambia una `Particle` de un estado a otro? ¿Qué método es responsable de gestionar la transición? (Busca `setState`).

      Una `Particle` cambia de estado cuando se llama al método `setState()`, que es el encargado de gestionar la transición entre el estado actual y el nuevo.
      
    - ¿Qué sucede dentro de `Particle::setState()`? ¿Por qué son importantes los métodos `onEnter` y `onExit` de la interfaz `State` (aunque no todos los estados concretos los usen extensivamente en este ejemplo)? ¿Qué gestionan `onEnter` y `onExit` en `NormalState`?

      Dentro de `setState()`, primero se ejecuta `onExit()` del estado anterior, luego ese estado se elimina, después se asigna el nuevo estado y finalmente se ejecuta `onEnter()` del nuevo estado. `onEnter` y `onExit` son importantes porque permiten preparar o limpiar lo necesario al cambiar de estado. En este ejemplo, en `NormalState`, `onEnter()` reasigna una velocidad aleatoria a la partícula.

    - ¿Qué evento externo (mediado por el patrón Observer, que ya analizaste) desencadena la llamada a `setState` en una `Particle`?
  
      La llamada a `setState()` se desencadena cuando la partícula recibe una notificación en `onNotify()`, a partir de un evento enviado por `notify()` desde `ofApp::keyPressed()`.
