-[Change log]
--1.00 > Initial release
if myHero.charName ~= "Veigar" then return end
--[AutoUpdate]--
local version = 1.0
local AUTOUPDATE = true
local SCRIPT_NAME = "SionsVeigar"
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



print("Sion's Veigar script Version 1.0")
print("Thank you for using Sion's Vladimir script.")

require 'VPrediction'
require 'SOW'


local ts
local Recall = false
local VP = nil
local QREADY, WREADY, EREADY, RREADY, IREADY = false, false, false, false, false
local Target = nil
local wrange, erange, rrange = 900, 700, 700

local qDelay, qRadius, qRange, qSpeed = 0.875, 160, 900, 1750

function OnLoad()
	  VP = VPrediction()
    ts = TargetSelector(TARGET_LESS_CAST, 700)
		EnemyMinions = minionManager(MINION_ENEMY, qRange, myHero, MINION_SORT_HEALTH_ASC)
		IgniteSlot()
    NSOW = SOW(VP)
    ts.name = "Focus"
		menus()
		end
		
		
		function menus()
		Menu = scriptConfig("Vladimir", "Vladimir")
    Menu:addTS(ts)
		Menu:addSubMenu("Combo", "Combo")
		Menu.Combo:addParam("q", "Use Q", SCRIPT_PARAM_ONOFF, true)
		Menu.Combo:addParam("w", "Use W", SCRIPT_PARAM_ONOFF, true)
		Menu.Combo:addParam("e", "Use E", SCRIPT_PARAM_ONOFF, true)
		Menu.Combo:addParam("r", "Use R", SCRIPT_PARAM_ONOFF, true)
		Menu.Combo:addParam("ig", "Use Ignite if Killable", SCRIPT_PARAM_ONOFF, true)
		
		Menu:addSubMenu("Harass", "Harass")
		Menu.Harass:addParam("qh", "Use Q", SCRIPT_PARAM_ONOFF, true)
		Menu.Harass:addParam("eh", "Use W", SCRIPT_PARAM_ONOFF, true)
		
		
		Menu:addSubMenu("Last hit settings", "lasthit")
		Menu.lasthit:addParam("qf", "Use Q", SCRIPT_PARAM_ONOFF, true)
		
		Menu:addSubMenu("Killsteal", "killsteal")
		Menu.killsteal:addParam("ksr", "Killsteal on R", SCRIPT_PARAM_ONOFF, true)
		
		Menu:addSubMenu("Draw", "Draw")
		Menu.Draw:addParam("dq", "Draw Circle Q", SCRIPT_PARAM_ONOFF, true)
		Menu.Draw:addParam("dw", "Draw Circle W", SCRIPT_PARAM_ONOFF, true)
		Menu.Draw:addParam("de", "Draw Circle E", SCRIPT_PARAM_ONOFF, true)
		Menu.Draw:addParam("dr", "Draw Circle R", SCRIPT_PARAM_ONOFF, true)
		
		Menu:addSubMenu("[Veigar - OrbWalking]", "OrbWalking")
    NSOW:LoadToMenu(Menu.OrbWalking)
		end

function OnTick()
		if myHero.dead then return end
		    Target = GetOthersTarget()
    NSOW:ForceTarget(Target)
    Checks()
		Killsteal()
 if Menu.OrbWalking.Mode0 then activecombo() end
 if Menu.OrbWalking.Mode1 then holdharass() end
 if Menu.OrbWalking.Mode3 then farm() end
end

function farm() --hold
if Menu.lasthit.qf then qf() end
end




		
function qf() -- Q Farm
if Menu.lasthit.qf and (myHero:CanUseSpell(_Q) == READY) then
EnemyMinions:update()
for index, minion in pairs(EnemyMinions.objects) do
local qDmg = getDmg("Q",minion, GetMyHero()) + (myHero.ap * 0.6)
local MinionHealth = minion.health
if qDmg >= MinionHealth then
local CastPosition, HitChance, Position = VP:GetLineCastPosition(minion, 0.3, 75, 875, 1200, myHero, false)
if CastPosition and HitChance >= 2 and GetDistance(CastPosition) < 840 then
CastSpell(_Q, CastPosition.x, CastPosition.z)
end
end
end
end
end

function Killsteal()
if Menu.killsteal.ksr and RREADY then -- kill steal with R
	    for i = 1, heroManager.iCount, 1 do
                        local Target = heroManager:getHero(i)
                        local rDamage = getDmg("R",Target,myHero)
                        if ValidTarget(Target, rrange) and Target.health < rDamage then
                                CastSpell(_R, Target)
                        end
                end
        end
		    for i = 1, heroManager.iCount, 1 do
                        local Target = heroManager:getHero(i)
                        local qDamage = getDmg("Q",Target,myHero)
                        if ValidTarget(Target, 840) and Target.health < qDamage then
                                CastSpell(_Q, Target.x, Target.y)
                        end
                end
if Menu.killsteal.kse and WREADY then -- kill steal with W
		    for i = 1, heroManager.iCount, 1 do
                        local Target = heroManager:getHero(i)
                        local wDamage = getDmg("W",Target,myHero)
                        if ValidTarget(Target, wrange) and Target.health < wDamage then
                                CastSpell(_W, Target.x, Target.y)
                        end
                end
end
end

function activecombo() --Combo
	if Menu.Combo.ig then UseIgnite(Target) end
		if Menu.Combo.e then e() end
		if Menu.Combo.w then w() end
	if Menu.Combo.q then q() end
	if Menu.Combo.r then r() end
end


