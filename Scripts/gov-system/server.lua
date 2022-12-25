mysql = exports.mysql
Noti = exports['info-box']
------Track Vehicles By Plate
function GotoDatabase(plate)
	local mQuery = mysql:query("SELECT `id` FROM `vehicles` WHERE `plate` ='" ..mysql:escape_string(plate).."'")
		while true do
			local row = mysql:fetch_assoc(mQuery)
				if not row then break end
		if row then
		local vehicles = { }
		table.insert( vehicles, tonumber(row.id) )
			Noti:showInfobox(source, "success", "Successful Mark The Vehicle!")
			--triggerClientEvent( source, "ShowBlip", source, vehicles)
			for i, v in ipairs (vehicles) do
			theVehicle = exports.pool:getElement("vehicle", tonumber(v))
			vehLib = createBlipAttachedTo(theVehicle, 23, 2, 255, 0, 0, 255, 0, 65535, source)
		end
	mysql:free_result(mQuery)
		end
				end
			end
addEvent("GiveMeThat", true)
addEventHandler( "GiveMeThat", getRootElement(), GotoDatabase )

	setTimer ( function()
	destroyElement(vehLib)
	end, 50000, 0 )
----------------------------------------------
-----------Track By Phone-----------
function showPlayerByPhoneNumber(NameEdit)
	local phoneNumber = { }
	local itemID = 2
	local Name = exports.global:getCharacterIDFromName(NameEdit)
	local mQuery = mysql:query("SELECT `itemValue`, `owner` FROM `items` WHERE ( `itemID` ='" .. mysql:escape_string(itemID) .. "' AND `owner` ='" .. mysql:escape_string(Name) .. "' )")
		while true do
			local row = mysql:fetch_assoc(mQuery)
				if not row then break end
								table.insert( phoneNumber, {row.itemValue, exports.global:getCharacterNameFromID(row.owner)} )
						triggerClientEvent( source, "ShowPhoneNumbersToPolice", source, phoneNumber)
						end
	mysql:free_result(mQuery)
				end
addEvent("onClientWantToSearch", true)
addEventHandler( "onClientWantToSearch", getRootElement(), showPlayerByPhoneNumber )
------------------------------------
-----------Show Vehicles Tickets--------------
function showAllTicketsToPolice(myPlate)
	local Tickets = { }
	local mQuery = mysql:query("SELECT * FROM `pd_tickets` WHERE `plate` ='" ..mysql:escape_string(myPlate).."'")
		while true do
			local row = mysql:fetch_assoc(mQuery)
				if not row then break end
						--if tonumber(row["amount"]) >= 0 then
								table.insert( Tickets, { row.id, row.amount, row.time, row.vehid, row.reason, row.issuer, row.plate, row.vehmodel, row.area, row.dep} )
						triggerClientEvent( source, "ShowTicketsToPolice", source, Tickets)
			--	end
						end
	mysql:free_result(mQuery)
				end
addEvent("onClientClickSearch", true)
addEventHandler( "onClientClickSearch", getRootElement(), showAllTicketsToPolice )