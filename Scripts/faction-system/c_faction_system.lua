--[[
* Copyright (c) 2022 Future Time - All Rights Reserved
* All rights reserved. This program and the accompanying materials are private property belongs to OwlGaming Community
* GUI Copyright Reserved To thisdp (DGS)
* Edited By Dharma (AbdulMalik FM) 
]]

gFactionWindow, gMemberGrid, gMOTDLabel, colName, colRank, colWage, colDuty, colLastLogin, --[[colLocation,]] colLeader, colOnline, colPhone, gButtonKick, gButtonPromote, gButtonDemote, gButtonEditRanks, gButtonEditMOTD, gButtonInvite, gButtonLeader, gButtonQuit, gButtonExit, wConfirmQuit, eNote = nil
theMotd, theTeam, arrUsernames, arrRanks, arrPerks, arrLeaders, arrOnline, arrFactionRanks, --[[arrLocations,]] arrFactionWages, arrLastLogin, membersOnline, membersOffline, gButtonRespawn, gButtonPerk = nil
tabVehicles, gVehicleGrid, colVehID, colVehModel, colVehPlates, colVehLocation, gButtonVehRespawn, gButtonAllVehRespawn, gButtonYes, gButtonNo, showrespawnUI = nil
statue = getElementData(factionID, "JobApp:Statue")
local tmpPhone = nil
local promotionWindow = {}
local promotionButton = {}
local promotionLabel = {}
local promotionRadio = {}
local factionTable = {}
lRanks = { }
tRanks = { }
tRankWages = { }
wRanks = nil
bRanksSave, bRanksClose = nil
local screenW, screenH = guiGetScreenSize()

Duty = {
    gridlist = {},
    button = {},
    label = {}
}

DGS = exports['dgs-master']
Noti = exports['cr_infobox']
home = dxCreateTexture(":resources/images/home.png")
rank = dxCreateTexture(":resources/images/ranks.png")
member = dxCreateTexture(":resources/images/member.png")
duty = dxCreateTexture(":resources/images/duty.png")
veh = dxCreateTexture(":resources/images/vehicless.png")
online = dxCreateTexture(":resources/images/online.png")
offline = dxCreateTexture(":resources/images/offline.png")
ann = dxCreateTexture(":resources/images/ann.png")
finance = dxCreateTexture(":resources/images/finance.png")
tow = dxCreateTexture(":resources/images/description.png")

function showFactionMenu(motd, memberUsernames, memberRanks, memberPerks, memberLeaders, memberOnline, memberLastLogin, factionRanks, factionWages, factionTheTeam, note, fnote, vehicleIDs, vehicleModels, vehiclePlates, vehicleLocations, memberOnDuty, towstats, phone, membersPhone, fromShowF, factionID, birlikLevel, birlikOnay, statue)
	factionTable[factionID] = {motd, memberUsernames, memberRanks, memberPerks, memberLeaders, memberOnline, memberLastLogin, factionRanks, factionWages, factionTheTeam, note, fnote, vehicleIDs, vehicleModels, vehiclePlates, vehicleLocations, memberOnDuty, towstats, phone, membersPhone, fromShowF, factionID, birlikLevel, birlikOnay, statue}
	--renderFactionMenu = not renderFactionMenu()
	statue = setElementData(factionID, "JobApp:Statue", statue)
	if (gFactionWindow==nil) then
		renderFactionMenu()
		showCursor(true)
	end
end
addEvent("showFactionMenu", true)
addEventHandler("showFactionMenu", getRootElement(), showFactionMenu)

local function checkF3( )
	if not f3state and getKeyState( "f3" ) then
		hideFactionMenu( )
	else
		f3state = getKeyState( "f3" )
	end
end

