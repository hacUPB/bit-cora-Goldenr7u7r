# Actividad 3

`ofApp.h`

<img width="1917" height="1079" alt="image" src="https://github.com/user-attachments/assets/95f4c56f-91a9-4fcc-9afe-3584bdb5fc3c" />

<img width="1904" height="1079" alt="image" src="https://github.com/user-attachments/assets/f3bd896c-1aca-4f5a-8b60-6d4d35b0a341" />

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/84b966fa-af8f-44e7-969a-4cf75f52b883" />

---

- **Código `ofApp.h` con documentación**

``` c++
#pragma once
// Evita que este header se incluya más de una vez en el proceso de compilación.
// (Protege contra redefiniciones)

#include "ofMain.h"
// Incluye lo esencial de openFrameworks:
// clases (ofBaseApp, ofColor, ofMesh), funciones (ofGetWidth), y GLM (glm::vec2), etc.


// =====================
// Nodo para la lista
// =====================
class Node {
public:
    glm::vec2 position;
    // Guarda la posición 2D (x, y) del nodo en pantalla.

    Node* next;
    // Puntero al siguiente nodo de la lista.
    // Si next == nullptr, este nodo es el último.

    Node(glm::vec2 pos) : position(pos), next(nullptr) {}
    // Constructor:
    // - position queda inicializada con el valor pos
    // - next se inicializa como nullptr (por defecto no apunta a nada)
};


// =====================
// Lista enlazada simple
// =====================
class LinkedList {
public:
    Node* head;
    // Apunta al primer nodo de la lista.
    // Si head es nullptr, la lista está vacía.

    Node* tail;
    // Apunta al último nodo de la lista.
    // Se usa para insertar al final rápidamente.

    int size;
    // Cantidad de nodos en la lista.

    LinkedList() : head(nullptr), tail(nullptr), size(0) {}
    // Constructor:
    // - Inicializa una lista vacía.

    ~LinkedList() {
        clear();
    }
    // Destructor:
    // Al destruirse el objeto LinkedList, borra todos los nodos para evitar fugas de memoria.

    void push_back(glm::vec2 pos) {
        // Agrega un nuevo nodo al final.

        Node* newNode = new Node(pos);
        // Reserva memoria dinámicamente para el nodo y lo inicializa con pos.

        if (head == nullptr) {
            // Si la lista está vacía...
            head = tail = newNode;
            // El primer nodo es también el último.
        }
        else {
            // Si ya hay nodos...
            tail->next = newNode;
            // El último nodo actual apunta al nuevo.

            tail = newNode;
            // Actualizamos tail para que sea el nuevo último nodo.
        }

        size++;
        // Aumenta la cantidad de nodos.
    }

    void pop_back() {
        // Elimina el último nodo de la lista.

        if (head == nullptr)
            return;
        // Si está vacía, no hay nada que borrar.

        if (head == tail) {
            // Caso: solo hay 1 nodo.
            delete head;
            // Liberamos memoria de ese nodo.

            head = tail = nullptr;
            // Lista queda vacía.
        }
        else {
            // Caso: hay más de un nodo.
            Node* temp = head;
            // temp empieza en la cabeza para recorrer.

            while (temp->next != tail) {
                // Avanza hasta llegar al nodo justo antes del tail.
                temp = temp->next;
            }

            delete tail;
            // Borra el último nodo.

            tail = temp;
            // El penúltimo ahora es el último.

            tail->next = nullptr;
            // Como es el último, su next debe quedar en nullptr.
        }

        size--;
        // Disminuye la cantidad de nodos.
    }

    void clear() {
        // Borra todos los nodos de la lista y libera memoria.

        Node* current = head;
        // current apunta al nodo actual, empezando por head.

        while (current != nullptr) {
            // Mientras no lleguemos al final...

            Node* nextNode = current->next;
            // Guardamos el siguiente nodo antes de borrar el actual.

            delete current;
            // Liberamos memoria del nodo actual.

            current = nextNode;
            // Avanzamos al siguiente nodo.
        }

        head = tail = nullptr;
        // Lista vacía: no hay nodos.

        size = 0;
        // El tamaño vuelve a cero.
    }
};


// =====================
// App principal de oF
// =====================
class ofApp : public ofBaseApp {
public:
    LinkedList snake;
    // La serpiente es una lista enlazada de nodos.
    // Cada nodo tiene una posición y apunta al siguiente (segmento).

    float backgroundHue;
    // Guardará el hue del fondo, para animar el gradiente.

    void setup();
    // Se ejecuta una vez al iniciar.

    void update();
    // Se ejecuta cada frame (lógica).

    void draw();
    // Se ejecuta cada frame (dibujo).

    void keyPressed(int key);
    // Se ejecuta al presionar teclas.
};
```
`ofApp.cpp`

<img width="1919" height="1070" alt="image" src="https://github.com/user-attachments/assets/b6744c30-0bef-49ba-b99a-69c1efb68fae" />

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/9d586639-8e58-4b0f-8e50-80f21fcffc0b" />

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/8f92c577-bb41-4b50-bf39-f2f9c3108848" />

---

- **Código `ofApp.cpp` con documentación**

