---------------------------
--Developer = Dharma (AbdulMalik Almadi)
--Description = يسمح لك هذا المود بإجراء توزيعات للاعبين بأنواع مختلفة كــ (المال , جي سي , الخ..).
--Server Type = RolePlay
--For Project = لايوجد مشروع الى الان-- *
--Version = 1.0.0
--Other Version = يوجد نسخة قادمة مستقبلا باضافات اكثر وخيارات اوسع
--* Thank You ^_^
---------------------------

guiSetInputMode("no_binds_when_editing")
screenW, screenH = guiGetScreenSize()
Prize = nil
Code = nil
ID = nil
Time = {
 {"1 Min", 60000, 1},
 {"5 Min", 300000, 2},
 {"1 Hour", 3600000, 3},
}

Timer = {
 "1 Min",
 "5 Min",
 "1 Hour",
 }

LogTable = {}
CodeTable = {
	[1] = "A",
	[2] = "B",
	[3] = "C",
	[4] = "D",
	[5] = "E",
	[6] = "F",
	[7] = "G",
	[8] = "H",
	[9] = "I",
	[10] = "J",
	[11] = "K",
	[12] = "L",
	[13] = "M",
	[14] = "N",
	[15] = "O",
	[16] = "P",
	[17] = "Q",
	[18] = "R",
	[19] = "S",
	[20] = "T",
	[21] = "U",
	[22] = "V",
	[23] = "W",
	[24] = "X",
	[25] = "Y",
	[26] = "Z",
	[27] = "0",
	[28] = "1",
	[29] = "2",
	[30] = "3",
	[31] = "4",
	[32] = "5",
	[33] = "6",
	[34] = "7",
	[35] = "8",
	[36] = "9",
}


function getProgress( addtick ) 
    local now = getTickCount() 
    local elapsedTime = now - lastTick 
    local duration = lastTick+addtick - lastTick 
    local progress = elapsedTime / duration 
    return progress 
