-- if true then return end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Set up custom filetypes
-- vim.filetype.add {
--   extension = {
--     foo = "fooscript",
--   },
--   filename = {
--     ["Foofile"] = "fooscript",
--   },
--   pattern = {
--     ["~/%.config/foo/.*"] = "fooscript",
--   },
-- }
--
-- Additional configurations
vim.opt.scrolloff = 10
vim.opt.textwidth = 0
vim.opt.wrapmargin = 0
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.textwidth = 80
vim.opt.formatoptions = vim.opt.formatoptions + "t"
vim.opt.clipboard = ""
vim.opt.relativenumber = true

-- Remap j and k to gj and gk
vim.api.nvim_set_keymap("n", "j", "gj", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "k", "gk", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "j", "gj", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "k", "gk", { noremap = true, silent = true })

-- fixing the signcolumn
vim.opt.signcolumn = "yes"

-- preserve code folds
vim.api.nvim_create_autocmd({ "BufWinLeave" }, {
  pattern = { "*.*" },
  desc = "save view (folds), when closing file",
  command = "mkview",
})
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  pattern = { "*.*" },
  desc = "load view (folds), when opening file",
  command = "silent! loadview",
})

-- press alt + number to go to a particular tab
for i = 1, 9, 1 do
  vim.keymap.set("n", string.format("<A-%s>", i), function() vim.api.nvim_set_current_buf(vim.t.bufs[i]) end)
end

-- restore cursor position when file is opened
local autocmd = vim.api.nvim_create_autocmd

autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local line = vim.fn.line "'\""
    if
      line > 1
      and line <= vim.fn.line "$"
      and vim.bo.filetype ~= "commit"
      and vim.fn.index({ "xxd", "gitrebase" }, vim.bo.filetype) == -1
    then
      vim.cmd 'normal! g`"'
    end
  end,
})

-- dismiss notifications
vim.api.nvim_set_keymap("", "<leader>dn", ':lua require("notify").dismiss()<CR>', { noremap = true, silent = true })
