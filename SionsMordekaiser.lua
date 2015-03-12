--[Change log]
--1.00 > Initial release
if myHero.charName ~= "Mordekaiser" then return end
--[AutoUpdate]--
local version = 1.1
local AUTOUPDATE = true
local SCRIPT_NAME = "SionsMordekaiser"
time = os.clock()
--========--
local SOURCELIB_URL = "https://raw.github.com/TheRealSource/public/master/common/SourceLib.lua"
local SOURCELIB_PATH = LIB_PATH.."SourceLib.lua"

if FileExist(SOURCELIB_PATH) then
	require("SourceLib")
else
	DOWNLOADING_SOURCELIB = true
	DownloadFile(SOURCELIB_URL, SOURCELIB_PATH, function() print("Required libraries downloaded successfully, please reload") end)
end

if DOWNLOADING_SOURCELIB then print("Downloading required libraries, please wait...") return end

if AUTOUPDATE then
	 SourceUpdater(SCRIPT_NAME, version, "raw.github.com", "/SionScripts/BoL/BoL/"..SCRIPT_NAME..".lua", SCRIPT_PATH .. GetCurrentEnv().FILE_NAME, "/SionScripts/BoL/BoL/"..SCRIPT_NAME..".version"):CheckUpdate()
end



print("Sion's Mordekaiser script Version 1.0")
print("Thank you for using Sion's script")

local QREADY, WREADY, EREADY, RREADY, IREADY = false, false, false, false, false
local qrange, wrange, erange, rrange = 250, 750, 650, 850
local ts
local allies = GetAllyHeroes()
require 'VPrediction'
require 'SOW'

function OnLoad()
  VP = VPrediction()
    NSOW = SOW(VP)
		local DFGSlot, HXGSlot, BWCSlot, SheenSlot, TrinitySlot, LBSlot, IGSlot, LTSlot, BTSlot, STISlot, ROSlot, BRKSlot = nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
local HXGREADY, BWCREADY, STIREADY, ROREADY, BRKREADY, IREADY = false, false, false, false, false, false
menu()
end

function menu()

	
	--[Menu]--
	Config = scriptConfig("Mordekaiser by Sion", "sion")
	--[Hotkeys]--
	Config:addSubMenu("Combat hotkeys", "hotkeys")
Config.hotkeys:addParam("combo", "Combo mode", SCRIPT_PARAM_ONKEYDOWN, false, string.byte(" "))
--[Combo]--
		Config:addSubMenu("Combo", "Combo")
				Config.Combo:addParam("Q", "Use Q in Combo", SCRIPT_PARAM_ONOFF, true)
						Config.Combo:addParam("W", "Use W in Combo", SCRIPT_PARAM_ONOFF, true)
								Config.Combo:addParam("E", "Use E in Combo", SCRIPT_PARAM_ONOFF, true)
									Config.Combo:addParam("R", "Use R in Combo", SCRIPT_PARAM_ONOFF, false)
										Config.Combo:addParam("RO", "Use R only if killable", SCRIPT_PARAM_ONOFF, true)
		--[Draw]--
		Config:addSubMenu("Draw", "draw")
		
		Config.draw:addParam("DLC", "Use Lag-Free Circles", SCRIPT_PARAM_ONOFF, true)

	Config.draw:addParam("drawQ", "Draw Q Range", SCRIPT_PARAM_ONOFF, true)
			Config.draw:addParam("drawQC", "Draw Q Range Color", SCRIPT_PARAM_COLOR, {227,18,255,0})
			
		Config.draw:addParam("drawW", "Draw W Range", SCRIPT_PARAM_ONOFF, true)
		Config.draw:addParam("drawWC", "Draw W Range Color", SCRIPT_PARAM_COLOR, {18,235,141,0})
		
			Config.draw:addParam("drawE", "Draw E Range", SCRIPT_PARAM_ONOFF, true)
					Config.draw:addParam("drawEC", "Draw E Range Color", SCRIPT_PARAM_COLOR, {227,235,18,0})
				Config.draw:addParam("drawR", "Draw R Range", SCRIPT_PARAM_ONOFF, true)
					Config.draw:addParam("drawRC", "Draw R Range Color", SCRIPT_PARAM_COLOR, {255,177,88,0})
	
	ts = TargetSelector(TARGET_LOW_HP_PRIORITY,800)
	
	--[SOW]--
	Config:addSubMenu("[Mordekaiser - OrbWalking]", "OrbWalking")
    NSOW:LoadToMenu(Config.OrbWalking)

	_G.oldDrawCircle = rawget(_G, 'DrawCircle')
	_G.DrawCircle = DrawCircle2
		end