end 


        playerWnd = guiCreateWindow((screenW - 251) / 2, (screenH - 213) / 2, 251, 213, "Redeem Code | By Dharma", false)
        guiWindowSetSizable(playerWnd, false)
        guiSetVisible(playerWnd, false)
        enterEdt = guiCreateEdit(55, 68, 141, 28, "", false, playerWnd)
        enterLbl = guiCreateLabel(56, 36, 140, 22, "Enter The Code", false, playerWnd)
		guiSetFont(enterLbl, "default-bold-small")
        guiLabelSetHorizontalAlign(enterLbl, "center", false)
        guiLabelSetVerticalAlign(enterLbl, "center")
		guiLabelSetColor(enterLbl, 252, 189, 0)
        sumbitBtn = guiCreateButton(60, 127, 136, 28, "Sumbit", false, playerWnd)
		guiSetProperty(sumbitBtn, "NormalTextColour", "FF17FE00")
		guiSetFont(sumbitBtn, "default-bold-small")
        playerclsBtn = guiCreateButton(60, 165, 136, 28, "Close", false, playerWnd)    
		guiSetFont(playerclsBtn, "default-bold-small")
		guiSetProperty(playerclsBtn, "NormalTextColour", "FFFF0000") 


    function infoWnds()
        infoWnd = guiCreateWindow((screenW - 310) / 2, (screenH - 342) / 2, 310, 342, "Information", false)
        guiWindowSetSizable(infoWnd, false)

        infoMemo = guiCreateMemo(9, 25, 291, 276, "مرحبا بك في لوحة المعلومات المتعلقة بــ نظام الاكواد\nاليك بعض المساعدات لتصبح جاهز في استخدام المود\n1- يفضل عدم وضع اموال بكميات كبيرة عند التوزيع\nفأقصى كمية هي : 10000 وأدناها : 1000\nملاحظة : انت لست مقيد بهذه الارقام\n\n2- يفضل عدم وضع عملات ذهبية [GC]ي بكميات كبيرة\n3- عند استخدام التوكين المتعلق بالمركبات او البيوت\nيجب ان لاتتجاوز الـ5 قطع عند الارسال\nملاحظة : انت لست مقيد بهذه الارقام\n\n4- عند استخدام كود الرقم المميز لشريحة الهاتف\nيفضل عدم وضع ارقام تتجاوز الـ 6 او تقل عن الـ 3\n -- New Update SooN\n5- عند استخدام الكود المتعلق بالآيتم[Items]\nيجب ان يكون ايدي الايتم لايتجاوز الـ214 \nوالتأكد ان القطعة مناسبة  للاعب من خلال [items/]\nشكرا لك على تجاوبك معنا وقرائتك للملاحظات كاملة\nنرجوا الاستمتاع بالمود , وعدم التخريب\n\nفي حال وجود اي أخطاء الرجاء التحدث مع المبرمج\n\n#Author : Dharma", false, infoWnd)
        infoclsBtn = guiCreateButton(9, 311, 291, 21, "Close", false, infoWnd)   
		guiSetFont(infoclsBtn, "default-bold-small")
		guiSetProperty(infoclsBtn, "NormalTextColour", "FFFF0000") 				
    end

        LogWnd = guiCreateWindow((screenW - 435) / 2, (screenH - 354) / 2, 435, 354, "Redeem Code Log | By Dharma", false)
        guiWindowSetSizable(LogWnd, false)
        guiSetVisible(LogWnd, false)
        gridList = guiCreateGridList(9, 30, 416, 275, false, LogWnd)
        guiGridListAddColumn(gridList, "Name", 0.22)
        guiGridListAddColumn(gridList, "Type", 0.18)
        guiGridListAddColumn(gridList, "Amount", 0.11)
        guiGridListAddColumn(gridList, "ID", 0.1)
        guiGridListAddColumn(gridList, "Time", 0.12)
        guiGridListAddColumn(gridList, "Code", 0.15)
        guiGridListAddColumn(gridList, "Real Time", 0.29)
        guiGridListAddRow(gridList)
        logclsBtn = guiCreateButton(147, 318, 142, 26, "Close", false, LogWnd)  
		guiSetFont(logclsBtn, "default-bold-small")
		guiSetProperty(logclsBtn, "NormalTextColour", "FFFF0000") 		



        Wnd2 = guiCreateWindow((screenW - 277) / 2, (screenH - 450) / 2, 277, 450, "Redeem Code Control | By Dharma", false)
        guiWindowSetSizable(Wnd2, false)
        guiSetVisible(Wnd2, false)
		guiSetAlpha(Wnd2, 0.85)
        selectCombo = guiCreateComboBox((277 - 175) / 2, (200 - 128) / 2, 175, 128, "Select Something", false, Wnd2)
		guiSetFont(selectCombo, "default-bold-small")
        guiComboBoxAddItem(selectCombo, "Money Code")
        guiComboBoxAddItem(selectCombo, "GC Code")
        guiComboBoxAddItem(selectCombo, "Vehicle Token's")
        guiComboBoxAddItem(selectCombo, "House Token's")
        guiComboBoxAddItem(selectCombo, "Special Number SIM Code")
        --guiComboBoxAddItem(selectCombo, "Item's Code")
        codeLbl = guiCreateLabel(10, 175, 41, 18, "Code : ", false, Wnd2)
		guiLabelSetColor(codeLbl, 252, 189, 0)
		guiSetFont(codeLbl, "default-bold-small")
        codeEdt = guiCreateEdit(61, 171, 110, 24, "", false, Wnd2)
        valueEdt = guiCreateEdit(61, 203, 110, 24, "", false, Wnd2)
        valueLbl = guiCreateLabel(10, 209, 41, 18, "Value : ", false, Wnd2)
		guiLabelSetColor(valueLbl, 252, 189, 0)
		guiSetFont(valueLbl, "default-bold-small")
        IDEdt = guiCreateEdit(61, 237, 110, 24, "", false, Wnd2)
        IDLbl = guiCreateLabel(10, 243, 41, 18, "ID : ", false, Wnd2)
		guiSetFont(IDLbl, "default-bold-small")
		guiLabelSetColor(IDLbl, 252, 189, 0)
        timeLbl = guiCreateLabel(10, 275, 41, 18, "Time : ", false, Wnd2)
		guiLabelSetColor(timeLbl, 252, 189, 0)
		guiSetFont(timeLbl, "default-bold-small")
        timeCombo = guiCreateComboBox(62, 271, 109, 81, "Select Time", false, Wnd2)
		guiSetFont(timeCombo, "default-bold-small")
        guiComboBoxAddItem(timeCombo, "1 Min")
        guiComboBoxAddItem(timeCombo, "5 Min")
        guiComboBoxAddItem(timeCombo, "1 Hour")
        genCodeBtn = guiCreateButton(181, 170, 86, 25, "Generate Code", false, Wnd2)
		guiSetFont(genCodeBtn, "default-bold-small")
		guiSetProperty (genCodeBtn, "NormalTextColour", "FFFFFF00")
        randomValueBtn = guiCreateButton(181, 202, 86, 25, "Random", false, Wnd2)
		guiSetFont(randomValueBtn, "default-bold-small")
		guiSetProperty(randomValueBtn, "NormalTextColour", "FFFFFF00") 
        randomIDBtn = guiCreateButton(181, 237, 86, 25, "Random", false, Wnd2)
		guiSetFont(randomIDBtn, "default-bold-small")
		guiSetProperty(randomIDBtn, "NormalTextColour", "FFFFFF00") 
        randomTimeBtn = guiCreateButton(181, 271, 86, 25, "Random", false, Wnd2)
		guiSetFont(randomTimeBtn, "default-bold-small")
		guiSetProperty(randomTimeBtn, "NormalTextColour", "FFFFFF00") 
        sendBtn = guiCreateButton(9, 365, 110, 31, "Send", false, Wnd2)
		guiSetFont(sendBtn, "default-bold-small")
		guiSetProperty(sendBtn, "NormalTextColour", "FF17FE00")
        infoBtn = guiCreateButton(157, 365, 110, 31, "Information", false, Wnd2)
		guiSetFont(infoBtn, "default-bold-small")
		guiSetProperty(infoBtn, "NormalTextColour", "FF0650F7")
        logBtn = guiCreateButton(9, 406, 110, 31, "Log (Manager)", false, Wnd2)
		guiSetFont(logBtn, "default-bold-small")
		guiSetProperty(logBtn, "NormalTextColour", "FFF81C06")
        clsBtn = guiCreateButton(157, 406, 110, 31, "Close", false, Wnd2)
		guiSetFont(clsBtn, "default-bold-small")
		guiSetProperty(clsBtn, "NormalTextColour", "FFFF0000") 

		
