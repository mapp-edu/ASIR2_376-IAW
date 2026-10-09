// ============================================================================
// CONFIGURACIÓN DE UNIDADES — Navegación y Contenidos
// ============================================================================
//
// 👤 EDITA ESTE ARCHIVO para definir los módulos/unidades del curso
//    y su navegación (navbar y sidebar).
//
// CONCEPTOS CLAVE:
//   Unidad (unit) — Un bloque de contenido con su propia navegación.
//                   Aquí: la presentación del módulo y las 7 unidades de
//                   programación (UP1…UP7).
//   Navbar        — Menú horizontal en la barra superior.
//   Sidebar       — Panel de navegación lateral izquierdo.
//   code          — Prefijo de URL de los archivos de esta unidad.
//                   Ejemplo: code = 'up5' → los links apuntan a /up5/...
//
// FLUJO RÁPIDO:
//   1. Crea los archivos .md en src/<code>/contenidos/ y src/<code>/ejercicios/
//   2. Añade los links aquí (en navbar y sidebar)
//   3. El sistema detecta todas las unidades automáticamente:
//        /<code>/ → carga el sidebar de esa unidad
//        /        → raíz sin sidebar (página de inicio)
//
// ⚠️ Los links se escriben SIN el prefijo de la unidad: el sistema antepone
//    /<code> automáticamente ('/contenidos/1-x' → '/up5/contenidos/1-x').
//
// ============================================================================

import { DefaultTheme } from 'vitepress'
import type { NavGroup } from '../shared/navigation'

// ============================================================================
// 1. NAVBARS Y SIDEBARS
// ============================================================================

// ── Presentación del módulo ────────────────────────────────────────────────
const navbarGeneral: DefaultTheme.NavItem[] = [
  { text: 'Presentación del módulo', link: '/index' },
  { text: 'Organización y recursos', link: '/contenidos/1-organizacion' },
  { text: 'Resultados de aprendizaje', link: '/contenidos/2-resultados-aprendizaje' },
  { text: 'Evaluación y rúbricas', link: '/contenidos/3-evaluacion' },
]

const sidebarGeneral: DefaultTheme.SidebarItem[] = [
  {
    text: '📘 El módulo',
    collapsed: false,
    items: [
      { text: 'Presentación', link: '/index' },
      { text: 'Organización y recursos', link: '/contenidos/1-organizacion' },
      { text: 'Resultados de aprendizaje', link: '/contenidos/2-resultados-aprendizaje' },
      { text: 'Evaluación y rúbricas', link: '/contenidos/3-evaluacion' },
      { text: 'Créditos y fuentes', link: '/contenidos/4-creditos' },
    ]
  },
]

// ── UP1 — Servidores de aplicaciones web (RA1) ─────────────────────────────
const navbarUP1: DefaultTheme.NavItem[] = [
  { text: 'Portada de la unidad', link: '/index' },
  { text: 'Contenidos', link: '/contenidos/1-arquitecturas-web' },
  { text: 'Prácticas', link: '/ejercicios/' },
]

const sidebarUP1: DefaultTheme.SidebarItem[] = [
  {
    text: '🖥️ UP1 — Servidores de aplicaciones web',
    collapsed: false,
    items: [
      { text: 'Portada de la unidad', link: '/index' },
    ]
  },
  {
    text: '📚 Contenidos',
    collapsed: false,
    items: [
      { text: '1. Arquitecturas web', link: '/contenidos/1-arquitecturas-web' },
      { text: '2. Herramientas y puesta en marcha', link: '/contenidos/2-herramientas-entorno' },
      { text: '3. Tecnologías y entorno de desarrollo', link: '/contenidos/3-tecnologias-desarrollo' },
      { text: '4. Control de versiones con Git', link: '/contenidos/4-control-versiones-git' },
      { text: '5. Instalación de un servidor', link: '/contenidos/5-instalacion-servidores' },
    ]
  },
  {
    text: '🧪 Prácticas',
    collapsed: false,
    items: [
      { text: 'Índice de prácticas', link: '/ejercicios/' },
      { text: 'P1.1 Git y GitHub', link: '/ejercicios/1-git-github' },
      { text: 'P1.2 Requerimientos y sistema', link: '/ejercicios/2-requerimientos-sistema' },
      { text: 'P1.3 Apache y PHP en Ubuntu', link: '/ejercicios/3-apache-ubuntu' },
      { text: 'P1.4 MariaDB en Ubuntu', link: '/ejercicios/4-mariadb-ubuntu' },
      { text: 'P1.5 Entorno con Docker Compose', link: '/ejercicios/5-docker-compose' },
    ]
  },
]

