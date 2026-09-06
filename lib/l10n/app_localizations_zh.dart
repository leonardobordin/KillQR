// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'KillQR';

  @override
  String get bootstrapStarting => '正在准备本地存储…';

  @override
  String get bootstrapFailed => '无法打开本地存储。';

  @override
  String get bootstrapReady => '初始化完成';

  @override
  String get bootstrapDescription => 'Android 基础功能已准备好进入下一阶段。';

  @override
  String get bootstrapErrorDetails => '您的本地数据仍然是私密的。请尝试重新打开应用。';

  @override
  String get retry => '重试';

  @override
  String get scanner => '扫描';

  @override
  String get history => '历史记录';

  @override
  String get create => '创建';

  @override
  String get settings => '设置';

  @override
  String get scanTitle => '扫描代码';

  @override
  String get scanHint => '启用此选项可同时扫描多个代码。';

  @override
  String get cameraUnavailable => '相机不可用';

  @override
  String get cameraPermission => '仅在扫描时需要相机权限。';

  @override
  String get openSettings => '打开设置';

  @override
  String get importImage => '选择图片';

  @override
  String get importDocument => '选择图片或文档';

  @override
  String get imageFiles => '图片';

  @override
  String get pdfFiles => 'PDF 文件';

  @override
  String get officeFiles => 'Office 文档';

  @override
  String get scanningFile => '正在分析文档…';

  @override
  String get codeNotFoundInFile => '在此文件中未找到二维码或条形码。';

  @override
  String get fileScanFailed => '无法读取所选文件。';

  @override
  String get fileTooLarge => '此文件太大，无法在本地扫描。';

  @override
  String get legacyOfficeUnsupported => '不支持旧版 Office 文件。请使用 DOCX、XLSX 或 PPTX。';

  @override
  String get unsupportedFileType => '不支持扫描此文件类型中的二维码。';

  @override
  String get continuousScan => '连续扫描';

  @override
  String get continuousScanDescription => '无需打开每个结果即可继续扫描。';

  @override
  String get importDocumentDescription => '从图片、PDF 或 Office 文档中读取代码。';

  @override
  String get continuousModeTitle => '连续扫描';

  @override
  String get continuousModeExplanation =>
      '启用后，KillQR 会保持相机开启，记录每个新代码，而不会打开结果页面。可在设置中调整重复读取之间的间隔。';

  @override
  String get multipleScanDescription => '从一次相机拍摄中查找多个代码。';

  @override
  String get multipleModeTitle => '多代码扫描';

  @override
  String get multipleModeExplanation =>
      '启用后，KillQR 会分析完整的相机画面，并可从一次拍摄中返回多个代码。由于使用整个画面，中央扫描框会隐藏。';

  @override
  String get doNotShowAgain => '不再显示';

  @override
  String get close => '关闭';

  @override
  String get flashlight => '手电筒';

  @override
  String get switchCamera => '切换相机';

  @override
  String get moreScannerActions => '更多扫描操作';

  @override
  String get flashUnavailable => '此相机不支持手电筒。';

  @override
  String get scanAreaSize => '扫描区域';

  @override
  String get resizeScanArea => '拖动角落调整扫描区域';

  @override
  String scanAreaValue(int percent) {
    return '扫描区域：$percent%';
  }

  @override
  String get fullCameraFrame => '完整相机画面';

  @override
  String get zoom => '缩放';

  @override
  String zoomValue(String value) {
    return '缩放：${value}x';
  }

  @override
  String get privateMode => '私密模式';

  @override
  String get privateModeHint => '本次会话的结果不会保存。';

  @override
  String get noHistory => '暂无扫描记录';

  @override
  String get noHistoryHint => '扫描结果会显示在这里。';

  @override
  String get searchHistory => '搜索历史记录';

  @override
  String get favoritesOnly => '仅收藏';

  @override
  String get allTypes => '所有类型';

  @override
  String get clearHistory => '清除历史记录';

  @override
  String get clearHistoryConfirm => '删除所有已保存的扫描记录？此操作无法撤销。';

  @override
  String get cancel => '取消';

  @override
  String get delete => '删除';

  @override
  String get save => '保存';

  @override
  String get saved => '已保存';

  @override
  String get favorite => '收藏';

  @override
  String get note => '备注';

  @override
  String get addNote => '添加备注';

  @override
  String get copy => '复制';

  @override
  String get copied => '已复制';

  @override
  String get share => '分享';

  @override
  String get scanAgain => '再次扫描';

  @override
  String get details => '详细信息';

  @override
  String get value => '值';

  @override
  String get format => '格式';

  @override
  String get type => '类型';

  @override
  String get source => '来源';

  @override
  String get warning => '警告';

  @override
  String get actions => '操作';

  @override
  String get actionOpen => '打开';

  @override
  String get actionCall => '拨打电话';

  @override
  String get actionSendSms => '编辑短信';

  @override
  String get actionSendEmail => '编辑邮件';

  @override
  String get actionOpenMap => '打开地图';

  @override
  String get actionSaveContact => '保存联系人';

  @override
  String get actionSaveEvent => '保存日程';

  @override
  String get actionWifiSettings => 'Wi-Fi 设置';

  @override
  String get confirmExternalAction => '要打开其他应用继续吗？';

  @override
  String get noAppFound => '未找到兼容的应用。';

  @override
  String get generateTitle => '创建代码';

  @override
  String get content => '内容';

  @override
  String get barcodeFormat => '条形码格式';

  @override
  String get generate => '生成';

  @override
  String get generatedPreview => '预览';

  @override
  String get savePng => '保存 PNG';

  @override
  String get savedToGallery => 'PNG 已保存到图库。';

  @override
  String get galleryPermissionDenied => '请允许存储权限，以便将 PNG 保存到图库。';

  @override
  String get gallerySaveFailed => '无法将 PNG 保存到图库。';

  @override
  String get invalidContent => '请输入内容以生成代码。';

  @override
  String get invalidBarcodeContent => '请输入符合所选格式的有效内容。';

  @override
  String get generationFailed => '无法生成代码。请检查内容。';

  @override
  String get unsupportedFormat => '此格式不支持写入。';

  @override
  String get importExport => '导入和导出';

  @override
  String get exportJson => '导出 JSON';

  @override
  String get exportCsv => '导出 CSV';

  @override
  String get importData => '导入数据';

  @override
  String get transferComplete => '传输完成。';

  @override
  String get theme => '主题';

  @override
  String get themeSystem => '跟随系统';

  @override
  String get themeLight => '浅色';

  @override
  String get themeDark => '深色';

  @override
  String get themeAmoled => 'AMOLED';

  @override
  String get accentColor => '强调色';

  @override
  String get customAccentColor => '自定义颜色';

  @override
  String get customAccentColorHint => '选择任意 RGB 颜色';

  @override
  String get hexColor => 'HEX 颜色';

  @override
  String get red => '红色';

  @override
  String get green => '绿色';

  @override
  String get blue => '蓝色';

  @override
  String get invalidHexColor => '请输入 6 位十六进制数字。';

  @override
  String get applyColor => '应用';

  @override
  String get language => '语言';

  @override
  String get languageSystem => '系统';

  @override
  String get languagePortuguese => '葡萄牙语（巴西）';

  @override
  String get languageEnglish => '英语';

  @override
  String get languageSpanish => '西班牙语';

  @override
  String get languageFrench => '法语';

  @override
  String get languageGerman => '德语';

  @override
  String get languageItalian => '意大利语';

  @override
  String get languageJapanese => '日语';

  @override
  String get languageChineseSimplified => '简体中文';

  @override
  String get saveAutomatically => '自动保存结果';

  @override
  String get debounce => '连续扫描间隔';

  @override
  String get about => '关于';

  @override
  String get privacy => '隐私';

  @override
  String get aboutText => 'KillQR 默认将扫描结果保存在本地并离线运行。只有检查更新时才会使用网络。';

  @override
  String get version => '版本 0.1.8（构建 9）';

  @override
  String get createdBy => '作者：Leonardo Silva Bordin';

  @override
  String get license => 'Apache-2.0 许可证';

  @override
  String get productSearch => '搜索产品';

  @override
  String get parserWarning => '部分字段无法安全解析。';

  @override
  String get typeText => '文本';

  @override
  String get typeUrl => 'URL';

  @override
  String get typePhone => '电话';

  @override
  String get typeSms => '短信';

  @override
  String get typeEmail => '电子邮件';

  @override
  String get typeWifi => 'Wi-Fi';

  @override
  String get typeContact => '联系人';

  @override
  String get typeGeo => '位置';

  @override
  String get typeEvent => '日程';

  @override
  String get typeProduct => '产品';

  @override
  String get typeUnknown => '未知';

  @override
  String get sourceCamera => '相机';

  @override
  String get sourceImage => '图片';

  @override
  String get sourceContinuous => '连续扫描';

  @override
  String get sourceImported => '已导入';

  @override
  String get sourceGenerated => '已生成';

  @override
  String get multipleScan => '启用多代码扫描';

  @override
  String get continuousActive => '连续';

  @override
  String get privateActive => '私密';

  @override
  String get releaseNotesImprovementsTitle => '改进';

  @override
  String get releaseNotesBugFixesTitle => '错误修复';

  @override
  String get releaseNotesTitle => 'KillQR 更新内容';

  @override
  String updatedToVersion(String version) {
    return '已更新到版本 $version';
  }

  @override
  String get releaseNotesIntro => '此版本的更改：';

  @override
  String get releaseNoteScanArea => '现在可以从右下角自由调整相机扫描区域，并独立设置宽度和高度。';

  @override
  String get releaseNoteTopControls =>
      '手电筒、切换相机、导入文档和扫描模式现在集中在顶部栏，窄屏设备会使用更多菜单。';

  @override
  String get releaseNoteZoom => '缩放控件在竖屏时为横向，在横屏时垂直显示在右侧；扫描单个代码时只分析选定的矩形区域。';

  @override
  String get releaseNoteModeHelp => '启用连续扫描和多代码模式时，现在会说明其工作方式，并可永久隐藏说明。';

  @override
  String get releaseNoteCameraOverlay => '相机遮罩现在会沿着扫描区域的圆角边框显示，不再有明亮的角落溢出轮廓。';

  @override
  String get releaseNoteContinuousIndicator => '连续模式提示现在位于相机右下角，不会再增加顶部栏高度。';

  @override
  String get releaseNoteDocumentScan => '图片、PDF 和 Office 文档扫描现在独立于连续模式运行。';

  @override
  String get releaseNoteScannerHint => '扫描器提示现在会说明此选项可以同时扫描多个代码。';

  @override
  String get releaseNoteDocumentLoading => '导入文件时会显示“正在分析文档…”窗口，直到文件读取完成。';

  @override
  String get releaseNoteVersioning => '每次更新后首次打开应用时，这些说明只会显示一次。';

  @override
  String get releaseNoteQuickTile =>
      'KillQR 快捷设置磁贴现在使用清晰可识别的二维码图标，并命名为“使用 KillQR 扫描”。';

  @override
  String get releaseNoteGitHubUpdates =>
      '新增 GitHub 发布版本的自动和手动检查，并可选择稍后提醒或停止提醒。';

  @override
  String get releaseNoteAccentSwitch => '多代码开关现在会跟随自定义强调色。';

  @override
  String get updates => '更新';

  @override
  String get automaticUpdates => '自动检查更新';

  @override
  String get automaticUpdatesHint => '每天检查一次 GitHub，并在有新版本时提醒您。';

  @override
  String get checkForUpdates => '检查更新';

  @override
  String get checkForUpdatesHint => '立即检查 GitHub 上的 KillQR 官方发布版本。';

  @override
  String get checkingUpdates => '正在检查更新…';

  @override
  String get updateAvailable => '有可用更新';

  @override
  String updateVersionAvailable(String version) {
    return '版本 $version 可用。';
  }

  @override
  String get updateReleaseNotes => '发布说明';

  @override
  String get downloadUpdate => '下载更新';

  @override
  String get remindLater => '稍后提醒';

  @override
  String get neverRemind => '不再提醒';

  @override
  String get noUpdatesAvailable => '您正在使用最新版本。';

  @override
  String get updateCheckFailed => '暂时无法检查更新。';

  @override
  String get updatesNotConfigured => '此构建未配置自动更新。';

  @override
  String get updateOpenFailed => '无法打开更新下载。';

  @override
  String get continueLabel => '继续';

  @override
  String get searchEngines => '搜索引擎';

  @override
  String get addSearchEngine => '添加搜索引擎';

  @override
  String get editSearchEngine => '编辑搜索引擎';

  @override
  String get searchEngineName => '名称';

  @override
  String get searchEngineTemplate => '搜索网址';

  @override
  String get searchEngineTemplateHint => '在代码应出现的位置使用 CODE 标记。';

  @override
  String get invalidSearchTemplate => '请使用包含 CODE 标记的 http(s) 网址。';

  @override
  String get noSearchEngines => '未配置搜索引擎。';

  @override
  String get enabled => '已启用';

  @override
  String get openAppSettings => '打开应用设置';

  @override
  String get searchProduct => '搜索产品';

  @override
  String get tags => '标签';

  @override
  String get addTag => '添加标签';

  @override
  String get tagHint => '标签名称';

  @override
  String get saveTags => '保存标签';

  @override
  String get noTags => '没有标签';

  @override
  String get selectItems => '选择项目';

  @override
  String get selectedItems => '个项目已选择';

  @override
  String get exportSelected => '导出所选项目';

  @override
  String get shareSelected => '分享所选项目';

  @override
  String get deleteSelected => '删除所选项目';

  @override
  String get sourceFilter => '来源';

  @override
  String get allSources => '所有来源';

  @override
  String get formatFilter => '格式';

  @override
  String get allFormats => '所有格式';

  @override
  String get template => '内容模板';

  @override
  String get templateText => '文本';

  @override
  String get templateUrl => 'URL';

  @override
  String get templateWifi => 'Wi-Fi';

  @override
  String get templateEmail => '电子邮件';

  @override
  String get templateSms => '短信';

  @override
  String get templateContact => '联系人';
}

