cask "defi" do
  version "0.2.0-alpha"
  sha256 "68fa7de3b2d2f7d96bcc5ca15617b28fba853cd5d234afd98110828f8e42990f"

  url "https://github.com/qeude/Defi/releases/download/v#{version}/Defi-v#{version}.zip"
  name "Defi"
  desc "Scrolling window manager"
  homepage "https://github.com/qeude/Defi"

  depends_on arch: :arm64
  depends_on macos: :tahoe

  app "Defi.app"
  binary "#{appdir}/Defi.app/Contents/MacOS/defi"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Defi.app"]
  end

  uninstall_preflight do
    system_command "#{appdir}/Defi.app/Contents/MacOS/defi",
                   args: ["service", "disable"]
    system_command "#{appdir}/Defi.app/Contents/MacOS/defi",
                   args: ["service", "stop"]
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

    Open Defi, grant Accessibility access in System Settings, then reopen it.
    Configuration is optional at ~/.config/defi/config.toml.
    Enable Launch at Login from Defi's menu bar if desired.
  EOS
end
