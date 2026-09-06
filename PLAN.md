# PLAN.md — KillQR

Status: implementação das Fases 1–12 concluída localmente; pacote Fase 13 preparado; API 26 e API 36 x86_64 validadas; ARM64, testes físicos/TalkBack e F-Droid ainda pendentes  
Data da descoberta: 2026-09-05  
Versão planejada do primeiro release: 0.1.3  
Versão/build atual do candidato: 0.1.5+6  
Escopo desta execução: Fases 1–13 implementadas sem publicação externa; pendências externas estão registradas como risco, não como código ausente

## Regra de governança

Este arquivo é a fonte de verdade do projeto. A implementação só pode começar quando o usuário responder exatamente:

~~~text
APROVAR PLANO
~~~

Até essa aprovação, não devem ser criados pubspec.yaml, código Dart, projeto Android, scripts de build, arquivos de licença ou qualquer outro artefato de implementação. Nesta primeira execução, o único arquivo novo permitido é este PLAN.md.

Marcadores usados abaixo:

- [x] concluído e validado nesta descoberta documental ou de ambiente;
- [~] em andamento;
- [ ] ainda não iniciado;
- [!] bloqueado ou dependente de decisão/validação externa.

Uma tarefa de código só poderá receber [x] depois de passar pelos gates de qualidade definidos na seção 25. A marcação [x] da Fase 0 significa que a descoberta e este plano foram entregues, não que exista uma aplicação implementada.

## 1. Visão geral

KillQR será um aplicativo Android nativo em experiência, construído com Flutter, para:

- ler QR Codes e códigos de barras pela câmera;
- ler uma ou várias simbologias em uma imagem da galeria;
- interpretar o conteúdo com segurança e oferecer ações inteligentes;
- salvar, consultar, filtrar, favoritar, etiquetar e anotar o histórico local;
- gerar códigos apenas nos formatos efetivamente suportados pelo motor escolhido;
- importar e exportar dados em JSON e CSV;
- funcionar sem conta, servidor, sincronização, telemetria, anúncios ou acesso à internet.

O repositório entregue para a descoberta contém apenas prompt.md; não há projeto Flutter, pubspec.yaml, pasta android/, testes ou histórico Git. O ambiente local, contudo, está preparado para o bootstrap: Flutter 3.47.2 stable, Dart 3.13.2, Android SDK 36.1.0/37.0 instalado, Java 25.0.2, NDK 28.2 e 29.0, Build Tools 36.0.0 e 36.1.0, ADB 37.0.1 e todas as licenças Android aceitas.

## 2. Objetivos e princípios do produto

### Objetivos

1. Tornar a leitura rápida e previsível, com estados explícitos de permissão, erro, câmera indisponível e nenhum resultado.
2. Transformar um valor lido em uma ação útil sem executar nada automaticamente.
3. Preservar os dados somente no dispositivo, com histórico pesquisável e controle de privacidade.
4. Oferecer uma interface visual consistente, acessível, localizada em português do Brasil e inglês e confortável em tema claro, escuro e AMOLED.
5. Manter uma base auditável, livre e aceitável para uma futura distribuição no F-Droid.

### Princípios

- offline por construção;
- permissões mínimas e solicitadas no contexto;
- confirmação antes de qualquer ação externa;
- separação rigorosa entre domínio, UI, persistência e APIs Android;
- dependências pequenas, livres e justificadas;
- formatos de leitura e escrita derivados do motor, sem listas inventadas;
- dados privados não entram em logs, backup automático ou imagens persistidas;
- toda decisão relevante fica registrada neste plano e, depois, no changelog.

## 3. Fora de escopo

Não serão implementados no primeiro ciclo:

- iOS, web, Windows, macOS ou Linux;
- contas, login, nuvem, sincronização, compartilhamento interno ou backend;
- anúncios, analytics, crash reporting, rastreamento, Firebase, Crashlytics ou SDKs proprietários;
- Google ML Kit, Play Services, Firebase, APIs dependentes de GMS ou bibliotecas que baixem modelos;
- WebView ou navegador embutido;
- abertura automática de URL, ligação, SMS, e-mail, contato, evento ou configuração de Wi-Fi;
- conexão automática a uma rede Wi-Fi;
- solicitação de INTERNET, armazenamento amplo, localização, contatos, calendário, telefone ou SMS;
- armazenamento de fotos, frames de câmera ou miniaturas no histórico;
- geração de uma simbologia marcada pelo motor como somente leitura;
- sincronização de preferências entre dispositivos;
- publicação automática na Play Store, F-Droid ou qualquer loja;
- inclusão de uma dependência apenas para resolver um detalhe visual ou funcional que o Flutter SDK já cobre.

## 4. Requisitos funcionais

### 4.1 Scanner

- Tela inicial com scanner de câmera e enquadramento claro.
- Permissão de câmera solicitada somente ao entrar em um fluxo que precisa dela.
- Estados distintos para: primeira solicitação, negada, negada permanentemente, câmera ocupada, câmera indisponível, sem código e erro do motor.
- Ações de lanterna, zoom por gesto/controle e seleção de imagem/arquivo.
- Importação offline de imagens, PDFs e Office moderno; PDFs são rasterizados
  localmente e imagens incorporadas em DOCX/XLSX/PPTX (e variantes macro) são
  examinadas pelo mesmo decoder, com feedback explícito quando não há código.
- Leitura de múltiplos códigos em imagem, com lista selecionável e indicação visual quando houver pontos confiáveis.
- Leitura contínua opcional com debounce configurável, sem inserir duplicatas repetidas durante o intervalo.
- Modo privado: resultado é usado na sessão, mas não é salvo.
- Modo em lote: cada item recebe uma sessão comum para consulta posterior.
- Feedback discreto de sucesso com haptics/som do Flutter, sem novos arquivos de áudio e sem permissão de rede.
- Pausar e retomar a câmera corretamente no ciclo de vida Android e ao trocar de aba.

### 4.2 Resultado e interpretação

- Mostrar o valor completo, com quebra visual segura para textos longos.
- Mostrar a simbologia com rótulo localizado e a origem do resultado.
- Permitir copiar, compartilhar, salvar/editar, apagar e repetir a leitura.
- Detectar, sem rede, texto genérico, URL, telefone, SMS, e-mail, Wi-Fi, vCard/MECARD, geo, evento/calendário e identificadores de produto quando a forma for inequívoca.
- Mostrar ações somente quando o parser reconhecer o tipo.
- URL, telefone, SMS, e-mail, localização, contato e evento sempre exigem ação explícita do usuário.
- Valores malformados continuam disponíveis como texto, com mensagem neutra e sem tentativa perigosa de execução.

### 4.3 Histórico

- Salvar leituras por padrão após confirmação do resultado.
- Filtrar por tipo, formato, favorito, etiqueta, data, origem e sessão.
- Pesquisar valor e notas com paginação e limite de resultados.
- Adicionar e remover etiquetas e notas.
- Favoritar/desfavoritar.
- Selecionar vários itens para apagar, exportar ou compartilhar.
- Apagar um item individual ou todo o histórico com confirmação e caminho claro para desfazer quando viável.
- Não guardar imagem da câmera nem imagem importada.

### 4.4 Gerador

- Selecionar apenas formatos expostos como graváveis pelo motor na versão travada.
- Formulários específicos para QR Code: texto, URL, contato, Wi-Fi, e-mail e SMS.
- Gerar uma prévia local e exibir erro de conteúdo incompatível.
- Copiar, compartilhar e salvar como PNG usando seletor nativo de arquivo.
- Oferecer o conjunto de formatos genéricos suportado pelo motor sem criar um catálogo paralelo.
- Informar quando um formato é somente leitura e, portanto, não está disponível no gerador.

### 4.5 Importação e exportação

- Exportar todos, itens selecionados ou uma sessão para JSON e CSV.
- Importar JSON/CSV com validação, prévia, limite de tamanho e transação.
- Preservar datas e favoritos quando válidos.
- Informar e permitir uma política para duplicatas; nunca sobrescrever silenciosamente.
- Exportar/compartilhar pelo sistema Android, sem usar armazenamento amplo.
- Garantir round-trip: exportar, importar e comparar os campos relevantes.

### 4.6 Configurações

- Tema: Sistema, Claro, Escuro e AMOLED.
- Cor de destaque: presets e cor personalizada.
- Ajuste de debounce do scanner contínuo.
- Preferência de salvar automaticamente e modo privado.
- Seleção e manutenção de mecanismos de busca locais para códigos de produto.
- Idioma: Sistema, português do Brasil e inglês, conforme capacidade do app.
- Acesso à tela de configurações do aplicativo quando for necessário corrigir permissão.
- Página “Sobre” com versão, licença Apache-2.0, avisos de terceiros, privacidade e reconhecimento de dependências.
- Atualizações: verificação manual e automática de releases do GitHub, preferência para interromper as buscas,
  “Lembrar mais tarde” e “Não lembrar mais”.

## 5. Requisitos não funcionais e critérios mensuráveis

- Android API 26 ou superior; o app não terá alvo iOS/web/desktop.
- `android.permission.INTERNET` somente para o verificador opcional/manual de releases do GitHub; nenhum outro tráfego de rede funcional.
- Nenhuma chamada HTTP para dados de leitura, socket arbitrário, WebView, telemetria, SDK de anúncios, Firebase, Play Services ou download de modelo.
- Todos os dados funcionais ficam no SQLite local ou nas preferências locais; arquivos exportados só existem quando o usuário os cria.
- O frame de câmera não pode acumular fila sem limite; deve haver no máximo um processamento em voo por sessão.
- A tela não deve travar por consulta de histórico, migração ou abertura do banco; SQLite roda fora do isolate de UI quando a API escolhida permitir.
- O histórico usa paginação e limites para não carregar a tabela inteira.
- Alvos de UX no aparelho de referência: primeira página do histórico local em até 500 ms após o banco estar aberto; ações de scanner sem jank perceptível; esses valores serão medidos, não presumidos.
- Alvos de acessibilidade: toque mínimo de 48 dp, contraste normal de pelo menos 4.5:1 e texto grande de pelo menos 3:1, foco e rótulo para TalkBack e suporte à escala de fonte.
- Rotação, retorno do background, câmera ocupada por outro app e ausência de aplicativo externo devem resultar em estados recuperáveis.
- JSON terá versão de formato; CSV seguirá regras RFC 4180 para aspas, vírgulas, quebras de linha e Unicode.
- Build release deverá ser reproduzível o máximo possível: versões travadas, dependências identificadas, sem binários baixados em runtime, fonte nativa auditável e instruções de build.
- O pacote final terá testes unitários, widget, integração e auditoria de manifesto proporcional às funcionalidades implementadas.

## 6. Arquitetura proposta

### 6.1 Camadas

