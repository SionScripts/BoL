
local version = 1.0
local AUTOUPDATE = true
local SCRIPT_NAME = "SionsYoMomma"
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

print("Sion's Yo Momma script Version 1.0")
print("Press T to do a joke *Don't hold it or it will spam*")


local yomumma = {
	"Yo momma's so ugly when she joined an ugly contest, they said 'Sorry, no professionals.'"	, "Yo momma's so ugly they didn't give her a costume when she tried out for Star Wars."
	,"Yo momma's so ugly that when she sits in the sand on the beach, cats try to bury her."
	, "Yo momma's so ugly they pay her to put her clothes on in strip joints"
, "Yo momma's so ugly when she walks down the street in September, people say 'Damn, is it Halloween already?"
, "Yo momma's so ugly when she walks into a bank, they turn off the surveillence cameras"
, "Yo momma's so ugly the government moved Halloween to her birthday."
, "Yo momma's so ugly that if ugly were bricks she'd have her own projects."
, "Yo momma's so ugly she made an onion cry."
, "Yo momma's so ugly she turned Medusa to stone!"
, "Yo momma's so stupid, she got fired from the M&M factory for throwing away all the W's."
, "Yo momma's so stupid, when she went to take the 44 bus, she took the 22 twice instead."
, "Yo momma's so stupid, she ordered her sushi well done."
, "Yo momma is so fat, I took a picture of her last Christmas and it's still printing."
, "Yo momma is so fat when she got on the scale it said, 'I need your weight not your phone number.'"
, "Yo momma's so fat and old when God said, 'Let there be light,' he asked your mother to move out of the way.'"
}

function OnLoad()
    Menu = scriptConfig("Yo Momma", "yomomma")
		Menu:addParam("enab", "Enable script", SCRIPT_PARAM_ONOFF, true)
			Menu:addParam("Joke", "Joke", SCRIPT_PARAM_ONOFF, false, jke)
		end
		
		
		function OnTick()
if IsKeyPressed(84) then
makeajoke()
end
end
		
		function makeajoke()
		SendChat(yomumma[ math.random( #yomumma ) ])
		end


