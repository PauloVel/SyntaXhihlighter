![Tec de Monterrey](../Images/logotecmty.png)

# Área Triángulo
Básicos-Área Triángulo

Crea una función que lea los datos tipo <i>float</i>: base (b) y altura (h),
y regrese el área del triángulo.

Ejemplo:
```
Dame la base: 7
Dame la altura: 5
El área es: 17.5
```

# Calcula Tiempo
Básicos-Calcula tiempo

Crea una función que reciba la edad del usuario y el año actual,
como resultado le indicará el año en que cumplirá 100 años.


**Entrada:**
La edad (entero positivo) de la persona y el año actual (entero positivo), en este orden.


**Salida:**
El año (entero positivo) en el que la persona cumplirá 100 años.


Ejemplo:
```
Dame tu edad: 10
Dame el año actual: 2021
Cumplirás 100 años en el año: 2111
```

# Lustros
Básicos-Lustros

Crea una función que indique el número de lustros que ha vivido una persona
por medio de su año de nacimiento y el año actual.

**Entradas:** Dos números enteros. Primero el año de nacimiento y luego el año actual.

**Salida:** Un número con punto decimal que representa los lustros vividos por la persona.

Ejemplo:
```
Dame el año de nacimiento: 1998
Dame el año actual: 2021
Los lustros que has vivido son: 4.6
```

# Peso
Básicos-Peso

Crea una función que haga lo siguiente:
A inicio de año, las personas están preocupadas por su peso por lo que acuden a
nutriólogos, gimnasios y cualquier otra cosa que les ayude en el proceso.
Realiza un programa que ayude a las personas a indicar cuántos kilos debe bajar
por mes, dados el peso inicial, el peso final y el número de meses que una
persona estará en un programa integral para bajar de peso.

**Entradas:** Peso inicial (número decimal), peso final (número decimal),
meses (número entero). Un dato en cada línea en ese orden.

**Salida:** Un número decimal que indique cuánto debe bajar por mes.

Ejemplo:
```
Dame el peso inicial: 60
Dame el peso final: 55
Dame la cantidad de meses: 4
Lo que debes bajar por mes es: 1.25
```

# Pendiente Linea
Básicos-Pendiente Linea

Modifica el programa para que haga lo siguiente:
Realiza un programa que reciba las coordenadas de dos puntos y que calcule
la pendiente de la recta que une esos dos puntos.
La fórmula para calcular la pendiente es:

<b>m = (y2 - y1) / (x2 - x1)</b>

**Entradas:**
Cuatro números con punto decimal que representan las coordenadas
x1, y1, x2, y2. Uno en cada línea y en el orden que se especifica.

**Salidas:**
Un número decimal que representa la pendiente.

Ejemplo de ejecución del programa:
```
Dame x1: 3.6
Dame y1: -1.3
Dame x2: 8.6
Dame y2: 2.5
Pendiente: 0.76
```

# Teléfono
Básicos-Costo del teléfono


Modifica el programa para que haga lo siguiente:
Una compañía de telefonía celular cobra $0.80 por mensaje, por mega o
por minuto. Realiza un programa que calcule el costo total mensual de un
usuario según estos datos.

**Entradas:**
El número de mensajes (número entero), el número de megas (número flotante) y el número de minutos (número entero). Un dato por línea y en ese orden.

**Salidas:**
Un número que representa el costo mensual.

Ejemplo:
```
Dame el número de mensajes: 38
Dame el número de megas: 3.1
Dame el número de minutos: 78
El costo mensual es: 95.28
```

# PEMDAS
Básicos-PEMDAS


Modifica el programa para que haga lo siguiente:

Escribe un programa que despliegue en pantalla el resultado de las
siguientes operaciones:
<p>oper1 = 2 &frac34; + 4 &frac23; - 3 &frac15; + 5 &frac12;</p>
<p>oper2 = 2 <span>&#8730;</span>35<sup>2</sup> + 4 <span>&#8730;</span>36<sup>3</sup> - 6<span>&#8730;</span>49<sup>2</sup></p>
<p>oper3 = (a<sup>3</sup> + 2b<sup>2</sup>) / (4a)</p>
<p>oper4 = (2(a+b)<sup>2</sup> + 4(a-b)<sup>2</sup>) / ab<sup>2</sup></p>
<p>oper5 =  <span>&#8730;</span>((a+b)<sup>2</sup> + 2<sup>(a+b)</sup>) / (2a + 2b)<sup>2</sup></p>

<b>El valor de a es 4 y b es 5</b>

**Entradas:**
El programa no tiene entradas.

