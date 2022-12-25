
GUIEditor = {
    button = {},
    staticimage = {},
    label = {},
	    edit = {}
}
addEvent("onClientGETAcc", true)
addEventHandler("onClientGETAcc", getRootElement(),
function (itemValue)
local screenW, screenH = guiGetScreenSize()
        img1 = guiCreateStaticImage((screenW - 226) / 2, (screenH - 118) / 2, 226, 118, ":rightclick/beroadd.png", false)

        img2 = guiCreateStaticImage(0.00, 0.00, 1.00, 0.19, ":rightclick/topwin.png", true, img1)

        lbl1 = guiCreateLabel(0.00, 0.00, 0.98, 1.00, "Track System | Grape RP", true, img2)
        guiLabelSetHorizontalAlign(lbl1, "center", false)
        guiLabelSetVerticalAlign(lbl1, "center")

        lbl2 = guiCreateLabel(6, 35, 214, 15, "Do You Want Track This Vehicle", false, img1)
        guiLabelSetHorizontalAlign(lbl2, "center", false)
        btn1 = guiCreateButton(6, 88, 91, 26, "تعقب", false, img1)
        btn2 = guiCreateButton(130, 88, 91, 26, "اغلاق", false, img1)
        lbl = guiCreateLabel(6, 60, 214, 15, itemValue, false, img1)
        guiSetAlpha(lbl, 0.00)
		showCursor(true)
end)

addEvent("trackVehicle", true)
addEventHandler("trackVehicle", getRootElement(),
function (vehicle)
vin = getElementData(vehicle, "dbid")
triggerServerEvent("Track", getLocalPlayer(), vin)
end)


addEventHandler("onClientGUIClick", getRootElement(),
function (itemValue)
idi = guiGetText(lbl)
if source == btn1 then
triggerServerEvent("Tracking", getLocalPlayer(), idi)
end
end)

  addEventHandler("onClientGUIClick",root,
  function ()
  if source == btn2 then
  guiSetVisible ( img1, false )
  showCursor (false)
end
end)

--antiCheat
function ac ()
guiSetVisible(img1, false)
showCursor (false)
end
bindKey("m", "down", ac)
--[[
--Sound & Effect
addEventHandler( "onClientMouseEnter", getRootElement(), 
function ()
if source == btn1 then
guiSetVisible(re1, true)
playSound("select.mp3")
elseif source == btn2 then
guiSetVisible(re2, true)
playSound("select.mp3")
end
end)

addEventHandler( "onClientMouseLeave", getRootElement(), 
function ()
if source == btn1 then
guiSetVisible(re1, false)
elseif source == btn2 then
guiSetVisible(re2, false)
end
end)
]]