class Nanny < Formula
    desc "Nanny - is a command line interface for creation Github Pull Requests for projects with multiple release versions."
    homepage "https://github.com/kolenkainc/Nanny"
    url "https://github.com/kolenkainc/Nanny/releases/download/1.0.0.217/nanny_1.0.0.217.tar.gz"
    sha256 "983449e15d406bb1f33e3e4d76a3570ebf2fa47d6b74a4d3bdca23d2ef97cf83"
    license "MIT"
  
    livecheck do
      url "https://github.com/kolenkainc/Nanny/releases/latest"
      regex(%r{href=.*?/tag/v?(\d+(?:\.\d+)+)["' >]}i)
    end
  
    def install
      rm_f Dir["libexec"]
      libexec.install Dir["*"]
      bin.install_symlink libexec/"Nanny.Console" => "nanny"
    end
  
    test do
      assert_match version.to_s, shell_output("#{bin}/nanny --version")
    end
  end