**Salidas:**
Cinco números (flotantes), resultado de las 5 operaciones anteriores, el orden
de los resultados debe con el orden de las operaciones mostradas arriba.
Los datos se deben formatear para que imprima un máximo de 4 cifras decimales
(usa la función <i>round()</i>).

NOTA IMPORTANTE: La salida debe coincidir exactamente con el formato y/o tipo
de dato que se te pide como salida.

Ejemplo:
```
6.0667
640.0
7.125
1.66
0.0752
```

# Distancia entre dos puntos


Desarrolla un programa en Python que calcule la distancia entre dos
puntos del plano cartesiano.

**Entrada:**
El programa solicita el punto inicial (x1, y1) y el final (x2, y2).
Todos enteros y en ese orden.

**Salida:**
El valor de la distancia (numero flotante) que existe entre los dos puntos.
Despliega el resultado con la palabra distancia (todo en minúsculas) y un =
y el número formateado a 2 decimales (sin espacios entre caracteres y números).
Por ejemplo: distancia= 9.90

## Ejemplos de ejecución

Ejemplo 1

```plaintext
x1= 2
y1= -4
x2= 5
y2= 3
distancia= 7.62
```

Ejemplo 2

```plaintext
x1= 5
y1= 10
x2= -3
y2= -4
distancia= 16.12
```

# Razón Aurea

La razón áurea es un número irracional, representado por la letra griega phi
en honor al escultor griego Fidias. Este número aparece repetidamente en el
mundo que nos rodea, La proporción áurea podremos encontrarla en el arte, la
música e incluso en las proporciones de nuestro cuerpo. En matemáticas, la
razón áurea será una forma de dividir un segmento en 2 partes: lo pequeño es a
lo grande como lo grande es al todo. Su valor se calcula de la siguiente manera:

varphi = (1+sqrt(5))/2


**Entradas:**
Un número flotante que representa el número por el cuál se multiplicará la razón aurea (resultado de la fórmula).
Un entero que representa el número de cifras decimales para el despliegue del número.
(Los valores se deben ingresar cada uno en un renglón y en el orden indicado).

**Salida:**
La razón áurea

Ejemplo:
```
Número: 1.5
Decimales a mostrar: 3
Razón áurea: 2.427
```
Ejemplo 2:
```
Número: 4.7
Decimales a mostrar: 5
Razón áurea: 7.60476
```

# Saldo final de una cuenta bancaria
Básicos-CuentaBancaria

Modifica el programa para que haga lo siguiente:

Un banco cobra el 7.5% de interés mensual sobre el saldo final de una cuenta.
Además, cada cheque expedido tiene un costo de 13 pesos. Realiza un programa
para obtener el saldo mensual de una cuenta en este banco tomando en cuenta el
saldo del mes anterior, los ingresos, los egresos y el número de cheques expedidos.

**Entradas:**
* Saldo del mes anterior (número decimal)
* Ingresos (número decimal)
* Egresos (número decimal)
* Número de cheques expedidos (número entero)

Un dato en cada línea en ese orden.

**Salida:**
Un número decimal que represente el saldo final de la cuenta en ese mes.

Ejemplo:
```
Dame el saldo del mes anterior: 100.1
Dame los ingresos: 57.38
Dame los egresos: 5.23
Dame el número de cheques: 2
El saldo final de la cuenta es: 116.78125
```

# Publicación en una editorial
Básicos-Editorial


Modifica el programa para que haga lo siguiente:

Una editorial cobra 60 dólares por página publicada y hace un descuento de 10%
a los autores. Además, la editorial tiene una política que indica que 475
palabras es una página. Realiza un programa que indique cuál es el costo de
una publicación a partir de las palabras de la misma. Considera que se necesita
una página completa aunque el número de palabras sea menor a 475.

**Entradas:**
* Número de páginas (número entero)

**Salida:** Un número decimal que represente el costo de la publicación.

Ejemplo:
```
Dame el número de palabras: 500
El costo de la publicación es: 108.0
```

# Levadura para pizza
Básicos-LevaduraParaPizza


Modifica el programa para que haga lo siguiente:

Se requieren 50 gramos de levadura para 1 kg. de harina si se utiliza para
la base de una pizza. Realiza el cálculo de la levadura necesitada a partir
de los gramos de harina que indique el usuario.

**Entradas:**
* Gramos de harina (número decimal)

**Salida:** Un número decimal que represente la cantidad en gramos de levadura que se requieren.

Ejemplo:
```
Dame la harina en gramos: 1500
Necesitas estos gramos de levadura: 75.0
```
