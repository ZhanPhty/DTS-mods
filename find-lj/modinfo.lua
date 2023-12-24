local function loc(t)
    t.zht = t.zht or t.zh
    return t[locale] or t.en
end

local function zh_en(a, b)
    return loc({
        zh = a,
        en = b
    })
end

version = "5.2"
author = zh_en("秋一，秃妮", "Civi, Tony")
name = zh_en("超级鼹鼠帽滤镜", "Super Moggles")
changelog = zh_en([[
- 简化了部分代码。

- 修复了一个潜在的崩溃。
- 弃用UpvalueHacker以避免各种兼容性问题。
- 改用UpvalueUtil且移出scripts目录。
]], [[
- Remove some useless code.

- Fix a potential issue that might cause crash.
- Remove scripts/upvaluehacker due to compatibility issues.
- Use MODROOT/upvalueutil instead.
]])
description = zh_en("版本: ", "Version: ") .. version ..
    zh_en("\n\n更新内容:\n", "\n\nChangelog:\n") .. changelog .. "\n" ..
    zh_en("“移除鼹鼠帽滤镜和其他一些阴间滤镜.”", "\"Removes colorcubes for Moggles and Ghost Vision.\"")
-- api_version = 10
dst_compatible = true
client_only_mod = true

icon_atlas = "modicon.xml"
icon = "modicon.tex"

folder_name = folder_name or "workshop-"
if not folder_name:find("workshop-") then
    name = name .. " - DEV"
end

priority = -32768
configuration_options =
{
	{
		name = "keep_hud_ui",
		label = zh_en("保留低SAN的花纹UI", "Keep HUD UI at Low Sanity"),
		options = {
			{description = zh_en("保留", "Yes"), data = true},
			{description = zh_en("不保留", "No"), data = false}
		},
		default = true,
	},
	{
		name = "molehat_vision",
		label = zh_en("移除鼹鼠帽滤镜", "Remove Molehat Vision"),
		options = {
			{description = zh_en("移除", "Yes"), data = true},
			{description = zh_en("保留白天滤镜", "Keep during days.\n"), data = "keep_on_day"},
			{description = zh_en("不移除", "no"), data = false}
		},
		default = "keep_on_day",
	},
	{
		name = "ghost_vision",
		label = zh_en("移除灵魂滤镜", "Remove Ghost Vision"),
		options = {
			{description = zh_en("移除", "Yes"), data = true},
			{description = zh_en("不移除", "no"), data = false}
		},
		default = false,
	},
	{
		name = "insane_noise",
		label = zh_en("移除低san声音", "Remove Low-sanity Noise"),
		hover = zh_en("禁用该选项后，你需要重启游戏", "Restart game if you don't want to remove noise again."),
		options = {
			{description = zh_en("移除", "Yes"), data = true},
			{description = zh_en("不移除", "no"), data = false}
		},
		default = false,
	},
	{
		name = "lunacy_noise",
		label = zh_en("移除月岛高启蒙声音", "Remove Lunacy Noise"),
		hover = zh_en("禁用该选项后，你需要重启游戏", "Restart game if you don't want to remove noise again."),
		options = {
			{description = zh_en("移除", "Yes"), data = true},
			{description = zh_en("不移除", "no"), data = false}
		},
		default = false,
	},
	{
		name = "autumn_cc_only",
		label = zh_en("季节滤镜全局为秋季", "Autumn CC Only"),
		options = {
			{description = zh_en("开启", "Yes"), data = true},
			{description = zh_en("关闭", "no"), data = false}
		},
		default = false,
	},
}