# EdenVim — Craft your personal IDE experience

A perfect starting point for your personal, full-featured Neovim config. No convoluted layers, just a clean and intuitive setup to kickstart your PDE (Personalized Development Environment) journey.

If you came here looking for a pre-made, full-blown Neovim IDE, then you're in the right place. Chances are you're on the same path I was — [Why EdenVim? My Neovim Journey](#why-edenvim--my-neovim-journey).

## Features
- 🍴**Fork & Craft**🎨 This is *your* configuration, it's the starting point. No *"we have **our** base configuration, don't touch it, clone a starter repository and go with it*". If you don't want to maintain plugin versions, you can pull our changes to your configuration.
- ⚡**Fast**🚀 Lazy-loading with `Lazy.nvim` and caching of Lua bytecode with a new Neovim 0.9+ feature. On my laptop, using `:Lazy profile` gives 45 ms, compared to 90 ms for AstroNvim, 80 ms for LazyVim, and 50 ms for NvChad.
- 🪶**Small**🔍 ~2500 lines of code, mostly plugin settings and explicitly defined defaults. Plus, ~500 lines of comments.
- 🏰**Stable**🪤 You are guarded from breaking changes on updates by using a mechanism based on `Lazy.nvim` lazylock files.
- 🎮**Tools that work immediately**🧰 No need to configure `treesitter`, debug adapters, language servers, linters and diagnostics "from scratch". Furthermore, all packages install automatically using `mason.nvim` for `null-ls.nvim`, `nvim-lspconfig`, and `nvim-dap`.
- 🪟**Out-of-the-box transparency**🌙 It just works for almost all color schemes — a feature often missing even in IDE-like configurations.
- 🌀**No wrapping**➡️ Be it `Lazy.nvim`, `rust-tools.nvim`, or your color scheme, you use it explicitly — no *"lang packs"*, *"theme loaders"*, *"UI layers"*, etc. You can also include your own plugins from your local file system.
- 🧶**Minimal interdependencies**📌 All related things are generally placed together, there is no approach of *"taking icons from here, fetching settings from there, extending default options from base config"*. The exception is key mappings — we keep them in one place.
- 🌱**Extend Neovim, not replace it**💡 We want you to learn Neovim, not yet another IDE. No `<leader>tl` or `<leader>lm` instead of `:Lazy` and `:Mason`, no bindings like `<leader><tab>n` instead of simple Neovim's builtin `gt`, and so on.
- 🦉**Simplicity over hiding**🧮 should we write a code to hide a `Switch C/C++ header/source file` keybinding while you're in a Python file? For us, the answer is no — we trust you, and your journey is simpler without extensive checks, notification code, and autocommand chains.
- 🏆**Exceptional support of C/C++ and Rust**📚 correct configuration of `clangd_extensions.nvim`, include-based autocompletion, crate management, etc. I've personally used it to navigate some complex Rust projects and Linux kernel (for the kernel, just be sure to [generate compile_commands.json](https://github.com/torvalds/linux/blob/master/scripts/clang-tools/gen_compile_commands.py)).
- 📐**Sane defaults for options, keymaps, basic plugins, and autocommands**✅ Things you'll do anyway. For instance, many users dislike when indenting in Virtual mode switches to Normal mode, or the inability to save a root-owned file if they forgot to use `sudo` or `sudoedit`.
- 💡**Modern obsessively picked plugins**🎯 You'll notice how `typescript-tools.nvim` outperforms `typescript-language-server` in a large project, how `flash.nvim` really exceeds `hop.nvim`, how `mini.ai` elevates text objects to a whole new level, and a lot more.

## Why EdenVim? My Neovim Journey
My path started with IDEs like IDEA, CLion, and VS Code. At first, I tried to get "the most powerful" Neovim setup. Intuitively, I treated it as a pre-made IDE, although it's a PDE platform.

I tried AstroNvim, LunarVim, LazyVim, and NvChad. I was overwhelmed by complexity — not only did I have to learn Vim, Neovim, and Lua, but I also had to navigate configuration-specific abstractions. I even had to create a Neovim configuration switcher to navigate between my setups. In the end, I settled on NvChad — it felt less bloated and had a noticeable presence on YouTube.

It went well until I decided to remove "close all" and "toggle dark/light theme" buttons. For something that I've never used, they consumed too much screen real estate. Surprisingly, it became a time-consuming endeavor. I discovered that it was hard-coded in NvChad's dependencies: to fix this, I had to change the `NvChad UI` plugin, breaking all future updates.

The consensus on the Neovim subreddit was clear: in the end, most people craft their own configuration. The advice is to start with templates like `Neovim-from-scratch` or `kickstart.nvim`. This time, I was sure: they're not being elitist, it is genuine advice.

Some templates were outdated, while others hadn't incorporated even basic tools like `Lazy.nvim`. Still, it was a breath of fresh air — you do everything yourself, gaining understanding and remembering your keymaps. I went with `nvim-basic-ide` template.

Soon, a new challenge arose — plugin authors occasionally introduce literally breaking changes that can ruin your workday. This is where pre-built configurations shine — they fix updates or give the ability to rollback to the clean installation. Having taken "do it yourself" approach, I spent a lot of time creating my own full-featured stable configuration. I was lucky to have some spare time, but I doubt everyone has it.

As you may have guessed, EdenVim is my solution — you still follow the "do it yourself" approach but with more speed and less frustration. The goal is to bridge the gaps between *"I've installed it"*, *"It works for my projects"*, and *"I can customize my PDE"*. Although these stages don't coincide in practice, the aim is to make them overlap as much as possible. Moreover, if you're familiar with Vim, you'll become productive in just a day or two — I've tested it with my friends.

## Credits
- [nvim-basic-ide](https://github.com/LunarVim/nvim-basic-ide): I've grown my configuration from it, and my configuration eventually grown into EdenVim.
- [LazyVim](https://github.com/LazyVim/LazyVim): For me, this configuration is one of the best "full-blown" configurations in terms of code quality, extensibility, and design.
- [NvChad](https://github.com/NvChad/NvChad): This configuration showed me both how valuable simplicity is and how easy it is to make something complex.
