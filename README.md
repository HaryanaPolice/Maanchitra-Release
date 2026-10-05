# Maanchitra

Official Android releases for Project Maanchitra.

## Release files

Each GitHub Release contains:

- `Maanchitra-vX.Y.Z-release.apk`
- `update.json`

## Prepare a release

Build the signed Android APK, then run:

```bash
./release.sh /path/to/app-release.apk 1.4.0 7
```

Upload both files created in `dist/` to a GitHub Release tagged `v1.4.0`.

For the next release, update the version name and increase the version code. For example, version `1.4.1` will produce `Maanchitra-v1.4.1-release.apk`.
