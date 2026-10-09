---
layout: doc
title: Formularios
sidebar: true
outline: [2, 3]
aside: true
---

# 📝 Tema 5 — Formularios

<ExportPDF />

::: info-box Diapositivas del tema
Este tema tiene presentación de clase: [ver las diapositivas](../diapositivas/5-formularios).
:::

## ¿Qué son los formularios HTML?

Los formularios HTML son una herramienta fundamental para permitir que los usuarios envíen datos a un servidor web. Son esenciales en las aplicaciones web para interactuar con los usuarios: encuestas, registros, inicio de sesión y más.

```html
<form action="submit_form.php" method="POST">
  <input type="text" name="username" placeholder="Nombre de usuario">
  <input type="submit" value="Enviar">
</form>
```

Los formularios permiten capturar datos del usuario mediante diversos tipos de campos de entrada, como `<input>`, `<select>` o `<textarea>`. Los datos capturados pueden enviarse al servidor mediante los métodos GET o POST.

## Estructura de un formulario HTML

Un formulario HTML básico se estructura con la etiqueta `<form>`, que contiene los distintos campos de entrada que el usuario puede completar.

```html
<form action="process.php" method="POST">
  <label for="name">Nombre:</label>
  <input type="text" id="name" name="name" placeholder="Tu nombre">

  <label for="email">Correo electrónico:</label>
  <input type="email" id="email" name="email" placeholder="Tu correo electrónico">

  <input type="submit" value="Enviar">
</form>
```

La etiqueta `<form>` contiene todos los elementos que forman el formulario. Los campos `<input>` permiten la entrada de datos, y cada uno tiene atributos como `name`, que es crucial para identificar y acceder a los datos después de enviarlos.

### Atributos esenciales: `action`, `method`, `name`

Varios atributos clave determinan el comportamiento del formulario:

- `action`: define la URL a la que se enviarán los datos del formulario.
- `method`: define el método HTTP que se utilizará para enviar los datos (`GET` o `POST`).
- `name`: asocia un nombre a cada campo del formulario, lo cual es necesario para acceder a esos valores en el servidor.

```html
<form action="submit_form.php" method="POST">
  <input type="text" name="username" placeholder="Nombre de usuario">
  <input type="password" name="password" placeholder="Contraseña">
  <input type="submit" value="Enviar">
</form>
```

## Métodos GET y POST

Existen dos métodos principales para enviar datos a través de formularios HTML. Cada uno tiene características que lo hacen adecuado para situaciones diferentes.

| | GET | POST |
|:--|:----|:-----|
| **Dónde viajan los datos** | En la URL. | En el cuerpo de la petición HTTP. |
| **Visibilidad** | Visibles en la barra de direcciones. | No aparecen en la URL. |
| **Cantidad de datos** | Limitada. | Adecuado para grandes cantidades de información. |
| **Uso habitual** | Búsquedas, filtros, enlaces que se pueden compartir. | Altas, modificaciones, inicio de sesión, subida de archivos. |

```html
<form action="process_get.php" method="GET">
  <input type="text" name="username" placeholder="Nombre de usuario">
  <input type="submit" value="Enviar">
</form>

<form action="process_post.php" method="POST">
  <input type="text" name="username" placeholder="Nombre de usuario">
  <input type="submit" value="Enviar">
</form>
```

Ejemplo de URL generada por el método GET: `process_get.php?username=Juan`.

::: warning-box POST no cifra los datos
Con POST los datos no se ven en la URL, pero viajan igualmente en claro si la conexión no es HTTPS. Las contraseñas se envían siempre por POST y sobre HTTPS.
:::

## Acceder a los datos enviados: `$_GET` y `$_POST`

En PHP, los datos enviados mediante formularios están disponibles en las variables superglobales `$_GET` y `$_POST`, según el método utilizado.

- `$_GET['username']` accede a un dato enviado por el método GET.
- `$_POST['password']` accede a un dato enviado por el método POST.

