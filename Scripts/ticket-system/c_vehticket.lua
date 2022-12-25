------------------------
--Developer = Dharma (AbdulMalik FM)
--Description = يسمح لك هذا المود بمخالفة مركبات اللاعبين وسيتم رفع المخالفة مباشرة على قاعدة البيانات ويمكن الاطلاع عليها من قبل الاعب في مركز الشرطة
--Server Type = RolePlay
--For Project = لايوجد مشروع الى الان
-- Note = I don't have copyright for pictures and sound also the gui-library(dgs)
------------------------


local localPlayer = getLocalPlayer()
--local atmPed = createPed( 113, 1511.4228515625, -1741.6103515625, 13.546875 )
local atmPed = createPed( 113, 246.5869140625, 118.529296875, 1003.21875 )
setPedRotation( atmPed, 180 )
setElementDimension( atmPed, 1158)
setElementInterior( atmPed , 10 )
setElementData( atmPed, "talk", 1, false )
setElementData( atmPed, "name", "John K. Lother", false )
--setPedAnimation ( atmPed, "INT_OFFICE", "OFF_Sit_Bored_Loop", -1, true, false, false )
setElementFrozen(atmPed, true)
DGS = exports['dgs-master']
local screenW, screenH = guiGetScreenSize()

function ShowTicketsGUI(name, TicketInfos) 
        Tkwin = guiCreateWindow((screenW - 367) / 2, (screenH - 362) / 2, 367, 362, "", false)
        guiWindowSetSizable(Tkwin, false)

        GridList = guiCreateGridList(9, 31, 348, 279, false, Tkwin)
        Buy = guiCreateButton(9, 329, 153, 23, "Pay", false, Tkwin)
        Close = guiCreateButton(194, 329, 153, 23, "Close", false, Tkwin)   
		    local IDticket =  guiGridListAddColumn(GridList, "ID", 0.2)
	 local Amountticket =  guiGridListAddColumn(GridList, "Amount", 0.2)
     local DateTicket =   guiGridListAddColumn(GridList, "Date", 0.2)
      local VINticket =  guiGridListAddColumn(GridList, "VIN", 0.2)
       local ResTicket = guiGridListAddColumn(GridList, "Reason", 0.5)
       local IssuerTicket = guiGridListAddColumn(GridList, "Issuer", 0.5)
       local PlateTicket = guiGridListAddColumn(GridList, "Plate", 0.5)
       local vehModelTicket = guiGridListAddColumn(GridList, "Vehicle Model", 0.5)
       local AreaTicket = guiGridListAddColumn(GridList, "Area", 0.5)
       local DepTicket = guiGridListAddColumn(GridList, "Department", 0.5)
		for key, value in pairs(TicketInfos) do
			local ID = TicketInfos[key][1]
			local Amount = TicketInfos[key][2]
			local Date = TicketInfos[key][3]
			local VIN = TicketInfos[key][4]
			local Reason = TicketInfos[key][5]
			local Issuer = TicketInfos[key][6]
			local Plate = TicketInfos[key][7]
			local vehModel = TicketInfos[key][8]
			local Area = TicketInfos[key][9]
			local Dep = TicketInfos[key][10]
			local row = guiGridListAddRow(GridList)
			--local namec = exports.global:getCharacterNameFromID(tostring(Issuer))
			guiGridListSetItemText(GridList, row, IDticket, tostring(ID), false, false)
			guiGridListSetItemText(GridList, row, Amountticket, tostring(Amount), false, false)
			guiGridListSetItemText(GridList, row, DateTicket, tostring(Date), false, false)
			guiGridListSetItemText(GridList, row, VINticket, tostring(VIN), false, false)
			guiGridListSetItemText(GridList, row, ResTicket, tostring(Reason), false, false)
			guiGridListSetItemText(GridList, row, IssuerTicket, tostring(Issuer), false, false)
			guiGridListSetItemText(GridList, row, PlateTicket, tostring(Plate), false, false)
			guiGridListSetItemText(GridList, row, vehModelTicket, tostring(vehModel), false, false)
			guiGridListSetItemText(GridList, row, AreaTicket, tostring(Area), false, false)
			guiGridListSetItemText(GridList, row, DepTicket, tostring(Dep), false, false)
		end
		addEventHandler("onClientGUIClick", Buy,  function (button, state)

		local rowSelect, colSelect = guiGridListGetSelectedItem(GridList)
		if (rowSelect==-1) or (colSelect==-1) then
		return
		else
		local ticketId = guiGridListGetItemText(GridList, guiGridListGetSelectedItem(GridList), 1)
		 triggerServerEvent("payTicket", getRootElement(), getLocalPlayer(), ticketId)
		 showCursor(false) 
		 guiSetVisible(Tkwin, false)
		 destroyElement(Tkwin)
						end
					end, true)
					triggerEvent("hud:convertUI", localPlayer, Tkwin, "ticket", name)
