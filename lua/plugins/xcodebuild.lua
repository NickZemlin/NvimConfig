if vim.uv.os_uname().sysname ~= "Darwin" then
    return
end

require("xcodebuild").setup({
    project_manager = {
        guess_target = false,
        should_update_project = function(_)
            return false
        end,
    },
    integrations = {
        xcode_build_server = {
            enabled = true,
            guess_scheme = false,
        },
        neo_tree = {
            enabled = false,
        },
    },
})

local xcode_build_server = require("xcodebuild.integrations.xcode-build-server")
local project_config = require("xcodebuild.project.config")
local util = require("xcodebuild.util")

local function notify(message, level)
    vim.schedule(function()
        vim.notify(message, level or vim.log.levels.INFO)
    end)
end

local function normalize_build_server_json(path)
    if not path or vim.fn.filereadable(path) == 0 then
        return
    end

    local ok, data = pcall(vim.fn.json_decode, table.concat(vim.fn.readfile(path), "\n"))
    if not ok or type(data) ~= "table" then
        return
    end

    data.argv = { "/usr/bin/python3", "/opt/homebrew/bin/xcode-build-server" }
    vim.fn.writefile(vim.split(vim.fn.json_encode(data), "\n"), path)
end

function xcode_build_server.run_config(project_file, scheme)
    local working_directory = project_config.settings.workingDirectory or vim.fn.getcwd()
    local build_server_json = working_directory .. "/buildServer.json"
    local command = {
        "/usr/bin/python3",
        "/opt/homebrew/bin/xcode-build-server",
        "config",
        util.has_suffix(project_file, "xcodeproj") and "-project" or "-workspace",
        project_file,
        "-scheme",
        scheme,
    }

    notify("Updating buildServer.json for scheme: " .. scheme)

    return vim.fn.jobstart(command, {
        cwd = working_directory,
        on_exit = function(_, code)
            if code == 0 then
                normalize_build_server_json(build_server_json)
                notify("Updated " .. build_server_json)
                require("xcodebuild.integrations.lsp").restart_sourcekit_lsp()
            else
                notify("Failed to update buildServer.json", vim.log.levels.ERROR)
            end
        end,
    })
end

function xcode_build_server.run_config_if_enabled(scheme)
    if not xcode_build_server.is_enabled() or vim.fn.executable("/opt/homebrew/bin/xcode-build-server") == 0 then
        return
    end

    local project_file = project_config.settings.projectFile
    local project_scheme = scheme or project_config.settings.scheme

    if project_file and project_scheme then
        xcode_build_server.run_config(project_file, project_scheme)
    end
end

vim.api.nvim_create_user_command("XcodebuildUpdateBuildServer", function()
    xcode_build_server.run_config_if_enabled()
end, { desc = "Regenerate buildServer.json for the current Xcode project" })

vim.keymap.set("n", "<leader>xca", "<cmd>XcodebuildPicker<cr>", { desc = "Xcodebuild Actions" })
vim.keymap.set("n", "<leader>xcm", "<cmd>XcodebuildProjectManager<cr>", { desc = "Xcode Project Manager" })
vim.keymap.set("n", "<leader>xcu", "<cmd>XcodebuildUpdateBuildServer<cr>", { desc = "Xcode Update Build Server" })
vim.keymap.set("n", "<leader>xcS", "<cmd>XcodebuildUpdateBuildServer<cr>", { desc = "Xcode Update Build Server" })

vim.keymap.set("n", "<leader>xcb", "<cmd>XcodebuildBuild<cr>", { desc = "Xcode Build" })
vim.keymap.set("n", "<leader>xcB", "<cmd>XcodebuildBuildForTesting<cr>", { desc = "Xcode Build For Testing" })
vim.keymap.set("n", "<leader>xcr", "<cmd>XcodebuildBuildRun<cr>", { desc = "Xcode Build & Run" })

vim.keymap.set("n", "<leader>xct", "<cmd>XcodebuildTest<cr>", { desc = "Xcode Test" })
vim.keymap.set("v", "<leader>xct", "<cmd>XcodebuildTestSelected<cr>", { desc = "Xcode Test Selected" })
vim.keymap.set("n", "<leader>xcT", "<cmd>XcodebuildTestClass<cr>", { desc = "Xcode Test Class" })
vim.keymap.set("n", "<leader>xc.", "<cmd>XcodebuildTestRepeat<cr>", { desc = "Xcode Repeat Test" })

vim.keymap.set("n", "<leader>xcl", "<cmd>XcodebuildToggleLogs<cr>", { desc = "Xcode Logs" })
vim.keymap.set("n", "<leader>xcc", "<cmd>XcodebuildToggleCodeCoverage<cr>", { desc = "Xcode Code Coverage" })
vim.keymap.set("n", "<leader>xcC", "<cmd>XcodebuildShowCodeCoverageReport<cr>", { desc = "Xcode Coverage Report" })
vim.keymap.set("n", "<leader>xce", "<cmd>XcodebuildTestExplorerToggle<cr>", { desc = "Xcode Test Explorer" })
vim.keymap.set("n", "<leader>xcs", "<cmd>XcodebuildFailingSnapshots<cr>", { desc = "Xcode Failing Snapshots" })

vim.keymap.set("n", "<leader>xcp", "<cmd>XcodebuildPreviewGenerateAndShow<cr>", { desc = "Xcode Generate Preview" })
vim.keymap.set("n", "<leader>xcP", "<cmd>XcodebuildPreviewToggle<cr>", { desc = "Xcode Preview" })

vim.keymap.set("n", "<leader>xcd", "<cmd>XcodebuildSelectDevice<cr>", { desc = "Xcode Select Device" })
vim.keymap.set("n", "<leader>xcq", "<cmd>Telescope quickfix<cr>", { desc = "Xcode Quickfix List" })

vim.keymap.set("n", "<leader>xcx", "<cmd>XcodebuildQuickfixLine<cr>", { desc = "Xcode Quickfix Line" })
vim.keymap.set("n", "<leader>xcA", "<cmd>XcodebuildCodeActions<cr>", { desc = "Xcode Code Actions" })
