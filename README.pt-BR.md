# KillQR

<p align="center">
  <img src="assets/branding/killqr-app-icon-opaque.png" alt="Ícone do KillQR" width="168">
</p>

<h1 align="center">KillQR</h1>

<p align="center">
  <strong>Kit privado e offline-first para QR Codes e códigos de barras no Android.</strong><br>
  Leia, gere, importe e gerencie códigos sem conta, anúncios ou armazenamento em nuvem.
</p>

<p align="center">
  <a href="https://github.com/leonardobordin/KillQR/actions/workflows/ci.yml"><img src="https://github.com/leonardobordin/KillQR/actions/workflows/ci.yml/badge.svg" alt="Status do CI"></a>
  <a href="https://github.com/leonardobordin/KillQR/releases/latest"><img src="https://img.shields.io/github/v/release/leonardobordin/KillQR?display_name=tag" alt="Última release"></a>
  <a href="https://developer.android.com/about/versions/oreo"><img src="https://img.shields.io/badge/Android-API%2026%2B-3DDC84?logo=android&logoColor=white" alt="Android API 26 ou superior"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/license-Apache--2.0-2ea44f?logo=apache&logoColor=white" alt="Licença Apache-2.0"></a>
</p>

<p align="center">
  <a href="https://github.com/leonardobordin/KillQR/releases/latest">Baixar o APK mais recente</a> ·
  <a href="#destaques">Destaques</a> ·
  <a href="docs/BUILDING.md">Guia de compilação</a> ·
  <a href="docs/PRIVACY.md">Privacidade</a>
</p>

<p align="center">
  <a href="README.md">English</a> ·
  <a href="README.pt-BR.md">Português (Brasil)</a>
</p>

## Conteúdo

