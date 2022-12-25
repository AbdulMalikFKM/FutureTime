version = "Bank System v3.0 [06.09.2014]"

loans = {
-- loan value, loan intrest, intrest value, final value, salary
 {"50,000", "10%", "5,000", "55,000", "1500"},
 {"100,000", "10%", "10,000", "110,000", "2000"},
 {"500,000", "10%", "50,000", "550,000", "2500"}
}


wBank, bClose, lBalance, tabPanel, tabPersonal, tabPersonalTransactions, tabBusiness, tabBusinessTransactions, lWithdrawP, tWithdrawP, bWithdrawP, lDepositP, tDepositP, bDepositP = nil
lWithdrawB, tWithdrawB, bWithdrawB, lDepositB, tDepositB, bDepositB, lBalanceB, gPersonalTransactions, gBusinessTransactions = nil
isInFaction, isFactionLeader, factionBalance, depositable, limit, withdrawable, factionType = nil
gfactionBalance = nil
cooldown = nil
mySalary = nil
loanState = nil
loanValue = nil

lastUsedATM = nil
_depositable = nil
_withdrawable = nil
limitedwithdraw = 0
DGS = exports['dgs-master']
local screenW, screenH = guiGetScreenSize()
local localPlayer = getLocalPlayer()
--[[
function Salary (mySalary)
	mySalary = mySalary or 0
	outputChatBox(mySalary)
end
addEvent("mySalary", true)
addEventHandler("mySalary", root, Salary)
]]
function tonumber2( num )
	if type(num) == "number" then
		return num
	else
		num = num:gsub(",",""):gsub("%$","")
		return tonumber(num)
	end
end

local bankPed = createPed(150, 2358.710205, 2361.2133789, 2022.919189)
setPedRotation(bankPed, 90.4609375)
setElementInterior(bankPed, 3)
--[[
function updateTabStuff()
	if guiGetSelectedTab(tabPanel) == tabPersonalTransactions then
		guiGridListClear(gPersonalTransactions)
		triggerServerEvent("tellTransfersPersonal", localPlayer, cardInfoSaved)
	elseif guiGetSelectedTab(tabPanel) == tabBusinessTransactions then
		guiGridListClear(gBusinessTransactions)
		triggerServerEvent("tellTransfersBusiness", localPlayer)
	end
end
]]
finance = dxCreateTexture(":resources/finance.png")
coins = dxCreateTexture(":resources/coins.png")
banks = dxCreateTexture(":resources/bank.png")
loan = dxCreateTexture(":resources/editduty.png")

function showBankUI(isInFaction, isFactionLeader, factionBalance, depositable, limit, withdrawable, factionType, state, value)
	if not (wBank) then
		if getElementData(getLocalPlayer(), "exclusiveGUI") or not isCameraOnPlayer() then
			return false
		end
		cardInfoSaved = nil
		_depositable = depositable
		_withdrawable = withdrawable
		lastUsedATM = source
		limitedwithdraw = limit

		setElementData(getLocalPlayer(), "exclusiveGUI", true, false)

		local width, height = 600, 400
		local scrWidth, scrHeight = guiGetScreenSize()
		local x = scrWidth/2 - (width/2)
		local y = scrHeight/2 - (height/2)

		robotoFont10 = DGS:dgsCreateFont(":job-system/storekeeper/files/Roboto-Regular.ttf", 10)
		robotoFont11 = DGS:dgsCreateFont(":job-system/storekeeper/files/Roboto-Regular.ttf", 11)
				opal18 = DGS:dgsCreateFont(":resources/OPAL.ttf", 18)