/// The translations for Chinese, as used in China (`zh_CN`).
class AppLocalizationsZhCn extends AppLocalizationsZh {
  AppLocalizationsZhCn() : super('zh_CN');

  @override
  String get appTitle => 'KillQR';

  @override
  String get bootstrapStarting => '正在准备本地存储…';

  @override
  String get bootstrapFailed => '无法打开本地存储。';

  @override
  String get bootstrapReady => '初始化完成';

  @override
  String get bootstrapDescription => 'Android 基础功能已准备好进入下一阶段。';

  @override
  String get bootstrapErrorDetails => '您的本地数据仍然是私密的。请尝试重新打开应用。';

  @override
  String get retry => '重试';

  @override
  String get scanner => '扫描';

  @override
  String get history => '历史记录';

  @override
  String get create => '创建';

  @override
  String get settings => '设置';

  @override
  String get scanTitle => '扫描代码';

  @override
  String get scanHint => '启用此选项可同时扫描多个代码。';

  @override
  String get cameraUnavailable => '相机不可用';

  @override
  String get cameraPermission => '仅在扫描时需要相机权限。';

  @override
  String get openSettings => '打开设置';

  @override
  String get importImage => '选择图片';

  @override
  String get importDocument => '选择图片或文档';

  @override
  String get imageFiles => '图片';

