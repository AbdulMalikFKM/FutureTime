--
-- c_switch.lua
--

----------------------------------------------------------------
----------------------------------------------------------------
-- Effect switching on and off
--
--	To switch on:
--			triggerEvent( "switchCarPaintReflect", root, true )
--
--	To switch off:
--			triggerEvent( "switchCarPaintReflect", root, false )
--
----------------------------------------------------------------
----------------------------------------------------------------

--------------------------------
-- onClientResourceStart
--		Auto switch on at start
--------------------------------

	function update()
		if not (tonumber(dxGetStatus().VideoCardPSVersion) > 2) then 
			outputChatBox('sCarReflect: Shader model 3 not supported',255,0,0)
			return
		end
		if getElementData(localPlayer, "graphic_shaderveh_reflect") ~= "0" then
		triggerEvent( "switchCarPaintReflect", resourceRoot, true )
			else
		triggerEvent( "switchCarPaintReflect", resourceRoot, false )
		end
	end
addEventHandler( "onClientResourceStart", getResourceRootElement( getThisResource()), update)
addEvent("accounts:settings:graphic_shaderveh_reflect", false)
addEventHandler( "accounts:settings:graphic_shaderveh_reflect", root, update )

--------------------------------
-- Switch effect on or off
--------------------------------
function switchCarPaintReflect( cprOn )
	outputDebugString( "switchCarPaintReflect: " .. tostring(cprOn) )
	if cprOn then
		startCarPaintReflect()
	else
		stopCarPaintReflect()
	end
end

addEvent( "switchCarPaintReflect", true )
addEventHandler( "switchCarPaintReflect", resourceRoot, switchCarPaintReflect )
