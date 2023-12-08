local function e_or_z(en, zh)
	return (locale == "zh" or locale == "zhr" or locale == "zht") and zh or en
end

name = e_or_z("Save And Load", "读档和存档")

description = e_or_z([[
* Archiving and reading functions, shortcut keys can be replaced;
* To prevent misoperation, you need to add the Ctrl key combination to read files;
* Save Archive (default: F6);
* Load Archive (default: Ctrl + F7);
]],
 [[
* 存档、读档功能，可更换快捷键
* 防止误操作，读档是需要额外加Ctrl组合键
* Save存档（默认: F6）
* Load读档（默认: Ctrl + F7）
]]
)

author = "zhanphty"
version = "1.2.1"
forumthread = ""
api_version = 10

--兼容性
all_clients_require_mod = false
client_only_mod = true
dst_compatible = true

icon = "Modicon.tex"
icon_atlas = "Modicon.xml"

local alpha = {"F1", "F2", "F3", "F4", "F5", "F6", "F7", "F8", "F9", "F10", "F11", "F12"}
local KEY_A = 282
local keyslist = {}
for i = 1,#alpha do keyslist[i] = {description = alpha[i],data = i + KEY_A - 1} end

configuration_options =
{
    {
        name = "keyboard_save",
        label = e_or_z("Save Archive", "存档"),
		hover = e_or_z("Save Archive (default: F6)", "存档(默认: F6）"),
        options = keyslist,
        default = 287,
    },
    {
        name = "keyboard_load",
        label = e_or_z("Load Archive", "读档"),
		hover = e_or_z("Load Archive (default: Ctrl + F7)", "存档(默认: Ctrl + F7）)"),
        options = keyslist,
        default = 288,
    },
}
