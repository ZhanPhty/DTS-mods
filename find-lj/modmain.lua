GLOBAL.setmetatable(env, { __index = function(t, k) return GLOBAL.rawget(GLOBAL, k) end})

modimport "upvalueutil"

----------------------------------
-- 移除鼹鼠帽滤镜
----------------------------------
local molehat_vision = GetModConfigData("molehat_vision")

AddComponentPostInit("playervision", function(self)
    if molehat_vision == "keep_on_day" then
        local keep_on_day_cubes = {
            day = "images/colour_cubes/mole_vision_off_cc.tex",
            full_moon = "images/colour_cubes/purple_moon_cc.tex",
        }
        UpvalueUtil.SetUpvalue(self.UpdateCCTable, "NIGHTVISION_COLOURCUBES", keep_on_day_cubes)
    elseif molehat_vision then
        UpvalueUtil.SetUpvalue(self.UpdateCCTable, "NIGHTVISION_COLOURCUBES", {})
    end
end)

----------------------------------
-- 移除沙漠护目镜及亮茄头滤镜效果
----------------------------------
local config_goggle_sover = GetModConfigData("goggle_sover")

if config_goggle_sover == 1 then
	AddClassPostConstruct("widgets/gogglesover",function(self)
		local oldToggleGoggles = self.ToggleGoggles
		self.ToggleGoggles = function(self,show)
			show = false
			return oldToggleGoggles(self,show)
		end
	end)
end

----------------------------------
-- 去除启迪滤镜及音效
----------------------------------
local config_remove_enlightened = GetModConfigData("remove_enlightened")
local config_lunacy_sound = GetModConfigData("lunacy_enlightened_sound")
local should_remove_overlay = (config_remove_enlightened == 2)

AddComponentPostInit("playercontroller", function(self, inst)
    if inst ~= GLOBAL.ThePlayer then return end

    -- 启迪滤镜
    if config_remove_enlightened ~= 0 then
        local PostProcessor = GLOBAL.PostProcessor
        if not PostProcessor then return end

        local PostProcessor_mt = GLOBAL.getmetatable(PostProcessor)
        if not PostProcessor_mt then return end

        local LUNACY_CHANNEL = 2
        local OldSetColourCubeLerp = PostProcessor_mt.__index.SetColourCubeLerp

        if OldSetColourCubeLerp then
            PostProcessor_mt.__index.SetColourCubeLerp = function(self2, channel, blend_amount)
                if channel == LUNACY_CHANNEL then
                    blend_amount = 0
                end
                return OldSetColourCubeLerp(self2, channel, blend_amount)
            end
        end

        -- 启迪晕影效果
        if should_remove_overlay then
            local OldSetOverlayBlend = PostProcessor_mt.__index.SetOverlayBlend
            if OldSetOverlayBlend then
                if PostProcessor.SetOverlayBlend then
                    PostProcessor:SetOverlayBlend(0)
                end
                PostProcessor_mt.__index.SetOverlayBlend = function(self2, blend)
                    return OldSetOverlayBlend(self2, 0)
                end
            end
        end
    end

    -- 启迪音效
    if config_lunacy_sound ~= nil and config_lunacy_sound ~= 1 then
        local fp = GLOBAL.TheFocalPoint
        if fp ~= nil and fp.SoundEmitter ~= nil then
            local mt = GLOBAL.getmetatable(fp.SoundEmitter)
            if mt ~= nil and mt.__index ~= nil and not mt.__index._ecd_lunacy_sound_patch then
                local old_PlaySound = mt.__index.PlaySound
                if old_PlaySound ~= nil then
                    mt.__index.PlaySound = function(se, event, name, ...)
                        local e = type(event) == "string" and string.lower(event) or ""
                        local is_stinger = (e == "dontstarve/sanity/lunacy_stinger") or (e:find("lunacy_stinger", 1, true) ~= nil)
                        local is_loop = (e == "turnoftides/sanity/lunacy_lp")
                            or (e:find("lunacy", 1, true) ~= nil and (e:find("_lp", 1, true) ~= nil or e:find("loop", 1, true) ~= nil))
                        if config_lunacy_sound == 2 then
                            if is_loop then
                                return
                            end
                        elseif config_lunacy_sound == 3 then
                            if is_stinger or is_loop then
                                return
                            end
                        end
                        return old_PlaySound(se, event, name, ...)
                    end
                    mt.__index._ecd_lunacy_sound_patch = true
                end
            end
        end
    end
end)

AddComponentPostInit("ambientsound", function(self, inst)
    if config_lunacy_sound ~= nil and config_lunacy_sound ~= 1 then
        local old_OnUpdate = self.OnUpdate
        self.OnUpdate = function(self2, dt)
            if old_OnUpdate ~= nil then
                old_OnUpdate(self2, dt)
            end
            if inst.SoundEmitter ~= nil then
                inst.SoundEmitter:KillSound("ENLIGHT")
            end
        end
    end
end)

AddComponentPostInit("playercontroller", function(self, inst)
    if inst ~= GLOBAL.ThePlayer then return end
    if config_lunacy_sound ~= nil and config_lunacy_sound ~= 1 then
        local fp = GLOBAL.TheFocalPoint
        if fp ~= nil and fp.SoundEmitter ~= nil then
            local mt = GLOBAL.getmetatable(fp.SoundEmitter)
            if mt ~= nil and mt.__index ~= nil and not mt.__index._ecd_lunacy_param_patch then
                local old_SetParameter = mt.__index.SetParameter
                if old_SetParameter ~= nil then
                    mt.__index.SetParameter = function(se, name, param, value, ...)
                        if type(name) == "string" and name == "ENLIGHT" then
                            return
                        end
                        return old_SetParameter(se, name, param, value, ...)
                    end
                end
                local old_SetVolume = mt.__index.SetVolume
                if old_SetVolume ~= nil then
                    mt.__index.SetVolume = function(se, name, vol, ...)
                        if type(name) == "string" and name == "ENLIGHT" then
                            return
                        end
                        return old_SetVolume(se, name, vol, ...)
                    end
                end
                mt.__index._ecd_lunacy_param_patch = true
            end
        end
    end
end)