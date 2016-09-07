addMissionEventHandler [ "HandleDisconnect", {
	params[ "_unit", "_id", "_uid", "_name" ];
	
	[ "SAVE" ] remoteExec [ "NEB_fnc_profileVars", _unit ];
}];

addMissionEventHandler [ "Ended", {
	[ "SAVE" ] remoteExec [ "NEB_fnc_profileVars", 0 ];
}];