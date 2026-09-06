# GitHub release procedure

The release workflow publishes a signed APK whenever a tag matching
`vMAJOR.MINOR.PATCH` is pushed. The tag must match the `versionName` in
`pubspec.yaml`; the build number after `+` remains the Android `versionCode`.

## One-time repository configuration

Create or use a permanent Android upload keystore outside this repository.
The same signing identity must be preserved for future updates:

```text
keytool -genkeypair -v -keystore killqr-release.jks -alias killqr \
  -keyalg RSA -keysize 2048 -validity 10000
```

Add these GitHub Actions repository secrets under **Settings → Secrets and
variables → Actions**:

- `ANDROID_KEYSTORE_BASE64`: the Base64 content of `killqr-release.jks`;
- `ANDROID_KEYSTORE_PASSWORD`: keystore password;
- `ANDROID_KEY_ALIAS`: key alias, for example `killqr`;
- `ANDROID_KEY_PASSWORD`: key password.

Never commit the keystore, passwords, or a decoded key to the repository.

## Publish a release

1. Update `pubspec.yaml`, `AppRelease`, localized version text, and the English
   `CHANGELOG.md`. Keep `CHANGELOG.pt-BR.md` synchronized for readers who use
   Brazilian Portuguese; GitHub Release notes are extracted from the English
   changelog so that each release has one consistent language.
2. Run `flutter analyze`, `flutter test`, and a local release build.
3. Commit the changes and create a matching tag, for example:

   ```text
   git tag -a v0.1.6 -m "KillQR 0.1.6"
   git push origin main --follow-tags
   ```

4. GitHub Actions validates the tag, builds the APK with the repository name
   embedded for the updater, calculates SHA-256, and creates the GitHub Release.

The app queries `https://api.github.com/repos/<owner>/<repo>/releases/latest`
when automatic checks are enabled or the user requests a manual check. It
opens the APK asset or release page; Android still asks the user to confirm the
installation.
