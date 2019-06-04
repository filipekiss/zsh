# Kiss' ZSH Files

> My zsh configuration

## Installation

**1. Clone the repository**

```sh
git clone --recursive https://github.com/filipekiss/zsh ~/zshfiles
cd ~/zshfiles
```

**2. Link required folders**

```sh
make link
```

**3. Install Plugins**

```sh
make install-plugins
```

**3b. Update Plugins**

```sh
make update-plugins
```

## Speed Profile

To run `zprof` and check for startup times and see what's slowing the startup
down, uncomment the profile sections at the **start** of `.zshenv` and at the
**end** of `.zshrc` and, then, start a new shell.

![zprof results](https://user-images.githubusercontent.com/48519/58891436-e2e5d000-86c2-11e9-98a6-47982fa3bc8d.jpg)

## Related

- [Dotfiles](http://github.com/filipekiss/dotfiles) - My Dotfiles repository

**filipekiss/zsh** © 2019+, Filipe Kiss Released under the [MIT] License.<br>
Authored and maintained by Filipe Kiss with help from contributors ([list][contributors]).

> GitHub [@filipekiss](https://github.com/filipekiss) &nbsp;&middot;&nbsp;
> Twitter [@filipekiss](https://twitter.com/filipekiss)

[mit]: http://mit-license.org/
[contributors]: http://github.com/filipekiss/zsh/contributors
