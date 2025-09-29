# iferr.nvim

Neovim plugin to insert Go `if err != nil { ... }` blocks using
[iferr](https://github.com/koron/iferr).

> **Requires**: the `iferr` binary available in your `$PATH`.

## Install (lazy.nvim)

```lua
{
    'alirostami1/iferr.nvim',
    ft = 'go', -- load only for Go files
    opts = {
        -- filetypes = {'go'},
        -- cmd_name  = 'IfErr',
        -- map       = '<leader>ie', -- buffer-local keymap
        -- message   = [[fmt.Errorf("failed to %w", err)]],
    }
}

