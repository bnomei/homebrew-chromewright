#!/usr/bin/env bash
set -euo pipefail

repo="bnomei/chromewright"
formula="Formula/chromewright.rb"

commit="${1:-}"
version="${2:-}"

if [[ -z "${commit}" ]]; then
  commit="$(
    ruby -ne 'if $_ =~ %r{url\s+"https://github.com/bnomei/chromewright/archive/([0-9a-f]{40})\.tar\.gz"}; puts $1; exit; end' \
      "$formula"
  )"
fi

if [[ -z "${version}" ]]; then
  version="$(
    ruby -ne 'if $_ =~ /version\s+"([^"]+)"/; puts $1; exit; end' \
      "$formula"
  )"
fi

if [[ -z "${commit}" ]]; then
  echo "Failed to determine commit from ${formula}." >&2
  exit 1
fi

if [[ -z "${version}" ]]; then
  echo "Failed to determine version from ${formula}." >&2
  exit 1
fi

url="https://github.com/${repo}/archive/${commit}.tar.gz"

workdir="$(mktemp -d)"
trap 'rm -rf "$workdir"' EXIT

archive="${workdir}/chromewright-${commit}.tar.gz"

echo "Downloading ${url}"
curl -fsSL "${url}" -o "${archive}"

if command -v shasum >/dev/null 2>&1; then
  sha256="$(shasum -a 256 "${archive}" | awk '{print $1}')"
elif command -v sha256sum >/dev/null 2>&1; then
  sha256="$(sha256sum "${archive}" | awk '{print $1}')"
else
  echo "Missing shasum/sha256sum to compute checksums." >&2
  exit 1
fi

python3 - "${formula}" "${version}" "${commit}" "${sha256}" <<'PY'
import re
import sys

formula, version, commit, sha256 = sys.argv[1:5]

with open(formula, "r", encoding="utf-8") as f:
    text = f.read()

text = re.sub(r'^\s*version\s+"[^"]+"$', f'  version "{version}"', text, flags=re.MULTILINE)
text = re.sub(
    r'^\s*url\s+"https://github.com/bnomei/chromewright/archive/[0-9a-f]{40}\.tar\.gz"$',
    f'  url "https://github.com/bnomei/chromewright/archive/{commit}.tar.gz"',
    text,
    flags=re.MULTILINE,
)
text = re.sub(r'^\s*sha256\s+"[a-f0-9]{64}"$', f'  sha256 "{sha256}"', text, flags=re.MULTILINE)

with open(formula, "w", encoding="utf-8") as f:
    f.write(text)
PY

printf "Updated %s\n" "${formula}"
printf "Version: %s\n" "${version}"
printf "Commit: %s\n" "${commit}"
printf "SHA-256: %s\n" "${sha256}"
