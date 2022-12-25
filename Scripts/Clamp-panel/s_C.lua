
addEvent("PutClamp", true)
addEventHandler("PutClamp", root,
function (vehicle)
setElementData(vehicle, "VehicleClamp", 1)
Fechar()
triggerServerEvent("GRRP:PutClamp", localPlayer, vehicle)
end)

addEvent("RemoveClamp", true)
addEventHandler("RemoveClamp", root,
function (vehicle)
setElementData(vehicle, "VehicleClamp", 0)
Fechar()
triggerServerEvent("GRRP:RemoveClamp", localPlayer, vehicle)
end)

function Fechar(element)
    if painel then
        painel = false
        showCursor(false)
		setElementFrozen(localPlayer, false)
    end
end

addEventHandler("onClientKey", getRootElement(),
	function (key, press)
		if isPedInVehicle(localPlayer) and getPedOccupiedVehicleSeat(localPlayer) == 0 then
			local theVeh = getPedOccupiedVehicle(localPlayer)

			if getElementModel(theVeh) then
				local state = getElementData(theVeh, "veiculo.trava") or false

				if state ~= false then
					local task = getPedSimplestTask(localPlayer)

					if task == "TASK_SIMPLE_CAR_GET_OUT" or task == "TASK_SIMPLE_CAR_CLOSE_DOOR_FROM_OUTSIDE" then
						return
					end

					local keys = {}

					for k, v in pairs(getBoundKeys("accelerate")) do
						table.insert(keys, k)
					end

					for k, v in pairs(getBoundKeys("brake_reverse")) do
						table.insert(keys, k)
					end

					for k, v in pairs(keys) do
						if v == key then
							cancelEvent()

							if press then
							exports['cr_infobox']:addBox("error", "You can't move because of the clamp in the wheel")
								--outputChatBox("لايمكنك التحرك بسبب وجود الاصفاد على المركبة", 255, 255, 255, true)
							end
						end
					end
				end
			end
		end
	end
)