function openRedemCodes()
        guiSetVisible(Wnd2, not guiGetVisible(Wnd2))
		showCursor(guiGetVisible(Wnd2))
		end
		addCommandHandler("open", checkPremissions)
--addEvent("openRedemCodes", true)
--addEventHandler("openRedemCodes", root, openRedemCodes)
	
function openPWnd()
        guiSetVisible(playerWnd, not guiGetVisible(playerWnd))
		showCursor(guiGetVisible(playerWnd))
end
addCommandHandler("opens", openPWnd)
		
--#ComboBox Clicks
addEventHandler("onClientGUIClick", root,
function()
local item = guiComboBoxGetSelected(selectCombo)
local text = guiComboBoxGetItemText(selectCombo, item)
if text == "Money Code" then
guiEditSetReadOnly(IDEdt, true)
guiSetText(IDEdt, 134)
guiSetEnabled(randomIDBtn, false)

elseif text == "GC Code" then
guiEditSetReadOnly(IDEdt, true)
guiSetText(IDEdt, -1)
guiSetEnabled(randomIDBtn, false)

elseif text == "Vehicle Token's" then
guiEditSetReadOnly(IDEdt, true)
guiSetText(IDEdt, 1000)
guiSetEnabled(randomIDBtn, false)

elseif text == "House Token's" then
guiEditSetReadOnly(IDEdt, true)
guiSetText(IDEdt, 1001)
guiSetEnabled(randomIDBtn, false)

elseif text == "Special Number SIM Code" then
guiEditSetReadOnly(IDEdt, true)
guiSetText(IDEdt, 230)
guiSetEnabled(randomIDBtn, false)

elseif text == "Item's Code" then
guiEditSetReadOnly(IDEdt, false)
guiSetEnabled(randomIDBtn, true)
--guiSetText(IDEdt, "")

end
end)

