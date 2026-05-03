![ninote](https://github.com/user-attachments/assets/c00ab8b8-82bf-4c0f-9337-4e7530e75ea1)

[![English](https://img.shields.io/badge/lang-en-blue)](./README_en.md)
[![Português](https://img.shields.io/badge/lang-pt--BR-green)](./README.md)

![Lua](https://img.shields.io/badge/Lua-5.1%20--%205.4-blue?logo=lua)
![Neovim](https://img.shields.io/badge/Neovim-0.9%2B-57A143?logo=neovim)
![Plugin](https://img.shields.io/badge/Plugin-Type--nvim-905)
![License](https://img.shields.io/github/license/jzes/ninote.nvim)

# 📝 ninote.nvim

> A minimalist note-taking plugin for Neovim, crafted with care — inspired by simplicity and a continuous writing flow.

---

## ✨ Overview

`ninote.nvim` is a note-taking plugin designed to quickly open a floating note, let you write without distractions, and archive your notes with automatic or custom names.

It’s simple, straightforward, yet extensible — ideal for quick drafts, daily logs, or ideas while coding.

---

## 📦 Main Features

- 🔐 Open the **current note** in a floating window
- 🧘‍♂️ Distraction-free experience: write and close with `q` (auto-save)
- 📁 Archive notes with automatic or custom names (`NinoteClose`)
- 🔍 Search notes:
  - by content (using `fzf-lua` or `telescope`)

---

## ⚙️ Installation (with `lazy.nvim`)

```lua
{
  "jzes/ninote.nvim",
  config = function()
    require("ninote").setup({
      note_dir = "~/notes",          -- directory where notes are stored
      new_note_header = "New note",  -- default note title
      search_engine = "fzf-lua",     -- future: "telescope"
      open_search = "float"          -- "float" or "buffer"
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

| Command        | Description                                          |
| -------------- | ---------------------------------------------------- |
| :Ninote new    | Open (or create) the current note in a floating view |
| :Ninote close  | Archive the current note with auto/custom name       |
| :Ninote search | Search notes (content or name, float/buffer)         |

---

## 🔍 Note Search

Supported engines:

- fzf-lua (recommended)

Configuration:

- `search_engine = "fzf-lua"`
- `open_search = "float"` -- or `"buffer"`

---

## 🧠 Usage Example

```vim
" Open a new note
:Ninote new

" Write freely, then press 'q' to close (auto-save)

" Archive the note (custom or automatic name)
:Ninote close

" Search through notes
:Ninote search
```

---

## 📈 Roadmap (future ideas)

- Integration with more search engines
- Search by file name
- Integration with lualine for active note indicator

---

## ❤️ Credits

Developed by @jzes

Spiritual co-author and technical advisor: ChatGPT

Nerd Font Icons, fzf-lua, telescope.nvim — Neovim community 💚

---

## 🔖 License

MIT — use it, break it, improve it, and share it.
