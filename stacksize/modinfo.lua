local function e_or_z(en, zh)
	return (locale == "zh" or locale == "zhr" or locale == "zht") and zh or en
end

name = e_or_z("StackSize&KeepFresh", "堆叠上限和保鲜")

description = e_or_z([[
* Stacking limit (Default: 80);
* Food preservation can be modified (Default: System Default);
* Freshness needs to be turned on manually!!
]],
 [[
* 可以修改堆叠上限值（默认：80）；
* 食物保鲜 (默认：系统值)；
* 保鲜需手动开启！！保鲜需手动开启！！！
]]
)

author = "zhanphty"
version = "1.3.4"
forumthread = ""
api_version = 10

--兼容性
dont_starve_compatible = true
reign_of_giants_compatible = true
all_clients_require_mod = true
client_only_mod = false
dst_compatible = true

icon = "modicon.tex"
icon_atlas = "modicon.xml"

keep_def_options = {
	{description = e_or_z("perish quickly", "更快腐烂"), data = 5},
	{description = e_or_z("ground perish rate", "地面级腐烂"), data = 1.5},
	{description = e_or_z("default perish rate","默认腐烂"), data = 1},
	{description = e_or_z("icebox perish rate","冰箱级腐烂"), data = 0.5},
	{description = e_or_z("salt box perish rate","盐盒级腐烂"), data = 0.25},
	{description = e_or_z("bearger bin perish rate","熊盒级腐烂"), data = 0.1},
	{description = e_or_z("keep fresh","永鲜"), data = 0},
	{description = e_or_z("refresh","返鲜"), data = -1},
	{description = e_or_z("refresh quickly","返鲜x5"), data = -5},
}

configuration_options =
{
  {
		name = "",
		label = e_or_z("STACK OPTIONS", "堆叠配置"),
		hover = "",
		options = {
				{description = "", data = 0},
		},
		default = 0,
	},
	{
		name = "stack_size",
		label = e_or_z("stack size", "物资堆叠上限"),
		hover = e_or_z("stack size", "物资堆叠上限"),
		options = 
		{	
			{description = e_or_z("Default", "默认"), data = 10},
			{description = "40", data = 40},
			{description = "60", data = 60},
			{description = "64", data = 64},
			{description = "80", data = 80},
			{description = "99", data = 99},
			{description = "120", data = 120},
			{description = "200", data = 200},
			{description = "999", data = 999},
		},
		default = 80,
	},
	{
		name = "soul_stack",
		label = e_or_z("wortox's souls size", "沃托克斯的灵魂上限"),
		hover = e_or_z("wortox's souls size", "沃托克斯的灵魂上限"),
		options = 
		{	
			{description = e_or_z("20(Default)", "20(默认)"), data = 20},
			{description = "40", data = 40},
			{description = "60", data = 60},
			{description = "64", data = 64},
			{description = "80", data = 80},
			{description = "99", data = 99},
			{description = "120", data = 120},
			{description = "200", data = 200},
			{description = "999", data = 999},
		},
		default = 20,
	},
	{
		name = "",
		label = e_or_z("KEEP FRESH OPTIONS", "保鲜配置"),
		hover = "",
		options = {
				{description = "", data = 0},
		},
		default = 0,
	},
	{
		name = "fridge_mult",
		label = e_or_z("icebox and Snow Chester perish rate", "冰箱和冰小切的腐烂速度"),
		hover = e_or_z("icebox and Snow Chester perish rate", "冰箱和冰小切的腐烂速度"),
		options = keep_def_options,
		default = 0.5,
	},
	{
		name = "salt_freeze",
		label = e_or_z("salt box perish rate", "盐盒腐烂速度"),
		hover = e_or_z("salt box perish rate", "盐盒腐烂速度"),
		options = keep_def_options,
		default = 0.25,
	},
	{
		name = "glow_freeze",
		label = e_or_z("mushlight and glowcap perish rate", "蘑菇灯腐烂速度"),
		hover = e_or_z("mushlight and glowcap perish rate", "蘑菇灯腐烂速度"),
		options = keep_def_options,
		default = 0.25,
	},
	{
		name = "icepack_freeze",
		label = e_or_z("insulated pack perish rate", "熊皮包腐烂速度"),
		hover = e_or_z("insulated pack perish rate", "熊皮包腐烂速度"),
		options = keep_def_options,
		default = 0.5,
	},
	{
		name = "backpack_freeze",
		label = e_or_z("backpack perish rate", "背包腐烂速度"),
		hover = e_or_z("backpack perish rate", "背包腐烂速度"),
		options = keep_def_options,
		default = 1,
	},
	{
		name = "krampussack_freeze",
		label = e_or_z("krampus sack perish rate", "小偷包腐烂速度"),
		hover = e_or_z("krampus sack perish rate", "小偷包腐烂速度"),
		options = keep_def_options,
		default = 1,
	},
	{
		name = "beargerfur_sack",
		label = e_or_z("Polar Bearger Bin perish rate", "极地熊獾桶腐烂速度"),
		hover = e_or_z("Polar Bearger Bin perish rate", "极地熊獾桶腐烂速度"),
		options = {
			{description = e_or_z("default perish rate","默认腐烂"), data = 0.05},
			{description = e_or_z("keep fresh","永鲜"), data = 0},
			{description = e_or_z("refresh","返鲜"), data = -1},
			{description = e_or_z("refresh quickly","返鲜x5"), data = -5},
		},
		default = 0.05,
	}
}
