---
layout: doc
title: Introducción a PHP
sidebar: true
outline: [2, 3]
aside: true
---

# 🐘 Tema 1 — Introducción a PHP

<ExportPDF />

::: info-box Diapositivas del tema
Este tema tiene presentación de clase: [ver las diapositivas](../diapositivas/1-introduccion-php).
:::

## Estructura de un script en PHP

En PHP, el código debe estar contenido entre las etiquetas `<?php` y `?>`. Esto le indica al servidor qué parte del archivo debe procesar como código PHP.

```php
<?php
echo "¡Hola, mundo!";
?>
```

## Comentarios

Existen dos formas de añadir comentarios en PHP:

1. **Comentarios de una sola línea**, usando `//` o `#`.

   ```php
   // Esto es un comentario de una línea
   $x += 10; // Incrementa $x en 10
   ```

2. **Comentarios de varias líneas**, usando `/* */`.

   ```php
   /* Este es un comentario
   de varias líneas */
   ```

::: warning-box Precaución: los comentarios no se anidan
No se pueden anidar comentarios de varias líneas. El primer `*/` cierra el comentario y lo que queda detrás provoca un error:

```php
/* Comentario /* Comentario anidado */ */
```

Utiliza un **editor con resaltado de sintaxis** para detectar este tipo de errores a simple vista.
:::

## Sintaxis básica

- Las instrucciones en PHP deben finalizar con un **punto y coma** (`;`).
- El símbolo `$` debe preceder a todas las variables.

```php
$mycounter = 1;
$mystring = "Hola";
$myarray = array("Uno", "Dos", "Tres");
```

## Variables

Las variables en PHP son dinámicas: pueden contener números, cadenas, arrays, etc. Las cadenas se definen usando comillas simples o dobles.

```php
$username = "Fred Smith";
echo $username;
```

### Primer programa en PHP

Crea un archivo PHP y guárdalo como `test1.php`:

```php
<?php
$username = "Fred Smith";
echo $username;
echo "<br>";
$current_user = $username;
echo $current_user;
?>
```

**Resultado:** al ejecutarlo en el navegador, verás dos veces el nombre *Fred Smith*.

### Variables numéricas

Las variables pueden contener números enteros o decimales.

```php
$count = 17;
$price = 19.99;
echo $count;
echo $price;
```

### ¿Qué son las matrices?

Una matriz (*array*) puede pensarse como varias cajas de cerillas pegadas entre sí: cada caja guarda un valor y tiene una posición.

Ejemplo de una matriz con los nombres de los jugadores de un equipo:

```php
$team = array('Bill', 'Mary', 'Mike', 'Chris', 'Anne');
```

Las posiciones empiezan a contar en 0. Para acceder al cuarto jugador se usa el índice 3:

```php
echo $team[3]; // Muestra 'Chris'
```

### Matrices de dos dimensiones

Las matrices pueden ser multidimensionales. Por ejemplo, un tablero de tres en raya es una matriz de 3×3:

```php
$oxo = array(
  array('x', ' ', 'o'),
  array('o', 'o', 'x'),
  array('x', 'o', ' ')
);
```

Para acceder al tercer elemento de la segunda fila:

```php
echo $oxo[1][2]; // Muestra 'x'
```

Las matrices se estudian a fondo en el [tema 4](./4-matrices).

### Reglas de denominación de variables

1. Deben comenzar con una letra o con el carácter `_`.
2. Solo pueden contener letras, números y `_`.
3. No pueden contener espacios; usa `_` para separar palabras.
4. Distinguen entre mayúsculas y minúsculas.

```php
$user_name = "John";
```

## Operadores

### Operadores aritméticos

Los operadores aritméticos en PHP son similares a los de la aritmética básica:

| Operador | Descripción | Ejemplo |
|:--------:|:------------|:--------|
| `+` | Suma | `$j + 1` |
| `-` | Resta | `$j - 6` |
| `*` | Multiplicación | `$j * 11` |
| `/` | División | `$j / 4` |
| `%` | Módulo (resto de la división) | `$j % 9` |
| `++` | Incremento | `++$j` |
| `--` | Decremento | `--$j` |
| `**` | Exponenciación | `$j ** 2` |

### Orden de prioridad de los operadores

Cuando una expresión combina varios operadores, PHP los evalúa según su precedencia. La tabla los ordena de mayor a menor prioridad; la asociatividad indica en qué sentido se agrupan los operadores de la misma fila.

