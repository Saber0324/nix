return {
    "saghen/blink.cmp",
    opts = {
        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
            providers = {
                snippets = {
                    opts = {
                        search_paths = { vim.fn.stdpath("config") .. "/snippets" },
                    },
                },
            },
        },
        snippets = {
            preset = "default",
        },
    },
}
