---------------------------
--Developer = Dharma (AbdulMalik FM)
--Description = هذا المود يجمع عدة خصائص داخل نافذة واحدة ويساعد الحكومة على تقفي المجرمين بكل سهولة
--Server Type = RolePlay
--For Project = لايوجد مشروع الى الان-- *
--Version = 1.0.0
--Other Version = يوجد نسخة قادمة مستقبلا باضافات اكثر وخيارات اوسع
--* Thank You ^_^
---------------------------
DGS = exports['dgs-master']
Noti = exports['info-box']
plate = dxCreateTexture(":resources/other.png")
phone = dxCreateTexture(":resources/phone_icon.png")
veh = dxCreateTexture(":resources/vehicles.png")


function MainWindow()
DGS:dgsSetInputMode("no_binds_when_editing")
local screenW, screenH = guiGetScreenSize()
local playerFaction = getPlayerTeam(localPlayer)
local factionName = getTeamName(playerFaction)
robotoFont11 = DGS:dgsCreateFont(":job-system/storekeeper/files/Roboto-Regular.ttf", 11)
robotoboldFont14 = DGS:dgsCreateFont(":resources/Roboto-Bold.ttf", 14)
ChaletLondon1960_11 = DGS:dgsCreateFont(":resources/ChaletLondon1960.ttf", 11)

		mainRect = DGS:dgsCreateRoundRect(0, false,tocolor(40,39,41,255))
		btnRect = DGS:dgsCreateRoundRect(15, false, tocolor(15,15,15,255))
		upperRect = DGS:dgsCreateRoundRect(0, false, tocolor(15,15,15,255))
		btnRecthov = DGS:dgsCreateRoundRect(15, false, tocolor(255, 51, 51, 200))
		btnRectClick = DGS:dgsCreateRoundRect(15, false, tocolor(255, 51, 51, 255)) 
		
		Wnd = DGS:dgsCreateImage((screenW - 611) / 2, (screenH - 293) / 2, 611, 293,mainRect,false)
		
		
		upperImg = DGS:dgsCreateImage(0, 0, 611, 55,upperRect,false,Wnd)
		DGS:dgsSetEnabled(upperImg, false)
		
		logo = DGS:dgsCreateImage(0, 0, 212, 47,":resources/logosecsystem.png",false, Wnd)
		DGS:dgsSetEnabled(logo, false)
		clsBtn = DGS:dgsCreateButton(575, 18, 23, 19, "", false, Wnd, tocolor(200, 200, 200, 255), _, _, ":interaction/icons/cross_x.png", ":interaction/icons/cross_x.png", ":interaction/icons/cross_x.png",_, tocolor(255,51,51,200), tocolor(255, 51, 51, 255))

        mainGrid = DGS:dgsCreateGridList(0, 54, 211, 239, false, Wnd, _, tocolor(10,10,10,255), _, tocolor(10,10,10,255))
		DGS:dgsGridListSetNavigationEnabled(mainGrid, false)
		local column = DGS:dgsGridListAddColumn( mainGrid, "", 1 )
           -- row = DGS:dgsGridListAddRow(maingrid)
		for i = 1, 3 do
		DGS:dgsGridListAddRow(mainGrid)
		DGS:dgsGridListSetItemText(mainGrid, 1, column, "       Track By Plate", false)
		DGS:dgsGridListSetItemText(mainGrid, 2, column, "       Track By Phone", false)
		DGS:dgsGridListSetItemText(mainGrid, 3, column, "       Show Vehicles Tickets", false)
		
		DGS:dgsSetProperty(mainGrid,"rowHeight",40)
		DGS:dgsGridListSetColumnHeight(mainGrid, 0)

		DGS:dgsGridListSetRowBackGroundColor(mainGrid,1,tocolor(25, 25, 25, 200),tocolor(255,51,51,200),tocolor(255,51,51,255))
		DGS:dgsGridListSetRowBackGroundColor(mainGrid,2,tocolor(15, 15, 15, 200),tocolor(255,51,51,200),tocolor(255,51,51,255))
		DGS:dgsGridListSetRowBackGroundColor(mainGrid,3,tocolor(25, 25, 25, 200),tocolor(255,51,51,200),tocolor(255,51,51,255))
		
		DGS:dgsGridListSetItemImage(mainGrid,1,1,plate,tocolor(255,255,255,255),-5,2,32,32,false)
		DGS:dgsGridListSetItemImage(mainGrid,2,1,phone,tocolor(255,255,255,255),-5,5,32,32,false)
		DGS:dgsGridListSetItemImage(mainGrid,3,1,veh,tocolor(255,255,255,255),-5,5,32,32,false)
		
		DGS:dgsSetProperty(mainGrid,"font",robotoFont11)
		end
		DGS:dgsGridListSetSelectedItem (mainGrid, 1)
        facName = DGS:dgsCreateLabel(228, 5, 345, 47, factionName, false, Wnd, tocolor(200, 200, 200, 255))
        playerName = DGS:dgsCreateLabel(228, 30, 345, 47, "#c8c8c8Welcome Back #ff3333" .. getPlayerName(localPlayer):gsub("_", " "), false, Wnd, tocolor(200, 200, 200, 255))
		DGS:dgsSetProperty(facName,"font",robotoboldFont14)
		DGS:dgsSetProperty(playerName,"font",ChaletLondon1960_11)
		DGS:dgsSetProperty(playerName,"colorcoded",true)
		-------Track By Plate
		searchBtn = DGS:dgsCreateButton(322, 250, 173, 32, "Search", false, Wnd, tocolor(200, 200, 200, 255), _, _, btnRect, btnRecthov, btnRectClick)
        searchEdit = DGS:dgsCreateEdit(306, 93, 199, 30, "", false, Wnd, _, _, _, _, tocolor(15,15,15,255))
		DGS:dgsEditSetPlaceHolder(searchEdit, "Insert Vehicle Plate")
		DGS:dgsSetProperty(searchEdit,"font",robotoFont11)
		DGS:dgsSetProperty(searchEdit,"placeHolderFont",robotoFont11)
		DGS:dgsSetProperty(searchBtn,"font",robotoFont11)
		--------------------
		--------Track By Phone--------
        PsearchEdit = DGS:dgsCreateEdit(306, 75, 199, 30, "", false, Wnd, _, _, _, _, tocolor(15,15,15,255))
		DGS:dgsEditSetPlaceHolder(PsearchEdit, "Insert Name")
		DGS:dgsSetProperty(PsearchEdit,"font",robotoFont11)
		DGS:dgsSetProperty(PsearchEdit,"placeHolderFont",robotoFont11)
		PsearchBtn = DGS:dgsCreateButton(230, 250, 173, 32, "Search", false, Wnd, tocolor(200, 200, 200, 255), _, _, btnRect, btnRecthov, btnRectClick)
		PmarkBtn = DGS:dgsCreateButton(420, 250, 173, 32, "Mark", false, Wnd, tocolor(200, 200, 200, 255), _, _, btnRect, btnRecthov, btnRectClick)
		DGS:dgsSetProperty(PsearchBtn,"font",robotoFont11)
		DGS:dgsSetProperty(PmarkBtn,"font",robotoFont11)
		playerGrid = DGS:dgsCreateGridList(262, 120, 307, 120, false, Wnd, _, tocolor(10,10,10,255), _, tocolor(10,10,10,255))
		playerName = DGS:dgsGridListAddColumn(playerGrid, "Name", 0.4)
        phoneNo = DGS:dgsGridListAddColumn(playerGrid, "Phone Number", 0.3)
		DGS:dgsSetVisible(playerGrid, false)
		DGS:dgsSetVisible(PsearchBtn, false)
		DGS:dgsSetVisible(PsearchEdit, false)
		DGS:dgsSetVisible(PmarkBtn, false)
		--------------------
		-------Show Vehicles Tickets-----
		TsearchEdit = DGS:dgsCreateEdit(306, 75, 199, 30, "", false, Wnd, _, _, _, _, tocolor(15,15,15,255))
		DGS:dgsEditSetPlaceHolder(TsearchEdit, "Insert Vehicle Plate")
		DGS:dgsSetProperty(TsearchEdit,"font",robotoFont11)
		DGS:dgsSetProperty(TsearchEdit,"placeHolderFont",robotoFont11)
		
		TsearchBtn = DGS:dgsCreateButton(322, 250, 173, 32, "Search", false, Wnd, tocolor(200, 200, 200, 255), _, _, btnRect, btnRecthov, btnRectClick)
		DGS:dgsSetProperty(TsearchBtn,"font",robotoFont11)
		vehTicketGrid = DGS:dgsCreateGridList(262, 120, 307, 120, false, Wnd, _, tocolor(10,10,10,255), _, tocolor(10,10,10,255))
		DGS:dgsSetVisible(vehTicketGrid, false)
		DGS:dgsSetVisible(TsearchBtn, false)
		DGS:dgsSetVisible(TsearchEdit, false)
		IDticketp = DGS:dgsGridListAddColumn(vehTicketGrid, "ID", 0.1)
        Amountticketp = DGS:dgsGridListAddColumn(vehTicketGrid, "Amount", 0.3)
        DateTicketp = DGS:dgsGridListAddColumn(vehTicketGrid, "Date", 0.4)
        VINticketp = DGS:dgsGridListAddColumn(vehTicketGrid, "VIN", 0.15)
        ResTicketp = DGS:dgsGridListAddColumn(vehTicketGrid, "Reason", 0.4)
        IssuerTicketp = DGS:dgsGridListAddColumn(vehTicketGrid, "Issuer", 0.4)
        PlateTicketp = DGS:dgsGridListAddColumn(vehTicketGrid, "Plate", 0.3)
        vehModelTicketp = DGS:dgsGridListAddColumn(vehTicketGrid, "Vehicle Model", 0.4)
        AreaTicketp = DGS:dgsGridListAddColumn(vehTicketGrid, "Area", 0.6)
        DepTicketp = DGS:dgsGridListAddColumn(vehTicketGrid, "Department", 0.6)
    end
