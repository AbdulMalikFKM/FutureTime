---------------------------
--Developer = Dharma (AbdulMalik Almadi)
--Description = فبدلا من سحب المركبات ايضا اعطاء مخالفة لآخذين موقف دون ترخيص(Rapid Towing)يسمح لك هذا المود بأخذ بطاقة للمواقف لمدة محددة , سيوفر المود مساحة اوسع للعمل بالنسبة لوظيفة الـ 
--Server Type = RolePlay
--For Project = لايوجد مشروع الى الان-- *
--Version = 1.0.0
--Other Version = يوجد نسخة قادمة مستقبلا باضافات اكثر وخيارات اوسع
--* Thank You ^_^
---------------------------

local screenW, screenH = guiGetScreenSize()

--800x600
--3.23 4.68
    function dxThings()
        roundedRectangle(screenW/5.20, screenH/4.68, screenW/1.61, screenH/1.74, tocolor(0, 0, 0, 155))--(screenW - 494) / 2, (screenH - 344) / 2, 494, 344 --3.48
		dxDrawLine(screenW/5.22, screenH/2.03, screenW/1.23, screenH/2.03, tocolor(255, 255, 255, 255), 3, false)--153, 295, 647, 295
        roundedRectangle(screenW/5.06, screenH/1.91, screenW/16.32, screenH/13.95, tocolor(42, 42, 42, 155), false)--1-- 158, 313, 49, 43
        roundedRectangle(screenW/3.68, screenH/1.91, screenW/16.32, screenH/13.95, tocolor(42, 42, 42, 155), false)--2-- 217, 313, 49, 43
        roundedRectangle(screenW/2.90, screenH/1.91, screenW/16.32, screenH/13.95, tocolor(42, 42, 42, 155), false)--3-- 275, 313, 49, 43
		
        roundedRectangle(screenW/2.39, screenH/1.63, screenW/16.32, screenH/13.95, tocolor(42, 42, 42, 155), false)--0-- 334, 366, 49, 43
        roundedRectangle(screenW/5.06, screenH/1.63, screenW/16.32, screenH/13.95, tocolor(42, 42, 42, 155), false)--4-- 158, 366, 49, 43
        roundedRectangle(screenW/5.06, screenH/1.43, screenW/16.32, screenH/13.95, tocolor(42, 42, 42, 155), false)--7-- 158, 419, 49, 43
		
        roundedRectangle(screenW/3.68, screenH/1.63, screenW/16.32, screenH/13.95, tocolor(42, 42, 42, 155), false)--5-- 217, 366, 49, 43
        roundedRectangle(screenW/3.68, screenH/1.43, screenW/16.32, screenH/13.95, tocolor(42, 42, 42, 155), false)--8-- 217, 419, 49, 43
        roundedRectangle(screenW/2.90, screenH/1.63, screenW/16.32, screenH/13.95, tocolor(42, 42, 42, 155), false)--6-- 275, 366, 49, 43
        roundedRectangle(screenW/2.90, screenH/1.43, screenW/16.32, screenH/13.95, tocolor(42, 42, 42, 155), false)--9-- 275, 419, 49, 43
        dxDrawText("1", screenW/5.09, screenH/1.91, screenW/3.86, screenH/1.68, tocolor(255, 255, 255, 255), 1.00, "bankgothic", "center", "center", false, false, false, false, false)--157, 313, 207, 356
        dxDrawText("2", screenW/3.70, screenH/1.91, screenW/3.00, screenH/1.68, tocolor(255, 255, 255, 255), 1.00, "bankgothic", "center", "center", false, false, false, false, false)--216, 313, 266, 356
        dxDrawText("3", screenW/2.91, screenH/1.91, screenW/2.46, screenH/1.68, tocolor(255, 255, 255, 255), 1.00, "bankgothic", "center", "center", false, false, false, false, false)--274, 313, 324, 356
        dxDrawText("4", screenW/5.09, screenH/1.63, screenW/3.86, screenH/1.46, tocolor(255, 255, 255, 255), 1.00, "bankgothic", "center", "center", false, false, false, false, false)--157, 366, 207, 409
        dxDrawText("7", screenW/5.09, screenH/1.43, screenW/3.86, screenH/1.29, tocolor(255, 255, 255, 255), 1.00, "bankgothic", "center", "center", false, false, false, false, false)--157, 419, 207, 462
        dxDrawText("5", screenW/3.70, screenH/1.63, screenW/3.00, screenH/1.46, tocolor(255, 255, 255, 255), 1.00, "bankgothic", "center", "center", false, false, false, false, false)--216, 366, 266, 409
        dxDrawText("8", screenW/3.70, screenH/1.43, screenW/3.00, screenH/1.29, tocolor(255, 255, 255, 255), 1.00, "bankgothic", "center", "center", false, false, false, false, false)--216, 419, 266, 462
        dxDrawText("6", screenW/2.91, screenH/1.63, screenW/2.46, screenH/1.46, tocolor(255, 255, 255, 255), 1.00, "bankgothic", "center", "center", false, false, false, false, false)--274, 366, 324, 409
        dxDrawText("9", screenW/2.91, screenH/1.43, screenW/2.46, screenH/1.29, tocolor(255, 255, 255, 255), 1.00, "bankgothic", "center", "center", false, false, false, false, false)--274, 419, 324, 462
        dxDrawText("0", screenW/2.39, screenH/1.63, screenW/2.08, screenH/1.46, tocolor(255, 255, 255, 255), 1.00, "bankgothic", "center", "center", false, false, false, false, false)--334, 366, 384, 409
        roundedRectangle(screenW/1.36, screenH/1.63, screenW/16.32, screenH/13.95, tocolor(42, 42, 42, 155), false)--deleteBtn -- 588, 366, 49, 43
        roundedRectangle(screenW/2.39, screenH/1.43, screenW/16.32, screenH/13.95, tocolor(42, 42, 42, 155), false)--nothing down-- 334, 419, 49, 43
        roundedRectangle(screenW/2.39, screenH/1.91, screenW/16.32, screenH/13.95, tocolor(42, 42, 42, 155), false)--nothing up-- 334, 313, 49, 43
        roundedRectangle(screenW/1.36, screenH/1.91, screenW/16.32, screenH/13.95, tocolor(42, 42, 42, 155), false)--enterBtn-- 588, 313, 49, 43
        roundedRectangle(screenW/1.36, screenH/1.43, screenW/16.32, screenH/13.95, tocolor(42, 42, 42, 155), false)--closeBtn-- 588, 419, 49, 43
        dxDrawText("ادخال", screenW/1.36, screenH/1.91, screenW/1.25, screenH/1.68, tocolor(255, 255, 255, 255), 1.00, "sans", "center", "center", false, false, false, false, false)--588, 313, 638, 356
        dxDrawText("مسح", screenW/1.36, screenH/1.63, screenW/1.25, screenH/1.46, tocolor(255, 255, 255, 255), 1.00, "sans", "center", "center", false, false, false, false, false)--588, 366, 638, 409
        roundedRectangle(screenW/1.89, screenH/1.91, screenW/16.32, screenH/13.95, tocolor(42, 42, 42, 155), false)--hhourBtn--423, 313, 49, 43
        dxDrawText("خروج", screenW/1.36, screenH/1.43, screenW/1.25, screenH/1.29, tocolor(255, 255, 255, 255), 1.00, "sans", "center", "center", false, false, false, false, false)--588, 419, 638, 462
        dxDrawLine(screenW/1.98, screenH/2.02, screenW/1.98, screenH/1.27, tocolor(255, 255, 255, 255), 3, false)--403, 297, 403, 470
        dxDrawLine(screenW/1.41, screenH/2.00, screenW/1.41, screenH/1.27, tocolor(255, 255, 255, 255), 3, false)--566, 299, 566, 472
        roundedRectangle(screenW/1.93, screenH/1.43, screenW/5.63, screenH/13.95, tocolor(42, 42, 42, 155), false)--note-- 414, 419, 142, 43
        roundedRectangle(screenW/1.59, screenH/1.91, screenW/16.32, screenH/13.95, tocolor(42, 42, 42, 155), false)--hourBtn-- 501, 313, 49, 43
        dxDrawText("نص ساعة", screenW/1.89, screenH/1.91, screenW/1.69, screenH/1.68, tocolor(255, 255, 255, 255), 1.00, "sans", "center", "center", false, false, false, false, false)-- 423, 313, 473, 356
        dxDrawText("ساعة", screenW/1.59, screenH/1.91, 551, screenH/1.68, tocolor(255, 255, 255, 255), 1.00, "sans", "center", "center", false, false, false, false, false)-- 501, 313, 551, 356
        dxDrawLine(screenW/1.98, screenH/1.53, screenW/1.41, screenH/1.53, tocolor(255, 255, 255, 255), 3, false)--403, 392, 567, 392
    end
	

    function showGui()
	        enterimg = guiCreateStaticImage(screenW/2.46, screenH/2.55, screenW/5.63, screenH/20.68, ":rightclick/topwin.png", false)--324, 235, 142, 29
	--[[
        lblnum1 = guiCreateLabel(324, 235, 35, 29, "", false)
        guiSetFont(lblnum1, "sa-header")
        guiLabelSetHorizontalAlign(lblnum1, "center", false)


        lblnum2 = guiCreateLabel(359, 235, 35, 29, "", false)
        guiSetFont(lblnum2, "sa-header")
        guiLabelSetHorizontalAlign(lblnum2, "center", false)


        lblnum3 = guiCreateLabel(394, 235, 35, 29, "", false)
        guiSetFont(lblnum3, "sa-header")
        guiLabelSetHorizontalAlign(lblnum3, "center", false)


        lblnum4 = guiCreateLabel(429, 235, 37, 29, "", false)
        guiSetFont(lblnum4, "sa-header")
        guiLabelSetHorizontalAlign(lblnum4, "center", false)
]]

        lblnote = guiCreateLabel(screenW/1.93, screenH/1.43, screenW/5.63, screenH/40, "كل نصف ساعة بـ دولار", false)--414, 419, 142, 15
        guiSetFont(lblnote, "default-bold-small")
        guiLabelSetHorizontalAlign(lblnote, "center", false)


        lblprice = guiCreateLabel(screenW/1.93, screenH/1.35, screenW/5.63, screenH/40, "السعر : ", false)--414, 444, 142, 15
        guiSetFont(lblprice, "default-bold-small")
        guiLabelSetHorizontalAlign(lblprice, "right", false)


        lblfirst = guiCreateLabel(screenW/2.47, screenH/2.53, screenW/5.59, screenH/22.22, "", false)--323, 237, 143, 27
		guiSetFont(lblfirst, "sa-header")
        guiLabelSetHorizontalAlign(lblfirst, "center", false)
        guiLabelSetVerticalAlign(lblfirst, "center")
		
        lblaenter = guiCreateLabel(screenW/2.47, screenH/2.26, screenW/5.55, screenH/30, "", false)--323, 265, 144, 20
		guiSetFont(lblaenter, "sa-header")
        guiLabelSetHorizontalAlign(lblaenter, "center", false)
        guiLabelSetVerticalAlign(lblaenter, "center")
		guiSetAlpha(lblaenter, 0.50)
		
		lblinfo = guiCreateLabel(screenW/1.70, screenH/2.53, screenW/5.67, screenH/26.08, "الرجاء ادخال رقم الموقف : ", false)--469, 237, 141, 23
		guiSetFont(lblinfo, "default-bold-small")
        guiLabelSetHorizontalAlign(lblinfo, "right", false)
		
        mawgifimg = guiCreateStaticImage(screenW/2.70, screenH/4.68, screenW/3.82, screenH/7.14, ":resources/mawgif.png", false)--296, 128, 209, 84
		
		--buttons
		num0Btn = guiCreateButton(screenW/2.39, screenH/1.63, screenW/16.32, screenH/13.95, "0", false)  
        guiSetAlpha(num0Btn, 0.00)
		
		num1Btn = guiCreateButton(screenW/5.06, screenH/1.91, screenW/16.32, screenH/13.95, "1", false)  
        guiSetAlpha(num1Btn, 0.00)
		
		num2Btn = guiCreateButton(screenW/3.68, screenH/1.91, screenW/16.32, screenH/13.95, "2", false)  
        guiSetAlpha(num2Btn, 0.00)
		
		num3Btn = guiCreateButton(screenW/2.90, screenH/1.91, screenW/16.32, screenH/13.95, "3", false)  
        guiSetAlpha(num3Btn, 0.00)
		
		num4Btn = guiCreateButton(screenW/5.06, screenH/1.63, screenW/16.32, screenH/13.95, "4", false)  
        guiSetAlpha(num4Btn, 0.00)
		
		num5Btn = guiCreateButton(screenW/3.68, screenH/1.63, screenW/16.32, screenH/13.95, "5", false)  
        guiSetAlpha(num5Btn, 0.00)
		
		num6Btn = guiCreateButton(screenW/2.90, screenH/1.63, screenW/16.32, screenH/13.95, "6", false)  
        guiSetAlpha(num6Btn, 0.00)		
		
		num7Btn = guiCreateButton(screenW/5.06, screenH/1.43, screenW/16.32, screenH/13.95, "7", false)  
        guiSetAlpha(num7Btn, 0.00)
		
	    num8Btn = guiCreateButton(screenW/3.68, screenH/1.43, screenW/16.32, screenH/13.95, "8", false)  
        guiSetAlpha(num8Btn, 0.00)	
		
	    num9Btn = guiCreateButton(screenW/2.90, screenH/1.43, screenW/16.32, screenH/13.95, "9", false)  
        guiSetAlpha(num9Btn, 0.00)	
		
	    enterBtn = guiCreateButton(screenW/1.36, screenH/1.91, screenW/16.32, screenH/13.95, "", false)  
        guiSetAlpha(enterBtn, 0.00)
		
	    deleteBtn = guiCreateButton(screenW/1.36, screenH/1.63, screenW/16.32, screenH/13.95, "", false)  
        guiSetAlpha(deleteBtn, 0.00)
		
	    closeBtn = guiCreateButton(screenW/1.36, screenH/1.43, screenW/16.32, screenH/13.95, "", false)  
        guiSetAlpha(closeBtn, 0.00)	
		
	    hhourBtn = guiCreateButton(screenW/1.89, screenH/1.91, screenW/16.32, screenH/13.95, "", false)  
        guiSetAlpha(hhourBtn, 0.00)	
		
		hourBtn = guiCreateButton(screenW/1.59, screenH/1.91, screenW/16.32, screenH/13.95, "", false)  
        guiSetAlpha(hourBtn, 0.00)	
				
    end
	
