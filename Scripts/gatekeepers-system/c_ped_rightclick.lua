wPedRightClick = nil
bTalkToPed, bClosePedMenu = nil
ax, ay = nil
closing = nil
sent=false
DGS = exports['dgs-master']
function pedDamage()
	cancelEvent()
end
addEventHandler("onClientPedDamage", getRootElement(), pedDamage)

function clickPed(button, state, absX, absY, wx, wy, wz, element)
	if getElementData(getLocalPlayer(), "exclusiveGUI") then
		return
	end
	if (element) and (getElementType(element)=="ped") and (button=="right") and (state=="down") and (sent==false) and (element~=getLocalPlayer()) then
		if (isPedDoingGangDriveby(getLocalPlayer()) == true) then
			setPedWeaponSlot(getLocalPlayer(), 0)
			setPedDoingGangDriveby(getLocalPlayer(), false)
		end
		local gatekeeper = getElementData(element, "talk")
		if (gatekeeper) then
			local x, y, z = getElementPosition(getLocalPlayer())

			if (getDistanceBetweenPoints3D(x, y, z, wx, wy, wz)<=3) then
				if (wPedRightClick) then
					hidePlayerMenu()
				end

				showCursor(true)
				ax = absX
				ay = absY
				local w, h = 150, 75
				player = element
				closing = false
				local pedName = getElementData(element, "name") or "The Storekeeper"
				pedName = tostring(pedName):gsub("_", " ")
				--wPedRightClick = guiCreateWindow(ax, ay, 150, 75, pedName, false)

				if pedName == "Tony Johnston" then showCursor(false) return end



				wPedRightClick = DGS:dgsCreateImage(ax-w/2, ay-h/2, w, h , ":rightclick/0.png", false)
				local l1 = DGS:dgsCreateLabel(0, 0.08, 1, 0.25, pedName.."#ffc600 (NPC)", true, wPedRightClick)
				DGS:dgsLabelSetHorizontalAlign(l1, "center")
				DGS:dgsSetFont(l1, "default-bold")
				DGS:dgsSetProperty(l1,"colorcoded",true)
				bTalkToPed = DGS:dgsCreateButton(0.05, 0.3, 0.87, 0.25, "Talk", true, wPedRightClick,tocolor(255,255,255,255), _, _, _, _, _, tocolor(53, 53, 53, 100), tocolor(255, 198, 0, 200), tocolor(255, 198, 0, 255))
				addEventHandler("onDgsMouseClickUp", bTalkToPed,  function (button, state)
					if(button == "left" and state == "up") then

						hidePedMenu()

						local ped = getElementData(element, "name")
						local isFuelped = getElementData(element,"ped:fuelped")
						local isTollped = getElementData(element,"ped:tollped")
						local isShopKeeper = getElementData(element,"shopkeeper") or false

						if (ped=="Steven Pullman") then
							triggerServerEvent( "startStevieConvo", getLocalPlayer())
							if (getElementData(element, "activeConvo")~=1) then
								triggerEvent ( "stevieIntroEvent", getLocalPlayer()) -- Trigger Client side function to create GUI.
							end
						elseif (ped=="Hunter") then
							triggerServerEvent( "startHunterConvo", getLocalPlayer())
						elseif (ped=="Rook") then
							triggerServerEvent( "startRookConvo", getLocalPlayer())
						elseif (ped=="Victoria Greene") then
							triggerEvent("cPhotoOption", getLocalPlayer(), ax, ay)
						elseif (ped=="Jessie Smith") then
							--triggerEvent("onEmployment", getLocalPlayer())
							triggerEvent("cityhall:jesped", getLocalPlayer())
						elseif (ped=="Carla Cooper") then
							triggerEvent("onLicense", getLocalPlayer())
						elseif (ped=="Dominick Hollingsworth") then
							triggerEvent("showRecoverLicenseWindow", getLocalPlayer())
						elseif (ped=="Mr. Clown") then
							triggerServerEvent("electionWantVote", getLocalPlayer())
						elseif (ped=="Greer Reid") then
							triggerServerEvent("onTowMisterTalk", getLocalPlayer())
						elseif (ped=="Guard Jenkins") then
							triggerServerEvent("gateCityHall", getLocalPlayer())
						elseif (ped=="Airman Connor") then
							triggerServerEvent("gateAngBase", getLocalPlayer())
						elseif (ped=="Rosie Jenkins") then
							triggerEvent("lses:popupPedMenu", getLocalPlayer())
						--[[elseif (ped=="Jacob Greenaway") then
							triggerEvent("lses:popupPedMenu", getLocalPlayer())]]
						elseif (ped=="Gabrielle McCoy") then
							triggerEvent("cBeginPlate", getLocalPlayer())
						--elseif (ped=="Vanna Spadafora") then
							--triggerEvent("vm:popupPedMenu", getLocalPlayer())
						elseif (isFuelped == true) then
							triggerServerEvent("fuel:startConvo", element)
						elseif (isTollped == true) then
							triggerServerEvent("toll:startConvo", element)
						elseif (ped=="Novella Iadanza") then
							triggerServerEvent("onSpeedyTowMisterTalk", getLocalPlayer())
						elseif isShopKeeper then -- MAXIME
							triggerServerEvent("shop:keeper", element)
						elseif (ped=="Maxime Du Trieux") then --Banker ATM Service, MAXIME
							triggerEvent("bank-system:bankerInteraction", getLocalPlayer())
						elseif (ped=="Jonathan Smith") then --Banker General Service, MAXIME
							triggerServerEvent( "bank:showGeneralServiceGUI", getLocalPlayer(), getLocalPlayer())
						elseif getElementData(element,"carshop") then
							triggerServerEvent( "vehlib:sendLibraryToClient", localPlayer, element)
						elseif (ped=="Julie Dupont") then
							triggerServerEvent('clothing:list', getResourceRootElement (getResourceFromName("mabako-clothingstore")))
						elseif (ped=="Evelyn Branson") then
							triggerEvent("airport:ped:receptionistFAA", localPlayer, element)
						elseif (ped=="John G. Fox") then
							triggerServerEvent("startPrisonGUI", root, localPlayer)
						elseif (ped=="Georgio Dupont") then
       						triggerEvent("locksmithGUI", localPlayer, localPlayer)
       					elseif (ped=="Corey Byrd") then
							triggerEvent('ha:treatment', getLocalPlayer())
						elseif (ped=="Justin Borunda") then --PD impounder / Maxime 
							triggerServerEvent("tow:openImpGui", localPlayer, ped)
						elseif (ped=="Sergeant K. Johnson") then --PD release / Maxime
							triggerServerEvent("tow:openReleaseGUI", localPlayer, ped)
						elseif (ped=="Bobby Jones") then --HP impounder / Maxime 
							triggerServerEvent("tow:openImpGui", localPlayer, ped)
						elseif (ped=="Robert Dunston") then --HP release / Maxime
							triggerServerEvent("tow:openReleaseGUI", localPlayer, ped)
						elseif (ped=="Ken Rose") then --warpGUI / Dharma
							triggerEvent("warpGUI", getLocalPlayer())
						elseif (ped=="Frank Lopidos") then --bridgeGUI / Dharma
							triggerEvent("bridgeGUI", getLocalPlayer())
						elseif (ped=="Frederick W'Smith") then --Fed-Ex / Dharma
							triggerEvent("fedExGUI", getLocalPlayer())
						elseif (ped=="Alex Lucas") then --Border Pass Card / Dharma
							triggerEvent("borderCardGUI", getLocalPlayer())
						elseif (ped=="Smith Micheal") then --Vehicle Plate / Dharma
							triggerEvent("vehiclePlateGUI", getLocalPlayer())
						elseif (ped=="John K. Lother") then --Ticket-System / Dharma
							triggerEvent("tt", getLocalPlayer())
						elseif (ped=="Micheal Toreno") then --Ped Inventory / Dharma
							triggerEvent("itemsGUI", getLocalPlayer())
						elseif (ped=="Mike Johnson") then
							triggerEvent("kiralamaGoster", getLocalPlayer())
						elseif (ped=="Pete Robinson") then
							triggerServerEvent("vergi:sVergiGUI", getLocalPlayer())
						elseif (ped=="Melina Dupont") then --HP release / Maxime
							triggerEvent("clothes:list", getLocalPlayer())
						else
							exports.hud:sendBottomNotification(getLocalPlayer(),(ped or "NPC").." says:", "        'Hi!'")
						end
					end
				end, false)
				startY = 0
				startY = startY + 40 
				--bClosePedMenu = guiCreateButton(0.05, 0.6, 0.87, 0.25, "Close Menu", true, wPedRightClick)
				bClosePedMenu = exports['dgs-master']:dgsCreateButton(0.05, 0.6, 0.87, 0.25,"Close Menu",true,wPedRightClick,tocolor(255,255,255,255), 1,1,nil,nil,nil, tocolor(53, 53, 53, 100), tocolor(255, 198, 0, 200), tocolor(255, 198, 0, 255))
				DGS:dgsSetProperty(bClosePedMenu,"iconImage",{":interaction/icons/cross_x.png",":interaction/icons/cross_x.png",":interaction/icons/cross_x.png"})
				DGS:dgsSetProperty(bClosePedMenu,"iconDirection","left")
				addEventHandler("onDgsMouseClickUp", bClosePedMenu, hidePedMenu, false)
				--exports['dgs-master']:dgsMoveTo(bClosePedMenu,0,startY,false,false,"OutElastic",1500)
				sent=true
			end
		end
	end
end
addEventHandler("onClientClick", getRootElement(), clickPed, true)

function hidePedMenu()
	if (isElement(bTalkToPed)) then
		destroyElement(bTalkToPed)
	end
	bTalkToPed = nil

	if (isElement(bClosePedMenu)) then
		destroyElement(bClosePedMenu)
	end
	bClosePedMenu = nil

	if (isElement(wPedRightClick)) then
		destroyElement(wPedRightClick)
	end
	wPedRightClick = nil

	ax = nil
	ay = nil
	sent=false
	showCursor(false)

end