addEvent("gov:showGovGUI", true)
addEventHandler("gov:showGovGUI", getRootElement(), MainWindow)
addCommandHandler("gov", MainWindow)
--addEventHandler("onClientResourceStart", resourceRoot, MainWindow)

addEventHandler("onDgsMouseClickDown", root, function ()
	if source == clsBtn then
	DGS:dgsSetVisible(Wnd, false)
	end
end)

addEventHandler ( "onDgsMouseClickDown", root, function ( button, state  )
	if source == mainGrid then 
		local Selected = DGS:dgsGridListGetSelectedItem(mainGrid)
		if Selected == 1 then 
			DGS:dgsSetVisible(searchEdit, not DGS:dgsGetVisible(searchEdit))
			DGS:dgsSetVisible(searchBtn, not DGS:dgsGetVisible(searchBtn))
			DGS:dgsSetVisible(vehTicketGrid, false)
			DGS:dgsSetVisible(TsearchEdit, false)
			DGS:dgsSetVisible(TsearchBtn, false)
			DGS:dgsSetVisible(playerGrid, false)
			DGS:dgsSetVisible(PsearchBtn, false)
			DGS:dgsSetVisible(PsearchEdit, false)
			DGS:dgsSetVisible(PmarkBtn, false)
		elseif Selected == 2 then
			DGS:dgsSetVisible(playerGrid, not DGS:dgsGetVisible(playerGrid))
			DGS:dgsSetVisible(PsearchBtn, not DGS:dgsGetVisible(PsearchBtn))
			DGS:dgsSetVisible(PsearchEdit, not DGS:dgsGetVisible(PsearchEdit))
			DGS:dgsSetVisible(PmarkBtn, not DGS:dgsGetVisible(PmarkBtn))
			DGS:dgsSetVisible(searchEdit, false)
			DGS:dgsSetVisible(searchBtn, false)
			DGS:dgsSetVisible(vehTicketGrid, false)
			DGS:dgsSetVisible(TsearchBtn, false)
			DGS:dgsSetVisible(TsearchEdit, false)
			DGS:dgsGridListClear(playerGrid)
		elseif Selected == 3 then
			DGS:dgsSetVisible(vehTicketGrid, not DGS:dgsGetVisible(vehTicketGrid))
			DGS:dgsSetVisible(TsearchBtn, not DGS:dgsGetVisible(TsearchBtn))
			DGS:dgsSetVisible(TsearchEdit, not DGS:dgsGetVisible(TsearchEdit))
			DGS:dgsSetVisible(searchEdit, false)
			DGS:dgsSetVisible(searchBtn, false)
			DGS:dgsSetVisible(playerGrid, false)
			DGS:dgsSetVisible(PsearchBtn, false)
			DGS:dgsSetVisible(PsearchEdit, false)
			DGS:dgsSetVisible(PmarkBtn, false)
		end
	end
end )
--Track By Plate--
addEventHandler("onDgsMouseClickDown", root,
function ()
local plate = DGS:dgsGetText(searchEdit)
if source == searchBtn then
	if plate == "" or plate == " " or plate == "  " then
		Noti:showInfobox("error", "Please fill the gaps!")
	else
		triggerServerEvent("GiveMeThat", localPlayer, plate)
end
	end
		end)
		
