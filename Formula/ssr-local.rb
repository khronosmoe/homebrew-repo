class SsrLocal < Formula
  desc "Shadowsocksr-libev"
  homepage "https://github.com/tindy2013/shadowsocks-static-binaries"
  url "https://github.com/tindy2013/shadowsocks-static-binaries/raw/master/shadowsocksr-libev/macos/ssr-local"
  version "2.5.6"
  sha256 "8de9b3f59a839ca01177e8e7dc54cc50314f6a04adafd13871ade29c3d98c31f"

  def install
    bin.install "ssr-local"
  end
end
