local TheNet = GLOBAL.TheNet
local lang = TheNet:GetDefaultServerLanguage()
local Vector3 = GLOBAL.Vector3
local io = GLOBAL.io
local TheSim = GLOBAL.TheSim

local checkingdays = GetModConfigData("checking_days")
local white_area = GetModConfigData("white_area")
local clean_mode = GetModConfigData("clean_mode")
local float_mode = GetModConfigData("float_mode")

local lightbulb = "***"

local whitelist = {
    "book",                     --奶奶的书(关键词)
    "wereitem",                 --俗气雕像(关键词)
    "mooneye",                  --月眼(关键词)
    "saddle",                   --鞍(关键词)
    "powcake",                  --芝士蛋糕(关键词)
    "jellybean",                --糖豆
    "waxwelljournal",           --老麦的书
    "fireflies",                --萤火虫
    "slurper",                  --啜食者
    "pumpkin_lantern",          --南瓜灯
    "bullkelp_beachedroot",     --海带
    "driftwood_log",            --浮木桩
    "panflute",                 --排箫
    "skeletonhat",              --骨盔
    "armorskeleton",            --骨甲
    "thurible",                 --香炉
    "fossil_piece",             --化石碎片
    "shadowheart",              --心脏
    "amulet",                   --生命护符
    "reviver",                  --救赎之心
    "heatrock",                 --暖石
    "dug_trap_starfish",        --挖起的海星
    "nightmare_timepiece",      --铥矿勋章
    "staff",                    --法杖(关键词 唤星法杖、喚月法杖、瞬移手杖、分解法杖)
    "cane",                     --步行手杖
    "glommerfuel",              --格罗姆燃料
    "lureplantbulb",            --食人花种子
    "tentaclespots",            --触手皮
    "hivehat",                  --蜂王帽
    "tentaclespike",            --狼牙棒
    "nightsword",               --影刀
    "armor_sanity",             --影甲
    "tacklecontainer",          --钓具箱
    "supertacklecontainer",     --超级钓具箱
    "singingshell_octave",      --贝壳钟(关键词 有3 4 5)
    "winter_ornament_light",    --冬季盛宴灯泡（1-8）
    "winter_ornament_festivalevents", --冬季盛宴（华丽冠军）
    "winter_ornament_boss",     --冬季盛宴 boss装饰物
    "trinket",                  --玩具(关键词 有1-37)
    "gem",                      --宝石(关键词 各颜色的宝石)
    "alterguardianhat",         --启迪之冠(包括碎片：alterguardianhatshard)
    "nitre",                    --硝石
    "beeswax",                  --蜂蜡
    "waxpaper",                 --蜡纸
    "honeycomb",                --蜂巢
    "walrus_tusk",              --海象牙
    "mosquitosack",             --蚊子血袋
    "minotaurhorn",             --远古守护者角
    "lightninggoathorn",        --闪电羊角
    "gears",                    --齿轮
    "eyebrellahat",             --眼球伞
    "minerhat",                 --矿工灯
    "beehat",                   --养蜂人的帽子
    "walrushat",                --贝雷帽
    "beefalohat",               --牛角帽
    "bushhat",                  --灌木帽
    "plantregistryhat",         --耕作先驱帽
    "nutrientsgoggleshat",      --高级耕作先驱帽
    "malbatross_beak",          --邪天翁喙
    "winter_food4",             --永恒水果蛋糕
    "pigskin",                  --猪皮
    "manrabbit_tail",           --兔人尾巴
    "moonrockidol",             --月岩雕像
    "soil_amender",             --催长剂
    "messagebottleempty",       --瓶中信（空瓶子）
    "messagebottle",            --瓶中信
    "eye",                      --眼球(关键词)
    "dragon_scales",            --龙蝇皮
    "spoiled_fish",             --变质的鱼
    "boneshard",                --骨头碎片
    "livinglog",                --活木
    "shroom_skin",              --蛤蟆皮
    "oar_driftwood",            --浮木浆
    "lantern",                  --提灯
    "armormarble",              --大理石甲
    "greenamulet",              --建造护符
    "beef_bell",                --牛铃
    "compost",                  --堆肥
    "treegrowthsolution",       --树果酱
    "fertilizer",               --堆肥桶
    "thulecite",                --铥矿类
    "gunpowder",                --火药
    "tallbirdegg",              --高脚鸟蛋
    "houndstooth",              --狗牙
    "onemanband",               --独奏乐器
    "security_pulse_cage",      --火花柜（包含充能）
    "reskin_tool",              --清洁扫把
    "wateringcan",              --浇水壶（鸟嘴壶）
    "lunarplant",               --亮茄系列(关键词)
    "voidcloth",                --虚空系列(关键词)
    "purebrilliance",           --纯粹辉煌
    "dreadstone",               --绝望石
    "horrorfuel",               --纯粹恐惧
    "voidcloth",                --暗影碎布
}

