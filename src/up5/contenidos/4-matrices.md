---
layout: doc
title: Matrices (arrays)
sidebar: true
outline: [2, 3]
aside: true
---

# 🗃️ Tema 4 — Matrices (arrays)

<ExportPDF />

::: info-box Diapositivas del tema
Este tema tiene presentación de clase: [ver las diapositivas](../diapositivas/4-matrices).
:::

## Arrays numéricos

Un array numérico es una estructura en la que los elementos se almacenan utilizando índices numéricos.

```php
$paper[] = "Copier";
$paper[] = "Inkjet";
$paper[] = "Laser";
$paper[] = "Photo";
print_r($paper);
```

En este ejemplo, cada elemento se guarda automáticamente en la siguiente posición libre, con índices numéricos implícitos. El resultado es un array con los valores almacenados en los índices del 0 al 3.

### Índices explícitos

También es posible asignar valores a un array especificando manualmente los índices.

```php
$paper[0] = "Copier";
$paper[1] = "Inkjet";
$paper[2] = "Laser";
$paper[3] = "Photo";
print_r($paper);
```

Aunque esto puede ser útil en ciertos casos, generalmente es preferible dejar que PHP asigne los índices de manera automática: es menos código que mantener.

### Dar valores iniciales a un array

Se pueden asignar valores a un array en el momento de su declaración o más tarde. Se pueden definir índices específicos o dejar que PHP los asigne.

```php
$cars = array("Volvo", "BMW", "Toyota");
$cars = ["Volvo", "BMW", "Toyota"];

// Array con su índice
$cars = [
  0 => "Volvo",
  3 => "BMW",
  2 => "Toyota"
];
```

### Recorrer un array numérico con `for`

Se puede acceder a los valores de un array numérico utilizando un bucle `for`.

```php
for ($j = 0 ; $j < 4 ; ++$j)
    echo "$j: $paper[$j]<br>";
```

Este bucle recorre el array `$paper`, accediendo a cada elemento mediante su índice y mostrando su valor.

### Recorrer un array numérico con `foreach`

El bucle `foreach` permite recorrer arrays de manera sencilla, sin necesidad de conocer su tamaño.

```php
foreach ($paper as $item)
    echo "$item<br>";
```

Este bucle recorre automáticamente todos los elementos del array `$paper`, mostrando cada uno de ellos sin necesidad de utilizar índices.

## Arrays asociativos

Un array asociativo utiliza **claves**, en lugar de índices numéricos, para almacenar y acceder a los elementos.

```php
$paper['copier'] = "Copier & Multipurpose";
$paper['inkjet'] = "Inkjet Printer";
$paper['laser'] = "Laser Printer";
$paper['photo'] = "Photographic Paper";
echo $paper['laser'];
```

Cada elemento del array se almacena con una clave personalizada, como `'laser'`, y su valor asociado. En lugar de recordar índices numéricos, se usan estas claves para acceder a los datos.

::: note-box En otros lenguajes
En Java, esta estructura se conoce como diccionario o mapa (`Map`).
:::

### Creación de arrays con `array()`

PHP permite crear arrays de manera más compacta usando la función `array()`.

```php
$p1 = array("Copier", "Inkjet", "Laser", "Photo");
$p2 = array('copier' => "Copier & Multipurpose",
            'inkjet' => "Inkjet Printer",
            'laser'  => "Laser Printer",
            'photo'  => "Photographic Paper");
```

Aquí se crean un array numérico (`$p1`) y un array asociativo (`$p2`) en una sola instrucción cada uno, lo que ahorra tiempo y espacio en el código.

### `foreach…as` con arrays asociativos

`foreach` también sirve para recorrer arrays asociativos, y permite acceder tanto a las claves como a los valores.

```php
foreach ($paper as $item => $description)
    echo "$item: $description<br>";
```

Aquí, `$item` contiene la clave y `$description` contiene el valor asociado. El bucle recorre todos los pares clave-valor del array.

## Arrays multidimensionales

PHP permite crear arrays de más de una dimensión, lo que facilita la gestión de estructuras de datos complejas. Este tipo de arrays son comunes en aplicaciones que necesitan almacenar datos organizados en varios niveles.

```php
$products = array(
    'paper' => array(
        'copier' => "Copier & Multipurpose",
        'inkjet' => "Inkjet Printer",
        'laser'  => "Laser Printer",
        'photo'  => "Photographic Paper"
    ),
    'pens' => array(
        'ball'   => "Ball Point",
        'hilite' => "Highlighters",
        'marker' => "Markers"
    ),
    'misc' => array(
        'tape'  => "Sticky Tape",
        'glue'  => "Adhesives",
        'clips' => "Paperclips"
    )
);
```

### Acceso a los elementos

Los elementos de un array multidimensional se obtienen utilizando varios niveles de índices.

```php
echo $products['misc']['glue'];
```

Esto imprime `Adhesives`. El índice `'misc'` accede al subarray, y luego `'glue'` recupera el valor asociado.