1. presentation: telas, widgets, navegação, estados de acessibilidade e bindings Riverpod.
2. application: casos de uso, comandos, filtros, orquestração de sessão e estado de tela.
3. domain: entidades, value objects, enums, parser, contratos e regras puras.
4. data: tabelas Drift, DAOs, repositórios, serializadores e migrações.
5. platform: câmera, permissões, intents, compartilhamento, seletor de arquivo e sistema.
6. core: tema, localização, erros, relógio injetável, limites, logging redigido e utilitários.

Dependências apontam para dentro. A camada de domínio não importa Flutter, Drift, flutter_zxing, Android ou BuildContext. A UI não chama diretamente um plugin; usa casos de uso e contratos. Cada adapter externo fica atrás de uma interface que pode ser substituída por um fake nos testes.

### 6.2 Organização planejada

~~~text
lib/
  main.dart
  app/
    app.dart
    navigation/
    providers.dart
  core/
    errors/
    localization/
    logging/
    platform/
    theme/
    utils/
  features/
    scanner/
      data/
      domain/
      application/
      presentation/
    result/
    history/
    generator/
    transfer/
    settings/
test/
  core/
  features/
android/
  app/src/main/
  app/src/debug/
  app/src/profile/
docs/
  THIRD_PARTY_LICENSES.md
  FDROID.md
~~~

O diretório é uma proposta para as Fases 1–13; ele não foi criado nesta execução.

### 6.3 Estado e injeção

Riverpod será usado com Notifier, AsyncNotifier e StreamNotifier modernos, conforme o caso. Não serão usados StateProvider ou StateNotifierProvider legados sem justificativa, pois a linha atual do pacote move esses APIs para legacy.dart. Providers de repositório e adapter receberão implementações reais na aplicação e fakes nos testes. Não haverá service locator global oculto.

## 7. Dependências propostas, licenças e compatibilidade

Snapshot pesquisado em 2026-09-05. Os números abaixo são baseline de planejamento, não substituem a resolução final do pubspec.lock. Na Fase 1 cada pacote será resolvido, testado, inspecionado no cache e incluído na auditoria de licenças.

| Pacote/SDK | Baseline pesquisado | Licença declarada | FOSS/F-Droid | Decisão, uso e risco |
|---|---:|---|---|---|
| Flutter SDK | 3.47.2 local | BSD-3-Clause | Sim, com toolchain auditável | Base Android-only; fixar release exato no build F-Droid. |
| flutter_zxing | 3.0.1 | MIT | Sim, condicional à auditoria do pacote nativo | Motor primário; usa ZXing-C++ e expõe leitura, múltiplos códigos, câmera, imagem e geração. É muito recente e o uploader está marcado como não verificado; exige spike. |
| zxing-cpp | 3.1.1 bundled pela linha 3.x do plugin | Apache-2.0 | Sim | Motor nativo subjacente; verificar a fonte efetivamente presente no artefato do pacote e o modo de escrita. |
| Zint/libzint, quando incluído pelo zxing-cpp | versão efetivamente incluída | BSD-3-Clause para a biblioteca de encoding 2.5+; GUI/CLI têm GPLv3 | Sim, se somente a biblioteca aplicável estiver vinculada | Auditar submódulo e licença real. Não atribuir a licença BSD à distribuição inteira do Zint. |
| camera | 0.12.1 atual no snapshot, em geral transitivo de flutter_zxing | BSD-3-Clause | Sim | Implementação CameraX; testar API 26, lifecycle, rotação e aparelhos reais. Não adicionar câmera secundária sem necessidade. |
| image_picker | 1.2.3 | Apache-2.0/BSD-3-Clause conforme componentes | Sim | Seleção de imagem; usar picker/document provider, sem permissão ampla de armazenamento. Incluir recuperação de retrieveLostData. |
| image | 4.9.2, transitivo possível | MIT | Sim | Conversão/manipulação necessária ao motor; não armazenar imagens. |
| ffi | 2.2.0, transitivo | BSD-3-Clause | Sim | Ponte Dart/native usada pelo scanner e/ou SQLite; inventariar no aviso final. |
| flutter_riverpod | 3.4.3 | MIT | Sim | Estado e injeção; usar APIs modernas. |
| drift | 2.34.4 | MIT | Sim, com validação de geração | SQLite tipado, DAOs, migrações e queries paginadas. |
| sqlite3 | linha 3.x, snapshot 3.5.2 | MIT para bindings; SQLite em domínio público | Sim, condicional à origem nativa | Driver para NativeDatabase.createInBackground; hooks v3 podem buscar binários pré-compilados, então a estratégia source/offline precisa ser aprovada no spike F-Droid. |
| path_provider | 2.1.6 | BSD-3-Clause | Sim | Caminhos privados de banco, documentos, suporte e temporários; sem permissão de armazenamento. |
| drift_dev | 2.34.6 | MIT | Sim | Geração em desenvolvimento; não vai para runtime. |
| build_runner | 2.16.1 | BSD-3-Clause | Sim | Geração do código Drift; travar no lockfile. |
| shared_preferences | 2.5.5 | BSD-3-Clause | Sim | Preferências simples, usando SharedPreferencesAsync ou SharedPreferencesWithCache; não guardar histórico crítico aqui. |
| file_selector | 1.1.0 | BSD-3-Clause | Sim | Abrir/importar e escolher destino para exportação, por UI nativa e URI concedida pelo usuário. |
| share_plus | 13.3.0 | BSD-3-Clause | Sim | Sharesheet Android para texto/arquivo/URI, sempre iniciado por ação do usuário. |
| url_launcher | 6.3.2 | BSD-3-Clause | Sim | Abrir app externo para URL, telefone, e-mail, SMS, geo e o APK/release do GitHub; sem WebView. |
| android_intent_plus | 6.1.0 | BSD-3-Clause | Sim | Intents Android para contato, calendário, Wi-Fi e configurações, atrás de adapter; testar ausência de app e package visibility. |
| permission_handler | removido do baseline | MIT | — | Retirado porque a implementação Android 13.0.2 exige compileSdk 37, enquanto o template/AGP validado usa compileSdk 36; reavaliar somente com mudança explícita de toolchain. |
| intl | 0.20.3 | BSD-3-Clause | Sim | Formatação de datas/números e suporte à localização gerada. |
| flutter_localizations | SDK | BSD-3-Clause | Sim | ARB e mensagens do Flutter. |
| flutter_lints | 6.0.0 | BSD-3-Clause | Sim | Regras de análise em desenvolvimento. |
| flutter_test | SDK | BSD-3-Clause | Sim | Testes locais; a validação Android usa o smoke nativo e o updater permanece fora dos testes de rede. |

### 7.1 Dependências deliberadamente rejeitadas

- Google ML Kit, Firebase, Crashlytics, Play Services e qualquer biblioteca que exija ou sugira GMS: violam o alvo offline/F-Droid.
- mobile_scanner, qr_code_scanner e alternativas não escolhidas: duplicariam a responsabilidade do motor e aumentariam a superfície de auditoria.
- qr_flutter ou outro gerador separado: poderia divergir dos formatos realmente aceitos no scanner; geração deve usar o mesmo motor/capability layer.
- WebView e navegadores embutidos: não são necessários para abrir links e elevam o risco de execução de conteúdo.
- drift_flutter: não será dependência direta no baseline porque a linha atual declara dependências de compatibilidade sqlite3_flutter_libs e sqlcipher_flutter_libs marcadas como EOL/no-op. O bootstrap pode reconsiderar somente se o resultado do spike provar que isso simplifica o build sem introduzir binários opacos.
- sqlite3_flutter_libs e sqlcipher_flutter_libs: não adicionar para “corrigir” SQLite v3; a documentação atual indica que não são necessários para o caminho nativo moderno.
- Pacotes de JSON/CSV, UUID, áudio ou geradores de formulário: começar com dart:convert, parser CSV pequeno e APIs do Flutter; adicionar somente diante de um requisito demonstrado.

### 7.2 Política de resolução

- Usar constraints conservadores compatíveis com Flutter 3.47.2 e travar o resultado em pubspec.lock.
- Não atualizar automaticamente a linha principal durante uma fase.
- Registrar versão, origem, checksum quando disponível, licença e pacote nativo de cada dependência direta e transitiva.
- O único acesso de rede em execução é o endpoint público de release do GitHub, condicionado à preferência do usuário e sem dados de leitura.
- Repetir o build com cache isolado/offline e com Java 17 antes de declarar F-Droid-ready.

## 8. Permissões e manifesto Android

| Recurso | Manifesto | Política |
|---|---|---|
| Câmera | android.permission.CAMERA | Única permissão perigosa esperada; solicitar em contexto, explicar estado e oferecer configurações quando permanentemente negada. |
| Internet | android.permission.INTERNET | Permitida somente para a verificação opcional/manual do GitHub; não enviar leituras, identificadores ou telemetria. Auditar manifesto mesclado e APK. |
| Vibração | nenhuma inicialmente | Usar HapticFeedback; validar no aparelho. Só abrir mudança de escopo se a implementação exigir permissão normal explícita. |
| Imagens/arquivos | `WRITE_EXTERNAL_STORAGE` somente com `maxSdkVersion=28` para salvar PNG na galeria; nenhuma leitura ampla | Usar image_picker, file_selector e ACTION_OPEN_DOCUMENT/Photo Picker conforme disponibilidade; API 29+ usa MediaStore e recebe somente URI/conteúdo selecionado. |
| Telefone/SMS | nenhuma | ACTION_DIAL e compositor SMS; nunca CALL_PHONE nem envio automático. |
| Contatos | nenhuma | Intent de inserção/visualização; nunca ler ou gravar agenda diretamente. |
| Calendário | nenhuma | Intent de criação; nunca solicitar acesso à agenda. |
| Localização/Wi-Fi | nenhuma | Abrir tela de configurações; não conectar, escanear ou inferir localização. |
| Notificação | nenhuma | Não há notificações no primeiro ciclo. |
| Pacotes | nenhuma | Não usar QUERY_ALL_PACKAGES; queries seletivas somente se um preflight de intent realmente for necessário. |

O template do Flutter instalado inclui INTERNET em manifests de debug e profile para desenvolvimento, e o produto agora a declara explicitamente para o endpoint de releases. A auditoria deve confirmar que esse é o único acesso de rede permitido; nenhum dado de leitura pode sair do aparelho.

Para API 30 ou superior, package visibility será tratada com queries mínimo e específico, somente para esquemas/intents que forem consultados. Quando possível, a aplicação tentará launchUrl/intent diretamente e tratará retorno falso, reduzindo a necessidade de queries.

## 9. Modelo de domínio

### Entidades e value objects

- ScanRecord: id, rawValue, formatKey, contentType, source, createdAtUtc, isFavorite, note, batchSessionId, parserVersion.
- BarcodeFormatDescriptor: chave estável do motor, rótulo localizado, capacidade de leitura e escrita; não é uma lista fixa codificada na UI.
- ParsedContent: tipo reconhecido, campos estruturados opcionais, valor original, avisos e ações possíveis.
- ScanSource: câmera individual, câmera contínua, imagem, importação ou geração.
- ContentType: texto, URL, telefone, SMS, e-mail, Wi-Fi, contato, geo, evento, produto ou desconhecido.
- BatchSession: identificador, início, fim e contagem derivada.
- Tag: nome normalizado, rótulo original quando relevante e vínculo com registros.
- SearchEngineDefinition: nome, template local, estado ativo e ordem.
- ThemeSettings: tema, cor de destaque, contraste/variante e idioma.
- ScannerSettings: salvar automaticamente, modo privado, debounce, lanterna inicial e zoom inicial.

