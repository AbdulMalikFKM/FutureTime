local w, h = guiGetScreenSize( );
local x1, y1, z1 = getCameraMatrix()
local sx1, sy1 = getScreenFromWorldPosition(x1, y1, z1)
local enable = false;

--[[
	function update( )
		if getElementData(localPlayer, "graphic_motionblur") ~= "0" then
		enableBlackWhite()
		--bindKey( "u", "up", enableBlackWhite );
		end
	end
addEventHandler( "onClientResourceStart", getResourceRootElement( getThisResource() ), update)
addEvent("accounts:settings:graphic_motionblur", false)
addEventHandler( "accounts:settings:graphic_motionblur", root, update )
]]
function findRotation(x1,y1,x2,y2)
 
  local t = -math.deg(math.atan2(x2-x1,y2-y1))
  if t < 0 then t = t + 360 end;
  return t;
 
end

function renderEffect( )	
	local x2, y2, z2 = getCameraMatrix()
	
	local d = getDistanceBetweenPoints3D(x1, y1, z1, x2, y2, z2);
	
	sx2, sy2 = w/2, h/2
	
	local dx = x1 - x2
	local dy = y1 - y2
	local dz = z1 - z2
	
	if getPedOccupiedVehicle(getLocalPlayer()) then
		multiplier = 0.0003
	else
		multiplier = 0.0008
	end
	
	dxSetShaderValue( screenShader, "BlurAmount", d*multiplier );
	dxSetShaderValue( screenShader, "Angle", findRotation(dx, dx, dx, dz)) -- Fail code, but gives a nice effect
	
	dxSetRenderTarget();
	dxUpdateScreenSource( screenSrc );
	dxDrawImage( 0, 0, w, h, screenShader );
	
	x1, y1, z1 =  getCameraMatrix()
end

function update( )
	enable = not enable;
			if getElementData(localPlayer, "graphic_motionblur") ~= "0" then
	--if enable then
		--outputChatBox("Motion Blur Enabled")
		screenShader = dxCreateShader( "motion.fx" );
		screenSrc = dxCreateScreenSource( w, h );
		if screenShader and screenSrc then
			dxSetShaderValue( screenShader, "ScreenTexture", screenSrc );
			addEventHandler( "onClientHUDRender", getRootElement( ), renderEffect );
		end
	else
		if screenShader and screenSrc then
			--outputChatBox("Motion Blur Disabled")
			destroyElement( screenShader );
			destroyElement( screenSrc );
			screenShader, screenSrc = nil, nil;
			removeEventHandler( "onClientHUDRender", getRootElement( ), renderEffect );
		end
	end
end
addEventHandler( "onClientResourceStart", getResourceRootElement( getThisResource() ), update)
addEvent("accounts:settings:graphic_motionblur", false)
addEventHandler( "accounts:settings:graphic_motionblur", root, update )