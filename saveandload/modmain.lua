local _G = GLOBAL

local TheInput = _G.TheInput
local TheNet = _G.TheNet
local KEY_CTRL = _G.KEY_CTRL


-- 存档
TheInput:AddKeyUpHandler(GetModConfigData("keyboard_save"), function()
    TheNet:SendRemoteExecute('c_save()')
end)

-- 读档, 按下ctrl组合键
TheInput:AddKeyUpHandler(GetModConfigData("keyboard_load"), function()
	if TheInput:IsKeyDown(KEY_CTRL) then
		TheNet:SendRemoteExecute('c_reset()')
	end
end)
