--
-- c_switch.lua
--

----------------------------------------------------------------
----------------------------------------------------------------
-- Effect switching on and off
--
--	To switch on:
--			triggerEvent( "switchDoF", root, true )
--
--	To switch off:
--			triggerEvent( "switchDoF", root, false )
--
----------------------------------------------------------------
----------------------------------------------------------------

--------------------------------
-- onClientResourceStart
--		Auto switch on at start
--------------------------------
local forceOnIfNoDB = false 

	function update()
		if isDepthBufferAccessible() or forceOnIfNoDB then 
			triggerEvent( "switchDoF", resourceRoot, 0 )
				if getElementData(localPlayer, "dynamic_lighting") ~= "0" then
					triggerEvent( "switchDoF", resourceRoot, true )
					else
					triggerEvent( "switchDoF", resourceRoot, false )
				end
		else
			outputChatBox('DoF: Depth Buffer not supported',255,0,0) return 
		end
	end
addEventHandler( "onClientResourceStart", getResourceRootElement( getThisResource()), update)
addEvent("accounts:settings:dynamic_lighting", false)
addEventHandler( "accounts:settings:dynamic_lighting", root, update )

--------------------------------
-- Switch effect on or off
--------------------------------
function switchDoF( aaOn )
	outputDebugString( "switchDoF: " .. tostring(aaOn) )
	if aaOn then
		enableDoF()
	else
		disableDoF()
	end
end

addEvent( "switchDoF", true )
addEventHandler( "switchDoF", resourceRoot, switchDoF )
