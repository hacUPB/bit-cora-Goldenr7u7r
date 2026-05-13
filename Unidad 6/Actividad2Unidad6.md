# Actividad 2: Investiga el patrón observer

## Análisis del caso de estudio

Vuelve al código del caso de estudio (`ofApp.h` y `ofApp.cpp`).

1. **Identifica los Roles:**
   
    - ¿Qué clase actúa como la interfaz `Observer`? ¿Qué método define?

      La clase que actúa como interfaz `Observer` es la clase `Observer`. Define el método `onNotify(const std::string& event)`.
      
    - ¿Qué clase actúa como `Subject`? ¿Qué métodos proporciona para gestionar observadores y notificar?

      La clase que actua como `Subject` es `Subject`. Proporciona los siguientes métodos:

      - `addObserver(Observer* observer)` -> agrega observadores
      - `removeObserver(Observer* observer)` -> elimina observadores
      - `notify(const std::string& event)` -> notifica a los observadores
      
    - ¿Qué clase es el `ConcreteSubject` en esta aplicación? ¿Por qué? (Pista: ¿Quién *envía* las notificaciones?)

      El `ConcreteSubject` es:
      
      - La clase que realmente envía las notificaciones a los observadores
        
      - La implementación concreta del Subject
        
      La clase que actúa como `ConcreteSubject` es `ofApp`, ya que es la encargada de enviar las notificaciones a los observadores. Esto se evidencia en el método `keyPressed`, donde, al presionar una tecla, se llama al método `notify`, el cual envía un evento a todas las instancias registradas como observadores. Por lo tanto, `ofApp` es quien controla y dispara las notificaciones, cumpliendo el rol de sujeto concreto en el patrón Observer.

    - ¿Qué clase(s) actúan como `ConcreteObserver`? ¿Por qué? (Pista: ¿Quién *recibe* y *reacciona* a las notificaciones?)

      El `ConcreteObserver` es:

      - Una clase que implementa la interfaz Observer
      
      - La clase que recibe las notificaciones
     
      - La clase que reacciona a las notificaciones

      La clase que actúa como `ConcreteObserver` es `Particle`, ya que hereda de la interfaz `Observer` e implementa el método `onNotify`. Esta clase recibe las notificaciones enviadas por el `Subject` y reacciona a ellas modificando su estado interno (por ejemplo, cambiando a `AttractState`, `RepelState`, `StopState` o `NormalState`). Por lo tanto, cumple el rol de observador concreto, ya que no solo recibe los eventos, sino que también cambia su comportamiento en función de estos.
      
2. **Sigue el flujo de notificación:**
   
    - Localiza el método `keyPressed` en `ofApp.cpp`. ¿Qué sucede cuando se presiona la tecla ‘a’? ¿Qué método se llama?

      <img width="412" height="543" alt="image" src="https://github.com/user-attachments/assets/a0916682-383d-4380-b874-82bc866fca99" />
      
      Cuando se presiona la tecla "a" se notifica el evento "attract" en el método `Particle::onNotify(const std::string& event)`.
      
      <img width="605" height="521" alt="image" src="https://github.com/user-attachments/assets/2cc529aa-0a24-4704-9405-ac2487c7205f" />
      
      Hace que la partícula cambie de estado.
      
      <img width="955" height="143" alt="image" src="https://github.com/user-attachments/assets/557a61c6-7593-46ab-841a-eda7fe6d93bf" />

    - Ve al método `notify` en la clase `Subject`. ¿Qué hace este método?

      El método `notify` en la clase `Subject` se encarga de enviar un evento a todos los observadores registrados.
      
    - Localiza el método que implementa la interfaz `Observer` en la clase `Particle` (`onNotify`). ¿Qué hace este método cuando recibe el evento “attract”?
  
      <img width="728" height="538" alt="image" src="https://github.com/user-attachments/assets/5867b4e5-5aae-4fcd-b4b6-201a6a5f9f12" />

      Cuando el método recibe el evento "attract", cambia el estado de la partícula llamando a `setState(new AttractState())`

      <img width="603" height="518" alt="image" src="https://github.com/user-attachments/assets/8f69d4bd-ae86-4511-a53f-fb5da41d57bf" />
      
3. **Registro y eliminación de observadores:**
   
    - ¿En qué parte del código se añaden las instancias de `Particle` como observadores de `ofApp`? (Busca dónde se llama a `addObserver`).

      <img width="740" height="573" alt="image" src="https://github.com/user-attachments/assets/56b7166c-83a5-4d07-ad36-e05db155724c" />

      Las instancias de `Particle` se añaden como observadores en el método `setup()` de la clase `ofApp.cpp`.

    - Aunque no se usa explícitamente en este ejemplo simple, ¿Dónde se eliminarían los observadores si fuera necesario (por ejemplo, si una partícula se destruyera durante la ejecución)? (Busca `removeObserver`). ¿Por qué es importante el destructor de `ofApp` en este contexto?
  
      <img width="368" height="218" alt="image" src="https://github.com/user-attachments/assets/e13be42f-06a1-42f2-96b2-190bc4cbe933" />

