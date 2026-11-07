-- Cache vim.version(): on nvim 0.12 each call rebuilds api_info (~0.37 ms).
-- Workaround for https://github.com/brenoprata10/nvim-highlight-colors/issues/181
local cached_version = vim.version()
getmetatable(vim.version).__call = function()
  return setmetatable(vim.deepcopy(cached_version), getmetatable(cached_version))
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)
vim.diagnostic.config({
  virtual_text = true, -- re-enable inline diagnostic text
  underline = true,    -- keep underlines for errors/warnings
  signs = true,        -- keep sign‑column indicators
})

-- Make floating window and border backgrounds match the editor background
-- vim.api.nvim_create_autocmd("ColorScheme", {
--   pattern = "*", -- Using '*' applies this to any colorscheme you use
--   callback = function()
--     -- Link the float window background to the normal background
--     vim.api.nvim_set_hl(0, 'NormalFloat', { link = 'Normal' })
--
--     -- Optional: Link the border to the normal background for a seamless look
--     -- vim.api.nvim_set_hl(1, "FloatBorder", { link = "Float" })
--   end,
-- })

vim.opt.langmap = table.concat({
  "фa,иb,сc,вd,уe,аf,пg,рh,шi,оj,лk,дl,ьm,тn,щo,зp,йq,кr,ыs,еt,гu,мv,цw,чx,нy,яz",
  "ФA,ИB,СC,ВD,УE,АF,ПG,РH,ШI,ОJ,ЛK,ДL,ЬM,ТN,ЩO,ЗP,ЙQ,КR,ЫS,ЕT,ГU,МV,ЦW,ЧX,НY,ЯZ",
}, ",")

require("vim-settings")
require("lazy").setup("plugins")
