<div align="center">
  <img
    src="https://github.com/user-attachments/assets/859b1e5e-15da-4457-9d69-07eb645499bc"
    width="410"
  />
</div>
<h1 align="center">Craft your personal IDE experience</h1>

EdenVim is a perfect starting point for your personal, full-featured Neovim configuration. No convoluted layers, just a clean setup to kickstart your **PDE (Personalized Development Environment)** journey.

Your configuration will [work seamlessly on Nix-based systems](#-using-nix-or-nixos) and traditional Linux/MacOS setups alike. It's also [Docker-friendly](#-quick-start-with-docker) and has features to [run EdenVim in enterprise](#-docker-use-cases-and-corporate-environments).

If you're looking for a pre-made, full-blown Neovim IDE, you're probably on [the same path I was](#-why-edenvim-my-neovim-journey).

Just give it a try and [learn to navigate in EdenVim](#-start-working-in-edenvim) in minutes:
```bash
docker run -it --rm  -v .:/root/work edenvim/edenvim:full
```

## ✨ Features

- 🍴**Fork & Craft** This is _your_ configuration, the starting point. Nothing like _"don't touch **our** base config, clone a starter repository and go with it_".
- 🏰**But enjoy stability** Protected from breaking changes via lazy.nvim lockfile. If you forked, just pull our changes to your configuration, no need to maintain plugin versions.
- 🪶**Small** Codebase without healthchecks, autocommand chains, custom events: mostly `lazy.nvim` plugin settings and explicitly defined defaults.
- 🎮**Tools that work immediately** Pre-configured LSP, debug adapters, and other tools installed automatically using `mason.nvim` or externally with tools like Nix.
- 🌱**Extend Neovim, not replace** We want you to learn Neovim, not another IDE. No `<leader>lm` to do `:Mason` or `<leader><tab>n` to replace builtin`gt`.
- 🌀**No wrapping** Direct plugin usage — use everything explicitly, no _"lang packs"_ or _"theme loaders"_.
- 🦉**Simplicity over fool-proofness** Should we write code to hide a `Switch C/C++ header/source file` keybinding when you're in a Python file? No — we trust you, and your journey is simpler without extra code.
- 🧶**Minimal interdependencies** Related things are placed together, no _"taking icons from here, fetching settings from there, extending default options"_. The exception is key mappings.
- 🪟**Transparency & Icons** Works seamlessly with popular color schemes.
- 🏆**Great C/C++ and Rust support** I used it to navigate Rust projects and Linux kernel (just [generate compile_commands.json](https://github.com/torvalds/linux/blob/master/scripts/clang-tools/gen_compile_commands.py)).
- 🏗️**Enterprise, Docker, Nix** Leverage extensive Docker support, create instant development environments, or enjoy Neovim on Nix systems.

## 🖼️ Showcase

<div align="center">

  ![EdenVim Main Screen](https://github.com/user-attachments/assets/d7412f28-fb7a-447b-99da-245d2c438121)
  **Main Dashboard** showcasing transparency support and session management

  ![Keybindings helper](https://github.com/user-attachments/assets/ae2ea4c4-b885-4874-8c9a-f78287a0131f)
  **Development Environment** featuring file explorer, interactive keybindings, and symbols outline

  ![Development Features](https://github.com/user-attachments/assets/535a1f8b-f4d4-4f21-ae9c-43d41d972000)
  **Smart Completions** with auto-complete, signature help, and GitHub-style definitions & references explorer

  ![LSP Features](https://github.com/user-attachments/assets/dc8723fc-9c0a-4e75-8805-b0fdf8fa6f72)
  **Language Intelligence** powered by LSP Servers and none-ls, featuring code actions, language tools, and inlay hints

  ![Search Features](https://github.com/user-attachments/assets/9ef909dd-908f-4680-91fa-5f0ec37c32df)
  **Powerful Search** with Telescope integration and native fzf fuzzy finding

</div>

## 📑 Table of Contents

- [📖 Why EdenVim? My Neovim journey](#-why-edenvim-my-neovim-journey)
- [🐳 Quick start with Docker](#-quick-start-with-docker)
  - [Available Images](#available-images)
  - [Version tags and mutability](#version-tags-and-mutability)
  - [Customization and advanced usage](#customization-and-advanced-usage)
- [🛫 Start working in EdenVim](#-start-working-in-edenvim)
- [🔧 Customization](#-customization)
  - [EdenVim structure](#edenvim-structure)
  - [Plugin system](#plugin-system)
  - [Core tools and Language support](#core-tools-and-language-support)
  - [LSP Server configuration](#lsp-server-configuration)
- [🏢 Docker use cases and Corporate environments](#-docker-use-cases-and-corporate-environments)
- [📦 Installation](#-installation)
  - [✅ Requirements](#-requirements)
  - [💻 Local installation on Linux and MacOS](#-local-installation-on-linux-and-macos)
- [🧬 Using Nix or NixOS](#-using-nix-or-nixos)
- [👥 Credits](#-credits)

## 📖 Why EdenVim? My Neovim journey

My path started with IDEs like IDEA and VS Code. At first, I tried to get _"the most powerful"_ Neovim setup. Intuitively, I treated it as a pre-made IDE, although it's a PDE platform.

I tried AstroNvim, LunarVim, LazyVim, and NvChad, but found myself overwhelmed — not only did I need to learn Vim, Neovim, and Lua, but also configuration-specific abstractions. I settled on NvChad.

It went well until I decided to remove UI elements that I'd never use. What seemed like a simple task became time-consuming as these elements were hard-coded into dependencies and modifying them meant breaking future core updates.

The consensus on the Neovim subreddit was clear: eventually, people often craft their own configurations. The advice was to start with templates like `Neovim-from-scratch` or `kickstart.nvim`. This time, I knew: they're not being elitist, it is genuine advice.

Some templates were outdated, while others hadn't incorporated basic tools like `lazy.nvim`. I found `nvim-basic-ide` refreshingly straightforward — doing everything myself led to better understanding and personally intuitive keymaps.

However, a new challenge emerged: plugin authors occasionally introduce breaking changes that can disrupt your workflow. And this is where pre-built configurations shine, as maintaining a personal configuration requires significant time investment.

I want to minimize the distance between _"I've installed it"_, _"It works for my projects"_, and _"I can customize my PDE"_. For me, EdenVim fits this gap — you follow the _"do it yourself"_ approach, but with more speed and less frustration.

## 🐳 Quick start with Docker

Want to run EdenVim without affecting your system? If your terminal emulator supports true color and Nerd Font symbols, it's easy:
```bash
docker run -it --rm edenvim/edenvim:full
```

Mount your local files to work with them:
```bash
# Mount the current directory on the host to /root/work inside the container
docker run -it --rm -v .:/root/work edenvim/edenvim:full

# Mount a specific host directory
docker run -it --rm -v ~/projects:/root/work edenvim/edenvim:full
```

### Available images

EdenVim provides ready-to-use Docker images on the [Docker Hub](https://hub.docker.com/r/edenvim/edenvim). Each image builds upon the previous one in a multi-stage setup:

| Image Tag | What's Inside | System Deps | Plugins & TS | Language Toolchains | Mason Tools | Notes |
|-----------|-------------|-------------|--------------|----------------|-------------|-------|
| `edenvim/edenvim:base` | Tools like git, Neovim and config | ✅ | ❌ | ❌ | ❌ | Neovim with EdenVim configuration available, no dependencies installed
| `edenvim/edenvim:plugins` | Above + Lazy plugins, Treesitter | ✅ | ✅ | ❌ | ❌ | Configuration works, but Mason commands won't be able to install tools
| `edenvim/edenvim:langtools` | Above + tools like npm, pip, cargo, go | ✅ | ✅ | ✅ | ❌ | Mason can install tools using toolchains, both manually and automatically
| `edenvim/edenvim:full` | Above + pre-installed Mason tools | ✅ | ✅ | ✅ | ✅ | Immediately functional, no runtime installation needed

Lua-based Neovim configuration (EdenVim or your fork) is a part of `base`. Plugins are installed by `Lazy.nvim`. Language toolchains are system-wide tools like `npm`, `pip`, `go`, `cargo`, or `clangd`. Mason installs tools like LSP servers and debug adapters and uses language toolchains to do so.

### Version tags and mutability
- *If unsure, use `edenvim:full` which is the complete suite that tracks the latest release.*
- `edenvim` and `edenvim:latest` are aliases for `edenvim:full`, which is a mutable tag.
- `edenvim:1.0.0` is an alias for `edenvim:full-1.0.0`.
- For each of `base`, `plugins`, `langtools`, and `full`, there are two tags:
  - `edenvim:full-1.0.0` is a pinned image, guaranteed to be immutable.
  - `edenvim:full-1.0` is mutable, it tracks the newest patch version `z` in `edenvim:full-1.0.z`

### Customization and advanced usage
Everything related to Docker is contained within a single `Dockerfile` with the goal to be easy to copy and paste. Please refer to the `Dockerfile` for details - it's very simple and you can modify system packages, set non-root user, add tools, etc.
It uses a multi-stage build that produces four images. `edenvim:base` may be a good base image for setting company-wide policies, proxy, and other features. If new images are based on it, it simplifies compliance. If it's worked out to `edenvim:full`, it may be a way to distribute reproducible developer environment that is based on the trusted base image.

For advanced usage, please refer to [Docker use cases and Corporate environments](#-docker-use-cases-and-corporate-environments).

## 🛫 Start working in EdenVim

When you first open EdenVim, you'll see a dashboard with one-key shortcuts. For an empty session (like `dotfiles`), you'll start with an empty buffer. To begin working:

- **Navigate files**
  - `SPC f f` to open file search.
  - `SPC f g` to grep through codebase.
  - `SPC f r` to browse recent files.
  - `SPC e` to open traditional IDE-style file explorer (nvim-tree).
  - `SPC f e` / `SPC f E` to open `mini.files` file picker (which also provides file preview like `SPC f f`).

- **Key bindings**
- `SPC` to open which-key popup (interactive cheatsheet):
  - navigate through groups with their prefix letters;
  - use backspace to go back;
  - backspace over `SPC` to see global bindings (like `gcc` to comment a line);
- `SPC h k` to search all custom and plugin keybindings.

- **Buffers**
- `[b` / `]b` (or `SPC bp` / `SPC bn`) to navigate prev/next buffer.
- `SPC b` to see buffer-related commands.
- `SPC .` for a quick buffer picker (single letter is assigned to each buffer and you can jump to it by typing the letter).
- `SPC ,` to browse all buffers in a Telescope popup.

- **Terminal**
- `Ctrl + z` to suspend Neovim, work in the original terminal, and then `fg` to resume.
- `SPC tt` or `Ctrl + \` to open a floating terminal.
- `SPC th` to open a terminal window in a horizontal split.
- `SPC gg` to open Lazygit.

To open **Mason** and **Lazy** popups, use `:Mason` and `:Lazy`. If you encounter issues with LSP or code actions, type `:LspInfo` or `SPC l i` to check their status. For general setup checks, use `:checkhealth` or review `:messages` for error messages.

Quickly adjust UI options via `SPC o`. For example, if you find it uncomfortable that you don't see `cmdline` under status line by default, you can toggle it with `SPC o c`.

### Neovim basics

If you're new to Neovim, start by entering `:Tutor` in Normal mode to learn the basics.
Once you're comfortable, it’s helpful to read the [Neovim documentation](https://neovim.io/doc/user/index.html). The best approach is to read it regularly in small parts, ideally practicing as you go. This will help you gradually evolve your skill set and simplify your configuration. Many Neovim plugins and custom key mappings wouldn’t exist if more users read the full documentation!

We also recommend to [learn Lua](https://learnxinyminutes.com/docs/lua/) early. Many obstacles you may encounter are Lua-related, and knowing the language will enable you to treat and debug your configuration as a regular Lua program.

## 🔧 Customization

### EdenVim structure

**The entry point** for the EdenVim-based configurations is `init.lua`. This is one of several predefined filenames Neovim looks for in configuration directories, including `~/.config/nvim`, `XDG_CONFIG_HOME/nvim`, and the `nvim` subdirectory within each `XDG_CONFIG_DIRS`. Our `init.lua` sequentially loads:

- `lua/options.lua`: sets `vim.*` options and EdenVim-specific options like `vim.g.eden_theme`. These are globally available; try `:lua print(vim.g.eden_theme)`.
- `lua/keymaps.lua`: defines most of the key mappings, though some keymaps are defined within plugins. In `keymaps.lua`, you can see both VimScript and Lua syntax.
- `lua/plugin-loader.lua`: the plugin loader, lazy.nvim. It installs plugins (typically to `~/.local/share/nvim/lazy`), manages their loading order, and loads them on demand.
- `lua/autocommands.lua`: "trigger-like" commands that are automatically executed on certain events like opening a buffer.

The **best place to start customization** is in `lua/options.lua`, then move on to `lua/keymaps.lua` and `lua/settings/toolset.lua`. Of course, don't forget to create your own dashboard header on `lua/settings/alpha-dashboard.lua`. Refer to the comments in the files on how to customize them — they are also available for most plugins in `lua/plugins/`. To define custom floating terminals with commands like `btop` or `iPython` in them, see `lua/plugins/toggleterm.lua` and `lua/keymaps.lua`.

### Plugin system
Lua files in `lua/plugins/` and `lua/colorschemes/` are automatically loaded by lazy.nvim, as specified in the `import_dirs` attribute in `lua/plugin-loader.lua`. These can be any directories. Each Lua file in these directories can return a list of plugins (or a single plugin) in lazy.nvim format. For example, if you create a file `lua/plugins/name_doesnt_matter.lua` with the following code, the plugin `lambdalisue/suda.vim` will be installed and lazily loaded on the next startup:
```lua
return {
  "lambdalisue/suda.vim",
  cmd = { "SudaRead", "SudaWrite" },
}
```

Lazy loading is a great optimization strategy, but it can be tricky to debug. If you add a plugin and something goes wrong, consult the [lazy.nvim documentation](https://lazy.folke.io/) as it's pretty compact and may save you some time.

### Core tools and Language support
Next is `lua/settings/toolset.lua`, which specifies the tools that should be available, covering:
- **Treesitter language parsers (`lua/plugins/treesitter.lua`)**: provide syntactic support for code highlighting, context-aware comments, and text objects (e.g., functions, statement bodies). To do so, it builds a syntax tree for a source file.
- **LSP Servers (`lua/plugins/lspconfig.lua`)**: in ideal world, they provide all language intelligence tools like code actions, refactoring routines, documentation popups, analysis-based code completion, and more. Technically, LSP Servers implement Language Server Protocol, which is based on a JSON-RPC.
- **DAP Debug Adapters (`lua/plugins/dap.lua`)**: debug adapters used for language-specific debugging with `nvim-dap`.
- **`null-ls` Sources (`lua/plugins/null-ls.lua`)**: specialized external tools like linters and formatters that are not LSP servers. When we say `null-ls`, we actually refer to its maintained fork `none-ls`.

**`nvim-treesitter`** supports automatic parser installation but requires a C compiler or pre-compiled binaries. Tree-sitter parser generators output C code, and Neovim interacts with these parsers as compiled shared libraries (e.g., `parser/{language}.so` files in Neovim’s `runtimepath`). Parsers for all languages in `toolset.ts_languages` are pre-installed as specified in `lua/plugins/treesitter.lua`.

**Mason (`mason.nvim`)** is a plugin manager for external dependencies, and it is configured as follows:
- `lua/settings/toolset.lua` specifies tools that may be installed automatically with Mason.
- `lua/plugins/lspconfig.lua` uses `mason-lspconfig.nvim` to tell Mason to install LSP servers specified in `toolset.lsp_mason_install` and to automatically set them up.
- `lua/plugins/null-ls.lua` configures `null-ls` to use `toolset.null_ls_sources` as sources, creating a single point of truth for `null-ls` configuration.
- `lua/plugins/mason.lua` sets up `mason.nvim` and `mason-lspconfig.nvim`, and it also uses `mason-null-ls.nvim` to request automatic installation of `null-ls` sources.
- `lua/plugins/dap.lua` employs `mason-nvim-dap.nvim` to request installation of debug adapters from `toolset.dap_servers`.

> [!NOTE]
> The relationship between `mason-lspconfig.nvim` and `nvim-lspconfig` is nuanced. In EdenVim, all servers listed in `toolset.lsp_mason_install` are passed to `mason-lspconfig.nvim`, which maps `lspconfig` server names to Mason package names. `mason-lspconfig.nvim` then requests installation of these packages from `mason.nvim`.
> Although `mason-lspconfig.nvim` can automatically call `lspconfig.servername.setup {}`, we intentionally avoid this. It allows disabling Mason without breaking anything, configuring externally managed LSPs, and ensures consistency between Nix and non-Nix systems. Instead, servers in `toolset.lsp_servers` are iterated over in `lua/plugins/lspconfig.lua`, where `setup { ... }` is explicitly called for each server with defaults given by `nvim-lspconfig` and merged with `settings/{server}.lua` if present.

Mason is unnecessary on Nix systems, see the [Nix instructions](#-using-nix-or-nixos) for details. In fact, it is unnecessasry on any system if you manage LSP, DAP, linters, and other tools externally.

### LSP Server configuration
Most plugin-specific code is intentionally grouped together, but LSP servers are an exception. `lspconfig` can set default configurations for LSP servers, but sometimes further customization is needed. Don’t hesitate to make changes, introduce hard-coded paths, or add commands when necessary to get everything working as desired — sometimes there's no other way.

In `lua/plugins/lspconfig.lua`, a loop iterates over `require("settings.toolset").lsp_servers` and looks for `lua/settings/{server}.lua` for each `server` in the list. If a file is found and returns a table, that table is merged with the default `lspconfig` configuration for the server. For a list of LSP servers and their default configurations, refer to the [nvim-lspconfig documentation](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md).

To customize an LSP server like `pyright`, create a file `lua/settings/pyright.lua`. The file name must match the [LSP server name](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md) in `toolset.lsp_servers`:
```lua
return {
  -- Usually, you're only interested in the `settings` table
  settings = {
    python = {
      -- Configuration for Pyright
      -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#pyright
    },
  },
  -- However, you can customize everything, including the command to launch the server
  -- cmd = { "pyright-langserver", "--stdio" },
  -- filetypes = { "python" },
}
```
> [!NOTE]
> The `python` key in `settings.python` does not refer to the LSP server or filetype; it has no connection to Neovim or plugins. The `settings` table is wrapped in a JSON-RPC message and passed to the LSP server. For Pyright, it just happens that language settings are placed under the `python` key, while tool-specific settings are located under the `pyright` key. See the [Pyright documentation](https://github.com/microsoft/pyright/blob/main/docs/settings.md) for more details.

### 🏢 Docker use cases and Corporate environments

EdenVim doesn't require Docker. But it provides first-class Docker support and opens some powerful possibilities:

1. **Instant development environments and Reproducibility:**
  - Launch a fully-configured EdenVim environments in seconds, without installing anything on your host machine.
  - Ensure every Neovim user in your team works in an identical base environment, but can use different plugins and configurations.
  - Experiment with new plugins or configurations in an without risking your main setup.
  - Provide reproducible environments for teaching, workshops, and tutorials.

2. **Enterprise and Security compliance:**
  - Achieve standardization and compliance by using approved base images, controlled distribution, reproducible builds, and operation in isolated networks without internet access.
  - If company doesn't allow installing anything, run EdenVim in Docker. Requesting docker is typically easy for developers.
  - Propose creating a pre-approved base Docker image for your team with proxies, mirrors, monitoring and scanners, version pinning, and other features enforced.
  - If security only allows specific base images, start from a company-sanctioned image and extend on a per-project, per-team, or per-user basis.
  - If you have private Docker registry, upload your custom EdenVim images for easy team access.
  - If you need to use internal mirrors/proxies, configure them inside Dockerfile. It's very easy to prove that they work when enforced on the whole container.
  - If users should have no capability to build local images, they can push them for scanning and building, subsequently pulling them from the private registry. This enables auditing and helps to prevent malicious plugins from being distributed.

3. **Layered images for customization, compliance, and economy:**
  ```
  FROM corporate-base-image:1.0       # Approved corporate base with scary features
  ├── edenvim-full:1.0                # EdenVim and core plugins and tools
      ├── team-customizations:1.0     # Team/project/customer-specific settings and tools
          └── personal-config:latest   # Your personal tweaks like keymaps, options, etc.
  ```

4. **Multiple Neovim instances at once with persistent state on the host:**
  You can create multiple Neovim environments by mounting different state directories for each Neovim instance and use the same Docker image to simultaneously run different Neovim instances. 
  - Configuration: `-v ~/nvim1/config:/root/.config/nvim`
  - Plugins: `-v ~/nvim1/share:/root/.local/share/nvim`
  - History: `-v ~/nvim1/state:/root/.local/state/nvim`
  - Cache: `-v ~/nvim1/cache:/root/.cache/nvim`

## 📦 Installation

### ✅ Requirements

EdenVim is pre-configured to support TypeScript, Rust, Go, Lua, C/C++, Python, and other popular languages. 

#### Running in Docker
- A terminal emulator with true color and UTF-8 support (Kitty, alacritty, WezTerm, foot, Ghostty, etc.)
- Clipboard tool (xclip, wl-clipboard, pbcopy, etc. `:help clipboard-tool` in Neovim for more details)
- [A Nerd Font](https://www.nerdfonts.com/) like `JetBrains Mono Nerd Font` for icons

#### Running locally
**Core dependencies:**
- [Neovim](https://github.com/neovim/neovim/blob/master/INSTALL.md#install-from-package) 0.9.5+
- A terminal emulator with true color and UTF-8 support (Kitty, alacritty, WezTerm, foot, Ghostty, etc.)
- Clipboard tool (xclip, wl-clipboard, pbcopy, etc. `:help clipboard-tool` in Neovim for more details)
- [Git](https://git-scm.com/) for plugin management
- [A Nerd Font](https://www.nerdfonts.com/) like `JetBrains Mono Nerd Font` for icons
- [Ripgrep](https://github.com/BurntSushi/ripgrep) for faster file search
- [C compiler](https://gcc.gnu.org/) for treesitter compilation (cc, gcc, clang, zig, etc.)
- [GNU Make](https://www.gnu.org/software/make/) for building plugins like telescope-fzf-native

**Extra dependencies for out-of-the-box experience:**
- [Lazygit](https://github.com/jesseduffield/lazygit) for TUI-based git interface
- [LuaRocks](https://github.com/luarocks/luarocks) for Lua package manager
- [Node.js](https://nodejs.org/en/download/) with `npm` for LSP servers and tools
- [Python](https://www.python.org/downloads/) with `pip` for LSP servers and tools
- [Rust](https://www.rust-lang.org/tools/install) for some LSP servers
- [Go](https://go.dev/doc/install) for some LSP servers

> [!TIP]
> Modern terminal emulators like Kitty and WezTerm allow you to use any font and still get icons by using `Symbols Nerd Font` as a fallback font. Glyphs like alphabet characters are rendered according to your favorite normal font, and if a glyph is missing, it is taken from the fallback font.

### 💻 Local installation on Linux and MacOS

The idea of EdenVim is to provide a working "clean slate" for your Neovim configuration. We encourage you to:
1. Think of a cool name for your Personal Development Environment (PDE).
2. [Fork EdenVim](https://github.com/LitRidl/edenvim/fork) to your own repository.
3. Use it as a starting point for your configuration.
4. Optionally, pull updates and improvements from EdenVim to offload version management and plugin maintenance.

#### Steps to install

1. Make [dependencies](#-requirements) available.

On Ubuntu 22.10, you can globally install them (except Lazygit and Nerd Font) with:
```bash
sudo apt install git curl neovim python3-full python3-pip golang ripgrep luarocks npm nodejs rustc cargo make gcc
```

On MacOS, you can use Brew:
```bash
brew install neovim ripgrep lazygit go node rustup
rustup default stable
# Try `brew install --cask symbols-only-nerd-font font-jetbrains-mono-nerd-font` if your terminal emulator doesn't support fallback fonts
brew install --cask symbols-only-nerd-font
```

> [!NOTE]
> Commands above install language tools globally. It's often better to use tools like `nvm`/`fnm` and `pyenv` to manage your language toolchains. Also, it can be harder to troubleshoot in future if tools like `rustup` and `go` are installed with Brew.

2. Back up your existing Neovim configuration (if you have one):
```bash
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
```

3. Clone your fork of EdenVim or the main repository:

For your fork:
```bash
git clone https://github.com:your-username/your-fork-name.git ~/.config/nvim
```

To clone EdenVim repository:
```bash
git clone https://github.com/LitRidl/edenvim.git ~/.config/nvim
```

_Replace `https://` with `git@` if you have SSH access configured._

4. Launch Neovim:
```bash
nvim
```

#### First launch

On first launch, EdenVim automatically:
- Installs the plugin manager (lazy.nvim).
- Downloads and installs Neovim plugins (versions pinned in lazy-lock.json).
- Downloads and compiles Treesitter parsers.  
- Sets up Mason package manager for LSP servers, linters, and formatters.
- Installs binary dependencies requested by mason-lspconfig, mason-dap, and mason-null-ls.

Please be patient; this process may take several minutes depending on your connection, GitHub rate limiting, and system performance. You may see multiple notifications during the process.

## 🧬 Using Nix or NixOS

Setting up Neovim on Nix-driven systems is often tricky when it comes to managing external binary dependencies like LSP servers.
Neovim users frequently modify files in `~/.config/nvim`, and tools like `mason.nvim` dynamically install formatters, LSP servers, and other binaries at runtime.
This conflicts with Nix's philosophy of reproducible builds and immutability. This often results in the dilemma of choosing either Nix-first or Neovim-first, which is very unsatisfying as, in principle, Nix and Neovim seem like a match made in heaven.

While excellent projects like [nixvim](https://github.com/nix-community/nixvim) offer Nix-first Neovim installations, in practice many users prefer their Neovim configuration
to remain Nix-agnostic for portability.

### Nix for binary dependencies, lazy.nvim for plugins, `.config/nvim` for configuration

With EdenVim, you can disable Mason-based plugins on Nix systems and manage external tools like LSP servers and null-ls/none-ls tools via Nix. This means:

- Your Neovim configuration remains in `~/.config/nvim` and is non-immutable, so you can customize it without rebuilding.
- External dependencies are managed by Nix, ensuring that setup is reproducible in term of binary dependencies.
- It works on non-Nix systems just as usual, and no parts of Nix "leak" into your Lua files.

### How to set up EdenVim with Home Manager

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
> I cross-referenced common tools installed by Mason (some of them extracted from VS Code) to corresponding `nixpkgs` packages. See the list in the [Home-Manager Example to Copy and Paste](#full-home-manager-example-to-copy-and-paste) section.

> [!NOTE]
> Treesitter parsers are compiled binaries that can be managed through Nix. However, they also work well when compiled locally using `clang` which we use for C/C++ LSP anyway. To maintain consistency between Nix and non-Nix setups, EdenVim defaults to local compilation.
> If you prefer Nix-managed parsers, add `pkgs.vimPlugins.nvim-treesitter.withAllGrammars` to `programs.neovim.plugins` and set `auto_install = false` in `lua/plugins/treesitter.lua`.

#### 3. Link or Clone your Neovim configuration

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

#### 5. Set up Home Manager Activation scripts (Optional)

To make sure all your plugins are ready to go when you start Neovim, use activation scripts — a mechanism used to set up the environment during `home-manager switch`.
Consider it a "build" step for your Neovim configuration and a way to make it idempotent.
In the example below, `lazy.nvim` clones git repositories and builds `telescope-fzf-native` using `make` during activation phase.

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

### Full Home-Manager example to Copy and Paste

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
      buf
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

## 👥 Credits

- [nvim-basic-ide](https://github.com/LunarVim/nvim-basic-ide): I've grown my configuration from it, and my configuration eventually grown into EdenVim.
- [LazyVim](https://github.com/LazyVim/LazyVim): For me, this configuration is one of the best full-featured configurations in terms of code quality and design. Created by [@folke](https://github.com/folke), the creator of Lazy.nvim and author of many Neovim plugins.
- [NvChad](https://github.com/NvChad/NvChad): This configuration showed me what an IDE-like Neovim experience could look like, and formed my values toward simplicity.
