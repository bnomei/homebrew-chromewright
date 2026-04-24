#!/usr/bin/env bash
set -euo pipefail

repo="bnomei/chromewright"
formula="Formula/chromewright.rb"

version="${1:-}"

if [[ -z "${version}" ]]; then
  version="$(
    ruby -ne 'if $_ =~ /version\s+"([^"]+)"/; puts $1; exit; end' \
      "$formula"
  )"
fi

if [[ -z "${version}" ]]; then
  echo "Failed to determine version from ${formula}." >&2
  exit 1
fi

workdir="$(mktemp -d)"
trap 'rm -rf "$workdir"' EXIT

keys=(
  aarch64_apple_darwin
  x86_64_apple_darwin
  aarch64_unknown_linux_musl
  x86_64_unknown_linux_musl
)

asset_for_key() {
  case "$1" in
    aarch64_apple_darwin) printf "chromewright-v%s-aarch64-apple-darwin.tar.gz.sha256" "$version" ;;
    x86_64_apple_darwin) printf "chromewright-v%s-x86_64-apple-darwin.tar.gz.sha256" "$version" ;;
    aarch64_unknown_linux_musl) printf "chromewright-v%s-aarch64-unknown-linux-musl.tar.gz.sha256" "$version" ;;
    x86_64_unknown_linux_musl) printf "chromewright-v%s-x86_64-unknown-linux-musl.tar.gz.sha256" "$version" ;;
    *) return 1 ;;
  esac
}

args=()
for key in "${keys[@]}"; do
  asset="$(asset_for_key "$key")"
  url="https://github.com/${repo}/releases/download/v${version}/${asset}"
  checksum_file="${workdir}/${asset}"

  echo "Downloading ${url}"
  curl -fsSL "${url}" -o "${checksum_file}"

  sha256="$(awk '{print tolower($1)}' "${checksum_file}")"
  if [[ ! "${sha256}" =~ ^[a-f0-9]{64}$ ]]; then
    echo "Invalid SHA-256 in ${asset}: ${sha256}" >&2
    exit 1
  fi

  args+=("${key}" "${sha256}")
done

python3 - "${formula}" "${version}" "${args[@]}" <<'PY'
import re
import sys

formula = sys.argv[1]
version = sys.argv[2]
pairs = sys.argv[3:]
checksums = dict(zip(pairs[0::2], pairs[1::2]))

with open(formula, "r", encoding="utf-8") as f:
    text = f.read()

text = re.sub(r'^\s*version\s+"[^"]+"$', f'  version "{version}"', text, flags=re.MULTILINE)

for key, sha256 in checksums.items():
    pattern = rf'({re.escape(key)}:\s*")[a-f0-9]{{64}}(")'
    text, count = re.subn(pattern, rf'\g<1>{sha256}\2', text, count=1)
    if count != 1:
        raise SystemExit(f"Failed to update checksum key: {key}")

with open(formula, "w", encoding="utf-8") as f:
    f.write(text)
PY

printf "Updated %s\n" "${formula}"
printf "Version: %s\n" "${version}"
