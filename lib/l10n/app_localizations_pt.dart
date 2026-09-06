// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'KillQR';

  @override
  String get bootstrapStarting => 'Preparando o armazenamento local…';

  @override
  String get bootstrapFailed => 'Não foi possível abrir o armazenamento local.';

  @override
  String get bootstrapReady => 'Bootstrap pronto';

  @override
  String get bootstrapDescription =>
      'A fundação Android está pronta para a próxima fase.';

  @override
  String get bootstrapErrorDetails =>
      'Seus dados locais continuam privados. Tente abrir o app novamente.';

  @override
  String get retry => 'Tentar novamente';

  @override
  String get scanner => 'Ler';

  @override
  String get history => 'Histórico';

  @override
  String get create => 'Criar';

  @override
  String get settings => 'Configurações';

  @override
  String get scanTitle => 'Ler um código';

  @override
  String get scanHint =>
      'Ative esta opção para escanear vários códigos ao mesmo tempo.';

  @override
  String get cameraUnavailable => 'Câmera indisponível';

  @override
  String get cameraPermission =>
      'O acesso à câmera é necessário somente durante a leitura.';

  @override
  String get openSettings => 'Abrir configurações';

  @override
  String get importImage => 'Escolher imagem';

  @override
  String get importDocument => 'Escolher imagem ou documento';

  @override
  String get imageFiles => 'Imagens';

  @override
  String get pdfFiles => 'Arquivos PDF';

  @override
  String get officeFiles => 'Documentos Office';

  @override
  String get scanningFile => 'Analisando documento…';

  @override
  String get codeNotFoundInFile =>
      'Nenhum QR Code ou código de barras foi encontrado neste arquivo.';

  @override
  String get fileScanFailed => 'Não foi possível ler o arquivo selecionado.';

  @override
  String get fileTooLarge => 'Este arquivo é grande demais para leitura local.';

  @override
  String get legacyOfficeUnsupported =>
      'Arquivos Office antigos não são compatíveis. Use DOCX, XLSX ou PPTX.';

  @override
  String get unsupportedFileType =>
      'Este tipo de arquivo não é compatível com a leitura de QR Code.';

  @override
  String get continuousScan => 'Leitura contínua';

  @override
  String get privateMode => 'Modo privado';

  @override
  String get privateModeHint => 'Os resultados desta sessão não serão salvos.';

  @override
  String get noHistory => 'Nenhuma leitura ainda';

  @override
  String get noHistoryHint => 'Os resultados lidos aparecerão aqui.';

  @override
  String get searchHistory => 'Pesquisar no histórico';

  @override
  String get favoritesOnly => 'Somente favoritos';

  @override
  String get allTypes => 'Todos os tipos';

  @override
  String get clearHistory => 'Limpar histórico';

  @override
  String get clearHistoryConfirm =>
      'Excluir todas as leituras salvas? Não é possível desfazer.';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Excluir';

  @override
  String get save => 'Salvar';

  @override
  String get saved => 'Salvo';

  @override
  String get favorite => 'Favorito';

  @override
  String get note => 'Nota';

  @override
  String get addNote => 'Adicionar uma nota';

  @override
  String get copy => 'Copiar';

  @override
  String get copied => 'Copiado';

  @override
  String get share => 'Compartilhar';

  @override
  String get scanAgain => 'Ler novamente';

  @override
  String get details => 'Detalhes';

  @override
  String get value => 'Valor';

  @override
  String get format => 'Formato';

  @override
  String get type => 'Tipo';

  @override
  String get source => 'Origem';

  @override
  String get warning => 'Aviso';

  @override
  String get actions => 'Ações';

  @override
  String get actionOpen => 'Abrir';

  @override
  String get actionCall => 'Ligar';

  @override
  String get actionSendSms => 'Compor SMS';

  @override
  String get actionSendEmail => 'Compor e-mail';

  @override
  String get actionOpenMap => 'Abrir mapa';

  @override
  String get actionSaveContact => 'Salvar contato';

  @override
  String get actionSaveEvent => 'Salvar evento';

  @override
  String get actionWifiSettings => 'Configurações de Wi-Fi';

  @override
  String get confirmExternalAction => 'Abrir outro app para continuar?';

  @override
  String get noAppFound => 'Nenhum app compatível foi encontrado.';

  @override
  String get generateTitle => 'Criar um código';

  @override
  String get content => 'Conteúdo';

  @override
  String get barcodeFormat => 'Formato do código';

  @override
  String get generate => 'Gerar';

  @override
  String get generatedPreview => 'Prévia';

  @override
  String get savePng => 'Salvar PNG';

  @override
  String get savedToGallery => 'PNG salvo na galeria.';

  @override
  String get galleryPermissionDenied =>
      'Permita o acesso ao armazenamento para salvar o PNG na galeria.';

  @override
  String get gallerySaveFailed => 'Não foi possível salvar o PNG na galeria.';

  @override
  String get invalidContent => 'Digite um conteúdo para gerar o código.';

  @override
  String get invalidBarcodeContent =>
      'Informe um conteúdo válido para o formato selecionado.';

  @override
  String get generationFailed =>
      'Não foi possível gerar o código. Verifique o conteúdo.';

  @override
  String get unsupportedFormat =>
      'Este formato não está disponível para escrita.';

  @override
  String get importExport => 'Importar e exportar';

  @override
  String get exportJson => 'Exportar JSON';

  @override
  String get exportCsv => 'Exportar CSV';

  @override
  String get importData => 'Importar dados';

  @override
  String get transferComplete => 'Transferência concluída.';

  @override
  String get theme => 'Tema';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Escuro';

  @override
  String get themeAmoled => 'AMOLED';

  @override
  String get accentColor => 'Cor de destaque';

  @override
  String get customAccentColor => 'Cor personalizada';

  @override
  String get customAccentColorHint => 'Escolha qualquer cor RGB';

  @override
  String get hexColor => 'Cor HEX';

  @override
  String get red => 'Vermelho';

  @override
  String get green => 'Verde';

  @override
  String get blue => 'Azul';

  @override
  String get invalidHexColor => 'Informe 6 dígitos hexadecimais.';

  @override
  String get applyColor => 'Aplicar';

  @override
  String get language => 'Idioma';

  @override
  String get languageSystem => 'Sistema';

  @override
  String get languagePortuguese => 'Português (Brasil)';

  @override
  String get languageEnglish => 'English';

  @override
  String get saveAutomatically => 'Salvar resultados automaticamente';

  @override
  String get debounce => 'Atraso da leitura contínua';

  @override
  String get about => 'Sobre';

  @override
  String get privacy => 'Privacidade';

  @override
  String get aboutText =>
      'O KillQR armazena leituras localmente e funciona offline por padrão. A rede é usada somente ao verificar atualizações.';

  @override
  String get version => 'Versão 0.1.5 (build 6)';

  @override
  String get createdBy => 'Feito por Leonardo Silva Bordin';

  @override
  String get license => 'Licença Apache-2.0';

  @override
  String get productSearch => 'Pesquisar produto';

  @override
  String get parserWarning =>
      'Alguns campos não puderam ser interpretados com segurança.';

  @override
  String get typeText => 'Texto';

  @override
  String get typeUrl => 'URL';

  @override
  String get typePhone => 'Telefone';

  @override
  String get typeSms => 'SMS';

  @override
  String get typeEmail => 'E-mail';

  @override
  String get typeWifi => 'Wi-Fi';

  @override
  String get typeContact => 'Contato';

  @override
  String get typeGeo => 'Localização';

  @override
  String get typeEvent => 'Evento';

  @override
  String get typeProduct => 'Produto';

  @override
  String get typeUnknown => 'Desconhecido';

  @override
  String get sourceCamera => 'Câmera';

  @override
  String get sourceImage => 'Imagem';

  @override
  String get sourceContinuous => 'Leitura contínua';

  @override
  String get sourceImported => 'Importado';

  @override
  String get sourceGenerated => 'Gerado';

  @override
  String get multipleScan => 'Ativar leitura de vários códigos';

  @override
  String get continuousActive => 'CONTÍNUA';

  @override
  String get privateActive => 'PRIVADO';

  @override
  String get releaseNotesImprovementsTitle => 'Melhorias';

  @override
  String get releaseNotesBugFixesTitle => 'Correções de bugs';

  @override
  String get releaseNotesTitle => 'Novidades do KillQR';

  @override
  String updatedToVersion(String version) {
    return 'Atualizado para a versão $version';
  }

  @override
  String get releaseNotesIntro => 'O que mudou nesta versão:';

  @override
  String get releaseNoteContinuousIndicator =>
      'O indicador do modo contínuo agora fica no canto inferior direito da câmera, sem aumentar o cabeçalho.';

  @override
  String get releaseNoteDocumentScan =>
      'A leitura de imagens, PDFs e documentos Office funciona de forma independente do modo contínuo.';

  @override
  String get releaseNoteScannerHint =>
      'A instrução do scanner agora explica que esta opção ativa a leitura de vários códigos ao mesmo tempo.';

  @override
  String get releaseNoteDocumentLoading =>
      'A importação agora mostra uma janela de carregamento com a mensagem “Analisando documento…” durante a leitura.';

  @override
  String get releaseNoteVersioning =>
      'As novidades aparecem uma vez na primeira abertura depois de cada atualização.';

  @override
  String get releaseNoteQuickTile =>
      'O tile do KillQR agora usa um ícone de QR Code reconhecível e o nome “Escanear com KillQR”.';

  @override
  String get releaseNoteGitHubUpdates =>
      'Adicionada a verificação automática e manual de releases do GitHub, com opções para adiar ou interromper os avisos.';

  @override
  String get releaseNoteAccentSwitch =>
      'O botão de vários códigos agora acompanha a cor de destaque personalizada.';

  @override
  String get updates => 'Atualizações';

  @override
  String get automaticUpdates => 'Buscar atualizações automaticamente';

  @override
  String get automaticUpdatesHint =>
      'Consulta o GitHub uma vez por dia e avisa quando há uma nova versão.';

  @override
  String get checkForUpdates => 'Verificar atualizações';

  @override
  String get checkForUpdatesHint =>
      'Consultar agora as releases oficiais do KillQR no GitHub.';

  @override
  String get checkingUpdates => 'Verificando atualizações…';

  @override
  String get updateAvailable => 'Atualização disponível';

  @override
  String updateVersionAvailable(String version) {
    return 'A versão $version está disponível.';
  }

  @override
  String get updateReleaseNotes => 'Notas da versão';

  @override
  String get downloadUpdate => 'Baixar atualização';

  @override
  String get remindLater => 'Lembrar mais tarde';

  @override
  String get neverRemind => 'Não lembrar mais';

  @override
  String get noUpdatesAvailable => 'Você já está usando a versão mais recente.';

  @override
  String get updateCheckFailed =>
      'Não foi possível verificar atualizações agora.';

  @override
  String get updatesNotConfigured =>
      'As atualizações automáticas não estão configuradas nesta build.';

  @override
  String get updateOpenFailed =>
      'Não foi possível abrir o download da atualização.';

  @override
  String get continueLabel => 'Continuar';

  @override
  String get searchEngines => 'Mecanismos de busca';

  @override
  String get addSearchEngine => 'Adicionar mecanismo';

  @override
  String get editSearchEngine => 'Editar mecanismo';

  @override
  String get searchEngineName => 'Nome';

  @override
  String get searchEngineTemplate => 'URL do mecanismo';

  @override
  String get searchEngineTemplateHint =>
      'Use o marcador CODE no lugar do código.';

  @override
  String get invalidSearchTemplate =>
      'Use uma URL http(s) com o marcador CODE.';

  @override
  String get noSearchEngines => 'Nenhum mecanismo configurado.';

  @override
  String get enabled => 'Ativo';

  @override
  String get openAppSettings => 'Abrir configurações do app';

  @override
  String get searchProduct => 'Pesquisar produto';

  @override
  String get tags => 'Etiquetas';

  @override
  String get addTag => 'Adicionar etiqueta';

  @override
  String get tagHint => 'Nome da etiqueta';

  @override
  String get saveTags => 'Salvar etiquetas';

  @override
  String get noTags => 'Nenhuma etiqueta';

  @override
  String get selectItems => 'Selecionar itens';

  @override
  String get selectedItems => 'itens selecionados';

  @override
  String get exportSelected => 'Exportar selecionados';

  @override
  String get shareSelected => 'Compartilhar selecionados';

  @override
  String get deleteSelected => 'Excluir selecionados';

  @override
  String get sourceFilter => 'Origem';

  @override
  String get allSources => 'Todas as origens';

  @override
  String get formatFilter => 'Formato';

  @override
  String get allFormats => 'Todos os formatos';

  @override
  String get template => 'Modelo de conteúdo';

  @override
  String get templateText => 'Texto';

  @override
  String get templateUrl => 'URL';

  @override
  String get templateWifi => 'Wi-Fi';

  @override
  String get templateEmail => 'E-mail';

  @override
  String get templateSms => 'SMS';

  @override
  String get templateContact => 'Contato';
}