rawValue é a fonte de verdade. Texto de exibição, tipo parseado e ações são derivados, mas o snapshot de contentType, formatKey e parserVersion é persistido para que mudanças futuras do parser não reescrevam silenciosamente a classificação histórica. Valores recebidos de importação e câmera têm limite de tamanho antes de chegar ao banco.

## 10. Banco SQLite e consultas

### Tabelas propostas

~~~text
scans
  id INTEGER PRIMARY KEY AUTOINCREMENT
  raw_value TEXT NOT NULL
  format_key TEXT NOT NULL
  content_type TEXT NOT NULL
  source TEXT NOT NULL
  created_at_ms INTEGER NOT NULL
  is_favorite INTEGER NOT NULL DEFAULT 0
  note TEXT NULL
  parser_version INTEGER NOT NULL DEFAULT 1
  batch_session_id INTEGER NULL

tags
  id INTEGER PRIMARY KEY AUTOINCREMENT
  name TEXT NOT NULL UNIQUE

scan_tags
  scan_id INTEGER NOT NULL
  tag_id INTEGER NOT NULL
  PRIMARY KEY (scan_id, tag_id)
  FOREIGN KEY scan_id REFERENCES scans(id) ON DELETE CASCADE
  FOREIGN KEY tag_id REFERENCES tags(id) ON DELETE CASCADE

continuous_sessions
  id INTEGER PRIMARY KEY AUTOINCREMENT
  started_at_ms INTEGER NOT NULL
  finished_at_ms INTEGER NULL

search_engines
  id INTEGER PRIMARY KEY AUTOINCREMENT
  name TEXT NOT NULL
  template TEXT NOT NULL
  is_active INTEGER NOT NULL DEFAULT 1
  sort_order INTEGER NOT NULL
~~~

Decisões:

- armazenar timestamps como milissegundos UTC no SQLite e converter para DateTime UTC no domínio;
- criar índices para created_at_ms, is_favorite, content_type, format_key, batch_session_id e chaves de junção;
- manter notas e valores sem indexação de texto completo no primeiro corte; medir antes de adicionar FTS5;
- limitar consultas, ordenar por data/ID e usar paginação estável;
- ativar foreign keys e executar operações relacionadas em transação;
- manter limite de tamanho no boundary para conteúdo importado ou lido;
- nunca persistir frame, caminho temporário de imagem ou conteúdo duplicado de prévia;
- apagar tags órfãs em caso de remoção, sem apagar tags ainda usadas;
- usar parâmetros Drift para impedir concatenação de SQL.

O banco será aberto por NativeDatabase.createInBackground ou API equivalente validada pelo spike, mantendo I/O e migração fora do isolate de UI. O local ficará no diretório privado de dados do app, obtido por path_provider.

## 11. Migrações e integridade

- A versão do schema será explícita e monotônica.
- Toda mudança será aditiva quando possível.
- Renomear/remover coluna exigirá tabela sombra, cópia validada e troca transacional; nunca apagar dados por conveniência.
- Cada migração terá teste partindo de um fixture da versão anterior e teste de abertura em banco já preenchido.
- Testar chaves estrangeiras, índices, valores nulos, duplicidade de tags, ordenação e transações interrompidas.
- Exportação será a rota de recuperação manual antes de mudanças destrutivas.
- O app não usará backup automático do banco: android:allowBackup=false e regras de extração explícitas serão configurados. Em Android 12+ as regras de dataExtractionRules serão usadas, com fullBackupContent para versões antigas, excluindo banco, preferências sensíveis, cache e arquivos de transferência. O comportamento OEM de transferência direta será verificado em QA.

## 12. Navegação e shell do aplicativo

A navegação principal terá quatro destinos persistentes:

1. Scanner;
2. Histórico;
3. Criar;
4. Configurações.

O Scanner será a aba inicial. O shell usará NavigationBar/Material 3 e manterá estado de abas sem manter a câmera ativa fora do destino. Resultado e edição serão rotas/folhas de detalhe com retorno previsível. O histórico poderá abrir resultado, seleção múltipla e filtros. A navegação não dependerá de URL, deep link ou serviço externo.

Ao trocar de aba, entrar em background, bloquear a tela ou abrir um intent externo, a sessão de câmera será pausada. Ao retornar, a sessão será revalidada; nenhuma operação assume que o controller ainda existe.

## 13. Design system

O Material 3 será apenas a fundação técnica. Não será usado Dynamic Color. Tokens iniciais:

- espaçamento: 4, 8, 12, 16, 24 e 32 dp;
- toque: mínimo de 48 dp;
- raios: pequeno 8, médio 12, grande 20 dp;
- divisores sutis e elevação baixa;
- ícones de 24 dp, com áreas de toque maiores;
- hierarquia tipográfica com títulos curtos, corpo legível e valor de código em fonte monoespaçada quando ajudar;
- cores semânticas separadas de cores da marca: sucesso, aviso, erro, informação e superfície.

Componentes compartilhados incluirão cartão de resultado, estado vazio, estado de erro, banner de permissão, seletor de tema, seletor de cor, chips de filtro, diálogo destrutivo, campo de valor longo, linha de histórico e botão de ação primária. Componentes terão estados normal, pressionado, foco, desabilitado, carregando e erro.

## 14. Temas, AMOLED e contraste

Temas:

- Sistema: acompanha MediaQuery/configuração do Android;
- Claro;
- Escuro;
- AMOLED: fundo e superfícies principais pretos, com bordas e estados distinguíveis sem depender somente de elevação.

Cor de destaque terá presets e entrada personalizada. Para qualquer combinação, calcular a luminância relativa sRGB e o contraste:

~~~text
contraste = (maior luminância + 0,05) / (menor luminância + 0,05)
~~~

Para texto normal, escolher preto ou branco com maior contraste e rejeitar combinações abaixo de 4.5:1; para texto grande, aceitar no mínimo 3:1. Quando a cor escolhida não atender ao critério, ajustar a cor de superfície, usar uma variante acessível ou substituir automaticamente o foreground, mostrando o resultado de maneira consistente. Nunca confiar somente em “cor clara” ou “cor escura” nominal.

Testes de contraste cobrirão preto, branco, amarelo, azul, vermelho, verde, presets e amostras intermediárias em claro, escuro e AMOLED. Estados de erro/favorito/seleção terão ícone, texto ou contorno além da cor.

## 15. Arquitetura do scanner e do motor de códigos

### Contrato interno

Definir interfaces como:

- BarcodeScannerEngine: inicialização, capabilities, leitura de frame/imagem, criação de imagem e encerramento;
- BarcodeScanResult: valor, formato, pontos opcionais, metadados e timestamp de captura;
- EngineCapabilities: formatos de leitura, formatos de escrita, leitura por câmera, leitura por imagem, múltiplos resultados, pontos, lanterna e zoom;
- CameraSession: lifecycle, permissão, orientação, backpressure, zoom e torch;
- ScanDeduplicator: chave formatKey + rawValue + batch/session e relógio injetável.

O único adapter inicial será flutter_zxing. A UI não importará a API do pacote diretamente. O adapter ficará responsável por diferenças de versão, conversão de orientação/coordenadas e normalização dos erros.

### Baseline técnico pesquisado

flutter_zxing 3.0.1 é MIT, é construído sobre ZXing-C++ 3.1.1, declara suporte Android a partir da API 23 e lista leitura por câmera/imagem, múltiplos códigos, pontos, torch, zoom e geração. A documentação pública marca como graváveis, no baseline, UPC-A, UPC-E, EAN-8, EAN-13, DataBar, Code39, Code93, Code128, Codabar, DataBar Expanded, ITF, QR Code, Aztec, DataMatrix e PDF417. DataBar Limited, Telepen, DX Film Edge, Micro QR, rMQR, MicroPDF417 e MaxiCode aparecem como leitura, não escrita. Essa matriz pública não será tratada como contrato suficiente: a lista do gerador será obtida de EngineCapabilities e confirmada por testes de encode/decode na versão travada.

### Estratégia de câmera

- Usar a implementação CameraX fornecida pelo ecossistema Flutter/plugin, sem ML Kit ou GMS.
- Processar somente o frame necessário, com flag de processamento em voo e descarte controlado de frames atrasados.
- Aplicar rotação e transformação de pontos somente quando a origem e a orientação forem conhecidas.
- Se pontos não forem confiáveis em determinado caminho, mostrar lista de resultados sem desenhar uma caixa enganosa.
- Liberar controller e recursos nativos em todos os estados de erro e lifecycle.
- Testar ARM64, API 26, API 31 e API 35/36 emulador/dispositivo, rotação, pouca luz, reflexo, códigos pequenos, vários códigos e câmera ocupada.
- O release 3.0.1 do plugin é recente e o publisher do pub.dev aparece como uploader não verificado; a Fase 1/3 deve transformar isso em evidência operacional antes de aceitar a dependência.

### Geração

O adapter exporá somente formatos de escrita verificados. A sequência será: validar capacidade, validar payload, codificar em memória, renderizar prévia, permitir copiar/compartilhar/salvar e redigir recursos temporários. Falha de encoding será uma mensagem localizada, nunca uma imagem aparentemente válida.

## 16. Parser de conteúdo

O parser será Dart puro, determinístico, sem rede e independente da UI. A ordem de reconhecimento será conservadora:

1. formatos explícitos de Wi-Fi, vCard/MECARD, evento, geo, SMS e e-mail;
2. telefone em forma inequívoca;
3. URL somente com esquemas permitidos;
4. identificador de produto quando a regra de dígitos e formato for comprovada;
5. texto genérico.

Regras:

- preservar o valor original;
- tratar CRLF/LF, percent encoding, escapes, Unicode e campos ausentes;
- limitar tamanhos e quantidade de linhas;
- não interpretar javascript:, intent:, file:, content: arbitrário ou esquemas não permitidos como ação;
- distinguir “parece URL” de “URL pronta para abrir”;
- produzir warnings para campos incompletos;
- manter uma versão do parser no registro;
- ter testes de casos válidos, inválidos, maliciosos, Unicode, duplicados e valores longos.

## 17. Ações inteligentes e intents

Criar ExternalAction com tipo, rótulo, dados sanitizados, risco e necessidade de confirmação. Um ExternalActionService por plataforma traduzirá ações para APIs externas.