function OnTick()
	ts:update()
	check()
	
	if (ts.target ~= nil) and Config.hotkeys.combo then
		Combo()
	end
	
local ally = getRandomAlly(750)
					--- Combo -----
	end
	
	function Combo()
		
		if (Config.hotkeys.combo) then
		
			if (myHero:CanUseSpell(_E) == READY) then
					if (Config.Combo.E) then
			CastSpell(_E, ts.target.x,ts.target.z)
			end
		end
	
		
			if (myHero:CanUseSpell(_W) == READY) then
					if (Config.Combo.W) then
					 if ally then
        CastSpell(_W, ally)
    else
        CastSpell(_W, myHero) 
    end
			end
		end
		
					if (myHero:CanUseSpell(_Q) == READY) then
					if (Config.Combo.Q) then
			CastSpell(_Q)
			myHero:Attack(ts.target)
			end
		end
		
				if (myHero:CanUseSpell(_R) == READY) then
if Config.Combo.R and Config.Combo.RO ~= true and ts.target then 
if GetDistance(ts.target) < rrange then 
CastSpell(_R,ts.target) end
	end
	end
	
		if (myHero:CanUseSpell(_R) == READY) then
if Config.Combo.RO and ts.target then 
if GetDistance(ts.target) < rrange then 
if ts.target.health < getDmg("R",ts.target,myHero) then 
CastSpell(_R,ts.target) end
end
end
end
end	
		
end


function check()

if Config.draw.DLC then 
		_G.DrawCircle = DrawCircle2 
	else 
		_G.DrawCircle = _G.oldDrawCircle 
	end
		end






function getRandomAlly(range)
    for i, ally in pairs(allies) do
        if GetDistance(ally) < wrange then
            return ally
        end
    end
    return nil
end


function OnDraw()

	if Config.draw.drawQ and (myHero:CanUseSpell(_Q) == READY) then			
		DrawCircle(myHero.x, myHero.y, myHero.z, qrange, RGB(Config.draw.drawQC[2], Config.draw.drawQC[3], Config.draw.drawQC[4]))
	end
	
		if Config.draw.drawW and (myHero:CanUseSpell(_W) == READY) then			
		DrawCircle(myHero.x, myHero.y, myHero.z, wrange, RGB(Config.draw.drawWC[2], Config.draw.drawWC[3], Config.draw.drawWC[4]))
	end
	
		if Config.draw.drawE and (myHero:CanUseSpell(_E) == READY) then			
		DrawCircle(myHero.x, myHero.y, myHero.z, erange, RGB(Config.draw.drawEC[2], Config.draw.drawEC[3], Config.draw.drawEC[4]))
	end
	
		if Config.draw.drawR and (myHero:CanUseSpell(_R) == READY) then			
		DrawCircle(myHero.x, myHero.y, myHero.z, rrange, RGB(Config.draw.drawRC[2], Config.draw.drawRC[3], Config.draw.drawRC[4]))
	end
	
	
	end



function DrawCircle2(x, y, z, radius, color)
  local vPos1 = Vector(x, y, z)
  local vPos2 = Vector(cameraPos.x, cameraPos.y, cameraPos.z)
  local tPos = vPos1 - (vPos1 - vPos2):normalized() * radius
  local sPos = WorldToScreen(D3DXVECTOR3(tPos.x, tPos.y, tPos.z))
  
  if OnScreen({ x = sPos.x, y = sPos.y }, { x = sPos.x, y = sPos.y }) then
    DrawCircleNextLvl(x, y, z, radius, 1, color, 75) 
  end
end

function DrawCircleNextLvl(x, y, z, radius, width, color, chordlength)
  radius = radius or 300
  quality = math.max(8,round(180/math.deg((math.asin((chordlength/(2*radius)))))))
  quality = 2 * math.pi / quality
  radius = radius*.92
  
  local points = {}
  for theta = 0, 2 * math.pi + quality, quality do
    local c = WorldToScreen(D3DXVECTOR3(x + radius * math.cos(theta), y, z - radius * math.sin(theta)))
    points[#points + 1] = D3DXVECTOR2(c.x, c.y)
  end
  
  DrawLines2(points, width or 1, color or 4294967295)
end

function round(num) 
  if num >= 0 then return math.floor(num+.5) else return math.ceil(num-.5) end
end

