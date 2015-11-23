class RockerCompose < Formula
  desc "Docker tool for deploying apps composed of multiple containers."
  homepage "https://github.com/grammarly/rocker-compose"
  url "https://github.com/grammarly/rocker-compose.git", :tag => "0.1.2"
  head "https://github.com/grammarly/rocker-compose.git"
  version "0.1.2"

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = "#{Dir.pwd}/vendor:#{Dir.pwd}"
    system "make", "binary"
    bin.install "bin/rocker-compose"
  end

  test do
    shell "#{bin}/rocker-compose --version"
  end
end
