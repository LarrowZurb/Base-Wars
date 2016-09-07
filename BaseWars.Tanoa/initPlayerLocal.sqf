waitUntil { !isNull player && time > 0 }; //after briefing

//#define UIhealthIcon 1011

//Start loading screen

[ "LOAD" ] call NEB_fnc_profileVars;

[] call NEB_fnc_playerEHs;




titleCut ["", "BLACK FADED", 999];
sleep 1;
// Set Starting Pos

	
				switch (side player) do {
 
						case west: {
						_posRandom = ["blu_playerSpawnA","blu_playerSpawnB","blu_playerSpawnC","blu_playerSpawnD"] call bis_fnc_selectRandom;
						_position = getMarkerPos _posRandom vectorAdd [0,0,400];
						[_position] call neb_fnc_core_setStartingPos;
						
						playSound "airplanes";
						
						
						};
 
						case east: {
						_posRandom = ["red_playerSpawnA","red_playerSpawnB","red_playerSpawnC","red_playerSpawnD"] call bis_fnc_selectRandom;
						_position = getMarkerPos _posRandom vectorAdd [0,0,400];
						[_position] call neb_fnc_core_setStartingPos;
						playSound "airplanes";
						
						
						};
 
				};
	sleep 1;
   titlecut [" ","BLACK IN",5];

                
    

 
 
 








	





fnc_addSprintSuitA = {
player forceAddUniform "U_O_Protagonist_VR";
[ [], "NEB_fnc_isSpecialSuit", player ] call BIS_fnc_MP;
};

fnc_addSprintSuitB = {
player forceAddUniform "U_B_Protagonist_VR";
[ [], "NEB_fnc_isSpecialSuit", player ] call BIS_fnc_MP;
};
fnc_addSprintSuitC = {
player forceAddUniform "U_I_Protagonist_VR";
[ [], "NEB_fnc_isSpecialSuit", player ] call BIS_fnc_MP;
};
fnc_redSuit = {
player forceAddUniform "U_O_Soldier_VR";
[ [], "NEB_fnc_isSpecialSuit", player ] call BIS_fnc_MP;
};
fnc_bluSuit = {
player forceAddUniform "U_B_Soldier_VR";
[ [], "NEB_fnc_isSpecialSuit", player ] call BIS_fnc_MP;
};

fnc_bubEffect = {
	params[ "_objNetID" ];
	
	_unit = objectFromNetId _objNetID;
	
	_unit setVariable[ "bubEffect", true ]; //local object variable
	
	if ( local _unit ) then {
		_unit allowDamage false; //AL and EG
	};
	
	_unit setAnimSpeedCoef 2;//Unsure of locality needs testing
	_unit switchMove "AmovPercMstpSnonWnonDnon_EaseIn"; //AG and EL
	_unit setAnimSpeedCoef 0; //Unsure of locality needs testing
	
	while ( _unit getVariable[ "bubEffect", false ] ) do {
		
		drop [ //EL
			["\A3\data_f\ParticleEffects\Universal\Universal",16,13,7,0],"","BillBoard",
			1,1,[0,0.25,1],[0,0,0],
			random pi*2,1.277,1,0,
			[3],
			[[1,0,0,.5],[1,0,0,.5]],
			[10000],
			0,0,"","",
			_unit,0,
			false,-1
		];
		
		playSound "electricshock"; //EL
		_unit switchMove "AmovPercMstpSnonWnonDnon_Ease"; //AG and EL
		
		sleep 0.25; //This is the equivilent of you action per tick 6/24 = 0.25 seconds
	};
};


fnc_bubFinish = {
	params[ "_objNetID" ];
	
	_unit = objectFromNetId _objNetID;
	
	//Stop the particle loop
	_unit setVariable[ "bubEffect", false ];
	
	if ( local _unit ) then {
		//allowDamage is AL( arguments local ) EG( effects global )
		//So only where the unit is local( argument )
		//the Effects will be seen on all machine( effect global )  
		_unit allowDamage true; //AL and EG
	};
	
	_unit setAnimSpeedCoef 1; //Unsure of locality needs testing
	_unit switchMove ""; //AG and EL
};