```php
<?php
// Acceso a los datos enviados por GET
$username = $_GET['username'];
echo "El nombre de usuario es: " . $username;

// Acceso a los datos enviados por POST
$password = $_POST['password'];
echo "La contraseña es: " . $password;
?>
```

::: danger-box No muestres datos del usuario sin escapar
Este ejemplo enseña el mecanismo, pero imprime lo recibido tal cual. Cualquier dato que venga del usuario debe pasar por `htmlspecialchars()` antes de mostrarse en una página, para evitar inyección de código (XSS).
:::

## Validación en el lado del servidor

La validación en el servidor es esencial para asegurar la integridad y la seguridad de los datos que envían los usuarios. La validación en el lado del cliente puede mejorar la experiencia del usuario, pero **solo la validación en el servidor garantiza** que los datos sean correctos y seguros antes de ser procesados o almacenados.

```php
if (empty($email)) {
    echo "El campo de correo electrónico es obligatorio.";
} elseif (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
    echo "El correo electrónico no tiene un formato válido.";
}
```

### Validación básica

La validación básica consiste en asegurarse de que los campos obligatorios estén completos y de que los datos tengan el formato esperado. Un ejemplo común es verificar que un campo de correo electrónico contenga una dirección válida o que un número de teléfono tenga la cantidad correcta de dígitos.

```php
if (empty($name)) {
    echo "El campo 'nombre' es obligatorio.";
}

if (!is_numeric($age)) {
    echo "El campo 'edad' debe ser un número.";
}
```

### Funciones comunes de validación

PHP ofrece varias funciones útiles para validar y sanear datos. Permiten comprobar si los datos están presentes, son válidos y siguen el formato adecuado.

| Función | Qué hace |
|:--------|:---------|
| `isset()` | Verifica si una variable está definida. |
| `empty()` | Verifica si una variable está vacía. |
| `filter_var()` | Valida y sanea datos, por ejemplo un correo electrónico. |
| `preg_match()` | Compara un dato con una expresión regular. |

```php
$email = "example@example.com";
if (filter_var($email, FILTER_VALIDATE_EMAIL)) {
    echo "El correo electrónico es válido.";
} else {
    echo "El correo electrónico no es válido.";
}
```

::: tip-box isset frente a empty
`isset` comprueba si una variable **existe**: si el campo ha llegado en la URL (GET) o en el cuerpo de la petición (POST). `empty` comprueba si, habiendo llegado, **está vacía**; considera vacíos `NULL`, `0`, `""`, `"0"`, `false` y un array sin elementos.
:::

### Funciones para comprobar y convertir tipos

Los datos de un formulario llegan siempre como cadenas. Estas funciones permiten comprobar qué contienen y convertirlos al tipo que se necesita.

**Comprobación de tipos**

| Función | Descripción | Ejemplo |
|:--------|:------------|:--------|
| `is_numeric($var)` | Verifica si una variable es numérica (número o cadena numérica). | `$var = "123"; var_dump(is_numeric($var)); // true` |
| `is_int($var)` | Comprueba si una variable es de tipo entero. | `$var = 10; var_dump(is_int($var)); // true` |
| `is_float($var)` | Verifica si una variable es un número de coma flotante (decimal). | `$var = 3.14; var_dump(is_float($var)); // true` |
| `is_null($var)` | Determina si una variable es `null`. | `$var = null; var_dump(is_null($var)); // true` |
| `is_string($var)` | Comprueba si una variable es una cadena de texto. | `$var = "Hola"; var_dump(is_string($var)); // true` |

**Conversión de tipos**

| Función | Descripción | Ejemplo |
|:--------|:------------|:--------|
| `gettype($var)` | Devuelve el tipo de datos de una variable. | `$var = true; echo gettype($var); // boolean` |
| `settype($var, $type)` | Cambia el tipo de datos de una variable al tipo especificado (`integer`, `string`, etc.). | `$var = "123"; settype($var, "integer"); echo $var; // 123` |
| `intval($var)` | Convierte una variable a entero. | `$var = "45.7"; echo intval($var); // 45` |
| `floatval($var)` | Convierte una variable a número de coma flotante. | `$var = "3.14"; echo floatval($var); // 3.14` |
| `strval($var)` | Convierte una variable a cadena de texto. | `$var = 100; echo strval($var); // "100"` |

