# lazygrep.nvim

💤 Welcome to lazygrep.nvim! 💤

<vide src="./img/lazygrep.mp4">

A super cool plugin for Neovim that helps you search your project files and Neovim documentation like a pro! With lazygrep.nvim, you can search using regular expressions and instantly preview results within the Telescope interface. No more wasting time digging through files or guessing keybindings.

Installation

Make sure you have [Telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) and [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) installed. Then, add lazygrep.nvim to your plugin manager.

- Using packer.nvim

```lua
use {
  'BrunoCiccarino/lazygrep.nvim',
  requires = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
  config = function()
    require('lazygrep').setup()
  end
}
```
- Using lazy.nvim

```lua
{
    "BrunoCiccarino/lazygrep.nvim"m
    dependencies = {
        { 
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim"  
        },
  },
},
```

#### Usage

Basic Commands

- `:LazyGrep` <search_term>: Searches recursively for your term across all files in your current working directory.

- `:LazyGrepDocs` <search_term>: Searches through Neovim's documentation for commands, options, and shortcuts.

Just Open the UI!

Run `:LazyGrep` or `:LazyGrepDocs` without any arguments, and you’ll get a live search UI. Start typing to see results instantly!

### Keybindings

Want to make things even faster? Add keybindings in your init.lua or init.vim:

#### **Lua Example**

```lua
vim.api.nvim_set_keymap('n', '<leader>lg', ":LazyGrep<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ld', ":LazyGrepDocs<CR>", { noremap = true, silent = true })
```

### Tips & Tricks

Search smarter with regex

You can use regex to refine your searches. For example:

- foo.*bar matches "foo" followed by anything, then "bar".
- ^TODO finds lines starting with "TODO".

#### Preview results live

When searching, lazygrep.nvim highlights the matched line in a preview window. Navigate to a result with `<CR>` (Enter) to jump straight to it.

Explore the Neovim docs

Use `:LazyGrepDocs` to search the official Neovim help files for commands, options, or keyboard shortcuts. Never be lost again!

