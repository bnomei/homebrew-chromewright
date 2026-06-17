class Chromewright < Formula
  desc "Browser automation MCP server via Chrome DevTools Protocol"
  homepage "https://github.com/bnomei/chromewright"
  version "0.5.0"
  license "MIT"

  checksums = {
    aarch64_apple_darwin:       "f862575018006b47b16598b35a4faf0e743749c6c61647a3e8e312169bce59da",
    x86_64_apple_darwin:        "15d2637eb7cf54e5aac188e59f5f3bbb2d36f6ad621b488ae33fd62675c13830",
    aarch64_unknown_linux_musl: "554e4da3cb248beb452d94cb86f60ae822ba9ea00f53e478ce58b759b326d5a6",
    x86_64_unknown_linux_musl:  "6de7f4b1d7c32f1f8492299eb85047150f033a92f5f6c8e81555e0b00ad070e7",
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
