private[ "_msg" ];
params[ "_type", "_this" ];

//Add case statements for each type of message available
switch ( toUpper _type ) do {
	
	//Level up message
	case ( "LVL" ) : {
		_color = "#B8AB67";
		_msg = format["<t color=%1 size ='.4'>LEVEL UP! Now Level %2</t>", str _color, _this ];
	};
	
	//Changes to cash
	case ( "CASH" ) : {
		_color = "#FF0000";
		_msg = format["<t color=%1 size = '.4'>$%2</t>", str _color, _this ];
	};
	
	//Changes to experience
	case ( "EXP" ) : {
		_color = "#0000FF";
		_msg = format["<t color=%1 size = '.4'>Exp %2</t>", str _color, _this ];
	};
	
	//Buying/Selling of vehicles
	case ( "VEH" ) : {
		params[ "_fnc", "_className" ];
		
		_description = getText( configFile >> "CfgVehicles" >> _className >> "displayName" );
		
		switch ( _fnc ) do {
			case ( "ADD" ) : {
				_color = "#FFFFFF";
				_msg = format["<t color=%1 size = '.4'>A %2 was added to your garage</t>", str _color, _description ];
			};
			case ( "REM" ) : {
				_color = "#FFFFFF";
				_msg = format["<t color=%1 size = '.4'>A %2 was removed from your garage</t>", str _color, _description ];
			};
		};
	};
	
	//Telecache adding/removeing items
	case ( "CACHE" ) : {
		params[ "_fnc", "_itemInfo" ];

		_itemInfo params[ "_item", "_count" ];
		_description = {
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
				_msg = format["<t color=%1 size = '.4'>%2 x %3%4 added to your telecache</t>", str _color, _count, _description, [ " was", "'s were" ] select ( _count > 1 ) ];
			};
			case ( "REM" ) : {
				_color = "#FFFFFF";
				_msg = format["<t color=%1 size = '.4'>%2 x %3%4 removed from your telecache</t>", str _color, _count, _description, [ " was", "'s were" ] select ( _count > 1 ) ];
			};
		};
	};
	
	//Enter/Exit shop
	case ( "SHOP" ) : {
		params[ "_fnc", "_txt" ];

		switch ( _fnc ) do {
			case ( "ENTER" ) : {
				_color = "#FFFFFF";
				_msg = format["<t color=%1 size = '.4'>You have entered %2 shop</t>", str _color, _txt ];
			};
			case ( "LEAVE" ) : {
				_color = "#FFFFFF";
				_msg = format["<t color=%1 size = '.4'>You have left %2 shop</t>", str _color, _txt ];
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


