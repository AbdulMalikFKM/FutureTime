------------------------
--Developer = Dharma (AbdulMalik FM)
--Description = يسمح لك هذا المود بعرض مركبتك للمزاد العلني
--Server Type = RolePlay
--For Project = لايوجد مشروع الى الان
------------------------
--This ped to take the key if you auction the vehicle and give you money if your vehicle sold.
local auctionPed = createPed( 113, 1545.81640625, -1007.1142578125, 24.078125)
setPedRotation( auctionPed, 242.5241394043 )
setElementDimension( auctionPed, 0)
setElementInterior( auctionPed , 0 )
setElementData( auctionPed, "talk", 1, false )
setElementData( auctionPed, "name", "Micheal Toreno", false )
setElementFrozen(auctionPed, true)
local screenW, screenH = guiGetScreenSize()
function Window (Items)
        Wnd = guiCreateWindow((screenW - 458) / 2, (screenH - 439) / 2, 458, 439, "Your Items", false)
        guiWindowSetSizable(Wnd, false)

        gridlist = guiCreateGridList(9, 29, 437, 342, false, Wnd)
        takeBtn = guiCreateButton(22, 393, 172, 36, "Take", false, Wnd)
       clsBtn = guiCreateButton(264, 393, 172, 36, "Close", false, Wnd)    
	   
	   		    local itemID =  guiGridListAddColumn(gridlist, "Item ID", 0.2)
	   		    local itemName =  guiGridListAddColumn(gridlist, "Item Name", 0.2)
	   		    local itemValue =  guiGridListAddColumn(gridlist, "Item Value", 0.2)
	   
	   		for key, value in pairs(Items) do
			local ID = Items[key][1]
			local Value = Items[key][2]
			local Name = exports.global:getItemName(tonumber(ID)) 
			local row = guiGridListAddRow(gridlist)
			--local namec = exports.global:getCharacterNameFromID(tostring(Issuer))
			guiGridListSetItemText(gridlist, row, itemID, tostring(ID), false, false)
			guiGridListSetItemText(gridlist, row, itemValue, tostring(Value), false, false)
			guiGridListSetItemText(gridlist, row, itemName, tostring(Name), false, false)
	   end
end
addEvent("ShowItemsGUI", true)
addEventHandler("ShowItemsGUI", root, Window)

addEvent("itemsGUI", true)
addEventHandler("itemsGUI", getRootElement(),
function ()
--localPlayer = localPlayer
triggerServerEvent("ShowMyItems", getRootElement(), getLocalPlayer())
end)

--[[ for sql
--the old owner
--bid price
--minimum increase
--buyout
--description
--VIN
]]
local Vin = nil
DGS = exports['dgs-master']
Auction_Marker = createMarker(1548.904296875, -1016.5244140625, 23.90625-0.95, "cylinder", 3, 255, 255, 255, 0)
--addEventHandler("onClientMarkerHit",west,MarkerHit3) 

		robotoFont10 = DGS:dgsCreateFont(":job-system/storekeeper/files/Roboto-Regular.ttf", 10)
		clondon10 = DGS:dgsCreateFont(":resources/ChaletLondon1960.ttf", 10)
		opal12 = DGS:dgsCreateFont(":resources/OPAL.ttf", 12)

function CheckTheVehicle ()
theVehicle = getPedOccupiedVehicle ( localPlayer )
year = getElementData(theVehicle, "year")
brand = getElementData(theVehicle, "brand")
model = getElementData(theVehicle, "maximemodel")
plate = getElementData(theVehicle, "plate")
vin = getElementData(theVehicle, "dbid")

	if theVehicle then
		triggerServerEvent("CheckTheVehicle", localPlayer, theVehicle)
	else
		exports.notification:addNotification("You Must Be in Vehicle", "warning")
	end
end
addEventHandler("onClientMarkerHit", Auction_Marker, CheckTheVehicle)

		mainRect = DGS:dgsCreateRoundRect(0, false,tocolor(10,10,10,255))
		--dummyRect = DGS:dgsCreateRoundRect(0, false,tocolor(10,10,10,255))
		labelRect = DGS:dgsCreateRoundRect(0, false,tocolor(0,167,255,200))
		underRect = DGS:dgsCreateRoundRect(0, false,tocolor(35,35,35,255))
		
		btnRect = DGS:dgsCreateRoundRect(10, false, tocolor(20,20,20,255))
		btnRecthov = DGS:dgsCreateRoundRect(10, false, tocolor(0, 167, 255, 200))
		btnRectClick = DGS:dgsCreateRoundRect(10, false, tocolor(0,167,255, 255))

