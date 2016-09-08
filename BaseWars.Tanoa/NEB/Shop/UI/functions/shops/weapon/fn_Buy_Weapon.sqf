private [ "_currentWeapon", "_currentAttach", "_cfg", "_compatibleMags", "_currentMags", "_crate", "_magCount",
	"_ammoData", "_priCount", "_priIndex", "_secCount", "_secIndex" ];
params[ "_className", "_cost" ];

//Remove money
[ _cost ] call NEB_fnc_core_pay;

//Get Crate
_crate = [ "GET" ] call NEB_fnc_shopCrate;

//Get current weapon
_currentWeapon = [ primaryWeapon player, secondaryWeapon player, handgunWeapon player ] select NEB_currentButton;

if !( _currentWeapon isEqualTo "" ) then {
		
	//Get current weapon attachments
	_currentAttach = [ primaryWeaponItems player, secondaryWeaponItems player, handgunItems player ] select NEB_currentButton;
					
	_fnc_getCompatMags = {
		params[ "_weapon" ];
		
		//Get weapons compatible magazines
		_cfg = configFile >> "CfgWeapons" >> _weapon;
		
		_compatibleMags = [];
		{
			if ( _x == "this" ) then {
				_compatibleMags = _compatibleMags + getArray( _cfg >> "magazines" );
			}else{
				_compatibleMags = _compatibleMags + getArray( _cfg >> _x >> "magazines" );
			};
		}forEach getArray( _cfg >> "muzzles" );
		
		_compatibleMags
	};
	
	_compatOld = _currentWeapon call _fnc_getCompatMags;
	_compatNew = _className call _fnc_getCompatMags;
	
	//Get current magazines including ones in current weapon that are compatible with the current weapon but not new weapon
	_currentMags = magazinesAmmoFull player select { _x select 0 in _compatOld && { !( _x select 0 in _compatNew ) } };
	
	//Add current weapon base type( we are going to add attachments seperately ) to crate
	[ "CACHE", [ "ADD", [ [ _currentWeapon ] call BIS_fnc_baseWeapon, 1 ] ] ] call NEB_fnc_shopCrate;
	[ "SHOW" ] call NEB_fnc_shopCrate;
	
	{
		_x params[ "_mag", "_ammo" ];
		
		//Add identical magazine to crate including ammo count
		[ "CACHE", [ "ADD", [ _mag, 1, _ammo ] ] ] call NEB_fnc_shopCrate;
		//Remove mag from player
		player removeMagazine _mag;
	}forEach _currentMags;
	
};
				
//function to add mags, checking if the player has space
_fnc_addmags = {
	params[ "_mag", "_count" ];
	
	for "_i" from 1 to _count do {
		if ( player canAdd _mag ) then {
			//add one magazine
			player addMagazine _mag;
		}else{
			//else add it to crate
			[ "CACHE", [ "ADD", [ _mag, 1 ] ] ] call NEB_fnc_shopCrate;
			[ "SHOW" ] call NEB_fnc_shopCrate;
		};
		
	};

};

//New weapon config
_cfg = configFile >> "CfgWeapons" >> _classname;

if ( isArray( missionConfigFile >> "NEB_weaponData" >> _classname >> "ammo" ) ) then {
	_ammoData = getArray( missionConfigFile >> "NEB_weaponData" >> _classname >> "ammo" );
	_priCount = _ammoData select 0 select 0;
	_priIndex = _ammoData select 0 select 1;
	if ( count getArray( _cfg >> "muzzles" ) > 1 ) then {
		_secCount = _ammoData select 1 select 0;
		_secIndex = _ammoData select 1 select 1;
	}; 
}else{
	_defaultAmmo = getArray( missionConfigFile >> "NEB_WeaponData" >> "NEB_defaultAmmo" ) select NEB_currentButton;
	_priCount = _defaultAmmo select 0 select 0;
	_priIndex = _defaultAmmo select 0 select 1;
	_secCount = _defaultAmmo select 1 select 0;
	_secIndex = _defaultAmmo select 1 select 1;
};
			
//Get default primary muzzle mag
_priMuzzleMag = getArray( _cfg >> "magazines" ) select _priIndex;

//Add mags
[ _priMuzzleMag, _priCount ] call _fnc_addmags;
				
//If we are doing a primary weapon and the weapon has a secondary muzzle
if ( NEB_currentButton isEqualTo 0 && { count getArray( _cfg >> "muzzles" ) > 1 } ) then {
	//Get secondary muzzle
	_secMuzzle = getArray( _cfg >> "muzzles" ) select 1;
	//Get default secondary muzzle mag
	_secMuzzleMag = getArray( _cfg >> _secMuzzle >> "magazines" ) select _secIndex;
	//Add mags
	[ _secMuzzleMag, _secCount ] call _fnc_addmags;
	
	//Whats this for???
	player setVariable ["lastPrimary",_className];
};

//Add new weapon to player
player addWeapon _className;

_newAttachments = [ primaryWeaponItems player, secondaryWeaponItems player, handgunItems player ] select NEB_currentButton;

_slotClasses = [ "MuzzleSlot", "PointerSlot", "CowsSlot", "UnderBarrelSlot" ]; //[ silencer, pointer, optic, bipod ]

//If the new weapon has no attachment in a slot and the old attach is compat then fit it
{
	_oldAttach = _currentAttach select _forEachIndex;
	if ( _x isEqualTo "" && { _oldAttach != "" } ) then {
		_slotType = _slotClasses select _forEachIndex;
		_compatibleAttachments = getArray( configFile >> "CfgWeapons" >> _className >> "WeaponSlotsInfo" >> _slotType >> "compatibleItems" );
		
		if ( toLower _oldAttach in ( _compatibleAttachments apply{ toLower _x } ) ) then {
			player addWeaponItem [ _className, _oldAttach ];
		}else{
			[ "CACHE", [ "ADD", [ _oldAttach, 1 ] ] ] call NEB_fnc_shopCrate;
		};
		
	}else{
		if ( _oldAttach != "" ) then {
			[ "CACHE", [ "ADD", [ _oldAttach, 1 ] ] ] call NEB_fnc_shopCrate;
		};
	};
}forEach _newAttachments;

[ "UPDATE" ] call NEB_fnc_shopCrate;