## Ejemplo completo 1: formulario y procesado en archivos separados

El formulario está en un archivo HTML y envía los datos a un script PHP que los recoge y los muestra. Reúne los tipos de campo más habituales de HTML5.

::: tabs

== Formulario1.html

```html
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Formulario HTML5</title>
</head>
<body>

<h2>Formulario de Ejemplo</h2>

<form action="Procesado1.php" method="GET">

    <!-- Campo de texto -->
    <label for="nombre">Nombre:</label>
    <input type="text" id="nombre" name="nombre" required>
    <br><br>

    <!-- Campo de correo electrónico -->
    <label for="email">Correo electrónico:</label>
    <input type="email" id="email" name="email" required>
    <br><br>

    <!-- Campo de número -->
    <label for="edad">Edad:</label>
    <input type="number" id="edad" name="edad" min="18" max="100" required>
    <br><br>

    <!-- Campo de teléfono -->
    <label for="telefono">Teléfono:</label>
    <input type="tel" id="telefono" name="telefono" pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}" required>
    <br><br>

    <!-- Campo de contraseña -->
    <label for="password">Contraseña:</label>
    <input type="password" id="password" name="password" required>
    <br><br>

    <!-- Área de texto -->
    <label for="mensaje">Mensaje:</label>
    <textarea id="mensaje" name="mensaje" rows="4" cols="50" required></textarea>
    <br><br>

    <!-- Campo de selección múltiple -->
    <label for="colores">Colores favoritos:</label>
    <select id="colores" name="colores[]" multiple required>
        <option value="rojo">Rojo</option>
        <option value="verde">Verde</option>
        <option value="azul">Azul</option>
        <option value="amarillo">Amarillo</option>
    </select>
    <br><br>

    <!-- Casillas de verificación -->
    <label for="suscripcion">Suscripción al boletín:</label>
    <input type="checkbox" id="suscripcion" name="suscripcion" value="1">
    <br><br>

    <!-- Botón de radio -->
    <label for="sexo">Sexo:</label>
    <input type="radio" id="masculino" name="sexo" value="masculino" required> Masculino
    <input type="radio" id="femenino" name="sexo" value="femenino" required> Femenino
    <br><br>

    <!-- Fecha -->
    <label for="fecha">Fecha de nacimiento:</label>
    <input type="date" id="fecha" name="fecha" required>
    <br><br>

    <!-- Hora -->
    <label for="hora">Hora:</label>
    <input type="time" id="hora" name="hora">
    <br><br>

    <!-- Campo para archivo -->
    <label for="archivo">Subir archivo:</label>
    <input type="file" id="archivo" name="archivo">
    <br><br>

    <!-- Enviar formulario -->
    <button type="submit">Enviar</button>
</form>

</body>
</html>
```

== Procesado1.php

```php
<?php
if ($_SERVER["REQUEST_METHOD"] == "GET") {
    // Recoger los valores del formulario
    $nombre = $_GET['nombre'] ?? '';
    $email = $_GET['email'] ?? '';
    $edad = $_GET['edad'] ?? '';
    $telefono = $_GET['telefono'] ?? '';
    $password = $_GET['password'] ?? '';
    $mensaje = $_GET['mensaje'] ?? '';
    $colores = $_GET['colores'] ?? [];
    $suscripcion = isset($_GET['suscripcion']) ? 'Sí' : 'No';
    $sexo = $_GET['sexo'] ?? '';
    $fecha = $_GET['fecha'] ?? '';
    $hora = $_GET['hora'] ?? '';

    // Mostrar los valores recogidos
    echo "<h2>Datos del formulario:</h2>";
    echo "Nombre: $nombre<br>";
    echo "Correo: $email<br>";
    echo "Edad: $edad<br>";
    echo "Teléfono: $telefono<br>";
    echo "Contraseña: $password<br>";
    echo "Mensaje: $mensaje<br>";
    echo "Colores favoritos: " . implode(", ", $colores) . "<br>";
    echo "Suscripción al boletín: $suscripcion<br>";
    echo "Sexo: $sexo<br>";
    echo "Fecha de nacimiento: $fecha<br>";
    echo "Hora: $hora<br>";
}
?>
```

