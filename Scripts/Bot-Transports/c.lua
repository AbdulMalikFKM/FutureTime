---------------------------
--Developer = Dharma (AbdulMalik FM)
--Description = This script allow players to move around city using (bot) transport, without needing for other players to help you
--Note = I make the time and price a little high, just to encourage players to not use it always; instead use the taxi or buses that other players work in
--Server Type = RolePlay
--For Project = لايوجد مشروع الى الان-- *
--Version = 1.0.1
--Other Version = I don't think so... you can add places daynamiclly in easy way, just take the coordinate and add it to "Places" table
--How to add = I edited, now its more easy; you just need to go to the middle of the booth and take the coordinate, then paste it in "Places" table
--* Thank You ^_^
---------------------------
--This is for the seat in the bus, i put it to give more rp
Bus_Seat = {
    {1696.9879150391, 971.00372314453, 11.755864143372},
    {1699.4742431641, 971.00469970703, 11.755864143372},
    {1697.0240478516, 968.595703125, 11.755864143372},
    {1699.5797119141, 968.5966796875, 11.755864143372},
    {1697.0172119141, 966.19940185547, 11.755864143372},
    {1699.6353759766, 966.19549560547, 11.755864143372},
    {1699.7926025391, 963.80114746094, 11.755864143372},
    {1698.6695556641, 963.79919433594, 11.755864143372},
    {1697.9937744141, 963.80017089844, 11.755864143372},
    {1696.8052978516, 963.80114746094, 11.755864143372}
}
--just add the place name and coordinate as the format below, it's important to add r (Rotation) to calculate the location excatly
Places = {
    --Place name, x, y, z, r
    {"City Hall", 1459.99609375, -1741.1103515625, 13.546875, 0},
    {"DMV", 1288.8193359375, -1812.978515625, 13.546875, 270},
    {"Idlewood", 1922.9453125, -1760.6982421875, 13.546875, 360},
    {"Unity Station", 1765.0263671875, -1833.69140625, 13.553800582886, 344},
    {"Market Station", 821.3125, -1333.75, 13.546875, 344}
}
Markers = {}

DGS = exports['dgs-master']
local screenW, screenH = guiGetScreenSize()
Image = dxCreateTexture(":resources/vehicless.png")  
robotoboldFont14 = DGS:dgsCreateFont(":resources/Roboto-Bold.ttf", 14)
robotoFont11 = DGS:dgsCreateFont(":job-system/storekeeper/files/Roboto-Regular.ttf", 10)

function showWnd ()
    mainRect = DGS:dgsCreateRoundRect(0, false,tocolor(25,25,25,255))
    btnRect = DGS:dgsCreateRoundRect(15, false, tocolor(15,15,15,255))
    btnRecthov = DGS:dgsCreateRoundRect(15, false, tocolor(255, 51, 51, 200))
    btnRectClick = DGS:dgsCreateRoundRect(15, false, tocolor(255, 51, 51, 255))

    Wnd = DGS:dgsCreateImage((screenW - 429) / 2, (screenH - 443) / 2, 429, 443, mainRect, false)
    
    mainGrid = DGS:dgsCreateGridList(9, 29, 407, 319, false, Wnd, _, tocolor(10,10,10,255), _, tocolor(10,10,10,255))
    DGS:dgsSetProperty(mainGrid,"rowHeight",30)
    DGS:dgsSetProperty(mainGrid,"font",robotoFont11)
    local placeCol = DGS:dgsGridListAddColumn( mainGrid, "Place", 0.38 )
    local distanceCol = DGS:dgsGridListAddColumn( mainGrid, "Distance", 0.25 )
    local timeCol = DGS:dgsGridListAddColumn( mainGrid, "Time", 0.22 )
    local priceCol = DGS:dgsGridListAddColumn( mainGrid, "Price", 0.15 )

    for i,v in ipairs (Places) do
        local row = DGS:dgsGridListAddRow(mainGrid)
        placec = Places[i][1]

        xc = Places[i][2]
        yc = Places[i][3]
        zc = Places[i][4]
        r = Places[i][5]
        local x, y, z = getElementPosition(localPlayer)

        local Distance = getDistanceBetweenPoints3D ( x, y, z, xc, yc, zc )
        local formatted = string.format("%.2f" .. "m", Distance)

        if (row % 2 == 0) then
            DGS:dgsGridListSetRowBackGroundColor(mainGrid,row,tocolor(15, 15, 15, 200),tocolor(255,51,51,200),tocolor(255,51,51,255))
        else
            DGS:dgsGridListSetRowBackGroundColor(mainGrid,row,tocolor(25, 25, 25, 200),tocolor(255,51,51,200),tocolor(255,51,51,255))
        end

       -- time = "Less than Minute"
        local calculate_cost = Distance/100 -- for every 100 meter add 10 dollar
        local  cost = "$" .. math.floor(calculate_cost * 10)

        local calculate_time = Distance/250
        local time = math.floor(calculate_time * 10000)

        if Distance < 5 then
            DGS:dgsGridListRemoveRow ( mainGrid, row )
        end  

        DGS:dgsGridListSetItemText(mainGrid, row, placeCol, tostring(placec), false, false)
        DGS:dgsGridListSetItemText(mainGrid, row, distanceCol, tostring(formatted), false, false)
        DGS:dgsGridListSetItemText(mainGrid, row, timeCol, exports.global:convertSecondsToMinutes(time), false, false)
        DGS:dgsGridListSetItemText(mainGrid, row, priceCol, tostring(cost), false, false)
    end

    goBtn = DGS:dgsCreateButton(114, 357, 196, 31, "Go", false, Wnd, tocolor(200, 200, 200, 255), _, _, btnRect, btnRecthov, btnRectClick)
    clsBtn = DGS:dgsCreateButton(114, 398, 196, 31, "Close", false, Wnd, tocolor(200, 200, 200, 255), _, _, btnRect, btnRecthov, btnRectClick)
    DGS:dgsSetProperty(goBtn,"font",robotoFont11)
    DGS:dgsSetProperty(clsBtn,"font",robotoFont11)
