--
-- c_switch.lua
--

----------------------------------------------------------------
----------------------------------------------------------------
-- Effect switching on and off
--
--	To switch on:
--			triggerEvent( "onClientSwitchCarPaint", root, true )
--
--	To switch off:
--			triggerEvent( "onClientSwitchCarPaint", root, false )
--
----------------------------------------------------------------
----------------------------------------------------------------

--------------------------------
-- onClientResourceStart
--		Auto switch on at start
--------------------------------
	function update()
		--outputDebugString('/carpaint to switch the effect')
		--addCommandHandler( "carpaint",
			--function()
		if getElementData(localPlayer, "graphic_shaderveh") ~= "0" then
				triggerEvent( "onClientSwitchCarPaint", resourceRoot, true )
				else
				triggerEvent( "onClientSwitchCarPaint", resourceRoot, false )
			end
		--)
	end
addEventHandler( "onClientResourceStart", getResourceRootElement( getThisResource()), update)
addEvent("accounts:settings:graphic_shaderveh", false)
addEventHandler( "accounts:settings:graphic_shaderveh", root, update )


--------------------------------
-- Switch effect on or off
--------------------------------
function handleOnClientSwitchCarPaint( cpOn )
	outputDebugString( "switchCarPaint: " .. tostring(cpOn) )
	if cpOn then
		startCarPaint()
	else
		stopCarPaint()
	end
end

addEvent( "onClientSwitchCarPaint", true )
addEventHandler( "onClientSwitchCarPaint", resourceRoot, handleOnClientSwitchCarPaint )
