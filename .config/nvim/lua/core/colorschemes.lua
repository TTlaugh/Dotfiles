local M = {}

--[[ habamax is default colorscheme
[1]  tokyonight
[2]  tokyonight-moon
[3]  tokyonight-storm
[4]  tokyonight-night
[5]  tokyonight-day
]]
function M.colorscheme(name_or_index)
    local colorscheme = vim.cmd.colorscheme

    if (name_or_index == 1 or name_or_index == "tokyonight") then
        colorscheme "tokyonight"
    elseif (name_or_index == 2 or name_or_index == "tokyonight-moon") then
        colorscheme "tokyonight-moon"
    elseif (name_or_index == 3 or name_or_index == "tokyonight-storm") then
        colorscheme "tokyonight-storm"
    elseif (name_or_index == 4 or name_or_index == "tokyonight-night") then
        colorscheme "tokyonight-night"
    elseif (name_or_index == 5 or name_or_index == "tokyonight-day") then
        colorscheme "tokyonight-day"
    else
        vim.notify("Can't load third party colorscheme! Use nvim's builtin colorscheme: 'habamax'", vim.log.levels.INFO)
        colorscheme "habamax"
    end
end

return M
