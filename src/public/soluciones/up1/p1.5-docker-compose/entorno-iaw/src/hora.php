<?php
// ── Parte que se ejecuta en el SERVIDOR ──────────────────────────────
// Este bloque lo interpreta PHP dentro del contenedor "web" antes de enviar
// la respuesta. El navegador nunca recibe este código, solo su resultado.

$horaServidor = date('H:i:s');
$zonaServidor = date_default_timezone_get();
$generada     = date('d/m/Y H:i:s T');

// Consulta a la base de datos con PDO (los datos de conexión vienen del .env)
$host  = getenv('DB_HOST');
$base  = getenv('DB_NAME');
$dsn   = "mysql:host=$host;dbname=$base;charset=utf8mb4";

try {
    $pdo = new PDO($dsn, getenv('DB_USER'), getenv('DB_PASSWORD'), [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
    ]);
    $versionBD = $pdo->query('SELECT VERSION()')->fetchColumn();
    $errorBD   = null;
} catch (PDOException $e) {
    $versionBD = null;
    $errorBD   = 'No se ha podido conectar con la base de datos.';
    error_log('hora.php: ' . $e->getMessage());   // el detalle va al registro, no a la página
}

function e(string $texto): string
{
    return htmlspecialchars($texto, ENT_QUOTES, 'UTF-8');
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Hora del servidor y del navegador</title>
    <style>
        body  { font-family: system-ui, sans-serif; background: #F5F5F5; color: #222; max-width: 46rem; margin: 2rem auto; padding: 0 1rem; }
        h1    { color: #1C375B; }
        .caja { background: #fff; border-left: 6px solid #1C375B; padding: 1rem 1.25rem; margin: 1rem 0; border-radius: 4px; }
        .cliente { border-left-color: #ED6E51; }
        .hora { font-size: 2.5rem; font-weight: 700; font-variant-numeric: tabular-nums; }
        .nota { color: #6F8197; font-size: .9rem; }
        .error { color: #B00020; }
    </style>
</head>
<body>
    <h1>Hora del servidor y del navegador</h1>

    <div class="caja">
        <h2>🖥️ Servidor (PHP)</h2>
        <p class="hora"><?= e($horaServidor) ?></p>
        <p>Zona horaria del servidor: <strong><?= e($zonaServidor) ?></strong></p>
        <p class="nota">Calculada una sola vez, al generar la página (<?= e($generada) ?>). Recarga para actualizarla.</p>
    </div>

    <div class="caja cliente">
        <h2>🌐 Navegador (JavaScript)</h2>
        <p class="hora" id="hora-cliente">--:--:--</p>
        <p>Zona horaria del navegador: <strong id="zona-cliente">—</strong></p>
        <p class="nota">Calculada en tu equipo y actualizada cada segundo, sin volver a pedir nada al servidor.</p>
        <noscript><p class="error">JavaScript está desactivado: el navegador no puede calcular su hora.</p></noscript>
    </div>

    <div class="caja">
        <h2>🗄️ Base de datos (PDO)</h2>
        <?php if ($versionBD !== null): ?>
            <p>Versión de MariaDB: <strong><?= e($versionBD) ?></strong></p>
            <p class="nota">Servidor <code><?= e($host) ?></code>, base de datos <code><?= e($base) ?></code>.</p>
        <?php else: ?>
            <p class="error"><?= e($errorBD) ?></p>
        <?php endif; ?>
    </div>

    <script>
        // ── Parte que se ejecuta en el CLIENTE ───────────────────────────
        // Este código llega tal cual al navegador, que es quien lo ejecuta.
        function mostrarHora() {
            document.getElementById('hora-cliente').textContent =
                new Date().toLocaleTimeString('es-ES');
        }
        document.getElementById('zona-cliente').textContent =
            Intl.DateTimeFormat().resolvedOptions().timeZone;
        mostrarHora();
        setInterval(mostrarHora, 1000);
    </script>
</body>
</html>