  @override
  String get pdfFiles => 'PDF 文件';

  @override
  String get officeFiles => 'Office 文档';

  @override
  String get scanningFile => '正在分析文档…';

  @override
  String get codeNotFoundInFile => '在此文件中未找到二维码或条形码。';

  @override
  String get fileScanFailed => '无法读取所选文件。';

  @override
  String get fileTooLarge => '此文件太大，无法在本地扫描。';

  @override
  String get legacyOfficeUnsupported => '不支持旧版 Office 文件。请使用 DOCX、XLSX 或 PPTX。';

  @override
  String get unsupportedFileType => '不支持扫描此文件类型中的二维码。';

  @override
  String get continuousScan => '连续扫描';

  @override
  String get continuousScanDescription => '无需打开每个结果即可继续扫描。';

  @override
  String get importDocumentDescription => '从图片、PDF 或 Office 文档中读取代码。';

  @override
  String get continuousModeTitle => '连续扫描';

  @override
  String get continuousModeExplanation =>
      '启用后，KillQR 会保持相机开启，记录每个新代码，而不会打开结果页面。可在设置中调整重复读取之间的间隔。';

  @override
  String get multipleScanDescription => '从一次相机拍摄中查找多个代码。';

  @override
  String get multipleModeTitle => '多代码扫描';

