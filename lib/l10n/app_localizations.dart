import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
    Locale('ja'),
    Locale('pt'),
    Locale('pt', 'BR'),
    Locale('zh'),
    Locale('zh', 'CN'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'KillQR'**
  String get appTitle;

  /// No description provided for @bootstrapStarting.
  ///
  /// In en, this message translates to:
  /// **'Preparing local storage…'**
  String get bootstrapStarting;

  /// No description provided for @bootstrapFailed.
  ///
  /// In en, this message translates to:
  /// **'Local storage could not be opened.'**
  String get bootstrapFailed;

  /// No description provided for @bootstrapReady.
  ///
  /// In en, this message translates to:
  /// **'Bootstrap ready'**
  String get bootstrapReady;

  /// No description provided for @bootstrapDescription.
  ///
  /// In en, this message translates to:
  /// **'The Android foundation is ready for the next phase.'**
  String get bootstrapDescription;

  /// No description provided for @bootstrapErrorDetails.
  ///
  /// In en, this message translates to:
  /// **'Your local data remains private. Try opening the app again.'**
  String get bootstrapErrorDetails;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get retry;

  /// No description provided for @scanner.
  ///
  /// In en, this message translates to:
  /// **'Scan'**
  String get scanner;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @scanTitle.
  ///
  /// In en, this message translates to:
  /// **'Scan a code'**
  String get scanTitle;

  /// No description provided for @scanHint.
  ///
  /// In en, this message translates to:
  /// **'Enable this option to scan multiple codes at the same time.'**
  String get scanHint;

  /// No description provided for @cameraUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Camera unavailable'**
  String get cameraUnavailable;

  /// No description provided for @cameraPermission.
  ///
  /// In en, this message translates to:
  /// **'Camera access is needed only while scanning.'**
  String get cameraPermission;

  /// No description provided for @openSettings.
  ///
  /// In en, this message translates to:
  /// **'Open settings'**
  String get openSettings;

  /// No description provided for @importImage.
  ///
  /// In en, this message translates to:
  /// **'Choose image'**
  String get importImage;

  /// No description provided for @importDocument.
  ///
  /// In en, this message translates to:
  /// **'Choose image or document'**
  String get importDocument;

  /// No description provided for @imageFiles.
  ///
  /// In en, this message translates to:
  /// **'Images'**
  String get imageFiles;

  /// No description provided for @pdfFiles.
  ///
  /// In en, this message translates to:
  /// **'PDF files'**
  String get pdfFiles;

  /// No description provided for @officeFiles.
  ///
  /// In en, this message translates to:
  /// **'Office documents'**
  String get officeFiles;

  /// No description provided for @scanningFile.
  ///
  /// In en, this message translates to:
  /// **'Analyzing document…'**
  String get scanningFile;

  /// No description provided for @codeNotFoundInFile.
  ///
  /// In en, this message translates to:
  /// **'No QR code or barcode was found in this file.'**
  String get codeNotFoundInFile;

  /// No description provided for @fileScanFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not read the selected file.'**
  String get fileScanFailed;

  /// No description provided for @fileTooLarge.
  ///
  /// In en, this message translates to:
  /// **'This file is too large to scan locally.'**
  String get fileTooLarge;

  /// No description provided for @legacyOfficeUnsupported.
  ///
  /// In en, this message translates to:
  /// **'Legacy Office files are not supported. Use DOCX, XLSX or PPTX.'**
  String get legacyOfficeUnsupported;

  /// No description provided for @unsupportedFileType.
  ///
  /// In en, this message translates to:
  /// **'This file type is not supported for QR scanning.'**
  String get unsupportedFileType;

  /// No description provided for @continuousScan.
  ///
  /// In en, this message translates to:
  /// **'Continuous scan'**
  String get continuousScan;

  /// No description provided for @continuousScanDescription.
  ///
  /// In en, this message translates to:
  /// **'Keep scanning without opening each result.'**
  String get continuousScanDescription;

  /// No description provided for @importDocumentDescription.
  ///
  /// In en, this message translates to:
  /// **'Read a code from an image, PDF or Office document.'**
  String get importDocumentDescription;

  /// No description provided for @continuousModeTitle.
  ///
  /// In en, this message translates to:
  /// **'Continuous scan'**
  String get continuousModeTitle;

  /// No description provided for @continuousModeExplanation.
  ///
  /// In en, this message translates to:
  /// **'When enabled, KillQR keeps the camera open and records each new code without opening a result page. The delay between repeated reads is controlled in Settings.'**
  String get continuousModeExplanation;

  /// No description provided for @multipleScanDescription.
  ///
  /// In en, this message translates to:
  /// **'Find several codes in one camera capture.'**
  String get multipleScanDescription;

  /// No description provided for @multipleModeTitle.
  ///
  /// In en, this message translates to:
  /// **'Multiple-code scanning'**
  String get multipleModeTitle;

  /// No description provided for @multipleModeExplanation.
  ///
  /// In en, this message translates to:
  /// **'When enabled, KillQR analyzes the full camera frame and can return several codes from one capture. The central scan box is hidden because the whole frame is used.'**
  String get multipleModeExplanation;

  /// No description provided for @doNotShowAgain.
  ///
  /// In en, this message translates to:
  /// **'Don’t show this again'**
  String get doNotShowAgain;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @flashlight.
  ///
  /// In en, this message translates to:
  /// **'Flashlight'**
  String get flashlight;

  /// No description provided for @switchCamera.
  ///
  /// In en, this message translates to:
  /// **'Switch camera'**
  String get switchCamera;

  /// No description provided for @moreScannerActions.
  ///
  /// In en, this message translates to:
  /// **'More scanner actions'**
  String get moreScannerActions;

  /// No description provided for @flashUnavailable.
  ///
  /// In en, this message translates to:
  /// **'The flashlight is not available on this camera.'**
  String get flashUnavailable;

  /// No description provided for @scanAreaSize.
  ///
  /// In en, this message translates to:
  /// **'Scan area'**
  String get scanAreaSize;

  /// No description provided for @resizeScanArea.
  ///
  /// In en, this message translates to:
  /// **'Drag the corner to resize the scan area'**
  String get resizeScanArea;

  /// No description provided for @scanAreaValue.
  ///
  /// In en, this message translates to:
  /// **'Scan area: {percent}%'**
  String scanAreaValue(int percent);

  /// No description provided for @fullCameraFrame.
  ///
  /// In en, this message translates to:
  /// **'Full camera frame'**
  String get fullCameraFrame;

  /// No description provided for @zoom.
  ///
  /// In en, this message translates to:
  /// **'Zoom'**
  String get zoom;

  /// No description provided for @zoomValue.
  ///
  /// In en, this message translates to:
  /// **'Zoom: {value}x'**
  String zoomValue(String value);

  /// No description provided for @privateMode.
  ///
  /// In en, this message translates to:
  /// **'Private mode'**
  String get privateMode;

  /// No description provided for @privateModeHint.
  ///
  /// In en, this message translates to:
  /// **'Results from this session will not be saved.'**
  String get privateModeHint;

  /// No description provided for @noHistory.
  ///
  /// In en, this message translates to:
  /// **'No scans yet'**
  String get noHistory;

  /// No description provided for @noHistoryHint.
  ///
  /// In en, this message translates to:
  /// **'Scanned results will appear here.'**
  String get noHistoryHint;

  /// No description provided for @searchHistory.
  ///
  /// In en, this message translates to:
  /// **'Search history'**
  String get searchHistory;

  /// No description provided for @favoritesOnly.
  ///
  /// In en, this message translates to:
  /// **'Favorites only'**
  String get favoritesOnly;

  /// No description provided for @allTypes.
  ///
  /// In en, this message translates to:
  /// **'All types'**
  String get allTypes;

  /// No description provided for @clearHistory.
  ///
  /// In en, this message translates to:
  /// **'Clear history'**
  String get clearHistory;

  /// No description provided for @clearHistoryConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete every saved scan? This cannot be undone.'**
  String get clearHistoryConfirm;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @saved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get saved;

  /// No description provided for @favorite.
  ///
  /// In en, this message translates to:
  /// **'Favorite'**
  String get favorite;

  /// No description provided for @note.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get note;

  /// No description provided for @addNote.
  ///
  /// In en, this message translates to:
  /// **'Add a note'**
  String get addNote;

  /// No description provided for @copy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copy;

  /// No description provided for @copied.
  ///
  /// In en, this message translates to:
  /// **'Copied'**
  String get copied;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @scanAgain.
  ///
  /// In en, this message translates to:
  /// **'Scan again'**
  String get scanAgain;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// No description provided for @value.
  ///
  /// In en, this message translates to:
  /// **'Value'**
  String get value;

  /// No description provided for @format.
  ///
  /// In en, this message translates to:
  /// **'Format'**
  String get format;

  /// No description provided for @type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get type;

  /// No description provided for @source.
  ///
  /// In en, this message translates to:
  /// **'Source'**
  String get source;

  /// No description provided for @warning.
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get warning;

  /// No description provided for @actions.
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get actions;

  /// No description provided for @actionOpen.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get actionOpen;

  /// No description provided for @actionCall.
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get actionCall;

  /// No description provided for @actionSendSms.
  ///
  /// In en, this message translates to:
  /// **'Compose SMS'**
  String get actionSendSms;

  /// No description provided for @actionSendEmail.
  ///
  /// In en, this message translates to:
  /// **'Compose email'**
  String get actionSendEmail;

  /// No description provided for @actionOpenMap.
  ///
  /// In en, this message translates to:
  /// **'Open map'**
  String get actionOpenMap;

  /// No description provided for @actionSaveContact.
  ///
  /// In en, this message translates to:
  /// **'Save contact'**
  String get actionSaveContact;

  /// No description provided for @actionSaveEvent.
  ///
  /// In en, this message translates to:
  /// **'Save event'**
  String get actionSaveEvent;

  /// No description provided for @actionWifiSettings.
  ///
  /// In en, this message translates to:
  /// **'Wi-Fi settings'**
  String get actionWifiSettings;

  /// No description provided for @confirmExternalAction.
  ///
  /// In en, this message translates to:
  /// **'Open another app to continue?'**
  String get confirmExternalAction;

  /// No description provided for @noAppFound.
  ///
  /// In en, this message translates to:
  /// **'No compatible app was found.'**
  String get noAppFound;

  /// No description provided for @generateTitle.
  ///
  /// In en, this message translates to:
  /// **'Create a code'**
  String get generateTitle;

  /// No description provided for @content.
  ///
  /// In en, this message translates to:
  /// **'Content'**
  String get content;

  /// No description provided for @barcodeFormat.
  ///
  /// In en, this message translates to:
  /// **'Barcode format'**
  String get barcodeFormat;

  /// No description provided for @generate.
  ///
  /// In en, this message translates to:
  /// **'Generate'**
  String get generate;

  /// No description provided for @generatedPreview.
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get generatedPreview;

  /// No description provided for @savePng.
  ///
  /// In en, this message translates to:
  /// **'Save PNG'**
  String get savePng;

  /// No description provided for @savedToGallery.
  ///
  /// In en, this message translates to:
  /// **'PNG saved to the gallery.'**
  String get savedToGallery;

  /// No description provided for @galleryPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Allow storage access to save the PNG to the gallery.'**
  String get galleryPermissionDenied;

  /// No description provided for @gallerySaveFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not save the PNG to the gallery.'**
  String get gallerySaveFailed;

  /// No description provided for @invalidContent.
  ///
  /// In en, this message translates to:
  /// **'Enter content to generate a code.'**
  String get invalidContent;

  /// No description provided for @invalidBarcodeContent.
  ///
  /// In en, this message translates to:
  /// **'Enter content valid for the selected format.'**
  String get invalidBarcodeContent;

  /// No description provided for @generationFailed.
  ///
  /// In en, this message translates to:
  /// **'The code could not be generated. Check the content.'**
  String get generationFailed;

  /// No description provided for @unsupportedFormat.
  ///
  /// In en, this message translates to:
  /// **'This format is not available for writing.'**
  String get unsupportedFormat;

  /// No description provided for @importExport.
  ///
  /// In en, this message translates to:
  /// **'Import and export'**
  String get importExport;

  /// No description provided for @exportJson.
  ///
  /// In en, this message translates to:
  /// **'Export JSON'**
  String get exportJson;

  /// No description provided for @exportCsv.
  ///
  /// In en, this message translates to:
  /// **'Export CSV'**
  String get exportCsv;

  /// No description provided for @importData.
  ///
  /// In en, this message translates to:
  /// **'Import data'**
  String get importData;

  /// No description provided for @transferComplete.
  ///
  /// In en, this message translates to:
  /// **'Transfer completed.'**
  String get transferComplete;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @themeAmoled.
  ///
  /// In en, this message translates to:
  /// **'AMOLED'**
  String get themeAmoled;

  /// No description provided for @accentColor.
  ///
  /// In en, this message translates to:
  /// **'Accent color'**
  String get accentColor;

  /// No description provided for @customAccentColor.
  ///
  /// In en, this message translates to:
  /// **'Custom color'**
  String get customAccentColor;

  /// No description provided for @customAccentColorHint.
  ///
  /// In en, this message translates to:
  /// **'Choose any RGB color'**
  String get customAccentColorHint;

  /// No description provided for @hexColor.
  ///
  /// In en, this message translates to:
  /// **'HEX color'**
  String get hexColor;

  /// No description provided for @red.
  ///
  /// In en, this message translates to:
  /// **'Red'**
  String get red;

  /// No description provided for @green.
  ///
  /// In en, this message translates to:
  /// **'Green'**
  String get green;

  /// No description provided for @blue.
  ///
  /// In en, this message translates to:
  /// **'Blue'**
  String get blue;

  /// No description provided for @invalidHexColor.
  ///
  /// In en, this message translates to:
  /// **'Enter 6 hexadecimal digits.'**
  String get invalidHexColor;

  /// No description provided for @applyColor.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get applyColor;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @languageSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get languageSystem;

  /// No description provided for @languagePortuguese.
  ///
  /// In en, this message translates to:
  /// **'Português (Brasil)'**
  String get languagePortuguese;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageSpanish.
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get languageSpanish;

  /// No description provided for @languageFrench.
  ///
  /// In en, this message translates to:
  /// **'French'**
  String get languageFrench;

  /// No description provided for @languageGerman.
  ///
  /// In en, this message translates to:
  /// **'German'**
  String get languageGerman;

  /// No description provided for @languageItalian.
  ///
  /// In en, this message translates to:
  /// **'Italian'**
  String get languageItalian;

  /// No description provided for @languageJapanese.
  ///
  /// In en, this message translates to:
  /// **'Japanese'**
  String get languageJapanese;

  /// No description provided for @languageChineseSimplified.
  ///
  /// In en, this message translates to:
  /// **'Simplified Chinese'**
  String get languageChineseSimplified;

  /// No description provided for @saveAutomatically.
  ///
  /// In en, this message translates to:
  /// **'Save results automatically'**
  String get saveAutomatically;

  /// No description provided for @debounce.
  ///
  /// In en, this message translates to:
  /// **'Continuous scan delay'**
  String get debounce;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @privacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get privacy;

  /// No description provided for @aboutText.
  ///
  /// In en, this message translates to:
  /// **'KillQR stores scans locally and works offline by default. Network access is used only when you check for updates.'**
  String get aboutText;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version 0.1.7 (build 8)'**
  String get version;

  /// No description provided for @createdBy.
  ///
  /// In en, this message translates to:
  /// **'Created by Leonardo Silva Bordin'**
  String get createdBy;

  /// No description provided for @license.
  ///
  /// In en, this message translates to:
  /// **'Apache-2.0 license'**
  String get license;

  /// No description provided for @productSearch.
  ///
  /// In en, this message translates to:
  /// **'Search product'**
  String get productSearch;

  /// No description provided for @parserWarning.
  ///
  /// In en, this message translates to:
  /// **'Some fields could not be interpreted safely.'**
  String get parserWarning;

  /// No description provided for @typeText.
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get typeText;

  /// No description provided for @typeUrl.
  ///
  /// In en, this message translates to:
  /// **'URL'**
  String get typeUrl;

  /// No description provided for @typePhone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get typePhone;

  /// No description provided for @typeSms.
  ///
  /// In en, this message translates to:
  /// **'SMS'**
  String get typeSms;

  /// No description provided for @typeEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get typeEmail;

  /// No description provided for @typeWifi.
  ///
  /// In en, this message translates to:
  /// **'Wi-Fi'**
  String get typeWifi;

  /// No description provided for @typeContact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get typeContact;

  /// No description provided for @typeGeo.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get typeGeo;

  /// No description provided for @typeEvent.
  ///
  /// In en, this message translates to:
  /// **'Event'**
  String get typeEvent;

  /// No description provided for @typeProduct.
  ///
  /// In en, this message translates to:
  /// **'Product'**
  String get typeProduct;

  /// No description provided for @typeUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get typeUnknown;

  /// No description provided for @sourceCamera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get sourceCamera;

  /// No description provided for @sourceImage.
  ///
  /// In en, this message translates to:
  /// **'Image'**
  String get sourceImage;

  /// No description provided for @sourceContinuous.
  ///
  /// In en, this message translates to:
  /// **'Continuous scan'**
  String get sourceContinuous;

  /// No description provided for @sourceImported.
  ///
  /// In en, this message translates to:
  /// **'Imported'**
  String get sourceImported;

  /// No description provided for @sourceGenerated.
  ///
  /// In en, this message translates to:
  /// **'Generated'**
  String get sourceGenerated;

  /// No description provided for @multipleScan.
  ///
  /// In en, this message translates to:
  /// **'Enable multiple-code scanning'**
  String get multipleScan;

  /// No description provided for @continuousActive.
  ///
  /// In en, this message translates to:
  /// **'CONTINUOUS'**
  String get continuousActive;

  /// No description provided for @privateActive.
  ///
  /// In en, this message translates to:
  /// **'PRIVATE'**
  String get privateActive;

  /// No description provided for @releaseNotesImprovementsTitle.
  ///
  /// In en, this message translates to:
  /// **'Improvements'**
  String get releaseNotesImprovementsTitle;

  /// No description provided for @releaseNotesBugFixesTitle.
  ///
  /// In en, this message translates to:
  /// **'Bug fixes'**
  String get releaseNotesBugFixesTitle;

  /// No description provided for @releaseNotesTitle.
  ///
  /// In en, this message translates to:
  /// **'What’s new in KillQR'**
  String get releaseNotesTitle;

  /// No description provided for @updatedToVersion.
  ///
  /// In en, this message translates to:
  /// **'Updated to version {version}'**
  String updatedToVersion(String version);

  /// No description provided for @releaseNotesIntro.
  ///
  /// In en, this message translates to:
  /// **'Changes in this version:'**
  String get releaseNotesIntro;

  /// No description provided for @releaseNoteScanArea.
  ///
  /// In en, this message translates to:
  /// **'The camera scan area can now be freely resized from its bottom-right corner, with independent width and height.'**
  String get releaseNoteScanArea;

  /// No description provided for @releaseNoteTopControls.
  ///
  /// In en, this message translates to:
  /// **'Flashlight, camera switching, document import and scanner modes are now grouped in the top bar, with an overflow menu on narrow screens.'**
  String get releaseNoteTopControls;

  /// No description provided for @releaseNoteZoom.
  ///
  /// In en, this message translates to:
  /// **'Single-code scans analyze only the selected rectangular area, and the compact zoom control preserves more camera space in wide landscape layouts.'**
  String get releaseNoteZoom;

  /// No description provided for @releaseNoteModeHelp.
  ///
  /// In en, this message translates to:
  /// **'Continuous and multiple-code modes now explain their behavior when enabled and can be dismissed permanently.'**
  String get releaseNoteModeHelp;

  /// No description provided for @releaseNoteCameraOverlay.
  ///
  /// In en, this message translates to:
  /// **'Removed the old floating multiple-code switch and continuous-mode status overlay from the camera preview.'**
  String get releaseNoteCameraOverlay;

  /// No description provided for @releaseNoteContinuousIndicator.
  ///
  /// In en, this message translates to:
  /// **'The continuous-mode indicator now sits in the camera’s lower-right corner without increasing the header.'**
  String get releaseNoteContinuousIndicator;

  /// No description provided for @releaseNoteDocumentScan.
  ///
  /// In en, this message translates to:
  /// **'Image, PDF and Office document scanning now works independently from continuous mode.'**
  String get releaseNoteDocumentScan;

  /// No description provided for @releaseNoteScannerHint.
  ///
  /// In en, this message translates to:
  /// **'The scanner instruction now explains that this option enables scanning multiple codes at the same time.'**
  String get releaseNoteScannerHint;

  /// No description provided for @releaseNoteDocumentLoading.
  ///
  /// In en, this message translates to:
  /// **'File imports now show a loading window saying “Analyzing document…” while the file is being read.'**
  String get releaseNoteDocumentLoading;

  /// No description provided for @releaseNoteVersioning.
  ///
  /// In en, this message translates to:
  /// **'These notes appear once the first time the app opens after each update.'**
  String get releaseNoteVersioning;

  /// No description provided for @releaseNoteQuickTile.
  ///
  /// In en, this message translates to:
  /// **'The KillQR tile now uses a recognizable QR Code icon and the name “Scan with KillQR”.'**
  String get releaseNoteQuickTile;

  /// No description provided for @releaseNoteGitHubUpdates.
  ///
  /// In en, this message translates to:
  /// **'Added automatic and manual GitHub release checks, with options to snooze or stop update reminders.'**
  String get releaseNoteGitHubUpdates;

  /// No description provided for @releaseNoteAccentSwitch.
  ///
  /// In en, this message translates to:
  /// **'The multiple-code switch now follows the custom accent color.'**
  String get releaseNoteAccentSwitch;

  /// No description provided for @updates.
  ///
  /// In en, this message translates to:
  /// **'Updates'**
  String get updates;

  /// No description provided for @automaticUpdates.
  ///
  /// In en, this message translates to:
  /// **'Check for updates automatically'**
  String get automaticUpdates;

  /// No description provided for @automaticUpdatesHint.
  ///
  /// In en, this message translates to:
  /// **'Checks GitHub once a day and alerts you when a new version is available.'**
  String get automaticUpdatesHint;

  /// No description provided for @checkForUpdates.
  ///
  /// In en, this message translates to:
  /// **'Check for updates'**
  String get checkForUpdates;

  /// No description provided for @checkForUpdatesHint.
  ///
  /// In en, this message translates to:
  /// **'Check the official KillQR releases on GitHub now.'**
  String get checkForUpdatesHint;

  /// No description provided for @checkingUpdates.
  ///
  /// In en, this message translates to:
  /// **'Checking for updates…'**
  String get checkingUpdates;

  /// No description provided for @updateAvailable.
  ///
  /// In en, this message translates to:
  /// **'Update available'**
  String get updateAvailable;

  /// No description provided for @updateVersionAvailable.
  ///
  /// In en, this message translates to:
  /// **'Version {version} is available.'**
  String updateVersionAvailable(String version);

  /// No description provided for @updateReleaseNotes.
  ///
  /// In en, this message translates to:
  /// **'Release notes'**
  String get updateReleaseNotes;

  /// No description provided for @downloadUpdate.
  ///
  /// In en, this message translates to:
  /// **'Download update'**
  String get downloadUpdate;

  /// No description provided for @remindLater.
  ///
  /// In en, this message translates to:
  /// **'Remind me later'**
  String get remindLater;

  /// No description provided for @neverRemind.
  ///
  /// In en, this message translates to:
  /// **'Don\'t remind me again'**
  String get neverRemind;

  /// No description provided for @noUpdatesAvailable.
  ///
  /// In en, this message translates to:
  /// **'You are using the latest version.'**
  String get noUpdatesAvailable;

  /// No description provided for @updateCheckFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not check for updates right now.'**
  String get updateCheckFailed;

  /// No description provided for @updatesNotConfigured.
  ///
  /// In en, this message translates to:
  /// **'Automatic updates are not configured in this build.'**
  String get updatesNotConfigured;

  /// No description provided for @updateOpenFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not open the update download.'**
  String get updateOpenFailed;

  /// No description provided for @continueLabel.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueLabel;

  /// No description provided for @searchEngines.
  ///
  /// In en, this message translates to:
  /// **'Search engines'**
  String get searchEngines;

  /// No description provided for @addSearchEngine.
  ///
  /// In en, this message translates to:
  /// **'Add search engine'**
  String get addSearchEngine;

  /// No description provided for @editSearchEngine.
  ///
  /// In en, this message translates to:
  /// **'Edit search engine'**
  String get editSearchEngine;

  /// No description provided for @searchEngineName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get searchEngineName;

  /// No description provided for @searchEngineTemplate.
  ///
  /// In en, this message translates to:
  /// **'Search URL'**
  String get searchEngineTemplate;

  /// No description provided for @searchEngineTemplateHint.
  ///
  /// In en, this message translates to:
  /// **'Use the CODE marker where the code should go.'**
  String get searchEngineTemplateHint;

  /// No description provided for @invalidSearchTemplate.
  ///
  /// In en, this message translates to:
  /// **'Use an http(s) URL containing the CODE marker.'**
  String get invalidSearchTemplate;

  /// No description provided for @noSearchEngines.
  ///
  /// In en, this message translates to:
  /// **'No search engines configured.'**
  String get noSearchEngines;

  /// No description provided for @enabled.
  ///
  /// In en, this message translates to:
  /// **'Enabled'**
  String get enabled;

  /// No description provided for @openAppSettings.
  ///
  /// In en, this message translates to:
  /// **'Open app settings'**
  String get openAppSettings;

  /// No description provided for @searchProduct.
  ///
  /// In en, this message translates to:
  /// **'Search product'**
  String get searchProduct;

  /// No description provided for @tags.
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get tags;

  /// No description provided for @addTag.
  ///
  /// In en, this message translates to:
  /// **'Add tag'**
  String get addTag;

  /// No description provided for @tagHint.
  ///
  /// In en, this message translates to:
  /// **'Tag name'**
  String get tagHint;

  /// No description provided for @saveTags.
  ///
  /// In en, this message translates to:
  /// **'Save tags'**
  String get saveTags;

  /// No description provided for @noTags.
  ///
  /// In en, this message translates to:
  /// **'No tags'**
  String get noTags;

  /// No description provided for @selectItems.
  ///
  /// In en, this message translates to:
  /// **'Select items'**
  String get selectItems;

  /// No description provided for @selectedItems.
  ///
  /// In en, this message translates to:
  /// **'items selected'**
  String get selectedItems;

  /// No description provided for @exportSelected.
  ///
  /// In en, this message translates to:
  /// **'Export selected'**
  String get exportSelected;

  /// No description provided for @shareSelected.
  ///
  /// In en, this message translates to:
  /// **'Share selected'**
  String get shareSelected;

  /// No description provided for @deleteSelected.
  ///
  /// In en, this message translates to:
  /// **'Delete selected'**
  String get deleteSelected;

  /// No description provided for @sourceFilter.
  ///
  /// In en, this message translates to:
  /// **'Source'**
  String get sourceFilter;

  /// No description provided for @allSources.
  ///
  /// In en, this message translates to:
  /// **'All sources'**
  String get allSources;

  /// No description provided for @formatFilter.
  ///
  /// In en, this message translates to:
  /// **'Format'**
  String get formatFilter;

  /// No description provided for @allFormats.
  ///
  /// In en, this message translates to:
  /// **'All formats'**
  String get allFormats;

  /// No description provided for @template.
  ///
  /// In en, this message translates to:
  /// **'Content template'**
  String get template;

  /// No description provided for @templateText.
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get templateText;

  /// No description provided for @templateUrl.
  ///
  /// In en, this message translates to:
  /// **'URL'**
  String get templateUrl;

  /// No description provided for @templateWifi.
  ///
  /// In en, this message translates to:
  /// **'Wi-Fi'**
  String get templateWifi;

  /// No description provided for @templateEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get templateEmail;

  /// No description provided for @templateSms.
  ///
  /// In en, this message translates to:
  /// **'SMS'**
  String get templateSms;

  /// No description provided for @templateContact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get templateContact;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'de',
    'en',
    'es',
    'fr',
    'it',
    'ja',
    'pt',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'pt':
      {
        switch (locale.countryCode) {
          case 'BR':
            return AppLocalizationsPtBr();
        }
        break;
      }
    case 'zh':
      {
        switch (locale.countryCode) {
          case 'CN':
            return AppLocalizationsZhCn();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'pt':
      return AppLocalizationsPt();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
