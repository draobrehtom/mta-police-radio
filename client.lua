local bufferSound = {} 
local bufferString = "[R]:"
local bindButton = {}
local iterations = 1																			
local a 																
local iBuffer = 1
local turn = true

local screenWidth, screenHeight = guiGetScreenSize()
local stringToDraw
local text
local height = 500
--[[
playSFX("genrl", 136, 10, false) - police radio sheeeeee
playSFX("genrl", 52, 14, false) - sounds effects
playSFX("genrl", 75, 7, false) - main theme loading
playSound("OFFICERSNEEDASSISTANCE.mp3")



--]]


--[[These sounds have to be just from the SFX archive 'Script'. The current version does not support the other archives]]--
--[[Developed by D.Kabanov - draobrehtom@gmail.com, Skype - draobrehtom]]
--[[Do not forget to put the commas in the array when you add new sounds or pages]]
local p = 	
{
	--Place names for crime reports--
	cityHall = {0, 19, "City Hall"},
	downTownLosSantos = {0, 27, "downtown Los Santos"},
	eastLosSantos = {0, 28, "east Los Santos"},
	losSantos = {0, 86, "Los Santos"},
	sanFierro = {0, 168, "San Fierro"},
	--//--

	--Vehicle colors for crime reports--
	dark = {1, 6, "dark"},
	light = {1, 10, "light"},
	red = {1, 12, "red"},
	green = {1, 8, "green"},
	blue = {1, 1, "blue"},
	customized = {1, 5, "customized"},
	--//--

	--Directions for crime reports--
	aCenteral = {2, 0, "a centeral"},
	east = {2, 1, "east"},
	north = {2, 2, "north"},
	south = {2, 3, "south"},
	west = {2, 4, "west"},
	--//--

	--Locations for crime reports--
	canYouATen = {3, 0, "can you a ten"},
	inA = {3, 1, "in a"},
	inWater = {3, 2, "in water"},
	onA = {3, 3, "on a"},
	onFoot = {3, 4, "on foot"},
	respondYourATen = {3, 5, "respond your a ten"},
	suspectInWater = {3, 6, "suspect in water"},
	suspectLastSeen = {3, 7, "suspect last seen"},
	weGotATen = {3, 8, "we got a ten"},
	--//--

	--10-code pieces for crime reports--
	code70in = {4, 0, "70 in"}, -- prowler (wor) or fire			[10]
	code21in = {4, 1, "21 in"}, -- telephone						[9]
	code24in = {4, 2, "24 in"}, -- assigment complied				[4]
	code29in = {4, 3, "29 in"}, -- check for wanted					[5]
	code34in = {4, 4, "34 in"}, -- riot								[8]
	code37in = {4, 5, "37 in"}, -- investigate, suspicios vehicle 	[1]
	code7in = {4, 6, "7 in"},	-- out of service					[5]
	code71in = {4, 7, "71 in"}, -- shooting							[2]
	code61in = {4, 8, "61 in"}, -- personnel in areas				[7]
	code90in = {4, 9, "90 in"}, -- alarm at a __					[6]
	code91in = {4, 10, "91 in"}, -- hazard							[3]
	--aTen = {4, 11, "a 10-"},
	--aTen = {4, 12, "a 10-"},
	--aTen = {4, 13, "a 10-"}
	--//--

	--Vehicle types for crime reports--
	twoDoor = {5, 0, "two door"},
	fourDoor = {5, 1, "four door"},
	bike = {5, 5, "bike"},
	boat = {5, 6, "boat"},
	coach = {5, 11, "coach"},
	motorBike = {5, 33, "motorbike"},
	taxi = {5, 52, "taxi"},
	--//--

	--Others--
	dontMove = {162, 2, "Police! Don't move!"},
	beeeeeep = {6, 0, "beeeeeeep"} -- surpise
	--//--
	
	--name = {, , "your description"}
};


