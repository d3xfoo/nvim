# TheStrayByte's Neovim Configuration
[![VIM](https://i.postimg.cc/YSb8WH9G/vim.png)](https://github.com/sbytex/nvim)


A modern and efficient Neovim configuration built with Lua, featuring lazy loading and a modular structure.

## Features

- 🚀 **Lazy Loading**: Uses [lazy.nvim](https://github.com/folke/lazy.nvim) for efficient plugin management
- 📦 **Modular Structure**: Organized configuration files for better maintainability
- ⚡ **Fast Startup**: Optimized for quick loading times
- 🎨 **Custom Keymaps**: Intuitive keybindings for enhanced productivity
- 🔧 **Custom Options**: Carefully tuned Neovim settings

## Structure

```
.
├── init.lua              # Main entry point
├── lazy-lock.json       # Plugin lock file
└── lua/
    └── thestraybyte/    # Main configuration directory
        ├── init.lua     # Core configuration
        ├── opt.lua      # Neovim options
        ├── remaps.lua   # Key mappings
        ├── autocmds.lua # Autocommands
        ├── lazy-init.lua # Plugin manager setup
        └── lazyaf/      # Plugin specifications
```

## Installation

1. Clone this repository:
   ```bash
   git clone  https://github.com/sbytex/nvim.git ~/.config/nvim
   ```

2. Start Neovim and let it install the plugins:
   ```bash
   nvim
   ```

## Requirements

- Neovim 0.9.0 or higher
- Git
- A Nerd Font (recommended for icons)

## Configuration Files

- `opt.lua`: Contains Neovim options and settings
- `remaps.lua`: Custom key mappings
- `autocmds.lua`: Autocommands for automated tasks
- `lazy-init.lua`: Plugin manager configuration
- `lazyaf/`: Plugin specifications and configurations

## Customization

To customize this configuration:

1. Edit the respective files in the `lua/thestraybyte/` directory
2. Add or remove plugins in the `lua/thestraybyte/lazyaf/` directory
3. Modify key mappings in `remaps.lua`


## Contributing

Feel free to submit issues and enhancement requests!
