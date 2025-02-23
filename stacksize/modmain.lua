---------------------------------
-- 一、叠堆
---------------------------------
local stack_size = GetModConfigData("stack_size")
local soul_stack = GetModConfigData("soul_stack")

local function ModSetStacksize()
	-- 物资
	if stack_size ~= 10 then
		GLOBAL.TUNING.STACK_SIZE_LARGEITEM = stack_size
		GLOBAL.TUNING.STACK_SIZE_MEDITEM = stack_size
		GLOBAL.TUNING.STACK_SIZE_SMALLITEM = stack_size
		GLOBAL.TUNING.STACK_SIZE_TINYITEM = stack_size
	end

	-- 沃托克斯的灵魂上限
	if soul_stack ~= 20 then
		GLOBAL.TUNING.WORTOX_MAX_SOULS = soul_stack
	end
end

-- 调用堆叠函数
ModSetStacksize()

local function ModStackSizeDirty(inst)
	local self = inst.replica.stackable
	if not self then
		return
	end
	
	self:ClearPreviewStackSize()
	inst:PushEvent("inventoryitem_stacksizedirty")
end

if stack_size ~= 10 or soul_stack ~= 20 then
	local mod_stackable_replica = GLOBAL.require("components/stackable_replica")
	mod_stackable_replica._ctor = function(self, inst)
		self.inst = inst
		self._stacksize = GLOBAL.net_shortint(inst.GUID, "stackable._stacksize", "stacksizedirty")
		self._stacksizeupper = GLOBAL.net_shortint(inst.GUID, "stackable._stacksizeupper", "stacksizedirty")
		self._ignoremaxsize = GLOBAL.net_bool(inst.GUID, "stackable._ignoremaxsize")
		self._maxsize = GLOBAL.net_shortint(inst.GUID, "stackable._maxsize")

		if not GLOBAL.TheWorld.ismastersim then
			inst:ListenForEvent("stacksizedirty", ModStackSizeDirty)
		end
	end
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
local beargerfur_sack = GetModConfigData("beargerfur_sack")

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

-- 极地熊獾桶
if beargerfur_sack ~= 0.05 then
	GLOBAL.TUNING.BEARGERFUR_SACK_PRESERVER_RATE = beargerfur_sack
end

-- 背包
SetPrefabPerishRate("backpack", backpack_freeze)

-- 熊皮包
SetPrefabPerishRate("icepack", icepack_freeze)

-- 小偷包
SetPrefabPerishRate("krampus_sack", krampussack_freeze)
