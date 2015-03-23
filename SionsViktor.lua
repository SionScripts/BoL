
if myHero.charName ~= "Viktor" then return end
assert(load(Base64Decode("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"), nil, "bt", _ENV))() ScriptStatus("SFIGKLFMJKJ") 


--[AutoUpdate]--
local version = 1.21
local AUTOUPDATE = true
local SCRIPT_NAME = "SionsViktor"
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



		
function CheckStuff()
    if _G.Reborn_Loaded and not _G.Reborn_Initialised then
        DelayAction(CheckStuff, 1)
    elseif _G.Reborn_Initialised then
		return false
    else
				print("SAC:R not found, loading SOW")
        require "SOW"
				return true
    end
		end
		
require "VPrediction"
require "SourceLib"
local VP = VPrediction()



gapCloseList = {
       ['Ahri']        = {true, spell = 'AhriTumble'},
        ['Aatrox']      = {true, spell = 'AatroxQ'},
        ['Akali']       = {true, spell = 'AkaliShadowDance'}, -- Targeted ability
        ['Alistar']     = {true, spell = 'Headbutt'}, -- Targeted ability
        ['Diana']       = {true, spell = 'DianaTeleport'}, -- Targeted ability
        ['Gragas']      = {true, spell = 'GragasE'},
        ['Graves']      = {true, spell = 'GravesMove'},
        ['Hecarim']     = {true, spell = 'HecarimUlt'},
        ['Irelia']      = {true, spell = 'IreliaGatotsu'}, -- Targeted ability
        ['JarvanIV']    = {true, spell = 'JarvanIVDragonStrike'}, -- Skillshot/Targeted ability
        ['Jax']         = {true, spell = 'JaxLeapStrike'}, -- Targeted ability
        ['Jayce']       = {true, spell = 'JayceToTheSkies'}, -- Targeted ability
		['Katarina']	 = {true, spell = 'KatarinaE'},
        ['Khazix']      = {true, spell = 'KhazixW'},
        ['Leblanc']     = {true, spell = 'LeblancSlide'},
        ['LeeSin']      = {true, spell = 'blindmonkqtwo'},
        ['Leona']       = {true, spell = 'LeonaZenithBlade'},
        ['Malphite']    = {true, spell = 'UFSlash'},
        ['Maokai']      = {true, spell = 'MaokaiTrunkLine',}, -- Targeted ability	
		['MasterYi']	=  {true, spell = 'AlphaStrike',}, -- Targeted
        ['MonkeyKing']  = {true, spell = 'MonkeyKingNimbus'}, -- Targeted ability
        ['Pantheon']    = {true, spell = 'PantheonW'}, -- Targeted ability
        ['Pantheon']    = {true, spell = 'PantheonRJump'},
        ['Pantheon']    = {true, spell = 'PantheonRFall' },
        ['Poppy']       = {true, spell = 'PoppyHeroicCharge'}, -- Targeted ability
        --['Quinn']       = {true, spell = 'QuinnE',                  range = 725,   projSpeed = 2000, }, -- Targeted ability
        ['Renekton']    = {true, spell = 'RenektonSliceAndDice'},
        ['Sejuani']     = {true, spell = 'SejuaniArcticAssault'},
        ['Shen']        = {true, spell = 'ShenShadowDash'},
        ['Tristana']    = {true, spell = 'RocketJump'},
        ['Tryndamere']  = {true, spell = 'Slash'},
        ['XinZhao']     = {true, spell = 'XenZhaoSweep'}, -- Targeted ability
}