end
addEvent("ShowTicketsGUI", true)
addEventHandler("ShowTicketsGUI", getRootElement(), ShowTicketsGUI)

	addEventHandler("onClientGUIClick",root, 
function() 
if source == Close then 
showCursor(false) 
 guiSetVisible(Tkwin, false)
destroyElement(Tkwin)
end  
end
)

addEvent("tt", true)
addEventHandler("tt", getRootElement(),
function ()
triggerServerEvent("ShowMyTickets", getRootElement(), getLocalPlayer())
end)
local speed = 200
local removespeed = 100
local T = ""

function writeText()
    local text = getPlayerName(localPlayer):gsub("_", " ")
    setTimer(function (  )
        local c = string.sub(text,string.len(T)+1,string.len(T)+1)
        T = T..c
    end,speed,string.len(text))
end

function removeText()
    local text = getPlayerName(localPlayer):gsub("_", " ")
    setTimer(function (  )
        T = string.sub(text,0,string.len(T)-1 )
    end,removespeed,string.len(text))
end

function policeTicket()
DGS:dgsSetInputMode("no_binds_when_editing")

	signtureFont = DGS:dgsCreateFont(":job-system/storekeeper/files/lunabar.ttf", 20)
	handFont = DGS:dgsCreateFont(":job-system/storekeeper/files/hand.otf", 14)
	ttime = getRealTime()
	year = ttime.year +1900
	month = ttime.month
	day = ttime.monthday
	minute = ttime.minute
        parkimg = DGS:dgsCreateImage((screenW - 323) / 2, (screenH - 520) / 2, 323, 520, ":ticket-system/files/parking.png", false)

        punshEdit = DGS:dgsCreateEdit(14, 100, 144, 30, year.."/"..month.."/"..day, false, parkimg, _, _, _, _, tocolor(0, 0, 0, 0))
        amountEdit =  DGS:dgsCreateEdit(168, 100, 144, 30, "", false, parkimg, _, _, _, _, tocolor(0, 0, 0, 0))
        plateEdit =  DGS:dgsCreateEdit(14, 138, 298, 30, "", false, parkimg, _, _, _, _, tocolor(0, 0, 0, 0))
        vehModelEdit =  DGS:dgsCreateEdit(14, 175, 298, 30, "", false, parkimg, _, _, _, _, tocolor(0, 0, 0, 0))
        areaEdit =  DGS:dgsCreateEdit(14, 212, 298, 30, "", false, parkimg, _, _, _, _, tocolor(0, 0, 0, 0))
        reasonEdit =  DGS:dgsCreateEdit(14, 252, 298, 30, "", false, parkimg, _, _, _, _, tocolor(0, 0, 0, 0))
        depEdit =  DGS:dgsCreateEdit(14, 289, 298, 30, "", false, parkimg, _, _, _, _, tocolor(0, 0, 0, 0))
        crimEdit =  DGS:dgsCreateEdit(10, 463, 140, 30, "", false, parkimg, _, _, _, _, tocolor(0, 0, 0, 0))
        issueBtn =  DGS:dgsCreateButton(167, 463, 140, 30, "", false, parkimg)     
		DGS:dgsSetAlpha(issueBtn, 0)

		DGS:dgsSetProperty(punshEdit, "textColor", tocolor(0, 0, 0, 255))
		DGS:dgsSetProperty(punshEdit, "readOnly", true)
		DGS:dgsSetProperty(punshEdit, "readOnlyCaretShow", false)
		DGS:dgsSetFont(punshEdit, handFont)
		
		DGS:dgsSetProperty(amountEdit, "textColor", tocolor(0, 0, 0, 255))
		DGS:dgsSetProperty(amountEdit, "caretColor", tocolor(0, 0, 0, 0))
		DGS:dgsSetFont(amountEdit, handFont)
		
		DGS:dgsSetProperty(plateEdit, "textColor", tocolor(0, 0, 0, 255))
		DGS:dgsSetProperty(plateEdit, "caretColor", tocolor(0, 0, 0, 0))
		DGS:dgsSetFont(plateEdit, handFont)
		
		DGS:dgsSetProperty(vehModelEdit, "textColor", tocolor(0, 0, 0, 255))
		DGS:dgsSetProperty(vehModelEdit, "caretColor", tocolor(0, 0, 0, 0))
		DGS:dgsSetFont(vehModelEdit, handFont)
	
		DGS:dgsSetProperty(areaEdit, "textColor", tocolor(0, 0, 0, 255))
		DGS:dgsSetProperty(areaEdit, "caretColor", tocolor(0, 0, 0, 0))
		DGS:dgsSetFont(areaEdit, handFont)
		
		DGS:dgsSetProperty(reasonEdit, "textColor", tocolor(0, 0, 0, 255))
		DGS:dgsSetProperty(reasonEdit, "caretColor", tocolor(0, 0, 0, 0))
		DGS:dgsSetFont(reasonEdit, handFont)
		
		DGS:dgsSetProperty(depEdit, "textColor", tocolor(0, 0, 0, 255))
		DGS:dgsSetProperty(depEdit, "caretColor", tocolor(0, 0, 0, 0))
		DGS:dgsSetFont(depEdit, handFont)
	
		DGS:dgsSetProperty(crimEdit, "textColor", tocolor(0, 0, 0, 0))
		DGS:dgsSetProperty(crimEdit, "readOnly", true)
		DGS:dgsSetProperty(crimEdit, "readOnlyCaretShow", false)
		DGS:dgsSetFont(crimEdit, handFont)