// ── UP2 — Implantación de gestores de contenidos (RA2) ─────────────────────
const navbarUP2: DefaultTheme.NavItem[] = [
  { text: 'Portada de la unidad', link: '/index' },
  { text: 'Contenidos', link: '/contenidos/1-gestores-contenidos' },
  { text: 'Prácticas', link: '/ejercicios/' },
]

const sidebarUP2: DefaultTheme.SidebarItem[] = [
  {
    text: '📰 UP2 — Implantación de CMS',
    collapsed: false,
    items: [
      { text: 'Portada de la unidad', link: '/index' },
    ]
  },
  {
    text: '📚 Contenidos',
    collapsed: false,
    items: [
      { text: '1. Gestores de contenidos', link: '/contenidos/1-gestores-contenidos' },
    ]
  },
  {
    text: '🧪 Prácticas',
    collapsed: false,
    items: [
      { text: 'Índice y proyecto del portal', link: '/ejercicios/' },
      { text: 'P2.1 Instalación de WordPress', link: '/ejercicios/1-instalacion-wordpress' },
      { text: 'P2.2 Uso básico de WordPress', link: '/ejercicios/2-uso-basico-wordpress' },
      { text: 'P2.3 WordPress en remoto', link: '/ejercicios/3-wordpress-remoto' },
      { text: 'P2.4 WordPress en LAMP', link: '/ejercicios/4-wordpress-lamp' },
      { text: 'P2.5 Moodle', link: '/ejercicios/5-moodle' },
      { text: 'P2.6 Joomla y comparativa', link: '/ejercicios/6-joomla-remoto' },
    ]
  },
]

// ── UP3 — Administración de gestores de contenidos (RA3) ───────────────────
const navbarUP3: DefaultTheme.NavItem[] = [
  { text: 'Portada de la unidad', link: '/index' },
  { text: 'Contenidos', link: '/contenidos/1-administracion-cms' },
  { text: 'Prácticas', link: '/ejercicios/' },
]

const sidebarUP3: DefaultTheme.SidebarItem[] = [
  {
    text: '🛠️ UP3 — Administración de CMS',
    collapsed: false,
    items: [
      { text: 'Portada de la unidad', link: '/index' },
    ]
  },
  {
    text: '📚 Contenidos',
    collapsed: false,
    items: [
      { text: '1. Administración de gestores de contenidos', link: '/contenidos/1-administracion-cms' },
    ]
  },
  {
    text: '🧪 Prácticas',
    collapsed: false,
    items: [
      { text: 'Índice de prácticas', link: '/ejercicios/' },
      { text: 'P3.1 Actualizaciones, plugins y copias', link: '/ejercicios/1-actualizaciones-copias' },
      { text: 'P3.2 Usuarios, roles y actividad', link: '/ejercicios/2-usuarios-roles' },
      { text: 'P3.3 Organización y sindicación', link: '/ejercicios/3-organizacion-sindicacion' },
      { text: 'P3.4 Proyecto integrador', link: '/ejercicios/4-proyecto-integrador-cms' },
    ]
  },
]

// ── UP4 — Adaptación de gestores de contenidos (RA7) ───────────────────────
const navbarUP4: DefaultTheme.NavItem[] = [
  { text: 'Portada de la unidad', link: '/index' },
  { text: 'Contenidos', link: '/contenidos/1-adaptacion-cms' },
  { text: 'Prácticas', link: '/ejercicios/' },
]

