<div align="center">

# asdf-p4 [![Build](https://github.com/splinter98/asdf-p4/actions/workflows/build.yml/badge.svg)](https://github.com/splinter98/asdf-p4/actions/workflows/build.yml) [![Lint](https://github.com/splinter98/asdf-p4/actions/workflows/lint.yml/badge.svg)](https://github.com/splinter98/asdf-p4/actions/workflows/lint.yml)

[p4](https://www.perforce.com/perforce/doc.current/manuals/cmdref/) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

**TODO: adapt this section**

- `bash`, `curl`, `tar`: generic POSIX utilities.
- `SOME_ENV_VAR`: set this environment variable in your shell config to load the correct version of tool x.

# Install

Plugin:

```shell
asdf plugin add p4
# or
asdf plugin add p4 https://github.com/splinter98/asdf-p4.git
```

p4:

```shell
# Show all installable versions
asdf list-all p4

# Install specific version
asdf install p4 latest

# Set a version globally (on your ~/.tool-versions file)
asdf global p4 latest

# Now p4 commands are available
p4 -V
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/splinter98/asdf-p4/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Stephen Alderman](https://github.com/splinter98/)
