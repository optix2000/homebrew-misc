class Arcanist < Formula
  desc "Phabricator Arcanist Tool"
  homepage "https://secure.phabricator.com/book/phabricator/article/arcanist/"

  stable do
    url "https://github.com/wikimedia/arcanist/archive/release/2018-08-23/1.tar.gz"
    sha256 "ca85ddee6b102be5cc7901af39e14a4c26ccd809e6c4bb16901af349ef4666ea"
    version "20180823"

    resource "libphutil" do
      url "https://github.com/wikimedia/phabricator-libphutil/archive/release/2018-08-23/1.tar.gz"
      sha256 "61ee7fcdcb570a8cbcb9ca074c558c97554d94e5684cb5c10cab325d14adac45"
      version "20180823"
    end
  end

  def install
    libexec.install Dir["*"]

    resource("libphutil").stage do
      (buildpath/"libphutil").install Dir["*"]
    end

    prefix.install Dir["*"]

    bin.install_symlink libexec/"bin/arc" => "arc"

    cp libexec/"resources/shell/bash-completion", libexec/"resources/shell/arc-completion.zsh"
    bash_completion.install libexec/"resources/shell/bash-completion" => "arc"
    zsh_completion.install libexec/"resources/shell/arc-completion.zsh" => "_arc"
  end

  test do
    system "#{bin}/arc", "help"
  end
end
