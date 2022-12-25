-- © 2020 Hype Unity
local renderData = {}
local data = {}
players = {}
local Key = "tab"
local scoreboardState = false
renderData.sWidth, renderData.sHeight = guiGetScreenSize()
renderData.wWidth, renderData.wHeight = renderData.sWidth / 2, renderData.sHeight / 2
local maxRows = 8 
local Distance = 40
local drawX = renderData.wWidth - 285
local drawY = renderData.wHeight - 110
local currentRow = 1
local movingcounter = 1

local screenX, screenY = guiGetScreenSize()
local selectWidth = 400
local selectHeight = 470
local selectPosX = (screenX / 2) - (selectWidth / 2)
local selectPosY = (screenY / 2) - (selectHeight / 2)
local bgMargin = 1
--local customFont = dxCreateFont("files/font.ttf", 19, false, "cleartype")
local customFont = "default-bold"


bindKey(Key, "down", 
    function() 
        if getElementData(localPlayer, "loggedin") then
            scoreboardState = true
            addEventHandler("onClientRender", getRootElement(), renderScoreboard)
            showChat(false)
            toggleControl("action", false)
        end
    end
)

bindKey(Key, "up", 
    function() 
        if getElementData(localPlayer, "loggedin") then    
            scoreboardState = false
            removeEventHandler("onClientRender", getRootElement(), renderScoreboard)
            showChat(true)
            toggleControl("action", true)
        end
    end        
)

function renderScoreboard()
	if scoreboardState then
	onlinePlayers = {} 
	for k,v in ipairs(getElementsByType("player")) do
		onlinePlayers[k] = v
	end
	table.sort(onlinePlayers, function(a, b)
		if a ~= localPlayer and b ~= localPlayer and getElementData(a, "account:id") and getElementData(b, "account:id" ) then
			return tonumber(getElementData(a, "account:id") or 0) < tonumber(getElementData(b, "account:id") or 0)
		end
	end)
	
       -- exports.ng_blur:createBlur()
		dxDrawImage(selectPosX-50, selectPosY-70, 677, 680, "files/score.png", 0, 0, 0, tocolor(255, 255, 255, 255))
		dxDrawText(getCurrentPlayers(), selectPosX + 395, selectPosY + 19, 0, 0, tocolor(255, 255, 255, 204), 1, customFont, "left", "top", false, false, true, true, true)
	 	latestLine = currentRow + maxRows - 1
	    counter = 0  
		for k,v in pairs(onlinePlayers) do
			if k >= currentRow then
		    	if k <= latestLine then
		        	counter = counter + 1
					panelfY = drawY + (Distance * (counter - 1))
					if not getElementData(v, "loggedin") then
						alpha = 60
					else
						alpha = 204
					end
					dxDrawImage(renderData.wWidth - 200, panelfY - 18, 505, 36, "files/bar.png", 0, 0, 0, tocolor(0, 0, 0, 255))
					local adminduty = getElementData(v, "duty_admin")
					local supduty = getElementData(v, "duty_supporter")
					local adminlevel = getElementData(v, "admin_level") or "Player"
					local suplevel = getElementData(v, "supporter_level") or "Player"
					local scrlevel = getElementData(v, "scripter_level") or "Player"
					local spawned = getElementData(v, "loggedin")
					local ID = getElementData(v, "account:id")
					local hours = getElementData(v, "hoursplayed")
					local name = getElementData(v, "account:username")
					local nameChar = getPlayerName(localPlayer):gsub("_", " ")
					local rank = exports.global:getPlayerAdminTitle(localPlayer)
					if spawned then
					--name = getElementData(v,"visibleName"):gsub("_", " ")
					name = getElementData(v, "account:username")
					end
					
					if adminlevel == 1 then
						adminname = "TA"
					elseif adminlevel == 2 then
					    adminname = "AD"
					elseif adminlevel == 3 then
					    adminname = "SA"	
					elseif adminlevel == 4 then
					    adminname = "LA"
					elseif suplevel == 1 then
						adminname = "SP"
					elseif suplevel == 2 then
						adminname = "SP"
					elseif scrlevel == 1 then
						adminname = "Dev"
					elseif scrlevel == 2 then
						adminname = "Dev"
					elseif scrlevel == 3 then
						adminname = "Dev"
					else	
					    adminname = adminlevel
					end					
					--if getElementData(v, "afk") then
					 --   name = name.." #fe771d(AFK)"
					--end
					if adminduty == 1 or supduty == 1 then
						aColor = tocolor(254, 119, 29, apha)
					--elseif supduty == 1 then
						--aColor = tocolor(51, 255, 51, apha)
					else	
					    aColor = tocolor(255, 255, 255, alpha)
					end
					local ping = getPlayerPing(v)
					if adminduty == 1 then
						pingColor = tocolor(254, 119, 29, alpha)
					elseif ping <= 150 then
						pingColor = tocolor(255, 255, 255, alpha)
					elseif ping > 220 then
						pingColor = tocolor(173, 19, 19, alpha)
					end
					
					if not (adminlevel == 1337) then
						if spawned and (adminduty==1) then
						dxDrawImage(drawX + 30, panelfY - 177, 677, 680, "files/adminduty.png", 0, 0, 0, tocolor(255, 255, 255, 200), true)	
						end
						if spawned and (adminlevel>=1) and (adminduty==0) then
						dxDrawImage(drawX + 30, panelfY - 177, 677, 680, "files/admin.png", 0, 0, 0, tocolor(255, 255, 255, 200), true)
						end		            
						--if spawned and (adminlevel>=1) then
						if spawned then
						dxDrawText (hours, drawX + 1005, panelfY - 6, drawX, panelfY, aColor, 1, customFont, "center", "top", false, false, true, true)
						end
					end
					
					dxDrawText (ID, drawX + 350, panelfY - 6, drawX, panelfY, aColor, 1, customFont, "center", "top", false, false, true, true)
					--dxDrawText (name, drawX + 230, panelfY - 6, drawX, panelfY, aColor, 1, customFont, "left", "top", false, false, true, true)
					dxDrawText (ping, drawX + 855, panelfY - 6, drawX, panelfY, pingColor, 1, customFont, "center", "top", false, false, true, true)
					dxDrawText (hours, drawX + 1005, panelfY - 6, drawX, panelfY, aColor, 1, customFont, "center", "top", false, false, true, true)
					if adminlevel >= 1 then
					dxDrawText (nameChar .. " (" .. name .. ")" .. " (" .. adminname .. ")", drawX + 230, panelfY - 6, drawX, panelfY, aColor, 1, customFont, "left", "top", false, false, true, true)
					else
					dxDrawText (nameChar .. "(" .. adminname .. ")", drawX + 230, panelfY - 6, drawX, panelfY, aColor, 1, customFont, "left", "top", false, false, true, true)
					end
				end
			end
		end
	end
end

addEventHandler("onClientPlayerQuit", getRootElement(), 
	function() 
		if source then
			onlinePlayers = {}
		end
	end
)

function getCurrentPlayers()
	return #getElementsByType("player")
end

bindKey("mouse_wheel_down", "down", 
	function() 
		if scoreboardState then
			if currentRow < #onlinePlayers - 7 then
				currentRow = currentRow + 1		
			end
		end
	end
)

bindKey("mouse_wheel_up", "down", 
	function() 
		if scoreboardState then
			if currentRow > 1 then
				currentRow = currentRow - 1		
			end
		end
	end
)