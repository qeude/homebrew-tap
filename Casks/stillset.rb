cask "stillset" do
  version "0.1.0"
  sha256 "1d786156d39a8d02279ce49b8d48add48be1eaf7377a895fc29d5df111d228b7"

  url "https://github.com/qeude/Stillset/releases/download/v#{version}/Stillset-v#{version}.zip"
  name "Stillset"
  desc "Turn screen recordings into full-resolution screenshots"
  homepage "https://github.com/qeude/Stillset"

  depends_on arch: :arm64
  depends_on macos: ">= :golden_gate"

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
