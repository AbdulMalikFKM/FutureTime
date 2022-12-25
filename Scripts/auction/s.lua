theVehicle = nil
lastbidder = nil
local Attributes = { }
mysql = exports.mysql
function countdownFin() 
outputChatBox("The Timer Has Been Finished")
    --setElementPosition ( source, 1536.091796875, -1027.6552734375, 24.078125 )  
end 

addEvent("PutVehicleInDisplay", true)
addEventHandler("PutVehicleInDisplay", root,
	function(theVehicle, bid, minin, buyout, charID, desc)
		local thePlayerID = getElementData(source, "account:character:id")
		local type = 4
		local itemID = 3
		local hasPhone, itemKey, itemValue, item = exports.global:hasItem(source, 3)
	
	--removePlayerFromVehicle ( source ) غالبا الكود ذا انتهت مدته يعني ماراح يكون موجود في تحديثات اللعبة القادمة , الكود اللي تحته هو الجديد 
		local countdown = setTimer(countdownFin, 86400000, 1) --set the timer for 1 day 
		removePedFromVehicle(source) 
		setElementPosition ( source, 1536.091796875, -1027.6552734375, 24.078125 )  
		setElementData(theVehicle, "show_vin", 1)
		vin = getElementData(theVehicle, "dbid")
		--setElementData(theVehicle, "show_plate", 0) 
			setTimer (function ()
				if (isTimer(countdown) == true) then -- to prevent any error and warning message
					local timeLeft = getTimerDetails(countdown) 
					des1 = exports.anticheat:changeProtectedElementDataEx(theVehicle, "description:1", "Time Remaining : " .. exports.global:convertSecondsToMinutes(timeLeft), true)
				end
			end, 1000, 0)
		des2 = exports.anticheat:changeProtectedElementDataEx(theVehicle, "description:2", "Current Bid : "..bid.."$", true)
		des3 = exports.anticheat:changeProtectedElementDataEx(theVehicle, "description:3", "Buyout : "..buyout.."$", true)
		des4 = exports.anticheat:changeProtectedElementDataEx(theVehicle, "description:4", "Minimum Increase : "..minin.."$", true)
		des5 = exports.anticheat:changeProtectedElementDataEx(theVehicle, "description:5", "Right Click To The Vehicle To Bid", true)
		--triggerClientEvent(source, "test", source, des1, des2, des3, des4, theVehicle) 
		mysql:query_free("INSERT INTO auction SET ownerid="..mysql:escape_string(charID)..", lastbidder="..mysql:escape_string(charID)..", bidprice="..mysql:escape_string(bid)..", minincrease="..mysql:escape_string(minin)..", buyout="..mysql:escape_string(buyout)..", vin="..mysql:escape_string(vin)..", description='"..mysql:escape_string(desc).."'")
		mysql:query_free("INSERT INTO `ped_inventory` (type, owner, itemID, itemValue) VALUES ('" .. mysql:escape_string(type) .. "','" .. mysql:escape_string(thePlayerID) .. "','" .. mysql:escape_string(itemID) .. "','" .. mysql:escape_string(itemValue) .. "')" )
	end
)
--يشيك اذا كانت السيارة اللي بيعرضها للمزاد ملك له
addEvent("CheckTheVehicle", true)
addEventHandler("CheckTheVehicle", root,
	function(theVehicle)
		local vehicleOwner = getElementData(theVehicle, "owner") or -1
	    local playerID = getElementData(source, "dbid") or 0
		local isPlayerVehicleFrozen = isElementFrozen(theVehicle)
           if vehicleOwner == playerID then
				triggerClientEvent(source, "VerifyTheAccepetion", source)
				setElementFrozen(theVehicle, not isPlayerVehicleFrozen)
			else
				exports.notification:addNotification(source, "This is Not Your Vehicle Get Fuck out of here", "error")
			end
	end
)


addEvent("UpdateVehicleStats", true)
addEventHandler("UpdateVehicleStats", root,
function(theVehicle, bid, charID)
thePlayerID = getElementData(source, "account:character:id")
local vehID = getElementData(theVehicle, "dbid")
outputChatBox(tostring(lastbidder) .. "\n" .. tostring(charID))
if lastbidder == charID then
outputChatBox("You can't bid twice at same time!")
else
des2 = exports.anticheat:changeProtectedElementDataEx(theVehicle, "description:2", "Current Bid : "..bid.."$", true)
		mysql:query_free("UPDATE auction SET bidprice="..mysql:escape_string(bid)..", lastbidder="..mysql:escape_string(charID).." WHERE vin="..vehID)
end
end)
--هنا يشيك اذا كانت في سيارة في وحدة من المواقف اذا فيه يحطها في المكان اللي بعده عشان لايصير تداخل--
--هنا اذا عرض السيارة للبيع ياخذ منه المفتاح ويعطيه للبوت، واذا احد اشترى السيارة ينحذف المفتاح ويجي مكانه الفلوس
function ShowMyItems(thePlayer)
			local thePlayerID = getElementData(thePlayer, "account:character:id")
			local result = exports.mysql:query( "SELECT `itemID`, `itemValue` FROM `ped_inventory` WHERE `owner` = '".. thePlayerID .."' ORDER BY `index` DESC" )
		if result then
			local items = { }
			while true do
				local row = mysql:fetch_assoc(result)
				if not row then break end
				
				table.insert( items, {row.itemID, row.itemValue} )
				
			end
			
			mysql:free_result(result)	
			triggerClientEvent( thePlayer, "ShowItemsGUI", thePlayer, items)		
			else
			outputChatBox("Error", thePlayer, 255, 0, 0)
		end
				end
			--end
addEvent("ShowMyItems", true)
addEventHandler( "ShowMyItems", getRootElement(), ShowMyItems )

function getAllAttribute(theVehicle)
		vin = getElementData(theVehicle, "dbid")
			local result = exports.mysql:query( "SELECT * FROM `auction` WHERE `vin` = " ..mysql:escape_string(vin) )
		if result then
			
			while true do
				local row = mysql:fetch_assoc(result)
				if not row then break end
				lastbidder = row.lastbidder
				table.insert( Attributes, {row.id, row.ownerid, row.lastbidder, row.bidprice, row.minincrease, row.buyout, row.vin, row.description} )
				
			end
			
			mysql:free_result(result)	
			--triggerClientEvent( thePlayer, "ShowItemsGUI", thePlayer, items)		
			else
			outputChatBox("Error", thePlayer, 255, 0, 0)
		end
				end
			--end
addEvent("getAllAttribute", true)
addEventHandler( "getAllAttribute", getRootElement(), getAllAttribute )

--[[
function convertSecondsToMinutes(sec) --turn the seconds into a MM:SS format 
        local hours = math.floor (sec/3600000) -- convert ms to hours
        local mins = math.floor (sec/60000) -- convert ms to mins
        local secs = math.floor ((sec/1000) % 60) -- convert ms to secs
		
		local hour = string.format ( "%02s", math.floor (sec/3600000))
		local min = string.format ( "%02s", ( mins - hours * 60 ))
		local sec = string.format ( "%02s", secs )

   return tostring(hour)..":"..tostring(min).. ":"..tostring(sec) 
end ]]