  @override
  String get multipleModeExplanation =>
      '启用后，KillQR 会分析完整的相机画面，并可从一次拍摄中返回多个代码。由于使用整个画面，中央扫描框会隐藏。';

  @override
  String get doNotShowAgain => '不再显示';

  @override
  String get close => '关闭';

  @override
  String get flashlight => '手电筒';

  @override
  String get switchCamera => '切换相机';

  @override
  String get moreScannerActions => '更多扫描操作';

  @override
  String get flashUnavailable => '此相机不支持手电筒。';

  @override
  String get scanAreaSize => '扫描区域';

  @override
  String get resizeScanArea => '拖动角落调整扫描区域';

  @override
  String scanAreaValue(int percent) {
    return '扫描区域：$percent%';
  }

  @override
  String get fullCameraFrame => '完整相机画面';

  @override
  String get zoom => '缩放';

  @override
  String zoomValue(String value) {
    return '缩放：${value}x';
  }

  @override
  String get privateMode => '私密模式';

  @override
  String get privateModeHint => '本次会话的结果不会保存。';

  @override
  String get noHistory => '暂无扫描记录';

  @override
  String get noHistoryHint => '扫描结果会显示在这里。';

  @override
  String get searchHistory => '搜索历史记录';

  @override
  String get favoritesOnly => '仅收藏';

