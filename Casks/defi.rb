cask "defi" do
  version "0.2.4"
  sha256 "085a0f687bc01b634c348240829dbf4af066c58aae37d74e69c2efc3f1456298"

  url "https://github.com/qeude/Defi/releases/download/v#{version}/Defi-v#{version}.zip"
  name "Defi"
  desc "Scrolling window manager"
  homepage "https://github.com/qeude/Defi"

  depends_on arch: :arm64
  depends_on macos: :tahoe

  app "Defi.app"
  binary "#{appdir}/Defi.app/Contents/MacOS/defi"

  postflight_steps do
    run "/usr/bin/xattr",
        args: ["-dr", "com.apple.quarantine", "{{appdir}}/Defi.app"]
  end

  uninstall_preflight_steps do
    run "Defi.app/Contents/MacOS/defi",
        args: ["service", "disable"], base: :appdir, must_succeed: false
    run "Defi.app/Contents/MacOS/defi",
        args: ["service", "stop"], base: :appdir, must_succeed: false
  end

  uninstall quit: "com.quentin.defi"

  zap trash: [
    "~/.config/defi",
    "~/Library/Application Support/Defi",
    "~/Library/Caches/com.quentin.defi",
    "~/Library/LaunchAgents/com.quentin.defi.plist",
    "~/Library/Logs/Defi",
    "~/Library/Logs/Defi.log",
    "~/Library/Preferences/com.quentin.defi.plist",
    "~/Library/Saved Application State/com.quentin.defi.savedState",
  ]

  caveats <<~EOS
    Defi is an experimental alpha for macOS 26 and Apple Silicon.
    It is signed with a self-signed certificate and is not notarized.
    This Cask removes quarantine from Defi.app to allow it to open.

    Open Defi and grant Accessibility access in System Settings.
    Defi starts managing windows automatically, without a restart.
    Configuration is optional at ~/.config/defi/config.toml.
    Enable Launch at Login from Defi's menu bar if desired.
  EOS
end
