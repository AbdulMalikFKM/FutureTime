﻿--[[
gov_veh = {
416, 433, 427, 490, 528, 407, 544, 523, 470, 596, 598, 599, 597, 601
}
]]
enableBlips = get("enableSpeedcamBlips")
mysql = exports.mysql
thisResource = getResourceRootElement(getThisResource())

function createSpeedFunc()
local speedcams = getElementsByType ("speedcam", resourceRoot)
num=0
id=0
speedcam = { }
speedBlip = { }
speedID = { }
	for key,val in ipairs(speedcams) do
		num=num+1
		id=id+1
		speedX = getElementData(val, "x")
		speedY = getElementData(val, "y")
		speedZ = getElementData(val, "z")
		size = getElementData(val, "size")
		ticketCost = getElementData(val, "ticketCost")
		requiredSpeed = getElementData(val, "requiredSpeed")
		speedcam[num] = createMarker (speedX, speedY, speedZ-1, "cylinder", size, 255, 200, 0, 0, root)
		setElementData(speedcam[num], "id", tonumber(id), true)
		setElementData(speedcam[num], "speedcam", speedcam[num])
		setElementData(speedcam[num], "x", speedX)
		setElementData(speedcam[num], "y", speedY)
		setElementData(speedcam[num], "z", speedZ)
		setElementData(speedcam[num], "ticketCost", ticketCost)
		setElementData(speedcam[num], "requiredSpeed", requiredSpeed)
		speedcamData = getElementData(speedcam[num], "speedcam")
		addEventHandler("onMarkerHit", speedcamData, triggerFlashShit)
		if enableBlips == "true" then
			for m,n in ipairs(speedcam) do
				local blip = createBlip(speedX, speedY, speedZ, 0, 1, 255, 0, 0, 255, 0, 70, getRootElement())
				setBlipVisibleDistance(blip, 200)
			end	
		end
	end
