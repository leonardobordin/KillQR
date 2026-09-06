# KillQR

[English](README.md) · [Português (Brasil)](README.pt-BR.md)

O KillQR é um leitor e gerador de QR Codes e códigos de barras para Android,
com funcionamento offline por padrão. As leituras e o histórico permanecem no
dispositivo. Não são necessários conta, telemetria, anúncios, Google Play
Services ou armazenamento em nuvem.

## Funcionalidades

- leitura pela câmera e por imagem, incluindo vários códigos;
- interpretação local de URLs, telefones, SMS, e-mails, Wi-Fi, contatos,
  eventos, localizações e códigos de produto;
- confirmação antes de abrir aplicativos externos;
- histórico SQLite local com pesquisa, filtros, favoritos, notas, etiquetas e
  sessões de leitura contínua;
- geração de QR Code e códigos de barras pelas capacidades reais do ZXing,
  incluindo exportação PNG;
- importação e exportação JSON/CSV com validação e controle de duplicatas;
- temas Sistema, Claro, Escuro e AMOLED; português do Brasil e inglês;
- verificação opcional de releases do GitHub, que pode ser desativada nas
  Configurações.

## Requisitos

- Flutter 3.47.2 / Dart 3.13.2;
- Android SDK API 36, Build Tools 36.x e NDK 28.2.13676358;
- Java 17 para a validação semelhante à do F-Droid (o Java 25 do Android
  Studio também é compatível com o Gradle 9.3.1 deste projeto);
- Android API 26 ou superior.

## Compilar e validar

Na raiz do projeto:

```powershell
flutter pub get --offline
dart run build_runner build
dart format --set-exit-if-changed .
flutter analyze
flutter test
flutter build apk --release --dart-define=GITHUB_REPOSITORY=OWNER/KillQR
powershell -ExecutionPolicy Bypass -File scripts/audit_android.ps1
powershell -ExecutionPolicy Bypass -File scripts/check_prohibited_dependencies.ps1
```

O APK de produto é `build/app/outputs/flutter-apk/app-release.apk`. O fluxo
completo de smoke test Android está documentado em
[`docs/BUILDING.md`](docs/BUILDING.md).

`GITHUB_REPOSITORY` é fornecido automaticamente pelo workflow de release do
GitHub. Em builds locais, substitua `OWNER/KillQR` pelo repositório real. O app
só acessa a rede ao verificar releases; leitura e histórico continuam locais.

## Releases e atualizações pelo GitHub

Envie uma tag seguindo Semantic Versioning, como `v0.1.5`, para disparar
`.github/workflows/release.yml`. O workflow analisa, testa, compila o APK
release, calcula seu checksum SHA-256 e publica os dois arquivos em uma GitHub
Release.

A configuração da assinatura e o checklist de release estão documentados em
[`docs/RELEASING.md`](docs/RELEASING.md).

Nas Configurações do app há opções para buscar atualizações automaticamente,
verificar manualmente, “Lembrar mais tarde” e “Não lembrar mais”. O Android
sempre pede a confirmação do usuário para instalar um APK; o app nunca instala
atualizações silenciosamente.

## Privacidade e licenças

Consulte [`docs/PRIVACY.md`](docs/PRIVACY.md), [`LICENSE`](LICENSE) e o
inventário de dependências em
[`docs/THIRD_PARTY_LICENSES.md`](docs/THIRD_PARTY_LICENSES.md). A pasta
`metadata/` é um rascunho F-Droid e não publica nem envia nada automaticamente.

## Estado da distribuição

A versão `0.1.5+6` é um candidato de build fonte. Este projeto não publica
automaticamente em lojas.