fnc_suitAbilities = {
 _skillA = [
/* 0 object */				player,
/* 1 action title */			"Sprint 1",
/* 2 idle icon */				"images\sprinticonA.paa",
/* 3 progress icon */			"images\sprinticonA.paa",
/* 4 condition to show */		"player getvariable [ 'Sprint', false ]",
/* 5 condition for action */		"true",
/* 6 code executed on start */		{player setAnimSpeedCoef 1},
/* 7 code executed per tick */		{
	 _progress = param[ 4 ]; //max progress is always 24
	player setAnimSpeedCoef ( linearConversion[ 0, 24, _progress, 1.5, 2 ] );
},
/* 8 code executed on completion */	{player setAnimSpeedCoef 1},
/* 9 code executed on interruption */	{player setAnimSpeedCoef 1},
/* 10 arguments */			["Sprint"],
/* 11 action duration */		6,
/* 12 priority */			0,
/* 13 remove on completion */		false,
/* 14 show unconscious */		false
] call bis_fnc_holdActionAdd;

_skillB = [
/* 0 object */				player,
/* 1 action title */			"Sprint 2",
/* 2 idle icon */				"images\sprinticonA.paa",
/* 3 progress icon */			"images\sprinticonA.paa",
/* 4 condition to show */		"player getvariable [ 'Sprint2', false ]",
/* 5 condition for action */		"true",
/* 6 code executed on start */		{player setAnimSpeedCoef 1.50},
/* 7 code executed per tick */		{
	 _progress = param[ 4 ]; //max progress is always 24
	player setAnimSpeedCoef ( linearConversion[ 0, 32, _progress, 1.5, 4 ] );
},
/* 8 code executed on completion */	{player setAnimSpeedCoef 1},
/* 9 code executed on interruption */	{player setAnimSpeedCoef 1},
/* 10 arguments */			["Sprint"],
/* 11 action duration */		6,
/* 12 priority */			0,
/* 13 remove on completion */		false,
/* 14 show unconscious */		false
] call bis_fnc_holdActionAdd;
_skillC = [
/* 0 object */				player,
/* 1 action title */			"Sprint 3",
/* 2 idle icon */				"images\sprinticonA.paa",
/* 3 progress icon */			"images\sprinticonA.paa",
/* 4 condition to show */		"player getvariable [ 'Sprint3', false ]",
/* 5 condition for action */		"true",
/* 6 code executed on start */		{player setAnimSpeedCoef 1.70},
/* 7 code executed per tick */		{
	 _progress = param[ 4 ]; //max progress is always 24
	player setAnimSpeedCoef ( linearConversion[ 1.7, 32, _progress, 1.5, 6 ] );
},
/* 8 code executed on completion */	{player setAnimSpeedCoef 1},
/* 9 code executed on interruption */	{player setAnimSpeedCoef 1},
/* 10 arguments */			["Sprint"],
/* 11 action duration */		12,
/* 12 priority */			0,
/* 13 remove on completion */		false,
/* 14 show unconscious */		false
] call bis_fnc_holdActionAdd;
_skillD = [
/* 0 object */				player,
/* 1 action title */			"Lightning",
/* 2 idle icon */				"images\blinkicon.paa",
/* 3 progress icon */			"images\blinkicon.paa",
/* 4 condition to show */		"player getvariable [ 'Lightning', false ]",
/* 5 condition for action */		"true",
/* 6 code executed on start */		{["Suit", "Preparing Lightning"] call BIS_fnc_showSubtitle},
/* 7 code executed per tick */		{hint "Lightning Charging"},
/* 8 code executed on completion */	{[] call neb_fnc_core_strikeLightning;},
/* 9 code executed on interruption */	{hint ""},
/* 10 arguments */			["Lightning"],
/* 11 action duration */		3,
/* 12 priority */			0,
/* 13 remove on completion */		false,
/* 14 show unconscious */		false
] call bis_fnc_holdActionAdd;
_skillE = [
	player,							//  0 object
	"Bubble",						//  1 action title
	"images\blinkicon.paa",					//  2 idle icon
	"images\blinkicon.paa",					//  3 progress icon
	"player getvariable [ 'Bubble', false ]",		//  4 condition to show
	"true",							//  5 condition for action
	
	//  6 code executed on start
	{
		//Create a unique name for the jip queue
		[ netId player ] remoteExec [ "fnc_bubEffect", 0, format[ "%1_bub", netId player ] ];
	},
	
	//  7 code executed per ACTION tick ( Range 0 - 24 ), tick duration = action duration / MAX tick 24  
	{},
	
	//  8 code executed on completion
	{
		//No JIP
		[ netId player ] remoteExec [ "fnc_bubFinish", 0 ];
		//Remove start from JIP queue
		remoteExec [ "", format[ "%1_bub", netId player ] ]
	},
	
	//  9 code executed on interruption
	{
		//No JIP
		[ netId player ] remoteExec [ "fnc_bubFinish", 0 ];
		//Remove start from JIP queue
		remoteExec [ "", format[ "%1_bub", netId player ] ]
	},
	
	[],							// 10 arguments
	6,							// 11 action duration
	0,							// 12 priority
	false,							// 13 remove on completion
	false							// 14 show unconscious
] call BIS_fnc_holdActionAdd;
 //player setVariable ["skillA", _skillA];
// player setVariable ["skillB", _skillB];
 //player setVariable ["skillC", _skillC];
// player setVariable ["skillD", _skillD];
};


