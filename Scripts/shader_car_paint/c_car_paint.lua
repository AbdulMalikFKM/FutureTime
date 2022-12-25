--
-- c_car_paint.lua
--

local renderTarget = {RTColor = nil, RTNormal = nil, isOn = false}
local scx, scy = guiGetScreenSize()

function startCarPaint()
		if cpEffectEnabled then return end
		-- Create shader
		if renderTarget.isOn then
			carPaintShader, tec = dxCreateShader ( "fx/car_paint_dl.fx", 2, 0, false, "vehicle" )
		else
			carPaintShader, tec = dxCreateShader ( "fx/car_paint.fx", 2, 50, false, "vehicle" )
		end

		if carPaintShader then
			outputDebugString( "dl_carPaint: Using technique " .. tec )
			
			if renderTarget.isOn then
				dxSetShaderValue( carPaintShader, "ColorRT", renderTarget.RTColor )
				dxSetShaderValue( carPaintShader, "NormalRT", renderTarget.RTNormal )
			end

			-- Set textures
			myScreenSource = dxCreateScreenSource( scx, scy)			

			dxSetShaderValue ( carPaintShader, "sTextureRef", myScreenSource )
			
			dxSetShaderValue( carPaintShader, "sEffectFade", 50, 40)
			
			-- Apply to world texture
			engineApplyShaderToWorldTexture ( carPaintShader, "*" )
			engineRemoveShaderFromWorldTexture ( carPaintShader, "unnamed" )

			cpEffectEnabled = true	
			addEventHandler( "onClientHUDRender", root, updateScreen )
		else	
			outputChatBox( "dl_carPaint: Could not create shader.",255,0,0 ) return		
		end
end

function stopCarPaint()
	if not cpEffectEnabled then return end
	removeEventHandler( "onClientHUDRender", root, updateScreen )
	engineRemoveShaderFromWorldTexture ( carPaintShader,"*" )
	destroyElement( carPaintShader )
	destroyElement( myScreenSource )
	carPaintShader = nil
	myScreenSource = nil
	cpEffectEnabled = false
end

function updateScreen()
	if myScreenSource then
		dxUpdateScreenSource( myScreenSource)
	end
end

----------------------------------------------------------------------------------------------------------------------------
-- onClientResourceStart/Stop
----------------------------------------------------------------------------------------------------------------------------
addEventHandler ( "onClientResourceStart", root, function(startedRes)
	switchDREffect(getResourceName(startedRes), true)
end
)

addEventHandler ( "onClientResourceStop", root, function(stoppedRes)
	switchDREffect(getResourceName(stoppedRes), false)
end
)

function switchDREffect(resName, isStarted)
	if isStarted then
		if resName == "dl_core" then
			local isCoreOn = getElementData ( localPlayer, "dl_core.on", false )
			if renderTarget.isOn and isCoreOn then return end
			renderTarget.isOn = isCoreOn
			if renderTarget.isOn then
				renderTarget.RTColor, renderTarget.RTNormal = exports.dl_core:getRenderTargets()
			end
			if renderTarget.RTColor and renderTarget.RTNormal then
				if cpEffectEnabled then
					stopCarPaint()
					startCarPaint()
				end
				renderTarget.isOn = true
			end
		end	
	else
		if not renderTarget.isOn then return end
		if resName == "dl_core" then
			if cpEffectEnabled then
				stopCarPaint()
				renderTarget.isOn = false
				startCarPaint()
			end
		end	
	end
end

addEventHandler ( "onClientResourceStart", resourceRoot, function()
	renderTarget.isOn = getElementData ( localPlayer, "dl_core.on", false )
	if renderTarget.isOn then 
		renderTarget.RTColor, renderTarget.RTNormal = exports.dl_core:getRenderTargets()
		if renderTarget.RTColor and renderTarget.RTNormal then
			renderTarget.isOn = true
		end
	end
	triggerEvent( "onClientSwitchCarPaint", resourceRoot, true )
end
)

addEvent( "switchDL_core", true )
addEventHandler( "switchDL_core", root, function(isOn) switchDREffect("dl_core", isOn) end)