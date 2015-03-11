--[Change log]
--1.00 > Initial release
if myHero.charName ~= "Vladimir" then return end
--[AutoUpdate]--
local version = 1.2
local AUTOUPDATE = true
local SCRIPT_NAME = "SionsVladimir"
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



print("Sion's Vladimir script Version 1.0")
print("Thank you for using Sion's Vladimir script.")

require 'VPrediction'
require 'SOW'

local ts
local Recall = false
local VP = nil
local QREADY, WREADY, EREADY, RREADY, IREADY = false, false, false, false, false
local Target = nil
local qrange, erange, rrange = 600, 600, 700
function OnLoad()
	  VP = VPrediction()
    ts = TargetSelector(TARGET_LESS_CAST, 700)
		IgniteSlot()
    NSOW = SOW(VP)
    Menu = scriptConfig("Vladimir", "Vladimir")
    Menu:addTS(ts)
    ts.name = "Focus"

		
		Menu:addSubMenu("Combo", "Combo")
		Menu.Combo:addParam("q", "Use Q", SCRIPT_PARAM_ONOFF, true)
		Menu.Combo:addParam("e", "Use E", SCRIPT_PARAM_ONOFF, true)
		Menu.Combo:addParam("r", "Use R", SCRIPT_PARAM_ONOFF, true)
		Menu.Combo:addParam("ig", "Use Ignite if Killable", SCRIPT_PARAM_ONOFF, true)
		
				Menu:addSubMenu("Harass", "Harass")
		Menu.Harass:addParam("qh", "Use Q", SCRIPT_PARAM_ONOFF, true)
		Menu.Harass:addParam("eh", "Use E", SCRIPT_PARAM_ONOFF, true)
		
		
		
			Menu:addSubMenu("Last hit settings", "lasthit")
		Menu.lasthit:addParam("sep", "--Last Hit Settings--", SCRIPT_PARAM_INFO, "")
		Menu.lasthit:addParam("qf", "Use Q", SCRIPT_PARAM_ONOFF, true)
		Menu.lasthit:addParam("ef", "Use E", SCRIPT_PARAM_ONOFF, true)
		
						Menu:addSubMenu("Killsteal", "killsteal")
		Menu.killsteal:addParam("ksq", "Killsteal on Q", SCRIPT_PARAM_ONOFF, true)
		Menu.killsteal:addParam("kse", "Killsteal on E", SCRIPT_PARAM_ONOFF, true)
		Menu.killsteal:addParam("ksr", "Killsteal on R", SCRIPT_PARAM_ONOFF, true)
		
		Menu:addSubMenu("Zhonyas", "zhonyas")
				Menu.zhonyas:addParam("zhonyas", "Auto Zhonyas", SCRIPT_PARAM_ONOFF, true)
				Menu.zhonyas:addParam("zhonyasunder", "Use Zhonyas under % health", SCRIPT_PARAM_SLICE, 20, 0, 100 , 0)
				Menu.zhonyas:addParam("zRange", "Use if x Enemies are in x Range", SCRIPT_PARAM_SLICE, 500, 0, 800, 0)
				Menu.zhonyas:addParam("zAmount", "Use Zhonyas if x Enemies are near", SCRIPT_PARAM_SLICE, 1, 0, 5, 0)
				
									Menu:addSubMenu("Additional", "Additional")
		Menu.Additional:addParam("stack", "Auto-Stack E", SCRIPT_PARAM_ONOFF, false)

		
					Menu:addSubMenu("Draw", "Draw")
		Menu.Draw:addParam("dq", "Draw Circle Q", SCRIPT_PARAM_ONOFF, true)
		Menu.Draw:addParam("de", "Draw Circle E", SCRIPT_PARAM_ONOFF, true)
		Menu.Draw:addParam("dr", "Draw Circle R", SCRIPT_PARAM_ONOFF, true)
		    Menu:addSubMenu("[Vladimir - OrbWalking]", "OrbWalking")
    NSOW:LoadToMenu(Menu.OrbWalking)
end

function OnTick()
		if myHero.dead then return end
    Target = GetOthersTarget()
    NSOW:ForceTarget(Target)
    Checks()
		Killsteal()
		if Menu.Additional.stack then if time > os.clock() - 9 then do stack() end end end
			if Menu.zhonyas.zhonyas then Zhonyas() end
 if Menu.OrbWalking.Mode0 then activecombo() end
 if Menu.OrbWalking.Mode1 then holdharass() end
 if Menu.OrbWalking.Mode3 then farm() end
end

function farm() --hold
if Menu.lasthit.qf then qf() end
if Menu.lasthit.ef then ef() end
end

function qf() 
if Menu.lasthit.qf and (myHero:CanUseSpell(_Q) == READY) then
        for index, minion in pairs(minionManager(MINION_ENEMY, qrange, player, MINION_SORT_HEALTH_ASC).objects) do
                local qDmg = getDmg("Q",minion, GetMyHero()) + (myHero.ap * 0.6)
            local MinionHealth_ = minion.health
            if qDmg >= MinionHealth_ then
                    CastSpell(_Q, minion)
            end
        end
    end
end



function stack()
if (myHero:CanUseSpell(_E) == READY) then
                    CastSpell(_E)
										time = os.clock()
end
end

function ef()
if Menu.lasthit.ef and (myHero:CanUseSpell(_E) == READY) then
        for index, minion in pairs(minionManager(MINION_ENEMY, erange, player, MINION_SORT_HEALTH_ASC).objects) do
                local eDmg = getDmg("E",minion, GetMyHero()) + (myHero.ap * 0.45)
            local MinionHealth_ = minion.health
            if eDmg >= MinionHealth_ then
                    CastSpell(_E)
            end
        end
    end
