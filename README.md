# Homebrew tap

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

## slky

[slky](https://github.com/aimlesx/slky) is a Slack CLI for coding agents. It runs on Apple Silicon and Intel Macs.

```sh
brew install aimlesx/tap/slky
slky --version
```

To upgrade an existing Slack AXI installation, run `brew update`. If Homebrew still lists the installed formula as `slack-axi`, run `brew migrate slack-axi`. Then upgrade and check your workspace profiles.

```sh
brew upgrade aimlesx/tap/slky
slky auth list
```

Use `slky` in scripts that invoked `slack-axi`. The CLI reuses existing Slack AXI data and Keychain entries. See the [slky upgrade guide](https://github.com/aimlesx/slky#upgrading-from-slack-axi) for the output schema and updated Claude Code skill link.

Before running `brew uninstall slky`, follow the [access revocation and data removal instructions](https://github.com/aimlesx/slky#upgrade-completions-and-removal) for any credentials and workspace data you want to remove.

Installation defects and feature requests belong in the relevant project's
issue tracker, not this tap. Report suspected vulnerabilities through that
project's private reporting channel:

- [Cookidoo AXI security policy](https://github.com/aimlesx/cookidoo-axi/security/policy)
- [slky security policy](https://github.com/aimlesx/slky/security/policy)
