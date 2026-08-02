local is_macos = vim.uv.os_uname().sysname == "Darwin"
local cmd

if is_macos then
    if vim.fn.executable("xcrun") == 0 then
        return
    end

    cmd = { "xcrun", "sourcekit-lsp" }
else
    if vim.fn.executable("sourcekit-lsp") == 0 then
        return
    end

    cmd = { "sourcekit-lsp" }
end

local scratch_path = vim.fn.stdpath("cache") .. "/sourcekit-lsp"
vim.fn.mkdir(scratch_path, "p")
vim.list_extend(cmd, { "--scratch-path", scratch_path })

local root_markers = {
    "buildServer.json",
    ".bsp",
    "Package.swift",
    "*.xcodeproj",
    "*.xcworkspace",
    "compile_commands.json",
}

local marker_priority = {
    ["buildServer.json"] = 1,
    [".bsp"] = 1,
    ["Package.swift"] = 2,
    ["*.xcodeproj"] = 3,
    ["*.xcworkspace"] = 3,
    ["compile_commands.json"] = 4,
}

local function matches_marker(name, marker)
    if marker == "*.xcodeproj" then
        return vim.endswith(name, ".xcodeproj")
    end

    if marker == "*.xcworkspace" then
        return vim.endswith(name, ".xcworkspace")
    end

    return name == marker
end

local function marker_root(filename, marker)
    local marker_path = vim.fs.find(function(name)
        return matches_marker(name, marker)
    end, { path = filename, upward = true })[1]
    return marker_path and vim.fs.dirname(marker_path) or nil
end

local function project_root(filename)
    local best_root
    local best_priority

    for _, marker in ipairs(root_markers) do
        local root = marker_root(filename, marker)
        if root then
            local priority = marker_priority[marker]
            if not best_root or #root > #best_root or (#root == #best_root and priority < best_priority) then
                best_root = root
                best_priority = priority
            end
        end
    end

    return best_root or vim.fs.dirname(vim.fs.find(".git", { path = filename, upward = true })[1])
end

vim.lsp.config("sourcekit", {
    cmd = cmd,
    root_dir = function(bufnr, on_dir)
        local filename = vim.api.nvim_buf_get_name(bufnr)
        on_dir(project_root(filename))
    end,
})
vim.lsp.enable("sourcekit")