| Tipo | Ação permitida | Proteção |
|---|---|---|
| URL | abrir no navegador externo, copiar, compartilhar | aceitar inicialmente apenas http/https; exibir host completo; nunca WebView. |
| Telefone | abrir discador (ACTION_DIAL) | não chamar automaticamente e não pedir CALL_PHONE. |
| SMS | abrir compositor | não enviar automaticamente. |
| E-mail | abrir compositor mailto | validar destinatários e assunto; não enviar automaticamente. |
| Geo | abrir app externo de mapas/geo | validar latitude/longitude; fallback para copiar. |
| Contato | abrir inserção/visualização de contato | não acessar agenda; apresentar preview antes do intent. |
| Evento | abrir criação de evento | não acessar calendário; normalizar horário e timezone. |
| Wi-Fi | abrir configurações ou mostrar campos | não conectar, não mudar configuração e não pedir localização. |
| Produto | abrir template de busca escolhido pelo usuário | permitir somente template http/https; codificar {CODE}. |

url_launcher será usado com aplicação externa quando apropriado. android_intent_plus ficará por trás do adapter para ações que exigem Intent explícito. Se não houver app capaz de resolver, o usuário verá mensagem e ações alternativas. Não usar canLaunchUrl de forma indiscriminada; qualquer queries será mínimo e documentado.

## 18. Histórico, privacidade e consulta

- O resultado é salvo após a etapa de confirmação, salvo quando o usuário está em modo privado ou desativou salvamento automático.
- O mesmo valor só será deduplicado no contínuo conforme a janela configurada; leituras separadas continuam distinguíveis.
- Histórico e detalhes devem mostrar data/hora local derivada do timestamp UTC, origem, formato, favorito, tags e nota.
- Filtros devem ser composáveis e refletidos em estado restaurável da tela.
- Ações destrutivas exigem confirmação com contagem de itens.
- Valores e notas não serão incluídos em logs de produção.
- Não usar clipboard ou compartilhamento sem gesto/ação explícita.
- O estado “não salvar” será evidente antes do primeiro resultado e não removerá dados já existentes por acidente.

## 19. Gerador de códigos

Implementar o gerador depois de estabilizar o adapter do motor. Formulários estruturados serão apenas atalhos que montam payloads locais; o usuário ainda poderá gerar texto bruto quando o formato permitir.

Fluxo:

1. carregar writeFormats do engine;
2. selecionar o formato;
3. escolher template/conteúdo;
4. validar limites e sintaxe;
5. codificar com o mesmo engine;
6. renderizar prévia com semântica e zoom;
7. copiar, compartilhar ou salvar via picker;
8. liberar bytes temporários.

Testar cada formato gravável em uma matriz encode → decode, incluindo dados Unicode, vazios, caracteres de controle rejeitados, payload próximo do limite e conteúdo específico de QR. A UI não exibirá opções que falhem nessa matriz.

## 20. Importação e exportação

### Envelope JSON

Formato versionado:

~~~text
{
  "format": "killqr-export",
  "version": 1,
  "exportedAtUtc": "...",
  "records": [
    {
      "rawValue": "...",
      "formatKey": "...",
      "contentType": "...",
      "source": "...",
      "createdAtUtc": "...",
      "isFavorite": false,
      "note": "...",
      "tags": ["..."],
      "batchSessionId": "..."
    }
  ]
}
~~~

Campos desconhecidos serão ignorados de forma compatível; campos obrigatórios e tipos serão validados. O limite inicial de arquivo e de registros será definido no spike de memória, documentado e aplicado antes do parse completo.

CSV será UTF-8 com cabeçalho versionado, escape de aspas, vírgulas, quebra de linha e Unicode. Um parser pequeno e coberto por testes será preferido a outra dependência. Importação mostrará prévia, erros por linha e política de duplicata (pular, importar como novo ou cancelar). A escrita será transacional e não deixará metade do arquivo importada.

file_selector escolherá arquivos/locais e share_plus iniciará compartilhamento. O app não pede acesso ao armazenamento inteiro e não tenta publicar o arquivo por conta própria.

## 21. Localização

- Usar flutter_localizations e ARB gerados para pt_BR e en.
- Português do Brasil será a linguagem padrão da primeira experiência se o sistema não indicar outra suportada.
- Nenhum texto de UI ficará espalhado em widgets.
- Labels de formato, tipos, permissões, erros e ações terão chaves localizadas.
- Valores lidos, nomes de tags e conteúdo do usuário não serão traduzidos.
- Datas e números usarão intl; timestamps serão convertidos para o locale somente na apresentação.
- Pluralização, texto longo, falta de app externo e mensagens de erro terão testes em ambos os locales.
- O build Android será o único alvo; não adicionar configurações de localização iOS/web.

## 22. Acessibilidade e ergonomia

- Semantics e rótulos claros em todos os controles, incluindo torch, zoom, scanner, seleção múltipla e cor.
- Contraste calculado pelo algoritmo da seção 14.
- Alvos de toque de pelo menos 48 dp e espaçamento suficiente para evitar acionamento acidental.
- Conteúdo longo com leitura, cópia e navegação acessíveis; não depender de uma linha horizontal cortada.
- Foco de teclado útil quando houver teclado físico e foco lógico para TalkBack.
- Estados de seleção, erro, favorito e permissão comunicados por texto/ícone e não apenas por cor.
- Respeitar fonte ampliada, accessibleNavigation e redução de animações quando expostos pelo Android/Flutter.
- Testar portrait e landscape, API 26 e API 35+, TalkBack, fonte grande, modo escuro e AMOLED.
- Overlay do scanner deve ser discreto, não piscar e não esconder o resultado para leitores de tela.

## 23. Privacidade e arquitetura offline

O desenho deve ser verificável:

- nenhuma permissão de internet;
- nenhum cliente HTTP, WebSocket, WebView, analytics, ads, identificador ou endpoint;
- todos os casos de uso funcionam com modo avião;
- o banco e preferências ficam no sandbox privado;
- backup cloud e dados de transferência são desativados/excluídos;
- arquivos exportados só saem do sandbox após gesto explícito;
- abrir navegador, compartilhar ou enviar conteúdo para outro app é uma saída voluntária; a UI deve tornar essa transição compreensível;
- logs de release são redigidos e nunca registram o valor do código;
- página de privacidade explica armazenamento local, histórico, exportação e ações externas.

O teste de privacidade incluirá build e execução com rede desligada, inspeção de permissões, confirmação de que somente o endpoint público de releases é acessado e auditoria de manifesto mesclado. O envio de dados de leitura é critério bloqueante.

## 24. Segurança

- Allowlist de esquemas e validação por Uri; bloquear javascript:, intent:, file:, content: arbitrário e strings de controle.
- Não executar conteúdo lido nem interpolá-lo em SQL, shell, HTML, WebView ou Intent sem campos explícitos.
- Codificar corretamente query parameters e extras; não concatenar URLs sem validação.
- Exibir host e destino antes de abrir links.
- Limitar bytes, linhas, quantidade de códigos, campos de vCard/Wi-Fi e registros importados.
- Rejeitar imagens/arquivos grandes antes de carregar tudo na memória quando a API permitir.
- Usar transações e queries parametrizadas.
- Não logar raw value, note, tags, URI privada ou payload completo.
- Tratar ausência de app, intent não resolvido, arquivo removido e permissão revogada.
- Limpar arquivos temporários após gerar/exportar quando o sistema permitir.
- Testar fuzzing leve do parser, CSV/JSON malformado e payloads com esquemas perigosos.

## 25. Estratégia de testes e gates de qualidade

### Unitários

- parser para cada ContentType e seus fallbacks;
- validação de URL, telefone, e-mail, Wi-Fi, vCard/MECARD, geo e evento;
- allowlist de esquemas e construção de intents/templates;
- deduplicação, debounce e relógio injetável;
- serialização JSON/CSV e round-trip;
- cálculo de contraste e escolha de foreground;
- entidades, limites, filtros e políticas de duplicata;
- DAOs, queries paginadas e migrações;
- matriz de capabilities e geração fake.

### Widget

- estados de permissão e botão para configurações;
- scanner vazio/erro/sucesso;
- resultado com valor longo e ações;
- seleção múltipla, filtros, tags, notas e confirmação destrutiva;
- temas System/Light/Dark/AMOLED e presets de cor;
- generator com formatos somente graváveis;
- importação com prévia/erro;
- ambos os locales, fonte ampliada e Semantics básicos.

### Integração Android

- API 26, API 31 e API 35/36 no AVD ou dispositivo;
- permissão concedida, negada, negada permanentemente e revogada;
- lifecycle, rotação, background/foreground e câmera ocupada;
- captura fake/real, leitura de imagem, múltiplos códigos e contínuo;
- persistência após reinício, migração e banco vazio;
- picker em API 26 e Photo Picker/document provider em versões recentes;
- share sheet, intents sem app e intents com app;
- import/export real e reabertura do arquivo;
- auditoria do manifesto e backup.

### Gates executáveis

Em cada fase de código, antes de marcar a fase como concluída:

~~~text
dart format --set-exit-if-changed .
flutter analyze
flutter test
~~~

Gates adicionais quando aplicáveis:

~~~text
flutter build apk --release --target=lib/spikes/native_smoke.dart
adb install -r build/app/outputs/flutter-apk/app-release.apk
adb shell am start -n com.killstreak.killqr/.MainActivity
flutter build apk --release
apkanalyzer manifest permissions build/app/outputs/flutter-apk/app-release.apk
~~~

O gate de privacidade deve localizar android.permission.INTERNET e confirmar que ele é usado somente pelo cliente de releases; o gate de licenças deve produzir uma lista baseada no pubspec.lock, fontes Dart/native e dependências Gradle. Falha em lint, teste, build, licença, permissão proibida, permissão de armazenamento sem limite legado ou preservação do modo offline impede a marcação [x].

O runner padrão de `integration_test` não é usado nesta configuração: ele precisa de um socket do Dart VM service, incompatível com o manifesto Android sem `INTERNET`. O smoke release dedicado e a verificação visual/ADB dos AVDs são a estratégia de integração compatível com essa política; ARM64, testes físicos e TalkBack continuam uma execução externa.

## 26. Estratégia de release

- SemVer iniciando em 0.1.0, com versionCode monotônico.
- APK release assinado somente com chave fornecida/gerenciada pelo proprietário; nunca criar ou publicar chave no repositório.
- Gerar SHA-256 do artefato e registrar Flutter, Dart, AGP, Gradle, JDK, SDK, NDK e lockfile.
- Incluir changelog, limitações conhecidas, instruções de instalação e matriz de teste.
- Incluir LICENSE Apache-2.0, aviso de terceiros e fontes/licenças aplicáveis antes do primeiro release.
- CI deverá ter permissões mínimas, versões fixadas e nenhum segredo impresso.
- Validar arm64 e o ABI adicional que o scanner/SQLite realmente suportar; não anunciar um ABI não testado.
- Manter build local e build F-Droid-like documentados.
- Releases GitHub serão publicados somente por tag SemVer, pelo workflow com `contents: write` e chave de assinatura armazenada em Secrets.

## 27. Estratégia F-Droid

