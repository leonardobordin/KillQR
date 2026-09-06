# Changelog

[English](CHANGELOG.md) · [Português (Brasil)](CHANGELOG.pt-BR.md)

Todas as alterações importantes do KillQR estão documentadas aqui.

## Não lançado

### Melhorias

- Tornada ajustável a área de leitura da câmera; somente a região central
  selecionada é analisada na leitura de um único código.
- Movidos a lanterna, a troca de câmera, a importação de documentos e os modos
  do scanner para a barra superior, com menu adaptativo em telas estreitas.
- Adicionados controles inferiores para o tamanho da área de leitura e o zoom
  da câmera.
- Adicionadas explicações na primeira ativação da leitura contínua e da leitura
  de vários códigos, com a opção persistente “Não exibir novamente”.

### Correções de bugs

- Removidos o antigo botão de vários códigos e o indicador do modo contínuo
  sobre a prévia da câmera.

## 0.1.5 - 2026-09-05

### Melhorias

- Adicionada a verificação opcional automática e manual de releases do GitHub
  nas Configurações.
- Adicionadas as opções “Lembrar mais tarde” e “Não lembrar mais”.
- Adicionado o README em inglês como padrão, com README em português do Brasil.
- Adicionada a autoria “Leonardo Silva Bordin” à tela Sobre e à documentação.
- Reorganizados os READMEs com identidade visual, funcionalidades, download,
  compilação, privacidade, releases e autoria.
- Adicionados workflows do GitHub Actions para validação e publicação de APKs.

### Correções de bugs

- A verificação de atualizações agora respeita as preferências de desativação e
  adiamento do usuário.

## 0.1.4 - 2026-09-05

### Melhorias

- Substituída a arte do tile de Configurações rápidas por uma matriz de QR Code
  reconhecível.
- Renomeado o tile para `Escanear com KillQR`.

### Correções de bugs

- Corrigidos o nome e o ícone exibidos pelo Android depois que o tile é
  adicionado ao painel de Configurações rápidas.

## 0.1.3 - 2026-09-05

### Melhorias

- Adicionado um tile do KillQR às Configurações rápidas do Android.
- Atualizada a versão para `0.1.3+4` com notas de atualização categorizadas.

### Correções de bugs

- Corrigido o botão de vários códigos para acompanhar a cor de destaque
  configurada.

## 0.1.2 - 2026-09-05

### Melhorias

- Reorganizadas as notas de versão dentro do app em `Melhorias` e `Correções
  de bugs`.
- Substituída a instrução do scanner por uma explicação direta de que a opção
  ativa a leitura de vários códigos ao mesmo tempo.
- Adicionada uma janela de carregamento com o texto `Analisando documento…`
  durante a leitura de imagens, PDFs e documentos Office.
- Atualizada a versão para `0.1.2+3`, com notas exibidas uma vez na primeira
  abertura após a instalação.

### Correções de bugs

- Corrigada a importação de documentos, que era encaminhada ao modo contínuo
  quando esse modo estava ativo.

## 0.1.1 - 2026-09-05

### Melhorias

- Movido o indicador do modo contínuo para o canto inferior direito da câmera,
  deixando livres os controles de flash e câmera frontal.
- Esclarecida a instrução da câmera para explicar que `Vários códigos` lê
  diversos códigos ao mesmo tempo.
- Adicionados metadados monotônicos de versão (`0.1.1+2`) e notas localizadas
  exibidas uma vez após cada atualização.

### Correções de bugs

- Desacopladas as importações de imagens, PDFs e documentos Office modernos do
  modo contínuo. Resultados importados passaram a usar a origem `Importado`.

## 0.1.0 - 2026-09-05

### Melhorias

- Adicionado scanner offline de QR Codes e códigos de barras para Android,
  usando `flutter_zxing`.
- Adicionada interpretação local segura de URLs, telefone, SMS, e-mail, Wi-Fi,
  contatos, eventos, coordenadas geográficas e produtos.
- Adicionada confirmação antes de abrir intents externos e URLs.
- Adicionado histórico local Drift/SQLite com notas, favoritos, etiquetas e
  sessões de leitura contínua.
- Adicionadas importação e exportação JSON/CSV com validação, limites e regras
  para duplicatas.
- Adicionada geração de códigos de barras, templates e exportação PNG.
- Adicionado salvamento explícito de PNG na galeria com confirmação de sucesso.
- Adicionado seletor offline de imagens, PDFs e documentos Office modernos, com
  carregamento visível e mensagens para ausência de código ou erro.
- Substituído o ícone padrão pelo logo neon de QR Code fornecido para o KillQR.
- Removida a margem preta externa do ícone opaco para preencher melhor o espaço
  dos ícones do launcher.
- Melhorada a leitura de PDFs, incluindo códigos invertidos, QR Pix e código de
  barras ITF do documento DAS.
- Alterada a importação de documentos para ler todos os códigos
  automaticamente.
- Movido o indicador contínuo para fora da área dos controles da câmera e
  atualizado o histórico em tempo real.
- Adicionados inglês, português do Brasil, temas, AMOLED, cores de destaque
  RGB/HEX e mecanismos configuráveis de pesquisa de produtos.
- Feita a expansão limitada do campo de conteúdo do gerador.
- Corrigida a geração linear de CodaBar, EAN8, EAN13, ITF, UPCA e UPCE.
- Adicionadas auditorias do manifesto Android e smoke test nativo de release.

Esta versão é um candidato de build a partir do código-fonte. Ainda não foi
publicada em loja nem enviada ao F-Droid.
