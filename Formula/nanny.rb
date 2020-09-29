class Nanny < Formula
    desc "Nanny - is a command line interface for creation Github Pull Requests for projects with multiple release versions."
    homepage "https://github.com/kolenkainc/Nanny"
    url "https://github.com/kolenkainc/Nanny/releases/download/1.0.0.177/nanny_1.0.0.177.tar.gz"
    sha256 "e6eaa334520bf111ac9057bc756921cafdcc9330bb35a0300fae0bae0199d7d8"
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
