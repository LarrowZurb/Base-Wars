waitUntil { !isNull player && time > 0 }; //after briefing
 
//Define UI ctrls
#define UIlevel 1000
#define UIprogress 1001
#define UIprogressBar 1002
#define UIcash 1003
#define UIkills 1004
#define UIredScore 1005
#define UIbluScore 1006
#define UIbluBar 1007
#define UIredBar 1008
#define UIendScore 1009
#define UIhealthBar 1010
#define UIhealthIcon 1011
#define UIdisplayFPS 1012


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

//Set player var        var            to stored profile value            profile var                default value if it does not exist
//                                                                                            ( means we must be a new player! )
player setVariable [ "cash",        profileNamespace getVariable [ "NEB_PRO_39573_CASH",    500 ] ];
player setVariable [ "experience",    profileNamespace getVariable [ "NEB_PRO_39573_EXP",        100 ] ];
player setVariable [ "kills",        profileNamespace getVariable [ "NEB_PRO_39573_KILLS",    0 ] ];
player setVariable [ "level",        profileNamespace getVariable [ "NEB_PRO_39573_LEVEL",    1 ] ];

                
    
//Add event to player
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
 
 
 
//Function to update stats
fnc_updateStats = {
    params[
        [ "_addCash", 0 ],
        [ "_addExp", 0 ],
        [ "_addKills", 0 ]
    ];
	
	//If we are in unscheduled mode e.g been called by a local EH
	//Which means we cannot pause( waituntil ) 
	if !( canSuspend ) exitWith {
		//Then re spawn( create new scheduler thread ) this script with the arguments
		_nul = _this spawn fnc_updateStats;
	};
	
	//singleton type setup
	//If something is already using the update stats
	if !( isNil "statsUpdating" ) then {
		//then wait here until it has finished
		waitUntil{ isNil "statsUpdating" };
	};

	//Flag updatestats as in use
	statsUpdating = true;
	
	
    //Get current stats + what was passed
    _cash = (( player getVariable [ "cash", 0 ] ) + _addcash ) max 0; //Make sure cash cannot go into negative values?
    _exp = (( player getVariable [ "experience", 0 ] ) + _addExp ) max 100; //Make sure experience cannot go into negative values?
    _kills = ( player getVariable [ "kills", 0 ] ) + _addKills;
    _currentLevel = player getVariable [ "level", 0 ];
    
    _tmpExp = _exp; //temp variable to store left over xp towards players next level
    _newLevel = 0; //Starting at zero as we are working out from the player total experience
    _oldLevel = _currentLevel;
 
    //Exp need to from level 0 to level 1
    _expForNextLevel = 100;
    
    //Work out new level
    while { _tmpExp >= _expForNextLevel } do {
        //If we are in the loop we have enough exp to reach next level
        //Increase the level
        _newLevel = _newLevel + 1;
              
        //Every level needs twice as much exp as the level before
        //Increase exp needed for next iteration
        _expForNextLevel = _expForNextLevel * 2;
    };
    
    
    //Update stat vars on player object - no PV as everything is now handled client side by this function
    player setVariable [ "cash",        _cash ];
    player setVariable [ "experience",    _exp ]; //total experience
    player setVariable [ "kills",        _kills ];
    player setVariable [ "level",        _newLevel ];
    player setVariable [ "cashGains",        _addCash ];
	player setVariable [ "expGains",        _addExp ];
	
    //Update profile stats
    profileNamespace setVariable [ "NEB_PRO_39573_CASH", _cash ];
    profileNamespace setVariable [ "NEB_PRO_39573_EXP", _exp ]; //total experience
    profileNamespace setVariable [ "NEB_PRO_39573_KILLS", _kills ];
    profileNamespace setVariable [ "NEB_PRO_39573_LEVEL", _newLevel ];
	
    //saveProfileNamespace can be quite an expensive operation
    //it maybe be better to add the above section to a player disconnected EH and a mission over fucntion
    //So the saved profile stats are only updated then, rather than every update
    //and only work with the player vars until you actually need to save their profile values
    
    //If we increased in level
    if ( _newLevel > _currentLevel ) then {
        //Inform player of level increase
        //hint format [ " LEVEL UP \nNow Level %1", _newLevel ];
		
		[] call fnc_showLevelUp;
        
        //No need to remoteExec( BIS_fnc_MP ) a function that is only working on our own local client
        [] call fnc_levelUpRewards;
    };
 
    //Get progress to next level - how much progress do we have towards our next level
    //0 to experience needed for next level
    //converted into a 0 to 1 value for the progress bar
    //based off of the tmp experience left over from our calculation loop above
    _progress = linearConversion [ (_expForNextLevel / 2), _expForNextLevel, _tmpExp, 0, 1 ];
	
	//_healthIcon = "\A3\ui_f\data\map\markers\nato\b_med.paa";
 
    //Update UI with stats
	
	
    (uiNamespace getVariable "UIplayerInfo" displayCtrl UIlevel ) ctrlSetText ( format [ "Level : %1", _newLevel ] );
    (uiNamespace getVariable "UIplayerInfo" displayCtrl UIprogress ) ctrlSetText ( format [ "XP : %1/%2", _tmpExp, _expForNextLevel ] );
    (uiNamespace getVariable "UIplayerInfo" displayCtrl UIprogressBar ) progressSetPosition _progress;
    (uiNamespace getVariable "UIplayerInfo" displayCtrl UIcash ) ctrlSetText ( format [ "$%1", _cash ] );
    (uiNamespace getVariable "UIplayerInfo" displayCtrl UIkills ) ctrlSetText ( format [ "Kills : %1", _kills ] );
	
	
	[] call fnc_showCashGain;
	
		//flag updatestats as finished
	statsUpdating = nil;
};


