class CowsayNg < Formula
  desc "Configurable talking characters in ASCII art"
  # Historical homepage: https://web.archive.org/web/20120225123719/www.nog.net/~tony/warez/cowsay.shtml
  homepage "https://github.com/daviderestivo/cowsay-ng"
  url "https://github.com/daviderestivo/cowsay-ng/archive/refs/tags/cowsay-3.04.tar.gz"
  sha256 "238fa16f257d382c0ae61d9f8e814620d5b8c605997d2892090c2f468b64d449"
  license "GPL-3.0"
  version "3.04"
  revision 1

  option "with-offensive-cows", "Include offensive cows"

  def install
    # Remove offensive cows
    if build.without? "offensive-cows"
      %w[cows/sodomized.cow cows/telebears.cow].each do |file|
        rm file
        inreplace "Files.base", file, ""
      end
    end

    system "/bin/sh", "install.sh", prefix
    mv prefix/"man", share
  end

  test do
    output = shell_output("#{bin}/cowsay moo")
    assert_match "moo", output  # bubble
    assert_match "^__^", output # cow
  end
end