triggerServerEvent("getMySalary", localPlayer)
		local transactionColumns = {
			{ "ID", 0.09 },
			{ "From", 0.2 },
			{ "To", 0.2 },
			{ "Amount", 0.1 },
			{ "Date", 0.2 },
			{ "Reason", 0.5 }
		}

		local bannedTypes = {
			[0] = true,
			[1] = true,
		}

		mainRect = DGS:dgsCreateRoundRect(0, false,tocolor(10,10,10,255))
		dummyRect = DGS:dgsCreateRoundRect(0, false,tocolor(10,10,10,255))
		labelRect = DGS:dgsCreateRoundRect(0, false,tocolor(15,15,15,255))
		
		btnRect = DGS:dgsCreateRoundRect(15, false, tocolor(20,20,20,255))
		btnRecthov = DGS:dgsCreateRoundRect(15, false, tocolor(255, 51, 51, 200))
		btnRectClick = DGS:dgsCreateRoundRect(15, false, tocolor(255, 51, 51, 255))

		wBank = DGS:dgsCreateImage((screenW - 825) / 2, (screenH - 465) / 2, 825, 465,mainRect,false)
		
		logoRect = DGS:dgsCreateImage(0, 0, 825, 65,labelRect,false,wBank)
        logo = DGS:dgsCreateImage(9, 2, 213, 65, ":resources/bnklogo.png", false, wBank)
		DGS:dgsSetEnabled(logo, false)
		DGS:dgsSetEnabled(logoRect, false)
		nameLbl = DGS:dgsCreateLabel(235, 8, 509, 35, "#c8c8c8Welcome #ff3333".. getPlayerName(localPlayer):gsub("_", " "), false, wBank, tocolor(200, 200, 200, 255))
		welLbl = DGS:dgsCreateLabel(235, 35, 509, 35, "Bank Of Los Santos", false, wBank, tocolor(200, 200, 200, 255))
		
		DGS:dgsSetProperty(nameLbl,"font",opal18)
		DGS:dgsSetProperty(nameLbl,"colorcoded",true)
		DGS:dgsSetProperty(welLbl,"font",opal18)
		DGS:dgsSetProperty(welLbl,"colorcoded",true)
		
		--guiWindowSetSizable(wBank, false)

		tabPanel = DGS:dgsCreateImage(225, 65, 600, 400,dummyRect,false,wBank)
		--addEventHandler( "onClientGUITabSwitched", tabPanel, updateTabStuff )

		--tabPersonal = guiCreateTab("Personal Banking", tabPanel)
		--tabPersonalTransactions = guiCreateTab("Personal Transactions", tabPanel)
			tabPersonalTransactions = DGS:dgsCreateImage(225, 65, 600, 400,dummyRect,false,wBank)

		local hoursplayed = getElementData(localPlayer, "hoursplayed") or 0

			tabBusiness = DGS:dgsCreateImage(225, 65, 600, 400,dummyRect,false,wBank)

			gfactionBalance = factionBalance

			lBalanceB = DGS:dgsCreateLabel(0.1, 0.05, 0.9, 0.05, "Balance: $" .. exports.global:formatMoney(factionBalance), true, tabBusiness)
			--DGS:dgsSetFont(lBalanceB, robotoFont10)
			DGS:dgsSetProperty(lBalanceB,"font",robotoFont10)

			if (withdrawable) then
			-- WITHDRAWAL BUSINESS
				lWithdrawB = DGS:dgsCreateLabel(0.1, 0.15, 0.2, 0.05, "Withdraw:", true, tabBusiness)
				DGS:dgsSetProperty(lWithdrawB,"font",robotoFont10)
				--DGS:dgsSetFont(lWithdrawB, robotoFont10)

				tWithdrawB = DGS:dgsCreateEdit(0.22, 0.13, 0.2, 0.075, "", true, tabBusiness, tocolor(200, 200, 200, 255), _, _, btnRect)
				DGS:dgsSetProperty(tWithdrawB,"font",robotoFont10)
				--DGS:dgsSetFont(tWithdrawB, robotoFont10)
				DGS:dgsEditSetPlaceHolder( tWithdrawB, "0" )
				--[[
				addEventHandler("onDgsMouseClickDown", tWithdrawB, function()
					if DGS:dgsGetText(tWithdrawB) == "0" then
						DGS:dgsSetText(tWithdrawB, "")
					end
				end, false)]]

				bWithdrawB = DGS:dgsCreateButton(0.44, 0.13, 0.2, 0.075, "Withdraw", true, tabBusiness, tocolor(200, 200, 200, 255), _, _, btnRect, btnRecthov, btnRectClick)
				addEventHandler("onDgsMouseClickDown", bWithdrawB, withdrawMoneyBusiness, false)
			else
				lWithdrawB = DGS:dgsCreateLabel(0.1, 0.15, 0.5, 0.05, "This ATM does not support the withdraw function.", true, tabBusiness)
				DGS:dgsSetProperty(lWithdrawB,"font",robotoFont10)
				--DGS:dgsSetFont(lWithdrawB, robotoFont10)
			end

			if (depositable) then
				-- DEPOSIT BUSINESS
				lDepositB = DGS:dgsCreateLabel(0.1, 0.25, 0.2, 0.05, "Deposit:", true, tabBusiness)
				DGS:dgsSetProperty(lDepositB,"font",robotoFont10)
				--DGS:dgsSetFont(lDepositB, robotoFont10)

				tDepositB = DGS:dgsCreateEdit(0.22, 0.23, 0.2, 0.075, "", true, tabBusiness, tocolor(200, 200, 200, 255), _, _, btnRect)
				DGS:dgsSetProperty(tDepositB,"font",robotoFont10)
				--DGS:dgsSetFont(tDepositB, robotoFont10)
				DGS:dgsEditSetPlaceHolder( tDepositB, "0" )
				--[[
				addEventHandler("onDgsMouseClickDown", tDepositB, function()
					if DGS:dgsGetText(tDepositB) == "0" then
						DGS:dgsSetText(tDepositB, "")
					end
				end, false)
]]
				bDepositB = DGS:dgsCreateButton(0.44, 0.23, 0.2, 0.075, "Deposit", true, tabBusiness, tocolor(200, 200, 200, 255), _, _, btnRect, btnRecthov, btnRectClick)
				addEventHandler("onDgsMouseClickDown", bDepositB, depositMoneyBusiness, false)
			else
				lDepositB = DGS:dgsCreateLabel(0.1, 0.25, 0.5, 0.05, "This ATM does not support the deposit function.", true, tabBusiness)
				DGS:dgsSetProperty(lDepositB,"font",robotoFont10)
				--DGS:dgsSetFont(lDepositB, robotoFont10)

				if limitedwithdraw > 0 and withdrawable then
					tDepositB = DGS:dgsCreateLabel(0.67, 0.15, 0.2, 0.05, "Max: $" .. exports.global:formatMoney( limitedwithdraw - ( getElementData( source, "withdrawn" ) or 0 ) ) .. ".", true, tabBusiness)
					DGS:dgsSetProperty(tDepositB,"font",robotoFont10)
					--DGS:dgsSetFont(tDepositB, robotoFont10)
				end
			end

			if hoursplayed >= 12 then
				-- TRANSFER BUSINESS
				lTransferB = DGS:dgsCreateLabel(0.1, 0.45, 0.2, 0.05, "Transfer:", true, tabBusiness)
				DGS:dgsSetProperty(lTransferB,"font",robotoFont10)
				--DGS:dgsSetFont(lTransferB, robotoFont10)

				tTransferB = DGS:dgsCreateEdit(0.22, 0.43, 0.2, 0.075, "", true, tabBusiness, tocolor(200, 200, 200, 255), _, _, btnRect)
				DGS:dgsSetProperty(tTransferB,"font",robotoFont10)
				--DGS:dgsSetFont(tTransferB, robotoFont10)
				DGS:dgsEditSetPlaceHolder( tTransferB, "0" )
				--[[
				addEventHandler("onDgsMouseClickDown", tTransferB, function()
					if DGS:dgsGetText(tTransferB) == "0" then
						DGS:dgsSetText(tTransferB, "")
					end
				end, false)
]]
				bTransferB = DGS:dgsCreateButton(0.44, 0.43, 0.2, 0.075, "Transfer to", true, tabBusiness, tocolor(200, 200, 200, 255), _, _, btnRect, btnRecthov, btnRectClick)
				addEventHandler("onDgsMouseClickDown", bTransferB, transferMoneyBusiness, false)

				eTransferB = DGS:dgsCreateEdit(0.66, 0.43, 0.3, 0.075, "", true, tabBusiness, tocolor(200, 200, 200, 255), _, _, btnRect)
				DGS:dgsEditSetPlaceHolder( eTransferB, "<Bank Account Number>" )
				--[[
				addEventHandler("onClientGUIClick", eTransferB, function()
					if DGS:dgsGetText(eTransferB) == "<Bank Account Number>" then
						DGS:dgsSetText(eTransferB, "")
					end
				end, false)
]]
				lTransferBReason = DGS:dgsCreateLabel(0.1, 0.55, 0.2, 0.05, "Reason:", true, tabBusiness)
				DGS:dgsSetProperty(lTransferBReason,"font",robotoFont10)
				--DGS:dgsSetFont(lTransferBReason, robotoFont10)

				tTransferBReason = DGS:dgsCreateEdit(0.22, 0.54, 0.74, 0.075, "", true, tabBusiness, tocolor(200, 200, 200, 255), _, _, btnRect)
				DGS:dgsEditSetPlaceHolder( tTransferBReason, "<What is this transaction for?>" )
				--[[
				addEventHandler("onDgsMouseClickDown", tTransferBReason, function()
					if DGS:dgsGetText(tTransferBReason) == "<What is this transaction for?>" then
						DGS:dgsSetText(tTransferBReason, "")
					end
				end, false)
				]]
			end

			-- TRANSACTION HISTORY
			tabBusinessTransactions = DGS:dgsCreateImage(225, 65, 600, 400,dummyRect,false,wBank)

			gBusinessTransactions = DGS:dgsCreateGridList(0.02, 0.02, 0.96, 0.96, true, tabBusinessTransactions)
			for key, value in ipairs( transactionColumns ) do
				DGS:dgsGridListAddColumn( gBusinessTransactions, value[1], value[2] or 0.1 )
			end
		--end


		tabLoan = DGS:dgsCreateImage(225, 65, 600, 400,dummyRect,false,wBank)
		tabLoanalready = DGS:dgsCreateImage(225, 65, 600, 400,dummyRect,false,wBank)
		
		DGS:dgsSetVisible(tabLoanalready, false)
		--tloanTLbl = DGS:dgsCreateLabel(375, 41, 25, 25, "Loans Value: ", false, tabLoan)
		--trateTLbl = DGS:dgsCreateLabel(375, 76, 25, 25, "Interest Rate: ", false, tabLoan)
		--trepayTLbl = DGS:dgsCreateLabel(375, 111, 25, 25, "Repay Amount: ", false, tabLoan)
		
		loanState = state
		loanValue = value
		
		tinfoTlbl = DGS:dgsCreateLabel(170, 165, 175, 29, "You Already Have A loan You Need To Pay it First!", false, tabLoanalready)
		tvalueTlbl = DGS:dgsCreateLabel(300, 190, 175, 29, "", false, tabLoanalready)

		tnameTLbl = DGS:dgsCreateLabel(20, 41, 25, 25, "Your Name:", false, tabLoan)
		tNameT = DGS:dgsCreateEdit(90, 35, 175, 29, "", false, tabLoan, tocolor(200, 200, 200, 255), _, _, btnRect)
		DGS:dgsSetText (tNameT, getPlayerName(localPlayer):gsub("_", " "))
		DGS:dgsEditSetReadOnly(tNameT, true)
		
		tphoneTLbl = DGS:dgsCreateLabel(20, 86, 25, 25, "Phone No.:", false, tabLoan)
		tPhoneT = DGS:dgsCreateEdit(90, 80, 175, 29, "", false, tabLoan, tocolor(200, 200, 200, 255), _, _, btnRect)
		local hasPhone, itemKey, itemValue, itemID = exports.global:hasItem(localPlayer, 2)
		DGS:dgsSetText (tPhoneT, itemValue)
		DGS:dgsEditSetReadOnly(tPhoneT, true)
		
		tsalaryTLbl = DGS:dgsCreateLabel(20, 131, 25, 25, "Your Salary:", false, tabLoan)
		tSalaryT = DGS:dgsCreateEdit(90, 125, 175, 29, "200", false, tabLoan, tocolor(200, 200, 200, 255), _, _, btnRect)
		--DGS:dgsSetText (tSalaryT, mySalary)
		DGS:dgsEditSetReadOnly(tSalaryT, true)
		
		tageTLbl = DGS:dgsCreateLabel(300, 41, 25, 25, "Your Age:", false, tabLoan)
		tAgeT = DGS:dgsCreateEdit(370, 35, 175, 29, "", false, tabLoan, tocolor(200, 200, 200, 255), _, _, btnRect)
		DGS:dgsSetText (tAgeT, getElementData(localPlayer, "age"))
		DGS:dgsEditSetReadOnly(tAgeT, true)
		
		tloanTGrid = DGS:dgsCreateGridList (20, 200, 550, 160, false, tabLoan )
		local columnlvalue = DGS:dgsGridListAddColumn( tloanTGrid, "Loans Value", 0.25 )
		local columnirate = DGS:dgsGridListAddColumn( tloanTGrid, "Interest Rate", 0.30 )
		local columnivalue = DGS:dgsGridListAddColumn( tloanTGrid, "Interest Value", 0.30 )
		local columnfvalue = DGS:dgsGridListAddColumn( tloanTGrid, "Final Value", 0.30 )
		local columnsvalue = DGS:dgsGridListAddColumn( tloanTGrid, "Salary", 0.20 )
		
		for i, v in ipairs (loans) do
		local row = DGS:dgsGridListAddRow ( tloanTGrid )
		DGS:dgsGridListSetItemText ( tloanTGrid, row, columnlvalue, v[1] )
		DGS:dgsGridListSetItemText ( tloanTGrid, row, columnirate, v[2] )
		DGS:dgsGridListSetItemText ( tloanTGrid, row, columnivalue, v[3] )
		DGS:dgsGridListSetItemText ( tloanTGrid, row, columnfvalue, v[4] )
		DGS:dgsGridListSetItemText ( tloanTGrid, row, columnsvalue, v[5] )
		DGS:dgsSetProperty(tloanTGrid,"font",robotoFont11)
		DGS:dgsSetProperty(tloanTGrid,"rowHeight",40)
		DGS:dgsGridListSetRowBackGroundColor(tloanTGrid,row,tocolor(25, 25, 25, 200),tocolor(255,51,51,200),tocolor(255,51,51,255))
		
		availableItemscroll = DGS:dgsGridListGetScrollBar( tloanTGrid )
		DGS:dgsSetProperty(availableItemscroll,"arrowColor",{tocolor(65, 65, 65, 200), tocolor(255, 51, 51, 225), tocolor(255, 51, 51, 255)})
		DGS:dgsSetProperty(availableItemscroll,"cursorColor",{tocolor(65, 65, 65, 200), tocolor(255, 51, 51, 225), tocolor(255, 51, 51, 255)})
		end
		DGS:dgsEditSetPlaceHolder( tNameT, "" )
				
		lrulesB = DGS:dgsCreateButton(200, 165, 175, 29, "Rules", false, tabLoan, tocolor(200, 200, 200, 255), _, _, btnRect, btnRecthov, btnRectClick)				
		addEventHandler("onDgsMouseClickDown", lrulesB, showRules, false)
		
		laccC = DGS:dgsCreateCheckBox(380, 165, 175, 29,"Accepet Rules",false,false,tabLoan)
		
		lsumbitB = DGS:dgsCreateButton(200, 365, 175, 29, "Sumbit Loan", false, tabLoan, tocolor(200, 200, 200, 255), _, _, btnRect, btnRecthov, btnRectClick)		
		--DGS:dgsSetEnabled(lsumbitB, false)
				
				
				
				
		bClose = DGS:dgsCreateButton(788, 21, 26, 23, "", false, wBank, tocolor(200, 200, 200, 255), _, _, ":interaction/icons/cross_x.png", ":interaction/icons/cross_x.png", ":interaction/icons/cross_x.png",_, tocolor(255,51,51,200), tocolor(255, 51, 51, 255))
		addEventHandler("onDgsMouseClickDown", bClose, hideBankUI, false)

		local balance = getElementData(localPlayer, "bankmoney")

		maingrid = DGS:dgsCreateGridList(9, 65, 215, 391, false, wBank, _, tocolor(5,5,5,255), _, tocolor(5,5,5,255))
        local column = DGS:dgsGridListAddColumn( maingrid, "", 0.95 )
		DGS:dgsGridListSetNavigationEnabled(maingrid, false)
		
		for i = 1, 5 do
		row = DGS:dgsGridListAddRow(maingrid)
		end
		DGS:dgsGridListSetItemText(maingrid, 1, column, "        Personal Banking", false)
		DGS:dgsGridListSetItemText(maingrid, 2, column, "        Personal Transactions", false)
		DGS:dgsGridListSetItemText(maingrid, 3, column, "        Bank Loan", false)
		DGS:dgsGridListSetItemText(maingrid, 4, column, "        Business Banking", false)
		DGS:dgsGridListSetItemText(maingrid, 5, column, "        Business Transactions", false)
		
		DGS:dgsSetProperty(maingrid,"rowHeight",40)
		DGS:dgsGridListSetColumnHeight(maingrid, 0)

		DGS:dgsGridListSetRowBackGroundColor(maingrid,1,tocolor(25, 25, 25, 200),tocolor(255,51,51,200),tocolor(255,51,51,255))
		DGS:dgsGridListSetRowBackGroundColor(maingrid,2,tocolor(15, 15, 15, 200),tocolor(255,51,51,200),tocolor(255,51,51,255))
		DGS:dgsGridListSetRowBackGroundColor(maingrid,3,tocolor(25, 25, 25, 200),tocolor(255,51,51,200),tocolor(255,51,51,255))
		DGS:dgsGridListSetRowBackGroundColor(maingrid,4,tocolor(15, 15, 15, 200),tocolor(255,51,51,200),tocolor(255,51,51,255))
		DGS:dgsGridListSetRowBackGroundColor(maingrid,5,tocolor(25, 25, 25, 200),tocolor(255,51,51,200),tocolor(255,51,51,255))
		
		DGS:dgsGridListSetItemImage(maingrid,1,1,coins,tocolor(255,255,255,255),-5,2,32,32,false)
		DGS:dgsGridListSetItemImage(maingrid,2,1,finance,tocolor(255,255,255,255),-5,5,32,32,false)
		DGS:dgsGridListSetItemImage(maingrid,3,1,loan,tocolor(255,255,255,255),-5,5,32,32,false)
		DGS:dgsGridListSetItemImage(maingrid,4,1,banks,tocolor(255,255,255,255),-5,5,35,35,false)
		DGS:dgsGridListSetItemImage(maingrid,5,1,finance,tocolor(255,255,255,255),-5,5,32,32,false)
		
		DGS:dgsSetProperty(maingrid,"font",robotoFont11)
		DGS:dgsGridListSetSelectedItem (maingrid, 1)

		DGS:dgsSetVisible(tabPersonalTransactions, false)
		DGS:dgsSetVisible(tabBusiness, false)
		DGS:dgsSetVisible(tabBusinessTransactions, false)
		DGS:dgsSetVisible(tabLoan, false)

		--outputDebugString(balance)
		--outputDebugString(exports.global:formatMoney(balance))

			local rowCount = DGS:dgsGridListGetRowCount ( maingrid )
			if not (isInFaction) and not (isFactionLeader) --[[and not(bannedTypes[factionType])]] then
				for i = 4, rowCount do 
					DGS:dgsGridListRemoveRow ( maingrid, 4 )--to del Business from all except leaders from faction \--Dharma
				end
			end

		--shit
		lBalance = DGS:dgsCreateLabel(0.1, 0.05, 0.9, 0.05, "Balance: $" .. exports.global:formatMoney(balance), true, tabPanel)
		DGS:dgsSetProperty(lBalance,"font",robotoFont10)
		--DGS:dgsSetFont(lBalance, "default-bold-small")

		if withdrawable then
			-- WITHDRAWAL PERSONAL
			lWithdrawP = DGS:dgsCreateLabel(0.1, 0.15, 0.2, 0.05, "Withdraw:", true, tabPanel)
			DGS:dgsSetProperty(lWithdrawP,"font",robotoFont10)
			--DGS:dgsSetFont(lWithdrawP, "default-bold-small")

			tWithdrawP = DGS:dgsCreateEdit(0.22, 0.13, 0.2, 0.075, "", true, tabPanel, tocolor(200, 200, 200, 255), _, _, btnRect)
		--	DGS:dgsSetFont(tWithdrawP, "default-bold-small")
			DGS:dgsSetProperty(tWithdrawP,"font",robotoFont10)
			DGS:dgsEditSetPlaceHolder( tWithdrawP, "0" )
			--[[
			addEventHandler("onDgsMouseClickDown", tWithdrawP, function()
				if DGS:dgsGetText(tWithdrawP) == "0" then
					DGS:dgsSetText(tWithdrawP, "")
				end
			end, false)
]]
			bWithdrawP = DGS:dgsCreateButton(0.44, 0.13, 0.2, 0.075, "Withdraw", true, tabPanel, tocolor(200, 200, 200, 255), _, _, btnRect, btnRecthov, btnRectClick)
			addEventHandler("onDgsMouseClickDown", bWithdrawP, withdrawMoneyPersonal, false)
		else
			lWithdrawP = DGS:dgsCreateLabel(0.1, 0.15, 0.5, 0.05, "This ATM does not support the withdraw function.", true, tabPanel)
			DGS:dgsSetProperty(lWithdrawP,"font",robotoFont10)
			--DGS:dgsSetFont(lWithdrawP, "default-bold-small")
		end

		if (depositable) then
			-- DEPOSIT PERSONAL
			lDepositP = DGS:dgsCreateLabel(0.1, 0.25, 0.2, 0.05, "Deposit:", true, tabPanel)
			DGS:dgsSetProperty(lDepositP,"font",robotoFont10)
			--DGS:dgsSetFont(lDepositP, "default-bold-small")

			tDepositP = DGS:dgsCreateEdit(0.22, 0.23, 0.2, 0.075, "", true, tabPanel, tocolor(200, 200, 200, 255), _, _, btnRect)
			DGS:dgsSetProperty(tDepositP,"font",robotoFont10)
			DGS:dgsEditSetPlaceHolder( tDepositP, "0" )
			--DGS:dgsSetFont(tDepositP, "default-bold-small")
			--[[
			addEventHandler("onDgsMouseClickDown", tDepositP, function()
				if DGS:dgsGetText(tDepositP) == "0" then
					DGS:dgsSetText(tDepositP, "")
				end
			end, false)
]]
			bDepositP = DGS:dgsCreateButton(0.44, 0.23, 0.2, 0.075, "Deposit", true, tabPanel, tocolor(200, 200, 200, 255), _, _, btnRect, btnRecthov, btnRectClick)
			addEventHandler("onDgsMouseClickDown", bDepositP, depositMoneyPersonal, false)
		else
			lDepositP = DGS:dgsCreateLabel(0.1, 0.25, 0.5, 0.05, "This ATM does not support the deposit function.", true, tabPanel)
			DGS:dgsSetProperty(lDepositP,"font",robotoFont10)
			--DGS:dgsSetFont(lDepositP, robotoFont10)

			if limitedwithdraw > 0 and withdrawable then
				tDepositP = DGS:dgsCreateLabel(0.67, 0.15, 0.2, 0.05, "Max: $" .. ( limitedwithdraw - ( getElementData( source, "withdrawn" ) or 0 ) ) .. ".", true, tabPanel)
				DGS:dgsSetProperty(tDepositP,"font",robotoFont10)
				--DGS:dgsSetFont(tDepositP, robotoFont10)
			end
		end

		if hoursplayed >= 12 then
			-- TRANSFER PERSONAL
			lTransferP = DGS:dgsCreateLabel(0.1, 0.45, 0.2, 0.05, "Transfer:", true, tabPanel)
			DGS:dgsSetProperty(lTransferP,"font",robotoFont10)
			--DGS:dgsSetFont(lTransferP, robotoFont10)

			tTransferP = DGS:dgsCreateEdit(0.22, 0.43, 0.2, 0.075, "", true, tabPanel, tocolor(200, 200, 200, 255), _, _, btnRect)
			DGS:dgsSetProperty(tTransferP,"font",robotoFont10)
			--DGS:dgsSetFont(tTransferP, robotoFont10)
			DGS:dgsEditSetPlaceHolder( tTransferP, "0" )
			--[[
			addEventHandler("onDgsMouseClickDown", tTransferP, function()
				if DGS:dgsGetText(tTransferP) == "0" then
					DGS:dgsSetText(tTransferP, "")
				end
			end, false)
]]
			bTransferP = DGS:dgsCreateButton(0.44, 0.43, 0.2, 0.075, "Transfer to", true, tabPanel, tocolor(200, 200, 200, 255), _, _, btnRect, btnRecthov, btnRectClick)
			addEventHandler("onDgsMouseClickDown", bTransferP, transferMoneyPersonal, false)

			eTransferP = DGS:dgsCreateEdit(0.66, 0.43, 0.3, 0.075, "", true, tabPanel, tocolor(200, 200, 200, 255), _, _, btnRect)
			DGS:dgsEditSetPlaceHolder( eTransferP, "<Player/Faction Name>" )
			--[[
			addEventHandler("onDgsMouseClickDown", eTransferP, function()
				if DGS:dgsGetText(eTransferP) == "<Player/Faction Name>" then
					DGS:dgsSetText(eTransferP, "")
				end
			end, false)
]]
			lTransferPReason = DGS:dgsCreateLabel(0.1, 0.55, 0.2, 0.05, "Reason:", true, tabPanel)
			DGS:dgsSetProperty(lTransferPReason,"font",robotoFont10)
			--DGS:dgsSetFont(lTransferPReason, robotoFont10)

			tTransferPReason = DGS:dgsCreateEdit(0.22, 0.54, 0.74, 0.075, "", true, tabPanel, tocolor(200, 200, 200, 255), _, _, btnRect)
			DGS:dgsEditSetPlaceHolder( tTransferPReason, "<What is this transaction for?>" )
			--[[
			addEventHandler("onDgsMouseClickDown", tTransferPReason, function()
				if DGS:dgsGetText(tTransferPReason) == "<What is this transaction for?>" then
					DGS:dgsiSetText(tTransferPReason, "")
				end
			end, false)
			]]
		end

		-- TRANSACTION HISTORY

		gPersonalTransactions = DGS:dgsCreateGridList(0.02, 0.02, 0.96, 0.96, true, tabPersonalTransactions)
		for key, value in ipairs( transactionColumns ) do
			DGS:dgsGridListAddColumn( gPersonalTransactions, value[1], value[2] or 0.1 )
		end

		DGS:dgsSetInputEnabled(true)

		--outputChatBox("Welcome to the Bank of Los Santos")

	end
