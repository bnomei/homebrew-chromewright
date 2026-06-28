class Chromewright < Formula
  desc "Browser automation MCP server via Chrome DevTools Protocol"
  homepage "https://github.com/bnomei/chromewright"
  version "0.7.0"
  license "MIT"

  checksums = {
    aarch64_apple_darwin:       "cb43303829d0980eebe55ddadb53209dd6c681ad9754d8a2418e0834db006cb5",
    x86_64_apple_darwin:        "dc7567cdc099ac1f2b168255657a5b33ad44f50926372c129ff2394c6cd49134",
    aarch64_unknown_linux_musl: "05073ad0b8b17c2c51721facc449c4135ac1efbb089c05a360ea68127fe7a982",
    x86_64_unknown_linux_musl:  "fb4e2aeb582adb4cc83dee196cb04eb4847003ac5267b27593b434ab5b3b72c7",
  }

  on_macos do
    on_arm do
      url "https://github.com/bnomei/chromewright/releases/download/v#{version}/chromewright-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 checksums[:aarch64_apple_darwin]
    end
    on_intel do
      url "https://github.com/bnomei/chromewright/releases/download/v#{version}/chromewright-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 checksums[:x86_64_apple_darwin]
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bnomei/chromewright/releases/download/v#{version}/chromewright-v#{version}-aarch64-unknown-linux-musl.tar.gz"
      sha256 checksums[:aarch64_unknown_linux_musl]
    end
    on_intel do
      url "https://github.com/bnomei/chromewright/releases/download/v#{version}/chromewright-v#{version}-x86_64-unknown-linux-musl.tar.gz"
      sha256 checksums[:x86_64_unknown_linux_musl]
    end
  end

  def install
    bin.install "chromewright"
  end

  test do
    assert_match "chromewright", shell_output("#{bin}/chromewright --help")
  end
end