function renderFactionMenu()
	faction = getElementData(localPlayer,"faction")
	newTable = factionTable[faction]
	motd, memberUsernames, memberRanks, memberPerks, memberLeaders, memberOnline, memberLastLogin, factionRanks, factionWages, factionTheTeam, note, fnote, vehicleIDs, vehicleModels, vehiclePlates, vehicleLocations, memberOnDuty, towstats, phone, membersPhone, fromShowF, factionID, birlikLevel, birlikOnay = newTable[1],newTable[2],newTable[3],newTable[4],newTable[5],newTable[6],newTable[7],newTable[8],newTable[9],newTable[10],newTable[11],newTable[12],newTable[13],newTable[14],newTable[15],newTable[16],newTable[17],newTable[18],newTable[19],newTable[20],newTable[21],newTable[22],newTable[23],newTable[24]
	
	if (gFactionWindow==nil) then
		invitedPlayer = nil
		arrUsernames = memberUsernames
		arrRanks = memberRanks
		arrLeaders = memberLeaders
		arrPerks = memberPerks
		arrOnline = memberOnline
		arrLastLogin = memberLastLogin
		factionID1 = factionID
		--arrLocations = memberLocation
		arrFactionRanks = factionRanks
		arrFactionWages = factionWages
		financeLoaded = false
		
		if (motd) == nil then motd = "" end
		theMotd = motd
		tmpPhone = phone
	
	
		local thePlayer = getLocalPlayer()
		theTeam = factionTheTeam
		local teamName = getTeamName(theTeam)
		local playerName = getPlayerName(thePlayer)
		--[[
				Roboto11 = DGS:dgsCreateFont(":resources/fonts/Roboto-Regular.ttf", 11)
		Roboto14 = DGS:dgsCreateFont(":resources/fonts/Roboto-Regular.ttf", 14)
		Roboto16 = DGS:dgsCreateFont(":resources/fonts/Roboto-Regular.ttf", 16)
		Roboto18 = DGS:dgsCreateFont(":resources/fonts/Roboto-Regular.ttf", 18)
		RobotoL16 = DGS:dgsCreateFont(":resources/fonts/Roboto-Light.ttf", 16)
		RobotoL18 = DGS:dgsCreateFont(":resources/fonts/Roboto-Light.ttf", 18)
		RobotoLI16 = DGS:dgsCreateFont(":resources/fonts/Roboto-Light-Italic.ttf", 16)
		RobotoLI24 = DGS:dgsCreateFont(":resources/fonts/Roboto-Light-Italic.ttf", 24)
		gtaFont2 = DGS:dgsCreateFont(":resources/fonts/gtaFont2.ttf", 40)
		Themify60 = DGS:dgsCreateFont(":resources/fonts/Themify.ttf", 60)
		RobotoB18 = DGS:dgsCreateFont(":resources/fonts/Roboto-Bold.ttf", 18)
		Themify18 = DGS:dgsCreateFont(":resources/fonts/Themify.ttf", 18)
		RobotoL14 = DGS:dgsCreateFont(":resources/fonts/Roboto-Light.ttf", 14)
		RobotoB14 = DGS:dgsCreateFont(":resources/fonts/Roboto-Bold.ttf", 14)

		metro18 = DGS:dgsCreateFont("metro.ttf", 18)
		metro60 = DGS:dgsCreateFont("metro.ttf", 60)
		]]
		robotoFont11 = DGS:dgsCreateFont(":resources/fonts/Roboto-Regular.ttf", 11)
		robotoFont14 = DGS:dgsCreateFont(":resources/fonts/Roboto-Regular.ttf", 14)
		robotoboldFont18 = DGS:dgsCreateFont(":resources/fonts/Roboto-Bold.ttf", 18)
		gtaFont15 = DGS:dgsCreateFont(":resources/fonts/gtaFont.ttf", 15)
		themify16 = DGS:dgsCreateFont(":resources/fonts/Themify.ttf", 16)
		
		mainRect = DGS:dgsCreateRoundRect(0, false,tocolor(20,20,20,255))
		rnkRect = DGS:dgsCreateRoundRect(0, false,tocolor(5,91,166,255))
		numRect = DGS:dgsCreateRoundRect(0, false,tocolor(2,113,104,255))
		vehRect = DGS:dgsCreateRoundRect(0, false,tocolor(136,103,48,255))
		radRect = DGS:dgsCreateRoundRect(0, false,tocolor(176,57,47,255))
		upperRect = DGS:dgsCreateRoundRect(0, false,tocolor(10,10,10,255))
		
		DmainRect = DGS:dgsCreateRoundRect(0, false,tocolor(20,20,20,255))
		DrnkRect = DGS:dgsCreateRoundRect(0, false,tocolor(20,20,20,255))
		DmemberRect = DGS:dgsCreateRoundRect(0, false,tocolor(20,20,20,255))
		DvehRect = DGS:dgsCreateRoundRect(0, false,tocolor(20,20,20,255))
		DannRect = DGS:dgsCreateRoundRect(0, false,tocolor(20,20,20,255))
		DfinanceRect = DGS:dgsCreateRoundRect(0, false,tocolor(20,20,20,255))
		DdutyRect = DGS:dgsCreateRoundRect(0, false,tocolor(20,20,20,255))
		DjobRect = DGS:dgsCreateRoundRect(0, false,tocolor(20,20,20,255))
		DtowRect = DGS:dgsCreateRoundRect(0, false,tocolor(20,20,20,255))
		
		---Btns--
		btnRect = DGS:dgsCreateRoundRect(15, false, tocolor(25,25,25,255))
		btnRecthov = DGS:dgsCreateRoundRect(15, false, tocolor(7, 112, 196, 200))
		btnRectClick = DGS:dgsCreateRoundRect(15, false, tocolor(0, 163, 255, 255)) 
		

		gFactionWindow = DGS:dgsCreateImage((screenW - 970) / 2, (screenH - 638) / 2, 970, 638,mainRect,false)
		DGS:dgsSetInputEnabled(true)
		DGS:dgsSetAlpha(gFactionWindow,0)
		DGS:dgsAlphaTo(gFactionWindow,1,"Linear",900)
		upperImg = DGS:dgsCreateImage(0, 0, 970, 65,upperRect,false,gFactionWindow)
		DGS:dgsSetEnabled(upperImg, false)
		
		logo = DGS:dgsCreateImage(10, 10, 196, 42,":resources/images/faclogo.png",false,gFactionWindow)
		
		maingrid = DGS:dgsCreateGridList(0, 65, 215, 573, false, gFactionWindow, _, tocolor(10,10,10,255), _, tocolor(10,10,10,255))
		local column = DGS:dgsGridListAddColumn( maingrid, "", 0.95 )
		DGS:dgsGridListSetNavigationEnabled(maingrid, false)

		for i = 1, 9 do
		row = DGS:dgsGridListAddRow(maingrid)
		end
		DGS:dgsGridListSetItemText(maingrid, 1, column, "        Home", false)
		DGS:dgsGridListSetItemText(maingrid, 2, column, "        Members", false)
		DGS:dgsGridListSetItemText(maingrid, 3, column, "        Ranks", false)
		DGS:dgsGridListSetItemText(maingrid, 4, column, "        Vehicles", false)
		DGS:dgsGridListSetItemText(maingrid, 5, column, "        Announcements", false)
		DGS:dgsGridListSetItemText(maingrid, 6, column, "        Finance", false)
		DGS:dgsGridListSetItemText(maingrid, 7, column, "        Duty", false)
		DGS:dgsGridListSetItemText(maingrid, 8, column, "        Job Applications", false)
		DGS:dgsGridListSetItemText(maingrid, 9, column, "        Towstats", false)
		
		DGS:dgsSetProperty(maingrid,"rowHeight",40)
		DGS:dgsGridListSetColumnHeight(maingrid, 0)

		DGS:dgsGridListSetRowBackGroundColor(maingrid,1,tocolor(25, 25, 25, 200),tocolor(7, 112, 196, 200),tocolor(7, 112, 196, 255))
		DGS:dgsGridListSetRowBackGroundColor(maingrid,2,tocolor(15, 15, 15, 200),tocolor(7, 112, 196, 200),tocolor(7, 112, 196, 255))
		DGS:dgsGridListSetRowBackGroundColor(maingrid,3,tocolor(25, 25, 25, 200),tocolor(7, 112, 196, 200),tocolor(7, 112, 196, 255))
		DGS:dgsGridListSetRowBackGroundColor(maingrid,4,tocolor(15, 15, 15, 200),tocolor(7, 112, 196, 200),tocolor(7, 112, 196, 255))
		DGS:dgsGridListSetRowBackGroundColor(maingrid,5,tocolor(25, 25, 25, 200),tocolor(7, 112, 196, 200),tocolor(7, 112, 196, 255))
		DGS:dgsGridListSetRowBackGroundColor(maingrid,6,tocolor(15, 15, 15, 200),tocolor(7, 112, 196, 200),tocolor(7, 112, 196, 255))
		DGS:dgsGridListSetRowBackGroundColor(maingrid,7,tocolor(25, 25, 25, 200),tocolor(7, 112, 196, 200),tocolor(7, 112, 196, 255))
		DGS:dgsGridListSetRowBackGroundColor(maingrid,8,tocolor(15, 15, 15, 200),tocolor(7, 112, 196, 200),tocolor(7, 112, 196, 255))
		DGS:dgsGridListSetRowBackGroundColor(maingrid,9,tocolor(25, 25, 25, 200),tocolor(7, 112, 196, 200),tocolor(7, 112, 196, 255))
		
		DGS:dgsGridListSetItemImage(maingrid,1,1,home,tocolor(255,255,255,255),-5,2,32,32,false)
		DGS:dgsGridListSetItemImage(maingrid,2,1,member,tocolor(255,255,255,255),-5,5,32,32,false)
		DGS:dgsGridListSetItemImage(maingrid,3,1,rank,tocolor(255,255,255,255),-5,5,32,32,false)
		DGS:dgsGridListSetItemImage(maingrid,4,1,veh,tocolor(255,255,255,255),-5,5,32,32,false)
		DGS:dgsGridListSetItemImage(maingrid,5,1,ann,tocolor(255,255,255,255),-5,5,32,32,false)
		DGS:dgsGridListSetItemImage(maingrid,6,1,finance,tocolor(255,255,255,255),-5,5,32,32,false)
		DGS:dgsGridListSetItemImage(maingrid,7,1,duty,tocolor(255,255,255,255),-5,5,32,32,false)
		DGS:dgsGridListSetItemImage(maingrid,9,1,tow,tocolor(255,255,255,255),-5,5,32,32,false)
		
		DGS:dgsSetProperty(maingrid,"font",robotoFont11)
		DGS:dgsGridListSetSelectedItem (maingrid, 1)
		
		--DummyWnd instead of tabs--
		DmainRectImg = DGS:dgsCreateImage(215, 65, 754, 572,DmainRect,false,gFactionWindow)
		DrnkRectImg = DGS:dgsCreateImage(215, 65, 754, 572,DrnkRect,false,gFactionWindow)
		DmemberRectImg = DGS:dgsCreateImage(215, 65, 754, 572,DmemberRect,false,gFactionWindow)
		DvehRectImg = DGS:dgsCreateImage(215, 65, 754, 572,DvehRect,false,gFactionWindow)
		DannRectImg = DGS:dgsCreateImage(215, 65, 754, 572,DannRect,false,gFactionWindow)
		DfinanceRectImg = DGS:dgsCreateImage(215, 65, 754, 572,DfinanceRect,false,gFactionWindow)
		DdutyRectImg = DGS:dgsCreateImage(215, 65, 754, 572,DdutyRect,false,gFactionWindow)
		DjobRectImg = DGS:dgsCreateImage(215, 65, 754, 572,DjobRect,false,gFactionWindow)
		DtowRectImg = DGS:dgsCreateImage(215, 65, 754, 572,DtowRect,false,gFactionWindow)
		
		rnkRectImg = DGS:dgsCreateImage(25, 25, 173, 124,rnkRect,false,DmainRectImg)
		numRectImg = DGS:dgsCreateImage(208, 25, 173, 124,numRect,false,DmainRectImg)
		vehRectImg = DGS:dgsCreateImage(391, 25, 173, 124,vehRect,false,DmainRectImg)
		radRectImg = DGS:dgsCreateImage(574, 25, 173, 124,radRect,false,DmainRectImg)
		
		rnkImg = DGS:dgsCreateImage(78, 50, 70, 70,":resources/images/rank.png",false,DmainRectImg)--235, 80, 70, 70 --53, 25
		numImg = DGS:dgsCreateImage(267, 60, 50, 50,":resources/images/stat_users.png",false,DmainRectImg)--418, 80, 50, 50
		vehImg = DGS:dgsCreateImage(451, 60, 50, 50,":resources/images/menu_car.png",false,DmainRectImg)--601, 80, 50, 50
		radImg = DGS:dgsCreateImage(626, 40, 70, 70,":resources/images/walkietalkie.png",false,DmainRectImg)--784, 80, 70, 70
		
		crownImg = DGS:dgsCreateImage(10, 420, 20, 20,":resources/images/crown.png",false,DmemberRectImg)
		--crownImg = DGS:dgsCreateImage(10, 420, 20, 20,_,false,DmemberRectImg)--784, 80, 70, 70
		
		DGS:dgsSetVisible(DrnkRectImg, false)
		DGS:dgsSetVisible(DmemberRectImg, false)
		DGS:dgsSetVisible(DvehRectImg, false)
		DGS:dgsSetVisible(DdutyRectImg, false)
		DGS:dgsSetVisible(DannRectImg, false)
		DGS:dgsSetVisible(DfinanceRectImg, false)
		DGS:dgsSetVisible(DjobRectImg, false)
		DGS:dgsSetVisible(DtowRectImg, false)
		
		DGS:dgsSetVisible(crownImg, false)
		
		DGS:dgsSetEnabled(rnkRectImg, false)
		DGS:dgsSetEnabled(numRectImg, false)
		DGS:dgsSetEnabled(vehRectImg, false)
		DGS:dgsSetEnabled(radRectImg, false)
		
		--Lines--
		line = DGS:dgsCreateLine(10,450,600,400, false, DrnkRectImg, 10, tocolor(255, 255, 255, 255))
		DGS:dgsLineAddItem(line,0,0,730,0, 2, tocolor(200,200,200,255),false)
		line = DGS:dgsCreateLine(10,450,600,400, false, DmemberRectImg, 10, tocolor(255, 255, 255, 255))
		DGS:dgsLineAddItem(line,0,0,730,0, 2, tocolor(200,200,200,255),false)
		line = DGS:dgsCreateLine(10,450,600,400, false, DvehRectImg, 10, tocolor(255, 255, 255, 255))
		DGS:dgsLineAddItem(line,0,0,730,0, 2, tocolor(200,200,200,255),false)
		line = DGS:dgsCreateLine(10,185,600,400, false, DdutyRectImg, 10, tocolor(255, 255, 255, 255))
		line2 = DGS:dgsCreateLine(10,357,600,400, false, DdutyRectImg, 10, tocolor(255, 255, 255, 255))
		DGS:dgsLineAddItem(line,0,0,730,0, 2, tocolor(200,200,200,255),false)
		DGS:dgsLineAddItem(line2,0,0,730,0, 2, tocolor(200,200,200,255),false)
		
		facName = DGS:dgsCreateLabel(217, 5, 509, 35, teamName, false, gFactionWindow, tocolor(200, 200, 200, 255))
		welLbl = DGS:dgsCreateLabel(217, 35, 509, 35, "#c8c8c8Welcome Back #0770C4".. getPlayerName(localPlayer):gsub("_", " "), false, gFactionWindow, tocolor(200, 200, 200, 255))
		
        rankLbl = DGS:dgsCreateLabel(10, 5, 509, 35, "Rank", false, rnkRectImg, tocolor(200, 200, 200, 255))
		rankNameLbl = DGS:dgsCreateLabel(0, 100, 173, 35, newTable[8], false, rnkRectImg, tocolor(200, 200, 200, 255))
		DGS:dgsSetProperty(facName,"font",robotoboldFont18)
		DGS:dgsSetProperty(welLbl,"font",robotoFont11)
		DGS:dgsSetProperty(rankLbl,"font",robotoFont11)
		DGS:dgsSetProperty(rankNameLbl,"font",robotoFont11)
		DGS:dgsLabelSetHorizontalAlign(rankNameLbl, "right", false) 
		DGS:dgsSetProperty(welLbl,"colorcoded",true)
		memberLbl = DGS:dgsCreateLabel(10, 5, 509, 35, "Members", false, numRectImg, tocolor(200, 200, 200, 255))
		DGS:dgsSetProperty(memberLbl,"font",robotoFont11)
		vehLbl = DGS:dgsCreateLabel(10, 5, 509, 35, "Vehicles", false, vehRectImg, tocolor(200, 200, 200, 255))
        vehNumLbl = DGS:dgsCreateLabel(150, 100, 509, 35, #newTable[13], false, vehRectImg, tocolor(200, 200, 200, 255))
		DGS:dgsSetProperty(vehLbl,"font",robotoFont11)
		DGS:dgsSetProperty(vehNumLbl,"font",robotoFont11)
		radioLbl = DGS:dgsCreateLabel(10, 5, 509, 35, "Radio", false, radRectImg, tocolor(200, 200, 200, 255))
		DGS:dgsSetProperty(radioLbl,"font",robotoFont11)
		
		nameLbl = DGS:dgsCreateLabel(15, 421, 509, 38, "", false, DmemberRectImg, tocolor(225, 225, 225, 200))
		DGS:dgsSetProperty(nameLbl,"font",robotoFont14)
		-- Make members list
		gMemberGrid = DGS:dgsCreateGridList(15, 24, 720, 350, false, DmemberRectImg, _, tocolor(10,10,10,255), _, tocolor(10,10,10,255))
		memberscroll = DGS:dgsGridListGetScrollBar( gMemberGrid )
		DGS:dgsSetProperty(memberscroll,"arrowColor",{tocolor(25, 25, 25, 200), tocolor(7, 112, 196, 200), tocolor(0, 163, 255, 255)})
		DGS:dgsSetProperty(memberscroll,"cursorColor",{tocolor(25, 25, 25, 200), tocolor(7, 112, 196, 200), tocolor(0, 163, 255, 255)})
		
		colName = DGS:dgsGridListAddColumn(gMemberGrid, "Name", 1.00)
		DGS:dgsGridListSetColumnHeight(gMemberGrid, 0)
		DGS:dgsSetProperty(gMemberGrid,"rowHeight",30)
		DGS:dgsSetProperty(gMemberGrid,"font",robotoFont11)
		
		leaderLbl = DGS:dgsCreateLabel(15, 460, 509, 38, "Leader: ", false, DmemberRectImg, tocolor(225, 225, 225, 200))
		rankLbl = DGS:dgsCreateLabel(15, 500, 509, 38, "Rank: ", false, DmemberRectImg, tocolor(225, 225, 225, 200))
		llLbl = DGS:dgsCreateLabel(15, 540, 509, 38, "Last Login: ", false, DmemberRectImg, tocolor(225, 225, 225, 200))
		DGS:dgsSetProperty(leaderLbl,"font",robotoFont11)
		DGS:dgsSetProperty(leaderLbl,"colorCoded",true)
		DGS:dgsSetProperty(rankLbl,"font",robotoFont11)
		DGS:dgsSetProperty(llLbl,"font",robotoFont11)
		
		local factionType = tonumber(getElementData(theTeam, "type"))
		
		if (factionType==2) or (factionType==3) or (factionType==4) or (factionType==5) or (factionType==6) or (factionType==7) then -- Added Mechanic type \ Adams
		salaryLbl = DGS:dgsCreateLabel(15, 520, 509, 38, "Salary: ", false, DmemberRectImg, tocolor(225, 225, 225, 200))
			--colLocation = guiGridListAddColumn(gMemberGrid, "Location", 0.12)
			--colWage = guiGridListAddColumn(gMemberGrid, "Wage ($)", 0.06)
		--else
			--colLocation = guiGridListAddColumn(gMemberGrid, "Location", 0.1)
		end
		DGS:dgsSetProperty(salaryLbl,"font",robotoFont11)
		
		local factionID = getElementData(factionTheTeam, "id")
		local factionPackages = exports.duty:getFactionPackages(factionID)
		if factionPackages and factionType >= 2 then
		dutyLbl = DGS:dgsCreateLabel(15, 480, 509, 38, "Duty: ", false, DmemberRectImg, tocolor(225, 225, 225, 200))
			--colDuty = guiGridListAddColumn(gMemberGrid, "Duty", 0.06)
		end
		DGS:dgsSetProperty(dutyLbl,"font",robotoFont11)
		DGS:dgsSetProperty(dutyLbl,"colorcoded",true)
		
		local localPlayerIsLeader = nil
		local counterOnline, counterOffline = 0, 0


		for k, v in ipairs(memberUsernames) do
			theRank = tonumber(memberRanks[k])
			rankName = factionRanks[theRank]
			local row = DGS:dgsGridListAddRow(gMemberGrid)
			DGS:dgsGridListSetItemText(gMemberGrid, row, colName, ""..string.gsub(tostring(memberUsernames[k]), "_", " ") .. " (" .. tostring(rankName) .. ")" .. " (" .. tostring(theRank) .. ")", false, false)
			DGS:dgsGridListSetItemData(gMemberGrid, row, colName, tostring(theRank))
			DGS:dgsGridListSetRowBackGroundColor(gMemberGrid,row,tocolor(15, 15, 15, 200),tocolor(7, 112, 196, 200),tocolor(7, 112, 196, 255))
			if (memberOnline[k]) then
				DGS:dgsGridListSetItemImage(gMemberGrid,row,colName,online,tocolor(255,255,255,255),-10,0,5,30,false)
				counterOnline = counterOnline + 1
			else
				DGS:dgsGridListSetItemImage(gMemberGrid,row,colName,offline,tocolor(255,255,255,255),-10,0,5,30,false)
				counterOffline = counterOffline + 1
			end
			
			-- Check if this is the local player
			if (tostring(memberUsernames[k])==playerName) then
				localPlayerIsLeader = memberLeaders[k]
			elseif fromShowF then
				localPlayerIsLeader = fromShowF
			end


		end
		
		membersOnline = counterOnline
		membersOffline = counterOffline
		
		-- Update the window title
		membersLbl = DGS:dgsCreateLabel(15, -6, 509, 38, "Member: " .. counterOnline+counterOffline .. ", Online: " .. counterOnline, false, DmemberRectImg, tocolor(225, 225, 225, 200))
		DGS:dgsSetProperty(membersLbl,"font",themify16)
		memberNumLbl = DGS:dgsCreateLabel(150, 100, 509, 35, counterOnline .. "/" .. counterOnline+counterOffline, false, numRectImg, tocolor(200, 200, 200, 255))
		DGS:dgsSetProperty(memberNumLbl,"font",robotoFont11)
		--guiSetText(gFactionWindow, tostring(teamName) .. " (" .. counterOnline .. " of " .. (counterOnline+counterOffline) .. " Members Online)")
		gMOTDLabel = DGS:dgsCreateLabel(120, 100, 509, 35, tostring(motd), false, radRectImg, tocolor(200, 200, 200, 255)) --guiCreateLabel(0.015, 0.935, 0.95, 0.15, tostring(motd), true, tabOverview)
		DGS:dgsSetProperty(gMOTDLabel,"font",robotoFont11)
		-- Make the buttons
		if (localPlayerIsLeader) then
			gButtonKick = DGS:dgsCreateButton(560, 495, 180, 30, " Boot Player", false, DmemberRectImg, tocolor(200, 200, 200, 255), _, _, _, _, _,tocolor(98, 57, 34, 200), tocolor(98, 57, 34,225), tocolor(98, 57, 34, 255))
			gButtonLeader = DGS:dgsCreateButton(560, 460, 180, 30, " Toggle Leader", false, DmemberRectImg, tocolor(200, 200, 200, 255), _, _, _, _, _,tocolor(12, 71, 67, 200), tocolor(12, 71, 67,225), tocolor(12, 71, 67, 255))
			gButtonPromote = DGS:dgsCreateButton(370, 460, 180, 30, " Promote Player", false, DmemberRectImg, tocolor(200, 200, 200, 255), _, _, _, _, _,tocolor(12, 71, 67, 200), tocolor(12, 71, 67,225), tocolor(12, 71, 67, 255))
			
			DGS:dgsSetProperty(gButtonPromote,"font",robotoFont11)
			DGS:dgsSetProperty(gButtonLeader,"font",robotoFont11)
			DGS:dgsSetProperty(gButtonKick,"font",robotoFont11)
			DGS:dgsSetProperty(gButtonPromote,"iconImage",{":resources/images/plus.png",":resources/images/plus.png",":resources/images/plus.png"})
			DGS:dgsSetProperty(gButtonLeader,"iconImage",{":resources/images/leader.png",":resources/images/leader.png",":resources/images/leader.png"})
			DGS:dgsSetProperty(gButtonKick,"iconImage",{":resources/images/kick.png",":resources/images/kick.png",":resources/images/kick.png"})
			DGS:dgsSetProperty(gButtonPromote,"colorTransitionPeriod",350)
			DGS:dgsSetProperty(gButtonLeader,"colorTransitionPeriod",350)
			DGS:dgsSetProperty(gButtonKick,"colorTransitionPeriod",350)
			
			DGS:dgsSetVisible(gMOTDLabel, false)
			gMOTDEdit = DGS:dgsCreateEdit(690, 115, 100, 35, tostring(motd), false, DmainRectImg, tocolor(200, 200, 200, 255), _, _, _, tocolor(30,30,30,0))
			DGS:dgsSetProperty(gMOTDEdit,"font",robotoFont11)
			DGS:dgsEditSetPlaceHolder(gMOTDEdit, "Enter Radio Frequency" )
			
			
			--if (factionType==2) or (factionType==3) or (factionType==4) or (factionType==5) or (factionType==6) or (factionType==7) then -- Added Mechanic type \ Adams
				--gButtonEditRanks = DGS:dgsCreateButton(680, 470, 65, 30, "OK", false, DrnkRectImg, tocolor(200, 200, 200, 255), _, _, _, _, _,tocolor(0, 163, 255, 100), tocolor(7, 112, 196, 200), tocolor(0, 163, 255, 255))
				--gButtonEditWage = DGS:dgsCreateButton(680, 520, 65, 30, "OK", false, DrnkRectImg, tocolor(200, 200, 200, 255), _, _, _, _, _,tocolor(0, 163, 255, 100), tocolor(7, 112, 196, 200), tocolor(0, 163, 255, 255))
				--else
				--DGS:dgsSetEnabled(gButtonEditWage, false)
			--end
			
			--gButtonEditMOTD = guiCreateButton(0.825, 0.3824, 0.16, 0.06, "Edit MOTD", true, tabOverview)
			tInvite = DGS:dgsCreateEdit(15, 380, 620, 30, "", false, DmemberRectImg, _, _, _, _, tocolor(30,30,30,255))
			gButtonInvite = DGS:dgsCreateButton(640, 380, 95, 30, "Invite Member", false, DmemberRectImg, tocolor(200, 200, 200, 255), _, _, _, _, _,tocolor(0, 163, 255, 100), tocolor(7, 112, 196, 200), tocolor(0, 163, 255, 255))
			DGS:dgsSetEnabled(gButtonInvite, false)
			--gButtonRespawnui = guiCreateButton(0.825, 0.5356, 0.16, 0.06, "Respawn Vehicles", true, tabOverview)
			DGS:dgsSetProperty(gButtonInvite,"iconImage",{":resources/images/add.png",":resources/images/add.png",":resources/images/add.png"})
			DGS:dgsSetProperty(gButtonInvite,"textOffset",{10,0,false})
			DGS:dgsSetProperty(gButtonInvite,"font",robotoFont11)
			DGS:dgsSetProperty(gButtonInvite,"colorTransitionPeriod",350)
			
			DGS:dgsEditSetPlaceHolder(tInvite, " Enter Player Name or Parital Name" )
			DGS:dgsSetProperty(tInvite,"placeHolderFont",robotoFont11)
			
			nameExistLbl = DGS:dgsCreateLabel(300, 410, 509, 38, "", false, DmemberRectImg, tocolor(225, 225, 225, 200))
			
			if factionPackages and factionType >= 2 then
				gButtonPerk = DGS:dgsCreateButton(370, 495, 180, 30, " Manage Duty Perks", false, DmemberRectImg, tocolor(200, 200, 200, 255), _, _, _, _, _,tocolor(98, 57, 34, 200), tocolor(98, 57, 34,225), tocolor(98, 57, 34, 255))
				addEventHandler("onDgsMouseClick", gButtonPerk, btButtonPerk, false)
			end
			DGS:dgsSetProperty(gButtonPerk,"font",robotoFont11)
			DGS:dgsSetProperty(gButtonPerk,"iconImage",{":resources/images/editduty.png",":resources/images/editduty.png",":resources/images/editduty.png"})
			DGS:dgsSetProperty(gButtonPerk,"colorTransitionPeriod",350)
			
			addEventHandler("onDgsMouseClick", gButtonKick, btKickPlayer, false)
			addEventHandler("onDgsMouseClick", gButtonLeader, btToggleLeader, false)
			addEventHandler("onDgsMouseClick", gButtonPromote, btPromotePlayer, false)	
			addEventHandler("onDgsEditAccepted", gMOTDEdit, sendMOTD, false)
			addEventHandler("onDgsMouseClick", gButtonInvite, sendInvite, false)
			--addEventHandler("onDgsMouseClick", gButtonInvite, btInvitePlayer, false)
			addEventHandler("onDgsTextChange", tInvite, checkNameExists)
			
			--tabVehicles = guiCreateTab("(Leader) Vehicles", tabs)
		
			gVehicleGrid = DGS:dgsCreateGridList(15, 24, 720, 400, false, DvehRectImg, _, tocolor(10,10,10,255), _, tocolor(10,10,10,255))
			vehscroll = DGS:dgsGridListGetScrollBar( gVehicleGrid )
			DGS:dgsSetProperty(vehscroll,"arrowColor",{tocolor(25, 25, 25, 200), tocolor(0, 163, 255, 225), tocolor(0, 163, 255, 255)})
			DGS:dgsSetProperty(vehscroll,"cursorColor",{tocolor(25, 25, 25, 200), tocolor(0, 163, 255, 225), tocolor(0, 163, 255, 255)})
			
			DGS:dgsGridListSetColumnHeight(gVehicleGrid, 0)
			DGS:dgsSetProperty(gVehicleGrid,"rowHeight",30)
			
			colVehID = DGS:dgsGridListAddColumn(gVehicleGrid, "ID (VIN)", 0.1)
			colVehModel = DGS:dgsGridListAddColumn(gVehicleGrid, "Model", 0.30)
			colVehPlates = DGS:dgsGridListAddColumn(gVehicleGrid, "Plate", 0.1)
			colVehLocation = DGS:dgsGridListAddColumn(gVehicleGrid, "Location", 0.4)
			gButtonVehRespawn = DGS:dgsCreateButton(80, 460, 600, 30, " Respawn Vehicle", false, DvehRectImg, tocolor(200, 200, 200, 255), _, _, _, _, _,tocolor(16, 70, 118, 200), tocolor(16, 70, 118,225), tocolor(16, 70, 118, 255))
			gButtonRespawn = DGS:dgsCreateButton(80, 500, 600, 30, " Respawn All Vehicles", false, DvehRectImg, tocolor(200, 200, 200, 255), _, _, _, _, _,tocolor(91, 37, 32, 200), tocolor(91, 37, 32,225), tocolor(91, 37, 32, 255))

			DGS:dgsSetProperty(gButtonVehRespawn,"font",robotoFont14)
			DGS:dgsSetProperty(gButtonRespawn,"font",robotoFont14)
			DGS:dgsSetProperty(gButtonVehRespawn,"iconImage",{":resources/images/vehicles.png",":resources/images/vehicles.png",":resources/images/vehicles.png"})
			DGS:dgsSetProperty(gButtonRespawn,"iconImage",{":resources/images/vehicless.png",":resources/images/vehicless.png",":resources/images/vehicless.png"})
			DGS:dgsSetProperty(gButtonVehRespawn,"colorTransitionPeriod",350)
			DGS:dgsSetProperty(gButtonRespawn,"colorTransitionPeriod",350)
			
			
			for index, vehID in ipairs(vehicleIDs) do
				local row = DGS:dgsGridListAddRow(gVehicleGrid)
				DGS:dgsGridListSetItemText(gVehicleGrid, row, colVehID, tostring(vehID), false, true)
				DGS:dgsGridListSetItemText(gVehicleGrid, row, colVehModel, tostring(vehicleModels[index]), false, false)
				DGS:dgsGridListSetItemText(gVehicleGrid, row, colVehPlates, tostring(vehiclePlates[index]), false, false)
				DGS:dgsGridListSetItemText(gVehicleGrid, row, colVehLocation, tostring(vehicleLocations[index]), false, false)
				DGS:dgsGridListSetRowBackGroundColor(gVehicleGrid,row,tocolor(15, 15, 15, 200),tocolor(7, 112, 196, 200),tocolor(7, 112, 196, 255))
			end
			addEventHandler("onDgsMouseClick", gButtonVehRespawn, btRespawnOneVehicle, false)
			addEventHandler("onDgsMouseClick", gButtonRespawn, btRespawnVehicles, false)
			
			--tabNote = guiCreateTab("(Leader) Note", tabs)
			eNote = DGS:dgsCreateMemo(15, 20, 722, 450, note or "Nothing Here For Now, You Can Add Something",false,DannRectImg,_,_,_,_,tocolor(15, 77, 134, 200))
			gButtonSaveNote = DGS:dgsCreateButton(245, 530, 300, 30, "Save", false, DannRectImg, tocolor(200, 200, 200, 255), _, _, btnRect, btnRecthov, btnRectClick)
			addEventHandler("onDgsMouseClick", gButtonSaveNote, btUpdateNote, false)
			DGS:dgsSetProperty(gButtonSaveNote,"font",robotoFont14)
			DGS:dgsSetProperty(gButtonSaveNote,"iconImage",{":resources/images/save.png",":resources/images/save.png",":resources/images/save.png"})
			DGS:dgsSetProperty(gButtonSaveNote,"iconOffset",{-4, 0})
			DGS:dgsSetProperty(gButtonSaveNote,"colorTransitionPeriod",350)

			
			-- jobapplications

				gJobGrid = DGS:dgsCreateGridList(15, 20, 720, 410, false, DjobRectImg)
				
				jobscroll = DGS:dgsGridListGetScrollBar( gJobGrid )
				DGS:dgsSetProperty(jobscroll,"arrowColor",{tocolor(25, 25, 25, 200), tocolor(0, 163, 255, 225), tocolor(0, 163, 255, 255)})
				DGS:dgsSetProperty(jobscroll,"cursorColor",{tocolor(25, 25, 25, 200), tocolor(0, 163, 255, 225), tocolor(0, 163, 255, 255)})
			
				DGS:dgsSetProperty(gJobGrid,"rowHeight",30)
					
				colID = DGS:dgsGridListAddColumn(gJobGrid, 'ID', 0.07)
				colName = DGS:dgsGridListAddColumn(gJobGrid, 'Name', 0.2)
				colNum = DGS:dgsGridListAddColumn(gJobGrid, 'Phone No.', 0.2)
				colAge = DGS:dgsGridListAddColumn(gJobGrid, 'Age', 0.08)
				colAddr = DGS:dgsGridListAddColumn(gJobGrid, 'Address', 0.2)
				colEmail = DGS:dgsGridListAddColumn(gJobGrid, 'Email', 0.2)
				colOthers = DGS:dgsGridListAddColumn(gJobGrid, 'Informations', 0.2)
				colRP = DGS:dgsGridListAddColumn(gJobGrid, 'RP', 0.2)
				colTime = DGS:dgsGridListAddColumn(gJobGrid, 'Time', 0.2)
				--				DGS:dgsGridListSetRowBackGroundColor(gVehicleGrid,row,tocolor(15, 15, 15, 200),tocolor(7, 112, 196, 200),tocolor(7, 112, 196, 255))
				
				showBtn = DGS:dgsCreateButton(80, 450, 600, 30, " Show Application", false, DjobRectImg, tocolor(200, 200, 200, 255), _, _, _, _, _,tocolor(16, 70, 118, 200), tocolor(16, 70, 118,225), tocolor(16, 70, 118, 255))
					DGS:dgsSetProperty(showBtn,"font",robotoFont14)
					DGS:dgsSetProperty(showBtn,"iconImage",{":resources/images/save.png",":resources/images/save.png",":resources/images/save.png"})
					DGS:dgsSetProperty(showBtn,"iconOffset",{-4, 0})
					DGS:dgsSetProperty(showBtn,"colorTransitionPeriod",350)
					--[[
					addEventHandler("onDgsMouseClickDown", showBtn,  function (button, state)
					local rowSelect, colSelect = DGS:dgsGridListGetSelectedItem(gJobGrid)
						if (rowSelect==-1) or (colSelect==-1) then
							return
						else
						local infoa = DGS:dgsGridListGetItemText(gJobGrid, DGS:dgsGridListGetSelectedItem(gJobGrid), 2)
							outputChatBox(infoa)
							--triggerEvent("JobApp:ShowWholeApp", getRootElement() appID)
						end
					end)
				]]
				delBtn = DGS:dgsCreateButton(80, 490, 600, 30, " Delete Application", false, DjobRectImg, tocolor(200, 200, 200, 255), _, _, _, _, _,tocolor(91, 37, 32, 200), tocolor(91, 37, 32,225), tocolor(91, 37, 32, 255))
					DGS:dgsSetProperty(delBtn,"font",robotoFont14)
					DGS:dgsSetProperty(delBtn,"iconImage",{":resources/images/save.png",":resources/images/save.png",":resources/images/save.png"})
					DGS:dgsSetProperty(delBtn,"iconOffset",{-4, 0})
					DGS:dgsSetProperty(delBtn,"colorTransitionPeriod",350)
				
					addEventHandler("onDgsMouseClickDown", delBtn,  function (button, state)
					local rowSelect, colSelect = DGS:dgsGridListGetSelectedItem(gJobGrid)
						if (rowSelect == -1) or (colSelect == -1) then
							return
						else
						local appID = DGS:dgsGridListGetItemText(gJobGrid, DGS:dgsGridListGetSelectedItem(gJobGrid), 1)
							triggerServerEvent("JobApp:DeleteApp", getRootElement(), appID)
							outputChatBox("Successful Delete Application With ID: " .. appID)
							hideFactionMenu()
						end
					end)
				--if statue == 0 then
					clsBtn = DGS:dgsCreateButton(80, 530, 600, 30, "", false, DjobRectImg, tocolor(200, 200, 200, 255), _, _, _, _, _,tocolor(12, 71, 67, 200), tocolor(12, 71, 67,225), tocolor(12, 71, 67, 255))
					DGS:dgsSetProperty(clsBtn,"font",robotoFont14)
					DGS:dgsSetProperty(clsBtn,"iconImage",{":resources/images/save.png",":resources/images/save.png",":resources/images/save.png"})
					DGS:dgsSetProperty(clsBtn,"iconOffset",{-4, 0})
					DGS:dgsSetProperty(clsBtn,"colorTransitionPeriod",350)
					addEventHandler("onDgsMouseClickDown", clsBtn, OpenCloseApply, false)
			-- towstats
			
			if towstats then
				--tabTowstats = guiCreateTab("(Leader) Towstats", tabs)
				gTowGrid = DGS:dgsCreateGridList(15, 20, 720, 410, false, DtowRectImg)
				
				tstatscroll = DGS:dgsGridListGetScrollBar( gTowGrid )
				DGS:dgsSetProperty(tstatscroll,"arrowColor",{tocolor(25, 25, 25, 200), tocolor(0, 163, 255, 225), tocolor(0, 163, 255, 255)})
				DGS:dgsSetProperty(tstatscroll,"cursorColor",{tocolor(25, 25, 25, 200), tocolor(0, 163, 255, 225), tocolor(0, 163, 255, 255)})
			
				DGS:dgsSetProperty(gTowGrid,"rowHeight",30)

				local totals = {[0] = 0, [-1] = 0, [-2] = 0, [-3] = 0, [-4] = 0}
				local colName = DGS:dgsGridListAddColumn(gTowGrid, 'Name', 0.2)
				local colRank = DGS:dgsGridListAddColumn(gTowGrid, 'Rank', 0.2)
				local cols = {
					[0] = DGS:dgsGridListAddColumn(gTowGrid, 'this week', 0.1),
					[-1] = DGS:dgsGridListAddColumn(gTowGrid, 'last week', 0.1),
					[-2] = DGS:dgsGridListAddColumn(gTowGrid, '2 weeks ago', 0.1),
					[-3] = DGS:dgsGridListAddColumn(gTowGrid, '3 weeks ago', 0.1),
					[-4] = DGS:dgsGridListAddColumn(gTowGrid, '4 weeks ago', 0.1)
				}

				for k, v in ipairs(memberUsernames) do
					local row = DGS:dgsGridListAddRow(gTowGrid)
					DGS:dgsGridListSetItemText(gTowGrid, row, colName, v:gsub("_", " "), false, false)
					DGS:dgsGridListSetRowBackGroundColor(gTowGrid,row,tocolor(15, 15, 15, 200),tocolor(7, 112, 196, 200),tocolor(7, 112, 196, 255))

					local theRank = tonumber(memberRanks[k])
					local rankName = factionRanks[theRank]
					DGS:dgsGridListSetItemText(gTowGrid, row, colRank, tostring(rankName), false, false)
			
					local stats = towstats[v] or {}
					for week, col in pairs(cols) do
						DGS:dgsGridListSetItemText(gTowGrid, row, col, tostring(stats[week] or ""), false, true)
						totals[week] = totals[week] + (stats[week] or 0)
					end
				end

				local row = DGS:dgsGridListAddRow(gTowGrid)
				DGS:dgsGridListSetItemText(gTowGrid, row, colName, "Totals", true, false)
				DGS:dgsGridListSetRowBackGroundColor(gTowGrid,row,tocolor(15, 15, 15, 200),tocolor(7, 112, 196, 200),tocolor(7, 112, 196, 255))
				for week, col in pairs(cols) do
					DGS:dgsGridListSetItemText(gTowGrid, row, col, tostring(totals[week] or 0), true, true)

				end
				else
							local rowCount = DGS:dgsGridListGetRowCount ( maingrid )
				for i = 9, rowCount do 
					DGS:dgsGridListRemoveRow ( maingrid, 9 )--to del towstats from all types except Mechanic \--Dharma
				end
			end
			
			-- for faction-wide note
			--tabFNote = guiCreateTab("Note", tabs)
			 --for leaders
			fNote = DGS:dgsCreateMemo(25, 180, 722, 360,fnote or "Nothing Here For Now, The Leader Will Add Something Soon",false,DmainRectImg,_,_,_,_,tocolor(15, 77, 134, 200))
			DGS:dgsMemoSetReadOnly(fNote, false)
			gButtonSaveFNote = DGS:dgsCreateButton(340, 545, 100, 25, "Save", false, DmainRectImg, tocolor(200, 200, 200, 255), _, _, btnRect, btnRecthov, btnRectClick)
			DGS:dgsSetProperty(gButtonSaveFNote,"colorTransitionPeriod",350)
			
			addEventHandler("onDgsMouseClick", gButtonSaveFNote, btUpdateFNote, false)

			--tabFinance = guiCreateTab("(Leader) Finance", tabs)
			--addEventHandler("onClientGUITabSwitched", tabFinance, loadFinance)
			local rowCount = DGS:dgsGridListGetRowCount ( maingrid )
			if factionType < 2 then
				for i = 7, rowCount do 
					DGS:dgsGridListRemoveRow ( maingrid, 7 )--to del duty for gang and mafia \--Dharma
				end
			end

		else -- for faction-wide note
			--tabFNote = guiCreateTab("Note", tabs)
			--for Players--
			fNote = DGS:dgsCreateMemo(25, 180, 722, 360,fnote or "Nothing Here For Now, The Leader Will Add Something Soon",false,DmainRectImg,_,_,_,_,tocolor(15, 77, 134, 200))
			DGS:dgsMemoSetReadOnly(fNote, true)
			--this thing to delete row bc when you delete for ex row num 2, row num 3 will shift the place of row num 2 --/Dharma
						local rowCount = DGS:dgsGridListGetRowCount ( maingrid )
			for i=3,rowCount do 
			DGS:dgsGridListRemoveRow ( maingrid, 3 )
			end
			------------------------------------------------------
	--	end
				--end
		    end
			--gButtonQuit = guiCreateButton(0.825, 0.7834, 0.16, 0.06, "Leave Faction", true, tabOverview)
			gButtonExit = DGS:dgsCreateButton(934, 21, 26, 23, "", false, gFactionWindow, tocolor(200, 200, 200, 255), _, _, ":interaction/icons/cross_x.png", ":interaction/icons/cross_x.png", ":interaction/icons/cross_x.png",_, tocolor(7, 112, 196, 200), tocolor(0, 163, 255, 255))
			DGS:dgsSetProperty(gButtonExit,"colorTransitionPeriod",350)
			
			--addEventHandler("onClientGUIClick", gButtonQuit, btQuitFaction, false)
			addEventHandler("onDgsMouseClick", gButtonExit, hideFactionMenu, false)

			--DGS:dgsiSetEnabled(gButtonQuit, getElementData(getLocalPlayer(), 'faction') == getElementData(factionTheTeam, 'id'))
			
			--------Ranks & Wages----------
			lRanks = { }
			local wages = (factionType==2) or (factionType==3) or (factionType==4) or (factionType==5) or (factionType==6) or (factionType==7)  -- Added Mechanic type \ Adams
			rankGrid = DGS:dgsCreateGridList(15, 20, 720, 410, false, DrnkRectImg, _, tocolor(10,10,10,255), _, tocolor(10,10,10,255))
			DGS:dgsGridListSetColumnHeight(rankGrid, 0)
			DGS:dgsSetProperty(rankGrid,"rowHeight",30)
			idColumn = DGS:dgsGridListAddColumn( rankGrid, "Rank ID", 0.05 )
			rankColumn = DGS:dgsGridListAddColumn( rankGrid, "Rank Name", 0.83 )
			wageColumn = DGS:dgsGridListAddColumn( rankGrid, "Rank Wage", 0.1 )
			DGS:dgsGridListSetColumnAlignment(rankGrid,wageColumn,"right")
			DGS:dgsSetProperty(rankGrid,"scrollBarThick",0)
			DGS:dgsSetProperty(rankGrid,"font",robotoFont11)
			
			tRank = DGS:dgsCreateEdit(420, 460, 325, 30, "", false, DrnkRectImg, _, _, _, _, tocolor(30,30,30,255))
			tWage = DGS:dgsCreateEdit(420, 496, 325, 30, "", false, DrnkRectImg, _, _, _, _, tocolor(30,30,30,255))
			
			DGS:dgsEditSetPlaceHolder(tRank, " Enter Rank Name To Change it" )
			DGS:dgsEditSetPlaceHolder(tWage, " Enter Salary Amount To Change it" )

			bRanksSave = DGS:dgsCreateButton(420, 535, 325, 30, "Save!", false, DrnkRectImg, tocolor(200, 200, 200, 255), _, _, _, _, _,tocolor(16, 70, 118, 200), tocolor(16, 70, 118,225), tocolor(16, 70, 118, 255))
			DGS:dgsSetProperty(bRanksSave,"iconImage",{":resources/images/save.png",":resources/images/save.png",":resources/images/save.png"})
			DGS:dgsSetProperty(bRanksSave,"font",robotoFont11)
			DGS:dgsSetProperty(bRanksSave,"iconOffset",{-2, 0})
			DGS:dgsSetProperty(bRanksSave,"colorTransitionPeriod",350)
			addEventHandler("onDgsMouseClick", bRanksSave, saveRanks, false)

			for i=1, 20 do
			rankRow = DGS:dgsGridListAddRow(rankGrid)
			DGS:dgsGridListSetItemText(rankGrid, rankRow, rankColumn, arrFactionRanks[i] , false)
			DGS:dgsGridListSetItemText(rankGrid, rankRow, idColumn, "#"..i , false)

			DGS:dgsGridListSetRowBackGroundColor(rankGrid,rankRow,tocolor(15, 15, 15, 200),tocolor(7, 112, 196, 200),tocolor(7, 112, 196, 255))

			if wages then
			DGS:dgsGridListSetItemText(rankGrid, rankRow, wageColumn, "" .. tostring(arrFactionWages[i]) .. "$" , false)
			else
			DGS:dgsSetEnabled(tWage, false)
			DGS:dgsEditSetPlaceHolder(tWage, " You Can't Do This!" )
			DGS:dgsSetProperty(tWage,"placeHolderColor",tocolor(214, 63, 62, 255))--62,166,80
			end
			rankNameLbl2 = DGS:dgsCreateLabel(10, 470, 100, 35, "", false, DrnkRectImg, tocolor(7, 112, 196, 200))
			DGS:dgsSetProperty(rankNameLbl2,"font",robotoFont14)
			wageLbl = DGS:dgsCreateLabel(10, 501, 100, 35, "Salary: ", false, DrnkRectImg, tocolor(200, 200, 200, 255))
			DGS:dgsSetProperty(wageLbl,"font",robotoFont14)
			wageNumLbl = DGS:dgsCreateLabel(70, 500, 100, 35, "", false, DrnkRectImg, tocolor(200, 200, 200, 255))
			DGS:dgsSetProperty(wageNumLbl,"font",gtaFont15)
			DGS:dgsSetProperty(wageNumLbl,"colorcoded",true)
			
		end
			-------------------------------Duty------------------------
			
				if isElement(Duty.gridlist[1]) then
		beginLoad()
		return
	end
    Duty.gridlist[1] = DGS:dgsCreateGridList(15, 24, 510, 150, false, DdutyRectImg, _, tocolor(10,10,10,255), _, tocolor(10,10,10,255))
    DGS:dgsGridListAddColumn(Duty.gridlist[1], "ID", 0.1)
    DGS:dgsGridListAddColumn(Duty.gridlist[1], "Name", 0.2)
    DGS:dgsGridListAddColumn(Duty.gridlist[1], "Radius", 0.1)
    DGS:dgsGridListAddColumn(Duty.gridlist[1], "Interior", 0.1)
    DGS:dgsGridListAddColumn(Duty.gridlist[1], "Dimension", 0.12)
    DGS:dgsGridListAddColumn(Duty.gridlist[1], "X", 0.1)
    DGS:dgsGridListAddColumn(Duty.gridlist[1], "Y", 0.1)
    DGS:dgsGridListAddColumn(Duty.gridlist[1], "Z", 0.1)
	dutyscroll = DGS:dgsGridListGetScrollBar( Duty.gridlist[1] )
	DGS:dgsSetProperty(dutyscroll,"arrowColor",{tocolor(25, 25, 25, 200), tocolor(0, 163, 255, 225), tocolor(0, 163, 255, 255)})
	DGS:dgsSetProperty(dutyscroll,"cursorColor",{tocolor(25, 25, 25, 200), tocolor(0, 163, 255, 225), tocolor(0, 163, 255, 255)})

    Duty.button[1] = DGS:dgsCreateButton(535, 24, 200, 30, " Add Duty Location", false, DdutyRectImg, tocolor(200, 200, 200, 255), _, _, _, _, _,tocolor(16, 70, 118, 200), tocolor(16, 70, 118,225), tocolor(16, 70, 118, 255))
    --guiSetProperty(Duty.button[1], "NormalTextColour", "FFAAAAAA")
    addEventHandler("onDgsMouseClick", Duty.button[1], createDutyLocationMaker, false)

    --Duty.label[1] = guiCreateLabel(0.0059, 0.0076, 0.2625, 0.03, "Duty Locations", true, tabDuty)
    --guiLabelSetHorizontalAlign(Duty.label[1], "center", false)
    Duty.button[2] = DGS:dgsCreateButton(535, 83, 200, 30, " Remove Duty Location", false, DdutyRectImg, tocolor(200, 200, 200, 255), _, _, _, _, _,tocolor(16, 70, 118, 200), tocolor(16, 70, 118,225), tocolor(16, 70, 118, 255))
    --guiSetProperty(Duty.button[2], "NormalTextColour", "FFAAAAAA")
    addEventHandler("onDgsMouseClick", Duty.button[2], removeLocation, false)

    Duty.button[3] = DGS:dgsCreateButton(535, 143, 200, 30, " Edit Duty Location", false, DdutyRectImg, tocolor(200, 200, 200, 255), _, _, _, _, _,tocolor(16, 70, 118, 200), tocolor(16, 70, 118,225), tocolor(16, 70, 118, 255))
   -- guiSetProperty(Duty.button[3], "NormalTextColour", "FFAAAAAA")
    addEventHandler("onDgsMouseClick", Duty.button[3], processLocationEdit, false)
    addEventHandler("onDgsMouseDoubleClick", Duty.gridlist[1], processLocationEdit, false)

	DGS:dgsSetProperty( Duty.button[1],"font",robotoFont11)
	DGS:dgsSetProperty( Duty.button[2],"font",robotoFont11)
	DGS:dgsSetProperty( Duty.button[3],"font",robotoFont11)
	DGS:dgsSetProperty( Duty.button[1],"iconImage",{":resources/images/editduty.png",":resources/images/editduty.png",":resources/images/editduty.png"})
	DGS:dgsSetProperty( Duty.button[2],"iconImage",{":resources/images/editduty.png",":resources/images/editduty.png",":resources/images/editduty.png"})
	DGS:dgsSetProperty( Duty.button[3],"iconImage",{":resources/images/editduty.png",":resources/images/editduty.png",":resources/images/editduty.png"})

    Duty.gridlist[2] = DGS:dgsCreateGridList(15, 367, 510, 150, false, DdutyRectImg, _, tocolor(10,10,10,255), _, tocolor(10,10,10,255))
    DGS:dgsGridListAddColumn(Duty.gridlist[2], "ID", 0.3)
    DGS:dgsGridListAddColumn(Duty.gridlist[2], "Name", 0.3)
    DGS:dgsGridListAddColumn(Duty.gridlist[2], "Locations", 0.3)
	duty2scroll = DGS:dgsGridListGetScrollBar( Duty.gridlist[2] )
	DGS:dgsSetProperty(duty2scroll,"arrowColor",{tocolor(25, 25, 25, 200), tocolor(0, 163, 255, 225), tocolor(0, 163, 255, 255)})
	DGS:dgsSetProperty(duty2scroll,"cursorColor",{tocolor(25, 25, 25, 200), tocolor(0, 163, 255, 225), tocolor(0, 163, 255, 255)})

    --Duty.label[2] = guiCreateLabel(0.68, 0.0076, 0.2636, 0.03, "Duty Perks", true, tabDuty)
   -- guiLabelSetHorizontalAlign(Duty.label[2], "center", false)
    Duty.button[4] = DGS:dgsCreateButton(535, 367, 200, 30, " Add New Duty", false, DdutyRectImg, tocolor(200, 200, 200, 255), _, _, _, _, _,tocolor(16, 70, 118, 200), tocolor(16, 70, 118,225), tocolor(16, 70, 118, 255))
   -- guiSetProperty(Duty.button[4], "NormalTextColour", "FFAAAAAA")
    addEventHandler("onDgsMouseClick", Duty.button[4], createDuty, false)

    Duty.button[5] = DGS:dgsCreateButton(535, 426, 200, 30, " Remove Duty", false, DdutyRectImg, tocolor(200, 200, 200, 255), _, _, _, _, _,tocolor(16, 70, 118, 200), tocolor(16, 70, 118,225), tocolor(16, 70, 118, 255))
   -- guiSetProperty(Duty.button[5], "NormalTextColour", "FFAAAAAA")
    addEventHandler("onDgsMouseClick", Duty.button[5], removeDuty, false)

    Duty.button[6] = DGS:dgsCreateButton(535, 486, 200, 30, " Edit Duty Perks", false, DdutyRectImg, tocolor(200, 200, 200, 255), _, _, _, _, _,tocolor(16, 70, 118, 200), tocolor(16, 70, 118,225), tocolor(16, 70, 118, 255))
    --guiSetProperty(Duty.button[6], "NormalTextColour", "FFAAAAAA")
    addEventHandler("onDgsMouseClick", Duty.button[6], processDutyEdit, false)
    addEventHandler("onDgsMouseDoubleClick", Duty.gridlist[2], processDutyEdit, false)
	
	DGS:dgsSetProperty(Duty.button[4],"font",robotoFont11)
	DGS:dgsSetProperty(Duty.button[5],"font",robotoFont11)
	DGS:dgsSetProperty(Duty.button[6],"font",robotoFont11)
	DGS:dgsSetProperty(Duty.button[4],"iconImage",{":resources/images/editduty.png",":resources/images/editduty.png",":resources/images/editduty.png"})
	DGS:dgsSetProperty(Duty.button[5],"iconImage",{":resources/images/editduty.png",":resources/images/editduty.png",":resources/images/editduty.png"})
	DGS:dgsSetProperty(Duty.button[6],"iconImage",{":resources/images/editduty.png",":resources/images/editduty.png",":resources/images/editduty.png"})

    Duty.gridlist[3] = DGS:dgsCreateGridList(15, 195, 510, 150, false, DdutyRectImg, _, tocolor(10,10,10,255), _, tocolor(10,10,10,255))
    DGS:dgsGridListAddColumn(Duty.gridlist[3], "ID", 0.1)
    DGS:dgsGridListAddColumn(Duty.gridlist[3], "Vehicle ID", 0.4)
    DGS:dgsGridListAddColumn(Duty.gridlist[3], "Vehicle", 0.5)
	duty3scroll = DGS:dgsGridListGetScrollBar( Duty.gridlist[3] )
	DGS:dgsSetProperty(duty3scroll,"arrowColor",{tocolor(25, 25, 25, 200), tocolor(0, 163, 255, 225), tocolor(0, 163, 255, 255)})
	DGS:dgsSetProperty(duty3scroll,"cursorColor",{tocolor(25, 25, 25, 200), tocolor(0, 163, 255, 225), tocolor(0, 163, 255, 255)})

    --Duty.label[3] = guiCreateLabel(0.325, 0.0076, 0.2886, 0.03, "Duty Vehicle Locations", true, tabDuty)
    --guiLabelSetHorizontalAlign(Duty.label[3], "center", false)
    Duty.button[8] = DGS:dgsCreateButton(535, 195, 200, 30, " Add Duty Vehicle", false, DdutyRectImg, tocolor(200, 200, 200, 255), _, _, _, _, _,tocolor(16, 70, 118, 200), tocolor(16, 70, 118,225), tocolor(16, 70, 118, 255))
    --guiSetProperty(Duty.button[8], "NormalTextColour", "FFAAAAAA")
    addEventHandler("onDgsMouseClick", Duty.button[8], createVehicleAdd, false)

    Duty.button[9] = DGS:dgsCreateButton(535, 314, 200, 30, " Remove Duty Vehicle", false, DdutyRectImg, tocolor(200, 200, 200, 255), _, _, _, _, _,tocolor(16, 70, 118, 200), tocolor(16, 70, 118,225), tocolor(16, 70, 118, 255))
   -- guiSetProperty(Duty.button[9], "NormalTextColour", "FFAAAAAA")    
    addEventHandler("onDgsMouseClick", Duty.button[9], removeVehicle, false)
	
	DGS:dgsSetProperty(Duty.button[8],"font",robotoFont11)
	DGS:dgsSetProperty(Duty.button[9],"font",robotoFont11)
	DGS:dgsSetProperty(Duty.button[8],"iconImage",{":resources/images/editduty.png",":resources/images/editduty.png",":resources/images/editduty.png"})
	DGS:dgsSetProperty(Duty.button[9],"iconImage",{":resources/images/editduty.png",":resources/images/editduty.png",":resources/images/editduty.png"})

   --[[Duty.gridlist[4] = guiCreateGridList(0.3355, 0.6, 0.282, 0.35, true, tabDuty) Was going to be for logs but meh UCP.
    guiGridListAddColumn(Duty.gridlist[4], "ID", 0.1)
    guiGridListAddColumn(Duty.gridlist[4], "Name", 0.3)
    guiGridListAddColumn(Duty.gridlist[4], "Action", 0.5)]]

    beginLoad()
			-----------------------------------------------------------
			addEventHandler("onClientRender", getRootElement(), checkF3)
			f3state = getKeyState( "f3" )
	else
		hideFactionMenu()
	end
	showCursor(true)
end


function saveRanks(button, state)
	if (source==bRanksSave) and (button=="left") and (state=="up") then
		local found = false
		local isNumber = true
		local Selected = DGS:dgsGridListGetSelectedItem(rankGrid)
		local theRankID = tRanks[#tRanks] -- to get The Last ID Number of ranks --
		local theWageID = tRankWages[#tRankWages] -- to get The Last ID Number of ranks --

			if (string.find(DGS:dgsGetText(tRank), ";")) or (string.find(DGS:dgsGetText(tRank), "'")) then
				found = true
			end
		
		local factionType = tonumber(getElementData(theTeam, "type"))
		if (factionType==2) or (factionType==3) or (factionType==4) or (factionType==5) or (factionType==6) or (factionType==7) then -- Added Mechanic type \ Adams
				if not (tostring(type(tonumber(DGS:dgsGetText(tWage)))) == "number") then
					isNumber = false
				end
		end
		
		if (found) then
			outputChatBox("Your ranks contain invalid characters, please ensure it does not contain characters such as '@.;", 255, 0, 0)
		elseif not (isNumber) then
			outputChatBox("Your wages are not numbers, please ensure you entered a number and no currency symbol.", 255, 0, 0)
		else
			local tRanks = DGS:dgsGetText(tRank)
			local tRankWages = DGS:dgsGetText(tWage)
			if --[[theRankID == 1 and ]](factionType==2) or (factionType==3) or (factionType==4) or (factionType==5) or (factionType==6) or (factionType==7) then
			triggerServerEvent("cguiUpdateRanks", getLocalPlayer(), tRanks, tRankWages, theRankID, theWageID, arrFactionRanks, arrFactionWages)
			else
			triggerServerEvent("cguiUpdateRanks", getLocalPlayer(), tRanks, theRankID)
			end
			--hideFactionMenu()

		end
	end
end
--[[
function showrespawn()
	local sx, sy = guiGetScreenSize() 
	
	showrespawnUI = guiCreateWindow(sx/2 - 150,sy/2 - 50,300,100,"Vehicle respawn", false)
	local lQuestion = guiCreateLabel(0.05,0.25,0.9,0.3,"Are you sure you want to respawn the faction vehicles?",true,showrespawnUI)
	guiLabelSetHorizontalAlign (lQuestion,"center",true)
	gButtonRespawn = guiCreateButton(0.1,0.65,0.37,0.23,"Yes",true,showrespawnUI)
	gButtonNo = guiCreateButton(0.53,0.65,0.37,0.23,"No",true,showrespawnUI)

			addEventHandler("onClientGUIClick", gButtonRespawn, btRespawnVehicles, false)
			addEventHandler("onClientGUIClick", gButtonNo, btRespawnVehicles, false)
end
addEvent("showrespawn",true)
addEventHandler("showrespawn", getRootElement(), showrespawn)
]]
-- BUTTON EVENTS

-- MOTD
wMOTD, tMOTD, bUpdate, bMOTDClose = nil

function sendMOTD(button, state)
	--if (source==bUpdate) and (button=="left") and (state=="up") then
		local motd = DGS:dgsGetText(gMOTDEdit)
		
		local found1 = string.find(motd, ";")
		local found2 = string.find(motd, "'")
		
		if (found1) or (found2) then
			outputChatBox("Your message contains invalid characters.", 255, 0, 0)
		else
			DGS:dgsSetText(gMOTDLabel, tostring(motd))
			theMOTD = motd -- Store it clientside
			triggerServerEvent("cguiUpdateMOTD", getLocalPlayer(), motd)
		end
	--end
end

-- NOTE
function btUpdateNote(button, state)
	if button == "left" and state == "up" then
		triggerServerEvent("faction:note", getLocalPlayer(), DGS:dgsGetText(eNote))
	end
end

-- FACTION NOTE
function btUpdateFNote(button, state)
	if button == "left" and state == "up" then
		triggerServerEvent("faction:fnote", getLocalPlayer(), DGS:dgsGetText(fNote))
	end
end

-- INVITE
wInvite, tInvite, lNameCheck, bInvite, bInviteClose, invitedPlayer = nil
--[[
function btInvitePlayer(button, state)
	if (source==gButtonInvite) and (button=="left") and (state=="up") then
		--if not (wInvite) then
			--local width, height = 300, 200
			--local scrWidth, scrHeight = guiGetScreenSize()
			--local x = scrWidth/2 - (width/2)
			--local y = scrHeight/2 - (height/2)
			
			--wInvite = guiCreateWindow(x, y, width, height, "Invite a Player", false)
			--tInvite = guiCreateEdit(0.1, 0.2, 0.85, 0.1, "Partial Player Name", true, wInvite)
					
			lNameCheck = guiCreateLabel(0.1, 0.325, 0.8, 0.3, "Player not found or multiple were found.", true, wInvite)
			guiSetFont(lNameCheck, "default-bold-small")
			guiLabelSetColor(lNameCheck, 255, 0, 0)
			guiLabelSetHorizontalAlign(lNameCheck, "center")
			
			guiSetInputEnabled(true)
			
			bInvite = guiCreateButton(0.1, 0.6, 0.85, 0.15, "Invite!", true, wInvite)
			guiSetEnabled(bInvite, false)
			addEventHandler("onClientGUIClick", bInvite, sendInvite, false)
			
			bCloseInvite = guiCreateButton(0.1, 0.775, 0.85, 0.15, "Close Window", true, wInvite)
			addEventHandler("onClientGUIClick", bCloseInvite, closeInvite, false)
		else
			guiBringToFront(wInvite)
		end
	end
end
]]
--[[
function closeInvite(button, state)
	if (source==bCloseInvite) and (button=="left") and (state=="up") then
		if (wInvite) then
			destroyElement(wInvite)
			wInvite, tInvite, lNameCheck, bInvite, bInviteClose, invitedPlayer = nil, nil, nil, nil, nil, nil
		end
	end
end
]]
function sendInvite(button, state)
	if (source==bInvite) and (button=="left") and (state=="up") then
		triggerServerEvent("cguiInvitePlayer", getLocalPlayer(), invitedPlayer)
	end
end

function checkNameExists(theEditBox)
	local found = nil
	local foundstr = ""
	local count = 0
	
	local players = getElementsByType("player")
	for key, value in ipairs(players) do
		local username = string.lower(tostring(getPlayerName(value)))
		if (string.find(username, string.lower(tostring(DGS:dgsGetText(theEditBox))))) and (DGS:dgsGetText(theEditBox)~="") then
			count = count + 1
			found = value
			foundstr = username
		end
	end
	
	if (count>1) then
		--Noti:addBox("info", "Multiple Found.")
		DGS:dgsSetText(nameExistLbl, "Multiple Found.")
		DGS:dgsLabelSetColor(nameExistLbl, 255, 255, 0)
		--guiMemoSetReadOnly(tInvite, true)
		DGS:dgsSetEnabled(bInvite, false)
	elseif (count==1) then
		--Noti:addBox("success", "Player Found. ("..foundstr..")")
		DGS:dgsSetText(nameExistLbl, "Player Found. ("..foundstr..")")
		DGS:dgsLabelSetColor(nameExistLbl, 0, 255, 0)
		invitedPlayer = found
		--guiMemoSetReadOnly(tInvite, false)
		DGS:dgsSetEnabled(bInvite, true)
	elseif (count==0) then
		--Noti:addBox("error", "Player not found or multiple were found.")
		DGS:dgsSetText(nameExistLbl, "Player not found or multiple were found.")
		DGS:dgsLabelSetColor(nameExistLbl, 255, 0, 0)
		--guiMemoSetReadOnly(tInvite, true)
		DGS:dgsSetEnabled(bInvite, false)
	end
	--guiLabelSetHorizontalAlign(lNameCheck, "center")
end
--bc there's no button for that \--Dharma
--[[
function btQuitFaction(button, state)
	if (button=="left") and (state=="up") and (source==gButtonQuit) then
		local numLeaders = 0
		local isLeader = false
		local localUsername = getPlayerName(getLocalPlayer())
		
		for k, v in ipairs(arrUsernames) do -- Find the player
			if (v==localUsername) then -- Found
				isLeader = arrLeaders[k]
			end
		end
		
		for k, v in ipairs(arrLeaders) do
			numLeaders = numLeaders + 1
		end
		
		--if (numLeaders==1) and (isLeader) then
			--outputChatBox("You must promote someone to lead this faction before quitting. You are the only leader.", 255, 0, 0)
		--else
			local sx, sy = guiGetScreenSize() 
			wConfirmQuit = guiCreateWindow(sx/2 - 125,sy/2 - 50,250,100,"Leaving Confirmation", false)
			local lQuestion = guiCreateLabel(0.05,0.25,0.9,0.3,"Do you really want to leave " .. getTeamName(theTeam) .. "?",true,wConfirmQuit)
			guiLabelSetHorizontalAlign (lQuestion,"center",true)
			local bYes = guiCreateButton(0.1,0.65,0.37,0.23,"Yes",true,wConfirmQuit)
			local bNo = guiCreateButton(0.53,0.65,0.37,0.23,"No",true,wConfirmQuit)
			addEventHandler("onClientGUIClick", getRootElement(), 
				function(button)
					if button=="left" and ( source == bYes or source == bNo ) then
						if source == bYes then
							hideFactionMenu()
							triggerServerEvent("cguiQuitFaction", getLocalPlayer())
						end
						if wConfirmQuit then
							destroyElement(wConfirmQuit)
							wConfirmQuit = nil
						end
					end
				end
			)
		--end
	end
end
]]
function btKickPlayer(button, state)
	if (button=="left") and (state=="up") and (source==gButtonKick) then
		local Selected = DGS:dgsGridListGetSelectedItem(gMemberGrid)
		local playerName =  string.gsub(tostring(memberUsernames[Selected]), " ", "_") --string.gsub(DGS:dgsGridListGetItemText(gMemberGrid, DGS:dgsGridListGetSelectedItem(gMemberGrid), 1), " ", "_")
		
		--if (playerName==getPlayerName(getLocalPlayer())) then
			--outputChatBox("You cannot kick yourself, quit instead.", thePlayer)
		--[[else]]if (playerName~="") then
			local row = DGS:dgsGridListGetSelectedItem(gMemberGrid)
			DGS:dgsGridListRemoveRow(gMemberGrid, row)
			
			local theTeamName = getTeamName(theTeam)
			
			outputChatBox("You removed " .. playerName:gsub("_", " ") .. " from the faction '" .. tostring(theTeamName) .. "'.", 0, 255, 0)
			triggerServerEvent("cguiKickPlayer", getLocalPlayer(), playerName)
		else
			outputChatBox("Please select a member to kick.")
		end
	end
end

function btButtonPerk(button, state)
	if (button=="left") and (state=="up") and (source==gButtonPerk) then
		local Selected = DGS:dgsGridListGetSelectedItem(gMemberGrid)
		local playerName = string.gsub(tostring(memberUsernames[Selected]), " ", "_") --DGS:dgsGridListGetItemText(gMemberGrid, DGS:dgsGridListGetSelectedItem(gMemberGrid), 1)
		--local playerName = string.gsub(bPerkActivePlayer, " ", "_")
		if (playerName == "") then
			outputChatBox("Please select a member to manage.")
			return
		end
		triggerServerEvent("Duty:GetPackages", resourceRoot, factionID1)
	end
end

wPerkWindow, bPerkSave, bPerkClose, bPerkChkTable, bPerkActivePlayer = nil
function gotPackages(factionPackages)
	bPerkChkTable = { }
	--local bPerkActivePlayer = DGS:dgsGridListGetItemText(gMemberGrid, DGS:dgsGridListGetSelectedItem(gMemberGrid), 1)
	local playerName = string.gsub(tostring(memberUsernames[DGS:dgsGridListGetSelectedItem(gMemberGrid)]), " ", "_")
			
	DGS:dgsSetInputEnabled(true)
	
	local width, height = 500, 540
	local scrWidth, scrHeight = guiGetScreenSize()
	local x = scrWidth/2 - (width/2)
	local y = scrHeight/2 - (height/2)
	
	wPerkWindow = DGS:dgsCreateWindow(x, y, width, height, "Faction perks for "..playerName, false,_,_,_,_,_,_,_,true)
	
	local factionPerks = false
	for k, v in ipairs(arrUsernames) do -- Find the player
		if (v==playerName) then -- Found
			factionPerks = arrPerks[k]
			--outputDebugString(getElementType(factionPerks))
			--outputDebugString(tostring(factionPerks))
		end
	end
	
	if not factionPerks then
		outputChatBox("Failed to load "..playerName.. " his faction perks")
		factionPerks = { }
	end
	
	local y = 0
	for index, factionPackage in pairs ( factionPackages ) do
		y = ( y or 0 ) + 20
		local tmpChk = DGS:dgsCreateCheckBox(0.05 * width, y + 3, 0.4 * width, 17, factionPackage[2], false, false, wPerkWindow)
		DGS:dgsSetFont(tmpChk, "default-bold-small")
		setElementData(tmpChk, "factionPackage:ID", factionPackage[1], false)
		setElementData(tmpChk, "factionPackage:selected", bPerkActivePlayer, false)
		
		for index, permissionID in pairs(factionPerks) do
			--outputDebugString(tostring(factionPackage["grantID"]) .. " vs "..tostring(permissionID))
			if (permissionID == factionPackage[1]) then
				--outputDebugString("win!")
				DGS:dgsCheckBoxSetSelected (tmpChk, true)
			end
		end
		
		table.insert(bPerkChkTable, tmpChk)
	end
	
	bPerkSave = DGS:dgsCreateButton(0.05, 0.900, 0.9, 0.045, "Save", true, wPerkWindow, tocolor(200, 200, 200, 255), _, _, btnRect, btnRecthov, btnRectClick)
	bPerkClose = DGS:dgsCreateButton(0.05, 0.950, 0.9, 0.045, "Close", true, wPerkWindow, tocolor(200, 200, 200, 255), _, _, btnRect, btnRecthov, btnRectClick)
	addEventHandler("onDgsMouseClick", bPerkSave, 
		function (button, state)
			if (source == bPerkSave) and (button=="left") and (state=="up") then
				if (wPerkWindow) then
					local collectedPerks = { }
					for _, checkBox in ipairs ( bPerkChkTable ) do
						if ( DGS:dgsCheckBoxGetSelected( checkBox ) ) then
							table.insert(collectedPerks, getElementData(checkBox, "factionPackage:ID") or -1 )
						end
					end
					
					triggerServerEvent("faction:perks:edit", getLocalPlayer(), collectedPerks, playerName)
					destroyElement(wPerkWindow)
					wPerkWindow, bPerkSave, bPerkClose, bPerkChkTable, bPerkActivePlayer = nil
					DGS:dgsSetInputEnabled(false)
				end
			end
		end
	, false)
	addEventHandler("onDgsMouseClick", bPerkClose, 
		function (button, state)
			if (source == bPerkClose) and (button=="left") and (state=="up") then
				if (wPerkWindow) then
					destroyElement(wPerkWindow)
					wPerkWindow, bPerkSave, bPerkClose, bPerkChkTable, bPerkActivePlayer = nil
					DGS:dgsSetInputEnabled(false)
				end
			end
		end
	, false)
end
addEvent("Duty:GotPackages", true)
addEventHandler("Duty:GotPackages", resourceRoot, gotPackages)

function btRespawnOneVehicle(button, state)
	if button == "left" and state == "up" then
		local vehID = DGS:dgsGridListGetItemText(gVehicleGrid, DGS:dgsGridListGetSelectedItem(gVehicleGrid), 1)
		if vehID then
			triggerServerEvent("cguiRespawnOneVehicle", getLocalPlayer(), vehID)
		else
			outputChatBox("Please select a vehicle to respawn.", 255, 0, 0)
		end
	end
end

function btToggleLeader(button, state)
	if (button=="left") and (state=="up") and (source==gButtonLeader) then
		local Selected = DGS:dgsGridListGetSelectedItem(gMemberGrid)
		local playerName =  string.gsub(tostring(memberUsernames[Selected]), " ", "_") --string.gsub(DGS:dgsGridListGetItemText(gMemberGrid, Selected, 1), " ", "_")
		local currentLevel = tostring(memberLeaders[Selected])
		--local currentLevel = DGS:dgsGridListGetItemText(gMemberGrid, DGS:dgsGridListGetSelectedItem(gMemberGrid), 5)
		
		if (playerName==getPlayerName(getLocalPlayer())) then
			outputChatBox("You cannot un-leader yourself.", thePlayer)
		elseif (playerName~="") then
			--local row = DGS:dgsGridListGetSelectedItem(gMemberGrid)
			
			if (currentLevel=="true") then --(currentLevel=="Leader") then
				--DGS:dgsGridListSetItemText(gMemberGrid, row, tonumber(colLeader), "Member", false, false)
				--DGS:dgsGridListSetSelectedItem(gMemberGrid, 0, 0)
				triggerServerEvent("cguiToggleLeader", getLocalPlayer(), playerName, false) -- false = not leader
			else
				--DGS:dgsGridListSetItemText(gMemberGrid, row, tonumber(colLeader), "Leader", false, false)
				--DGS:dgsGridListSetSelectedItem(gMemberGrid, 0, 0)
				triggerServerEvent("cguiToggleLeader", getLocalPlayer(), playerName, true) -- true = leader
			end
		else
			outputChatBox("Please select a member to toggle leader on.")
		end
	end
end


-- PHONE
--[[
local wPhone, tPhone
function btPhoneNumber(button, state)
	if (button=="left") and (state=="up") and (source==gAssignPhone) then
		local row = guiGridListGetSelectedItem(gMemberGrid)
		local playerName = guiGridListGetItemText(gMemberGrid, guiGridListGetSelectedItem(gMemberGrid), 1)
		if playerName ~= "" then
			local currentPhone = guiGridListGetItemText(gMemberGrid, row, colPhone):gsub(tmpPhone .. "%-", "")

			if not (wPhone) then
				local width, height = 300, 200
				local scrWidth, scrHeight = guiGetScreenSize()
				local x = scrWidth/2 - (width/2)
				local y = scrHeight/2 - (height/2)
				
				wPhone = guiCreateWindow(x, y, width, height, "Phone Number", false)
				tPhone = guiCreateEdit(0.3, 0.325, 0.85, 0.1, currentPhone, true, wPhone)
				guiSetProperty(tPhone, "ValidationString","[0-9]{0,2}")

				local tPre = guiCreateLabel(0.1, 0.325, 0.18, 0.1, tostring(tmpPhone) .. " -", true, wPhone)
				guiLabelSetHorizontalAlign(tPre, "right")
				guiSetFont(tPre, "default-bold-small")
				guiLabelSetVerticalAlign(tPre, "center")

				guiCreateLabel(0.1, 0.2, 0.8, 0.08, "Phone number for " .. playerName .. ":", true, wPhone)

				guiSetInputEnabled(true)
				
				bSet = guiCreateButton(0.1, 0.6, 0.85, 0.15, "Assign Phone No.", true, wPhone)
				addEventHandler("onClientGUIClick", bSet, setPhoneNumber, false)
				
				bClosePhone = guiCreateButton(0.1, 0.775, 0.85, 0.15, "Close Window", true, wPhone)
				addEventHandler("onClientGUIClick", bClosePhone, closePhone, false)


				addEventHandler("onClientGUIChanged", tPhone, function(element)
					guiSetEnabled(bSet, guiGetText(element) == "" or (#guiGetText(element) == 2 and type(tonumber(guiGetText(element))) == 'number' and numberIsUnused(tonumber(guiGetText(element)))))
					end, false)
			else
				guiBringToFront(wPhone)
			end
		else
			outputChatBox("Please select a member to toggle leader on.")
		end
	end
end

function closePhone(button, state)
	if (wPhone) then
		destroyElement(wPhone)
		wPhone = nil
	end
end

function setPhoneNumber(button, state)
	local text = guiGetText(tPhone)
	local num = tonumber(text)

	if text == "" then
		guiGridListSetItemText(gMemberGrid, guiGridListGetSelectedItem(gMemberGrid), colPhone, "", false, false)
	elseif #text and num then
		guiGridListSetItemText(gMemberGrid, guiGridListGetSelectedItem(gMemberGrid), colPhone, tostring(tmpPhone) .. "-" .. ("%02d"):format(num), false, true)
	else
		return "Invalid Format"
	end
	local playerName = guiGridListGetItemText(gMemberGrid, guiGridListGetSelectedItem(gMemberGrid), 1):gsub(" ", "_")

	triggerServerEvent("factionmenu:setphone", getLocalPlayer(), playerName, num)
	closePhone(button, state)
end

function numberIsUnused(number)
	local testText = tostring(tmpPhone) .. "-" .. ("%02d"):format(number)
	for i = 0, guiGridListGetRowCount(gMemberGrid) do
		if guiGridListGetItemText(gMemberGrid, i, colPhone) == testText and i ~= guiGridListGetSelectedItem(gMemberGrid) then
			return false
		end
	end
	return true
end
]]
--

function btPromotePlayer(button, state)
	if (button=="left") and (state=="up") and (source==gButtonPromote) then
		local row = DGS:dgsGridListGetSelectedItem(gMemberGrid)
		local playerName = string.gsub(tostring(memberUsernames[row]), " ", "_")
		local currentRank = factionRanks[tonumber(memberRanks[row])] --DGS:dgsGridListGetItemText(gMemberGrid, row, 2)
		if (playerName~="") then
			local currRankNumber = tonumber( DGS:dgsGridListGetItemData(gMemberGrid, row, colName) )
			promotionWindow[1] = DGS:dgsCreateWindow(0.3887,0.2383,0.1713,0.5834,"Promote / Demote Player",true,_,_,_,_,_,_,_,true)
			DGS:dgsWindowSetSizable(promotionWindow[1], false)
			promotionLabel[1] = DGS:dgsCreateLabel(0.0427,0.058,0.9145,0.044,"Please select Player_Name's new rank",true,promotionWindow[1])
			promotionRadio[20] = DGS:dgsCreateRadioButton(0.047,0.1071,0.9145,0.0402,"Generic Rank 20",true,promotionWindow[1])
			promotionRadio[19] = DGS:dgsCreateRadioButton(0.047,0.1473,0.9145,0.0402,"Generic Rank 19",true,promotionWindow[1])
			promotionRadio[18] = DGS:dgsCreateRadioButton(0.047,0.1875,0.9145,0.0402,"Generic Rank 18",true,promotionWindow[1])
			promotionRadio[17] = DGS:dgsCreateRadioButton(0.047,0.2277,0.9145,0.0402,"Generic Rank 17",true,promotionWindow[1])
			promotionRadio[16] = DGS:dgsCreateRadioButton(0.047,0.2679,0.9145,0.0402,"Generic Rank 16",true,promotionWindow[1])
			promotionRadio[15] = DGS:dgsCreateRadioButton(0.047,0.308,0.9145,0.0402,"Generic Rank 15",true,promotionWindow[1])
			promotionRadio[14] = DGS:dgsCreateRadioButton(0.047,0.3482,0.9145,0.0402,"Generic Rank 14",true,promotionWindow[1])
			promotionRadio[13] = DGS:dgsCreateRadioButton(0.047,0.3884,0.9145,0.0402,"Generic Rank 13",true,promotionWindow[1])
			promotionRadio[12] = DGS:dgsCreateRadioButton(0.047,0.4286,0.9145,0.0402,"Generic Rank 12",true,promotionWindow[1])
			promotionRadio[11] = DGS:dgsCreateRadioButton(0.047,0.4688,0.9145,0.0402,"Generic Rank 11",true,promotionWindow[1])
			promotionRadio[10] = DGS:dgsCreateRadioButton(0.047,0.5089,0.9145,0.0402,"Generic Rank 10",true,promotionWindow[1])
			promotionRadio[9] = DGS:dgsCreateRadioButton(0.047,0.5491,0.9145,0.0402,"Generic Rank 9",true,promotionWindow[1])
			promotionRadio[8] = DGS:dgsCreateRadioButton(0.047,0.5893,0.9145,0.0402,"Generic Rank 8",true,promotionWindow[1])
			promotionRadio[7] = DGS:dgsCreateRadioButton(0.047,0.6295,0.9145,0.0402,"Generic Rank 7",true,promotionWindow[1])
			promotionRadio[6] = DGS:dgsCreateRadioButton(0.047,0.6696,0.9145,0.0402,"Generic Rank 6",true,promotionWindow[1])
			promotionRadio[5] = DGS:dgsCreateRadioButton(0.047,0.7098,0.9145,0.0402,"Generic Rank 5",true,promotionWindow[1])
			promotionRadio[4] = DGS:dgsCreateRadioButton(0.047,0.75,0.9145,0.0402,"Generic Rank 4",true,promotionWindow[1])
			promotionRadio[3] = DGS:dgsCreateRadioButton(0.047,0.7902,0.9145,0.0402,"Generic Rank 3",true,promotionWindow[1])
			promotionRadio[2] = DGS:dgsCreateRadioButton(0.047,0.8304,0.9145,0.0402,"Generic Rank 2",true,promotionWindow[1])
			promotionRadio[1] = DGS:dgsCreateRadioButton(0.047,0.8705,0.9145,0.0402,"Generic Rank 1",true,promotionWindow[1])
			promotionButton[1] = DGS:dgsCreateButton(0.0427,0.9107,0.4231,0.067,"Save",true,promotionWindow[1], tocolor(200, 200, 200, 255), _, _, btnRect, btnRecthov, btnRectClick)
			promotionButton[2] = DGS:dgsCreateButton(0.5214,0.9107,0.4231,0.067,"Close",true,promotionWindow[1], tocolor(200, 200, 200, 255), _, _, btnRect, btnRecthov, btnRectClick)
			DGS:dgsRadioButtonSetSelected(promotionRadio[currRankNumber], true)
			DGS:dgsSetText(promotionLabel[1], "Please select " .. playerName:gsub("_"," ") .. "'s new rank")
			for i = 1, 20 do
				DGS:dgsSetText(promotionRadio[i], "Rank " .. i .. ": " .. arrFactionRanks[i])
			end
			addEventHandler("onDgsMouseClick", promotionButton[1], savePromotion, false)
			addEventHandler("onDgsMouseClick", promotionButton[2], closePromotion, false)
		else
			outputChatBox("Please select a member to promote / demote.", 255, 0, 0)
		end
	end
end

function savePromotion(button, state)
	if button == "left" and state == "up" and source == promotionButton[1] then
		local newRank = 0
		for key, value in ipairs(promotionRadio) do
			if isElement(value) then
				if DGS:dgsRadioButtonGetSelected(value) then
					newRank = key
					break
				end
			end
		end
		local row = DGS:dgsGridListGetSelectedItem(gMemberGrid)
		local playerName = string.gsub(tostring(memberUsernames[row]), " ", "_")--string.gsub(DGS:dgsGridListGetItemText(gMemberGrid, DGS:dgsGridListGetSelectedItem(gMemberGrid), 1), " ", "_")
		local currRankNumber = tonumber(DGS:dgsGridListGetItemData(gMemberGrid, row, colName))
		if newRank == currRankNumber then
			outputChatBox("You must select a new rank to make the player", 255, 0, 0)
			closePromotion("left", "up")
		elseif newRank > currRankNumber then
			DGS:dgsGridListSetItemData(gMemberGrid, row, colName, tostring(newRank))
			triggerServerEvent("cguiPromotePlayer", getLocalPlayer(), playerName, newRank, arrFactionRanks[currRankNumber], arrFactionRanks[newRank])
			DGS:dgsGridListSetSelectedItem(gMemberGrid, row, colName)
			closePromotion("left", "up")
		elseif newRank < currRankNumber then
			DGS:dgsGridListSetItemData(gMemberGrid, row, colName, tostring(newRank))
			triggerServerEvent("cguiDemotePlayer", getLocalPlayer(), playerName, newRank, arrFactionRanks[currRankNumber], arrFactionRanks[newRank])
			DGS:dgsGridListSetSelectedItem(gMemberGrid, row, colName)
			closePromotion("left", "up")
		else
			outputChatBox("FAC-PRMO-ERROR-0001 - Please report on the forums.", 255, 0, 0)
		end
	end
end

function closePromotion(button, state)
	if button == "left" and state == "up" then
		destroyElement(promotionWindow[1])
	end
end

function reselectItem(grid, row, col)
	DGS:dgsGridListSetSelectedItem(grid, row, col)
end

function hideFactionMenu()
factionTable = {}
	showCursor(false)
	DGS:dgsSetInputEnabled(false)
	
	if (gFactionWindow) then
		destroyElement(gFactionWindow)
	end
	
	gFactionWindow, gMemberGrid = nil
	triggerServerEvent("factionmenu:hide", getLocalPlayer())
	
	if (wInvite) then
		destroyElement(wInvite)
		wInvite, tInvite, lNameCheck, bInvite, bInviteClose, invitedPlayer = nil, nil, nil, nil, nil, nil
	end

	if wPhone then
		destroyElement(wPhone)
		wPhone = nil
	end
	
	if (wMOTD) then
		destroyElement(wMOTD)
		wMOTD, tMOTD, bUpdate, bMOTDClose = nil, nil, nil, nil
	end
	
	if (wRanks) then
		destroyElement(wRanks)
		lRanks, tRanks, tRankWages, wRanks, bRanksSave, bRanksClose = nil, nil, nil, nil, nil, nil
	end
	
	--[[if (showrespawn) then
		destroyElement(showrespawn)
		gButtonRespawn, bButtonNo = nil, nil

	end]]--
	local t = getElementData(resourceRoot, "DutyGUI") or {}
	if t[getLocalPlayer()] then
		t[getLocalPlayer()] = nil
		setElementData(resourceRoot, "DutyGUI", t)
	end
	
	if isElement(tabDuty) then
		destroyElement(tabDuty)
	end

	if isElement(promotionWindow[1]) then
		destroyElement(promotionWindow[1])
	end
	
	-- Clear variables (should reduce lag a tiny bit clientside)
	gFactionWindow, gMemberGrid, gMOTDLabel, colName, colRank, colWage, colLastLogin, --[[colLocation,]] colLeader, colOnline, gButtonKick, gButtonPromote, gButtonDemote, gButtonEditRanks, gButtonEditMOTD, gButtonInvite, gButtonLeader, gButtonQuit, gButtonExit = nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
	theMotd, theTeam, arrUsernames, arrRanks, arrLeaders, arrOnline, arrFactionRanks, --[[arrLocations,]] arrFactionWages, arrLastLogin, membersOnline, membersOffline = nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
	removeEventHandler("onClientRender", getRootElement(), checkF3)
end
addEvent("hideFactionMenu", true)
addEventHandler("hideFactionMenu", getRootElement(), hideFactionMenu)

function resourceStopped()
	showCursor(false)
	guiSetInputEnabled(false)

	setElementData(getLocalPlayer(), "savedLocations", false)
	setElementData(getLocalPlayer(), "savedSkins", false)
end
addEventHandler("onClientResourceStop", getResourceRootElement(), resourceStopped)

function btRespawnVehicles(button, state)
	if (button=="left") and (state=="down") then
		if source == gButtonRespawn then
			hideFactionMenu()
			destroyElement(showrespawnUI)
			triggerServerEvent("cguiRespawnVehicles", getLocalPlayer())
		end
	end
end

function loadFinance()
	--if source == tabFinance then
	--if DGS:dgsGridListGetSelectedItem(maingrid) == 6 then
		--if not financeLoaded then	
			--local label = DGS:dgsCreateLabel(0,0,1,1,"Loading...",true,DfinanceRectImg)
			--DGS:dgsLabelSetHorizontalAlign(label, "center", false)
			--DGS:dgsLabelSetVerticalAlign(label, "center")
			triggerServerEvent("factionmenu:getFinance", getResourceRootElement())
		--end
	--end
end

function fillFinance(factionID, bankThisWeek, bankPrevWeek, bankmoney, vehiclesvalue, propertiesvalue)
	financeLoaded = true
	for k,v in ipairs(getElementChildren(DfinanceRectImg)) do
		destroyElement(v)
	end

	--local financeTabs = guiCreateTabPanel(10, 36, 1048, 346, false, tabFinance)

	--[[
	financeCombo = guiCreateComboBox(12, 8, 123, 70, "This week", false, tabFinance)
	guiComboBoxAddItem(financeCombo, "This week")
	guiComboBoxAddItem(financeCombo, "Last week") 
	--]]

	--tabWeeklyStatement = guiCreateTab("Weekly Statement", financeTabs)

		weeklyStatementGridlist = DGS:dgsCreateGridList(15, 24, 725, 150, false, DfinanceRectImg, _, tocolor(10,10,10,255), _, tocolor(10,10,10,255))
		statementColText = DGS:dgsGridListAddColumn(weeklyStatementGridlist, "", 0.4)
		statementColLast = DGS:dgsGridListAddColumn(weeklyStatementGridlist, "Last week", 0.25)
		statementColThis = DGS:dgsGridListAddColumn(weeklyStatementGridlist, "This week", 0.25)

		assetsGridlist = DGS:dgsCreateGridList(15, 195, 725, 150, false, DfinanceRectImg, _, tocolor(10,10,10,255), _, tocolor(10,10,10,255))
		DGS:dgsGridListAddColumn(assetsGridlist, "Assets", 0.65)
		DGS:dgsGridListAddColumn(assetsGridlist, "Value", 0.25)

		local row = DGS:dgsGridListAddRow(assetsGridlist)
		DGS:dgsGridListSetItemText(assetsGridlist, row, 1, "Bank Account", false, false)
		DGS:dgsGridListSetRowBackGroundColor(assetsGridlist,row,tocolor(25, 25, 25, 200),tocolor(7, 112, 196, 200),tocolor(7, 112, 196, 255))
		if not bankmoney then bankmoney = 0 end
		DGS:dgsGridListSetItemText(assetsGridlist, row, 2, "$"..tostring(exports.global:formatMoney(bankmoney)), false, false)
		local row = DGS:dgsGridListAddRow(assetsGridlist)
		DGS:dgsGridListSetRowBackGroundColor(assetsGridlist,row,tocolor(25, 25, 25, 200),tocolor(7, 112, 196, 200),tocolor(7, 112, 196, 255))
		DGS:dgsGridListSetItemText(assetsGridlist, row, 1, "Vehicles", false, false)
		if not vehiclesvalue then vehiclesvalue = 0 end
		DGS:dgsGridListSetItemText(assetsGridlist, row, 2, "$"..tostring(exports.global:formatMoney(vehiclesvalue)), false, false)
		local row = DGS:dgsGridListAddRow(assetsGridlist)
		DGS:dgsGridListSetRowBackGroundColor(assetsGridlist,row,tocolor(25, 25, 25, 200),tocolor(7, 112, 196, 200),tocolor(7, 112, 196, 255))
		DGS:dgsGridListSetItemText(assetsGridlist, row, 1, "Properties", false, false)
		if not propertiesvalue then propertiesvalue = 0 end
		DGS:dgsGridListSetItemText(assetsGridlist, row, 2, "$"..tostring(exports.global:formatMoney(propertiesvalue)), false, false)

		local row = DGS:dgsGridListAddRow(assetsGridlist)
		DGS:dgsGridListSetItemText(assetsGridlist, row, 1, "TOTAL", false, false)
		DGS:dgsGridListSetItemText(assetsGridlist, row, 2, "$"..tostring(exports.global:formatMoney(bankmoney+vehiclesvalue+propertiesvalue)), false, false)
		DGS:dgsGridListSetRowBackGroundColor(assetsGridlist,row,tocolor(25, 25, 25, 200),tocolor(7, 112, 196, 200),tocolor(7, 112, 196, 255))
		DGS:dgsSetProperty(assetsGridlist,"rowHeight",30)

        --local label1 = DGS:dgsCreateLabel(413, 10, 156, 30, "Faction finance information goes maximum 2 weeks back.", false, tabWeeklyStatement)
        --	DGS:dgsSetFont(label1, "default-small")
        --	DGS:dgsLabelSetHorizontalAlign(label1, "left", true)

       -- local label2 = DGS:dgsCreateLabel(413, 292, 156, 15, "Double-click a line to show details.", false, tabWeeklyStatement)
        	--DGS:dgsSetFont(label2, "default-small")

	--tabTransactions = guiCreateTab("Transactions", financeTabs)
		transactionsGridlist = DGS:dgsCreateGridList(15, 367, 725, 150, false, DfinanceRectImg, _, tocolor(10,10,10,255), _, tocolor(10,10,10,255))
		transcroll = DGS:dgsGridListGetScrollBar( transactionsGridlist )
	DGS:dgsSetProperty(transcroll,"arrowColor",{tocolor(10,10,10,255), tocolor(0, 163, 255, 225), tocolor(0, 163, 255, 255)})
	DGS:dgsSetProperty(transcroll,"cursorColor",{tocolor(25,25,25,255), tocolor(0, 163, 255, 225), tocolor(0, 163, 255, 255)})
	
		local transactionColumns = {
			{ "ID", 0.05 },
			{ "Type", 0.05 },
			{ "From", 0.15 },
			{ "To", 0.25 },
			{ "Amount", 0.07 },
			{ "Date", 0.19 },
			{ "Week", 0.07 },
			{ "Reason", 0.24 }
		}
		for key, value in ipairs(transactionColumns) do
			DGS:dgsGridListAddColumn(transactionsGridlist, value[1], value[2] or 0.1)
		end

	thisWeek = {
		["income"] = 0,
		["expenses"] = 0,
		["profit"] = 0,
		
		["incomingTransfers"] = 0,
		["deposits"] = 0,
		["budget"] = 0,
		
		["outgoingTransfers"] = 0,
		["withdrawals"] = 0,
		["wages"] = 0,
		["fuel"] = 0,
		["repair"] = 0,
	}
	lastWeek = {
		["income"] = 0,
		["expenses"] = 0,
		["profit"] = 0,
		
		["incomingTransfers"] = 0,
		["deposits"] = 0,
		["budget"] = 0,
		
		["outgoingTransfers"] = 0,
		["withdrawals"] = 0,
		["wages"] = 0,
		["fuel"] = 0,
		["repair"] = 0,
	}

	for k,v in ipairs(bankThisWeek) do
		local amount
		--[[
		if v.to == -factionID then
			amount = v.amount
		elseif v.from == -factionID then
			amount = -v.amount
		else
			amount = v.amount
		end
		--]]
		amount = v.amount

		if v.type == 0 then --withdraw personal
			
		elseif v.type == 1 then --deposit personal

		elseif v.type == 2 then --transfer from personal to personal
			thisWeek.incomingTransfers = thisWeek.incomingTransfers + amount
			thisWeek.income = thisWeek.income + amount
		elseif v.type == 3 then --transfer from business to personal
			thisWeek.outgoingTransfers = thisWeek.outgoingTransfers + amount
			thisWeek.expenses = thisWeek.expenses + amount
		elseif v.type == 4 then --withdraw business
			thisWeek.withdrawals = thisWeek.withdrawals + amount
			thisWeek.expenses = thisWeek.expenses + amount
		elseif v.type == 5 then --deposit business
			thisWeek.deposits = thisWeek.deposits + amount
			thisWeek.income = thisWeek.income + amount
		elseif v.type == 6 then --wage/state benefits
			thisWeek.wages = thisWeek.wages + amount
			thisWeek.expenses = thisWeek.expenses + amount
		elseif v.type == 7 then --everything in payday except wage/state benefits

		elseif v.type == 8 then --faction budget
			thisWeek.budget = thisWeek.budget + amount
			thisWeek.income = thisWeek.income + amount
		elseif v.type == 9 then --fuel
			thisWeek.fuel = thisWeek.fuel + amount
			thisWeek.expenses = thisWeek.expenses + amount
		elseif v.type == 10 then --repair
			thisWeek.repair = thisWeek.repair + amount
			thisWeek.expenses = thisWeek.expenses + amount
		end

	end
	for k,v in ipairs(bankPrevWeek) do
		local amount = 0
		if v.to == -factionID then
			amount = v.amount
		elseif v.from == -factionID then
			amount = -v.amount
		end

		if v.type == 0 then --withdraw personal
			
		elseif v.type == 1 then --deposit personal

		elseif v.type == 2 then --transfer from personal to personal
			lastWeek.incomingTransfers = lastWeek.incomingTransfers + amount
			lastWeek.income = lastWeek.income + amount
		elseif v.type == 3 then --transfer from business to personal
			lastWeek.outgoingTransfers = lastWeek.outgoingTransfers + amount
			lastWeek.expenses = lastWeek.expenses + amount
		elseif v.type == 4 then --withdraw business
			lastWeek.withdrawals = lastWeek.withdrawals + amount
			lastWeek.expenses = lastWeek.expenses + amount
		elseif v.type == 5 then --deposit business
			lastWeek.deposits = lastWeek.deposits + amount
			lastWeek.income = lastWeek.income + amount
		elseif v.type == 6 then --wage/state benefits
			lastWeek.wages = lastWeek.wages + amount
			lastWeek.expenses = lastWeek.expenses + amount
		elseif v.type == 7 then --everything in payday except wage/state benefits

		elseif v.type == 8 then --faction budget
			lastWeek.budget = lastWeek.budget + amount
			lastWeek.income = lastWeek.income + amount
		elseif v.type == 9 then --fuel
			lastWeek.fuel = lastWeek.fuel + amount
			lastWeek.expenses = lastWeek.expenses + amount
		elseif v.type == 10 then --repair
			lastWeek.repair = lastWeek.repair + amount
			lastWeek.expenses = lastWeek.expenses + amount
		end
	end

	lastWeek.profit = lastWeek.income + lastWeek.expenses
	thisWeek.profit = thisWeek.income + thisWeek.expenses

	insertStatement = {
		--varName, text, subinfo, transaction types
		{"income", "Income", { {"incomingTransfers", "Incoming Transfers", false, {[2]=true}}, {"deposits", "Bank Deposits", false, {[5]=true}}, {"budget", "Budget", false, {[8]=true}}, }, false },
		{"expenses", "Expenses", { {"outgoingTransfers", "Outgoing Transfers", false, {[3]=true}}, {"withdrawals", "Bank Withdrawals", false, {[4]=true}}, {"wages", "Wages", false, {[6]=true}}, {"fuel", "Fuel", false, {[9]=true}}, {"repair", "Repairs", false, {[10]=true}}, }, false },
		{"profit", "Profit", false, false},
	}

	for k,v in ipairs(insertStatement) do
		local rowVar = v[1]
		local rowText = v[2]
		local rowSub = v[3]

		local row = DGS:dgsGridListAddRow(weeklyStatementGridlist)
		DGS:dgsGridListSetItemText(weeklyStatementGridlist, row, statementColText, rowText, false, false)
		DGS:dgsGridListSetItemData(weeklyStatementGridlist, row, statementColText, rowVar)
		DGS:dgsGridListSetItemText(weeklyStatementGridlist, row, statementColLast, "$"..tostring(exports.global:formatMoney(lastWeek[rowVar])), false, false)
		DGS:dgsGridListSetItemText(weeklyStatementGridlist, row, statementColThis, "$"..tostring(exports.global:formatMoney(thisWeek[rowVar])), false, false)
		DGS:dgsGridListSetRowBackGroundColor(weeklyStatementGridlist,row,tocolor(25, 25, 25, 200),tocolor(7, 112, 196, 200),tocolor(7, 112, 196, 255))
		DGS:dgsSetProperty(weeklyStatementGridlist,"rowHeight",30)
		
		if lastWeek[rowVar] > 0 then
			DGS:dgsGridListSetItemColor(weeklyStatementGridlist, row, statementColLast, 0, 148, 0)
		elseif lastWeek[rowVar] < 0 then
			DGS:dgsGridListSetItemColor(weeklyStatementGridlist, row, statementColLast, 171, 0, 0)
		else
			DGS:dgsGridListSetItemColor(weeklyStatementGridlist, row, statementColLast, 122, 122, 122)
		end
		if thisWeek[rowVar] > 0 then
			DGS:dgsGridListSetItemColor(weeklyStatementGridlist, row, statementColThis, 0, 255, 0)
		elseif thisWeek[rowVar] < 0 then
			DGS:dgsGridListSetItemColor(weeklyStatementGridlist, row, statementColThis, 255, 0, 0)
		else
			DGS:dgsGridListSetItemColor(weeklyStatementGridlist, row, statementColThis, 255, 255, 255)
		end
	end

	addEventHandler("onDgsMouseDoubleClick", weeklyStatementGridlist, function(btn,state)
		if btn == "left" and state == "down" then -- this shit save my a$$
		local selectedRow, selectedCol = DGS:dgsGridListGetSelectedItem(weeklyStatementGridlist)
		local rowvar = DGS:dgsGridListGetItemData(weeklyStatementGridlist, selectedRow, 1)
		local parent = false
		local rows = false
		local transTypes = false
		if rowvar then
			for k,v in ipairs(insertStatement) do
				if v[1] == rowvar then
					parent = true
					rows = v[3]
					transTypes = v[4]
					thisText = v[2]
					break
				elseif v[3] then
					for k2,v2 in ipairs(v[3]) do
						if v2[1] == rowvar then
							parent = true
							rows = v2[3]
							transTypes = v2[4]
							thisText = v2[2]
							break
						end
					end
					if parent then break end
				end
			end
		else
			rows = insertStatement
		end
		if rows then
			--if tabStatementDetails then
				--guiDeleteTab(tabStatementDetails, financeTabs)
			--	tabStatementDetails = nil
		--	end
			DGS:dgsGridListClear(weeklyStatementGridlist)
			local row = DGS:dgsGridListAddRow(weeklyStatementGridlist)
			if parent then
				DGS:dgsGridListSetItemText(weeklyStatementGridlist, row, statementColText, "...", false, false)
			end
			for k,v in ipairs(rows) do
				local rowVar = v[1]
				local rowText = v[2]
				local rowSub = v[3]

				local row = DGS:dgsGridListAddRow(weeklyStatementGridlist)
				DGS:dgsGridListSetItemText(weeklyStatementGridlist, row, statementColText, rowText, false, false)
				DGS:dgsGridListSetItemData(weeklyStatementGridlist, row, statementColText, rowVar)
				DGS:dgsGridListSetItemText(weeklyStatementGridlist, row, statementColLast, "$"..tostring(exports.global:formatMoney(lastWeek[rowVar])), false, false)
				DGS:dgsGridListSetItemText(weeklyStatementGridlist, row, statementColThis, "$"..tostring(exports.global:formatMoney(thisWeek[rowVar])), false, false)
					DGS:dgsGridListSetRowBackGroundColor(weeklyStatementGridlist,row,tocolor(25, 25, 25, 200),tocolor(7, 112, 196, 200),tocolor(7, 112, 196, 255))
				if lastWeek[rowVar] > 0 then
					DGS:dgsGridListSetItemColor(weeklyStatementGridlist, row, statementColLast, 0, 148, 0)
				elseif lastWeek[rowVar] < 0 then
					DGS:dgsGridListSetItemColor(weeklyStatementGridlist, row, statementColLast, 171, 0, 0)
				else
					DGS:dgsGridListSetItemColor(weeklyStatementGridlist, row, statementColLast, 122, 122, 122)
				end
				if thisWeek[rowVar] > 0 then
					DGS:dgsGridListSetItemColor(weeklyStatementGridlist, row, statementColThis, 0, 255, 0)
				elseif thisWeek[rowVar] < 0 then
					DGS:dgsGridListSetItemColor(weeklyStatementGridlist, row, statementColThis, 255, 0, 0)
				else
					DGS:dgsGridListSetItemColor(weeklyStatementGridlist, row, statementColThis, 255, 255, 255)
				end				
			end
		elseif transTypes then
			--outputDebugString("transTypes")
			--if tabStatementDetails then
			--	guiDeleteTab(tabStatementDetails, financeTabs)
			--	tabStatementDetails = nil
		--	end
			--if not tabStatementDetails then
				--tabStatementDetails = guiCreateTab("Details: "..tostring(thisText), financeTabs)
				transactionDetailsGridlist = DGS:dgsCreateGridList(15, 367, 725, 150, false, DfinanceRectImg)

				local transactionColumns = {
					{ "ID", 0.09 },
					{ "Type", 0.03 },
					{ "From", 0.2 },
					{ "To", 0.2 },
					{ "Amount", 0.07 },
					{ "Date", 0.1 },
					{ "Week", 0.03 },
					{ "Reason", 0.24 }
				}
				for key, value in ipairs(transactionColumns) do
					DGS:dgsGridListAddColumn(transactionDetailsGridlist, value[1], value[2] or 0.1)
					
				end				
			--end
			for k,v in ipairs(bankThisWeek) do
				if transTypes[v.type] then
					local row = DGS:dgsGridListAddRow(transactionDetailsGridlist)
					DGS:dgsGridListSetItemText(transactionDetailsGridlist, row, 1, tostring(v.id), false, false)
					DGS:dgsGridListSetItemText(transactionDetailsGridlist, row, 2, tostring(v.type), false, false)
					DGS:dgsGridListSetItemText(transactionDetailsGridlist, row, 3, tostring(v.from), false, false)
					DGS:dgsGridListSetItemText(transactionDetailsGridlist, row, 4, tostring(v.to), false, false)
					DGS:dgsGridListSetItemText(transactionDetailsGridlist, row, 5, tostring(exports.global:formatMoney(v.amount)), false, false)

					if v.amount > 0 then
						DGS:dgsGridListSetItemColor(transactionDetailsGridlist, row, 5, 0, 255, 0)
					elseif v.amount < 0 then
						DGS:dgsGridListSetItemColor(transactionDetailsGridlist, row, 5, 255, 0, 0)
					end
					DGS:dgsGridListSetItemText(transactionDetailsGridlist, row, 6, tostring(v.time), false, false)
					DGS:dgsGridListSetItemText(transactionDetailsGridlist, row, 7, tostring(v.week), false, false)
					DGS:dgsGridListSetItemText(transactionDetailsGridlist, row, 8, tostring(v.reason), false, false)
				end
			end
			for k,v in ipairs(bankPrevWeek) do
				if transTypes[v.type] then
					local row = DGS:dgsGridListAddRow(transactionDetailsGridlist)
					DGS:dgsGridListSetItemText(transactionDetailsGridlist, row, 1, tostring(v.id), false, false)
					DGS:dgsGridListSetItemText(transactionDetailsGridlist, row, 2, tostring(v.type), false, false)
					DGS:dgsGridListSetItemText(transactionDetailsGridlist, row, 3, tostring(v.from), false, false)
					DGS:dgsGridListSetItemText(transactionDetailsGridlist, row, 4, tostring(v.to), false, false)
					DGS:dgsGridListSetItemText(transactionDetailsGridlist, row, 5, tostring(exports.global:formatMoney(v.amount)), false, false)
					if v.amount > 0 then
						DGS:dgsGridListSetItemColor(transactionDetailsGridlist, row, 5, 0, 255, 0)
					elseif v.amount < 0 then
						DGS:dgsGridListSetItemColor(transactionDetailsGridlist, row, 5, 255, 0, 0)
					end
					DGS:dgsGridListSetItemText(transactionDetailsGridlist, row, 6, tostring(v.time), false, false)
					DGS:dgsGridListSetItemText(transactionDetailsGridlist, row, 7, tostring(v.week), false, false)
					DGS:dgsGridListSetItemText(transactionDetailsGridlist, row, 8, tostring(v.reason), false, false)
				end
			end
			end--guiSetSelectedTab(financeTabs, tabStatementDetails)
		end
	end, false)

	for k,v in ipairs(bankThisWeek) do
		local row = DGS:dgsGridListAddRow(transactionsGridlist)
		DGS:dgsGridListSetItemText(transactionsGridlist, row, 1, tostring(v.id), false, false)
		DGS:dgsGridListSetItemText(transactionsGridlist, row, 2, tostring(v.type), false, false)
		DGS:dgsGridListSetItemText(transactionsGridlist, row, 3, tostring(v.from), false, false)
		DGS:dgsGridListSetItemText(transactionsGridlist, row, 4, tostring(v.to), false, false)
		DGS:dgsGridListSetItemText(transactionsGridlist, row, 5, tostring(exports.global:formatMoney(v.amount)), false, false)
		DGS:dgsGridListSetRowBackGroundColor(transactionsGridlist,row,tocolor(25, 25, 25, 200),tocolor(7, 112, 196, 200),tocolor(7, 112, 196, 255))
		DGS:dgsSetProperty(transactionsGridlist,"rowHeight",30)
		if v.amount > 0 then
			DGS:dgsGridListSetItemColor(transactionsGridlist, row, 5, 0, 255, 0)
		elseif v.amount < 0 then
			DGS:dgsGridListSetItemColor(transactionsGridlist, row, 5, 255, 0, 0)
		end
		DGS:dgsGridListSetItemText(transactionsGridlist, row, 6, tostring(v.time), false, false)
		DGS:dgsGridListSetItemText(transactionsGridlist, row, 7, tostring(v.week), false, false)
		DGS:dgsGridListSetItemText(transactionsGridlist, row, 8, tostring(v.reason), false, false)
	end
	for k,v in ipairs(bankPrevWeek) do
		local row = DGS:dgsGridListAddRow(transactionsGridlist)
		DGS:dgsGridListSetItemText(transactionsGridlist, row, 1, tostring(v.id), false, false)
		DGS:dgsGridListSetItemText(transactionsGridlist, row, 2, tostring(v.type), false, false)
		DGS:dgsGridListSetItemText(transactionsGridlist, row, 3, tostring(v.from), false, false)
		DGS:dgsGridListSetItemText(transactionsGridlist, row, 4, tostring(v.to), false, false)
		DGS:dgsGridListSetItemText(transactionsGridlist, row, 5, tostring(exports.global:formatMoney(v.amount)), false, false)
		if v.amount > 0 then
			DGS:dgsGridListSetItemColor(transactionsGridlist, row, 5, 0, 255, 0)
		elseif v.amount < 0 then
			DGS:dgsGridListSetItemColor(transactionsGridlist, row, 5, 255, 0, 0)
		end
		DGS:dgsGridListSetItemText(transactionsGridlist, row, 6, tostring(v.time), false, false)
		DGS:dgsGridListSetItemText(transactionsGridlist, row, 7, tostring(v.week), false, false)
		DGS:dgsGridListSetItemText(transactionsGridlist, row, 8, tostring(v.reason), false, false)
	end

end
addEvent("factionmenu:fillFinance", true)
addEventHandler("factionmenu:fillFinance", getResourceRootElement(), fillFinance)

--[[
	Transaction Types:
	0: Withdraw Personal
	1: Deposit Personal
	2: Transfer from Personal to Personal
	3: Transfer from Business to Personal
	4: Withdraw Business
	5: Deposit Business
	6: Wage/State Benefits
	7: everything in payday except Wage/State Benefits
	8: faction budget
	9: fuel
	10: repair
]]

-- Made by Chaos for OwlGaming - Custom Duties
Duty = {
    gridlist = {},
    button = {},
    label = {}
}

customEditID = 0
locationEditID = 0

-- 35 for logs
function centerWindow (center_window)
    local screenW, screenH = guiGetScreenSize()
    local windowW, windowH = guiGetSize(center_window, false)
    local x, y = (screenW - windowW) /2,(screenH - windowH) /2
    guiSetPosition(center_window, x, y, false)
end

function beginLoad()
	DGS:dgsGridListAddRow(Duty.gridlist[1])
	DGS:dgsGridListSetItemText(Duty.gridlist[1], 0, 2, "Loading", false, false)

	DGS:dgsGridListAddRow(Duty.gridlist[2])
	DGS:dgsGridListSetItemText(Duty.gridlist[2], 0, 1, "Loading", false, false)

	DGS:dgsGridListAddRow(Duty.gridlist[3])
	DGS:dgsGridListSetItemText(Duty.gridlist[3], 0, 1, "Loading", false, false)

	--[[guiGridListAddRow(Duty.gridlist[4])
	guiGridListSetItemText(Duty.gridlist[4], 0, 1, "Loading", false, false)]]

	triggerServerEvent("fetchDutyInfo", resourceRoot, factionID1)
end

function importData(custom, locations, factionID, message)
	if not isElement(gFactionWindow) then
		return
	end
	customg = custom
	locationsg = locations
	factionIDg = factionID 
	forceDutyClose = true
	forceLocationClose = true
	if locationEditID == 0 then
		forceLocationClose = false
	end
	if customEditID == 0 then
		forceDutyClose = false
	end
	DGS:dgsGridListClear( Duty.gridlist[1] )
	DGS:dgsGridListClear( Duty.gridlist[2] )
	DGS:dgsGridListClear( Duty.gridlist[3] )
	for k,v in pairs(custom) do
		local row = DGS:dgsGridListAddRow(Duty.gridlist[2])

		DGS:dgsGridListSetItemText(Duty.gridlist[2], row, 1, tostring(v[1]), false, true)
		DGS:dgsGridListSetItemText(Duty.gridlist[2], row, 2, v[2], false, false)
		t = {}
		for key, val in pairs(v[4]) do
			table.insert(t, key)
		end
		DGS:dgsGridListSetItemText(Duty.gridlist[2], row, 3, table.concat(t, ", "), false, false)
		if customEditID == tonumber(v[1]) then
			forceDutyClose = false
		end
	end
	for k,v in pairs(locations) do
		if not v[10] then
			local row = DGS:dgsGridListAddRow(Duty.gridlist[1])

			DGS:dgsGridListSetItemText(Duty.gridlist[1], row, 1, tostring(v[1]), false, true)
			DGS:dgsGridListSetItemText(Duty.gridlist[1], row, 2, tostring(v[2]), false, false)
			DGS:dgsGridListSetItemText(Duty.gridlist[1], row, 3, tostring(v[6]), false, false)
			DGS:dgsGridListSetItemText(Duty.gridlist[1], row, 4, tostring(v[8]), false, false)
			DGS:dgsGridListSetItemText(Duty.gridlist[1], row, 5, tostring(v[7]), false, false)
			DGS:dgsGridListSetItemText(Duty.gridlist[1], row, 6, tostring(v[3]), false, false)
			DGS:dgsGridListSetItemText(Duty.gridlist[1], row, 7, tostring(v[4]), false, false)
			DGS:dgsGridListSetItemText(Duty.gridlist[1], row, 8, tostring(v[5]), false, false)
		else
			local row = DGS:dgsGridListAddRow(Duty.gridlist[3])

			DGS:dgsGridListSetItemText(Duty.gridlist[3], row, 1, tostring(v[1]), false, true)
			DGS:dgsGridListSetItemText(Duty.gridlist[3], row, 2, tostring(v[9]), false, true)
			DGS:dgsGridListSetItemText(Duty.gridlist[3], row, 3, getVehicleNameFromModel(v[10]), false, false)
			--[[table.insert(vehlocal, tostring(v[10]), v[11])
			table.remove(locations, k)]]
		end
		if locationEditID == tonumber(v[1]) then
			forceLocationClose = false
		end
	end
	if forceLocationClose or forceDutyClose then
		outputChatBox(message, 255, 0, 0)
		if forceDutyClose then
			if DutyCreate.window[1] then
				destroyElement(DutyCreate.window[1])
			end
			if DutyLocations.window[1] then
				destroyElement(DutyLocations.window[1])
			end
			if DutySkins.window[1] then
				destroyElement(DutySkins.window[1])
			end
		end
		if forceLocationClose then
			if DutyLocationMaker.window[1] then
				destroyElement(DutyLocationMaker.window[1])
			end
		end
	end
end
addEvent("importDutyData", true)
addEventHandler("importDutyData", resourceRoot, importData)

function refreshUI()
	DGS:dgsGridListClear( Duty.gridlist[1] )
	DGS:dgsGridListClear( Duty.gridlist[2] )
	DGS:dgsGridListClear( Duty.gridlist[3] )
	for k,v in pairs(customg) do
		local row = DGS:dgsGridListAddRow(Duty.gridlist[2])

		DGS:dgsGridListSetItemText(Duty.gridlist[2], row, 1, tostring(v[1]), false, true)
		DGS:dgsGridListSetItemText(Duty.gridlist[2], row, 2, v[2], false, false)
		t = {}
		for key, val in pairs(v[4]) do
			table.insert(t, key)
		end
		DGS:dgsGridListSetItemText(Duty.gridlist[2], row, 3, table.concat(t, ", "), false, false)
	end
	for k,v in pairs(locationsg) do
		if not v[10] then
			local row = DGS:dgsGridListAddRow(Duty.gridlist[1])

			DGS:dgsGridListSetItemText(Duty.gridlist[1], row, 1, tostring(v[1]), false, true)
			DGS:dgsGridListSetItemText(Duty.gridlist[1], row, 2, v[2], false, false)
			DGS:dgsGridListSetItemText(Duty.gridlist[1], row, 3, v[6], false, false)
			DGS:dgsGridListSetItemText(Duty.gridlist[1], row, 4, v[8], false, false)
			DGS:dgsGridListSetItemText(Duty.gridlist[1], row, 5, v[7], false, false)
			DGS:dgsGridListSetItemText(Duty.gridlist[1], row, 6, v[3], false, false)
			DGS:dgsGridListSetItemText(Duty.gridlist[1], row, 7, v[4], false, false)
			DGS:dgsGridListSetItemText(Duty.gridlist[1], row, 8, v[5], false, false)
		else
			local row = DGS:dgsGridListAddRow(Duty.gridlist[3])

			DGS:dgsGridListSetItemText(Duty.gridlist[3], row, 1, tostring(v[1]), false, true)
			DGS:dgsGridListSetItemText(Duty.gridlist[3], row, 2, tostring(v[9]), false, true)
			DGS:dgsGridListSetItemText(Duty.gridlist[3], row, 3, getVehicleNameFromModel(v[10]), false, false)
			--[[table.insert(vehlocal, tostring(v[10]), v[11])
			table.remove(locations, k)]]
		end
	end
end

function processLocationEdit()
	local r, c = DGS:dgsGridListGetSelectedItem ( Duty.gridlist[1] )
	if r >= 0 then
		local x = DGS:dgsGridListGetItemText ( Duty.gridlist[1], r, 6 )
		local y = DGS:dgsGridListGetItemText ( Duty.gridlist[1], r, 7 )
		local z = DGS:dgsGridListGetItemText ( Duty.gridlist[1], r, 8 )
		local rot = DGS:dgsGridListGetItemText ( Duty.gridlist[1], r, 3 )
		local i = DGS:dgsGridListGetItemText ( Duty.gridlist[1], r, 4 )
		local d = DGS:dgsGridListGetItemText ( Duty.gridlist[1], r, 5 )
		local name = DGS:dgsGridListGetItemText ( Duty.gridlist[1], r, 2 )
		locationEditID = tonumber(DGS:dgsGridListGetItemText ( Duty.gridlist[1], r, 1 ))
		createDutyLocationMaker(x, y, z, rot, i, d, name)
	end
end

function processDutyEdit()
	local r, c = DGS:dgsGridListGetSelectedItem ( Duty.gridlist[2] )
	if r >= 0 then
		local id = DGS:dgsGridListGetItemText(Duty.gridlist[2], r, 1)
		customEditID = tonumber(id)
		createDuty()
	end
end

DutyCreate = {
    label = {},
    button = {},
    window = {},
    gridlist = {},
    edit = {}
}
function grabDetails(dutyID)
	triggerServerEvent("Duty:Grab", resourceRoot, factionID1)

	DGS:dgsGridListAddRow(DutyCreate.gridlist[1])
	DGS:dgsGridListSetItemText(DutyCreate.gridlist[1], 0, 2, "Loading", false, false)

	DGS:dgsGridListAddRow(DutyCreate.gridlist[2])
	DGS:dgsGridListSetItemText(DutyCreate.gridlist[2], 0, 2, "Loading", false, false)

	DGS:dgsGridListAddRow(DutyCreate.gridlist[3])
	DGS:dgsGridListSetItemText(DutyCreate.gridlist[3], 0, 1, "Loading", false, false)

	DGS:dgsGridListAddRow(DutyCreate.gridlist[4])
	DGS:dgsGridListSetItemText(DutyCreate.gridlist[4], 0, 1, "Loading", false, false)		
end

function isItemAllowed(id)
	for k,v in pairs(allowListg) do
		if tonumber(id) == tonumber(v[1]) then
			return true
		end
	end
	return false
end

function populateDuty(allowList)
	dutyItems = { }
	allowListg = allowList
	DGS:dgsGridListClear( DutyCreate.gridlist[1] )
	DGS:dgsGridListClear( DutyCreate.gridlist[2] )
	DGS:dgsGridListClear( DutyCreate.gridlist[3] )
	DGS:dgsGridListClear( DutyCreate.gridlist[4] )

	if customEditID ~= 0 then
		dutyItems = customg[customEditID][5]
		for k,v in pairs(customg[customEditID][5]) do
			if tonumber(v[2]) >= 0 then -- Items
				local row = DGS:dgsGridListAddRow(DutyCreate.gridlist[4])
	
				DGS:dgsGridListSetItemText(DutyCreate.gridlist[4], row, 1, exports["item-system"]:getItemName(v[2]), false, false) -- Item Name
				DGS:dgsGridListSetItemText(DutyCreate.gridlist[4], row, 2, tostring(v[2]), false, true) -- Item ID
				DGS:dgsGridListSetItemData(DutyCreate.gridlist[4], row, 1, { v[1], tonumber(v[2]), v[3] })

				if not isItemAllowed(v[1]) then
					DGS:dgsGridListSetItemColor(DutyCreate.gridlist[4], row, 1, 255, 0, 0)
					DGS:dgsGridListSetItemColor(DutyCreate.gridlist[4], row, 2, 255, 0, 0)
				end
			else -- Weapons
				local row = DGS:dgsGridListAddRow(DutyCreate.gridlist[3])
				if tonumber(v[2]) == -100 then
					DGS:dgsGridListSetItemText(DutyCreate.gridlist[3], row, 1, "Armor", false, false) -- Weapon Name
					DGS:dgsGridListSetItemText(DutyCreate.gridlist[3], row, 2, tostring(v[3]), false, false) -- Ammo
					DGS:dgsGridListSetItemData(DutyCreate.gridlist[3], row, 2, { v[1], tonumber(v[2]), v[3], v[4] })
				else
					DGS:dgsGridListSetItemText(DutyCreate.gridlist[3], row, 1, exports["item-system"]:getItemName(v[2]), false, false) -- Weapon Name
					DGS:dgsGridListSetItemText(DutyCreate.gridlist[3], row, 2, tostring(v[3]), false, false) -- Ammo
					DGS:dgsGridListSetItemData(DutyCreate.gridlist[3], row, 2, { v[1], tonumber(v[2]), v[3], v[4] })
				end

				if not isItemAllowed(v[1]) then
					DGS:dgsGridListSetItemColor(DutyCreate.gridlist[3], row, 1, 255, 0, 0)
					DGS:dgsGridListSetItemColor(DutyCreate.gridlist[3], row, 2, 255, 0, 0)
				end
			end
		end
		dgs:DGSSetText(DutyCreate.edit[3], customg[customEditID][2])
	end

	for k,v in pairs(allowList) do
		if tonumber(v[2]) >= 0 then -- Items
			if customEditID == 0 or (customEditID ~= 0 and not customg[customEditID][5][tostring(v[1])]) then
				local row = DGS:dgsGridListAddRow(DutyCreate.gridlist[2])

				DGS:dgsGridListSetItemText(DutyCreate.gridlist[2], row, 1, exports["item-system"]:getItemName(v[2]), false, false)
				DGS:dgsGridListSetItemText(DutyCreate.gridlist[2], row, 2, exports["item-system"]:getItemDescription(v[2], v[3]), false, false)
				DGS:dgsGridListSetItemData(DutyCreate.gridlist[2], row, 1, { v[1], tonumber(v[2]), v[3] })
			end
		else -- Weapons
			if customEditID == 0 or (customEditID ~= 0 and not customg[customEditID][5][tostring(v[1])]) then
				local row = DGS:dgsGridListAddRow(DutyCreate.gridlist[1])
				if tonumber(v[2]) == -100 then
					DGS:dgsGridListSetItemText(DutyCreate.gridlist[1], row, 1, "Armor", false, false)
					DGS:dgsGridListSetItemText(DutyCreate.gridlist[1], row, 2, v[3], false, false)
					DGS:dgsGridListSetItemData(DutyCreate.gridlist[1], row, 1, { v[1], tonumber(v[2]), v[3] })
				else
					DGS:dgsGridListSetItemText(DutyCreate.gridlist[1], row, 1, exports["item-system"]:getItemName(v[2]), false, false)
					DGS:dgsGridListSetItemText(DutyCreate.gridlist[1], row, 2, v[3], false, false)
					DGS:dgsGridListSetItemData(DutyCreate.gridlist[1], row, 1, { v[1], tonumber(v[2]), v[3] })
				end
			end
		end
	end

end
addEvent("gotAllow", true)
addEventHandler("gotAllow", resourceRoot, populateDuty)

function populateLocations()
	if customEditID == 0 then
		tempLocations = getElementData(getLocalPlayer(), "savedLocations") or {}
	else
		tempLocations = getElementData(getLocalPlayer(), "savedLocations") or customg[customEditID][4]
	end

	for k,v in pairs(locationsg) do
		if not tempLocations[v[1]] then 
			local row = DGS:dgsGridListAddRow(DutyLocations.gridlist[1])

			DGS:dgsGridListSetItemText(DutyLocations.gridlist[1], row, 1, tostring(v[1]), false, true)
			DGS:dgsGridListSetItemText(DutyLocations.gridlist[1], row, 2, tostring(v[2]), false, false)
		end
	end

	for k,v in pairs(tempLocations) do
		local row = DGS:dgsGridListAddRow(DutyLocations.gridlist[2])

		DGS:dgsGridListSetItemText(DutyLocations.gridlist[2], row, 1, tostring(k), false, true)
		DGS:dgsGridListSetItemText(DutyLocations.gridlist[2], row, 2, tostring(v), false, false)
	end
end

function populateSkins()
	if customEditID == 0 then
		dutyNewSkins = getElementData(getLocalPlayer(), "savedSkins") or {}
	else
		dutyNewSkins = getElementData(getLocalPlayer(), "savedSkins") or customg[customEditID][3]
	end

	for k,v in pairs(dutyNewSkins) do
		local row = DGS:dgsGridListAddRow(DutySkins.gridlist[1])

		DGS:dgsGridListSetItemText(DutySkins.gridlist[1], row, 1, tostring(v[1]), false, false)
		DGS:dgsGridListSetItemText(DutySkins.gridlist[1], row, 2, tostring(v[2]), false, false)
	end
end

function checkAmmo()
	local r, c = DGS:dgsGridListGetSelectedItem( DutyCreate.gridlist[1] )
	if r >= 0 then
		if tonumber(DGS:dgsGetText(DutyCreate.edit[2])) then
			if tonumber(DGS:dgsGridListGetItemText(DutyCreate.gridlist[1], r, 2)) >= tonumber(DGS:dgsGetText( DutyCreate.edit[2] )) then
				DGS:dgsLabelSetColor(DutyCreate.label[2], 0, 255, 0)
				DGS:dgsSetText(DutyCreate.label[2], "Valid")
				DGS:dgsSetEnabled(DutyCreate.button[3], true)
				return
			end
		end
	end
	DGS:dgsLabelSetColor(DutyCreate.label[2], 255, 0, 0)
	DGS:dgsSetText(DutyCreate.label[2], "Invalid")
	DGS:dgsSetEnabled(DutyCreate.button[3], false)
end

function addDutyItem()
   	local r, c = DGS:dgsGridListGetSelectedItem ( DutyCreate.gridlist[2] )
	if r >= 0 then
		local info = DGS:dgsGridListGetItemData( DutyCreate.gridlist[2], r, 1 )
		local row = DGS:dgsGridListAddRow(DutyCreate.gridlist[4])

		DGS:dgsGridListSetItemText(DutyCreate.gridlist[4], row, 1, exports["item-system"]:getItemName(info[2]), false, false) -- Item Name
		DGS:dgsGridListSetItemText(DutyCreate.gridlist[4], row, 2, tostring(info[2]), false, false) -- Item ID
		DGS:dgsGridListSetItemData( DutyCreate.gridlist[4], row, 1, info )

		dutyItems[tostring(info[1])] = { info[1], tonumber(info[2]), info[3] }
		DGS:dgsGridListRemoveRow( DutyCreate.gridlist[2], r )
	end
end

function removeDutyWeapon()
   	local r, c = DGS:dgsGridListGetSelectedItem ( DutyCreate.gridlist[3] )
	if r >= 0 then
		local info = DGS:dgsGridListGetItemData(DutyCreate.gridlist[3], r, 2)
		local red, g, b = DGS:dgsGridListGetItemColor(DutyCreate.gridlist[3], r, 1)
		dutyItems[tostring(info[1])] = nil
		DGS:dgsGridListRemoveRow( DutyCreate.gridlist[3], r)
		if red == 255 and g ~= 0 and b ~= 0 then
			local row = DGS:dgsGridListAddRow(DutyCreate.gridlist[1])
			if tonumber(info[1]) == -100 then
				DGS:dgsGridListSetItemText(DutyCreate.gridlist[1], row, 1, "Armor", false, false)
				DGS:dgsGridListSetItemText(DutyCreate.gridlist[1], row, 2, tostring(info[4]), false, false)
				DGS:dgsGridListSetItemData(DutyCreate.gridlist[1], row, 1, info)
			else
				DGS:dgsGridListSetItemText(DutyCreate.gridlist[1], row, 1, exports["item-system"]:getItemName(info[2]), false, false)
				DGS:dgsGridListSetItemText(DutyCreate.gridlist[1], row, 2, tostring(info[4]), false, false)
				DGS:dgsGridListSetItemData(DutyCreate.gridlist[1], row, 1, info)
			end
		end
	end
end

function removeDutyItem()
   	local r, c = DGS:dgsGridListGetSelectedItem ( DutyCreate.gridlist[4] )
	if r >= 0 then
		local info = DGS:dgsGridListGetItemData(DutyCreate.gridlist[4], r, 1)
		local red, g, b = DGS:dgsGridListGetItemColor(DutyCreate.gridlist[4], r, 1)
		dutyItems[tostring(info[1])] = nil
		DGS:dgsGridListRemoveRow(DutyCreate.gridlist[4], r)
		if red == 255 and g ~= 0 and b ~= 0 then
			local row = DGS:dgsGridListAddRow(DutyCreate.gridlist[2])

			DGS:dgsGridListSetItemText(DutyCreate.gridlist[2], row, 1, exports["item-system"]:getItemName(tonumber(info[2])), false, false)
			DGS:dgsGridListSetItemText(DutyCreate.gridlist[2], row, 2, exports["item-system"]:getItemDescription(tonumber(info[2]), info[3]), false, false)
			DGS:dgsGridListSetItemData(DutyCreate.gridlist[2], row, 1, info)
		end
	end
end

function createDuty()
	if isElement(DutyCreate.window[1]) then
		destroyElement(DutyCreate.window[1])
		dutyItems = nil
	end

    DutyCreate.window[1] = DGS:dgsCreateWindow(450, 310, 768, 566, "Duty Editing Window - Main", false)
    DGS:dgsWindowSetSizable(DutyCreate.window[1], false)
    centerWindow(DutyCreate.window[1])

    DutyCreate.button[1] = DGS:dgsCreateButton(600, 512, 158, 44, "Cancel", false, DutyCreate.window[1])
    --DGS:dgsSetProperty(DutyCreate.button[1], "NormalTextColour", "FFAAAAAA")
    addEventHandler("onDgsMouseClick", DutyCreate.button[1], closeTheGUI, false)

    DutyCreate.button[2] = guiCreateButton(454, 512, 138, 44, "Save", false, DutyCreate.window[1])
   -- guiSetProperty(DutyCreate.button[2], "NormalTextColour", "FFAAAAAA")
    addEventHandler("onDgsMouseClick", DutyCreate.button[2], saveGUI, false)

    DutyCreate.gridlist[1] = DGS:dgsCreateGridList(11, 34, 427, 192, false, DutyCreate.window[1])
    --guiGridListAddColumn(DutyCreate.gridlist[1], "ID", 0.1)
    DGS:dgsGridListAddColumn(DutyCreate.gridlist[1], "Weapon Name", 0.5)
    DGS:dgsGridListAddColumn(DutyCreate.gridlist[1], "Max Amount of Ammo", 0.5)

    DutyCreate.gridlist[2] = DGS:dgsCreateGridList(12, 247, 426, 208, false, DutyCreate.window[1])
   --guiGridListAddColumn(DutyCreate.gridlist[2], "ID", 0.1)
    DGS:dgsGridListAddColumn(DutyCreate.gridlist[2], "Item Name", 0.3)
    DGS:dgsGridListAddColumn(DutyCreate.gridlist[2], "Description", 0.7)

    DutyCreate.button[3] = DGS:dgsCreateButton(444, 34, 128, 41, "-->", false, DutyCreate.window[1])
   -- guiSetProperty(DutyCreate.button[3], "NormalTextColour", "FFAAAAAA")
    addEventHandler("onDgsMouseClick", DutyCreate.gridlist[1], checkAmmo)
    addEventHandler("onDgsMouseClick", DutyCreate.button[3], function()
    	 -- Add Duty Weapon
    	local r, c = DGS:dgsGridListGetSelectedItem ( DutyCreate.gridlist[1] )
		if r >= 0 then
			local maxammo = DGS:dgsGridListGetItemText( DutyCreate.gridlist[1], r, 2 )
			local info = DGS:dgsGridListGetItemData( DutyCreate.gridlist[1], r, 1 )
			local ammo = DGS:dgsGetText( DutyCreate.edit[2] )

			local row = DGS:dgsGridListAddRow(DutyCreate.gridlist[3])
			if tonumber(info[2]) == -100 then
				DGS:dgsGridListSetItemText(DutyCreate.gridlist[3], row, 1, "Armor", false, false) -- Weapon Name
				DGS:dgsGridListSetItemData(DutyCreate.gridlist[3], row, 2, info)
				DGS:dgsGridListSetItemText(DutyCreate.gridlist[3], row, 2, ammo, false, false) -- Ammo
			else
				DGS:dgsGridListSetItemText(DutyCreate.gridlist[3], row, 1, exports["item-system"]:getItemName(tonumber(info[2])), false, false) -- Weapon Name
				DGS:dgsGridListSetItemData(DutyCreate.gridlist[3], row, 2, info)
				DGS:dgsGridListSetItemText(DutyCreate.gridlist[3], row, 2, ammo, false, false) -- Ammo
			end

			dutyItems[tostring(info[1])] = { info[1], tonumber(info[2]), tonumber(ammo), info[3] }

			DGS:dgsGridListRemoveRow( DutyCreate.gridlist[1], r )
		end
    end, false)
    DutyCreate.button[4] = DGS:dgsCreateButton(444, 249, 128, 41, "-->", false, DutyCreate.window[1])
    DGS:dgsSetProperty(DutyCreate.button[4], "NormalTextColour", "FFAAAAAA")
    addEventHandler("onDgsMouseClick", DutyCreate.button[4], addDutyItem, false) -- Add Duty Item
    addEventHandler("onDgsMouseDoubleClick", DutyCreate.gridlist[2], addDutyItem, false)
    
    DutyCreate.gridlist[3] = DGS:dgsCreateGridList(582, 34, 176, 192, false, DutyCreate.window[1])
    DGS:dgsGridListAddColumn(DutyCreate.gridlist[3], "Weapon", 0.5)
    DGS:dgsGridListAddColumn(DutyCreate.gridlist[3], "Ammo", 0.3)

    --[[DutyCreate.edit[1] = guiCreateEdit(445, 298, 127, 27, "Item Value", false, DutyCreate.window[1])
    DutyCreate.label[1] = guiCreateLabel(444, 325, 128, 89, "Invalid", false, DutyCreate.window[1])
    guiLabelSetColor(DutyCreate.label[1], 255, 0, 0)
    guiLabelSetHorizontalAlign(DutyCreate.label[1], "center", false)]]
    DutyCreate.edit[2] = DGS:dgsCreateEdit(445, 81, 127, 27, "Amount of Ammo", false, DutyCreate.window[1])
    DutyCreate.label[2] = DGS:dgsCreateLabel(444, 108, 128, 77, "Invalid", false, DutyCreate.window[1])
    DGS:dgsLabelSetColor(DutyCreate.label[2], 255, 0, 0)
    addEventHandler("onDgsTextChange", DutyCreate.edit[2], checkAmmo)

    DutyCreate.gridlist[4] = DGS:dgsCreateGridList(582, 248, 176, 207, false, DutyCreate.window[1])
    DGS:dgsGridListAddColumn(DutyCreate.gridlist[4], "Item", 0.5)
    DGS:dgsGridListAddColumn(DutyCreate.gridlist[4], "ID", 0.3)
    DGS:dgsLabelSetHorizontalAlign(DutyCreate.label[2], "center", false)

    DutyCreate.button[5] = DGS:dgsCreateButton(444, 185, 128, 41, "<---", false, DutyCreate.window[1])
    --guiSetProperty(DutyCreate.button[5], "NormalTextColour", "FFAAAAAA")
    addEventHandler("onDgsMouseClick", DutyCreate.button[5], removeDutyWeapon, false)
    addEventHandler("onDgsMouseDoubleClick", DutyCreate.gridlist[3], removeDutyWeapon, false)
    DutyCreate.button[6] = guiCreateButton(444, 414, 128, 41, "<--", false, DutyCreate.window[1])
   -- guiSetProperty(DutyCreate.button[6], "NormalTextColour", "FFAAAAAA")
    addEventHandler("onDgsMouseClick", DutyCreate.button[6], removeDutyItem, false)
    addEventHandler("onDgsMouseDoubleClick", DutyCreate.gridlist[4], removeDutyItem, false)
    DutyCreate.button[7] = DGS:dgsCreateButton(12, 511, 138, 45, "Skins", false, DutyCreate.window[1])
    --guiSetProperty(DutyCreate.button[7], "NormalTextColour", "FFAAAAAA")
    addEventHandler("onDgsMouseClick", DutyCreate.button[7], createSkins, false)

    DutyCreate.button[8] = DGS:dgsCreateButton(160, 512, 138, 44, "Locations", false, DutyCreate.window[1])
    --guiSetProperty(DutyCreate.button[8], "NormalTextColour", "FFAAAAAA")
    addEventHandler("onDgsMouseClick", DutyCreate.button[8], createLocations, false)

    DutyCreate.label[3] = DGS:dgsCreateLabel(57, 19, 319, 15, "Available Weapons", false, DutyCreate.window[1])
    DGS:dgsLabelSetHorizontalAlign(DutyCreate.label[3], "center", false)
    DutyCreate.label[4] = DGS:dgsCreateLabel(582, 17, 176, 17, "Duty Weapons", false, DutyCreate.window[1])
    DGS:dgsLabelSetHorizontalAlign(DutyCreate.label[4], "center", false)
    DutyCreate.label[5] = DGS:dgsCreateLabel(57, 228, 319, 15, "Available Items", false, DutyCreate.window[1])
    DGS:dgsLabelSetHorizontalAlign(DutyCreate.label[5], "center", false)
    DutyCreate.label[6] = DGS:dgsCreateLabel(583, 227, 175, 21, "Duty Items", false, DutyCreate.window[1])
    DGS:dgsLabelSetHorizontalAlign(DutyCreate.label[6], "center", false)
    DutyCreate.label[7] = DGS:dgsCreateLabel(14, 463, 88, 32, "Duty Name:", false, DutyCreate.window[1])
    DGS:dgsLabelSetVerticalAlign(DutyCreate.label[7], "center")
    DutyCreate.edit[3] = DGS:dgsCreateEdit(83, 462, 240, 33, "", false, DutyCreate.window[1])    

	DGS:dgsSetEnabled(DutyCreate.button[3], false)
    grabDetails()
end


DutyLocations = {
    gridlist = {},
    window = {},
    button = {},
    label = {}
}

function addLocationToDuty()
   	local r, c = DGS:dgsGridListGetSelectedItem ( DutyLocations.gridlist[1] )
	if r >= 0 then
		local id = DGS:dgsGridListGetItemText(DutyLocations.gridlist[1], r, 1)
		local name = DGS:dgsGridListGetItemText(DutyLocations.gridlist[1], r, 2)

		DGS:dgsGridListRemoveRow(DutyLocations.gridlist[1], r)
		local row = DGS:dgsGridListAddRow(DutyLocations.gridlist[2])

		DGS:dgsGridListSetItemText(DutyLocations.gridlist[2], row, 1, tostring(id), false, true)
		DGS:dgsGridListSetItemText(DutyLocations.gridlist[2], row, 2, tostring(name), false, false)
		tempLocations[id] = name
	end
end

function removeLocationFromDuty()
   	local r, c = DGS:dgsGridListGetSelectedItem ( DutyLocations.gridlist[2] )
	if r >= 0 then
		local id = DGS:dgsGridListGetItemText(DutyLocations.gridlist[2], r, 1)
		local name = DGS:dgsGridListGetItemText(DutyLocations.gridlist[2], r, 2)

		DGS:dgsGridListRemoveRow(DutyLocations.gridlist[2], r)
		local row = DGS:dgsGridListAddRow(DutyLocations.gridlist[1])

		DGS:dgsGridListSetItemText(DutyLocations.gridlist[1], row, 1, tostring(id), false, true)
		DGS:dgsGridListSetItemText(DutyLocations.gridlist[1], row, 2, tostring(name), false, false)
		tempLocations[id] = nil
	end
end

function createLocations()
	if isElement(DutyLocations.window[1]) then
		destroyElement(DutyLocations.window[1])
		tempLocations = nil
	end
    DutyLocations.window[1] = DGS:dgsCreateWindow(573, 285, 520, 423, "Duty Editing Window - Locations", false)
    DGS:dgsWindowSetSizable(DutyLocations.window[1], false)
    centerWindow(DutyLocations.window[1])

    DutyLocations.gridlist[1] = DGS:dgsCreateGridList(9, 36, 240, 297, false, DutyLocations.window[1])
    DGS:dgsGridListAddColumn(DutyLocations.gridlist[1], "ID", 0.2)
    DGS:dgsGridListAddColumn(DutyLocations.gridlist[1], "Name", 0.9)

    DutyLocations.gridlist[2] = DGS:dgsCreateGridList(270, 36, 240, 297, false, DutyLocations.window[1])
    DGS:dgsGridListAddColumn(DutyLocations.gridlist[2], "ID", 0.2)
    DGS:dgsGridListAddColumn(DutyLocations.gridlist[2], "Name", 0.9)

    DutyLocations.button[1] = DGS:dgsCreateButton(9, 332, 240, 27, "-->", false, DutyLocations.window[1])
    DGS:dgsSetProperty(DutyLocations.button[1], "NormalTextColour", "FFAAAAAA")
    addEventHandler("onDgsMouseClickDown", DutyLocations.button[1], addLocationToDuty, false)
    addEventHandler("onDgsMouseDoubleClick", DutyLocations.gridlist[1], addLocationToDuty, false)
    DutyLocations.button[2] = DGS:dgsCreateButton(270, 332, 240, 27, "<--", false, DutyLocations.window[1])
    DGS:dgsSetProperty(DutyLocations.button[2], "NormalTextColour", "FFAAAAAA")
    addEventHandler("onDgsMouseClickDown", DutyLocations.button[2], removeLocationFromDuty, false)
    addEventHandler("onDgsMouseDoubleClick", DutyLocations.gridlist[2], removeLocationFromDuty, false)
    DutyLocations.label[1] = DGS:dgsCreateLabel(10, 19, 233, 17, "All locations", false, DutyLocations.window[1])
    DGS:dgsLabelSetHorizontalAlign(DutyLocations.label[1], "center", false)
    DutyLocations.label[2] = DGS:dgsCreateLabel(270, 19, 233, 17, "Duty locations", false, DutyLocations.window[1])
    DGS:dgsLabelSetHorizontalAlign(DutyLocations.label[2], "center", false)
    DutyLocations.button[3] = DGS:dgsCreateButton(270, 367, 146, 36, "Save", false, DutyLocations.window[1])
    DGS:dgsSetProperty(DutyLocations.button[3], "NormalTextColour", "FFAAAAAA")
    addEventHandler("onDgsMouseClickDown", DutyLocations.button[3], saveGUI, false)

    DutyLocations.button[4] = DGS:dgsCreateButton(103, 367, 146, 36, "Cancel", false, DutyLocations.window[1])
    DGS:dgsSetProperty(DutyLocations.button[4], "NormalTextColour", "FFAAAAAA")   
    addEventHandler("onDgsMouseClickDown", DutyLocations.button[4], closeTheGUI, false) 

    populateLocations()
end

DutySkins = {
    edit = {},
    button = {},
    window = {},
    label = {},
    gridlist = {}
}

function skinAlreadyExists(skin, dupont)
	for k,v in pairs(dutyNewSkins) do
		if skin == v[1] and dupont == v[2] then
			return true
		end
	end
end

function addSkin()
	local raw = DGS:dgsGetText(DutySkins.edit[1])
	if string.find(raw, ":") then
		local howAboutIt = split(raw, ":")
		if tonumber(howAboutIt[1]) and tonumber(howAboutIt[2]) then
			if not skinAlreadyExists(tonumber(howAboutIt[1]), tonumber(howAboutIt[2])) then
				table.insert(dutyNewSkins, { howAboutIt[1], howAboutIt[2] })
				local row = DGS:dgsGridListAddRow(DutySkins.gridlist[1])

				DGS:dgsGridListSetItemText(DutySkins.gridlist[1], row, 1, tostring(howAboutIt[1]), false, false)
				DGS:dgsGridListSetItemText(DutySkins.gridlist[1], row, 2, tostring(howAboutIt[2]), false, false)
			else
				outputChatBox("You cannot add the same skin twice.", 255, 0, 0)
			end
		else
			outputChatBox("Please use only numbers.", 255, 0, 0)
		end
	else
		local raw = tonumber(raw)
		if raw then
			if not skinAlreadyExists(raw, "N/A") then
				table.insert(dutyNewSkins, { raw, "N/A" })
				local row = DGS:dgsGridListAddRow(DutySkins.gridlist[1])

				DGS:dgsGridListSetItemText(DutySkins.gridlist[1], row, 1, tostring(raw), false, false)
				DGS:dgsGridListSetItemText(DutySkins.gridlist[1], row, 2, "N/A", false, false)
			else
				outputChatBox("You cannot add the same skin twice.", 255, 0, 0)
			end
		else
			outputChatBox("Please use only numbers.", 255, 0, 0)
		end
	end
	DGS:dgsSetText(DutySkins.edit[1], "")
end

function removeSkin()
   	local r, c = DGS:dgsGridListGetSelectedItem ( DutySkins.gridlist[1] )
	if r >= 0 then
		local skin = DGS:dgsGridListGetItemText(DutySkins.gridlist[1], r, 1)
		local dupont = DGS:dgsGridListGetItemText(DutySkins.gridlist[1], r, 2) -- ew dupont!

		for k,v in pairs(dutyNewSkins) do
			if tonumber(v[1]) == tonumber(skin) and tostring(v[2]) == dupont then
				table.remove(dutyNewSkins, k)
				break
			end
		end

		DGS:dgsGridListRemoveRow(DutySkins.gridlist[1], r)
	end
end

function createSkins()
	if isElement(DutySkins.window[1]) then
		destroyElement(DutySkins.window[1])
		dutyNewSkins = nil
	end
    DutySkins.window[1] = DGS:dgsCreateWindow(697, 240, 294, 425, "", false)
    DGS:dgsWindowSetSizable(DutySkins.window[1], false)
    centerWindow(DutySkins.window[1])

    DutySkins.gridlist[1] = DGS:dgsCreateGridList(9, 36, 275, 275, false, DutySkins.window[1])
    DGS:dgsGridListAddColumn(DutySkins.gridlist[1], "SkinID", 0.5)
    DGS:dgsGridListAddColumn(DutySkins.gridlist[1], "DupontID", 0.5)
    DutySkins.label[1] = DGS:dgsCreateLabel(12, 18, 272, 18, "Duty Skins", false, DutySkins.window[1])
    DGS:dgsLabelSetHorizontalAlign(DutySkins.label[1], "center", false)
    DutySkins.edit[1] = DGS:dgsCreateEdit(11, 313, 139, 29, "", false, DutySkins.window[1])
    DutySkins.button[1] = DGS:dgsCreateButton(152, 313, 53, 29, "Add", false, DutySkins.window[1])
    DGS:dgsSetProperty(DutySkins.button[1], "NormalTextColour", "FFAAAAAA")
    addEventHandler("onDgsMouseClickDown", DutySkins.button[1], addSkin, false)
    DutySkins.button[2] = DGS:dgsCreateButton(231, 313, 53, 29, "Remove", false, DutySkins.window[1])
    DGS:dgsSetProperty(DutySkins.button[2], "NormalTextColour", "FFAAAAAA")
    addEventHandler("onDgsMouseClickDown", DutySkins.button[2], removeSkin, false)
    addEventHandler("onDgsMouseDoubleClick", DutySkins.gridlist[1], removeSkin, false)
    DutySkins.label[2] = DGS:dgsCreateLabel(11, 345, 273, 29, "Use format: SkinID:DupontID\nExample: 121:622 or 130 for just a SkinID.", false, DutySkins.window[1])
    DGS:dgsLabelSetHorizontalAlign(DutySkins.label[2], "center", false)
    DutySkins.button[3] = DGS:dgsCreateButton(9, 381, 99, 34, "Cancel", false, DutySkins.window[1])
    DGS:dgsSetProperty(DutySkins.button[3], "NormalTextColour", "FFAAAAAA")
    addEventHandler("onDgsMouseClickDown", DutySkins.button[3], closeTheGUI, false)

    DutySkins.button[4] = DGS:dgsCreateButton(185, 381, 99, 34, "Save", false, DutySkins.window[1])
    DGS:dgsSetProperty(DutySkins.button[4], "NormalTextColour", "FFAAAAAA")    
    addEventHandler("onDgsMouseClickDown", DutySkins.button[4], saveGUI, false)

    populateSkins()
end

DutyVehicleAdd = {
    button = {},
    window = {},
    edit = {}
}
function createVehicleAdd()
	if isElement(DutyVehicleAdd.window[1]) then
		destroyElement(DutyVehicleAdd.window[1])
	end
    DutyVehicleAdd.window[1] = DGS:dgsCreateWindow(685, 338, 335, 85, "Add new duty vehicle", false)
    DGS:dgsWindowSetSizable(DutyVehicleAdd.window[1], false)
    centerWindow(DutyVehicleAdd.window[1])

    DutyVehicleAdd.edit[1] = DGS:dgsCreateEdit(9, 26, 181, 40, "Vehicle ID", false, DutyVehicleAdd.window[1])
    DutyVehicleAdd.button[1] = DGS:dgsCreateButton(192, 26, 62, 40, "Add", false, DutyVehicleAdd.window[1])
    DGS:dgsSetProperty(DutyVehicleAdd.button[1], "NormalTextColour", "FFAAAAAA")
    addEventHandler("onDgsMouseClickDown", DutyVehicleAdd.button[1], saveGUI, false)

    DutyVehicleAdd.button[2] = DGS:dgsCreateButton(263, 26, 62, 40, "Close", false, DutyVehicleAdd.window[1])
    DGS:dgsSetProperty(DutyVehicleAdd.button[2], "NormalTextColour", "FFAAAAAA")   
    addEventHandler( "onDgsMouseClickDown", DutyVehicleAdd.button[2], closeTheGUI, false ) 
end

DutyLocationMaker = {
    button = {},
    window = {},
    edit = {},
    label = {}
}
function createDutyLocationMaker(x, y, z, r, i, d, name)
	if isElement(DutyLocationMaker.window[1]) then
		destroyElement(DutyLocationMaker.window[1])
	end
    DutyLocationMaker.window[1] = DGS:dgsCreateWindow(638, 285, 488, 198, "Add duty location", false)
    DGS:dgsWindowSetSizable(DutyLocationMaker.window[1], false)
    centerWindow(DutyLocationMaker.window[1])

    DutyLocationMaker.label[1] = DGS:dgsCreateLabel(8, 24, 44, 19, "X Value:", false, DutyLocationMaker.window[1])
    DutyLocationMaker.edit[1] = DGS:dgsCreateEdit(56, 24, 135, 20, "", false, DutyLocationMaker.window[1])
    DutyLocationMaker.label[2] = DGS:dgsCreateLabel(201, 24, 53, 19, "Y Value:", false, DutyLocationMaker.window[1])
    DutyLocationMaker.edit[2] = DGS:dgsCreateEdit(253, 23, 88, 20, "", false, DutyLocationMaker.window[1])
    DutyLocationMaker.label[3] = DGS:dgsCreateLabel(355, 25, 52, 18, "Z Value:", false, DutyLocationMaker.window[1])
    DutyLocationMaker.edit[3] = DGS:dgsCreateEdit(406, 23, 71, 20, "", false, DutyLocationMaker.window[1])
    DutyLocationMaker.label[4] = DGS:dgsCreateLabel(8, 60, 49, 18, "Radius:", false, DutyLocationMaker.window[1])
    DutyLocationMaker.edit[4] = DGS:dgsCreateEdit(53, 58, 82, 20, "1-10", false, DutyLocationMaker.window[1])
    DutyLocationMaker.label[5] = DGS:dgsCreateLabel(162, 61, 72, 17, "Interior:", false, DutyLocationMaker.window[1])
    DutyLocationMaker.edit[5] = DGS:dgsCreateEdit(216, 58, 93, 20, "", false, DutyLocationMaker.window[1])
    DutyLocationMaker.label[6] = DGS:dgsCreateLabel(336, 60, 60, 18, "Dimension:", false, DutyLocationMaker.window[1])
    DutyLocationMaker.edit[6] = DGS:dgsCreateEdit(402, 58, 75, 20, "", false, DutyLocationMaker.window[1])
    DutyLocationMaker.label[7] = DGS:dgsCreateLabel(9, 92, 57, 21, "Name:", false, DutyLocationMaker.window[1])
    DutyLocationMaker.label[8] = DGS:dgsCreateLabel(10, 119, 467, 28, "The name of the duty is used strictly for your identification.", false, DutyLocationMaker.window[1])
    DGS:dgsLabelSetHorizontalAlign(DutyLocationMaker.label[8], "center", false)
    DutyLocationMaker.edit[7] = DGS:dgsCreateEdit(51, 91, 426, 22, "", false, DutyLocationMaker.window[1])
    DutyLocationMaker.button[1] = DGS:dgsCreateButton(10, 149, 115, 37, "Insert Current Position", false, DutyLocationMaker.window[1])
    DGS:dgsSetProperty(DutyLocationMaker.button[1], "NormalTextColour", "FFAAAAAA")
    addEventHandler("onDgsMouseClickDown", DutyLocationMaker.button[1], curPos, false)

    DutyLocationMaker.button[2] = DGS:dgsCreateButton(184, 149, 115, 37, "Close", false, DutyLocationMaker.window[1])
    DGS:dgsSetProperty(DutyLocationMaker.button[2], "NormalTextColour", "FFAAAAAA")
    addEventHandler("onDgsMouseClickDown", DutyLocationMaker.button[2], closeTheGUI, false)

    DutyLocationMaker.button[3] = DGS:dgsCreateButton(357, 149, 115, 37, "Save", false, DutyLocationMaker.window[1])
    DGS:dgsSetProperty(DutyLocationMaker.button[3], "NormalTextColour", "FFAAAAAA") 
    addEventHandler("onDgsMouseClickDown", DutyLocationMaker.button[3], saveGUI, false)

    -- Populate List
    if name then
    	DGS:dgsSetText(DutyLocationMaker.edit[1], x)
		DGS:dgsSetText(DutyLocationMaker.edit[2], y)
		DGS:dgsSetText(DutyLocationMaker.edit[3], z)
		DGS:dgsSetText(DutyLocationMaker.edit[4], r)
		DGS:dgsSetText(DutyLocationMaker.edit[5], i)
		DGS:dgsSetText(DutyLocationMaker.edit[6], d)
		DGS:dgsSetText(DutyLocationMaker.edit[7], name)
	end
end

function duplicateVeh(type, id, faction)
	for k,v in ipairs(locationsg) do
		if v[10] == id then
			return true
		end
	end
end

-- Closing! 
function closeTheGUI()
	if source == DutyCreate.button[1] then -- Main
		destroyElement(DutyCreate.window[1])
		customEditID = 0
		tempLocations = nil
		dutyNewSkins = nil
		dutyItems = nil
		setElementData(getLocalPlayer(), "savedLocations", false)
		setElementData(getLocalPlayer(), "savedSkins", false)
	elseif source == DutyLocations.button[4] then -- Main > Locations
		tempLocations = nil
		destroyElement(DutyLocations.window[1])
	elseif source == DutySkins.button[3] then -- Main > Skins
		dutyNewSkins = nil
		destroyElement(DutySkins.window[1])
	elseif source == DutyVehicleAdd.button[2] then -- Vehicle Add
		destroyElement(DutyVehicleAdd.window[1])
	elseif source == DutyLocationMaker.button[2] then -- Location Maker
		locationEditID = 0
		destroyElement(DutyLocationMaker.window[1])
	end
end

-- Save!
function saveGUI()
	if source == DutyCreate.button[2] then -- Main
		local name = DGS:dgsGetText(DutyCreate.edit[3])
		if name ~= "" then
			if customEditID ~= 0 then
				triggerServerEvent("Duty:AddDuty", resourceRoot, dutyItems, getElementData(getLocalPlayer(), "savedLocations") or customg[customEditID][4], getElementData(getLocalPlayer(), "savedSkins") or customg[customEditID][3], name, factionIDg, customEditID)
			else
				triggerServerEvent("Duty:AddDuty", resourceRoot, dutyItems, getElementData(getLocalPlayer(), "savedLocations") or {}, getElementData(getLocalPlayer(), "savedSkins") or {}, name, factionIDg, customEditID)
			end
			tempLocations = nil
			dutyNewSkins = nil
			dutyItems = nil 
			customEditID = 0
			setElementData(getLocalPlayer(), "savedLocations", false)
			setElementData(getLocalPlayer(), "savedSkins", false)
		else
			outputChatBox("Please enter in a name for this duty.", 255, 0, 0)
			return
		end
		destroyElement(DutyCreate.window[1])
	elseif source == DutyLocations.button[3] then -- Main > Locations
		setElementData(getLocalPlayer(), "savedLocations", tempLocations)
		tempLocations = nil
		destroyElement(DutyLocations.window[1])
	elseif source == DutySkins.button[4] then -- Main > Skins
		setElementData(getLocalPlayer(), "savedSkins", dutyNewSkins)
		dutyNewSkins = nil
		destroyElement(DutySkins.window[1])
	elseif source == DutyVehicleAdd.button[1] then -- Vehicle Add
		local id = DGS:dgsGetText(DutyVehicleAdd.edit[1])
		if not duplicateVeh("location", id, factionIDg) then
			triggerServerEvent("Duty:AddVehicle", resourceRoot, tonumber(id), factionIDg)
			destroyElement(DutyVehicleAdd.window[1])
		else
			outputChatBox("This vehicle is already added.", 255, 0, 0)
		end
	elseif source == DutyLocationMaker.button[3] then -- Location Maker
		local x = tonumber(DGS:dgsGetText(DutyLocationMaker.edit[1]))
		local y = tonumber(DGS:dgsGetText(DutyLocationMaker.edit[2]))
		local z = tonumber(DGS:dgsGetText(DutyLocationMaker.edit[3]))
		local r = tonumber(DGS:dgsGetText(DutyLocationMaker.edit[4]))
		local i = tonumber(DGS:dgsGetText(DutyLocationMaker.edit[5]))
		local d = tonumber(DGS:dgsGetText(DutyLocationMaker.edit[6]))
		local name = DGS:dgsGetText(DutyLocationMaker.edit[7])
		if (x and y and z and r and i and d and name) then
			if r >= 1 and r <=10 then
				if string.len(name) > 0 then
					triggerServerEvent("Duty:AddLocation", resourceRoot, x, y, z, r, i, d, name, factionIDg, (locationEditID ~= 0 and locationEditID or nil))
				else
					outputChatBox("You must enter a name.", 255, 0, 0)
					return
				end
			else
				outputChatBox("Radius must be between 1 and 10", 255, 0, 0)
				return
			end
		else
			outputChatBox("Please enter in all the information correctly.", 255, 0, 0)
			return
		end
		locationEditID = 0
		destroyElement(DutyLocationMaker.window[1])
	end
end

function curPos()
	local x, y, z = getElementPosition(getLocalPlayer())
	local dim = getElementDimension(getLocalPlayer())
	local int = getElementInterior(getLocalPlayer())
	return DGS:dgs(DutyLocationMaker.edit[1], x), guiSetText(DutyLocationMaker.edit[2], y), guiSetText(DutyLocationMaker.edit[3], z), guiSetText(DutyLocationMaker.edit[5], int), guiSetText(DutyLocationMaker.edit[6], dim)
end

function removeLocation()
	local r, c = DGS:dgsGridListGetSelectedItem ( Duty.gridlist[1] )
	if r >= 0 then
		local removeid = DGS:dgsGridListGetItemText ( Duty.gridlist[1], r, 1 )
		triggerServerEvent("Duty:RemoveLocation", resourceRoot, removeid, factionIDg)
		locationsg[tonumber(removeid)] = nil
		refreshUI()
	end
end

function removeDuty()
	local r, c = DGS:dgsGridListGetSelectedItem ( Duty.gridlist[2] )
	if r >= 0 then
		local removeid = DGS:dgsGridListGetItemText ( Duty.gridlist[2], r, 1 )
		triggerServerEvent("Duty:RemoveDuty", resourceRoot, removeid, factionIDg)
		customg[tonumber(removeid)] = nil
		refreshUI()
	end
end

function removeVehicle()
	local r, c = DGS:dgsGridListGetSelectedItem ( Duty.gridlist[3] )
	if r >= 0 then
		local removeid = DGS:dgsGridListGetItemText ( Duty.gridlist[3], r, 1 )
		triggerServerEvent("Duty:RemoveLocation", resourceRoot, removeid, factionIDg)
		locationsg[tonumber(removeid)] = nil
		refreshUI()
	end
end

addEventHandler ( "onDgsGridListSelect", root, function ( current, currentcolumn )
		if source == gMemberGrid then
	local Selected = DGS:dgsGridListGetSelectedItem(gMemberGrid)
	if Selected >= 0 then
		local getName = string.gsub(tostring(memberUsernames[Selected]), "_", " ")
		local getRank = factionRanks[tonumber(memberRanks[Selected])]
		local getLeader = tostring(memberLeaders[Selected])
		local getDuty = tostring(memberOnDuty[Selected])
		local getSalary = factionWages[tonumber(memberRanks[Selected])]
		local getLLogin = tostring(memberLastLogin[Selected])
			DGS:dgsSetText(nameLbl, "    "..getName)
			DGS:dgsSetText(rankLbl, "Rank: " .. getRank)
			DGS:dgsSetText(salaryLbl, "Salary: " .. getSalary .. "$")
			if getLLogin == 0 then
			DGS:dgsSetText(llLbl, "Last Login: Now")
			else
			DGS:dgsSetText(llLbl, "Last Login: " .. getLLogin .. " days")
			end
			if getDuty == "false" then
			DGS:dgsSetText(dutyLbl, "on Duty: #d63f3eNo")
			else
			DGS:dgsSetText(dutyLbl, "on Duty: #3ea650Yes")
			end
			if getLeader == "true" then
			DGS:dgsSetText(leaderLbl, "Leader: #3ea650Yes")
			DGS:dgsSetVisible(crownImg, true)
			--DGS:dgsImageSetImage ( crownImg, crown )
			else
			DGS:dgsSetText(leaderLbl, "Leader: #d63f3eNo")
			DGS:dgsSetVisible(crownImg, false)
			end
		end
	end
end)

addEventHandler("onDgsGridListSelect", root, function ( current, currentcolumn )
	if source == rankGrid then
	 local Selected = DGS:dgsGridListGetSelectedItem(rankGrid)
	 local rank = DGS:dgsGridListGetItemText(rankGrid,current,rankColumn)
	 local wage = DGS:dgsGridListGetItemText(rankGrid,current,wageColumn):gsub("$$", "")
	 DGS:dgsSetText (tRank, rank)
	 DGS:dgsSetText (tWage, wage)
	 table.insert(tRanks, Selected)
	 table.insert(tRankWages, Selected)
	 DGS:dgsSetText (rankNameLbl2, rank .. " (".. Selected ..")")
	 DGS:dgsSetText (wageNumLbl, "#307898" .. wage .. "#FFFFFF$")
	end
end)

addEventHandler ( "onDgsMouseClickDown", root, function ( button, state  )
		playerTeam = getPlayerTeam(localPlayer)
		teamName = getTeamName(playerTeam)
	if source == maingrid then 
		local Selected = DGS:dgsGridListGetSelectedItem(maingrid)
		if Selected == 1 then 
			DGS:dgsSetVisible(DmainRectImg, true)
			DGS:dgsSetAlpha(DmainRectImg,0)
			DGS:dgsAlphaTo(DmainRectImg,1,"Linear",500)
			DGS:dgsSetVisible(DrnkRectImg, false)
			DGS:dgsSetVisible(DmemberRectImg, false)
			DGS:dgsSetVisible(DvehRectImg, false)
			DGS:dgsSetVisible(DdutyRectImg, false)
			DGS:dgsSetVisible(DfinanceRectImg, false)
			DGS:dgsSetVisible(DannRectImg, false)
			DGS:dgsSetVisible(DtowRectImg, false)
			DGS:dgsSetVisible(DjobRectImg, false)
		elseif Selected == 2 then
		DGS:dgsSetVisible(DmemberRectImg, true)
		DGS:dgsSetAlpha(DmemberRectImg,0)
		DGS:dgsAlphaTo(DmemberRectImg,1,"Linear",500)
		DGS:dgsSetVisible(DmainRectImg, false)
		DGS:dgsSetVisible(DrnkRectImg, false)
		DGS:dgsSetVisible(DvehRectImg, false)
		DGS:dgsSetVisible(DdutyRectImg, false)
		DGS:dgsSetVisible(DfinanceRectImg, false)
		DGS:dgsSetVisible(DannRectImg, false)
		DGS:dgsSetVisible(DtowRectImg, false)
		DGS:dgsSetVisible(DjobRectImg, false)
		elseif Selected == 3 then
		DGS:dgsSetVisible(DrnkRectImg, true)
		DGS:dgsSetAlpha(DrnkRectImg,0)
		DGS:dgsAlphaTo(DrnkRectImg,1,"Linear",500)
		DGS:dgsSetVisible(DmainRectImg, false)
		DGS:dgsSetVisible(DmemberRectImg, false)
		DGS:dgsSetVisible(DvehRectImg, false)
		DGS:dgsSetVisible(DdutyRectImg, false)
		DGS:dgsSetVisible(DfinanceRectImg, false)
		DGS:dgsSetVisible(DannRectImg, false)
		DGS:dgsSetVisible(DtowRectImg, false)
		DGS:dgsSetVisible(DjobRectImg, false)
		elseif Selected == 4 then
		DGS:dgsSetVisible(DvehRectImg, true)
		DGS:dgsSetAlpha(DvehRectImg,0)
		DGS:dgsAlphaTo(DvehRectImg,1,"Linear",500)
		DGS:dgsSetVisible(DmainRectImg, false)
		DGS:dgsSetVisible(DmemberRectImg, false)
		DGS:dgsSetVisible(DrnkRectImg, false)
		DGS:dgsSetVisible(DdutyRectImg, false)
		DGS:dgsSetVisible(DfinanceRectImg, false)
		DGS:dgsSetVisible(DannRectImg, false)
		DGS:dgsSetVisible(DtowRectImg, false)
		DGS:dgsSetVisible(DjobRectImg, false)
		elseif Selected == 5 then
		DGS:dgsSetVisible(DannRectImg, true)
		DGS:dgsSetAlpha(DannRectImg,0)
		DGS:dgsAlphaTo(DannRectImg,1,"Linear",500)
		DGS:dgsSetVisible(DmainRectImg, false)
		DGS:dgsSetVisible(DrnkRectImg, false)
		DGS:dgsSetVisible(DmemberRectImg, false)
		DGS:dgsSetVisible(DdutyRectImg, false)
		DGS:dgsSetVisible(DfinanceRectImg, false)
		DGS:dgsSetVisible(DtowRectImg, false)
		DGS:dgsSetVisible(DjobRectImg, false)
		elseif Selected == 6 then
		loadFinance()
		DGS:dgsSetVisible(DfinanceRectImg, true)
		DGS:dgsSetAlpha(DfinanceRectImg,0)
		DGS:dgsAlphaTo(DfinanceRectImg,1,"Linear",500)
		DGS:dgsSetVisible(DmainRectImg, false)
		DGS:dgsSetVisible(DrnkRectImg, false)
		DGS:dgsSetVisible(DmemberRectImg, false)
		DGS:dgsSetVisible(DdutyRectImg, false)
		DGS:dgsSetVisible(DannRectImg, false)
		DGS:dgsSetVisible(DtowRectImg, false)
		DGS:dgsSetVisible(DjobRectImg, false)
		financeLoaded = true
		elseif Selected == 7 then
		DGS:dgsSetVisible(DdutyRectImg, true)
		DGS:dgsSetAlpha(DdutyRectImg,0)
		DGS:dgsAlphaTo(DdutyRectImg,1,"Linear",500)
		DGS:dgsSetVisible(DmainRectImg, false)
		DGS:dgsSetVisible(DrnkRectImg, false)
		DGS:dgsSetVisible(DmemberRectImg, false)
		DGS:dgsSetVisible(DvehRectImg, false)
		DGS:dgsSetVisible(DfinanceRectImg, false)
		DGS:dgsSetVisible(DannRectImg, false)
		DGS:dgsSetVisible(DtowRectImg, false)
		DGS:dgsSetVisible(DjobRectImg, false)
		elseif Selected == 8 then
		--DGS:dgsSetVisible(DjobRectImg, not DGS:dgsGetVisible(DjobRectImg))
		DGS:dgsSetVisible(DmainRectImg, false)
		DGS:dgsSetVisible(DrnkRectImg, false)
		DGS:dgsSetVisible(DmemberRectImg, false)
		DGS:dgsSetVisible(DvehRectImg, false)
		DGS:dgsSetVisible(DfinanceRectImg, false)
		DGS:dgsSetVisible(DannRectImg, false)
		DGS:dgsSetVisible(DdutyRectImg, false)
		DGS:dgsSetVisible(DtowRectImg, false)
		if statue == 0 then
		DGS:dgsSetText(clsBtn, "Open Applyment")
		else
		DGS:dgsSetText(clsBtn, "Close Applyment")
		end
		triggerServerEvent("JobApp:ShowApp", getRootElement(), teamName)
		--triggerServerEvent("JobApp:StatueAdminstrator", getRootElement(), teamName)
		setTimer (function () --to make sure that all app load from sql
				DGS:dgsSetVisible(DjobRectImg, not DGS:dgsGetVisible(DjobRectImg))
				DGS:dgsSetAlpha(DjobRectImg,0)
				DGS:dgsAlphaTo(DjobRectImg,1,"Linear",500)
			--DGS:dgsSetText(premiumloadLbl, "")
		end, 1000, 1)
		elseif Selected == 9 then
		DGS:dgsSetVisible(DtowRectImg, true)
		DGS:dgsSetAlpha(DtowRectImg,0)
		DGS:dgsAlphaTo(DtowRectImg,1,"Linear",500)
		DGS:dgsSetVisible(DmainRectImg, false)
		DGS:dgsSetVisible(DrnkRectImg, false)
		DGS:dgsSetVisible(DmemberRectImg, false)
		DGS:dgsSetVisible(DvehRectImg, false)
		DGS:dgsSetVisible(DfinanceRectImg, false)
		DGS:dgsSetVisible(DannRectImg, false)
		DGS:dgsSetVisible(DdutyRectImg, false)
		DGS:dgsSetVisible(DjobRectImg, false)
		end
	end
end )

function ShowAppAdminstrator(information) 
	DGS:dgsGridListClear(gJobGrid)--to make sure there's no duplicate value /-Dharma
		for key, value in pairs(information) do
			ID = information[key][1]
			Name = information[key][2]
			Num = information[key][3]
			Age = information[key][4]
			Addr = information[key][5]
			Email = information[key][6]
			Others = information[key][7]
			RP = information[key][8]
			Time = information[key][9]
			row = DGS:dgsGridListAddRow(gJobGrid)
			DGS:dgsGridListSetItemText(gJobGrid, row, colID, tostring(ID), false, false)
			DGS:dgsGridListSetItemText(gJobGrid, row, colName, tostring(Name), false, false)
			DGS:dgsGridListSetItemText(gJobGrid, row, colNum, tostring(Num), false, false)
			DGS:dgsGridListSetItemText(gJobGrid, row, colAge, tostring(Age), false, false)
			DGS:dgsGridListSetItemText(gJobGrid, row, colAddr, tostring(Addr), false, false)
			DGS:dgsGridListSetItemText(gJobGrid, row, colEmail, tostring(Email), false, false)
			DGS:dgsGridListSetItemText(gJobGrid, row, colOthers, tostring(Others), false, false)
			DGS:dgsGridListSetItemText(gJobGrid, row, colRP, tostring(RP), false, false)
			DGS:dgsGridListSetItemText(gJobGrid, row, colTime, tostring(Time), false, false)
		end
end
addEvent("JobApp:ShowAppAdminstrator", true)
addEventHandler("JobApp:ShowAppAdminstrator", getRootElement(), ShowAppAdminstrator)

addEventHandler("onDgsMouseClickDown", root, function ()
	if source == showBtn then
	local rowSelect, colSelect = DGS:dgsGridListGetSelectedItem(gJobGrid)
		if (rowSelect==-1) or (colSelect==-1) then
			return
		else
		
			local name = DGS:dgsGridListGetItemText(gJobGrid, DGS:dgsGridListGetSelectedItem(gJobGrid), 2)
			local phnum = DGS:dgsGridListGetItemText(gJobGrid, DGS:dgsGridListGetSelectedItem(gJobGrid), 3)
			local age = DGS:dgsGridListGetItemText(gJobGrid, DGS:dgsGridListGetSelectedItem(gJobGrid), 4)
			local addr = DGS:dgsGridListGetItemText(gJobGrid, DGS:dgsGridListGetSelectedItem(gJobGrid), 5)
			local email = DGS:dgsGridListGetItemText(gJobGrid, DGS:dgsGridListGetSelectedItem(gJobGrid), 6)
			local info = DGS:dgsGridListGetItemText(gJobGrid, DGS:dgsGridListGetSelectedItem(gJobGrid), 7)
			local rp = DGS:dgsGridListGetItemText(gJobGrid, DGS:dgsGridListGetSelectedItem(gJobGrid), 8)
			local time = DGS:dgsGridListGetItemText(gJobGrid, DGS:dgsGridListGetSelectedItem(gJobGrid), 9)
			triggerEvent("JobApp:ShowWholeApp", getRootElement(), name, phnum, age, addr, email, info, rp, time)
			--outputChatBox(name .. "\n" .. phnum)
		end
	end
end)

function OpenCloseApply()
--local statue = 0
local statueText = DGS:dgsGetText(clsBtn)
		playerTeam = getPlayerTeam(localPlayer)
		faction = getTeamName(playerTeam)
	if statue == 0 and statueText == "Open Applyment" then
		statue = 1
		DGS:dgsSetText(clsBtn, "Close Applyment")
		outputChatBox("You Successful Open Applyment")
	else
--	statue == 1 and statueText == "Close Applyment" then
		statue = 0
		DGS:dgsSetText(clsBtn, "Open Applyment")
		outputChatBox("You Successful Close Applyment")
	end
	triggerServerEvent("JobApp:StatueAdminstrator", getRootElement(), statue, faction)
end

--addEvent("JobApp:CloseOpenAppAdminstrator", true)
--addEventHandler("JobApp:CloseOpenAppAdminstrator", getRootElement(), OpenCloseApply)