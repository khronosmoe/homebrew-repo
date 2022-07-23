class V2rayExporter < Formula
  desc "Prometheus exporter for V2Ray"
  homepage "https://github.com/khronosmoe/v2ray_exporter"
  url "https://github.com/khronosmoe/v2ray_exporter/releases/download/v0.6.3/v2ray_exporter-macos.tar.gz"
  version "0.6.3"
  sha256 "471ab09ba0892d5f9a7a8071ecda1d4d6955b6b09bcc2b96f0fbc828c7a912b8"
  license all_of: ["MIT", "CC-BY-SA-4.0"]

  def install
    bin.install "v2ray_exporter"
    
    touch etc/"v2ray_exporter.args"

    (bin/"v2ray_exporter_brew_services").write <<~EOS
      #!/bin/bash
      exec #{bin}/v2ray_exporter $(<#{etc}/v2ray_exporter.args)
    EOS
  end

  def caveats
    <<~EOS
      When run from `brew services`, `v2ray_exporter` is run from
      `v2ray_exporter_brew_services` and uses the flags in:
        #{etc}/v2ray_exporter.args
    EOS
  end

  service do
    run [opt_bin/"v2ray_exporter_brew_services"]
    keep_alive false
    log_path var/"log/v2ray_exporter.log"
    error_log_path var/"log/v2ray_exporter.log"
  end

  test do
    assert_match "v2ray_exporter", shell_output("#{bin}/v2ray_exporter --version 2>&1")

    fork { exec bin/"v2ray_exporter" }
    sleep 2
    assert_match "# HELP", shell_output("curl -s localhost:9110/metrics")
  end
end
