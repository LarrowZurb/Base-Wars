private [ "_allItems" ];
params[ "_className", "_cost" ];

//Remove money
[ _cost ] call NEB_fnc_core_pay;

//Get Crate
_crate = [ "GET" ] call NEB_fnc_shopCrate;

switch( NEB_currentButton ) do {
	//uniform
	case ( 0 ) : {
		if ( uniform player != "" ) then {
			_allItems = uniformItems player;
			_crate addItemCargo [ uniform player, 1 ];
			[ "SHOW" ] call NEB_fnc_shopCrate;
			player forceAddUniform _className;
			{
				if ( player canAddItemToUniform _x ) then {
					uniformContainer player addItemCargoGlobal [ _x, 1 ];
				}else{
					_crate addItemCargo [ _x, 1 ];
				};
			}forEach _allItems;	
		}else{
			player forceAddUniform _className;
		};
		[] call NEB_fnc_isSpecialSuit;
	};
	
	//vest
	case ( 1 ) : {
		if ( vest player != "" ) then {
			_allItems = vestItems player;
			_crate addItemCargo [ vest player, 1 ];
			[ "SHOW" ] call NEB_fnc_shopCrate;
			player addVest _className;
			{
				if ( player canAddItemToVest _x ) then {
					vestContainer player addItemCargoGlobal [ _x, 1 ];
				}else{
					_crate addItemCargo [ _x, 1 ];
				};
			}forEach _allItems;
		}else{
			player addVest _className;
		};
	};
	
	//Backpack
	case ( 2 ) : {
		if ( backpack player != "" ) then {
			_allItems = backpackItems player;
			_crate addBackpackCargo [ backpack player, 1 ];
			[ "SHOW" ] call NEB_fnc_shopCrate;
			player addBackpack _className;
			{
				if ( player canAddItemToBackpack _x ) then {
					backpackContainer player addItemCargoGlobal [ _x, 1 ];
				}else{
					_crate addItemCargo [ _x, 1 ];
				};
			}forEach _allItems;
		}else{
			player addBackpack _className;
		};
	
	};
	
	//helmets
	case ( 3 ) : {
		if ( headgear player != "" ) then {
			_crate addItemCargo [ headgear player, 1 ];
			[ "SHOW" ] call NEB_fnc_shopCrate;
		};
		player addHeadgear _className;
	};
	
	//Facewear
	case ( 4 ) : {
		if ( goggles player != "" ) then {
			_crate addItemCargo [ goggles player, 1 ];
			[ "SHOW" ] call NEB_fnc_shopCrate;
		};
		player addGoggles _className;
	};
	
	//NVG
	case ( 5 ) : {
		if ( hmd player != "" ) then {
			_crate addItemCargo [ hmd player, 1 ];
			[ "SHOW" ] call NEB_fnc_shopCrate;
			player unlinkItem hmd player;
		};
		player linkItem _className;
	};
};

[ "UPDATE" ] call NEB_fnc_shopCrate;