addEvent("onBuyTicket", true)
addEventHandler("onBuyTicket", getRootElement(),
function()
addEventHandler("onClientRender", root, dxThings)
showGui()
guiSetVisible(hhourBtn, false)
guiSetVisible(hourBtn, false)
end)

addEventHandler("onClientGUIClick", getRootElement(),
function ()
		local realTime = getRealTime()
		local hours = realTime.hour
		local minutes = realTime.minute
		local seconds = realTime.second
		local day = realTime.monthday
	    local month = realTime.month + 1
		local year = realTime.year + 1900
if source == num0Btn then
addIntoLabel("0")
elseif source == num1Btn then
addIntoLabel("1")
elseif source == num2Btn then
addIntoLabel("2")
elseif source == num3Btn then
addIntoLabel("3")
elseif source == num4Btn then
addIntoLabel("4")
elseif source == num5Btn then
addIntoLabel("5")
elseif source == num6Btn then
addIntoLabel("6")
elseif source == num7Btn then
addIntoLabel("7")
elseif source == num8Btn then
addIntoLabel("8")
elseif source == num9Btn then
addIntoLabel("9")
elseif source == closeBtn then
removeEventHandler("onClientRender", root, dxThings)
guiSetVisible(num0Btn, false)
guiSetVisible(num1Btn, false)
guiSetVisible(num2Btn, false)
guiSetVisible(num3Btn, false)
guiSetVisible(num4Btn, false)
guiSetVisible(num5Btn, false)
guiSetVisible(num6Btn, false)
guiSetVisible(num7Btn, false)
guiSetVisible(num8Btn, false)
guiSetVisible(num9Btn, false)
guiSetVisible(enterBtn, false)
guiSetVisible(deleteBtn, false)
guiSetVisible(closeBtn, false)
guiSetVisible(hhourBtn, false)
guiSetVisible(hourBtn, false)
guiSetVisible(mawgifimg, false)
guiSetVisible(enterimg, false)
guiSetVisible(lblfirst, false)
guiSetVisible(lblnote, false)
guiSetVisible(lblprice, false)
guiSetVisible(lblaenter, false)
guiSetVisible(lblinfo, false)
elseif source == deleteBtn then
guiSetText(lblfirst, "")
elseif source == enterBtn then
if guiGetText(lblfirst) == "" then
guiSetText(lblfirst, "Error")
setTimer(function() 
guiSetText(lblfirst, "")end, 600, 1)
--outputChatBox("Error")
else
guiSetText(lblaenter, guiGetText(lblfirst))
guiSetText(lblfirst, "")
guiSetText(lblinfo, "الان ادخل زمن المكوث : ")
guiSetVisible(num0Btn, false)
guiSetVisible(num1Btn, false)
guiSetVisible(num2Btn, false)
guiSetVisible(num3Btn, false)
guiSetVisible(num4Btn, false)
guiSetVisible(num5Btn, false)
guiSetVisible(num6Btn, false)
guiSetVisible(num7Btn, false)
guiSetVisible(num8Btn, false)
guiSetVisible(num9Btn, false)
guiSetVisible(hhourBtn, true)
guiSetVisible(hourBtn, true)
end
elseif source == hourBtn then
guiSetText(lblfirst, "لقد تم اختيار ساعة")
guiSetVisible(enterBtn, false)
setTimer(function()
guiSetText(lblfirst, ""..hours + 1 .. ":" ..minutes)
guiSetVisible(enterBtn, true)end, 1500, 1)
hourlbl = hours + 1 .. ":" ..minutes
parknum = guiGetText(lblaenter)
guiSetText(lblinfo, "سينتهي الوقت عند : ")
guiSetText(lblprice, "السعر : دولارين")
guiSetVisible(hhourBtn, false)
guiSetVisible(deleteBtn, false)
addEventHandler("onClientGUIClick", enterBtn, function()
triggerServerEvent("printTicket", localPlayer, hourlbl, parknum)
removeEventHandler("onClientRender", root, dxThings)
guiSetVisible(num0Btn, false)
guiSetVisible(num1Btn, false)
guiSetVisible(num2Btn, false)
guiSetVisible(num3Btn, false)
guiSetVisible(num4Btn, false)
guiSetVisible(num5Btn, false)
guiSetVisible(num6Btn, false)
guiSetVisible(num7Btn, false)
guiSetVisible(num8Btn, false)
guiSetVisible(num9Btn, false)
guiSetVisible(enterBtn, false)
guiSetVisible(deleteBtn, false)
guiSetVisible(closeBtn, false)
guiSetVisible(hhourBtn, false)
guiSetVisible(hourBtn, false)
guiSetVisible(mawgifimg, false)
guiSetVisible(enterimg, false)
guiSetVisible(lblfirst, false)
guiSetVisible(lblnote, false)
guiSetVisible(lblprice, false)
guiSetVisible(lblaenter, false)
guiSetVisible(lblinfo, false)end)
elseif source == hhourBtn then
guiSetText(lblfirst, "لقد تم اختيار نص ساعة")
guiSetVisible(hourBtn, false)
guiSetVisible(enterBtn, false)
setTimer(function()
mintuestohour()
hhourlbl = guiGetText(lblfirst)
guiSetVisible(enterBtn, true)end, 1500, 1)
guiSetText(lblinfo, "سينتهي الوقت عند : ")
guiSetText(lblprice, "السعر : دولار")
parknumh = guiGetText(lblaenter)
guiSetVisible(deleteBtn, false)
addEventHandler("onClientGUIClick", enterBtn, function()
triggerServerEvent("printTickets", localPlayer, hhourlbl, parknumh)
removeEventHandler("onClientRender", root, dxThings)
guiSetVisible(num0Btn, false)
guiSetVisible(num1Btn, false)
guiSetVisible(num2Btn, false)
guiSetVisible(num3Btn, false)
guiSetVisible(num4Btn, false)
guiSetVisible(num5Btn, false)
guiSetVisible(num6Btn, false)
guiSetVisible(num7Btn, false)
guiSetVisible(num8Btn, false)
guiSetVisible(num9Btn, false)
guiSetVisible(enterBtn, false)
guiSetVisible(deleteBtn, false)
guiSetVisible(closeBtn, false)
guiSetVisible(hhourBtn, false)
guiSetVisible(hourBtn, false)
guiSetVisible(mawgifimg, false)
guiSetVisible(enterimg, false)
guiSetVisible(lblfirst, false)
guiSetVisible(lblnote, false)
guiSetVisible(lblprice, false)
guiSetVisible(lblaenter, false)
guiSetVisible(lblinfo, false)end)
end
end)