--[[You can bind a nine keys simultaneously. From 1 to 9				]]--
--[[You can create multiple pages to play sounds						]]--
--[[  Index 	Page  	Sound1 - "1" 	Sound2 - "2"	"3" - "9 		]]--
--[[  [1] = 	{1, 	p.dontMove, 	p.code37in, , , , , , , , },	]]--

-- p.canYouATen p.suspectLastSeen

-- p.canYouATen p.code37in p.north p.idlewood p.suspectLastSeen p.onFoot
-- p.weGotATen p.code37in p.north p.idlewood p.suspectLastSeen p.onFoot
-- p.weGotATen p.code70in p.north p.idlewood p.suspectLastSeen p.onFoot
-- p.respondYourATen p.code37in p.north p.idlewood p.suspectLastSeen p.onFoot
-- p.suspectLastSeen (in a?) p.red p.fourDoor || p.two

-- p.respondYourATen p.code24in p.suspectLastSeen p.policeCar

local pages = 	
{
	[1] = {1, p.weGotATen, p.canYouATen, p.respondYourATen},
	[2] = {2, p.code37in, p.code71in, p.code91in, p.code24in, p.code7in, p.code90in, p.code61in, p.code34in, p.code21in},
	[3] = {3, p.aCenteral, p.north, p.south, p.west, p.east},
	[4] = {4, p.losSantos, p.downTownLosSantos},
	[5] = {5, p.suspectLastSeen},
	[6] = {6, p.onFoot, p.onA},
	[7] = {7, p.dark, p.red, p.green, p.blue, p.light, p.customized},
	[8] = {8, p.fourDoor, p.twoDoor, p.motorBike, p.bike, p.taxi, p.coach, p.boat}
	--[9] = {9, p.west},
	--[10] = {10, p.west},
	--[11] = {11, p.west},
	--[12] = {12, p.west},
	--[13] = {13, p.west},
	--[14] = {14, p.west},
	--[15] = {15, p.west},
	--[16] = {16, p.west},
	--[17] = {17, p.west}
};






function drawText()
	dxDrawText(text, 20, screenHeight - height, screenWidth, screenHeight, tocolor( 0, 0, 0, 255 ), 1.04, "arial")
	dxDrawText (text, 20, screenHeight - height, screenWidth, screenHeight, tocolor ( 255, 255, 255, 255 ), 1, "arial") 

end
function handleRenderingText(text, height)
	addEventHandler("onClientRender", root, drawText)
	--removeEventHandler( "onClientRender", root, drawText())
end

function iBufferRetrive()
	turn = false
	iBuffer = iBuffer + 1
	setTimer(finalPlaySound, sLength, 1)
end


function finalPlaySound()
	if turn then
		sLength = playSoundFrom(bufferSound[1])
	end
	if iBuffer <= #bufferSound then
		setTimer(function()
					sLength = playSoundFrom(bufferSound[iBuffer])
				end, sLength, 1)
		iBufferRetrive()
	else
		turn = true
		iBuffer = 1
		bufferString = "[R]:"
		unbindKey("Z", "down", finalPlaySound)
		bindKey( "Z", "down", getLevel)
	end
end


function playSoundFrom(sound)
	return getSoundLength(playSFX("script", sound[1], sound[2], false)) * 1000
end
		

function bindedPlay(keyBind, lvlSound, sound)

	text = "[" ..(lvlSound - 1).. "] " ..keyBind.. ". " ..sound[3]
	handleRenderingText()
	height = height - 15
	bindKey(keyBind, "down", function()
							height = 500
							bufferSound[lvlSound - 1] = sound
							playSoundFrom(sound)
							outputChatBox("[" ..(lvlSound - 1).. "] " ..keyBind.. ". " ..sound[3])
							for k,v in pairs(bindButton) do
								unbindKey(""..v.."", "down")
							end
							bufferString = bufferString .. " " .. sound[3]
							iterations = iterations + 1
							nextLevelSound()
							end)
end


local playPageSoundsFromTable = function(page, ... ) 
									bindButton = {}
									for i = 1, arg.n do
										bindButton[i] = "" .. i
										bindedPlay(bindButton[i], page + 1, arg[i])
									end
								end


function nextLevelSound()
	if iterations <= a then
		pg = pages[iterations]
		playPageSoundsFromTable(unpack(pg))
	else
		iterations = 1
		outputChatBox( "Press Z to confirm.")
		bindKey("Z", "down", finalPlaySound)
	end
	
end


function getLevel()
	outputChatBox("Press a number:")
	a = #pages
	nextLevelSound()
	unbindKey("Z", "down")
	bindKey( "Z", "down", reset)
end
bindKey( "Z", "down", getLevel)
