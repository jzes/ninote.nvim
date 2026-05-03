local M = {}

local NO_BUFF = -1

local function load_buffer(file_path)
  local buf = vim.fn.bufnr(file_path, false)

  if buf == NO_BUFF then
    vim.cmd("silent! badd " .. vim.fn.fnameescape(file_path))
    buf = vim.fn.bufnr(file_path, false)
  end

  if not vim.api.nvim_buf_is_loaded(buf) then
    local ok, err = pcall(vim.fn.bufload, buf)
    if not ok then
      vim.notify("Error on load buffer: " .. (err or "Unknow"), vim.log.levels.ERROR)
    end
  end

  return buf
end

local function calc_dimensions()
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

function M.set_quit_command(buf)
  vim.api.nvim_buf_set_keymap(buf, "n", "q", "<cmd>wq<CR>", { noremap = true, silent = true })
  vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
end

function M.send_cursor_to_end(buf, win)
  local last_line = vim.api.nvim_buf_line_count(buf)
  vim.api.nvim_win_set_cursor(win, { last_line, 0 })

  -- Inserir linha em branco e entrar no modo de inserção
  vim.api.nvim_feedkeys("o", "n", false)
end

--- Enviar o cursor para uma linha específica (padrão para a primeira linha)
--- @param buf number O buffer onde o cursor deve ser posicionado
--- @param win number A janela onde o cursor deve ser posicionado
--- @param lineNumber number A linha para onde o cursor deve ser enviado (padrão para 1)
function M.send_cursor_to_line(buf, win, lineNumber)
  local max_linha = vim.api.nvim_buf_line_count(buf)
  lineNumber = math.min(lineNumber or 1, max_linha)
  vim.api.nvim_win_set_cursor(win, { lineNumber, 0 })
end

--- Abrir um arquivo em uma janela flutuante
--- @param filepath string O caminho do arquivo a ser aberto
function M.open_in_floating_window(filepath)
  local buf = load_buffer(filepath)
  local dimensions = calc_dimensions()
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

--- Enviar uma solicitação de entrada para o usuário
--- @param text string O texto a ser exibido na solicitação de entrada
--- @param callback function A função de callback a ser chamada com a entrada do usuário
--- @param default string O valor padrão a ser exibido na solicitação de entrada (opcional)
function M.send_input(text, callback, default)
  vim.ui.input({
    prompt = text,
    default = default or "",
  }, callback)
end

return M