end
addEvent("showBankUI", true)
addEventHandler("showBankUI", getRootElement(), showBankUI)

function showRules()
        rulesWnd = DGS:dgsCreateWindow((screenW - 397) / 2, (screenH - 360) / 2, 397, 360, "", false, _, -1, _, _, _, tocolor(10, 10, 10, 255), _, true)
        DGS:dgsWindowSetSizable(rulesWnd, false)

        rulesMemo = DGS:dgsCreateMemo(3, 3, 390, 325, "مرحبا بك عميلنا العزيز,\nهل تود تقديم قرض بنكي؟\nسوف نساعدك على ذلك بكل تأكيد\nيمكنك الآن تقديم قرض بنكي بكل سهولة وبفوائد قليلة\nولكن يجب عليك ان توقع على بعض الأوراق لتأكد من استعدادك على تحمل القرض\n\nاولا: يجب ان تكون موظف وان لايقل راتبك عن 1000$\nثانيا: هنالك فائدة تصل لـ 10% على القرض الذي سوف تأخذه\nثالثا: ستكون هنالك مهلة لاتقل ولاتزيد عن شهر\nرابعا: سيتم رهن بعض ممتلكاتك الخاصة في حال عدم سدادك للقرض في الفترة المحددة\nخامسا: في حال خروجك من الوظيفة سيتم رهن بعض ممتلكاتك الخاصة\n\nفي حال توقعيك وقبولك لهذه الشروط ستصبح ملزم على تنفيذها ولن يتم التنازل نهائيا عناي شرط\n\nمع خالص تحياتنا\nبنك لوس سانتوس\n\nتوقيع مدير البنك\n#Dharma Dharma", false, rulesWnd, _, _, _, _, tocolor(20, 20, 20, 255))
        rclsB = DGS:dgsCreateButton(114, 333, 173, 22, "Close", false, rulesWnd, tocolor(200, 200, 200, 255), _, _, btnRect, btnRecthov, btnRectClick)   
