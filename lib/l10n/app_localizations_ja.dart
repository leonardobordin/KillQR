// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'KillQR';

  @override
  String get bootstrapStarting => 'ローカルストレージを準備しています…';

  @override
  String get bootstrapFailed => 'ローカルストレージを開けませんでした。';

  @override
  String get bootstrapReady => '起動準備完了';

  @override
  String get bootstrapDescription => 'Androidの基盤が次の段階に進む準備を整えました。';

  @override
  String get bootstrapErrorDetails => 'ローカルデータは安全に保護されています。アプリをもう一度開いてください。';

  @override
  String get retry => '再試行';

  @override
  String get scanner => 'スキャン';

  @override
  String get history => '履歴';

  @override
  String get create => '作成';

  @override
  String get settings => '設定';

  @override
  String get scanTitle => 'コードをスキャン';

  @override
  String get scanHint => 'このオプションを有効にすると、複数のコードを同時にスキャンできます。';

  @override
  String get cameraUnavailable => 'カメラを利用できません';

  @override
  String get cameraPermission => 'カメラへのアクセスはスキャン中のみ必要です。';

  @override
  String get openSettings => '設定を開く';

  @override
  String get importImage => '画像を選択';

  @override
  String get importDocument => '画像またはドキュメントを選択';

  @override
  String get imageFiles => '画像';

  @override
  String get pdfFiles => 'PDFファイル';

  @override
  String get officeFiles => 'Officeドキュメント';

  @override
  String get scanningFile => 'ドキュメントを解析しています…';

  @override
  String get codeNotFoundInFile => 'このファイルにQRコードまたはバーコードが見つかりませんでした。';

  @override
  String get fileScanFailed => '選択したファイルを読み取れませんでした。';

  @override
  String get fileTooLarge => 'このファイルはローカルスキャンには大きすぎます。';

  @override
  String get legacyOfficeUnsupported =>
      '古いOfficeファイルには対応していません。DOCX、XLSX、PPTXを使用してください。';

  @override
  String get unsupportedFileType => 'このファイル形式はQRコードのスキャンに対応していません。';

  @override
  String get continuousScan => '連続スキャン';

  @override
  String get continuousScanDescription => '結果を毎回開かずにスキャンを続けます。';

  @override
  String get importDocumentDescription => '画像、PDF、Officeドキュメントからコードを読み取ります。';

  @override
  String get continuousModeTitle => '連続スキャン';

  @override
  String get continuousModeExplanation =>
      '有効にすると、KillQRはカメラを開いたままにして、新しいコードを記録します。結果画面は開きません。繰り返し読み取る間隔は設定で変更できます。';

  @override
  String get multipleScanDescription => '1回のカメラ撮影から複数のコードを検出します。';

  @override
  String get multipleModeTitle => '複数コードのスキャン';

  @override
  String get multipleModeExplanation =>
      '有効にすると、KillQRはカメラのフレーム全体を解析し、1回の撮影から複数のコードを返せます。フレーム全体を使用するため、中央のスキャン枠は非表示になります。';

  @override
  String get doNotShowAgain => '今後表示しない';

  @override
  String get close => '閉じる';

  @override
  String get flashlight => 'ライト';

  @override
  String get switchCamera => 'カメラを切り替え';

  @override
  String get moreScannerActions => 'その他のスキャン操作';

  @override
  String get flashUnavailable => 'このカメラではライトを利用できません。';

  @override
  String get scanAreaSize => 'スキャン範囲';

  @override
  String scanAreaValue(int percent) {
    return 'スキャン範囲: $percent%';
  }

  @override
  String get fullCameraFrame => 'カメラフレーム全体';

  @override
  String get zoom => 'ズーム';

  @override
  String zoomValue(String value) {
    return 'ズーム: ${value}x';
  }

  @override
  String get privateMode => 'プライベートモード';

  @override
  String get privateModeHint => 'このセッションの結果は保存されません。';

  @override
  String get noHistory => 'スキャン履歴はありません';

  @override
  String get noHistoryHint => 'スキャンした結果がここに表示されます。';

  @override
  String get searchHistory => '履歴を検索';

  @override
  String get favoritesOnly => 'お気に入りのみ';

  @override
  String get allTypes => 'すべての種類';

  @override
  String get clearHistory => '履歴を消去';

  @override
  String get clearHistoryConfirm => '保存したスキャンをすべて削除しますか？この操作は元に戻せません。';

  @override
  String get cancel => 'キャンセル';

  @override
  String get delete => '削除';

  @override
  String get save => '保存';

  @override
  String get saved => '保存済み';

  @override
  String get favorite => 'お気に入り';

  @override
  String get note => 'メモ';

  @override
  String get addNote => 'メモを追加';

  @override
  String get copy => 'コピー';

  @override
  String get copied => 'コピーしました';

  @override
  String get share => '共有';

  @override
  String get scanAgain => 'もう一度スキャン';

  @override
  String get details => '詳細';

  @override
  String get value => '値';

  @override
  String get format => '形式';

  @override
  String get type => '種類';

  @override
  String get source => 'ソース';

  @override
  String get warning => '警告';

  @override
  String get actions => '操作';

  @override
  String get actionOpen => '開く';

  @override
  String get actionCall => '電話をかける';

  @override
  String get actionSendSms => 'SMSを作成';

  @override
  String get actionSendEmail => 'メールを作成';

  @override
  String get actionOpenMap => '地図を開く';

  @override
  String get actionSaveContact => '連絡先を保存';

  @override
  String get actionSaveEvent => '予定を保存';

  @override
  String get actionWifiSettings => 'Wi-Fi設定';

  @override
  String get confirmExternalAction => '続行するために別のアプリを開きますか？';

  @override
  String get noAppFound => '対応するアプリが見つかりませんでした。';

  @override
  String get generateTitle => 'コードを作成';

  @override
  String get content => '内容';

  @override
  String get barcodeFormat => 'バーコード形式';

  @override
  String get generate => '生成';

  @override
  String get generatedPreview => 'プレビュー';

  @override
  String get savePng => 'PNGを保存';

  @override
  String get savedToGallery => 'PNGをギャラリーに保存しました。';

  @override
  String get galleryPermissionDenied => 'PNGをギャラリーに保存するにはストレージへのアクセスを許可してください。';

  @override
  String get gallerySaveFailed => 'PNGをギャラリーに保存できませんでした。';

  @override
  String get invalidContent => 'コードを生成する内容を入力してください。';

  @override
  String get invalidBarcodeContent => '選択した形式に有効な内容を入力してください。';

  @override
  String get generationFailed => 'コードを生成できませんでした。内容を確認してください。';

  @override
  String get unsupportedFormat => 'この形式は書き込みに対応していません。';

  @override
  String get importExport => 'インポートとエクスポート';

  @override
  String get exportJson => 'JSONをエクスポート';

  @override
  String get exportCsv => 'CSVをエクスポート';

  @override
  String get importData => 'データをインポート';

  @override
  String get transferComplete => '転送が完了しました。';

  @override
  String get theme => 'テーマ';

  @override
  String get themeSystem => 'システム';

  @override
  String get themeLight => 'ライト';

  @override
  String get themeDark => 'ダーク';

  @override
  String get themeAmoled => 'AMOLED';

  @override
  String get accentColor => 'アクセントカラー';

  @override
  String get customAccentColor => 'カスタムカラー';

  @override
  String get customAccentColorHint => '任意のRGBカラーを選択';

  @override
  String get hexColor => 'HEXカラー';

  @override
  String get red => '赤';

  @override
  String get green => '緑';

  @override
  String get blue => '青';

  @override
  String get invalidHexColor => '16進数6桁を入力してください。';

  @override
  String get applyColor => '適用';

  @override
  String get language => '言語';

  @override
  String get languageSystem => 'システム';

  @override
  String get languagePortuguese => 'ポルトガル語（ブラジル）';

  @override
  String get languageEnglish => '英語';

  @override
  String get languageSpanish => 'スペイン語';

  @override
  String get languageFrench => 'フランス語';

  @override
  String get languageGerman => 'ドイツ語';

  @override
  String get languageItalian => 'イタリア語';

  @override
  String get languageJapanese => '日本語';

  @override
  String get languageChineseSimplified => '中国語（簡体字）';

  @override
  String get saveAutomatically => '結果を自動的に保存';

  @override
  String get debounce => '連続スキャンの間隔';

  @override
  String get about => 'アプリについて';

  @override
  String get privacy => 'プライバシー';

  @override
  String get aboutText =>
      'KillQRはスキャン結果をローカルに保存し、初期設定ではオフラインで動作します。ネットワークは更新を確認するときだけ使用します。';

  @override
  String get version => 'バージョン 0.1.6（ビルド7）';

  @override
  String get createdBy => '作成者: Leonardo Silva Bordin';

  @override
  String get license => 'Apache-2.0ライセンス';

  @override
  String get productSearch => '商品を検索';

  @override
  String get parserWarning => '一部のフィールドを安全に解釈できませんでした。';

  @override
  String get typeText => 'テキスト';

  @override
  String get typeUrl => 'URL';

  @override
  String get typePhone => '電話番号';

  @override
  String get typeSms => 'SMS';

  @override
  String get typeEmail => 'メール';

  @override
  String get typeWifi => 'Wi-Fi';

  @override
  String get typeContact => '連絡先';

  @override
  String get typeGeo => '場所';

  @override
  String get typeEvent => '予定';

  @override
  String get typeProduct => '商品';

  @override
  String get typeUnknown => '不明';

  @override
  String get sourceCamera => 'カメラ';

  @override
  String get sourceImage => '画像';

  @override
  String get sourceContinuous => '連続スキャン';

  @override
  String get sourceImported => 'インポート';

  @override
  String get sourceGenerated => '生成';

  @override
  String get multipleScan => '複数コードのスキャンを有効にする';

  @override
  String get continuousActive => '連続';

  @override
  String get privateActive => 'プライベート';

  @override
  String get releaseNotesImprovementsTitle => '改善';

  @override
  String get releaseNotesBugFixesTitle => 'バグ修正';

  @override
  String get releaseNotesTitle => 'KillQRの新機能';

  @override
  String updatedToVersion(String version) {
    return 'バージョン$versionに更新しました';
  }

  @override
  String get releaseNotesIntro => 'このバージョンの変更点:';

  @override
  String get releaseNoteScanArea =>
      'カメラのスキャン範囲を変更できるようになり、1つのコードをスキャンすると選択した範囲だけを解析します。';

  @override
  String get releaseNoteTopControls =>
      'ライト、カメラ切り替え、ドキュメントの読み込み、スキャンモードを上部バーにまとめました。狭い画面では追加メニューを使用できます。';

  @override
  String get releaseNoteZoom => 'カメラプレビューの下部に、スキャン範囲とカメラズームのスライダーを追加しました。';

  @override
  String get releaseNoteModeHelp =>
      '連続スキャンと複数コードのモードを有効にすると、動作の説明が表示され、今後表示しない設定も選べます。';

  @override
  String get releaseNoteCameraOverlay =>
      'カメラプレビューから、以前の複数コード用フローティングボタンと連続モード表示を削除しました。';

  @override
  String get releaseNoteContinuousIndicator =>
      '連続モードの表示をカメラの右下に移動し、ヘッダーが大きくならないようにしました。';

  @override
  String get releaseNoteDocumentScan =>
      '画像、PDF、Officeドキュメントのスキャンが連続モードから独立して動作するようになりました。';

  @override
  String get releaseNoteScannerHint =>
      'スキャナーの説明で、このオプションが複数コードの同時スキャンを有効にすることを示すようになりました。';

  @override
  String get releaseNoteDocumentLoading =>
      'ファイルの読み込み中に「ドキュメントを解析しています…」という画面が表示されるようになりました。';

  @override
  String get releaseNoteVersioning => 'この説明は、更新後にアプリを初めて開いたときに一度だけ表示されます。';

  @override
  String get releaseNoteQuickTile =>
      'KillQRタイルに認識しやすいQRコードアイコンを使用し、名前を「KillQRでスキャン」に変更しました。';

  @override
  String get releaseNoteGitHubUpdates =>
      'GitHubのリリースを自動または手動で確認できるようにし、通知を延期または停止する設定を追加しました。';

  @override
  String get releaseNoteAccentSwitch => '複数コードのスイッチがカスタムアクセントカラーに従うようになりました。';

  @override
  String get updates => '更新';

  @override
  String get automaticUpdates => '更新を自動的に確認';

  @override
  String get automaticUpdatesHint => '1日1回GitHubを確認し、新しいバージョンがあると通知します。';

  @override
  String get checkForUpdates => '更新を確認';

  @override
  String get checkForUpdatesHint => 'KillQRの公式GitHubリリースを今すぐ確認します。';

  @override
  String get checkingUpdates => '更新を確認しています…';

  @override
  String get updateAvailable => '更新があります';

  @override
  String updateVersionAvailable(String version) {
    return 'バージョン$versionを利用できます。';
  }

  @override
  String get updateReleaseNotes => 'リリースノート';

  @override
  String get downloadUpdate => '更新をダウンロード';

  @override
  String get remindLater => '後で通知';

  @override
  String get neverRemind => '今後通知しない';

  @override
  String get noUpdatesAvailable => '最新バージョンを使用しています。';

  @override
  String get updateCheckFailed => '現在、更新を確認できませんでした。';

  @override
  String get updatesNotConfigured => 'このビルドでは自動更新が設定されていません。';

  @override
  String get updateOpenFailed => '更新のダウンロードを開けませんでした。';

  @override
  String get continueLabel => '続行';

  @override
  String get searchEngines => '検索エンジン';

  @override
  String get addSearchEngine => '検索エンジンを追加';

  @override
  String get editSearchEngine => '検索エンジンを編集';

  @override
  String get searchEngineName => '名前';

  @override
  String get searchEngineTemplate => '検索URL';

  @override
  String get searchEngineTemplateHint => 'コードを入れる場所にCODEマーカーを使用してください。';

  @override
  String get invalidSearchTemplate => 'CODEマーカーを含むhttp(s) URLを使用してください。';

  @override
  String get noSearchEngines => '検索エンジンが設定されていません。';

  @override
  String get enabled => '有効';

  @override
  String get openAppSettings => 'アプリの設定を開く';

  @override
  String get searchProduct => '商品を検索';

  @override
  String get tags => 'タグ';

  @override
  String get addTag => 'タグを追加';

  @override
  String get tagHint => 'タグ名';

  @override
  String get saveTags => 'タグを保存';

  @override
  String get noTags => 'タグなし';

  @override
  String get selectItems => '項目を選択';

  @override
  String get selectedItems => '件を選択中';

  @override
  String get exportSelected => '選択項目をエクスポート';

  @override
  String get shareSelected => '選択項目を共有';

  @override
  String get deleteSelected => '選択項目を削除';

  @override
  String get sourceFilter => 'ソース';

  @override
  String get allSources => 'すべてのソース';

  @override
  String get formatFilter => '形式';

  @override
  String get allFormats => 'すべての形式';

  @override
  String get template => 'コンテンツテンプレート';

  @override
  String get templateText => 'テキスト';

  @override
  String get templateUrl => 'URL';

  @override
  String get templateWifi => 'Wi-Fi';

  @override
  String get templateEmail => 'メール';

  @override
  String get templateSms => 'SMS';

  @override
  String get templateContact => '連絡先';
}
