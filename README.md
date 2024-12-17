# lazygrep.nvim

💤 lazygrep is a plugin that searches directories based on the specified term. 💤

<vide src="./img/lazygrep.mp4">

Search your directories for functions, specific identifiers in a much easier and lazier way with lazygrep

## Installation

- lazy.nvim

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