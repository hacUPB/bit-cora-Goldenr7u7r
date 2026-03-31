# Actividad 7

## Evidencias

**`CrossExplosion`**

<img width="1016" height="792" alt="image" src="https://github.com/user-attachments/assets/ab7fa4a0-1b3c-4f39-a2a0-3f05dcdd2e08" />

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
