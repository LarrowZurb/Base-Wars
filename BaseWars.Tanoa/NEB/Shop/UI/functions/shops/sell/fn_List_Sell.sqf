
params[ "_listbox", "_buyButton", "_data" ];

{
	_x params[ "_className", "_price", "_ammo" ];

	_cfg = {
		if ( isClass ( configFile >> _x >> _className ) ) exitWith {
			( configFile >> _x >> _className )
		};
	}forEach [
		//This list should be enough to cover most class types
		"CfgVehicles",
		"CfgWeapons",
		"CfgGlasses",
		"CfgMagazines",
		"CfgAmmo"
	];
	
	_ammoDisplay = if ( _ammo > -1 ) then {
		_full = getNumber( configFile >> "CfgMagazines" >> _className >> "count" );
		format[ "[ %1/%2 ]", _ammo, _full ]
	}else{
		""
	};

	_index = _listbox lbAdd format[ "%1 - %2 $%3", getText( _cfg >> "displayName" ), _ammoDisplay, _price ];
	_listbox lbSetPicture [ _index, getText( _cfg >> "picture" ) ];
	_listbox lbSetData [ _index, str [ _className, _ammo ] ];
	_listbox lbSetValue [ _index, _price ];

	//Turn listbox entry red for testing as price is 0 meaning no shop data for class is found
	if ( _price isEqualTo 0 ) then {
		_listbox lbSetColor [ _index, [ 1, 0, 0, 0.8 ] ];
		_listbox lbSetSelectColor [ _index, [ 1, 0, 0, 0.8 ] ];
	};
	
}forEach _data;

if ( lbSize _listbox > 0 && lbCurSel _listbox > -1 ) then {
	_buyButton ctrlEnable true;
};