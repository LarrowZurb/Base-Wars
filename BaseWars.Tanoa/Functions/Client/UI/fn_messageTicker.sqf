
if !( hasInterface ) exitWith {};

NEB_MsgTickDelay = 2;

NEB_MsgTickLayers = [
	[ [ "up1" ] call BIS_fnc_rscLayer, false ],
	[ [ "up2" ] call BIS_fnc_rscLayer, false ],
	[ [ "up3" ] call BIS_fnc_rscLayer, false ]
];

NEB_MsgTickQueue = [];
NEB_MsgTickNext = diag_tickTime;

addMissionEventHandler [ "EachFrame", {

	if ( count NEB_MsgTickQueue > 0 && { diag_tickTime > NEB_MsgTickNext } ) then {

		_layerInfo = {
			_x params[ "_layer", "_active" ];
			if !( _active ) exitWith {
				( NEB_MsgTickLayers select _forEachIndex ) set [ 1, true ];
				[ _layer, _forEachIndex ]
			};
		}forEach NEB_MsgTickLayers;
		
		if !( isNil "_layerInfo" ) then {
			
			NEB_MsgTickNext = diag_tickTime + NEB_MsgTickDelay;
			
			_layerInfo spawn {
				params[ "_layer", "_index" ];
				
				_duration = 4;
				_fadeIn = 1;
				_moveY = safeZoneH * 0.05;
				
				_script = [ NEB_MsgTickQueue deleteAt 0, safeZoneX + 0.3 * safeZoneW, safeZoneY, _duration, _fadeIn, _moveY, _layer ] spawn BIS_fnc_dynamicText;
				waitUntil{ scriptDone _script };
				
				( NEB_MsgTickLayers select _index ) set [ 1, false ];
			};
		};
		
		
	};
}];