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
	table.insert(SuperCars, veh)
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
	outputConsole("Liste der Supercars:")
	for i,v in ipairs(SuperCars) do 
		local id = getElementModel(v)
		local model = getVehicleName(v)
		local driver = getVehicleController(v) and getPlayerName(getVehicleController(v)) or "keiner"
		local posX, posY, posZ = getElementPosition(v)
		local zone, city = getElementZoneName(v), getElementZoneName(v, true)
		outputConsole(("Modell: %s (ID: %s), Fahrer: %s, Standort: %s in %s"):format(model, id, driver, zone, city))
	end
	outputConsole(" - Ende der Liste - ")

end
addCommandHandler("supercars", getSupercars)








supercar = createSupercar()

