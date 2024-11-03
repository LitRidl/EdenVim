# EdenVim — Craft your personal IDE experience

A perfect starting point for your personal, full-featured Neovim configuration. No convoluted layers, just a clean setup to kickstart your PDE (Personalized Development Environment) journey.

As a bonus, your Neovim configuration will [work the same way on Nix-based systems like NixOS](#installation-with-nix-including-nixos), too!

If you came here looking for a pre-made, full-blown Neovim IDE, you may actually be in the right place. Chances are you're on the same path I was — [my Neovim journey](#why-edenvim-my-neovim-journey).

## Features

- 🍴**Fork & Craft** This is _your_ configuration, the starting point. Nothing like _"don't touch **our** base config, clone a starter repository and go with it_".
- 🏰**But enjoy stability** Protected from breaking changes via Lazy.nvim lockfile. If you forked, just pull our changes to your configuration, no need to maintain plugin versions.
- ⚡**Fast** 45ms startup with lazy-loading and Lua bytecode caching (vs 90ms AstroNvim, 80ms LazyVim, 50ms NvChad).
- 🪶**Small** ~2500 lines of code, mostly plugin settings and explicitly defined defaults.
- 🎮**Tools that work immediately** Pre-configured common LSP, debug adapters, linters, and diagnostics installed automatically using `mason.nvim` or externally with tools like Nix.
- 🪟**Out-of-the-box transparency** Works seamlessly with popular color schemes.
- 🌀**No wrapping** Direct plugin usage — use everything explicitly, no _"lang packs"_ or _"theme loaders".
- 🧶**Minimal interdependencies** Related things are placed together, no _"taking icons from here, fetching settings from there, extending default options"_. The exception is key mappings — we keep them in one place.
- 🌱**Extend Neovim, not replace it** We want you to learn Neovim, not another IDE. No `<leader>lm` instead of `:Mason` or `<leader><tab>n` instead of builtin `gt`, and so on.
- 🦉**Simplicity over hiding** Should we write code to hide a `Switch C/C++ header/source file` keybinding when you're in a Python file? For us, the answer is no — we trust you, and your journey is simpler without extensive checks and autocommand chains.
- 🏆**Exceptional support of C/C++ and Rust** Correct configuration of `clangd_extensions.nvim`, include-based autocompletion, etc. I used it to navigate complex Rust projects and Linux kernel (just be sure to [generate compile_commands.json for kernel](https://github.com/torvalds/linux/blob/master/scripts/clang-tools/gen_compile_commands.py)).
- 🎯**Sane defaults** Things you'll do anyway. For instance, many dislike being unable to save a root-owned file if they forgot to use `sudo` or `sudoedit`.

## Why EdenVim? My Neovim Journey

My path started with IDEs like IDEA and VS Code. At first, I tried to get _"the most powerful"_ Neovim setup. Intuitively, I treated it as a pre-made IDE, although it's a PDE platform.

I tried AstroNvim, LunarVim, LazyVim, and NvChad, but found myself overwhelmed — not only did I need to learn Vim, Neovim, and Lua, but also configuration-specific abstractions. I settled on NvChad.

It went well until I decided to remove UI elements that I'd never use. What seemed like a simple task became time-consuming as these elements were hard-coded into dependencies and modifying them meant breaking future core updates.

The consensus on the Neovim subreddit was clear: eventually, people often craft their own configurations. The advice was to start with templates like `Neovim-from-scratch` or `kickstart.nvim`. This time, I knew: they're not being elitist, it is genuine advice.

Some templates were outdated, while others hadn't incorporated basic tools like `Lazy.nvim`. I found `nvim-basic-ide` refreshingly straightforward — doing everything myself led to better understanding and personally intuitive keymaps.

However, a new challenge emerged: plugin authors occasionally introduce breaking changes that can disrupt your workflow. And this is where pre-built configurations shine, as maintaining a personal configuration requires significant time investment.

For me, EdenVim fits this gap — you follow the _"do it yourself"_ approach, but with more speed and less frustration. I want to minimize the distance between _"I've installed it"_, _"It works for my projects"_, and _"I can customize my PDE"_. If you're familiar with Vim, you can be productive in a few days, as tested with my friends.

## Requirements

EdenVim is pre-configured to support TypeScript, Rust, Go, Lua, C/C++, Python, and other popular languages. To get the best out-of-the box experience, ensure that recommended dependencies are available:

- [Neovim](https://github.com/neovim/neovim/blob/master/INSTALL.md#install-from-package) 0.9.5+
- A terminal emulator with true color and UTF-8 support (Kitty, alacritty, WezTerm, foot, Ghostty, etc.)
- Clipboard tool (xclip, wl-clipboard, pbcopy, etc. `:help clipboard-tool` in Neovim for more details)
- [Git](https://git-scm.com/) for plugin management
- [Ripgrep](https://github.com/BurntSushi/ripgrep) for faster file search
- [C compiler](https://gcc.gnu.org/) for treesitter compilation (cc, gcc, clang, zig, etc.)
- [GNU Make](https://www.gnu.org/software/make/) for building plugins like telescope-fzf-native
- [Node.js](https://nodejs.org/en/download/) with `npm` for LSP servers and tools
- [Python](https://www.python.org/downloads/) with `pip` for LSP servers and tools
- [Rust](https://www.rust-lang.org/tools/install) for some LSP servers
- [LuaRocks](https://github.com/luarocks/luarocks) for some LSP servers
- [Go](https://go.dev/doc/install) for some LSP servers
- [A Nerd Font](https://www.nerdfonts.com/) like `JetBrains Mono Nerd Font` for icons

For example, on Ubuntu 22.10, you can install dependencies globally with:
```bash
sudo apt install git curl neovim python3-full python3-pip golang ripgrep luarocks npm nodejs rustc cargo make gcc
```

While it's valuable to show how to work with popular tools and languages, you can customize your configuration by removing unused tools. Edit `lua/settings/toolset.lua` to do so.

> [!TIP]
> Modern terminal emulators like Kitty and WezTerm allow you to avoid using patched fonts. By installing the `Symbols Nerd Font` as a fallback, you can render missing glyphs without limiting yourself to pre-patched fonts. It allows you to use any ordinary font you like.

## Installation on Linux and MacOS

The idea of EdenVim is to provide a working "clean slate" for your Neovim configuration. We encourage you to:
1. Think of a cool name for your Personal Development Environment (PDE).
2. [Fork EdenVim](https://github.com/LitRidl/edenvim/fork) to your own repository.
3. Use it as a starting point for your configuration.
4. Optionally, pull updates and improvements from EdenVim to offload version management and plugin maintenance.

### Step-by-Step Installation

1. Back up your existing Neovim configuration (if you have one):
```bash
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
```

2. Clone your fork of EdenVim or the main repository:

For your fork:
```bash
git clone https://github.com:your-username/your-fork-name.git ~/.config/nvim
```

To clone EdenVim repository:
```bash
git clone https://github.com/LitRidl/edenvim.git ~/.config/nvim
```

_Replace `https://` with `git@` if you have SSH access configured._

3. Launch Neovim:
```bash
nvim
```

### First Launch

On first launch, EdenVim automatically:
- Installs the plugin manager (Lazy.nvim).
- Downloads and installs Neovim plugins (versions pinned in lazy-lock.json).
- Downloads and compiles Treesitter parsers.
- Sets up Mason package manager for LSP servers, linters, and formatters.
- Installs binary dependencies requested by mason-lspconfig, mason-dap, and mason-null-ls.

Please be patient; this process may take several minutes depending on your connection, GitHub rate limiting, and system performance. You may see multiple notifications during the process.

## Installation with Nix (including NixOS)

Setting up Neovim on Nix-driven systems is often tricky when it comes to managing external binary dependencies like LSP servers.
Neovim users frequently modify files in `~/.config/nvim`, and tools like `mason.nvim` dynamically install formatters, LSP servers, and other binaries at runtime.
This conflicts with Nix's philosophy of reproducible builds and immutability. This often results in the dilemma of choosing either Nix-first or Neovim-first, which is very unsatisfying as, in principle, Nix and Neovim seem like a match made in heaven.

While excellent projects like [nixvim](https://github.com/nix-community/nixvim) offer Nix-first Neovim installations, in practice many users prefer their Neovim configuration
to remain Nix-agnostic for portability.

### Solution: Nix for binary dependencies, Lazy.nvim for plugin management, `.config/nvim` for configuration

With EdenVim, you can disable Mason-based plugins on Nix systems and manage external tools like LSP servers and null-ls/none-ls tools via Nix. This means:

- Your Neovim configuration remains in `~/.config/nvim` and is non-immutable, so you can customize it without rebuilding.
- External dependencies are managed by Nix, ensuring that setup is reproducible in term of binary dependencies.
- It works on non-Nix systems just as usual, and no parts of Nix "leak" into your Lua files.

### Setting Up EdenVim with Home Manager

You don't have to use [Home Manager](https://nix-community.github.io/home-manager/), but it simplifies the process. Here's how you can set up EdenVim with Home Manager:

#### 1. Enable Neovim in Home Manager

First, enable Neovim and set up isolated environments for Python and Node.js, which are often needed by Neovim plugins.

```nix
programs.neovim = {
  enable = true;
  withPython3 = true;
  withNodeJs = true;
};
```

#### 2. Install LSP Servers and Tools via Nix

Instead of using `mason`, `mason-lspconfig`, `mason-dap`, and `mason-null-ls` to install binary dependencies, declare them in the `programs.neovim.extraPackages` option.
This ensures all your tools are managed by Nix and are available within Neovim when it is launched. They don't pollute global environment.
```nix
programs.neovim.extraPackages = with pkgs; [
  # clang provides both LSP Server for C/C++ and a C compiler for treesitter parsers 
  clang
  bash-language-server
  rust-analyzer
  # ... Other LSP servers, formatters, linters, etc ...
];
```

> [!TIP]
> I cross-referenced common tools installed by Mason (some of them extracted from VS Code) to corresponding `nixpkgs` packages. See the list in the [Full Example to Copy and Paste](#full-example-to-copy-and-paste) section.

> [!NOTE]
> Treesitter parsers are compiled binaries that can be managed through Nix. However, they also work well when compiled locally using `clang` which we use for C/C++ LSP anyway. To maintain consistency between Nix and non-Nix setups, EdenVim defaults to local compilation.
> If you prefer Nix-managed parsers, add `pkgs.vimPlugins.nvim-treesitter.withAllGrammars` to `programs.neovim.plugins` and set `auto_install = false` in `lua/plugins/treesitter.lua`.

#### 3. Link or Clone Your Neovim Configuration

You can manually clone or place your Neovim configuration in `~/.config/nvim` and skip this step.

If you manage your Neovim configuration as a Git submodule or a directory within your Nix-based dotfiles repository, use a symlink.
To keep Neovim configuration in `~/.config/nvim` editable, symlink it using the `xdg.configFile` option with the `mkOutOfStoreSymlink` function. The function returns a path in the Nix store, but the path itself is just a symlink that resolves to the specified path.

```nix
xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "/home/username/dotfiles/config/nvim";
```

> [!IMPORTANT]
> Replace `"/home/username/dotfiles/config/nvim"` with the **absolute path** to your Neovim configuration.
> When using Flakes, your Flake directory is first copied to the Nix store. During evaluation, relative paths are resolved within this store path rather than your home directory. Using an absolute path ensures correct symlinking.

#### 4. Disable Mason

This is the only change you need to make inside your Neovim configuration to use it on Nix systems versus non-Nix systems.
Since external tools are managed by Nix, we need to disable `mason.nvim`. In EdenVim-based configurations, ensure to set `g.mason_enabled = false` in `lua/options.lua`.
This tells EdenVim not to use `mason.nvim`, preventing it from trying to download tools at runtime and causing errors.
If you're using a different Neovim setup, you can disable Mason in your `lazy.nvim` configuration like this:

```lua
require("lazy").setup({
  -- ...
  spec = {
    -- ...
    -- Disable mason-related plugins
    { "williamboman/mason.nvim", enabled = false },
    { "williamboman/mason-lspconfig.nvim", enabled = false },
    { "jay-babu/mason-nvim-dap.nvim", enabled = false },
    { "jay-babu/mason-null-ls.nvim", enabled = false },
    -- ...
  },
  -- ...
})
```

#### 5. Set Up Home Manager Activation Scripts (Optional)

To make sure all your plugins are ready to go when you start Neovim, use activation scripts — a mechanism used to set up the environment during `home-manager switch`.
Consider it a "build" step for your Neovim configuration and a way to make it idempotent.
In the example below, `Lazy.nvim` clones git repositories and builds `telescope-fzf-native` using `make` during activation phase.

First, ensure that the necessary tools are available during the activation phase.
> [!NOTE]
> The packages listed here are available only during activation phase, except if you make them available in other ways.
> For example, if you disable Neovim by `programs.neovim.enable = false`, it would still be available during activation phase (to install packages) just like `make` or `gcc`, however you won't be able to use it afterward.

```nix
home.extraActivationPath = with pkgs; [
  git       # For cloning plugins
  gnumake   # For building plugins like telescope-fzf-native
  gcc       # For compiling native extensions
  neovim    # To run Lazy-related Neovim commands during activation
  # If possible, please use this instead of just `neovim`:
  # config.programs.neovim.finalPackage
];
```

Then, add the activation script block (the name `updateNeovimPlugins` is arbitrary):

```nix
home.activation.updateNeovimState = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
  # Suppress output unless VERBOSE is set, like when running `home-manager --verbose switch`
  args=""
  if [[ -z "''${VERBOSE+x}" ]]; then
    args="--quiet"
  fi
  # Restore plugins to the versions pinned in lazy-lock.json, builds telescope-fzf-native, etc.
  run $args nvim --headless '+Lazy! restore' +qa
'';
```

This script ensures that when you run `home-manager switch`, Neovim will install all plugins pinned to the versions specified in your `lazy-lock.json`,
and any necessary build steps will be executed. So when you start Neovim, everything is ready to go.

#### Full Example to Copy and Paste

Here's how it all comes together in your `home.nix` file, assuming you're using `home-manager`:

```nix
{ pkgs, config, lib, ... }:
{
  # ... Other parts of your configuration ...
  programs.neovim = {
    enable = true;

    # Often required; don't worry as they are isolated in Neovim environment
    withPython3 = true;
    withNodeJs = true;

    # Packages available within Neovim during runtime. Put your LSP Servers, formatters, linters, etc.
    extraPackages = with pkgs; [
      bash-language-server
      buf-language-server
      # clang provides both LSP Server for C/C++ and a C compiler for treesitter parsers 
      clang
      lldb
      lua-language-server
      stylua
      gopls
      gomodifytags
      lua51Packages.lua
      lua51Packages.luv
      lua51Packages.luarocks-nix
      lua51Packages.jsregexp
      statix
      nixpkgs-fmt
      go-tools
      rust-analyzer
      dockerfile-language-server-nodejs
      emmet-language-server
      vscode-langservers-extracted
      nixd
      nil
      prettierd
      typescript-language-server
      eslint
      python312Packages.debugpy
      delve
      taplo
      yaml-language-server
      terraform-ls
      ruff
      basedpyright
      tree-sitter
    ];
  };

  # Symlink your Neovim configuration (or delete the line to manage .config/nvim directly)
  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "/home/username/dotfiles/config/nvim";

  # Tools available during activation
  home.extraActivationPath = with pkgs; [
    git
    gnumake
    gcc
    config.programs.neovim.finalPackage
    # The package above is preferred, but if you can't make it work, use this instead:
    # neovim
  ];

  # Activation script to set up Neovim plugins
  home.activation.updateNeovimState = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    args=""
    if [[ -z "''${VERBOSE+x}" ]]; then
      args="--quiet"
    fi
    run $args nvim --headless '+Lazy! restore' +qa
  '';

  # ... Other parts of your configuration ...
}
```

### Future Plans: Flake-based solution for any Lua Neovim configurations (WIP)

I'm working on a way to make integrating arbitrary Neovim configurations with Nix smoother. This will allow you to wrap your Lua-based Neovim configuration in a Nix-friendly way without changing your code at all, and still keep all your configuration files in `~/.config/nvim`. Stay tuned for updates!

## Credits

- [nvim-basic-ide](https://github.com/LunarVim/nvim-basic-ide): I've grown my configuration from it, and my configuration eventually grown into EdenVim.
- [LazyVim](https://github.com/LazyVim/LazyVim): For me, this configuration is one of the best full-featured configurations in terms of code quality, extensibility, and design.
- [NvChad](https://github.com/NvChad/NvChad): This configuration showed me what an IDE-like Neovim experience could look like, and formed my values toward simplicity.