  @override
  String get allTypes => '所有类型';

  @override
  String get clearHistory => '清除历史记录';

  @override
  String get clearHistoryConfirm => '删除所有已保存的扫描记录？此操作无法撤销。';

  @override
  String get cancel => '取消';

  @override
  String get delete => '删除';

  @override
  String get save => '保存';

  @override
  String get saved => '已保存';

  @override
  String get favorite => '收藏';

  @override
  String get note => '备注';

  @override
  String get addNote => '添加备注';

  @override
  String get copy => '复制';

  @override
  String get copied => '已复制';

  @override
  String get share => '分享';

  @override
  String get scanAgain => '再次扫描';

  @override
  String get details => '详细信息';

  @override
  String get value => '值';

  @override
  String get format => '格式';

  @override
  String get type => '类型';

  @override
  String get source => '来源';

  @override
  String get warning => '警告';

  @override
  String get actions => '操作';

  @override
  String get actionOpen => '打开';

  @override
  String get actionCall => '拨打电话';

  @override
  String get actionSendSms => '编辑短信';

  @override
  String get actionSendEmail => '编辑邮件';

  @override
  String get actionOpenMap => '打开地图';

  @override
  String get actionSaveContact => '保存联系人';

  @override
  String get actionSaveEvent => '保存日程';

  @override
  String get actionWifiSettings => 'Wi-Fi 设置';

  @override
  String get confirmExternalAction => '要打开其他应用继续吗？';

  @override
  String get noAppFound => '未找到兼容的应用。';

  @override
  String get generateTitle => '创建代码';

  @override
  String get content => '内容';

  @override
  String get barcodeFormat => '条形码格式';

  @override
  String get generate => '生成';

  @override
  String get generatedPreview => '预览';

  @override
  String get savePng => '保存 PNG';

  @override
  String get savedToGallery => 'PNG 已保存到图库。';

  @override
  String get galleryPermissionDenied => '请允许存储权限，以便将 PNG 保存到图库。';

  @override
  String get gallerySaveFailed => '无法将 PNG 保存到图库。';

  @override
  String get invalidContent => '请输入内容以生成代码。';

  @override
  String get invalidBarcodeContent => '请输入符合所选格式的有效内容。';

  @override
  String get generationFailed => '无法生成代码。请检查内容。';

