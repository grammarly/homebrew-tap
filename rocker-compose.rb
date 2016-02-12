class RockerCompose < Formula
  desc "Docker tool for deploying apps composed of multiple containers."
  homepage "https://github.com/grammarly/rocker-compose"
  url "https://github.com/grammarly/rocker-compose.git", :tag => "0.1.5"
  head "https://github.com/grammarly/rocker-compose.git"
  version "0.1.5"

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = "#{Dir.pwd}/build"
    ENV["GO15VENDOREXPERIMENT"] = "1"

    sha = `git rev-parse HEAD 2>/dev/null`
    t = DateTime.now.new_offset(0).strftime("%Y-%m-%d_%H:%M_GMT")
    system "mkdir -p build/src/github.com/grammarly"
    system "ln -s `pwd` build/src/github.com/grammarly/rocker-compose"
    system [
      "cd ./build/src/github.com/grammarly/rocker-compose && go install",
      "-ldflags \"-X main.Version=#{version} -X main.GitCommit=#{sha[0,7]}",
      "-X main.GitBranch=master -X main.BuildTime=#{t}_Homebrew\""
    ].join(" ")
    bin.install "build/bin/rocker-compose"
  end

  test do
    shell "#{bin}/rocker-compose --version"
  end
end