neb_healthBar = addMissionEventHandler ["Draw3D",{
_bluProgress = linearConversion [ 0, endScore, bluScore, 0, 1 ];
_redProgress = linearConversion [ 0, endScore, redScore, 0, 1 ];
_displayFPS = round diag_fps;
_playerDamage = (1 - (damage player));
[] call neb_fnc_core_ticketCounter;
	(uiNamespace getVariable "UIplayerInfo" displayCtrl UIhealthBar ) progressSetPosition _playerDamage;
	(uiNamespace getVariable "UIplayerInfo" displayCtrl UIdisplayFPS ) ctrlSetText ( format [ "FPS : %1", _displayFPS ] );
	(uiNamespace getVariable "UIplayerInfo" displayCtrl UIredScore ) ctrlSetText ( format [ "%1", redScore ] );
	(uiNamespace getVariable "UIplayerInfo" displayCtrl UIbluScore ) ctrlSetText ( format [ "%1", bluScore ] );
	(uiNamespace getVariable "UIplayerInfo" displayCtrl UIendScore ) ctrlSetText ( format [ "%1", endScore ] );
	(uiNamespace getVariable "UIplayerInfo" displayCtrl UIbluBar ) progressSetPosition _bluProgress;
    (uiNamespace getVariable "UIplayerInfo" displayCtrl UIredBar ) progressSetPosition _redProgress;
}];


fnc_showLevelUp = {
	
	_myLvl = player getVariable [ "level", 0 ];
	if (_myLvl > 1) then {
	_lvlText = format [ " LEVEL UP!<br /> Now Level %1", _myLvl ];
	["<t color='#B8AB67' size = '.4'>" + _lvlText + "</t>",safezoneX + 0.76 * safezoneW,safezoneY + safezoneH - 0.23,4,1,0,788] call bis_fnc_dynamicText;
	};

};

fnc_showCashGain = {
	_cashUp = player getVariable [ "cashGains", 0 ];
	_xpUp = player getVariable [ "expGains", 0 ];
	if ( _xpUp > 0) then {
	_cashText = format [ " $%1", _cashUp];
	_xpText = format [ " XP%1", _xpUp];
	["<t color='#B8AB67' size = '.4'>" + _cashText  + "<br/>" + _xpText +"</t>",safezoneX + 0.72 * safezoneW,safezoneY + safezoneH - 0.08,4,1,0,789] call bis_fnc_dynamicText;
	};
};

fnc_levelUpRewards = {
					private [ "_currentWeapon", "_cfg", "_compatibleMags", "_myLvl" ];
					_myLvl = player getVariable [ "level", 0 ];
					_currentWeapon = primaryWeapon player;
					_cfg = configFile >> "CfgWeapons" >> _currentWeapon;
					_compatibleMags = [];
					{
						if ( _x == "this" ) then {
							_compatibleMags = _compatibleMags + getArray( _cfg >> "magazines" );
						}else{
							_compatibleMags = _compatibleMags + getArray( _cfg >> _x >> "magazines" );
						};
					}forEach getArray( _cfg >> "muzzles" );
					_mainMag = _compatibleMags select 0;
					_currentPack = backpack player;

						if ((player canAdd "HandGrenade") && (_myLvl ==3)) then {
						player addMagazine 'HandGrenade';
						};
						if ((player canAdd [_mainMag, 2]) && (_myLvl ==5)) then {
						player addMagazine 'HandGrenade';
						player addMagazine _mainMag;
						if (_currentPack == "") then {
							switch (playerSide) do {
									case west: {
									player addBackpack "B_AssaultPack_tna_F";
									};
									case east: {
									player addBackpack "B_FieldPack_ghex_F"
									};
								};
							};
						};
						if ((player canAdd [_mainMag, 3]) && (_myLvl ==10)) then {
						player addMagazine 'HandGrenade';
						player addMagazines [_mainMag, 2];
						};
						if ((player canAdd [_mainMag, 4]) && (_myLvl ==15)) then {
						player addMagazine 'HandGrenade';
						player addMagazines [_mainMag, 3];
						};
						if ((player canAdd [_mainMag, 5]) && (_myLvl ==20)) then {
						player addMagazine 'HandGrenade';
						player addMagazines [_mainMag, 4];
						/*
						switch (playerSide) do {
								case west: {
								
								};
								case east: {
								
								};
							};
						*/
						};
						if ((player canAdd [_mainMag, 5]) && (_myLvl ==25)) then {
						player addMagazine 'HandGrenade';
						player addMagazines [_mainMag, 4];
						};
						if ((player canAdd [_mainMag, 5]) && (_myLvl ==30)) then {
						player addMagazine 'HandGrenade';
						player addMagazines [_mainMag, 4];
						/*
						switch (playerSide) do {
								case west: {
								
								};
								case east: {
								
								};
							};
						*/
						};
						if ((player canAdd [_mainMag, 5]) && (_myLvl ==35)) then {
						player addMagazine 'HandGrenade';
						player addMagazines [_mainMag, 4];
						};
						if ((player canAdd [_mainMag, 5]) && (_myLvl ==40)) then {
						player addMagazine 'HandGrenade';
						player addMagazines [_mainMag, 4];
						/*
						switch (playerSide) do {
								case west: {
								
								};
								case east: {
								
								};
							};
						*/
						};
						if ((player canAdd [_mainMag, 5]) && (_myLvl ==45)) then {
						player addMagazine 'HandGrenade';
						player addMagazines [_mainMag, 4];
							};
	
						};
	





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
player addEventHandler [ "Take", {
	[] call NEB_fnc_isSpecialSuit;
}];

player addEventHandler [ "Put", {
	[] call NEB_fnc_isSpecialSuit;
}];

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

				
