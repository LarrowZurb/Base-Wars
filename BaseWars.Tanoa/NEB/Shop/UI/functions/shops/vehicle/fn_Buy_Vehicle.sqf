
params[ "_className", "_cost" ];

//Get empty position
_emptyPos = position player findEmptyPosition [ 5, 50, _className ];

if ( _emptyPos isEqualTo [] ) then {
	hint "Not enough room to spawn Vehicle";
} else {
	
	//Deduct cost - player cannot get here if not enough money or level as the button is disabled
	[ _cost ] call NEB_fnc_core_pay;
	
	//Spawn Vehicle
	_veh = createVehicle [ _className, _emptyPos, [], 0, "" ];
	clearWeaponCargoGlobal _veh;
	clearMagazineCargoGlobal _veh;
	clearItemCargoGlobal _veh;
	
	player setDir (getDir _veh);
	
};