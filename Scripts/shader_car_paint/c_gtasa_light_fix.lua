--
-- c_gtasa_light_fix.lua
--

----------------------------------------------------------------------------------------------------------------------------
-- GTASA vehicle pointlight 'fix'
----------------------------------------------------------------------------------------------------------------------------
local attachedLight = nil
addEventHandler( "onClientPedsProcessed", root, 
function()
	if not attachedLight then 
		attachedLight = createLight ( 0, 0,0,0, 60, 1,0,0 )
		return 
	end
	setElementPosition(attachedLight, getElementPosition(getCamera()))	
end
)