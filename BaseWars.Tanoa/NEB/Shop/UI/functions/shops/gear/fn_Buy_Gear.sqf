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
			[ "CACHE", [ "ADD", [ uniform player, 1 ] ] ] call NEB_fnc_shopCrate;
			[ "SHOW" ] call NEB_fnc_shopCrate;
			player forceAddUniform _className;
			{
				if ( player canAddItemToUniform _x ) then {
					uniformContainer player addItemCargoGlobal [ _x, 1 ];
				}else{
					[ "CACHE", [ "ADD", [ _x, 1 ] ] ] call NEB_fnc_shopCrate;
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
			[ "CACHE", [ "ADD", [ vest player, 1 ] ] ] call NEB_fnc_shopCrate;
			[ "SHOW" ] call NEB_fnc_shopCrate;
			player addVest _className;
			{
				if ( player canAddItemToVest _x ) then {
					vestContainer player addItemCargoGlobal [ _x, 1 ];
				}else{
					[ "CACHE", [ "ADD", [ _x, 1 ] ] ] call NEB_fnc_shopCrate;
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
			[ "CACHE", [ "ADD", [ backpack player, 1 ] ] ] call NEB_fnc_shopCrate;
			[ "SHOW" ] call NEB_fnc_shopCrate;
			player addBackpack _className;
			{
				if ( player canAddItemToBackpack _x ) then {
					backpackContainer player addItemCargoGlobal [ _x, 1 ];
				}else{
					[ "CACHE", [ "ADD", [ _x, 1 ] ] ] call NEB_fnc_shopCrate;
				};
			}forEach _allItems;
		}else{
			player addBackpack _className;
		};
	
	};
	
	//helmets
	case ( 3 ) : {
		if ( headgear player != "" ) then {
			[ "CACHE", [ "ADD", [ headgear player, 1 ] ] ] call NEB_fnc_shopCrate;
			[ "SHOW" ] call NEB_fnc_shopCrate;
		};
		player addHeadgear _className;
	};
	
	//Facewear
	case ( 4 ) : {
		if ( goggles player != "" ) then {
			[ "CACHE", [ "ADD", [ goggles player, 1 ] ] ] call NEB_fnc_shopCrate;
			[ "SHOW" ] call NEB_fnc_shopCrate;
		};
		player addGoggles _className;
	};
	
	//NVG
	case ( 5 ) : {
		if ( hmd player != "" ) then {
			[ "CACHE", [ "ADD", [ hmd player, 1 ] ] ] call NEB_fnc_shopCrate;
			[ "SHOW" ] call NEB_fnc_shopCrate;
			player unlinkItem hmd player;
		};
		player linkItem _className;
	};
};

[ "UPDATE" ] call NEB_fnc_shopCrate;