![Tec de Monterrey](../../images/logotecmty.png)
# Identifica signo

## Definición del problema
¿Positivo, negativo o cero?
Identifica si un número entero es positivo, negativo o cero.

El programa despliega un mensaje "Es positivo" "Es negativo" ó "Es cero" dependiendo de la entrada del usuario.

**Entradas:**
Un número entero

**Salida:**
Un mensaje

Ejemplo:
```
Dame un número: -8
Es negativo

```

Ejemplo 2:
```
Dame un número: 0
Es cero

```

# Licencia

## Definición del problema
Una persona puede obtener su licencia de manejo si es mayor de edad y tiene identificación oficial.

Escribe un programa en Python que lea la edad de una persona y si tiene (s/n) identificación oficial.

De salida debe mostrar Si puede obtener su licencia o No la puede obtener.

**Entradas**
El programa va a preguntar por:
- la edad de la persona, debe ser un entero positivo.
- si tiene identificación o no. Debe ser un string, que contenga las letras "s" o "n"

**Salidas**
Añade el código necesario para que el programa imprima:
- **Trámite de licencia concedido** si la edad es mayor o igual a 18 y tiene identificación oficial
- **No cumples requisitos** si no cumple con los requisitos para la licencia
- Si la edad es negativa o el usuario ingresó cualquier otro caracter que no sea s o n cuando pides la identificación, debe mostrar el mensaje **Respuesta incorrecta**

La salida del programa debe de ser exactamente de la siguiente forma:

## Ejemplos
Ejemplo 1

```plaintext
Ingresa tu edad: 19
¿Tienes identificación oficial? (s/n): s
Trámite de licencia concedido
```
Ejemplo 2

```plaintext
Ingresa tu edad: 19
¿Tienes identificación oficial? (s/n): n
No cumples requisitos
```

Ejemplo 3
```plaintext
Ingresa tu edad: 12
No cumples requisitos
```

Ejemplo 4
```plaintext
Ingresa tu edad: 20
¿Tienes identificación oficial? (s/n): g
Respuesta incorrecta
```

# El mayor de 3 números

## Definición del problema

Realiza un programa que muestre el mayor de 3 números enteros x, y, z proporcionados por el usuario.

**NOTA:** NO puedes utilizar la función incorporada de Python: max(), debes hacerlo con condicionales.

**Entradas**
El programa va a preguntar por tres **números enteros** uno en cada renglón.

**Salidas**
El mayor de los tres números dados por el usuario.

## Ejemplos

Ejemplo 1

```plaintext
Ingresa el primer número: 5
Ingresa el segundo número: 8
Ingresa el tercer número: -3
8
```
Ejemplo 2

```plaintext
Ingresa el primer número: 5
Ingresa el segundo número: 1
Ingresa el tercer número: 12
12
```

# Ordena 3 números

## Definición del problema

Realiza un programa que ordena en forma ascendente tres números enteros x, y, z.

**NOTA:** NO puedes utilizar la función incorporada de Python: sort(), debes hacerlo con condicionales.

**Entradas**
El programa va a preguntar por tres **números enteros** uno en cada renglón.

**Salidas**
Los números de menor a mayor uno por renglón.

## Ejemplos

Ejemplo 1

```plaintext
Ingresa el primer número: 5
Ingresa el segundo número: 8
Ingresa el tercer número: -3
-3
5
8
```
Ejemplo 2

```plaintext
Ingresa el primer número: 5
Ingresa el segundo número: 1
Ingresa el tercer número: 12
1
5
12
```

# Índice de masa corporal

## Definición del problema

Escribe un programa que calcule el **IMC** (Índice de Masa Corporal) de una persona, el cual se utiliza para determinar si la proporción de peso y altura es adecuada. El IMC se puede calcular utilizando la siguiente fórmula:

indice = peso / altura^2

Donde el peso debe darse en kilogramos y la altura en metros. La siguiente tabla muestra cómo se clasifican los diferentes rangos de índice:

| Rango de índice |  Descripción  |
| :-------------: |:-------------:|
|índice < 20      | PESO BAJO     |
|20 <= índice < 25| NORMAL        |
|25 <= índice < 30| SOBREPESO     |
|30 <= índice < 40| OBESIDAD      |
|índice >= 40     | OBESIDAD MORBIDA|

