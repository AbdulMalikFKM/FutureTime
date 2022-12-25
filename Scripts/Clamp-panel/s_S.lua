Noti = exports['info-box']
function PutClamp(vehicle)
	if getElementData(vehicle, "veiculo.trava") == false then
	    setElementFrozen(vehicle, true)
		setElementData(vehicle, "handbreak", 0)
		setElementData(vehicle, "veiculo.trava", true)
		exports.global:applyAnimation(source, "bomber", "bom_plant", 4000, false, true, true)
		Noti:showInfobox(source, "success", "The clamp has been successfully put!", "", ":interaction/icons/wheelclamp.png", {25, 155, 0, 255})
	else
		Noti:showInfobox(source, "warning", "The clamp is already install!", "", ":interaction/icons/wheelclamp.png", {155, 25, 0, 255})
	end
end
addEvent("GRRP:PutClamp", true)
addEventHandler("GRRP:PutClamp", root, PutClamp)

function RemoveClamp(vehicle)
	if getElementData(vehicle, "veiculo.trava") == false then
		--exports.notification:addNotification(source, "لايوجد اصفاد على المركبة", "info")
	else
	Noti:showInfobox(source, "success", "The clamp has been successfully remove!", "", ":interaction/icons/wheelclamp.png", {25, 155, 0, 255})
		exports.global:applyAnimation(source, "bomber", "bom_plant", 4000, false, true, true)
		setElementData(vehicle,"veiculo.trava", false)
		setElementFrozen(vehicle, false)
		setElementData(vehicle, "handbreak", 1)
	end
end
addEvent("GRRP:RemoveClamp", true)
addEventHandler("GRRP:RemoveClamp", root, RemoveClamp)