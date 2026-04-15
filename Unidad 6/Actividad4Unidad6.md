# Actividad 4: Investiga el patrón State

## Análisis del caso de estudio

1. **Identifica los componentes:**
   
    - ¿Cuál es la clase `Context`? ¿Qué miembro utiliza para mantener el estado actual?
      
    - ¿Cuál es la interfaz `State`? ¿Qué métodos importantes define? (Piensa en `update`, `onEnter`, `onExit`).
      
    - Enumera las clases `ConcreteState`. ¿Qué comportamiento específico encapsula cada una?
      
2. **Delegación del comportamiento:**
   
    - Observa el método `Particle::update()`. ¿Cómo delega la lógica de actualización al estado actual?
      
    - Compara el código dentro de `NormalState::update()`, `AttractState::update()`, `RepelState::update()` y `StopState::update()`. ¿Cómo encapsula cada clase un comportamiento diferente?
      
3. **Transiciones de estado:**
   
    - ¿Cómo cambia una `Particle` de un estado a otro? ¿Qué método es responsable de gestionar la transición? (Busca `setState`).
      
    - ¿Qué sucede dentro de `Particle::setState()`? ¿Por qué son importantes los métodos `onEnter` y `onExit` de la interfaz `State` (aunque no todos los estados concretos los usen extensivamente en este ejemplo)? ¿Qué gestionan `onEnter` y `onExit` en `NormalState`?
      
    - ¿Qué evento externo (mediado por el patrón Observer, que ya analizaste) desencadena la llamada a `setState` en una `Particle`?
