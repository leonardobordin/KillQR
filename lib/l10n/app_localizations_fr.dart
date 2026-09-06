// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'KillQR';

  @override
  String get bootstrapStarting => 'Préparation du stockage local…';

  @override
  String get bootstrapFailed => 'Impossible d’ouvrir le stockage local.';

  @override
  String get bootstrapReady => 'Initialisation terminée';

  @override
  String get bootstrapDescription =>
      'La base Android est prête pour la prochaine étape.';

  @override
  String get bootstrapErrorDetails =>
      'Vos données locales restent privées. Essayez de rouvrir l’application.';

  @override
  String get retry => 'Réessayer';

  @override
  String get scanner => 'Scanner';

  @override
  String get history => 'Historique';

  @override
  String get create => 'Créer';

  @override
  String get settings => 'Paramètres';

  @override
  String get scanTitle => 'Scanner un code';

  @override
  String get scanHint =>
      'Activez cette option pour scanner plusieurs codes à la fois.';

  @override
  String get cameraUnavailable => 'Caméra indisponible';

  @override
  String get cameraPermission =>
      'L’accès à la caméra est nécessaire uniquement pendant le scan.';

  @override
  String get openSettings => 'Ouvrir les paramètres';

  @override
  String get importImage => 'Choisir une image';

  @override
  String get importDocument => 'Choisir une image ou un document';

  @override
  String get imageFiles => 'Images';

  @override
  String get pdfFiles => 'Fichiers PDF';

  @override
  String get officeFiles => 'Documents Office';

  @override
  String get scanningFile => 'Analyse du document…';

  @override
  String get codeNotFoundInFile =>
      'Aucun QR Code ni code-barres n’a été trouvé dans ce fichier.';

  @override
  String get fileScanFailed => 'Impossible de lire le fichier sélectionné.';

  @override
  String get fileTooLarge =>
      'Ce fichier est trop volumineux pour être analysé localement.';

  @override
  String get legacyOfficeUnsupported =>
      'Les anciens fichiers Office ne sont pas pris en charge. Utilisez DOCX, XLSX ou PPTX.';

  @override
  String get unsupportedFileType =>
      'Ce type de fichier n’est pas pris en charge pour le scan de QR Codes.';

  @override
  String get continuousScan => 'Scan continu';

  @override
  String get continuousScanDescription =>
      'Continuez à scanner sans ouvrir chaque résultat.';

  @override
  String get importDocumentDescription =>
      'Lisez un code depuis une image, un PDF ou un document Office.';

  @override
  String get continuousModeTitle => 'Scan continu';

  @override
  String get continuousModeExplanation =>
      'Une fois activé, KillQR garde la caméra ouverte et enregistre chaque nouveau code sans ouvrir la page de résultat. Le délai entre les lectures répétées se règle dans les paramètres.';

  @override
  String get multipleScanDescription =>
      'Trouvez plusieurs codes dans une capture de la caméra.';

  @override
  String get multipleModeTitle => 'Scan de plusieurs codes';

  @override
  String get multipleModeExplanation =>
      'Une fois activé, KillQR analyse toute l’image de la caméra et peut renvoyer plusieurs codes en une capture. La zone centrale est masquée, car toute l’image est utilisée.';

  @override
  String get doNotShowAgain => 'Ne plus afficher';

  @override
  String get close => 'Fermer';

  @override
  String get flashlight => 'Lampe torche';

  @override
  String get switchCamera => 'Changer de caméra';

  @override
  String get moreScannerActions => 'Autres actions du scanner';

  @override
  String get flashUnavailable =>
      'La lampe torche n’est pas disponible sur cette caméra.';

  @override
  String get scanAreaSize => 'Zone de scan';

  @override
  String scanAreaValue(int percent) {
    return 'Zone de scan : $percent %';
  }

  @override
  String get fullCameraFrame => 'Image complète de la caméra';

  @override
  String get zoom => 'Zoom';

  @override
  String zoomValue(String value) {
    return 'Zoom : ${value}x';
  }

  @override
  String get privateMode => 'Mode privé';

  @override
  String get privateModeHint =>
      'Les résultats de cette session ne seront pas enregistrés.';

  @override
  String get noHistory => 'Aucun scan pour le moment';

  @override
  String get noHistoryHint => 'Les résultats scannés apparaîtront ici.';

  @override
  String get searchHistory => 'Rechercher dans l’historique';

  @override
  String get favoritesOnly => 'Favoris uniquement';

  @override
  String get allTypes => 'Tous les types';

  @override
  String get clearHistory => 'Effacer l’historique';

  @override
  String get clearHistoryConfirm =>
      'Supprimer tous les scans enregistrés ? Cette action est irréversible.';

  @override
  String get cancel => 'Annuler';

  @override
  String get delete => 'Supprimer';

  @override
  String get save => 'Enregistrer';

  @override
  String get saved => 'Enregistré';

  @override
  String get favorite => 'Favori';

  @override
  String get note => 'Note';

  @override
  String get addNote => 'Ajouter une note';

  @override
  String get copy => 'Copier';

  @override
  String get copied => 'Copié';

  @override
  String get share => 'Partager';

  @override
  String get scanAgain => 'Scanner à nouveau';

  @override
  String get details => 'Détails';

  @override
  String get value => 'Valeur';

  @override
  String get format => 'Format';

  @override
  String get type => 'Type';

  @override
  String get source => 'Source';

  @override
  String get warning => 'Avertissement';

  @override
  String get actions => 'Actions';

  @override
  String get actionOpen => 'Ouvrir';

  @override
  String get actionCall => 'Appeler';

  @override
  String get actionSendSms => 'Rédiger un SMS';

  @override
  String get actionSendEmail => 'Rédiger un e-mail';

  @override
  String get actionOpenMap => 'Ouvrir la carte';

  @override
  String get actionSaveContact => 'Enregistrer le contact';

  @override
  String get actionSaveEvent => 'Enregistrer l’événement';

  @override
  String get actionWifiSettings => 'Paramètres Wi-Fi';

  @override
  String get confirmExternalAction =>
      'Ouvrir une autre application pour continuer ?';

  @override
  String get noAppFound => 'Aucune application compatible n’a été trouvée.';

  @override
  String get generateTitle => 'Créer un code';

  @override
  String get content => 'Contenu';

  @override
  String get barcodeFormat => 'Format du code-barres';

  @override
  String get generate => 'Générer';

  @override
  String get generatedPreview => 'Aperçu';

  @override
  String get savePng => 'Enregistrer le PNG';

  @override
  String get savedToGallery => 'PNG enregistré dans la galerie.';

  @override
  String get galleryPermissionDenied =>
      'Autorisez l’accès au stockage pour enregistrer le PNG dans la galerie.';

  @override
  String get gallerySaveFailed =>
      'Impossible d’enregistrer le PNG dans la galerie.';

  @override
  String get invalidContent => 'Saisissez du contenu pour générer un code.';

  @override
  String get invalidBarcodeContent =>
      'Saisissez un contenu valide pour le format sélectionné.';

  @override
  String get generationFailed =>
      'Impossible de générer le code. Vérifiez le contenu.';

  @override
  String get unsupportedFormat =>
      'Ce format n’est pas disponible pour l’écriture.';

  @override
  String get importExport => 'Importer et exporter';

  @override
  String get exportJson => 'Exporter en JSON';

  @override
  String get exportCsv => 'Exporter en CSV';

  @override
  String get importData => 'Importer des données';

  @override
  String get transferComplete => 'Transfert terminé.';

  @override
  String get theme => 'Thème';

  @override
  String get themeSystem => 'Système';

  @override
  String get themeLight => 'Clair';

  @override
  String get themeDark => 'Sombre';

  @override
  String get themeAmoled => 'AMOLED';

  @override
  String get accentColor => 'Couleur d’accentuation';

  @override
  String get customAccentColor => 'Couleur personnalisée';

  @override
  String get customAccentColorHint => 'Choisissez n’importe quelle couleur RVB';

  @override
  String get hexColor => 'Couleur HEX';

  @override
  String get red => 'Rouge';

  @override
  String get green => 'Vert';

  @override
  String get blue => 'Bleu';

  @override
  String get invalidHexColor => 'Saisissez 6 chiffres hexadécimaux.';

  @override
  String get applyColor => 'Appliquer';

  @override
  String get language => 'Langue';

  @override
  String get languageSystem => 'Système';

  @override
  String get languagePortuguese => 'Portugais (Brésil)';

  @override
  String get languageEnglish => 'Anglais';

  @override
  String get languageSpanish => 'Espagnol';

  @override
  String get languageFrench => 'Français';

  @override
  String get languageGerman => 'Allemand';

  @override
  String get languageItalian => 'Italien';

  @override
  String get languageJapanese => 'Japonais';

  @override
  String get languageChineseSimplified => 'Chinois simplifié';

  @override
  String get saveAutomatically => 'Enregistrer automatiquement les résultats';

  @override
  String get debounce => 'Délai du scan continu';

  @override
  String get about => 'À propos';

  @override
  String get privacy => 'Confidentialité';

  @override
  String get aboutText =>
      'KillQR stocke les scans localement et fonctionne hors ligne par défaut. Le réseau est utilisé uniquement lorsque vous recherchez des mises à jour.';

  @override
  String get version => 'Version 0.1.6 (build 7)';

  @override
  String get createdBy => 'Créé par Leonardo Silva Bordin';

  @override
  String get license => 'Licence Apache-2.0';

  @override
  String get productSearch => 'Rechercher un produit';

  @override
  String get parserWarning =>
      'Certains champs n’ont pas pu être interprétés en toute sécurité.';

  @override
  String get typeText => 'Texte';

  @override
  String get typeUrl => 'URL';

  @override
  String get typePhone => 'Téléphone';

  @override
  String get typeSms => 'SMS';

  @override
  String get typeEmail => 'E-mail';

  @override
  String get typeWifi => 'Wi-Fi';

  @override
  String get typeContact => 'Contact';

  @override
  String get typeGeo => 'Emplacement';

  @override
  String get typeEvent => 'Événement';

  @override
  String get typeProduct => 'Produit';

  @override
  String get typeUnknown => 'Inconnu';

  @override
  String get sourceCamera => 'Caméra';

  @override
  String get sourceImage => 'Image';

  @override
  String get sourceContinuous => 'Scan continu';

  @override
  String get sourceImported => 'Importé';

  @override
  String get sourceGenerated => 'Généré';

  @override
  String get multipleScan => 'Activer le scan de plusieurs codes';

  @override
  String get continuousActive => 'CONTINU';

  @override
  String get privateActive => 'PRIVÉ';

  @override
  String get releaseNotesImprovementsTitle => 'Améliorations';

  @override
  String get releaseNotesBugFixesTitle => 'Corrections de bugs';

  @override
  String get releaseNotesTitle => 'Nouveautés de KillQR';

  @override
  String updatedToVersion(String version) {
    return 'Mis à jour vers la version $version';
  }

  @override
  String get releaseNotesIntro => 'Changements de cette version :';

  @override
  String get releaseNoteScanArea =>
      'La zone de scan de la caméra peut maintenant être redimensionnée ; les scans d’un seul code analysent uniquement la région sélectionnée.';

  @override
  String get releaseNoteTopControls =>
      'La lampe torche, le changement de caméra, l’importation de documents et les modes du scanner sont regroupés dans la barre supérieure, avec un menu supplémentaire sur les petits écrans.';

  @override
  String get releaseNoteZoom =>
      'Des curseurs pour la taille de la zone de scan et le zoom de la caméra ont été ajoutés en bas de l’aperçu.';

  @override
  String get releaseNoteModeHelp =>
      'Les modes continu et plusieurs codes expliquent maintenant leur fonctionnement à l’activation et peuvent être masqués définitivement.';

  @override
  String get releaseNoteCameraOverlay =>
      'L’ancien bouton flottant de plusieurs codes et l’indicateur du mode continu ont été retirés de l’aperçu de la caméra.';

  @override
  String get releaseNoteContinuousIndicator =>
      'L’indicateur du mode continu se trouve maintenant dans le coin inférieur droit de la caméra sans agrandir l’en-tête.';

  @override
  String get releaseNoteDocumentScan =>
      'Le scan des images, PDF et documents Office fonctionne indépendamment du mode continu.';

  @override
  String get releaseNoteScannerHint =>
      'L’instruction du scanner explique maintenant que cette option active le scan de plusieurs codes à la fois.';

  @override
  String get releaseNoteDocumentLoading =>
      'Les importations affichent maintenant une fenêtre indiquant « Analyse du document… » pendant la lecture du fichier.';

  @override
  String get releaseNoteVersioning =>
      'Ces notes s’affichent une seule fois lors de la première ouverture après chaque mise à jour.';

  @override
  String get releaseNoteQuickTile =>
      'La tuile KillQR utilise maintenant une icône de QR Code reconnaissable et le nom « Scanner avec KillQR ».';

  @override
  String get releaseNoteGitHubUpdates =>
      'Ajout de recherches automatiques et manuelles des releases GitHub, avec des options pour reporter ou arrêter les notifications.';

  @override
  String get releaseNoteAccentSwitch =>
      'Le bouton de plusieurs codes suit maintenant la couleur d’accentuation personnalisée.';

  @override
  String get updates => 'Mises à jour';

  @override
  String get automaticUpdates => 'Rechercher automatiquement les mises à jour';

  @override
  String get automaticUpdatesHint =>
      'Consulte GitHub une fois par jour et vous avertit lorsqu’une nouvelle version est disponible.';

  @override
  String get checkForUpdates => 'Rechercher des mises à jour';

  @override
  String get checkForUpdatesHint =>
      'Consultez maintenant les releases officielles de KillQR sur GitHub.';

  @override
  String get checkingUpdates => 'Recherche des mises à jour…';

  @override
  String get updateAvailable => 'Mise à jour disponible';

  @override
  String updateVersionAvailable(String version) {
    return 'La version $version est disponible.';
  }

  @override
  String get updateReleaseNotes => 'Notes de version';

  @override
  String get downloadUpdate => 'Télécharger la mise à jour';

  @override
  String get remindLater => 'Me le rappeler plus tard';

  @override
  String get neverRemind => 'Ne plus me le rappeler';

  @override
  String get noUpdatesAvailable => 'Vous utilisez déjà la dernière version.';

  @override
  String get updateCheckFailed =>
      'Impossible de rechercher les mises à jour pour le moment.';

  @override
  String get updatesNotConfigured =>
      'Les mises à jour automatiques ne sont pas configurées dans cette version.';

  @override
  String get updateOpenFailed =>
      'Impossible d’ouvrir le téléchargement de la mise à jour.';

  @override
  String get continueLabel => 'Continuer';

  @override
  String get searchEngines => 'Moteurs de recherche';

  @override
  String get addSearchEngine => 'Ajouter un moteur de recherche';

  @override
  String get editSearchEngine => 'Modifier le moteur de recherche';

  @override
  String get searchEngineName => 'Nom';

  @override
  String get searchEngineTemplate => 'URL de recherche';

  @override
  String get searchEngineTemplateHint =>
      'Utilisez le marqueur CODE à l’emplacement du code.';

  @override
  String get invalidSearchTemplate =>
      'Utilisez une URL http(s) contenant le marqueur CODE.';

  @override
  String get noSearchEngines => 'Aucun moteur de recherche configuré.';

  @override
  String get enabled => 'Activé';

  @override
  String get openAppSettings => 'Ouvrir les paramètres de l’application';

  @override
  String get searchProduct => 'Rechercher un produit';

  @override
  String get tags => 'Étiquettes';

  @override
  String get addTag => 'Ajouter une étiquette';

  @override
  String get tagHint => 'Nom de l’étiquette';

  @override
  String get saveTags => 'Enregistrer les étiquettes';

  @override
  String get noTags => 'Aucune étiquette';

  @override
  String get selectItems => 'Sélectionner des éléments';

  @override
  String get selectedItems => 'éléments sélectionnés';

  @override
  String get exportSelected => 'Exporter la sélection';

  @override
  String get shareSelected => 'Partager la sélection';

  @override
  String get deleteSelected => 'Supprimer la sélection';

  @override
  String get sourceFilter => 'Source';

  @override
  String get allSources => 'Toutes les sources';

  @override
  String get formatFilter => 'Format';

  @override
  String get allFormats => 'Tous les formats';

  @override
  String get template => 'Modèle de contenu';

  @override
  String get templateText => 'Texte';

  @override
  String get templateUrl => 'URL';

  @override
  String get templateWifi => 'Wi-Fi';

  @override
  String get templateEmail => 'E-mail';

  @override
  String get templateSms => 'SMS';

  @override
  String get templateContact => 'Contact';
}
