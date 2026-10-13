cask "stillset" do
  version "0.2.0"
  sha256 "1d72878cba5faae1c71805482fec5879cd09cb3b098a718d16daf4d06ca042cf"

  url "https://github.com/qeude/Stillset/releases/download/v#{version}/Stillset-v#{version}.zip"
  name "Stillset"
  desc "Turn screen recordings into full-resolution screenshots"
  homepage "https://github.com/qeude/Stillset"

  depends_on arch: :arm64
  depends_on macos: :golden_gate

  app "Stillset.app"

  postflight_steps do
    run "/usr/bin/xattr",
        args: ["-dr", "com.apple.quarantine", "{{appdir}}/Stillset.app"]
  end

  uninstall quit: "com.qeude.stillset"

  zap trash: [
    "~/Library/Application Support/com.qeude.stillset",
    "~/Library/Caches/com.qeude.stillset",
    "~/Library/Preferences/com.qeude.stillset.plist",
    "~/Library/Saved Application State/com.qeude.stillset.savedState",
  ]

  caveats <<~EOS
    Stillset is signed with a self-signed certificate and is not notarized.
    This Cask removes quarantine from Stillset.app so it can open.
  EOS
end
