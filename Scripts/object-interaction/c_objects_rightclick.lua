local debugModelOutput = false

local showering = {}
Interaction = {}
local function getFancyRotation( rx, ry, rz )
  local t = {rx, ry, rz}
  for i = 0, 360, 45 do
    for k, v in ipairs(t) do
      if v > i-0.6 and v < i+0.6 then
        t[k] = i%360
      end
    end
  end
  return unpack(t)
end

rightclick = exports.rightclick

global = exports.global

integration = exports.integration

itemworld = exports['item-world']

item = exports['item-system']

localPlayer = getLocalPlayer()

depth = 5

local noMenuFor = {

	[0] = true, --nothing

}

local noPickupFor = {

	[81] = true, --fridge

	[103] = true, --shelf

}

local noPropertiesFor = {

	

}
function moveObjectDx()
	if moveElement then
	exports.interaction:createElementOutlineEffect(moveElement, true)
	--[[
		local x, y, z1 = getElementPosition(moveElement)
		dxDrawLine3D ( x, y+1, z1, x, y, z1, tocolor ( 255, 0, 0, 230 ),2,true)--x
		dxDrawLine3D ( x+1, y, z1, x, y, z1, tocolor ( 0, 255, 0, 230 ),2,true)--y
		dxDrawLine3D ( x, y, z1, x, y, z1+1, tocolor ( 0, 0, 255, 230 ),2,true)--z]]
	end
end

function mouseMove(cursorX, cursorY, absoluteX, absoluteY, worldX, worldY, worldZ)
	if moveElement then
		absoluteX, absoluteY = absoluteX, absoluteY
		local worldX, worldY, worldZ = getWorldFromScreenPosition ( absoluteX, absoluteY, depth )
		setElementPosition(moveElement, worldX, worldY, worldZ)
	end
end
function mouseUp()
	if moveElement then
		if depth < 10 then
			depth = depth + 1
			local worldX, worldY, worldZ = getWorldFromScreenPosition ( absoluteX, absoluteY, depth )
			setElementPosition(moveElement, worldX, worldY, worldZ)
		end
	end
end
bindKey("mouse_wheel_up","down",mouseUp)

function rot()
	if moveElement then
		local worldX, worldY, worldZ = getElementPosition(moveElement)
		local rx, ry, rz = getFancyRotation(getElementRotation(moveElement))
		local newz = setElementRotation(moveElement, rx, ry, rz-1.5)
			moveObject(moveElement, 1000, worldX, worldY, worldZ, rx, ry, newz)
	end
end
bindKey("arrow_l","up",rot)

function fastrot(key) 
    if (key == "arrow_l") then 
            if (getKeyState("lshift")) then 
	if moveElement then
		local worldX, worldY, worldZ = getElementPosition(moveElement)
		local rx, ry, rz = getFancyRotation(getElementRotation(moveElement))
		local newz = setElementRotation(moveElement, rx, ry, rz-10)
			moveObject(moveElement, 1000, worldX, worldY, worldZ, rx, ry, newz)
			end
		end  
	end  
end  
bindKey("arrow_l", "down", fastrot) 

function rot3ks()
	if moveElement then
		local worldX, worldY, worldZ = getElementPosition(moveElement)
		local rx, ry, rz = getFancyRotation(getElementRotation(moveElement))
		local newz = setElementRotation(moveElement, rx, ry, rz+1.5)
			moveObject(moveElement, 1000, worldX, worldY, worldZ, rx, ry, newz)
	end
end
bindKey("arrow_r","up",rot3ks)

function fastrot3ks(key) 
    if (key == "arrow_r") then 
            if (getKeyState("lshift")) then 
	if moveElement then
		local worldX, worldY, worldZ = getElementPosition(moveElement)
		local rx, ry, rz = getFancyRotation(getElementRotation(moveElement))
		local newz = setElementRotation(moveElement, rx, ry, rz+10)
			moveObject(moveElement, 1000, worldX, worldY, worldZ, rx, ry, newz)
			end
		end  
	end  
