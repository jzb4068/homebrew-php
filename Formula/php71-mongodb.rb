require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Mongodb < AbstractPhp71Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.2.5.tgz"
  sha256 "1d43c5038cd8cb7e6db57620c40f2cc6385bd538db002c60f61f44376d829848"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "b15d5eb726cda2260f873856384cd98df2d49a1d2cab1597269f6a5ee95af772" => :sierra
    sha256 "7e0c10670f5d6de5f49546136720be4aea7d6ab07986295d0d171111b7631c8c" => :el_capitan
    sha256 "52f6c1519347264183b43ca27ac7058ad73cc1b8250587faac1a0f4656d2d93d" => :yosemite
  end

  depends_on "openssl"

  def install
    Dir.chdir "mongodb-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-openssl-dir=#{Formula["openssl"].opt_prefix}"
    system "make"
    prefix.install "modules/mongodb.so"
    write_config_file if build.with? "config-file"
  end
end
