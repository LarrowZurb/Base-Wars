params[ "_shopName" ];

_crateContents = [ "CARGO", "ALL" ] call NEB_fnc_shopCrate;
_crateContents params[ "_magazines", "_items", "_weapons", "_backpacks" ];


{
	_x params[ "_cargo", "_cfgData", "_condition", "_sellRatio" ];
	
	_shopData = NEB_shopData select _forEachIndex;
	_cfg = ( missionConfigFile >> _cfgData );
	{
		private[ "_item", "_ammo" ];
		_x params [ "_itemInfo", "_count" ];
		
		if ( _itemInfo isEqualType [] ) then {
			_item = _itemInfo select 0;
			_ammo = _itemInfo select 1;
		}else{
			_item = _itemInfo;
			_ammo = -1;
		};
		
		if ( _item call _condition ) then {
			if ( isClass( _cfg >> _item ) ) then {
				if ( _ammo > -1 ) then {
					_full = getNumber( configFile >> "CfgMagazines" >> _item >> "count" );
					_ammoPrice = linearConversion[ 0, _full, _ammo, 0, 1 ];
					_sellRatio = _sellRatio * _ammoPrice;
				};
				_nul = _shopData pushBack [ _item, getNumber( _cfg >> _item >> "cost" ) * _sellRatio, _ammo, _count ];
			}else{
				//For testing so we know whats missing in data class
				_nul = _shopData pushBack [ _item, 0, _ammo, _count ];
			};
		};
	}forEach _cargo;
	
}forEach [
	//[ cargo, data to check, condition to add ]
	//Weapons
	[ _weapons, "NEB_weaponData", { true }, 0.75 ],
	//Attachments
	[ _items, "NEB_attachData", { getNumber( configFile >> "CfgWeapons" >> _this >> "iteminfo" >> "type" ) in [ 101, 201, 301, 302 ] }, 0.75 ],
	//Gear
	[ _items + _backpacks, "NEB_gearData", { !( getNumber( configFile >> "CfgWeapons" >> _this >> "iteminfo" >> "type" ) in [ 101, 201, 301, 302 ] ) }, 0.75 ],
	//Magazines
	[ _magazines, "NEB_attachData", { true }, 0.75 ] //change data structure when ammo is implemented
];
