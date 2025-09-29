local M = {}

local function buf_text(buf)
    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, true)
    return table.concat(lines, "\n")
end

local function run_iferr()
    local bpos  = vim.fn.wordcount().cursor_bytes
    local buf   = vim.api.nvim_get_current_buf()
    local input = buf_text(buf)

    local out   = vim.fn.systemlist('iferr -pos ' .. tostring(bpos), input)

    if type(out) ~= 'table' or #out == 1 then
        return
    end

    local pos  = vim.fn.getcurpos()
    local lnum = pos[2]
    vim.fn.append(lnum, out)
    vim.cmd('silent normal! j=2j')
    vim.fn.setpos('.', pos)
    vim.cmd('silent normal! 4j')
end

M.run = run_iferr

--- Setup: creates a buffer-local :IfErr command (and optional keymap) for given filetypes.
--- @param opts table|nil { filetypes={'go'}, cmd_name='IfErr', map=nil }
M.setup = function(opts)
    opts           = opts or {}
    local fts      = opts.filetypes or { 'go' }
    local cmd_name = opts.cmd_name or 'IfErr'
    local map      = opts.map

    vim.api.nvim_create_autocmd('FileType', {
        pattern = fts,
        callback = function(args)
            vim.api.nvim_buf_create_user_command(
                args.buf,
                cmd_name,
                function() run_iferr() end,
                { nargs = 0, desc = 'Insert iferr block at cursor' }
            )

            if map then
                vim.keymap.set('n', map, run_iferr, { buffer = args.buf, desc = 'iferr: insert error check' })
            end
        end,
    })
end

return M
