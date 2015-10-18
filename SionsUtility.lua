print("Thank you for using Sion's Overlay")
print("If you enjoy the script like the thread and consider donating")
local version = 0.1

--[[
.____    ._____.     ________                      .__                    .___            
|    |   |__\_ |__   \______ \   ______  _  ______ |  |   _________     __| _/___________ 
|    |   |  || __ \   |    |  \ /  _ \ \/ \/ /    \|  |  /  _ \__  \   / __ |/ __ \_  __ \
|    |___|  || \_\ \  |    `   (  <_> )     /   |  \  |_(  <_> ) __ \_/ /_/ \  ___/|  | \/
|_______ \__||___  / /_______  /\____/ \/\_/|___|  /____/\____(____  /\____ |\___  >__|   
        \/       \/          \/                  \/                \/      \/    \/       
]]

-- SourceLib auto download
local sourceLibFound = true
if FileExist(LIB_PATH .. "SourceLib.lua") then
    require "SourceLib"
else
    sourceLibFound = false
    DownloadFile("https://raw.github.com/TheRealSource/public/master/common/SourceLib.lua", LIB_PATH .. "SourceLib.lua", function() print("<font color=\"#6699ff\"><b>" .. scriptName .. ":</b></font> <font color=\"#FFFFFF\">SourceLib downloaded! Please reload!</font>") end)
end
-- Return if SourceLib has to be downloaded
if not sourceLibFound then return end

-- Updater
if autoUpdate then
    SourceUpdater(scriptName, version, "raw.github.com", "/SionScripts/BoL/BoL/SionsUtility.lua", SCRIPT_PATH .. GetCurrentEnv().FILE_NAME, "/SionScripts/BoL/BoL/SionsUtility.version"):SetSilent(silentUpdate):CheckUpdate()
end


local _a = 7
local aa = SPRITE_PATH .. "\\SionsOverlay\\"
local ba = {}
local ca = 0
local menu = nil
local lastSend = 0
local menuText = nil
local interval = 50


function NearFountain(da)
  local _b = GetFountain()
  if _b == nil then
    return false
  else
    return da > GetDistance(_b, myHero)
  end
end
function OnLoad()
  ChecksFiles()
  _G.Menu = scriptConfig("Sion's utility", "Menu")
	    Menu = _G.menu

	Menu:addSubMenu("Hud Overlay", "HudOverlay")
		Menu.HudOverlay:addParam("Enable", "Enable HUD overlay", SCRIPT_PARAM_ONOFF, true)
  Menu.HudOverlay:addParam("selection", "Choose HUD skin number", SCRIPT_PARAM_SLICE, 1, 0, ca, 0)
  Menu.HudOverlay:addParam("autodisable", "Auto disable near fountain", SCRIPT_PARAM_ONOFF, false)
  Menu.HudOverlay:addSubMenu("Quick search", "quick")
  Menu.HudOverlay.quick:addSubMenu("Shards", "Shards")
  Menu.HudOverlay.quick.Shards:addParam("Shards1", "Blue Shards", SCRIPT_PARAM_ONOFF, false)
  Menu.HudOverlay.quick.Shards:addParam("Shards2", "Light Shards", SCRIPT_PARAM_ONOFF, false)
	  Menu.HudOverlay.quick.Shards:addParam("Shards3", "Neutral Shards", SCRIPT_PARAM_ONOFF, false)
		  Menu.HudOverlay.quick.Shards:addParam("Shards4", "Pink Shards", SCRIPT_PARAM_ONOFF, false)
			  Menu.HudOverlay.quick.Shards:addParam("Shards5", "Red Shards", SCRIPT_PARAM_ONOFF, false)
							  Menu.HudOverlay.quick.Shards:addParam("Shards6", "Green Shards", SCRIPT_PARAM_ONOFF, false)
  Menu.HudOverlay.quick:addParam("udyr", "udyr", SCRIPT_PARAM_ONOFF, false)

			Menu:addSubMenu("VIP options", "VIP")
			Menu.VIP:addSubMenu("Anti Ban", "anti")
			Menu.VIP.anti:addParam("Enabled", "Enable anti-ban", SCRIPT_PARAM_ONOFF, true)
			Menu.VIP.anti:addParam("antilevel", "Legitness level", SCRIPT_PARAM_SLICE, 1, 1, 3, 0)

    PacketHandler:HookOutgoingPacket(Packet.headers.S_MOVE, OnMovePacket)
	
	
end
function OnTick()
  if Menu.HudOverlay.quick.Shards.Shards1 == true then
    Menu.HudOverlay.selection = 1
    Menu.HudOverlay.quick.Shards.Shards1 = false
  end
  if Menu.HudOverlay.quick.Shards.Shards2 == true then
    Menu.HudOverlay.selection = 2
    Menu.HudOverlay.quick.Shards.Shards2 = false
  end
	  if Menu.HudOverlay.quick.Shards.Shards3 == true then
    Menu.HudOverlay.selection = 3
    Menu.HudOverlay.quick.Shards.Shards3 = false
  end
	  if Menu.HudOverlay.quick.Shards.Shards4 == true then
    Menu.HudOverlay.selection = 4
    Menu.HudOverlay.quick.Shards.Shards4 = false
  end
	  if Menu.HudOverlay.quick.Shards.Shards5 == true then
    Menu.HudOverlay.selection = 5
    Menu.HudOverlay.quick.Shards.Shards5 = false
  end
	  if Menu.HudOverlay.quick.Shards.Shards6 == true then
    Menu.HudOverlay.selection = 6
    Menu.HudOverlay.quick.Shards.Shards6 = false
  end
	 if Menu.HudOverlay.quick.udyr == true then
    Menu.HudOverlay.selection = 7
    Menu.HudOverlay.quick.udyr = false
end
if Menu.VIP.anti.antilevel == 1 then
	interval = 50
	end
	if Menu.VIP.anti.antilevel == 2 then
	interval = 100
	end
	if Menu.VIP.anti.antilevel == 3 then
	interval = 150
	end


end

function OnDraw()
  if Menu.HudOverlay.Enable and Menu.HudOverlay.selection ~= 0 and not GetGame().isOver and ba[Menu.HudOverlay.selection].sprite ~= nil then
    if Menu.HudOverlay.autodisable == false then
      ba[Menu.HudOverlay.selection].sprite:SetScale(WINDOW_W / 1920, WINDOW_H / 1080)
      ba[Menu.HudOverlay.selection].sprite:Draw(0, 0, 255)
    end
    if Menu.HudOverlay.autodisable and not NearFountain(1200) then
      ba[Menu.HudOverlay.selection].sprite:SetScale(WINDOW_W / 1920, WINDOW_H / 1080)
      ba[Menu.HudOverlay.selection].sprite:Draw(0, 0, 255)
    end
  end
end

function OnMovePacket(p)

	if not Menu.VIP.anti.Enabled then return end

    local packet = Packet(p)
    if packet:get("type") == 2 then
        if packet:get("sourceNetworkId") == player.networkID then
            if os.clock() * 1000 - lastSend < Menu.interval and not _G.Evadeee_evading then
                p:Block()
            else
                lastSend = os.clock() * 1000
            end
        end
    elseif packet:get("type") == 3 then
        lastSend = 0
    end

end

function ChecksFiles()
  for i = 1, _a do
    if FileExist(aa .. "hud_" .. i .. ".png") then
      ba[i] = {
        file = aa .. "hud_" .. i .. ".png",
        name = "Hud " .. i,
        sprite = createSprite(aa .. "hud_" .. i .. ".png")
      }
      ca = i
    end
  end
end
function OnUnload()
  if #ba > 0 then
    for i = 1, ca do
      if ba[i].sprite ~= nil then
        ba[i].sprite:Release()
      end
    end
  end
end