/// The translations for Portuguese, as used in Brazil (`pt_BR`).
class AppLocalizationsPtBr extends AppLocalizationsPt {
  AppLocalizationsPtBr() : super('pt_BR');

  @override
  String get appTitle => 'KillQR';

  @override
  String get bootstrapStarting => 'Preparando o armazenamento local…';

  @override
  String get bootstrapFailed => 'Não foi possível abrir o armazenamento local.';

  @override
  String get bootstrapReady => 'Bootstrap pronto';

  @override
  String get bootstrapDescription =>
      'A fundação Android está pronta para a próxima fase.';

  @override
  String get bootstrapErrorDetails =>
      'Seus dados locais continuam privados. Tente abrir o app novamente.';

  @override
  String get retry => 'Tentar novamente';

  @override
  String get scanner => 'Ler';

  @override
  String get history => 'Histórico';

  @override
  String get create => 'Criar';

  @override
  String get settings => 'Configurações';

  @override
  String get scanTitle => 'Ler um código';

  @override
  String get scanHint =>
      'Ative esta opção para escanear vários códigos ao mesmo tempo.';

  @override
  String get cameraUnavailable => 'Câmera indisponível';

  @override
  String get cameraPermission =>
      'O acesso à câmera é necessário somente durante a leitura.';

