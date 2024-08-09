require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("i", "<C-e>", "<ESC>A", {desc = "Goto end line in insrt"})
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
