
params[ "_mode", "_this" ];

switch ( toUpper _mode ) do {
	
	case "LOAD" : {
		
		//Set player var		var			to stored profile value			profile var				default value if it does not exist
		player setVariable [ "cash",		profileNamespace getVariable [ "NEB_PRO_39573_CASH",	500 ] ];
		player setVariable [ "experience",	profileNamespace getVariable [ "NEB_PRO_39573_EXP",		100 ] ];
		player setVariable [ "kills",		profileNamespace getVariable [ "NEB_PRO_39573_KILLS",	0 ] ];
		player setVariable [ "level",		profileNamespace getVariable [ "NEB_PRO_39573_LEVEL",	1 ] ];
		
		[ "LOAD" ] call NEB_fnc_shopCrate;
		
	};
	
	case "SAVE" : {
		
		[ "UPDATE" ] call NEB_fnc_profileVars;
		
		[ "SAVE" ] call NEB_fnc_shopCrate;
		
		saveProfileNamespace;
		
	};
	
	case "UPDATE" : {
		
		profileNamespace setVariable [ "NEB_PRO_39573_CASH",	player getVariable "cash" ];
		profileNamespace setVariable [ "NEB_PRO_39573_EXP",		player getVariable "experience" ];
		profileNamespace setVariable [ "NEB_PRO_39573_KILLS",	player getVariable "kills" ];
		profileNamespace setVariable [ "NEB_PRO_39573_LEVEL",	player getVariable "level" ];
				
	};
	
};


