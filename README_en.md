![ninote](ninotelogo.png)

[![Português](https://img.shields.io/badge/lang-pt--BR-green)](./README.md)
[![English](https://img.shields.io/badge/lang-en-blue)](./README.en.md)

# 📝 ninote.nvim

> A minimalist note plugin for Neovim, made with care — inspired by simplicity and uninterrupted writing flow.

---

## ✨ Overview

`ninote.nvim` is a note-taking plugin designed to quickly open a floating note window, allowing distraction-free editing and archiving with either automatic or custom filenames.

It’s simple and focused, yet extensible — perfect for quick drafts, daily logs, or ideas that come while coding.

---

## 📦 Key Features

- 🔐 Open a **current note** in a floating window
- 🧘‍♂️ Distraction-free experience: write and close with `q` (it auto-saves)
- 📁 Archive the note with an automatic or custom name (`:NinoteClose`)
- 🔍 Search notes:
  - by content (using `fzf-lua` or `telescope`)

---

## ⚙️ Installation (with `lazy.nvim`)

```lua
{
  "jzes/ninote.nvim",
  config = function()
    require("ninote").setup({
      NoteDir = "~/notes",          -- directory where notes are stored
      NewNoteHeader = "New Note",  -- default title for new notes
      SearchEngine = "fzf-lua",    -- or "telescope" (in the future)
      OpenSearch = "float"         -- "float" or "buffer"
    })
  end,
  dependencies = {
    { "ibhagwan/fzf-lua", optional = true },
    { "nvim-telescope/telescope.nvim", optional = true },
  },
}
```

---

## 📋 Available Commands

| Command          | Description                                                 |
|------------------|-------------------------------------------------------------|
| `:NinoteNew`     | Open (or create) the current note in a floating window      |
| `:NinoteClose`   | Archive the current note with a custom or automatic name    |
| `:NinoteSearch`  | Search notes (by content or filename, using float/buffer)   |

---

## 🔍 Note Searching

Supported engines:

- `fzf-lua` (recommended)

Configure in your setup:

- `SearchEngine = "fzf-lua"`
- `OpenSearch = "float"` — or `"buffer"`

---

## 🧠 Usage Example

```vim
:NinoteNew      " Open a new note
" write normally, then press 'q' to save and close

:NinoteClose    " Archive the note (custom or auto name)

:NinoteSearch   " Search your notes
```

---

## 📈 Roadmap (upcoming ideas)

- Support for more search backends
- Search by filename
- lualine integration (show indicator if note is open)

---

## 📼 In Action

![ninote_in_action](ninote.gif)

---

## ❤️ Credits

Created by [@jzes](https://github.com/jzes)

Spiritual co-author and technical advisor: ChatGPT

Thanks to the Neovim community 💚 — fzf-lua, telescope.nvim, Nerd Font Icons

---

## 🔖 License

MIT — use it, break it, improve it, and share it.
