local ui = {}

local NO_BUFF = -1

function ui.loadBuffer(filePath)
    local buf = vim.fn.bufnr(filePath, false)

    if buf == NO_BUFF then
        vim.cmd("silent! badd " .. vim.fn.fnameescape(filePath))
        buf = vim.fn.bufnr(filePath, false)
    end

    if not vim.api.nvim_buf_is_loaded(buf) then
        local ok, err = pcall(vim.fn.bufload, buf)
        if not ok then
            vim.notify("Error on load buffer: " .. (err or "Unknow"), vim.log.levels.ERROR)
        end
    end

    return buf
end

function ui.calcDimensions()
    local total_width = vim.o.columns
    local total_height = vim.o.lines

    local width = math.floor(total_width * 0.5) -- metade direita da tela
    local height = math.floor(total_height * 0.8)

    local row = math.floor((total_height - height) / 2)
    local col = math.floor(total_width * 0.5)

    return {
        width = width,
        height = height,
        row = row,
        col = col,
    }
end

function ui.SetQuitCommand(buf)
    vim.api.nvim_buf_set_keymap(buf, "n", "q", "<cmd>wq<CR>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
end

function ui.SendCursorToEnd(buf, win)
    local last_line = vim.api.nvim_buf_line_count(buf)
    vim.api.nvim_win_set_cursor(win, { last_line, 0 })

    -- Inserir linha em branco e entrar no modo de inserção
    vim.api.nvim_feedkeys("o", "n", false)
end

function ui.SendCursorToLine(buf, win, lineNumber)
    local max_linha = vim.api.nvim_buf_line_count(buf)
    lineNumber = math.min(lineNumber or 1, max_linha)
    vim.api.nvim_win_set_cursor(win, { lineNumber, 0 })
end

function ui.OpenInFloatingWindow(filepath)
    local buf = ui.loadBuffer(filepath)
    local dimensions = ui.calcDimensions()
    local win = vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        row = dimensions.row,
        col = dimensions.col,
        width = dimensions.width,
        height = dimensions.height,
        style = "minimal",
        border = "rounded",
    })

    return buf, win
end

function ui.SendInput(text, callback)
    vim.ui.input(text, callback)
end

return ui
