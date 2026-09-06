// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'KillQR';

  @override
  String get bootstrapStarting => 'Preparing local storage…';

  @override
  String get bootstrapFailed => 'Local storage could not be opened.';

  @override
  String get bootstrapReady => 'Bootstrap ready';

  @override
  String get bootstrapDescription =>
      'The Android foundation is ready for the next phase.';

  @override
  String get bootstrapErrorDetails =>
      'Your local data remains private. Try opening the app again.';

  @override
  String get retry => 'Try again';

  @override
  String get scanner => 'Scan';

  @override
  String get history => 'History';

  @override
  String get create => 'Create';

  @override
  String get settings => 'Settings';

  @override
  String get scanTitle => 'Scan a code';

  @override
  String get scanHint =>
      'Enable this option to scan multiple codes at the same time.';

  @override
  String get cameraUnavailable => 'Camera unavailable';

  @override
  String get cameraPermission => 'Camera access is needed only while scanning.';

  @override
  String get openSettings => 'Open settings';

  @override
  String get importImage => 'Choose image';

  @override
  String get importDocument => 'Choose image or document';

  @override
  String get imageFiles => 'Images';

  @override
  String get pdfFiles => 'PDF files';

  @override
  String get officeFiles => 'Office documents';

  @override
  String get scanningFile => 'Analyzing document…';

  @override
  String get codeNotFoundInFile =>
      'No QR code or barcode was found in this file.';

  @override
  String get fileScanFailed => 'Could not read the selected file.';

  @override
  String get fileTooLarge => 'This file is too large to scan locally.';

  @override
  String get legacyOfficeUnsupported =>
      'Legacy Office files are not supported. Use DOCX, XLSX or PPTX.';

  @override
  String get unsupportedFileType =>
      'This file type is not supported for QR scanning.';

  @override
  String get continuousScan => 'Continuous scan';

  @override
  String get privateMode => 'Private mode';

  @override
  String get privateModeHint => 'Results from this session will not be saved.';

  @override
  String get noHistory => 'No scans yet';

  @override
  String get noHistoryHint => 'Scanned results will appear here.';

  @override
  String get searchHistory => 'Search history';

  @override
  String get favoritesOnly => 'Favorites only';

  @override
  String get allTypes => 'All types';

  @override
  String get clearHistory => 'Clear history';

  @override
  String get clearHistoryConfirm =>
      'Delete every saved scan? This cannot be undone.';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get save => 'Save';

  @override
  String get saved => 'Saved';

  @override
  String get favorite => 'Favorite';

  @override
  String get note => 'Note';

  @override
  String get addNote => 'Add a note';

  @override
  String get copy => 'Copy';

  @override
  String get copied => 'Copied';

  @override
  String get share => 'Share';

  @override
  String get scanAgain => 'Scan again';

  @override
  String get details => 'Details';

  @override
  String get value => 'Value';

  @override
  String get format => 'Format';

  @override
  String get type => 'Type';

  @override
  String get source => 'Source';

  @override
  String get warning => 'Warning';

  @override
  String get actions => 'Actions';

  @override
  String get actionOpen => 'Open';

  @override
  String get actionCall => 'Call';

  @override
  String get actionSendSms => 'Compose SMS';

  @override
  String get actionSendEmail => 'Compose email';

  @override
  String get actionOpenMap => 'Open map';

  @override
  String get actionSaveContact => 'Save contact';

  @override
  String get actionSaveEvent => 'Save event';

  @override
  String get actionWifiSettings => 'Wi-Fi settings';

  @override
  String get confirmExternalAction => 'Open another app to continue?';

  @override
  String get noAppFound => 'No compatible app was found.';

  @override
  String get generateTitle => 'Create a code';

  @override
  String get content => 'Content';

  @override
  String get barcodeFormat => 'Barcode format';

  @override
  String get generate => 'Generate';

  @override
  String get generatedPreview => 'Preview';

  @override
  String get savePng => 'Save PNG';

  @override
  String get savedToGallery => 'PNG saved to the gallery.';

  @override
  String get galleryPermissionDenied =>
      'Allow storage access to save the PNG to the gallery.';

  @override
  String get gallerySaveFailed => 'Could not save the PNG to the gallery.';

  @override
  String get invalidContent => 'Enter content to generate a code.';

  @override
  String get invalidBarcodeContent =>
      'Enter content valid for the selected format.';

  @override
  String get generationFailed =>
      'The code could not be generated. Check the content.';

  @override
  String get unsupportedFormat => 'This format is not available for writing.';

  @override
  String get importExport => 'Import and export';

  @override
  String get exportJson => 'Export JSON';

  @override
  String get exportCsv => 'Export CSV';

  @override
  String get importData => 'Import data';

  @override
  String get transferComplete => 'Transfer completed.';

  @override
  String get theme => 'Theme';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeAmoled => 'AMOLED';

  @override
  String get accentColor => 'Accent color';

  @override
  String get customAccentColor => 'Custom color';

  @override
  String get customAccentColorHint => 'Choose any RGB color';

  @override
  String get hexColor => 'HEX color';

  @override
  String get red => 'Red';

  @override
  String get green => 'Green';

  @override
  String get blue => 'Blue';

  @override
  String get invalidHexColor => 'Enter 6 hexadecimal digits.';

  @override
  String get applyColor => 'Apply';

  @override
  String get language => 'Language';

  @override
  String get languageSystem => 'System';

  @override
  String get languagePortuguese => 'Português (Brasil)';

  @override
  String get languageEnglish => 'English';

  @override
  String get saveAutomatically => 'Save results automatically';

  @override
  String get debounce => 'Continuous scan delay';

  @override
  String get about => 'About';

  @override
  String get privacy => 'Privacy';

  @override
  String get aboutText =>
      'KillQR stores scans locally and works offline by default. Network access is used only when you check for updates.';

  @override
  String get version => 'Version 0.1.5 (build 6)';

  @override
  String get license => 'Apache-2.0 license';

  @override
  String get productSearch => 'Search product';

  @override
  String get parserWarning => 'Some fields could not be interpreted safely.';

  @override
  String get typeText => 'Text';

  @override
  String get typeUrl => 'URL';

  @override
  String get typePhone => 'Phone';

  @override
  String get typeSms => 'SMS';

  @override
  String get typeEmail => 'Email';

  @override
  String get typeWifi => 'Wi-Fi';

  @override
  String get typeContact => 'Contact';

  @override
  String get typeGeo => 'Location';

  @override
  String get typeEvent => 'Event';

  @override
  String get typeProduct => 'Product';

  @override
  String get typeUnknown => 'Unknown';

  @override
  String get sourceCamera => 'Camera';

  @override
  String get sourceImage => 'Image';

  @override
  String get sourceContinuous => 'Continuous scan';

  @override
  String get sourceImported => 'Imported';

  @override
  String get sourceGenerated => 'Generated';

  @override
  String get multipleScan => 'Enable multiple-code scanning';

  @override
  String get continuousActive => 'CONTINUOUS';

  @override
  String get privateActive => 'PRIVATE';

  @override
  String get releaseNotesImprovementsTitle => 'Improvements';

  @override
  String get releaseNotesBugFixesTitle => 'Bug fixes';

  @override
  String get releaseNotesTitle => 'What’s new in KillQR';

  @override
  String updatedToVersion(String version) {
    return 'Updated to version $version';
  }

  @override
  String get releaseNotesIntro => 'Changes in this version:';

  @override
  String get releaseNoteContinuousIndicator =>
      'The continuous-mode indicator now sits in the camera’s lower-right corner without increasing the header.';

  @override
  String get releaseNoteDocumentScan =>
      'Image, PDF and Office document scanning now works independently from continuous mode.';

  @override
  String get releaseNoteScannerHint =>
      'The scanner instruction now explains that this option enables scanning multiple codes at the same time.';

  @override
  String get releaseNoteDocumentLoading =>
      'File imports now show a loading window saying “Analyzing document…” while the file is being read.';

  @override
  String get releaseNoteVersioning =>
      'These notes appear once the first time the app opens after each update.';

  @override
  String get releaseNoteQuickTile =>
      'The KillQR tile now uses a recognizable QR Code icon and the name “Scan with KillQR”.';

  @override
  String get releaseNoteGitHubUpdates =>
      'Added automatic and manual GitHub release checks, with options to snooze or stop update reminders.';

  @override
  String get releaseNoteAccentSwitch =>
      'The multiple-code switch now follows the custom accent color.';

  @override
  String get updates => 'Updates';

  @override
  String get automaticUpdates => 'Check for updates automatically';

  @override
  String get automaticUpdatesHint =>
      'Checks GitHub once a day and alerts you when a new version is available.';

  @override
  String get checkForUpdates => 'Check for updates';

  @override
  String get checkForUpdatesHint =>
      'Check the official KillQR releases on GitHub now.';

  @override
  String get checkingUpdates => 'Checking for updates…';

  @override
  String get updateAvailable => 'Update available';

  @override
  String updateVersionAvailable(String version) {
    return 'Version $version is available.';
  }

  @override
  String get updateReleaseNotes => 'Release notes';

  @override
  String get downloadUpdate => 'Download update';

  @override
  String get remindLater => 'Remind me later';

  @override
  String get neverRemind => 'Don\'t remind me again';

  @override
  String get noUpdatesAvailable => 'You are using the latest version.';

  @override
  String get updateCheckFailed => 'Could not check for updates right now.';

  @override
  String get updatesNotConfigured =>
      'Automatic updates are not configured in this build.';

  @override
  String get updateOpenFailed => 'Could not open the update download.';

  @override
  String get continueLabel => 'Continue';

  @override
  String get searchEngines => 'Search engines';

  @override
  String get addSearchEngine => 'Add search engine';

  @override
  String get editSearchEngine => 'Edit search engine';

  @override
  String get searchEngineName => 'Name';

  @override
  String get searchEngineTemplate => 'Search URL';

  @override
  String get searchEngineTemplateHint =>
      'Use the CODE marker where the code should go.';

  @override
  String get invalidSearchTemplate =>
      'Use an http(s) URL containing the CODE marker.';

  @override
  String get noSearchEngines => 'No search engines configured.';

  @override
  String get enabled => 'Enabled';

  @override
  String get openAppSettings => 'Open app settings';

  @override
  String get searchProduct => 'Search product';

  @override
  String get tags => 'Tags';

  @override
  String get addTag => 'Add tag';

  @override
  String get tagHint => 'Tag name';

  @override
  String get saveTags => 'Save tags';

  @override
  String get noTags => 'No tags';

  @override
  String get selectItems => 'Select items';

  @override
  String get selectedItems => 'items selected';

  @override
  String get exportSelected => 'Export selected';

  @override
  String get shareSelected => 'Share selected';

  @override
  String get deleteSelected => 'Delete selected';

  @override
  String get sourceFilter => 'Source';

  @override
  String get allSources => 'All sources';

  @override
  String get formatFilter => 'Format';

  @override
  String get allFormats => 'All formats';

  @override
  String get template => 'Content template';

  @override
  String get templateText => 'Text';

  @override
  String get templateUrl => 'URL';

  @override
  String get templateWifi => 'Wi-Fi';

  @override
  String get templateEmail => 'Email';

  @override
  String get templateSms => 'SMS';

  @override
  String get templateContact => 'Contact';
}