end

function hideBankUI()
	if isElement(wBank) then
		destroyElement(wBank)
		wBank = nil

		guiSetInputEnabled(false)

		cooldown = setTimer(function() cooldown = nil end, 1000, 1)
		setElementData(getLocalPlayer(), "exclusiveGUI", false, false)
	end
end
addEvent("hideBankUI", true)
addEventHandler("hideBankUI", getRootElement(), hideBankUI)
addEventHandler ( "onSapphireXMBShow", getRootElement(), hideBankUI )
addEventHandler("onClientChangeChar", getRootElement(), hideBankUI)

function withdrawMoneyPersonal(button)
	if (button=="left") then
		local amount = tonumber2(DGS:dgsGetText(tWithdrawP))
		local money = getElementData(localPlayer, "bankmoney")

		local oldamount = getElementData( lastUsedATM, "withdrawn" ) or 0
		if not amount or amount <= 0 or math.ceil( amount ) ~= amount then
			outputChatBox("Please enter a positive amount!", 255, 0, 0)
		elseif (amount>money) then
			outputChatBox("You do not have enough funds.", 255, 0, 0)
		elseif not _depositable and limitedwithdraw ~= 0 and oldamount + amount > limitedwithdraw then
			outputChatBox("This ATM only allows you to withdraw $" .. exports.global:formatMoney( limitedwithdraw - oldamount ) .. ".")
		else
			setElementData( lastUsedATM, "withdrawn", oldamount + amount, false )
			setTimer(
				function( atm, amount )
					setElementData( atm, "withdrawn", getElementData( atm, "withdrawn" ) - amount )
				end,
				120000, 1, lastUsedATM, amount
			)
			hideBankUI()
			triggerServerEvent("withdrawMoneyPersonal", localPlayer, amount)
		end
	end
