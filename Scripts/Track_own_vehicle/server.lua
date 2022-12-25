
addEvent("Track", true)
addEventHandler("Track", getRootElement(),
function (id, vin)
			 
			local theVehicle = exports.pool:getElement("vehicle", tonumber(id))
			if theVehicle then
			local vehicleOwner = getElementData(theVehicle, "owner") or -1
	        local playerID = getElementData(source, "dbid") or 0
            if vehicleOwner == playerID then
				exports.logs:dbLog(source, 6, theVehicle, vin)
				exports.global:takeItem(source, 233)
				exports.global:giveItem(source, 234, tonumber(id))
				exports.notification:addNotification(source, "تم وضع جهاز التعقب بنجاح , يمكنك التحكم به عن طريق الريموت", "success")


			else
				exports.notification:addNotification(source, "لايمكنك وضع جهاز التعقب على مركبة لا تملكها", "warning")
				end
          end			
   end)

addEvent("Tracking", true)
addEventHandler("Tracking", getRootElement(),
function (id, idi)
			 
			local theVehicle = exports.pool:getElement("vehicle", tonumber(id))
			if theVehicle then
			local vehicleOwner = getElementData(theVehicle, "owner") or -1
	        local playerID = getElementData(source, "dbid") or 0
            if vehicleOwner == playerID then
				exports.logs:dbLog(source, 6, theVehicle, idi)
	Vehicleb = createBlipAttachedTo(theVehicle, 23, 2, 255, 0, 0, 255, 0, 65535, source)

				end
          end			
   end)
   
   
	setTimer ( function()
	destroyElement(Vehicleb)
	end, 50000, 0 )
	