  @override
  String get openSettings => 'Abrir configurações';

  @override
  String get importImage => 'Escolher imagem';

  @override
  String get scanningFile => 'Analisando documento…';

  @override
  String get continuousScan => 'Leitura contínua';

  @override
  String get privateMode => 'Modo privado';

  @override
  String get privateModeHint => 'Os resultados desta sessão não serão salvos.';

  @override
  String get noHistory => 'Nenhuma leitura ainda';

  @override
  String get noHistoryHint => 'Os resultados lidos aparecerão aqui.';

  @override
  String get searchHistory => 'Pesquisar no histórico';

  @override
  String get favoritesOnly => 'Somente favoritos';

  @override
  String get allTypes => 'Todos os tipos';

  @override
  String get clearHistory => 'Limpar histórico';

  @override
  String get clearHistoryConfirm =>
      'Excluir todas as leituras salvas? Não é possível desfazer.';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Excluir';

  @override
  String get save => 'Salvar';

  @override
  String get saved => 'Salvo';

  @override
  String get favorite => 'Favorito';

  @override
  String get note => 'Nota';

  @override
  String get addNote => 'Adicionar uma nota';

  @override
  String get copy => 'Copiar';

  @override
  String get copied => 'Copiado';

  @override
  String get share => 'Compartilhar';

