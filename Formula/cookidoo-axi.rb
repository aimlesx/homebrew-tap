require "digest"

class CookidooAxi < Formula
  desc "Agent-friendly CLI for the unofficial Cookidoo API"
  homepage "https://github.com/aimlesx/cookidoo-axi"
  url "https://github.com/aimlesx/cookidoo-axi/releases/download/v0.1.0-beta.2/cookidoo-axi-0.1.0-beta.2.tgz"
  sha256 "fd72425d10cc8fcebb7b2adadb0f0284f4eba9030b3554252c188e81210d82c4"
  license "MIT"

  depends_on arch: :arm64
  depends_on macos: :sequoia
  depends_on "node@24"

  def install
    ENV["NODE_USE_SYSTEM_CA"] = "1"
    cp "homebrew-package-lock.json", "package-lock.json"
    node_bin = formula_opt_bin("node@24")
    system node_bin/"npm", "ci", *std_npm_args(prefix: false), "--omit=dev"

    launcher = buildpath/"bin/cookidoo-axi.mjs"
    inreplace launcher, "#!/usr/bin/env node", "#!#{node_bin}/node --use-system-ca"
    libexec.install "bin", "dist", "node_modules", "package.json", "skills"
    libexec.install "LICENSE", "NOTICE", "README.md", "SECURITY.md", "THIRD_PARTY_NOTICES.md"
    bin.install_symlink libexec/"bin/cookidoo-axi.mjs" => "cookidoo-axi"
  end

  test do
    node = formula_opt_bin("node@24")/"node"
    assert_match(/^v24\./, shell_output("#{node} --version"))
    assert_equal "#!#{node} --use-system-ca\n", File.open(libexec/"bin/cookidoo-axi.mjs", &:gets)
    assert_equal "#{version}\n", shell_output("#{bin}/cookidoo-axi --version")
    skill = libexec/"skills/cookidoo-axi/SKILL.md"
    assert_predicate skill, :file?
    assert_operator skill.size, :>, 0
    assert_equal "3743f3d9f23e784c4d93bf19cc896561b2b86a2ebc535e9421d40802c1d66b29", Digest::SHA256.file(skill).hexdigest

    doctor = JSON.parse(shell_output("#{bin}/cookidoo-axi auth doctor --output json")).fetch("data")
    assert_equal "loaded", doctor.fetch("keychainBinding")
    assert_equal "darwin", doctor.fetch("platform")
    assert_equal "arm64", doctor.fetch("architecture")
    assert_equal "not-requested", doctor.fetch("keychainAccess")
    assert_equal 0, doctor.fetch("keychainRecordsRead")
    assert_equal 0, doctor.fetch("keychainRecordsWritten")
    assert_equal 0, doctor.fetch("networkRequests")

    operation = JSON.parse(shell_output("#{bin}/cookidoo-axi operation describe getRecipe --output json"))
    assert_equal "getRecipe", operation.fetch("data").fetch("operationId")
  end
end