| Asociatividad | Operadores | Tipo |
|:--------------|:-----------|:-----|
| no asociativo | `clone` `new` | clonación y creación de objetos |
| derecha | `**` | aritmético |
| derecha | `++` `--` `~` `(int)` `(float)` `(string)` `(array)` `(object)` `(bool)` `@` | tipos e incremento/decremento |
| no asociativo | `instanceof` | tipos |
| derecha | `!` | lógico |
| izquierda | `*` `/` `%` | aritmético |
| izquierda | `+` `-` | aritmético |
| izquierda | `<<` `>>` | bit a bit |
| izquierda | `.` | concatenación de cadenas |
| no asociativo | `<` `<=` `>` `>=` | comparación |
| no asociativo | `==` `!=` `===` `!==` `<>` `<=>` | comparación |
| izquierda | `&` | bit a bit y referencias |
| izquierda | `^` | bit a bit |
| izquierda | `\|` | bit a bit |
| izquierda | `&&` | lógico |
| izquierda | `\|\|` | lógico |
| derecha | `??` | fusión de null |
| no asociativo | `? :` | ternario |
| derecha | `=` `+=` `-=` `*=` `**=` `/=` `.=` `%=` `&=` `\|=` `^=` `<<=` `>>=` `??=` | asignación |
| izquierda | `and` | lógico |
| izquierda | `xor` | lógico |
| izquierda | `or` | lógico |