end  
bindKey("arrow_r", "down", fastrot3ks) 
-----------
function rotup()
	if moveElement then
		local worldX, worldY, worldZ = getElementPosition(moveElement)
		local rx, ry, rz = getFancyRotation(getElementRotation(moveElement))
		local newx = setElementRotation(moveElement, rx-1.5, ry, rz)
			moveObject(moveElement, 1000, worldX, worldY, worldZ, newx, ry, rx)
	end
end
bindKey("arrow_u","up",rotup)

function fastrotup(key)
    if (key == "arrow_u") then 
            if (getKeyState("lshift")) then 
	if moveElement then
		local worldX, worldY, worldZ = getElementPosition(moveElement)
		local rx, ry, rz = getFancyRotation(getElementRotation(moveElement))
		local newx = setElementRotation(moveElement, rx-10, ry, rz)
			moveObject(moveElement, 1000, worldX, worldY, worldZ, newx, ry, rx)
			end
		end  
	end  
end  
bindKey("arrow_u", "down", fastrotup) 

function rotdown()
	if moveElement then
		local worldX, worldY, worldZ = getElementPosition(moveElement)
		local rx, ry, rz = getFancyRotation(getElementRotation(moveElement))
		local newx = setElementRotation(moveElement, rx+1.5, ry, rz)
			moveObject(moveElement, 1000, worldX, worldY, worldZ, newx, ry, rz)
	end
end
bindKey("arrow_d","up",rotdown)

function fastrotup(key) 
    if (key == "arrow_d") then 
            if (getKeyState("lshift")) then 
	if moveElement then
		local worldX, worldY, worldZ = getElementPosition(moveElement)
		local rx, ry, rz = getFancyRotation(getElementRotation(moveElement))
		local newx = setElementRotation(moveElement, rx+10, ry, rz)
			moveObject(moveElement, 1000, worldX, worldY, worldZ, newx, ry, rz)
			end
		end  
	end  
end  
bindKey("arrow_d", "down", fastrotup) 
---------------
function mouseDown()
	if moveElement then
		if depth > 0 then
			depth = depth - 1
			local worldX, worldY, worldZ = getWorldFromScreenPosition ( absoluteX, absoluteY, depth )
			setElementPosition(moveElement, worldX, worldY, worldZ)
		end
	end
end
bindKey("mouse_wheel_down","down",mouseDown)

Interaction.Close = function()
    exports.interaction:destroyElementOutlineEffect(moveElement)
    removeEventHandler("onClientRender", root, moveObjectDx)
end

function Close()
			Interaction.Close()
end
bindKey("mouse1","down",Close)

function mouseClick( button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedWorld)
	if moveElement then
		if getKeyState("mouse1") then
		local x, y, z1 = getWorldFromScreenPosition ( absoluteX, absoluteY, depth )
		local rx, ry, rz = getElementRotation(moveElement)
			triggerServerEvent( 'item:move:save', moveElement, x, y, z1, rx, ry, rz )
			setElementCollisionsEnabled(moveElement, true)
			setTimer(function()
			setElementData(moveElement, "moving", false)
			moveElement = false
			exports.interaction:destroyElementOutlineEffect(moveElement)
			removeEventHandler("onClientRender", root, moveObjectDx)
			removeEventHandler( "onClientCursorMove", root, mouseMove)
			removeEventHandler( "onClientClick", root, mouseClick)
			end, 100,1)
		end
	end
end
function moveObjectWithCruser(element)
	moveElement = element
	setElementCollisionsEnabled(element, false)
	setElementData(moveElement, "moving", true)
	addEventHandler("onClientRender", root, moveObjectDx)
	addEventHandler( "onClientCursorMove", root, mouseMove)
	addEventHandler( "onClientClick", root, mouseClick)
end