A candidatura futura deve obedecer à política de inclusão do F-Droid: software livre, sem tracking/ads/proprietário, sem binários opacos não reconstruíveis e com fonte/build transparentes. O projeto deverá ter:

- ID de aplicação único e estável;
- licença Apache-2.0 no app e notices de todas as dependências;
- fontes das dependências nativas identificadas;
- nenhum acesso de rede para dados funcionais; o cliente opcional de releases do GitHub deve permanecer documentado e sem telemetria;
- lockfile revisado e build sem buscar artefatos durante a execução;
- release source tag/commit e instrução de build;
- metadata YAML em metadata/application-id.yml somente na Fase 13;
- Flutter SDK fixado a uma release/commit exato, nunca o canal stable abstrato;
- flutter config --no-analytics no recipe;
- flutter pub get --enforce-lockfile quando aceito pelo ambiente do recipe;
- limpeza/auditoria de .pub-cache e diretórios não Android conforme as regras do F-Droid;
- submodules: true somente se a fonte do projeto efetivamente usar submódulos;
- saída APK e versionCode coerentes com o metadata;
- build validado em ambiente limpo e, quando possível, com rede bloqueada após obtenção controlada das fontes.

### Risco específico do SQLite

O sqlite3.dart v3 usa Dart hooks e pode obter bibliotecas nativas pré-compiladas de assets de release. Isso é uma possível incompatibilidade com build reproduzível/offline do F-Droid. A decisão fica assim:

1. baseline: Drift + sqlite3 v3 + NativeDatabase.createInBackground;
2. spike obrigatório: demonstrar compilação das bibliotecas nativas a partir de fonte ou origem aceita, sem download oculto, em build limpo/F-Droid-like;
3. se aprovado, documentar fonte, versão, checksum, toolchain e licença;
4. se reprovado, avaliar sqlite3 configurado para fonte, ou uma alternativa SQLite Android que preserve os requisitos de licença e offline;
5. não trocar silenciosamente para bibliotecas EOL nem aceitar binário baixado em build/runtime sem decisão registrada.

Flutter SDK e Android SDK oficiais podem ser usados conforme as regras de toolchain do F-Droid, mas o JDK local 25 não pode ser a única referência. O build deve passar também em JDK 17, com Gradle/AGP compatíveis.

## 28. Riscos técnicos conhecidos e mitigação

| Risco | Impacto | Mitigação | Fase | Estado |
|---|---|---|---|---|
| flutter_zxing 3.0.1 muito recente/uploader não verificado | quebra de API ou artefato nativo | spike, lockfile, adapter isolado, testes de encode/decode e auditoria da fonte | 1–3, 8 | [~] QR passou no smoke; matriz completa e auditoria permanecem. |
| FFI, ZXing-C++ e Zint mudarem disponibilidade de escrita | gerador oferece formato falso | capabilities em runtime + matriz encode/decode + notices | 1, 3, 8, 13 | [~] Capabilities e QR foram provados; vínculo/licença completa pendente. |
| CameraX/lifecycle/rotação variarem por aparelho | travamentos, frames inválidos, overlays errados | backpressure, lifecycle rigoroso, matriz API/aparelho e fallback sem pontos | 3, 7, 12 | [~] API 26 e API 36 x86_64 abriram o scanner e passaram o smoke; rotação, câmera física e ARM64 permanecem. |
| API 26 não ter Photo Picker moderno | importação quebrada ou permissão excessiva | ACTION_OPEN_DOCUMENT/provider, sem READ storage, teste real API 26 | 1, 7, 12 | [ ] |
| JDK 25 local divergir de JDK 17 do F-Droid | build passa local e falha na distribuição | validar ambos, fixar Gradle/AGP/Kotlin e registrar toolchain | 1, 12, 13 | [x] Produto compilado com JDK 17 portátil e JDK 25; builder F-Droid ainda precisa repetir. |
| sqlite3 v3 usar asset pré-compilado/hook não aceito | build F-Droid não reproduz | spike source/offline; fallback documentado antes de persistência | 1, 5, 13 | [~] Drift/SQLite abriu no host e no AVD; reprodução F-Droid permanece pendente. |
| remover INTERNET quebrar debug/profile | perda de hot reload ou tooling | aceitar limitação, usar testes locais/release e auditar todas as variantes | 1, 12 | [x] Manifests, APKs e fluxo alternativo auditados. |
| OEM ignorar parte de allowBackup=false em D2D | histórico privado transferido | dataExtractionRules, fullBackupContent, teste API 31+ e documentação | 1, 5, 12 | [ ] |
| nenhum app externo resolver intent | ação parece quebrada | capturar falha, oferecer copiar/compartilhar e não pedir permissões adicionais | 4, 10, 12 | [ ] |
| package visibility exigir queries | preflight falha em Android 11+ | queries seletivas ou tentativa direta; nunca QUERY_ALL_PACKAGES | 4, 10, 12 | [ ] |
| CSV/JSON grande ou malicioso | OOM, corrupção ou importação parcial | limites antes do parse, streaming quando necessário, prévia e transação | 9, 12 | [ ] |
| parser classificar conteúdo perigosamente | ação externa incorreta | parser conservador, allowlist, confirmação e fallback em texto | 4, 12 | [ ] |
| contraste personalizado inadequado | inacessibilidade | luminância calculada, foreground automático e testes de presets/cores | 2, 11, 12 | [ ] |
| câmera, scanner e banco consumirem recursos simultaneamente | jank ou bateria excessiva | isolate/background DB, descarte de frame, métricas e lifecycle | 3, 5, 7, 11 | [ ] |

## 29. Questões técnicas descobertas e decisões pendentes

Cada item abaixo deve ser fechado por evidência e registrado no changelog ou em um ADR curto quando a implementação começar.

- [x] Confirmar os nomes e o formato dos APIs de capabilities/encode expostos por flutter_zxing 3.0.1 no pacote resolvido, não somente na documentação; o smoke usa `encodeBarcode`, `pngFromBytes` e `readBarcodeImagePathString`.
- [~] Confirmar a matriz real de escrita para cada CodeFormat, incluindo o vínculo com Zint e a licença do código efetivamente empacotado; QR foi provado, a matriz completa permanece para a auditoria do adapter.
- [ ] Confirmar leitura de múltiplos códigos e coordenadas após rotação em API 26, API 35/36 e um aparelho ARM64.
- [ ] Confirmar que CameraX/camera 0.12.1 funciona com minSdk 26, lifecycle e ausência de GMS no conjunto de aparelhos alvo.
- [x] Remover `permission_handler` 13.0.2 do baseline: sua implementação Android exige compileSdk 37, incompatível com o AGP 9.1/template validado em compileSdk 36; a Fase 3/10 deverá provar se os estados e a abertura de configurações são cobertos por APIs Android/Camera ou reavaliar o adapter depois de atualizar o toolchain.
- [x] Confirmar NativeDatabase.createInBackground com sqlite3 v3 e Drift 2.34.x: passou no Windows local, smoke Android e build JDK 17; decisão F-Droid do hook permanece externa.
- [ ] Confirmar se a configuração sqlite3 por fonte atende F-Droid e qual arquivo/versionamento de SQLite será carregado.
- [ ] Confirmar backup cloud/D2D em API 26, API 31+ e pelo menos um OEM sem confiar só em allowBackup=false.
- [ ] Confirmar extras e comportamento de intents para contato, evento, Wi-Fi, tel, SMS, mailto e geo quando não há app instalado.
- [ ] Confirmar file_selector, image_picker e share_plus em API 26 sem permissões amplas.
- [x] Confirmar o impacto de remover INTERNET nos modos debug/profile do template Flutter; hot reload/runner podem não funcionar, e o fluxo local de teste está documentado em `docs/BUILDING.md`.
- [x] Confirmar build com o template atual: AGP 9.1.0, Gradle 9.3.1, Kotlin 2.4.0, compile/target 36 e minSdk alterado para 26.
- [x] Registrar a limitação do runner `integration_test`: o socket do Dart VM service não é compatível com a política sem INTERNET; o smoke release nativo foi usado para a prova Android.
- [ ] Confirmar tamanho, ABI e reproducibilidade do APK com bibliotecas nativas do scanner e SQLite.
- [ ] Confirmar limites de payload de cada formato e transformar-os em erros localizados antes do encode.
- [ ] Confirmar comportamento do parser para padrões locais brasileiros sem transformar texto ambíguo em telefone, produto ou evento.

Nenhuma dessas perguntas deve ser resolvida por suposição silenciosa; a primeira fase de implementação é deliberadamente um bootstrap/spike.

## 30. Roadmap executável

### Fase 0 — descoberta e plano [x]

**Objetivo:** entender o repositório, validar o ambiente, pesquisar dependências/licenças/F-Droid, registrar riscos e entregar o plano sem implementar.

**Arquivos/áreas:** leitura de prompt.md; criação deste PLAN.md; nenhum arquivo de aplicação.

**Tarefas:**

- [x] verificar que o repositório contém apenas prompt.md;
- [x] confirmar ausência de projeto Flutter/Git e de código existente;
- [x] inspecionar Flutter 3.47.2/Dart 3.13.2, Android SDK, Build Tools, NDK, JDK, ADB e emuladores;
- [x] inspecionar templates Flutter atuais, inclusive a permissão INTERNET de debug/profile;
- [x] pesquisar scanner, estado, banco, picker, intents, compartilhamento, licenças e política F-Droid;
- [x] consolidar stack, arquitetura, riscos, decisões pendentes, gates e dependências.

**Testes/validação:** flutter --version, flutter doctor -v, flutter devices, flutter emulators, avdmanager list avd, sdkmanager --list_installed, java -version, adb version, leitura dos templates locais e consulta às fontes oficiais listadas abaixo.

**Aceitação:** PLAN.md completo, sem código de implementação, com bloqueio textual pela resposta exata APROVAR PLANO.

**Riscos/dependências:** ausência de dispositivo Android conectado não bloqueia o plano; bloqueia somente a validação física das fases 3, 7 e 12.

### Fase 1 — bootstrap Android e spike de dependências [x]

**Objetivo:** criar o esqueleto Flutter Android-only, provar compilação mínima e resolver os riscos de plugin/toolchain antes da UI.

**Arquivos/áreas:** pubspec.yaml, pubspec.lock, analysis_options.yaml, lib/main.dart, android/, .gitignore, .metadata, .github/, scripts de auditoria e documentação de build.

**Tarefas:**

- [x] criar projeto Android-only com application ID `com.killstreak.killqr`;
- [x] configurar minSdk 26, compile/target conforme toolchain validada e Java/Gradle compatíveis; JDK 17 e JDK 25 passaram;
- [x] remover INTERNET dos manifests debug/profile/main e revisar permissões mescladas;
- [x] adicionar baseline de dependências com constraints e lockfile;
- [x] configurar lints, ARB mínimo e comandos reprodutíveis;
- [x] implementar apenas wiring mínimo de inicialização, sem fluxo de produto;
- [x] fazer spike de flutter_zxing, CameraX, Drift/sqlite3 v3, pickers, share e intents; capabilities, câmera, persistência, geração e ações têm adapters implementados;
- [x] testar em JDK 25 local e JDK 17 portátil; ambos compilaram o produto;
- [x] produzir primeira tabela de licenças e checagem de dependência proibida.