:::

Fíjate en estos detalles:

- El operador `??` devuelve el valor de la izquierda si existe y, si no, el de la derecha. Evita el aviso que se produce al leer un campo que no ha llegado.
- El `select` múltiple se llama `colores[]`: los corchetes hacen que PHP reciba un array con todas las opciones marcadas.
- Una casilla de verificación sin marcar no se envía; por eso se comprueba con `isset`.

::: warning-box Es un ejemplo para ver los datos, no un modelo de formulario
El formulario usa GET para que puedas ver en la URL cómo viaja cada campo, incluida la contraseña. En una aplicación real, un formulario con contraseña se envía por POST. Además, el campo de archivo no se sube con este formulario: para eso hacen falta POST y `enctype="multipart/form-data"`, como se ve [más abajo](#subida-de-archivos).
:::

## Ejemplo completo 2: formulario y validación en el mismo archivo

Aquí el formulario se envía a sí mismo: el mismo script muestra el formulario, valida los datos al recibirlos y vuelve a pintarlo con los errores y con los valores ya introducidos.

```php
<!DOCTYPE HTML>
<html>
<head>
<style>
.error {color: #FF0000;}
</style>
</head>
<body>

<?php
// define variables and set to empty values
$nameErr = $emailErr = $genderErr = $websiteErr = "";
$name = $email = $gender = $comment = $website = "";

if ($_SERVER["REQUEST_METHOD"] == "POST") {
  if (empty($_POST["name"])) {
    $nameErr = "Name is required";
  } else {
    $name = test_input($_POST["name"]);
    // check if name only contains letters and whitespace
    if (!preg_match("/^[a-zA-Z-' ]*$/",$name)) {
      $nameErr = "Only letters and white space allowed";
    }
  }

  if (empty($_POST["email"])) {
    $emailErr = "Email is required";
  } else {
    $email = test_input($_POST["email"]);
    // check if e-mail address is well-formed
    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
      $emailErr = "Invalid email format";
    }
  }

  if (empty($_POST["website"])) {
    $website = "";
  } else {
    $website = test_input($_POST["website"]);
    // check if URL address syntax is valid (this regular expression also allows dashes in the URL)
    if (!preg_match("/\b(?:(?:https?|ftp):\/\/|www\.)[-a-z0-9+&@#\/%?=~_|!:,.;]*[-a-z0-9+&@#\/%=~_|]/i",$website)) {
      $websiteErr = "Invalid URL";
    }
  }

  if (empty($_POST["comment"])) {
    $comment = "";
  } else {
    $comment = test_input($_POST["comment"]);
  }

  if (empty($_POST["gender"])) {
    $genderErr = "Gender is required";
  } else {
    $gender = test_input($_POST["gender"]);
  }
}

function test_input($data) {
  $data = trim($data);
  $data = stripslashes($data);
  $data = htmlspecialchars($data);
  return $data;
}
?>

<h2>PHP Form Validation Example</h2>
<p><span class="error">* required field</span></p>
<form method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]);?>">
  Name: <input type="text" name="name" value="<?php echo $name;?>">
  <span class="error">* <?php echo $nameErr;?></span>
  <br><br>
  E-mail: <input type="text" name="email" value="<?php echo $email;?>">
  <span class="error">* <?php echo $emailErr;?></span>
  <br><br>
  Website: <input type="text" name="website" value="<?php echo $website;?>">
  <span class="error"><?php echo $websiteErr;?></span>
  <br><br>
  Comment: <textarea name="comment" rows="5" cols="40"><?php echo $comment;?></textarea>
  <br><br>
  Gender:
  <input type="radio" name="gender" <?php if (isset($gender) && $gender=="female") echo "checked";?> value="female">Female
  <input type="radio" name="gender" <?php if (isset($gender) && $gender=="male") echo "checked";?> value="male">Male
  <input type="radio" name="gender" <?php if (isset($gender) && $gender=="other") echo "checked";?> value="other">Other
  <span class="error">* <?php echo $genderErr;?></span>
  <br><br>
  <input type="submit" name="submit" value="Submit">
</form>

<?php
echo "<h2>Your Input:</h2>";
echo $name;
echo "<br>";
echo $email;
echo "<br>";
echo $website;
echo "<br>";
echo $comment;
echo "<br>";
echo $gender;
?>

</body>
</html>
```

Qué hace cada parte:

| Fragmento | Función |
|:----------|:--------|
| `$_SERVER["REQUEST_METHOD"] == "POST"` | Distingue la primera visita (GET) del envío del formulario (POST). |
| `test_input()` | Limpia cada dato: quita espacios sobrantes, barras de escape y convierte los caracteres especiales de HTML. |
| `preg_match()` y `filter_var()` | Validan el formato del nombre, de la URL y del correo. |
| `htmlspecialchars($_SERVER["PHP_SELF"])` | Envía el formulario al propio script, escapando la URL para que no se pueda inyectar código en ella. |
| `value="<?php echo $name;?>"` | Conserva lo que el usuario ya había escrito cuando hay errores. |

## Subida de archivos

Para subir archivos a un servidor web, el formulario debe enviarse por POST y con el tipo de codificación `multipart/form-data`.

```php
echo <<<_END
<html><head><title>PHP Form Upload</title></head><body>
<form method='post' action='upload.php' enctype='multipart/form-data'>
Select File: <input type='file' name='filename' size='10'>
<input type='submit' value='Upload'>
</form>
_END;

if ($_FILES) {
    $name = $_FILES['filename']['name'];
    move_uploaded_file($_FILES['filename']['tmp_name'], $name);
    echo "Uploaded image '$name'<br><img src='$name'>";
}
echo "</body></html>";
```

Tras subir una imagen, la página muestra `Uploaded image 'nombre_del_archivo.jpg'` y la propia imagen.

::: danger-box Este primer ejemplo no valida nada
Guarda el archivo con el nombre que envía el usuario y en la misma carpeta que el script. Sirve para entender el mecanismo, pero no debe usarse así: hay que validar el archivo, como en los ejemplos siguientes.
:::

### Uso de `$_FILES`

Al subir un archivo, PHP guarda cinco datos sobre él en el array `$_FILES`, dentro de la clave que coincide con el `name` del campo. Si el campo se llama `file`:

| Elemento | Contenido |
|:---------|:----------|
| `$_FILES['file']['name']` | Nombre del archivo subido (p. ej. `smiley.jpg`). |
| `$_FILES['file']['type']` | Tipo de contenido del archivo (p. ej. `image/jpeg`). |
| `$_FILES['file']['size']` | Tamaño del archivo en bytes. |
| `$_FILES['file']['tmp_name']` | Nombre del archivo temporal almacenado en el servidor. |
| `$_FILES['file']['error']` | Código de error resultante de la subida del archivo. |

### Validación de archivos subidos

La validación de los datos de los formularios es crucial para proteger el servidor de entradas maliciosas. En este ejemplo solo se aceptan imágenes, y el archivo se guarda con un nombre que decide el servidor.

```php
if ($_FILES) {
    $name = $_FILES['filename']['name'];
    switch ($_FILES['filename']['type']) {
        case 'image/jpeg': $ext = 'jpg'; break;
        case 'image/gif':  $ext = 'gif'; break;
        case 'image/png':  $ext = 'png'; break;
        case 'image/tiff': $ext = 'tif'; break;
        default:           $ext = '';    break;
    }
    if ($ext) {
        $n = "image.$ext";
        move_uploaded_file($_FILES['filename']['tmp_name'], $n);
        echo "Uploaded image '$name' as '$n':<br>";
        echo "<img src='$n'>";
    } else echo "'$name' is not an accepted image file";
}
```

- Resultado después de subir un archivo válido: `Uploaded image 'nombre_del_archivo.jpg' as 'image.jpg':`
- Resultado si el archivo no es aceptado: `'nombre_del_archivo.txt' is not an accepted image file`

### Ejemplo completo 3: subida con control de tipo y tamaño

::: tabs

== formulario.html

```html
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Formulario de Subida de Archivos</title>
</head>
<body>
    <h2>Formulario para subir un archivo</h2>
    <form action="subir_archivo.php" method="POST" enctype="multipart/form-data">
        <label for="archivo">Selecciona un archivo:</label>
        <input type="file" name="archivo" id="archivo" required>
        <br><br>
        <input type="submit" value="Subir Archivo">
    </form>
</body>
</html>
```

== subir_archivo.php

```php
<?php
// Verificar si el formulario fue enviado y si no hubo errores en el envío del archivo
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_FILES['archivo'])) {
    // Variables para el archivo
    $archivo = $_FILES['archivo'];

    // Comprobar si hubo errores al subir el archivo
    if ($archivo['error'] == UPLOAD_ERR_OK) {
        // Obtener el nombre y el tipo del archivo
        $nombreArchivo = $archivo['name'];
        $tipoArchivo = $archivo['type'];
        $tmpArchivo = $archivo['tmp_name']; // El archivo temporal en el servidor
        $tamañoArchivo = $archivo['size'];

        // Directorio donde se almacenará el archivo subido
        $directorioDestino = 'uploads/';

        // Asegurarse de que el directorio existe
        if (!is_dir($directorioDestino)) {
            mkdir($directorioDestino, 0777, true); // Crear el directorio si no existe
        }

        // Definir una ruta completa para guardar el archivo
        $rutaDestino = $directorioDestino . basename($nombreArchivo);

        // Verificar el tipo de archivo (por ejemplo, solo imágenes JPG y PNG)
        $tiposPermitidos = ['image/jpeg', 'image/png', 'application/pdf']; // Ejemplo con imágenes y PDFs
        if (in_array($tipoArchivo, $tiposPermitidos)) {
            // Verificar el tamaño máximo (por ejemplo, 2MB)
            $maxTamaño = 2 * 1024 * 1024; // 2MB en bytes
            if ($tamañoArchivo <= $maxTamaño) {
                // Mover el archivo desde el temporal al directorio de destino
                if (move_uploaded_file($tmpArchivo, $rutaDestino)) {
                    echo "El archivo se ha subido correctamente: " . $nombreArchivo;
                } else {
                    echo "Hubo un error al mover el archivo.";
                }
            } else {
                echo "El archivo es demasiado grande. El tamaño máximo permitido es 2MB.";
            }
        } else {
            echo "Tipo de archivo no permitido. Solo se aceptan imágenes JPG, PNG y archivos PDF.";
        }
    } else {
        // Mostrar el error si hubo problemas con la subida
        echo "Error al subir el archivo. Código de error: " . $archivo['error'];
    }
} else {
    echo "No se ha recibido ningún archivo.";
}
?>
```

:::

El script comprueba, en este orden: que ha llegado un archivo, que la subida no dio error, que el tipo está permitido y que el tamaño no supera el máximo. Solo entonces mueve el archivo a la carpeta `uploads/`.

::: warning-box El tipo lo declara el navegador
`$_FILES[...]['type']` es el tipo que **dice** el navegador y se puede falsear. En una aplicación real hay que comprobar el contenido del archivo en el servidor (por ejemplo, con `mime_content_type()`) y guardar los archivos en una carpeta desde la que no se pueda ejecutar código.
:::

---

**Siguiente tema:** [Cookies, sesiones y autenticación →](./6-cookies-sesiones)