**Entradas**
Dos números **flotantes** (peso y altura) uno en cada renglón y recibidos en este orden.

**Salidas**
Un **string** correspondiente a la descripción del índice de masa corporal, tal como se ve en la tabla, todo en mayúsculas.
Debes de verificar que tanto el peso como la altura sean mayores a 0, en caso de que alguno sea 0 o menor, se debe mandar el siguiente mensaje de error: *Revisa tus datos, alguno de ellos es erróneo*.

## Ejemplos

Ejemplo 1

```plaintext
Peso en kg: 53
Altura en m: 1.66
PESO BAJO
```
Ejemplo 2

```plaintext
Peso en kg: 65
Altura en m: 0
Revisa tus datos, alguno de ellos es erróneo.
```

# Día siguiente - considera año Bisiesto

## Definición del problema

Escribe un programa que dada una fecha (año, mes y día), devuelva la fecha del día siguiente. Te recomiendo que antes de ponerte de codificar, verifiques todas las posibilidades que se pueden presentar.

Este problema debe considerar la verificación de año bisiesto. Recuerda que el siguiente algoritmo se puede usar para determinar si un año determinado es bisiesto:
  * Los años bisiestos son cualquier año que es divisible por 4 (como 2012, 2016, etc).
  * Excepto si puede dividirse por 100, entonces no lo es (como 2100, 2200, etc).
  * A menos que pueda ser divisible por 400, como 2000, 2400.

Para este ejercicio, no validaremos las entradas, confiaremos que el usuario ingresará una fecha válida.

**Entradas**
Año, día y mes (**enteros positivos**) en ese orden.

**Salidas**
Año, día y mes (**enteros positivos**) en ese orden que corresponde al día siguiente ingresado como entrada.

## Ejemplos

Ejemplo 1

```plaintext
Año: 2015
Mes: 2
Día: 13
2015
2
14
```

Ejemplo 2

```plaintext
Año: 2016
Mes: 2
Día: 28
2016
2
29
```

Ejemplo 3

```plaintext
Año: 2016
Mes: 12
Día: 31
2017
1
1
```

# Punto con respecto a la circunferencia

## Definición del problema

Escriba un programa que pida el radio y las coordenadas del centro de una circunferencia, así como las coordenadas de un punto. El programa deberá indicar si el punto está sobre la circunferencia, dentro o fuera de ella. Investiga o recuerda la fórmula del calculo de distancia entre dos puntos porque la vas a necesitar.

**Entradas**
- radio (flotante)
- x1 Coordenada x del centro de la circunferencia (flotante)
- y1 Coordenada y del centro de la circunferencia (flotante)
- x2 Coordenada x del punto (flotante)
- y2 Coordenada y del punto (flotante)
- NOTA: Los datos deberán ser ingresados estrictamente en este orden.

**Salida**
- Un string que representa la posición del punto con respecto a la circunferencia: `"DENTRO"`, `"FUERA"`, `"SOBRE"`.

Estos son algunos ejemplos de ejecución del programa. La salida del programa debe de ser exactamente de la siguiente forma:

```plaintext
Introduce el radio: 5
Introduce x1: 0
Introduce y1: 0
Introduce x2: 0
Introduce y2: 6
FUERA

Introduce el radio: 5
Introduce x1: 0
Introduce y1: 0
Introduce x2: 0
Introduce y2: 5
SOBRE

Introduce el radio: 5
Introduce x1: 0
Introduce y1: 0
Introduce x2: 0
Introduce y2: 3
DENTRO
```

# Cuadrante

## Definición del problema

Escribe un programa que lea un número entero que se encuentre entre 0 y 360 que representa los grados del plano cartesiano y que muestre como resultado el número de cuadrante en donde se encuentra.
En caso de que el grado caiga en un eje, tu programa debe mostrar la palabra `"eje"`.
En caso de que el grado sea menor a cero o mayor a 360,  tu programa debe mostrar la palabra `"excede"`.

**Entrada**
- Un número entero que representa una cantidad de grados.