NEB_fnc_isSpecialSuit = {
	private [ "_suitIndex" ];
	_specialSuits = [ "U_O_Protagonist_VR", "U_B_Protagonist_VR", "U_I_Protagonist_VR", "U_C_Driver_1_black", "U_C_Driver_1_white" ];
	
	_isWearing = uniform player in _specialSuits;
	if ( _isWearing ) then {
		_suitIndex = _specialSuits find uniform player;
	};
	_wasWearing = { _x }count ( player getVariable [ "hasSpecialSuit", [ false, false, false, false, false ] ] ) > 0;

	
	if ( _wasWearing && !_isWearing ) then {
		player setVariable [ "hasSpecialSuit", [ false, false, false, false, false ] ];
		[ -1 ] call NEB_fnc_suitChanged;
		hint format [ "%1 took off Special Suit", name player ];
	};
	
	if ( _isWearing ) then {
		_flags = player getVariable [ "hasSpecialSuit", [ false, false, false, false, false ] ];
		{
			if ( _forEachIndex isEqualTo _suitIndex ) then {
				if !( _x ) then {
					hint format [ "%1 put on Special Suit", name player ];
					_flags set [ _forEachIndex, true ];
					[ _suitIndex ] call NEB_fnc_suitChanged;
				};
			}else{
				_flags set [ _forEachIndex, false ];
			};
		}forEach _flags;

		player setVariable [ "hasSpecialSuit", _flags ];
		
	};
};
[] call NEB_fnc_isSpecialSuit;
NEB_fnc_suitChanged = {
	private[ "_newAbilities" ];
	params[ "_suitIndex" ];
	
	_allAbilities = [ "Sprint", "Sprint2", "Sprint3", "Lightning", "Bubble" ];
	
	_suitAbilities = [
		[ "Sprint" ],
		[ "Sprint2" ],
		[ "Sprint3" ],
		[ "Sprint3", "Lightning" ],
		[ "Sprint3", "Bubble" ]
	];
	
	if ( _suitIndex > -1 ) then {
		_newAbilities = _suitAbilities select _suitIndex;
	}else{
		_newAbilities = [];
	};
	
	{
		if ( _x in _newAbilities ) then {
			player setVariable[ _x, true ];
		}else{
			player setVariable[ _x, false ];
		};
	}forEach _allAbilities;	
};
enableSentences false;

_myLoadout = profileNamespace getVariable ["NEB_PRO_39573_LOADOUT",[]];

if (_myLoadout isEqualto []) then {
[] call neb_fnc_core_levelRewards;
}else{
player setUnitLoadout _myLoadout;
};



(_this select 0) enableStamina false;
[] spawn neb_fnc_core_openChute;
//Starting UI stats and groups
( [ "playerInfo" ] call BIS_fnc_rscLayer ) cutRsc [ "playerInfo", "PLAIN", 1, false ];
[] call fnc_updateStats;
//[] call neb_fnc_core_startingStats;
["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;
[player] call neb_fnc_core_disableStamina;

NEB_fnc_getPlayerLevel = {
	player getVariable [ "level", 0 ];
};

NEB_fnc_getPlayerCash = {
	player getVariable [ "cash", 0 ];
};

[] spawn neb_fnc_core_addPlayerIcons;

0 = ["players","ai"] call neb_fnc_core_playerMarkers;




//This will not work like this as this is a server command only
//So will not update all players, only the host if hosted server
onPlayerDisconnected {
	_loadout = getUnitLoadout player;
	profileNamespace setVariable ["NEB_PRO_39573_LOADOUT",_loadout];
    saveProfileNamespace;
};

				