local blacklist = {
    "twigs",                    --树枝
    "cutgrass",                 --割下的草
    "spoiled_food",             --腐烂食物
    "stinger",                  --蜂刺
    "poop",                     --粪便
    "guano",                    --鸟便
    "rottenegg",                --腐烂的蛋
    "pinecone",                 --松果
    "twiggy_nut",               --多支树种
    "spidergland",              --蜘蛛腺体
    "charcoal",                 --木炭
    -- "halloweencandy",           --万圣节糖果
    -- "lucky_goldnugget",         --幸运黄金（活动金元宝）
    -- "redpouch",                 --红包
    -- "redpouch_yotp",            --节日红包
}

local whitetag = {
    "smallcreature",            --鸟、兔子、鼹鼠
    "irreplaceable",            --可疑的大理石、远古钥匙、眼骨、星空、天体灵球、格罗姆花
    "heavy",                    --雕像
    "backpack",                 --背包、小猪包、小偷包
    "icepack",                  --熊包
    "bundle",                   --包裹、礼物
    "deerantler",               --鹿角
    "trap",                     --陷阱、狗牙陷阱、海星
}

local halfwhitelist = {
    "tentaclespike",            --狼牙棒
    "nightsword",               --影刀
    "armor_sanity",             --影甲
}

if clean_mode == 0 then
    local readtxt,err = io.open(MODROOT.."/whitelist.txt", "r")
    if not err then
        for line in readtxt:lines() do
            line = string.sub(line, 1, -2)
            table.insert(whitelist,line)
            print('Whitelist Add:', line)
        end
    end
else
    local readtxt,err = io.open(MODROOT.."/blacklist.txt", "r")
    if not err then
        for line in readtxt:lines() do
            line = string.sub(line, 1, -2)
            table.insert(blacklist,line)
            print('Blacklist Add:', line)
        end
    end
end

local function isWhitelist(name)
    for k,v in pairs(whitelist) do
        if string.find(name, v) then
            return true
        end
    end
    return false
end

local function isBlacklist(name)
    for k,v in pairs(blacklist) do
        if string.find(name, v) then
            return true
        end
    end
    return false
end

local function isWhiteTag(fabs)
    for k,v in pairs(whitetag) do
        if fabs:HasTag(v) then
            return true
        end
    end
    return false
end

local function isHalfWhitelist(fabs)
    for k,v in pairs(halfwhitelist) do
        if string.find(fabs.prefab, v) then
            if fabs.components.finiteuses then
                if fabs.components.finiteuses:GetPercent() < 1 then
                    return true
                end
            end
        end
    end
end

-- 不清除浮木、催长剂起子、催长剂、瓶中信、空瓶子
local function isFloat(fabs)
    if fabs.components.floater then
        if fabs.components.floater:IsFloating() 
            and fabs.prefab ~= "driftwood_log"
            and fabs.prefab ~= "soil_amender"
            and fabs.prefab ~= "soil_amender_fermented"
            and fabs.prefab ~= "messagebottleempty"
            and fabs.prefab ~= "messagebottle" then
            return true
        end
    end
    return false
end

local function WhiteArea(inst)
    if white_area then
        local pos = Vector3(inst.Transform:GetWorldPosition())
        local entity_list = TheSim:FindEntities(pos.x, pos.y, pos.z, 4)
        for i, entity in pairs(entity_list) do
            if entity.prefab == "endtable" then
                return false
            end
        end
        return true
    else
        return true
    end
end

-- 根据模式清理
local function DoRemove()
    local list = {}
    for k,v in pairs(GLOBAL.Ents) do
        if v.components.inventoryitem and v.components.inventoryitem.owner == nil then
            if (clean_mode == 0 and not isWhitelist(v.prefab) and not isWhiteTag(v))
                or (clean_mode == 1 and isBlacklist(v.prefab))
                or (float_mode and isFloat(v))
                or isHalfWhitelist(v) then
                if WhiteArea(v) then
                    if v:HasTag("RemoveCountOne") then
                        v:Remove()
                        local numm = list[v.name.."  "..v.prefab]
                        if numm == nil then
                            list[v.name.."  "..v.prefab] = 1
                        else
                            numm = numm + 1
                            list[v.name.."  "..v.prefab] = numm
                        end
                    else
                        v:AddTag("RemoveCountOne")
                    end
                end
            end
        end
    end
    
    --如果list为空就不宣告
    if GLOBAL.next(list) ~= nil then
        for k,v in pairs(list) do
            print("wiped", v, k)
        end
        print("Wiping Done!")
        if not GLOBAL.TheShard:IsSecondary() then
            if lang == "zh" then
                TheNet:Announce(lightbulb.."服务器清理完毕"..lightbulb)
            else
                TheNet:Announce(lightbulb.."Server Cleaning Done"..lightbulb)
            end
        end
    end