  @override
  String get unsupportedFormat => '此格式不支持写入。';

  @override
  String get importExport => '导入和导出';

  @override
  String get exportJson => '导出 JSON';

  @override
  String get exportCsv => '导出 CSV';

  @override
  String get importData => '导入数据';

  @override
  String get transferComplete => '传输完成。';

  @override
  String get theme => '主题';

  @override
  String get themeSystem => '跟随系统';

  @override
  String get themeLight => '浅色';

  @override
  String get themeDark => '深色';

  @override
  String get themeAmoled => 'AMOLED';

  @override
  String get accentColor => '强调色';

  @override
  String get customAccentColor => '自定义颜色';

  @override
  String get customAccentColorHint => '选择任意 RGB 颜色';

  @override
  String get hexColor => 'HEX 颜色';

  @override
  String get red => '红色';

  @override
  String get green => '绿色';

  @override
  String get blue => '蓝色';

  @override
  String get invalidHexColor => '请输入 6 位十六进制数字。';

  @override
  String get applyColor => '应用';

  @override
  String get language => '语言';

  @override
  String get languageSystem => '系统';

  @override
  String get languagePortuguese => '葡萄牙语（巴西）';

  @override
  String get languageEnglish => '英语';

  @override
  String get languageSpanish => '西班牙语';

  @override
  String get languageFrench => '法语';

  @override
  String get languageGerman => '德语';

  @override
  String get languageItalian => '意大利语';

  @override
  String get languageJapanese => '日语';

  @override
  String get languageChineseSimplified => '简体中文';

  @override
  String get saveAutomatically => '自动保存结果';

  @override
  String get debounce => '连续扫描间隔';

  @override
  String get about => '关于';

  @override
  String get privacy => '隐私';

  @override
  String get aboutText => 'KillQR 默认将扫描结果保存在本地并离线运行。只有检查更新时才会使用网络。';

  @override
  String get version => '版本 0.1.8（构建 9）';

  @override
  String get createdBy => '作者：Leonardo Silva Bordin';

  @override
  String get license => 'Apache-2.0 许可证';

  @override
  String get productSearch => '搜索产品';

  @override
  String get parserWarning => '部分字段无法安全解析。';

  @override
  String get typeText => '文本';

  @override
  String get typeUrl => 'URL';

  @override
  String get typePhone => '电话';

  @override
  String get typeSms => '短信';

  @override
  String get typeEmail => '电子邮件';

  @override
  String get typeWifi => 'Wi-Fi';

  @override
  String get typeContact => '联系人';

  @override
  String get typeGeo => '位置';

  @override
  String get typeEvent => '日程';

  @override
  String get typeProduct => '产品';

  @override
  String get typeUnknown => '未知';

  @override
  String get sourceCamera => '相机';

  @override
  String get sourceImage => '图片';

  @override
  String get sourceContinuous => '连续扫描';

  @override
  String get sourceImported => '已导入';

  @override
  String get sourceGenerated => '已生成';

  @override
  String get multipleScan => '启用多代码扫描';

  @override
  String get continuousActive => '连续';

  @override
  String get privateActive => '私密';

  @override
  String get releaseNotesImprovementsTitle => '改进';

  @override
  String get releaseNotesBugFixesTitle => '错误修复';

  @override
  String get releaseNotesTitle => 'KillQR 更新内容';

  @override
  String updatedToVersion(String version) {
    return '已更新到版本 $version';
  }

  @override
  String get releaseNotesIntro => '此版本的更改：';

  @override
  String get releaseNoteScanArea => '现在可以从右下角自由调整相机扫描区域，并独立设置宽度和高度。';

  @override
  String get releaseNoteTopControls =>
      '手电筒、切换相机、导入文档和扫描模式现在集中在顶部栏，窄屏设备会使用更多菜单。';

  @override
  String get releaseNoteZoom => '缩放控件在竖屏时为横向，在横屏时垂直显示在右侧；扫描单个代码时只分析选定的矩形区域。';

  @override
  String get releaseNoteModeHelp => '启用连续扫描和多代码模式时，现在会说明其工作方式，并可永久隐藏说明。';

