class Chromewright < Formula
  desc "Browser automation MCP server via Chrome DevTools Protocol"
  homepage "https://github.com/bnomei/chromewright"
  version "0.7.1"
  license "MIT"

  checksums = {
    aarch64_apple_darwin:       "ec276b5a39e60e322b2e9144957b5277503941d700549e9ee51ce166e1e7680a",
    x86_64_apple_darwin:        "8ee736cbeb9f3f700469225699619f9270d22ce057ea53597e043e8ea6a49cea",
    aarch64_unknown_linux_musl: "0a5c91264f7e34af8260cac29dba229a4884f63679d0139e4878966ce8e8d2f4",
    x86_64_unknown_linux_musl:  "627a26aed7819bdb711ea60d919dce69de0d01e2d3dff87fdce5af16237b0ceb",
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
