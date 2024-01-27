local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local b = null_ls.builtins

local sources = {

  -- webdev stuff
  b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
  b.formatting.prettier.with { filetypes = { "html", "markdown", "css" } }, -- so prettier works only on these filetypes

  -- Lua
  b.formatting.stylua,

  -- cpp
  b.formatting.clang_format,

  -- rust
  b.formatting.rustfmt.with({
    extra_args = { "--edition=2021" },
  }),

  -- go
  b.formatting.gofmt,

  -- haskell
  b.formatting.fourmolu,
}

null_ls.setup {
  debug = true,
  sources = sources,
}
