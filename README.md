# iferr.nvim

Neovim plugin to insert Go `if err != nil { ... }` blocks using
[iferr](https://github.com/koron/iferr).

> **Requires**: the `iferr` binary available in your `$PATH`.

## Install (lazy.nvim)

```lua
{
  'alirostami1/iferr.nvim',
  ft = 'go',              -- load only for Go files
}

