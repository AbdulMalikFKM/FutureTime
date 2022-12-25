﻿g = {
-- north x, north y, north z, south x , south y, south z, east x , east y, east z, west x , west y, west z
[1] = {1963.9130859375, -1824.677734375, 13.3828125, 1959.076171875, -1801.5859375, 13.3828125, 1973.15625, -1810.041015625, 13.3828125, 0, 0, 0},
[2] = {2091.666015625, -1763.857421875, 13.3995885849, 2079.4873046875, -1739.6875, 13.384455680847, 2106.056640625, -1750.21484375, 13.406240463257, 2066.7265625, -1754.458984375, 13.393749237061}
}
Noti = exports['info-box']
--fine = 500

local screen = dxCreateScreenSource ( 340, 380 );
local renderEvent = false
local sx, sy = guiGetScreenSize()
 
local sX = sx/1280
local sY = sy/720

local alpha = 140
local imgAlpha = 255

function daPic()
    dxUpdateScreenSource(screen);
    
	if renderEvent == false then
    addEventHandler("onClientRender", root, showSpeedPic)
	setTimer(removeDaAnnoyingThingy, 5500, 1);
	renderEvent = true
	end
end

addEvent("showPicture", true)
addEventHandler("showPicture", getLocalPlayer(), daPic)

function showSpeedPic()
    rect =  dxDrawRectangle(20.0*sX,209.0*sY,295.0*sX,255.0*sY,tocolor(0,0,0,alpha),false)
    dxDrawImage( 28.0*sX,217.0*sY,279.0*sX,238.0*sY, screen, 0, 0, 0, tocolor(255, 255, 255, imgAlpha), false)
end

function removeDaAnnoyingThingy()
	addEventHandler("onClientRender", getRootElement(), alphaShizz)
end

function alphaShizz()
	alpha = alpha-3
	imgAlpha = imgAlpha-3
	if (alpha <=0) then
		removeEventHandler("onClientRender", root, showSpeedPic)
		removeEventHandler("onClientRender", root, alphaShizz)
		renderEvent = false
		imgAlpha = 255
		alpha = 140
	end
end

addEventHandler("onClientResourceStart", root,
function ()
	for i, v in ipairs (g) do
		 north = createMarker(v[1], v[2], v[3]-1, "cylinder", 4, 255, 15, 15, 0)
		 south = createMarker(v[4], v[5], v[6]-1, "cylinder", 4, 255, 15, 15, 0)
		 east = createMarker(v[7], v[8], v[9]-1, "cylinder", 4, 255, 15, 15, 0)
		 west = createMarker(v[10], v[11], v[12]-1, "cylinder", 4, 255, 15, 15, 0)
		 --createColCuboid ( v[1], v[2], v[3], 5, 5, 5 )
    addEventHandler ("onClientMarkerHit",north,MarkerHit) 
    addEventHandler ("onClientMarkerHit",south,MarkerHit1) 
    addEventHandler ("onClientMarkerHit",east,MarkerHit2) 
    addEventHandler ("onClientMarkerHit",west,MarkerHit3) 
	end
end )
  
addEventHandler('onClientRender',root,
function ()
	if ( getTrafficLightState() == 0 ) then
		setElementData(north,"trafficState",true)
		setElementData(south,"trafficState",true)
		setElementData(east,"trafficState",false)
		setElementData(west,"trafficState",false)
	else
		setElementData(north,"trafficState",false)
		setElementData(south,"trafficState",false)
		setElementData(east,"trafficState",true)
		setElementData(west,"trafficState",true)
	end 
		if ( getTrafficLightState() == 3 ) then
			setElementData(north,"trafficState",false)
			setElementData(south,"trafficState",false)
			setElementData(east,"trafficState",true)
			setElementData(west,"trafficState",true)
	else
		setElementData(north,"trafficState",true)
		setElementData(south,"trafficState",true)
		setElementData(east,"trafficState",false)
		setElementData(west,"trafficState",false)
end
end)
  
