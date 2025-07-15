local jdtls_dir = vim.fn.stdpath('data') .. '/mason/packages/jdtls'
local config_dir = jdtls_dir .. '/config_linux'
local plugin_dir = jdtls_dir .. '/plugins/'
local path_to_jar = plugin_dir .. 'org.eclipse.equinox.launcher_1.7.0.v20250331-1702.jar'
local path_to_lombok = jdtls_dir .. '/lombok.jar'

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.fn.stdpath('data') .. '/site/java/workspace-root/'..project_name
os.execute("mkdir "..workspace_dir)

-- main config
local config = {
  --cmd = {vim.fn.expand('~/.local/share/nvim/mason/bin/jdtls')},
  cmd = {
    '/usr/lib/jvm/java-21-openjdk-amd64/bin/java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-javaagent:' .. path_to_lombok,
    '-Xms1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

    '-jar', path_to_jar,
    '-configuration', config_dir,
    '-data', workspace_dir,
  },
  root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw', 'build.gradlew'}, { upward = true })[1]),
  settings = {
    format = {
      enabled = true,
      settings = {
        url = vim.fn.stdpath "config" .. "/lang-servers/intellij-java-google-style.xml",
        profile = "GoogleStyle",
      },
    }
  }
}
require('jdtls').start_or_attach(config)