  @override
  String get scanAgain => 'Ler novamente';

  @override
  String get details => 'Detalhes';

  @override
  String get value => 'Valor';

  @override
  String get format => 'Formato';

  @override
  String get type => 'Tipo';

  @override
  String get source => 'Origem';

  @override
  String get warning => 'Aviso';

  @override
  String get actions => 'Ações';

  @override
  String get actionOpen => 'Abrir';

  @override
  String get actionCall => 'Ligar';

  @override
  String get actionSendSms => 'Compor SMS';

  @override
  String get actionSendEmail => 'Compor e-mail';

  @override
  String get actionOpenMap => 'Abrir mapa';

  @override
  String get actionSaveContact => 'Salvar contato';

  @override
  String get actionSaveEvent => 'Salvar evento';

  @override
  String get actionWifiSettings => 'Configurações de Wi-Fi';

  @override
  String get confirmExternalAction => 'Abrir outro app para continuar?';

  @override
  String get noAppFound => 'Nenhum app compatível foi encontrado.';

  @override
  String get generateTitle => 'Criar um código';

  @override
  String get content => 'Conteúdo';

  @override
  String get barcodeFormat => 'Formato do código';

  @override
  String get generate => 'Gerar';

  @override
  String get generatedPreview => 'Prévia';

  @override
  String get savePng => 'Salvar PNG';

  @override
  String get savedToGallery => 'PNG salvo na galeria.';

