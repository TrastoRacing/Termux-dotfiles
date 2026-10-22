return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      -- En Termux, las herramientas ya se instalan de forma nativa vía pkg y npm -g.
      -- Filtramos cualquier paquete que ya esté presente en $PATH para evitar descargas innecesarias.
      opts.ensure_installed = vim.tbl_filter(function(tool)
        return vim.fn.executable(tool) == 0
      end, opts.ensure_installed or {})
    end,
  },
}