**Salida**
- La palabra cuadrante (en minúsculas) seguida del número de cuadrante correspondiente (por ejemplo: `cuadrante 2`), o bien alguna de las palabras `eje` o `excede`.

Estos son algunos ejemplos de ejecución del programa. La salida del programa debe de ser exactamente de la siguiente forma:

```plaintext
Introduce los grados: -10
excede

Introduce los grados: 90
eje

Introduce los grados: 45
cuadrante 1

Introduce los grados: 215
cuadrante 3
```

# Cuadrática

## Definición del problema

Realiza un programa para calcular los valores de la ecuación cuadrática `ax^2+bx+c` usando la fórmula cuadrática.
El programa debe leer tres valores enteros a, b y c, y encontrar los valores de x, considerando las siguientes restricciones:
- Si a = 0 y b = 0 se debe desplegar el mensaje `"No tiene solucion”`.
- Si a = 0 y b != 0 se debe despejar el valor de x = –c/b y mostrar este valor.
- Si a != 0 y b != 0 se debe calcular el discriminante.
      * Si el valor del discriminante es negativo debe mostrar el mensaje `"Raices complejas"`.
      * Si el valor del discriminante es positivo debe calcular y mostrar los dos valores de x, una en cada renglón.
      * En caso de que el discriminante sea cero se debe mostrar sólo un valor de x = -b/(2a).

**Entradas**
- Los tres valores enteros a, b, c uno en cada renglón y en ese orden.

**Salidas**
- El valor de la o las raices (si es el caso) uno en cada renglón, o alguno de los mensajes `"No tiene solucion"` o `"Raices complejas"`.

Estos son algunos ejemplos de ejecución del programa. La salida del programa debe de ser exactamente de la siguiente forma:

```plaintext
Da el valor de a: 1
Da el valor de b: 2
Da el valor de c: 3
Raices complejas

Da el valor de a: 0
Da el valor de b: 1
Da el valor de c: 2
-2.0

Da el valor de a: 1
Da el valor de b: 5
Da el valor de c: 6
-2.0
-3.0

Da el valor de a: 0
Da el valor de b: 0
Da el valor de c: 2
No tiene solucion
```

# Minijuego Piedra, Papel o Tijera

## Definición del problema

Escriba un programa que simule el juego <a href="https://es.wikipedia.org/wiki/Piedra,_papel_o_tijera">Piedra, papel, tijera</a> para dos jugadores (Ana y Juan).

Las reglas del juego son las siguientes:
- Simultáneamente, los dos jugadores muestran una mano en tres posibles posiciones:
- Piedra: se muestra el puño cerrado y se representa con un caracter `a`.
- Papel: se muestra la palma de la mano y se representa con un caracter `p`.
- Tijera: se muestra la palma de la mano con los dedos separados en dos grupos y se representa con un caracter `t`.
- El jugador que ha sacado Piedra gana al jugador que ha sacado Tijera.
- El jugador que ha sacado Tijera gana al jugador que ha sacado Papel.
- El jugador que ha sacado Papel gana al jugador que ha sacado Piedra.
- Caso de empate cuando dos jugadores elijan el mismo elemento.

**Entradas**
- Dos caracteres (a, p o t), cada uno en un renglón y representan la tirada de Ana y Juan, en ese orden.

**Salida**
- Mensaje de quien es el ganador en el siguiente formato: `"Gana Ana"` o `"Gana Juan"` o `"Empate"`.
- En el caso de que ingresen algún string de más de un caracter se debe desplegar el siguiente mensaje `"Las tiradas deben ser un caracter"`, si son de un sólo caracter pero alguna de ellas no corresponde a un caracter válido, el mensaje a desplegar es `"Tirada incorrecta"`.

Estos son algunos ejemplos de ejecución del programa. La salida del programa debe de ser exactamente de la siguiente forma:

```plaintext
Tirada de Ana: a
Tirada de Juan: p
Gana Juan

Tirada de Ana: t
Tirada de Juan: p
Gana Ana

Tirada de Ana: a
Tirada de Juan: a
Empate

Tirada de Ana: piedra
Tirada de Juan: a
Las tiradas deben ser un caracter

Tirada de Ana: p
Tirada de Juan: r
Tirada incorrecta
```
