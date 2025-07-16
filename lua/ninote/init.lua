local ninote = {}

ninote.config = {
    NoteDir = vim.fn.expand("~/.notes"),
    NewNoteHeader = "New Note",
    SearchEngine = "fzf-lua",
    OpenSearch = "buffer", -- can be float
}

function ninote.setup(userConfig)
    -- seta valores pras configs
    ninote.config = vim.tbl_deep_extend("force", ninote.config, userConfig or {})
    -- registra os comandos
    --
    vim.api.nvim_create_user_command("NinoteNew", require("ninote.note").New, {})
    vim.api.nvim_create_user_command("NinoteClose", require("ninote.note").Close, {})
    vim.api.nvim_create_user_command("NinoteSearch", require("ninote.search").SearchInNotes, {})
end

return ninote
