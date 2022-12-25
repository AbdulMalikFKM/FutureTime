addEvent("printTicket", true)
addEventHandler("printTicket", root, 
function (hourlbl, parknum)
   if exports.global:hasMoney(source, 2) then
  exports.global:takeMoney(source, 2)
  exports.global:giveItem(source, 235, hourlbl.."\nPark Number : "..parknum..".")
    exports["notification"]:addNotification(source, "Successful Purchase The Ticket","success")
 -- exports.noti:show_box(source, "[Parking System]", "#00FF00Successful Purchase The Ticket!", "info")
  else
    exports["notification"]:addNotification(source, "You Don't Have Enough Money!","error")
  --exports.noti:show_box(source, "[Parking System]", "#FF0000You Don't Have Enough Money!", "error")
   end
end)

addEvent("printTickets", true)
addEventHandler("printTickets", root, 
function (hhourlbl, parknumh)
   if exports.global:hasMoney(source, 1) then
  exports.global:takeMoney(source, 1)
  exports.global:giveItem(source, 235, hhourlbl.."\nPark Number : "..parknumh..".")
  exports["notification"]:addNotification(source, "Successful Purchase The Ticket","success")
  --exports.noti:show_box(source, "[Parking System]", "#00FF00Successful Purchase The Ticket!", "info")
  else
  exports["notification"]:addNotification(source, "You Don't Have Enough Money!","error")
  --exports.noti:show_box(source, "[Parking System]", "#FF0000You Don't Have Enough Money!", "error")
   end
end)

--[[
addEvent("tests", true)
addEventHandler("tests", root, 
function (description1)
exports.anticheat:changeProtectedElementDataEx(vehicle, "description:1", "Hi", true)
end)
]]

function des(vehicle, itemValue)
exports.anticheat:changeProtectedElementDataEx(vehicle, "description:5", "Expired in : "..itemValue, true)
exports["item-system"]:giveItem(vehicle, 235, itemValue)
exports.global:takeItem(source, 235, itemValue)
end
addEvent("tests", true)
addEventHandler("tests", getRootElement(), des)


-- make Park Place --