end

function destroyWindow()
	if DGS:dgsSetVisible(parkimg, true) then
		DGS:dgsSetVisible(parkimg, false)
		destroyElement(parkimg)
		removeEventHandler("onClientRender", root, signture)
	end
end
bindKey("end", "down", destroyWindow)

addEvent("onPoliceIssueTicket", true)
addEventHandler("onPoliceIssueTicket", getRootElement(),
function (vehicle, thePlayer)
vehicleOwner = getElementData(vehicle, "owner") or -1
--outputChatBox(vehicleOwner)
veh = getElementData(vehicle, "dbid")
policeTicket()
DGS:dgsSetText(crimEdit, vehicleOwner)
--DGS:dgsSetText(crimEdit, vehicleOwner)
end)
	
addEventHandler("onDgsMouseClick", getRootElement(),
function (button, state)
	if button == "left" then
		if state == "up" then
			if source == issueBtn then
				if (DGS:dgsGetText (amountEdit) == "" or DGS:dgsGetText (amountEdit) == " ") and (DGS:dgsGetText (reasonEdit) == "" or DGS:dgsGetText (reasonEdit) == " ") and (DGS:dgsGetText (plateEdit) == "" or DGS:dgsGetText (plateEdit) == " ") and (DGS:dgsGetText (vehModelEdit) == "" or DGS:dgsGetText (vehModelEdit) == " ") and (DGS:dgsGetText (areaEdit) == "" or DGS:dgsGetText (areaEdit) == " ") and (DGS:dgsGetText (depEdit) == "" or DGS:dgsGetText (depEdit) == " ") then
				exports['cr_infobox']:addBox("error", "Complete The Form!")
				--exports.notification:addNotification("الرجاء ملء الاستمارة", "success")
				return false
			else
			exports['cr_infobox']:addBox("success", "The Ticket Has Been Successfully Issued!")
			--exports.notification:addNotification("تم اصدار مخالفة بنجاح", "success")
			writeText()
			amount = DGS:dgsGetText(amountEdit)
			reason = DGS:dgsGetText(reasonEdit)
			plate = DGS:dgsGetText(plateEdit)
			vehModel = DGS:dgsGetText(vehModelEdit)
			area = DGS:dgsGetText(areaEdit)
			dep = DGS:dgsGetText(depEdit)
			vehOwner = DGS:dgsGetText(crimEdit)
			Name = getPlayerName(localPlayer) 
			triggerServerEvent("onIssueSuccess",localPlayer, amount, reason, veh, Name, vehOwner, plate, vehModel, area, dep)
			DGS:dgsSetInputEnabled(true)
			addEventHandler("onClientRender", root, signture)
			playSound(":ticket-system/files/sign.mp3")
setTimer (function ()
	destroyElement(parkimg)
	removeEventHandler("onClientRender", root, signture)
	playSound(":ticket-system/files/paper-rip.mp3")
	removeText()
	DGS:dgsSetInputEnabled(false)
end, 2900, 1)
				end
			end
		end 
	end
end)

