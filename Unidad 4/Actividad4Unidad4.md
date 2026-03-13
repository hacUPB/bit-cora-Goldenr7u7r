# Actividad 4: En esta actividad te toca a ti analizar una estructura de datos e implementarla.

``ofApp.h``

``` c++
#pragma once                          // Evita que este archivo se incluya más de una vez en la compilación
#include "ofMain.h"                   // Incluye la librería principal de openFrameworks

struct Node {                         // Definición de la estructura Node (nodo de la lista enlazada)

    float x, y;                       // Coordenadas del trazo en la pantalla
    float radius;                     // Radio del círculo que se dibujará
    ofColor color;                    // Color del círculo
    float opacity;                    // Opacidad del círculo
    Node* next;                       // Puntero al siguiente nodo de la cola

    Node(float _x, float _y, float _radius, ofColor _color, float _opacity)
        : x(_x), y(_y), radius(_radius), color(_color), opacity(_opacity), next(nullptr) {}
                                     // Constructor que inicializa todas las variables del nodo
};


class BrushQueue {                   // Clase que implementa una cola FIFO usando nodos enlazados

public:

    Node* front;                     // Puntero al nodo más antiguo de la cola
    Node* rear;                      // Puntero al nodo más reciente de la cola

    int size;                        // Número actual de nodos en la cola
    int maxSize;                     // Tamaño máximo permitido de la cola

    BrushQueue(int _maxSize);        // Constructor de la cola
    ~BrushQueue();                   // Destructor que libera memoria

    void enqueue(float x, float y, float radius, ofColor color, float opacity);
                                     // Inserta un nuevo nodo al final de la cola

    void dequeue();                  // Elimina el nodo más antiguo de la cola

    void clear();                    // Elimina todos los nodos de la cola
    bool isEmpty();                  // Verifica si la cola está vacía
};


BrushQueue::BrushQueue(int _maxSize)
    : front(nullptr), rear(nullptr), size(0), maxSize(_maxSize) {}
                                     // Inicializa la cola vacía con tamaño máximo definido


BrushQueue::~BrushQueue() {          
    clear();                         // Al destruir la cola se eliminan todos los nodos para evitar fugas de memoria
}


void BrushQueue::enqueue(float x, float y, float radius, ofColor color, float opacity) {

    Node* newNode = new Node(x, y, radius, color, opacity);
                                     // Crea dinámicamente un nuevo nodo con los datos del trazo

    if (isEmpty()) {                 // Si la cola está vacía

        front = newNode;             // El nuevo nodo se convierte en el primero
        rear = newNode;              // También es el último

    } else {                         // Si la cola ya tiene nodos

        rear->next = newNode;        // El último nodo actual apunta al nuevo nodo
        rear = newNode;              // El nuevo nodo pasa a ser el último de la cola
    }

    size++;                          // Aumenta el número de nodos en la cola

    if (size > maxSize) {            // Si se supera el tamaño máximo permitido
        dequeue();                   // Se elimina el nodo más antiguo (FIFO)
    }
}


void BrushQueue::dequeue() {

    if (isEmpty()) return;           // Si la cola está vacía no se hace nada

    Node* temp = front;              // Guarda el nodo más antiguo en una variable temporal

    front = front->next;             // El segundo nodo pasa a ser el nuevo frente

    delete temp;                     // Libera la memoria del nodo eliminado

    size--;                          // Reduce el tamaño de la cola

    if (front == nullptr) {          // Si después de eliminar no quedan nodos
        rear = nullptr;              // El final también se vuelve nulo
    }
}


void BrushQueue::clear() {

    while (!isEmpty()) {             // Mientras la cola tenga nodos
        dequeue();                   // Se elimina el nodo más antiguo
    }
}


bool BrushQueue::isEmpty() {

    return front == nullptr;         // La cola está vacía si el frente es nullptr
}


class ofApp : public ofBaseApp {     // Clase principal de la aplicación openFrameworks

public:

    BrushQueue strokes;              // Cola que almacenará los trazos del mouse
    float backgroundHue = 0;         // Variable que controla el color dinámico del fondo

    ofApp() : strokes(50) {}         // Constructor que inicia la cola con tamaño máximo 50

    void setup();                    // Se ejecuta una vez al iniciar el programa
    void update();                   // Se ejecuta cada frame para actualizar lógica
    void draw();                     // Se ejecuta cada frame para dibujar
    void keyPressed(int key);        // Detecta teclas presionadas
};
```

