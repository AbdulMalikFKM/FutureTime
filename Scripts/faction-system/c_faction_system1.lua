local screenW, screenH = guiGetScreenSize()

DGS = exports['dgs-master2']
home = dxCreateTexture(":resources/home.png")
rank = dxCreateTexture(":resources/ranks.png")
member = dxCreateTexture(":resources/member.png")
duty = dxCreateTexture(":resources/duty.png")
veh = dxCreateTexture(":resources/vehicless.png")
online = dxCreateTexture(":resources/online.png")
offline = dxCreateTexture(":resources/offline.png")

--! fonts !--
	robotoFont11 = DGS:dgsCreateFont(":job-system/storekeeper/files/Roboto-Regular.ttf", 11)
	robotoFont14 = DGS:dgsCreateFont(":job-system/storekeeper/files/Roboto-Regular.ttf", 14)
	robotoboldFont18 = DGS:dgsCreateFont("Roboto-Bold.ttf", 18)
	gtaFont15 = DGS:dgsCreateFont(":resources/gtaFont.ttf", 15)
	themify16 = DGS:dgsCreateFont(":resources/Themify.ttf", 16)
--! fonts !--


local factionTable = {}

local maxPlayersShow = 31

--! createSettings() !--

function showFactionMenu(motd, memberUsernames, memberRanks, memberPerks, memberLeaders, memberOnline, memberLastLogin, factionRanks, factionWages, factionTheTeam, note, fnote, vehicleIDs, vehicleModels, vehiclePlates, vehicleLocations, memberOnDuty, towstats, phone, membersPhone, fromShowF, factionID, birlikLevel, birlikOnay)
	factionTable[factionID] = {motd, memberUsernames, memberRanks, memberPerks, memberLeaders, memberOnline, memberLastLogin, factionRanks, factionWages, factionTheTeam, note, fnote, vehicleIDs, vehicleModels, vehiclePlates, vehicleLocations, memberOnDuty, towstats, phone, membersPhone, fromShowF, factionID, birlikLevel, birlikOnay}
	showPanel = not showPanel
	if showPanel then
	renderFactionMenu()
		--addEventHandler("onClientRender",root,renderFactionMenu)
		showCursor(true)
		currentTab = 1
		selectedVeh = 0
		selectedPlayer = 0
		currentSubTab = 0
		editRankMode = false
	end
end
addEvent("showFactionMenu", true)
addEventHandler("showFactionMenu", getRootElement(), showFactionMenu)


function hideFactionMenu()
	factionTable = {}
	removeEventHandler("onClientRender",root,renderFactionMenu)
	showCursor(false)
	triggerServerEvent("factionmenu:hide", getLocalPlayer())
	showPanel = false
	guiSetInputEnabled(false)
	closePromotion("left","up")
	anim = ">>"
	for k,v in ipairs(getElementsByType("gui-window")) do
		if getElementData(v,"tp:element") then
			destroyElement(v)
		end
	end
	for k,v in ipairs(getElementsByType("gui-window")) do
		if getElementData(v,"tp:element2") then
			destroyElement(v)
		end
	end
	for k,v in ipairs(getElementsByType("gui-edit")) do
		if getElementData(v,"child") then
			destroyElement(v)
		end
	end
	for k,v in ipairs(getElementsByType("gui-button")) do
		if getElementData(v,"child") then
			destroyElement(v)
		end
	end
	for k,v in ipairs(getElementsByType("gui-memo")) do
		if getElementData(v,"ann") then
			destroyElement(v)
		end
	end
end
addEvent("hideFactionMenu", true)
addEventHandler("hideFactionMenu", getRootElement(), hideFactionMenu)

function renderFactionMenu()
	
	x,y,w,h = sx/2-(sx/1.5)/2,sy/2-(sy/1.5)/2,sx/1.5,sy/1.5
	faction = getElementData(localPlayer,"faction")
	newTable = factionTable[faction]


	motd, memberUsernames, memberRanks, memberPerks, memberLeaders, memberOnline, memberLastLogin, factionRanks, factionWages, factionTheTeam, note, fnote, vehicleIDs, vehicleModels, vehiclePlates, vehicleLocations, memberOnDuty, towstats, phone, membersPhone, fromShowF, factionID, birlikLevel, birlikOnay = newTable[1],newTable[2],newTable[3],newTable[4],newTable[5],newTable[6],newTable[7],newTable[8],newTable[9],newTable[10],newTable[11],newTable[12],newTable[13],newTable[14],newTable[15],newTable[16],newTable[17],newTable[18],newTable[19],newTable[20],newTable[21],newTable[22],newTable[23],newTable[24]
	noteText = note
	arrFactionRanks = factionRanks
	arrFactionWages = factionWages
	arrUsernames = memberUsernames
	arrRanks = memberRanks
	arrLeaders = memberLeaders
	arrPerks = memberPerks
	arrOnline = memberOnline
	arrLastLogin = memberLastLogin
	theTeam = factionTheTeam
	local teamName = getTeamName(factionTheTeam)
	factionType = tonumber(getElementData(theTeam, "type"))
	
	online,offline = 0,0
	theMOTD = newTable[1]

	local factionPackages = exports.duty:getFactionPackages(factionID)
	for k, v in ipairs(memberUsernames) do
		if (memberOnline[k]) then
			online = online + 1
		else
			offline = offline + 1
		end
		
	end
	for k,v in ipairs(getElementsByType("gui-window")) do
		if getElementData(v,"tp:element") then
			if isElement(v) then
				xOffset = 110
			end
		else
			xOffset = 0
		end
	end
	factionID1 = factionID
	if not editRankMode then
		createUIPanel(x-xOffset,y,w,h,teamName.."\n#fefefe"..online.."/"..(online+offline).." aktif kullanıcı",factionID,factionID)-- yeni bir kullanıcı arayüz paneli oluştur
	end
end