::: info-box Más información
La tabla completa y actualizada está en el manual de PHP: [precedencia de operadores](https://www.php.net/manual/es/language.operators.precedence.php).
:::

### Operadores de asignación

Los operadores de asignación permiten modificar variables:

| Operador | Ejemplo | Equivalente a |
|:--------:|:--------|:--------------|
| `=` | `$j = 15` | `$j = 15` |
| `+=` | `$j += 5` | `$j = $j + 5` |
| `-=` | `$j -= 3` | `$j = $j - 3` |
| `*=` | `$j *= 8` | `$j = $j * 8` |
| `/=` | `$j /= 16` | `$j = $j / 16` |
| `.=` | `$j .= $k` | `$j = $j . $k` |
| `%=` | `$j %= 4` | `$j = $j % 4` |

### Operadores de comparación

Los operadores de comparación se usan para comparar dos valores:

| Operador | Descripción | Ejemplo |
|:--------:|:------------|:--------|
| `==` | es igual a | `$j == 4` |
| `!=` | no es igual a | `$j != 21` |
| `>` | es mayor que | `$j > 3` |
| `<` | es menor que | `$j < 100` |
| `>=` | es mayor o igual que | `$j >= 15` |
| `<=` | es menor o igual que | `$j <= 8` |
| `===` | es idéntico a | `$j === "987"` |
| `!==` | no es idéntico a | `$j !== "1.2e3"` |

#### ¿Cómo funciona el operador de igualdad estándar `==`?

El operador de igualdad estándar compara si los valores a ambos lados son iguales, **realizando la conversión de tipos si es necesario**. Estos ejemplos muestran el resultado en PHP 8:

```php
// si uno es un número y el otro una cadena numérica, se comparan como números
var_dump(1 == "01");            // 1 == 1 -> true
// si uno es un número y el otro una cadena NO numérica, se comparan como cadenas
var_dump(1 == "1hjfitujghb");   // "1" == "1hjfitujghb" -> false
var_dump(0 == "a");             // "0" == "a" -> false
var_dump('a' == 0);             // "a" == "0" -> false
// si ambos son cadenas numéricas, se comparan como números
var_dump("1" == "01");          // 1 == 1 -> true
// si ambos son cadenas pero alguna no es numérica, no hay conversión
var_dump("1" == "1hjf");        // "1" == "1hjf" -> false
// si alguno es booleano, ambos lados se convierten a booleano
var_dump(true == "1hjfitujghb");  // true == true -> true
var_dump(false == "0");           // false == false -> true
// null frente a una cadena se compara como cadena vacía
var_dump(null == "1hjfitujghb");  // "" == "1hjfitujghb" -> false
```

::: warning-box Cambio de comportamiento en PHP 8
Hasta PHP 7, al comparar un número con una cadena no numérica la cadena se convertía a número, de modo que `0 == "a"` era `true`. Desde PHP 8 la comparación se hace como cadenas y el resultado es `false`. Si encuentras ejemplos antiguos con otro resultado, es por este cambio.
:::

#### ¿Cómo funciona el operador de igualdad estricto `===`?

El operador de identidad comprueba que, además de ser iguales, los valores sean **del mismo tipo**. Con él, todos los ejemplos anteriores dan `false`:

```php
// Todos son FALSE
var_dump(1 === "1hjfitujghb");    // false
var_dump(0 === "a");              // false
var_dump('a' === 0);              // false
var_dump("1" === "01");           // false
var_dump("1" === "1hjf");         // false
var_dump(null === "1hjfitujghb"); // false
var_dump(true === "1hjfitujghb"); // false
var_dump(false === "0");          // false
```

::: tip-box Usa la comparación estricta por defecto
Para comprobar datos que llegan de un formulario o de una base de datos, `===` evita sorpresas con la conversión de tipos.
:::

### Operadores lógicos

| Operador | Descripción | Ejemplo |
|:--------:|:------------|:--------|
| `&&` | And (y) | `$j == 3 && $k == 2` |
| `and` | And (y) de baja prioridad | `$j == 3 and $k == 2` |
| `\|\|` | Or (o) | `$j < 5 \|\| $j > 10` |
| `or` | Or (o) de baja prioridad | `$j < 5 or $j > 10` |
| `!` | Not (no) | `!($j == $k)` |
| `xor` | Or exclusivo | `$j xor $k` |

`||` y `or` hacen la misma operación, pero **no tienen la misma precedencia**. `||` se evalúa antes que la asignación y `or` después:

```php
// "||" tiene una precedencia mayor que "or"

// El resultado de la expresión (false || true) es asignado a $e
// Actúa como: ($e = (false || true))
$e = false || true;

// La constante false es asignada a $f antes de que suceda la operación "or"
// Actúa como: (($f = false) or true)
$f = false or true;

var_dump($e, $f);
// bool(true)
// bool(false)
```

Lo mismo ocurre entre `&&` y `and`:

```php
// "&&" tiene una precedencia mayor que "and"

// El resultado de la expresión (true && false) es asignado a $g
// Actúa como: ($g = (true && false))
$g = true && false;

// La constante true es asignada a $h antes de que suceda la operación "and"
// Actúa como: (($h = true) and false)
$h = true and false;

var_dump($g, $h);
// bool(false)
// bool(true)
```

### Incremento y decremento

Los operadores `++` y `--` pueden ir delante o detrás de la variable. Detrás (*post*), primero se usa el valor y después se modifica; delante (*pre*), primero se modifica y después se usa.

::: tabs

== Incremento

```php
<?php
echo "<h3>Postincremento</h3>";
$a = 5;
echo "Debe ser 5: " . $a++ . "<br />\n";
echo "Debe ser 6: " . $a . "<br />\n";

echo "<h3>Preincremento</h3>";
$a = 5;
echo "Debe ser 6: " . ++$a . "<br />\n";
echo "Debe ser 6: " . $a . "<br />\n";
?>
```

== Decremento

```php
<?php
echo "<h3>Postdecremento</h3>";
$a = 5;
echo "Debe ser 5: " . $a-- . "<br />\n";
echo "Debe ser 4: " . $a . "<br />\n";

echo "<h3>Predecremento</h3>";
$a = 5;
echo "Debe ser 4: " . --$a . "<br />\n";
echo "Debe ser 4: " . $a . "<br />\n";
?>
```

:::

## Cadenas de texto

### Concatenación de cadenas

El punto (`.`) une cadenas:

```php
echo "You have " . $msgs . " messages.";
```

El operador `.=` añade una cadena al final de otra:

```php
$bulletin .= $newsflash;
```

### Tipos de cadenas

**Comillas simples:** el contenido se toma literalmente, sin sustituir variables.

```php
$info = 'Preface variables with a $ like this: $variable';
```

**Comillas dobles:** las variables se sustituyen por su valor.

```php
echo "This week $count people have viewed your profile";
```

### Caracteres de escape

Comillas dentro de una cadena delimitada con el mismo tipo de comillas:

```php
$text = 'My spelling\'s still atroshus';
```

```php
$text = "She wrote upon it, \"Return to sender\".";
```

Caracteres especiales, como el tabulador (`\t`) o el salto de línea (`\n`), que solo se interpretan entre comillas dobles:

```php
$heading = "Date\tName\tPayment";
```

### Cadenas de varias líneas

Una cadena puede ocupar varias líneas:

```php
$author = "Steve Ballmer";
echo "Developers, developers, developers, developers, developers,
developers, developers, developers, developers!
- $author.";
```

También se puede usar la sintaxis **heredoc**, que empieza con `<<<` seguido de un identificador y termina con ese mismo identificador en una línea aparte:

```php
$author = "Brian W. Kernighan";
echo <<<_END
Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it.
- $author.
_END;
```

## Tipificación de variables

PHP convierte automáticamente entre números y cadenas según la operación que se haga con ellos.

```php
$number = 12345 * 67890;
echo substr($number, 3, 1); // Convierte $number a cadena y extrae el carácter
```

```php
$pi = "3.1415927";
$radius = 5;
echo $pi * ($radius * $radius); // Convierte $pi a número y calcula el área
```

## Constantes

Las constantes son valores que no cambian durante la ejecución del script. Se definen una sola vez y no pueden ser modificadas.

**Definición de una constante:**

```php
define("ROOT_LOCATION", "/usr/local/www/");
```

**Uso de una constante** (sin `$` delante):

```php
$directory = ROOT_LOCATION;
```

### Constantes mágicas

Son constantes predefinidas por PHP que proporcionan información sobre el archivo y el contexto de ejecución:

| Constante | Contenido |
|:----------|:----------|
| `__LINE__` | Número de línea actual del archivo. |
| `__FILE__` | Ruta completa del archivo. |
| `__DIR__` | Directorio del archivo. |
| `__FUNCTION__` | Nombre de la función actual. |
| `__CLASS__` | Nombre de la clase actual. |
| `__METHOD__` | Nombre del método actual. |
| `__NAMESPACE__` | Nombre del espacio de nombres actual. |

```php
echo "This is line " . __LINE__ . " of file " . __FILE__;
```

## Diferencia entre `echo` y `print`

- `echo`: constructor del lenguaje que puede tomar varios parámetros y no devuelve ningún valor.
- `print`: constructor similar a una función, que toma un solo parámetro y devuelve 1. Por eso puede usarse dentro de una expresión.

```php
$b ? print "TRUE" : print "FALSE";
```

## Funciones

Las funciones encapsulan bloques de código que realizan tareas específicas y pueden aceptar parámetros y devolver valores.

**Declaración de una función:**

```php
function longdate($timestamp) {
    return date("l F jS Y", $timestamp);
}
```

**Llamada a una función:**

```php
echo longdate(time());
```

**Función con varios parámetros:**

```php
function longdate($text, $timestamp) {
    return $text . date("l F jS Y", $timestamp);
}
echo longdate("The date is ", time());
```

Las funciones se estudian a fondo en el [tema 3](./3-funciones).

## Ámbito de las variables

### Variables locales y globales

- **Variables locales:** definidas dentro de una función; no son accesibles fuera de ella.
- **Variables globales:** definidas fuera de las funciones. Para usarlas dentro de una función hay que declararlas con la palabra clave `global`.

```php
$temp = "The date is ";
function longdate($timestamp) {
    global $temp;
    return $temp . date("l F jS Y", $timestamp);
}
echo longdate(time());
```

::: tip-box Compruébalo
Prueba este ejemplo con y sin la línea `global $temp;`. ¿Cuál es el resultado en cada caso? ¿Por qué?
:::

::: info-box Más información
Manual de PHP: [ámbito de las variables](https://www.php.net/manual/es/language.variables.scope.php).
:::

### Variables estáticas

Las variables estáticas mantienen su valor entre llamadas a la función.

```php
function test() {
    static $count = 0;
    echo $count;
    $count++;
}
```

Este ejemplo es un contador de accesos a la función. Sin `static`, el incremento de `$count` se perdería al terminar cada llamada, porque sería una variable local más.

::: tip-box Compruébalo
Llama varias veces a `test()` y observa la salida. Después quita la palabra `static` y repite la prueba. ¿Qué ocurre con la cuenta?
:::

## Variables superglobales

Son variables predefinidas en PHP que están disponibles en cualquier parte del script. Algunas de ellas: `$_GET`, `$_POST`, `$_COOKIE`, `$_SESSION`, `$_SERVER`.

**Uso de superglobales:**

```php
$came_from = $_SERVER['HTTP_REFERER'];
```

**Desinfección de datos:** el contenido de las superglobales llega del exterior, así que conviene tratarlo antes de mostrarlo.

```php
$came_from = htmlentities($_SERVER['HTTP_REFERER']);
```

### La función `htmlentities`

La función `htmlentities()` convierte los caracteres especiales en su representación HTML correspondiente. Es útil sobre todo para prevenir problemas de seguridad, como los ataques de inyección de código (*cross-site scripting*, XSS), y para asegurar que el contenido se muestre correctamente en el navegador.

```php
$user_input = '<script>alert("XSS Attack");</script>';
$safe_output = htmlentities($user_input, ENT_QUOTES, 'UTF-8');
echo $safe_output;
```

Esto imprimirá:

```html
&lt;script&gt;alert(&quot;XSS Attack&quot;);&lt;/script&gt;
```

El navegador muestra el texto tal cual, sin ejecutar el *script*. Lo mismo ocurre con las comillas y con los caracteres acentuados:

```php
$text = "He said, \"Hello, World!\"";
echo htmlentities($text, ENT_QUOTES, 'UTF-8');
// He said, &quot;Hello, World!&quot;

$text = "Café";
echo htmlentities($text, ENT_QUOTES, 'UTF-8');
// Caf&eacute;
```

---

**Siguiente tema:** [Expresiones y control de flujo →](./2-control-flujo)
