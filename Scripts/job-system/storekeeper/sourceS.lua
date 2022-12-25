level = {
	[1] = 50,
	[2] = 200,
	[3] = 1000,
	[4] = 3200,
	[5] = 5400,
}
addEventHandler("onResourceStart", getResourceRootElement(),
	function ()
		setElementData(resourceRoot, "donePackages", 0)
	end
)

addEvent("crateCarryAnimation", true)
addEventHandler("crateCarryAnimation", getRootElement(),
	function ()
		if isElement(source) then
			setPedAnimation(source, "carry", "crry_prtial", 0, true, true, false, true)
		end
	end
)

addEvent("cratePutDownAnimation", true)
addEventHandler("cratePutDownAnimation", getRootElement(),
	function (transportedCrate)
		if isElement(source) then
			setPedAnimation(source, "carry", "putdwn", 1000, true, true, false, false)

			if transportedCrate then
				local donePackages = getElementData(resourceRoot, "donePackages")
				setElementData(resourceRoot, "donePackages", donePackages + 1)
			end
		end
	end
)

addEvent("giveStorekeeperJobCash", true)
addEventHandler("giveStorekeeperJobCash", getRootElement(),
	function (amount)
		if isElement(source) and tonumber(amount) then
			local currentMoney = getElementData(source, "money") or 0

			currentMoney = currentMoney + amount
			exports.global:giveMoney(source, amount)
		end
	end
)
--[[
addEvent("giveStorekeeperJobCash", true)
addEventHandler("giveStorekeeperJobCash", getRootElement(),
	function (amount)
		if isElement(source) and tonumber(amount) then
			local currentMoney = getElementData(source, "money") or 0
			local jobLevel = getElementData(client, "jobLevel") or 0
			local currentProgress = getElementData(client, "jobProgress") or 0
			local truckrunsTilNextLevel = level[jobLevel] or false
			local charID = getElementData(client, "dbid")
	--local hoursrate = math.floor(hours*(rate*0.03))

	if jobLevel <= 1 then
		amount = amount * 25
	elseif jobLevel <= 2 then
		amount = amount * 50
	elseif jobLevel <= 3 then
		amount = amount * 75
	elseif jobLevel <= 4 then
		amount = amount * 100
	elseif jobLevel <= 5 then
		amount = amount * 250
	end
		
			--currentMoney = currentMoney + amount
			exports.global:giveMoney(source, amount)
				setElementData(client, "jobProgress", tonumber(currentProgress) + 1)
	if truckrunsTilNextLevel then
	local truckrunCarry = (currentProgress + 1) - truckrunsTilNextLevel 
		if truckrunCarry >= 0 then -- level up
		setElementData(client, "jobLevel", tonumber(jobLevel) + 1)
		setElementData(client, "jobProgress", tonumber(truckrunCarry))
		export.mysql:query_free("UPDATE `jobs` SET `jobLevel`='"..tonumber(jobLevel + 1).."', `jobProgress`='"..(tonumber(truckrunCarry)).."', `jobTruckingRuns`='0' WHERE `jobID`='3' AND `jobCharID` = '" ..tostring(charID).."' " )
		end
	end
	end
	end
)
]]
