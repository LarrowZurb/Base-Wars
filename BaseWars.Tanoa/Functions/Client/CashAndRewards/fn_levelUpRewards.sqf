
private [ "_currentWeapon", "_cfg", "_compatibleMags", "_myLvl" ];
params[ "_level" ];

_fnc_getCompatibleMags = {
	params[ "_weapon" ];
	
	_cfg = ( configFile >> "CfgWeapons" >> _currentWeapon );
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
	params[ "_itemInfo" ];
	
	_itemInfo params[ "_item", "_count", [ "_ammo", -1 ] ];
	
	_left = for "_i" from 1 to _count do {
		_itemType = _item call BIS_fnc_itemType;
		
		switch ( toUpper( _itemType select 0 ) ) do {
			
			case "MINE";
			case "MAGAZINE" : {
				if !( player canAdd _item ) exitWith { _count - ( _i - 1 ) };
				if ( _ammo isEqualTo -1 ) then {
					_ammo = getNumber( configFile >> "CfgMagazines" >> _item >> "count" );
				};
				{
					if ( _item call compile format[ "player canadditemTo%1 _this", _x select 0 ] ) exitWith {
						[ _item, 1, _ammo ] call compile format[ "%1 player addMagazineAmmoCargo _this", _x select 1 ];
					};
				}forEach [
					[ "uniform", "uniformContainer" ],
					[ "vest", "vestContainer" ],
					[ "backpack", "backpackContainer" ]
				];
			};
			
			case "WEAPON" : {
				private[ "_oldWeapon" ];
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
					_notCompat = [];
					_otherMags = [];
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
				//Always add 2 new mags with a new WEAPON
				[ _compatNew select 0, 2 ] call _fnc_addPlayerItem;
				player addWeapon _item;
				//Add back any other mags - overflow will go to cache
				if !( isNil "_currentMags" ) then {
					{
						_x params[ "_mag", "_ammo" ];
						[ _mag, 1, _ammo ] call _fnc_addPlayerItem;
						//Other first so player retains grenades etc
					}forEach ( _otherMags + _notCompat ) ;
				};
				//Add old weapon to cache
				if !( isNil "_oldWeapon" ) then {
					[ "CACHE", [ "ADD", [ _oldWeapon, 1 ] ] ] call NEB_fnc_shopCrate;
				};
			};
			
			case "ITEM" : {
				if !( player canAdd _item ) exitWith { _count - ( _i - 1 ) };
				player addItem _item;
			};
			
			case "EQUIPMENT" : {
				
				switch ( toUpper( _itemType select 1 ) ) do {
					
					case "GLASSES" : {
						if !( goggles player isEqualTo "" ) exitWith { _count - ( _i - 1 ) };
						player addGoggles _item;
					};
					
					case "HEADGEAR" : {
						if !( headgear player isEqualTo "" ) exitWith { _count - ( _i - 1 ) };
						player addHeadgear _item;
					};
					
					case "Vest" : {
						if !( vest player isEqualTo "" ) exitWith { _count - ( _i - 1 ) };
						player addVest _item;
					};
					
					case "UNIFORM" : {
						private[ "_contents" ];
						//Give the uniform to the player NOW
						if !( uniform player isEqualTo "" ) then {
							//Put old uniform in cache
							[ "CACHE", [ "ADD", [ uniform player, 1 ] ] ] call NEB_fnc_shopCrate;
							//Save its contents
							_contents = [
								magazinesAmmoCargo uniformContainer player,
								( itemCargo uniformContainer player ) call BIS_fnc_consolidateArray,
								( weaponCargo uniformContainer player ) call BIS_fnc_consolidateArray 
							];
						};
						//Force the new uniform
						player forceAddUniform _item;
						//Make sure we have not switch into/out of a special uniform
						[] call NEB_fnc_isSpecialSuit;
						//Put old content in player inventory
						if !( isNil "_contents" ) then {
							//mags
							{
								_x params[ "_mag", "_ammo" ];
								[ _mag, 1, _ammo ] call _fnc_addPlayerItem;
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
						if !( backpack player isEqualTo "" ) exitWith { _count - ( _i - 1 ) };
						player addBackpack _item;
					};
					
				};
			};
		};
	};
	
	if !( isNil "_left" ) then {
		[ "CACHE", [ "ADD", [ _item, _left, _ammo ] ] ] call NEB_fnc_shopCrate;
	};

};

switch ( _level ) do {
	
	case ( 3 ) : {
		[ "HandGrenade", 1 ] call _fnc_addPlayerItem;
	};
	
	case ( 5 ) : {
		[ _mainMag, 1 ] call _fnc_addPlayerItem;
		[ "HandGrenade", 1 ] call _fnc_addPlayerItem;
		[ [ "B_FieldPack_ghex_F", "B_AssaultPack_tna_F" ] select ( playerSide call BIS_fnc_sideID ), 1 ] call _fnc_addPlayerItem
	};
	
	case ( 10 ) : {
		[ "HandGrenade", 1 ] call _fnc_addPlayerItem;
		[ _mainMag, 2 ] call _fnc_addPlayerItem;
	};
	
	case ( 15 ) : {
		[ "HandGrenade", 1 ] call _fnc_addPlayerItem;
		[ _mainMag, 3 ] call _fnc_addPlayerItem;
	};
	
	case ( 20 ) : {
		[ "HandGrenade", 1 ] call _fnc_addPlayerItem;
		[ _mainMag, 4 ] call _fnc_addPlayerItem;
	};
	
	case ( 25 ) : {
		[ "HandGrenade", 1 ] call _fnc_addPlayerItem;
		[ _mainMag, 4 ] call _fnc_addPlayerItem;
	};
	
	case ( 30 ) : {
		[ "HandGrenade", 1 ] call _fnc_addPlayerItem;
		[ _mainMag, 4 ] call _fnc_addPlayerItem;
	};
	
	case ( 35 ) : {
		[ "HandGrenade", 1 ] call _fnc_addPlayerItem;
		[ _mainMag, 4 ] call _fnc_addPlayerItem;
	};
	
	case ( 40 ) : {
		[ "HandGrenade", 1 ] call _fnc_addPlayerItem;
		[ _mainMag, 4 ] call _fnc_addPlayerItem;
	};
	
	case ( 45 ) : {
		[ "HandGrenade", 1 ] call _fnc_addPlayerItem;
		[ _mainMag, 4 ] call _fnc_addPlayerItem;
	};
	
};


