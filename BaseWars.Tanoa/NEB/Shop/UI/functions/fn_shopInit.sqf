
//[ shop trigger, shopName, allowed shops, create marker, is mobile shop ] call NEB_fnc_shopInit
// shop trigger - OBJECT - the trigger that denotes shops area
// shopName - STRING - name used in text marker and action text, both are suffixed with 'Shop'
// allowed shops - ARRAY of string OR STRING - allowed shops, 'ALL' can be used to allow all defined shops
// create marker - BOOL OR ARRAY of [ BOOL, BOOL ] - whether to create shop markers, ARRAY format is [ area marker, text marker ] - DEFAULT [ true, true ]
// is mobile shop - BOOL - if true each client will monitor the trigger for movement and will update marker locations - DEFAULT false

params[
	[ "_shopTrigger", objNull, [ objNull ] ],
	[ "_shopName", "", [ "" ] ],
	[ "_shops", "ALL", [ "", [] ] ],
	[ "_createMarker", [ true, true ], [ false, [] ], [ 2 ] ],
	[ "_isMobile", false ]
];

if ( isNull _shopTrigger ) exitWith {
	"No trigger passed in call to NEB_fnc_shopInit" call BIS_fnc_error;
};

if !( _createMarker isEqualType []  ) then {
	_createMarker = [ _createMarker, _createMarker ];
};
_createMarker params[ [ "_mrkArea", true ], [ "_mrkText", true ] ];

if ( isServer ) then {
	private[ "_mrk", "_mrkTxt" ];
	
	//Create unique marker name
	private _mrkName = "";
	while { true } do {
		_mrkName = format[ "%1_%2", random 1, _shopName ];
		if ( getMarkerPos _mrkName isEqualTo [0,0,0] ) exitWith {};
	};

	//Create Area Marker
	if ( _mrkArea ) then {
		_mrk = [ _mrkName, _shopTrigger ] call BIS_fnc_markerToTrigger;
		_mrk setMarkerBrush "Border";
	};

	//Create Name marker
	if ( _mrkText ) then {
		_mrkTxt = createMarker [ format[ "%1_txt", _mrkName ], getPos _shopTrigger ];
		_mrkTxt setMarkerShape "ICON";
		_mrkTxt setMarkerType "hd_dot";
		_mrkTxt setMarkerText format[ "%1 Shop", _shopName ];
	};
	
	if ( _isMobile ) then {
		
		if ( isNil "NEB_shopMarkers" ) then {
			NEB_shopMarkers = [];
		};
		
		{
			if !( isNil _x ) then {
				NEB_shopMarkers pushBack [ call compile _x, _shopTrigger ];
			};
		}forEach [ "_mrk", "_mrkTxt" ];
			
		publicVariable "NEB_shopMarkers";
	};
	
};

if ( _shops isEqualType "" && { _shops == "ALL" } ) then {
	_shops = NEB_availableShops;
}else{
	if !( _shops isEqualType [] ) then {
		_shops = [ _shops ];
	};
};

//Client or Host
if ( !isDedicated && hasInterface  ) then {
	
	_thread = [ _shopTrigger, _shopName, _shops ] spawn {
		params[ "_shopTrigger", "_shopName", "_shops" ];
		
		waitUntil{ !isNull player };
		
		_shopTrigger triggerAttachVehicle [ player ];
		_shopTrigger setTriggerActivation [ "VEHICLE", "PRESENT", true ];
		_shopTrigger setTriggerStatements [
			"this",
			format[ "
				hint 'You have entered\n%1 shop';
				player setvariable [ 'NEB_shopAction_%1',
					player addAction [ 'Open %1 Shop', {
							[ 'INIT', [ %2 ] ] call NEB_fnc_shop;
						},
						[],
						10
					]
				];
			", _shopName, _shops ],
			format[ "
				hint 'You have left\n%1 shop';
				player removeAction ( player getvariable 'NEB_shopAction_%1' );
				[ 'HIDE' ] call NEB_fnc_shopCrate;
			", _shopName ]
		];
		
		addMissionEventHandler [ "EachFrame", {
			if ( !isNil "NEB_shopMarkers" && { visibleMap || visibleGPS } ) then {
				{
					_x params[ "_marker", "_trigger" ];
					_pos = getPosATLVisual _trigger;
					_marker setMarkerPosLocal _pos;
				}forEach NEB_shopMarkers;
			};
		}];
	};
};