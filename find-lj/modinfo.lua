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

version = "1.2.0"
author = "zhanphty"
name = zh_en("美颜", "Beauty filter")
description = zh_en([[
1. 鼹鼠帽
2. 亮茄头盔
3. 启迪之冠
]], [[
1. Moggles
2. Brightshade Helm
3. Enlightened Crown
]])

--兼容性
api_version = 10
all_clients_require_mod = false
client_only_mod = true
dst_compatible = true

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
		name = "molehat_vision",
		label = zh_en("移除鼹鼠帽滤镜", "Remove Molehat Vision"),
		options = {
			{description = zh_en("移除", "Yes"), data = true},
			{description = zh_en("保留白天滤镜", "Keep during days"), data = "keep_on_day"},
			{description = zh_en("不移除", "no"), data = false}
		},
		default = "keep_on_day",
	},
	{
		name = "goggle_sover",
		label = zh_en("移除头盔类暗角特效(亮茄头盔、沙漠护目镜等)", "Remove helmet-related vignetting effects(Brightshade Helm/Desert Goggles)"),
		options = {
			{description = zh_en("移除", "Yes"), data = 1},
			{description = zh_en("保留", "No"), data = 0},
		},
		default = 0,
	},
	{
		name = "remove_enlightened",
		label = zh_en("移除启蒙滤镜", "Remove enlightenment filter"),
		options = {
			{description = zh_en("不移除", "No"), data = 0, hover = zh_en("保持原版的满启蒙视觉效果", "Preserve the original, fully illuminated visual effects")},
			{description = zh_en("仅移除滤镜", "Remove filter only"), data = 1, hover = zh_en("移除蓝色滤镜，但保留白色晕影", "Remove the blue filter, but keep the white halo")},
			{description = zh_en("移除滤镜和晕影", "Remove All"), data = 2, hover = zh_en("移除所有启蒙视觉效果", "Remove All")}
		},
		default = 1,
	},
	{
		name = "lunacy_enlightened_sound",
		label = zh_en("启蒙音效模式", "Enlightenment Sound Mode"),
		options = {
			{description = zh_en("保留所有启蒙音效", "Keep all Sound"), data = 1},
			{description = zh_en("仅移除循环音效", "Remove only the looping sound effect"), data = 2},
			{description = zh_en("移除所有启蒙音效", "Remove all Sound"), data = 3}
		},
		default = 2,
	}
}