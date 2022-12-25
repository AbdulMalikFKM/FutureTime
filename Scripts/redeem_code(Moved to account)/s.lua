
addEventHandler( "onResourceStart", resourceRoot,
	function()
	    logDB = dbConnect("sqlite", "Log.db")
        dbExec(logDB, "CREATE TABLE IF NOT EXISTS LogTable ( Player, Type, Prize, ID, Times, Code, gTime )")
	end 
)

Prize = nil
Code = nil
ID = nil
--[[
function checkPremissions (thePlayer)
	if not (exports.global:getPlayerAdminLevel(thePlayer) >= 2) then
		exports.notification:addNotification(thePlayer, "You Must Be At Least Admin!", "warning")
	else
	exports.notification:addNotification(thePlayer, "Welcome To The Adminstrator Panel!", "success")
		triggerClientEvent(thePlayer, "openRedemCodes", thePlayer)
	end
end
addCommandHandler("open", checkPremissions)
]]
function getCodePrize(cr, ca, Prize, ID, Type)
if cr and ca and Prize and ID and Type then
makeThePrize = Prize
ID = ID
getTheType = Type
end
end
addEvent("CheckTheWord", true)
addEventHandler("CheckTheWord", root, getCodePrize)

function test(cr, ca, Prize, ID, Type)
if cr == ca and wordOn == true and ID then
onPlayerWin(source)
removeCode()
ID = ID
else
exports.notification:addNotification(source, "This Code is Not Avilable Now!", "warning")
end
end
addEvent("CheckTheWord", true)
addEventHandler("CheckTheWord", root, test)

function onPlayerWin(player)
local getThePrize = getCodePrize(Code)
outputChatBox("#FFAA00[Redeem Code] #B22222["..getPlayerName(player).."] #00FF7FWon The Prize", getRootElement(), 255, 0, 0, true )
exports.guimessages:outputServer(source, "#FFAA00[Redeem Code] #B22222["..getPlayerName(player).."] #00FF7FWon!! The Prize", 255, 255, 255)

if getTheType == 0 then -- Money
exports.global:giveMoney(player, makeThePrize)
exports.TNShelp:ouPutDxWinnerForPlayer(player, "You Earned Money", 5, 255, 0, 255)
exports.TNShelp:OnServerSendMessage(player, "[+"..makeThePrize.."$]", 5, 255, 0, 255)

elseif getTheType == 1 then -- GC
exports.donators:giveGC(player, makeThePrize)
exports.TNShelp:ouPutDxWinnerForPlayer(player, "You Earned GC", 5, 255, 0, 255)
exports.TNShelp:OnServerSendMessage(player, "[+"..makeThePrize.."] GC", 5, 255, 0, 255)

elseif getTheType == 2 then -- Vehicle Token's
exports.global:giveItem(player, 1000, makeThePrize)
exports.TNShelp:ouPutDxWinnerForPlayer(player, "You Get Vehilce Token's", 5, 255, 0, 255)

elseif getTheType == 3 then -- House Token's
exports.global:giveItem(player, 1001, makeThePrize)
exports.TNShelp:ouPutDxWinnerForPlayer(player, "You Get House Token's", 5, 255, 0, 255)

elseif getTheType == 4 then -- SIM
exports.global:giveItem(player, 230, makeThePrize)
exports.TNShelp:ouPutDxWinnerForPlayer(player, "You Get Special SIM", 5, 255, 0, 255)
exports.TNShelp:OnServerSendMessage(player, "The Number is ["..makeThePrize.."]", 5, 255, 0, 255)

elseif getTheType == 5 then -- SooN
exports.global:giveItem(player, ID, makeThePrize)
end
end

addEvent("MakeTheCode", true)
addEventHandler("MakeTheCode", root,
function (Player, Code, TypeText, Prize, TimeText, ID, gTime)
--local Data = getData()
dbExec(logDB, "INSERT INTO LogTable VALUES(?, ?, ?, ?, ?, ?, ?)", Player, TypeText, Prize, ID, TimeText, Code, gTime)
exports.guimessages:outputServer(source, "#FFAA00[Redeem Code] : #B22222The Admin ["..Player.."] #58FAF4Make Code ["..Code.."] #00FF7FWith Type ["..TypeText.."] #20B2AA And The Amount is ["..Prize.."] #708090The Time Will Be ["..TimeText.."]", 255, 255, 255)
outputChatBox ( "#FFAA00[Redeem Code] : #B22222The Admin ["..Player.."] #58FAF4Make Code ["..Code.."] #00FF7FWith Type ["..TypeText.."] #20B2AA And The Amount is ["..Prize.."] #708090The Time Will Be ["..TimeText.."]", getRootElement(), 255, 0, 0, true )
wordOn = true
if rt == "1 Min" then
    codeTimer = setTimer(function ()
        removeCode()
		outputChatBox("Time End And No One Won The Prize!",root,0,255,0,true)
end, 60000, 1)
elseif rt == "5 Min" then
    codeTimer = setTimer(function ()
        removeCode()
		outputChatBox("Time End And No One Won The Prize!",root,0,255,0,true)
end, 300000, 1)
elseif rt == "1 Hour" then
    codeTimer = setTimer(function ()
        removeCode()
		outputChatBox("Time End And No One Won The Prize!",root,0,255,0,true)
end, 3600000, 1)
end
end)

addEvent('Log:GetTheLog',true)
addEventHandler('Log:GetTheLog',root,function()
local logs=dbPoll(dbQuery(logDB,'SELECT * FROM LogTable'),-1)
triggerClientEvent(source,'Log:SetTheLog',source,logs)

end)

function Refresh()
local logs=dbPoll(dbQuery(logDB,'SELECT * FROM LogTable'),-1)
triggerClientEvent(source,'Log:SetTheLog',source,logs)
end

function removeCode()
	if isTimer ( codeTimer ) then
		killTimer(codeTimer)
	end
	Code = nil
	Prize = nil
	wordOn = false
end