const sidebarUP4: DefaultTheme.SidebarItem[] = [
  {
    text: '🧩 UP4 — Adaptación de CMS',
    collapsed: false,
    items: [
      { text: 'Portada de la unidad', link: '/index' },
    ]
  },
  {
    text: '📚 Contenidos',
    collapsed: false,
    items: [
      { text: '1. Adaptación de gestores de contenidos', link: '/contenidos/1-adaptacion-cms' },
      { text: '2. Ejemplo guiado: Code Snippets', link: '/contenidos/2-ejemplo-code-snippets' },
    ]
  },
  {
    text: '🧪 Prácticas',
    collapsed: false,
    items: [
      { text: 'Índice de prácticas', link: '/ejercicios/' },
      { text: 'P4.1 PHP con Code Snippets', link: '/ejercicios/1-code-snippets' },
      { text: 'P4.2 Apariencia con tema hijo', link: '/ejercicios/2-apariencia-tema-hijo' },
      { text: 'P4.3 Plugin propio', link: '/ejercicios/3-plugin-propio' },
    ]
  },
]

// ── UP5 — PHP: lenguaje de guiones de servidor (RA5) ───────────────────────
const navbarUP5: DefaultTheme.NavItem[] = [
  { text: 'Portada de la unidad', link: '/index' },
  { text: 'Contenidos', link: '/contenidos/1-introduccion-php' },
  { text: 'Diapositivas', link: '/diapositivas/1-introduccion-php' },
  { text: 'Prácticas', link: '/ejercicios/' },
]

const sidebarUP5: DefaultTheme.SidebarItem[] = [
  {
    text: '🐘 UP5 — PHP',
    collapsed: false,
    items: [
      { text: 'Portada de la unidad', link: '/index' },
    ]
  },
  {
    text: '📚 Contenidos',
    collapsed: false,
    items: [
      { text: '1. Introducción a PHP', link: '/contenidos/1-introduccion-php' },
      { text: '2. Expresiones y control de flujo', link: '/contenidos/2-control-flujo' },
      { text: '3. Funciones', link: '/contenidos/3-funciones' },
      { text: '4. Matrices (arrays)', link: '/contenidos/4-matrices' },
      { text: '5. Formularios', link: '/contenidos/5-formularios' },
      { text: '6. Cookies, sesiones y autenticación', link: '/contenidos/6-cookies-sesiones' },
    ]
  },
  {
    text: '🎞️ Diapositivas',
    collapsed: true,
    items: [
      { text: '1. Introducción a PHP', link: '/diapositivas/1-introduccion-php' },
      { text: '2. Expresiones y control de flujo', link: '/diapositivas/2-control-flujo' },
      { text: '3. Funciones', link: '/diapositivas/3-funciones' },
      { text: '4. Matrices (arrays)', link: '/diapositivas/4-matrices' },
      { text: '5. Formularios', link: '/diapositivas/5-formularios' },
      { text: '6. Cookies, sesiones y autenticación', link: '/diapositivas/6-cookies-sesiones' },
    ]
  },
  {
    text: '🧪 Prácticas',
    collapsed: false,
    items: [
      { text: 'Índice de prácticas', link: '/ejercicios/' },
      { text: 'P5.1 Ejercicios básicos', link: '/ejercicios/1-ejercicios-basicos' },
      { text: 'P5.2 Bucles, arrays y funciones', link: '/ejercicios/2-bucles-arrays-funciones' },
      { text: 'P5.3 Envío de correos', link: '/ejercicios/3-envio-correos' },
      { text: 'P5.4 Formularios', link: '/ejercicios/4-formularios' },
      { text: 'P5.5 Monitorización de procesos', link: '/ejercicios/5-monitorizacion-procesos' },
      { text: 'P5.6 Zona privada', link: '/ejercicios/6-zona-privada' },
    ]
  },
]

// ── UP6 — PHP y bases de datos (RA6) ───────────────────────────────────────
const navbarUP6: DefaultTheme.NavItem[] = [
  { text: 'Portada de la unidad', link: '/index' },
  { text: 'Contenidos', link: '/contenidos/1-acceso-datos-pdo' },
  { text: 'Diapositivas', link: '/diapositivas/1-acceso-datos' },
  { text: 'Prácticas', link: '/ejercicios/' },
]

