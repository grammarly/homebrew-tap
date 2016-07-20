class Rocker < Formula
  desc "Rocker breaks the limits of Dockerfile."
  homepage "https://github.com/grammarly/rocker"
  url "https://github.com/grammarly/rocker.git", :tag => "1.3.0"
  head "https://github.com/grammarly/rocker.git"
  version "1.3.0"

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = "#{Dir.pwd}/build"
    ENV["GO15VENDOREXPERIMENT"] = "1"
    sha = `git rev-parse HEAD 2>/dev/null`
    t = DateTime.now.new_offset(0).strftime("%Y-%m-%d_%H:%M_GMT")
    system "mkdir -p build/src/github.com/grammarly"
    system "ln -s `pwd` build/src/github.com/grammarly/rocker"
    system [
      "cd ./build/src/github.com/grammarly/rocker && go install",
      "-ldflags \"-X main.Version=#{version} -X main.GitCommit=#{sha[0,7]}",
      "-X main.GitBranch=master -X main.BuildTime=#{t}_Homebrew\""
    ].join(" ")
    bin.install "build/bin/rocker"
  end

  test do
    shell "./rocker --version"
  end
end