addEvent("VerifyTheAccepetion", true)
addEventHandler("VerifyTheAccepetion", root,
function()
		--DGS:dgsCreateImage((screenW - 825) / 2, (screenH - 465) / 2, 825, 465,mainRect,false)
		--nameLbl = DGS:dgsCreateLabel(235, 8, 509, 35, "#c8c8c8Welcome #ff3333".. getPlayerName(localPlayer):gsub("_", " "), false, wBank, tocolor(200, 200, 200, 255))
		--DGS:dgsCreateEdit(0.22, 0.13, 0.2, 0.075, "", true, tabBusiness, tocolor(200, 200, 200, 255), _, _, btnRect)       
		--DGS:dgsCreateButton(0.44, 0.13, 0.2, 0.075, "Withdraw", true, tabBusiness, tocolor(200, 200, 200, 255), _, _, btnRect, btnRecthov, btnRectClick)
		auWnd = DGS:dgsCreateImage(87, 95, 310, 137, mainRect, false)
		aboveWnd = DGS:dgsCreateImage(0, 0, 310, 30, labelRect, false, auWnd)
		underWnd = DGS:dgsCreateImage(0, 107, 310, 30, underRect, false, auWnd)
		
		titleLbl = DGS:dgsCreateLabel(0, 8, 310, 56, "  Auction House", false, auWnd, tocolor(200, 200, 200, 255))
        nameLbl = DGS:dgsCreateLabel(0, 55, 310, 56, "  Would You Like To Sell Your: " ..year.." "..brand.. "\n  "..model, false, auWnd, tocolor(200, 200, 200, 255))
		yesBtn = DGS:dgsCreateButton(236, 111, 64, 20, "Yes", false, auWnd, tocolor(200, 200, 200, 255), _, _, btnRecthov, btnRectClick, btnRecthov)
        noBtn = DGS:dgsCreateButton(162, 111, 64, 20, "No", false, auWnd, tocolor(200, 200, 200, 255), _, _, btnRect, btnRecthov, btnRectClick)   
		
		DGS:dgsSetProperty(titleLbl,"font",robotoFont10)
		DGS:dgsSetProperty(yesBtn,"font",robotoFont10)
		DGS:dgsSetProperty(noBtn,"font",robotoFont10)
		DGS:dgsSetProperty(nameLbl,"font",opal12)
		--showCursor(true)
end)