### Recorrido

Para recorrer un array multidimensional se pueden usar bucles `foreach` anidados.

```php
foreach ($products as $section => $items) {
    foreach ($items as $key => $value) {
        echo "$section:\t$key\t($value)<br>";
    }
}
```

Este código recorre cada sección del array `$products` y, dentro de cada sección, recorre los pares clave/valor. El resultado es una impresión estructurada de cada elemento del array.

### Arrays multidimensionales numéricos

Los arrays multidimensionales no solo funcionan con claves asociativas: también pueden ser numéricos.

```php
$chessboard = array(
    array('r', 'n', 'b', 'q', 'k', 'b', 'n', 'r'),
    array('p', 'p', 'p', 'p', 'p', 'p', 'p', 'p'),
    array(' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '),
    array(' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '),
    array(' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '),
    array(' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '),
    array('P', 'P', 'P', 'P', 'P', 'P', 'P', 'P'),
    array('R', 'N', 'B', 'Q', 'K', 'B', 'N', 'R')
);
```

Este ejemplo representa un tablero de ajedrez. Los elementos del array son las ocho filas del tablero, y cada fila contiene las piezas individuales.

Se recorre de la misma manera que uno asociativo:

```php
foreach ($chessboard as $row) {
    foreach ($row as $piece) {
        echo "$piece ";
    }
    echo "<br>";
}
```

Este código recorre cada fila del tablero y luego cada pieza dentro de la fila, imprimiendo el tablero en un formato legible.

También se puede acceder directamente a un elemento usando sus índices numéricos:

```php
echo $chessboard[7][3];
```

Este código accede al cuarto elemento de la octava fila del tablero, que es la reina blanca (`Q`).

## Modificar un array

### Añadir elementos

Se pueden agregar nuevos elementos a arrays indexados y asociativos con la función `array_push` o con el operador `+=`.

```php
// Añadir varios elementos a un array
$fruits = array("Apple", "Banana", "Cherry");
array_push($fruits, "Orange", "Kiwi", "Lemon");

// Añadir items en array asociativo
$cars = array("brand" => "Ford", "model" => "Mustang");
$cars += ["color" => "red", "year" => 1964];
```

`array_push` añade elementos al final de un array indexado. Para arrays asociativos, se puede usar el operador `+=` para agregar nuevas claves y valores.

### Borrar elementos

PHP tiene varias formas de eliminar elementos de un array, usando `unset` o `array_splice` según la necesidad.

```php
// Borrar un elemento del array
$cars = array("Volvo", "BMW", "Toyota");
unset($cars[1]);

// Borrar múltiples elementos del array
$cars = array("Volvo", "BMW", "Toyota");
array_splice($cars, 1, 2);

// Borrar item en array asociativo
$cars = array("brand" => "Ford", "model" => "Mustang", "year" => 1964);
unset($cars["model"]);
```

`unset` se utiliza para eliminar un elemento específico de un array, mientras que `array_splice` permite quitar varios elementos consecutivos. En arrays asociativos se usa `unset` con la clave correspondiente.

::: warning-box unset no reordena los índices
Tras `unset($cars[1])` el array conserva los índices 0 y 2: queda un hueco. `array_splice`, en cambio, renumera los elementos que quedan.
:::

## Funciones de arrays

### Funciones básicas

| Función | Utilidad | Ejemplo |
|:--------|:---------|:--------|
| `is_array($var)` | Verifica si una variable es un array. | `echo is_array($var) ? "Es un array" : "No es un array";` |
| `count($array)` | Cuenta los elementos del array. | `echo count($array);` |
| `sort($array)` | Ordena un array de menor a mayor. | `sort($array);` |
| `shuffle($array)` | Baraja aleatoriamente los elementos de un array. | `shuffle($array);` |

### Conversión entre cadenas y arrays

| Función | Utilidad | Ejemplo |
|:--------|:---------|:--------|
| `explode($delimiter, $string)` | Divide una cadena en un array usando un delimitador. | `$array = explode(" ", "Palabras separadas");` |
| `implode($glue, $array)` | Une los elementos de un array en una cadena. | `$string = implode(", ", $array);` |

### Funciones especiales

| Función | Utilidad | Ejemplo |
|:--------|:---------|:--------|
| `compact('var1', 'var2', ...)` | Crea un array a partir de los nombres de variables y sus valores. | `$array = compact('var1', 'var2');` |
| `array_merge($array1, $array2)` | Combina dos o más arrays en uno. | `$merged = array_merge($array1, $array2);` |
| `array_unique($array)` | Elimina los valores duplicados de un array. | `$unique = array_unique($array);` |

::: info-box Y muchas más funciones
El manual de PHP recoge todas las [funciones de arrays](https://www.php.net/manual/es/ref.array.php): `array_chunk`, `array_column`, `array_combine`, `array_count_values`, `array_diff`…
:::

---

**Siguiente tema:** [Formularios →](./5-formularios)