end

function depositMoneyPersonal(button)
	if (button=="left") then
		local amount = tonumber2(DGS:dgsGetText(tDepositP))

		if not amount or amount <= 0 or math.ceil( amount ) ~= amount then
			outputChatBox("Please enter a positive amount!", 255, 0, 0)
		elseif not exports.global:hasMoney(localPlayer, amount) then
			outputChatBox("You do not have enough funds.", 255, 0, 0)
		else
			hideBankUI()
			triggerServerEvent("depositMoneyPersonal", localPlayer, amount)
		end
	end
end

function transferMoneyPersonal(button)
	if (button=="left") then
		local amount = tonumber2(DGS:dgsGetText(tTransferP))
		local money = getElementData(localPlayer, "bankmoney")
		local reason = DGS:dgsGetText(tTransferPReason)
		local playername = DGS:dgsGetText(eTransferP)

		if not amount or amount <= 0 or math.ceil( amount ) ~= amount then
			outputChatBox("Please enter a positive amount!", 255, 0, 0)
		elseif (amount>money) then
			outputChatBox("You do not have enough funds.", 255, 0, 0)
		elseif reason == "" then
			outputChatBox("Please enter a reason for the Transfer!", 255, 0, 0)
		elseif playername == "" then
			outputChatBox("Please enter the full character name of the reciever!", 255, 0, 0)
		else
			triggerServerEvent("transferMoneyToPersonal", localPlayer, false, playername, amount, reason)
			DGS:dgsSetText(tTransferP, "0")
			DGS:dgsSetText(tTransferPReason, "")
			DGS:dgsSetText(eTransferP, "")
		end
	end
