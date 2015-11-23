class Rocker < Formula
  desc "Rocker breaks the limits of Dockerfile."
  homepage "https://github.com/grammarly/rocker"
  url "https://github.com/grammarly/rocker.git", :tag => "1.0.0"
  head "https://github.com/grammarly/rocker.git"
  version "1.0.0"

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = "#{Dir.pwd}/vendor:#{Dir.pwd}"
    system "make", "local_binary"
    bin.install "bin/rocker"
  end

  test do
    shell "#{bin}/rocker --version"
  end
end
