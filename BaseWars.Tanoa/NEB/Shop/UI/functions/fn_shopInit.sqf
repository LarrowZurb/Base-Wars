
//[ shop trigger, shopName, allowed shops, create marker, is mobile shop ] call NEB_fnc_shopInit
// shop trigger - OBJECT - the trigger that denotes shops area
// shopName - STRING - name used in text marker and action text, both are suffixed with 'Shop'
// allowed shops - ARRAY of string OR STRING - allowed shops, 'ALL' can be used to allow all defined shops
// create marker - BOOL OR ARRAY of [ BOOL, BOOL ] - whether to create shop markers, ARRAY format is [ area marker, text marker ] - DEFAULT [ true, true ]
// is mobile shop - BOOL - if true each client will monitor the trigger for movement and will update marker locations - DEFAULT false

params[
	[ "_sides", [ east, west ] ],
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

if ( playerSide in _sides ) then {
	private[ "_mrk", "_mrkTxt" ];
	
	//Create unique marker name
	private _mrkName = format[ "shop_%1", random 1 ];
	while { !( getMarkerPos _mrkName isEqualTo [ 0,0,0 ] ) } do {
		_mrkName = format[ "shop_%1", random 1 ];
	};
	
	//Create Area Marker
	if ( _mrkArea ) then {
		_mrk = createMarkerLocal [ _mrkName, getPos _shopTrigger ];
		triggerArea _shopTrigger params[ "_a", "_b", "_angle", "_isRect" ];
		_mrk setMarkerDirLocal _angle;
		_mrk setMarkerSizeLocal [ _a, _b ];
		_mrk setMarkerShapeLocal ( [ "ELLIPSE", "RECTANGLE" ] select _isRect );
		_mrk setMarkerBrush "Border";
	};

	//Create Name marker
	if ( _mrkText ) then {
		_mrkTxt = createMarkerLocal [ format[ "shop_%1_txt", _mrkName ], getPos _shopTrigger ];
		_mrkTxt setMarkerShapeLocal "ICON";
		_mrkTxt setMarkerTypeLocal "hd_dot";
		_mrkTxt setMarkerTextLocal format[ "%1 Shop", _shopName ];
	};
	
	if ( _isMobile ) then {
		
		if ( isNil "NEB_shopMarkers" ) then {
			NEB_shopMarkers = [];
			
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
		
		{
			if !( isNil _x ) then {
				NEB_shopMarkers pushBack [ call compile _x, _shopTrigger ];
			};
		}forEach [ "_mrk", "_mrkTxt" ];

	};
	

	if ( _shops isEqualType "" && { _shops == "ALL" } ) then {
		_shops = NEB_availableShops;
	}else{
		if !( _shops isEqualType [] ) then {
			_shops = [ _shops ];
		};
	};


	waitUntil{ !isNull player };
	
	_shopTrigger triggerAttachVehicle [ player ];
	_shopTrigger setTriggerActivation [ "VEHICLE", "PRESENT", true ];
	_shopTrigger setTriggerStatements [
		"this",
		format[ "
			[ 'SHOP', [ 'ENTER', '%1' ] ] call NEB_fnc_showMessage;
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
			[ 'SHOP', [ 'LEAVE', '%1' ] ] call NEB_fnc_showMessage;
			player removeAction ( player getvariable 'NEB_shopAction_%1' );
			[ 'HIDE' ] call NEB_fnc_shopCrate;
		", _shopName ]
	];

};