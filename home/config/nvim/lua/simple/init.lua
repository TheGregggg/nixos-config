require("simple.colors")


vim.opt.path:append('**');
-- Display all matching files when we tab complete
vim.o.wildmenu = true;
vim.o.cursorline = true;
vim.o.termguicolors = true 
vim.o.cmdheight = 0; -- command only visible when typing

vim.cmd.syntax("enable");
vim.cmd.filetype({"plugin", "on"});

vim.wo.number = true;
vim.wo.relativenumber = true;


vim.g.netrw_banner = 0; -- disable annoying banner
vim.g.netrw_browse_split = 4;  -- open in prior window
vim.g.netrw_altv = 1;          -- open splits to the right
vim.g.netrw_liststyle = 3;     -- tree view
vim.g.netrw_winsize = 80;
-- let g:netrw_list_hide=netrw_gitignore#Hide()
-- let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

local function get_git_branch()
    local branch = vim.fn.system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
    if string.len(branch) > 0 then
        return branch
    else
        return ":"
    end
end

local modes = {
  ['n']      = 'NORMAL',
  ['no']     = 'O-PENDING',
  ['nov']    = 'O-PENDING',
  ['noV']    = 'O-PENDING',
  ['no\22'] = 'O-PENDING',
  ['niI']    = 'NORMAL',
  ['niR']    = 'NORMAL',
  ['niV']    = 'NORMAL',
  ['nt']     = 'NORMAL',
  ['ntT']    = 'NORMAL',
  ['v']      = 'VISUAL',
  ['vs']     = 'VISUAL',
  ['V']      = 'V-LINE',
  ['Vs']     = 'V-LINE',
  ['\22']   = 'V-BLOCK',
  ['\22s']  = 'V-BLOCK',
  ['s']      = 'SELECT',
  ['S']      = 'S-LINE',
  ['\19']   = 'S-BLOCK',
  ['i']      = 'INSERT',
  ['ic']     = 'INSERT',
  ['ix']     = 'INSERT',
  ['R']      = 'REPLACE',
  ['Rc']     = 'REPLACE',
  ['Rx']     = 'REPLACE',
  ['Rv']     = 'V-REPLACE',
  ['Rvc']    = 'V-REPLACE',
  ['Rvx']    = 'V-REPLACE',
  ['c']      = 'COMMAND',
  ['cv']     = 'EX',
  ['ce']     = 'EX',
  ['r']      = 'REPLACE',
  ['rm']     = 'MORE',
  ['r?']     = 'CONFIRM',
  ['!']      = 'SHELL',
  ['t']      = 'TERMINAL',
}
local function get_mode()
  local current_mode = vim.api.nvim_get_mode().mode
  if modes[current_mode] == nil then
    return current_mode
  end
  return modes[current_mode]
end

local function sl_git_branch()
    return string.format(
    "%s  %s %s",
        "%#sl_git_bg#",
        get_git_branch(),
        "%#sl_git_fg#"
    )
end

local function sl_mode()
    return string.format(
    "%s  %s %s",
        "%#sl_vim_mode_bg#",
        get_mode(),
        "%#sl_vim_mode_fg#"
    )
end

local function sl_percentage_line_col()
    return string.format(
    "%s %s:%s",
        "%p%%",
        "%l",
        "%c"
    )
end

function _G.statusline()
    
    local set_color_2 = "%#LineNr#"
    local file_name = " %f"
    local flags = "%h%w%m%r"
    local separator = "%="
    local fileencoding = " %{&fileencoding?&fileencoding:&encoding}"
    local fileformat = " [%{&fileformat}]"
    local filetype = " %y"

    return string.format(
        "%s%s%s %s%s%s%s%s%s%s",
        sl_mode(),
        sl_git_branch(),
        set_color_2,
        sl_percentage_line_col(),
        file_name,
        flags,
        separator,
        filetype,
        fileencoding,
        fileformat        
    )
end

vim.o.statusline = "%{%v:lua._G.statusline()%}"
