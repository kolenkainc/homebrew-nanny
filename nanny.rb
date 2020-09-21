class Nanny < Formula
  desc "Nanny - is a command line interface for creation Github Pull Requests for projects with multiple release versions."
  homepage "https://github.com/kolenkainc/Nanny"
  url "https://github.com/kolenkainc/Nanny/releases/download/1.0.0.99/nanny_1.0.0.99.tar.gz"
  sha256 "bf1390b9327bb77ea0419f0df7bb106d5c61a3de2b30fd95cb9b8b757289b443"
  license "Apache-2.0"

  livecheck do
    url "https://github.com/kolenkainc/Nanny/releases/latest"
    regex(%r{href=.*?/tag/v?(\d+(?:\.\d+)+)["' >]}i)
  end

  def install
    bin.install "Nanny.Console"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/nanny --version")
  end
end
