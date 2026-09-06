param(
  [string]$Device = "emulator-5554"
)

$ErrorActionPreference = 'Stop'
$package = 'com.killstreak.killqr'
$component = "$package/.MainActivity"
$oldPackage = 'com.planejador.planejador'
$apk = Join-Path $PWD 'build\app\outputs\flutter-apk\app-release.apk'

flutter build apk --release --target=lib/spikes/native_smoke.dart
if (-not (Test-Path -LiteralPath $apk)) {
  throw "Smoke APK was not generated: $apk"
}

adb -s $Device wait-for-device
adb -s $Device install -r $apk
adb -s $Device shell am force-stop $oldPackage
adb -s $Device shell am force-stop $package
adb -s $Device shell am start -n $component
Start-Sleep -Seconds 8

$active = adb -s $Device shell dumpsys activity activities | Select-String -SimpleMatch $component
if (-not $active) {
  throw "The expected component is not active: $component"
}

$uiDumpPath = '/sdcard/killqr-ui.xml'
adb -s $Device shell uiautomator dump $uiDumpPath | Out-Null
$ui = adb -s $Device shell cat $uiDumpPath
if ($ui -notmatch 'DRIFT: PASS' -or $ui -notmatch 'ZXING ENCODE/DECODE: PASS') {
  throw "Native smoke did not report both Drift and ZXing as PASS."
}

Write-Output "Active component: $component"
Write-Output 'Native smoke passed: Drift and ZXing.'
