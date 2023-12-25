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

version = "1.1.1"
author = zh_en("a", "a")
name = zh_en("Moggles", "Moggles")
changelog = zh_en([[
	Moggles
]], [[
	Moggles
]])
description = zh_en("版本: ", "Version: ") .. version ..
    zh_en("Moggles", "Moggles")
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