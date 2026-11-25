class Slky < Formula
  desc "Agent-ergonomic Slack CLI with bounded output and safe mutations"
  homepage "https://github.com/aimlesx/slky"
  url "https://registry.npmjs.org/@aimlesx/slky/-/slky-0.2.0.tgz"
  sha256 "b10d24ed996d1a4adf58261e039b9d811a6bab775c763bcc8c28082647555408"
  license "MIT"

  depends_on :macos
  depends_on "node@24"

  def install
    system "npm", "install", *std_npm_args

    node = Formula["node@24"]
    (bin/"slky").write_env_script libexec/"bin/slky",
      PATH: "#{node.opt_bin}:$PATH"
    bash_completion.install "completions/slky.bash"
    zsh_completion.install "completions/_slky"
    man1.install "docs/slky.1"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/slky --version").strip
    skill = libexec/"lib/node_modules/@aimlesx/slky/skills/slky/SKILL.md"
    assert_predicate skill, :file?
    assert_match(/^name: slky$/, skill.read)
    output = shell_output("HOME=#{testpath} #{bin}/slky --output json")
    assert_match '"schema": "slky/v1"', output
    assert_match '"status": "setup_required"', output
  end
end