end

function withdrawMoneyBusiness(button)
	if (button=="left") then
		local amount = tonumber2(DGS:dgsGetText(tWithdrawB))

		local oldamount = getElementData( lastUsedATM, "withdrawn" ) or 0
		if not amount or amount <= 0 or math.ceil( amount ) ~= amount then
			outputChatBox("Please enter a positive amount!", 255, 0, 0)
		elseif (amount>gfactionBalance) then
			outputChatBox("You do not have enough funds.", 255, 0, 0)
		elseif not _depositable and limitedwithdraw ~= 0 and oldamount + amount > limitedwithdraw then
			outputChatBox("This ATM only allows you to withdraw $" .. exports.global:formatMoney( limitedwithdraw - oldamount ) .. ".")
		else
			setElementData( lastUsedATM, "withdrawn", oldamount + amount, false )
			setTimer(
				function( atm, amount )
					setElementData( atm, "withdrawn", getElementData( atm, "withdrawn" ) - amount, false )
				end,
				120000, 1, lastUsedATM, amount
			)
			hideBankUI()
			triggerServerEvent("withdrawMoneyBusiness", localPlayer, amount)
		end
	end
end

function depositMoneyBusiness(button)
	if (button=="left") then
		local amount = tonumber2(DGS:dgsGetText(tDepositB))

		if not amount or amount <= 0 or math.ceil( amount ) ~= amount then
			outputChatBox("Please enter a positive amount!", 255, 0, 0)
		elseif not exports.global:hasMoney(localPlayer, amount) then
			outputChatBox("You do not have enough funds.", 255, 0, 0)
		else
			hideBankUI()
			triggerServerEvent("depositMoneyBusiness", localPlayer, amount)
		end
	end
end

function transferMoneyBusiness(button)
	if (button=="left") then
		local amount = tonumber2(DGS:dgsGetText(tTransferB))
		local playername = DGS:dgsGetText(eTransferB)
		local reason = DGS:dgsGetText(tTransferBReason)

		if not amount or amount <= 0 or math.ceil( amount ) ~= amount then
			outputChatBox("Please enter a positive amount!", 255, 0, 0)
		elseif (amount>gfactionBalance) then
			outputChatBox("You do not have enough funds.", 255, 0, 0)
		elseif reason == "" then
			outputChatBox("Please enter a reason for the Transfer!", 255, 0, 0)
		elseif playername == "" then
			outputChatBox("Please enter the full character name of the reciever!", 255, 0, 0)
		else
			triggerServerEvent("transferMoneyToPersonal", localPlayer, true, playername, amount, reason)
			DGS:dgsSetText(tTransferB, "0")
			DGS:dgsSetText(tTransferBReason, "")
			DGS:dgsSetText(eTransferB, "")
		end
	end
end