function clickObject(button, state, absX, absY, wx, wy, wz, element)

	rightclick = exports.rightclick

	global = exports.global

	integration = exports.integration

	itemworld = exports['item-world']

	item = exports['item-system']



	--outputDebugString("You clicked a "..tostring(getElementType(element)).." ("..tostring(getElementModel(element))..")")

	if getElementData(localPlayer, "exclusiveGUI") then

		return

	end

	if (element) and (getElementType(element)=="object") and (button=="right") and (state=="down") then

		local x, y, z = getElementPosition(getLocalPlayer())

		local eX, eY, eZ = getElementPosition(element)

		local minX, minY, minZ, maxX, maxY, maxZ = getElementBoundingBox(element)

		local addDistance = 0 --compensate for object size
		
		--triggerServerEvent("dropTheObject", getLocalPlayer(), element)	

		if minX then

			local boundingBoxBiggestDist = 0

			if minX > boundingBoxBiggestDist then

				boundingBoxBiggestDist = minX

			end

			if minY > boundingBoxBiggestDist then

				boundingBoxBiggestDist = minY

			end

			if maxX > boundingBoxBiggestDist then

				boundingBoxBiggestDist = maxX

			end

			if maxY > boundingBoxBiggestDist then

				boundingBoxBiggestDist = maxY

			end

			addDistance = boundingBoxBiggestDist

		end

		local maxDistance = 3 + addDistance

		if (getDistanceBetweenPoints3D(x, y, z, wx, wy, wz)<=maxDistance) then

			local rcMenu

			local row = {}



			if getElementParent(getElementParent(element)) == getResourceRootElement(getResourceFromName("item-world")) then

				local itemID = tonumber(getElementData(element, "itemID")) or 0

				if noMenuFor[itemID] then return end

				local itemValue = getElementData(element, "itemValue")

				local itemName = tostring(global:getItemName(itemID))

				

				if itemID == 81 then --fridge

					if itemworld:can(localPlayer, "use", element) then

						if not rcMenu then rcMenu = rightclick:create(itemName) end

						row.a = rightclick:addrow("Open fridge")

						addEventHandler("onDgsMouseClickUp", row.a,  function (button, state)

							if not getElementData ( localPlayer, "exclusiveGUI" ) then

								triggerServerEvent( "openFreakinInventory", getLocalPlayer(), element, absX, absY )

							end						

						end, false)

					end

				elseif itemID == 103 then --shelf

					if itemworld:can(localPlayer, "use", element) then

						if not rcMenu then rcMenu = rightclick:create(itemName) end

						row.a = rightclick:addrow("Browse shelf")

						addEventHandler("onDgsMouseClickUp", row.a,  function (button, state)

							if not getElementData ( localPlayer, "exclusiveGUI" ) then

								triggerServerEvent( "openFreakinInventory", getLocalPlayer(), element, absX, absY )

							end						

						end, false)

					end

				elseif itemID == 166 then --video system

					if itemworld:can(localPlayer, "use", element) then

						rcMenu = rightclick:create(itemName)

						if global:hasItem(element, 165) then --if disc in

							row.a = rightclick:addrow("Eject Disc")

							addEventHandler("onDgsMouseClickUp", row.a,  function (button, state)

								triggerServerEvent("clubtec:vs1000:ejectDisc", getLocalPlayer(), element)

							end, false)

						end

						row.b = rightclick:addrow("Control")

						addEventHandler("onDgsMouseClickUp", row.b,  function (button, state)

							triggerServerEvent("clubtec:vs1000:gui", getLocalPlayer(), element)

						end, false)

					end

				end



				--if item:getItemUseNewPickupMethod(itemID) then

					--[[

					if item:canItemBeMoved(itemID) then

						if itemworld:can(localPlayer, "move", element) then

							if not rcMenu then rcMenu = rightclick:create(itemName) end

							row.move = rightclick:addrow("Move")

						end						

					end

					--]]

				--end

				if not noPickupFor[itemID] and itemworld:can(localPlayer, "pickup", element) then

					if not rcMenu then rcMenu = rightclick:create(itemName) end

					row.pickup = rightclick:addrow("Pick Up")

					addEventHandler("onDgsMouseClickUp", row.pickup,  function (button, state)

						--triggerServerEvent("moveWorldItemToElement", localPlayer, element, localPlayer)
						triggerServerEvent("pickupItem", localPlayer, element, localPlayer)

					end, false)

						if itemworld:can(localPlayer, "move", element) then
					row.move = rightclick:addrow("Move")

					addEventHandler("onDgsMouseClickUp", row.move,  function (button, state)

						moveObjectWithCruser(element)
					end, false)
					
					end
						
				end
				
				if not noPropertiesFor[itemID] and itemworld:canEditItemProperties(localPlayer, element) then

					if not rcMenu then rcMenu = rightclick:create(itemName) end

					row.properties = rightclick:addrow("Properties")

					addEventHandler("onDgsMouseClickUp", row.properties,  function (button, state)

						triggerEvent("showItemProperties", localPlayer, element)

					end, false)						

				end

			end





			local model = getElementModel(element)

			if(model == 2517) then --SHOWERS

				rcMenu = exports.rightclick:create("Shower")

				if showering[1] then

					row.a = exports.rightclick:addrow("Stop showering")

					addEventHandler("onDgsMouseClickUp", row.a,  function (button, state)

						takeShower(element)

					end, false)
					
				else

					row.a = exports.rightclick:addrow("Take a shower")

					addEventHandler("onDgsMouseClickUp", row.a,  function (button, state)

						takeShower(element)

					end, false)

				end

			--[[elseif(model == 2964) then --Pool table / Billiard

				rcMenu = exports.rightclick:create("Pool Table")

				row.a = exports.rightclick:addrow("New Game")

				addEventHandler("onDgsMouseClickUp", row.a,  function (button, state)

					outputDebugString("object-interaction: triggering billiard")

					--exports['minigame-billiard'].startNewGame(element, getLocalPlayer())

					triggerServerEvent("sendLocalMeAction", getLocalPlayer(), getLocalPlayer(), "test message")

					triggerServerEvent("billiardnewgame", getLocalPlayer(), getLocalPlayer(), "test message")

					local result = triggerServerEvent("newBilliardGame", getLocalPlayer(), element)

					outputDebugString("server trigger "..tostring(result)..", "..tostring(element))

					

				end, true)

			--]]

			elseif(model == 2146) then --Stretcher (ES)

				rcMenu = exports.rightclick:create("Stretcher")

				row.a = exports.rightclick:addrow("Take Stretcher")				

				addEventHandler("onDgsMouseClickUp", row.a,  function (button, state)

					triggerServerEvent("stretcher:takeStretcher", localPlayer, element)	

				end, true)
			

			elseif(model == 962) then --Airport gate control box

				local airGateID = getElementData(element, "airport.gate.id")

				if airGateID then

					rcMenu = exports.rightclick:create("Control Box")

					row.a = exports.rightclick:addrow("Control Gate")				

					addEventHandler("onDgsMouseClickUp", row.a,  function (button, state)

						triggerEvent("airport-gates:controlGUI", getLocalPlayer(), element)	

					end, false)			

				end

			elseif(model == 1819) then --Airport fuel

				local airFuel = getElementData(element, "airport.fuel")

				if airFuel then

					outputDebugString("Air fuel: TODO")

				end

			else

				if debugModelOutput then

					outputChatBox("Model ID "..tostring(model))

				end

			end

		end

	end

end

addEventHandler("onClientClick", getRootElement(), clickObject, true)

function debugToggleModelOutput(thePlayer, commandName)

	if exports.integration:isPlayerScripter(thePlayer) then

		debugModelOutput = not debugModelOutput

		outputChatBox("DBG: ModelOutput set to "..tostring(debugModelOutput))

	end

end

addCommandHandler("debugmodeloutput", debugToggleModelOutput)


function refreshCalls(res)

	rightclick = exports.rightclick

	global = exports.global

	integration = exports.integration

	itemworld = exports['item-world']

	item = exports['item-system']

end

addEventHandler("onClientResourceStart", getRootElement(), refreshCalls)

fileDelete("c_objects_rightclick.lua")