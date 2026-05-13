# Actividad 7

## Evidencias

**`CrossExplosion`**

<img width="1016" height="792" alt="image" src="https://github.com/user-attachments/assets/ab7fa4a0-1b3c-4f39-a2a0-3f05dcdd2e08" />

<img width="1842" height="608" alt="image" src="https://github.com/user-attachments/assets/fa290e32-702d-4c33-8780-1260827d9ce8" />

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/9ee6d8f1-9288-4d09-833c-082fbedb6838" />

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/3d90cc7b-725d-41fc-9f2a-8f5a7074f5e1" />

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/c3f7c3f9-e516-40c8-9974-bda937a77e70" />

<img width="1652" height="205" alt="image" src="https://github.com/user-attachments/assets/a54c8d00-9161-41d6-b82a-1daccfb2bd71" />

### Cambios en el código `ofApp.cpp`

1. En `update()`

``` c++
// ANTES
int explosionType = (int)ofRandom(3);

// DESPUÉS
int explosionType = (int)ofRandom(4);
```
``` c++
// AGREGADO dentro del if
else {
    particles.push_back(new CrossExplosion(
        particles[i]->getPosition(),
        particles[i]->getColor()
    ));
}
```

2. En `createRisingParticle()`

``` c++
// NUEVO
int particleType = (int)ofRandom(3);
```
``` c++
// REEMPLAZO del push original
if (particleType == 0) {
    particles.push_back(new RisingParticle(pos, vel, col, lifetime));
}
else if (particleType == 1) {
    particles.push_back(new ZigZagParticle(pos, vel, col, lifetime));
}
else {
    particles.push_back(new FastParticle(pos, vel, col, lifetime));
}
```

### Cambios en el código `ofApp.h`

1. Clase `ZigZagParticle` agregada

``` C++
class ZigZagParticle : public Particle {
protected:
    glm::vec2 position;
    glm::vec2 velocity;
    ofColor color;
    float lifetime;
    float age;
    bool exploded;

public:
    ZigZagParticle(const glm::vec2& pos, const glm::vec2& vel, const ofColor& col, float life)
        : position(pos), velocity(vel), color(col), lifetime(life), age(0), exploded(false) {}

    void update(float dt) override {
        age += dt;
        position += velocity * dt;
        position.x += sin(age * 12.0f) * 120.0f * dt;
        velocity.y += 9.8f * dt * 7;

        float explosionThreshold = ofGetHeight() * 0.18f;
        if (position.y <= explosionThreshold || age >= lifetime) {
            exploded = true;
        }
    }

    void draw() override {
        ofSetColor(color);
        ofDrawRectangle(position.x, position.y, 12, 12);
    }

    bool isDead() const override { return exploded; }
    bool shouldExplode() const override { return exploded; }
    glm::vec2 getPosition() const override { return position; }
    ofColor getColor() const override { return color; }
};
```

2. Clase `FastParticle` agregada

``` c++
class FastParticle : public Particle {
protected:
    glm::vec2 position;
    glm::vec2 velocity;
    ofColor color;
    float lifetime;
    float age;
    bool exploded;

public:
    FastParticle(const glm::vec2& pos, const glm::vec2& vel, const ofColor& col, float life)
        : position(pos), velocity(vel), color(col), lifetime(life), age(0), exploded(false) {}

    void update(float dt) override {
        position += velocity * dt;
        age += dt;
        velocity.y += 9.8f * dt * 4;

        float explosionThreshold = ofGetHeight() * 0.10f;
        if (position.y <= explosionThreshold || age >= lifetime) {
            exploded = true;
        }
    }

    void draw() override {
        ofSetColor(color);
        ofDrawTriangle(
            position.x, position.y - 10,
            position.x - 8, position.y + 8,
            position.x + 8, position.y + 8
        );
    }

    bool isDead() const override { return exploded; }
    bool shouldExplode() const override { return exploded; }
    glm::vec2 getPosition() const override { return position; }
    ofColor getColor() const override { return color; }
};
```

