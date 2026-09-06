// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'KillQR';

  @override
  String get bootstrapStarting => 'Lokalen Speicher wird vorbereitet…';

  @override
  String get bootstrapFailed =>
      'Der lokale Speicher konnte nicht geöffnet werden.';

  @override
  String get bootstrapReady => 'Startvorgang abgeschlossen';

  @override
  String get bootstrapDescription =>
      'Die Android-Grundlage ist für die nächste Phase bereit.';

  @override
  String get bootstrapErrorDetails =>
      'Deine lokalen Daten bleiben privat. Versuche, die App erneut zu öffnen.';

  @override
  String get retry => 'Erneut versuchen';

  @override
  String get scanner => 'Scannen';

  @override
  String get history => 'Verlauf';

  @override
  String get create => 'Erstellen';

  @override
  String get settings => 'Einstellungen';

  @override
  String get scanTitle => 'Code scannen';

  @override
  String get scanHint =>
      'Aktiviere diese Option, um mehrere Codes gleichzeitig zu scannen.';

  @override
  String get cameraUnavailable => 'Kamera nicht verfügbar';

  @override
  String get cameraPermission =>
      'Der Kamerazugriff wird nur beim Scannen benötigt.';

  @override
  String get openSettings => 'Einstellungen öffnen';

  @override
  String get importImage => 'Bild auswählen';

  @override
  String get importDocument => 'Bild oder Dokument auswählen';

  @override
  String get imageFiles => 'Bilder';

  @override
  String get pdfFiles => 'PDF-Dateien';

  @override
  String get officeFiles => 'Office-Dokumente';

  @override
  String get scanningFile => 'Dokument wird analysiert…';

  @override
  String get codeNotFoundInFile =>
      'In dieser Datei wurde kein QR-Code oder Barcode gefunden.';

  @override
  String get fileScanFailed =>
      'Die ausgewählte Datei konnte nicht gelesen werden.';

  @override
  String get fileTooLarge => 'Diese Datei ist für die lokale Analyse zu groß.';

  @override
  String get legacyOfficeUnsupported =>
      'Ältere Office-Dateien werden nicht unterstützt. Verwende DOCX, XLSX oder PPTX.';

  @override
  String get unsupportedFileType =>
      'Dieser Dateityp wird für das Scannen von QR-Codes nicht unterstützt.';

  @override
  String get continuousScan => 'Kontinuierliches Scannen';

  @override
  String get continuousScanDescription =>
      'Scanne weiter, ohne jedes Ergebnis zu öffnen.';

  @override
  String get importDocumentDescription =>
      'Lies einen Code aus einem Bild, PDF oder Office-Dokument.';

  @override
  String get continuousModeTitle => 'Kontinuierliches Scannen';

  @override
  String get continuousModeExplanation =>
      'Wenn aktiviert, hält KillQR die Kamera geöffnet und speichert jeden neuen Code, ohne eine Ergebnisseite zu öffnen. Der Abstand zwischen wiederholten Scans wird in den Einstellungen festgelegt.';

  @override
  String get multipleScanDescription =>
      'Finde mehrere Codes in einer Kameraaufnahme.';

  @override
  String get multipleModeTitle => 'Mehrere Codes scannen';

  @override
  String get multipleModeExplanation =>
      'Wenn aktiviert, analysiert KillQR das gesamte Kamerabild und kann mehrere Codes aus einer Aufnahme zurückgeben. Das mittlere Scanfenster wird ausgeblendet, weil das gesamte Bild verwendet wird.';

  @override
  String get doNotShowAgain => 'Nicht mehr anzeigen';

  @override
  String get close => 'Schließen';

  @override
  String get flashlight => 'Taschenlampe';

  @override
  String get switchCamera => 'Kamera wechseln';

  @override
  String get moreScannerActions => 'Weitere Scanner-Aktionen';

  @override
  String get flashUnavailable =>
      'Die Taschenlampe ist bei dieser Kamera nicht verfügbar.';

  @override
  String get scanAreaSize => 'Scanbereich';

  @override
  String scanAreaValue(int percent) {
    return 'Scanbereich: $percent %';
  }

  @override
  String get fullCameraFrame => 'Gesamtes Kamerabild';

  @override
  String get zoom => 'Zoom';

  @override
  String zoomValue(String value) {
    return 'Zoom: ${value}x';
  }

  @override
  String get privateMode => 'Privater Modus';

  @override
  String get privateModeHint =>
      'Ergebnisse dieser Sitzung werden nicht gespeichert.';

  @override
  String get noHistory => 'Noch keine Scans';

  @override
  String get noHistoryHint => 'Gescannte Ergebnisse werden hier angezeigt.';

  @override
  String get searchHistory => 'Verlauf durchsuchen';

  @override
  String get favoritesOnly => 'Nur Favoriten';

  @override
  String get allTypes => 'Alle Typen';

  @override
  String get clearHistory => 'Verlauf löschen';

  @override
  String get clearHistoryConfirm =>
      'Alle gespeicherten Scans löschen? Dies kann nicht rückgängig gemacht werden.';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get delete => 'Löschen';

  @override
  String get save => 'Speichern';

  @override
  String get saved => 'Gespeichert';

  @override
  String get favorite => 'Favorit';

  @override
  String get note => 'Notiz';

  @override
  String get addNote => 'Notiz hinzufügen';

  @override
  String get copy => 'Kopieren';

  @override
  String get copied => 'Kopiert';

  @override
  String get share => 'Teilen';

  @override
  String get scanAgain => 'Erneut scannen';

  @override
  String get details => 'Details';

  @override
  String get value => 'Wert';

  @override
  String get format => 'Format';

  @override
  String get type => 'Typ';

  @override
  String get source => 'Quelle';

  @override
  String get warning => 'Warnung';

  @override
  String get actions => 'Aktionen';

  @override
  String get actionOpen => 'Öffnen';

  @override
  String get actionCall => 'Anrufen';

  @override
  String get actionSendSms => 'SMS verfassen';

  @override
  String get actionSendEmail => 'E-Mail verfassen';

  @override
  String get actionOpenMap => 'Karte öffnen';

  @override
  String get actionSaveContact => 'Kontakt speichern';

  @override
  String get actionSaveEvent => 'Termin speichern';

  @override
  String get actionWifiSettings => 'WLAN-Einstellungen';

  @override
  String get confirmExternalAction => 'Andere App zum Fortfahren öffnen?';

  @override
  String get noAppFound => 'Keine kompatible App gefunden.';

  @override
  String get generateTitle => 'Code erstellen';

  @override
  String get content => 'Inhalt';

  @override
  String get barcodeFormat => 'Barcode-Format';

  @override
  String get generate => 'Generieren';

  @override
  String get generatedPreview => 'Vorschau';

  @override
  String get savePng => 'PNG speichern';

  @override
  String get savedToGallery => 'PNG wurde in der Galerie gespeichert.';

  @override
  String get galleryPermissionDenied =>
      'Erlaube den Speicherzugriff, um das PNG in der Galerie zu speichern.';

  @override
  String get gallerySaveFailed =>
      'Das PNG konnte nicht in der Galerie gespeichert werden.';

  @override
  String get invalidContent => 'Gib Inhalt ein, um einen Code zu erstellen.';

  @override
  String get invalidBarcodeContent =>
      'Gib gültigen Inhalt für das ausgewählte Format ein.';

  @override
  String get generationFailed =>
      'Der Code konnte nicht erstellt werden. Überprüfe den Inhalt.';

  @override
  String get unsupportedFormat =>
      'Dieses Format ist zum Schreiben nicht verfügbar.';

  @override
  String get importExport => 'Importieren und exportieren';

  @override
  String get exportJson => 'JSON exportieren';

  @override
  String get exportCsv => 'CSV exportieren';

  @override
  String get importData => 'Daten importieren';

  @override
  String get transferComplete => 'Übertragung abgeschlossen.';

  @override
  String get theme => 'Design';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Hell';

  @override
  String get themeDark => 'Dunkel';

  @override
  String get themeAmoled => 'AMOLED';

  @override
  String get accentColor => 'Akzentfarbe';

  @override
  String get customAccentColor => 'Benutzerdefinierte Farbe';

  @override
  String get customAccentColorHint => 'Wähle eine beliebige RGB-Farbe';

  @override
  String get hexColor => 'HEX-Farbe';

  @override
  String get red => 'Rot';

  @override
  String get green => 'Grün';

  @override
  String get blue => 'Blau';

  @override
  String get invalidHexColor => 'Gib 6 Hexadezimalziffern ein.';

  @override
  String get applyColor => 'Anwenden';

  @override
  String get language => 'Sprache';

  @override
  String get languageSystem => 'System';

  @override
  String get languagePortuguese => 'Portugiesisch (Brasilien)';

  @override
  String get languageEnglish => 'Englisch';

  @override
  String get languageSpanish => 'Spanisch';

  @override
  String get languageFrench => 'Französisch';

  @override
  String get languageGerman => 'Deutsch';

  @override
  String get languageItalian => 'Italienisch';

  @override
  String get languageJapanese => 'Japanisch';

  @override
  String get languageChineseSimplified => 'Vereinfachtes Chinesisch';

  @override
  String get saveAutomatically => 'Ergebnisse automatisch speichern';

  @override
  String get debounce => 'Verzögerung beim kontinuierlichen Scannen';

  @override
  String get about => 'Über';

  @override
  String get privacy => 'Datenschutz';

  @override
  String get aboutText =>
      'KillQR speichert Scans standardmäßig lokal und funktioniert offline. Netzwerkzugriff wird nur bei der Suche nach Updates verwendet.';

  @override
  String get version => 'Version 0.1.6 (Build 7)';

  @override
  String get createdBy => 'Erstellt von Leonardo Silva Bordin';

  @override
  String get license => 'Apache-2.0-Lizenz';

  @override
  String get productSearch => 'Produkt suchen';

  @override
  String get parserWarning =>
      'Einige Felder konnten nicht sicher interpretiert werden.';

  @override
  String get typeText => 'Text';

  @override
  String get typeUrl => 'URL';

  @override
  String get typePhone => 'Telefon';

  @override
  String get typeSms => 'SMS';

  @override
  String get typeEmail => 'E-Mail';

  @override
  String get typeWifi => 'WLAN';

  @override
  String get typeContact => 'Kontakt';

  @override
  String get typeGeo => 'Ort';

  @override
  String get typeEvent => 'Termin';

  @override
  String get typeProduct => 'Produkt';

  @override
  String get typeUnknown => 'Unbekannt';

  @override
  String get sourceCamera => 'Kamera';

  @override
  String get sourceImage => 'Bild';

  @override
  String get sourceContinuous => 'Kontinuierliches Scannen';

  @override
  String get sourceImported => 'Importiert';

  @override
  String get sourceGenerated => 'Generiert';

  @override
  String get multipleScan => 'Scannen mehrerer Codes aktivieren';

  @override
  String get continuousActive => 'KONTINUIERLICH';

  @override
  String get privateActive => 'PRIVAT';

  @override
  String get releaseNotesImprovementsTitle => 'Verbesserungen';

  @override
  String get releaseNotesBugFixesTitle => 'Fehlerbehebungen';

  @override
  String get releaseNotesTitle => 'Neu in KillQR';

  @override
  String updatedToVersion(String version) {
    return 'Auf Version $version aktualisiert';
  }

  @override
  String get releaseNotesIntro => 'Änderungen in dieser Version:';

  @override
  String get releaseNoteScanArea =>
      'Der Scanbereich der Kamera kann jetzt angepasst werden; beim Scannen eines einzelnen Codes wird nur der ausgewählte Bereich analysiert.';

  @override
  String get releaseNoteTopControls =>
      'Taschenlampe, Kamerwechsel, Dokumentimport und Scanmodi sind jetzt in der oberen Leiste gruppiert; auf schmalen Bildschirmen gibt es ein Überlaufmenü.';

  @override
  String get releaseNoteZoom =>
      'Am unteren Rand der Kameravorschau gibt es jetzt Regler für Scanbereich und Kamerazoom.';

  @override
  String get releaseNoteModeHelp =>
      'Die Modi für kontinuierliches Scannen und mehrere Codes erklären jetzt beim Aktivieren ihre Funktion und können dauerhaft ausgeblendet werden.';

  @override
  String get releaseNoteCameraOverlay =>
      'Der alte schwebende Schalter für mehrere Codes und die Statusanzeige des kontinuierlichen Modus wurden aus der Kameravorschau entfernt.';

  @override
  String get releaseNoteContinuousIndicator =>
      'Die Anzeige des kontinuierlichen Modus befindet sich jetzt unten rechts in der Kamera, ohne die Kopfzeile zu vergrößern.';

  @override
  String get releaseNoteDocumentScan =>
      'Das Scannen von Bildern, PDFs und Office-Dokumenten funktioniert unabhängig vom kontinuierlichen Modus.';

  @override
  String get releaseNoteScannerHint =>
      'Der Scanner-Hinweis erklärt jetzt, dass diese Option das gleichzeitige Scannen mehrerer Codes aktiviert.';

  @override
  String get releaseNoteDocumentLoading =>
      'Beim Importieren von Dateien wird während des Lesens ein Fenster mit „Dokument wird analysiert…“ angezeigt.';

  @override
  String get releaseNoteVersioning =>
      'Diese Hinweise werden nach jedem Update beim ersten Öffnen der App einmal angezeigt.';

  @override
  String get releaseNoteQuickTile =>
      'Das KillQR-Kachel-Symbol verwendet jetzt ein erkennbares QR-Code-Symbol und den Namen „Mit KillQR scannen“.';

  @override
  String get releaseNoteGitHubUpdates =>
      'Automatische und manuelle GitHub-Release-Prüfungen mit Optionen zum Verschieben oder Beenden von Update-Hinweisen wurden hinzugefügt.';

  @override
  String get releaseNoteAccentSwitch =>
      'Der Schalter für mehrere Codes folgt jetzt der benutzerdefinierten Akzentfarbe.';

  @override
  String get updates => 'Updates';

  @override
  String get automaticUpdates => 'Automatisch nach Updates suchen';

  @override
  String get automaticUpdatesHint =>
      'Prüft einmal täglich GitHub und benachrichtigt dich, wenn eine neue Version verfügbar ist.';

  @override
  String get checkForUpdates => 'Nach Updates suchen';

  @override
  String get checkForUpdatesHint =>
      'Jetzt die offiziellen KillQR-Releases auf GitHub prüfen.';

  @override
  String get checkingUpdates => 'Suche nach Updates…';

  @override
  String get updateAvailable => 'Update verfügbar';

  @override
  String updateVersionAvailable(String version) {
    return 'Version $version ist verfügbar.';
  }

  @override
  String get updateReleaseNotes => 'Versionshinweise';

  @override
  String get downloadUpdate => 'Update herunterladen';

  @override
  String get remindLater => 'Später erinnern';

  @override
  String get neverRemind => 'Nicht mehr erinnern';

  @override
  String get noUpdatesAvailable => 'Du verwendest bereits die neueste Version.';

  @override
  String get updateCheckFailed =>
      'Updates konnten gerade nicht gesucht werden.';

  @override
  String get updatesNotConfigured =>
      'Automatische Updates sind in diesem Build nicht konfiguriert.';

  @override
  String get updateOpenFailed =>
      'Der Update-Download konnte nicht geöffnet werden.';

  @override
  String get continueLabel => 'Weiter';

  @override
  String get searchEngines => 'Suchmaschinen';

  @override
  String get addSearchEngine => 'Suchmaschine hinzufügen';

  @override
  String get editSearchEngine => 'Suchmaschine bearbeiten';

  @override
  String get searchEngineName => 'Name';

  @override
  String get searchEngineTemplate => 'Such-URL';

  @override
  String get searchEngineTemplateHint =>
      'Verwende den CODE-Platzhalter an der Stelle des Codes.';

  @override
  String get invalidSearchTemplate =>
      'Verwende eine http(s)-URL mit dem CODE-Platzhalter.';

  @override
  String get noSearchEngines => 'Keine Suchmaschinen konfiguriert.';

  @override
  String get enabled => 'Aktiviert';

  @override
  String get openAppSettings => 'App-Einstellungen öffnen';

  @override
  String get searchProduct => 'Produkt suchen';

  @override
  String get tags => 'Tags';

  @override
  String get addTag => 'Tag hinzufügen';

  @override
  String get tagHint => 'Tag-Name';

  @override
  String get saveTags => 'Tags speichern';

  @override
  String get noTags => 'Keine Tags';

  @override
  String get selectItems => 'Elemente auswählen';

  @override
  String get selectedItems => 'Elemente ausgewählt';

  @override
  String get exportSelected => 'Auswahl exportieren';

  @override
  String get shareSelected => 'Auswahl teilen';

  @override
  String get deleteSelected => 'Auswahl löschen';

  @override
  String get sourceFilter => 'Quelle';

  @override
  String get allSources => 'Alle Quellen';

  @override
  String get formatFilter => 'Format';

  @override
  String get allFormats => 'Alle Formate';

  @override
  String get template => 'Inhaltsvorlage';

  @override
  String get templateText => 'Text';

  @override
  String get templateUrl => 'URL';

  @override
  String get templateWifi => 'WLAN';

  @override
  String get templateEmail => 'E-Mail';

  @override
  String get templateSms => 'SMS';

  @override
  String get templateContact => 'Kontakt';
}
