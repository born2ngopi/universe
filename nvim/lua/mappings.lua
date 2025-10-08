require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- In Visual mode
vim.keymap.set("v", "<Tab>", ">gv", { desc = "Indent right (like VSCode)" })
vim.keymap.set("v", "<S-Tab>", "<gv", { desc = "Indent left (like VSCode)" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