champsToStun = {
                { charName = "Katarina",        spellName = "KatarinaR" ,                  important = 0},
                { charName = "Galio",           spellName = "GalioIdolOfDurand" ,          important = 0},
                { charName = "FiddleSticks",    spellName = "Crowstorm" ,                  important = 1},
                { charName = "FiddleSticks",    spellName = "DrainChannel" ,               important = 1},
                { charName = "Nunu",            spellName = "AbsoluteZero" ,               important = 0},
                { charName = "Shen",            spellName = "ShenStandUnited" ,            important = 0},
                { charName = "Urgot",           spellName = "UrgotSwap2" ,                 important = 0},
                { charName = "Malzahar",        spellName = "AlZaharNetherGrasp" ,         important = 0},
                { charName = "Karthus",         spellName = "FallenOne" ,                  important = 0},
                { charName = "Pantheon",        spellName = "PantheonRJump" ,              important = 0},
				{  charName = "Pantheon",        spellName = "PantheonRFall",               important = 0},
                { charName = "Varus",           spellName = "VarusQ" ,                     important = 1},
                { charName = "Caitlyn",         spellName = "CaitlynAceintheHole" ,        important = 1},
                { charName = "MissFortune",     spellName = "MissFortuneBulletTime" ,      important = 1},
                { charName = "Warwick",         spellName = "InfiniteDuress" ,             important = 0}
}

function OnLoad()
CheckStuff()
	qRng, wRng, eRng, rRng = 600, 625, 1040, 700
	Q = Spell(_Q, qRng)
	W = Spell(_W, wRng):SetSkillshot(VP, SKILLSHOT_CIRCULAR, 300, 0.5, 1750, false)
	E = Spell(_E, eRng):SetSkillshot(VP, SKILLSHOT_LINEAR, 90, 0.5, 1210, false)
	R = Spell(_R, rRng):SetSkillshot(VP, SKILLSHOT_CIRCULAR, 250, 0.5, 1210, false)
	DLib = DamageLib()
	--DamageLib:RegisterDamageSource(spellId, damagetype, basedamage, perlevel, scalingtype, scalingstat, percentscaling, condition, extra)
	DLib:RegisterDamageSource(_Q, _MAGIC, 80, 45, _MAGIC, _AP, 0.65, function() return (player:CanUseSpell(_Q) == READY)end)
	DLib:RegisterDamageSource(_E, _MAGIC, 70, 45, _MAGIC, _AP, 0.70, function() return (player:CanUseSpell(_E) == READY)end)
	DLib:RegisterDamageSource(_R, _MAGIC, 150, 100, _MAGIC, _AP, 0.55, function() return (player:CanUseSpell(_R) == READY)end)
	DFG = Item(3128,750)
	Config = scriptConfig("Ryuk's Viktor","Ryuks's Viktor")
	-- Key Binds
	Config:addSubMenu("Key Bindings","bind")
	Config.bind:addParam("active", "Combo", SCRIPT_PARAM_ONKEYDOWN, false, 32)

	Config.bind:addParam("harass", "Harass", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("C"))

	-- Options
	Config:addSubMenu("Combo settings","options")
		Config.options:addSubMenu("Use R on","targets")
	Config.options:addParam("useUlt", "Use R in Combo", SCRIPT_PARAM_ONOFF, true)
			Config.options:addParam("comboRHealth", "Enemy Health % before R", SCRIPT_PARAM_SLICE, 50, 0, 100, -1)
	Config.options:addParam("useStun", "Use W in Combo", SCRIPT_PARAM_ONOFF, true)
	
	
	
		Config:addSubMenu("Harass settings","hoptions")
				Config.hoptions:addParam("qhar", "Use Q in Harass", SCRIPT_PARAM_ONOFF, true)
	Config.hoptions:addParam("ehar", "Use E in Harass", SCRIPT_PARAM_ONOFF, true)

		
		
		Config:addSubMenu("Other settings","ooptions")
		Config.ooptions:addParam("gapClose", "Auto-W on Gap Close", SCRIPT_PARAM_ONOFF, true)
	Config.ooptions:addParam("stun", "Stun Prediction (Auto W)", SCRIPT_PARAM_ONOFF, true)
		Config.ooptions:addParam("interrupt", "Auto-Interrupt With W/R", SCRIPT_PARAM_ONOFF, true)
	Config.ooptions:addParam("useW", "Interrupt with W", SCRIPT_PARAM_ONOFF, true)
	Config.ooptions:addParam("useR", "Interrupt with R", SCRIPT_PARAM_ONOFF, true)

	for i, enemy in ipairs(GetEnemyHeroes()) do
			Config.options.targets:addParam(""..enemy.charName,"".. enemy.charName,SCRIPT_PARAM_ONOFF, true)
			
	end
	Config:addSubMenu("Draw","Draw")
	Config.Draw:addParam("drawq", "Draw Q", SCRIPT_PARAM_ONOFF, true)
	Config.Draw:addParam("draww", "Draw W", SCRIPT_PARAM_ONOFF, true)
	Config.Draw:addParam("drawe", "Draw E", SCRIPT_PARAM_ONOFF, true)
	Config.Draw:addParam("drawr", "Draw R", SCRIPT_PARAM_ONOFF, true)

	
		Combo = {_Q, _E, _R}
	ts = TargetSelector(TARGET_LESS_CAST,eRng,DAMAGE_MAGIC,false)
	ts.name = "Viktor"
	Config:addTS(ts)
	PrintChat("<font color='#E97FA5'> >> Ryuk's Viktor Fix Loaded!</font>")
	PrintChat("Ryuk's viktor Update 1.2: Improved E")
	
	if CheckStuff() then
		Orbwalker = SOW(VP)
	Config:addSubMenu("[Viktor - OrbWalking]", "SOWorb")
	Orbwalker:LoadToMenu(Config.SOWorb)
