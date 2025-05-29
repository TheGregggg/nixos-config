vim.g.colors_name = 'catppuccin_macchiato';

vim.o.background = 'dark';
vim.cmd('hi clear');

if vim.fn.exists('syntax_on') then
    vim.cmd('syntax reset');
end


local colors = {
    rosewater = "#F4DBD6",
    flamingo = "#F0C6C6",
    pink = "#F5BDE6",
    mauve = "#C6A0F6",
    red = "#ED8796",
    maroon = "#EE99A0",
    peach = "#F5A97F",
    yellow = "#EED49F",
    green = "#A6DA95",
    teal = "#8BD5CA",
    sky = "#91D7E3",
    sapphire = "#7DC4E4",
    blue = "#8AADF4",
    lavender = "#B7BDF8",
    text = "#CAD3F5",
    subtext1 = "#B8C0E0",
    subtext0 = "#A5ADCB",
    overlay2 = "#939AB7",
    overlay1 = "#8087A2",
    overlay0 = "#6E738D",
    surface2 = "#5B6078",
    surface1 = "#494D64",
    surface0 = "#363A4F",
    base = "#24273A",
    mantle = "#1E2030",
    crust = "#181926"
}

local function hi(group, guisp, guifg, guibg, gui, cterm)
    local cmd = ""
    if guisp ~= "" then
        cmd = cmd .. " guisp=" .. guisp
    end
    if guifg ~= "" then
        cmd = cmd .. " guifg=" .. guifg
    end
    if guibg ~= "" then
        cmd = cmd .. " guibg=" .. guibg
    end
    if gui ~= "" then
        cmd = cmd .. " gui=" .. gui
    end
    if cterm ~= "" then
        cmd = cmd .. " cterm=" .. cterm
    end
    if cmd ~= "" then
        vim.cmd("hi " .. group .. cmd)
    end
end

-- Apply highlight groups
hi("Normal", "NONE", colors.text, colors.base, "NONE", "NONE")
hi("Visual", "NONE", "NONE", colors.surface1, "bold", "bold")
hi("Conceal", "NONE", colors.overlay1, "NONE", "NONE", "NONE")
hi("ColorColumn", "NONE", "NONE", colors.surface0, "NONE", "NONE")
hi("Cursor", "NONE", colors.base, colors.text, "NONE", "NONE")
hi("lCursor", "NONE", colors.base, colors.text, "NONE", "NONE")
hi("CursorIM", "NONE", colors.base, colors.text, "NONE", "NONE")
hi("CursorColumn", "NONE", "NONE", colors.mantle, "NONE", "NONE")
hi("CursorLine", "NONE", "NONE", colors.surface0, "NONE", "NONE")
hi("Directory", "NONE", colors.blue, "NONE", "NONE", "NONE")
hi("DiffAdd", "NONE", colors.base, colors.green, "NONE", "NONE")
hi("DiffChange", "NONE", colors.base, colors.yellow, "NONE", "NONE")
hi("DiffDelete", "NONE", colors.base, colors.red, "NONE", "NONE")
hi("DiffText", "NONE", colors.base, colors.blue, "NONE", "NONE")
hi("EndOfBuffer", "NONE", "NONE", "NONE", "NONE", "NONE")
hi("ErrorMsg", "NONE", colors.red, "NONE", "bolditalic", "bold,italic")
hi("VertSplit", "NONE", colors.crust, "NONE", "NONE", "NONE")
hi("Folded", "NONE", colors.blue, colors.surface1, "NONE", "NONE")
hi("FoldColumn", "NONE", colors.overlay0, colors.base, "NONE", "NONE")
hi("SignColumn", "NONE", colors.surface1, colors.base, "NONE", "NONE")
hi("IncSearch", "NONE", colors.surface1, colors.pink, "NONE", "NONE")
hi("CursorLineNR", "NONE", colors.lavender, "NONE", "NONE", "NONE")
hi("LineNr", "NONE", colors.surface1, "NONE", "NONE", "NONE")
hi("MatchParen", "NONE", colors.peach, "NONE", "bold", "bold")
hi("ModeMsg", "NONE", colors.text, "NONE", "bold", "bold")
hi("MoreMsg", "NONE", colors.blue, "NONE", "NONE", "NONE")
hi("NonText", "NONE", colors.overlay0, "NONE", "NONE", "NONE")
hi("Pmenu", "NONE", colors.overlay2, colors.surface0, "NONE", "NONE")
hi("PmenuSel", "NONE", colors.text, colors.surface1, "bold", "bold")
hi("PmenuSbar", "NONE", "NONE", colors.surface1, "NONE", "NONE")
hi("PmenuThumb", "NONE", "NONE", colors.overlay0, "NONE", "NONE")
hi("Question", "NONE", colors.blue, "NONE", "NONE", "NONE")
hi("QuickFixLine", "NONE", "NONE", colors.surface1, "bold", "bold")
hi("Search", "NONE", colors.pink, colors.surface1, "bold", "bold")
hi("SpecialKey", "NONE", colors.subtext0, "NONE", "NONE", "NONE")
hi("SpellBad", "NONE", colors.base, colors.red, "NONE", "NONE")
hi("SpellCap", "NONE", colors.base, colors.yellow, "NONE", "NONE")
hi("SpellLocal", "NONE", colors.base, colors.blue, "NONE", "NONE")
hi("SpellRare", "NONE", colors.base, colors.green, "NONE", "NONE")
hi("StatusLine", "NONE", colors.text, colors.mantle, "NONE", "NONE")
hi("StatusLineNC", "NONE", colors.surface1, colors.mantle, "NONE", "NONE")
hi("StatusLineTerm", "NONE", colors.text, colors.mantle, "NONE", "NONE")
hi("StatusLineTermNC", "NONE", colors.surface1, colors.mantle, "NONE", "NONE")
hi("TabLine", "NONE", colors.surface1, colors.mantle, "NONE", "NONE")
hi("TabLineFill", "NONE", "NONE", colors.mantle, "NONE", "NONE")
hi("TabLineSel", "NONE", colors.green, colors.surface1, "NONE", "NONE")
hi("Title", "NONE", colors.blue, "NONE", "bold", "bold")
hi("VisualNOS", "NONE", "NONE", colors.surface1, "bold", "bold")
hi("WarningMsg", "NONE", colors.yellow, "NONE", "NONE", "NONE")
hi("WildMenu", "NONE", "NONE", colors.overlay0, "NONE", "NONE")
hi("Comment", "NONE", colors.overlay0, "NONE", "NONE", "NONE")
hi("Constant", "NONE", colors.peach, "NONE", "NONE", "NONE")
hi("Identifier", "NONE", colors.flamingo, "NONE", "NONE", "NONE")
hi("Statement", "NONE", colors.mauve, "NONE", "NONE", "NONE")
hi("PreProc", "NONE", colors.pink, "NONE", "NONE", "NONE")
hi("Type", "NONE", colors.blue, "NONE", "NONE", "NONE")
hi("Special", "NONE", colors.pink, "NONE", "NONE", "NONE")
hi("Underlined", "NONE", colors.text, colors.base, "underline", "underline")
hi("Error", "NONE", colors.red, "NONE", "NONE", "NONE")
hi("Todo", "NONE", colors.base, colors.flamingo, "bold", "bold")

