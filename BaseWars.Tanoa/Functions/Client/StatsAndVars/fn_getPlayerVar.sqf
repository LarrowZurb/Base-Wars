
params[ "_varName" ];

switch ( toUpper _varName ) do {
	case "CASH" : {
		player getVariable [ "cash", 0 ];
	};
	case "LEVEL" : {
		player getVariable [ "level", 0 ];
	};
	case "EXP" : {
		player getVariable [ "experience", 0 ];
	};
	case "KILLS" : {
		player getVariable [ "kills", 0 ];
	};
};