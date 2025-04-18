# kickstart.nvim

## Introduction

A starting point for Neovim that is:

* Small
* Single-file
* Completely Documented

**NOT** a Neovim distribution, but instead a starting point for your configuration.

## Installation

### Install Neovim

Kickstart.nvim targets *only* the latest
['stable'](https://github.com/neovim/neovim/releases/tag/stable) and latest
['nightly'](https://github.com/neovim/neovim/releases/tag/nightly) of Neovim.
If you are experiencing issues, please make sure you have the latest versions.

### Install External Dependencies

External Requirements:
- Basic utils: `git`, `make`, `unzip`, C Compiler (`gcc`)
- [ripgrep](https://github.com/BurntSushi/ripgrep#installation)
- Clipboard tool (xclip/xsel/win32yank or other depending on the platform)
- A [Nerd Font](https://www.nerdfonts.com/): optional, provides various icons
  - if you have it set `vim.g.have_nerd_font` in `init.lua` to true
- Emoji fonts (Ubuntu only, and only if you want emoji!) `sudo apt install fonts-noto-color-emoji`
- Language Setup:
  - If you want to write Typescript, you need `npm`
  - If you want to write Golang, you will need `go`
  - etc.

> **NOTE**
> See [Install Recipes](#Install-Recipes) for additional Windows and Linux specific notes
> and quick install snippets

### Install Kickstart

> **NOTE**
> [Backup](#FAQ) your previous configuration (if any exists)

Neovim's configurations are located under the following paths, depending on your OS:

| OS | PATH |
| :- | :--- |
| Linux, MacOS | `$XDG_CONFIG_HOME/nvim`, `~/.config/nvim` |
| Windows (cmd)| `%localappdata%\nvim\` |
| Windows (powershell)| `$env:LOCALAPPDATA\nvim\` |

#### Recommended Step

[Fork](https://docs.github.com/en/get-started/quickstart/fork-a-repo) this repo
so that you have your own copy that you can modify, then install by cloning the
fork to your machine using one of the commands below, depending on your OS.

> **NOTE**
> Your fork's URL will be something like this:
> `https://github.com/<your_github_username>/kickstart.nvim.git`

You likely want to remove `lazy-lock.json` from your fork's `.gitignore` file
too - it's ignored in the kickstart repo to make maintenance easier, but it's
[recommended to track it in version control](https://lazy.folke.io/usage/lockfile).

#### Clone kickstart.nvim
> **NOTE**
> If following the recommended step above (i.e., forking the repo), replace
> `nvim-lua` with `<your_github_username>` in the commands below

<details><summary> Linux and Mac </summary>

```sh
git clone https://github.com/nvim-lua/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

</details>

<details><summary> Windows </summary>

If you're using `cmd.exe`:

```
git clone https://github.com/nvim-lua/kickstart.nvim.git "%localappdata%\nvim"
```

If you're using `powershell.exe`

```
git clone https://github.com/nvim-lua/kickstart.nvim.git "${env:LOCALAPPDATA}\nvim"
```

</details>

### Post Installation

Start Neovim

```sh
nvim
```

That's it! Lazy will install all the plugins you have. Use `:Lazy` to view
the current plugin status. Hit `q` to close the window.

#### Read The Friendly Documentation

Read through the `init.lua` file in your configuration folder for more
information about extending and exploring Neovim. That also includes
examples of adding popularly requested plugins.

> [!NOTE]
> For more information about a particular plugin check its repository's documentation.


### Getting Started

[The Only Video You Need to Get Started with Neovim](https://youtu.be/m8C0Cq9Uv9o)

### FAQ

* What should I do if I already have a pre-existing Neovim configuration?
  * You should back it up and then delete all associated files.
  * This includes your existing init.lua and the Neovim files in `~/.local`
    which can be deleted with `rm -rf ~/.local/share/nvim/`
* Can I keep my existing configuration in parallel to kickstart?
  * Yes! You can use [NVIM_APPNAME](https://neovim.io/doc/user/starting.html#%24NVIM_APPNAME)`=nvim-NAME`
    to maintain multiple configurations. For example, you can install the kickstart
    configuration in `~/.config/nvim-kickstart` and create an alias:
    ```
    alias nvim-kickstart='NVIM_APPNAME="nvim-kickstart" nvim'
    ```
    When you run Neovim using `nvim-kickstart` alias it will use the alternative
    config directory and the matching local directory
    `~/.local/share/nvim-kickstart`. You can apply this approach to any Neovim
    distribution that you would like to try out.
* What if I want to "uninstall" this configuration:
  * See [lazy.nvim uninstall](https://lazy.folke.io/usage#-uninstalling) information
* Why is the kickstart `init.lua` a single file? Wouldn't it make sense to split it into multiple files?
  * The main purpose of kickstart is to serve as a teaching tool and a reference
    configuration that someone can easily use to `git clone` as a basis for their own.
    As you progress in learning Neovim and Lua, you might consider splitting `init.lua`
    into smaller parts. A fork of kickstart that does this while maintaining the
    same functionality is available here:
    * [kickstart-modular.nvim](https://github.com/dam9000/kickstart-modular.nvim)
  * Discussions on this topic can be found here:
    * [Restructure the configuration](https://github.com/nvim-lua/kickstart.nvim/issues/218)
    * [Reorganize init.lua into a multi-file setup](https://github.com/nvim-lua/kickstart.nvim/pull/473)

### Install Recipes

Below you can find OS specific install instructions for Neovim and dependencies.

After installing all the dependencies continue with the [Install Kickstart](#Install-Kickstart) step.

#### Windows Installation

<details><summary>Windows with Microsoft C++ Build Tools and CMake</summary>
Installation may require installing build tools and updating the run command for `telescope-fzf-native`

See `telescope-fzf-native` documentation for [more details](https://github.com/nvim-telescope/telescope-fzf-native.nvim#installation)

This requires:

- Install CMake and the Microsoft C++ Build Tools on Windows

```lua
{'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
```
</details>
<details><summary>Windows with gcc/make using chocolatey</summary>
Alternatively, one can install gcc and make which don't require changing the config,
the easiest way is to use choco:

1. install [chocolatey](https://chocolatey.org/install)
either follow the instructions on the page or use winget,
run in cmd as **admin**:
```
winget install --accept-source-agreements chocolatey.chocolatey
```

2. install all requirements using choco, exit the previous cmd and
open a new one so that choco path is set, and run in cmd as **admin**:
```
choco install -y neovim git ripgrep wget fd unzip gzip mingw make
```
</details>
<details><summary>WSL (Windows Subsystem for Linux)</summary>

```
wsl --install
wsl
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install make gcc ripgrep unzip git xclip neovim
```
</details>

#### Linux Install
<details><summary>Ubuntu Install Steps</summary>

```
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install make gcc ripgrep unzip git xclip neovim
```
</details>
<details><summary>Debian Install Steps</summary>

```
sudo apt update
sudo apt install make gcc ripgrep unzip git xclip curl

# Now we install nvim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim-linux-x86_64
sudo mkdir -p /opt/nvim-linux-x86_64
sudo chmod a+rX /opt/nvim-linux-x86_64
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz

# make it available in /usr/local/bin, distro installs to /usr/bin
sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/
```
</details>
<details><summary>Fedora Install Steps</summary>

```
sudo dnf install -y gcc make git ripgrep fd-find unzip neovim
```
</details>

<details><summary>Arch Install Steps</summary>

```
sudo pacman -S --noconfirm --needed gcc make git ripgrep fd unzip neovim
```
</details>

# My neovim keyboard short cuts:
- ctrl + w = switches focus between the Neotree and neovim text editor 
- ctrl + c = allows you to type neovim commands
- press i = To start typing again in neovim
- /search = / and then type the word that you want to search in your current file in neovim
    - n : to move to next matched word
    - N : to move to prevous matched word
- :q! = will not save any changes
- :wq = will write changes and then quits neovim
- :w =  will save the file without quitting the neovim
- :Lazy sync = Will sync your new lazy packages and install it in the neovim text editor
  - I, U, H, S will allow you to change between different tabs in you lazy package manager window 
- :Neotree = This will open a terminal directory tree just like in vs code for neovim (default)
- :terminal = Open terminal inside of neovim
# Nvchad neovim keyboard short cuts :
## nvchad installation process : 
Follow this link to install nvchad ricing after installing neovim in your system.        
```https://github.com/NvChad/NvChad```
## neovim (nvchad installation) shortcuts
- space + e = This will open neotree a terminal directory tree just like vs code for neovim (Nvchad)
- $ : Moves the cursor to the end of the line.
- ^ : Moves the cusrsor to the start of the line.
- space + t + h : This brings up the nvchad theme configurator using this you can set yout desired theme in your neovim editor.
- space + v : This will open a terminal inside neoivim with a vertical split.
- space + h : This will open a terminal inside neovim with a horizontal split.
- . : This is used to comment or uncomment a line of code in nvchad neovim editor.
- space + / : This will comment or uncomment a line in neovim.
- ctrl + v + j or k + space + / : this will comment multiple lines in neovim. 
- space + ff : This will open up a find file browser in your current directory.
- ctrl + v + > or < : This will allow you to indent multiple lines using this shortcut

## neotree (nvchad installation) shortcuts
- r : To rename a file.
- a : To create a new file in your current directory.
- c : To copy a file in neotree.
- p : To paste a file in a neotree.
- d : To delete a file in neotree.
- m : Its used mark files that you are currently working on and helps you distinguish and identify the files that are currently important to you.
- space + c + h : This opens up the cheatsheet for all the shortcuts that neovim nvchad installation has to offer.

## git hub keyboard shortcuts for neovim
### using gitsigns
The link to the Gitsigns = ```https://github.com/lewis6991/gitsigns.nvim```     
- space + g + p : This opens up git preview in a separate pop.
- space + c + l + b : When you are in normal mode this tells you who and when a line in a file has been changed by someone in the repository or in a branch in github and gitlab.
- space + diff : This will tell yout difference in your local and you git copy of the currently opened file.
### using lazygit
When setting up lazygit make sure you have installed lazygit in your system before integrating it in you nvchad setup and configuring these keymaps.
Link to the github source code page is here : ```https://github.com/jesseduffield/lazygit.git```
- vim.keymap.set("n","leader + lg",":LazyGit",{})
- vim.keymap.set("n","leader + lgc",":LazyGitConfig",{})
- vim.keymap.set("n","leader + lgcf",":LazyGitCurrentFile",{})
- vim.keymap.set("n","leader + lgf",":LazyGitFilter",{})
- vim.keymap.set("n","leader + lgfcf",":LazyGitFilterCurrentFile",{})

### Copy and paste shortcuts in neovim
#### copy paste using internal registers
**Copy (Yank)**
Action	Normal Mode Keybinding
- Copy (yank) a line	yy
- Copy (yank) a word	yaw
- Copy (yank) from cursor to end of line	y$
- Copy (yank) a selected text (Visual Mode)	y
- Copy (yank) entire file	ggVGy

**Paste**
Action	Normal Mode Keybinding
- Paste after cursor	p
- Paste before cursor	P

#### Copy paste using clipboard 
**Copy (Yank) to System Clipboard**
Action	Command
- Copy a line to clipboard	"+yy
- Copy selected text to clipboard (Visual Mode)	"+y
- Copy the entire file to clipboard	:%y+

**Paste from System Clipboard**
Action	Command
- Paste after cursor	"+p
- Paste before cursor	"+P
### select and delete in neovim
Selecting Text in Neovim    
Neovim has different selection modes:
- Character-wise Selection (Visual Mode)
  - Press v → Move cursor to select characters.
  - Press d → Delete the selection.
- Line-wise Selection (Visual Line Mode)
  - Press V → Select entire lines.
  - Press d → Delete the selected lines.
- Block-wise Selection (Visual Block Mode)
  - Press Ctrl + v → Select a block of text (column selection).
  - Press d → Delete the selected block.
- Action	Key Combination
  - Select text	v (character) / V (line) / Ctrl + v (block)
  - Copy selection	y
  - Cut selection	d
- Comment multiple lines in neovim:
    - Ctrl + v + 2j + Shift i + # + esc : Here ```2``` is the number of lines that you want to select and ```#``` is the character used in python to comment a line of code.

## NeoTree shortcuts:
### File and directory management:
For more info visit this link : https://lyz-code.github.io/blue-book/neotree/
a: Create a new file or directory. Add a / to the end of the name to make a directory.
d: Delete the selected file or directory
r: Rename the selected file or directory
y: Mark file to be copied (supports visual selection)
x: Mark file to be cut (supports visual selection)
m: Move the selected file or directory
c: Copy the selected file or directory

## Neovim terminal tool for git operations
- lazygit
- here is the github link: ```https://github.com/jesseduffield/lazygit.git```

# neovim Trouble shooting
## If Neotree fails to open a file then 
Run these neovim commands to resolve this issue
:Lazy update
:TSUpdate

# Neovim setup
Link to the gihub repo for neovim setup guide : https://github.com/hendrikmi/dotfiles/blob/main/nvim/lua/core/options.lua

## Lazy package manager setup
```
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end 
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins. STARTS
require('lazy').setup({
    --...Your configurations here...
})

```
## Neovim Neotree setup
- init.lua file
```
require('lazy').setup({
{
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
  }
},
{
  "nvim-treesitter/nvim-treesitter",
  run = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup {
      ensure_installed = { "lua" },
      highlight = { enable = true },
      indent = { enable = true },
    }
  end
},
})

-- Load additional plugin configs
require("plugins.neotree")
``` 
- lua/plugins/neotree.lua
```
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
  end,
})
```
## Neovim theme setup 
Theme link : ```https://github.com/scottmckendry/cyberdream.nvim?tab=readme-ov-file```
### lualine.lua
```
return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- Optional but recommended
  config = function()
    require("lualine").setup({
      options = { theme = "auto" }
    })
  end,
}
```
### cyberdream.lua
```
return {
  "askfiy/cyberdream.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("cyberdream").setup({
      transparent = true, -- Enable transparency
    })
    vim.cmd("colorscheme cyberdream")
  end
}
```
### init.lua 
```
require('lazy').setup({
{
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
},
require("plugins.lualine"),
require("plugins.cyberdream"),
})

-- Apply colorscheme automatically
vim.cmd.colorscheme "cyberdream"
```
## Neovim buffer delete package 
This allows you to close the current file opended in neovim when multiple file is opened in neovim
```
require('lazy').setup({
  {
    "famiu/bufdelete.nvim"  -- Plugin to delete buffers
  },
  -- Other plugins...
})
```
## Neovim shortcut keys setup 
To get the related config visit this link here : https://github.com/hendrikmi/dotfiles/blob/main/nvim/lua/core/keymaps.lua
Put the file inside the directory lua/core/keymaps.lua