const sidebarUP6: DefaultTheme.SidebarItem[] = [
  {
    text: '🗄️ UP6 — PHP y bases de datos',
    collapsed: false,
    items: [
      { text: 'Portada de la unidad', link: '/index' },
    ]
  },
  {
    text: '📚 Contenidos',
    collapsed: false,
    items: [
      { text: '1. Acceso a datos con PDO', link: '/contenidos/1-acceso-datos-pdo' },
      { text: '2. Crear, consultar, modificar y borrar', link: '/contenidos/2-crud-pdo' },
    ]
  },
  {
    text: '🎞️ Diapositivas',
    collapsed: true,
    items: [
      { text: '1. Acceso a datos', link: '/diapositivas/1-acceso-datos' },
    ]
  },
  {
    text: '🧪 Prácticas',
    collapsed: false,
    items: [
      { text: 'Índice de prácticas', link: '/ejercicios/' },
      { text: 'P6.1 Autenticación contra MySQL', link: '/ejercicios/1-autenticacion-bd' },
      { text: 'P6.2 Gestión de una tabla', link: '/ejercicios/2-crud' },
      { text: 'P6.3 Clientes y pedidos', link: '/ejercicios/3-clientes-pedidos' },
      { text: 'P6.4 Proyecto integrador', link: '/ejercicios/4-proyecto-gestor-tareas' },
    ]
  },
]

// ── UP7 — Ofimática web (RA4) ──────────────────────────────────────────────
const navbarUP7: DefaultTheme.NavItem[] = [
  { text: 'Portada de la unidad', link: '/index' },
  { text: 'Contenidos', link: '/contenidos/1-ofimatica-web' },
  { text: 'Prácticas', link: '/ejercicios/' },
]

const sidebarUP7: DefaultTheme.SidebarItem[] = [
  {
    text: '📎 UP7 — Ofimática web',
    collapsed: false,
    items: [
      { text: 'Portada de la unidad', link: '/index' },
    ]
  },
  {
    text: '📚 Contenidos',
    collapsed: false,
    items: [
      { text: '1. Aplicaciones de ofimática web', link: '/contenidos/1-ofimatica-web' },
    ]
  },
  {
    text: '🧪 Prácticas',
    collapsed: false,
    items: [
      { text: 'Índice de prácticas', link: '/ejercicios/' },
      { text: 'P7.1 Instalación de Nextcloud', link: '/ejercicios/1-instalacion-nextcloud' },
      { text: 'P7.2 Usuarios y accesos', link: '/ejercicios/2-usuarios-accesos' },
      { text: 'P7.3 Trabajo cooperativo', link: '/ejercicios/3-trabajo-cooperativo' },
      { text: 'P7.4 Tareas y calendario', link: '/ejercicios/4-tareas-calendario' },
    ]
  },
]

// ============================================================================
// 2. REGISTRO DE UNIDADES
// ============================================================================
// Añade, elimina o modifica entradas para gestionar los módulos del curso.
//
// Propiedades de cada unidad:
//   id        — Identificador único (debe coincidir con la clave del objeto)
//   code      — Prefijo de URL. Los links del navbar/sidebar se prefijarán
//               automáticamente con /<code>/
//   title     — Nombre corto (es el texto del desplegable en el navbar)
//   fullTitle — Nombre completo (aparece en la pestaña del navegador)
//   siteTitle — Nombre en el sidebar (puede usar </br> para saltos de línea)
//   icon      — Emoji decorativo del módulo
//   navbar    — Ítems del menú superior de esta unidad
//   sidebar   — Ítems del panel lateral de esta unidad

export interface UnitConfig {
  id: string
  code: string
  title: string
  fullTitle: string
  siteTitle: string
  icon: string
  navbar: DefaultTheme.NavItem[]
  sidebar: DefaultTheme.SidebarItem[]
}

