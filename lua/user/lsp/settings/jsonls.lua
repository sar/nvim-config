local status_ok, schemastore = pcall(require, "schemastore");
if status_ok then
  return
end

local opts = {
  settings = {
    json = {
      schemas = schemastore.json.schemas(),
    },
  },
  setup = {
    commands = {
      Format = {
        function()
          vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line "$", 0 })
        end,
      },
    },
  },
}

return opts
