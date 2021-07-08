class GnuProlog < Formula
  desc "Prolog compiler with constraint solving"
  homepage "http://www.gprolog.org/"
  url "http://www.gprolog.org/gprolog-1.5.0.tar.gz"
  sha256 "670642b43c0faa27ebd68961efb17ebe707688f91b6809566ddd606139512c01"
  license any_of: ["LGPL-3.0-or-later", "GPL-2.0-or-later"]

  livecheck do
    url :homepage
    regex(/href=.*?gprolog[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, big_sur:  "e3825d38dac91ef3dbb9d7b67a6e3352dcc27fb1f897332ba39e5a0b97caad25"
    sha256 cellar: :any_skip_relocation, catalina: "25b07a365e6907466222e64d10458a9006830b3061698eaf6af101f3355d43f9"
    sha256 cellar: :any_skip_relocation, mojave:   "76ed18b57bf7719b1212adc6fd323b184a9ed496c0ebc7f588ee8e172e887696"
  end

  def install
    cd "src" do
      system "./configure", "--prefix=#{prefix}", "--with-doc-dir=#{doc}"
      ENV.deparallelize
      system "make"
      system "make", "install"
    end
  end

  test do
    (testpath/"test.pl").write <<~EOS
      :- initialization(main).
      main :- write('Hello World!'), nl, halt.
    EOS
    system "#{bin}/gplc", "test.pl"
    assert_match "Hello World!", shell_output("./test")
  end
end
