addEvent("takeMoneyAndTeleport", true)
addEventHandler("takeMoneyAndTeleport", getRootElement(),
    function (Price, x, y, z)
        exports.infobox:addBox(source, "success", "Please Sit down until we arrive")
        exports.global:takeMoney(source, Price)

        setElementPosition(source, x, y, z)

    end
)
