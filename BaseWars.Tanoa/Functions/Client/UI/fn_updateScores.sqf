
#define UIRedScore		1005
#define UIBluScore		1006
#define UIBluBar		1007
#define UIRedBar		1008
#define UIEndScore		1009

//This function is called by the server when the scores change

params[ [ "_redScore", 0 ], [ "_bluScore", 0 ] ];

if ( isNil "NEB_endScore" ) then {
	NEB_endScore = paramsArray param[ 0, 1000 ];
};

_bluProgress = linearConversion [ 0, NEB_endScore, _bluScore, 0, 1 ];
_redProgress = linearConversion [ 0, NEB_endScore, _redScore, 0, 1 ];

[] call neb_fnc_core_ticketCounter;

(uiNamespace getVariable "UIplayerInfo" displayCtrl UIRedScore ) ctrlSetText ( format [ "%1", _redScore ] );
(uiNamespace getVariable "UIplayerInfo" displayCtrl UIBluScore ) ctrlSetText ( format [ "%1", _bluScore ] );
(uiNamespace getVariable "UIplayerInfo" displayCtrl UIBluBar ) progressSetPosition _bluProgress;
(uiNamespace getVariable "UIplayerInfo" displayCtrl UIRedBar ) progressSetPosition _redProgress;
(uiNamespace getVariable "UIplayerInfo" displayCtrl UIEndScore ) ctrlSetText ( format [ "%1", NEB_endScore ] );

