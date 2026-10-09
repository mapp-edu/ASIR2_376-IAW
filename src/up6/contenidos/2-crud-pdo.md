---
layout: doc
title: Crear, consultar, modificar y borrar datos
sidebar: true
outline: [2, 3]
aside: true
---

# 🗃️ Tema 2 — Crear, consultar, modificar y borrar datos

<ExportPDF />

El [tema anterior](./1-acceso-datos-pdo) mostró cómo conectarse a MySQL con PDO y leer una tabla. Este tema completa las cuatro operaciones básicas sobre los datos, conocidas como **CRUD**: *Create* (insertar), *Read* (consultar), *Update* (modificar) y *Delete* (borrar). También se ve cómo crear las tablas desde PHP, cómo trabajar con tablas relacionadas y cómo organizar el código de conexión.

| Operación | SQL | Método de PDO habitual | Qué devuelve |
|:----------|:----|:-----------------------|:-------------|
| Crear | `INSERT` | `prepare()` + `execute()` | `lastInsertId()`: el identificador generado. |
| Consultar | `SELECT` | `query()` o `prepare()` + `execute()` | Las filas, con `fetch()` o `fetchAll()`. |
| Modificar | `UPDATE` | `prepare()` + `execute()` | `rowCount()`: filas afectadas. |
| Borrar | `DELETE` | `prepare()` + `execute()` | `rowCount()`: filas afectadas. |

## Un archivo de conexión para toda la aplicación

En lugar de repetir los datos de conexión en cada página, se escriben una sola vez en un archivo que las demás incluyen.

`conexion.php`:

```php
<?php
// Datos de conexión: en una aplicación real, fuera de la carpeta pública
// o en variables de entorno, nunca en un repositorio público
const DB_HOST = 'localhost';
const DB_NAME = 'tienda';
const DB_USER = 'tienda_user';
const DB_PASS = 'una-contraseña-segura';

function conectar(): PDO {
    $dsn = 'mysql:host=' . DB_HOST . ';dbname=' . DB_NAME . ';charset=utf8mb4';
    return new PDO($dsn, DB_USER, DB_PASS, [
        PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        PDO::ATTR_EMULATE_PREPARES   => false,
    ]);
}
```

Cualquier página la usa así:

```php
<?php
require_once __DIR__ . '/conexion.php';
$pdo = conectar();
```

## Crear la base de datos y las tablas desde PHP

PHP puede ejecutar cualquier instrucción SQL, también las que definen la estructura. `exec()` ejecuta una instrucción que no devuelve filas.

```php
<?php
require_once __DIR__ . '/conexion.php';

try {
    $pdo = conectar();

    $pdo->exec("CREATE TABLE IF NOT EXISTS clientes (
        id     INT AUTO_INCREMENT PRIMARY KEY,
        nombre VARCHAR(100) NOT NULL,
        email  VARCHAR(150) NOT NULL UNIQUE
    ) ENGINE=InnoDB");

    $pdo->exec("CREATE TABLE IF NOT EXISTS pedidos (
        id         INT AUTO_INCREMENT PRIMARY KEY,
        producto   VARCHAR(100) NOT NULL,
        precio     DECIMAL(8,2) NOT NULL,
        id_cliente INT NOT NULL,
        FOREIGN KEY (id_cliente) REFERENCES clientes(id) ON DELETE CASCADE
    ) ENGINE=InnoDB");

    echo "Las tablas se han creado correctamente.";
} catch (PDOException $e) {
    echo "No se han podido crear las tablas.";
    error_log($e->getMessage());
}
```

- `IF NOT EXISTS` permite ejecutar el *script* varias veces sin error.
- La **clave ajena** `id_cliente` garantiza que cada pedido pertenece a un cliente que existe. Con `ON DELETE CASCADE`, al borrar un cliente se borran sus pedidos.
- `ENGINE=InnoDB` es el motor que admite claves ajenas y transacciones. Es el predeterminado en MySQL y MariaDB actuales.

Si el usuario de la aplicación tiene permiso para ello, también se puede crear la base de datos: `$pdo->exec("CREATE DATABASE IF NOT EXISTS tienda")`. En ese caso el DSN de la conexión no debe incluir `dbname`.

## Insertar datos

Los datos que llegan de un formulario se insertan **siempre** con una sentencia preparada. Los marcadores pueden ser posicionales (`?`) o con nombre (`:nombre`):

