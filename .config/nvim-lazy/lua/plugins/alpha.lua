return {
  "goolord/alpha-nvim",
  opts = function(_, dashboard)
    require("alpha.term")
    dashboard.section.terminal.command =
      "neo --fps=30 --speed=5 -D -d 0.5 -l 1,1 --charset=ascii -m 'Wake up, Neo... Vim'"
    table.remove(dashboard.config.layout, 2)
    table.insert(dashboard.config.layout, 2, dashboard.section.terminal)
  end,
}
