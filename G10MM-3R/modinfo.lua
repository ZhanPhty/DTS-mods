local function e_or_z(en, zh)
	return (locale == "zh" or locale == "zhr" or locale == "zht") and zh or en
end

name = e_or_z("G10MM-3R-zh", "G10MM-3R-汉化(仅自用)")
description = e_or_z("Automate gathering resources! Eng&Chi", "自动采集资源机器人-汉化(仅自用)\n支持简中、英文")
author = "<default>, oblivioncth"
version = "1.35.11"

forumthread = "https://steamcommunity.com/sharedfiles/filedetails/?id=1628298090"

api_version_dst = 0xa

dst_compatible = true
dont_starve_compatible = false
reign_of_giants_compatible = false
all_clients_require_mod = true

icon_atlas = "modicon.xml"
icon = "modicon.tex"

server_filter_tags = {
"robobee", "robot glommer", "g10mm-3R","creature"
}

--priority = 257
id = "robobeemod"

configuration_options = {
	{
		name = "robobeestatuerecipeconfig",
		label = e_or_z("G10MM-3R Base Recipe", "制作配方"),
		options =
		{
			{description = e_or_z("Easy", "简单"), hover = e_or_z("1 Gears + 1 Glommer's Flower + 1 Glommer's Wings", "齿轮*1 + 格罗姆之花*1 + 格罗姆之翼*1"), data = 1},
			{description = e_or_z("Default", "默认"), hover = e_or_z("2 Gears + 1 Glommer's Flower + 1 Glommer's Wings", "齿轮*2 + 格罗姆之花*1 + 格罗姆之翼*1"), data = 2},
			{description = e_or_z("Hard", "困难"), hover = e_or_z("3 Gears + 1 Glommer's Flower + 1 Glommer's Wings", "齿轮*3 + 格罗姆之花*1 + 格罗姆之翼*1"), data = 3},
		},
		default = 2,
	},
	{
		name = "robobeetechconfig",
		label = e_or_z("Recipe's availability", "配方获取方式"),
		options =
		{
			{description = e_or_z("Obtainable", "图纸获取"), hover = e_or_z("Recipe must be obtained by killing bosses or mining Glommer's Statue.", "通过杀死BOSS或挖掘格罗姆雕像获得图纸。"), data = 1},
			{description = e_or_z("Shadow Manipulator", "暗影操控器(魔法二本)"), hover = e_or_z("Recipe is unlockable via Shadow Manipulator.", "解锁暗影操控器(魔法二本)后制作"), data = 2},
			{description = e_or_z("Prestihatitator", "灵子分解器(魔法一本)"), hover = e_or_z("Recipe is unlockable via Prestihatitator.", "解锁灵子分解器(魔法一本)后制作"), data = 3},
			{description = e_or_z("Alchemy Engine", "炼金引擎(科技二本)"), hover = e_or_z("Recipe is unlockable via Alchemy Engine.", "解锁炼金引擎(科技二本)后制作"), data = 4},
			{description = e_or_z("Science Machine", "科学机器(科技一本)"), hover = e_or_z("Recipe is unlockable via Science Machine", "解锁科学机器(科技一本)后制作"), data = 5},
			{description = e_or_z("No unlock needed", "直接制作"), hover = e_or_z("Recipe is available from the start", "无需解锁，直接制作"), data = 6},
		},
		default = 1,
	},
	{
		name = "robobeerangeconfig",
		label = "G10MM-3R 工作范围",
		label = e_or_z("G10MM-3R's Range", "采集范围"),
		options =
		{
			{description = e_or_z("3", "3"), data = 3},
			{description = e_or_z("6", "6"), data = 6},
			{description = e_or_z("9", "9"), data = 9},
			{description = e_or_z("12", "12"), data = 12},
			{description = e_or_z("15(Default)", "15(默认值)"), data = 15},
			{description = e_or_z("18", "18"), data = 18},
			{description = e_or_z("21", "21"), data = 21},
			{description = e_or_z("24", "24"), data = 24},
			{description = e_or_z("27", "27"), data = 27},
			{description = e_or_z("30", "30"), data = 30},
			{description = e_or_z("36", "36"), data = 36},
			{description = e_or_z("42", "42"), data = 42},
		},
		default = 15,
	},
	{
		name = "robobeeclosebuzzconfig",
		label = e_or_z("Disable the sleep buzz", "关闭烦人的呼噜声"),
		options =
		{
			{description = e_or_z("Yes", "是"), hover = e_or_z("Turn off the snoring sound effect of G10MM-3R while sleeping", "关闭G10MM-3R睡觉时的呼噜声音效"), data = 1},
			{description = e_or_z("No", "否"), hover = e_or_z("No!!!", "不关闭"), data = 2},
		},
		default = 1,
	},
	{
		name = "chesticeboxconfig",
		label = e_or_z("G10MM-3R's Base Container is", "容器效果"),
		--hover	= "Choose the container, which should spawn.",
		options =
		{
			{description = e_or_z("Chest", "普通箱子"), data = 1},
			{description = e_or_z("Icebox", "冰箱"), data = 0},
		},
		default = 1,
	},
	{
		name = "includestructures",
		label = e_or_z("Can target structures", "是否可以采集建筑物"),
		options =
		{
			{description = e_or_z("No", "否"), hover	= e_or_z("G10MM-3R will ignore structures.", "忽略任何建筑"), data = 1},
			{description = e_or_z("Yes", "是"), hover	= e_or_z("G10MM-3R can target Bee Boxes and Drying Racks.", "会采集蜂箱、晾肉架等建筑物"), data = 2},
		},
		default = 1,
	},
	{
		name = "includecrops",
		label = e_or_z("Can target crops", "是否可以采集农作物"),
		options =
		{
			{description = e_or_z("No", "否"), hover	= e_or_z("G10MM-3R will ignore unharvested crops.", "忽略未采集的农作物"), data = 1},
			{description = e_or_z("Yes", "是"), hover	= e_or_z("G10MM-3R can harvest crops (this includes weeds).", "可以采集作物（包括杂草）"), data = 2},
		},
		default = 1,
	},
	{
		name = "whentoharvest",
		label = e_or_z("Harvest when the target", "采集时机（蜂箱等）"),
		options =
		{
			{description = e_or_z("Is full", "满的"), hover	= e_or_z("G10MM-3R will harvest Bee Boxes, etc. only when they're full.", "只有在蜂箱等满了时才会采集"), data = 1},
			{description = e_or_z("Is halfway full", "一半"), hover	= e_or_z("G10MM-3R will harvest Bee Boxes, etc. when they're at least halfway full.", "会在蜂箱等至少一半时才会采集"), data = 2},
			{description = e_or_z("Always", "总是"), hover	= e_or_z("G10MM-3R will harvest Bee Boxes, etc. as soon as they produce.", "蜂箱等只要有就会采集"), data = 3},
		},
		default = 1,
	},
	{
		name = "excludeitemsconfig",
		label = e_or_z("G10MM-3R shouldn't pick up", "忽略采集范围"),
		options =
		{
			{description = e_or_z("None", "无"), hover = e_or_z("Regular G10MM-3R pickup list.", "常规采集列表。"), data = 1},
			{description = e_or_z("Flowers", "鲜花"), hover = e_or_z("This also includes Ferns and Succulents.", "鲜花、还包括蕨类植物和多肉植物。"), data = 2},
			{description = e_or_z("Meats", "肉类"), hover = e_or_z("This also includes Eggs and Drying Racks.", "肉类、还包括鸡蛋和晾肉架"), data = 3},
			{description = e_or_z("Veggies/Fruits", "蔬菜、水果"), hover = e_or_z("This also includes Mushrooms. Does not affect unharvested crops.", "蔬菜、水果、蘑菇。不影响未收获的农作物。"), data = 4},
		},
		default = 1,
	},
	{
		name = "robobee_speed",
		label = e_or_z("G10MM-3R's Movespeed", "移动速度"),
		options =
		{
			{description = e_or_z("Slower(75%)", "缓慢(75%)"), hover	= e_or_z("G10MM-3R moves 25% slower.", "0.75倍的移动速度"), data = 3},
			{description = e_or_z("Default(100%)", "默认(100%)"), hover	= e_or_z("Regular movespeed.", "正常速度"), data = 4},
			{description = e_or_z("Faster(150%)", "快(150%)"), hover	= e_or_z("G10MM-3R moves 50% faster.", "1.5倍的移动速度"), data = 6},
			{description = e_or_z("Very Fast(200%)", "飞快(200%)"), hover	= e_or_z("G10MM-3R moves at double speed.", "2倍的移动速度"), data = 8},
		},
		default = 4,
	},
}
