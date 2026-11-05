# Releasing

Every push to `main` runs GitHub Actions **Package & Release**, which builds `contexta-plugin.zip` and publishes it as the latest GitHub Release. The Contexta dashboard **Download plugin** button streams that zip to signed-in users, so they don't need GitHub access.

Raise `version` in `.claude-plugin/plugin.json` and `.claude-plugin/marketplace.json` with every release. The Claude directory tracks `main` and picks up new versions from it after review.

Before pushing, run `claude plugin validate ./` from the repo root. A clean run prints "Validation passed".
