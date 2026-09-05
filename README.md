# Homebrew tap

Homebrew packages maintained by [qeude](https://github.com/qeude).

## Defi

Install the public alpha:

```sh
brew install --cask qeude/tap/defi
```

Requires Apple Silicon and macOS 26 or newer. Defi is an experimental alpha,
signed with a self-signed certificate and not notarized. The Cask removes
quarantine from the installed app. Only install if you trust this source.

Open Defi, grant Accessibility permission, then reopen it. Existing settings
are preserved; no configuration file is required. See the
[Defi README](https://github.com/qeude/Defi) for shortcuts and configuration.

```sh
brew uninstall --cask defi
```

To also remove configuration, saved state, and logs:

```sh
brew uninstall --cask --zap defi
```

The Cask disables launch at login and stops Defi before removing the app.
macOS privacy permissions can be removed separately in System Settings.
