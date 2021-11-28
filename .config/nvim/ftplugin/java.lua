local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

local workspace_dir = '/path/to/workspace-root/' .. project_name

local config = {
    cmd = {
	'java',
	'-Declipse.application=org.eclipse.jdt.ls.core.id1',
	'-Dosgi.bundles.defaultStartLevel=4',
	'-Declipse.product=org.eclipse.jdt.ls.core.product',
	'-Dlog.protocol=true',
	'-Dlog.level=ALL',
	'-Xms1g',
	'-Xmx2G',
	'--add-modules=ALL-SYSTEM',
	'--add-opens', 'java.base/java.util=ALL-UNNAMED',
	'--add-opens', 'java.base/java.lang=ALL-UNNAMED',
	'-jar', '$JDTLS_HOME/plugins/org.eclipse.equinox.launcher_*.jar',
	'-configuration', 'config_linux',
	'-data', workspace_dir
    },
    root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'})
}

require('jdtls').start_or_attach(config)