  @override
  String get galleryPermissionDenied =>
      'Permita o acesso ao armazenamento para salvar o PNG na galeria.';

  @override
  String get gallerySaveFailed => 'Não foi possível salvar o PNG na galeria.';

  @override
  String get invalidContent => 'Digite um conteúdo para gerar o código.';

  @override
  String get invalidBarcodeContent =>
      'Informe um conteúdo válido para o formato selecionado.';

  @override
  String get generationFailed =>
      'Não foi possível gerar o código. Verifique o conteúdo.';

  @override
  String get unsupportedFormat =>
      'Este formato não está disponível para escrita.';

  @override
  String get importExport => 'Importar e exportar';

  @override
  String get exportJson => 'Exportar JSON';

  @override
  String get exportCsv => 'Exportar CSV';

  @override
  String get importData => 'Importar dados';

  @override
  String get transferComplete => 'Transferência concluída.';

  @override
  String get theme => 'Tema';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Escuro';

  @override
  String get themeAmoled => 'AMOLED';

  @override
  String get accentColor => 'Cor de destaque';

  @override
  String get customAccentColor => 'Cor personalizada';

  @override
  String get customAccentColorHint => 'Escolha qualquer cor RGB';

  @override
  String get hexColor => 'Cor HEX';

  @override
  String get red => 'Vermelho';

  @override
  String get green => 'Verde';

  @override
  String get blue => 'Azul';

  @override
  String get invalidHexColor => 'Informe 6 dígitos hexadecimais.';

  @override
  String get applyColor => 'Aplicar';

  @override
  String get language => 'Idioma';

  @override
  String get languageSystem => 'Sistema';

  @override
  String get languagePortuguese => 'Português (Brasil)';

  @override
  String get languageEnglish => 'English';

  @override
  String get saveAutomatically => 'Salvar resultados automaticamente';

  @override
  String get debounce => 'Atraso da leitura contínua';

  @override
  String get about => 'Sobre';

  @override
  String get privacy => 'Privacidade';

  @override
  String get aboutText =>
      'O KillQR armazena leituras localmente e funciona offline por padrão. A rede é usada somente ao verificar atualizações.';

  @override
  String get version => 'Versão 0.1.5 (build 6)';

  @override
  String get createdBy => 'Feito por Leonardo Silva Bordin';

  @override
  String get license => 'Licença Apache-2.0';

  @override
  String get productSearch => 'Pesquisar produto';

  @override
  String get parserWarning =>
      'Alguns campos não puderam ser interpretados com segurança.';

  @override
  String get typeText => 'Texto';

  @override
  String get typeUrl => 'URL';

  @override
  String get typePhone => 'Telefone';

  @override
  String get typeSms => 'SMS';

  @override
  String get typeEmail => 'E-mail';

  @override
  String get typeWifi => 'Wi-Fi';

  @override
  String get typeContact => 'Contato';

  @override
  String get typeGeo => 'Localização';

  @override
  String get typeEvent => 'Evento';

  @override
  String get typeProduct => 'Produto';

  @override
  String get typeUnknown => 'Desconhecido';

  @override
  String get sourceCamera => 'Câmera';

  @override
  String get sourceImage => 'Imagem';

  @override
  String get sourceContinuous => 'Leitura contínua';

  @override
  String get sourceImported => 'Importado';

  @override
  String get sourceGenerated => 'Gerado';

  @override
  String get multipleScan => 'Ativar leitura de vários códigos';

  @override
  String get continuousActive => 'CONTÍNUA';

  @override
  String get privateActive => 'PRIVADO';

  @override
  String get releaseNotesImprovementsTitle => 'Melhorias';

  @override
  String get releaseNotesBugFixesTitle => 'Correções de bugs';

  @override
  String get releaseNotesTitle => 'Novidades do KillQR';

  @override
  String updatedToVersion(String version) {
    return 'Atualizado para a versão $version';
  }

  @override
  String get releaseNotesIntro => 'O que mudou nesta versão:';

  @override
  String get releaseNoteContinuousIndicator =>
      'O indicador do modo contínuo agora fica no canto inferior direito da câmera, sem aumentar o cabeçalho.';

  @override
  String get releaseNoteDocumentScan =>
      'A leitura de imagens, PDFs e documentos Office funciona de forma independente do modo contínuo.';