export const UNITS: Record<string, UnitConfig> = {

  // Página de inicio — sin navegación de curso.
  // En cursos con varias unidades, de aquí salen el título de la pestaña
  // del navegador y el nombre que se muestra junto al logo.
  root: {
    id: 'root',
    code: 'root',
    title: 'IAW',
    fullTitle: 'Implantación de Aplicaciones Web',
    siteTitle: 'IAW</br>2º ASIR',
    icon: '🌐',
    navbar: [{ text: '🏠 Inicio', link: '/' }],
    sidebar: []
  },

  // ── Presentación del módulo ──────────────────────────────────────────────
  MODULO: {
    id: 'MODULO',
    code: 'general',    // → archivos en src/general/
    title: 'Módulo',
    fullTitle: 'IAW — Presentación del módulo',
    siteTitle: 'IAW</br>El módulo',
    icon: '📘',
    navbar: navbarGeneral,
    sidebar: sidebarGeneral
  },

  UP1: {
    id: 'UP1',
    code: 'up1',        // → archivos en src/up1/
    title: 'UP1',
    fullTitle: 'UP1 — Conceptos sobre aplicaciones web e instalación de servidores de aplicaciones web',
    siteTitle: 'UP1</br>Servidores web',
    icon: '🖥️',
    navbar: navbarUP1,
    sidebar: sidebarUP1
  },

  UP2: {
    id: 'UP2',
    code: 'up2',
    title: 'UP2',
    fullTitle: 'UP2 — Implantación de gestores de contenidos',
    siteTitle: 'UP2</br>Implantación de CMS',
    icon: '📰',
    navbar: navbarUP2,
    sidebar: sidebarUP2
  },

  UP3: {
    id: 'UP3',
    code: 'up3',
    title: 'UP3',
    fullTitle: 'UP3 — Administración de gestores de contenidos',
    siteTitle: 'UP3</br>Administración de CMS',
    icon: '🛠️',
    navbar: navbarUP3,
    sidebar: sidebarUP3
  },

  UP4: {
    id: 'UP4',
    code: 'up4',
    title: 'UP4',
    fullTitle: 'UP4 — Adaptación y personalización de gestores de contenidos',
    siteTitle: 'UP4</br>Adaptación de CMS',
    icon: '🧩',
    navbar: navbarUP4,
    sidebar: sidebarUP4
  },

  UP5: {
    id: 'UP5',
    code: 'up5',
    title: 'UP5',
    fullTitle: 'UP5 — Programación de documentos web con lenguajes de script de servidor (PHP)',
    siteTitle: 'UP5</br>PHP',
    icon: '🐘',
    navbar: navbarUP5,
    sidebar: sidebarUP5
  },

  UP6: {
    id: 'UP6',
    code: 'up6',
    title: 'UP6',
    fullTitle: 'UP6 — Acceso a bases de datos desde lenguajes de script de servidor',
    siteTitle: 'UP6</br>PHP y bases de datos',
    icon: '🗄️',
    navbar: navbarUP6,
    sidebar: sidebarUP6
  },

  UP7: {
    id: 'UP7',
    code: 'up7',
    title: 'UP7',
    fullTitle: 'UP7 — Gestión de aplicaciones de ofimática web',
    siteTitle: 'UP7</br>Ofimática web',
    icon: '📎',
    navbar: navbarUP7,
    sidebar: sidebarUP7
  },

}

// ============================================================================
// FUNCIONES DE ACCESO — No modificar
// ============================================================================

export function getAllUnitsArray(): UnitConfig[] {
  return Object.values(UNITS)
}

export function getUnitByCode(code: string): UnitConfig | undefined {
  return UNITS[code]
}

// ── Navbar dinámico por unidad (opcional) ────────────────────────────────
// Si el curso tiene múltiples sesiones/unidades, define aquí qué dropdown
// mostrar en el navbar según la URL activa.
// Ejemplo:
// export const unitNavbars: Record<string, NavGroup[]> = {
//   'general': [{ text: '📚 Módulos', items: [{ text: 'General', link: '/general/' }] }],
// }
export const unitNavbars: Record<string, NavGroup[]> = {}
