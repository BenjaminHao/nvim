--╭──────────────────────────────────────────────────────────────────────────╮--
--│                                                                          │--
--│  MODULE: my.helpers.icons                                                │--
--│  DETAIL: Nerdfont required                                               │--
--│  CREATE: 2024-08-08 by Benjamin Hao                                      │--
--│  UPDATE: 2024-09-13 by Benjamin Hao                                      │--
--│                                                                          │--
--╰──────────────────────────────────────────────────────────────────────────╯--
local Icons = {}

local data = {
  kind = {
    Class = "󰠱",
    Color = "󰏘",
    Constant = "󰏿",
    Constructor = "",
    Enum = "",
    EnumMember = "",
    Event = "",
    Field = "󰇽",
    File = "󰈙",
    Folder = "󰉋",
    Fragment = "",
    Function = "󰊕",
    Interface = "",
    Implementation = "",
    Keyword = "󰌋",
    Method = "󰆧",
    Module = "",
    Namespace = "󰌗",
    Number = "",
    Operator = "󰆕",
    Package = "",
    Property = "󰜢",
    Reference = "",
    Snippet = "",
    Struct = "",
    Text = "󰉿",
    TypeParameter = "󰅲",
    Undefined = "",
    Unit = "",
    Value = "󰎠",
    Variable = "",
    -- ccls-specific icons.
    TypeAlias = "",
    Parameter = "",
    StaticMethod = "",
    Macro = "",
  },
  type = {
    Array = "󰅪",
    Boolean = "",
    Null = "󰟢",
    Number = "",
    Object = "󰅩",
    String = "󰉿",
  },
  documents = {
    Default = "",
    File = "",
    Files = "",
    FileType = "󰩋",
    FileTree = "󰙅",
    Import = "",
    Symlink = "",
  },
  git = {
    Add = "",
    Branch = "",
    Diff = "",
    Git = "󰊢",
    Ignore = "",
    Mod = "M",
    Mod_alt = "",
    Remove = "",
    Rename = "",
    Repo = "",
    Unmerged = "󰘬",
    Untracked = "󰞋",
    Unstaged = "",
    Staged = "",
    Conflict = "",
  },
  ui = {
    Accepted = "",
    ArrowClosed = "",
    ArrowOpen = "",
    BookMark = "󰃃",
    Buffer = "󰓩",
    Bug = "",
    Calendar = "",
    Character = "",
    Check = "󰄳",
    Check_alt = "󰗡",
    ChevronRight = "",
    Uncheck = "",
    Uncheck_alt  = "󰄰",
    Circle = "",
    Circle_alt = "",
    Close = "󰅖",
    Close_alt = "",
    CloudDownload = "",
    CodeAction = "󰌵",
    Comment = "󰅺",
    Dashboard = "",
    DoubleSeparator = "󰄾",
    Emoji = "󰱫",
    EmptyFolder = "",
    EmptyFolderOpen = "",
    File = "󰈤",
    Fire = "",
    Folder = "",
    FolderOpen = "",
    FolderWithHeart = "󱃪",
    Gear = "",
    History = "󰄉",
    Incoming = "󰏷",
    Indicator = "",
    Keyboard = "󰌌",
    Left = "",
    List = "",
    Lock = "󰍁",
    Modified = "✥",
    Modified_alt = "",
    NewFile = "",
    Newspaper = "",
    Note = "󰍨",
    Outgoing = "󰏻",
    Package = "󰏓",
    Pencil = "󰏫",
    Perf = "󰅒",
    Play = "",
    Project = "",
    Right = "",
    RootFolderOpened = "",
    Search = "󰍉",
    Separator = "",
    SignIn = "",
    SignOut = "",
    Sort = "",
    Spell = "󰓆",
    Square = "",
    StarEmpty = "",
    StarFill = "",
    Symlink = "",
    SymlinkFolder = "",
    Table = "",
    Task = "",
    Telescope = "",
    ToggleOff = "󰨙",
    ToggleOn = "󰔡",
    Vbar = "│",
    Window = "",
  },
  diagnostics = {
    Error = "",
    Warning = "",
    Information = "",
    Question = "",
    Hint = "󰌵",
    -- Holo version
    Error_alt = "󰅚",
    Warning_alt = "󰀪",
    Information_alt = "",
    Question_alt = "",
    Hint_alt = "󰌶",
  },
  misc = {
    Campass = "󰀹",
    Code = "",
    Gavel = "",
    Glass = "󰂖",
    NoActiveLsp = "󱚧",
    PyEnv = "󰢩",
    Squirrel = "",
    Tag = "",
    Tree = "",
    Watch = "",
    Lego = "",
    LspAvailable = "󱜙",
    Add = "+",
    Added = "",
    Ghost = "󰊠",
    ManUp = "",
    Neovim = "",
    Vim = "",
    BellRing = "󰂞",
    BellSleep = "󰂠",
    Power = "",
    Config = "",
    Heart = "󰋑",
    Cmd = "",
    Terminal = "",
    KeyEsc = "󱊷",
    KeySpace = "󱁐",
    KeyEnter = "󰌑",
    KeyBackspace = "󰌍",
    KeyTab = "󰌒",
  },
  cmp = {
    Codeium = "",
    TabNine = "",
    Copilot = "",
    Copilot_alt = "",
    -- Add source-specific icons here
    buffer = "",
    cmp_tabnine = "",
    codeium = "",
    copilot = "",
    copilot_alt = "",
    latex_symbols = "",
    luasnip = "󰃐",
    nvim_lsp = "",
    nvim_lua = "",
    orgmode = "",
    path = "",
    spell = "󰓆",
    tmux = "",
    treesitter = "",
    undefined = "",
  },
  dap = {
    Breakpoint = "󰝥",
    BreakpointCondition = "󰟃",
    BreakpointRejected = "",
    LogPoint = "",
    Pause = "",
    Play = "",
    RunLast = "↻",
    StepBack = "",
    StepInto = "󰆹",
    StepOut = "󰆸",
    StepOver = "󰆷",
    Stopped = "",
    Terminate = "󰝤",
  },
}

---Get a specific icon set.
---@param category "kind"|"type"|"documents"|"git"|"ui"|"diagnostics"|"misc"|"cmp"|"dap"
---@param add_space? boolean @Add trailing space after the icon.
function Icons.get(category, add_space)
  if add_space then
    return setmetatable({}, {
      __index = function(_, key)
        return data[category][key] .. " "
      end,
    })
  else
    return data[category]
  end
end

return Icons