3. Clase `CrossExplosion` agregada

``` c++
class CrossExplosion : public ExplosionParticle {
public:
    CrossExplosion(const glm::vec2& pos, const ofColor& col)
        : ExplosionParticle(pos, glm::vec2(0, 0), col, 1.1f, ofRandom(15, 28)) {

        float angle = ofRandom(0, TWO_PI);
        float speed = ofRandom(100, 190);
        velocity = glm::vec2(cos(angle), sin(angle)) * speed;
    }

    void draw() override {
        ofSetColor(color);

        ofPushMatrix();
        ofTranslate(position);
        ofDrawLine(-size, 0, size, 0);
        ofDrawLine(0, -size, 0, size);
        ofPopMatrix();
    }
};
```

1. ¿Cómo y por qué implementé cada extensión?

Agregué dos nuevos tipos de `Particle`: `ZigZagParticle` y `FastParticle`.

La `ZigZagParticle` la hice para que no todas las partículas subieran de forma recta, sino que una de ellas tuviera un movimiento lateral en zigzag usando `sin()`. La implementé heredando directamente de `Particle` y sobreescribiendo `update()`, `draw()`, `isDead()`, `shouldExplode()`, `getPosition()` y `getColor()`. La hice así porque quería que tuviera un comportamiento claramente diferente al de `RisingParticle`.

La `FastParticle` la hice como otra variante de partícula ascendente, pero más rápida y con una explosión más temprana. También hereda de `Particle` y redefine sus métodos principales. La hice para que hubiera más variedad visual y para probar mejor el polimorfismo en tiempo de ejecución.

Además, implementé un nuevo modo de explosión llamado `CrossExplosion`, que hereda de `ExplosionParticle`. Esta explosión dibuja una cruz con dos líneas. La agregué para extender el caso de estudio sin cambiar la estructura principal del programa, sino reutilizando la jerarquía ya existente.

2. ¿Cómo y por qué implementé encapsulamiento, herencia y polimorfismo?

El encapsulamiento se ve en que cada clase guarda sus propios atributos, como posición, velocidad, color, edad y tiempo de vida. Esos datos quedan agrupados dentro de cada objeto y cada clase controla cómo se usan por medio de sus métodos. Esto ayuda a que el código esté más organizado y que cada objeto maneje su propio estado.

La herencia se implementa porque laa nuevas clases (`ZigZagParticle`, `FastParticle` y `CrossExplosion`) parten de clases base que ya existían. Las dos primeras heredan de `Particle`, y `CrossExplosion` hereda de `ExplosionParticle`, que a su vez hereda de `Particle`. Esto me permitió reutilizar la lógica general del sistema y solo cambiar el comportamiento específico que necesitaba.

El polimorfismo se implementa porque todas las partículas, aunque sean de tipos distintos, se guardan en el mismo vector `std::vector<Particle*> particles`. Luego, cuando el programa recorre ese vector y llama a `update()` o `draw()`, cada objeto responde con su propia versión del método. Eso permite manejar objetos distintos como si fueran del mismo tipo base.

3. ¿Cómo verifiqué que las extensiones funcionan correctamente?

Verifiqué el funcionamiento ejecutando la aplicación varias veces y generando muchas partículas con clic y con la barra espaciadora.

Para comprobar las nuevas partículas, observé visualmente que:

- Unas subían de forma normal (`RisingParticle`)
- Otras hacían un movimiento lateral en zigzag (`ZigZagParticle`)
- Otras subían más rápido (`FastParticle`)

Para comprobar la nueva explosión, observé que además de los modos anteriores apareció un nuevo patrón en forma de cruz (`CrossExplosion`).

En el depurador revisé el contenido del vector particles y confirmé que allí había objetos de distintos tipos guardados todos como `Particle*`. También fui entrando a las llamadas de `update()` y `draw()` para ver que, dependiendo del objeto real, el programa ejecutaba una versión diferente del método. Eso evidenció el polimorfismo en tiempo de ejecución.

