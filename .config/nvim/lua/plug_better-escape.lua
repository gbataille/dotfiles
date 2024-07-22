esc_and_clean_empty = function()
    vim.api.nvim_input("<esc>")
    local current_line = vim.api.nvim_get_current_line()
    if current_line:match("^%s+j$") then
        vim.api.nvim_set_current_line("")
    end
end

require("better_escape").setup {
    timeout = vim.o.timeoutlen, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
    mappings = {
        i = {
            j = {
                -- These can all also be functions
                k = esc_and_clean_empty,
                j = esc_and_clean_empty,
            },
        },
        c = {
            j = {
                k = esc_and_clean_empty,
                j = esc_and_clean_empty,
            },
        },
        t = {
            j = {
                k = esc_and_clean_empty,
                j = esc_and_clean_empty,
            },
        },
        v = {
            j = {
                k = esc_and_clean_empty,
            },
        },
        s = {
            j = {
                k = esc_and_clean_empty,
            },
        },
    },
}