hi("String", "NONE", colors.green, "NONE", "NONE", "NONE")
hi("Character", "NONE", colors.teal, "NONE", "NONE", "NONE")
hi("Number", "NONE", colors.peach, "NONE", "NONE", "NONE")
hi("Boolean", "NONE", colors.peach, "NONE", "NONE", "NONE")
hi("Float", "NONE", colors.peach, "NONE", "NONE", "NONE")
hi("Function", "NONE", colors.blue, "NONE", "NONE", "NONE")
hi("Conditional", "NONE", colors.red, "NONE", "NONE", "NONE")
hi("Repeat", "NONE", colors.red, "NONE", "NONE", "NONE")
hi("Label", "NONE", colors.peach, "NONE", "NONE", "NONE")
hi("Operator", "NONE", colors.sky, "NONE", "NONE", "NONE")
hi("Keyword", "NONE", colors.pink, "NONE", "NONE", "NONE")
hi("Include", "NONE", colors.pink, "NONE", "NONE", "NONE")
hi("StorageClass", "NONE", colors.yellow, "NONE", "NONE", "NONE")
hi("Structure", "NONE", colors.yellow, "NONE", "NONE", "NONE")
hi("Typedef", "NONE", colors.yellow, "NONE", "NONE", "NONE")
hi("debugPC", "NONE", "NONE", colors.crust, "NONE", "NONE")
hi("debugBreakpoint", "NONE", colors.overlay0, colors.base, "NONE", "NONE")

-- status line
hi("sl_git_fg","NONE", colors.surface0, "NONE", "NONE", "NONE")
hi("sl_git_bg","NONE", colors.text, colors.surface0, "NONE", "NONE")
hi("sl_vim_mode_fg","NONE", colors.lavender, colors.surface0, "bold", "bold")
hi("sl_vim_mode_bg","NONE", colors.crust, colors.lavender, "bold", "bold")

-- Link highlight groups
vim.cmd([[
    hi link Define PreProc
    hi link Macro PreProc
    hi link PreCondit PreProc
    hi link SpecialChar Special
    hi link Tag Special
    hi link Delimiter Special
    hi link SpecialComment Special
    hi link Debug Special
    hi link Exception Error
    hi link StatusLineTerm StatusLine
    hi link StatusLineTermNC StatusLineNC
    hi link Terminal Normal
    hi link Ignore Comment
]])

-- Set terminal colors
vim.g.terminal_ansi_colors = {
    colors.surface1, colors.red, colors.green, colors.yellow,
    colors.blue, colors.pink, colors.teal, colors.subtext1,
    colors.surface2, colors.red, colors.green, colors.yellow,
    colors.blue, colors.pink, colors.teal, colors.subtext0
}
