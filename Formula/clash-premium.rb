class ClashPremium < Formula
  desc "Pre-built premium version of Clash"
  homepage "https://github.com/Dreamacro/clash/releases/tag/premium"
  url "https://github.com/Dreamacro/clash/releases/download/premium/clash-darwin-amd64-2022.07.07.gz"
  version "1.11.4"
  sha256 "ccdb2760be48c2f51106fcc16c995cbd7d1a64cd5f742f44c9cba8ddc9bcba9c"

  def install
    bin.install Dir.glob("clash*")[0] => "clash"
    (etc/"clash").mkpath
  end
  
  def caveats
    <<~EOS
      Configuration files are stored in `/usr/local/etc/clash`. 
      Clash needs elevated permission to create TUN device:
      Run `sudo brew services start clash-premium`
      
      This will require manual removal of these paths using `sudo rm` on
      brew upgrade/reinstall/uninstall because of ownership change:
        `/usr/local/Cellar/clash-premium`
        `/usr/local/opt/clash-premium`
        `/usr/local/var/homebrew/linked/clash-premium`
    EOS
  end
  
  service do
    run [bin/"clash", "-d", etc/"clash"]
    keep_alive true
    log_path var/"log/clash.log"
    error_log_path var/"log/clash.err.log"
  end

end