------------------
------Track By Phone------
addEventHandler("onDgsMouseClickDown", root,
function ()
if source == PsearchBtn then
DGS:dgsGridListClear(playerGrid)
NameEdit = DGS:dgsGetText(PsearchEdit):gsub("_", " ")
triggerServerEvent("onClientWantToSearch", localPlayer, NameEdit)
	end
end)

addEventHandler("onDgsMouseClickDown",root,function()
if ( source == PmarkBtn ) then
local selectedplayer =  DGS:dgsGridListGetItemText ( playerGrid, DGS:dgsGridListGetSelectedItem ( playerGrid ), 1 )
local playe = getPlayerFromName(selectedplayer)
local Me = getLocalPlayer()
--elseif exports.global:hasItem(playe, 2) then
blip = createBlipAttachedTo ( playe, 61, 2, 255, 0, 0, 255, 0, 99999.0, getRootElement() )
	setTimer ( function()
	destroyElement(blip)
	end, 50000, 0 )
--table.insert (Blips, blip)
--else
--destroyElement(blip)
--table.remove(Blips, blip)

--elseif ( source == GUIEditor.button[2] ) then
--for _,v in ipairs ( Blips ) do
-- destroyElement(v)
--end
end
end
 )
 
 function ShowPhoneNumber(phoneNumber)
		local row = DGS:dgsGridListAddRow(playerGrid)
		for i, v in ipairs (phoneNumber) do
			local pn = phoneNumber[i][1]
			local name = phoneNumber[i][2]
			DGS:dgsGridListSetItemText(playerGrid, row, phoneNo, tostring(pn), false, false)
			DGS:dgsGridListSetItemText(playerGrid, row, playerName, tostring(name), false, false)
		--------------------
		end

