mysql = exports.mysql
function ShowMyTickets(thePlayer)
local thePlayerID = getElementData(thePlayer, "account:character:id")
local charname = getPlayerName(thePlayer):gsub("_", " ")
local vehicleOwner = getElementData(thePlayer, "owner") or -1
local playerID = getElementData(thePlayer, "dbid")
--local namefromcharid = getCharacterNameFromID(thePlayerID)
			--if thePlayerID == vehicleOwner then
			local result = exports.mysql:query( "SELECT * FROM `pd_tickets` WHERE `charid` = '".. thePlayerID .."' ORDER BY `id` DESC" )
		if result then
			local ticket = { }
			
			while true do
				local row = mysql:fetch_assoc(result)
				if not row then break end
				
				table.insert( ticket, { row.id, row.amount, row.time, row.vehid, row.reason, row.issuer, row.plate, row.vehmodel, row.area, row.dep} )
				
			end
			
			mysql:free_result(result)	
			triggerClientEvent( thePlayer, "ShowTicketsGUI", thePlayer, charname, ticket)		
			else
			outputChatBox("Error", thePlayer, 255, 0, 0)
		end
				end
			--end
addEvent("ShowMyTickets", true)
addEventHandler( "ShowMyTickets", getRootElement(), ShowMyTickets )

function payTicket(thePlayer, id)
	local logged = getElementData(thePlayer, "loggedin")
		if (logged==1) then
		if not id or not (tonumber(id)) then
			outputChatBox("SYNTAX: /"..theCommand.." [ticketID]", thePlayer, 255, 194, 14)
		else
			local mQuery = mysql:query("SELECT `reason`, `amount`, `charid` FROM `pd_tickets` WHERE `id`='"..mysql:escape_string(id).."' ORDER BY `id` ASC")
				local row = mysql:fetch_assoc(mQuery)
				if not row then 
					outputChatBox("[ERR-424-001-34324]", thePlayer, 255, 0, 0)
				else
				local amount = tonumber(row["amount"])
				--local id = tonumber(row["id"])
				local issuerCharID = tonumber(row["charid"])
				local issuer = exports['cache']:getCharacterName(row["charid"])
				local reason = tostring(row["reason"])
				mysql:free_result(mQuery) -- We got all the info we need, let's set free this query! Good luck with life, mQuery!
				local money = exports.global:getMoney(thePlayer)
				local bankmoney = getElementData(thePlayer, "bankmoney")
				local takeFromCash = math.min( money, amount )
				local takeFromBank = amount - takeFromCash
				local tax = exports.global:getTaxAmount()
			local qWeimy = mysql:query("SELECT `faction_id` FROM `characters` WHERE `id` ='"..issuerCharID.."'")
				local faggot = mysql:fetch_assoc(qWeimy)
				if not faggot then
					outputChatBox("[ERR-FGGT-WEIMY-034]", thePlayer, 255, 0, 0)
				else
				local issuerFaction = 1
					issuerFaction = tonumber(faggot["faction_id"])
				if issuerFaction == 4 then
					issuerFaction = "326 Enterprises"
				elseif issuerFaction == 1 then
					issuerFaction = "Los Santos Police Department"
				else
					issuerFaction = "San Andreas State Police"
				end
				if not exports.global:hasMoney( thePlayer, amount ) then
		
				outputChatBox( "لا يمكنك تسديد المخالفة ، ليس لديك المال الكافي .", client, 255, 0, 0 )
				return
				end
				exports.global:takeMoney(thePlayer, takeFromCash)
					mysql:free_result(mWeimy) -- Since we don't need this fucking faggot query anymore, we release him into the free.
					exports.global:giveMoney( getTeamFromName(issuerFaction), math.ceil((1-tax)*amount) )
					exports.global:giveMoney( getTeamFromName("Government of Los Santos"), math.ceil(tax*amount) )
					mysql:query_free("DELETE FROM `pd_tickets` WHERE `id`='"..mysql:escape_string(id).."'")
					outputChatBox("You have paid ticket #" ..id.." for the amount of $"..amount..".", thePlayer, 0, 255, 0)
					outputChatBox("The ticket you paid was issued to you by "..issuer.. " on behalf of " ..issuerFaction, thePlayer, 0, 255, 0)
					if takeFromBank > 0 then
						outputChatBox("Since you don't have enough money with you, $" .. exports.global:formatMoney(takeFromBank) .. " have been taken from your bank account.", thePlayer)
						exports.anticheat:changeProtectedElementDataEx(thePlayer, "bankmoney", bankmoney - takeFromBank, false)
					end
				end
			end
		end
	end
