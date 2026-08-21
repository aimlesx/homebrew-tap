class SlackAxi < Formula
  desc "Agent-ergonomic Slack CLI with bounded output and safe mutations"
  homepage "https://github.com/aimlesx/slack-axi"
  url "https://registry.npmjs.org/slack-axi-cli/-/slack-axi-cli-0.1.0.tgz"
  sha256 "1681b6220b176d2e9ddbabd23587302b60b6d28ecf259ccd2a9fb003f9ec0650"
  license "MIT"

  depends_on :macos
  depends_on "node@24"

  def install
    system "npm", "install", *std_npm_args

    node = Formula["node@24"]
    (bin/"slack-axi").write_env_script libexec/"bin/slack-axi",
      PATH: "#{node.opt_bin}:$PATH"
    bash_completion.install "completions/slack-axi.bash"
    zsh_completion.install "completions/_slack-axi"
    man1.install "docs/slack-axi.1"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/slack-axi --version").strip
    output = shell_output("HOME=#{testpath} #{bin}/slack-axi --output json")
    assert_match '"schema": "slack-axi/v1"', output
    assert_match '"status": "setup_required"', output
  end
end
