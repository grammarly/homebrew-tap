class Rocker < Formula
  desc "Rocker breaks the limits of Dockerfile."
  homepage "https://github.com/grammarly/rocker"
  url "https://github.com/grammarly/rocker.git", :tag => "1.1.0"
  head "https://github.com/grammarly/rocker.git"
  version "1.1.0"

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = "#{Dir.pwd}/vendor:#{Dir.pwd}"
    system "make", "default"
    bin.install "./rocker"
  end

  test do
    shell "./rocker --version"
  end
end
