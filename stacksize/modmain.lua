---------------------------------
-- 一、叠堆
---------------------------------
local stack_size = GetModConfigData("stack_size")
local soul_stack = GetModConfigData("soul_stack")

local function ModSetStacksize()
	-- 物资
	if GetModConfigData("stack_size")==10 then
		GLOBAL.TUNING.STACK_SIZE_LARGEITEM = 10
		GLOBAL.TUNING.STACK_SIZE_MEDITEM = 20
		GLOBAL.TUNING.STACK_SIZE_SMALLITEM = 40
		GLOBAL.TUNING.STACK_SIZE_TINYITEM = 60
	else
		GLOBAL.TUNING.STACK_SIZE_LARGEITEM = stack_size
		GLOBAL.TUNING.STACK_SIZE_MEDITEM = stack_size
		GLOBAL.TUNING.STACK_SIZE_SMALLITEM = stack_size
		GLOBAL.TUNING.STACK_SIZE_TINYITEM = stack_size
	end

	-- 沃托克斯的灵魂上限
	GLOBAL.TUNING.WORTOX_MAX_SOULS = soul_stack
end

-- 调用堆叠函数
ModSetStacksize()

local mod_stackable_replica = GLOBAL.require("components/stackable_replica")
mod_stackable_replica._ctor = function(self, inst)
	self.inst = inst
	self._stacksize = GLOBAL.net_shortint(inst.GUID, "stackable._stacksize", "stacksizedirty")
	self._maxsize = GLOBAL.net_shortint(inst.GUID, "stackable._maxsize")
end

---------------------------------
-- 二、保鲜度
---------------------------------
local icebox_freeze = GetModConfigData("fridge_mult")
local salt_freeze = GetModConfigData("salt_freeze")
local glow_freeze = GetModConfigData("glow_freeze")
local backpack_freeze = GetModConfigData("backpack_freeze")
local icepack_freeze = GetModConfigData("icepack_freeze")
local krampussack_freeze = GetModConfigData("krampussack_freeze")

-- 设置腐烂度函数
local function SetPrefabPerishRate(prefab, rate)
	AddPrefabPostInit(prefab, function(inst)
			if inst.components.preserver == nil then
					inst:AddComponent("preserver")
			end
			inst.components.preserver:SetPerishRateMultiplier(rate)
	end)
end

-- 全局食物腐烂度设置
GLOBAL.TUNING.PERISH_FRIDGE_MULT = icebox_freeze

-- 冰箱
if icebox_freeze < 0 then
	SetPrefabPerishRate("icebox", GLOBAL.TUNING.PERISH_FRIDGE_MULT)
end

-- 盐盒
GLOBAL.TUNING.PERISH_SALTBOX_MULT = salt_freeze

-- 蘑菇灯
GLOBAL.TUNING.PERISH_MUSHROOM_LIGHT_MULT = glow_freeze

-- 背包
SetPrefabPerishRate("backpack", backpack_freeze)

-- 熊皮包
SetPrefabPerishRate("icepack", icepack_freeze)

-- 小偷包
SetPrefabPerishRate("krampus_sack", krampussack_freeze)