``` c++
#include "ofApp.h"
// Incluye la definición de ofApp, Node y LinkedList.


//--------------------------------------------------------------
void ofApp::setup() {
    // setup() corre una sola vez al inicio de la aplicación.

    backgroundHue = 0;
    // Inicia el tono del fondo en 0 (rojo en HSB).

    // Inicializa la serpiente con varios nodos en el centro
    for (int i = 0; i < 20; i++) {
        // Repite 20 veces para crear 20 segmentos.

        snake.push_back(glm::vec2(ofGetWidth() / 2, ofGetHeight() / 2));
        // Inserta un nodo al final de la lista (cola).
        // La posición es el centro de la pantalla:
        // ofGetWidth()/2 = centro X
        // ofGetHeight()/2 = centro Y
    }
}


//--------------------------------------------------------------
void ofApp::update() {
    // update() se ejecuta cada frame para actualizar la lógica.

    if (snake.head == nullptr)
        return;
    // Si la lista está vacía (no hay serpiente), no hay nada que actualizar.

    glm::vec2 target = glm::vec2(ofGetMouseX(), ofGetMouseY());
    // target empieza siendo la posición actual del mouse.
    // La cabeza intentará acercarse a este punto.

    float interpolationFactor = 0.2f;
    // Qué tanto se acerca en cada frame:
    // 0.2 = 20% hacia el target por frame.
    // (Más alto = más rápido, menos suave)

    Node* current = snake.head;
    // current apunta al primer nodo (cabeza) para recorrer la lista.

    while (current != nullptr) {
        // Recorremos cada nodo hasta el final (nullptr).

        // Mueve la posición del nodo hacia el target (interpolación lineal).
        // Fórmula: pos = pos*(1-a) + target*a
        current->position = glm::mix(current->position, target, interpolationFactor);

        target = current->position;
        // Ahora el target se vuelve la posición del nodo actual.
        // Esto hace que el siguiente nodo siga al anterior (efecto serpiente).

        current = current->next;
        // Avanzamos al siguiente nodo.
    }

    backgroundHue = fmod(backgroundHue + 0.1f, 255.0f);
    // Aumenta lentamente el hue del fondo.
    // fmod hace que vuelva a 0 después de 255 (ciclo de color).
}


//--------------------------------------------------------------
void ofApp::draw() {
    // draw() se ejecuta cada frame para renderizar en pantalla.

    ofColor color1 = ofColor::fromHsb(backgroundHue, 150, 240);
    // Crea un color usando HSB:
    // Hue = backgroundHue (cambia con el tiempo)
    // Saturation = 150 (intensidad)
    // Brightness = 240 (brillo)

    ofColor color2 = ofColor::fromHsb(fmod(backgroundHue + 128, 255), 150, 240);
    // Segundo color con hue desplazado 128 (aprox color complementario),
    // para que el gradiente tenga contraste.

    ofBackgroundGradient(color1, color2, OF_GRADIENT_LINEAR);
    // Dibuja un fondo degradado lineal con esos dos colores.

    if (snake.head == nullptr)
        return;
    // Si no hay nodos, no dibujamos nada más.

    ofMesh mesh;
    // Creamos una malla: guarda vértices y colores.

    mesh.setMode(OF_PRIMITIVE_LINE_STRIP);
    // Se dibuja como una línea continua que une los vértices en orden.

    Node* current = snake.head;
    // Apuntamos al primer nodo para recorrer otra vez.

    int index = 0;
    // Índice para calcular color por nodo.

    while (current) {
        // Recorremos todos los nodos.

        float hue = ofMap(index++, 0, snake.size - 1, 0, 255);
        // ofMap mapea el índice a un rango de hue:
        // cabeza ~0, cola ~255.
        // (Si index crece, el color va recorriendo el espectro)

        mesh.addColor(ofColor::fromHsb(hue, 200, 255));
        // Asigna un color para el vértice que vamos a agregar.

        mesh.addVertex(glm::vec3(current->position, 0.0f));
        // Agrega el vértice en posición (x,y) y z=0 para dibujar en 2D.

        current = current->next;
        // Avanza al siguiente nodo.
    }

    ofSetLineWidth(2);
    // Grosor de la línea.

    mesh.draw();
    // Dibuja la línea multicolor siguiendo la forma de la serpiente.


    // -----------------------------
    // Círculos con tamaño y color variable
    // -----------------------------
    current = snake.head;
    // Reiniciamos para volver a recorrer.

    index = 0;
    // Reiniciamos índice.

    ofNoFill();
    // Los círculos serán solo contorno.

    ofSetLineWidth(2);
    // Grosor del contorno.

    while (current) {
        // Para cada nodo...

        float hue = ofMap(index, 0, snake.size - 1, 0, 255);
        // Calcula el hue según la posición en la serpiente.

        ofSetColor(ofColor::fromHsb(hue, 220, 255));
        // Fija el color de dibujo actual.

        float radius = ofMap(index++, 0, snake.size - 1, 20, 5);
        // Radio decreciente:
        // cabeza = 20 aprox
        // cola = 5 aprox

        ofDrawCircle(current->position.x, current->position.y, radius);
        // Dibuja el círculo en la posición del nodo.

        current = current->next;
        // Avanza.
    }
}


//--------------------------------------------------------------
void ofApp::keyPressed(int key) {
    // Función llamada cuando se presiona una tecla.

    if (key == 'c') {
        // Si presionas 'c'...
        snake.clear();
        // Borra toda la serpiente liberando memoria.
    }
    else if (key == 'a') {
        // Si presionas 'a'...
        snake.push_back(glm::vec2(ofRandomWidth(), ofRandomHeight()));
        // Agrega un nuevo nodo al final en una posición random en pantalla.
    }
    else if (key == 'r') {
        // Si presionas 'r'...
        snake.pop_back();
        // Quita el último nodo.
    }
    else if (key == 's') {
        // Si presionas 's'...
        ofSaveFrame();
        // Guarda una captura del frame actual.
    }
}
```

#### Experimentación

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/6929c6ac-f605-4d5f-bd3f-650d53f3da78" />