function createUIPanel(x,y,w,h,windowName,factID,factID2)
	factionPackages = exports.duty:getFactionPackages(factID)

	dxDrawRectangle(x,y,w,h,tocolor(23,24,27,240))
	dxDrawRectangle(x,y,w/5.5,h,tocolor(15,14,16,180))
	dxDrawRectangle(x+(w/5.5),y,w-(w/5.5),70,tocolor(18,16,17,180))

	
	if sx <= 1366 and sy <= 768 then
		dxDrawText("Dharma Roleplay",x,y,w/5.5+x,70+y,tocolor(255,0,0),1,"default-bold","center","center")
		scaleW = 15
	else
		dxDrawText("Dharma Roleplay",x,y,w/5.5+x,70+y,tocolor(255,0,0),1,"default-bold","center","center")
	end


	dxDrawImage(x+(w/5.5)+6,y+18,32,32,"file/type_"..(factionType)..".png")
	dxDrawText(windowName,x+(w/5.5)+40,y+2,w-(w/5.5)+x+(w/5.5)+40,70+y+2,tocolor(255,255,255),1,font3,"left","center",false,false,false,true)
	dxDrawRectangle(x,y+69,w/5.5,1,tocolor(unpack(color["rgb"])))
	
	localPlayerIsLeader = nil

	
	


		for k, v in ipairs(memberUsernames) do
			
			if (tostring(memberUsernames[k])==getPlayerName(localPlayer)) then
				localPlayerIsLeader = memberLeaders[k]
			elseif newTable[20] then
				localPlayerIsLeader = newTable[20]
			end
		end

	count = 0
		tabStartX,tabStartY = x+(w/5.5),y+72
		tabStartW = w-(w/5.5)
		hex1,hex2 = "#4286f4","#4286f4"

	for k,v in pairs(tabsData) do
		if k == 0 or k == 2 or k == 4 or k == 6 then
			dxDrawRectangle(x,y+80+count,w/5.5,40,tocolor(20,19,21,210))
		else
			dxDrawRectangle(x,y+80+count,w/5.5,40,tocolor(15,14,16,210))
		end
		
		if currentTab == k then
			dxDrawImage(x+9,y+85+count,30,30,directoryMenu(k))
			dxDrawText(tabsData[k],x+55,y+80+count,w/5.5+x+55,40+y+80+count,tocolor(255,255,255),1,opti,"left","center")
		else
			dxDrawImage(x+9,y+85+count,30,30,directoryMenu(k),0,0,0,tocolor(215,215,215,170))
			dxDrawText(tabsData[k],x+55,y+80+count,w/5.5+x+55,40+y+80+count,tocolor(215,215,225,170),1,opti,"left","center")
		end
		if currentTab == 5 then
			if k == 5 then
				_y = y
				y = y+10
				if currentSubTab == 1 then
					dxDrawText("Member notes",x+55,y+80+count+45,w/5.5+x+55,40+y+80+count,tocolor(215,215,225,240),1,opti,"left","center")
					dxDrawText("Leader notes",x+55,y+80+count+90,w/5.5+x+55,40+y+80+count,tocolor(215,215,225,170),1,opti,"left","center")
				elseif currentSubTab == 2 then
					dxDrawText("Member notes",x+55,y+80+count+45,w/5.5+x+55,40+y+80+count,tocolor(215,215,225,170),1,opti,"left","center")
					dxDrawText("Leader notes",x+55,y+80+count+90,w/5.5+x+55,40+y+80+count,tocolor(215,215,225,240),1,opti,"left","center")
				else
					dxDrawText("Member notes",x+55,y+80+count+45,w/5.5+x+55,40+y+80+count,tocolor(215,215,225,170),1,opti,"left","center")
					dxDrawText("Leader notes",x+55,y+80+count+90,w/5.5+x+55,40+y+80+count,tocolor(215,215,225,170),1,opti,"left","center")
				end
				
				if isInSlot(x+55,y+75+count+45,80,14) then
					if getKeyState("mouse1") and lastClick+200 <= getTickCount() then
						lastClick = getTickCount()
						currentSubTab = 1
						
						if isElement(noteEdit) then
							destroyElement(noteEdit)
						end
							fNote = guiCreateMemo(tabStartX+15,tabStartY+10,tabStartW-30,h/1.5,fnote,false)
							setElementData(fNote,"ann",true)
							if localPlayerIsLeader then
								guiMemoSetReadOnly(fNote, false)
							else
								guiMemoSetReadOnly(fNote, true)
							end

					end
				elseif isInSlot(x+55,y+75+count+65,80,14) then
					
					if getKeyState("mouse1") and lastClick+200 <= getTickCount() then
						lastClick = getTickCount()
						if localPlayerIsLeader then
							currentSubTab = 2

							if isElement(fNote) then
								destroyElement(fNote)
							end
							noteEdit = guiCreateMemo(tabStartX+15,tabStartY+10,tabStartW-30,h/1.5,noteText,false)
							setElementData(noteEdit,"ann",true)
							
							guiMemoSetReadOnly(noteEdit, false)
						else
							exports.notification:addNotification("You have no right to enter this area!", "error")
						end
							
					end

				end
				y = _y
			end		
		end
		if isInSlot(x,y+80+count,w/5.5,40) then
			if getKeyState("mouse1") and lastClick+200 <= getTickCount() then
				lastClick = getTickCount()
				if k == 2 then
					if localPlayerIsLeader then
						btEditRanks()
					else
						exports.notification:addNotification("You have no right to enter this area!", "error")
					end
				else
					currentTab = k
				end
			

				if currentTab ~= 5 then
					currentSubTab = 0
					guiSetInputEnabled(false)
					for k,v in ipairs(getElementsByType("gui-window")) do
						if getElementData(v,"tp:element") then
							destroyElement(v)
						end
					end
					for k,v in ipairs(getElementsByType("gui-memo")) do
						if getElementData(v,"ann") then
							destroyElement(v)
						end
					end
				else
					guiSetInputEnabled(true)
				end
			end
		end

		count = count+41
	end



		
	if currentTab == 1 then--/anasayfa

		dxDrawText("Faction statement: "..theMOTD,x+(w/5.5)+5,y+h-26,w,h+h-26,tocolor(215,215,225,220),1,roboto,"left","top")
	

		dxDrawRectangle(tabStartX+8,tabStartY+10,tabStartW/3.1,160,tocolor(5,91,166))
		teX,teY,teW,teH = tabStartX+8,tabStartY+10,tabStartW/3.1,160
		dxDrawText("User Data\n"..#newTable[2].." Person",teX,teY-7,teW+teX,teY+teH-7,tocolor(255,255,255),1,roboto,"center","bottom")
		dxDrawImage(teX+teW/2-32,teY+teH/2-32,64,64,"file/stat_users.png")
		
		dxDrawRectangle(tabStartX+16+tabStartW/3.1,tabStartY+10,tabStartW/3.1,160,tocolor(0,115,108))
		teX,teY,teW,teH = tabStartX+16+tabStartW/3.1,tabStartY+10,tabStartW/3.1,160
		dxDrawText("Vehicle Data\n"..#newTable[13].." Vehicle",teX,teY-7,teW+teX,teY+teH-7,tocolor(255,255,255),1,roboto,"center","bottom")
		dxDrawImage(teX+teW/2-32,teY+teH/2-32,64,64,"file/stat_cars.png")
		
		--level,onay = 23,24
		dxDrawRectangle(tabStartX+24+(tabStartW/3.1)*2,tabStartY+10,tabStartW/3.1-scaleW,160,tocolor(136,103,50))
		teX,teY,teW,teH = tabStartX+16+tabStartW/3.1+tabStartW/3.1-scaleW,tabStartY+10,tabStartW/3.1,160
		dxDrawText("Faction Level: "..newTable[23].."\nConfirmation: "..checkOnay(newTable[24]),teX+6,teY-7,teW+teX+6,teY+teH-7,tocolor(255,255,255),1,roboto,"center","bottom")
		dxDrawImage(teX+teW/2-27,teY+teH/2-32-scaleW,64,64,"file/stat_info.png")
		

		if factionPackages and factionType >= 2 then
		--if true and factionType >= 2 then
			if localPlayerIsLeader then
				dxDrawRectangle(tabStartX+8,tabStartY+180,tabStartW/3.1,50,tocolor(5,91,166))
				teX,teY,teW,teH = tabStartX+8,tabStartY+180,tabStartW/3.1,50
				dxDrawText("Duty Settings",teX,teY,teW+teX,teH+teY,tocolor(255,255,255),1,roboto,"center","center")
				if isInSlot(tabStartX+8,tabStartY+180,tabStartW/3.1,50) then
					if getKeyState("mouse1") and lastClick+200 <= getTickCount() then
						lastClick = getTickCount()
						btDutyPanel()
					end
				end

				dxDrawRectangle(tabStartX+16+tabStartW/3.1,tabStartY+180,tabStartW/3.1,50,tocolor(0,115,108))
				teX,teY,teW,teH = tabStartX+16+tabStartW/3.1,tabStartY+180,tabStartW/3.1,50
				dxDrawText("Financial Management",teX,teY,teW+teX,teH+teY,tocolor(255,255,255),1,roboto,"center","center")

				if isInSlot(tabStartX+16+tabStartW/3.1,tabStartY+180,tabStartW/3.1,50) then
					if getKeyState("mouse1") and lastClick+200 <= getTickCount() then
						lastClick = getTickCount()
						btFinancePanel()
					end
				end

			end
		end
		this, leaveFaction = drawButton(" Leave Faction",tabStartX+tabStartW-180,y+h-35,170,25,"#4286f4", false, false, false, nil, true)
		if isInSlot(tabStartX+tabStartW-180,y+h-35,170,25) then
			if getKeyState("mouse1") and lastClick+200 <= getTickCount() then
				lastClick = getTickCount()
				btQuitFaction()
			end
		end
	elseif currentTab == 2 then--/rütbeler

	elseif currentTab == 3 then--/kullanıcılar
		
		if (localPlayerIsLeader) then
			--dxDrawnButtons // aka Incama
			hoverData = {}
			buttonX,buttonY,buttonW,buttonH = tabStartX+tabStartW-(w-tabStartW/1.4)/2.1,tabStartY+10,(w-tabStartW/1.4)/2.2,30

			this, hoverData["kick"] = drawButton(" Discard Contact",buttonX,buttonY,buttonW,buttonH,hex2, false, false, false, nil, true)
			if isInSlot(buttonX,buttonY,buttonW,buttonH) then
				if getKeyState("mouse1") and lastClick+200 <= getTickCount() then
					lastClick = getTickCount()
					if selectedPlayer ~= 0 then
						btKickPlayer()
					end
				end
			end

			buttonY = buttonY+35
			this, hoverData["leader"] = drawButton(" Give Leadership",buttonX,buttonY,buttonW,buttonH,hex1, false, false, false, nil, true)
			if isInSlot(buttonX,buttonY,buttonW,buttonH) then
				if getKeyState("mouse1") and lastClick+200 <= getTickCount() then
					lastClick = getTickCount()
					if selectedPlayer ~= 0 then
						btToggleLeader()

					end
				end
			end

			buttonY = buttonY+35
			this, hoverData["rankcontrol"] = drawButton(" Promote / Demote",buttonX,buttonY,buttonW,buttonH,hex2, false, false, false, nil, true)
		
			if isInSlot(buttonX,buttonY,buttonW,buttonH) then
				if getKeyState("mouse1") and lastClick+200 <= getTickCount() then
					lastClick = getTickCount()
					if selectedPlayer ~= 0 then
						btPromotePlayer(selectedPlayer,string.gsub(tostring(memberUsernames[selectedPlayer]), "_", " "))
					
					end
				end
			end
			buttonY = buttonY+35
			this, hoverData["editdesc"] = drawButton(" Edit Faction Message",buttonX,buttonY,buttonW,buttonH,hex1, false, false, false, nil, true)
			if isInSlot(buttonX,buttonY,buttonW,buttonH) then
				if getKeyState("mouse1") and lastClick+200 <= getTickCount() then
					lastClick = getTickCount()
					btEditMOTD(theMOTD)
				end
			end

			buttonY = buttonY+35
			this, hoverData["addplayer"] = drawButton(" Invite Players",buttonX,buttonY,buttonW,buttonH,hex2, false, false, false, nil, true)
			if isInSlot(buttonX,buttonY,buttonW,buttonH) then
				if getKeyState("mouse1") and lastClick+200 <= getTickCount() then
					lastClick = getTickCount()

					btInvitePlayer()
				end
			end
			buttonY = buttonY+35
			if factionPackages and factionType >= 2 then
				this, hoverData["dutySet"] = drawButton(" Set duty",buttonX,buttonY,buttonW,buttonH,hex1, false, false, false, nil, true)
				if isInSlot(buttonX,buttonY,buttonW,buttonH) then
					if getKeyState("mouse1") and lastClick+200 <= getTickCount() then
						lastClick = getTickCount()
						btButtonPerk(factID2)
					end
				end
				buttonY = buttonY+35
			end
			if selectedPlayer ~= 0 then
				dxDrawText("Selected User Information\n#fefefeCharacter name: " ..string.gsub(tostring(memberUsernames[selectedPlayer]), "_", " ").."\nRank: "..factionRanks[tonumber(memberRanks[selectedPlayer])].."\nRank salary: "..factionWages[tonumber(memberRanks[selectedPlayer])].."$",buttonX,buttonY,buttonW,buttonH,tocolor(255,255,255),1,roboto,"left","top",false,false,false,true)
			end
		end
		dxDrawRectangle(tabStartX+10,tabStartY+10,tabStartW/1.4,h-100,tocolor(15,15,15,150))
		dxDrawRectangle(tabStartX+10,tabStartY+10,tabStartW/1.4,25,tocolor(30,30,30))
		dxDrawRectangle(tabStartX+10,tabStartY+10+24,tabStartW/1.4,1,tocolor(unpack(color["rgb"])))

		prewX,prewY,prewW,prewH = tabStartX+10,tabStartY+10,tabStartW/1.4,25
		dxDrawText("Character name",prewX+5,prewY,prewW+prewX,prewH+prewY,tocolor(225,225,225),1,opti,"left","center")
		dxDrawText("Rank",prewX+tabStartW/5.5,prewY,prewW+prewX,prewH+prewY,tocolor(225,225,225),1,opti,"left","center")
		if (factionType==2) or (factionType==3) or (factionType==4) or (factionType==5) or (factionType==6) or (factionType==7) then -- Added Mechanic type \ Adams
			gridScale = 2.6
		else
			gridScale = 3
		end

		dxDrawText("Status",prewX+tabStartW/gridScale,prewY,prewW+prewX,prewH+prewY,tocolor(225,225,225),1,opti,"left","center")
		if gridScale == 2.6 then
			dxDrawText("Salary",prewX+tabStartW/3.3,prewY,prewW+prewX,prewH+prewY,tocolor(225,225,225),1,opti,"left","center")
			dxDrawText("on duty",prewX+tabStartW/1.75,prewY,prewW+prewX,prewH+prewY,tocolor(225,225,225),1,opti,"left","center")
		end

		dxDrawText("Last Login",prewX+tabStartW/2.1,prewY,prewW+prewX,prewH+prewY,tocolor(225,225,225),1,opti,"left","center")

		dxDrawText("Leader",prewX+tabStartW/1.5,prewY,prewW+prewX,prewH+prewY,tocolor(225,225,225),1,opti,"left","center")

		line = 0
		for k, v in ipairs(memberUsernames) do

			if (k > players_scroll and line < maxPlayersShow) then
					line = line + 1
					countY = (line-1)*15

					if selectedPlayer == k then
						rr,gg,bb = unpack(color["rgb"])
					else
						rr,gg,bb = 225,225,225
					end
					if isInSlot(prewX,prewY+27+countY,prewW,prewH-7) then
						if getKeyState("mouse1") and lastClick+200 <= getTickCount() then
							lastClick = getTickCount()
							selectedPlayer = k
						end
					end

					dxDrawText(string.gsub(tostring(memberUsernames[k]), "_", " "),prewX+5,prewY+24+countY,prewW+prewX,prewH+prewY+24+countY,tocolor(rr,gg,bb),1,opti2,"left","center")
					local theRank = tonumber(memberRanks[k])
					local rankName = factionRanks[theRank]
					dxDrawText(rankName,prewX+tabStartW/5.5,prewY+24+countY,prewW+prewX,prewH+prewY+24+countY,tocolor(rr,gg,bb),1,opti2,"left","center")

					if (memberOnline[k]) then
						dxDrawImage(prewX+tabStartW/gridScale+5,prewY+27+countY+2,16,16,"file/online.png")
						--dxDrawText("",prewX+tabStartW/3+5,prewY+24+countY,prewW+prewX,prewH+prewY+24+countY,tocolor(0, 255, 0),1,opti2,"left","center")
					else
						dxDrawImage(prewX+tabStartW/gridScale+5,prewY+27+countY+2,16,16,"file/offline.png")
						--dxDrawText("",prewX+tabStartW/3+5,prewY+24+countY,prewW+prewX,prewH+prewY+24+countY,tocolor(255,0,0),1,opti2,"left","center")
					end
			
					local rankPay = factionWages[theRank]
					if gridScale == 2.6 then
						dxDrawText(rankPay.."$",prewX+tabStartW/3.3,prewY+24+countY,prewW+prewX,prewH+prewY+24+countY,tocolor(225,225,225),1,opti2,"left","center")
						if memberOnDuty[k] then
							dxDrawImage(prewX+tabStartW/1.75+8,prewY+27+countY+2,16,16,"file/online.png")
						else
							dxDrawImage(prewX+tabStartW/1.75+8,prewY+27+countY+2,16,16,"file/offline.png")
						end
					end

					local login = "No"
					if (not memberLastLogin[k]) then
						login = "No"
					else
						if (memberLastLogin[k]==0) then
							login = "Today"
						elseif (memberLastLogin[k]==1) then
							login = tostring(memberLastLogin[k]) .. " days ago"
						else
							login = tostring(memberLastLogin[k]) .. " days ago"
						end
					end
					dxDrawText(login,prewX+tabStartW/2.1,prewY+24+countY,prewW+prewX,prewH+prewY+24+countY,tocolor(rr,gg,bb),1,opti2,"left","center")
					
					if (memberLeaders[k]) then
						textL = "Yes"
					else
						textL = "No"
					end
					dxDrawText(textL,prewX+tabStartW/1.5,prewY+24+countY,prewW+prewX,prewH+prewY+24+countY,tocolor(rr,gg,bb),1,opti2,"left","center")
			end
			
		end
	elseif currentTab == 4 then--/araçlar

		prewX,prewY,prewW,prewH = tabStartX+10,tabStartY+10,tabStartW/1.4,25
		dxDrawRectangle(tabStartX+10,tabStartY+10,tabStartW/1.4,h-100,tocolor(15,15,15,150))
		dxDrawRectangle(tabStartX+10,tabStartY+10,tabStartW/1.4,25,tocolor(30,30,30))
		dxDrawRectangle(tabStartX+10,tabStartY+10+24,tabStartW/1.4,1,tocolor(unpack(color["rgb"])))

		dxDrawText("ID",prewX+15,prewY,prewW+prewX,prewH+prewY,tocolor(225,225,225),1,opti,"left","center")
		dxDrawText("Model",prewX+tabStartW/4,prewY,prewW+prewX,prewH+prewY,tocolor(225,225,225),1,opti,"left","center")
		dxDrawText("Plate",prewX+tabStartW/2,prewY,prewW+prewX,prewH+prewY,tocolor(225,225,225),1,opti,"left","center")
		if (localPlayerIsLeader) then
			hoverData = {}
			buttonX,buttonY,buttonW,buttonH = tabStartX+tabStartW-(w-tabStartW/1.4)/2.1,tabStartY+10,(w-tabStartW/1.4)/2.2,30
			this, hoverData["thisRespawn"] = drawButton(" Respawn Selected",buttonX,buttonY,buttonW,buttonH,hex2, false, false, false, nil, true)
			if isInSlot(buttonX,buttonY,buttonW,buttonH) then
				if getKeyState("mouse1") and lastClick+200 <= getTickCount() then
					lastClick = getTickCount()
					if selectedVeh ~= 0 then
						btRespawnOneVehicle(vehicleIDs[selectedVeh])
					end
				end
			end
			buttonY = buttonY + 35
			this, hoverData["thisRespawn"] = drawButton(" Respawn Tools",buttonX,buttonY,buttonW,buttonH,hex1, false, false, false, nil, true)
			if isInSlot(buttonX,buttonY,buttonW,buttonH) then
				if getKeyState("mouse1") and lastClick+200 <= getTickCount() then
					lastClick = getTickCount()
					showrespawn()
				end
			end
		end


		countY = 0
		local line = 0
		for k,v in ipairs(vehicleIDs) do
			if (k > vehicles_scroll and line < maxPlayersShow) then
				line = line + 1
				countY = (line-1)*15

				if isInSlot(prewX,prewY+27+countY,prewW,prewH-7) then
					if getKeyState("mouse1") and lastClick+200 <= getTickCount() then
						lastClick = getTickCount()
						if selectedVeh == k then
							selectedVeh = 0
						else
							selectedVeh = k
						end
					end
				end

				if selectedVeh == k then
					rr,gg,bb = unpack(color["rgb"])
				else
					rr,gg,bb = 225,225,225
				end
				dxDrawText(tostring(v),prewX+15,prewY+24+countY,prewW+prewX,prewH+prewY+24+countY,tocolor(rr,gg,bb),1,opti2,"left","center")
				dxDrawText(tostring(newTable[14][k]),prewX+tabStartW/4,prewY+24+countY,prewW+prewX,prewH+prewY+24+countY,tocolor(rr,gg,bb),1,opti2,"left","center")
				dxDrawText(tostring(newTable[15][k]),prewX+tabStartW/2,prewY+24+countY,prewW+prewX,prewH+prewY+24+countY,tocolor(rr,gg,bb),1,opti2,"left","center")
			end
		
		end
	elseif currentTab == 5 then--/duyurular
		if localPlayerIsLeader and currentSubTab ~= 0 then
			buttonX,buttonY,buttonW,buttonH = tabStartX+15,tabStartY+(h/1.5)+15,tabStartW-30,30
			hoverData = {}
			this, hoverData["thisSave"] = drawButton(" Save and Process Data",buttonX,buttonY,buttonW,buttonH,hex1, false, false, false, nil, true)
			if isInSlot(buttonX,buttonY,buttonW,buttonH) then
				if getKeyState("mouse1") and lastClick+200 <= getTickCount() then
					lastClick = getTickCount()
					if currentSubTab == 1 then
						btUpdateFNote()
					else
						btUpdateNote()
					end
				end
			end
		end
	end

	if isInSlot(x+w-55,y+20,32,32) then
		dxDrawImage(x+w-55,y+20,32,32,"file/close.png",0,0,0,tocolor(225,0,0))
		if getKeyState("mouse1") and lastClick+200 <= getTickCount() then
			lastClick = getTickCount()
			hideFactionMenu()
		end
	else
		dxDrawImage(x+w-55,y+20,32,32,"file/close.png")
	end
end


local promotionRadio = {}
function btPromotePlayer(row,playerName)
		playerName = playerName
		local theRank = tonumber(memberRanks[row])
		local rankName = factionRanks[theRank]
		local currentRank = theRank
		if (playerName~="") then
			local currRankNumber = currentRank



			local width, height = 300, 500
			local scrWidth, scrHeight = guiGetScreenSize()
			local x = scrWidth-width-10
			local y = scrHeight/2 - (height/2)

			rankWindow = guiCreateWindow(x,y,width,height,"Set Player Rank",false)
			setElementData(rankWindow,"promote",true)
			setElementData(rankWindow,"tp:element",true)
			guiWindowSetSizable(rankWindow, false)
			rankLabel = guiCreateLabel(0.0427,0.058,0.9145,0.044,"Please select Player_Name's new rank",true,rankWindow)
			promotionRadio[20] = guiCreateRadioButton(0.047,0.1071,0.9145,0.0402,"Generic Rank 20",true,rankWindow)
			promotionRadio[19] = guiCreateRadioButton(0.047,0.1473,0.9145,0.0402,"Generic Rank 19",true,rankWindow)
			promotionRadio[18] = guiCreateRadioButton(0.047,0.1875,0.9145,0.0402,"Generic Rank 18",true,rankWindow)
			promotionRadio[17] = guiCreateRadioButton(0.047,0.2277,0.9145,0.0402,"Generic Rank 17",true,rankWindow)
			promotionRadio[16] = guiCreateRadioButton(0.047,0.2679,0.9145,0.0402,"Generic Rank 16",true,rankWindow)
			promotionRadio[15] = guiCreateRadioButton(0.047,0.308,0.9145,0.0402,"Generic Rank 15",true,rankWindow)
			promotionRadio[14] = guiCreateRadioButton(0.047,0.3482,0.9145,0.0402,"Generic Rank 14",true,rankWindow)
			promotionRadio[13] = guiCreateRadioButton(0.047,0.3884,0.9145,0.0402,"Generic Rank 13",true,rankWindow)
			promotionRadio[12] = guiCreateRadioButton(0.047,0.4286,0.9145,0.0402,"Generic Rank 12",true,rankWindow)
			promotionRadio[11] = guiCreateRadioButton(0.047,0.4688,0.9145,0.0402,"Generic Rank 11",true,rankWindow)
			promotionRadio[10] = guiCreateRadioButton(0.047,0.5089,0.9145,0.0402,"Generic Rank 10",true,rankWindow)
			promotionRadio[9] = guiCreateRadioButton(0.047,0.5491,0.9145,0.0402,"Generic Rank 9",true,rankWindow)
			promotionRadio[8] = guiCreateRadioButton(0.047,0.5893,0.9145,0.0402,"Generic Rank 8",true,rankWindow)
			promotionRadio[7] = guiCreateRadioButton(0.047,0.6295,0.9145,0.0402,"Generic Rank 7",true,rankWindow)
			promotionRadio[6] = guiCreateRadioButton(0.047,0.6696,0.9145,0.0402,"Generic Rank 6",true,rankWindow)
			promotionRadio[5] = guiCreateRadioButton(0.047,0.7098,0.9145,0.0402,"Generic Rank 5",true,rankWindow)
			promotionRadio[4] = guiCreateRadioButton(0.047,0.75,0.9145,0.0402,"Generic Rank 4",true,rankWindow)
			promotionRadio[3] = guiCreateRadioButton(0.047,0.7902,0.9145,0.0402,"Generic Rank 3",true,rankWindow)
			promotionRadio[2] = guiCreateRadioButton(0.047,0.8304,0.9145,0.0402,"Generic Rank 2",true,rankWindow)
			promotionRadio[1] = guiCreateRadioButton(0.047,0.8705,0.9145,0.0402,"Generic Rank 1",true,rankWindow)
			save = guiCreateButton(0.0427,0.9107,0.4231,0.067,"Save",true,rankWindow)
			close = guiCreateButton(0.5214,0.9107,0.4231,0.067,"Close",true,rankWindow)
			guiRadioButtonSetSelected(promotionRadio[currRankNumber], true)
			guiSetText(rankLabel, "Please " .. playerName:gsub("_"," ") .. " Select 's rank")
			for i = 1, 20 do
				guiSetText(promotionRadio[i], "Rank " .. i .. ": " .. arrFactionRanks[i])
			end
			addEventHandler("onClientGUIClick", save, savePromotion, false)
			addEventHandler("onClientGUIClick", close, closePromotion, false)

			openLibrary("convert",rankWindow)
		else
			outputChatBox("Choose a Player.", 255, 0, 0)
		end

end

function savePromotion(button, state)
	if button == "left" and state == "up" and source == save then
		local newRank = 0
		for key, value in ipairs(promotionRadio) do
			if isElement(value) then
				if guiRadioButtonGetSelected(value) then
					newRank = key
					break
				end
			end
		end
	
		local playerName = memberUsernames[selectedPlayer]
		local row = selectedPlayer
		local theRank = tonumber(memberRanks[row])
		local currRankNumber = theRank
		if newRank == currRankNumber then
			outputChatBox("You must select a new rank to make the player", 255, 0, 0)
			closePromotion("left", "up")
		elseif newRank > currRankNumber then
		--	guiGridListSetItemData(gMemberGrid, row, colRank, tostring(newRank))
			memberRanks[row] = newRank
			triggerServerEvent("cguiPromotePlayer", getLocalPlayer(), playerName, newRank, arrFactionRanks[currRankNumber], arrFactionRanks[newRank])
			
			closePromotion("left", "up")
		elseif newRank < currRankNumber then
		--	guiGridListSetItemData(gMemberGrid, row, colRank, tostring(newRank))
			memberRanks[row] = newRank
			triggerServerEvent("cguiDemotePlayer", getLocalPlayer(), playerName, newRank, arrFactionRanks[currRankNumber], arrFactionRanks[newRank])
			
			closePromotion("left", "up")
		else
			outputChatBox("FAC-PRMO-ERROR-0001 - Please report on the forums.", 255, 0, 0)
		end
	end
end

function closePromotion(button, state)
	if button == "left" and state == "up" then
		for k,v in ipairs(getElementsByType("gui-window",root)) do
			if getElementData(v,"promote") then
				destroyElement(v)
			end
		end
	end
end

function btKickPlayer()
	local playerName = memberUsernames[selectedPlayer]
	if (playerName~="") then
		local row = selectedPlayer
		--memberUsernames[row] = {}--// added update from table.
		
		local theTeamName = getTeamName(theTeam)
		
		outputChatBox("* " .. playerName:gsub("_", " ") .. " named player'" .. tostring(theTeamName) .. "' was kicked out from the Faction.", 0, 255, 0)
		if triggerServerEvent("cguiKickPlayer", getLocalPlayer(), playerName) then
			selectedPlayer = 0
		end
	else
		outputChatBox("Please choose someone to be Kick..")
	end
end

function btToggleLeader()
	
		local playerName = memberUsernames[selectedPlayer]
		
		if (playerName==getPlayerName(getLocalPlayer())) then
			outputChatBox("You cannot un-leader yourself.", thePlayer)
		elseif (playerName~="") then
		
			if (memberLeaders[selectedPlayer]) then
				memberLeaders[selectedPlayer] = false
				triggerServerEvent("cguiToggleLeader", getLocalPlayer(), playerName, false) -- false = not leader
			else
				memberLeaders[selectedPlayer] = true
				triggerServerEvent("cguiToggleLeader", getLocalPlayer(), playerName, true) -- true = leader
			end
			selectedPlayer = 0
		else
			outputChatBox("Please select a member to toggle leader on.")
		end
	
end

wMOTD, tMOTD, bUpdate, bMOTDClose = nil
function btEditMOTD(theMotd)

	if not (wMOTD) then
		local width, height = 300, 200
		local scrWidth, scrHeight = guiGetScreenSize()
		local x = scrWidth-width-10
		local y = scrHeight/2 - (height/2)
		
		wMOTD = guiCreateWindow(x, y, width, height, "Edit Faction Message", false)
		setElementData(wMOTD,"tp:element",true)
		tMOTD = guiCreateEdit(0.1, 0.2, 0.85, 0.1, tostring(theMotd), true, wMOTD)
		
		guiSetInputEnabled(true)
		
		bUpdate = guiCreateButton(0.1, 0.6, 0.85, 0.15, "Update", true, wMOTD)
		addEventHandler("onClientGUIClick", bUpdate, sendMOTD, false)
		
		bMOTDClose= guiCreateButton(0.1, 0.775, 0.85, 0.15, "Close", true, wMOTD)
		addEventHandler("onClientGUIClick", bMOTDClose, closeMOTD, false)

		openLibrary("convert",wMOTD)
	else
		guiBringToFront(wMOTD)
	end
	
end

function closeMOTD(button, state)
	if (source==bMOTDClose) and (button=="left") and (state=="up") then
		if (wMOTD) then
			destroyElement(wMOTD)
			wMOTD, tMOTD, bUpdate, bMOTDClose = nil, nil, nil, nil
		end
	end
end

function sendMOTD(button, state)
	if (source==bUpdate) and (button=="left") and (state=="up") then
		local motd = guiGetText(tMOTD)
		
		local found1 = string.find(motd, ";")
		local found2 = string.find(motd, "'")
		
		if (found1) or (found2) then
			exports.notification:addNotification("wrong characters found in your message.", "error")
		else
			--guiSetText(gMOTDLabel, tostring(motd))
			theMOTD = motd -- Store it clientside
			triggerServerEvent("cguiUpdateMOTD", getLocalPlayer(), motd)
		end
	end
end


function showrespawn()
	local sx, sy = guiGetScreenSize() 
	
	showrespawnUI = guiCreateWindow(sx-310,sy/2 - 50,300,100,"Respawn Tools", false)
	setElementData(showrespawnUI,"tp:element",true)
	local lQuestion = guiCreateLabel(0.05,0.25,0.9,0.3,"All vehicles will be respawned?",true,showrespawnUI)
	guiLabelSetHorizontalAlign (lQuestion,"center",true)
	gButtonRespawn = guiCreateButton(0.1,0.65,0.37,0.23,"Yes",true,showrespawnUI)
	gButtonNo = guiCreateButton(0.53,0.65,0.37,0.23,"No",true,showrespawnUI)

	openLibrary("convert",showrespawnUI)

			addEventHandler("onClientGUIClick", gButtonRespawn, btRespawnVehicles, false)
			addEventHandler("onClientGUIClick", gButtonNo, btRespawnVehicles, false)
end
addEvent("showrespawn",true)
addEventHandler("showrespawn", getRootElement(), showrespawn)


function btRespawnVehicles(button, state)
	if (button=="left") then
		if source == gButtonRespawn then
			--hideFactionMenu()
			destroyElement(showrespawnUI)
			triggerServerEvent("cguiRespawnVehicles", getLocalPlayer())
		elseif source == gButtonNo then
			--hideFactionMenu()
			destroyElement(showrespawnUI)
		end
	end
end
function btRespawnOneVehicle(vehID)
	
	if vehID then
		triggerServerEvent("cguiRespawnOneVehicle", getLocalPlayer(), vehID)
	else
		exports.notification:addNotification("Please select a vehicle to respawn.", "error")
	end
	
end
function btUpdateFNote()
	
	triggerServerEvent("faction:fnote", getLocalPlayer(), guiGetText(fNote))
	
end
function btUpdateNote()
	
	triggerServerEvent("faction:note", getLocalPlayer(), guiGetText(noteEdit))
	
end
-- INVITE
wInvite, tInvite, lNameCheck, bInvite, bInviteClose, invitedPlayer = nil
function btInvitePlayer()

		if isElement(wInvite) then return end
			local width, height = 300, 200
			local scrWidth, scrHeight = guiGetScreenSize()
			local x = scrWidth-width-10
			local y = scrHeight/2 - (height/2)
			
			wInvite = guiCreateWindow(x, y, width, height, "Invite Player", false)
			setElementData(wInvite,"tp:element",true)
			tInvite = guiCreateEdit(0.1, 0.2, 0.85, 0.1, "Oyuncu Ismi : 'Ad_Soyad'", true, wInvite)
			addEventHandler("onClientGUIChanged", tInvite, checkNameExists)
					
			lNameCheck = guiCreateLabel(0.1, 0.325, 0.8, 0.3, "Birden fazla oyuncu bulundu.", true, wInvite)
			guiSetFont(lNameCheck, "default-bold-small")
			guiLabelSetColor(lNameCheck, 255, 0, 0)
			guiLabelSetHorizontalAlign(lNameCheck, "center")
			
			guiSetInputEnabled(true)
			
			bInvite = guiCreateButton(0.1, 0.6, 0.85, 0.15, "Davet et!", true, wInvite)
			guiSetEnabled(bInvite, false)
			--addEventHandler("onClientGUIClick", bInvite, birlikDavetEtmeILK, false)
			addEventHandler("onClientGUIClick", guiRoot, 
				function () 
					if source == bInvite then
						local theTeamName = getTeamName(theTeam)
						if getElementData(invitedPlayer,"loggedin") == 1 then
						--	outputChatBox(getElementData(invitedPlayer,"faction"))
							if tonumber(getElementData(invitedPlayer,"faction")) > 0 then
								outputChatBox("[!] #ffffffDavet etmek istediğiniz kişi zaten bir birlikte!", 255, 0, 0, true)
								destroyElement(wInvite)
							else
								triggerServerEvent("faction-system:sendInviteRequest", localPlayer, invitedPlayer, theTeamName)
								destroyElement(wInvite)
							end
						end

						--triggerEvent("faction-system:davetEtmeBurayaGEL", invitedPlayer, getLocalPlayer(), theTeamName)
					
					end
				end)
			
			bCloseInvite = guiCreateButton(0.1, 0.775, 0.85, 0.15, "Pencereyi Kapat", true, wInvite)
			addEventHandler("onClientGUIClick", bCloseInvite, closeInvite, false)

			openLibrary("convert",wInvite)
		
	
end

--[[
function birlikDavetEtmeILK(davetEdenOyuncu, theTeamName)
	outputChatBox("invitedPlayer ismi1: "..getPlayerName(invitedPlayer))
	outputChatBox("davetEdenOyuncu ismi1: "..getPlayerName(davetEdenOyuncu))
	triggerEvent("faction-system:birlikDavetEtmePaneli", invitedPlayer, davetEdenOyuncu, theTeamName)
end
addEvent("faction-system:davetEtmeBurayaGEL", true)
addEventHandler("faction-system:davetEtmeBurayaGEL", getRootElement(), birlikDavetEtmeILK)
]]

GUIEditor = {
    gridlist = {},
    window = {},
    scrollbar = {},
    button = {},
	label = {}
}

function showInviteMenu(davetEdenOyuncu, davetEdilenBirlik, fromPlayer)
	showCursor(true)

	GUIEditor.window[1] = guiCreateWindow(0.37, 0.42, 0.26, 0.14, "Mercy Roleplay - Birlik Daveti", true)
	guiWindowSetSizable(GUIEditor.window[1], false)


	GUIEditor.label[1] = guiCreateLabel(0.03, 0.21, 0.31, 0.13, "Davet eden oyuncu :", true, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[1], "default-bold-small")
	GUIEditor.label[2] = guiCreateLabel(0.03, 0.34, 0.31, 0.13, "Davet ettiği birlik     :", true, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[2], "default-bold-small")
	GUIEditor.label[3] = guiCreateLabel(0.35, 0.21, 0.62, 0.13, getPlayerName(davetEdenOyuncu), true, GUIEditor.window[1])
	GUIEditor.label[4] = guiCreateLabel(0.35, 0.34, 0.62, 0.13, davetEdilenBirlik, true, GUIEditor.window[1])
	onaylaButonu = guiCreateButton(0.02, 0.53, 0.47, 0.35, "ONAYLA", true, GUIEditor.window[1])
	addEventHandler("onClientGUIClick", guiRoot, 
	function () 
		if source == onaylaButonu then
			triggerServerEvent("cguiInvitePlayer", localPlayer, davetEdenOyuncu)
			triggerServerEvent("outputFactionChat",davetEdenOyuncu,davetEdenOyuncu,"+",getPlayerName(localPlayer))
			destroyElement(GUIEditor.window[1])
			showCursor(false)
		end
	end)
	
	kapatmaButonu = guiCreateButton(0.51, 0.53, 0.47, 0.35, "REDDET", true, GUIEditor.window[1])    
	addEventHandler("onClientGUIClick", guiRoot, 
	function () 
		if source == kapatmaButonu then
			destroyElement(GUIEditor.window[1])
			triggerServerEvent("outputFactionChat",davetEdenOyuncu,davetEdenOyuncu,"-",getPlayerName(localPlayer))

			showCursor(false)
		end
	end)
	openLibrary("convert",GUIEditor.window[1])
end
addEvent("faction-system:showInviteMenu", true)
addEventHandler("faction-system:showInviteMenu", root, showInviteMenu)

function closeInvite(button, state)
	if (source==bCloseInvite) and (button=="left") and (state=="up") then
		if (wInvite) then
			destroyElement(wInvite)

			wInvite, tInvite, lNameCheck, bInvite, bInviteClose, invitedPlayer = nil, nil, nil, nil, nil, nil
		end
	end
end

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
		if (string.find(username, string.lower(tostring(guiGetText(theEditBox))))) and (guiGetText(theEditBox)~="") then
			count = count + 1
			found = value
			foundstr = username
		end
	end
	
	if (count>1) then
		guiSetText(lNameCheck, "Birden fazla oyuncu bulundu.")
		guiLabelSetColor(lNameCheck, 255, 255, 0)
		--guiMemoSetReadOnly(tInvite, true)
		guiSetEnabled(bInvite, false)
	elseif (count==1) then
		guiSetText(lNameCheck, "Oyuncu Bulundu : ("..foundstr..")")
		guiLabelSetColor(lNameCheck, 0, 255, 0)
		invitedPlayer = found
		--guiMemoSetReadOnly(tInvite, false)
		guiSetEnabled(bInvite, true)
	elseif (count==0) then
		guiSetText(lNameCheck, "Birden fazla oyuncu bulundu veya bulunamadi.")
		guiLabelSetColor(lNameCheck, 255, 0, 0)
		guiMemoSetReadOnly(tInvite, true)
		guiSetEnabled(bInvite, false)
	end
	guiLabelSetHorizontalAlign(lNameCheck, "center")
end


--ranks

lRanks = { }
tRanks = { }
tRankWages = { }
wRanks = nil
bRanksSave, bRanksClose = nil

function btEditRanks()
	
		local factionType = tonumber(getElementData(theTeam, "type"))
		lRanks = { }
		tRanks = { }
		tRankWages = { }
		editRankMode = true
		--guiSetInputEnabled(true)
		
		local wages = (factionType==2) or (factionType==3) or (factionType==4) or (factionType==5) or (factionType==6) or (factionType==7)  -- Added Mechanic type \ Adams
		local width, height = 550, 565
		local scrWidth, scrHeight = guiGetScreenSize()
		local x = scrWidth/2 - (width/2)
		local y = scrHeight/2 - (height/2)
		
		wRanks = guiCreateWindow(x, y, width, height, "Rutbeler & Maaşlar", false)
		guiSetEnabled(wRanks,false)
		guiWindowSetSizable(wRanks, false)
		guiWindowSetMovable(wRanks, false)
		setElementData(wRanks,"tp:element2",true)
		yy = y
		local y = 0

		for i=1, 20 do
			y = ( y or 0 ) + 23
			lRanks[i] = guiCreateLabel(0.05 * width, y + 3, 0.4 * width, 20, "Rutbe #" .. i .. " Rutbe Adi & Maas: ", false, wRanks)
			guiSetFont(lRanks[i], "default-bold-small")
			tRanks[i] = guiCreateEdit(x+0.4 * width, yy+y, ( wages and 0.33 or 0.55 ) * width, 20, arrFactionRanks[i], false, false)
			setElementData(tRanks[i],"child",true)
			if wages then
				if (exports.integration:isPlayerScripter(getLocalPlayer()) or false) then
					tRankWages[i] = guiCreateEdit(x+0.75 * width, y+yy, 0.2 * width, 20, tostring(arrFactionWages[i]), false, false)
					setElementData(tRankWages[i],"child",true)
				else
					tRankWages[i] = guiCreateEdit(x+0.75 * width, y+yy, 0.2 * width, 20, tostring(arrFactionWages[i]), false, false)
					--guiSetEnabled(tRankWages[i], false)
					setElementData(tRankWages[i],"child",true)
				end
				
			end
		end
		
		bRanksSave = guiCreateButton(x+10, yy+height-80, 530, 30, "Kaydet", false, false)
		bRanksClose = guiCreateButton(x+10, yy+height-40, 530, 30, "Kapat", false, false)
		
		setElementData(bRanksSave,"child",true)
		setElementData(bRanksClose,"child",true)
		openLibrary("convert",wRanks)
		addEventHandler("onClientGUIClick", wRanks, function()
			cancelEvent()
		end)
		addEventHandler("onClientGUIClick", bRanksSave, saveRanks, false)
		addEventHandler("onClientGUIClick", bRanksClose, closeRanks, false)
	
end

function saveRanks(button, state)
	if (source==bRanksSave) and (button=="left") and (state=="up") then
		editRankMode = false
		local found = false
		local isNumber = true
		for key, value in ipairs(tRanks) do
			if (string.find(guiGetText(tRanks[key]), ";")) or (string.find(guiGetText(tRanks[key]), "'")) then
				found = true
			end
		end
		
		local factionType = tonumber(getElementData(theTeam, "type"))
		if (factionType==2) or (factionType==3) or (factionType==4) or (factionType==5) or (factionType==6) or (factionType==7) then -- Added Mechanic type \ Adams
			for key, value in ipairs(tRankWages) do
				if not (tostring(type(tonumber(guiGetText(tRankWages[key])))) == "number") then
					isNumber = false
				end
			end
		end
		
		if (found) then
			outputChatBox("Rank isimlerinizde veya maaslarda uygunsuz characters bulundu Ornek; '@.;", 255, 0, 0)
		elseif not (isNumber) then
			outputChatBox("Lutfen sembol girmeyin.", 255, 0, 0)
		else
			local sendRanks = { }
			local sendWages = { }
			
			for key, value in ipairs(tRanks) do
				sendRanks[key] = guiGetText(tRanks[key])
			end
			
			if (factionType==2) or (factionType==3) or (factionType==4) or (factionType==5) or (factionType==6) or (factionType==7) then -- Added Mechanic type \ Adams
				for key, value in ipairs(tRankWages) do
					sendWages[key] = guiGetText(tRankWages[key])
				end
			end
			
			hideFactionMenu()
			if (factionType==2) or (factionType==3) or (factionType==4) or (factionType==5) or (factionType==6) or (factionType==7) then -- Added Mechanic type \ Adams
				triggerServerEvent("cguiUpdateRanks", getLocalPlayer(), sendRanks, sendWages)
			else
				triggerServerEvent("cguiUpdateRanks", getLocalPlayer(), sendRanks)
			end
		end
	end
end

function closeRanks(button, state)
	if (source==bRanksClose) and (button=="left") and (state=="up") then
		if (wRanks) then
			destroyElement(wRanks)
			editRankMode = false
			lRanks, tRanks, tRankWages, wRanks, bRanksSave, bRanksClose = nil, nil, nil, nil, nil, nil
			guiSetInputEnabled(false)
			for k,v in ipairs(getElementsByType("gui-edit")) do
				if getElementData(v,"child") then
					destroyElement(v)
				end
			end
			for k,v in ipairs(getElementsByType("gui-button")) do
				if getElementData(v,"child") then
					destroyElement(v)
				end
			end
		end
	end
end

function isInSlot(x, y, w, h)
	local cX, cY = getCursorPosition()
	cX, cY = cX * sx, cY * sy
	if isInBox(x, y, w, h, cX, cY) then
		return true
	else
		return false
	end
end

function isInBox(dX, dY, dSZ, dM, eX, eY)
    if(eX >= dX and eX <= dX+dSZ and eY >= dY and eY <= dY+dM) then
        return true
    else
        return false
    end
end


function checkOnay(state)
	if state then
		return "Var"
	else
		return "Yok"
	end
end
function directoryMenu(k)
	if k == 1 then
		return "file/menu_home.png"
	elseif k == 2 then
		return "file/menu_rank.png"
	elseif k == 3 then
		return "file/menu_user.png"
	elseif k == 4 then
		return "file/menu_car.png"
	elseif k == 5 then
		return "file/menu_horn.png"
	else
		return"file/menu_home.png"
	end
end
Duty = {
    gridlist = {},
    button = {},
    label = {}
}

function btDutyPanel()
	if isElement(Duty.gridlist[1]) then
		beginLoad()
		return
	end
	editRankMode = true
	
	local width, height = 640, 500
	local scrWidth, scrHeight = guiGetScreenSize()
	local x = scrWidth/2 - (width/2)
	local y = scrHeight/2 - (height/2)
	dutyWindow = tabDuty
	if isElement(dutyWindow) then return end
	dutyWindow = guiCreateWindow(x,y,width,height, "Duty Yönetimi - HWP [BETA] [Alern]", false)
	tabs = guiCreateTabPanel(0, 0.07, 1, 0.91, true, dutyWindow)
	setElementData(dutyWindow,"tp:element2",true)
	tabDuty = guiCreateTab("Ayarlar", tabs,false)
    Duty.gridlist[1] = guiCreateGridList(0.0047, 0.046, 0.3, 0.84, true, tabDuty)
    guiGridListAddColumn(Duty.gridlist[1], "ID", 0.1)
    guiGridListAddColumn(Duty.gridlist[1], "Name", 0.2)
    guiGridListAddColumn(Duty.gridlist[1], "Radius", 0.1)
    guiGridListAddColumn(Duty.gridlist[1], "Interior", 0.1)
    guiGridListAddColumn(Duty.gridlist[1], "Dimension", 0.06)
    guiGridListAddColumn(Duty.gridlist[1], "X", 0.1)
    guiGridListAddColumn(Duty.gridlist[1], "Y", 0.1)
    guiGridListAddColumn(Duty.gridlist[1], "Z", 0.1)

    Duty.button[1] = guiCreateButton(0.005, 0.919, 0.09, 0.06, "Add location", true, tabDuty)
    --guiSetProperty(Duty.button[1], "NormalTextColour", "FFAAAAAA")
    addEventHandler("onClientGUIClick", Duty.button[1], createDutyLocationMaker, false)

    Duty.label[1] = guiCreateLabel(0.0059, 0.0076, 0.2625, 0.03, "Duty Locations", true, tabDuty)
    guiLabelSetHorizontalAlign(Duty.label[1], "center", false)
    Duty.button[2] = guiCreateButton(0.1, 0.919, 0.099, 0.06, "Remove location", true, tabDuty)
    --guiSetProperty(Duty.button[2], "NormalTextColour", "FFAAAAAA")
    addEventHandler("onClientGUIClick", Duty.button[2], removeLocation, false)

    Duty.button[3] = guiCreateButton(0.205, 0.919, 0.099, 0.06, "Edit Duty Location", true, tabDuty)
    --guiSetProperty(Duty.button[3], "NormalTextColour", "FFAAAAAA")
    addEventHandler("onClientGUIClick", Duty.button[3], processLocationEdit, false)
    addEventHandler("onClientGUIDoubleClick", Duty.gridlist[1], processLocationEdit, false)

    Duty.gridlist[2] = guiCreateGridList(0.66, 0.046, 0.3, 0.84, true, tabDuty)
    guiGridListAddColumn(Duty.gridlist[2], "ID", 0.3)
    guiGridListAddColumn(Duty.gridlist[2], "Name", 0.3)
    guiGridListAddColumn(Duty.gridlist[2], "Locations", 0.3)

    Duty.label[2] = guiCreateLabel(0.68, 0.0076, 0.2636, 0.03, "Duty Perks", true, tabDuty)
    guiLabelSetHorizontalAlign(Duty.label[2], "center", false)
    Duty.button[4] = guiCreateButton(0.66, 0.919, 0.09, 0.06, "Add new duty", true, tabDuty)
    --guiSetProperty(Duty.button[4], "NormalTextColour", "FFAAAAAA")
    addEventHandler("onClientGUIClick", Duty.button[4], createDuty, false)

    Duty.button[5] = guiCreateButton(0.765, 0.919, 0.09, 0.06, "Remove Duty", true, tabDuty)
    --guiSetProperty(Duty.button[5], "NormalTextColour", "FFAAAAAA")
    addEventHandler("onClientGUIClick", Duty.button[5], removeDuty, false)

    Duty.button[6] = guiCreateButton(0.869, 0.919, 0.09, 0.06, "Edit Duty Perks", true, tabDuty)
    --guiSetProperty(Duty.button[6], "NormalTextColour", "FFAAAAAA")
    addEventHandler("onClientGUIClick", Duty.button[6], processDutyEdit, false)
    addEventHandler("onClientGUIDoubleClick", Duty.gridlist[2], processDutyEdit, false)

    Duty.gridlist[3] = guiCreateGridList(0.3355, 0.046, 0.282, 0.472, true, tabDuty)
    guiGridListAddColumn(Duty.gridlist[3], "ID", 0.1)
    guiGridListAddColumn(Duty.gridlist[3], "Vehicle ID", 0.4)
    guiGridListAddColumn(Duty.gridlist[3], "Vehicle", 0.5)

    Duty.label[3] = guiCreateLabel(0.325, 0.0076, 0.2886, 0.03, "Duty Vehicle Locations", true, tabDuty)
    guiLabelSetHorizontalAlign(Duty.label[3], "center", false)
    Duty.button[8] = guiCreateButton(0.3355, 0.5304, 0.1, 0.06, "Add Duty Vehicle", true, tabDuty)
    --guiSetProperty(Duty.button[8], "NormalTextColour", "FFAAAAAA")
    addEventHandler("onClientGUIClick", Duty.button[8], createVehicleAdd, false)

    Duty.button[9] = guiCreateButton(0.5177, 0.5304, 0.1, 0.06, "Remove Duty Vehicle", true, tabDuty)
    --guiSetProperty(Duty.button[9], "NormalTextColour", "FFAAAAAA")    
    addEventHandler("onClientGUIClick", Duty.button[9], removeVehicle, false)
	
	kapat = guiCreateButton(0.35, 0.919, 0.25, 0.06, "Kapat/Geri", true, tabDuty)
	addEventHandler("onClientGUIClick",kapat,function()
		editRankMode = false
		destroyElement(dutyWindow)
	end)

	yenile = guiCreateButton(0.35, 0.819, 0.25, 0.06, "Yenile", true, tabDuty)
	addEventHandler("onClientGUIClick",yenile,function()
		beginLoad()
	end)

    beginLoad()
end


function processLocationEdit()
	local r, c = guiGridListGetSelectedItem ( Duty.gridlist[1] )
	if r >= 0 then
		local x = guiGridListGetItemText ( Duty.gridlist[1], r, 6 )
		local y = guiGridListGetItemText ( Duty.gridlist[1], r, 7 )
		local z = guiGridListGetItemText ( Duty.gridlist[1], r, 8 )
		local rot = guiGridListGetItemText ( Duty.gridlist[1], r, 3 )
		local i = guiGridListGetItemText ( Duty.gridlist[1], r, 4 )
		local d = guiGridListGetItemText ( Duty.gridlist[1], r, 5 )
		local name = guiGridListGetItemText ( Duty.gridlist[1], r, 2 )
		locationEditID = tonumber(guiGridListGetItemText ( Duty.gridlist[1], r, 1 ))
		createDutyLocationMaker(x, y, z, rot, i, d, name)
	end
end

function processDutyEdit()
	local r, c = guiGridListGetSelectedItem ( Duty.gridlist[2] )
	if r >= 0 then
		local id = guiGridListGetItemText(Duty.gridlist[2], r, 1)
		customEditID = tonumber(id)
		createDuty()
	end
end
function beginLoad()
	guiGridListAddRow(Duty.gridlist[1])
	guiGridListSetItemText(Duty.gridlist[1], 0, 2, "Loading", false, false)

	guiGridListAddRow(Duty.gridlist[2])
	guiGridListSetItemText(Duty.gridlist[2], 0, 1, "Loading", false, false)

	guiGridListAddRow(Duty.gridlist[3])
	guiGridListSetItemText(Duty.gridlist[3], 0, 1, "Loading", false, false)

	--[[guiGridListAddRow(Duty.gridlist[4])
	guiGridListSetItemText(Duty.gridlist[4], 0, 1, "Loading", false, false)]]
	--outputChatBox(factionID1)
	triggerServerEvent("fetchDutyInfo", resourceRoot, factionID1)
end
function importData(custom, locations, factionID, message)
	if not isElement(dutyWindow) then
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
	guiGridListClear( Duty.gridlist[1] )
	guiGridListClear( Duty.gridlist[2] )
	guiGridListClear( Duty.gridlist[3] )
	for k,v in pairs(custom) do
		local row = guiGridListAddRow(Duty.gridlist[2])

		guiGridListSetItemText(Duty.gridlist[2], row, 1, tostring(v[1]), false, true)
		guiGridListSetItemText(Duty.gridlist[2], row, 2, v[2], false, false)
		t = {}
		for key, val in pairs(v[4]) do
			table.insert(t, key)
		end
		guiGridListSetItemText(Duty.gridlist[2], row, 3, table.concat(t, ", "), false, false)
		if customEditID == tonumber(v[1]) then
			forceDutyClose = false
		end
	end
	for k,v in pairs(locations) do
		if not v[10] then
			local row = guiGridListAddRow(Duty.gridlist[1])

			guiGridListSetItemText(Duty.gridlist[1], row, 1, tostring(v[1]), false, true)
			guiGridListSetItemText(Duty.gridlist[1], row, 2, tostring(v[2]), false, false)
			guiGridListSetItemText(Duty.gridlist[1], row, 3, tostring(v[6]), false, false)
			guiGridListSetItemText(Duty.gridlist[1], row, 4, tostring(v[8]), false, false)
			guiGridListSetItemText(Duty.gridlist[1], row, 5, tostring(v[7]), false, false)
			guiGridListSetItemText(Duty.gridlist[1], row, 6, tostring(v[3]), false, false)
			guiGridListSetItemText(Duty.gridlist[1], row, 7, tostring(v[4]), false, false)
			guiGridListSetItemText(Duty.gridlist[1], row, 8, tostring(v[5]), false, false)
		else
			local row = guiGridListAddRow(Duty.gridlist[3])

			guiGridListSetItemText(Duty.gridlist[3], row, 1, tostring(v[1]), false, true)
			guiGridListSetItemText(Duty.gridlist[3], row, 2, tostring(v[9]), false, true)
			guiGridListSetItemText(Duty.gridlist[3], row, 3, getVehicleNameFromModel(v[10]), false, false)
			--[[table.insert(vehlocal, tostring(v[10]), v[11])
			table.remove(locations, k)]]
		end
		if locationEditID == tonumber(v[1]) then
			forceLocationClose = false
		end
	end
	if forceLocationClose or forceDutyClose then
	--	outputChatBox(message, 255, 0, 0)
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
DutyCreate = {
    label = {},
    button = {},
    window = {},
    gridlist = {},
    edit = {}
}
function grabDetails(dutyID)
	triggerServerEvent("Duty:Grab", resourceRoot, factionID1)

	guiGridListAddRow(DutyCreate.gridlist[1])
	guiGridListSetItemText(DutyCreate.gridlist[1], 0, 2, "Loading", false, false)

	guiGridListAddRow(DutyCreate.gridlist[2])
	guiGridListSetItemText(DutyCreate.gridlist[2], 0, 2, "Loading", false, false)

	guiGridListAddRow(DutyCreate.gridlist[3])
	guiGridListSetItemText(DutyCreate.gridlist[3], 0, 1, "Loading", false, false)

	guiGridListAddRow(DutyCreate.gridlist[4])
	guiGridListSetItemText(DutyCreate.gridlist[4], 0, 1, "Loading", false, false)		
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
	guiGridListClear( DutyCreate.gridlist[1] )
	guiGridListClear( DutyCreate.gridlist[2] )
	guiGridListClear( DutyCreate.gridlist[3] )
	guiGridListClear( DutyCreate.gridlist[4] )

	if customEditID ~= 0 then
		dutyItems = customg[customEditID][5]
		for k,v in pairs(customg[customEditID][5]) do
			if tonumber(v[2]) >= 0 then -- Items
				local row = guiGridListAddRow(DutyCreate.gridlist[4])
	
				guiGridListSetItemText(DutyCreate.gridlist[4], row, 1, exports["item-system"]:getItemName(v[2]), false, false) -- Item Name
				guiGridListSetItemText(DutyCreate.gridlist[4], row, 2, tostring(v[2]), false, true) -- Item ID
				guiGridListSetItemData(DutyCreate.gridlist[4], row, 1, { v[1], tonumber(v[2]), v[3] })

				if not isItemAllowed(v[1]) then
					guiGridListSetItemColor(DutyCreate.gridlist[4], row, 1, 255, 0, 0)
					guiGridListSetItemColor(DutyCreate.gridlist[4], row, 2, 255, 0, 0)
				end
			else -- Weapons
				local row = guiGridListAddRow(DutyCreate.gridlist[3])
				if tonumber(v[2]) == -100 then
					guiGridListSetItemText(DutyCreate.gridlist[3], row, 1, "Armor", false, false) -- Weapon Name
					guiGridListSetItemText(DutyCreate.gridlist[3], row, 2, tostring(v[3]), false, false) -- Ammo
					guiGridListSetItemData(DutyCreate.gridlist[3], row, 2, { v[1], tonumber(v[2]), v[3], v[4] })
				else
					guiGridListSetItemText(DutyCreate.gridlist[3], row, 1, exports["item-system"]:getItemName(v[2]), false, false) -- Weapon Name
					guiGridListSetItemText(DutyCreate.gridlist[3], row, 2, tostring(v[3]), false, false) -- Ammo
					guiGridListSetItemData(DutyCreate.gridlist[3], row, 2, { v[1], tonumber(v[2]), v[3], v[4] })
				end

				if not isItemAllowed(v[1]) then
					guiGridListSetItemColor(DutyCreate.gridlist[3], row, 1, 255, 0, 0)
					guiGridListSetItemColor(DutyCreate.gridlist[3], row, 2, 255, 0, 0)
				end
			end
		end
		guiSetText(DutyCreate.edit[3], customg[customEditID][2])
	end

	for k,v in pairs(allowList) do
		if tonumber(v[2]) >= 0 then -- Items
			if customEditID == 0 or (customEditID ~= 0 and not customg[customEditID][5][tostring(v[1])]) then
				local row = guiGridListAddRow(DutyCreate.gridlist[2])

				guiGridListSetItemText(DutyCreate.gridlist[2], row, 1, exports["item-system"]:getItemName(v[2]), false, false)
				guiGridListSetItemText(DutyCreate.gridlist[2], row, 2, exports["item-system"]:getItemDescription(v[2], v[3]), false, false)
				guiGridListSetItemData(DutyCreate.gridlist[2], row, 1, { v[1], tonumber(v[2]), v[3] })
			end
		else -- Weapons
			if customEditID == 0 or (customEditID ~= 0 and not customg[customEditID][5][tostring(v[1])]) then
				local row = guiGridListAddRow(DutyCreate.gridlist[1])
				if tonumber(v[2]) == -100 then
					guiGridListSetItemText(DutyCreate.gridlist[1], row, 1, "Armor", false, false)
					guiGridListSetItemText(DutyCreate.gridlist[1], row, 2, v[3], false, false)
					guiGridListSetItemData(DutyCreate.gridlist[1], row, 1, { v[1], tonumber(v[2]), v[3] })
				else
					guiGridListSetItemText(DutyCreate.gridlist[1], row, 1, exports["item-system"]:getItemName(v[2]), false, false)
					guiGridListSetItemText(DutyCreate.gridlist[1], row, 2, v[3], false, false)
					guiGridListSetItemData(DutyCreate.gridlist[1], row, 1, { v[1], tonumber(v[2]), v[3] })
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
			local row = guiGridListAddRow(DutyLocations.gridlist[1])

			guiGridListSetItemText(DutyLocations.gridlist[1], row, 1, tostring(v[1]), false, true)
			guiGridListSetItemText(DutyLocations.gridlist[1], row, 2, tostring(v[2]), false, false)
		end
	end

	for k,v in pairs(tempLocations) do
		local row = guiGridListAddRow(DutyLocations.gridlist[2])

		guiGridListSetItemText(DutyLocations.gridlist[2], row, 1, tostring(k), false, true)
		guiGridListSetItemText(DutyLocations.gridlist[2], row, 2, tostring(v), false, false)
	end
end

function populateSkins()
	if customEditID == 0 then
		dutyNewSkins = getElementData(getLocalPlayer(), "savedSkins") or {}
	else
		dutyNewSkins = getElementData(getLocalPlayer(), "savedSkins") or customg[customEditID][3]
	end

	for k,v in pairs(dutyNewSkins) do
		local row = guiGridListAddRow(DutySkins.gridlist[1])

		guiGridListSetItemText(DutySkins.gridlist[1], row, 1, tostring(v[1]), false, false)
		guiGridListSetItemText(DutySkins.gridlist[1], row, 2, tostring(v[2]), false, false)
	end
end

function checkAmmo()
	local r, c = guiGridListGetSelectedItem( DutyCreate.gridlist[1] )
	if r >= 0 then
		if tonumber(guiGetText(DutyCreate.edit[2])) then
			if tonumber(guiGridListGetItemText(DutyCreate.gridlist[1], r, 2)) >= tonumber(guiGetText( DutyCreate.edit[2] )) then
				guiLabelSetColor(DutyCreate.label[2], 0, 255, 0)
				guiSetText(DutyCreate.label[2], "Valid")
				guiSetEnabled(DutyCreate.button[3], true)
				return
			end
		end
	end
	guiLabelSetColor(DutyCreate.label[2], 255, 0, 0)
	guiSetText(DutyCreate.label[2], "Invalid")
	guiSetEnabled(DutyCreate.button[3], false)
end

function addDutyItem()
   	local r, c = guiGridListGetSelectedItem ( DutyCreate.gridlist[2] )
	if r >= 0 then
		local info = guiGridListGetItemData( DutyCreate.gridlist[2], r, 1 )
		local row = guiGridListAddRow(DutyCreate.gridlist[4])

		guiGridListSetItemText(DutyCreate.gridlist[4], row, 1, exports["item-system"]:getItemName(info[2]), false, false) -- Item Name
		guiGridListSetItemText(DutyCreate.gridlist[4], row, 2, tostring(info[2]), false, false) -- Item ID
		guiGridListSetItemData( DutyCreate.gridlist[4], row, 1, info )

		dutyItems[tostring(info[1])] = { info[1], tonumber(info[2]), info[3] }
		guiGridListRemoveRow( DutyCreate.gridlist[2], r )
	end
end

function removeDutyWeapon()
   	local r, c = guiGridListGetSelectedItem ( DutyCreate.gridlist[3] )
	if r >= 0 then
		local info = guiGridListGetItemData(DutyCreate.gridlist[3], r, 2)
		local red, g, b = guiGridListGetItemColor(DutyCreate.gridlist[3], r, 1)
		dutyItems[tostring(info[1])] = nil
		guiGridListRemoveRow( DutyCreate.gridlist[3], r)
		if red == 255 and g ~= 0 and b ~= 0 then
			local row = guiGridListAddRow(DutyCreate.gridlist[1])
			if tonumber(info[1]) == -100 then
				guiGridListSetItemText(DutyCreate.gridlist[1], row, 1, "Armor", false, false)
				guiGridListSetItemText(DutyCreate.gridlist[1], row, 2, tostring(info[4]), false, false)
				guiGridListSetItemData(DutyCreate.gridlist[1], row, 1, info)
			else
				guiGridListSetItemText(DutyCreate.gridlist[1], row, 1, exports["item-system"]:getItemName(info[2]), false, false)
				guiGridListSetItemText(DutyCreate.gridlist[1], row, 2, tostring(info[4]), false, false)
				guiGridListSetItemData(DutyCreate.gridlist[1], row, 1, info)
			end
		end
	end
end

function removeDutyItem()
   	local r, c = guiGridListGetSelectedItem ( DutyCreate.gridlist[4] )
	if r >= 0 then
		local info = guiGridListGetItemData(DutyCreate.gridlist[4], r, 1)
		local red, g, b = guiGridListGetItemColor(DutyCreate.gridlist[4], r, 1)
		dutyItems[tostring(info[1])] = nil
		guiGridListRemoveRow(DutyCreate.gridlist[4], r)
		if red == 255 and g ~= 0 and b ~= 0 then
			local row = guiGridListAddRow(DutyCreate.gridlist[2])

			guiGridListSetItemText(DutyCreate.gridlist[2], row, 1, exports["item-system"]:getItemName(tonumber(info[2])), false, false)
			guiGridListSetItemText(DutyCreate.gridlist[2], row, 2, exports["item-system"]:getItemDescription(tonumber(info[2]), info[3]), false, false)
			guiGridListSetItemData(DutyCreate.gridlist[2], row, 1, info)
		end
	end
end

function createDuty()
	if isElement(DutyCreate.window[1]) then
		destroyElement(DutyCreate.window[1])
		dutyItems = nil
	end

    DutyCreate.window[1] = guiCreateWindow(470, 310, 768, 566, "Duty Editing Window - Main", false)
    guiWindowSetSizable(DutyCreate.window[1], false)
    centerWindow(DutyCreate.window[1])

    DutyCreate.button[1] = guiCreateButton(600, 512, 158, 44, "Cancel", false, DutyCreate.window[1])
    --guiSetProperty(DutyCreate.button[1], "NormalTextColour", "FFAAAAAA")
    addEventHandler("onClientGUIClick", DutyCreate.button[1], closeTheGUI, false)

    DutyCreate.button[2] = guiCreateButton(454, 512, 138, 44, "Save", false, DutyCreate.window[1])
    --guiSetProperty(DutyCreate.button[2], "NormalTextColour", "FFAAAAAA")
    addEventHandler("onClientGUIClick", DutyCreate.button[2], saveGUI, false)

    DutyCreate.gridlist[1] = guiCreateGridList(11, 34, 427, 192, false, DutyCreate.window[1])
    --guiGridListAddColumn(DutyCreate.gridlist[1], "ID", 0.1)
    guiGridListAddColumn(DutyCreate.gridlist[1], "Weapon Name", 0.5)
    guiGridListAddColumn(DutyCreate.gridlist[1], "Max Amount of Ammo", 0.5)

    DutyCreate.gridlist[2] = guiCreateGridList(12, 247, 426, 208, false, DutyCreate.window[1])
   --guiGridListAddColumn(DutyCreate.gridlist[2], "ID", 0.1)
    guiGridListAddColumn(DutyCreate.gridlist[2], "Item Name", 0.3)
    guiGridListAddColumn(DutyCreate.gridlist[2], "Description", 0.7)

    DutyCreate.button[3] = guiCreateButton(444, 34, 128, 41, "-->", false, DutyCreate.window[1])
    --guiSetProperty(DutyCreate.button[3], "NormalTextColour", "FFAAAAAA")
    addEventHandler("onClientGUIClick", DutyCreate.gridlist[1], checkAmmo)
    addEventHandler("onClientGUIClick", DutyCreate.button[3], function()
    	 -- Add Duty Weapon
    	local r, c = guiGridListGetSelectedItem ( DutyCreate.gridlist[1] )
		if r >= 0 then
			local maxammo = guiGridListGetItemText( DutyCreate.gridlist[1], r, 2 )
			local info = guiGridListGetItemData( DutyCreate.gridlist[1], r, 1 )
			local ammo = guiGetText( DutyCreate.edit[2] )

			local row = guiGridListAddRow(DutyCreate.gridlist[3])
			if tonumber(info[2]) == -100 then
				guiGridListSetItemText(DutyCreate.gridlist[3], row, 1, "Armor", false, false) -- Weapon Name
				guiGridListSetItemData(DutyCreate.gridlist[3], row, 2, info)
				guiGridListSetItemText(DutyCreate.gridlist[3], row, 2, ammo, false, false) -- Ammo
			else
				guiGridListSetItemText(DutyCreate.gridlist[3], row, 1, exports["item-system"]:getItemName(tonumber(info[2])), false, false) -- Weapon Name
				guiGridListSetItemData(DutyCreate.gridlist[3], row, 2, info)
				guiGridListSetItemText(DutyCreate.gridlist[3], row, 2, ammo, false, false) -- Ammo
			end

			dutyItems[tostring(info[1])] = { info[1], tonumber(info[2]), tonumber(ammo), info[3] }

			guiGridListRemoveRow( DutyCreate.gridlist[1], r )
		end
    end, false)
    DutyCreate.button[4] = guiCreateButton(444, 249, 128, 41, "-->", false, DutyCreate.window[1])
    --guiSetProperty(DutyCreate.button[4], "NormalTextColour", "FFAAAAAA")
    addEventHandler("onClientGUIClick", DutyCreate.button[4], addDutyItem, false) -- Add Duty Item
    addEventHandler("onClientGUIDoubleClick", DutyCreate.gridlist[2], addDutyItem, false)
    
    DutyCreate.gridlist[3] = guiCreateGridList(582, 34, 176, 192, false, DutyCreate.window[1])
    guiGridListAddColumn(DutyCreate.gridlist[3], "Weapon", 0.5)
    guiGridListAddColumn(DutyCreate.gridlist[3], "Ammo", 0.3)

    --[[DutyCreate.edit[1] = guiCreateEdit(445, 298, 127, 27, "Item Value", false, DutyCreate.window[1])
    DutyCreate.label[1] = guiCreateLabel(444, 325, 128, 89, "Invalid", false, DutyCreate.window[1])
    guiLabelSetColor(DutyCreate.label[1], 255, 0, 0)
    guiLabelSetHorizontalAlign(DutyCreate.label[1], "center", false)]]
    DutyCreate.edit[2] = guiCreateEdit(445, 81, 127, 27, "Amount of Ammo", false, DutyCreate.window[1])
    DutyCreate.label[2] = guiCreateLabel(444, 108, 128, 77, "Invalid", false, DutyCreate.window[1])
    guiLabelSetColor(DutyCreate.label[2], 255, 0, 0)
    addEventHandler("onClientGUIChanged", DutyCreate.edit[2], checkAmmo)

    DutyCreate.gridlist[4] = guiCreateGridList(582, 248, 176, 207, false, DutyCreate.window[1])
    guiGridListAddColumn(DutyCreate.gridlist[4], "Item", 0.5)
    guiGridListAddColumn(DutyCreate.gridlist[4], "ID", 0.3)
    guiLabelSetHorizontalAlign(DutyCreate.label[2], "center", false)

    DutyCreate.button[5] = guiCreateButton(444, 185, 128, 41, "<---", false, DutyCreate.window[1])
    --guiSetProperty(DutyCreate.button[5], "NormalTextColour", "FFAAAAAA")
    addEventHandler("onClientGUIClick", DutyCreate.button[5], removeDutyWeapon, false)
    addEventHandler("onClientGUIDoubleClick", DutyCreate.gridlist[3], removeDutyWeapon, false)
    DutyCreate.button[6] = guiCreateButton(444, 414, 128, 41, "<--", false, DutyCreate.window[1])
    --guiSetProperty(DutyCreate.button[6], "NormalTextColour", "FFAAAAAA")
    addEventHandler("onClientGUIClick", DutyCreate.button[6], removeDutyItem, false)
    addEventHandler("onClientGUIDoubleClick", DutyCreate.gridlist[4], removeDutyItem, false)
    DutyCreate.button[7] = guiCreateButton(12, 511, 138, 45, "Skins", false, DutyCreate.window[1])
    --guiSetProperty(DutyCreate.button[7], "NormalTextColour", "FFAAAAAA")
    addEventHandler("onClientGUIClick", DutyCreate.button[7], createSkins, false)

    DutyCreate.button[8] = guiCreateButton(160, 512, 138, 44, "Locations", false, DutyCreate.window[1])
    --guiSetProperty(DutyCreate.button[8], "NormalTextColour", "FFAAAAAA")
    addEventHandler("onClientGUIClick", DutyCreate.button[8], createLocations, false)

    DutyCreate.label[3] = guiCreateLabel(57, 19, 319, 15, "Available Weapons", false, DutyCreate.window[1])
    guiLabelSetHorizontalAlign(DutyCreate.label[3], "center", false)
    DutyCreate.label[4] = guiCreateLabel(582, 17, 176, 17, "Duty Weapons", false, DutyCreate.window[1])
    guiLabelSetHorizontalAlign(DutyCreate.label[4], "center", false)
    DutyCreate.label[5] = guiCreateLabel(57, 228, 319, 15, "Available Items", false, DutyCreate.window[1])
    guiLabelSetHorizontalAlign(DutyCreate.label[5], "center", false)
    DutyCreate.label[6] = guiCreateLabel(583, 227, 175, 21, "Duty Items", false, DutyCreate.window[1])
    guiLabelSetHorizontalAlign(DutyCreate.label[6], "center", false)
    DutyCreate.label[7] = guiCreateLabel(14, 463, 88, 32, "Duty Name:", false, DutyCreate.window[1])
    guiLabelSetVerticalAlign(DutyCreate.label[7], "center")
    DutyCreate.edit[3] = guiCreateEdit(83, 462, 240, 33, "", false, DutyCreate.window[1])    

	guiSetEnabled(DutyCreate.button[3], false)
    grabDetails()
end


DutyLocations = {
    gridlist = {},
    window = {},
    button = {},
    label = {}
}

function addLocationToDuty()
   	local r, c = guiGridListGetSelectedItem ( DutyLocations.gridlist[1] )
	if r >= 0 then
		local id = guiGridListGetItemText(DutyLocations.gridlist[1], r, 1)
		local name = guiGridListGetItemText(DutyLocations.gridlist[1], r, 2)

		guiGridListRemoveRow(DutyLocations.gridlist[1], r)
		local row = guiGridListAddRow(DutyLocations.gridlist[2])

		guiGridListSetItemText(DutyLocations.gridlist[2], row, 1, tostring(id), false, true)
		guiGridListSetItemText(DutyLocations.gridlist[2], row, 2, tostring(name), false, false)
		tempLocations[id] = name
	end
end

function removeLocationFromDuty()
   	local r, c = guiGridListGetSelectedItem ( DutyLocations.gridlist[2] )
	if r >= 0 then
		local id = guiGridListGetItemText(DutyLocations.gridlist[2], r, 1)
		local name = guiGridListGetItemText(DutyLocations.gridlist[2], r, 2)

		guiGridListRemoveRow(DutyLocations.gridlist[2], r)
		local row = guiGridListAddRow(DutyLocations.gridlist[1])

		guiGridListSetItemText(DutyLocations.gridlist[1], row, 1, tostring(id), false, true)
		guiGridListSetItemText(DutyLocations.gridlist[1], row, 2, tostring(name), false, false)
		tempLocations[id] = nil
	end
end

function createLocations()
	if isElement(DutyLocations.window[1]) then
		destroyElement(DutyLocations.window[1])
		tempLocations = nil
	end
    DutyLocations.window[1] = guiCreateWindow(573, 285, 520, 423, "Duty Editing Window - Locations", false)
    guiWindowSetSizable(DutyLocations.window[1], false)
    centerWindow(DutyLocations.window[1])

    DutyLocations.gridlist[1] = guiCreateGridList(9, 36, 240, 297, false, DutyLocations.window[1])
    guiGridListAddColumn(DutyLocations.gridlist[1], "ID", 0.2)
    guiGridListAddColumn(DutyLocations.gridlist[1], "Name", 0.9)

    DutyLocations.gridlist[2] = guiCreateGridList(270, 36, 240, 297, false, DutyLocations.window[1])
    guiGridListAddColumn(DutyLocations.gridlist[2], "ID", 0.2)
    guiGridListAddColumn(DutyLocations.gridlist[2], "Name", 0.9)

    DutyLocations.button[1] = guiCreateButton(9, 332, 240, 27, "-->", false, DutyLocations.window[1])
    --guiSetProperty(DutyLocations.button[1], "NormalTextColour", "FFAAAAAA")
    addEventHandler("onClientGUIClick", DutyLocations.button[1], addLocationToDuty, false)
    addEventHandler("onClientGUIDoubleClick", DutyLocations.gridlist[1], addLocationToDuty, false)
    DutyLocations.button[2] = guiCreateButton(270, 332, 240, 27, "<--", false, DutyLocations.window[1])
    --guiSetProperty(DutyLocations.button[2], "NormalTextColour", "FFAAAAAA")
    addEventHandler("onClientGUIClick", DutyLocations.button[2], removeLocationFromDuty, false)
    addEventHandler("onClientGUIDoubleClick", DutyLocations.gridlist[2], removeLocationFromDuty, false)
    DutyLocations.label[1] = guiCreateLabel(10, 19, 233, 17, "All locations", false, DutyLocations.window[1])
    guiLabelSetHorizontalAlign(DutyLocations.label[1], "center", false)
    DutyLocations.label[2] = guiCreateLabel(270, 19, 233, 17, "Duty locations", false, DutyLocations.window[1])
    guiLabelSetHorizontalAlign(DutyLocations.label[2], "center", false)
    DutyLocations.button[3] = guiCreateButton(270, 367, 146, 36, "Save", false, DutyLocations.window[1])
    --guiSetProperty(DutyLocations.button[3], "NormalTextColour", "FFAAAAAA")
    addEventHandler("onClientGUIClick", DutyLocations.button[3], saveGUI, false)

    DutyLocations.button[4] = guiCreateButton(103, 367, 146, 36, "Cancel", false, DutyLocations.window[1])
    --guiSetProperty(DutyLocations.button[4], "NormalTextColour", "FFAAAAAA")   
    addEventHandler("onClientGUIClick", DutyLocations.button[4], closeTheGUI, false) 

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
	local raw = guiGetText(DutySkins.edit[1])
	if string.find(raw, ":") then
		local howAboutIt = split(raw, ":")
		if tonumber(howAboutIt[1]) and tonumber(howAboutIt[2]) then
			if not skinAlreadyExists(tonumber(howAboutIt[1]), tonumber(howAboutIt[2])) then
				table.insert(dutyNewSkins, { howAboutIt[1], howAboutIt[2] })
				local row = guiGridListAddRow(DutySkins.gridlist[1])

				guiGridListSetItemText(DutySkins.gridlist[1], row, 1, tostring(howAboutIt[1]), false, false)
				guiGridListSetItemText(DutySkins.gridlist[1], row, 2, tostring(howAboutIt[2]), false, false)
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
				local row = guiGridListAddRow(DutySkins.gridlist[1])

				guiGridListSetItemText(DutySkins.gridlist[1], row, 1, tostring(raw), false, false)
				guiGridListSetItemText(DutySkins.gridlist[1], row, 2, "N/A", false, false)
			else
				outputChatBox("You cannot add the same skin twice.", 255, 0, 0)
			end
		else
			outputChatBox("Please use only numbers.", 255, 0, 0)
		end
	end
	guiSetText(DutySkins.edit[1], "")
end

function removeSkin()
   	local r, c = guiGridListGetSelectedItem ( DutySkins.gridlist[1] )
	if r >= 0 then
		local skin = guiGridListGetItemText(DutySkins.gridlist[1], r, 1)
		local dupont = guiGridListGetItemText(DutySkins.gridlist[1], r, 2) -- ew dupont!

		for k,v in pairs(dutyNewSkins) do
			if tonumber(v[1]) == tonumber(skin) and tostring(v[2]) == dupont then
				table.remove(dutyNewSkins, k)
				break
			end
		end

		guiGridListRemoveRow(DutySkins.gridlist[1], r)
	end
end

function createSkins()
	if isElement(DutySkins.window[1]) then
		destroyElement(DutySkins.window[1])
		dutyNewSkins = nil
	end
    DutySkins.window[1] = guiCreateWindow(697, 240, 294, 425, "", false)
    guiWindowSetSizable(DutySkins.window[1], false)
    centerWindow(DutySkins.window[1])

    DutySkins.gridlist[1] = guiCreateGridList(9, 36, 275, 275, false, DutySkins.window[1])
    guiGridListAddColumn(DutySkins.gridlist[1], "SkinID", 0.5)
    guiGridListAddColumn(DutySkins.gridlist[1], "DupontID", 0.5)
    DutySkins.label[1] = guiCreateLabel(12, 18, 272, 18, "Duty Skins", false, DutySkins.window[1])
    guiLabelSetHorizontalAlign(DutySkins.label[1], "center", false)
    DutySkins.edit[1] = guiCreateEdit(11, 313, 139, 29, "", false, DutySkins.window[1])
    DutySkins.button[1] = guiCreateButton(152, 313, 53, 29, "Add", false, DutySkins.window[1])
    --guiSetProperty(DutySkins.button[1], "NormalTextColour", "FFAAAAAA")
    addEventHandler("onClientGUIClick", DutySkins.button[1], addSkin, false)
    DutySkins.button[2] = guiCreateButton(231, 313, 53, 29, "Remove", false, DutySkins.window[1])
    --guiSetProperty(DutySkins.button[2], "NormalTextColour", "FFAAAAAA")
    addEventHandler("onClientGUIClick", DutySkins.button[2], removeSkin, false)
    addEventHandler("onClientGUIDoubleClick", DutySkins.gridlist[1], removeSkin, false)
    DutySkins.label[2] = guiCreateLabel(11, 345, 273, 29, "Use format: SkinID:DupontID\nExample: 121:622 or 130 for just a SkinID.", false, DutySkins.window[1])
    guiLabelSetHorizontalAlign(DutySkins.label[2], "center", false)
    DutySkins.button[3] = guiCreateButton(9, 381, 99, 34, "Cancel", false, DutySkins.window[1])
    --guiSetProperty(DutySkins.button[3], "NormalTextColour", "FFAAAAAA")
    addEventHandler("onClientGUIClick", DutySkins.button[3], closeTheGUI, false)

    DutySkins.button[4] = guiCreateButton(185, 381, 99, 34, "Save", false, DutySkins.window[1])
    --guiSetProperty(DutySkins.button[4], "NormalTextColour", "FFAAAAAA")    
    addEventHandler("onClientGUIClick", DutySkins.button[4], saveGUI, false)

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
    DutyVehicleAdd.window[1] = guiCreateWindow(685, 338, 335, 85, "Add new duty vehicle", false)
    guiWindowSetSizable(DutyVehicleAdd.window[1], false)
    centerWindow(DutyVehicleAdd.window[1])

    DutyVehicleAdd.edit[1] = guiCreateEdit(9, 26, 181, 40, "Vehicle ID", false, DutyVehicleAdd.window[1])
    DutyVehicleAdd.button[1] = guiCreateButton(192, 26, 62, 40, "Add", false, DutyVehicleAdd.window[1])
    --guiSetProperty(DutyVehicleAdd.button[1], "NormalTextColour", "FFAAAAAA")
    addEventHandler("onClientGUIClick", DutyVehicleAdd.button[1], saveGUI, false)

    DutyVehicleAdd.button[2] = guiCreateButton(263, 26, 62, 40, "Close", false, DutyVehicleAdd.window[1])
    --guiSetProperty(DutyVehicleAdd.button[2], "NormalTextColour", "FFAAAAAA")   
    addEventHandler( "onClientGUIClick", DutyVehicleAdd.button[2], closeTheGUI, false ) 
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
    DutyLocationMaker.window[1] = guiCreateWindow(638, 285, 488, 198, "Add duty location", false)
    guiWindowSetSizable(DutyLocationMaker.window[1], false)
    centerWindow(DutyLocationMaker.window[1])

    DutyLocationMaker.label[1] = guiCreateLabel(8, 24, 44, 19, "X Value:", false, DutyLocationMaker.window[1])
    DutyLocationMaker.edit[1] = guiCreateEdit(56, 24, 135, 20, "", false, DutyLocationMaker.window[1])
    DutyLocationMaker.label[2] = guiCreateLabel(201, 24, 53, 19, "Y Value:", false, DutyLocationMaker.window[1])
    DutyLocationMaker.edit[2] = guiCreateEdit(253, 23, 88, 20, "", false, DutyLocationMaker.window[1])
    DutyLocationMaker.label[3] = guiCreateLabel(355, 25, 52, 18, "Z Value:", false, DutyLocationMaker.window[1])
    DutyLocationMaker.edit[3] = guiCreateEdit(406, 23, 71, 20, "", false, DutyLocationMaker.window[1])
    DutyLocationMaker.label[4] = guiCreateLabel(8, 60, 49, 18, "Radius:", false, DutyLocationMaker.window[1])
    DutyLocationMaker.edit[4] = guiCreateEdit(53, 58, 82, 20, "1-10", false, DutyLocationMaker.window[1])
    DutyLocationMaker.label[5] = guiCreateLabel(162, 61, 72, 17, "Interior:", false, DutyLocationMaker.window[1])
    DutyLocationMaker.edit[5] = guiCreateEdit(216, 58, 93, 20, "", false, DutyLocationMaker.window[1])
    DutyLocationMaker.label[6] = guiCreateLabel(336, 60, 60, 18, "Dimension:", false, DutyLocationMaker.window[1])
    DutyLocationMaker.edit[6] = guiCreateEdit(402, 58, 75, 20, "", false, DutyLocationMaker.window[1])
    DutyLocationMaker.label[7] = guiCreateLabel(9, 92, 57, 21, "Name:", false, DutyLocationMaker.window[1])
    DutyLocationMaker.label[8] = guiCreateLabel(10, 119, 467, 28, "The name of the duty is used strictly for your identification.", false, DutyLocationMaker.window[1])
    guiLabelSetHorizontalAlign(DutyLocationMaker.label[8], "center", false)
    DutyLocationMaker.edit[7] = guiCreateEdit(51, 91, 426, 22, "", false, DutyLocationMaker.window[1])
    DutyLocationMaker.button[1] = guiCreateButton(10, 149, 115, 37, "Insert Current Position", false, DutyLocationMaker.window[1])
    --guiSetProperty(DutyLocationMaker.button[1], "NormalTextColour", "FFAAAAAA")
    addEventHandler("onClientGUIClick", DutyLocationMaker.button[1], curPos, false)

    DutyLocationMaker.button[2] = guiCreateButton(184, 149, 115, 37, "Close", false, DutyLocationMaker.window[1])
    --guiSetProperty(DutyLocationMaker.button[2], "NormalTextColour", "FFAAAAAA")
    addEventHandler("onClientGUIClick", DutyLocationMaker.button[2], closeTheGUI, false)

    DutyLocationMaker.button[3] = guiCreateButton(357, 149, 115, 37, "Save", false, DutyLocationMaker.window[1])
    --guiSetProperty(DutyLocationMaker.button[3], "NormalTextColour", "FFAAAAAA") 
    addEventHandler("onClientGUIClick", DutyLocationMaker.button[3], saveGUI, false)

    -- Populate List
    if name then
    	guiSetText(DutyLocationMaker.edit[1], x)
		guiSetText(DutyLocationMaker.edit[2], y)
		guiSetText(DutyLocationMaker.edit[3], z)
		guiSetText(DutyLocationMaker.edit[4], r)
		guiSetText(DutyLocationMaker.edit[5], i)
		guiSetText(DutyLocationMaker.edit[6], d)
		guiSetText(DutyLocationMaker.edit[7], name)
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
		local name = guiGetText(DutyCreate.edit[3])
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
		local id = guiGetText(DutyVehicleAdd.edit[1])
		if not duplicateVeh("location", id, factionIDg) then
			triggerServerEvent("Duty:AddVehicle", resourceRoot, tonumber(id), factionIDg)
			destroyElement(DutyVehicleAdd.window[1])
		else
			outputChatBox("This vehicle is already added.", 255, 0, 0)
		end
	elseif source == DutyLocationMaker.button[3] then -- Location Maker
		local x = tonumber(guiGetText(DutyLocationMaker.edit[1]))
		local y = tonumber(guiGetText(DutyLocationMaker.edit[2]))
		local z = tonumber(guiGetText(DutyLocationMaker.edit[3]))
		local r = tonumber(guiGetText(DutyLocationMaker.edit[4]))
		local i = tonumber(guiGetText(DutyLocationMaker.edit[5]))
		local d = tonumber(guiGetText(DutyLocationMaker.edit[6]))
		local name = guiGetText(DutyLocationMaker.edit[7])
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
	return guiSetText(DutyLocationMaker.edit[1], x), guiSetText(DutyLocationMaker.edit[2], y), guiSetText(DutyLocationMaker.edit[3], z), guiSetText(DutyLocationMaker.edit[5], int), guiSetText(DutyLocationMaker.edit[6], dim)
end

function removeLocation()
	local r, c = guiGridListGetSelectedItem ( Duty.gridlist[1] )
	if r >= 0 then
		local removeid = guiGridListGetItemText ( Duty.gridlist[1], r, 1 )
		triggerServerEvent("Duty:RemoveLocation", resourceRoot, removeid, factionIDg)
		locationsg[tonumber(removeid)] = nil
		refreshUI()
	end
end

function removeDuty()
	local r, c = guiGridListGetSelectedItem ( Duty.gridlist[2] )
	if r >= 0 then
		local removeid = guiGridListGetItemText ( Duty.gridlist[2], r, 1 )
		triggerServerEvent("Duty:RemoveDuty", resourceRoot, removeid, factionIDg)
		customg[tonumber(removeid)] = nil
		refreshUI()
	end
end

function refreshUI()
	guiGridListClear( Duty.gridlist[1] )
	guiGridListClear( Duty.gridlist[2] )
	guiGridListClear( Duty.gridlist[3] )
	for k,v in pairs(customg) do
		local row = guiGridListAddRow(Duty.gridlist[2])

		guiGridListSetItemText(Duty.gridlist[2], row, 1, tostring(v[1]), false, true)
		guiGridListSetItemText(Duty.gridlist[2], row, 2, v[2], false, false)
		t = {}
		for key, val in pairs(v[4]) do
			table.insert(t, key)
		end
		guiGridListSetItemText(Duty.gridlist[2], row, 3, table.concat(t, ", "), false, false)
	end
	for k,v in pairs(locationsg) do
		if not v[10] then
			local row = guiGridListAddRow(Duty.gridlist[1])

			guiGridListSetItemText(Duty.gridlist[1], row, 1, tostring(v[1]), false, true)
			guiGridListSetItemText(Duty.gridlist[1], row, 2, v[2], false, false)
			guiGridListSetItemText(Duty.gridlist[1], row, 3, v[6], false, false)
			guiGridListSetItemText(Duty.gridlist[1], row, 4, v[8], false, false)
			guiGridListSetItemText(Duty.gridlist[1], row, 5, v[7], false, false)
			guiGridListSetItemText(Duty.gridlist[1], row, 6, v[3], false, false)
			guiGridListSetItemText(Duty.gridlist[1], row, 7, v[4], false, false)
			guiGridListSetItemText(Duty.gridlist[1], row, 8, v[5], false, false)
		else
			local row = guiGridListAddRow(Duty.gridlist[3])

			guiGridListSetItemText(Duty.gridlist[3], row, 1, tostring(v[1]), false, true)
			guiGridListSetItemText(Duty.gridlist[3], row, 2, tostring(v[9]), false, true)
			guiGridListSetItemText(Duty.gridlist[3], row, 3, getVehicleNameFromModel(v[10]), false, false)
			--[[table.insert(vehlocal, tostring(v[10]), v[11])
			table.remove(locations, k)]]
		end
	end
end

function removeVehicle()
	local r, c = guiGridListGetSelectedItem ( Duty.gridlist[3] )
	if r >= 0 then
		local removeid = guiGridListGetItemText ( Duty.gridlist[3], r, 1 )
		triggerServerEvent("Duty:RemoveLocation", resourceRoot, removeid, factionIDg)
		locationsg[tonumber(removeid)] = nil
		refreshUI()
	end
end

function btFinancePanel()
	editRankMode = true
	
	local width, height = 600, 400
	local scrWidth, scrHeight = guiGetScreenSize()
	local x = scrWidth/2 - (width/2)
	local y = scrHeight/2 - (height/2)

	if isElement(tabFinance) then return end
	tabFinance = guiCreateWindow(x,y,width,height, "Finans Yönetimi - HWP [BETA] [Alern]", false)

		--tabs = guiCreateTabPanel(0, 0.07, 1, 0.91, true, financeWindow)
	setElementData(tabFinance,"tp:element2",true)
	--tabFinance = guiCreateTab("Ayarlar", tabs,false)

	triggerServerEvent("factionmenu:getFinance", getResourceRootElement())
	

end

function fillFinance(factionID, bankThisWeek, bankPrevWeek, bankmoney, vehiclesvalue, propertiesvalue)
	financeLoaded = true
	for k,v in ipairs(getElementChildren(tabFinance)) do
		destroyElement(v)
	end

	local financeTabs = guiCreateTabPanel(10, 20, 600, 345, false, tabFinance)


	tabWeeklyStatement = guiCreateTab("Weekly Statement", financeTabs,true)
	
		weeklyStatementGridlist = guiCreateGridList(13, 11, 395, 298, false, tabWeeklyStatement)
		statementColText = guiGridListAddColumn(weeklyStatementGridlist, "", 0.4)
		statementColLast = guiGridListAddColumn(weeklyStatementGridlist, "Last week", 0.25)
		statementColThis = guiGridListAddColumn(weeklyStatementGridlist, "This week", 0.25)

		assetsGridlist = guiCreateGridList(639, 11, 395, 298, false, tabWeeklyStatement)
		guiGridListAddColumn(assetsGridlist, "Assets", 0.65)
		guiGridListAddColumn(assetsGridlist, "Value", 0.25)

		local row = guiGridListAddRow(assetsGridlist)
		guiGridListSetItemText(assetsGridlist, row, 1, "Bank Account", false, false)
		if not bankmoney then bankmoney = 0 end
		guiGridListSetItemText(assetsGridlist, row, 2, "$"..tostring(exports.global:formatMoney(bankmoney)), false, false)
		local row = guiGridListAddRow(assetsGridlist)
		guiGridListSetItemText(assetsGridlist, row, 1, "Vehicles", false, false)
		if not vehiclesvalue then vehiclesvalue = 0 end
		guiGridListSetItemText(assetsGridlist, row, 2, "$"..tostring(exports.global:formatMoney(vehiclesvalue)), false, false)
		local row = guiGridListAddRow(assetsGridlist)
		guiGridListSetItemText(assetsGridlist, row, 1, "Properties", false, false)
		if not propertiesvalue then propertiesvalue = 0 end
		guiGridListSetItemText(assetsGridlist, row, 2, "$"..tostring(exports.global:formatMoney(propertiesvalue)), false, false)

		local row = guiGridListAddRow(assetsGridlist)
		guiGridListSetItemText(assetsGridlist, row, 1, "TOTAL", false, false)
		guiGridListSetItemText(assetsGridlist, row, 2, "$"..tostring(exports.global:formatMoney(bankmoney+vehiclesvalue+propertiesvalue)), false, false)

        local label1 = guiCreateLabel(413, 10, 156, 30, "Faction finance information goes maximum 2 weeks back.", false, tabWeeklyStatement)
        	guiSetFont(label1, "default-small")
        	guiLabelSetHorizontalAlign(label1, "left", true)

        	kapat = guiCreateButton(413, 292, 156, 25,"Kapat/Geri",false,tabWeeklyStatement)
        	addEventHandler("onClientGUIClick",kapat,function()
        		destroyElement(tabFinance)
        		editRankMode = false
        	end)
        local label2 = guiCreateLabel(413, 262, 156, 15, "Çift tıklayarak detaylara ulaşın", false, tabWeeklyStatement)
        	guiSetFont(label2, "default-small")

	tabTransactions = guiCreateTab("Transactions", financeTabs,false)
		transactionsGridlist = guiCreateGridList(0, 0, 1, 1, true, tabTransactions)
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
			guiGridListAddColumn(transactionsGridlist, value[1], value[2] or 0.1)
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

		local row = guiGridListAddRow(weeklyStatementGridlist)
		guiGridListSetItemText(weeklyStatementGridlist, row, statementColText, rowText, false, false)
		guiGridListSetItemData(weeklyStatementGridlist, row, statementColText, rowVar)
		guiGridListSetItemText(weeklyStatementGridlist, row, statementColLast, "$"..tostring(exports.global:formatMoney(lastWeek[rowVar])), false, false)
		guiGridListSetItemText(weeklyStatementGridlist, row, statementColThis, "$"..tostring(exports.global:formatMoney(thisWeek[rowVar])), false, false)

		if lastWeek[rowVar] > 0 then
			guiGridListSetItemColor(weeklyStatementGridlist, row, statementColLast, 0, 148, 0)
		elseif lastWeek[rowVar] < 0 then
			guiGridListSetItemColor(weeklyStatementGridlist, row, statementColLast, 171, 0, 0)
		else
			guiGridListSetItemColor(weeklyStatementGridlist, row, statementColLast, 122, 122, 122)
		end
		if thisWeek[rowVar] > 0 then
			guiGridListSetItemColor(weeklyStatementGridlist, row, statementColThis, 0, 255, 0)
		elseif thisWeek[rowVar] < 0 then
			guiGridListSetItemColor(weeklyStatementGridlist, row, statementColThis, 255, 0, 0)
		else
			guiGridListSetItemColor(weeklyStatementGridlist, row, statementColThis, 255, 255, 255)
		end
	end

	addEventHandler("onClientGUIDoubleClick", weeklyStatementGridlist, function()
		local selectedRow, selectedCol = guiGridListGetSelectedItem(weeklyStatementGridlist)
		local rowvar = guiGridListGetItemData(weeklyStatementGridlist, selectedRow, 1)
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
			if tabStatementDetails then
				guiDeleteTab(tabStatementDetails, financeTabs)
				tabStatementDetails = nil
			end
			guiGridListClear(weeklyStatementGridlist)
			local row = guiGridListAddRow(weeklyStatementGridlist)
			if parent then
				guiGridListSetItemText(weeklyStatementGridlist, row, statementColText, "...", false, false)
			end
			for k,v in ipairs(rows) do
				local rowVar = v[1]
				local rowText = v[2]
				local rowSub = v[3]

				local row = guiGridListAddRow(weeklyStatementGridlist)
				guiGridListSetItemText(weeklyStatementGridlist, row, statementColText, rowText, false, false)
				guiGridListSetItemData(weeklyStatementGridlist, row, statementColText, rowVar)
				guiGridListSetItemText(weeklyStatementGridlist, row, statementColLast, "$"..tostring(exports.global:formatMoney(lastWeek[rowVar])), false, false)
				guiGridListSetItemText(weeklyStatementGridlist, row, statementColThis, "$"..tostring(exports.global:formatMoney(thisWeek[rowVar])), false, false)

				if lastWeek[rowVar] > 0 then
					guiGridListSetItemColor(weeklyStatementGridlist, row, statementColLast, 0, 148, 0)
				elseif lastWeek[rowVar] < 0 then
					guiGridListSetItemColor(weeklyStatementGridlist, row, statementColLast, 171, 0, 0)
				else
					guiGridListSetItemColor(weeklyStatementGridlist, row, statementColLast, 122, 122, 122)
				end
				if thisWeek[rowVar] > 0 then
					guiGridListSetItemColor(weeklyStatementGridlist, row, statementColThis, 0, 255, 0)
				elseif thisWeek[rowVar] < 0 then
					guiGridListSetItemColor(weeklyStatementGridlist, row, statementColThis, 255, 0, 0)
				else
					guiGridListSetItemColor(weeklyStatementGridlist, row, statementColThis, 255, 255, 255)
				end				
			end
		elseif transTypes then
			--outputDebugString("transTypes")
			if tabStatementDetails then
				guiDeleteTab(tabStatementDetails, financeTabs)
				tabStatementDetails = nil
			end
			--if not tabStatementDetails then
				tabStatementDetails = guiCreateTab("Details: "..tostring(thisText), financeTabs,false)
				transactionDetailsGridlist = guiCreateGridList(0, 0, 1, 1, true, tabStatementDetails)
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
					guiGridListAddColumn(transactionDetailsGridlist, value[1], value[2] or 0.1)
				end				
			--end
			for k,v in ipairs(bankThisWeek) do
				if transTypes[v.type] then
					local row = guiGridListAddRow(transactionDetailsGridlist)
					guiGridListSetItemText(transactionDetailsGridlist, row, 1, tostring(v.id), false, false)
					guiGridListSetItemText(transactionDetailsGridlist, row, 2, tostring(v.type), false, false)
					guiGridListSetItemText(transactionDetailsGridlist, row, 3, tostring(v.from), false, false)
					guiGridListSetItemText(transactionDetailsGridlist, row, 4, tostring(v.to), false, false)
					guiGridListSetItemText(transactionDetailsGridlist, row, 5, tostring(exports.global:formatMoney(v.amount)), false, false)
					if v.amount > 0 then
						guiGridListSetItemColor(transactionDetailsGridlist, row, 5, 0, 255, 0)
					elseif v.amount < 0 then
						guiGridListSetItemColor(transactionDetailsGridlist, row, 5, 255, 0, 0)
					end
					guiGridListSetItemText(transactionDetailsGridlist, row, 6, tostring(v.time), false, false)
					guiGridListSetItemText(transactionDetailsGridlist, row, 7, tostring(v.week), false, false)
					guiGridListSetItemText(transactionDetailsGridlist, row, 8, tostring(v.reason), false, false)
				end
			end
			for k,v in ipairs(bankPrevWeek) do
				if transTypes[v.type] then
					local row = guiGridListAddRow(transactionDetailsGridlist)
					guiGridListSetItemText(transactionDetailsGridlist, row, 1, tostring(v.id), false, false)
					guiGridListSetItemText(transactionDetailsGridlist, row, 2, tostring(v.type), false, false)
					guiGridListSetItemText(transactionDetailsGridlist, row, 3, tostring(v.from), false, false)
					guiGridListSetItemText(transactionDetailsGridlist, row, 4, tostring(v.to), false, false)
					guiGridListSetItemText(transactionDetailsGridlist, row, 5, tostring(exports.global:formatMoney(v.amount)), false, false)
					if v.amount > 0 then
						guiGridListSetItemColor(transactionDetailsGridlist, row, 5, 0, 255, 0)
					elseif v.amount < 0 then
						guiGridListSetItemColor(transactionDetailsGridlist, row, 5, 255, 0, 0)
					end
					guiGridListSetItemText(transactionDetailsGridlist, row, 6, tostring(v.time), false, false)
					guiGridListSetItemText(transactionDetailsGridlist, row, 7, tostring(v.week), false, false)
					guiGridListSetItemText(transactionDetailsGridlist, row, 8, tostring(v.reason), false, false)
				end
			end
			guiSetSelectedTab(financeTabs, tabStatementDetails)
		end
	end, false)

	for k,v in ipairs(bankThisWeek) do
		local row = guiGridListAddRow(transactionsGridlist)
		guiGridListSetItemText(transactionsGridlist, row, 1, tostring(v.id), false, false)
		guiGridListSetItemText(transactionsGridlist, row, 2, tostring(v.type), false, false)
		guiGridListSetItemText(transactionsGridlist, row, 3, tostring(v.from), false, false)
		guiGridListSetItemText(transactionsGridlist, row, 4, tostring(v.to), false, false)
		guiGridListSetItemText(transactionsGridlist, row, 5, tostring(exports.global:formatMoney(v.amount)), false, false)
		if v.amount > 0 then
			guiGridListSetItemColor(transactionsGridlist, row, 5, 0, 255, 0)
		elseif v.amount < 0 then
			guiGridListSetItemColor(transactionsGridlist, row, 5, 255, 0, 0)
		end
		guiGridListSetItemText(transactionsGridlist, row, 6, tostring(v.time), false, false)
		guiGridListSetItemText(transactionsGridlist, row, 7, tostring(v.week), false, false)
		guiGridListSetItemText(transactionsGridlist, row, 8, tostring(v.reason), false, false)
	end
	for k,v in ipairs(bankPrevWeek) do
		local row = guiGridListAddRow(transactionsGridlist)
		guiGridListSetItemText(transactionsGridlist, row, 1, tostring(v.id), false, false)
		guiGridListSetItemText(transactionsGridlist, row, 2, tostring(v.type), false, false)
		guiGridListSetItemText(transactionsGridlist, row, 3, tostring(v.from), false, false)
		guiGridListSetItemText(transactionsGridlist, row, 4, tostring(v.to), false, false)
		guiGridListSetItemText(transactionsGridlist, row, 5, tostring(exports.global:formatMoney(v.amount)), false, false)
		if v.amount > 0 then
			guiGridListSetItemColor(transactionsGridlist, row, 5, 0, 255, 0)
		elseif v.amount < 0 then
			guiGridListSetItemColor(transactionsGridlist, row, 5, 255, 0, 0)
		end
		guiGridListSetItemText(transactionsGridlist, row, 6, tostring(v.time), false, false)
		guiGridListSetItemText(transactionsGridlist, row, 7, tostring(v.week), false, false)
		guiGridListSetItemText(transactionsGridlist, row, 8, tostring(v.reason), false, false)
	end

end
addEvent("factionmenu:fillFinance", true)
addEventHandler("factionmenu:fillFinance", getResourceRootElement(), fillFinance)

function btQuitFaction(button, state)

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
		
	
			local sx, sy = guiGetScreenSize() 
			wConfirmQuit = guiCreateWindow(sx-260,sy/2 - 50,250,100,"Ayrılma Onayı", false)
			setElementData(wConfirmQuit,"tp:element",true)
			local lQuestion = guiCreateLabel(0.05,0.25,0.9,0.3,"Ayrılmak istediğine emin misin?",true,wConfirmQuit)
			guiLabelSetHorizontalAlign (lQuestion,"center",true)
			local bYes = guiCreateButton(0.1,0.65,0.37,0.23,"Evet",true,wConfirmQuit)
			local bNo = guiCreateButton(0.53,0.65,0.37,0.23,"Hayır",true,wConfirmQuit)

			openLibrary("convert",wConfirmQuit)
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
	
	
end


function btButtonPerk(factID)

	local bPerkActivePlayer = memberUsernames[selectedPlayer]
	local playerName = string.gsub(bPerkActivePlayer, " ", "_")
	if (playerName == "") then
		outputChatBox("Yonetmek için bir üye seçin.")
		return
	end
	triggerServerEvent("Duty:GetPackages", resourceRoot, factID)

end



wPerkWindow, bPerkSave, bPerkClose, bPerkChkTable, bPerkActivePlayer = nil
function gotPackages(factionPackages)
	bPerkChkTable = { }
	local bPerkActivePlayer = memberUsernames[selectedPlayer]
	local playerName = string.gsub(bPerkActivePlayer, " ", "_")
			
	guiSetInputEnabled(true)
	
	local width, height = 500, 540
	local scrWidth, scrHeight = guiGetScreenSize()
	local x = scrWidth/2 - (width/2)
	local y = scrHeight/2 - (height/2)
	
	wPerkWindow = guiCreateWindow(x, y, width, height, "Birlik Rütbesi : "..playerName, false)
	
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
		local tmpChk = guiCreateCheckBox(0.05 * width, y + 3, 0.4 * width, 17, factionPackage[2], false, false, wPerkWindow)
		guiSetFont(tmpChk, "default-bold-small")
		setElementData(tmpChk, "factionPackage:ID", factionPackage[1], false)
		setElementData(tmpChk, "factionPackage:selected", bPerkActivePlayer, false)
		
		for index, permissionID in pairs(factionPerks) do
			--outputDebugString(tostring(factionPackage["grantID"]) .. " vs "..tostring(permissionID))
			if (permissionID == factionPackage[1]) then
				--outputDebugString("win!")
				guiCheckBoxSetSelected (tmpChk, true)
			end
		end
		
		table.insert(bPerkChkTable, tmpChk)
	end
	
	bPerkSave = guiCreateButton(0.05, 0.900, 0.9, 0.045, "Kaydet", true, wPerkWindow)
	bPerkClose = guiCreateButton(0.05, 0.950, 0.9, 0.045, "Kapat", true, wPerkWindow)
	addEventHandler("onClientGUIClick", bPerkSave, 
		function (button, state)
			if (source == bPerkSave) and (button=="left") and (state=="up") then
				if (wPerkWindow) then
					local collectedPerks = { }
					for _, checkBox in ipairs ( bPerkChkTable ) do
						if ( guiCheckBoxGetSelected( checkBox ) ) then
							table.insert(collectedPerks, getElementData(checkBox, "factionPackage:ID") or -1 )
						end
					end
					
					triggerServerEvent("faction:perks:edit", getLocalPlayer(), collectedPerks, playerName)
					destroyElement(wPerkWindow)
					wPerkWindow, bPerkSave, bPerkClose, bPerkChkTable, bPerkActivePlayer = nil
					guiSetInputEnabled(false)
				end
			end
		end
	, false)
	addEventHandler("onClientGUIClick", bPerkClose, 
		function (button, state)
			if (source == bPerkClose) and (button=="left") and (state=="up") then
				if (wPerkWindow) then
					destroyElement(wPerkWindow)
					wPerkWindow, bPerkSave, bPerkClose, bPerkChkTable, bPerkActivePlayer = nil
					guiSetInputEnabled(false)
				end
			end
		end
	, false)
end
addEvent("Duty:GotPackages", true)
addEventHandler("Duty:GotPackages", resourceRoot, gotPackages)