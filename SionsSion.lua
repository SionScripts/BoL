print("Sion's Sion script Version 1.0")
print("Thank you for using")
require "VPrediction"


local VP = VPrediction()
local ts

function OnLoad()


	--[Menu]--
	Config = scriptConfig("Sion by Sion", "sion")
	--[Hotkeys]--
	Config:addSubMenu("Combat hotkeys", "hotkeys")
Config.hotkeys:addParam("combo", "Combo mode", SCRIPT_PARAM_ONKEYDOWN, false, string.byte(" "))
--[Combo]--
		Config:addSubMenu("Combo", "Combo")
				Config.Combo:addParam("Q", "Use Q in Combo", SCRIPT_PARAM_ONOFF, true)
						Config.Combo:addParam("W", "Use W in Combo", SCRIPT_PARAM_ONOFF, true)
								Config.Combo:addParam("E", "Use E in Combo", SCRIPT_PARAM_ONOFF, true)
			--[Ultimate]--
				Config:addSubMenu("Ultimate control", "ulty")
		Config.ulty:addParam("ultimate", "Ultimate control", SCRIPT_PARAM_ONOFF, true)
		--[Draw]--
	Config:addSubMenu("Draw", "draw")
	Config.draw:addParam("drawCircle", "Draw Q range", SCRIPT_PARAM_ONOFF, true)
			--[other]--
							Config:addSubMenu("other", "other")
	Config.other:addParam("printHp", "Health warning", SCRIPT_PARAM_ONOFF, true)

	ts = TargetSelector(TARGET_LOW_HP_PRIORITY,800)
end
 

function OnTick()

	--[Target update]--


	ts:update()
	
	if (ts.target ~= nil) then
		-- Spacebar pressed ?
		if (Config.hotkeys.combo) then

	if (myHero:CanUseSpell(_E) == READY) then
   if (Config.Combo.E) then
      CastPosition,  HitChance,  Position = VP:GetLineCastPosition(target, delay, width, range, speed, myHero, isCollision)
      if CastPosition then
         CastSpell(_E, CastPosition.x, CastPosition.z)
      end
   end
end

			if (myHero:CanUseSpell(_W) == READY) then
					if (Config.Combo.W) then
				CastSpell(_W, ts.target.x,ts.target.z)
			end
		end
if (myHero:CanUseSpell(_Q) == READY) then
   if (Config.Combo.Q) then
      CastPosition,  HitChance,  Position = VP:GetLineCastPosition(target, delay, width, range, speed, myHero, isCollision)
      if CastPosition then
         CastSpell(_Q, CastPosition.x, CastPosition.z)
      end
   end
end
		end
	end
	
	
	if TargetHaveBuff("SionR", myHero) then
	if Config.ulty.ultimate then
local Pos = Vector(myHero) + 400 * (Vector(mousePos) - Vector(myHero)):normalized()
myHero:MoveTo(Pos.x, Pos.z)
end
end
end
 
function OnDraw()
	if (Config.draw.drawCircle) then
		DrawCircle(myHero.x, myHero.y, myHero.z, 800, 0x111111)
	end
	
	-- Show HP warning
	if (Config.printHp) then
		if (myHero.health < 200) then
			DrawText("Warning: LOW HP! Drink a potion!", 18, 100, 100, 0xFFFFFF00)
		end
	end
end

function setSummonerSlots() -- sets heal to summoner slot
--set heal
if player:GetSpellData(SUMMONER_1).name == "summonerheal" then
HL_slot = SUMMONER_1
elseif player:GetSpellData(SUMMONER_2).name == "summonerheal" then
HL_slot = SUMMONER_2
end
end
