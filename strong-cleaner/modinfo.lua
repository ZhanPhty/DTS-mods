local function e_or_z(en, zh)
	return (locale == "zh" or locale == "zhr" or locale == "zht") and zh or en
end

name = e_or_z("Strong Cleaner(Only Myself)", "服务器定时清理(仅自用)")

description = e_or_z([[
Server scheduled cleanup Mod [google translate]
* Console executes manual cleanup command: DoRemove()
* Whitelist mode cleanup: DoRW()

Cleanup mechanism:
Check the ground for items every 20 days (default: 20 days, adjustable)
The first time an item on the ground is inspected, a mark will be added.
Flagged items will be cleared during the second check
This means that it will take at least 20 days for items on the ground to be cleared

How to use fault tolerance:
* Set to blacklist mode (default).
* In blacklist mode, only the items in the blacklist and most of the items on the sea will be cleared.
 --- Ground: twigs, grass cuttings, rotten food, bee stings, droppings, bird droppings, rotten eggs, pine cones, multi-branched tree species, spider glands, charcoal, lucky gold, red envelopes、houndstooth (will not clean out the box!)
 --- Sea surface: Items other than driftwood, growth promoter screwdrivers, growth promoters, messages in bottles, and empty bottles (the ship will not be cleaned by default)
* Throw unwanted items into the sea and then execute "DoRemove()" to clean them up

The cleaning dates are 1, 5, 10, 20, 30, 40, 60, 80, 100, 200 and so on.

This Mod will only clean the ground and items not included in the whitelist
Items on players, items in the whitelist, or items near the coffee table will not be cleared.

In addition, server restarts will cause item tags to be lost.
]],
[[
服务器定时清理Mod
* 控制台执行手动清理命令：DoRemove()
* 白名单模式清理：DoRW()

清理机制：
每20天（默认值: 20天，可调整）检查地面的物品
地面的物品第一次被检查，会添加标记
被添加标记的物品在第二次检查时会被清理
这意味着地面物品至少20天以上才会被清理

容错使用方法：
* 设置成黑名单模式（默认）
* 黑名单模式下只会清理黑名单里的物品和大部分海面的物品
 --- 地面：树枝、割下的草、腐烂食物、蜂刺、粪便、鸟便、腐烂的蛋、松果、狗牙、多支树种、蜘蛛腺体、木炭、幸运黄金、红包 （不会清理箱子里的！）
 --- 海面：除了浮木、催长剂起子、催长剂、瓶中信、空瓶子以外的物品（默认不会清理船）
* 把不想要的物品丢进海里，然后执行“DoRemove()”进行清理

清理的日期是1、5、10、20、30、40、60、80、100，200以此类推

本Mod只会清理地面且不包含在白名单的物品
玩家身上，或者白名单里的物品，或者茶几附近的物品不会被清理

另外，服务器重启会使物品标记丢失

查询物品对应的代码: https://zhuanlan.zhihu.com/p/34134405
]])
author = "zhanphty"
version = "1.9.10"

forumthread = ""

api_version = 10

all_clients_require_mod = false
client_only_mod = false
dst_compatible = true

icon_atlas = "modicon.xml"
icon = "modicon.tex"

----------------------
-- General settings --
----------------------
configuration_options =
{
	{
		name = "checking_days",
		label = e_or_z("Checking Period(Day)", "清理间隔(天)"),
		hover = e_or_z("Checking Period(Day)", "清理间隔(天)"),
		options =	{
            {description = e_or_z("Not Cleaner", "不清理"), data = 999999},
            {description = e_or_z("1 Days", "1天"), data = 1},
            {description = e_or_z("5 Days", "5天"), data = 5},
            {description = e_or_z("10 Days", "10天"), data = 10},
            {description = e_or_z("20 Days", "20天"), data = 20},
            {description = e_or_z("30 Days", "30天"), data = 30},
            {description = e_or_z("40 Days", "40天"), data = 40},
            {description = e_or_z("50 Days", "50天"), data = 50},
            {description = e_or_z("60 Days", "60天"), data = 60},
            {description = e_or_z("80 Days", "80天"), data = 80},
            {description = e_or_z("100 Days", "100天"), data = 100},
            {description = e_or_z("100 Days", "200天"), data = 200},
        },
		default = 20,
	},
    {
        name = "clean_mode",
		label = e_or_z("Clean Mode", "清理模式"),
        hover = "Whitelist mode or Blacklist mode白名单模式或者黑名单模式",
        options =   {
            {description = e_or_z("Whitelist", "白名单模式"), data = 0, hover = "除了白名单里的都清理"},
            {description = e_or_z("Blacklist", "黑名单模式"), data = 1, hover = "只清理黑名单的"},
        },
        default = 1,
    },
    {
        name = "white_area",
		label = e_or_z("Things near the tables will not be removed", "茶几附近不清理"),
        hover = "Things near the tables will not be removed茶几附近的物品不清理",
        options =   {
            {description = e_or_z("YES", "是"), data = true, hover = ""},
            {description = e_or_z("NO", "否"), data = false, hover = ""},
        },
        default = true,
    },
    {
        name = "boat_clean",
		label = e_or_z("Destroy boats that were not used for a specific days", "清理未使用的船"),
        hover = "Destroy boats that were not used for a specific days销毁特定日期未使用的船只",
        options =   {
            {description = e_or_z("No", "不清理"), data = false, hover = ""},
            {description = e_or_z("180 days in game", "180天游戏时间"), data = 180, hover = ""},
            {description = e_or_z("360 days in game", "360天游戏时间"), data = 360, hover = ""},
            {description = e_or_z("540 days in game", "540天游戏时间"), data = 540, hover = ""},
            {description = e_or_z("720 days in game", "720天游戏时间"), data = 720, hover = ""},
        },
        default = false,
    },
    {
        name = "float_mode",
		label = e_or_z("Whether to clean up the sea surface", "是否清理海面"),
        hover = "默认开启，清理除了浮木、催长剂起子、催长剂、瓶中信、空瓶子所有海面物品",
        options =   {
            {description = e_or_z("YES", "是"), data = true, hover = ""},
            {description = e_or_z("NO", "否"), data = false, hover = ""},
        },
        default = true,
    },
}