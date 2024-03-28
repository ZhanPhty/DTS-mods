GLOBAL.setmetatable(env, { __index = function(t, k) return GLOBAL.rawget(GLOBAL, k) end})

modimport "upvalueutil"

if not GetModConfigData("keep_hud_ui") then
	local PlayerHud = require("screens/playerhud")
    function PlayerHud:GoInsane()
        self:GoSane()
    end
end

-- -- Also from Kynoox_'s Seasonal Colour Cubes
AddComponentPostInit("colourcube", function(self, inst)
    if GetModConfigData("autumn_cc_only") and not inst:HasTag("cave") then
        inst:PushEvent("overridecolourcube", "images/colour_cubes/day05_cc.tex")
    end

    if not GetModConfigData('keep_san_ui') then
        for _, fn in ipairs(TheWorld.event_listeners["playeractivated"][TheWorld]) do
            local OnSanityDelta = UpvalueUtil.GetUpvalue(fn, "OnSanityDelta")
            if OnSanityDelta then
                UpvalueUtil.SetUpvalue(fn, "OnSanityDelta", function(player, data)
                    local easing = require("easing")
                    PostProcessor:SetColourCubeLerp(1, 0)
                    PostProcessor:SetDistortionFactor(1)
                    UpvalueUtil.SetUpvalue(OnSanityDelta, "_fxspeed", easing.outQuad(0, 0, .2, 1))
                end)
            end
        end
    end
end)

AddComponentPostInit("playervision", function(self)
    if GetModConfigData("ghost_vision") then
        UpvalueUtil.SetUpvalue(self.UpdateCCTable, "GHOSTVISION_COLOURCUBES", nil)
    end
    if GetModConfigData("molehat_vision") == "keep_on_day" then
        local keep_on_day_cubes = {
            day = "images/colour_cubes/mole_vision_off_cc.tex",
            full_moon = "images/colour_cubes/purple_moon_cc.tex",
        }
        UpvalueUtil.SetUpvalue(self.UpdateCCTable, "NIGHTVISION_COLOURCUBES", keep_on_day_cubes)
    elseif GetModConfigData("molehat_vision") then
        UpvalueUtil.SetUpvalue(self.UpdateCCTable, "NIGHTVISION_COLOURCUBES", {})
    end
end)

--------------------------------------------------------------------------------

local soundmap = {}
local play_sound = SoundEmitter.PlaySound
function SoundEmitter:PlaySound(name, ...)
    local mapname = soundmap[name] or name
    play_sound(self, mapname, ...)
end

if GetModConfigData("insane_noise") then
    soundmap["dontstarve/sanity/gonecrazy_stinger"] = ""
    soundmap["dontstarve/sanity/sanity"] = ""
end

if GetModConfigData("lunacy_noise") then
    soundmap["turnoftides/sanity/lunacy_LP"] = ""
end
