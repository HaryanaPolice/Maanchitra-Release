#!/bin/sh
set -eu

if [ "$#" -ne 3 ]; then
  echo "Usage: $0 <signed-apk> <version-name> <version-code>" >&2
  exit 1
fi

apk_path=$1
version_name=$2
version_code=$3

if [ ! -f "$apk_path" ]; then
  echo "APK not found: $apk_path" >&2
  exit 1
fi

case "$version_name" in
  ''|*[!A-Za-z0-9._+-]*) echo "Invalid version name" >&2; exit 1 ;;
esac

case "$version_code" in
  ''|*[!0-9]*) echo "Invalid version code" >&2; exit 1 ;;
esac

asset="Maanchitra-v$version_name-release.apk"
mkdir -p dist
cp "$apk_path" "dist/$asset"

if command -v shasum >/dev/null 2>&1; then
  sha256=$(shasum -a 256 "dist/$asset" | awk '{print $1}')
else
  sha256=$(sha256sum "dist/$asset" | awk '{print $1}')
fi

cat > update.json <<EOF
{
  "versionCode": $version_code,
  "versionName": "$version_name",
  "apkUrl": "https://github.com/HaryanaPolice/Maanchitra-Release/releases/download/v$version_name/$asset",
  "sha256": "$sha256"
}
EOF

cp update.json dist/update.json
echo "Prepared dist/$asset and dist/update.json"