function sellingWnds()
guiSetInputMode("no_binds_when_editing")
    sellingWnd = DGS:dgsCreateImage(104, 18, 294, 556, mainRect, false)
	
    aboveWnd = DGS:dgsCreateImage(0, 0, 294, 40, labelRect, false, sellingWnd)
	underWnd = DGS:dgsCreateImage(0, 516, 294, 40, underRect, false, sellingWnd)

	titleLbl = DGS:dgsCreateLabel(0, 12, 310, 56, "  Auction House", false, sellingWnd, tocolor(200, 200, 200, 255))

    modelLbl = DGS:dgsCreateLabel(10, 57, 274, 15, "Name: ", false, sellingWnd, tocolor(200, 200, 200, 255))
    modelEdit = DGS:dgsCreateEdit(9, 80, 275, 29, year.." "..brand.. " "..model, false, sellingWnd, tocolor(200, 200, 200, 255), _, _, btnRect)
    DGS:dgsEditSetReadOnly(modelEdit, true)
	
    plateLbl = DGS:dgsCreateLabel(10, 124, 103, 17, "Plate: ", false, sellingWnd, tocolor(200, 200, 200, 255))
	plateEdit = DGS:dgsCreateEdit(9, 147, 113, 29, plate, false, sellingWnd, tocolor(200, 200, 200, 255), _, _, btnRect)
	DGS:dgsEditSetReadOnly(plateEdit, true)
	
	lineLbl = DGS:dgsCreateLabel(1, 185, 103, 17, "ـــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــــ", false, sellingWnd, tocolor(200, 200, 200, 255))
	
	vinLbl = DGS:dgsCreateLabel(171, 124, 103, 17, "VIN: ", false, sellingWnd, tocolor(200, 200, 200, 255))
    vinEdit = DGS:dgsCreateEdit(171, 147, 113, 29, vin, false, sellingWnd, tocolor(200, 200, 200, 255), _, _, btnRect)
    DGS:dgsEditSetReadOnly(vinEdit, true)
	
	mileLbl = DGS:dgsCreateLabel(10, 202, 103, 17, "Mileage", false, sellingWnd, tocolor(200, 200, 200, 255))
    mileEdit = DGS:dgsCreateEdit(9, 225, 113, 29, "", false, sellingWnd, tocolor(200, 200, 200, 255), _, _, btnRect)
   
    endLbl = DGS:dgsCreateLabel(171, 202, 103, 17, "End Date", false, sellingWnd, tocolor(200, 200, 200, 255))
	endCombo = DGS:dgsCreateComboBox(171, 230, 108, 20, "", false, sellingWnd, 20, _, _, _, _, _, _, tocolor(25, 25, 25, 200),tocolor(0,167,255,200),tocolor(0,167,255,255))
	DGS:dgsComboBoxAddItem(endCombo, "1 Day")
	
	desLbl = DGS:dgsCreateLabel(10, 267, 103, 17, "Description", false, sellingWnd, tocolor(200, 200, 200, 255))
    desMemo = DGS:dgsCreateMemo(9, 290, 275, 76, "", false, sellingWnd, _, _, _, _, tocolor(20, 20, 20, 255))
    
	sbLbl = DGS:dgsCreateLabel(10, 385, 103, 17, "Starting Bid", false, sellingWnd, tocolor(200, 200, 200, 255))
	sbEdit = DGS:dgsCreateEdit(9, 408, 113, 29, "", false, sellingWnd, tocolor(200, 200, 200, 255), _, _, btnRect)
   
    mininLbl = DGS:dgsCreateLabel(171, 385, 103, 17, "Minimum Increase", false, sellingWnd, tocolor(200, 200, 200, 255))
    mininEdit = DGS:dgsCreateEdit(171, 408, 113, 29, "", false, sellingWnd, tocolor(200, 200, 200, 255), _, _, btnRect)
  
	buyoutLbl = DGS:dgsCreateLabel(10, 456, 103, 17, "Buyout", false, sellingWnd, tocolor(200, 200, 200, 255))
	buyoutEdit = DGS:dgsCreateEdit(9, 479, 275, 29, "", false, sellingWnd, tocolor(200, 200, 200, 255), _, _, btnRect)
    
	auBtn = DGS:dgsCreateButton(171, 523, 113, 23, "Auction Vehicle", false, sellingWnd, tocolor(200, 200, 200, 255), _, _, btnRect, btnRecthov, btnRectClick)
    clsBtn = DGS:dgsCreateButton(48, 523, 113, 23, "Cancel", false, sellingWnd, tocolor(200, 200, 200, 255), _, _, btnRect, btnRecthov, btnRectClick)    

	DGS:dgsSetProperty(titleLbl,"font",robotoFont10)
	DGS:dgsSetProperty(auBtn,"font",robotoFont10)
	DGS:dgsSetProperty(clsBtn,"font",robotoFont10)
	
	DGS:dgsSetProperty(modelLbl,"font",clondon10)
	DGS:dgsSetProperty(plateLbl,"font",clondon10)
	DGS:dgsSetProperty(vinLbl,"font",clondon10)
	DGS:dgsSetProperty(mileLbl,"font",clondon10)
	DGS:dgsSetProperty(endLbl,"font",clondon10)
	DGS:dgsSetProperty(desLbl,"font",clondon10)
	DGS:dgsSetProperty(sbLbl,"font",clondon10)
	DGS:dgsSetProperty(mininLbl,"font",clondon10)
	DGS:dgsSetProperty(buyoutLbl,"font",clondon10)
	
	--DGS:dgsEditSetPlaceHolder( mileEdit, "0" )

end

