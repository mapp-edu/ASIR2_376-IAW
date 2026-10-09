---
layout: doc
title: Funciones
sidebar: true
outline: [2, 3]
aside: true
---

# 🧮 Tema 3 — Funciones

<ExportPDF />

::: info-box Diapositivas del tema
Este tema tiene presentación de clase: [ver las diapositivas](../diapositivas/3-funciones).
:::

## Introducción

Las funciones son conjuntos de instrucciones que realizan una tarea específica y pueden devolver un valor. Facilitan la reutilización del código y reducen errores.

```php
echo date("l"); // Muestra el día de la semana
```

La función `date` devuelve la fecha actual con el formato indicado. Como cualquier función, se llama escribiendo su nombre seguido de paréntesis.

PHP incluye cientos de **funciones integradas** (de cadenas, matemáticas, de fecha…) y permite definir **funciones de usuario**.

## Funciones de usuario

Una función de usuario es un bloque de código reutilizable que realiza una tarea específica. Se define una vez y puede llamarse muchas veces desde diferentes partes del programa.

```php
<?php
function calcularEdad($anioNacimiento) {
    $anioActual = date("Y");
    return $anioActual - $anioNacimiento;
}

// Llamada a la función
echo "Tu edad es: " . calcularEdad(1990);
?>
```

La salida es `Tu edad es:` seguido de los años transcurridos desde 1990 hasta el año actual.

### Retorno de múltiples valores

Una función solo devuelve un valor, pero ese valor puede ser un array. Así se devuelven varios datos a la vez.

```php
$names = fix_names("WILLIAM", "henry", "gatES");
echo $names[0] . " " . $names[1] . " " . $names[2];

function fix_names($n1, $n2, $n3) {
    $n1 = ucfirst(strtolower($n1));
    $n2 = ucfirst(strtolower($n2));
    $n3 = ucfirst(strtolower($n3));
    return array($n1, $n2, $n3);
}
```

La función `fix_names` devuelve un array con los tres nombres corregidos, lo que permite acceder a cada uno por separado. El resultado es `William Henry Gates`.

### Valores por defecto

Un parámetro puede tener un valor por defecto, que se usa si la llamada no lo indica. Los parámetros con valor por defecto van siempre al final.

```php
function saludar($nombre, $saludo = "Hola") {
    return "$saludo, $nombre";
}

echo saludar("Ana");             // Hola, Ana
echo saludar("Ana", "Buenos días"); // Buenos días, Ana
```

### Tipos de los parámetros y del resultado

Desde PHP 7 se puede declarar el tipo de cada parámetro y del valor que devuelve la función. Si se llama con un dato que no se puede convertir al tipo indicado, PHP lanza un error en lugar de seguir con un valor incorrecto.

```php
function areaRectangulo(float $base, float $altura): float {
    return $base * $altura;
}

echo areaRectangulo(3, 4.5);   // 13.5
```

Con `declare(strict_types=1);` al principio del archivo, PHP deja de convertir tipos automáticamente en las llamadas: `areaRectangulo("3", 4)` daría error.

| Tipo | Contiene |
|:-----|:---------|
| `int`, `float` | Números enteros y decimales. |
| `string` | Texto. |
| `bool` | `true` o `false`. |
| `array` | Un array. |
| `?int`, `?string`… | El tipo indicado o `null`. |
| `void` | Solo para el resultado: la función no devuelve nada. |

### Paso por valor y por referencia

Por defecto, PHP pasa a la función una **copia** del valor: lo que haga la función con el parámetro no afecta a la variable original. Si el parámetro se declara con `&`, la función recibe una **referencia** a la variable y sus cambios se mantienen al salir.

```php
function duplicarValor($n) {
    $n = $n * 2;
}

function duplicarReferencia(&$n) {
    $n = $n * 2;
}

$a = 5;
duplicarValor($a);
echo $a;   // 5: la función trabajó con una copia

duplicarReferencia($a);
echo $a;   // 10: la función modificó la variable original
```

::: tip-box Cuándo usar referencias
Las referencias son útiles para modificar arrays grandes sin copiarlos, como hace la función integrada `sort($array)`. En el resto de casos es más claro que la función **devuelva** el resultado con `return`.
:::

## Funciones de cadena

### Longitud y mayúsculas

| Función | Descripción | Ejemplo |
|:--------|:------------|:--------|
| `strlen($string)` | Devuelve la longitud de la cadena. | `echo strlen("Hola"); // 4` |
| `strtoupper($string)` | Convierte todos los caracteres a mayúsculas. | `echo strtoupper("hola"); // HOLA` |
| `strtolower($string)` | Convierte todos los caracteres a minúsculas. | `echo strtolower("HOLA"); // hola` |

