// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'KillQR';

  @override
  String get bootstrapStarting => 'Preparando el almacenamiento local…';

  @override
  String get bootstrapFailed => 'No se pudo abrir el almacenamiento local.';

  @override
  String get bootstrapReady => 'Inicialización lista';

  @override
  String get bootstrapDescription =>
      'La base de Android está lista para la siguiente fase.';

  @override
  String get bootstrapErrorDetails =>
      'Tus datos locales siguen siendo privados. Intenta abrir la aplicación de nuevo.';

  @override
  String get retry => 'Intentar de nuevo';

  @override
  String get scanner => 'Escanear';

  @override
  String get history => 'Historial';

  @override
  String get create => 'Crear';

  @override
  String get settings => 'Ajustes';

  @override
  String get scanTitle => 'Escanear un código';

  @override
  String get scanHint =>
      'Activa esta opción para escanear varios códigos al mismo tiempo.';

  @override
  String get cameraUnavailable => 'Cámara no disponible';

  @override
  String get cameraPermission =>
      'El acceso a la cámara solo se necesita durante el escaneo.';

  @override
  String get openSettings => 'Abrir ajustes';

  @override
  String get importImage => 'Elegir imagen';

  @override
  String get importDocument => 'Elegir imagen o documento';

  @override
  String get imageFiles => 'Imágenes';

  @override
  String get pdfFiles => 'Archivos PDF';

  @override
  String get officeFiles => 'Documentos de Office';

  @override
  String get scanningFile => 'Analizando documento…';

  @override
  String get codeNotFoundInFile =>
      'No se encontró ningún código QR ni código de barras en este archivo.';

  @override
  String get fileScanFailed => 'No se pudo leer el archivo seleccionado.';

  @override
  String get fileTooLarge =>
      'Este archivo es demasiado grande para escanearlo localmente.';

  @override
  String get legacyOfficeUnsupported =>
      'Los archivos de Office antiguos no son compatibles. Usa DOCX, XLSX o PPTX.';

  @override
  String get unsupportedFileType =>
      'Este tipo de archivo no es compatible con el escaneo de códigos QR.';

  @override
  String get continuousScan => 'Escaneo continuo';

  @override
  String get continuousScanDescription =>
      'Sigue escaneando sin abrir cada resultado.';

  @override
  String get importDocumentDescription =>
      'Lee un código de una imagen, PDF o documento de Office.';

  @override
  String get continuousModeTitle => 'Escaneo continuo';

  @override
  String get continuousModeExplanation =>
      'Al activarlo, KillQR mantiene la cámara abierta y registra cada código nuevo sin abrir la página de resultados. El intervalo entre lecturas repetidas se controla en Ajustes.';

  @override
  String get multipleScanDescription =>
      'Encuentra varios códigos en una captura de la cámara.';

  @override
  String get multipleModeTitle => 'Escaneo de varios códigos';

  @override
  String get multipleModeExplanation =>
      'Al activarlo, KillQR analiza todo el encuadre de la cámara y puede devolver varios códigos en una captura. El recuadro central se oculta porque se utiliza todo el encuadre.';

  @override
  String get doNotShowAgain => 'No volver a mostrar';

  @override
  String get close => 'Cerrar';

  @override
  String get flashlight => 'Linterna';

  @override
  String get switchCamera => 'Cambiar cámara';

  @override
  String get moreScannerActions => 'Más acciones del escáner';

  @override
  String get flashUnavailable =>
      'La linterna no está disponible en esta cámara.';

  @override
  String get scanAreaSize => 'Área de escaneo';

  @override
  String get resizeScanArea =>
      'Arrastra la esquina para cambiar el tamaño del área de escaneo';

  @override
  String scanAreaValue(int percent) {
    return 'Área de escaneo: $percent%';
  }

  @override
  String get fullCameraFrame => 'Todo el encuadre de la cámara';

  @override
  String get zoom => 'Zoom';

  @override
  String zoomValue(String value) {
    return 'Zoom: ${value}x';
  }

  @override
  String get privateMode => 'Modo privado';

  @override
  String get privateModeHint =>
      'Los resultados de esta sesión no se guardarán.';

  @override
  String get noHistory => 'Aún no hay escaneos';

  @override
  String get noHistoryHint => 'Los resultados escaneados aparecerán aquí.';

  @override
  String get searchHistory => 'Buscar en el historial';

  @override
  String get favoritesOnly => 'Solo favoritos';

  @override
  String get allTypes => 'Todos los tipos';

  @override
  String get clearHistory => 'Borrar historial';

  @override
  String get clearHistoryConfirm =>
      '¿Eliminar todos los escaneos guardados? Esta acción no se puede deshacer.';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Eliminar';

  @override
  String get save => 'Guardar';

  @override
  String get saved => 'Guardado';

  @override
  String get favorite => 'Favorito';

  @override
  String get note => 'Nota';

  @override
  String get addNote => 'Añadir una nota';

  @override
  String get copy => 'Copiar';

  @override
  String get copied => 'Copiado';

  @override
  String get share => 'Compartir';

  @override
  String get scanAgain => 'Escanear de nuevo';

  @override
  String get details => 'Detalles';

  @override
  String get value => 'Valor';

  @override
  String get format => 'Formato';

  @override
  String get type => 'Tipo';

  @override
  String get source => 'Origen';

  @override
  String get warning => 'Advertencia';

  @override
  String get actions => 'Acciones';

  @override
  String get actionOpen => 'Abrir';

  @override
  String get actionCall => 'Llamar';

  @override
  String get actionSendSms => 'Redactar SMS';

  @override
  String get actionSendEmail => 'Redactar correo';

  @override
  String get actionOpenMap => 'Abrir mapa';

  @override
  String get actionSaveContact => 'Guardar contacto';

  @override
  String get actionSaveEvent => 'Guardar evento';

  @override
  String get actionWifiSettings => 'Ajustes de Wi-Fi';

  @override
  String get confirmExternalAction => '¿Abrir otra aplicación para continuar?';

  @override
  String get noAppFound => 'No se encontró ninguna aplicación compatible.';

  @override
  String get generateTitle => 'Crear un código';

  @override
  String get content => 'Contenido';

  @override
  String get barcodeFormat => 'Formato del código de barras';

  @override
  String get generate => 'Generar';

  @override
  String get generatedPreview => 'Vista previa';

  @override
  String get savePng => 'Guardar PNG';

  @override
  String get savedToGallery => 'PNG guardado en la galería.';

  @override
  String get galleryPermissionDenied =>
      'Permite el acceso al almacenamiento para guardar el PNG en la galería.';

  @override
  String get gallerySaveFailed => 'No se pudo guardar el PNG en la galería.';

  @override
  String get invalidContent => 'Introduce contenido para generar un código.';

  @override
  String get invalidBarcodeContent =>
      'Introduce contenido válido para el formato seleccionado.';

  @override
  String get generationFailed =>
      'No se pudo generar el código. Comprueba el contenido.';

  @override
  String get unsupportedFormat =>
      'Este formato no está disponible para escribir.';

  @override
  String get importExport => 'Importar y exportar';

  @override
  String get exportJson => 'Exportar JSON';

  @override
  String get exportCsv => 'Exportar CSV';

  @override
  String get importData => 'Importar datos';

  @override
  String get transferComplete => 'Transferencia completada.';

  @override
  String get theme => 'Tema';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Oscuro';

  @override
  String get themeAmoled => 'AMOLED';

  @override
  String get accentColor => 'Color de acento';

  @override
  String get customAccentColor => 'Color personalizado';

  @override
  String get customAccentColorHint => 'Elige cualquier color RGB';

  @override
  String get hexColor => 'Color HEX';

  @override
  String get red => 'Rojo';

  @override
  String get green => 'Verde';

  @override
  String get blue => 'Azul';

  @override
  String get invalidHexColor => 'Introduce 6 dígitos hexadecimales.';

  @override
  String get applyColor => 'Aplicar';

  @override
  String get language => 'Idioma';

  @override
  String get languageSystem => 'Sistema';

  @override
  String get languagePortuguese => 'Portugués (Brasil)';

  @override
  String get languageEnglish => 'Inglés';

  @override
  String get languageSpanish => 'Español';

  @override
  String get languageFrench => 'Francés';

  @override
  String get languageGerman => 'Alemán';

  @override
  String get languageItalian => 'Italiano';

  @override
  String get languageJapanese => 'Japonés';

  @override
  String get languageChineseSimplified => 'Chino simplificado';

  @override
  String get saveAutomatically => 'Guardar resultados automáticamente';

  @override
  String get debounce => 'Retraso del escaneo continuo';

  @override
  String get about => 'Acerca de';

  @override
  String get privacy => 'Privacidad';

  @override
  String get aboutText =>
      'KillQR almacena los escaneos localmente y funciona sin conexión de forma predeterminada. La red solo se utiliza cuando buscas actualizaciones.';

  @override
  String get version => 'Versión 0.1.7 (compilación 8)';

  @override
  String get createdBy => 'Creado por Leonardo Silva Bordin';

  @override
  String get license => 'Licencia Apache-2.0';

  @override
  String get productSearch => 'Buscar producto';

  @override
  String get parserWarning =>
      'Algunos campos no se pudieron interpretar de forma segura.';

  @override
  String get typeText => 'Texto';

  @override
  String get typeUrl => 'URL';

  @override
  String get typePhone => 'Teléfono';

  @override
  String get typeSms => 'SMS';

  @override
  String get typeEmail => 'Correo electrónico';

  @override
  String get typeWifi => 'Wi-Fi';

  @override
  String get typeContact => 'Contacto';

  @override
  String get typeGeo => 'Ubicación';

  @override
  String get typeEvent => 'Evento';

  @override
  String get typeProduct => 'Producto';

  @override
  String get typeUnknown => 'Desconocido';

  @override
  String get sourceCamera => 'Cámara';

  @override
  String get sourceImage => 'Imagen';

  @override
  String get sourceContinuous => 'Escaneo continuo';

  @override
  String get sourceImported => 'Importado';

  @override
  String get sourceGenerated => 'Generado';

  @override
  String get multipleScan => 'Activar escaneo de varios códigos';

  @override
  String get continuousActive => 'CONTINUO';

  @override
  String get privateActive => 'PRIVADO';

  @override
  String get releaseNotesImprovementsTitle => 'Mejoras';

  @override
  String get releaseNotesBugFixesTitle => 'Correcciones de errores';

  @override
  String get releaseNotesTitle => 'Novedades de KillQR';

  @override
  String updatedToVersion(String version) {
    return 'Actualizado a la versión $version';
  }

  @override
  String get releaseNotesIntro => 'Cambios de esta versión:';

  @override
  String get releaseNoteScanArea =>
      'Ahora el área de escaneo de la cámara se puede redimensionar libremente desde la esquina inferior derecha, ajustando el ancho y el alto de forma independiente.';

  @override
  String get releaseNoteTopControls =>
      'La linterna, el cambio de cámara, la importación de documentos y los modos del escáner ahora están agrupados en la barra superior, con un menú adicional en pantallas estrechas.';

  @override
  String get releaseNoteZoom =>
      'Los escaneos de un solo código analizan solo el área rectangular seleccionada y el control compacto de zoom deja más espacio de cámara en diseños horizontales anchos.';

  @override
  String get releaseNoteModeHelp =>
      'Los modos continuo y de varios códigos ahora explican su funcionamiento al activarse y se pueden ocultar permanentemente.';

  @override
  String get releaseNoteCameraOverlay =>
      'Se eliminaron el antiguo botón flotante de varios códigos y el indicador del modo continuo sobre la vista de la cámara.';

  @override
  String get releaseNoteContinuousIndicator =>
      'El indicador del modo continuo ahora aparece en la esquina inferior derecha de la cámara sin aumentar el encabezado.';

  @override
  String get releaseNoteDocumentScan =>
      'El escaneo de imágenes, PDF y documentos de Office funciona de forma independiente del modo continuo.';

  @override
  String get releaseNoteScannerHint =>
      'La instrucción del escáner ahora explica que esta opción activa el escaneo de varios códigos al mismo tiempo.';

  @override
  String get releaseNoteDocumentLoading =>
      'Las importaciones de archivos ahora muestran una ventana con el mensaje “Analizando documento…” mientras se lee el archivo.';

  @override
  String get releaseNoteVersioning =>
      'Estas notas aparecen una vez la primera vez que se abre la aplicación después de cada actualización.';

  @override
  String get releaseNoteQuickTile =>
      'El tile de KillQR ahora utiliza un icono de código QR reconocible y el nombre “Escanear con KillQR”.';

  @override
  String get releaseNoteGitHubUpdates =>
      'Se añadieron comprobaciones automáticas y manuales de releases de GitHub, con opciones para posponer o detener los avisos.';

  @override
  String get releaseNoteAccentSwitch =>
      'El interruptor de varios códigos ahora sigue el color de acento personalizado.';

  @override
  String get updates => 'Actualizaciones';

  @override
  String get automaticUpdates => 'Buscar actualizaciones automáticamente';

  @override
  String get automaticUpdatesHint =>
      'Consulta GitHub una vez al día y te avisa cuando hay una nueva versión.';

  @override
  String get checkForUpdates => 'Buscar actualizaciones';

  @override
  String get checkForUpdatesHint =>
      'Comprueba ahora las releases oficiales de KillQR en GitHub.';

  @override
  String get checkingUpdates => 'Buscando actualizaciones…';

  @override
  String get updateAvailable => 'Actualización disponible';

  @override
  String updateVersionAvailable(String version) {
    return 'La versión $version está disponible.';
  }

  @override
  String get updateReleaseNotes => 'Notas de la versión';

  @override
  String get downloadUpdate => 'Descargar actualización';

  @override
  String get remindLater => 'Recordármelo más tarde';

  @override
  String get neverRemind => 'No volver a recordármelo';

  @override
  String get noUpdatesAvailable => 'Ya estás usando la versión más reciente.';

  @override
  String get updateCheckFailed =>
      'No se pudieron buscar actualizaciones ahora.';

  @override
  String get updatesNotConfigured =>
      'Las actualizaciones automáticas no están configuradas en esta compilación.';

  @override
  String get updateOpenFailed =>
      'No se pudo abrir la descarga de la actualización.';

  @override
  String get continueLabel => 'Continuar';

  @override
  String get searchEngines => 'Motores de búsqueda';

  @override
  String get addSearchEngine => 'Añadir motor de búsqueda';

  @override
  String get editSearchEngine => 'Editar motor de búsqueda';

  @override
  String get searchEngineName => 'Nombre';

  @override
  String get searchEngineTemplate => 'URL de búsqueda';

  @override
  String get searchEngineTemplateHint =>
      'Usa el marcador CODE donde deba ir el código.';

  @override
  String get invalidSearchTemplate =>
      'Usa una URL http(s) que contenga el marcador CODE.';

  @override
  String get noSearchEngines => 'No hay motores de búsqueda configurados.';

  @override
  String get enabled => 'Activado';

  @override
  String get openAppSettings => 'Abrir ajustes de la aplicación';

  @override
  String get searchProduct => 'Buscar producto';

  @override
  String get tags => 'Etiquetas';

  @override
  String get addTag => 'Añadir etiqueta';

  @override
  String get tagHint => 'Nombre de la etiqueta';

  @override
  String get saveTags => 'Guardar etiquetas';

  @override
  String get noTags => 'No hay etiquetas';

  @override
  String get selectItems => 'Seleccionar elementos';

  @override
  String get selectedItems => 'elementos seleccionados';

  @override
  String get exportSelected => 'Exportar seleccionados';

  @override
  String get shareSelected => 'Compartir seleccionados';

  @override
  String get deleteSelected => 'Eliminar seleccionados';

  @override
  String get sourceFilter => 'Origen';

  @override
  String get allSources => 'Todos los orígenes';

  @override
  String get formatFilter => 'Formato';

  @override
  String get allFormats => 'Todos los formatos';

  @override
  String get template => 'Plantilla de contenido';

  @override
  String get templateText => 'Texto';

  @override
  String get templateUrl => 'URL';

  @override
  String get templateWifi => 'Wi-Fi';

  @override
  String get templateEmail => 'Correo electrónico';

  @override
  String get templateSms => 'SMS';

  @override
  String get templateContact => 'Contacto';
}