function getTransactionReason(type, reason, from)
	if type == 0 or type == 4 then
		return "Withdraw"
	elseif type == 1 or type == 5 then
		return "Deposit"
	elseif type == 6 then
		return tostring(reason or "")
	elseif type == 7 then
		return "Payday (Biz+Interest+Donator)"
	elseif type == 8 then
		return "Budget"
	elseif type == 9 then
		return tostring("Fuel: "..math.ceil(reason).."L")
	elseif type == 10 then
		return "Repair"
	elseif type == 11 then
		return "Wage"
	else
		return "Transfer: " .. tostring(reason or "")
	end
end

function recieveTransfer(grid,  id, amount, time, type, from, to, reason, details)
	local row = DGS:dgsGridListAddRow(grid)
	DGS:dgsGridListSetItemText(grid, row, 1, tostring(id), false, true)
	DGS:dgsGridListSetItemText(grid, row, 2, from, false, false)
	DGS:dgsGridListSetItemText(grid, row, 3, to, false, false)
	DGS:dgsGridListSetRowBackGroundColor(grid,row,tocolor(25, 25, 25, 200),tocolor(255,51,51,200),tocolor(255,51,51,255))
	DGS:dgsSetProperty(grid,"font",robotoFont11)
	DGS:dgsSetProperty(grid,"rowHeight",40)
	availableItemscroll = DGS:dgsGridListGetScrollBar( grid )
	DGS:dgsSetProperty(availableItemscroll,"arrowColor",{tocolor(65, 65, 65, 200), tocolor(255, 51, 51, 225), tocolor(255, 51, 51, 255)})
	DGS:dgsSetProperty(availableItemscroll,"cursorColor",{tocolor(65, 65, 65, 200), tocolor(255, 51, 51, 225), tocolor(255, 51, 51, 255)})
	if amount < 0 then
		DGS:dgsGridListSetItemText(grid, row, 4, "-$"..exports.global:formatMoney(math.abs(amount)), false, true)
		DGS:dgsGridListSetItemColor(grid, row, 4, 255, 127, 127)
	else
		DGS:dgsGridListSetItemText(grid, row, 4, "$"..exports.global:formatMoney(amount), false, true)
		DGS:dgsGridListSetItemColor(grid, row, 4, 127, 255, 127)
	end
	DGS:dgsGridListSetItemText(grid, row, 5, time, false, false)
	DGS:dgsGridListSetItemText(grid, row, 6, " " .. getTransactionReason(type, reason, from), false, false)
	DGS:dgsGridListSetItemText(grid, row, 7, " " .. details, false, false)
end

function recievePersonalTransfer(...)
	recieveTransfer(gPersonalTransactions, ...)
end

addEvent("recievePersonalTransfer", true)
addEventHandler("recievePersonalTransfer", localPlayer, recievePersonalTransfer)

function recieveBusinessTransfer(...)
	recieveTransfer(gBusinessTransactions, ...)
end

addEvent("recieveBusinessTransfer", true)
addEventHandler("recieveBusinessTransfer", localPlayer, recieveBusinessTransfer)

function checkDataChange(dn)
	if wBank then
		if dn == "bankmoney" and source == localPlayer then
			DGS:dgsSetText(lBalance, "Balance: $" .. exports.global:formatMoney(getElementData(source, "bankmoney")))
		elseif dn == "money" and source == getPlayerTeam(localPlayer) then
			gfactionBalance = getElementData(source, "money")
			DGS:dgsSetText(lBalanceB, "Balance: $" .. exports.global:formatMoney(gfactionBalance))
		end
	end
end
addEventHandler("onClientElementDataChange", getRootElement(), checkDataChange)

local thisResourceElement = getResourceRootElement(getThisResource())
function cleanUp()
	setElementData(getLocalPlayer(), "exclusiveGUI", false, false)
end
addEventHandler("onClientResourceStart", thisResourceElement, cleanUp)

function fadeOut()
	fadeCamera ( true, 1, 0, 0, 0 )
end
addEvent("bank:fadeOut", true)
addEventHandler("bank:fadeOut", localPlayer, fadeOut)

function isCameraOnPlayer()
	local vehicle = getPedOccupiedVehicle(getLocalPlayer())
	if vehicle then
		return getCameraTarget( ) == vehicle
	else
		return getCameraTarget( ) == getLocalPlayer()
	end
end

function hasBankMoney(thePlayer, amount)
	amount = tonumber(amount)
	amount = math.floor(math.abs(amount))
	return getElementData(thePlayer, "bankmoney") >= amount
end

addEventHandler ( "onDgsMouseClickDown", root, function ( button, state  )
	if source == maingrid then 
		local Selected = DGS:dgsGridListGetSelectedItem(maingrid)
		if Selected == 1 then 
			DGS:dgsSetVisible(tabPanel, not DGS:dgsGetVisible(tabPanel))
			DGS:dgsSetVisible(tabPersonalTransactions, false)
			DGS:dgsSetVisible(tabLoan, false)
			DGS:dgsSetVisible(tabBusiness, false)
			DGS:dgsSetVisible(tabBusinessTransactions, false)
		elseif Selected == 2 then
		DGS:dgsSetVisible(tabPersonalTransactions, not DGS:dgsGetVisible(tabPersonalTransactions))
			DGS:dgsSetVisible(tabPanel, false)
			DGS:dgsSetVisible(tabLoan, false)
			DGS:dgsSetVisible(tabBusiness, false)
			DGS:dgsSetVisible(tabBusinessTransactions, false)
			
			DGS:dgsGridListClear(gPersonalTransactions)
			triggerServerEvent("tellTransfersPersonal", localPlayer, cardInfoSaved)
		
		elseif Selected == 3 then
			if loanState == "Unpayed" then
			DGS:dgsSetVisible(tabLoanalready, not DGS:dgsGetVisible(tabLoanalready))
			
			DGS:dgsSetText(tvalueTlbl, "$" .. loanValue)
			
			DGS:dgsSetVisible(tabPanel, false)
			DGS:dgsSetVisible(tabPersonalTransactions, false)
			DGS:dgsSetVisible(tabBusiness, false)
			DGS:dgsSetVisible(tabBusinessTransactions, false)
			DGS:dgsSetVisible(tabLoan, false)
			else
			DGS:dgsSetVisible(tabLoan, not DGS:dgsGetVisible(tabLoan))
			DGS:dgsSetVisible(tabPanel, false)
			DGS:dgsSetVisible(tabPersonalTransactions, false)
			DGS:dgsSetVisible(tabBusiness, false)
			DGS:dgsSetVisible(tabBusinessTransactions, false)
			end
		elseif Selected == 4 then
			DGS:dgsSetVisible(tabBusiness, not DGS:dgsGetVisible(tabBusiness))
			DGS:dgsSetVisible(tabPanel, false)
			DGS:dgsSetVisible(tabLoan, false)
			DGS:dgsSetVisible(tabPersonalTransactions, false)
			DGS:dgsSetVisible(tabBusinessTransactions, false)

		elseif Selected == 5 then
			DGS:dgsSetVisible(tabBusinessTransactions, not DGS:dgsGetVisible(tabBusinessTransactions))
			DGS:dgsSetVisible(tabPanel, false)
			DGS:dgsSetVisible(tabLoan, false)
			DGS:dgsSetVisible(tabPersonalTransactions, false)
			DGS:dgsSetVisible(tabBusiness, false)

			DGS:dgsGridListClear(gBusinessTransactions)
			triggerServerEvent("tellTransfersBusiness", localPlayer)
			
		end
	end
end )


