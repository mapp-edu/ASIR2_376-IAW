<?php
// prueba-bd.php — Comprueba que PHP se conecta a MariaDB con PDO.
// Script de prueba: bórralo en cuanto lo hayas comprobado.

$dsn      = 'mysql:host=localhost;dbname=intranet;charset=utf8mb4';
$usuario  = 'intranet_user';
$clave    = 'CAMBIAR-por-una-clave-larga';   // en la memoria, tapar o sustituir por ********

try {
    $pdo = new PDO($dsn, $usuario, $clave, [
        PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    ]);
    $avisos = $pdo->query('SELECT id, titulo, fecha FROM avisos ORDER BY fecha')->fetchAll();
} catch (PDOException $e) {
    error_log('prueba-bd.php: ' . $e->getMessage());
    http_response_code(500);
    exit('Error de conexión con la base de datos. Consulta el registro de errores.');
}
?>
<!DOCTYPE html>
<html lang="es">
<head><meta charset="UTF-8"><title>Prueba de conexión</title></head>
<body>
    <h1>Avisos de la intranet</h1>
    <p>Conexión correcta con MariaDB <?= htmlspecialchars($pdo->query('SELECT VERSION()')->fetchColumn()) ?>.</p>
    <table border="1" cellpadding="6">
        <tr><th>Id</th><th>Título</th><th>Fecha</th></tr>
        <?php foreach ($avisos as $a): ?>
        <tr>
            <td><?= (int) $a['id'] ?></td>
            <td><?= htmlspecialchars($a['titulo']) ?></td>
            <td><?= date('d/m/Y', strtotime($a['fecha'])) ?></td>
        </tr>
        <?php endforeach; ?>
    </table>
</body>
</html>
