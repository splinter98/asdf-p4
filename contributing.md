# Contributing

Testing Locally:

```shell
asdf plugin test <plugin-name> <plugin-url> [--asdf-tool-version <version>] [--asdf-plugin-gitref <git-ref>] [test-command*]

# TODO: adapt this
asdf plugin test p4 https://github.com/splinter98/asdf-p4.git "p4 -V"
```

Tests are automatically run in GitHub Actions on push and PR.
