--//
--||	script: Supercar
--||	author: MasterM
--||	date: May / June 2015
--||	purpose: spawn a super powered car
--||	
--||	file: supercar_s (serverside)
--\\

--man kann schießen wenn man stirbt
--man kann als beifahrer schießen

--//
--||	variables
--\\


local SuperCarID = 582
local SuperCarColor = {0, 141, 40}
local SuperCars = {}
local MinigunTriggerKey = "mouse1"
local RocketLauncherTriggerKey = "mouse2"
local RocketLauncherCooldownTime = 1000 -- ms


--//
--||	createSupercar
--\\

function createSupercar(SuperCarSpawnPos)
	local veh = createVehicle(SuperCarID, unpack(SuperCarSpawnPos))
	SuperCars[veh] = {}
	SuperCars[veh].MinigunState = false
	SuperCars[veh].RocketCooldown = getTickCount()
	SuperCars[veh].Hirschkopf = createObject(1736, 0, 0, 0)
	SuperCars[veh].RocketLauncher = createObject(359, 0, 0, 0)
	attachElements(SuperCars[veh].Hirschkopf, veh, 0, 2.9, 0, 10, 0, 180)
	attachElements(SuperCars[veh].RocketLauncher, veh, 0, 1, 1, 0, 0, 90)
	local r, g, b = unpack(SuperCarColor)
	setVehicleColor(veh, r, g, b, r, g, b)
	
	setVehicleHandling (veh, "engineAcceleration", 20)
	setVehicleHandling (veh, "steeringLock", 40)
	setVehicleHandling (veh, "suspensionUpperLimit", 0.25)
	setVehicleHandling (veh, "suspensionLowerLimit", -0.05)
	
	addEventHandler("onVehicleEnter", veh, function(player)
		bindKey(player,MinigunTriggerKey,"both",setMinigunState, veh)
		bindKey(player,RocketLauncherTriggerKey,"down", fireRocket, veh)
	end)
	addEventHandler("onVehicleExit", veh, function(player)
		if isKeyBound(player,MinigunTriggerKey,"both",setMinigunState) then
			unbindKey(player,MinigunTriggerKey,"both",setMinigunState)
			unbindKey(player,RocketLauncherTriggerKey,"down",fireRocket)
		end
	end)
	
	return veh
end


--//
--||	getSupercars
--\\

function getSupercars(player)
	outputConsole("Liste der Supercars:", player)
	for i,v in ipairs(SuperCars) do 
		local id = getElementModel(i)
		local model = getVehicleName(i)
		local driver = getVehicleController(i) and getPlayerName(getVehicleController(i)) or "keiner"
		local posX, posY, posZ = getElementPosition(i)
		local zone, city = getElementZoneName(i), getElementZoneName(i, true)
		outputConsole(("Modell: %s (ID: %s), Fahrer: %s, Standort: %s in %s"):format(model, id, driver, zone, city), player)
	end
	outputConsole(" - Ende der Liste - ", player)

end
addCommandHandler("supercars", getSupercars)


--//
--||	setMinigunState
--\\

function setMinigunState(_, _, _, veh)
	SuperCars[veh].MinigunState = not SuperCars[veh].MinigunState
	triggerClientEvent("Supercar_onMinigunStateChange", resourceRoot, veh, SuperCars[veh].MinigunState)
end


--//
--||	fireRocket
--\\

function fireRocket(_, _, _, veh)
	local cooldown = SuperCars[veh].RocketCooldown
	if getTickCount()-cooldown <= RocketLauncherCooldownTime then return false end
	SuperCars[veh].RocketCooldown = getTickCount()
	triggerClientEvent("Supercar_onRocketFire", resourceRoot, veh)
end


--//
--||	triggerSupercarData
--\\

function triggerSupercarData()
	triggerClientEvent(client, "Supercar_onDataGet", resourceRoot, SuperCars)
end
addEvent("Supercar_onClientDataRequest",true)
addEventHandler("Supercar_onClientDataRequest",resourceRoot,triggerSupercarData)








local SuperCarSpawnPos = {1284.42126, -1701.62842, 13.54688, 0, 0, -90}
supercar = createSupercar(SuperCarSpawnPos)
SuperCarSpawnPos = {1284.42126, -1705.62842, 13.54688, 0, 0, -90}
supercar2 = createSupercar(SuperCarSpawnPos)

