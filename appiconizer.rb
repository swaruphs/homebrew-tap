 require "language/go"

class Appiconizer < Formula
  desc "Create app icons for iOS and Android"
  homepage "https://github.com/swaruphs/appiconizer"
  url "https://github.com/swaruphs/appiconizer/archive/0.2.tar.gz"
  sha256 "1aa466f54ab976b2500dbf56bc104a4f4308e1c896b10edb265b768451dd65b0"

  # bottle do
  #   cellar :any
  #   sha256 "ef0965454eb37a26a2113647d4214e14d38d8f3e89f26de2da2471972e8962a9" => :yosemite
  #   sha256 "46b4b7560d65c47deb00bedc5b6f2e80549074bc0b9c0d639ca7cac1e83e22c3" => :mavericks
  #   sha256 "8cfd06e0427cacb68bb65357fab9bf95375748b7b8c7a64fcb21076701b6ce5f" => :mountain_lion
  # end

  depends_on "go" => :build

  go_resource "github.com/nfnt/resize" do
    url "https://github.com/nfnt/resize.git",
      :revision => "4d93a29130b1b6aba503e2aa8b50f516213ea80e"
  end

  def install
    mkdir_p buildpath/"src/github.com/swaruphs/"
    ln_s buildpath, buildpath/"src/github.com/swaruphs/appiconizer"
    ENV["GOPATH"] = buildpath
    Language::Go.stage_deps resources, buildpath/"src"

    system "go", "build", "-o", "appiconizer"
    bin.install "appiconizer"
  end

  test do
    #pipe_output("#{bin}/vegeta attack -duration=1s -rate=1 | #{bin}/vegeta report", "GET http://localhost/")
  end
end
