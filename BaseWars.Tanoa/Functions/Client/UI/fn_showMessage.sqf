
params[ "_type", "_this" ];

//Add case statements for each type of message available
switch ( toUpper _type ) do {
	
	case ( "LVL" ) : {
		_color = "#B8AB67";
		_msg format["<t color=%1 size ='.4'>LEVEL UP! Now Level %2</t>", str _color, _this ];
	};
	
	case ( "CASH" ) : {
		_color = "#FF0000";
		_msg = format["<t color=%1 size = '.4'>$%2</t>", str _color, _this ];
	};
	
	case ( "EXP" ) : {
		_color = "#0000FF";
		_msg = format["<t color=%1 size = '.4'>$%2</t>", str _color, _this ];
	};
	
	case ( "VEH" ) : {
		params[ "_fnc", "_className" ];
		
		_description = getText( configFile >> "CfgVehicles" >> _className >> "displayName" );
		
		switch ( _fnc ) do {
			case ( "ADD" ) : {
				_color = "#FFFFFF";
				_msg = format["<t color=%1 size = '.4'>A %2 was added to your garage</t>", str _color, _descrition ];
			};
			case ( "REM" ) : {
				_color = "#FFFFFF";
				_msg = format["<t color=%1 size = '.4'>A %2 was removed from your garage</t>", str _color, _descrition ];
			};
		};
	};
	
	case ( "CACHE" ) : {
		params[ "_fnc", "_itemInfo" ];
		
		_itemInfo [ "_item", "_count" ]
		_descrition = {
			if ( isClass( configFile >> _x >> _item ) ) exitWith {
				getText( configFile >> _x >> _item >> "displayName" ) 
			};
		}forEach [
			"CfgMagazines",
			"CfgWeapons",
			"CfgVehicles"
		];		
		
		switch ( _fnc ) do {
			case ( "ADD" ) : {
				_color = "#FFFFFF";
				_msg = format["<t color=%1 size = '.4'>%2 %3%4 added to your telecache</t>", str _color, _count, _descrition, [ " was", "'s were" ] select ( _count > 1 ) ];
			};
			case ( "REM" ) : {
				_color = "#FFFFFF";
				_msg = format["<t color=%1 size = '.4'>%2 %3%4 removed from your telecache</t>", str _color, _count, _descrition, [ " was", "'s were" ] select ( _count > 1 ) ];
			};
		};
	};
	
	//General message with no type - creates plain white message
	default {
		_color = "#FFFFFF";
		_msg = format["<t color=%1 size = '.4'>$%2</t>", str _color, _msg ];
	};
};

_nul = NEB_MsgTickQueue pushBack _msg;


