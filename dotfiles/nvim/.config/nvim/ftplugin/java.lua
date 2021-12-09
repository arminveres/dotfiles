--[[
-- This is a custom lsp config for java, as it can't be started the same way
-- as other lsp can.
--]]

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- If you started neovim within `~/dev/xy/project-1` this would resolve to `project-1`
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.fn.expand('~/.cache/jdtls-workspace/') .. project_name

local config = {
    cmd = {
        'java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        -- 'noverify',
        '-Dlog.level=ALL',
        '-Xms1g',
        -- '-Xmx2G',
        -- '--add-modules=ALL-SYSTEM',
        -- '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        -- '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        '-jar', vim.fn.expand('$JDTLS_HOME/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar'),
        '-configuration', vim.fn.expand('$JDTLS_HOME/config_linux'),
        '-data', workspace_dir
    },
    settings = {
        java = {}
    },
    root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),
    capabilities = capabilities
}
require('jdtls').start_or_attach(config)