end

function Killsteal()
if Menu.killsteal.ksr and RREADY then
	    for i = 1, heroManager.iCount, 1 do
                        local Target = heroManager:getHero(i)
                        local rDamage = getDmg("R",Target,myHero)
                        if ValidTarget(Target, rrange) and Target.health < rDamage then
                                CastSpell(_R, Target)
                        end
                end
        end
if Menu.killsteal.ksq and QREADY then 
		    for i = 1, heroManager.iCount, 1 do
                        local Target = heroManager:getHero(i)
                        local qDamage = getDmg("Q",Target,myHero)
                        if ValidTarget(Target, qrange) and Target.health < qDamage then
                                CastSpell(_Q, Target)
                        end
                end
        end	
if Menu.killsteal.kse and EREADY then
		    for i = 1, heroManager.iCount, 1 do
                        local Target = heroManager:getHero(i)
                        local eDamage = getDmg("E",Target,myHero)
                        if ValidTarget(Target, erange) and Target.health < eDamage then
                                CastSpell(_E, Target)
                        end
                end
        end	
end

function activecombo() --Combo
	if Menu.Combo.ig then UseIgnite(Target) end
	if Menu.Combo.q then q() end
	if Menu.Combo.e then e() end
	if Menu.Combo.r then r() end
end


function holdharass() --Hold
	if ValidTarget(Target) then
	if Menu.Harass.qh then qh() end
	if Menu.Harass.eh then eh() end
end
end

function q()
	if Menu.Combo.q and ts.target and QREADY then
	if QREADY and GetDistance(ts.target) < qrange then CastSpell(_Q,ts.target) end
	end
	end

function e()
	if Menu.Combo.e and ts.target and EREADY then
	if EREADY and GetDistance(ts.target) < erange then CastSpell(_E) end
	end
	end

function r()
	if Menu.Combo.r and ts.target and RREADY then
	if RREADY and GetDistance(ts.target) < rrange then CastSpell(_R,ts.target) end
	end
	end
	
function qh() 
	if Menu.Harass.qh and ts.target and QREADY then
	if QREADY and GetDistance(ts.target) < qrange then CastSpell(_Q,ts.target) end
	end
	end

function eh()
	if Menu.Harass.eh and ts.target and EREADY then
	if EREADY and GetDistance(ts.target) < erange then CastSpell(_E) end
	end
	end


function isFacing(source, ourtarget, lineLength)
	local sourceVector = Vector(source.visionPos.x, source.visionPos.z)
	local sourcePos = Vector(source.x, source.z)
	sourceVector = (sourceVector-sourcePos):normalized()
	sourceVector = sourcePos + (sourceVector*(GetDistance(ourtarget, source)))
	return GetDistanceSqr(ourtarget, {x = sourceVector.x, z = sourceVector.y}) <= (lineLength and lineLength^2 or 90000)
end


function Zhonyas()
	local zSlot = GetInventorySlotItem(3157)
		if zSlot ~= nil and myHero:CanUseSpell(zSlot) == READY then
			local zrange = Menu.zhonyas.zRange
			local zamount = Menu.zhonyas.zAmount
			local health = myHero.health
			local maxHealth = myHero.maxHealth
				if ((health/maxHealth)*100) <= Config.misc.zhonyas.zhonyasunder and CountEnemyHeroInRange(zrange) <= zamount then
			CastSpell(zSlot)
		end
	end
end


function GetOthersTarget()
    ts:update()
    if _G.MMA_Target and _G.MMA_Target.type == myHero.type then return _G.MMA_Target end
    if _G.AutoCarry and _G.AutoCarry.Crosshair and _G.AutoCarry.Attack_Crosshair and _G.AutoCarry.Attack_Crosshair.target and _G.AutoCarry.Attack_Crosshair.target.type == myHero.type then return _G.AutoCarry.Attack_Crosshair.target end
    return ts.target
end

function IgniteSlot()
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
--By Feez
function isFacing(source, ourtarget, lineLength)
local sourceVector = Vector(source.visionPos.x, source.visionPos.z)
local sourcePos = Vector(source.x, source.z)
sourceVector = (sourceVector-sourcePos):normalized()
sourceVector = sourcePos + (sourceVector*(GetDistance(ourtarget, source)))
return GetDistanceSqr(ourtarget, {x = sourceVector.x, z = sourceVector.y}) <= (lineLength and lineLength^2 or 90000)
end
local function getHitBoxRadius(target)
        return GetDistance(target, target.minBBox)
end


function UseIgnite(enemy)
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
	    --Spells 
    QREADY = (myHero:CanUseSpell(_Q) == READY)
    WREADY = (myHero:CanUseSpell(_W) == READY)
    EREADY = (myHero:CanUseSpell(_E) == READY)
    RREADY = (myHero:CanUseSpell(_R) == READY)
    IREADY = (ignite ~= nil and myHero:CanUseSpell(ignite) == READY)
end		

function OnDraw()
	if Menu.Draw.dq then DrawCircle(myHero.x, myHero.y, myHero.z, qrange, 0x111111) end
	if Menu.Draw.de then DrawCircle(myHero.x, myHero.y, myHero.z, erange, 0x111111) end
	if Menu.Draw.dr then DrawCircle(myHero.x, myHero.y, myHero.z, rrange, 0x111111) end
	end
