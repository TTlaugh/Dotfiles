local M = {}

--[[
[1]  onedark
[2]  tokyonight
[3]  tokyonight-moon
[4]  tokyonight-storm
[5]  tokyonight-night
[6]  tokyonight-day
[7]  catppuccin
[8]  catppuccin-mocha
[9]  catppuccin-latte
[10] catppuccin-frappe
[11] catppuccin-macchiato
]]
function M.colorscheme(name_or_index)
    local colorscheme = vim.cmd.colorscheme

    if (name_or_index == 1 or name_or_index == "onedark") then
        local onedark_style = { "dark", "darker", "cool", "deep", "warm", "warmer", "light" }

        local ok, onedark = pcall(require, "onedark")
        if ok then
            onedark.setup({ style = onedark_style[4] })
            onedark.load()
        end
    elseif (name_or_index == 2 or name_or_index == "tokyonight") then
        colorscheme "tokyonight"
    elseif (name_or_index == 3 or name_or_index == "tokyonight-moon") then
        colorscheme "tokyonight-moon"
    elseif (name_or_index == 4 or name_or_index == "tokyonight-storm") then
        colorscheme "tokyonight-storm"
    elseif (name_or_index == 5 or name_or_index == "tokyonight-night") then
        colorscheme "tokyonight-night"
    elseif (name_or_index == 6 or name_or_index == "tokyonight-day") then
        colorscheme "tokyonight-day"
    elseif (name_or_index == 7 or name_or_index == "catppuccin") then
        colorscheme "catppuccin"
    elseif (name_or_index == 8 or name_or_index == "catppuccin-mocha") then
        colorscheme "catppuccin-mocha"
    elseif (name_or_index == 9 or name_or_index == "catppuccin-latte") then
        colorscheme "catppuccin-latte"
    elseif (name_or_index == 10 or name_or_index == "catppuccin-frappe") then
        colorscheme "catppuccin-frappe"
    elseif (name_or_index == 11 or name_or_index == "catppuccin-macchiato") then
        colorscheme "catppuccin-macchiato"
    else
        print("Can't load third party colorscheme!")
        print("Use nvim's builtin colorscheme: 'habamax'")
        colorscheme "habamax"
    end
end

return M
