# Actividad 2: Aplicación

`main.cpp`

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/ac15f18d-b003-491b-8091-ef1f864ae55e" />

`ofApp.cpp`

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/1193090f-1646-419f-b13d-82622659e6aa" />

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/d24409eb-6696-4d03-aa11-135e49f09fd8" />

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/c5b362ea-1d42-4fd1-a36a-ec88e99d7727" />

`ofApp.h`

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/3248ebbc-c5ba-4628-8e55-8c22e262bbe5" />

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/6cb8f5b8-8e57-4837-8b31-fbfa99757ed8" />

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/1fec0d7e-dd8f-4f63-a2a6-2b2890a5e82a" />

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/80677807-0691-46df-8c26-ebc897de574c" />

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/70cc24d3-70d5-43dd-b583-be0fad58d9a3" />

**Ejecución del programa**

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/0b60b3c1-33d1-449f-8099-5863890f4162" />

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/241a635c-889d-4dda-a112-97720530caac" />

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/77fe1e70-0302-4a4c-9a81-726d7744c732" />

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/78e10685-12bd-446e-b14b-21d1e0a9c2ea" />

#### Análisis de la aplicación

El código hace una simulación de fuegos artificiales.

Primero se crea una partícula que sube desde abajo (`RisingParticle`). Esa partícula tiene posición, velocidad y tiempo de vida. Cuando llega a cierta altura o pasa cierto tiempo, “explota”.

Cuando explota, se crean muchas partículas nuevas de diferentes tipos (`CircularExplosion`, `RandomExplosion` y `StarExplosion`). Estas se mueven en distintas direcciones, se dibujan en pantalla y poco a poco desaparecen.

Todo esto se guarda en una lista de partículas, y el programa en cada frame las actualiza y las dibuja. También elimina las que ya no sirven.

Si hago clic, aparece un fuego artificial. Si presiono espacio, aparecen muchos de golpe.

**Qué entendí**

- Cada tipo de partícula es una clase diferente.

- Todas vienen de una clase base (`Particle`).

- Aunque sean diferentes, el programa las trata igual usando update() y draw() (polimorfismo).

- Cada una hace algo distinto dependiendo de su tipo.

**Conclusión**

No entendí todo al 100%, pero entendí que el programa usa clases para organizar las partículas y que el polimorfismo permite manejarlas todas juntas aunque sean diferentes.
