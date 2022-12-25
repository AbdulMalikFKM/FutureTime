addEventHandler('onClientResourceStart', resourceRoot, 
function() 

    local txd = engineLoadTXD('files/transportcart.txd',true)
    engineImportTXD(txd, 8287)
	
	local dff = engineLoadDFF('files/transportcart.dff', 0) 
	engineReplaceModel(dff, 8287)

	local col = engineLoadCOL('files/transportcart.col') 
	engineReplaceCOL(col, 8287)
	
	local txd = engineLoadTXD('files/platform.txd',true)
    engineImportTXD(txd, 8286)
	
	local dff = engineLoadDFF('files/platform.dff', 0) 
	engineReplaceModel(dff, 8286)

	local col = engineLoadCOL('files/platform.col') 
	engineReplaceCOL(col, 8286)
	
	engineSetModelLODDistance(8287)	
	engineSetModelLODDistance(8286)	
	
end 
)