```php
<?php
require_once __DIR__ . '/conexion.php';
$pdo = conectar();

$nombre = trim($_POST['nombre'] ?? '');
$email  = trim($_POST['email'] ?? '');

if ($nombre === '' || !filter_var($email, FILTER_VALIDATE_EMAIL)) {
    exit('Datos no válidos');
}

$stmt = $pdo->prepare('INSERT INTO clientes (nombre, email) VALUES (:nombre, :email)');
$stmt->execute([':nombre' => $nombre, ':email' => $email]);

echo 'Cliente creado con el identificador ' . $pdo->lastInsertId();
```

### Errores de integridad

Si se intenta insertar un correo que ya existe (la columna es `UNIQUE`) o un pedido de un cliente que no existe (clave ajena), MySQL rechaza la operación y PDO lanza una excepción. El código de error SQLSTATE `23000` indica una violación de integridad:

```php
try {
    $stmt->execute([':nombre' => $nombre, ':email' => $email]);
} catch (PDOException $e) {
    if ($e->getCode() === '23000') {
        echo 'Ya existe un cliente con ese correo.';
    } else {
        throw $e;   // otro error: que lo trate el nivel superior
    }
}
```

## Consultar datos

### Todas las filas

```php
$clientes = $pdo->query('SELECT id, nombre, email FROM clientes ORDER BY nombre')->fetchAll();

foreach ($clientes as $c) {
    echo htmlspecialchars($c['nombre']) . ' — ' . htmlspecialchars($c['email']) . '<br>';
}
```

### Una fila concreta

```php
$stmt = $pdo->prepare('SELECT * FROM clientes WHERE id = ?');
$stmt->execute([$_GET['id'] ?? 0]);
$cliente = $stmt->fetch();      // false si no existe

if (!$cliente) {
    http_response_code(404);
    exit('Cliente no encontrado');
}
```

### Tablas relacionadas

Con `JOIN` se combinan los datos de varias tablas, y con `GROUP BY` se agrupan para calcular totales:

```php
// Pedidos de más de 200 € con el nombre del cliente
$sql = 'SELECT c.nombre, p.producto, p.precio
          FROM pedidos p
          JOIN clientes c ON c.id = p.id_cliente
         WHERE p.precio > :minimo
         ORDER BY p.precio DESC';
$stmt = $pdo->prepare($sql);
$stmt->execute([':minimo' => 200]);
$pedidos = $stmt->fetchAll();

// Número de pedidos y gasto de cada cliente, también de los que no tienen pedidos
$resumen = $pdo->query(
    'SELECT c.nombre, COUNT(p.id) AS num_pedidos, COALESCE(SUM(p.precio), 0) AS total
       FROM clientes c
       LEFT JOIN pedidos p ON p.id_cliente = c.id
      GROUP BY c.id, c.nombre
      ORDER BY total DESC'
)->fetchAll();
```

### Mostrar los resultados en una tabla HTML

```php
<table>
    <thead>
        <tr><th>Cliente</th><th>Pedidos</th><th>Total</th></tr>
    </thead>
    <tbody>
    <?php foreach ($resumen as $fila): ?>
        <tr>
            <td><?= htmlspecialchars($fila['nombre']) ?></td>
            <td><?= $fila['num_pedidos'] ?></td>
            <td><?= number_format($fila['total'], 2, ',', '.') ?> €</td>
        </tr>
    <?php endforeach; ?>
    </tbody>
</table>
```

`<?= … ?>` es la forma abreviada de `<?php echo … ?>`. La sintaxis `foreach (…): … endforeach;` hace más legible el código PHP mezclado con HTML.

## Modificar datos

```php
$stmt = $pdo->prepare('UPDATE clientes SET email = :email WHERE id = :id');
$stmt->execute([':email' => $nuevoEmail, ':id' => $id]);

if ($stmt->rowCount() === 0) {
    echo 'No se ha modificado ningún cliente (no existe o el correo era el mismo).';
}
```

## Borrar datos

```php
$stmt = $pdo->prepare('DELETE FROM clientes WHERE id = ?');
$stmt->execute([$id]);
echo $stmt->rowCount() . ' cliente borrado.';
```

::: danger-box Cuidado con UPDATE y DELETE sin WHERE
`DELETE FROM clientes` sin `WHERE` borra **todos** los clientes. Comprueba siempre la condición antes de ejecutar y, en la aplicación, pide confirmación antes de borrar.
:::

