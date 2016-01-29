class Rocker < Formula
  desc "Rocker breaks the limits of Dockerfile."
  homepage "https://github.com/grammarly/rocker"
  url "https://github.com/grammarly/rocker.git", :tag => "1.1.0"
  head "https://github.com/grammarly/rocker.git"
  version "1.1.0"

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = "#{Dir.pwd}/build"
    ENV["GO15VENDOREXPERIMENT"] = "1"
    system "mkdir -p build/src/github.com/grammarly"
    system "ln -s `pwd` build/src/github.com/grammarly/rocker"
    system "cd ./build/src/github.com/grammarly/rocker && go install "
    bin.install "build/bin/rocker"
  end

  test do
    shell "./rocker --version"
  end
end
