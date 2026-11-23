---
layout: doc
title: "Informe modelo · P2.6"
sidebar: true
outline: [2, 3]
aside: true
---

# Informe: ¿qué herramienta usar para la web de la asociación?

<ExportPDF />

::: info-box Material de referencia
Complemento de la [solución de la P2.6](./6-joomla-remoto).
:::

*Informe modelo de referencia para la P2.6 (nivel 4). Dirigido a la junta de una asociación cultural sin conocimientos técnicos. Datos de noviembre de 2026.*

---

## Resumen

Recomendamos **WordPress**, instalado en un alojamiento web con dominio propio. Es la opción más fácil de usar para los voluntarios, la más barata de mantener y la que más ayuda tiene disponible. Si la asociación necesita una web **completa en castellano y en valenciano**, Joomla es una alternativa igual de válida, porque lo trae de serie. No recomendamos Wix ni servicios parecidos por el coste anual y porque la web quedaría atada a esa empresa.

Hemos preparado una web de demostración con Joomla para que podáis verla: `https://…` (enlace del sitio publicado).

## 1. ¿Por qué usar un gestor de contenidos?

Un **gestor de contenidos** (CMS, por sus siglas en inglés) es un programa que permite publicar y actualizar una web desde el navegador, como quien escribe un correo, sin saber programar.

| Con una web hecha a mano | Con un gestor de contenidos |
|:-------------------------|:----------------------------|
| Cada cambio (una actividad nueva, una foto) hay que pedírselo a quien la hizo. | Cualquier persona de la junta puede publicar una noticia o una actividad. |
| Si esa persona deja la asociación, nadie sabe actualizarla. | Los voluntarios cambian cada año; la herramienta se aprende en una tarde. |
| Cambiar el diseño supone rehacer todas las páginas. | Se cambia la plantilla y los textos se conservan. |
| Muy rápida y difícil de atacar. | Hay que **actualizarla** cada cierto tiempo y hacer **copias de seguridad**, como con el móvil. |
| Funciones como un calendario o un formulario de inscripción hay que programarlas. | Se añaden instalando complementos, muchos gratuitos. |

Para una asociación que publica a menudo (agenda, crónicas, fotos, convocatorias) un gestor de contenidos ahorra tiempo y evita depender de una sola persona.

## 2. Comparación

Hemos comparado los dos gestores libres más conocidos y un servicio comercial en la nube.

| | **WordPress** | **Joomla** | **Wix** |
|:--|:--------------|:-----------|:--------|
| **Licencia** | Libre (GPL): gratis, sin límite de uso. | Libre (GPL): gratis, sin límite de uso. | Comercial: se paga una cuota para tener dominio propio y quitar la publicidad. |
| **Facilidad de uso** | La más sencilla: editor por bloques, muy visual. | Algo más difícil: hay que entender categorías, menús y «módulos». | Muy sencilla: se arrastran los elementos. |
| **Complementos** | Decenas de miles: agenda de eventos, socios, donaciones, boletín… | Miles, en un directorio oficial. Menos variedad. | Los que ofrece la tienda de Wix; algunos de pago. |
| **Usuarios y permisos** | Perfiles fijos (administrador, editor, autor…). Suficiente para una junta. | Muy detallados: se puede decidir quién edita cada sección. | Según el plan contratado. |
| **Varios idiomas** | Con un complemento (Polylang, gratuito en lo básico). | **Incluido**: castellano y valenciano sin añadir nada. | Incluido. |
| **Qué necesita** | Cualquier alojamiento web normal (desde unos pocos euros al mes). | Alojamiento algo más reciente (PHP 8.3). | Nada: Wix lo aloja todo. |
| **Comunidad y ayuda** | La mayor con diferencia: 39 % de todas las webs del mundo. Mucha documentación en castellano y muchos profesionales. | Más pequeña (1 % de las webs), pero activa y con documentación en castellano. | Soporte de la empresa; no hay comunidad de desarrolladores. |
| **Si queréis cambiar** | Podéis llevaros la web a cualquier otro alojamiento. | Igual. | La web no se puede trasladar tal cual: habría que rehacerla. |

*Datos de uso: W3Techs, 9 de noviembre de 2026 (WordPress 39,4 %, Wix 4,2 %, Joomla 1,1 % de todas las webs).*

## 3. ¿Qué significa la licencia para la asociación?

- **WordPress y Joomla (GPL):** podéis usarlos gratis para siempre, encargar a cualquier persona o empresa que los adapte y cambiar de proveedor cuando queráis. La licencia solo pone condiciones a quien **redistribuya** el programa modificado, no a quien lo usa para su propia web. Pagaréis el alojamiento y el dominio, no el programa.
- **Wix (comercial):** no compráis un programa, alquiláis un servicio. Mientras paguéis, funciona y no tenéis que ocuparos de nada técnico. Pero las condiciones y los precios los decide Wix, vuestra web y los datos de los socios quedan en sus servidores, y si un día queréis marcharos no podéis llevaros la web.

## 4. Lo que hemos visto al probar Joomla

En la demostración hemos instalado Joomla, creado las secciones «Actividades» y «Noticias» con un artículo en cada una, y cambiado el diseño con una plantilla nueva.

- La instalación es parecida a la de WordPress, con algún control de seguridad más.
- Organizar el contenido exige pensar antes la estructura: cada artículo va en una categoría y los menús se configuran aparte.
- El panel de administración tiene más opciones que el de WordPress: más potencia, pero más curva de aprendizaje para los voluntarios.

## 5. Recomendación

| Si para vosotros es más importante… | Elegid |
|:-------------------------------------|:-------|
| Que cualquier voluntario pueda publicar sin formación, gastar lo mínimo y tener ayuda fácil de encontrar | **WordPress** |
| Una web completa en castellano y valenciano, con permisos distintos por sección | **Joomla** |
| No ocuparse nunca de actualizaciones y copias, aunque se pague cada año y se dependa de una empresa | Wix |

**Nuestra recomendación es WordPress**, porque la asociación necesita sobre todo publicar a menudo con personas que cambian cada año, y es donde WordPress es más fuerte. Para que funcione bien:

1. Contratar un alojamiento con copias de seguridad automáticas y un dominio propio (`asociacion.org`).
2. Crear una cuenta para cada persona de la junta con el perfil justo («Editor» para quien publica, «Administrador» solo para una o dos personas).
3. Encargar a alguien la actualización mensual.
4. Si se quiere la web en valenciano, añadir el complemento de idiomas desde el principio.
