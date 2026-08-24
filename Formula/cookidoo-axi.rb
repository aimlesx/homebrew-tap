require "digest"

class CookidooAxi < Formula
  desc "Agent-friendly CLI for the unofficial Cookidoo API"
  homepage "https://github.com/aimlesx/cookidoo-axi"
  url "https://github.com/aimlesx/cookidoo-axi/releases/download/v0.1.0-beta.3/cookidoo-axi-0.1.0-beta.3.tgz"
  sha256 "e6206ccd4a53ff3858b3250924b65b8d9166c4d95941f20f6f9eb205b23abe5e"
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
    assert_equal "5d90186f6ef56db8542bcc4c4658d9d9ea43542d0c246b8bd2fc1fa8afb4803f", Digest::SHA256.file(skill).hexdigest

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