--#Buttons Clicks
addEventHandler("onClientGUIClick", root,
function()
local item = guiComboBoxGetSelected(selectCombo)
local text = guiComboBoxGetItemText(selectCombo, item)
valueM = math.random(1000, 10000)
valueO = math.random(1, 5)
IDS = math.random(1, 214)
if source == sendBtn then
if guiComboBoxGetSelected(selectCombo) == -1 then
exports.notification:addNotification("Please Select Type First", "error")
elseif guiComboBoxGetSelected(timeCombo) == -1 then
exports.notification:addNotification("Select Time First!", "error")
elseif guiGetText(codeEdt) == "" or guiGetText(codeEdt) == " " or guiGetText(IDEdt) == "" or guiGetText(IDEdt) == " " or guiGetText(valueEdt) == "" or guiGetText(valueEdt) == " " then
exports.notification:addNotification("Complete!", "error")
else
SuccessfulAndLog()
exports.notification:addNotification("You Successful Send The Code!", "success")
end

elseif source == genCodeBtn then
guiSetText(codeEdt, ""..CodeTable[math.random(1,36)]..""..CodeTable[math.random(1,36)]..""..CodeTable[math.random(1,36)]..""..CodeTable[math.random(1,36)]..""..CodeTable[math.random(1,36)].."")

elseif source == clsBtn then
guiSetVisible(Wnd2, false)
showCursor(false)
elseif source == randomIDBtn then
guiSetText(IDEdt, IDS)

elseif source == randomValueBtn then
if text == "Money Code" or text == "GC Code" then
guiSetText(valueEdt, valueM)
else
guiSetText(valueEdt, valueO)
end
elseif source == randomTimeBtn then
for i, v in pairs(Time) do
   guiComboBoxSetSelected ( timeCombo, Time[math.random(#Time)][i] )
   end
   
   elseif source == infoBtn then
   infoWnds()
   guiSetVisible(Wnd2, false)
   
   elseif source == infoclsBtn then
   guiSetVisible(infoWnd, false)
   guiSetVisible(Wnd2, true)
   
   elseif source == logBtn then
   guiSetVisible(LogWnd, true)
   guiSetVisible(Wnd2, false)
   triggerServerEvent('Log:GetTheLog',localPlayer)
   
   elseif source == logclsBtn then
   guiSetVisible(LogWnd, false)
   guiSetVisible(Wnd2, true)
   
   elseif source == playerclsBtn then
   guiSetVisible(playerWnd, false)
   showCursor(false)
   
   elseif source == sumbitBtn then
   Check_The_Word()
end
end)

function Check_The_Word()
codeRight = guiGetText(enterEdt)
codeAdmin = guiGetText(codeEdt)
Prize = guiGetText(valueEdt)
ID = guiGetText(IDEdt)
Type = guiComboBoxGetSelected(selectCombo)
triggerServerEvent("CheckTheWord", localPlayer, codeRight, codeAdmin, Prize, ID, Type)
end

function SuccessfulAndLog()
   		realTime = getRealTime()
		hours = realTime.hour
		minutes = realTime.minute
		seconds = realTime.second
		day = realTime.monthday
	    month = realTime.month + 1
		year = realTime.year + 1900
        Player = getPlayerName(localPlayer)
		Code = guiGetText(codeEdt)
		Type = guiComboBoxGetSelected(selectCombo)
		TypeText = guiComboBoxGetItemText(selectCombo, Type)
		Prize = guiGetText(valueEdt)
		Times = guiComboBoxGetSelected(timeCombo)
		TimeText = guiComboBoxGetItemText(timeCombo, Times)
		ID = guiGetText(IDEdt)
		gTime = "["..year.."/"..month.."/"..day.."/"..hours.."/"..minutes.."/"..seconds.."]"
		guiGridListClear ( gridList )
        table.insert(LogTable, {Player, TypeText, Prize, ID, TimeText, Code, gTime})
        for i, v in pairs(LogTable) do	
            local row = guiGridListAddRow(gridList)
		        guiGridListSetItemText(gridList, row, 1, LogTable[i][1], false, false)
				guiGridListSetItemText(gridList, row, 2, LogTable[i][2], false, false)
		        guiGridListSetItemText(gridList, row, 3, LogTable[i][3], false, false) 
		        guiGridListSetItemText(gridList, row, 4, LogTable[i][4], false, false) 
				guiGridListSetItemText(gridList, row, 5, LogTable[i][5], false, false)
		        guiGridListSetItemText(gridList, row, 6, LogTable[i][6], false, false) 
		        guiGridListSetItemText(gridList, row, 7, LogTable[i][7], false, false)			 
				guiGridListSetItemColor(gridList, row, 1, 5, 255, 0, 255) 
				guiGridListSetItemColor(gridList, row, 2, 255, 5, 0, 255) 
				guiGridListSetItemColor(gridList, row, 3, 5, 255, 0, 255) 	
				guiGridListSetItemColor(gridList, row, 4, 255, 5, 0, 255) 				
				guiGridListSetItemColor(gridList, row, 5, 5, 255, 0, 255)
				guiGridListSetItemColor(gridList, row, 6, 255, 5, 0, 255) 
				guiGridListSetItemColor(gridList, row, 7, 5, 255, 0, 255)		
end
 		        triggerServerEvent("MakeTheCode", localPlayer, Player, Code, TypeText, Prize, TimeText, ID, gTime)
end

   addEvent('Log:SetTheLog',true)
   addEventHandler('Log:SetTheLog',root,function(logCode)
   if guiGetVisible(gridList) then
   		guiGridListClear(gridList)
		end
		if #logCode~=0 then
			for k=1,#logCode do
				local row=guiGridListAddRow(gridList)
					guiGridListSetItemText(gridList,row,1,logCode[k].Player,false,false)
					guiGridListSetItemText(gridList,row,2,logCode[k].Type,false,false)
					guiGridListSetItemText(gridList,row,3,logCode[k].Prize,false,false)
					guiGridListSetItemText(gridList,row,4,logCode[k].ID,false,false)
					guiGridListSetItemText(gridList,row,5,logCode[k].Times,false,false)
					guiGridListSetItemText(gridList,row,6,logCode[k].Code,false,false)
					guiGridListSetItemText(gridList,row,7,logCode[k].gTime,false,false)
			end
		end
   end)    

