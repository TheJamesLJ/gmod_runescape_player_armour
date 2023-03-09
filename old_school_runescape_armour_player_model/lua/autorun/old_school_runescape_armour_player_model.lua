if SERVER then
	AddCSLuaFile()
end

local RUNESCAPE_ARMOUR_PLAYER_MODEL_PATH = "models/player/runescape/runescape_player_armour/runescape_player_armour.mdl"
local RUNESCAPE_ARMOUR_PLAYER_HANDS_MODEL_PATH = "models/weapons/arms/runescape/runescape_player_armour/v_arms_runescape_player_armour.mdl"

player_manager.AddValidModel( "Old School RuneScape Armour", RUNESCAPE_ARMOUR_PLAYER_MODEL_PATH )
player_manager.AddValidHands( "Old School RuneScape Armour", RUNESCAPE_ARMOUR_PLAYER_HANDS_MODEL_PATH, 0, "00000000" )
list.Set( "PlayerOptionsModel", "Old School RuneScape Armour", RUNESCAPE_ARMOUR_PLAYER_MODEL_PATH )

if CLIENT then

	-- Add a client side hook that changes the skin of the players hands to their player model skin
	-- I've only added this as a workaround as player_manager.AddValidHands doesn't work for multiple skins
	-- so it'd always set the skin of the hands to 0 (Bronze Armour) rather than their selected skin
	hook.Add("PreDrawPlayerHands", "RuneScapePlayerArmourPreDrawPlayerHands", function(hands, vm, ply, weapon)

		-- Get the players current model, we don't want to mess with other player models, just my own
		if ply:GetModel() == RUNESCAPE_ARMOUR_PLAYER_MODEL_PATH then
			if hands:GetModel() == RUNESCAPE_ARMOUR_PLAYER_HANDS_MODEL_PATH then
				local hs = hands:GetSkin()
				local ps = ply:GetSkin()

				-- When the players skin has changed, usually via the player model selector
				-- we need to change the skin used by the hands too, so they match.
				if hs != ps then
					hands:SetSkin(ps)
				end
			end
		end
	end)

end