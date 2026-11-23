---
layout: doc
title: "Guion del vídeo · P3.4"
sidebar: true
outline: [2, 3]
aside: true
---

# 🎬 Guion de referencia del vídeo · P3.4

<ExportPDF />

::: info-box Material de referencia
Complemento de la [solución de la P3.4](./4-proyecto-integrador-cms).
:::

Duración orientativa: **8–10 minutos**. Grabación de pantalla con voz (OBS Studio, Xbox Game Bar en Windows o la grabación de pantalla de PowerPoint). Lo que cuenta es que se oiga la explicación y que cada punto del enunciado se vea en pantalla.

Antes de grabar: XAMPP encendido, sesión iniciada como administradora en una ventana y una **ventana privada** para la parte pública, y el plugin de categorías en páginas activo.

| Tiempo | Punto del enunciado | Qué se ve | Qué se dice (ejemplo) |
|:-------|:--------------------|:----------|:----------------------|
| 0:00–0:30 | Presentación | Portada del sitio | «Esta es la web de ElectroHogar, montada sobre XAMPP 8.4 con WordPress 7.1. Voy a enseñar los usuarios, el contenido, las copias y la parte pública». |
| 0:30–2:00 | **1. Usuarios, roles y grupos** | **Usuarios**: columna *Rol*; filtrar por rol | «Seis usuarios: la gerente es administradora; Lucía, la responsable de contenidos, es editora: puede editar todo el contenido pero no tocar plugins ni usuarios; Diego y Marta son autores: publican sus ofertas pero no las de otros ni crean páginas; Álex, el alumno en prácticas, es colaborador: lo que escribe lo revisa Lucía; y hay un cliente suscriptor que solo puede editar su perfil». |
| | | **Groups → Groups** y la columna *Groups* en Usuarios | «El rol dice qué puede hacer cada uno; el grupo, a qué equipo pertenece. *Equipo de tienda* reúne al personal del local y *Contenidos web* a quien publica. Con Groups puedo restringir una página a un grupo, por ejemplo el cuadrante de turnos». |
| 2:00–4:00 | **2. Páginas, categorías y autores** | **Páginas**: columnas *Autor* y *Categorías* | «Las seis páginas: *Sobre nosotros* y *Contacto*, con contenido, las creó la gerente; las de producto, la editora. WordPress no deja poner categorías a las páginas: he instalado un plugin que lo permite y que además hace que las páginas salgan en el archivo de su categoría». |
| | | Abrir *Móviles* → panel *Categorías* | «Móviles está en la categoría Móviles, que es hija de Electrónica». |
| | | **Entradas → Categorías** → crear *Televisores* con superior *Electrónica* | «Para añadir una subcategoría nueva: nombre, categoría superior Electrónica y *Añadir*. Después crearía la página, le marcaría la categoría y la añadiría al menú, dentro de Electrónica». |
| 4:00–5:30 | **3. Copia de seguridad** | **Ajustes → UpdraftPlus**: *Copias de seguridad existentes* | «Esta es la copia completa que hice al terminar: base de datos, plugins, temas, archivos subidos y el resto de wp-content. No incluye el núcleo de WordPress, que se puede reinstalar». |
| | | Pestaña *Ajustes*: programación diaria → cambiar a **Semanal** → *Guardar* → volver y ver la próxima fecha | «Ahora está diaria. Para hacerla semanal, cambio aquí y guardo: la próxima copia pasa al día X. Lo ideal sería mandarla a Google Drive, porque aquí está en el mismo disco». |
| 5:30–8:00 | **4. Parte pública** | Ventana privada, portada | «Así lo ve un cliente». |
| | | Recorrer **todo** el menú: Productos → Electrónica (archivo con Móviles y Ordenadores) → Móviles → Ordenadores → Hogar → Cocina → Decoración → Sobre nosotros (imagen y enlaces, pulsar uno) → Contacto | Comentar el tercer nivel, que no hay páginas vacías y que los enlaces funcionan. |
| | | Ventana estrecha o modo móvil (F12) | «En el móvil el menú se convierte en un botón y los tres niveles se despliegan». |
| 8:00–9:30 | **5. Extras y dificultades** | Lo que corresponda | Ejemplos: «Activé las extensiones intl y zip en php.ini porque Salud del sitio las pedía»; «El puerto 80 estaba ocupado por…»; «El primer plugin de categorías no mostraba las páginas en el archivo y lo resolví con…»; «Cambié el pie, que traía enlaces de ejemplo». |
| 9:30–10:00 | Cierre | Portada | Resumen en una frase. |

## Lista de comprobación antes de entregar

- [ ] Se oye la voz y se entiende.
- [ ] Usuarios con su rol **y** grupos con sus miembros, en el panel.
- [ ] Columna de autor de las páginas, categorías en páginas y **demostración** de añadir una subcategoría.
- [ ] Copia existente y **cambio en directo** a semanal.
- [ ] **Todas** las opciones del menú, incluidos los tres niveles, sin 404 ni páginas vacías.
- [ ] Páginas con contenido: imagen y un enlace que se pulsa.
- [ ] Dificultades reales, no genéricas.