  @override
  String get releaseNoteScannerHint =>
      'A instrução do scanner agora explica que esta opção ativa a leitura de vários códigos ao mesmo tempo.';

  @override
  String get releaseNoteDocumentLoading =>
      'A importação agora mostra uma janela de carregamento com a mensagem “Analisando documento…” durante a leitura.';

  @override
  String get releaseNoteVersioning =>
      'As novidades aparecem uma vez na primeira abertura depois de cada atualização.';

  @override
  String get releaseNoteQuickTile =>
      'O tile do KillQR agora usa um ícone de QR Code reconhecível e o nome “Escanear com KillQR”.';

  @override
  String get releaseNoteGitHubUpdates =>
      'Adicionada a verificação automática e manual de releases do GitHub, com opções para adiar ou interromper os avisos.';

  @override
  String get releaseNoteAccentSwitch =>
      'O botão de vários códigos agora acompanha a cor de destaque personalizada.';

  @override
  String get updates => 'Atualizações';

  @override
  String get automaticUpdates => 'Buscar atualizações automaticamente';

  @override
  String get automaticUpdatesHint =>
      'Consulta o GitHub uma vez por dia e avisa quando há uma nova versão.';

  @override
  String get checkForUpdates => 'Verificar atualizações';

  @override
  String get checkForUpdatesHint =>
      'Consultar agora as releases oficiais do KillQR no GitHub.';

  @override
  String get checkingUpdates => 'Verificando atualizações…';

  @override
  String get updateAvailable => 'Atualização disponível';

  @override
  String updateVersionAvailable(String version) {
    return 'A versão $version está disponível.';
  }

  @override
  String get updateReleaseNotes => 'Notas da versão';

  @override
  String get downloadUpdate => 'Baixar atualização';

  @override
  String get remindLater => 'Lembrar mais tarde';

  @override
  String get neverRemind => 'Não lembrar mais';

  @override
  String get noUpdatesAvailable => 'Você já está usando a versão mais recente.';

  @override
  String get updateCheckFailed =>
      'Não foi possível verificar atualizações agora.';

  @override
  String get updatesNotConfigured =>
      'As atualizações automáticas não estão configuradas nesta build.';

  @override
  String get updateOpenFailed =>
      'Não foi possível abrir o download da atualização.';

  @override
  String get continueLabel => 'Continuar';

  @override
  String get searchEngines => 'Mecanismos de busca';

  @override
  String get addSearchEngine => 'Adicionar mecanismo';

  @override
  String get editSearchEngine => 'Editar mecanismo';

  @override
  String get searchEngineName => 'Nome';

  @override
  String get searchEngineTemplate => 'URL do mecanismo';

  @override
  String get searchEngineTemplateHint =>
      'Use o marcador CODE no lugar do código.';

  @override
  String get invalidSearchTemplate =>
      'Use uma URL http(s) com o marcador CODE.';

  @override
  String get noSearchEngines => 'Nenhum mecanismo configurado.';

  @override
  String get enabled => 'Ativo';

  @override
  String get openAppSettings => 'Abrir configurações do app';

  @override
  String get searchProduct => 'Pesquisar produto';

  @override
  String get tags => 'Etiquetas';

  @override
  String get addTag => 'Adicionar etiqueta';

  @override
  String get tagHint => 'Nome da etiqueta';

  @override
  String get saveTags => 'Salvar etiquetas';

  @override
  String get noTags => 'Nenhuma etiqueta';

  @override
  String get selectItems => 'Selecionar itens';

  @override
  String get selectedItems => 'itens selecionados';

  @override
  String get exportSelected => 'Exportar selecionados';

  @override
  String get shareSelected => 'Compartilhar selecionados';

  @override
  String get deleteSelected => 'Excluir selecionados';

  @override
  String get sourceFilter => 'Origem';

  @override
  String get allSources => 'Todas as origens';

  @override
  String get formatFilter => 'Formato';

  @override
  String get allFormats => 'Todos os formatos';

  @override
  String get template => 'Modelo de conteúdo';

  @override
  String get templateText => 'Texto';

  @override
  String get templateUrl => 'URL';

  @override
  String get templateWifi => 'Wi-Fi';

  @override
  String get templateEmail => 'E-mail';

  @override
  String get templateSms => 'SMS';

  @override
  String get templateContact => 'Contato';
}
