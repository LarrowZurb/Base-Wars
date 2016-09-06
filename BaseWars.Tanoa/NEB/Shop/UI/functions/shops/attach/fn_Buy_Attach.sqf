
params[ "_className", "_cost" ];

//Remove money
[ _cost ] call NEB_fnc_core_pay;

//Get Crate
_crate = [ "GET" ] call NEB_fnc_shopCrate;

_slots = [ 101, 301, 201, 302 ]; //[ silencer, pointer, optic, bipod ]
_slotClasses = [ "MuzzleSlot", "PointerSlot", "CowsSlot", "UnderBarrelSlot" ];

_slotIndex = _slots find getNumber( configFile >> "CfgWeapons" >> _className >> "itemInfo" >> "type" );
_slotType = _slotClasses select _slotIndex;
_compatibleAttachments = getArray( configFile >> "CfgWeapons" >> currentWeapon player >> "WeaponSlotsInfo" >> _slotType >> "compatibleItems" );
_currentAttachments = player weaponAccessories currentWeapon player;

if ( toLower _classname in ( _compatibleAttachments apply{ toLower _x } ) ) then {
	_toReplace = _currentAttachments select _slotIndex;
	if ( _toReplace != "" ) then {
		_crate addItemCargo [ _toReplace, 1 ];
		[ "SHOW" ] call NEB_fnc_shopCrate;
	};
	player addWeaponItem [ currentWeapon player, _classname ];
}else{
	_crate addItemCargo [ _className, 1 ];
	[ "SHOW" ] call NEB_fnc_shopCrate;
};

[ "UPDATE" ] call NEB_fnc_shopCrate;




