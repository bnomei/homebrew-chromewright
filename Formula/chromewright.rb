class Chromewright < Formula
  desc "Browser automation MCP server via Chrome DevTools Protocol"
  homepage "https://github.com/bnomei/chromewright"

  # Upstream has not published tags/releases yet, so pin the commit that
  # matches the local v0.2.3 tag until release artifacts exist.
  url "https://github.com/bnomei/chromewright/archive/ed7b523bfe6935dbddac3fded23e49218f585e9e.tar.gz"
  version "0.2.3"
  sha256 "ee2fb87d3ca10e4ec99eeffbe9add82569b0586192857777f68c36d4132d9ead"
  license "MIT"

  head "https://github.com/bnomei/chromewright.git", branch: "main"

  livecheck do
    skip "Upstream tags/releases are not published yet"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", "--locked", *std_cargo_args(path: ".")
  end

  test do
    assert_match "chromewright", shell_output("#{bin}/chromewright --help")
  end
end
