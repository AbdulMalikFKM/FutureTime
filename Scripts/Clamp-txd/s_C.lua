txd = engineLoadTXD ( "objeto/trava.txd" )
engineImportTXD ( txd, 8283 )
dff = engineLoadDFF ( "objeto/trava.dff", 0 )
engineReplaceModel ( dff, 8283 )

local travas = {}

function addtrava(vehicle)
    if isElement(vehicle) and not travas[vehicle] then
        local x, y, z = getVehicleComponentPosition(vehicle, "wheel_lf_dummy", "world")
        travas[vehicle] = createObject(8283, x, y, z, 0, 0, 180)
        setElementCollisionsEnabled(travas[vehicle], false)
    end
end

function removertrava(vehicle)
    if isElement(vehicle) and travas[vehicle] then
        destroyElement(travas[vehicle])
        travas[vehicle] = nil
    end
end

addEventHandler("onClientPreRender", root, function()
    for vehicle, object in pairs(travas) do
        if isElement(vehicle) and isElement(object) then
            local x, y, z = getVehicleComponentPosition(vehicle, "wheel_lf_dummy", "world")
            local rx, ry, rz = getVehicleComponentRotation(vehicle, "wheel_lf_dummy", "world")
            setElementPosition(object, x, y, z)
            setElementRotation(object, 0, 0, rz)
        end
    end
end)

addEventHandler("onClientResourceStart", resourceRoot, function()
    for k, v in pairs(getElementsByType("vehicle", root, true)) do
        if getElementData(v, "veiculo.trava") then
            addtrava(v)
        end 
    end
end)

addEventHandler("onClientElementStreamIn", root, function()
    if getElementType(source) == "vehicle" then
        if getElementData(source, "veiculo.trava") then
            addtrava(source)
        end
    end
end)

addEventHandler("onClientElementStreamOut", root, function()
    if getElementType(source) == "vehicle" then
        removertrava(source)
    end
end)

addEventHandler("onClientElementDestroy", root, function()
    if getElementType(source) == "vehicle" then
        removertrava(source)
    end
end)

addEventHandler("onClientElementDataChange", root, function(key, oldValue, newValue)
    if getElementType(source) == "vehicle" then
        if key == "veiculo.trava" then
            if newValue == true then
                if isElementStreamedIn(source) then
                    addtrava(source)
                end
            elseif newValue == false then
                removertrava(source)
            end
        end
    end
end)