addEvent("SuccessBid", true)
addEventHandler("SuccessBid", getRootElement(),
function(theVehicle)
Vin = theVehicle
des1 = getElementData(theVehicle, "description:1")
des2 = getElementData(theVehicle, "description:2")
des3 = getElementData(theVehicle, "description:3")
des4 = getElementData(theVehicle, "description:4")
des2a = string.match(des2, "%d+")--to ignore $, just match the numbers.
des3a = string.match(des3, "%d+")
des4a = string.match(des4, "%d+")
--des2a = string.match(des2, bid)
--des3a = string.match(des3, buyout)
--des4a = string.match(des4, minin)
price_plus_increase = des4a + des2a

		buyoutWnd = DGS:dgsCreateImage(335, 121, 323, 211, mainRect, false)
       -- buyoutWnd = guiCreateWindow(335, 121, 323, 211, "Auction House", false)
      --  guiWindowSetSizable(buyoutWnd, false)

        cubidLbl = DGS:dgsCreateLabel(6, 26, 312, 15, " The Current Bid is "..des2a.."$. You Must Bid At Least", false, buyoutWnd, tocolor(200, 200, 200, 255))
        leadbidLbl = DGS:dgsCreateLabel(6, 51, 312, 15, " "..des4a.."$ To Lead The Auction", false, buyoutWnd, tocolor(200, 200, 200, 255))
        cubidEdit = DGS:dgsCreateEdit(9, 85, 146, 29, price_plus_increase, false, buyoutWnd, tocolor(200, 200, 200, 255), _, _, btnRect)
        DGS:dgsEditSetReadOnly(cubidEdit, true)
        pbBtn = DGS:dgsCreateButton(176, 84, 87, 30, "Place Bid", false, buyoutWnd, tocolor(200, 200, 200, 255), _, _, btnRect, btnRecthov, btnRectClick)
        alterLbl = DGS:dgsCreateLabel(6, 128, 312, 15, " Alternativley You Can Buyout The Auction For", false, buyoutWnd, tocolor(200, 200, 200, 255))
        altpriceLbl = DGS:dgsCreateLabel(6, 148, 312, 15, " "..des3a.."$", false, buyoutWnd, tocolor(200, 200, 200, 255))
        buyoutBtn = DGS:dgsCreateButton(9, 172, 208, 29, "Buyout Auction For "..des3a.."$", false, buyoutWnd, tocolor(200, 200, 200, 255), _, _, btnRect, btnRecthov, btnRectClick)  
        endBtn = DGS:dgsCreateButton(230, 172, 80, 29, "Close", false, buyoutWnd, tocolor(200, 200, 200, 255), _, _, btnRect, btnRecthov, btnRectClick)  
end)

addEventHandler("onDgsMouseClickDown", root, function () 
local charID = getElementData(localPlayer, "account:character:id")
	if source == noBtn then
		DGS:dgsSetVisible(auWnd, false)
		--showCursor(false)
		setElementFrozen(theVehicle, false)
		
	elseif source == yesBtn then
		sellingWnds()
		DGS:dgsSetVisible(auWnd, false)
		setElementFrozen(theVehicle, false)
	
	elseif source == clsBtn then
		DGS:dgsSetVisible(sellingWnd, false)
		setElementFrozen(theVehicle, false)
		setElementData(theVehicle, "AgreeTheVehicle", 0)	
		
	elseif source == pbBtn then
		local updatedBid = DGS:dgsGetText(cubidEdit)
		DGS:dgsSetVisible(buyoutWnd, false)
		triggerServerEvent("UpdateVehicleStats", localPlayer, Vin, updatedBid, charID)		
		
	elseif source == endBtn then
		DGS:dgsSetVisible(buyoutWnd, false)	
	
	elseif source == auBtn then
		--if not ((DGS:dgsGetText(mileEdit) == "") and (DGS:dgsGetText(desMemo) == "") and (DGS:dgsGetText(sbEdit) == "") and (DGS:dgsGetText(mininEdit) == "") and (DGS:dgsGetText(buyoutEdit) == "") ) then
		--if ((string.find(DGS:dgsGetText(mileEdit), "")) and (string.find(DGS:dgsGetText(desMemo), "")) and (string.find(DGS:dgsGetText(sbEdit), "")) and (string.find(DGS:dgsGetText(mininEdit), "")) and (string.find(DGS:dgsGetText(buyoutEdit), "")) ) then
			DGS:dgsSetVisible(sellingWnd, false)
			setElementData(theVehicle, "AgreeTheVehicle", 1)
			bid = DGS:dgsGetText(sbEdit)
			minin = DGS:dgsGetText(mininEdit)
			buyout = DGS:dgsGetText(buyoutEdit)
			local desc = DGS:dgsGetText(desMemo)
			setElementPosition ( theVehicle, 1558.2080078125, -1012.6513671875, 23.633323669434 )
			setElementRotation ( theVehicle, 0, 0, 180 )
			triggerServerEvent("PutVehicleInDisplay", localPlayer, theVehicle, bid, minin, buyout, charID, desc)
			triggerServerEvent("getAllAttribute", localPlayer, theVehicle)
			--doThis()
	--	else
		--	outputChatBox ("You Must Fill Out The Form!")
		--end
	end
end)

Image = dxCreateTexture(":resources/vehicless.png") 

addEventHandler("onClientRender", root,  
    function() 
exports.global:dxDrawOctagon3D(1548.904296875, -1016.5244140625, 23.90625-0.95, 3, 3, tocolor (255, 255, 255, 255))
exports.global:dxDrawImageOnElement(Auction_Marker,Image,1,1, 255,255,255,255)
end)