end

-- 清理白名单
local function DoRemoveWhite()
    local list = {}
    for k,v in pairs(GLOBAL.Ents) do
        if v.components.inventoryitem and v.components.inventoryitem.owner == nil then
            if (not isWhitelist(v.prefab) and not isWhiteTag(v))
                or (float_mode and isFloat(v))
                or isHalfWhitelist(v) then
                if WhiteArea(v) then
                    if v:HasTag("RemoveCountOne") then
                        v:Remove()
                        local numm = list[v.name.."  "..v.prefab]
                        if numm == nil then
                            list[v.name.."  "..v.prefab] = 1
                        else
                            numm = numm + 1
                            list[v.name.."  "..v.prefab] = numm
                        end
                    else
                        v:AddTag("RemoveCountOne")
                    end
                end
            end
        end
    end
    
    --如果list为空就不宣告
    if GLOBAL.next(list) ~= nil then
        for k,v in pairs(list) do
            print("wiped: ", v, k)
        end
        print("Wiping Done!")
        if not GLOBAL.TheShard:IsSecondary() then
            if lang == "zh" then
                TheNet:Announce(lightbulb.."服务器清理完毕"..lightbulb)
            else
                TheNet:Announce(lightbulb.."Server Cleaning Done"..lightbulb)
            end
        end
    end
end

local function WorldPeriodicRemove(inst)
    if not GLOBAL.TheWorld:HasTag("cave") then
        inst:DoTaskInTime(.5, function(inst)
            inst:ListenForEvent("cycleschanged", function()
                local count_days = GLOBAL.TheWorld.state.cycles / checkingdays
                if math.floor(count_days) == count_days then --默认每20天检查一次
                    DoRemove()
                end
            end)
        end)
    end
end

local function CavePeriodicRemove(inst)
    if GLOBAL.TheWorld:HasTag("cave") then
        inst:DoTaskInTime(.5, function(inst)
            inst:ListenForEvent("cycleschanged", function()
                local count_days = GLOBAL.TheWorld.state.cycles / checkingdays
                if math.floor(count_days) == count_days then --默认每20天检查一次
                    DoRemove()
                end
            end)
        end)
    end
end

AddPrefabPostInit("forest", WorldPeriodicRemove)
AddPrefabPostInit("cave", CavePeriodicRemove)

--添加手动清理的功能 DoRemove()
GLOBAL.DoRemove = DoRemove
--直接清理白名单
GLOBAL.DoRW = DoRemoveWhite

--For Boat

if GetModConfigData("boat_clean") then

    local boat_delete_time = GetModConfigData("boat_clean") * 480

    local function starttimer(inst)
        inst.components.timer:StartTimer("boatRemoval", boat_delete_time)
        -- print("计时器：开始")
    end
    
    local function stoptimer(inst)
        inst.components.timer:StopTimer("boatRemoval")
        -- print("计时器：结束")
    end
    
    local function ontimerdone(inst)
        local players = inst.components.walkableplatform:GetEntitiesOnPlatform({"player"},nil)
        if #players == 0 then
            inst:Remove()
            print("计时器：删除船")
        end
    end
    
    local function BoatAutoRemove(inst)
        if not GLOBAL.TheWorld.ismastersim then
            return inst
        end
        inst:AddComponent("timer")
        -- inst.components.timer:StartTimer("boatRemoval", boat_delete_time)
        inst:ListenForEvent("timerdone", ontimerdone)
    
        inst._OnPhysicsWake = inst.OnPhysicsWake
        inst.OnPhysicsWake = function(...)
            if inst._OnPhysicsWake then
                inst._OnPhysicsWake(...)
            end
            stoptimer(inst)
        end
    
        inst._OnPhysicsSleep = inst.OnPhysicsSleep
        inst.OnPhysicsSleep = function(...)
            if inst._OnPhysicsSleep then
                inst._OnPhysicsSleep(...)
            end
            starttimer(inst)
        end
    end
    
    AddPrefabPostInit("boat", BoatAutoRemove)
    
end