end
end

function OnTick()
	ts:update()
	if Config.bind.active then 
		fullCombo()
	end
	if ts.target then
		stormControl(ts.target)
	end
	if Config.ooptions.stun then
		stun()
	end
	if Config.bind.harass then
		harass()
	end
	end


function findSecondEnemy(first,range)
	count = nil
	current = nil
	for i, enemy in ipairs(GetEnemyHeroes()) do
		if enemy.charName ~= first.charName and GetDistance(enemy) < range then
			if count == nil then
				count = enemy.health
				current = enemy
			end
			if count > enemy.health then
				count = enemy.health
				current = enemy
			end
		end
	end
	return current
end
			


function shouldUlt()
	if ts.target then
		if 	Config.options.targets[""..ts.target.charName] then
			return true
		else
			return false
		end
	end
end
					

function harass()
	if ts.target then
		if Config.hoptions.ehar and E:IsReady() and E:IsInRange(ts.target, myHero) then
			pose = E:GetPrediction(ts.target)
			if pose ~= nil then
				if GetDistance(ts.target) < 540 then
					ECast(ts.target.x,ts.target.z,pose.x,pose.z)
				else
					start = Vector(myHero) + (myHero - pose)*(-550/GetDistance(pose))
					ECast(start.x,start.z,pose.x,pose.z)				end
			end
		if Config.hoptions.qhar and Q:IsReady() and Q:IsInRange(ts.target,myHero) then
			CastSpell(_Q,ts.target)
		end
	
		end
	end
end

function isFacing(source, target, lineLength)
	local sourceVector = Vector(source.visionPos.x, source.visionPos.z)
	local sourcePos = Vector(source.x, source.z)
	sourceVector = (sourceVector-sourcePos):normalized()
	sourceVector = sourcePos + (sourceVector*(GetDistance(target, source)))
	return GetDistanceSqr(target, {x = sourceVector.x, z = sourceVector.y}) <= (lineLength and lineLength^2 or 90000)
end

function stun()
	if ts.target then
		if W:IsReady() and W:IsInRange(ts.target,myHero) then
			posw = W:GetPrediction(ts.target)
			if posw ~= nil then
					if isFacing(ts.target,myHero) then
						pw = Vector(posw) - 150 * (Vector(posw) - Vector(myHero)):normalized()
					else
						pw = Vector(posw) + 150 * (Vector(posw) - Vector(myHero)):normalized()
					end
					CastSpell(_W,pw.x,pw.z)
			end
		end
	end
end

function fullCombo()
	if ts.target then
			if E:IsReady() then
			pose = E:GetPrediction(ts.target)
			if pose ~= nil then
				if GetDistance(ts.target) < 540 then
Packet('S_CAST', { spellId = SPELL_3, fromX = ts.target.x, ts.target.z, toX = pose.x, toY = pose.z }):send()
				else
			start = Vector(myHero) - 530 * (Vector(myHero) - Vector(ts.target)):normalized()