function MarkerHit(hitPlayer,matchingDimension) 
    local vehicle = getPedOccupiedVehicle(hitPlayer)
	if getElementType(hitPlayer) == "player" then
		if isPedInVehicle(hitPlayer) then
			if (getElementData(north, "trafficState") == false) and not (getElementModel(vehicle) == 416) and not (getElementModel(vehicle) == 433) and not (getElementModel(vehicle) == 427) and not (getElementModel(vehicle) == 490) and not (getElementModel(vehicle) == 528) and not (getElementModel(vehicle) == 407) and not (getElementModel(vehicle) == 544) and not (getElementModel(vehicle) == 523) and not (getElementModel(vehicle) == 470) and not (getElementModel(vehicle) == 596) and not (getElementModel(vehicle) == 598) and not (getElementModel(vehicle) == 599) and not (getElementModel(vehicle) == 597) and not (getElementModel(vehicle) == 601) then 
					triggerServerEvent("ticketMoney", localPlayer, localPlayer)
					Noti:showInfobox("info", "You Got Ticket For Cutting Traffic")
					--Noti:showInfobox("info", "تم قيد مخالفة: قطع اشارة المرور")
			end
		end
	end
end 
function MarkerHit1(hitPlayer,matchingDimension) 
    local vehicle = getPedOccupiedVehicle(hitPlayer)
	if getElementType(hitPlayer) == "player" then
		if isPedInVehicle(hitPlayer) then
			if (getElementData(south, "trafficState") == false) and not (getElementModel(vehicle) == 416) and not (getElementModel(vehicle) == 433) and not (getElementModel(vehicle) == 427) and not (getElementModel(vehicle) == 490) and not (getElementModel(vehicle) == 528) and not (getElementModel(vehicle) == 407) and not (getElementModel(vehicle) == 544) and not (getElementModel(vehicle) == 523) and not (getElementModel(vehicle) == 470) and not (getElementModel(vehicle) == 596) and not (getElementModel(vehicle) == 598) and not (getElementModel(vehicle) == 599) and not (getElementModel(vehicle) == 597) and not (getElementModel(vehicle) == 601) then 
					triggerServerEvent("ticketMoney", localPlayer, fine)
					Noti:showInfobox("info", "You Got Ticket For Cutting Traffic")
					--Noti:showInfobox("info", "تم قيد مخالفة: قطع اشارة المرور")
			end
		end
	end
end 

function MarkerHit2(hitPlayer,matchingDimension) 
    local vehicle = getPedOccupiedVehicle(hitPlayer)
	if getElementType(hitPlayer) == "player" then
		if isPedInVehicle(hitPlayer) then
			if (getElementData(east, "trafficState") == false) and not (getElementModel(vehicle) == 416) and not (getElementModel(vehicle) == 433) and not (getElementModel(vehicle) == 427) and not (getElementModel(vehicle) == 490) and not (getElementModel(vehicle) == 528) and not (getElementModel(vehicle) == 407) and not (getElementModel(vehicle) == 544) and not (getElementModel(vehicle) == 523) and not (getElementModel(vehicle) == 470) and not (getElementModel(vehicle) == 596) and not (getElementModel(vehicle) == 598) and not (getElementModel(vehicle) == 599) and not (getElementModel(vehicle) == 597) and not (getElementModel(vehicle) == 601) then 
					triggerServerEvent("ticketMoney", localPlayer, fine)
					Noti:showInfobox("info", "You Got Ticket For Cutting Traffic")
					--Noti:showInfobox("info", "تم قيد مخالفة: قطع اشارة المرور")
			end
		end
	end
end 

function MarkerHit3(hitPlayer,matchingDimension) 
    local vehicle = getPedOccupiedVehicle(hitPlayer)
	if getElementType(hitPlayer) == "player" then
		if isPedInVehicle(hitPlayer) then
			if (getElementData(west, "trafficState") == false) and not (getElementModel(vehicle) == 416) and not (getElementModel(vehicle) == 433) and not (getElementModel(vehicle) == 427) and not (getElementModel(vehicle) == 490) and not (getElementModel(vehicle) == 528) and not (getElementModel(vehicle) == 407) and not (getElementModel(vehicle) == 544) and not (getElementModel(vehicle) == 523) and not (getElementModel(vehicle) == 470) and not (getElementModel(vehicle) == 596) and not (getElementModel(vehicle) == 598) and not (getElementModel(vehicle) == 599) and not (getElementModel(vehicle) == 597) and not (getElementModel(vehicle) == 601) then 
					triggerServerEvent("ticketMoney", localPlayer, fine)
					Noti:showInfobox("info", "You Got Ticket For Cutting Traffic")
					--Noti:showInfobox("info", "تم قيد مخالفة: قطع اشارة المرور")
			end
		end
	end
end 