Las capturas del depurador muestran justamente que el vector contiene distintos tipos derivados y que el programa resuelve correctamente qué método llamar en cada caso.

**Código `ofApp.h`**

``` c++
#pragma once
#include "ofMain.h"
#include <vector>

// -------------------------------------------------
// Clase base abstracta: Particle
// -------------------------------------------------
class Particle {
public:
    virtual ~Particle() {}
    virtual void update(float dt) = 0;
    virtual void draw() = 0;
    virtual bool isDead() const = 0;
    virtual bool shouldExplode() const { return false; }
    virtual glm::vec2 getPosition() const { return glm::vec2(0, 0); }
    virtual ofColor getColor() const { return ofColor(255); }
};

// -------------------------------------------------
// RisingParticle
// -------------------------------------------------
class RisingParticle : public Particle {
protected:
    glm::vec2 position;
    glm::vec2 velocity;
    ofColor color;
    float lifetime;
    float age;
    bool exploded;

public:
    RisingParticle(const glm::vec2& pos, const glm::vec2& vel, const ofColor& col, float life)
        : position(pos), velocity(vel), color(col), lifetime(life), age(0), exploded(false) {
    }

    void update(float dt) override {
        position += velocity * dt;
        age += dt;
        velocity.y += 9.8f * dt * 8;

        float explosionThreshold = ofGetHeight() * 0.15 + ofRandom(-30, 30);
        if (position.y <= explosionThreshold || age >= lifetime) {
            exploded = true;
        }
    }

    void draw() override {
        ofSetColor(color);
        ofDrawCircle(position, 10);
    }

    bool isDead() const override { return exploded; }
    bool shouldExplode() const override { return exploded; }
    glm::vec2 getPosition() const override { return position; }
    ofColor getColor() const override { return color; }
};

// -------------------------------------------------
// NUEVA: ZigZagParticle
// -------------------------------------------------
class ZigZagParticle : public Particle {
protected:
    glm::vec2 position;
    glm::vec2 velocity;
    ofColor color;
    float lifetime;
    float age;
    bool exploded;

public:
    ZigZagParticle(const glm::vec2& pos, const glm::vec2& vel, const ofColor& col, float life)
        : position(pos), velocity(vel), color(col), lifetime(life), age(0), exploded(false) {
    }

    void update(float dt) override {
        age += dt;
        position += velocity * dt;
        position.x += sin(age * 12.0f) * 120.0f * dt;
        velocity.y += 9.8f * dt * 7;

        float explosionThreshold = ofGetHeight() * 0.18f;
        if (position.y <= explosionThreshold || age >= lifetime) {
            exploded = true;
        }
    }

    void draw() override {
        ofSetColor(color);
        ofDrawRectangle(position.x, position.y, 12, 12);
    }

    bool isDead() const override { return exploded; }
    bool shouldExplode() const override { return exploded; }
    glm::vec2 getPosition() const override { return position; }
    ofColor getColor() const override { return color; }
};

// -------------------------------------------------
// NUEVA: FastParticle
// -------------------------------------------------
class FastParticle : public Particle {
protected:
    glm::vec2 position;
    glm::vec2 velocity;
    ofColor color;
    float lifetime;
    float age;
    bool exploded;

public:
    FastParticle(const glm::vec2& pos, const glm::vec2& vel, const ofColor& col, float life)
        : position(pos), velocity(vel), color(col), lifetime(life), age(0), exploded(false) {
    }

    void update(float dt) override {
        position += velocity * dt;
        age += dt;
        velocity.y += 9.8f * dt * 4;

        float explosionThreshold = ofGetHeight() * 0.10f;
        if (position.y <= explosionThreshold || age >= lifetime) {
            exploded = true;
        }
    }

    void draw() override {
        ofSetColor(color);
        ofDrawTriangle(
            position.x, position.y - 10,
            position.x - 8, position.y + 8,
            position.x + 8, position.y + 8
        );
    }

    bool isDead() const override { return exploded; }
    bool shouldExplode() const override { return exploded; }
    glm::vec2 getPosition() const override { return position; }
    ofColor getColor() const override { return color; }
};

// -------------------------------------------------
// Clase base para explosiones
// -------------------------------------------------
class ExplosionParticle : public Particle {
protected:
    glm::vec2 position;
    glm::vec2 velocity;
    ofColor color;
    float age;
    float lifetime;
    float size;

public:
    ExplosionParticle(const glm::vec2& pos, const glm::vec2& vel, const ofColor& col, float life, float sz)
        : position(pos), velocity(vel), color(col), age(0), lifetime(life), size(sz) {
    }

    void update(float dt) override {
        position += velocity * dt;
        age += dt;
        float alpha = ofMap(age, 0, lifetime, 255, 0, true);
        color.a = alpha;
    }

    bool isDead() const override {
        return age >= lifetime;
    }
};

// -------------------------------------------------
// CircularExplosion
// -------------------------------------------------
class CircularExplosion : public ExplosionParticle {
public:
    CircularExplosion(const glm::vec2& pos, const ofColor& col)
        : ExplosionParticle(pos, glm::vec2(0, 0), col, 1.2f, ofRandom(16, 32)) {
        float angle = ofRandom(0, TWO_PI);
        float speed = ofRandom(80, 200);
        velocity = glm::vec2(cos(angle), sin(angle)) * speed;
    }

    void draw() override {
        ofSetColor(color);
        ofDrawCircle(position, size);
    }
};

// -------------------------------------------------
// RandomExplosion
// -------------------------------------------------
class RandomExplosion : public ExplosionParticle {
public:
    RandomExplosion(const glm::vec2& pos, const ofColor& col)
        : ExplosionParticle(pos, glm::vec2(0, 0), col, 1.5f, ofRandom(16, 32)) {
        velocity = glm::vec2(ofRandom(-200, 200), ofRandom(-200, 200));
    }

    void draw() override {
        ofSetColor(color);
        ofDrawRectangle(position.x, position.y, size, size);
    }
};

// -------------------------------------------------
// StarExplosion
// -------------------------------------------------
class StarExplosion : public ExplosionParticle {
public:
    StarExplosion(const glm::vec2& pos, const ofColor& col)
        : ExplosionParticle(pos, glm::vec2(0, 0), col, 1.3f, ofRandom(20, 40)) {
        float angle = ofRandom(0, TWO_PI);
        float speed = ofRandom(90, 180);
        velocity = glm::vec2(cos(angle), sin(angle)) * speed;
    }

    void draw() override {
        ofSetColor(color);
        int rays = 5;
        float outerRadius = size;
        float innerRadius = size * 0.5;

        ofPushMatrix();
        ofTranslate(position);
        for (int i = 0; i < rays; i++) {
            float theta = ofMap(i, 0, rays, 0, TWO_PI);
            float xOuter = cos(theta) * outerRadius;
            float yOuter = sin(theta) * outerRadius;
            float xInner = cos(theta + PI / rays) * innerRadius;
            float yInner = sin(theta + PI / rays) * innerRadius;

            ofDrawLine(0, 0, xOuter, yOuter);
            ofDrawLine(xOuter, yOuter, xInner, yInner);
        }
        ofPopMatrix();
    }
};

// -------------------------------------------------
// NUEVA: CrossExplosion
// -------------------------------------------------
class CrossExplosion : public ExplosionParticle {
public:
    CrossExplosion(const glm::vec2& pos, const ofColor& col)
        : ExplosionParticle(pos, glm::vec2(0, 0), col, 1.1f, ofRandom(15, 28)) {
        float angle = ofRandom(0, TWO_PI);
        float speed = ofRandom(100, 190);
        velocity = glm::vec2(cos(angle), sin(angle)) * speed;
    }

    void draw() override {
        ofSetColor(color);
        ofPushMatrix();
        ofTranslate(position);
        ofDrawLine(-size, 0, size, 0);
        ofDrawLine(0, -size, 0, size);
        ofPopMatrix();
    }
};

// -------------------------------------------------
// ofApp
// -------------------------------------------------
class ofApp : public ofBaseApp {
public:
    void setup();
    void update();
    void draw();
    void mousePressed(int x, int y, int button);
    void keyPressed(int key);

    std::vector<Particle*> particles;
    ~ofApp();

private:
    void createRisingParticle();
};
```

