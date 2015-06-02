--//
--||	script: Supercar
--||	author: MasterM
--||	date: May / June 2015
--||	purpose: spawn a super powered car
--||	
--||	file: supercar_c (clientside)
--\\



--//
--||	variables
--\\
local SuperCars = {}
local minigunValues = {name="minigun", x=1.2, y=-2.4, z=0.3, rx=0, ry=30, rz=93, fx=0, fy=-30, fz=-3}

--//
--||	getSupercars
--\\

function getSupercars(supercars)
	SuperCars = supercars
	for i,v in pairs(SuperCars) do
		local mv = minigunValues
		SuperCars[i].MinigunRechts = createWeapon(mv.name, 0, 0, 0)
		SuperCars[i].MinigunLinks = createWeapon(mv.name, 0, 0, 0)
		attachElements(SuperCars[i].MinigunRechts, i, mv.x+0.1, mv.y, mv.z, mv.rx, mv.ry, mv.rz)
		attachElements(SuperCars[i].MinigunLinks, i, -mv.x, mv.y, mv.z, -mv.rx, mv.ry, mv.rz)
		setWeaponProperty(SuperCars[i].MinigunRechts, "fire_rotation",Vector3(mv.fx, mv.fy, mv.fz))
		setWeaponProperty(SuperCars[i].MinigunLinks, "fire_rotation",Vector3(mv.fx, mv.fy, mv.fz))
		setElementParent(SuperCars[i].MinigunRechts, i)
		setElementParent(SuperCars[i].MinigunLinks, i)
		setWeaponState(SuperCars[i].MinigunRechts,"firing")
		setWeaponState(SuperCars[i].MinigunLinks,"firing")
	end
end

addEvent("Supercar_onDataGet",true)
addEventHandler("Supercar_onDataGet",resourceRoot,getSupercars)

addEventHandler("onClientResourceStart",resourceRoot, function()   
	triggerServerEvent("Supercar_onClientDataRequest", resourceRoot)
end)