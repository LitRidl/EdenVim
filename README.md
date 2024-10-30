# EdenVim — Craft your personal IDE experience

A perfect starting point for your personal, full-featured Neovim config. No convoluted layers, just a clean and intuitive setup to kickstart your PDE (Personalized Development Environment) journey.

If you came here looking for a pre-made, full-blown Neovim IDE, then you also may be in the right place, actually. Chances are you're on the same path I was — [Why EdenVim? My Neovim Journey](#why-edenvim--my-neovim-journey).

As a bonus, your Neovim configuration would [work the same way on Nix-based systems like NixOS](#using-edenvim-based-configurations-with-nix-and-nixos), too!

## Features

- 🍴**Fork & Craft** This is _your_ configuration, the starting point. No _"don't touch **our** base config, clone a starter repository and go with it_".
- 🏰**But enjoy stability** Protected from breaking changes via Lazy.nvim lockfile. If you forked, just pull our changes to your configuration, no need to maintain plugin versions.
- ⚡**Fast** 45ms startup with lazy-loading and Lua bytecode caching (vs 90ms AstroNvim, 80ms LazyVim, 50ms NvChad).
- 🪶**Small** ~2500 lines of code, mostly plugin settings and explicitly defined defaults.
- 🎮**Tools that work immediately** Pre-configured common LSP, debug adapters, linters, and diagnostics installed automatically using `mason.nvim` or externally with tools like Nix.
- 🪟**Out-of-the-box transparency** It just works for most color schemes.
- 🌀**No wrapping** Direct plugin usage — use everything explicitly, no _"lang packs"_ or _"theme loaders".
- 🧶**Minimal interdependencies** Related things are placed together, no _"taking icons from here, fetching settings from there, extending default options"_. The exception is key mappings — we keep them in one place.
- 🌱**Extend Neovim, not replace it** We want you to learn Neovim, not another IDE. No `<leader>lm` instead of `:Mason` or `<leader><tab>n` instead of builtin `gt`, and so on.
- 🦉**Simplicity over hiding** should we write code to hide a `Switch C/C++ header/source file` keybinding when you're in a Python file? For us, the answer is no — we trust you, and your journey is simpler without extensive checks and autocommand chains.
- 🏆**Exceptional support of C/C++ and Rust** Correct configuration of `clangd_extensions.nvim`, include-based autocompletion, etc. I used it to navigate complex Rust projects and Linux kernel (just be sure to [generate compile_commands.json for kernel](https://github.com/torvalds/linux/blob/master/scripts/clang-tools/gen_compile_commands.py)).
- 🎯**Sane defaults** Things you'll do anyway. For instance, many dislike being unable to save a root-owned file if they forgot to use `sudo` or `sudoedit`.

## Why EdenVim? My Neovim Journey

My path started with IDEs like IDEA, CLion, and VS Code. At first, I tried to get "the most powerful" Neovim setup. Intuitively, I treated it as a pre-made IDE, although it's a PDE platform.

I tried AstroNvim, LunarVim, LazyVim, and NvChad. I was overwhelmed by complexity — not only did I have to learn Vim, Neovim, and Lua, but I also had to navigate configuration-specific abstractions. I even had to create a Neovim configuration switcher to navigate between my setups. In the end, I settled on NvChad — it felt less bloated and had a noticeable presence on YouTube.

It went well until I decided to remove "close all" and "toggle dark/light theme" buttons. For something that I've never used, they consumed too much screen real estate. Surprisingly, it became a time-consuming endeavor. I discovered that it was hard-coded in NvChad's dependencies: to fix this, I had to change the `NvChad UI` plugin, breaking all future updates.

The consensus on the Neovim subreddit was clear: in the end, most people craft their own configuration. The advice is to start with templates like `Neovim-from-scratch` or `kickstart.nvim`. This time, I was sure: they're not being elitist, it is genuine advice.

Some templates were outdated, while others hadn't incorporated even basic tools like `Lazy.nvim`. Still, it was a breath of fresh air — you do everything yourself, gaining understanding and remembering your keymaps. I went with `nvim-basic-ide` template.

Soon, a new challenge arose — plugin authors occasionally introduce literally breaking changes that can ruin your workday. This is where pre-built configurations shine — they fix updates or give the ability to rollback to the clean installation. Having taken "do it yourself" approach, I spent a lot of time creating my own full-featured stable configuration. I was lucky to have some spare time, but I doubt everyone has it.

As you may have guessed, EdenVim is my solution — you still follow the "do it yourself" approach but with more speed and less frustration. The goal is to bridge the gaps between _"I've installed it"_, _"It works for my projects"_, and _"I can customize my PDE"_. Although these stages don't coincide in practice, the aim is to make them overlap as much as possible. Moreover, if you're familiar with Vim, you'll become productive in just a day or two — I've tested it with my friends.

## Using EdenVim-based configurations with Nix and NixOS

Setting up Neovim on Nix-driven systems is often tricky when it comes to managing external binary dependencies like LSP servers.
Neovim users frequently modify files in `~/.config/nvim`, and tools like `mason.nvim` dynamically install formatters, LSP servers, and other binaries at runtime.
Both conflicts with Nix's philosophy of reproducible builds and immutability. This often results in dilemma to either go Nix-first or Neovim-first,
which is very unsatifying as in principle, Nix and Neovim look like a match in heaven.

While excellent projects like [nixvim](https://github.com/nix-community/nixvim) offer Nix-first Neovim installations, in practice many users prefer their Neovim configuration
to remain Nix-agnostic for portability.

### Solution: Nix for binary dependencies, Lazy.nvim for plugin management, `.config/nvim` for configuration

With EdenVim, you can disable Mason-based plugins on Nix systems and manage external tools like LSP servers via Nix. This means:

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

Instead of using `mason`, `mason-lspconfig`, `mason-dap` to install binary dependencies, declare them in the `programs.neovim.extraPackages` option.
This ensures all your tools are managed by Nix and are available within Neovim when it is launched. They don't pollute global environment.
**Note**: I cross-referenced some common tools installed by Mason (some of them extracted from VS Code) to corresponding `nixpkgs` packages, see the list in the [Full Example to Copy and Paste](#full-example-to-copy-and-paste) section.

```nix
programs.neovim.extraPackages = with pkgs; [
  bash-language-server
  rust-analyzer
  # ... Other LSP servers, formatters, linters, etc ...
];
```

#### 3. Link or Clone Your Neovim Configuration

First, you can manually clone or place your Neovim configuration in `~/.config/nvim` and skip this step.

If you manage your Neovim configuration as a Git submodule or just a directory within your Nix-based dotfiles repository, try using a symlink.
To keep Neovim configuration in `~/.config/nvim` editable, symlink it using the `xdg.configFile` option with the `mkOutOfStoreSymlink` function.
It works like this: `mkOutOfStoreSymlink` returns a path in the Nix store, but the path itself is just a symlink that resolves to the specified path.

```nix
xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "/home/username/dotfiles/config/nvim";
```

Make sure to replace `"/home/username/dotfiles/config/nvim"` with the **actual absolute path** to your Neovim configuration.
If you use Flakes, your dotfiles are copied to the Nix store first, so during evaluation relative paths will resolved inside a Nix store. An absolute path ensures linking works correctly.

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
    -- Disable mason.nvim, mason-lspconfig.nvim, and other mason-related plugins
    { "williamboman/mason.nvim", enabled = false },
    { "williamboman/mason-lspconfig.nvim", enabled = false },
    -- ...
  },
  -- ...
})
```

#### 5. Set Up Home Manager Activation Scripts (Optional)

To make sure all your plugins are installed and ready to go when you start Neovim, use activation scripts -- a mechanism used to set up the system during `home-manager switch`.
Consider it a "build" step for your configuration and a way make your setup idempotent.
In the example below, Lazy.nvim clones git repositories and builds telescope-fzf-native using make during activation phase.

First, ensure that the necessary tools are available during the activation phase.
Note: the packages listed here are available only during activation phase, except if you make them available in other ways.
For example, if you disable Neovim by `programs.neovim.enable = false`, it would still be available during activation phase
to install packages just like `make` or `gcc`, however you won't be able to use it after.

```nix
home.extraActivationPath = with pkgs; [
  git       # For cloning plugins
  gnumake   # For building plugins like telescope-fzf-native
  gcc       # For compiling native extensions
  neovim    # To run Lazy-related Neovim commands during activation
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

Here's how it all comes together in your `home.nix` file, assuming you're using `home-manager` and `EdenVim`:

```nix
{ pkgs, config, lib, ... }:
{
  # ... Other parts of your configuration ...
  programs.neovim = {
    enable = true;

    # Often required, don't worry as it's isolated in Neovim environment
    withPython3 = true;
    withNodeJs = true;

    # Packes available within Neovim during runtime. Put your LSP Servers, formatters, linters, etc.
    extraPackages = with pkgs; [
      bash-language-server
      buf-language-server
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
    neovim
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

### Future Plans: Flake-based solution for any Lua-based configurations (WIP)

I'm working on a way to make integrating arbitrary Neovim configurations with Nix smoother. This will allow you to wrap your Lua-based Neovim configuration in a Nix-friendly way without changing your code at all, and still keep all your configuration files in `~/.config/nvim`. Stay tuned for updates!

## Credits

- [nvim-basic-ide](https://github.com/LunarVim/nvim-basic-ide): I've grown my configuration from it, and my configuration eventually grown into EdenVim.
- [LazyVim](https://github.com/LazyVim/LazyVim): For me, this configuration is one of the best full-featured configurations in terms of code quality, extensibility, and design.
- [NvChad](https://github.com/NvChad/NvChad): This configuration showed me what an IDE-like Neovim experience could look like, and formed my values toward simplicity.