**Código `ofApp.cpp`**

``` c++
#include "ofApp.h"

// --------------------------------------------------------------
void ofApp::setup() {
    ofSetFrameRate(60);
    ofBackground(0);
}

// --------------------------------------------------------------
void ofApp::update() {
    float dt = ofGetLastFrameTime();

    // Actualiza todas las partículas
    for (int i = 0; i < particles.size(); i++) {
        particles[i]->update(dt);
    }

    // Procesa las partículas
    for (int i = particles.size() - 1; i >= 0; i--) {
        if (particles[i]->shouldExplode()) {
            int explosionType = (int)ofRandom(4);
            int numParticles = (int)ofRandom(20, 30);

            for (int j = 0; j < numParticles; j++) {
                if (explosionType == 0) {
                    particles.push_back(new CircularExplosion(
                        particles[i]->getPosition(),
                        particles[i]->getColor()
                    ));
                }
                else if (explosionType == 1) {
                    particles.push_back(new RandomExplosion(
                        particles[i]->getPosition(),
                        particles[i]->getColor()
                    ));
                }
                else if (explosionType == 2) {
                    particles.push_back(new StarExplosion(
                        particles[i]->getPosition(),
                        particles[i]->getColor()
                    ));
                }
                else {
                    particles.push_back(new CrossExplosion(
                        particles[i]->getPosition(),
                        particles[i]->getColor()
                    ));
                }
            }

            delete particles[i];
            particles.erase(particles.begin() + i);
        }
        else if (particles[i]->isDead()) {
            delete particles[i];
            particles.erase(particles.begin() + i);
        }
    }
}

// --------------------------------------------------------------
void ofApp::draw() {
    for (int i = 0; i < particles.size(); i++) {
        particles[i]->draw();
    }
}

// --------------------------------------------------------------
void ofApp::createRisingParticle() {
    float minX = ofGetWidth() * 0.35f;
    float maxX = ofGetWidth() * 0.65f;
    float spawnX = ofRandom(minX, maxX);

    glm::vec2 pos(spawnX, ofGetHeight());

    glm::vec2 target(
        ofGetWidth() / 2 + ofRandom(-300, 300),
        ofGetHeight() * 0.10f + ofRandom(-30, 30)
    );

    glm::vec2 direction = glm::normalize(target - pos);

    ofColor col;
    col.setHsb(ofRandom(255), 220, 255);

    int particleType = (int)ofRandom(3);

    if (particleType == 0) {
        glm::vec2 vel = direction * ofRandom(250, 350);
        float lifetime = ofRandom(1.5, 3.5);
        particles.push_back(new RisingParticle(pos, vel, col, lifetime));
    }
    else if (particleType == 1) {
        glm::vec2 vel = direction * ofRandom(220, 320);
        float lifetime = ofRandom(1.8, 3.2);
        particles.push_back(new ZigZagParticle(pos, vel, col, lifetime));
    }
    else {
        glm::vec2 vel = direction * ofRandom(320, 430);
        float lifetime = ofRandom(1.0, 2.2);
        particles.push_back(new FastParticle(pos, vel, col, lifetime));
    }
}

// --------------------------------------------------------------
void ofApp::mousePressed(int x, int y, int button) {
    createRisingParticle();
}

// --------------------------------------------------------------
void ofApp::keyPressed(int key) {
    if (key == ' ') {
        for (int i = 0; i < 1000; i++) {
            createRisingParticle();
        }
    }

    if (key == 's') {
        ofSaveScreen("screenshot_" + ofToString(ofGetFrameNum()) + ".png");
    }
}

// --------------------------------------------------------------
ofApp::~ofApp() {
    for (int i = 0; i < particles.size(); i++) {
        delete particles[i];
    }
    particles.clear();
}
```