### Búsqueda y reemplazo

| Función | Descripción | Ejemplo |
|:--------|:------------|:--------|
| `strpos($haystack, $needle)` | Devuelve la posición de la primera aparición de `$needle` en `$haystack`. | `echo strpos("Hola mundo", "mundo"); // 5` |
| `strrpos($haystack, $needle)` | Devuelve la posición de la última aparición de `$needle` en `$haystack`. | `echo strrpos("Hola mundo mundo", "mundo"); // 11` |
| `str_replace($search, $replace, $subject)` | Reemplaza todas las apariciones de `$search` en `$subject` por `$replace`. | `echo str_replace("mundo", "PHP", "Hola mundo"); // Hola PHP` |

::: warning-box Las posiciones empiezan en 0
`strpos` devuelve `0` si la coincidencia está al principio y `false` si no la encuentra. Como `0 == false`, para saber si hay coincidencia hay que comparar con `!== false`.
:::

### Subcadenas

| Función | Descripción | Ejemplo |
|:--------|:------------|:--------|
| `substr($string, $start, $length)` | Devuelve una parte de la cadena, comenzando en `$start` y con longitud `$length`. | `echo substr("Hola", 1, 2); // ol` |
| `substr_replace($string, $replacement, $start, $length)` | Reemplaza por `$replacement` la parte de la cadena que comienza en `$start` y tiene longitud `$length`. | `echo substr_replace("Hola", "a", 1, 2); // Haa` |

### Limpieza de espacios

| Función | Descripción | Ejemplo |
|:--------|:------------|:--------|
| `trim($string)` | Elimina los espacios en blanco (u otros caracteres) al inicio y al final. | `echo trim(" Hola "); // "Hola"` |
| `ltrim($string)` | Elimina los espacios en blanco al inicio. | `echo ltrim(" Hola "); // "Hola "` |
| `rtrim($string)` | Elimina los espacios en blanco al final. | `echo rtrim(" Hola "); // " Hola"` |

### Unir y dividir

| Función | Descripción | Ejemplo |
|:--------|:------------|:--------|
| `explode($delimiter, $string)` | Divide la cadena en un array utilizando `$delimiter` como separador. | `print_r(explode(",", "Hola,mundo")); // Array ( [0] => Hola [1] => mundo )` |
| `implode($glue, $array)` | Une los elementos de un array en una cadena, separados por `$glue`. | `echo implode(" ", ["Hola", "mundo"]); // Hola mundo` |

### Otras funciones

| Función | Descripción | Ejemplo |
|:--------|:------------|:--------|
| `ucfirst($string)` | Convierte a mayúscula el primer carácter de la cadena. | `echo ucfirst("hola"); // Hola` |
| `ucwords($string)` | Convierte a mayúscula el primer carácter de cada palabra. | `echo ucwords("hola mundo"); // Hola Mundo` |
| `strrev($string)` | Devuelve la cadena en orden inverso. | `echo strrev("Hola"); // aloH` |

