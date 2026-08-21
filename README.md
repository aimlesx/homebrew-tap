# Homebrew tap for AXI CLIs

## Cookidoo AXI

[Cookidoo AXI](https://github.com/aimlesx/cookidoo-axi) is an unofficial,
agent-friendly CLI for the Polish Cookidoo API. Its current beta supports
Apple Silicon Macs running macOS 15 or newer.

```sh
brew install aimlesx/tap/cookidoo-axi
```

Before uninstalling, remove each Cookidoo AXI profile whose Keychain records
should be deleted, then uninstall the Formula:

```sh
cookidoo-axi auth remove --profile default --confirm default
brew uninstall cookidoo-axi
```

See the [Cookidoo AXI README](https://github.com/aimlesx/cookidoo-axi#readme)
for authentication, safety, and additional profile-removal guidance.

## Slack AXI

[Slack AXI](https://github.com/aimlesx/slack-axi) is an agent-ergonomic Slack
CLI for macOS.

```sh
brew install aimlesx/tap/slack-axi
```

Upgrade or uninstall it with Homebrew:

```sh
brew upgrade slack-axi
brew uninstall slack-axi
```

Slack AXI stores credentials in macOS Keychain. Before uninstalling, follow
the access-revocation and local-data removal procedure in the
[Slack AXI README](https://github.com/aimlesx/slack-axi#upgrade-completions-and-removal).

Installation defects and feature requests belong in the relevant project's
issue tracker, not this tap. Report suspected vulnerabilities through that
project's private reporting channel:

- [Cookidoo AXI security policy](https://github.com/aimlesx/cookidoo-axi/security/policy)
- [Slack AXI security policy](https://github.com/aimlesx/slack-axi/security/policy)
