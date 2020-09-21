class Nanny < Formula
  desc "Nanny - is a command line interface for creation Github Pull Requests for projects with multiple release versions."
  homepage "https://github.com/kolenkainc/Nanny"
  url "https://github.com/kolenkainc/Nanny/releases/download/1.0.0.107/nanny_1.0.0.107.tar.gz"
  sha256 "b66218bab5e40731f864255f5de1fdc691c2bc90a032dacdb566f0d35241f3d2"
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

  # test do
  #   assert_match version.to_s, shell_output("#{bin}/nanny --version")
  # end
end
