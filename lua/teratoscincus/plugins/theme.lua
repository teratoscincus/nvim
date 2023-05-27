local colorscheme = require("teratoscincus.config").colorscheme
return {
  require("teratoscincus.plugins.themes." .. colorscheme),
}
