# To build full-featured image locally, run:
#   docker build --target edenvim-full -t edenvim .
# To build each image separately, run:
#   docker build --target edenvim-base -t edenvim-base .
#   docker build --target edenvim-plugins -t edenvim-plugins .
#   docker build --target edenvim-langtools -t edenvim-langtools .
#   docker build --target edenvim-full -t edenvim-full .

# Base image. When launched, starts to install everthing. Installed:
# - Minimal system dependencies (+ git, gcc, make) — yes
# - Lazy plugins + Treesitter grammars — no
# - System-wide language tools — no
# - Mason tools — no
FROM alpine:3.21 AS edenvim-base

RUN apk add --no-cache \
    alpine-sdk \
    ca-certificates \
    wget \
    ripgrep \
    neovim

WORKDIR /root

# Cloning from the external source (like corporate Git) is often preferred, but it is less convenient for general use
# RUN git clone https://github.com/LitRidl/EdenVim.git .config/nvim
COPY . .config/nvim

ENTRYPOINT ["nvim"]


# Image that starts EdenVim with plugins available, but no system-wide or Mason language tools. Will give Mason errors (no npm, etc).
# Installed:
# - Minimal system dependencies (+ git, gcc, make) — yes
# - Lazy plugins + Treesitter grammars — yes
# - System-wide language tools — no
# - Mason tools — no
FROM edenvim-base AS edenvim-plugins

# Sleep ensures that all treesitter language grammars are installed (TSUpdate and TSUpdateSync proceed to `qa` prematurely)
# If undesired, replace sleep with TS force reinstall: '+lua vim.cmd("TSInstall! " .. table.concat(require("settings.toolset").ts_languages, " "))'
RUN nvim --headless \
    "+Lazy! restore" \
    '+sleep 15' \
    "+qa"


# Image that starts EdenVim with language toolchains needed for Mason to work, but without preinstalled Mason tools.
# - Installed:
# - Minimal system dependencies (+ git, gcc, make) — yes
# - Lazy plugins + Treesitter grammars — yes
# - System-wide language tools — yes
# - Mason tools — no
FROM edenvim-plugins AS edenvim-langtools

RUN apk add --no-cache \
    luarocks \
    lua-language-server \
    py3-pip \
    npm \
    go \
    gopls \
    rust-lldb \
    cargo \
    clang19-extra-tools \
    xz


# Fully-functional EdenVim (for the specified languages), with no external dependencies in runtime.
# Installed:
# - Minimal system dependencies (+ git, gcc, make) — yes
# - Lazy plugins + Treesitter grammars — yes
# - System-wide language tools — yes
# - Mason tools — yes
FROM edenvim-langtools AS edenvim-full

COPY <<EOF /tmp/edenvim-bootstrap.lua
    vim.cmd("Lazy load mason.nvim mason-nvim-dap.nvim mason-null-ls.nvim")
    vim.cmd("LspInstall " .. table.concat(require("settings.toolset").lsp_mason_install, " "))
EOF

RUN nvim --headless "+luafile /tmp/edenvim-bootstrap.lua" "+qall" && \
    rm -f /tmp/edenvim-bootstrap.lua && \
    rm -rf /root/.cache/pip /root/.cache/go-build /root/.npm/_cacache
