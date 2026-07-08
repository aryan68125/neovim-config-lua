# My Neovim Configuration

Personal Neovim setup built around [lazy.nvim](https://github.com/folke/lazy.nvim), a file explorer, Treesitter-based syntax highlighting, a status line, a colorscheme, and Git integration via LazyGit.

## What's actually installed right now (reference snapshot)

| Item | Value |
|---|---|
| Neovim version | `0.9.5` (build `0.9.5-6ubuntu2`) |
| Neovim install source | Ubuntu's official `apt` repository (package: `neovim`) |
| OS | Ubuntu 24.04.4 LTS ("Noble Numbat") |
| Kernel | Linux 6.8.0, x86_64 |
| Plugin manager | [lazy.nvim](https://github.com/folke/lazy.nvim) |

This snapshot exists so that if something breaks later, you know exactly what "known good" looked like.

## Plugins used

| Plugin | Purpose | GitHub |
|---|---|---|
| lazy.nvim | Plugin manager | https://github.com/folke/lazy.nvim |
| neo-tree.nvim | Sidebar file explorer | https://github.com/nvim-neo-tree/neo-tree.nvim |
| nvim-treesitter | Better syntax highlighting/indent via parsers | https://github.com/nvim-treesitter/nvim-treesitter |
| lazygit.nvim | Open [LazyGit](https://github.com/jesseduffield/lazygit) inside Neovim | https://github.com/kdheepak/lazygit.nvim |
| cyberdream.nvim | Colorscheme (transparent background) | https://github.com/scottmckendry/cyberdream.nvim |
| lualine.nvim | Status line | https://github.com/nvim-lualine/lualine.nvim |
| bufdelete.nvim | Close buffers without messing up your window layout | https://github.com/famiu/bufdelete.nvim |
| plenary.nvim | Lua utility library (dependency of several plugins above) | https://github.com/nvim-lua/plenary.nvim |
| nvim-web-devicons | File type icons (needs a Nerd Font, see below) | https://github.com/nvim-tree/nvim-web-devicons |
| nui.nvim | UI component library (dependency of neo-tree) | https://github.com/MunifTanjim/nui.nvim |

**Important — nvim-treesitter is pinned to the `master` branch, not `main`.** In 2025 the nvim-treesitter maintainers did a full incompatible rewrite on `main` (removed the classic `require("nvim-treesitter.configs").setup{...}` API and it now requires a very new/nightly Neovim). `master` is the old, frozen, "compatible" branch kept alive specifically for setups like this one. Do not remove the `branch = "master"` line in the plugin spec unless you're prepared to rewrite the treesitter config and upgrade Neovim to a nightly build.

---

## 1. Installing Neovim

Official repo: **https://github.com/neovim/neovim**

Pick one of these:

**Option A — apt (what this machine uses, simplest, Ubuntu/Debian):**
```bash
sudo apt update
sudo apt install neovim
```
Ubuntu 24.04's repo currently ships `0.9.5`. That's older than upstream's latest release, but it's stable and is what this config was verified against.

**Option B — Official AppImage (newer version, no compiling, any distro):**
```bash
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
chmod u+x nvim-linux-x86_64.appimage
./nvim-linux-x86_64.appimage --appimage-extract-and-run   # test it works
sudo mv nvim-linux-x86_64.appimage /usr/local/bin/nvim
```

**Option C — Build from source (latest/nightly, needed only if you want the newest nvim-treesitter rewrite):**
```bash
git clone https://github.com/neovim/neovim
cd neovim
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
```

Verify:
```bash
nvim --version
```

---

## 2. Post-installation: putting this config to work

Assuming this repo will live on GitHub, on a fresh machine:

```bash
# 1. Back up anything already at ~/.config/nvim, then clone this repo there
git clone <your-repo-url> ~/.config/nvim

# 2. Launch nvim — init.lua auto-bootstraps lazy.nvim on first run
nvim
```

On that first launch, `init.lua` will:
1. Detect `lazy.nvim` isn't installed and `git clone` it automatically.
2. Read the plugin list in `init.lua` and install every plugin.
3. Read `lazy-lock.json` and check out the *exact* commit/branch pinned for each plugin — this is what makes the setup reproducible across machines instead of silently grabbing whatever the latest (possibly breaking) version is.

To be certain everything matches the lockfile exactly (recommended right after cloning, and anytime something seems off):
```vim
:Lazy restore
```

Other useful commands while inside Neovim:
```vim
:Lazy          " open the plugin manager UI — status, updates, logs
:Lazy sync     " install missing / update outdated / remove unused plugins
:checkhealth   " run Neovim's built-in diagnostics — flags missing tools, misconfigurations
:TSUpdate      " (re)compile/update treesitter parsers
```

Run `:checkhealth` once after first install — it will explicitly tell you if a required external tool (compiler, clipboard tool, etc.) is missing.

---

## 3. Extra steps required to make everything actually work (easy to forget)

These aren't Neovim plugins — they're system-level tools/fonts the plugins above depend on to function correctly.

### a) A Nerd Font (for icons in the file tree and status line)
`nvim-web-devicons` (used by neo-tree and lualine) renders file-type icons using special glyphs that only exist in a **[Nerd Font](https://www.nerdfonts.com/)**. Without one, icons show up as garbled boxes (`�`) instead of icons.

1. Download a Nerd Font, e.g. **JetBrainsMono Nerd Font** or **FiraCode Nerd Font**: https://www.nerdfonts.com/font-downloads
2. Install it as a system font:
   ```bash
   mkdir -p ~/.local/share/fonts
   unzip JetBrainsMono.zip -d ~/.local/share/fonts
   fc-cache -fv
   ```
3. Set your **terminal emulator** (not Neovim itself) to use that font. This is a terminal setting, e.g. in GNOME Terminal/Kitty/Alacritty/Windows Terminal preferences — Neovim just draws characters, the terminal decides how the font renders them.

### b) A C compiler + build tools (for Treesitter)
`nvim-treesitter` downloads parser source code and **compiles it** on your machine the first time a language is used. Needs:
```bash
sudo apt install build-essential curl tar git
```
(`build-essential` gives you `gcc`/`cc`/`make`.) This machine already has all of these.

### c) `lazygit` binary (for the `<leader>lg` keymap)
`lazygit.nvim` is just a thin wrapper — it launches the real `lazygit` program, which must be installed separately.
Repo: **https://github.com/jesseduffield/lazygit**
```bash
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
```

### d) System clipboard tool (for `<leader>y` / `unnamedplus`)
`options.lua` sets `clipboard = 'unnamedplus'`, meaning yank/paste should sync with the OS clipboard. Neovim needs a helper program to talk to the clipboard:
- **X11 sessions:** `sudo apt install xclip` or `xsel`
- **Wayland sessions:** `sudo apt install wl-clipboard` (provides `wl-copy`/`wl-paste`)

This machine is running a **Wayland** session but only has `xsel` (an X11 tool) installed, not `wl-clipboard`. It likely still works via XWayland compatibility, but for a fully native, more reliable Wayland clipboard, additionally install:
```bash
sudo apt install wl-clipboard
```

### e) Git
Required both for `lazy.nvim`'s self-bootstrap and for every plugin install. Already required by definition if you're pulling this config from GitHub.

---

## Keymap cheat sheet (leader = `<Space>`)

| Keys | Action |
|---|---|
| `<C-s>` | Save file |
| `<C-q>` | Quit |
| `<C-d>` / `<C-u>` | Scroll half-page down/up, keep cursor centered |
| `<leader>v` / `<leader>h` | Split window vertically / horizontally |
| `<leader>se` | Equalize split sizes |
| `<leader>xs` | Close current split |
| `<C-h/j/k/l>` | Move focus between splits |
| `<Tab>` / `<S-Tab>` | Next / previous buffer |
| `<leader>x` | Close current buffer |
| `<leader>b` | New empty buffer |
| `<leader>+` / `<leader>-` | Increment / decrement number under cursor |
| `<leader>to` / `<leader>tx` | New tab / close tab |
| `<leader>tn` / `<leader>tp` | Next / previous tab |
| `<leader>lw` | Toggle line wrap |
| `<leader>j` / `<leader>k` | Move line(s) down / up |
| `<leader>y` / `<leader>Y` | Yank to system clipboard |
| `<leader>lg` | Open LazyGit |

---

## Ideas if you want to grow this config later (not implemented yet)

Not part of the current setup, but common next additions for a config like this:
- **LSP** (`nvim-lspconfig` + `mason.nvim`) for autocompletion, go-to-definition, diagnostics.
- **A fuzzy finder** (`telescope.nvim`, which would make use of the `ripgrep` already installed on this machine) for fast file/text search.
- **A completion engine** (`nvim-cmp` or `blink.cmp`).

None of these are required for the config to work as-is — only add them if you actually want those features.
