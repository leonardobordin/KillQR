# KillQR

<p align="center">
  <img src="assets/branding/killqr-app-icon-opaque.png" alt="Ícone do KillQR" width="180">
</p>

<h3 align="center">Leitor e gerador offline de QR Codes e códigos de barras para Android</h3>

<p align="center">
  Privado por padrão · Sem conta · Sem anúncios · Código aberto
</p>

<p align="center">
  <a href="https://github.com/leonardobordin/KillQR/releases">Download</a> ·
  <a href="#funcionalidades">Funcionalidades</a> ·
  <a href="docs/BUILDING.md">Guia de compilação</a> ·
  <a href="docs/PRIVACY.md">Privacidade</a>
</p>

<p align="center">
  <a href="README.md">English</a> ·
  <a href="README.pt-BR.md">Português (Brasil)</a>
</p>

<p align="center">
  <a href="https://github.com/leonardobordin/KillQR/actions/workflows/ci.yml"><img src="https://github.com/leonardobordin/KillQR/actions/workflows/ci.yml/badge.svg" alt="Status do CI"></a>
  <a href="https://github.com/leonardobordin/KillQR/releases"><img src="https://img.shields.io/github/v/release/leonardobordin/KillQR?display_name=tag" alt="Última release"></a>
  <a href="LICENSE"><img src="https://img.shields.io/github/license/leonardobordin/KillQR" alt="Licença Apache-2.0"></a>
</p>

## O que é o KillQR?

O KillQR é um aplicativo Android offline-first para ler e gerar QR Codes e
códigos de barras. As leituras, os conteúdos gerados e o histórico permanecem
no dispositivo. O app não exige conta, telemetria, anúncios, Google Play
Services ou armazenamento em nuvem.

O KillQR foi criado e é mantido por **Leonardo Silva Bordin**.

## Funcionalidades

### Leitura

- Leia QR Codes e códigos de barras pela câmera ou por imagens selecionadas.
- Leia vários códigos em uma captura e use sessões de leitura contínua.
- Importe PDFs e documentos Office modernos, analisando páginas renderizadas ou
  imagens incorporadas quando houver suporte.
- Interprete localmente URLs, telefones, SMS, e-mails, Wi-Fi, contatos,
  eventos, localizações e códigos de produto.
- Confirme antes de abrir um aplicativo externo ou link.

### Geração

- Gere QR Codes e formatos lineares compatíveis, como CodaBar, EAN-8, EAN-13,
  ITF, UPC-A e UPC-E.
- Escolha uma cor de destaque personalizada usando RGB ou HEX.
- Exporte códigos gerados como PNG para a galeria e receba uma confirmação de
  salvamento.

### Histórico e dados

- Mantenha um histórico SQLite local com pesquisa, filtros, favoritos, notas,
  etiquetas e origem da leitura.
- Importe e exporte arquivos JSON e CSV validados.
- Use o modo privado quando um resultado não deve ser salvo automaticamente.

### Experiência Android

- Temas Sistema, Claro, Escuro e AMOLED.
- Traduções para inglês e português do Brasil.
- Tile de Configurações rápidas chamado **Escanear com KillQR**.
- Novidades exibidas uma vez depois de uma atualização.
- Verificação opcional de releases do GitHub, com verificação manual,
  “Lembrar mais tarde” e “Não lembrar mais”.

## Download

Os APKs oficiais são publicados nas [GitHub Releases](https://github.com/leonardobordin/KillQR/releases)
por meio do workflow assinado de release do GitHub Actions. Verifique o arquivo
SHA-256 anexado a cada release antes de instalar um APK.

Atualmente o projeto é distribuído como candidato de build a partir do código-
fonte. A publicação em lojas não é feita automaticamente.

## Compilar a partir do código-fonte

### Requisitos

- Flutter 3.47.2 / Dart 3.13.2;
- Android SDK API 36, Build Tools 36.x e NDK 28.2.13676358;
- Java 17 ou um JDK compatível do Android Studio;
- Android API 26 ou superior.

### Validar e compilar

Na raiz do projeto:

```powershell
flutter pub get
dart run build_runner build
flutter gen-l10n
dart format --set-exit-if-changed .
flutter analyze
flutter test
flutter build apk --release --dart-define=GITHUB_REPOSITORY=leonardobordin/KillQR
```

O APK é gerado em
`build/app/outputs/flutter-apk/app-release.apk`. O fluxo completo de smoke test
Android está documentado em [`docs/BUILDING.md`](docs/BUILDING.md).

## Releases e atualizações automáticas

Envie uma tag seguindo Semantic Versioning, como `v0.1.5`, para executar
o [`.github/workflows/release.yml`](.github/workflows/release.yml). O workflow
valida o projeto, executa os testes, compila o APK assinado, calcula o checksum
SHA-256 e publica uma GitHub Release.

O processo de release e os segredos de assinatura necessários estão documentados
em [`docs/RELEASING.md`](docs/RELEASING.md). O app pode consultar as releases
oficiais do GitHub uma vez por dia ou quando solicitado nas Configurações. Ele
nunca instala um APK silenciosamente: o Android sempre pede confirmação.

## Privacidade e permissões

O KillQR processa leituras e histórico localmente. A rede é usada somente para
a verificação opcional de releases do GitHub. A câmera é usada para leituras por
câmera, e o acesso a documentos é solicitado somente quando o usuário escolhe
um arquivo. A exportação PNG usa a permissão de galeria apropriada nas versões
antigas do Android.

Leia a política completa em [`docs/PRIVACY.md`](docs/PRIVACY.md).

## Traduções

O app inclui inglês e português do Brasil. Contribuições para os arquivos de
tradução são bem-vindas; o fluxo de localização está em `lib/l10n/`.

## Autoria e licença

O KillQR foi criado e é mantido por **Leonardo Silva Bordin**.

O código-fonte está sob a [Licença Apache 2.0](LICENSE). Os avisos de
dependências e terceiros estão listados em
[`docs/THIRD_PARTY_LICENSES.md`](docs/THIRD_PARTY_LICENSES.md). Nomes e ativos
de terceiros citados continuam sujeitos aos respectivos proprietários e
licenças.

## Agradecimentos

O KillQR é construído com Flutter, Drift, SQLite, ZXing e outras bibliotecas de
código aberto. Consulte o [inventário de licenças de terceiros](docs/THIRD_PARTY_LICENSES.md)
para ver a lista completa.

## Aviso

O KillQR é um projeto independente e não é afiliado ao Google, Android, GitHub,
ZXing ou a qualquer fornecedor de códigos de barras. Sempre confira dados
importantes antes de usar um resultado lido.

## Autor

Feito com cuidado por **[Leonardo Silva Bordin](https://github.com/leonardobordin)**.
