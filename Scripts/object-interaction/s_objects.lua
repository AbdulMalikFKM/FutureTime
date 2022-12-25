--    ____        __     ____  __            ____               _           __ 
--   / __ \____  / /__  / __ \/ /___ ___  __/ __ \_________    (_)__  _____/ /_
--  / /_/ / __ \/ / _ \/ /_/ / / __ `/ / / / /_/ / ___/ __ \  / / _ \/ ___/ __/
-- / _, _/ /_/ / /  __/ ____/ / /_/ / /_/ / ____/ /  / /_/ / / /  __/ /__/ /_  
--/_/ |_|\____/_/\___/_/   /_/\__,_/\__, /_/   /_/   \____/_/ /\___/\___/\__/  
--                                 /____/                /___/                 
--Server side script: Object interaction
--Last updated 23.02.2011 by Exciter
--Copyright 2008-2011, The Roleplay Project (www.roleplayproject.com)

--[[
function triggerBilliard(player, message)
	outputChatBox(getPlayerName(player).." "..message)
	outputDebugString("object-interaction: server triggered billiard")
	exports['minigame-billiard']:startNewGame(table, source)
end
addEvent("billiardnewgame", true)
addEventHandler("billiardnewgame", getRootElement(), triggerBilliard)
--]]

--[[
function tt(element, thePlayer)
setPedAnimation(thePlayer, "carry", "crry_prtial", 0, false, true, true)
      --attachElements ( element, thePlayer, 0, 0, 5 )
exports.bone_attach:attachElementToBone (element, thePlayer, 11, -0.3, 0, 0, 0, 90, 0)
exports.notification:addNotification(thePlayer, "To Drop The Object Write /dropobject.", "info")
end
addEvent("moveWorldItemToElement", true)
addEventHandler("moveWorldItemToElement", getRootElement(), tt)

function drop()
if exports.bone_attach:isElementAttachedToBone (element) then
if exports.bone_attach:detachElementFromBone (element) then
		end
	end
end
addCommandHandler("drop", drop)]]