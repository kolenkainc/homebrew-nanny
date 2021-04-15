class Nanny < Formula
    desc "Nanny - is a command line interface for creation Github Pull Requests for projects with multiple release versions."
    homepage "https://github.com/kolenkainc/Nanny"
    url "https://github.com/kolenkainc/Nanny/releases/download/1.0.0.252/nanny_1.0.0.252.tar.gz"
    sha256 "503f2e2540f7e0649347221734c8230bd2b1d5be63410dbaa5a5e0bbac1ed7f0"
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