function holdharass() --Hold
	if ValidTarget(Target) then
	if Menu.Harass.qh then qh() end
	if Menu.Harass.eh then eh() end
end
end


		
	function q() -- Use Q
	if Menu.Combo.q then
for i, target in pairs(GetEnemyHeroes()) do
     local CastPosition, HitChance, Position = VP:GetLineCastPosition(target, 0.3, 75, 875, 1200, myHero, false)
     if CastPosition and HitChance >= 2 and GetDistance(CastPosition) < 840 then
         CastSpell(_Q, CastPosition.x, CastPosition.z)
						end
				end
			end
		end

	function w() -- use W
	if Menu.Combo.w then
	 for i, target in pairs(GetEnemyHeroes()) do
        local CastPosition, HitChance, Position = VP:GetCircularCastPosition(target, 0.7, 225, 900)
        if CastPosition and HitChance >= 2 and GetDistance(CastPosition) < 850 then
            CastSpell(_W, CastPosition.x, CastPosition.z)
						end
						end
						end
						end

function e() -- use E
if Menu.Combo.e then
	 for i, target in pairs(GetEnemyHeroes()) do
        local CastPosition, HitChance, Position = VP:GetCircularCastPosition(target, 0.8, 730, 730)
        if CastPosition and HitChance >= 2 and GetDistance(CastPosition) < 800 then
            CastSpell(_E, CastPosition.x, CastPosition.z)
						end
						end
						end
						end

function r() -- use R
	if Menu.Combo.r and ts.target and RREADY then
	if RREADY and GetDistance(ts.target) < rrange then CastSpell(_R,ts.target) end
	end
	end
	
function qh() -- use Q Hold
	if Menu.Harass.qh and ts.target and QREADY then
for i, target in pairs(GetEnemyHeroes()) do
     local CastPosition, HitChance, Position = VP:GetLineCastPosition(target, 0.3, 75, 875, 1200, myHero, true)
     if CastPosition and HitChance >= 2 and GetDistance(CastPosition) < 840 then
         CastSpell(_Q, CastPosition.x, CastPosition.z)
						end
				end
			end
		end

function eh() -- use W Hold
	if Menu.Harass.eh and ts.target and WREADY then
	 for i, target in pairs(GetEnemyHeroes()) do
        local CastPosition, HitChance, Position = VP:GetCircularCastPosition(target, 0.7, 225, 900)
        if CastPosition and HitChance >= 2 and GetDistance(CastPosition) < 850 then
            CastSpell(_W, CastPosition.x, CastPosition.z)
						end
						end
						end
						end


function isFacing(source, ourtarget, lineLength)
	local sourceVector = Vector(source.visionPos.x, source.visionPos.z)
	local sourcePos = Vector(source.x, source.z)
	sourceVector = (sourceVector-sourcePos):normalized()
	sourceVector = sourcePos + (sourceVector*(GetDistance(ourtarget, source)))
	return GetDistanceSqr(ourtarget, {x = sourceVector.x, z = sourceVector.y}) <= (lineLength and lineLength^2 or 90000)
end

function GetOthersTarget()
    ts:update()
    if _G.MMA_Target and _G.MMA_Target.type == myHero.type then return _G.MMA_Target end
    if _G.AutoCarry and _G.AutoCarry.Crosshair and _G.AutoCarry.Attack_Crosshair and _G.AutoCarry.Attack_Crosshair.target and _G.AutoCarry.Attack_Crosshair.target.type == myHero.type then return _G.AutoCarry.Attack_Crosshair.target end
    return ts.target
end

function IgniteSlot() -- gets ignite summoner spot
    if myHero:GetSpellData(SUMMONER_1).name:find("SummonerDot") then
            ignite = SUMMONER_1
    elseif myHero:GetSpellData(SUMMONER_2).name:find("SummonerDot") then
            ignite = SUMMONER_2
    end
end

function OnRecall(hero, channelTimeInMs)
    if hero.networkID == player.networkID then
        Recall = true
    end
end
function OnAbortRecall(hero)
    if hero.networkID == player.networkID
        then Recall = false
    end
end
function OnFinishRecall(hero)
    if hero.networkID == player.networkID
        then Recall = false
    end
end

local function getHitBoxRadius(target)
        return GetDistance(target, target.minBBox)
end


function UseIgnite(enemy) -- use ignite
	        if Menu.Harass.ig then    
                if IREADY then
                        local ignitedmg = 0    
                        for j = 1, heroManager.iCount, 1 do
                                local enemyhero = heroManager:getHero(j)
                                if ValidTarget(enemyhero,600) then
                                        ignitedmg = 50 + 20 * myHero.level
                                        if enemyhero.health <= ignitedmg then
                                                        CastSpell(ignite, enemyhero)
end
end
end     
end
end
end

function Checks()	
    QREADY = (myHero:CanUseSpell(_Q) == READY)
    WREADY = (myHero:CanUseSpell(_W) == READY)
    EREADY = (myHero:CanUseSpell(_E) == READY)
    RREADY = (myHero:CanUseSpell(_R) == READY)
    IREADY = (ignite ~= nil and myHero:CanUseSpell(ignite) == READY)
end		

function OnDraw()
	if Menu.Draw.dq then DrawCircle(myHero.x, myHero.y, myHero.z, qRange, 0x111111) end
		if Menu.Draw.dw then DrawCircle(myHero.x, myHero.y, myHero.z, wrange, 0x111111) end
	if Menu.Draw.de then DrawCircle(myHero.x, myHero.y, myHero.z, erange, 0x111111) end
	if Menu.Draw.dr then DrawCircle(myHero.x, myHero.y, myHero.z, rrange, 0x111111) end
	end
