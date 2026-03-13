# Actividad 2: Paso por valor y paso por referencia

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/5a77c60b-edd0-40ad-86d8-231ccfb1f018" /><img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/72598be7-d1af-494c-8c2c-bc7fda44a868" />

- **Predicción**

Antes de ejecutar el programa, predije que en el caso de a (paso por valor) el número no cambiaría fuera de la función, porque lo que se envía es una copia del valor. Es como si se hiciera una fotocopia del número 10; la función modifica la copia a 15, pero el original sigue siendo 10.

En el caso de b (paso por referencia), predije que sí cambiaría después de la función, porque no se envía una copia sino la variable original. Es como si la función trabajara directamente sobre el número real, por lo que al sumarle 5, el valor pasa de 10 a 15 tanto dentro como fuera de la función.

En el caso de c (paso por puntero), también predije que cambiaría, porque se envía la dirección de memoria de la variable. Al modificar *n, realmente se está modificando el valor almacenado en esa dirección, es decir, el valor original de c.

- **¿Qué diferencias observé?**

Observé que a no cambió después de llamar a la función, mientras que b y c sí cambiaron de 10 a 15. Esto muestra claramente que el paso por valor no altera la variable original, pero el paso por referencia y por puntero sí lo hacen.

- **¿Por qué ocurre esta diferencia?**

La diferencia ocurre porque cada método maneja de forma distinta el acceso a la variable original:

- En el paso por valor se trabaja con una copia.

- En el paso por referencia se trabaja directamente con la variable original.

- En el paso por puntero se trabaja con la dirección de memoria de la variable original.

Por eso solo en los dos últimos casos el valor cambia fuera de la función.

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/e81ccce0-7342-4eb1-8fd7-3f7d4e9c05ea" />

---

### Paso por valor

``` .c++
void modificarPorValor(int n)
```

##### ¿Qué ocurre aquí?

- Se crea una copia de la variable que se pasa.
- Los cambios afectan solo a la copia.
- La variable original NO se modifica.

---

### Paso por referencia

``` .c++
void modificarPorReferencia(int& n)
```

##### ¿Qué significa el &?

- n es una referencia a la variable original.
- No se crea copia.
- Se trabaja directamente con la variable original.

---

### Paso por puntero

``` .c++
void modificarPorPuntero(int* n)
```

##### ¿Qué es un puntero?

Un puntero guarda la dirección de memoria de una variable.

En main:

``` .c++
modificarPorPuntero(&c);
```

- &c significa "la dirección de memoria de c".
- Dentro de la función usamos *n para acceder al valor.

## Reflexión final

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/87be931f-8a99-43b2-b63a-992c2a51c6e4" />

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/a87bfd21-6c43-4b99-9d1f-8185dd3082d9" />

#### Resultados obtenidos en la ejecución

Valores iniciales:

``` .c++
x = 5, y = 10
```

Después de llamar a *swapPorValor(x, y)*:

Dentro de la función los valores se intercambian:

``` .c++
a = 10, b = 5
```

Sin embargo, al regresar a *main()*:

``` .c++
x = 5, y = 10
```

No hubo cambios en las variables originales.

Después de llamar a *swapPorReferencia(x, y)*:

Dentro de la función:

``` .c++
a = 10, b = 5
```

Al regresar a *main()*:

``` .c++
x = 10, y = 5
```

Las variables originales sí se modificaron.

Después de llamar a *swapPorPuntero(&x, &y)*:

Dentro de la función:

``` .c++
*a = 5, *b = 10
```

Al regresar a *main()*:

``` .c++
x = 5, y = 10
```

Se volvió a realizar el intercambio utilizando punteros.

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/76bb8a50-1a2d-4712-a603-433b1f8216cb" />

**Conclusión**

En esta actividad comprobé que el paso por valor no modifica las variables originales, ya que la función trabaja con copias de los valores. Aunque el intercambio ocurre dentro de la función, las variables en *main()* permanecen iguales.

En el paso por referencia y en el paso por puntero, la función sí modifica las variables originales. En el caso de la referencia, se trabaja directamente con la variable original mediante un alias. En el caso del puntero, se trabaja con la dirección de memoria de la variable y se modifica su contenido mediante el operador de indirección *(***)*.

Esto demuestra claramente la diferencia entre trabajar con copias y trabajar directamente sobre la memoria de las variables.