**Testes:** `flutter pub get --offline`, geração Drift, formatação, `flutter analyze`, 12 testes locais, builds debug/release, smoke nativo no AVD, manifesto fonte/mesclado/APK, auditoria de dependências e verificação de `pubspec.lock`. O builder F-Droid real e a matriz de aparelhos continuam como validação externa.

**Aceitação:** app compila em release com minSdk 26, declara apenas o acesso de rede necessário ao updater opcional, dependencies resolvem sem proibidos, o banco abre sem bloquear UI e o scanner prova um encode/decode real. Esses critérios passaram com JDK 17 e 25; a reprodução F-Droid do hook sqlite3 permanece uma pendência externa documentada.

**Riscos/dependências:** depende somente da Fase 0; bloqueadores principais são sqlite3 hooks, plugin recente e compatibilidade JDK/AGP. Se o spike falhar, atualizar este plano antes da Fase 2.

### Fase 2 — shell, tema, tokens e navegação [x]

**Objetivo:** entregar a fundação visual e de navegação sem lógica de scanner.

**Arquivos/áreas:** lib/app/, lib/core/theme/, lib/core/localization/, lib/features/settings/, shell de navegação e testes widget.

**Tarefas:**

- [x] criar tokens de cor, espaçamento, tipografia, raios e elevação;
- [x] montar temas Sistema/Claro/Escuro/AMOLED e cor personalizada;
- [x] implementar cálculo de contraste e fallback acessível;
- [x] criar NavigationBar de quatro destinos;
- [x] estruturar estados vazios/carregando/erro e componentes compartilhados;
- [x] adicionar ARB pt_BR/en e evitar strings inline;
- [x] configurar Semantics e targets mínimos.

**Testes:** teste de contraste, ARB gerado, análise; navegação, estados vazios, labels e fonte ampliada verificados no AVD/API 36.

**Aceitação:** shell navega entre as quatro abas, preserva tema e idioma, não usa Dynamic Color, passa matriz de contraste e mantém layout utilizável em portrait/landscape e AMOLED.

**Riscos/dependências:** depende da Fase 1; alterações de tema devem preservar as regras de contraste da seção 14.

### Fase 3 — contrato do scanner e leitura básica [~]

**Objetivo:** integrar flutter_zxing atrás de um adapter e ler um código por câmera e por imagem.

**Arquivos/áreas:** lib/features/scanner/domain/, data/, application/, presentation/, adapters Android, fakes e testes.

**Tarefas:**

- [x] implementar interfaces de engine/camera/capabilities;
- [x] mapear códigos do plugin para BarcodeScanResult;
- [x] tratar permissão, lifecycle, rotação, erro e descarte de frames;
- [x] conectar torch, zoom e escolha de imagem;
- [x] preencher capability list de leitura/escrita;
- [x] criar adapter isolado para testes locais;
- [x] validar pontos antes de desenhar overlay.

**Testes:** capability test, smoke ZXing, integração visual e instalação release nos AVDs API 26 e API 36 x86_64. ARM64, rotação física e câmera ocupada exigem matriz externa ainda não disponível.

**Aceitação:** câmera lê um código real de forma repetível em API 26 e API recente testada, seleção de imagem lê sem permissão ampla, lifecycle libera recursos e a UI não conhece APIs do plugin.

**Riscos/dependências:** depende da Fase 1 e da disponibilidade de um dispositivo/AVD; falha de pontos não pode produzir retângulo incorreto.

### Fase 4 — resultado, parser e ações seguras [x]

**Objetivo:** transformar o valor lido em detalhe compreensível e ações externas confirmadas.

**Arquivos/áreas:** lib/features/result/, parser em lib/features/scanner/domain/ ou lib/core/, lib/core/platform/, intents, localizações e testes.

**Tarefas:**

- [x] implementar ContentParser puro;
- [x] criar tela de resultado com valor completo, formato, tipo e origem;
- [x] implementar copiar, compartilhar e salvar/editar;
- [x] criar allowlist de URL e ExternalAction;
- [x] adaptar url_launcher/android_intent_plus;
- [x] tratar ausência de app, esquemas bloqueados e fallback copiar;
- [x] evitar logs de valores longos ou privados.

**Testes:** parser unitário/fuzz leve; widget de resultado; intents fake; testes de URL perigosa; aparelho com e sem apps externos.

**Aceitação:** cada tipo suportado tem ações corretas e confirmação; nenhum conteúdo abre automaticamente; javascript:, intent:, file: e esquemas desconhecidos não viram ação executável.

**Riscos/dependências:** depende da Fase 3; package visibility e diferenças de apps Android podem exigir ajuste do adapter.

### Fase 5 — Drift, SQLite e persistência local [x]

**Objetivo:** persistir registros, tags, sessões e mecanismos sem bloquear a interface.

**Arquivos/áreas:** lib/features/history/data/, tabelas/DAOs, repositórios, migrações, lib/core/storage/, testes de banco e manifests/backup.

**Tarefas:**

- [x] criar tabelas e índices da seção 10;
- [x] abrir banco em background;
- [x] implementar queries, escrita e casos de uso necessários à UI;
- [x] inserir resultado somente após confirmação/modo de salvamento;
- [x] implementar tags/notas/favoritos e sessões;
- [x] configurar foreign keys, transações e limites;
- [x] configurar allowBackup=false, dataExtractionRules e fullBackupContent;
- [x] documentar o caminho sqlite3 e a validação F-Droid pendente.

**Testes:** unitários/integração de DAOs; migração de fixtures; concorrência; reinício; banco vazio/corrompido; backup manifest; benchmark inicial de listagem; build limpo/offline.

**Aceitação:** um resultado persiste e sobrevive ao reinício, a UI não trava, migrações são testadas, não há imagens armazenadas e o risco sqlite3 tem decisão aprovada.

**Riscos/dependências:** depende das Fases 1 e 4; se o caminho nativo não for aceitável para F-Droid, parar e aplicar a alternativa registrada antes de continuar.

### Fase 6 — histórico completo [x]

**Objetivo:** tornar o histórico pesquisável, filtrável, editável e seguro para exclusão.

**Arquivos/áreas:** lib/features/history/presentation/, application/data, componentes de filtro/seleção e testes.

**Tarefas:**

- [x] tela limitada/paginada com ordenação estável;
- [x] busca por valor/nota e filtros combinados;
- [x] tags, notas, favoritos e sessões;
- [x] seleção múltipla, exportação e deleção;
- [x] estados vazio, sem resultados, erro e carregamento;
- [x] confirmação e feedback pós-ação.

**Testes:** query/paginação; widget com milhares de fake records; seleção e deleção; tags órfãs; acessibilidade; performance no aparelho de referência.

**Aceitação:** histórico com dados reais pode ser consultado sem carregar tudo, filtros combinam corretamente e operações destrutivas não ocorrem sem confirmação.

**Riscos/dependências:** depende da Fase 5; busca sem FTS5 deve ser medida e só depois otimizada.

### Fase 7 — múltiplos códigos, contínuo e debounce [~]

**Objetivo:** completar imagem múltipla e scanner contínuo sem duplicação ou uso excessivo de recursos.

**Arquivos/áreas:** scanner application/presentation, ScanDeduplicator, sessões, configurações e testes de integração.

**Tarefas:**

- [x] exibir seleção/lista de múltiplos resultados;
- [x] criar sessão em lote;
- [x] implementar debounce configurável e modo contínuo;
- [x] permitir salvar individualmente ou em lote;
- [x] pausar processamento ao sair da tela;
- [x] desenhar pontos somente quando transformação validada;
- [ ] medir CPU, memória, bateria e jank em matriz de aparelhos.

**Testes:** imagem com vários formatos/códigos, valores repetidos, relógio fake, rotação, lifecycle, pouca luz, câmera ocupada, performance e integração API 26/API recente.

**Aceitação:** códigos distintos são listados, repetição dentro da janela não gera spam, a sessão pode ser encerrada/consultada e nenhum frame fica acumulado.

**Riscos/dependências:** depende das Fases 3, 4 e 5; coordenadas e performance são riscos de aparelho, não apenas de emulador.

### Fase 8 — gerador e exportação de imagem [~]

**Objetivo:** gerar códigos usando somente formatos realmente graváveis pelo engine.

**Arquivos/áreas:** lib/features/generator/, engine encoder, formulários QR, renderer, picker/share adapter e testes.

**Tarefas:**

- [x] carregar capabilities e esconder somente-leitura;
- [x] implementar templates QR e texto;
- [x] validar payload/limites;
- [x] codificar e renderizar PNG;
- [x] salvar PNG na galeria via MediaStore, compartilhar via share_plus, copiar;
- [x] tratar cancelamento sem criar arquivo;
- [~] matriz completa encode/decode: QR foi validado no smoke; os demais formatos dependem do conjunto nativo exposto.

**Testes:** unitários de validação; widget; integração em API 26/recente; round-trip de cada formato; Unicode, limite, payload inválido, save/share cancelado.

**Aceitação:** cada opção exibida gera um código que o decoder aceita na matriz; formatos não graváveis não aparecem como selecionáveis; nenhum arquivo sai sem gesto do usuário.

**Riscos/dependências:** depende da Fase 3 e do fechamento das capabilities; mudanças no motor podem reduzir formatos e exigem atualização da UI/localização.

### Fase 9 — importação e exportação JSON/CSV [x]

**Objetivo:** transportar histórico de maneira versionada, segura e reversível.

**Arquivos/áreas:** lib/features/transfer/, serializers, CSV parser/writer, picker/share adapter, repositórios e testes.

**Tarefas:**

- [x] implementar envelope JSON versionado;
- [x] implementar CSV RFC 4180;
- [x] exportar tudo e itens selecionados;
- [x] abrir arquivo com limite e prévia;
- [x] validar schema/linhas e mostrar erros;
- [x] implementar política de duplicatas;
- [x] importar em transação e preservar datas/tags/favoritos válidos;
- [x] compartilhar/salvar conforme ação explícita.

**Testes:** round-trip; Unicode; aspas/vírgulas/quebras de linha; versões desconhecidas; arquivo vazio/grande/malformado; cancelamento; rollback; API 26 e recente.

**Aceitação:** export → import reproduz os campos definidos, erro não altera o banco, duplicata nunca é silenciosa e nenhuma permissão ampla aparece.

**Riscos/dependências:** depende das Fases 5 e 6; limites e streaming precisam ser fechados por medição.

### Fase 10 — configurações, busca e preferências [x]

**Objetivo:** completar controle do usuário sobre tema, scanner, idioma e mecanismos de busca.

**Arquivos/áreas:** lib/features/settings/, providers, shared_preferences, search_engines, lib/core/localization/, intents de configurações.

**Tarefas:**