Packet('S_CAST', { spellId = SPELL_3, fromX = start.x, start.z, toX = pose.x, toY = pose.z }):send()
				end
			end
		end
			if Q:IsReady() and Q:IsInRange(ts.target,myHero) then
			CastSpell(_Q,ts.target)
			myHero:Attack(ts.target)
		end
		if W:IsReady() and W:IsInRange(ts.target,myHero) and Config.options.useStun then
			posw = W:GetPrediction(ts.target)
			if posw ~= nil then
				if W:IsInRange(ts.target,myHero) and W:IsReady() then
					if isFacing(ts.target,myHero) then
						pw = Vector(posw) - 150 * (Vector(posw) - Vector(ts.target)):normalized()
					else
						pw = Vector(posw) + 150 * (Vector(posw) - Vector(ts.target)):normalized()
					end
					CastSpell(_W,pw.x,pw.z)
				end
			end
		end

		if Config.options.useUlt and R:IsReady() and R:IsInRange(ts.target, myHero) and shouldUlt() and ts.target.health  < (ts.target.maxHealth * ( Config.options.comboRHealth / 100)) then
			posr = R:GetPrediction(ts.target)
			if posr ~= nil then
				R:Cast(ts.target.x,ts.target.z)
			end
		end
	end
end


function stormControl(target)
	if myHero:GetSpellData(_R).name == "viktorchaosstormguide" then
		CastSpell(_R, target.x, target.z)
	end
end

function OnDraw()
	if Config.Draw.drawq then
		DrawCircle(myHero.x,myHero.y,myHero.z,qRng,0xFFFF0000)
	end 
	if Config.Draw.draww then
		DrawCircle(myHero.x,myHero.y,myHero.z,wRng,0xFFFF0000)
	end
	if Config.Draw.drawe then
		DrawCircle(myHero.x,myHero.y,myHero.z,eRng,0xFFFF0000)
	end
	if Config.Draw.drawr then
		DrawCircle(myHero.x,myHero.y,myHero.z,rRng,0xFFFF0000)
	end
end

function OnProcessSpell(unit, spell)
	if Config.ooptions.gapClose and W:IsReady() then
		local jarvanAddition = unit.charName == "JarvanIV" and unit:CanUseSpell(_Q) ~= READY and _R or _Q 
		if unit.type == 'obj_AI_Hero' and unit.team == TEAM_ENEMY then
			local spellName = spell.name
			if gapCloseList[unit.charName] and spellName == gapCloseList[unit.charName].spell and GetDistance(unit) < 2000 then
				if spell.target ~= nil and spell.target.name == myHero.name or gapCloseList[unit.charName].spell == 'blindmonkqtwo' then
				--pos = W:GetPrediction(unit)
				--if pos then
					CastSpell(_W,myHero.x,myHero.z)
				end
			end
		end
	end
	if Config.ooptions.interrupt then
		if unit.type == 'obj_AI_Hero' and unit.team == TEAM_ENEMY and GetDistance(unit) < (wRng or rRng) then
		   	local spellName = spell.name
			for i = 1, #champsToStun do
				if unit.charName == champsToStun[i].charName and spellName == champsToStun[i].spellName then
					if champsToStun[i].important == 0 then
						if Config.ooptions.useW and W:IsReady() and W:IsInRange(ts.target,myHero) then
							CastSpell(_W,unit.x,unit.z)
						end
						if Config.ooptions.useR and R:IsReady() and R:IsInRange(ts.target,myHero) then
							CastSpell(_R,unit.x,unit.z)
						end
					else
						if Config.ooptions.useW and W:IsReady() and W:IsInRange(ts.target,myHero) then
							CastSpell(_W,unit.x,unit.z)
						end
						if Config.ooptions.useR and R:IsReady() and R:IsInRange(ts.target,myHero) then
							CastSpell(_R,unit.x,unit.z)
						end
					end
				end
			end
		end
	end	
end

function ECast(sx,sz,ex,ez)
	Packet('S_CAST', { spellId = SPELL_3, fromX = sx, fromY = sz, toX = ex, toY = ez }):send()
end
							
