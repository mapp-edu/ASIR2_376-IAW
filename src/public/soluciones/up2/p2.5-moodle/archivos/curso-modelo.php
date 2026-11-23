<?php
// P2.5 — Crea el curso modelo de referencia con la API de Moodle (uso del profesorado).
// El alumnado lo hace desde el navegador; este script sirve para preparar una demostración
// o comprobar rápidamente que la instalación admite cursos, recursos, actividades y matrículas.
//
// Uso:  sudo -u www-data php curso-modelo.php /var/www/moodle

define('CLI_SCRIPT', true);
$moodle = $argv[1] ?? '/var/www/moodle';
require($moodle . '/config.php');
require_once($CFG->dirroot . '/course/lib.php');
require_once($CFG->dirroot . '/course/modlib.php');
require_once($CFG->dirroot . '/user/lib.php');
require_once($CFG->libdir . '/enrollib.php');

\core\session\manager::set_user(get_admin());

// 1. Categoría
$cat = core_course_category::create([
    'name'        => 'Formación interna',
    'idnumber'    => 'FORM-INT',
    'description' => 'Cursos para la plantilla de la empresa.',
]);

// 2. Curso con formato de temas y dos secciones
$course = create_course((object) [
    'category'    => $cat->id,
    'fullname'    => 'Prevención de riesgos laborales en la oficina',
    'shortname'   => 'PRL-OFI',
    'idnumber'    => 'PRL-OFI-2026',
    'summary'     => 'Curso modelo del centro de formación: estructura, recurso, actividad y matrícula.',
    'format'      => 'topics',
    'numsections' => 2,
    'lang'        => '',
]);
course_get_format($course)->update_course_format_options(['numsections' => 2]);
$secciones = [1 => 'Tema 1. Puesto de trabajo', 2 => 'Tema 2. Evaluación'];
foreach ($secciones as $num => $nombre) {
    $s = $DB->get_record('course_sections', ['course' => $course->id, 'section' => $num], '*', MUST_EXIST);
    course_update_section($course, $s, ['name' => $nombre]);
}

// 3. Recurso: página en el tema 1
add_moduleinfo((object) [
    'modulename'   => 'page',
    'module'       => $DB->get_field('modules', 'id', ['name' => 'page']),
    'course'       => $course->id,
    'section'      => 1,
    'visible'      => 1,
    'name'         => 'Ergonomía del puesto con pantalla',
    'intro'        => 'Lectura obligatoria.',
    'introformat'  => FORMAT_HTML,
    'content'      => '<p>Altura de la pantalla, distancia de lectura, iluminación y pausas.</p>',
    'contentformat'=> FORMAT_HTML,
    'display'      => 5,
    'printintro'   => 0,
    'printlastmodified' => 1,
], $course);

// 4. Actividad: tarea en el tema 2
add_moduleinfo((object) [
    'modulename'   => 'assign',
    'module'       => $DB->get_field('modules', 'id', ['name' => 'assign']),
    'course'       => $course->id,
    'section'      => 2,
    'visible'      => 1,
    'name'         => 'Autoevaluación de tu puesto de trabajo',
    'intro'        => 'Sube una foto de tu puesto y señala dos mejoras.',
    'introformat'  => FORMAT_HTML,
    'alwaysshowdescription' => 1,
    'submissiondrafts' => 0, 'requiresubmissionstatement' => 0, 'sendnotifications' => 0,
    'sendlatenotifications' => 0, 'duedate' => 0, 'cutoffdate' => 0, 'gradingduedate' => 0,
    'allowsubmissionsfromdate' => 0, 'grade' => 10, 'teamsubmission' => 0,
    'requireallteammemberssubmit' => 0, 'blindmarking' => 0, 'markingworkflow' => 0,
    'assignsubmission_file_enabled' => 1, 'assignsubmission_file_maxfiles' => 1,
    'assignsubmission_file_maxsizebytes' => 0, 'assignsubmission_onlinetext_enabled' => 1,
], $course);

// 5. Usuario de prueba matriculado como estudiante
$userid = user_create_user((object) [
    'username'  => 'estudiante1',
    'password'  => 'Estudiante-2026!',
    'firstname' => 'Estudiante',
    'lastname'  => 'De Prueba',
    'email'     => 'estudiante1@empresa.local',
    'auth'      => 'manual',
    'confirmed' => 1,
    'mnethostid'=> $CFG->mnet_localhost_id,
]);
$manual = enrol_get_plugin('manual');
$instance = $DB->get_record('enrol', ['courseid' => $course->id, 'enrol' => 'manual'], '*', MUST_EXIST);
$manual->enrol_user($instance, $userid, $DB->get_field('role', 'id', ['shortname' => 'student']));

echo "Curso creado: {$CFG->wwwroot}/course/view.php?id={$course->id}\n";
