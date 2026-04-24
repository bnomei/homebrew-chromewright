class Chromewright < Formula
  desc "Browser automation MCP server via Chrome DevTools Protocol"
  homepage "https://github.com/bnomei/chromewright"
  version "0.4.0"
  license "MIT"

  checksums = {
    aarch64_apple_darwin:       "5f4c7229df471530b13957b431f736d2f572abea0d5b54214ad9375d64b99d4f",
    x86_64_apple_darwin:        "2862e671b0dc7a53091a79b5071ea35ad6b32af5e23f10ea684f28abd7c9b641",
    aarch64_unknown_linux_musl: "0a04ef46963ffc863c619c3759d31f4fb582e730e4c50be68c2796cf28438c8f",
    x86_64_unknown_linux_musl:  "a0061be72b19869301cc7e93c3e7ab622c778ab10e4e5ea922dba105e2f8fb9a",
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
