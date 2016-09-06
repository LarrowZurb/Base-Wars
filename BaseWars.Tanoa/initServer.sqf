//Server Cleanup
[
    300, // seconds to delete dead bodies (0 means don't delete) 
    10, // seconds to delete dead vehicles (0 means don't delete)
    120, // seconds to delete immobile vehicles (0 means don't delete)
    1000, // seconds to delete dropped weapons (0 means don't delete)
    400, // seconds to deleted planted explosives (0 means don't delete)
    400 // seconds to delete dropped smokes/chemlights (0 means don't delete)
] spawn neb_fnc_core_repeatCleanUp;
//Vehicle Spawns
[] spawn neb_fnc_core_vehicleSpawns;
//Creep Spawns
[] spawn neb_fnc_core_creepSpawn;
//Relations
[] call neb_fnc_core_setRelations;
//Groups UI
["Initialize"] call BIS_fnc_dynamicGroups;


redScore = 0;
bluScore = 0;
endScore = 1000;

publicVariable "redScore";
publicVariable "bluScore";
publicVariable "endScore";


/*Protect Commander --OLD, Might use again--
[blu_command] call neb_fnc_core_protectCommander;
[red_command] call neb_fnc_core_protectCommander;
*/

//Function for adding killed event to AI
fnc_addEvent = {

	//Passed unit
	_unit = _this;

	//Add event ( see initPlayerLocal.sqf for code comments )
	_unit addEventHandler [ "Killed", {
		_unit = _this select 0;
		_killer = _this select 1;

		if ( isPlayer _killer && !( _killer isEqualTo _unit ) ) then {

			_killedSide = ( getNumber ( configFile >> "CfgVehicles" >> typeOf _unit >> "side" ) ) call BIS_fnc_sideType;
			_isEnemy = _killedSide getFriend side _killer < 0.6;

			_currentCash = _killer getVariable [ "cash", 0 ];
			_currentExperience = _killer getVariable [ "experience", 0 ];
			_currentKills = _killer getVariable [ "kills", 0 ];

			if ( _isEnemy ) then {

				_killer setVariable [ "cash", ( _currentCash + 100 ) , true ];
				_killer setVariable [ "experience", ( _currentExperience + 100 ) , true ];
				_killer setVariable [ "kills", ( _currentKills + 1 ) , true ];

			}else{

				_killer setVariable [ "cash", ( _currentCash - 100 ) max 0 , true ];
				_killer setVariable [ "experience", ( _currentExperience - 200 ) max 0 , true ];
			};

			[ [], "fnc_updateStats", _killer ] call BIS_fnc_MP;
		};

	}];

	//Flag unit as having had event added
	_unit setVariable [ "hasEvent", true ];

};

//Function called by spawnAI module
fnc_setEventKilled = {

	//Passed group
	_grp = _this select 0;

	//For each unit in the group call addEvent function
	{
		_x call fnc_addEvent;
	}forEach units _grp;
};


addMissionEventHandler [ "HandleDisconnect", {
	params[ "_unit", "_id", "_uid", "_name" ];
	
	//Remove JIP for crate closing
	remoteExec [ "", format[ "shopCrate_%1", _uid ] ];
	
}];