``ofApp.cpp``

``` c++
#include "ofApp.h"                   // Incluye la definición de la aplicación


void ofApp::setup() {

    ofBackground(0);                 // Establece el fondo inicial negro

    ofSetCircleResolution(60);       // Mejora la calidad visual de los círculos dibujados
}


void ofApp::update() {

    backgroundHue += 0.2;            // Incrementa gradualmente el color del fondo

    if (backgroundHue > 255)         // Si supera el rango de color HSB
        backgroundHue = 0;           // Reinicia el valor para mantener el ciclo de colores

    if (ofGetMousePressed()) {       // Si el usuario está presionando el mouse

        float x = ofGetMouseX();     // Obtiene la posición X actual del mouse
        float y = ofGetMouseY();     // Obtiene la posición Y actual del mouse

        float radius = ofRandom(8, 18);  // Genera un radio aleatorio para el círculo

        ofColor color;               // Crea una variable para almacenar el color

        color.setHsb(ofRandom(255), 200, 255);
                                     // Asigna un color aleatorio usando el modelo HSB

        float opacity = 255;         // Define la opacidad máxima del trazo

        strokes.enqueue(x, y, radius, color, opacity);
                                     // Inserta el nuevo trazo en la cola
    }
}


void ofApp::draw() {

    ofColor color1, color2;          // Variables que almacenan los colores del fondo

    color1.setHsb(backgroundHue, 150, 240);
                                     // Primer color del gradiente

    color2.setHsb(fmod(backgroundHue + 128, 255), 150, 240);
                                     // Segundo color desplazado para crear contraste

    ofBackgroundGradient(color1, color2, OF_GRADIENT_LINEAR);
                                     // Dibuja un fondo con gradiente dinámico


    Node* current = strokes.front;   // Comienza el recorrido desde el nodo más antiguo

    int index = 0;                   // Contador de posición dentro de la cola

    while (current != nullptr) {     // Recorre todos los nodos de la cola

        float alpha = ofMap(index, 0, strokes.size - 1, 40, 255, true);
                                     // Calcula la opacidad según la posición en la cola

        ofSetColor(current->color.r,
                   current->color.g,
                   current->color.b,
                   alpha);           // Aplica el color del nodo con la opacidad calculada

        ofDrawCircle(current->x, current->y, current->radius);
                                     // Dibuja el círculo en la posición almacenada

        current = current->next;     // Avanza al siguiente nodo

        index++;                     // Incrementa el índice
    }
}


void ofApp::keyPressed(int key) {

    if (key == 'c') {                // Si se presiona la tecla 'c'
        strokes.clear();             // Se eliminan todos los trazos
    }

    if (key == 'a') {                // Si se presiona la tecla 'a'

        if (strokes.maxSize == 50)   // Si el tamaño máximo actual es 50
            strokes.maxSize = 100;   // Se cambia a 100
        else
            strokes.maxSize = 50;    // De lo contrario vuelve a 50

        while (strokes.size > strokes.maxSize) {
                                     // Si la cola es más grande que el límite permitido
            strokes.dequeue();       // Se eliminan los nodos más antiguos
        }
    }

    else if (key == 's') {           // Si se presiona la tecla 's'

        ofSaveScreen("screenshot_" + ofGetTimestampString() + ".png");
                                     // Guarda una captura de pantalla con marca de tiempo
    }
}
```

``main.cpp``

``` c++
#include "ofMain.h"
#include "ofApp.h"
//===
int main( ){
    //Use ofGLFWWindowSettings for more options like multi-monitor fullscreen
    ofGLWindowSettings settings;
    settings.setSize(1024, 768);
    settings.windowMode = OF_WINDOW; //can also be OF_FULLSCREEN

    auto window = ofCreateWindow(settings);

    ofRunApp(window, make_shared<ofApp>());
    ofRunMainLoopO);
}
```
