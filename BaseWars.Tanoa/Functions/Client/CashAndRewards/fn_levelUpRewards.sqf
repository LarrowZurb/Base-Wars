
private [ "_currentWeapon", "_cfg", "_compatibleMags", "_myLvl" ];
params[ "_level" ];

_fnc_getCompatibleMags = {
	params[ "_weapon" ];
	
	_cfg = ( configFile >> "CfgWeapons" >> _weapon );
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

_mainMag = ( primaryWeapon player call _fnc_getCompatibleMags ) select 0;
_currentPack = backpack player;

_fnc_addPlayerItem = {
	params[ "_item", [ "_count", 1 ], [ "_ammo", -1 ] ];
	
	_itemType = _item call BIS_fnc_itemType;
	
	switch ( toUpper( _itemType select 0 ) ) do {
		
		case "MINE";
		case "MAGAZINE" : {
			if ( _ammo isEqualTo -1 ) then {
				_ammo = getNumber( configFile >> "CfgMagazines" >> _item >> "count" );
			};
			_left = for "_i" from 1 to _count do {
				if !( player canAdd _item ) exitWith { _count - ( _i - 1 ) };
				{
					if ( _item call compile format[ "player canadditemTo%1 _this", _x select 0 ] ) exitWith {
						_nul = [ _item, 1, _ammo ] call compile format[ "%1 player addMagazineAmmoCargo _this", _x select 1 ];
					};
				}forEach [
					[ "uniform", "uniformContainer" ],
					[ "vest", "vestContainer" ],
					[ "backpack", "backpackContainer" ]
				];
			};
			if !( isNil "_left" ) then {
				[ "CACHE", [ "ADD", [ [ _item, _ammo ], _count ] ] ] call NEB_fnc_shopCrate;
			};
		};
		
		case "WEAPON" : {
			private[ "_oldWeapon" ];
			
			if ( _count > 1 ) then {
				_count = 1;
				[ "Can only add 1 weapon at a time" ] call BIS_fnc_error;
			};
			_notCompat = [];
			_otherMags = [];
			//Is it pri sec or hand
			_weaponType = getNumber( configFile >> "CfgWeapons" >> _item >> "type" );
			//Get compatable mags for new weapon
			_compatNew = ( _item call _fnc_getCompatibleMags ) apply{ toLower _x };
			//Get players current weap of that type
			_weaponType = [ objNull, primaryWeapon player, handgunWeapon player, objNull, secondaryWeapon player ] select _weaponType;
			//If we currently have a weapon in that slot
			if !( _weaponType isEqualTo "" ) then {
				//Save old weapon
				_oldWeapon = _weaponType;
				//Get current weapons compat mags
				_compat = ( _item call _fnc_getCompatibleMags ) apply{ toLower _x };
				//Get all current mags held by player
				_currentMags = magazinesAmmo player;
				{
					_x params[ "_mag", "_ammo" ];
					//if the mag is not compat with new weapon
					if !( toLower _mag in _compatNew ) then {
						//but was compat with old
						if ( toLower _mag in _compat ) then {
							_nul = _notCompat pushBack [ _mag, _ammo ];
						}else{
							//likely grenades and such
							_nul = _otherMags pushBack [ _mag, _ammo ];
						};
						_currentMags set [ _forEachIndex, objNull ];
					};
				}forEach _currentMags;
				_currentMags = _currentMags - [ objNull ];
				//Clear out ALL mags
				{
					if !( isNull _x ) then {
						clearMagazineCargoGlobal _x;
					};
				}forEach [ uniformContainer player, vestContainer player, backpackContainer player ];
				//Add all compatible mags back
				{
					_x params[ "_mag", "_ammo" ];
					[ _mag, 1, _ammo ] call _fnc_addPlayerItem;
				}forEach _currentMags;
			};
			//Always add 2 new mags with a new WEAPON <<<<<<<<<<<<<<<
			[ _compatNew select 0, 2 ] call _fnc_addPlayerItem;
			player addWeapon _item;
			//Add back any other mags - overflow will go to cache
			{
				_x params[ "_mag", "_ammo" ];
				[ _mag, 1, _ammo ] call _fnc_addPlayerItem;
				//Other first so player retains grenades etc
			}forEach ( _otherMags + _notCompat ) ;
			//Add old weapon to cache
			if !( isNil "_oldWeapon" ) then {
				[ "CACHE", [ "ADD", [ _oldWeapon, 1 ] ] ] call NEB_fnc_shopCrate;
			};
		};
		
		case "ITEM" : {
			_left = for "_i" from 1 to _count do {
				if !( player canAdd _item ) exitWith { _count - ( _i -1 ) };
				player addItem _item;
			};
			if !( isNil "_left" ) then {
				[ "CACHE", [ "ADD", [ _item, _left ] ] ] call NEB_fnc_shopCrate;
			};
		};
		
		case "EQUIPMENT" : {
			
			switch ( toUpper( _itemType select 1 ) ) do {
				
				case "GLASSES" : {
					if ( _count > 1 ) then {
						_count = 1;
						[ "Can only add 1 goggles at a time" ] call BIS_fnc_error;
					};
					if ( goggles player isEqualTo "" ) then {
						player addGoggles _item;
					}else{
						[ "CACHE", [ "ADD", [ _item, _count ] ] ] call NEB_fnc_shopCrate;
					};
				};
				
				case "HEADGEAR" : {
					if ( _count > 1 ) then {
						_count = 1;
						[ "Can only add 1 headgear at a time" ] call BIS_fnc_error;
					};
					if ( headgear player isEqualTo "" ) then {
						player addHeadgear _item;
					}else{
						[ "CACHE", [ "ADD", [ _item, _count ] ] ] call NEB_fnc_shopCrate;
					};
				};
				
				case "Vest" : {
					if ( _count > 1 ) then {
						_count = 1;
						[ "Can only add 1 vest at a time" ] call BIS_fnc_error;
					};
					if ( vest player isEqualTo "" ) then {
						player addVest _item;
					}else{
						[ "CACHE", [ "ADD", [ _item, _count ] ] ] call NEB_fnc_shopCrate;
					};
				};
				
				case "UNIFORM" : {
					if ( _count > 1 ) then {
						_count = 1;
						[ "Can only add 1 uniform at a time" ] call BIS_fnc_error;
					};
					private[ "_contents" ];
					//Give the uniform to the player NOW
					if !( uniform player isEqualTo "" ) then {
						//Put old uniform in cache
						[ "CACHE", [ "ADD", [ uniform player, 1 ] ] ] call NEB_fnc_shopCrate;
						//Save its contents
						_contents = [
							( magazinesAmmoCargo uniformContainer player apply{ _x select [ 0, 2 ] } ) call BIS_fnc_consolidateArray,
							( itemCargo uniformContainer player ) call BIS_fnc_consolidateArray,
							( weaponCargo uniformContainer player ) call BIS_fnc_consolidateArray 
						];
					};
					//Force the new uniform - overwrite old uniform
					player forceAddUniform _item;
					//Make sure we have not switch into/out of a special uniform
					[] call NEB_fnc_isSpecialSuit;
					//Put old content in player inventory
					if !( isNil "_contents" ) then {
						//mags
						{
							_x params[ "_magInfo", "_count" ];
							_magInfo params[ "_mag", "_ammo" ];
							[ _mag, _count, _ammo ] call _fnc_addPlayerItem;
						}forEach ( _contents select 0 );
						//items & weapons
						{
							{
								_x call _fnc_addPlayerItem;
							}forEach _x;
						}forEach ( _contents select [ 1, 2 ] );
					};
				};
				
				case "BACKPACK" : {
					if ( _count > 1 ) then {
						_count = 1;
						[ "Can only add 1 backpack at a time" ] call BIS_fnc_error;
					};
					if ( backpack player isEqualTo "" ) then {
						player addBackpack _item;
					}else{
						[ "CACHE", [ "ADD", [ _item, _count ] ] ] call NEB_fnc_shopCrate;
					};
				};
				
			};
		};
	};
};

switch ( _level ) do {
	
	case ( 3 ) : {
		[ "HandGrenade" ] call _fnc_addPlayerItem;
	};
	
	case ( 5 ) : {
		[ "HandGrenade" ] call _fnc_addPlayerItem;
		[ _mainMag ] call _fnc_addPlayerItem;
		[ [ "B_FieldPack_ghex_F", "B_AssaultPack_tna_F" ] select ( playerSide call BIS_fnc_sideID ) ] call _fnc_addPlayerItem
	};
	
	case ( 10 ) : {
		[ "HandGrenade" ] call _fnc_addPlayerItem;
		[ _mainMag, 2 ] call _fnc_addPlayerItem;
	};
	
	case ( 15 ) : {
		[ "HandGrenade" ] call _fnc_addPlayerItem;
		[ _mainMag, 3 ] call _fnc_addPlayerItem;
	};
	
	case ( 20 ) : {
		[ "HandGrenade" ] call _fnc_addPlayerItem;
		[ _mainMag, 4 ] call _fnc_addPlayerItem;
	};
	
	case ( 25 ) : {
		[ "HandGrenade" ] call _fnc_addPlayerItem;
		[ _mainMag, 4 ] call _fnc_addPlayerItem;
	};
	
	case ( 30 ) : {
		[ "HandGrenade" ] call _fnc_addPlayerItem;
		[ _mainMag, 4 ] call _fnc_addPlayerItem;
	};
	
	case ( 35 ) : {
		[ "HandGrenade" ] call _fnc_addPlayerItem;
		[ _mainMag, 4 ] call _fnc_addPlayerItem;
	};
	
	case ( 40 ) : {
		[ "HandGrenade" ] call _fnc_addPlayerItem;
		[ _mainMag, 4 ] call _fnc_addPlayerItem;
	};
	
	case ( 45 ) : {
		[ "HandGrenade" ] call _fnc_addPlayerItem;
		[ _mainMag, 4 ] call _fnc_addPlayerItem;
	};
	
};


