
#define UIhealthBar		1010
#define UIdisplayFPS	1012


if !( hasInterface ) exitWith {};

//Init UI stats display
( [ "playerInfo" ] call BIS_fnc_rscLayer ) cutRsc [ "playerInfo", "PLAIN", 1, false ];

//Call update to show stats
[] call NEB_fnc_updateStats;

//Update Health and FPS each frame
addMissionEventHandler [ "Draw3D", {
	_displayFPS = round diag_fps;
	_playerDamage = (1 - (damage player));
	
	(uiNamespace getVariable "UIplayerInfo" displayCtrl UIhealthBar ) progressSetPosition _playerDamage;
	(uiNamespace getVariable "UIplayerInfo" displayCtrl UIdisplayFPS ) ctrlSetText ( format [ "FPS : %1", _displayFPS ] );
}];

//Show Score and Progress
[] call NEB_fnc_updateScores;