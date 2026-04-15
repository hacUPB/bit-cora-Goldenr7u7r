# Actividad 2: Investiga el patrón observer

## Análisis del caso de estudio

Vuelve al código del caso de estudio (`ofApp.h` y `ofApp.cpp`).

1. **Identifica los Roles:**
   
    - ¿Qué clase actúa como la interfaz `Observer`? ¿Qué método define?

      La clase que actúa como interfaz `Observer` es la clase `Observer`. Define el métodpo `onNotify(const std::string& event)`.
      Es una interfaz abstracta porque tiene un método virtual puro (`= 0`), lo que obliga a las clases que heredan de ella a implementar este método para reaccionar a notificaciones.
      
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
      
    - Ve al método `notify` en la clase `Subject`. ¿Qué hace este método?
      
    - Localiza el método que implementa la interfaz `Observer` en la clase `Particle` (`onNotify`). ¿Qué hace este método cuando recibe el evento “attract”?
      
3. **Registro y eliminación de observadores:**
   
    - ¿En qué parte del código se añaden las instancias de `Particle` como observadores de `ofApp`? (Busca dónde se llama a `addObserver`).
      
    - Aunque no se usa explícitamente en este ejemplo simple, ¿Dónde se eliminarían los observadores si fuera necesario (por ejemplo, si una partícula se destruyera durante la ejecución)? (Busca `removeObserver`). ¿Por qué es importante el destructor de `ofApp` en este contexto?
