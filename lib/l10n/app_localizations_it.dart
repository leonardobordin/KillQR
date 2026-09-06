// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'KillQR';

  @override
  String get bootstrapStarting => 'Preparazione dell’archiviazione locale…';

  @override
  String get bootstrapFailed => 'Impossibile aprire l’archiviazione locale.';

  @override
  String get bootstrapReady => 'Avvio completato';

  @override
  String get bootstrapDescription =>
      'La base Android è pronta per la fase successiva.';

  @override
  String get bootstrapErrorDetails =>
      'I tuoi dati locali restano privati. Prova a riaprire l’app.';

  @override
  String get retry => 'Riprova';

  @override
  String get scanner => 'Scansiona';

  @override
  String get history => 'Cronologia';

  @override
  String get create => 'Crea';

  @override
  String get settings => 'Impostazioni';

  @override
  String get scanTitle => 'Scansiona un codice';

  @override
  String get scanHint =>
      'Attiva questa opzione per scansionare più codici contemporaneamente.';

  @override
  String get cameraUnavailable => 'Fotocamera non disponibile';

  @override
  String get cameraPermission =>
      'L’accesso alla fotocamera è necessario solo durante la scansione.';

  @override
  String get openSettings => 'Apri impostazioni';

  @override
  String get importImage => 'Scegli immagine';

  @override
  String get importDocument => 'Scegli immagine o documento';

  @override
  String get imageFiles => 'Immagini';

  @override
  String get pdfFiles => 'File PDF';

  @override
  String get officeFiles => 'Documenti Office';

  @override
  String get scanningFile => 'Analisi del documento…';

  @override
  String get codeNotFoundInFile =>
      'In questo file non è stato trovato alcun QR Code o codice a barre.';

  @override
  String get fileScanFailed => 'Impossibile leggere il file selezionato.';

  @override
  String get fileTooLarge =>
      'Questo file è troppo grande per la scansione locale.';

  @override
  String get legacyOfficeUnsupported =>
      'I vecchi file Office non sono supportati. Usa DOCX, XLSX o PPTX.';

  @override
  String get unsupportedFileType =>
      'Questo tipo di file non è supportato per la scansione dei QR Code.';

  @override
  String get continuousScan => 'Scansione continua';

  @override
  String get continuousScanDescription =>
      'Continua a scansionare senza aprire ogni risultato.';

  @override
  String get importDocumentDescription =>
      'Leggi un codice da un’immagine, PDF o documento Office.';

  @override
  String get continuousModeTitle => 'Scansione continua';

  @override
  String get continuousModeExplanation =>
      'Quando è attiva, KillQR mantiene aperta la fotocamera e registra ogni nuovo codice senza aprire la pagina del risultato. L’intervallo tra le letture ripetute è controllato nelle Impostazioni.';

  @override
  String get multipleScanDescription =>
      'Trova più codici in una cattura della fotocamera.';

  @override
  String get multipleModeTitle => 'Scansione di più codici';

  @override
  String get multipleModeExplanation =>
      'Quando è attiva, KillQR analizza l’intero fotogramma della fotocamera e può restituire più codici da una cattura. Il riquadro centrale viene nascosto perché viene usato l’intero fotogramma.';

  @override
  String get doNotShowAgain => 'Non mostrare più';

  @override
  String get close => 'Chiudi';

  @override
  String get flashlight => 'Torcia';

  @override
  String get switchCamera => 'Cambia fotocamera';

  @override
  String get moreScannerActions => 'Altre azioni dello scanner';

  @override
  String get flashUnavailable =>
      'La torcia non è disponibile su questa fotocamera.';

  @override
  String get scanAreaSize => 'Area di scansione';

  @override
  String get resizeScanArea =>
      'Trascina l’angolo per ridimensionare l’area di scansione';

  @override
  String scanAreaValue(int percent) {
    return 'Area di scansione: $percent%';
  }

  @override
  String get fullCameraFrame => 'Fotogramma completo della fotocamera';

  @override
  String get zoom => 'Zoom';

  @override
  String zoomValue(String value) {
    return 'Zoom: ${value}x';
  }

  @override
  String get privateMode => 'Modalità privata';

  @override
  String get privateModeHint =>
      'I risultati di questa sessione non verranno salvati.';

  @override
  String get noHistory => 'Nessuna scansione';

  @override
  String get noHistoryHint => 'I risultati scansionati appariranno qui.';

  @override
  String get searchHistory => 'Cerca nella cronologia';

  @override
  String get favoritesOnly => 'Solo preferiti';

  @override
  String get allTypes => 'Tutti i tipi';

  @override
  String get clearHistory => 'Cancella cronologia';

  @override
  String get clearHistoryConfirm =>
      'Eliminare tutte le scansioni salvate? L’operazione non può essere annullata.';

  @override
  String get cancel => 'Annulla';

  @override
  String get delete => 'Elimina';

  @override
  String get save => 'Salva';

  @override
  String get saved => 'Salvato';

  @override
  String get favorite => 'Preferito';

  @override
  String get note => 'Nota';

  @override
  String get addNote => 'Aggiungi una nota';

  @override
  String get copy => 'Copia';

  @override
  String get copied => 'Copiato';

  @override
  String get share => 'Condividi';

  @override
  String get scanAgain => 'Scansiona di nuovo';

  @override
  String get details => 'Dettagli';

  @override
  String get value => 'Valore';

  @override
  String get format => 'Formato';

  @override
  String get type => 'Tipo';

  @override
  String get source => 'Origine';

  @override
  String get warning => 'Avviso';

  @override
  String get actions => 'Azioni';

  @override
  String get actionOpen => 'Apri';

  @override
  String get actionCall => 'Chiama';

  @override
  String get actionSendSms => 'Componi SMS';

  @override
  String get actionSendEmail => 'Componi e-mail';

  @override
  String get actionOpenMap => 'Apri mappa';

  @override
  String get actionSaveContact => 'Salva contatto';

  @override
  String get actionSaveEvent => 'Salva evento';

  @override
  String get actionWifiSettings => 'Impostazioni Wi-Fi';

  @override
  String get confirmExternalAction => 'Aprire un’altra app per continuare?';

  @override
  String get noAppFound => 'Non è stata trovata alcuna app compatibile.';

  @override
  String get generateTitle => 'Crea un codice';

  @override
  String get content => 'Contenuto';

  @override
  String get barcodeFormat => 'Formato del codice a barre';

  @override
  String get generate => 'Genera';

  @override
  String get generatedPreview => 'Anteprima';

  @override
  String get savePng => 'Salva PNG';

  @override
  String get savedToGallery => 'PNG salvato nella galleria.';

  @override
  String get galleryPermissionDenied =>
      'Consenti l’accesso alla memoria per salvare il PNG nella galleria.';

  @override
  String get gallerySaveFailed => 'Impossibile salvare il PNG nella galleria.';

  @override
  String get invalidContent => 'Inserisci il contenuto per generare un codice.';

  @override
  String get invalidBarcodeContent =>
      'Inserisci un contenuto valido per il formato selezionato.';

  @override
  String get generationFailed =>
      'Impossibile generare il codice. Controlla il contenuto.';

  @override
  String get unsupportedFormat =>
      'Questo formato non è disponibile per la scrittura.';

  @override
  String get importExport => 'Importa ed esporta';

  @override
  String get exportJson => 'Esporta JSON';

  @override
  String get exportCsv => 'Esporta CSV';

  @override
  String get importData => 'Importa dati';

  @override
  String get transferComplete => 'Trasferimento completato.';

  @override
  String get theme => 'Tema';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeLight => 'Chiaro';

  @override
  String get themeDark => 'Scuro';

  @override
  String get themeAmoled => 'AMOLED';

  @override
  String get accentColor => 'Colore principale';

  @override
  String get customAccentColor => 'Colore personalizzato';

  @override
  String get customAccentColorHint => 'Scegli qualsiasi colore RGB';

  @override
  String get hexColor => 'Colore HEX';

  @override
  String get red => 'Rosso';

  @override
  String get green => 'Verde';

  @override
  String get blue => 'Blu';

  @override
  String get invalidHexColor => 'Inserisci 6 cifre esadecimali.';

  @override
  String get applyColor => 'Applica';

  @override
  String get language => 'Lingua';

  @override
  String get languageSystem => 'Sistema';

  @override
  String get languagePortuguese => 'Portoghese (Brasile)';

  @override
  String get languageEnglish => 'Inglese';

  @override
  String get languageSpanish => 'Spagnolo';

  @override
  String get languageFrench => 'Francese';

  @override
  String get languageGerman => 'Tedesco';

  @override
  String get languageItalian => 'Italiano';

  @override
  String get languageJapanese => 'Giapponese';

  @override
  String get languageChineseSimplified => 'Cinese semplificato';

  @override
  String get saveAutomatically => 'Salva automaticamente i risultati';

  @override
  String get debounce => 'Ritardo della scansione continua';

  @override
  String get about => 'Informazioni';

  @override
  String get privacy => 'Privacy';

  @override
  String get aboutText =>
      'KillQR archivia le scansioni localmente e funziona offline per impostazione predefinita. La rete viene usata solo quando controlli gli aggiornamenti.';

  @override
  String get version => 'Versione 0.1.9 (build 10)';

  @override
  String get createdBy => 'Creato da Leonardo Silva Bordin';

  @override
  String get license => 'Licenza Apache-2.0';

  @override
  String get productSearch => 'Cerca prodotto';

  @override
  String get parserWarning =>
      'Non è stato possibile interpretare alcuni campi in modo sicuro.';

  @override
  String get typeText => 'Testo';

  @override
  String get typeUrl => 'URL';

  @override
  String get typePhone => 'Telefono';

  @override
  String get typeSms => 'SMS';

  @override
  String get typeEmail => 'E-mail';

  @override
  String get typeWifi => 'Wi-Fi';

  @override
  String get typeContact => 'Contatto';

  @override
  String get typeGeo => 'Posizione';

  @override
  String get typeEvent => 'Evento';

  @override
  String get typeProduct => 'Prodotto';

  @override
  String get typeUnknown => 'Sconosciuto';

  @override
  String get sourceCamera => 'Fotocamera';

  @override
  String get sourceImage => 'Immagine';

  @override
  String get sourceContinuous => 'Scansione continua';

  @override
  String get sourceImported => 'Importato';

  @override
  String get sourceGenerated => 'Generato';

  @override
  String get multipleScan => 'Attiva la scansione di più codici';

  @override
  String get continuousActive => 'CONTINUA';

  @override
  String get privateActive => 'PRIVATA';

  @override
  String get releaseNotesImprovementsTitle => 'Miglioramenti';

  @override
  String get releaseNotesBugFixesTitle => 'Correzioni di bug';

  @override
  String get releaseNotesTitle => 'Novità di KillQR';

  @override
  String updatedToVersion(String version) {
    return 'Aggiornato alla versione $version';
  }

  @override
  String get releaseNotesIntro => 'Modifiche di questa versione:';

  @override
  String get releaseNoteScanArea =>
      'Il ridimensionamento dell’area di scansione ora segue l’intero movimento del dito, senza richiedere trascinamenti ripetuti.';

  @override
  String get releaseNoteTopControls =>
      'Torcia, cambio fotocamera, importazione dei documenti e modalità dello scanner sono ora raggruppati nella barra superiore, con un menu aggiuntivo sugli schermi stretti.';

  @override
  String get releaseNoteZoom =>
      'Il controllo dello zoom è orizzontale in verticale e verticale a destra in orizzontale; le scansioni di un singolo codice analizzano solo l’area rettangolare selezionata.';

  @override
  String get releaseNoteModeHelp =>
      'Le modalità continua e più codici ora spiegano il loro funzionamento quando vengono attivate e possono essere nascoste definitivamente.';

  @override
  String get releaseNoteCameraOverlay =>
      'La maschera della fotocamera segue ora il bordo arrotondato dell’area di scansione, senza angoli chiari fuori dal contorno.';

  @override
  String get releaseNoteContinuousIndicator =>
      'L’indicatore della modalità continua ora si trova nell’angolo inferiore destro della fotocamera senza aumentare l’intestazione.';

  @override
  String get releaseNoteDocumentScan =>
      'La scansione di immagini, PDF e documenti Office funziona indipendentemente dalla modalità continua.';

  @override
  String get releaseNoteScannerHint =>
      'L’istruzione dello scanner ora spiega che questa opzione attiva la scansione di più codici contemporaneamente.';

  @override
  String get releaseNoteDocumentLoading =>
      'L’importazione dei file ora mostra una finestra con il messaggio “Analisi del documento…” durante la lettura.';

  @override
  String get releaseNoteVersioning =>
      'Queste note vengono mostrate una volta alla prima apertura dell’app dopo ogni aggiornamento.';

  @override
  String get releaseNoteQuickTile =>
      'Il tile di KillQR ora usa un’icona QR Code riconoscibile e il nome “Scansiona con KillQR”.';

  @override
  String get releaseNoteGitHubUpdates =>
      'Aggiunti controlli automatici e manuali delle release GitHub, con opzioni per posticipare o interrompere gli avvisi.';

  @override
  String get releaseNoteAccentSwitch =>
      'L’interruttore per più codici ora segue il colore principale personalizzato.';

  @override
  String get updates => 'Aggiornamenti';

  @override
  String get automaticUpdates => 'Controlla automaticamente gli aggiornamenti';

  @override
  String get automaticUpdatesHint =>
      'Controlla GitHub una volta al giorno e avvisa quando è disponibile una nuova versione.';

  @override
  String get checkForUpdates => 'Controlla aggiornamenti';

  @override
  String get checkForUpdatesHint =>
      'Controlla ora le release ufficiali di KillQR su GitHub.';

  @override
  String get checkingUpdates => 'Controllo degli aggiornamenti…';

  @override
  String get updateAvailable => 'Aggiornamento disponibile';

  @override
  String updateVersionAvailable(String version) {
    return 'La versione $version è disponibile.';
  }

  @override
  String get updateReleaseNotes => 'Note di rilascio';

  @override
  String get downloadUpdate => 'Scarica aggiornamento';

  @override
  String get remindLater => 'Ricordamelo più tardi';

  @override
  String get neverRemind => 'Non ricordarmelo più';

  @override
  String get noUpdatesAvailable => 'Stai già usando la versione più recente.';

  @override
  String get updateCheckFailed =>
      'Impossibile controllare gli aggiornamenti in questo momento.';

  @override
  String get updatesNotConfigured =>
      'Gli aggiornamenti automatici non sono configurati in questa build.';

  @override
  String get updateOpenFailed =>
      'Impossibile aprire il download dell’aggiornamento.';

  @override
  String get continueLabel => 'Continua';

  @override
  String get searchEngines => 'Motori di ricerca';

  @override
  String get addSearchEngine => 'Aggiungi motore di ricerca';

  @override
  String get editSearchEngine => 'Modifica motore di ricerca';

  @override
  String get searchEngineName => 'Nome';

  @override
  String get searchEngineTemplate => 'URL di ricerca';

  @override
  String get searchEngineTemplateHint =>
      'Usa il segnaposto CODE nel punto in cui deve comparire il codice.';

  @override
  String get invalidSearchTemplate =>
      'Usa un URL http(s) che contenga il segnaposto CODE.';

  @override
  String get noSearchEngines => 'Nessun motore di ricerca configurato.';

  @override
  String get enabled => 'Attivo';

  @override
  String get openAppSettings => 'Apri le impostazioni dell’app';

  @override
  String get searchProduct => 'Cerca prodotto';

  @override
  String get tags => 'Tag';

  @override
  String get addTag => 'Aggiungi tag';

  @override
  String get tagHint => 'Nome del tag';

  @override
  String get saveTags => 'Salva tag';

  @override
  String get noTags => 'Nessun tag';

  @override
  String get selectItems => 'Seleziona elementi';

  @override
  String get selectedItems => 'elementi selezionati';

  @override
  String get exportSelected => 'Esporta selezionati';

  @override
  String get shareSelected => 'Condividi selezionati';

  @override
  String get deleteSelected => 'Elimina selezionati';

  @override
  String get sourceFilter => 'Origine';

  @override
  String get allSources => 'Tutte le origini';

  @override
  String get formatFilter => 'Formato';

  @override
  String get allFormats => 'Tutti i formati';

  @override
  String get template => 'Modello di contenuto';

  @override
  String get templateText => 'Testo';

  @override
  String get templateUrl => 'URL';

  @override
  String get templateWifi => 'Wi-Fi';

  @override
  String get templateEmail => 'E-mail';

  @override
  String get templateSms => 'SMS';

  @override
  String get templateContact => 'Contatto';
}
