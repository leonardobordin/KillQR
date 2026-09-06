$ErrorActionPreference = 'Stop'

$forbiddenPackages = @(
  'firebase',
  'google_ml_kit',
  'google_mobile_ads',
  'sentry_flutter',
  'webview_flutter',
  'connectivity_plus'
)

$lock = Get-Content -Raw pubspec.lock
$found = foreach ($package in $forbiddenPackages) {
  if ($lock -match "(?m)^  ${package}:") {
    $package
  }
}
if ($found) {
  throw "Prohibited packages found in pubspec.lock: $($found -join ', ')"
}

Write-Output 'Prohibited dependency audit passed.'