end
addEvent("payTicket", true)
addEventHandler( "payTicket", getRootElement(), payTicket )

function checkPendingTickets(thePlayer) 
	local vehID = getElementData(source, "dbid")
	local mQuery = mysql:query("SELECT `amount` FROM `pd_tickets` WHERE `vehid` ='" ..mysql:escape_string(vehID).."'")
		while true do
			local row = mysql:fetch_assoc(mQuery)
				if not row then break end
		if row then
			outputChatBox(" ** This vehicle has unpaid tickets attached to the windshield wipers go to Police Department to pay it.", thePlayer, 255, 51, 102)
		end
	mysql:free_result(mQuery)
	end
end
addEvent("onClientClickSearch", true)
addEventHandler("onVehicleEnter", getRootElement(), checkPendingTickets)
addEventHandler( "onClientClickSearch", getRootElement(), checkPendingTickets )

function it(amount, reason, veh, Name, issuetoID, plate, vehModel, area, dep, ...)
		local issuerID = getElementData(source, "account:character:id")
		local team = getPlayerTeam(source)
				--local reason = table.concat( { ... }, " " )
				mysql:query_free("INSERT INTO `pd_tickets` (`reason`, `vehid`, `amount`, `issuer`, `charid`, `plate`, `vehModel`, `area`, `dep`, `time`) VALUES ('".. mysql:escape_string(reason) .."', "..mysql:escape_string(veh)..", "..mysql:escape_string(amount)..", "..mysql:escape_string(issuerID)..", "..mysql:escape_string(issuetoID)..", '"..mysql:escape_string(plate).."', '"..mysql:escape_string(vehModel).."', '"..mysql:escape_string(area).."', '"..mysql:escape_string(dep).."', NOW() - interval 1 hour)")
				--mysql:query_free("INSERT INTO `pd_tickets` (`reason`, `vehid`, `amount`, `issuer`, `time`) VALUES ('".. mysql:escape_string(reason) .."', "..mysql:escape_string(veh)..", "..mysql:escape_string(amount)..", "..mysql:escape_string(issuerID)..", NOW() - interval 1 hour)")
				outputChatBox(" >>> Ticket successfully issued.", source, 0, 255, 0)
				local teamMembers = getPlayersInTeam(team)
				local charname = getPlayerName(source):gsub("_", " ")
				local factionID = getElementData(source, "faction")
				local factionRank = getElementData(source, "factionrank")
				local factionRanks = getElementData(team, "ranks")
				local factionRankTitle = factionRanks[factionRank]
				for key, value in ipairs(teamMembers) do
				outputChatBox("" .. factionRankTitle .. " " .. charname .." has issued a vehicle ticket to VIN " ..tonumber(veh).. " with the amount $" ..tonumber(amount).." for the reason: " ..reason.. ".", value, 0, 102, 255)
				end
			end
addEvent("onIssueSuccess", true)
addEventHandler("onIssueSuccess", getRootElement(), it)
-----------To Police--------------
--[[
function showAllTickets(myPlate)
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
--addCommandHandler("vehtickets", showAllTickets)
addEvent("onClientClickSearch", true)
addEventHandler( "onClientClickSearch", getRootElement(), showAllTickets )]]