function mintuestohour (times)
local realTime = getRealTime()
local hours = realTime.hour
local minutes = realTime.minute

    if minutes == 31 then
	guiSetText(lblfirst, ""..hours + 1 .. ": 1" )
	elseif minutes == 32 then
	guiSetText(lblfirst, ""..hours + 1 .. ": 2" )
	elseif minutes == 33 then
	guiSetText(lblfirst, ""..hours + 1 .. ": 3" )
	elseif minutes == 34 then
	guiSetText(lblfirst, ""..hours + 1 .. ": 4" )
	elseif minutes == 35 then
	guiSetText(lblfirst, ""..hours + 1 .. ": 5" )
	elseif minutes == 36 then
	guiSetText(lblfirst, ""..hours + 1 .. ": 6" )
	elseif minutes == 37 then
	guiSetText(lblfirst, ""..hours + 1 .. ": 7" )
	elseif minutes == 38 then
	guiSetText(lblfirst, ""..hours + 1 .. ": 8" )
	elseif minutes == 39 then
	guiSetText(lblfirst, ""..hours + 1 .. ": 9" )
	elseif minutes == 40 then
	guiSetText(lblfirst, ""..hours + 1 .. ": 10" )
	elseif minutes == 41 then
	guiSetText(lblfirst, ""..hours + 1 .. ": 11" )
	elseif minutes == 42 then
	guiSetText(lblfirst, ""..hours + 1 .. ": 12" )
	elseif minutes == 43 then
	guiSetText(lblfirst, ""..hours + 1 .. ": 13" )
	elseif minutes == 44 then
	guiSetText(lblfirst, ""..hours + 1 .. ": 14" )
	elseif minutes == 45 then
	guiSetText(lblfirst, ""..hours + 1 .. ": 15" )
	elseif minutes == 46 then
	guiSetText(lblfirst, ""..hours + 1 .. ": 16" )
	elseif minutes == 47 then
	guiSetText(lblfirst, ""..hours + 1 .. ": 17" )
	elseif minutes == 48 then
	guiSetText(lblfirst, ""..hours + 1 .. ": 18" )
	elseif minutes == 49 then
	guiSetText(lblfirst, ""..hours + 1 .. ": 19" )
	elseif minutes == 50 then
	guiSetText(lblfirst, ""..hours + 1 .. ": 20" )
	elseif minutes == 51 then
	guiSetText(lblfirst, ""..hours + 1 .. ": 21" )
	elseif minutes == 52 then
	guiSetText(lblfirst, ""..hours + 1 .. ": 22" )
	elseif minutes == 53 then
	guiSetText(lblfirst, ""..hours + 1 .. ": 23" )
	elseif minutes == 54 then
	guiSetText(lblfirst, ""..hours + 1 .. ": 24" )
	elseif minutes == 55 then
	guiSetText(lblfirst, ""..hours + 1 .. ": 25" )
	elseif minutes == 56 then
	guiSetText(lblfirst, ""..hours + 1 .. ": 26" )
	elseif minutes == 57 then
	guiSetText(lblfirst, ""..hours + 1 .. ": 27" )
	elseif minutes == 58 then
	guiSetText(lblfirst, ""..hours + 1 .. ": 28" )
	elseif minutes == 59 then
	guiSetText(lblfirst, ""..hours + 1 .. ": 29" )
	elseif minutes == 60 then
	guiSetText(lblfirst, ""..hours + 1 .. ": 30" )
	else
	guiSetText(lblfirst, ""..hours .. ":" ..minutes + 30)
	end
