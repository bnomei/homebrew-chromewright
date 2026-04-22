# homebrew-chromewright

Homebrew tap for `chromewright`.

## Install

```bash
brew install bnomei/chromewright/chromewright
```

## Maintain

The formula currently builds from a pinned GitHub commit archive because
`bnomei/chromewright` does not publish GitHub tags/releases yet.

To refresh the checksum for the current pinned commit:

```bash
scripts/update-sha256.sh
```

To bump to a different commit and optionally a new version:

```bash
scripts/update-sha256.sh <commit> [version]
```