- [x] persistir preferências simples com API moderna do shared_preferences;
- [x] implementar temas, cor, idioma e debounce;
- [x] ligar salvar automaticamente/modo privado;
- [x] CRUD de mecanismos de busca com validação http/https;
- [x] abrir configurações do app para permissão;
- [x] criar tela Sobre, licença e privacidade.

**Testes:** persistência/restart; parser de template; URLs com encoding; widget de tema/idioma; configuração sem apps externos; contraste.

**Aceitação:** todas as preferências sobrevivem a reinício, templates inválidos são rejeitados, ações externas continuam explícitas e a tela Sobre aponta para notices existentes.

**Riscos/dependências:** depende das Fases 2, 4, 5 e 9; não introduzir uma URL de busca padrão que dependa de rede para o funcionamento do app.

### Fase 11 — polimento, acessibilidade e desempenho [~]

**Objetivo:** consolidar a experiência em aparelhos reais e fechar requisitos não funcionais.

**Arquivos/áreas:** todas as telas, tokens, ARB, scanner lifecycle, banco, documentação e métricas.

**Tarefas:**

- [x] revisar todos os estados de erro/loading/vazio;
- [~] testar fonte grande, Semantics, AMOLED e claro/escuro no AVD; TalkBack, landscape físico e perfil de jank permanecem externos;
- [x] manter câmera e banco fora do trabalho síncrono da UI;
- [x] revisar mensagens, foco e targets;
- [x] revisar logs e conteúdo sensível;
- [x] eliminar dependências/imports não usados;
- [x] atualizar notices e limitações conhecidas.

**Testes:** gates gerais; perfil de performance; matriz de dispositivos; TalkBack; modo avião; teste de reinstalação/upgrade; inspeção de APK e permissões.

**Aceitação:** nenhum requisito da seção 4 fica sem fluxo; problemas P0/P1 fechados; acessibilidade e offline passam checklist; desempenho não regride nos cenários medidos.

**Riscos/dependências:** depende das Fases 2–10; mudanças tardias no engine ou banco podem reabrir fases anteriores.

### Fase 12 — QA, segurança e release candidate [~]

**Objetivo:** validar o fluxo completo e produzir candidato de release auditado.

**Arquivos/áreas:** testes de integração, scripts de auditoria, CHANGELOG.md, LICENSE, notices, CI, configuração de assinatura fora do repositório.

**Tarefas:**

- [x] executar suíte unitária e análise; o runner integration_test foi substituído pelo smoke release sem INTERNET;
- [x] testar criação/migração do schema e restauração por import manual no serviço;
- [x] auditar manifesto, permissões, classes/strings proibidas e dependências;
- [x] validar o app sem funcionalidade de rede e sem GMS no AVD disponível;
- [~] executar encode/decode e intents na matriz final; AVDs API 26 e API 36 x86_64 passaram o smoke, enquanto ARM64, ausência de apps externos e a matriz completa de intents aguardam aparelhos;
- [x] gerar APK release, checksum e relatório de toolchain;
- [x] revisar threat model e privacidade;
- [x] registrar known issues em docs/FDROID.md e no changelog.

**Testes:** todos os gates da seção 25, em ambiente limpo e nos aparelhos definidos; build com Java 17 e 25; inspeção de dependências Gradle/pub; auditoria de que INTERNET é usada somente pelo updater de releases.

**Aceitação:** candidate release instala em API 26+, passa smoke end-to-end, não contém permissão/SDK proibido, licenças estão completas e todos os riscos bloqueantes têm resolução documentada.

**Riscos/dependências:** depende de todas as fases anteriores; qualquer falha bloqueante retorna à fase responsável.

### Fase 13 — pacote open source e preparação F-Droid [~]

**Objetivo:** deixar o projeto publicável e auditável, sem fazer publicação externa automática.

**Arquivos/áreas:** README.md, LICENSE, THIRD_PARTY_NOTICES ou docs/THIRD_PARTY_LICENSES.md, docs/FDROID.md, metadata F-Droid, changelog, tags e CI.

**Tarefas:**

- [x] escrever build instructions offline e matriz de toolchain;
- [x] fixar Flutter e dependências no lockfile e documentar o recipe esperado;
- [~] finalizar inventário de licenças Dart, native e Gradle; Dart/native principais estão listados, auditoria independente do grafo Gradle ainda é necessária;
- [x] manter artefatos gerados fora do pacote de fonte documentado;
- [x] criar metadata YAML somente com dados verificáveis, explicitamente marcado como draft sem repositório canônico;
- [~] testar recipe em build limpo/F-Droid-like; build offline local passou, `fdroid` não está instalado e o hook sqlite3 aguarda builder real;
- [x] preparar checksum e release notes;
- [x] deixar a decisão de publicação para o proprietário.

**Testes:** reconstrução independente quando possível; comparação de APK; fdroid lint/fdroid build ou equivalente disponível; manifesto/permissões; licença e source scan.

**Aceitação:** outra pessoa consegue obter a fonte, entender a licença, reproduzir o build documentado e verificar que o app continua offline; nenhuma submissão/publicação ocorre sem autorização explícita.

**Riscos/dependências:** depende da Fase 12 e do fechamento do risco sqlite3; F-Droid pode exigir ajustes de metadata ou de dependências que devem voltar ao plano.

### Gate de passagem entre fases

A ordem padrão é F0 → F1 → F2 → F3 → F4 → F5 → F6 → F7/F8/F9 → F10 → F11 → F12 → F13. F7, F8 e F9 podem ser paralelizadas somente quando seus contratos estiverem estáveis. Uma fase não passa por “parece funcionar”: precisa de aceitação, gates de qualidade e atualização deste documento. Se uma descoberta alterar arquitetura, permissões, dependência ou licenciamento, atualizar o plano antes de seguir.

### Definition of Done do projeto

- [x] funcionalidades da seção 4 implementadas e cobertas por testes locais;
- [~] Android API 26+ e aparelho ARM64; AVDs API 26 e API 36 x86_64 foram validados, e ARM64/aparelhos físicos exigem matriz externa;
- [x] nenhum INTERNET, rede runtime, tracking, GMS, ML Kit, Firebase, WebView ou permissão proibida;
- [x] scanner, parser, gerador e import/export cobertos pelos testes disponíveis;
- [x] persistência/migrações/backup auditados localmente;
- [~] temas, contraste, localização e acessibilidade; AVD e testes de contraste passaram, TalkBack físico permanece;
- [x] logs não expõem valores privados;
- [~] dependências e licenças Dart/native/Gradle; inventário principal fechado, revisão F-Droid independente pendente;
- [~] build release passou com Java 17/25 e offline Dart, mas não há `fdroid` instalado para o builder oficial;
- [x] LICENSE, notices, README, privacidade, changelog e instruções de build completos;
- [x] checksum e versão do artefato registrados;
- [x] publicação externa somente após autorização separada.

### Evidências e fontes da descoberta

#### Ambiente local

- Repositório inicial: somente prompt.md; o bootstrap da Fase 1 agora está criado neste diretório, sem histórico Git prévio.
- Flutter: 3.47.2 stable; Dart 3.13.2; DevTools 2.60.0.
- Android: SDK 35, 36 e 37.0; Build Tools 36.0.0 e 36.1.0; Platform Tools 37.0.1; NDK 28.2.13676358 e 29.0.14206865; CMake 3.22.1.
- Java: OpenJDK 25.0.2 no JBR do Android Studio; validação cruzada concluída com Temurin portátil 17.0.20.1 fora da árvore do projeto.
- AVDs: `KillQR_API_26`, Google APIs, Android 8.0/API 26, x86_64, e `Planejador_API_36`, Pixel 6, Google APIs, Android 16/Baklava, x86_64; o smoke nativo passou nos `emulator-5556` e `emulator-5554`.
- Licenças Android aceitas; Gradle não está instalado globalmente, portanto o projeto deverá usar o wrapper.

#### Evidências executadas na Fase 1

- `flutter pub get --offline`, geração Drift, formatação, análise e `flutter test` passaram; o teste ZXing de host fica marcado como skip porque o DLL Windows não é o alvo Android.
- `flutter build apk --debug` passou com JDK 25; `flutter build apk --release` do produto passou com JDK 17 e JDK 25, com minSdk 26, AGP 9.1.0, Gradle 9.3.1 e Kotlin 2.4.0.
- O smoke release automatizado `scripts/run_android_smoke.ps1` passou nos AVDs API 26 e API 36 com `DRIFT: PASS`, `ZXING ENCODE/DECODE: PASS` e `com.killstreak.killqr/.MainActivity` ativo.
- Manifests mesclados debug/release e o APK não contêm INTERNET nem permissões proibidas de áudio/rede/leitura; o WRITE_EXTERNAL_STORAGE do produto é limitado a `maxSdkVersion=28` e só atende o salvamento explícito na galeria.
- A auditoria de dependências proibidas passou; o APK produto release atualizado `0.1.0+1` tem SHA-256 `FE8CAF4D56C3953881656AFEE68DA6C3F3A3BE2B4E40AC9DB75329FAD45F79F4` e 74.819.049 bytes.
- O lançamento do produto foi validado com `adb shell am start -n com.killstreak.killqr/.MainActivity` nos AVDs API 26 e API 36; o componente ativo foi KillQR, a tela de scanner apareceu e o app `com.planejador.planejador` não foi aberto.
- A suíte local terminou com 12 testes passando e 1 teste nativo host marcado como skip por não ser Windows/Android; o AVD confirmou visualmente scanner, histórico, gerador, configurações, filtros e templates.
- O campo de conteúdo do gerador usa altura mínima de três linhas e cresce até oito linhas; Configurações agora aceita cor de destaque personalizada por sliders RGB ou código HEX, com persistência local. Ambos foram exercitados no AVD sem FATAL/ANR.
- O botão Salvar PNG grava em `Pictures/KillQR`, exibe confirmação de sucesso e foi validado nos AVDs API 26 e API 36; API 26 pediu somente a permissão legada limitada ao salvamento explícito.
- A importação de imagem abriu o DocumentsUI e leu `KillQR` nos AVDs API 26 e API 36, identificando origem `Image`; o fluxo usa `ACTION_OPEN_DOCUMENT` via `file_selector` e não pede leitura ampla do armazenamento.
- PDF usa `PdfRenderer` nativo com limite de 50 páginas/3.000 px; Office moderno usa a dependência MIT `archive` 4.2.0 para extrair somente mídias incorporadas. Arquivos Office binários antigos e QR desenhado como vetor/texto permanecem fora do escopo offline.
- Smoke funcional no AVD API 36 selecionou um `.docx` com QR incorporado e um `.pdf` com QR renderizado, ambos abrindo o resultado `KillQR` com origem `Image`; não houve FATAL/ANR.
- `flutter pub get --offline`, `flutter analyze`, `flutter test`, `flutter build apk --release`, `scripts/audit_android.ps1` e `scripts/check_prohibited_dependencies.ps1` passaram após este código; o APK produto tem SHA-256 `C1C4CF1CDF0F8F51F8714BB5744C4C3C98BD5AAB3EAD6E173285C416F96AC237` e 74.999.649 bytes.
- O ícone de lançamento foi substituído pela arte KillQR fornecida pelo proprietário; a fonte ajustada está em
  `assets/branding/killqr-app-icon-source.png`, com recursos `ic_launcher.png` gerados em mdpi, hdpi, xhdpi,
  xxhdpi e xxxhdpi. O manifesto também declara o mesmo recurso para `roundIcon`.
