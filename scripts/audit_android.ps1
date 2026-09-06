param(
  [string]$ApkPath = "build\app\outputs\flutter-apk\app-release.apk"
)

$ErrorActionPreference = 'Stop'

$manifestFiles = Get-ChildItem -Path 'android' -Filter 'AndroidManifest.xml' -Recurse -File
$sourceManifestText = ($manifestFiles | ForEach-Object {
    Get-Content -Raw -LiteralPath $_.FullName
  }) -join "`n"
if ($sourceManifestText -match 'android\.permission\.WRITE_EXTERNAL_STORAGE' -and
    $sourceManifestText -notmatch 'android\.permission\.WRITE_EXTERNAL_STORAGE"\s+android:maxSdkVersion="28"') {
  throw 'WRITE_EXTERNAL_STORAGE must be limited to maxSdkVersion=28.'
}

if (Test-Path -LiteralPath $ApkPath) {
  $apkanalyzer = Get-Command apkanalyzer -ErrorAction SilentlyContinue
  if (-not $apkanalyzer) {
    Write-Warning 'apkanalyzer was not found; source-manifest audit passed, APK audit skipped.'
    exit 0
  }

  $manifestXml = (& $apkanalyzer.Source manifest print $ApkPath | Out-String)
  $forbiddenPermissions = @(
    'android.permission.RECORD_AUDIO',
    'android.permission.READ_EXTERNAL_STORAGE',
    'android.permission.ACCESS_NETWORK_STATE'
  )
  $foundForbidden = $forbiddenPermissions | Where-Object {
    $manifestXml -match ('android:name="' + [regex]::Escape($_) + '"')
  }
  if ($foundForbidden) {
    throw "Forbidden permissions declared by APK: $($foundForbidden -join ', ')"
  }
  if ($manifestXml -match 'android:name="android.permission.WRITE_EXTERNAL_STORAGE"') {
    if ($manifestXml -notmatch 'android:name="android.permission.WRITE_EXTERNAL_STORAGE"[^>]*android:maxSdkVersion="28"') {
      throw 'APK WRITE_EXTERNAL_STORAGE is not limited to maxSdkVersion=28.'
    }
  }
  Write-Output "APK permission audit passed: $ApkPath"
} else {
  Write-Output 'Source-manifest audit passed. APK audit skipped because the APK does not exist yet.'
}