function Salary (mySalary)
	--states = state
--	values = value
	if mySalary and mySalary >= 1000 then
		DGS:dgsSetText (tSalaryT, mySalary)
		else
		DGS:dgsSetText (tSalaryT, "Your Salary Poor")
	end
end
addEvent("mySalary", true)
addEventHandler("mySalary", root, Salary)
--[[
function test ()
		outputChatBox(values)
end
addCommandHandler("t", test)
]]
--local loansElement = createElement("Loans", "LoansTypes")
addEventHandler ( "onDgsMouseClickDown", root, function ( button, state  )
		local phoneNo = DGS:dgsGetText(tPhoneT)
		local ratb = DGS:dgsGetText(tSalaryT)
		local age = DGS:dgsGetText(tAgeT)
		
		local accrule = DGS:dgsCheckBoxGetSelected (laccC)
		local Selected = DGS:dgsGridListGetSelectedItem(tloanTGrid)
		
		

	if source == lsumbitB then 
		if (Selected == 1) and (accrule == true) and (tonumber(ratb) >= 1500) then
			triggerServerEvent("giveMeloan", localPlayer, Selected, phoneNo, ratb, age)
			--setElementData(getLocalPlayer(), "loans.states", false)
			--outputChatBox("nice one")
			
		elseif (Selected == 2) and (accrule == true) and (tonumber(ratb) >= 2000) then
			triggerServerEvent("giveMeloan", localPlayer, Selected, phoneNo, ratb, age)
			--outputChatBox("good")
		
		elseif (Selected == 3) and (accrule == true) and (tonumber(ratb) >= 2500) then
			triggerServerEvent("giveMeloan", localPlayer, Selected, phoneNo, ratb, age)
			--outputChatBox("perfect")
			
		else
			outputChatBox("You Either Not Accepet The Rule, or You Salary Not Enough")
		
		end
	end
end )


--addEventHandler("onClientResourceStart", resourceRoot,
function ShowLoansGUI(LoansInfos)
        Wnd = guiCreateWindow((screenW - 831) / 2, (screenH - 510) / 2, 831, 510, "Bank Loans Adminstrater", false)
        guiWindowSetSizable(Wnd, false)

        lgridlist = guiCreateGridList(9, 28, 812, 442, false, Wnd)
        IDloans = guiGridListAddColumn(lgridlist, "ID", 0.05)
        nameLoans = guiGridListAddColumn(lgridlist, "Name", 0.08)
        phoneLoans = guiGridListAddColumn(lgridlist, "Phone No.", 0.07)
        salaryLoans = guiGridListAddColumn(lgridlist, "Salary", 0.06)
        ageLoans = guiGridListAddColumn(lgridlist, "Age", 0.04)
        lvalueLoans = guiGridListAddColumn(lgridlist, "Loan Value", 0.1)
        irateLoans = guiGridListAddColumn(lgridlist, "Interest Rate", 0.1)
        ivalueLoans = guiGridListAddColumn(lgridlist, "Interest Value", 0.1)
        fvalueLoans = guiGridListAddColumn(lgridlist, "Final Value", 0.1)
        statLoans = guiGridListAddColumn(lgridlist, "Status", 0.1)
        timeLoans = guiGridListAddColumn(lgridlist, "Time", 0.15)
        clsBtn = guiCreateButton(302, 471, 231, 29, "Close", false, Wnd)    
		
			for key, value in pairs(LoansInfos) do
			local ID = LoansInfos[key][1]
			local Name = LoansInfos[key][2]
			local Phone = LoansInfos[key][3]
			local Salary = LoansInfos[key][4]
			local Age = LoansInfos[key][5]
			local lValue = LoansInfos[key][6]
			local IRate = LoansInfos[key][7]
			local IValue = LoansInfos[key][8]
			local FValue = LoansInfos[key][9]
			local States = LoansInfos[key][10]
			local Time = LoansInfos[key][11]
			local row = guiGridListAddRow(lgridlist)
			--local namec = exports.global:getCharacterNameFromID(tostring(Issuer))
			guiGridListSetItemText(lgridlist, row, IDloans, tostring(ID), false, false)
			guiGridListSetItemText(lgridlist, row, nameLoans, tostring(Name), false, false)
			guiGridListSetItemText(lgridlist, row, phoneLoans, tostring(Phone), false, false)
			guiGridListSetItemText(lgridlist, row, salaryLoans, tostring(Salary), false, false)
			guiGridListSetItemText(lgridlist, row, ageLoans, tostring(Age), false, false)
			guiGridListSetItemText(lgridlist, row, lvalueLoans, tostring(lValue), false, false)
			guiGridListSetItemText(lgridlist, row, irateLoans, tostring(IRate), false, false)
			guiGridListSetItemText(lgridlist, row, ivalueLoans, tostring(IValue), false, false)
			guiGridListSetItemText(lgridlist, row, fvalueLoans, tostring(FValue), false, false)
			guiGridListSetItemText(lgridlist, row, statLoans, tostring(States), false, false)
			guiGridListSetItemText(lgridlist, row, timeLoans, tostring(Time), false, false)
		end
		
    end
addEvent("ShowLoansGUI", true)
addEventHandler("ShowLoansGUI", getRootElement(), ShowLoansGUI)

addEventHandler("onClientGUIClick", root,
function ()
	if source == clsBtn then
		destroyElement(Wnd)
	end
end)

function open ()
	if ( guiGetVisible(Wnd) == false ) then
		triggerServerEvent("ShowAllLoans", getRootElement(), getLocalPlayer())
	end
end
addCommandHandler("openloan", open)
