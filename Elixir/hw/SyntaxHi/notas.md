# Reporte de Programa y Reflexión Personal

## 1. ¿Cómo funciona la solución?
Nuestro programa funciona como un rastreador que lee un archivo de C++ línea por línea y letra por letra de izquierda a derecha. Imagina que es como un carrito avanzando por una vía de texto: cada vez que lee un carácter, revisa un mapa o matriz de estados para ver en dónde está parado y qué significa lo que acaba de ver.

El código clasifica los caracteres en grupos simples (espacios, letras, números o símbolos). Al juntar estos caracteres según lo que dice la matriz, va armando palabras completas (que formalmente llamamos lexemas). En cuanto una palabra se termina (por ejemplo, cuando encuentra un espacio después de un `int`), el programa le pega su etiqueta de HTML con el color que le toca (palabra reservada, comentario, operador, etc.) y avanza directo a la siguiente letra sin trabarse ni regresar.

---

## 2. Análisis de Complejidad y Velocidad
Si llamamos $N$ al número total de letras y símbolos que tiene el archivo de C++:

* **Velocidad de ejecución:** Nuestro algoritmo corre en **Tiempo Lineal**, o $O(N)$. Tenia un bug de bucles infinitos que congelaban la terminal, el programa solo visita cada letra una sola vez. Lee el carácter, procesa el token si ya terminó, y pasa al siguiente. Por eso los archivos de prueba se procesan en menos de un milisegundo; el tiempo crece limpio y plano sin importar qué tan largo sea el código fuente.
* **Memoria usada:** El espacio que ocupa también es lineal, o $O(N)$. El texto se convierte en una lista de caracteres para poder recorrerlos en orden, y el archivo HTML final que generamos crece de forma proporcional al tamaño del archivo de código original que le metimos.

---

## 3. ¿Cómo podríamos optimizarlo para que sea aún más rápido?
Aunque el código actual ya es bastante rápido y no hace copias de texto innecesarias, se podría mejorar la velocidad haciendo un par de cambios en cómo Elixir maneja los datos por debajo:

* **Usar Pattern Matching con Binarios:** En lugar de romper cada línea de texto en una lista pesada de caracteres individuales usando `String.graphemes`, podríamos leer el archivo directamente como binarios de memoria (`<<char::utf8, resto::binary>>`). Leer bytes directamente del procesador es muchísimo más rápido que crear estructuras de listas.
* **Búsquedas directas para Keywords:** Para revisar si una palabra es una keyword de C++, en lugar de usar `Enum.member?` que recorre la lista una y otra vez, podríamos usar un mapa de hashes o compilar una expresión regular para que la validación sea instantánea (tiempo constante).

---

## 4. ¿Por qué importa esta tecnología? (Reflexión Ética)
Ponerle colores a un código puede parecer un simple capricho visual, pero hacer programas que lean y entiendan texto de forma rápida es súper importante por varias razones reales:

* **Inclusión y accesibilidad:** Los colores bien distribuidos reducen un buen la fatiga visual y ayudan a que estudiantes, principiantes o personas con problemas de aprendizaje (como dislexia o TDAH) entiendan la lógica del código sin que les explote la cabeza. Hacer que la programación sea accesible ayuda a que cualquiera pueda aprender a crear tecnología.
* **Seguridad informática:** Si un analizador de texto está mal programado o tiene bugs, los hackers pueden aprovecharse de eso. Pueden meter comandos dañinos escondidos en espacios invisibles que los humanos no ven pero las computadoras sí, o activar bucles infinitos para tirar servidores enteros (ataques DoS). Escribir código sólido y predecible protege la infraestructura digital en la que se basan los bancos, hospitales y apps diarias.
* **Cuidado del medio ambiente (Green Computing):** Los servidores en la nube procesan millones de líneas de código cada segundo. Si las herramientas que usan los desarrolladores tienen algoritmos pesados o mal optimizados, los procesadores del mundo tienen que trabajar el doble, calentándose y gastando cantidades enormes de luz. Usar algoritmos lineales y eficientes ($O(N)$) baja el consumo eléctrico global, ayudando a reducir la huella de carbono de la industria tecnológica.