  @override
  String get releaseNoteCameraOverlay => '相机遮罩现在会沿着扫描区域的圆角边框显示，不再有明亮的角落溢出轮廓。';

  @override
  String get releaseNoteContinuousIndicator => '连续模式提示现在位于相机右下角，不会再增加顶部栏高度。';

  @override
  String get releaseNoteDocumentScan => '图片、PDF 和 Office 文档扫描现在独立于连续模式运行。';

  @override
  String get releaseNoteScannerHint => '扫描器提示现在会说明此选项可以同时扫描多个代码。';

  @override
  String get releaseNoteDocumentLoading => '导入文件时会显示“正在分析文档…”窗口，直到文件读取完成。';

  @override
  String get releaseNoteVersioning => '每次更新后首次打开应用时，这些说明只会显示一次。';

  @override
  String get releaseNoteQuickTile =>
      'KillQR 快捷设置磁贴现在使用清晰可识别的二维码图标，并命名为“使用 KillQR 扫描”。';

  @override
  String get releaseNoteGitHubUpdates =>
      '新增 GitHub 发布版本的自动和手动检查，并可选择稍后提醒或停止提醒。';

  @override
  String get releaseNoteAccentSwitch => '多代码开关现在会跟随自定义强调色。';

  @override
  String get updates => '更新';

  @override
  String get automaticUpdates => '自动检查更新';

  @override
  String get automaticUpdatesHint => '每天检查一次 GitHub，并在有新版本时提醒您。';

  @override
  String get checkForUpdates => '检查更新';

  @override
  String get checkForUpdatesHint => '立即检查 GitHub 上的 KillQR 官方发布版本。';

  @override
  String get checkingUpdates => '正在检查更新…';

  @override
  String get updateAvailable => '有可用更新';

  @override
  String updateVersionAvailable(String version) {
    return '版本 $version 可用。';
  }

  @override
  String get updateReleaseNotes => '发布说明';

  @override
  String get downloadUpdate => '下载更新';

  @override
  String get remindLater => '稍后提醒';

  @override
  String get neverRemind => '不再提醒';

  @override
  String get noUpdatesAvailable => '您正在使用最新版本。';

  @override
  String get updateCheckFailed => '暂时无法检查更新。';

  @override
  String get updatesNotConfigured => '此构建未配置自动更新。';

  @override
  String get updateOpenFailed => '无法打开更新下载。';

  @override
  String get continueLabel => '继续';

  @override
  String get searchEngines => '搜索引擎';

  @override
  String get addSearchEngine => '添加搜索引擎';

  @override
  String get editSearchEngine => '编辑搜索引擎';

  @override
  String get searchEngineName => '名称';

  @override
  String get searchEngineTemplate => '搜索网址';

  @override
  String get searchEngineTemplateHint => '在代码应出现的位置使用 CODE 标记。';

  @override
  String get invalidSearchTemplate => '请使用包含 CODE 标记的 http(s) 网址。';

  @override
  String get noSearchEngines => '未配置搜索引擎。';

  @override
  String get enabled => '已启用';

  @override
  String get openAppSettings => '打开应用设置';

  @override
  String get searchProduct => '搜索产品';

  @override
  String get tags => '标签';

  @override
  String get addTag => '添加标签';

  @override
  String get tagHint => '标签名称';

  @override
  String get saveTags => '保存标签';

  @override
  String get noTags => '没有标签';

  @override
  String get selectItems => '选择项目';

  @override
  String get selectedItems => '个项目已选择';

  @override
  String get exportSelected => '导出所选项目';

  @override
  String get shareSelected => '分享所选项目';

  @override
  String get deleteSelected => '删除所选项目';

  @override
  String get sourceFilter => '来源';

  @override
  String get allSources => '所有来源';

  @override
  String get formatFilter => '格式';

  @override
  String get allFormats => '所有格式';

  @override
  String get template => '内容模板';

  @override
  String get templateText => '文本';

  @override
  String get templateUrl => 'URL';

  @override
  String get templateWifi => 'Wi-Fi';

  @override
  String get templateEmail => '电子邮件';

  @override
  String get templateSms => '短信';

  @override
  String get templateContact => '联系人';
}