end

for i, v in ipairs (Places) do
    local name = tostring(Places[i][1])
    local x = tonumber(Places[i][2])
    local y = tonumber(Places[i][3])
    local z = tonumber(Places[i][4])-- Becuase the z is same for both of them
    local r = tonumber(Places[i][5])

    Markers[i] = createMarker((x+(x-0.2))/2, (y+(y-0.1))/2, ((z)-0.95), "cylinder", 2, 255, 255, 255, 0)
    setElementData(Markers[i], "Transports", Markers[i])
    setElementData(Markers[i], "Name", name)
    setElementData(Markers[i], "x", x)
    setElementData(Markers[i], "y", y)
    setElementData(Markers[i], "z", z)
    setElementData(Markers[i], "rot", r)
    transportsData = getElementData(Markers[i], "Transports")

    addEventHandler("onClientMarkerHit", transportsData, function(hitElement)
        if getElementType(hitElement) == "player" then
            exports.infobox:addBox("info", "Press E to Open the Window")
            bindKey("e", "down", showWnd)
        end
    end)

    addEventHandler("onClientMarkerLeave", transportsData, function(hitElement)
        DGS:dgsSetVisible(Wnd, false)
        unbindKey("e", "down", showWnd)
    end)
end

addEventHandler("onClientRender", root,  
    function() 
        for i, v in ipairs (Places) do
            local x = getElementData(Markers[i], "x")
            local y = getElementData(Markers[i], "y")
            local z = getElementData(Markers[i], "z")
            local r = getElementData(Markers[i], "rot")

            if r == 270 then
                x1 = x - 0.9
                y1 = y - 2.24
                x2 = x + 0.8
                y2 = y + 2.3
            else
                x1 = x - 2.4
                y1 = y - 0.9
                x2 = x + 2.2
                y2 = y + 0.8
            end  

            exports.global:dxDrawBordered3DLine(x1, y1, z-0.95, x2, y2, z-0.95,tocolor(255, 255, 255, 150), 10)
            exports.global:dxDrawImageOnElement(Markers[i],Image,1,1, 255,255,255,255)
       end
    end
)

--Events
timeLeft = nil
addEventHandler("onDgsMouseClickDown", root,
    function ()
        if source == clsBtn then
            DGS:dgsSetVisible(Wnd, false)
            --destroyElement(Wnd)
        elseif source == goBtn then
            local Selected = DGS:dgsGridListGetSelectedItem(mainGrid)
            Name = DGS:dgsGridListGetItemText ( mainGrid, Selected, 1 )
            Time = DGS:dgsGridListGetItemText ( mainGrid, Selected, 3 )
            Price = string.match(DGS:dgsGridListGetItemText ( mainGrid, Selected, 4 ), "%d+")

            for i, v in ipairs(Markers) do
                if getElementData(Markers[i], "Name") == Name then
                    x = getElementData(Markers[i], "x")
                    y = getElementData(Markers[i], "y")
                    z = getElementData(Markers[i], "z")
                end
            end
            if exports.global:hasMoney(localPlayer, Price) then
                countDown = exports.global:convertToMillis(Time)
                --fadeCamera (false)
                Counter = setTimer(timerFunction, countDown, 1)
                displayTimer()
                DGS:dgsSetVisible(Wnd, false)

                setTimer(function()
                    triggerServerEvent("takeMoneyAndTeleport", localPlayer, Price, x, y, z)
                    DGS:dgsSetVisible(timerWnd, false)
                    setElementFrozen ( localPlayer, false )
                end, countDown, 1)
            else
                outputChatBox("You don't have enough money")
            end
         end
    end
)    

function timerFunction(Time)
    fadeCamera (true)
end

function displayTimer()
    timerWnd = DGS:dgsCreateImage(0, 302, 181, 92, mainRect, false)
   -- timerWnd = guiCreateWindow(0, 302, 181, 92, "", false)
   -- guiWindowSetSizable(timerWnd, false)
    lbl = DGS:dgsCreateLabel(8, 31, 155, 39, "", false, timerWnd)
    DGS:dgsLabelSetHorizontalAlign(lbl, "center", false)  
    DGS:dgsSetProperty(lbl,"font",robotoFont11)

    --First we need to teleport him to the bus then to the location
    pick_Seat = math.random(1, #Bus_Seat)
    setElementPosition(localPlayer, Bus_Seat[pick_Seat][1], Bus_Seat[pick_Seat][2], Bus_Seat[pick_Seat][3])
    setElementRotation(localPlayer, 0, 0, 360)
    setElementFrozen ( localPlayer, true )
    setPedAnimation(localPlayer, "ped", "seat_idle", countDown, true, false, false, false)

    setTimer (function ()
        if (isTimer(Counter) == true) then -- to prevent any error and warning message
            local timeLeft = getTimerDetails(Counter) 
            DGS:dgsSetText(lbl, "Time Remaining\n" .. exports.global:convertSecondsToMinutes(timeLeft))
        end
       --fadeCamera (true)
    end, 10, 0)
end