end
addEvent("ShowPhoneNumbersToPolice", true)
addEventHandler("ShowPhoneNumbersToPolice", getRootElement(), ShowPhoneNumber)
--------------------------

------Show Vehicles Tickets--------
addEventHandler("onDgsMouseClickDown", root,
function ()
if source == TsearchBtn then
plateData = DGS:dgsGetText(TsearchEdit)
triggerServerEvent("onClientClickSearch", localPlayer, plateData)
	end
end)

function ShowTickets(Tickets)
		local rowp = DGS:dgsGridListAddRow(vehTicketGrid)
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
			DGS:dgsGridListSetItemText(vehTicketGrid, rowp, IDticketp, tostring(IDp), false, false)
			DGS:dgsGridListSetItemText(vehTicketGrid, rowp, Amountticketp, tostring(Amountp), false, false)
			DGS:dgsGridListSetItemText(vehTicketGrid, rowp, DateTicketp, tostring(Datep), false, false)
			DGS:dgsGridListSetItemText(vehTicketGrid, rowp, VINticketp, tostring(VINp), false, false)
			DGS:dgsGridListSetItemText(vehTicketGrid, rowp, ResTicketp, tostring(Reasonp), false, false)
			DGS:dgsGridListSetItemText(vehTicketGrid, rowp, IssuerTicketp, tostring(Issuerp), false, false)
			DGS:dgsGridListSetItemText(vehTicketGrid, rowp, PlateTicketp, tostring(Platep), false, false)
			DGS:dgsGridListSetItemText(vehTicketGrid, rowp, vehModelTicketp, tostring(vehModelp), false, false)
			DGS:dgsGridListSetItemText(vehTicketGrid, rowp, AreaTicketp, tostring(Areap), false, false)
			DGS:dgsGridListSetItemText(vehTicketGrid, rowp, DepTicketp, tostring(Depp), false, false)
		--------------------
		end

end
addEvent("ShowTicketsToPolice", true)
addEventHandler("ShowTicketsToPolice", getRootElement(), ShowTickets)
-----------------------------------
--[[
addEventHandler("onClientResourceStart", resourceRoot,
    function()
local screenW, screenH = guiGetScreenSize()
        GUIEditor.window[1] = guiCreateWindow((screenW - 611) / 2, (screenH - 333) / 2, 611, 333, "", false)
        guiWindowSetSizable(GUIEditor.window[1], false)

        GUIEditor.gridlist[1] = guiCreateGridList(10, 83, 211, 237, false, GUIEditor.window[1])
        GUIEditor.label[1] = guiCreateLabel(9, 26, 212, 47, "Logo", false, GUIEditor.window[1])
        GUIEditor.label[2] = guiCreateLabel(228, 26, 345, 47, "Some shit", false, GUIEditor.window[1])
        GUIEditor.button[1] = guiCreateButton(322, 288, 173, 32, "Search", false, GUIEditor.window[1])
        GUIEditor.label[3] = guiCreateLabel(573, 22, 23, 19, "Cls", false, GUIEditor.window[1])
        GUIEditor.edit[1] = guiCreateEdit(306, 93, 199, 30, "", false, GUIEditor.window[1])
        GUIEditor.gridlist[2] = guiCreateGridList(262, 90, 307, 188, false, GUIEditor.window[1])    
    end
)
       GUIEditor.window[1] = guiCreateWindow(378, 218, 611, 333, "", false)]]