end
addEventHandler("onResourceStart", resourceRoot, createSpeedFunc)
    
	function triggerFlashShit(hitElement)
        if (getElementType(hitElement) == "player" ) then
            local vehicle = getPedOccupiedVehicle(hitElement)
            if (getElementType(vehicle) == "vehicle" ) then
			local driver = getVehicleOccupant ( vehicle )
			if (driver) then
            local speedx, speedy, speedz = getElementVelocity(vehicle)
			local cX, cY, cZ = getElementPosition(vehicle)
                local playerAcc = getPlayerAccount(hitElement)
				local belt = getElementData(hitElement, "seatbelt")
				local lightsRed = getTrafficLightState() == 2
               -- local pWanted = getPlayerWantedLevel(hitElement)
                local pMoney = exports.global:getMoney(hitElement)
				local issuerID = -1
				local dep = "Los Santos Police Department"
				local reason = "OverSpeeding"
				local reasonNoSeatbelt = "No Seatbelt"
				local vehicle = getPedOccupiedVehicle(hitElement)
				local veh = getElementData(vehicle, "dbid")
				local issuetoID = getElementData(vehicle, "owner") or -1
				local plate = getVehiclePlateText ( vehicle )
				local vehModel = exports.global:getVehicleName(vehicle)
				local x, y, z = getElementPosition(hitElement)
				local area = getZoneName(x, y, z)
                
                actualSpeed = (speedx^2 + speedy^2 + speedz^2)^(0.5)
                
                mph = math.floor(actualSpeed * 180)
				
              -- for k, v in ipairs (gov_veh) do
                if (mph >= tonumber(requiredSpeed)) and not (getElementModel(vehicle) == 416) and not (getElementModel(vehicle) == 433) and not (getElementModel(vehicle) == 427) and not (getElementModel(vehicle) == 490) and not (getElementModel(vehicle) == 528) and not (getElementModel(vehicle) == 407) and not (getElementModel(vehicle) == 544) and not (getElementModel(vehicle) == 523) and not (getElementModel(vehicle) == 470) and not (getElementModel(vehicle) == 596) and not (getElementModel(vehicle) == 598) and not (getElementModel(vehicle) == 599) and not (getElementModel(vehicle) == 597) and not (getElementModel(vehicle) == 601) then
                    --if (pMoney >= tonumber(ticketCost) ) then
                    outputChatBox("* تم لقطك بالرادار (السبب:سرعتك اكثر من "..requiredSpeed.." ك/س)", hitElement, 255, 200, 0, false)
                    outputChatBox("* سرعتك: "..mph.." ك/س", hitElement, 255, 200, 0, false)
					mysql:query_free("INSERT INTO `pd_tickets` (`reason`, `vehid`, `amount`, `issuer`, `charid`, `plate`, `vehModel`, `area`, `dep`, `time`) VALUES ('".. mysql:escape_string(reason) .."', "..mysql:escape_string(veh)..", "..mysql:escape_string(ticketCost)..", "..mysql:escape_string(issuerID)..", "..mysql:escape_string(issuetoID)..", '"..mysql:escape_string(plate).."', '"..mysql:escape_string(vehModel).."', '"..mysql:escape_string(area).."', '"..mysql:escape_string(dep).."', NOW() - interval 1 hour)")
                    --outputChatBox("* لقد دفعت "..ticketCost.."$ غرامة", hitElement, 255, 200, 0, false)
                    setTimer(triggerClientEvent, 100, 1, "showPicture", hitElement)
                    --exports.global:takeMoney(hitElement, tonumber(ticketCost))
                    fadeCamera(hitElement, false, 0.5, 255, 255, 255)
                    setTimer(fadeCamera, 100, 1, hitElement, true, 1.0, 255, 255, 255)
					end
					if ((not belt)) and not (getElementModel(vehicle) == 416) and not (getElementModel(vehicle) == 433) and not (getElementModel(vehicle) == 427) and not (getElementModel(vehicle) == 490) and not (getElementModel(vehicle) == 528) and not (getElementModel(vehicle) == 407) and not (getElementModel(vehicle) == 544) and not (getElementModel(vehicle) == 523) and not (getElementModel(vehicle) == 470) and not (getElementModel(vehicle) == 596) and not (getElementModel(vehicle) == 598) and not (getElementModel(vehicle) == 599) and not (getElementModel(vehicle) == 597) and not (getElementModel(vehicle) == 601) then
					outputChatBox("You have been captured by camera for reason (NO SEATBELT)", hitElement, 255, 200, 0, false)
					setTimer(triggerClientEvent, 100, 1, "showPicture", hitElement)
                    --exports.global:takeMoney(hitElement, tonumber(ticketCost))
                    fadeCamera(hitElement, false, 0.5, 255, 255, 255)
                    setTimer(fadeCamera, 100, 1, hitElement, true, 1.0, 255, 255, 255)
					mysql:query_free("INSERT INTO `pd_tickets` (`reason`, `vehid`, `amount`, `issuer`, `charid`, `plate`, `vehModel`, `area`, `dep`, `time`) VALUES ('".. mysql:escape_string(reasonNoSeatbelt) .."', "..mysql:escape_string(veh)..", "..mysql:escape_string(ticketCost)..", "..mysql:escape_string(issuerID)..", "..mysql:escape_string(issuetoID)..", '"..mysql:escape_string(plate).."', '"..mysql:escape_string(vehModel).."', '"..mysql:escape_string(area).."', '"..mysql:escape_string(dep).."', NOW() - interval 1 hour)")

                            end
                    end
					else
					return end
        end
        end
	--	end
addEvent("ticketMoney", true)
addEventHandler("ticketMoney", root,
function (hitElement)
local issuerID = -1
local dep = "Los Santos Police Department"
local reason = "Cut off Traffic Light"
local vehicle = getPedOccupiedVehicle(source)
local veh = getElementData(vehicle, "dbid")
local issuetoID = getElementData(vehicle, "owner") or -1
local plate = getVehiclePlateText ( vehicle )
local vehModel = exports.global:getVehicleName(vehicle)
local x, y, z = getElementPosition(source)
local area = getZoneName(x, y, z)
local ticketCost = 500
	if (getElementType(source) == "player" ) then
        local vehicle = getPedOccupiedVehicle(source)
		if (getElementType(vehicle) == "vehicle" ) then
			local driver = getVehicleOccupant ( vehicle )
			if (driver) then
			setTimer(triggerClientEvent, 100, 1, "showPicture", source)
				mysql:query_free("INSERT INTO `pd_tickets` (`reason`, `vehid`, `amount`, `issuer`, `charid`, `plate`, `vehModel`, `area`, `dep`, `time`) VALUES ('".. mysql:escape_string(reason) .."', "..mysql:escape_string(veh)..", "..mysql:escape_string(ticketCost)..", "..mysql:escape_string(issuerID)..", "..mysql:escape_string(issuetoID)..", '"..mysql:escape_string(plate).."', '"..mysql:escape_string(vehModel).."', '"..mysql:escape_string(area).."', '"..mysql:escape_string(dep).."', NOW() - interval 1 hour)")
			end
								else
					return end
		end
	--end 
end)


