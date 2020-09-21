class Nanny < Formula
  desc "Nanny - is a command line interface for creation Github Pull Requests for projects with multiple release versions."
  homepage "https://github.com/kolenkainc/Nanny"
  url "https://github.com/kolenkainc/Nanny/releases/download/1.0.0.105/nanny_1.0.0.105.tar.gz"
  sha256 "c2223670ba039003c8e792808341d2b089bd9210da6e4f653ead1405e22a1e17"
  license "Apache-2.0"

  livecheck do
    url "https://github.com/kolenkainc/Nanny/releases/latest"
    regex(%r{href=.*?/tag/v?(\d+(?:\.\d+)+)["' >]}i)
  end

  def install
    rm_f Dir["libexec"]
    libexec.install Dir["*"]
  end

  # test do
  #   assert_match version.to_s, shell_output("#{bin}/nanny --version")
  # end
end