::: info-box Y muchas más
El manual de PHP recoge todas las [funciones de cadenas](https://www.php.net/manual/es/ref.strings.php).
:::

## Incluir otros archivos: `include` y `require`

Las funciones propias suelen guardarse en un archivo aparte para usarlas desde varios scripts. PHP tiene cuatro instrucciones para incorporar un archivo en otro:

| Instrucción | Si el archivo no existe | Si ya se había incluido |
|:------------|:------------------------|:------------------------|
| `include` | Muestra un aviso y **continúa**. | Lo vuelve a incluir. |
| `require` | Error fatal: el script **se detiene**. | Lo vuelve a incluir. |
| `include_once` | Muestra un aviso y continúa. | **No** lo vuelve a incluir. |
| `require_once` | Error fatal: el script se detiene. | **No** lo vuelve a incluir. |

```php
require_once "funciones.php";   // imprescindible: sin él no se puede seguir
include "cabecera.php";         // si falta, la página se muestra igualmente
```

Las variantes `_once` evitan los errores que se producen al definir dos veces la misma función o constante. Para archivos de funciones o de configuración, lo habitual es `require_once`.

::: tip-box Rutas seguras
Para que la ruta funcione desde cualquier carpeta, constrúyela a partir de la carpeta del archivo actual: `require_once __DIR__ . "/funciones.php";`.
:::

## Funciones matemáticas

| Función | Descripción | Ejemplo |
|:--------|:------------|:--------|
| `abs($number)` | Devuelve el valor absoluto de un número. | `echo abs(-5); // 5` |
| `sqrt($number)` | Calcula la raíz cuadrada de un número. | `echo sqrt(25); // 5` |
| `pow($base, $exp)` | Eleva un número a la potencia especificada. | `echo pow(2, 3); // 8` |
| `max($val1, $val2, ...)` | Devuelve el valor máximo de una lista de valores. | `echo max(3, 7, 2, 9); // 9` |
| `min($val1, $val2, ...)` | Devuelve el valor mínimo de una lista de valores. | `echo min(3, 7, 2, 9); // 2` |
| `round($number, $precision)` | Redondea un número a la cantidad de decimales especificada (por defecto, 0). | `echo round(3.14159, 2); // 3.14` |
| `ceil($number)` | Redondea hacia arriba al entero más cercano. | `echo ceil(4.3); // 5` |
| `floor($number)` | Redondea hacia abajo al entero más cercano. | `echo floor(4.7); // 4` |
| `rand($min, $max)` | Genera un número aleatorio entre los valores mínimo y máximo dados. | `echo rand(1, 10); // p. ej. 7` |
| `mt_rand($min, $max)` | Genera un número aleatorio con el algoritmo Mersenne Twister. | `echo mt_rand(1, 100); // p. ej. 42` |

::: note-box rand y mt_rand
En versiones antiguas de PHP, `mt_rand` era más rápida y de mejor calidad que `rand`. Desde PHP 7.1, `rand` usa el mismo generador que `mt_rand`.
:::

## Funciones de fecha y hora

### Marcas de tiempo: `time`

Para llevar un registro de la fecha y la hora, PHP utiliza marcas de tiempo estándar de Unix (*timestamps*): el número de segundos transcurridos desde el inicio del 1 de enero de 1970. La función `time` devuelve el *timestamp* actual.

```php
echo time(); // p. ej. 1725219936
```

Para obtener el *timestamp* del mismo momento de la próxima semana hay que sumar 7 días × 24 horas × 60 minutos × 60 segundos al valor devuelto:

```php
echo time() + 7 * 24 * 60 * 60; // p. ej. 1725824736
```

### Crear una fecha concreta: `mktime`

Para crear el *timestamp* de una fecha específica se usa la función `mktime`. El siguiente código devuelve el *timestamp* del primer segundo del primer día de diciembre de 2022:

```php
echo mktime(0, 0, 0, 12, 1, 2022); // 1669852800 (con zona horaria UTC)
```

Los parámetros son, en orden: hora, minuto, segundo, mes, día y año.

### Mostrar fechas: `date`

La función `date` permite mostrar la fecha en diferentes formatos personalizados. Su firma es:

```text
date(string $format, ?int $timestamp = null): string
```

- El segundo parámetro es opcional. Si no se indica, se usa el momento actual.
- Se puede pasar el resultado de `mktime` para mostrar una fecha concreta.

```php
echo date("l F jS, Y - g:ia", time());
// p. ej. Friday October 25th, 2024 - 2:05pm
```

La función usa una **cadena de formato**: cada letra se sustituye por una parte de la fecha.

::: warning-box Los nombres salen en inglés
`date` escribe siempre los nombres de días y meses en inglés (`Monday`, `October`…).
:::

**Especificadores de día**

| Formato | Descripción | Valor devuelto |
|:-------:|:------------|:---------------|
| `d` | Día del mes, dos dígitos, con ceros iniciales | 01 a 31 |
| `D` | Día de la semana, tres letras | Mon a Sun |
| `j` | Día del mes, sin ceros iniciales | 1 a 31 |
| `l` | Día de la semana, nombre completo | Sunday a Saturday |
| `N` | Día de la semana, numérico, de lunes a domingo | 1 a 7 |
| `S` | Sufijo ordinal inglés para el día del mes (útil con `j`) | st, nd, rd o th |
| `w` | Día de la semana, numérico, de domingo a sábado | 0 a 6 |
| `z` | Día del año | 0 a 365 |

**Especificador de semana**

| Formato | Descripción | Valor devuelto |
|:-------:|:------------|:---------------|
| `W` | Número de semana del año | 01 a 53 |

**Especificadores de mes**

| Formato | Descripción | Valor devuelto |
|:-------:|:------------|:---------------|
| `F` | Nombre del mes | January a December |
| `m` | Número del mes, con ceros iniciales | 01 a 12 |
| `M` | Nombre del mes, tres letras | Jan a Dec |
| `n` | Número del mes, sin ceros iniciales | 1 a 12 |
| `t` | Número de días del mes dado | 28 a 31 |

**Especificadores de año**

| Formato | Descripción | Valor devuelto |
|:-------:|:------------|:---------------|
| `L` | Año bisiesto | 1 = sí, 0 = no |
| `y` | Año, 2 dígitos | 00 a 99 |
| `Y` | Año, 4 dígitos | 0000 a 9999 |

**Especificadores de tiempo**

| Formato | Descripción | Valor devuelto |
|:-------:|:------------|:---------------|
| `a` | Antes o después del mediodía, en minúsculas | am o pm |
| `A` | Antes o después del mediodía, en mayúsculas | AM o PM |
| `g` | Hora del día, formato de 12 horas, sin ceros iniciales | 1 a 12 |
| `G` | Hora del día, formato de 24 horas, sin ceros iniciales | 0 a 23 |
| `h` | Hora del día, formato de 12 horas, con ceros iniciales | 01 a 12 |
| `H` | Hora del día, formato de 24 horas, con ceros iniciales | 00 a 23 |
| `i` | Minutos, con ceros iniciales | 00 a 59 |
| `s` | Segundos, con ceros iniciales | 00 a 59 |

### Constantes de fecha

PHP cuenta con constantes que pueden usarse con la función `date` para devolver la fecha en formatos estándar.

| Constante | Descripción | Formato | Ejemplo de salida |
|:----------|:------------|:--------|:------------------|
| `DATE_ATOM` | Formato para *feeds* Atom. | `"Y-m-d\TH:i:sP"` | 2025-05-15T12:00:00+00:00 |
| `DATE_COOKIE` | Formato para cookies establecidas desde un servidor web o JavaScript. | `"l, d-M-Y H:i:s T"` | Thursday, 15-May-2025 12:00:00 UTC |
| `DATE_RSS` | Formato para *feeds* RSS. | `"D, d M Y H:i:s O"` | Thu, 15 May 2025 12:00:00 +0000 |
| `DATE_W3C` | Formato del Consorcio World Wide Web. | `"Y-m-d\TH:i:sP"` | 2025-05-15T12:00:00+00:00 |

```php
echo date(DATE_RSS);
// p. ej. Fri, 25 Oct 2024 14:05:00 +0000
```

### Validar una fecha: `checkdate`

Para validar si una fecha introducida es correcta se puede usar la función `checkdate`, que devuelve `TRUE` si la fecha es válida o `FALSE` si no lo es. Sus parámetros son mes, día y año.

```php
$month = 9;    // Septiembre (solo tiene 30 días)
$day = 31;     // 31
$year = 2025;  // Año 2025
if (checkdate($month, $day, $year)) echo "La fecha es válida";
else echo "La fecha no es válida";
```

La salida es `La fecha no es válida`: la función determina que el 31 de septiembre es una fecha incorrecta, ya que septiembre tiene solo 30 días.

### La clase `DateTime`

Además de las funciones, PHP ofrece la clase `DateTime`, que representa una fecha concreta y permite operar con ella de forma más clara.

```php
date_default_timezone_set('Europe/Madrid');

$hoy = new DateTime();                          // fecha y hora actuales
echo $hoy->format('d/m/Y H:i');                 // p. ej. 09/10/2026 11:30

$entrega = new DateTime('2026-11-15');          // una fecha concreta
echo $entrega->format('l, d \d\e F \d\e Y');    // Sunday, 15 de November de 2026

$entrega->modify('+7 days');                    // sumar o restar tiempo
echo $entrega->format('d/m/Y');                 // 22/11/2026

$diferencia = $hoy->diff($entrega);             // diferencia entre dos fechas
echo "Faltan {$diferencia->days} días";
```

| Método | Qué hace |
|:-------|:---------|
| `new DateTime('texto')` | Crea la fecha a partir de un texto: `'2026-11-15'`, `'tomorrow'`, `'next monday'`. |
| `format('formato')` | Devuelve la fecha como texto, con los mismos especificadores que `date`. |
| `modify('+1 month')` | Suma o resta tiempo. |
| `diff($otra)` | Devuelve un objeto con la diferencia: `days`, `y`, `m`, `d`, `h`, `i`… |

`DateTime::createFromFormat('d/m/Y', '15/11/2026')` crea una fecha a partir de un texto con un formato conocido, por ejemplo el que escribe un usuario en un formulario.

::: info-box Más información
Manual de PHP: [funciones de fecha y hora](https://www.php.net/manual/es/ref.datetime.php).
:::

---

**Siguiente tema:** [Matrices (arrays) →](./4-matrices)