- [Visão geral](#visão-geral)
- [Destaques](#destaques)
- [Download](#download)
- [Compilar a partir do código-fonte](#compilar-a-partir-do-código-fonte)
- [Releases e atualizações automáticas](#releases-e-atualizações-automáticas)
- [Privacidade e permissões](#privacidade-e-permissões)
- [Mapa do projeto](#mapa-do-projeto)
- [Contribuição](#contribuição)
- [Autoria e licença](#autoria-e-licença)

## Visão geral

O KillQR é um aplicativo Android offline-first para ler e gerar QR Codes e
códigos de barras. As leituras, os conteúdos gerados e o histórico permanecem
no dispositivo. O app não exige conta, telemetria, anúncios, Google Play
Services ou armazenamento em nuvem.

Ele foi feito para quem quer uma ferramenta objetiva de QR Codes e códigos de
barras, com suporte útil a documentos, histórico local e controle claro sobre
o que sai do dispositivo.

## Destaques

| Ler | Criar | Manter o controle |
| --- | --- | --- |
| Câmera, imagens, PDFs e documentos Office compatíveis | QR Codes e formatos lineares compatíveis | Histórico local, modo privado e sem conta |
| Vários códigos e leitura contínua | Cor de destaque RGB/HEX personalizada | Verificações opcionais de atualização pelo GitHub |

### Leitura

- Leia QR Codes e códigos de barras pela câmera ou por imagens selecionadas.
- Leia vários códigos em uma captura e use sessões de leitura contínua.
- Redimensione a área central de leitura e ajuste o zoom da câmera na tela do scanner.
- Importe PDFs e documentos Office modernos, analisando páginas renderizadas ou
  imagens incorporadas quando houver suporte.
- Interprete localmente URLs, telefones, SMS, e-mails, Wi-Fi, contatos,
  eventos, localizações e códigos de produto.
- Confirme antes de abrir um aplicativo externo ou link.

### Geração

- Gere QR Codes e formatos lineares compatíveis, como CodaBar, EAN-8, EAN-13,
  ITF, UPC-A e UPC-E.
- Escolha uma cor de destaque personalizada usando controles RGB ou HEX.
- Exporte códigos gerados como PNG para a galeria e receba uma confirmação de
  salvamento.

### Histórico e dados

- Mantenha um histórico SQLite local com pesquisa, filtros, favoritos, notas,
  etiquetas e origem da leitura.
- Importe e exporte arquivos JSON e CSV validados.
- Use o modo privado quando um resultado não deve ser salvo automaticamente.

### Experiência Android

- Temas Sistema, Claro, Escuro e AMOLED.
- Traduções para inglês, português do Brasil, espanhol, francês, alemão,
  italiano, japonês e chinês simplificado.
- Tile de Configurações rápidas chamado **Escanear com KillQR**.
- Lanterna, troca de câmera, importação de documentos e modos de leitura ficam
  na barra superior, com menu de opções em telas estreitas.
- Explicações na primeira ativação esclarecem a leitura contínua e de vários
  códigos, com opção persistente para não exibi-las novamente.
- Novidades exibidas uma vez depois de uma atualização.
- Verificação opcional de releases do GitHub, com verificação manual,
  **Lembrar mais tarde** e **Não lembrar mais**.

## Download

Baixe o APK assinado mais recente nas
[GitHub Releases](https://github.com/leonardobordin/KillQR/releases/latest) ou
consulte o [histórico completo de releases](https://github.com/leonardobordin/KillQR/releases).
Cada release inclui um checksum SHA-256; verifique-o antes de instalar o APK.

Atualmente o KillQR é distribuído pelas GitHub Releases. A publicação em lojas
ainda não é automatizada.

Consulte o [changelog em inglês](CHANGELOG.md) ou o
[changelog em português do Brasil](CHANGELOG.pt-BR.md) para ver o histórico de
releases.

## Compilar a partir do código-fonte

### Requisitos

- Flutter 3.47.2 / Dart 3.13.2;
- Android SDK API 36, Build Tools 36.x e NDK 28.2.13676358;
- Java 17 ou um JDK compatível do Android Studio;
- Android API 26 ou superior.

### Validar e compilar

```powershell
git clone https://github.com/leonardobordin/KillQR.git
cd KillQR
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

Envie uma tag seguindo Semantic Versioning, como `v0.1.6`, para executar o
[`release.yml`](.github/workflows/release.yml). O workflow valida o projeto,
executa os testes, compila o APK assinado, calcula o checksum SHA-256 e publica
uma GitHub Release.

O app pode consultar as releases oficiais do GitHub uma vez por dia ou quando
solicitado nas Configurações. As verificações automáticas podem ser
interrompidas, adiadas com **Lembrar mais tarde** ou desativadas com **Não
lembrar mais**. O KillQR nunca instala um APK silenciosamente: o Android sempre
pede confirmação ao usuário.

O processo de release e os segredos de assinatura necessários estão documentados
em [`docs/RELEASING.md`](docs/RELEASING.md).

## Privacidade e permissões

O KillQR processa leituras e histórico localmente. As permissões têm finalidade
específica:

| Acesso | Uso |
| --- | --- |
| Câmera | Leitura de QR Codes e códigos de barras ao vivo |
| Fotos/arquivos | Somente quando o usuário escolhe uma imagem ou documento, ou exporta um PNG |
| Internet | Somente para verificações opcionais de releases do GitHub |

Leia a política completa em [`docs/PRIVACY.md`](docs/PRIVACY.md).

## Mapa do projeto

| Caminho | Finalidade |
| --- | --- |
| [`lib/`](lib/) | Código-fonte do aplicativo Flutter |
| [`test/`](test/) | Testes unitários e de widgets |
| [`docs/BUILDING.md`](docs/BUILDING.md) | Build local e smoke test Android |
| [`docs/RELEASING.md`](docs/RELEASING.md) | Processo de release assinado |
| [`docs/PRIVACY.md`](docs/PRIVACY.md) | Política de dados e permissões |
| [`docs/THIRD_PARTY_LICENSES.md`](docs/THIRD_PARTY_LICENSES.md) | Inventário de licenças das dependências |
| [`CHANGELOG.md`](CHANGELOG.md) | Histórico de releases em inglês |
| [`CHANGELOG.pt-BR.md`](CHANGELOG.pt-BR.md) | Histórico de releases em português do Brasil |

## Traduções

O app inclui inglês e português do Brasil. Contribuições para os arquivos de
tradução são bem-vindas; a fonte da localização está em [`lib/l10n/`](lib/l10n/).

## Contribuição

Relatos de bugs, ideias de funcionalidades e pull requests são bem-vindos.
Para mudanças que afetem leitura, importação de documentos, permissões ou
releases, inclua a versão do Android e uma breve nota de reprodução ou
validação.

## Autoria e licença

O KillQR foi criado e é mantido por **Leonardo Silva Bordin**.

O código-fonte está sob a [Licença Apache 2.0](LICENSE). A atribuição de
copyright está registrada em [`NOTICE`](NOTICE). Os avisos de dependências e
terceiros estão listados em [`docs/THIRD_PARTY_LICENSES.md`](docs/THIRD_PARTY_LICENSES.md).

O KillQR é um projeto independente e não é afiliado ao Google, Android, GitHub,
ZXing ou a qualquer fornecedor de códigos de barras. Nomes e ativos de
terceiros citados continuam sujeitos aos respectivos proprietários e licenças.

<p align="center">
  Feito com cuidado por <a href="https://github.com/leonardobordin"><strong>Leonardo Silva Bordin</strong></a>.
</p>