function signture ()
	lunabar = dxCreateFont(":job-system/storekeeper/files/lunabar.ttf", 20)
	dxDrawText(T, screenW * 0.5102, screenH * 0.7773, screenW * 0.6010, screenH * 0.8021, tocolor(0, 0, 0, 255), 1.00, lunabar, "center", "top", false, false, true, true, false)
	--dxDrawText(T, screenW * 0.5112, screenH * 0.8533, screenW * 0.6737, screenH * 0.8683, tocolor(0, 0, 0, 255), 1.00, lunabar, "center", "top", false, false, true, true, false)
end

-----------

--[[
function showAllTickets(Tickets)
        --guiGridListClear(gridlistPolice)
local screenW, screenH = guiGetScreenSize()
        wndPolice = guiCreateWindow((screenW - 352) / 2, (screenH - 320) / 2, 352, 320, "Check Pending Ticket - Police Department", false)
        guiWindowSetSizable(wndPolice, false)
		
        searchEdit = guiCreateEdit(98, 29, 156, 29, "Enter Vehicle Plate", false, wndPolice)
        gridlistPolice = guiCreateGridList(9, 98, 333, 193, false, wndPolice)
		closeBtn = guiCreateButton(111, 292, 133, 18, "Close", false, wndPolice)
        searchBtn = guiCreateButton(109, 64, 135, 24, "Search", false, wndPolice)
		
        local IDticketp = guiGridListAddColumn(gridlistPolice, "ID", 0.1)
        local Amountticketp = guiGridListAddColumn(gridlistPolice, "Amount", 0.1)
        local DateTicketp = guiGridListAddColumn(gridlistPolice, "Date", 0.1)
        local VINticketp = guiGridListAddColumn(gridlistPolice, "VIN", 0.1)
        local ResTicketp = guiGridListAddColumn(gridlistPolice, "Reason", 0.1)
        local IssuerTicketp = guiGridListAddColumn(gridlistPolice, "Issuer", 0.1)
        local PlateTicketp = guiGridListAddColumn(gridlistPolice, "Plate", 0.1)
        local vehModelTicketp = guiGridListAddColumn(gridlistPolice, "Vehicle Model", 0.1)
        local AreaTicketp = guiGridListAddColumn(gridlistPolice, "Area", 0.1)
        local DepTicketp = guiGridListAddColumn(gridlistPolice, "Department", 0.1)
		
			for i, v in ipairs (Tickets) do
			local IDp = Tickets[i][1]
			local Amountp = Tickets[i][2]
			local Datep = Tickets[i][3]
			local VINp = Tickets[i][4]
			local Reasonp = Tickets[i][5]
			local Issuerp = Tickets[i][6]
			local Platep = Tickets[i][7]
			local vehModelp = Tickets[i][8]
			local Areap = Tickets[i][9]
			local Depp = Tickets[i][10]
			local rowp = guiGridListAddRow(gridlistPolice)
			guiGridListSetItemText(gridlistPolice, rowp, IDticketp, tostring(IDp), false, false)
			guiGridListSetItemText(gridlistPolice, rowp, Amountticketp, tostring(Amountp), false, false)
			guiGridListSetItemText(gridlistPolice, rowp, DateTicketp, tostring(Datep), false, false)
			guiGridListSetItemText(gridlistPolice, rowp, VINticketp, tostring(VINp), false, false)
			guiGridListSetItemText(gridlistPolice, rowp, ResTicketp, tostring(Reasonp), false, false)
			guiGridListSetItemText(gridlistPolice, rowp, IssuerTicketp, tostring(Issuerp), false, false)
			guiGridListSetItemText(gridlistPolice, rowp, PlateTicketp, tostring(Platep), false, false)
			guiGridListSetItemText(gridlistPolice, rowp, vehModelTicketp, tostring(vehModelp), false, false)
			guiGridListSetItemText(gridlistPolice, rowp, AreaTicketp, tostring(Areap), false, false)
			guiGridListSetItemText(gridlistPolice, rowp, DepTicketp, tostring(Depp), false, false)
	end
end
addEvent("ShowTicketsToPolice", true)
addEventHandler("ShowTicketsToPolice", getRootElement(), showAllTickets)


function ttr ()
showAllTickets()
--triggerServerEvent("onClientClickSearch", getRootElement(), getLocalPlayer())
--triggerServerEvent("onClientClickSearch", localPlayer)
end
addCommandHandler("tt", ttr)

addEventHandler("onClientGUIClick", root,
function ()
if source == searchBtn then
plateData = guiGetText(searchEdit)
triggerServerEvent("onClientClickSearch", localPlayer, plateData)
guiSetVisible(wndPolice, not guiGetVisible(wndPolice))
elseif source == closeBtn then
guiSetVisible(wndPolice, false)
	--destoryElement(wndPolice)
	end
end)
]]