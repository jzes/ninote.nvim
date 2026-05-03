![ninote](https://github.com/user-attachments/assets/c00ab8b8-82bf-4c0f-9337-4e7530e75ea1)

[![English](https://img.shields.io/badge/lang-en-blue)](./README_en.md)
[![Português](https://img.shields.io/badge/lang-pt--BR-green)](./README.md)

![Lua](https://img.shields.io/badge/Lua-5.1%20--%205.4-blue?logo=lua)
![Neovim](https://img.shields.io/badge/Neovim-0.9%2B-57A143?logo=neovim)
![Plugin](https://img.shields.io/badge/Plugin-Type--nvim-905)
![License](https://img.shields.io/github/license/jzes/ninote.nvim)

# 📝 ninote.nvim

> Um plugin minimalista de notas para o Neovim, feito com carinho — inspirado por simplicidade e fluxo contínuo de escrita.

---

## ✨ Visão geral

O `ninote.nvim` é um plugin de notas projetado para abrir uma nota flutuante rapidamente, permitir editar sem distrações e arquivar suas anotações com nomes automáticos ou definidos por você.

Ele é simples, direto, mas extensível — ideal para rascunhos rápidos, registros diários ou ideias durante o código.

---

## 📦 Principais funcionalidades

- 🔐 Abrir uma **nota atual** numa janela flutuante
- 🧘‍♂️ Experiência sem distrações: escreve e fecha com `q` (salvando)
- 📁 Arquivar nota com nome automático ou personalizado (`NinoteClose`)
- 🔍 Buscar por notas:
  - pelo conteúdo (com `fzf-lua` ou `telescope`)

---

## ⚙️ Instalação (com `lazy.nvim`)

```lua
{
  "jzes/ninote.nvim",
  config = function()
    require("ninote").setup({
      note_dir = "~/notas",         -- diretório onde as notas serão salvas
      new_note_header = "Nova nota", -- título padrão de cada nota
      search_engine = "fzf-lua",    -- futuramente "telescope"
      open_search = "float"         -- "float" ou "buffer"
    })
  end,
  dependencies = {
    { "ibhagwan/fzf-lua", optional = true },
    { "nvim-telescope/telescope.nvim", optional = true },
  },
}
```

## 📋 Comandos disponíveis

| Comando        | Descrição                                          |
| -------------- | -------------------------------------------------- |
| :Ninote new    | Abre (ou cria) a nota atual em modo flutuante      |
| :Ninote close  | Arquiva a nota atual com nome automático ou custom |
| :Ninote search | Busca notas (conteúdo ou nome, com float/buffer)   |

## 🔍 Busca de notas

Suporte a engines:

- fzf-lua (recomendado)

Configure em:

- search_engine = "fzf-lua",
- open_search = "float", -- ou "buffer"

## 🧠 Exemplo de uso

-- Abrir nova nota
:Ninote new

-- Escrever livremente, fechar com 'q' (salvando)

-- Arquivar a nota (com nome customizado ou automático)
:Ninote close

-- Buscar entre notas
:Ninote search

## 📈 Roadmap (ideias futuras)

- Integração com mais buscadores
- Buscar por nome do arquivo
- Permitir integração com lualine para indicador de nota aberta

## ❤️ Créditos

Desenvolvido por @jzes

Coautor espiritual e conselheiro técnico: ChatGPT

Nerd Font Icons, fzf-lua, telescope.nvim — comunidade Neovim 💚

## 🔖 Licença

MIT — use, quebre, melhore e compartilhe.
