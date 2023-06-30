local dap = require("dap")
local dbgs_path = vim.fn.stdpath("config") .. "/lua/plugins/configs/daps/debuggers/"

local function load(filename)
    local dbg = require("plugins.configs.daps.debuggers." .. filename)
    if type(dbg) == "table" then
        local adapter = dbg.dap_info["name_adapter"]
        local langs   = dbg.dap_info["name_configuration"]
        dap.adapters[adapter] = dbg.config["adapters"]
        if type(langs) == "table" then
            for _, lang in pairs(langs) do
                dap.configurations[lang] = dbg.config["configurations"]
            end
        else dap.configurations[langs] = dbg.config["configurations"]
        end
    end
end

local pfile = io.popen('ls "' .. dbgs_path .. '"')
if pfile ~= nil then
    for filename in pfile:lines() do
        filename = filename:match("[^.]+")
        if filename ~= nil then
            load(filename)
        end
    end
    pfile:close()
end