- O APK recompilado com o ícone tem SHA-256
  `F912B3003DC7CCDB26444530DA27189C7331AAEA4AA1F7285111A042F600CD4B` e 75.098.297 bytes; instalação e abertura
  do componente `com.killstreak.killqr/.MainActivity` passaram no AVD disponível (`emulator-5556`).
- A margem preta externa do ícone foi removida por recorte opaco em
  `assets/branding/killqr-app-icon-opaque.png`; as densidades Android permanecem totalmente opacas e a versão
  instalada foi conferida no launcher do AVD.
- A leitura PDF foi ajustada para preservar até 3.000 px, tentar códigos invertidos e permitir o controle de
  múltiplos códigos que antes estava bloqueado por `IgnorePointer`. No arquivo local `DAS 06-2026.pdf`, o AVD
  identificou simultaneamente o QR Pix (`QR Code`) e o código de barras `ITF`.
- A importação de documentos passou a solicitar varredura múltipla automaticamente, sem depender do seletor da
  câmera. Com o seletor desligado no estado inicial, o mesmo PDF abriu a tela `2 Scan` com QR Pix e ITF.
- O indicador da leitura contínua foi retirado do `Stack` sobre a câmera e passou a ocupar uma faixa própria,
  mantendo livres os controles de flash e câmera frontal. O histórico agora usa `watchScans()` do Drift, atualiza
  automaticamente após uma inserção e mantém `RefreshIndicator`/`AlwaysScrollableScrollPhysics` durante o carregamento
  e no estado vazio; o AVD confirmou os dois estados sem exceções.
- O APK final com o recorte opaco do ícone tem SHA-256
  `63AC9A3DC364CB15AD3300B3C18CBC54F0BDAF08587B55126DD3B6A5F1B64DB2` e 75.133.853 bytes; `flutter analyze`,
  `flutter test`, build release e as duas auditorias Android permanecem aprovados.
- A geração linear foi corrigida para CodaBar, EAN8, EAN13, ITF, UPCA e UPCE:
  cada formato recebe conteúdo inicial válido, templates incompatíveis ficam desabilitados, entradas manuais são
  validadas e o encoder usa a proporção correta de código 1D. O smoke Android gerou e releu os seis formatos; o APK
  do produto também foi verificado visualmente com CodaBar e EAN8, sem erro na interface.
- O APK release atualizado tem SHA-256
  `091FB9890F9D044FAE42571FB5931199E9AB9AF5F402A0C10F6814E5ECED0FDF` e 75.133.853 bytes; `flutter analyze`,
  `flutter test` (17 testes, 1 skip nativo de host), build release e as auditorias Android passaram.
- A versão `0.1.1+2` exibe notas de versão localizadas uma única vez após a atualização, usando a preferência local
  `last_seen_release`; a primeira abertura do APK mostrou o diálogo e a segunda não o exibiu novamente.
- O indicador contínuo agora fica dentro da área da câmera, no canto inferior direito (`x=664–1038` no AVD), sem
  ampliar o cabeçalho. Com o modo contínuo ativado, o PDF `DAS 06-2026.pdf` abriu `2 Scan` com QR Pix e ITF e o
  detalhe exibiu a origem `Importado`; não houve FATAL, `PlatformException` ou ANR.
- O APK release `0.1.1+2` tem SHA-256 `6C1D1DE402A22E682071640764441F78EE8F80AC75970E03E151CD78A8AFB0A3` e 75.133.897 bytes; `flutter analyze`,
  `flutter test`, build release e auditorias Android passaram após a implementação do changelog e do fluxo de
  documentos independente do modo contínuo.
- A versão `0.1.2+3` separa o changelog em `Melhorias` e `Correções de bugs`; a instrução do scanner passou a ser
  `Ative esta opção para escanear vários códigos ao mesmo tempo.` e o modo de leitura de documentos mostra uma janela
  modal `Analisando documento…` com progresso, bloqueio de fechamento acidental e permanência mínima de 350 ms.
- O APK release `0.1.2+3` tem SHA-256 `D7B732CF6E55ECC7EE68E48A44258C5F125714BD75AC7D915B35B4B1DA22C7F2` e 75.232.201 bytes;
  `flutter analyze`, `flutter test` (17 testes, 1 skip nativo de host), build release e as duas auditorias Android passaram.
- A versão `0.1.3+4` aplica a cor de destaque ao Switch de “vários códigos” (`primary` no trilho ativo e `onPrimary` no indicador)
  e adiciona o serviço nativo `KillQrTileService`, com ícone e label localizados. O AVD registrou o tile, exibiu “Abrir KillQR”
  no painel de configurações rápidas e o clique abriu `com.killstreak.killqr/.MainActivity`.
- O APK release `0.1.3+4` tem SHA-256 `5AE7D4BCA8BCCA0385B7975D48859793774079A44D4BC178FFA196E8E21D4CF6` e 75.217.589 bytes;
  `flutter analyze`, `flutter test` (17 testes, 1 skip nativo de host), build release e as duas auditorias Android passaram.
- A versão `0.1.4+5` substitui o ícone do tile por uma matriz QR de 21×21 módulos com os três padrões de localização
  e renomeia o tile para “Escanear com KillQR” (ou “Scan with KillQR” no inglês). O AVD exibiu o novo rótulo e o clique
  abriu `com.killstreak.killqr/.MainActivity`.
- O APK release `0.1.4+5` tem SHA-256 `D207782B09FA8387A3F5194A609A8D362BA72C0144C99CF9B109C3C8681AD69D` e 75.217.877 bytes;
  `flutter analyze`, `flutter test` (17 testes, 1 skip nativo de host), build release e as duas auditorias Android passaram.
- A versão `0.1.5+6` adiciona o cliente de releases do GitHub com limite automático de uma consulta diária, verificação manual,
  “Lembrar mais tarde” por 24 horas e “Não lembrar mais” equivalente à desativação. A release CI recebe `GITHUB_REPOSITORY`
  por `dart-define`, publica APK e SHA-256 em tags `vMAJOR.MINOR.PATCH`, e exige uma chave de assinatura por Secrets.
- README.md passou a ser inglês por padrão, `README.pt-BR.md` foi adicionado com links de seleção de idioma, e os workflows
  de CI/release foram criados em `.github/workflows/`. O build local `0.1.5+6` passou em análise, 20 testes (1 skip nativo),
  build release e auditorias Android; o APK declara INTERNET somente para o verificador de releases.
- O APK local `0.1.5+6` tem SHA-256 `DB6BFF4DA08BA09C3D26502078F048C9100B3B672FE0F98B16F5F0332DD744E2` e 76.004.393 bytes.

#### Fontes primárias de dependências e engines

- [flutter_zxing no pub.dev](https://pub.dev/packages/flutter_zxing) e [changelog](https://pub.dev/packages/flutter_zxing/changelog): versão, capabilities, formatos e mudanças recentes.
- [pubspec atual do flutter_zxing](https://raw.githubusercontent.com/khoren93/flutter_zxing/master/pubspec.yaml) e [licença MIT](https://raw.githubusercontent.com/khoren93/flutter_zxing/master/LICENSE).
- [ZXing-C++](https://github.com/zxing-cpp/zxing-cpp) e [licença Apache-2.0](https://raw.githubusercontent.com/zxing-cpp/zxing-cpp/master/LICENSE).
- [Zint/libzint](https://github.com/zint/zint): distinção entre licença BSD da biblioteca de encoding e GPLv3 da GUI/CLI.
- [flutter_riverpod](https://pub.dev/packages/flutter_riverpod), [drift](https://pub.dev/packages/drift), [drift_dev](https://pub.dev/packages/drift_dev), [sqlite3](https://pub.dev/packages/sqlite3), [camera](https://pub.dev/packages/camera), [image_picker](https://pub.dev/packages/image_picker), [file_selector](https://pub.dev/packages/file_selector), [path_provider](https://pub.dev/packages/path_provider), [shared_preferences](https://pub.dev/packages/shared_preferences), [share_plus](https://pub.dev/packages/share_plus), [url_launcher](https://pub.dev/packages/url_launcher), [android_intent_plus](https://pub.dev/packages/android_intent_plus), [permission_handler](https://pub.dev/packages/permission_handler), [intl](https://pub.dev/packages/intl) e [flutter_lints](https://pub.dev/packages/flutter_lints).
- [Documentação Drift para VM/native](https://drift.simonbinder.eu/platforms/vm/) e [plataformas Drift](https://drift.simonbinder.eu/platforms/).
- [Documentação sqlite3.dart](https://pub.dev/documentation/sqlite3/latest/index.html) e [hooks nativos](https://github.com/simolus3/sqlite3.dart/blob/main/sqlite3/doc/hook.md).

#### Fontes primárias Android e F-Droid

- [Android Photo Picker](https://developer.android.com/training/data-storage/shared/photo-picker): seleção segura e fallback para ACTION_OPEN_DOCUMENT, sem armazenamento amplo.
- [Android application element e backup](https://developer.android.com/guide/topics/manifest/application-element) e [mudanças de backup no Android 12](https://developer.android.com/about/versions/12/behavior-changes-12?hl=en): allowBackup, dataExtractionRules e diferenças OEM.
- [Android package visibility](https://developer.android.com/training/package-visibility): queries seletivas e restrições de API 30+.
- [F-Droid Inclusion Policy](https://f-droid.org/docs/Inclusion_Policy/), [Reproducible Builds](https://f-droid.org/docs/Reproducible_Builds/), [Flutter metadata guide](https://gitlab.com/fdroid/wiki/-/wikis/Metadata/YAML-Metadata) e [Build Metadata Reference](https://f-droid.org/docs/Build_Metadata_Reference/).
- [Compatibilidade Java/Gradle](https://docs.gradle.org/current/userguide/compatibility.html): Java 25 requer Gradle 9.1.0 ou superior; a compatibilidade com Java 17 também será preservada.

### Próximo passo autorizado

A aprovação foi recebida em 2026-09-05. As Fases 1–13 foram implementadas e
validadas no ambiente local sem publicação externa. O próximo passo, caso o
proprietário deseje um candidato distribuível, é fornecer um repositório Git
canônico e executar a matriz externa de API 26/ARM64, TalkBack e F-Droid; isso
não deve ser inferido nem publicado automaticamente.

~~~text
APROVAR PLANO
~~~

Depois dela, manter este arquivo atualizado se a matriz externa revelar alguma
incompatibilidade de dependência, licença, build offline ou permissão.
