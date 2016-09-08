//Function to update stats

//Define UI ctrls
#define UIlevel			1000
#define UIprogress		1001
#define UIprogressBar	1002
#define UIcash			1003
#define UIkills			1004

//If we are in unscheduled mode e.g been called by a local EH
//Which means we cannot pause( waituntil ) 
if !( canSuspend ) exitWith {
	//Then re spawn( create new scheduler thread ) this script with the arguments
	_nul = _this spawn NEB_fnc_updateStats;
};

//singleton type setup
//If something is already using the update stats
if !( isNil "NEB_statsUpdating" ) then {
	//then wait here until it has finished
	waitUntil{ isNil "NEB_statsUpdating" };
};

//Flag updatestats as in use
NEB_statsUpdating = true;

params[
    [ "_addCash", 0 ],
    [ "_addExp", 0 ],
    [ "_addKills", 0 ]
];

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
player setVariable [ "cash",		_cash ];
player setVariable [ "experience",	_exp ]; //total experience
player setVariable [ "kills",		_kills ];
player setVariable [ "level",		_newLevel ];

[ "UPDATE" ] call NEB_fnc_profileVars;

//flag updatestats as finished
NEB_statsUpdating = nil;

{
	if ( _x select 1 != 0 ) then {
		_x call NEB_fnc_showMessage;
	};
}forEach[
	[ "CASH", _addCash ],
	[ "EXP", _addExp ]
];

//If we increased in level
if ( _newLevel > _currentLevel ) then {
	[ "LVL", _newLevel ] call NEB_fnc_showMessage;
    //No need to remoteExec( BIS_fnc_MP ) a function that is only working on our own local client
    [ _newLevel ] call NEB_fnc_levelUpRewards;
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