::: warning-box Borrar y modificar se hace con POST
Un enlace como `borrar.php?id=5` ejecuta el borrado con solo visitarlo, y los navegadores y buscadores pueden visitar enlaces por su cuenta. Las operaciones que cambian datos se envían con un formulario por POST.
:::

## Transacciones

Una **transacción** agrupa varias operaciones para que se hagan todas o ninguna. Es imprescindible cuando las operaciones dependen unas de otras, por ejemplo al crear un cliente y su primer pedido:

```php
try {
    $pdo->beginTransaction();

    $pdo->prepare('INSERT INTO clientes (nombre, email) VALUES (?, ?)')
        ->execute([$nombre, $email]);
    $idCliente = $pdo->lastInsertId();

    $pdo->prepare('INSERT INTO pedidos (producto, precio, id_cliente) VALUES (?, ?, ?)')
        ->execute([$producto, $precio, $idCliente]);

    $pdo->commit();       // las dos operaciones quedan guardadas
} catch (PDOException $e) {
    $pdo->rollBack();     // ninguna queda guardada
    echo 'No se ha podido registrar el pedido.';
}
```

## PDO y mysqli

PHP ofrece dos extensiones para trabajar con MySQL. Encontrarás las dos en documentación y en aplicaciones existentes.

| | PDO | mysqli |
|:--|:----|:-------|
| **Bases de datos** | MySQL, MariaDB, PostgreSQL, SQLite, SQL Server… | Solo MySQL y MariaDB. |
| **Estilo** | Orientado a objetos. | Orientado a objetos o procedimental. |
| **Sentencias preparadas** | Sí, con marcadores `?` o `:nombre`. | Sí, con marcadores `?`. |
| **Gestión de errores** | Excepciones `PDOException`. | Excepciones `mysqli_sql_exception` (por defecto desde PHP 8.1). |

La misma consulta preparada con mysqli:

```php
$conexion = new mysqli('localhost', 'tienda_user', 'una-contraseña-segura', 'tienda');
$conexion->set_charset('utf8mb4');

$stmt = $conexion->prepare('SELECT nombre, email FROM clientes WHERE id = ?');
$stmt->bind_param('i', $id);     // 'i' = entero, 's' = texto, 'd' = decimal
$stmt->execute();
$resultado = $stmt->get_result();

while ($fila = $resultado->fetch_assoc()) {
    echo htmlspecialchars($fila['nombre']);
}

$conexion->close();
```

En este módulo se usa **PDO**, porque el mismo código sirve para otros sistemas gestores cambiando solo el DSN.

## Seguridad en el acceso a los datos

| Medida | Por qué |
|:-------|:--------|
| Sentencias preparadas para todo dato externo | Evitan la inyección de SQL. |
| `htmlspecialchars()` al mostrar datos | Evita la inyección de código en la página (XSS). |
| Un usuario de base de datos propio, con permisos mínimos | Limita el daño si la aplicación es atacada. |
| Credenciales fuera del código público | Evita que se filtren al publicar el código. |
| Contraseñas guardadas con `password_hash()` | Nunca en texto claro. Ver [autenticación de usuarios](/up5/contenidos/6-cookies-sesiones#autenticacion-de-usuarios). |
| Mensajes de error genéricos para el usuario | Los detalles van al registro, no a la pantalla. |
| Comprobar la sesión antes de cada operación | Solo quien tiene permiso puede modificar o borrar. |

## Funcionamiento y rendimiento

- **Prueba cada operación** con datos válidos, datos no válidos, datos que no existen y datos repetidos.
- **Índices.** Las columnas por las que se busca o se relacionan las tablas deben tener un índice. Las claves primarias, ajenas y `UNIQUE` lo crean automáticamente; para otras, `CREATE INDEX idx_precio ON pedidos(precio);`.
- **`EXPLAIN`** delante de un `SELECT`, en phpMyAdmin o en el cliente `mariadb`, muestra cómo va a ejecutar la consulta el servidor y si usa algún índice.
- **Pide solo lo que necesitas.** `SELECT nombre, email` en lugar de `SELECT *`, y `LIMIT` para paginar listados largos.
- **Una conexión por petición.** Abre la conexión una vez al principio de la página y reutilízala en todas las consultas.

::: note-box Fuente
Tema elaborado a partir de los contenidos del aula de IAW del CEEDCV (curso 2025-2026). Ver [Créditos y fuentes](/general/contenidos/4-creditos).
:::

---

**Siguiente paso:** [Prácticas de la unidad →](../ejercicios/)
