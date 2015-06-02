--//
--||	script: Supercar
--||	author: MasterM
--||	date: May / June 2015
--||	purpose: spawn a super powered car
--||	
--||	file: supercar_s (serverside)
--\\



--//
--||	variables
--\\

local SuperCarSpawnPos = {1284.42126, -1701.62842, 13.54688, 0, 0, -90}
local SuperCarID = 582
local SuperCarColor = {0, 141, 40}
local SuperCars = {}


--//
--||	createSupercar
--\\

function createSupercar()
	local veh = createVehicle(SuperCarID, unpack(SuperCarSpawnPos))
	SuperCars[veh] = {}
	SuperCars[veh].Hirschkopf = createObject(1736, 0, 0, 0)
	attachElements(SuperCars[veh].Hirschkopf, veh, 0, 2.9, 0, 10, 0, 180)
	local r, g, b = unpack(SuperCarColor)
	setVehicleColor(veh, r, g, b, r, g, b)
	
	setVehicleHandling (veh, "engineAcceleration", 20)
	setVehicleHandling (veh, "steeringLock", 40)
	setVehicleHandling (veh, "suspensionUpperLimit", 0.25)
	setVehicleHandling (veh, "suspensionLowerLimit", -0.05)
	
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
--||	triggerSupercarData
--\\

function triggerSupercarData()
	triggerClientEvent(client, "Supercar_onDataGet", resourceRoot, SuperCars)
end
addEvent("Supercar_onClientDataRequest",true)
addEventHandler("Supercar_onClientDataRequest",resourceRoot,triggerSupercarData)









supercar = createSupercar()

