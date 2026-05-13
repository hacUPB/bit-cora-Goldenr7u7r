# Actividad 5


#### ¿Qué puedo observar al mirar en memoria un objeto `CircularExplosion`? ¿Qué información me da el depurador? ¿Qué puedo concluir?

Al mirar el objeto `CircularExplosion` en memoria, se puede ver que no solo tiene los datos propios de esa clase, sino también los que vienen de las clases de las que hereda.

En este caso, `CircularExplosion` hereda de `ExplosionParticle`, y esa a su vez hereda de `Particle`, entonces el objeto en memoria reúne toda esa información en un solo bloque.

El depurador muestra justamente eso: la jerarquía de herencia y los campos que pertenecen a cada nivel de la clase. O sea, se alcanza a ver qué parte viene de la clase base y qué parte viene de la clase derivada.

Puedo concluir que la herencia en C++ no crea objetos separados, sino que junta dentro del mismo objeto los datos heredados y los propios de la clase hija.

#### ¿Cómo se implementa la herencia en C++?

Yo lo entiendo como que en C++ la herencia se implementa agregando dentro del objeto derivado la parte de la clase base.

O sea, si una clase hereda de otra, el objeto final guarda primero la información heredada y luego la información propia de la clase hija. Por eso el objeto termina teniendo todo junto en memoria.

Además, por esa herencia, la clase hija también puede usar métodos y atributos de la clase padre, dependiendo del nivel de acceso.
