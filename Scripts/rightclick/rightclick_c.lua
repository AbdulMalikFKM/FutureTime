--    ____        __     ____  __            ____               _           __ 
--   / __ \____  / /__  / __ \/ /___ ___  __/ __ \_________    (_)__  _____/ /_
--  / /_/ / __ \/ / _ \/ /_/ / / __ `/ / / / /_/ / ___/ __ \  / / _ \/ ___/ __/
-- / _, _/ /_/ / /  __/ ____/ / /_/ / /_/ / ____/ /  / /_/ / / /  __/ /__/ /_  
--/_/ |_|\____/_/\___/_/   /_/\__,_/\__, /_/   /_/   \____/_/ /\___/\___/\__/  
--                                 /____/                /___/                 
--Client-side script: Rightclick
--Last updated 2022 by Dharma
--Copyright 2008-2011, The Roleplay Project (www.roleplayproject.com)
local DGS = exports['dgs-master']
rcmenu = false

function destroy()
	destroyTimer = nil
	if rcmenu then
		destroyElement(rcmenu)
	end
	rcWidth = 0
	rcHeight = 0
	rcmenu = nil
	if isCursorShowing() then
		showCursor(false)
		--triggerEvent("cursorHide", getLocalPlayer())
	end
	return true
end


function leftClickAnywhere(button, state, absX, absY, wx, wy, wz, element)
	if(button == "left" and state == "down") then
		if isElement(rcmenu) then
			destroyTimer = setTimer(destroy, 250, 1) --100
			--guiSetVisible(rcmenu, false)
		end
	end
end
addEventHandler("onClientClick", getRootElement(), leftClickAnywhere, true)
addEvent("serverTriggerLeftClick", true)
addEventHandler("serverTriggerLeftClick", localPlayer, leftClickAnywhere)

function create(title)
	if(destroyTimer) then
		killTimer(destroyTimer)
		destroyTimer = nil
	end
	if(rcmenu) then
		destroy()
	end
	if not title then title = "" end
	local x,y,wx,wy,wz = getCursorPosition()
	robotoFont14 = DGS:dgsCreateFont(":resources/fonts/Roboto-Regular.ttf", 14)
	robotoFont11 = DGS:dgsCreateFont(":resources/fonts/Roboto-Regular.ttf", 11)
	--font = DGS:dgsCreateFont(":account/login-panel/DIN-NEXT-LT-W23-REGULAR.TTF", 12)
	rcmenu = DGS:dgsCreateImage(x,y,0,0,"0.png",true)
	--rcTitleBg = DGS:dgsCreateImage(0,0,0,0,"0.png",false,rcmenu)
	--if getElementType(rcmenu) == "vehicle" then
	rcTitle = DGS:dgsCreateLabel(10,0,0,0,tostring(title),false,rcmenu)
	DGS:dgsSetProperty(rcTitle,"colorCoded",true)
	DGS:dgsSetProperty(rcTitle,"font", robotoFont14)
	--DGS:dgsSetFont(rcTitle,"default-bold")
	DGS:dgsLabelSetColor ( rcTitle, 200, 200, 200, 255 )
	--DGS:dgsLabelSetColor(rcTitle,255,255,255)
	DGS:dgsLabelSetVerticalAlign(rcTitle, "center", false)
	DGS:dgsLabelSetHorizontalAlign(rcTitle, "center", false)
	DGS:dgsSetFont(rcTitle, robotoFont10)
	local extent = DGS:dgsLabelGetTextExtent(rcTitle)
	--DGS:dgsSetSize(rcTitleBg,500,30,false)
	DGS:dgsSetSize(rcTitle,extent,30,false)
	rcWidth = extent + 20
	rcHeight = 30
	DGS:dgsSetSize(rcmenu,rcWidth,rcHeight,false)
		startY = 0
	return rcmenu
	--end
end

function addRow(title,header,nohover)
	local row
	local image
	if not title then title = "" end
	if header then
		--local rowbg = DGS:dgsCreateImage(0,rcHeight,500,30,"0.png",false,rcmenu)
		local textX = 10+19+10 --margin+img+margin
		local addWidth = textX + 10
		row = DGS:dgsCreateLabel(textX,-7,0,0,"\n\n\n	"..tostring(title),false,rcmenu)
			DGS:dgsSetProperty(row,"colorCoded",true)
			DGS:dgsSetProperty(row,"font",robotoFont11)
			--DGS:dgsSetFont(row, font)
		--DGS:dgsSetFont(row,"default-bold")
		DGS:dgsLabelSetColor(row,200,200,200,255)
		DGS:dgsLabelSetVerticalAlign(row, "center")
		--DGS:dgsLabelSetHorizontalAlign(row, "left", false)
		local extent = DGS:dgsLabelGetTextExtent(row)
		DGS:dgsSetSize(row,extent,30,false)
		rcHeight = rcHeight + 30
		if(extent + addWidth > rcWidth) then
			rcWidth = extent + addWidth
		end
		DGS:dgsSetSize(rcmenu,rcWidth,rcHeight,false)
	else
		color = tocolor(53, 53, 53, 50)
		--color = tocolor(53, 53, 53, 100)
		hovercolor = tocolor(7, 112, 196, 200)
		--hovercolor = tocolor(255, 198, 0, 200)
		clickcolor = tocolor(0, 163, 255, 255)
		--clickcolor = tocolor(255, 198, 0, 255)
		if string.sub(title, 0, 3) == "ADM" or string.sub(title, 0,5) == "admin" or string.sub(title, 0,3) == "adm" or string.sub(title, 0,5) == "ADMIN" then
		color = tocolor(255, 51, 51, 175)
		--color = tocolor(255, 51, 51, 175)
		hovercolor = tocolor(255, 51, 51, 200)
		--hovercolor = tocolor(255, 51, 51, 200)
		clickcolor = tocolor(255, 51, 51, 255)
		--clickcolor = tocolor(255, 51, 51, 255)
	end
		local textX = 10+19+10 --margin+img+margin
		local addWidth = textX + 5
		--row = DGS:dgsCreateLabel(textX,rcHeight,0,0,tostring(title),false,rcmenu)
		row = DGS:dgsCreateButton(0,0,rcWidth,40,tostring(title),false,rcmenu,tocolor(200,200,200,255), _, _, _, _, _, color, hovercolor, clickcolor)
		
		DGS:dgsSetProperty(row,"colorTransitionPeriod",350)
		DGS:dgsSetProperty(row,"font",robotoFont11)
		
		rcHeight = rcHeight + 40
		DGS:dgsSetSize(rcmenu,rcWidth,rcHeight,false)
		DGS:dgsSetAlpha(rcmenu,0)
		DGS:dgsAlphaTo(rcmenu,1,"Linear",500)
		DGS:dgsSetAlpha(row,0)
		DGS:dgsAlphaTo(row,1,"Linear",500)
		DGS:dgsMoveTo(row,0,rcHeight-40,false,false,"Linear",1)  --Some Anim
		if not nohover then
			addEventHandler("onDgsMouseEnter",row,function()
			playSound("click.ogg")
			end,false)
		end
	end
	return row
end

function addrow(title,header,nohover) --for compatibility (older versions used lowercase function names, which is still being called to by some older scripts)
	return addRow(title,header,nohover)
end