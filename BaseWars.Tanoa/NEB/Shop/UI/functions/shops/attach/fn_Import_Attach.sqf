params[ "_shopName" ];

{
	_className = configName _x;
	_index = -1;
	{
		if ( getNumber( configFile >> "CfgWeapons" >> _className >> "itemInfo" >> "type" ) isEqualTo _x ) exitWith {
			_index = _forEachIndex;
		};
		
	}forEach [ 201, 301, 302, 101 ]; //These are the vanilla defines 'type' for [ optic, pointer, bipod, silencer ]
	
	if ( _index > -1 ) then {
		_data = NEB_shopData select _index;
		_nul = _data pushBack [ _className, getNumber( _x >> "level" ), getNumber( _x >> "cost" ) ];
	};
		
}forEach ( "true" configClasses ( missionConfigFile >> format[ "NEB_%1Data", _shopName ] )); //class in shopData to pull info from