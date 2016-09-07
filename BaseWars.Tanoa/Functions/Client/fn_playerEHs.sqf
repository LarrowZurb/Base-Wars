
//Handle pickup or drop of special suits
player addEventHandler [ "Take", {
	[] call NEB_fnc_isSpecialSuit;
}];

player addEventHandler [ "Put", {
	[] call NEB_fnc_isSpecialSuit;
}];



//Handle Killed
player addEventHandler [ "Killed", {
	
    //Get passed killed and killer
     params[ "_killed", "_killer" ];
 
    //If we were killed by a player AND did not kill ourself
    if ( isPlayer _killer && !( _killer isEqualTo _killed ) ) then {
 
        //Is our killer an enemy
        _killedSide = side group _killed;
        _isEnemy = !(_killedSide isEqualTo side group _killer);
 
        //Get killers stats
        //Removed, as we wont change them here but send to function on killers client
        //and let it handle changing stats
 
        //If killer was an enemy
        if ( _isEnemy ) then {
			if !( _killer isEqualTo vehicle _killer ) then {
				switch ( _killer ) do {
					case ( driver vehicle _killer ) : {
						switch (side _killer) do {
							case west: {
								bluScore = bluScore + 1;								
								publicVariable "bluScore";
								[ 500, 100, 1 ] remoteExec [ "fnc_updateStats", _killer ];
							};
							case east: {
								redScore = redScore + 1;	
								publicVariable "redScore";
								[ 500, 100, 1 ] remoteExec [ "fnc_updateStats", _killer ];
							};
						};
						
					};
					case ( gunner vehicle _killer ) : {
						switch (side _killer) do {
							case west: {
								bluScore = bluScore + 1;								
								publicVariable "bluScore";
								[ 500, 200, 1 ] remoteExec [ "fnc_updateStats", _killer ];
							};
							case east: {
								redScore = redScore + 1;
								publicVariable "redScore";
								[ 500, 200, 1 ] remoteExec [ "fnc_updateStats", _killer ];
							};
						};
					};
					case ( commander vehicle _killer ) : {
						switch (side _killer) do {
							case west: {
								bluScore = bluScore + 1;
								publicVariable "bluScore";
								[ 300, 200, 1 ] remoteExec [ "fnc_updateStats", _killer ];
							};
							case east: {
								redScore = redScore + 1;
								publicVariable "redScore";
								[ 300, 200, 1 ] remoteExec [ "fnc_updateStats", _killer ];
							};
						};
						
					};
					default {
						//crew
						switch (side _killer) do {
							case west: {
								bluScore = bluScore + 1;
								publicVariable "bluScore";
								[ 100, 100] remoteExec [ "fnc_updateStats", _killer ];
							};
							case east: {
								redScore = redScore + 1;
								publicVariable "redScore";
								[ 100, 100] remoteExec [ "fnc_updateStats", _killer ];
							};
						};
					};
				};
			}else{
				switch (side _killer) do {
					case west: {
						bluScore = bluScore + 1;
						publicVariable "bluScore";
						[ 500, 200, 1 ] remoteExec [ "fnc_updateStats", _killer ];
					};
					case east: {
						redScore = redScore + 1;
						publicVariable "redScore";
						[ 500, 200, 1 ] remoteExec [ "fnc_updateStats", _killer ];
					};
				};
			};
		}else{
			if !( _killer isEqualTo vehicle _killer ) then {
				switch ( _killer ) do {
					case ( driver vehicle _killer ) : {
						[ -250, -50] remoteExec [ "fnc_updateStats", _killer ];
					};
					case ( gunner vehicle _killer ) : {
						[ -250, -100] remoteExec [ "fnc_updateStats", _killer ];
					};
					case ( commander vehicle _killer ) : {
						[ -150, -100] remoteExec [ "fnc_updateStats", _killer ];
					};
					default {
						//crew
						[ -50, -50] remoteExec [ "fnc_updateStats", _killer ];
					};
				};
			}else{
				[ -250, -100] remoteExec [ "fnc_updateStats", _killer ];
			};
	
		};
	};

}];