end

function addIntoLabel (number)
	local text = guiGetText (lblfirst)
	guiSetText (lblfirst, text .. "" .. number)
end


function tg(vehicle)
local hasTicket, itemKey, itemValue, itemID = exports.global:hasItem(localPlayer, 235)
triggerServerEvent("tests", localPlayer, vehicle, itemValue)
description1 = getElementData(vehicle, "description:5", "Expired in : "..itemValue)
end
addEvent("onTicketVeh", true)
addEventHandler("onTicketVeh", getRootElement(), tg)


function roundedRectangle(x, y, w, h, borderColor, bgColor, postGUI)
    if (x and y and w and h) then
        if (not borderColor) then
            borderColor = tocolor(0, 0, 0, 200);
        end
        
        if (not bgColor) then
            bgColor = borderColor;
        end
        
        --> Background
        dxDrawRectangle(x, y, w, h, bgColor, postGUI);
        
        --> Border
        dxDrawRectangle(x + 2, y - 1, w - 4, 1, borderColor, postGUI); -- top
        dxDrawRectangle(x + 2, y + h, w - 4, 1, borderColor, postGUI); -- bottom
        dxDrawRectangle(x - 1, y + 2, 1, h - 4, borderColor, postGUI); -- left
        dxDrawRectangle(x + w, y + 2, 1, h - 4, borderColor, postGUI); -- right
    end
end

-- to boss --

addEvent("mawgifEmp", true)
addEventHandler("mawgifEmp", getRootElement(),
function (vehicle)
local check = exports["item-system"]:hasItem(vehicle, 235)
if check then
exports["notification"]:addNotification("There Ticket in The Vehicle","success")
else
exports["notification"]:addNotification("There's No Ticket in The Vehicle","error")
end
end)

