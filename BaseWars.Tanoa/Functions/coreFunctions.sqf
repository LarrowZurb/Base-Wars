/*  
* BASE WARS FUNCTION LIBRARY
*  by Nebulazer
*/

neb_fnc_core_setStartingPos = {
						params ["_position"];
						
						player setPos _position;    // _position
						diag_log format["setting player's position to: %1", _position];
						sleep 1;
						_real_player_pos = getPos player;
						diag_log format["position that has been set: %1", _real_player_pos];
						_tries = 0;
						sleep 1;
						
						
						while {abs(abs(_real_player_pos select 0) - abs(_position select 0))  > 10 or abs(abs(_real_player_pos select 1) - abs(_position select 1)) > 10} do {
							diag_log format["player pos is %1 which is not target pos %2. retrying...", _real_player_pos, _position];
							hint format["position wasn't set correctly; trying again... %1", _tries];
							sleep 1;
							_tries = _tries +1;
							player setPos _position;
							sleep 1;
							_real_player_pos = getPos player;
							diag_log format["player pos is %1 which is not target pos %2. retrying...", _real_player_pos, _position];
						};
};

//Tele to Truck
neb_fnc_core_teleToTruckFree = {
		params ["_home", "_truck", "_action"];
		
		_action = [
	/* 0 object */				_home,
	/* 1 action title */			"Teleport To Mobile FOB (FREE)[AIR]",
	/* 2 idle icon */				"images\blinkicon.paa",
	/* 3 progress icon */			"images\blinkicon.paa",
	/* 4 condition to show */		"true",
	/* 5 condition for action */		"true",
	/* 6 code executed on start */		{},
	/* 7 code executed per tick */		{},
	/* 8 code executed on completion */	{
										param[ 3 ] params ["_home","_truck", "_action"];
										player setPos [getPos _truck select 0, (getPos _truck select 1), (getPos _truck select 2) +500];
										},
	/* 9 code executed on interruption */	{},
	/* 10 arguments */			[_home,_truck, _action],
	/* 11 action duration */		1,
	/* 12 priority */			0,
	/* 13 remove on completion */		false,
	/* 14 show unconscious */		false
	] call bis_fnc_holdActionAdd;
};

neb_fnc_core_teleToTruck = {
	params [ "_home", "_truckVarName" ];
		
	_action = [
	/* 0 object */				_home,
	/* 1 action title */			"Teleport To Mobile FOB ($500)",
	/* 2 idle icon */			"images\blinkicon.paa",
	/* 3 progress icon */			"images\blinkicon.paa",
	/* 4 condition show */		        format[ "
                                                    call {
                                                        private _truck = missionNamespace getVariable [ '%1', objNull ];
                                                        !isNull _truck && { alive _truck && canMove _truck }
                                                    };
                                                ", _truckVarName ],
	/* 5 condition progress */              "
                                                    _arguments params [ '_truckVarName' ];
                                                    _truck = missionNamespace getVariable [ _truckVarName, objNull ];
                                                    !isNull _truck && { alive _truck && canMove _truck }
                                                ",
	/* 6 code executed on start */		{},
	/* 7 code executed per tick */		{},
	/* 8 code executed on completion */	{
							param[ 3 ] params [ "_truckVarName" ];
							_truck = missionNamespace getVariable [ _truckVarName, objNull ];
							if ( !isNull _truck && { alive _truck && canMove _truck } ) then {
								[ 500 ] call neb_fnc_core_pay;
								player setPos ( _truck getPos [ 5, random 360 ] );
							};
						},
	/* 9 code executed on interruption */	{},
	/* 10 arguments */			[ _truckVarName ],
	/* 11 action duration */		1,
	/* 12 priority */			0,
	/* 13 remove on completion */		false,
	/* 14 show unconscious */		false
	] call BIS_fnc_holdActionAdd;
};


//End Mission
neb_fnc_core_ticketCounter = {
_quarterScore = round (endScore / 4);
_midscore = round (endScore / 2);
_threeQuarter = round (endScore / 4) * 3;
_almostEnd = round (endScore / 4) * round 3.8;
_amountleftEnd = endScore - _almostEnd;
	// Blu is at Quarter Score
	if ((bluScore >= _quarterScore) && {isNil "bluQuarterFlag"}) then {
		_scoreText = format [ "Blu Is Now At %1 Out of %2 Points To Win The Game", bluScore, endScore ];
		["<t color='#1603B0' size = '.8'>" + _scoreText + "</t>",-1,safezoneY + safezoneH - 0.13,4,1,0,825] spawn BIS_fnc_dynamicText;
		bluQuarterFlag = true;
	};
	// Red is at Quarter Score
	if ((redScore >= _quarterScore) && {isNil "redQuarterFlag"}) then {
		_scoreText = format [ "Red Is Now At %1 Out of %2 Points To Win The Game", redScore, endScore ];
		["<t color='#971F1F' size = '.8'>" + _scoreText + "</t>",-1,safezoneY + safezoneH - 0.07,4,1,0,833] spawn BIS_fnc_dynamicText;
		redQuarterFlag = true ;
		};

	// Blu Has Half points needed to win
	if ((bluScore >= _midScore) && {isNil "bluHalfFlag"}) then {
		_scoreText = format [ "Blu Is Now At %1 Out of %2 Points To Win The Game", bluScore, endScore ];
		["<t color='#1603B0' size = '.8'>" + _scoreText + "</t>",-1,safezoneY + safezoneH - 0.13,4,1,0,845] spawn BIS_fnc_dynamicText;
		bluHalfFlag = true;
		};

	// Red Has Half points needed to win
	if ((redScore >= _midScore) && {isNil "redHalfFlag"}) then {
		_scoreText = format [ "Red Is Now At %1 Out of %2 Points To Win The Game", redScore, endScore ];
		["<t color='#971F1F' size = '.8'>" + _scoreText + "</t>",-1,safezoneY + safezoneH - 0.07,4,1,0,855] spawn BIS_fnc_dynamicText;
		redHalfFlag = true;
		};

	if ((bluScore >= _threeQuarter) && {isNil "bluThreeQFlag"}) then {
		_scoreText = format [ "Blu Is Now At %1 Out of %2 Points To Win The Game", bluScore, endScore ];
		["<t color='#1603B0' size = '.8'>" + _scoreText + "</t>",-1,safezoneY + safezoneH - 0.13,4,1,0,860] spawn BIS_fnc_dynamicText;
		bluThreeQFlag = true;
		};

	if ((redScore >= _threeQuarter) && {isNil "redThreeQFlag"}) then {
		_scoreText = format [ "Red Is Now At %1 Out of %2 Points To Win The Game", redScore, endScore ];
		["<t color='#971F1F' size = '.8'>" + _scoreText + "</t>",-1,safezoneY + safezoneH - 0.07,4,1,0,870] spawn BIS_fnc_dynamicText;
		redThreeQFlag = true;
		};
	
	if ((bluScore >= _almostEnd) && {isNil "bluAlmostFlag"}) then {
		_scoreText = format [ "Blu Only Needs %1 Points To Win The Game!!", _amountleftEnd];
		["<t color='#1603B0' size = '.8'>" + _scoreText + "</t>",-1,safezoneY + safezoneH - 0.13,4,1,0,875] spawn BIS_fnc_dynamicText;
		bluAlmostFlag = true;
		};

	if ((redScore >= _almostEnd) && {isNil "redAlmostFlag"}) then {
		_scoreText = format [ "Red Only Needs %1 Points To Win The Game!!", _amountleftEnd];
		["<t color='#971F1F' size = '.8'>" + _scoreText + "</t>",-1,safezoneY + safezoneH - 0.07,4,1,0,880] spawn BIS_fnc_dynamicText;
		redAlmostFlag = true;
		};
	
	if (bluScore >= endScore) then {
		//Crate Saving
	endMission "END1";
		};
	if (redScore >= endScore) then {
		//Crate Saving
	endMission "END1";
		};

};

//Take Money
neb_fnc_core_pay = {
params[["_cost", 0], ["_unit", player], ["_paid", false]];
_cash = _unit getVariable["cash", 0];

if (_cash >= _cost) then {
_balance = _cash - _cost;
_unit setVariable["cash", _balance, true];
_paid = true;
_loadout = getUnitLoadout _unit;
profileNamespace setVariable ["NEB_PRO_39573_LOADOUT",_loadout];
[] call fnc_updateStats;
};
_paid
};

// Disable Stamina
neb_fnc_core_disableStamina = {	
	params ["_unit"];
	_unit enableStamina false;
};

/* Copy gear from a unit
neb_fnc_core_copyGear = {
	params["_object", "_caller", "_id", "_args", "_copyFrom","_loadout"];
	_copyFrom = cursorTarget;
	if (!(_copyFrom isKindOf "Man")) exitWith {};
	_loadout = getUnitLoadout _copyFrom;
	_caller setUnitLoadout _loadout;
	hint format["You copied %1's gear.", name _copyFrom];
};
*/

		
/*
if (player == red_command)  then{
		
		};

	if (player == blu_command)  then{
		
		};
*/


//Protects the commanders from friendly damage.
neb_fnc_core_protectCommander = {
     params["_commander"];
     _commander addEventHandler
     [
         "HandleDamage",
         {
             params["_unit", "_selection", "_damage", "_source", "_projectile", "_hitPart", "_returnDamage"];
             _returnDamage = _damage;
             if ((side _unit) isEqualTo (side _source)) then
                 {
                     _returnDamage = 0;
                 };
             _returnDamage;
        }
    ];
};

//Reward from taking merc camp
neb_fnc_core_cashonCamp = {
    params [ "_module", "_owner" ];

    //make sure the PV change has happened
    waitUntil{ _module getVariable [ "owner", sideUnknown ] isEqualTo _owner };
	sleep 0.5;

    //While the secotr still belongs to the players side
    while{ ( _module getVariable [ "owner", sideUnknown ] ) isEqualTo playerSide } do {
        
		switch (_owner) do {
								case west: {
								bluScore = bluScore + 1;
								};
								case east: {
								redScore = redScore + 1;
								};								
							};
		publicVariable "redScore";
		publicVariable "bluScore";
		[ 125, 50 ] remoteExec [ "fnc_updateStats", _owner ];
		sleep 30;
    };
};

//Reward from sector East
neb_fnc_core_cashonCiviCamp = {
    params [ "_module", "_owner" ];

    //make sure the PV change has happened
    waitUntil{ _module getVariable [ "owner", sideUnknown ] isEqualTo _owner };
	sleep 0.5;

    //While the secotr still belongs to the players side
    while{ ( _module getVariable [ "owner", sideUnknown ] ) isEqualTo playerSide } do {
      
	  switch (_owner) do {
								case west: {
								bluScore = bluScore + 1;
								};
								case east: {
								redScore = redScore + 1;
								};								
							};
							
		 publicVariable "redScore";
		 publicVariable "bluScore";
		 [ 250, 25 ] remoteExec [ "fnc_updateStats", _owner ];
        sleep 30;
    };
};

//Reward from sector West
neb_fnc_core_cashonCiviCampB = {
    params [ "_module", "_owner" ];

    //make sure the PV change has happened
    waitUntil{ _module getVariable [ "owner", sideUnknown ] isEqualTo _owner };
	sleep 0.5;

    //While the secotr still belongs to the players side
    while{ ( _module getVariable [ "owner", sideUnknown ] ) isEqualTo playerSide } do {
        
		switch (_owner) do {
								case west: {
								bluScore = bluScore + 1;
								};
								case east: {
								redScore = redScore + 1;
								};
							};
		publicVariable "redScore";
		publicVariable "bluScore";
		[ 250, 25 ] remoteExec [ "fnc_updateStats", _owner ];
        sleep 30;
    };
};

//Reward For taking Red Base
neb_fnc_core_bluWin = {
   params [ "_module", "_owner" ];

    //make sure the PV change has happened
    waitUntil{ _module getVariable [ "owner", sideUnknown ] isEqualTo _owner };
	sleep 0.5;

    //While the secotr still belongs to the players side
    while{ ( _module getVariable [ "owner", sideUnknown ] ) isEqualTo WEST } do {
	player globalChat "Opfor is Holding Blufors Coms Tower";
	[ 500, 100 ] remoteExec [ "fnc_updateStats", _owner ];
	bluScore = bluScore + 2;
	publicVariable "bluScore";
	sleep 30;
	//endMission "END1";
		};   
    };

//Reward for taking Blu Base
neb_fnc_core_redWin = {
   params [ "_module", "_owner" ];

    //make sure the PV change has happened
    waitUntil{ _module getVariable [ "owner", sideUnknown ] isEqualTo _owner };
	sleep 0.5;

    //While the secotr still belongs to the players side
    while{ ( _module getVariable [ "owner", sideUnknown ] ) isEqualTo EAST } do {
	player globalChat "Opfor is Holding Blufors Coms Tower";
	[ 500, 100 ] remoteExec [ "fnc_updateStats", _owner ];
	redScore = redScore + 2;
	publicVariable "redScore";
	sleep 30;
	
		};   
    };
	
//Level Rewards after Respawn
neb_fnc_core_levelRewards = {
		private ["_myLvl"];
		_myLvl = player getVariable [ "level", 0 ];
		_starterClothes = ["U_C_Poloshirt_blue","U_C_Poloshirt_burgundy","U_C_Poloshirt_stripped",
		"U_C_Poloshirt_tricolour","U_C_Poloshirt_salmon","U_C_Poloshirt_redwhite","U_OrestesBody"] call BIS_fnc_selectRandom;
		//_starterHat = ["","","",""]
		switch (playerSide) do {
				case west: {
				if (_myLvl >=1) then {
				player forceAddUniform _starterClothes;
				player addVest "V_Rangemaster_belt";
				{player removeWeapon _x} forEach weapons player;
				{player removeMagazine _x} forEach magazines player;
				//Add new weapons
				player addMagazine '30Rnd_9x21_Mag_SMG_02_Tracer_Red';
				player addWeapon 'SMG_05_F';
				player addMagazines ['30Rnd_9x21_Mag_SMG_02_Tracer_Red', 3];
				player addMagazine '30Rnd_9x21_Mag';
				player addWeapon 'hgun_P07_khk_F';
				player addMagazines ['16Rnd_9x21_Mag', 2];
				player addItem "FirstAidKit";
				player addPrimaryWeaponItem 'optic_ACO';
				player addItem "itemGPS";
				player assignItem "itemGPS";
				};
				if (_myLvl >=5) then {
				player addeventhandler ["HandleDamage",{(_this select 2) / 10;} ];
				player forceAddUniform "U_B_T_Soldier_AR_F";
				player addHeadGear "H_HelmetB_Light_tna_F";
				player addBackpack "B_AssaultPack_tna_F";
				{player removeWeapon _x} forEach weapons player;
				{player removeMagazine _x} forEach magazines player;
				//Add new weapons
				player addMagazine '30Rnd_556x45_Stanag_Tracer_Red';
				player addWeapon 'arifle_SPAR_01_blk_F';
				player addMagazines ['30Rnd_556x45_Stanag_Tracer_Red', 3];
				player addMagazine '30Rnd_9x21_Mag';
				player addWeapon 'hgun_P07_khk_F';
				player addMagazines ['16Rnd_9x21_Mag', 2];
				player addPrimaryWeaponItem 'optic_ACO';
				player addItem "FirstAidKit";
				player addItem "FirstAidKit";
				player addMagazines ['HandGrenade', 4];
				player addMagazines ['30Rnd_556x45_Stanag_Tracer_Red', 4];
				player addItem "FirstAidKit";
				
				};
				if (_myLvl >=10) then {
				removeVest player;
				player addVest "V_TacChestrig_oli_F";
				
				};
				if (_myLvl >=15) then {
				removeHeadgear player;
				player addHeadgear "H_HelmetB_tna_F";
				player addMagazine 'HandGrenade';				
				};
				if (_myLvl >=20) then {
				removeVest player;
				player addVest "V_TacVest_oli";
				player forceAddUniform "U_B_T_Soldier_F";
				{player removeWeapon _x} forEach weapons player;
				{player removeMagazine _x} forEach magazines player;
				//Add new weapons
				player addMagazines ['HandGrenade', 5];
				player addMagazine '30Rnd_65x39_caseless_mag';
				player addWeapon 'arifle_MX_khk_F';
				player addPrimaryWeaponItem 'optic_ERCO_khk_F';
				player addMagazines ['30Rnd_65x39_caseless_mag', 6];
				player addMagazine '30Rnd_9x21_Mag';
				player addWeapon 'hgun_P07_khk_F';
				player addMagazines ['16Rnd_9x21_Mag', 2];
				player addItem "FirstAidKit";
				player addItem "FirstAidKit";
				player addItem "FirstAidKit";
				player addItem "FirstAidKit";
				};
				if (_myLvl >=25) then {
				removeVest player;
				player addVest "V_PlateCarrier1_tna_F";
				player addMagazines ['30Rnd_65x39_caseless_mag', 4];
				player addMagazines ['16Rnd_9x21_Mag', 2];
				player addItem "FirstAidKit";
				player addItem "FirstAidKit";
				player addItem "FirstAidKit";
				player addItem "FirstAidKit";
				};
				if (_myLvl >=30) then {
				removeVest player;
				player addVest "V_PlateCarrier2_tna_F";
				player addMagazines ['30Rnd_65x39_caseless_mag', 4];
				player addMagazines ['16Rnd_9x21_Mag', 2];
				player addItem "FirstAidKit";
				player addItem "FirstAidKit";
				player addItem "FirstAidKit";
				player addItem "FirstAidKit";
				};
				if (_myLvl >=35) then {
				removeVest player;
				player addVest "Vest_V_PlateCarrierSpec_tna_F";
				player addMagazines ['30Rnd_65x39_caseless_mag', 4];
				player addMagazines ['16Rnd_9x21_Mag', 2];
				player addItem "FirstAidKit";
				player addItem "FirstAidKit";
				player addItem "FirstAidKit";
				player addItem "FirstAidKit";
				};
				if (_myLvl >=40) then {
				removeVest player;
				player addVest "V_PlateCarrierGL_tna_F";
				player addMagazines ['30Rnd_65x39_caseless_mag', 4];
				player addMagazines ['16Rnd_9x21_Mag', 2];
				player addItem "FirstAidKit";
				player addItem "FirstAidKit";
				player addItem "FirstAidKit";
				player addItem "FirstAidKit";
				};
				if (_myLvl >=45) then {
				removeVest player;
				player addVest "V_PlateCarrierIAGL_oli";
				player addMagazines ['30Rnd_65x39_caseless_mag', 4];
				player addMagazines ['16Rnd_9x21_Mag', 2];
				player addItem "FirstAidKit";
				player addItem "FirstAidKit";
				player addItem "FirstAidKit";
				player addItem "FirstAidKit";
				};
			};


		case east: {
				
				if (_myLvl >=1) then {
				player forceAddUniform _starterClothes;
				player addVest "V_Rangemaster_belt";
				{player removeWeapon _x} forEach weapons player;
				{player removeMagazine _x} forEach magazines player;
				//Add new weapons
				player addMagazine '30Rnd_9x21_Mag_SMG_02_Tracer_Red';
				player addWeapon 'SMG_05_F';
				player addMagazines ['30Rnd_9x21_Mag_SMG_02_Tracer_Red', 3];
				player addMagazine '30Rnd_9x21_Mag';
				player addWeapon 'hgun_Rook40_F';
				player addMagazines ['16Rnd_9x21_Mag', 2];
				player addPrimaryWeaponItem 'optic_ACO';
				player addItem "itemGPS";
				player assignItem "itemGPS";
				};
				if (_myLvl >=5) then {
				player forceAddUniform "U_O_T_Soldier_F";
				player addHeadGear "H_CrewHelmetHeli_O";
				player addBackpack "B_FieldPack_ghex_F";
				{player removeWeapon _x} forEach weapons player;
				{player removeMagazine _x} forEach magazines player;
				//Add new weapons
				player addMagazine '30Rnd_580x42_Mag_F';
				player addWeapon 'arifle_CTAR_blk_F';
				player addMagazines ['30Rnd_580x42_Mag_F', 3];
				player addMagazine '30Rnd_9x21_Mag';
				player addWeapon 'hgun_Rook40_F';
				player addMagazines ['16Rnd_9x21_Mag', 2];
				player addPrimaryWeaponItem 'optic_ACO';
				player addItem "FirstAidKit";
				player addItem "FirstAidKit";
				player addMagazines ['HandGrenade', 4];
				player addMagazines ['30Rnd_580x42_Mag_F', 4];
				};
				if (_myLvl >=10) then {
				removeVest player;
				player addVest "V_HarnessO_ghex_F";
				
				};
				if (_myLvl >=15) then {
				removeHeadgear player;
				player addHeadgear "H_HelmetO_ghex_F";
				player addMagazine 'HandGrenade';
				player addBackpack "B_FieldPack_ghex_F";				
				};
				if (_myLvl >=20) then {
				removeVest player;
				player addVest "V_TacVest_oli";
				{player removeWeapon _x} forEach weapons player;
				{player removeMagazine _x} forEach magazines player;
				//Add new weapons
				player addMagazines ['HandGrenade', 5];
				player addMagazine '30Rnd_65x39_caseless_green';
				player addWeapon 'arifle_ARX_ghex_F';
				player addPrimaryWeaponItem 'optic_ARCO_ghex_F';
				player addMagazines ['30Rnd_65x39_caseless_green', 6];
				player addMagazine '30Rnd_9x21_Mag';
				player addWeapon 'hgun_Rook40_F';
				player addMagazines ['16Rnd_9x21_Mag', 2];
				player addItem "FirstAidKit";
				player addItem "FirstAidKit";
				player addItem "FirstAidKit";
				player addItem "FirstAidKit";
				};
				if (_myLvl >=25) then {
				removeVest player;
				player addVest "V_PlateCarrier1_rgr_noflag_F";
				player addMagazines ['30Rnd_65x39_caseless_green', 4];
				player addMagazines ['16Rnd_9x21_Mag', 2];
				player addItem "FirstAidKit";
				player addItem "FirstAidKit";
				player addItem "FirstAidKit";
				player addItem "FirstAidKit";
				};
				if (_myLvl >=30) then {
				removeVest player;
				player addVest "V_PlateCarrier2_rgr_noflag_F";
				player addMagazines ['30Rnd_65x39_caseless_green', 4];
				player addMagazines ['16Rnd_9x21_Mag', 2];
				player addItem "FirstAidKit";
				player addItem "FirstAidKit";
				player addItem "FirstAidKit";
				player addItem "FirstAidKit";
				};
				if (_myLvl >=35) then {
				removeVest player;
				player addVest "V_PlateCarrierSpec_rgr";
				player addMagazines ['30Rnd_65x39_caseless_green', 4];
				player addMagazines ['16Rnd_9x21_Mag', 2];
				player addItem "FirstAidKit";
				player addItem "FirstAidKit";
				player addItem "FirstAidKit";
				player addItem "FirstAidKit";
				};
				if (_myLvl >=40) then {
				removeVest player;
				player addVest "V_PlateCarrierGL_rgr";
				player addMagazines ['30Rnd_65x39_caseless_green', 4];
				player addMagazines ['16Rnd_9x21_Mag', 2];
				player addItem "FirstAidKit";
				player addItem "FirstAidKit";
				player addItem "FirstAidKit";
				player addItem "FirstAidKit";
				};
				if (_myLvl >=45) then {
				removeVest player;
				player addVest "V_PlateCarrierIAGL_dgtl";
				player addMagazines ['30Rnd_65x39_caseless_green', 4];
				player addMagazines ['16Rnd_9x21_Mag', 2];
				player addItem "FirstAidKit";
				player addItem "FirstAidKit";
				player addItem "FirstAidKit";
				player addItem "FirstAidKit";
				};
		};
	};
};

//Show Markers over friendlies
neb_fnc_core_playerMarkers = { 
				if (isDedicated) exitWith {}; // is server  
if (!isNil{aero_player_markers_pos}) exitWith {}; // already running
				   
private ["_marker","_markerText","_temp","_unit","_vehicle","_markerNumber","_show","_injured","_text","_num","_getNextMarker","_getMarkerColor","_showAllSides","_showPlayers","_showAIs","_l"];

_showAllSides=false;
_showPlayers=false;
_showAIs=false;

if(count _this==0) then {
	_showAllSides=false;
	_showPlayers=true;
	_showAIs=!isMultiplayer;
};
                         
{
	_l=toLower _x;
	if(_l in ["player","players"]) then {
		_showPlayers=true;
	};
	if(_l in ["ai","ais"]) then {
		_showAIs=true;
	};
	if(_l in ["allside","allsides"]) then {
		_showAllSides=true;
	};
} forEach _this;

aero_player_markers_pos = [0,0];
onMapSingleClick "aero_player_markers_pos=_pos;";

_getNextMarker = {
	private ["_marker"]; 
	_markerNumber = _markerNumber + 1;
	_marker = format["um%1",_markerNumber];	
	if(getMarkerType _marker == "") then {
		createMarkerLocal [_marker, _this];
	} else {
		_marker setMarkerPosLocal _this;
	};
	_marker;
};

_getMarkerColor = {	
	[(((side _this) call bis_fnc_sideID) call bis_fnc_sideType),true] call bis_fnc_sidecolor;
};

while {true} do {
	  
	waitUntil {
		sleep 0.025;
		true;
	};
	
	_markerNumber = 0; 
	
	// show players or player's vehicles
	{
		_show = false;
		_injured = false;
		_unit = _x;
		
		if(
			(
				(_showAIs && {!isPlayer _unit} && {0=={ {_x==_unit} count crew _x>0} count allUnitsUav}) ||
				(_showPlayers && {isPlayer _unit})
			) && {
				_showAllSides || side _unit==side player
			}
		) then {	
			if((crew vehicle _unit) select 0 == _unit) then {
				_show = true;
			};		
			if(!alive _unit || damage _unit > 0.9) then {
				_injured = true;
			};	  
			if(!isNil {_unit getVariable "hide"}) then {
				_show = false;
			};  
			if(_unit getVariable ["BTC_need_revive",-1] == 1) then {
				_injured = true;
				_show = false;
			};		  
			if(_unit getVariable ["NORRN_unconscious",false]) then {
				_injured = true;
			};	  			
		};
			  	 
		if(_show) then {
			_vehicle = vehicle _unit;  				  	
			_pos = getPosATL _vehicle;		  					
			_color = _unit call _getMarkerColor;  

			_markerText = _pos call _getNextMarker;						
			_markerText setMarkerColorLocal _color;	 						 				
 			_markerText setMarkerTypeLocal "c_unknown";		  			   
			_markerText setMarkerSizeLocal [0.8,0];

			_marker = _pos call _getNextMarker;			
			_marker setMarkerColorLocal _color;
			_marker setMarkerDirLocal getDir _vehicle;
			_marker setMarkerTypeLocal "mil_triangle";
			_marker setMarkerTextLocal "";	
			_playerLevel = _x getVariable [ "level", 0 ];
			if(_vehicle == vehicle player) then {
				_marker setMarkerSizeLocal [0.8,1];
			} else {
				_marker setMarkerSizeLocal [0.5,0.7];
			};
			
 			if(_vehicle != _unit && !(_vehicle isKindOf "ParachuteBase")) then {			 						
				_text = format["[%1]", getText(configFile>>"CfgVehicles">>typeOf _vehicle>>"DisplayName")];
				if(!isNull driver _vehicle) then {
					_text = format["%1 %2 %3", name driver _vehicle, _text, _playerLevel];	
				};							 						
				
				if((aero_player_markers_pos distance getPosATL _vehicle) < 50) then {
					aero_player_markers_pos = getPosATL _vehicle;
					_num = 0;
					{
						if(alive _x && isPlayer _x && _x != driver _vehicle) then {						
							_text = format["%1%2 %3 %4", _text, if(_num>0)then{","}else{""}, name _x, _playerLevel];
							_num = _num + 1;
						};						
					} forEach crew _vehicle; 
				} else { 
					_num = {alive _x && isPlayer _x && _x != driver _vehicle} count crew _vehicle;
					if (_num>0) then {					
						if (isNull driver _vehicle) then {
							_text = format["%1 %2 %3", _text, name (crew _vehicle select 0), _playerLevel];
							_num = _num - 1;
						};
						if (_num>0) then {
							_text = format["%1 +%2", _text, _num];
						};
					};
				};	 					
			} else {
				_text = name _x;			
			};
			_markerText setMarkerTextLocal _text;
		};
		
	} forEach allUnits;


	// show player controlled uavs
	{
		if(isUavConnected _x) then {	
			_unit=(uavControl _x) select 0;
			if(
				(				
					(_showAIs && {!isPlayer _unit}) || 
					(_showPlayers && {isPlayer _unit})
				) && {
					_showAllSides || side _unit==side player
				}
			) then {
				_color = _x call _getMarkerColor;								  										  				
				_pos = getPosATL _x;
				
				_marker = _pos call _getNextMarker;			
				_marker setMarkerColorLocal _color;
				_marker setMarkerDirLocal getDir _x;
				_marker setMarkerTypeLocal "mil_triangle";			
				_marker setMarkerTextLocal "";
				if(_unit == player) then {
					_marker setMarkerSizeLocal [0.8,1];
				} else {
					_marker setMarkerSizeLocal [0.5,0.7];
				};
									  		
				_markerText = _pos call _getNextMarker;	
				_markerText setMarkerColorLocal _color;	   
				_markerText setMarkerTypeLocal "c_unknown";
				_markerText setMarkerSizeLocal [0.8,0];
				_markerText setMarkerTextLocal format["%1 [%2]", name _unit, getText(configFile>>"CfgVehicles">>typeOf _x>>"DisplayName")];	
			};
		};
	} forEach allUnitsUav; 
	
	
	

	_markerNumber = _markerNumber + 1;
	_marker = format["um%1",_markerNumber];	
	while {(getMarkerType _marker) != ""} do {
		deleteMarkerLocal _marker;
		_markerNumber = _markerNumber + 1;
		_marker = format["um%1",_markerNumber];
		};
	 
	};
};


//Diary entry
neb_fnc_core_instructions = {
				player createDiaryRecord ["Welcome", ["Welcome to Base Wars!", "Level Up And Buy New Gear From The Shop, Capture The Enemy Coms Tower To Earn Big Points."]];
};


//Open Parachute at 100m
neb_fnc_core_openChute = {
				while {true} do {
					if ( (getPosATL player select 2 > 100) && (vehicle player IsEqualto player) && (alive player)) then {
						waitUntil {(position player select 2) <= 100};
						chute = createVehicle ['Steerable_Parachute_F', position Player, [], 0, 'FLY'];
						chute setPos position player;
						player moveIndriver chute;
						chute allowDamage false;
						};
					sleep 2;
    };
};


//Cleanup script
neb_fnc_core_repeatCleanUp = {
	if (!isServer) exitWith {}; // isn't server         

	#define PUSH(A,B) A set [count (A),B];
	#define REM(A,B) A=A-[B];

	private ["_ttdBodies","_ttdVehiclesDead","_ttdVehiclesImmobile","_ttdWeapons","_ttdPlanted","_ttdSmokes","_addToCleanup","_unit","_objectsToCleanup","_timesWhenToCleanup","_removeFromCleanup"];

	_ttdBodies=[_this,0,0,[0]] call BIS_fnc_param;
	_ttdVehiclesDead=[_this,1,0,[0]] call BIS_fnc_param;
	_ttdVehiclesImmobile=[_this,2,0,[0]] call BIS_fnc_param;
	_ttdWeapons=[_this,3,0,[0]] call BIS_fnc_param;
	_ttdPlanted=[_this,4,0,[0]] call BIS_fnc_param;
	_ttdSmokes=[_this,5,0,[0]] call BIS_fnc_param;

	if({_x>0}count _this==0) exitWith {}; // all times are 0, we do not want to run this script at all


	_objectsToCleanup=[];
	_timesWhenToCleanup=[];

	_addToCleanup = {
		_object = _this select 0;
		if(!(_object getVariable["persistent",false])) then {
			_newTime = (_this select 1)+time;
			_index = _objectsToCleanup find _object;
			if(_index == -1) then {
				PUSH(_objectsToCleanup,_object)
				PUSH(_timesWhenToCleanup,_newTime)
			} else {
				_currentTime = _timesWhenToCleanup select _index;
				if(_currentTime>_newTime) then {		
					_timesWhenToCleanup set[_index, _newTime];
				}; 
			};			   
		};
	};

	_removeFromCleanup = {
		_object = _this select 0;
		_index = _objectsToCleanup find _object;
		if(_index != -1) then {
			_objectsToCleanup set[_index, 0];
			_timesWhenToCleanup set[_index, 0]; 
		};			   
	};


	while{true} do {

		sleep 10;
			
		{	
			_unit = _x;
			
			if (_ttdWeapons>0) then {
				{
					{ 	 
						[_x, _ttdWeapons] call _addToCleanup;			
					} forEach (getpos _unit nearObjects [_x, 100]);
				} forEach ["WeaponHolder","GroundWeaponHolder","WeaponHolderSimulated"];
			};
			
			if (_ttdPlanted>0) then {
				{
					{ 
						[_x, _ttdPlanted] call _addToCleanup;  
					} forEach (getpos _unit nearObjects [_x, 100]);
				} forEach ["TimeBombCore"];
			};
			
			if (_ttdSmokes>0) then {
				{
					{ 	 
						[_x, _ttdSmokes] call _addToCleanup; 
					} forEach (getpos _unit nearObjects [_x, 100]);
				} forEach ["SmokeShell"];
			};
		
		} forEach allUnits;
		
		{
			if (_x getVariable [ "cleanup", true ] && (count units _x)==0) then {
			deleteGroup _x;
			};
		} forEach allGroups;
		
		if (_ttdBodies>0) then {
			{
				[_x, _ttdBodies] call _addToCleanup;
			} forEach allDeadMen;
		};	
		
		if (_ttdVehiclesDead>0) then {		
			{
				if(_x == vehicle _x) then { // make sure its vehicle 	 
					[_x, _ttdVehiclesDead] call _addToCleanup;
				}; 
			} forEach (allDead - allDeadMen); // all dead without dead men == mostly dead vehicles
		};
		
		if (_ttdVehiclesImmobile>0) then {		
			{
				if(!canMove _x && {alive _x}count crew _x==0) then { 	 
					[_x, _ttdVehiclesImmobile] call _addToCleanup;
				} else {
					[_x] call _removeFromCleanup;
				}; 
			} forEach vehicles;
		};

							
		REM(_objectsToCleanup,0)
		REM(_timesWhenToCleanup,0)

		{        
			if(isNull(_x)) then {
				_objectsToCleanup set[_forEachIndex, 0];
				_timesWhenToCleanup set[_forEachIndex, 0];
			} else {
				if(_timesWhenToCleanup select _forEachIndex < time) then {
					deleteVehicle _x;
					_objectsToCleanup set[_forEachIndex, 0];
					_timesWhenToCleanup set[_forEachIndex, 0];			 	
				};
			};	
		} forEach _objectsToCleanup;
		
		REM(_objectsToCleanup,0)
		REM(_timesWhenToCleanup,0)
				
	};
};


//Set Side Relations
neb_fnc_core_setRelations = {
				EAST setFriend [CIVILIAN,1];
				WEST setFriend [CIVILIAN,1];
				CIVILIAN setFriend [WEST,1];
				CIVILIAN setFriend [EAST,1];
				RESISTANCE setFriend [WEST,0];
				RESISTANCE setFriend [EAST,0];
				WEST setFriend [RESISTANCE,0];
				EAST setFriend [RESISTANCE,0];
};


//Lightning Ability
neb_fnc_core_strikeLightning = {
				private ["_strikeTarget","_dummy"];
				_strikeTarget = cursorObject;
				_strikeLoc =  (getPos _strikeTarget);
				_validObject = nearestObject _strikeLoc;
				if (_strikeLoc isequalto [0,0,0]) then {
				[_validObject,nil,true] call BIS_fnc_moduleLightning;
				}else{

				[_strikeTarget,nil,true] call BIS_fnc_moduleLightning;

				hint "";
					};
};

//Sign Texture loading
neb_fnc_core_signTextures = {
				vehStoreSign1 setdir getdir(vehStoreSign1);
				vehStoreSign1 SetObjectTextureGlobal [0,"images\storesignA.jpg"];
				vehStoreSign1 attachTo [vehStoreSign1,[0,-.1,0.6]];

				vehMenuBluSpawn setdir getdir(vehMenuBluSpawn);
				vehMenuBluSpawn SetObjectTextureGlobal [0,"images\computerscreenA.jpg"];
				vehMenuBluSpawn attachTo [vehMenuBluSpawn,[0,-.1,0.6]];

				MenuBlu setdir getdir(MenuBlu);
				MenuBlu SetObjectTextureGlobal [0,"images\computerscreenA.jpg"];
				MenuBlu attachTo [MenuBlu,[0,-.1,0.6]];
};

/*Blu Vehicle Spawns*/

//Prowler 1 spawn
neb_fnc_core_bluVehicleSpawnA = {
//BLULSV1
	if (isServer) then {
			disableSerialization;
			private["_position","_direction","_nearestTargets","_scanArea"];
			while{true} do{
	//Check if the marker has any cars near it
			_position = getMarkerPos "LSVB1";
			_scanArea = 5;
			_direction = 125;
			_nearestTargets = nearestObjects[_position,["landVehicle","Air","Ship"],_scanArea] select 0;
	//if the marker has no cars near it then spawn the new car with nothing in inventory
	if (!isNil "_nearestTargets") then {
				sleep 20;
			}else{
					
					_veh = createVehicle ["B_T_LSV_01_unarmed_F", _position, [], 0, "NONE"];
					_veh setVariable ["BIS_enableRandomization", false];
					_veh setDir _direction;
					clearWeaponCargoGlobal _veh;
					clearMagazineCargoGlobal _veh;
					clearItemCargoGlobal _veh;
					_veh setVehicleVarName "BluLSV1";
					BluLSV1 = _veh;
					[BluLSV1] call neb_fnc_addBounty;
					waitUntil {!alive BluLSV1};
					sleep .5;
					BluLSV1 = nil;
					sleep 10;
				};
			};
		};
};

//Prowler 2 Spawn
neb_fnc_core_bluVehicleSpawnB = {
//BLULSV2
	if (isServer) then {
			disableSerialization;
			private["_position","_direction","_nearestTargets","_scanArea"];
			while{true} do{
	//Check if the marker has any cars near it
			_position = getMarkerPos "LSVB2";
			_scanArea = 5;
			_direction = 200;
			_nearestTargets = nearestObjects[_position,["landVehicle","Air","Ship"],12] select 0;
	//if the marker has no cars near it then spawn the new car with nothing in inventory
	if (!isNil "_nearestTargets") then {
				sleep 20;
			}else{
					
					_veh = createVehicle ["B_T_LSV_01_unarmed_F", _position, [], 0, "NONE"];
					_veh setVariable ["BIS_enableRandomization", false];
					_veh setDir _direction;
					clearWeaponCargoGlobal _veh;
					clearMagazineCargoGlobal _veh;
					clearItemCargoGlobal _veh;
					_veh setVehicleVarName "BluLSV2";
					BluLSV2 = _veh;
					[BluLSV2] call neb_fnc_addBounty;
					waitUntil {!alive BluLSV2};
					sleep .5;
					BluLSV3 = nil;
					sleep 10;
			};
		};
	};
};
//Prowler 3 Spawn
neb_fnc_core_bluVehicleSpawnC = {
//BLULSV2
	if (isServer) then {
			disableSerialization;
			private["_position","_direction","_nearestTargets","_scanArea"];
			while{true} do{
	//Check if the marker has any cars near it
			_position = getMarkerPos "LSVB3";
			_scanArea = 5;
			_direction = 200;
			_nearestTargets = nearestObjects[_position,["landVehicle","Air","Ship"],12] select 0;
	//if the marker has no cars near it then spawn the new car with nothing in inventory
	if (!isNil "_nearestTargets") then {
				sleep 20;
			}else{
					
					_veh = createVehicle ["B_T_LSV_01_unarmed_F", _position, [], 0, "NONE"];
					_veh setVariable ["BIS_enableRandomization", false];
					_veh setDir _direction;
					clearWeaponCargoGlobal _veh;
					clearMagazineCargoGlobal _veh;
					clearItemCargoGlobal _veh;
					_veh setVehicleVarName "BluLSV3";
					BluLSV3 = _veh;
					[BluLSV3] call neb_fnc_addBounty;
					waitUntil {!alive BluLSV3};
					sleep .5;
					BluLSV3 = nil;
					sleep 10;
			};
		};
	};
};

//BLU SPAWN TRUCK
neb_fnc_core_bluSpawnTruck = {
	while {true} do {
					
					_direction = 120;
					_position = getMarkerPos "BluTruckSpawn";
					_mrk = "BluTruckSpawn";
					_veh = createVehicle ["B_T_Truck_01_box_F", _position, [], 0, "NONE"];
					_veh setVariable ["BIS_enableRandomization", false];
					_veh setDir _direction;
					clearWeaponCargoGlobal _veh;
					clearMagazineCargoGlobal _veh;
					clearItemCargoGlobal _veh;
					_veh setVehicleVarName "BluSpawnTruck";
					missionNamespace setVariable [ "BluSpawnTruck", _veh, true ];
					[BluSpawnTruck] call neb_fnc_addBounty;
					if (isNil "BluActionSpawnTruckCheck") then {
					[ BluTeleScreen, "BluSpawnTruck" ] remoteExec ["neb_fnc_core_teleToTruck", 0, "BluTruckJIP" ];
					BluActionSpawnTruckCheck = true;
					};
					
					//Create trigger for shop
					_trigger = createTrigger[ "EmptyDetector", getMarkerPos _mrk, true ];
					//Set trigger size on all clients and JIP
					[ _trigger, [ 5, 5, 0, false, 5 ] ] remoteExec [ "setTriggerArea", 0, true ];
					//Attach it to the vehicle
					_trigger attachTo [ BluSpawnTruck, [0,0,0] ];

					//Call shopInit on server and all clients and JIP
					_JIP = [ _trigger, "Blu Mobile FOB", "ALL", true, true ] remoteExec [ "NEB_fnc_shopInit", 0, true ];
					_JIP = [ _trigger, "Blu Mobile FOB", "ALL", true, true ] remoteExec [ "NEB_fnc_shopInit", 2 ];
					
					
					waitUntil {!alive BluSpawnTruck};
					sleep 10;
		};
	
};

//Quilin 1 spawn
neb_fnc_core_redVehicleSpawnA = {
//REDLSV1
		disableSerialization;
		private["_position","_direction","_nearestTargets","_scanArea"];
	while{true} do{
	//Check if the marker has any cars near it
		_position = getMarkerPos "LSVR1";
		_scanArea = 5;
		_direction = 110;
		_nearestTargets = nearestObjects[_position,["landVehicle","Air","Ship"],_scanArea] select 0;
	//if the marker has no cars near it then spawn the new car with nothing in inventory
	if (!isNil "_nearestTargets") then {
			sleep 20;
		}else{
				_veh = createVehicle ["O_T_LSV_02_unarmed_F", _position, [], 0, "NONE"];
				_veh setVariable ["BIS_enableRandomization", false];
				_veh setDir _direction;
				_veh setPos _position;
				clearWeaponCargoGlobal _veh;
				clearMagazineCargoGlobal _veh;
				clearItemCargoGlobal _veh;
				_veh setVehicleVarName "RedLSV1";
				RedLSV1 = _veh;
				[RedLSV1] call neb_fnc_addBounty;
				waitUntil {!alive RedLSV1};
				sleep .5;
				RedLSV1 = nil;
				sleep 10;
		};
	};
};

//Quilin 2 Spawn
neb_fnc_core_redVehicleSpawnB = {


		disableSerialization;
		private["_position","_direction","_nearestTargets","_scanArea"];
	while{true} do{
	//Check if the marker has any cars near it
		_position = getMarkerPos "LSVR2";
		_scanArea = 5;
		_direction = 345;
		_nearestTargets = nearestObjects[_position,["landVehicle","Air","Ship"],_scanArea] select 0;
	//if the marker has no cars near it then spawn the new car with nothing in inventory
	if (!isNil "_nearestTargets") then {
			sleep 20;
		}else{
				_veh = createVehicle ["O_T_LSV_02_unarmed_F", _position, [], 0, "NONE"];
				_veh setVariable ["BIS_enableRandomization", false];
				_veh setDir _direction;
				_veh setPos _position;
				clearWeaponCargoGlobal _veh;
				clearMagazineCargoGlobal _veh;
				clearItemCargoGlobal _veh;
				_veh setVehicleVarName "RedLSV2";
				RedLSV2 = _veh;
				[RedLSV2] call neb_fnc_addBounty;
				waitUntil {!alive RedLSV2};
				sleep .5;
				RedLSV2 = nil;
				sleep 10;
		};
	};
};
//Quilin 3 Spawn
neb_fnc_core_redVehicleSpawnC = {

	
		disableSerialization;
		private["_position","_direction","_nearestTargets","_scanArea"];
	while{true} do{
	//Check if the marker has any cars near it
		_position = getMarkerPos "LSVR3";
		_scanArea = 5;
		_direction = 300;
		_nearestTargets = nearestObjects[_position,["landVehicle","Air","Ship"],_scanArea] select 0;
	//if the marker has no cars near it then spawn the new car with nothing in inventory
	if (!isNil "_nearestTargets") then {
			sleep 20;
		}else{
				_veh = createVehicle ["O_T_LSV_02_unarmed_F", _position, [], 0, "NONE"];
				_veh setVariable ["BIS_enableRandomization", false];
				_veh setDir _direction;
				_veh setPos _position;
				clearWeaponCargoGlobal _veh;
				clearMagazineCargoGlobal _veh;
				clearItemCargoGlobal _veh;
				_veh setVehicleVarName "RedLSV3";
				RedLSV3 = _veh;
				[RedLSV3] call neb_fnc_addBounty;
				waitUntil {!alive RedLSV3};
				sleep .5;
				RedLSV3 = nil;
				sleep 10;
		};
	};
};

//RED SPAWN TRUCK
neb_fnc_core_redSpawnTruck = {
	
	while {true} do {
					
					_direction = 300;
					_position = getMarkerPos "RedTruckSpawn";
					_mrk = "RedTruckSpawn";
					_veh = createVehicle ["O_T_Truck_03_device_ghex_F", _position, [], 0, "NONE"];
					_veh setVariable ["BIS_enableRandomization", false];
					_veh setDir _direction;
					clearWeaponCargoGlobal _veh;
					clearMagazineCargoGlobal _veh;
					clearItemCargoGlobal _veh;
					_veh setVehicleVarName "RedSpawnTruck";
					missionNamespace setVariable [ "RedSpawnTruck", _veh, true ];
					[RedSpawnTruck] call neb_fnc_addBounty;
					if (isNil "RedActionSpawnTruckCheck") then {
					[ RedTeleScreen, "RedSpawnTruck" ] remoteExec ["neb_fnc_core_teleToTruck", 0, "RedTruckJIP" ];
					RedActionSpawnTruckCheck = true;
					};
					//Create trigger for shop
					_trigger = createTrigger[ "EmptyDetector", getMarkerPos _mrk, true ];
					//Set trigger size on all clients and JIP
					[ _trigger, [ 5, 5, 0, false, 5 ] ] remoteExec [ "setTriggerArea", 0, true ];
					//Attach it to the vehicle
					_trigger attachTo [ RedSpawnTruck, [0,0,0] ];

					//Call shopInit on server and all clients and JIP
					[ _trigger, "Red Mobile FOB", "ALL", true, true ] remoteExec [ "NEB_fnc_shopInit", 0, true ];
					[ _trigger, "Red Mobile FOB", "ALL", true, true ] remoteExec [ "NEB_fnc_shopInit", 2 ];
					waitUntil {!alive RedSpawnTruck};
					sleep .5;
					RedSpawnTruck = nil;
					sleep 10;
	};
};
/*Random Vehicles*/

//Merc Camp Vehicle
neb_fnc_core_randomVehicleSpawnA = {

	while{true} do{
		if (isServer) then {
			disableSerialization;
			private["_position","_direction","_nearestTargets","_scanArea"];
	
	//Check if the marker has any cars near it
			_position = getMarkerPos "LSVM1";
			_scanArea = 5;
			_direction = 125;
			_nearestTargets = nearestObjects[_position,["landVehicle","Air","Ship"],_scanArea] select 0;
	//if the marker has no cars near it then spawn the new car with nothing in inventory
	if (!isNil "_nearestTargets") then {
				sleep 20;
			}else{
					_choices = ["C_Offroad_02_unarmed_F","O_T_LSV_02_unarmed_F","B_T_LSV_01_unarmed_F",
					"B_T_LSV_01_armed_F","O_T_LSV_02_armed_F","B_G_Offroad_01_armed_F","I_G_Offroad_01_armed_F","O_G_Offroad_01_armed_F"] call BIS_fnc_selectRandom;
					_veh = createVehicle [_choices, _position, [], 0, "FLY"];
					_veh setVariable ["BIS_enableRandomization", false];
					_veh setDir _direction;
					_veh setPos [2914.5,12625.5,5];
					clearWeaponCargoGlobal _veh;
					clearMagazineCargoGlobal _veh;
					clearItemCargoGlobal _veh;
					_veh setVehicleVarName "MercLSV1";
					MercLSV1 = _veh;
					[MercLSV1] call neb_fnc_addBounty;
	//Respawn Vehicle If It Dies
					waitUntil {!alive MercLSV1};
					sleep .5;
					MercLSV1 = nil;
					sleep 10;
					
			};
		};
	};
};

//Jungle 1 Vehicle 1
neb_fnc_core_randomVehicleSpawnB = {

	while{true} do{
		if (isServer) then {
			disableSerialization;
			private["_position","_direction","_nearestTargets","_scanArea"];
	
	//Check if the marker has any cars near it
			_position = getMarkerPos "LSVJ1V1";
			_scanArea = 5;
			_direction = 270;
			_nearestTargets = nearestObjects[_position,["landVehicle","Air","Ship"],_scanArea] select 0;
	//if the marker has no cars near it then spawn the new car with nothing in inventory
	if (!isNil "_nearestTargets") then {
				sleep 20;
			}else{
					_choices = ["C_Offroad_02_unarmed_F","O_T_LSV_02_unarmed_F","B_T_LSV_01_unarmed_F",
					"B_T_LSV_01_armed_F","O_T_LSV_02_armed_F","B_G_Offroad_01_armed_F","I_G_Offroad_01_armed_F","O_G_Offroad_01_armed_F"] call BIS_fnc_selectRandom;
					_veh = createVehicle [_choices, _position, [], 0, "NONE"];
					_veh setVariable ["BIS_enableRandomization", false];
					_veh setDir _direction;
					clearWeaponCargoGlobal _veh;
					clearMagazineCargoGlobal _veh;
					clearItemCargoGlobal _veh;
					_veh setVehicleVarName "J1LSV1";
					J1LSV1 = _veh;
					[J1LSV1] call neb_fnc_addBounty;
	//Respawn Vehicle If It Dies
					waitUntil {!alive J1LSV1};
					sleep .5;
					J1LSV1 = nil;
					sleep 10;
					
			};
		};
	};
};


//Jungle 2 Vehicle 1
neb_fnc_core_randomVehicleSpawnC = {
			
	while{true} do{
		if (isServer) then {
			disableSerialization;
			private["_position","_direction","_nearestTargets","_scanArea"];
	
	//Check if the marker has any cars near it
			_position = getMarkerPos "LSVJ2V1";
			_scanArea = 5;
			_direction = 60;
			_nearestTargets = nearestObjects[_position,["landVehicle","Air","Ship"],_scanArea] select 0;
	//if the marker has no cars near it then spawn the new car with nothing in inventory
	if (!isNil "_nearestTargets") then {
				sleep 20;
			}else{
					_choices = ["C_Offroad_02_unarmed_F","O_T_LSV_02_unarmed_F","B_T_LSV_01_unarmed_F",
					"B_T_LSV_01_armed_F","O_T_LSV_02_armed_F","B_G_Offroad_01_armed_F","I_G_Offroad_01_armed_F","O_G_Offroad_01_armed_F"] call BIS_fnc_selectRandom;
					_veh = createVehicle [_choices, _position, [], 0, "NONE"];
					_veh setVariable ["BIS_enableRandomization", false];
					_veh setDir _direction;
					clearWeaponCargoGlobal _veh;
					clearMagazineCargoGlobal _veh;
					clearItemCargoGlobal _veh;
					_veh setVehicleVarName "J2LSV1";
					J2LSV1 = _veh;
					[J2LSV1] call neb_fnc_addBounty;
	//Respawn Vehicle If It Dies
					waitUntil {!alive J2LSV1};
					sleep .5;
					J2LSV1 = nil;
					sleep 10;
					
			};
		};
	};
};

//Random Spawn 1
neb_fnc_core_randomVehicleSpawnD = {

	while{true} do{
		if (isServer) then {
			disableSerialization;
			private["_position","_direction","_nearestTargets","_scanArea"];
	
	//Check if the marker has any cars near it
			_positionA = getMarkerPos "RandomVMA1";
			_positionB = getMarkerPos "RandomVMA2";
			_positionC = getMarkerPos "RandomVMA3";
			_positionD = getMarkerPos "RandomVMA4";
			_rPosition = [_positionA, _positionB, _positionC, _positionD] call BIS_fnc_selectRandom;
			_scanArea = 5;
			_direction = [60,120,30,90,50,300,210] call BIS_fnc_selectRandom;
			_nearestTargets = nearestObjects[_rPosition,["landVehicle","Air","Ship"],_scanArea] select 0;
	//if the marker has no cars near it then spawn the new car with nothing in inventory
	if (!isNil "_nearestTargets") then {
				sleep 20;
			}else{
					_choices = ["O_T_APC_Tracked_02_cannon_ghex_F","B_T_MBT_01_cannon_F","I_APC_Wheeled_03_cannon_F",
					"B_T_LSV_01_armed_F","O_T_LSV_02_armed_F","B_G_Offroad_01_armed_F","I_G_Offroad_01_armed_F","O_G_Offroad_01_armed_F"] call BIS_fnc_selectRandom;
					_veh = createVehicle [_choices, _rPosition, [], 0, "NONE"];
					_veh setVariable ["BIS_enableRandomization", false];
					_veh setDir _direction;
					clearWeaponCargoGlobal _veh;
					clearMagazineCargoGlobal _veh;
					clearItemCargoGlobal _veh;
					_veh setVehicleVarName "RandomV1";
					RandomV1 = _veh;
					[RandomV1] call neb_fnc_addBounty;
	//Respawn Vehicle If It Dies
					waitUntil {!alive RandomV1};
					sleep .5;
					RandomV1 = nil;
					sleep 10;
					
			};
		};
	};
};

//Spawn The vehicles in the functions above
neb_fnc_core_vehicleSpawns = {
[] spawn neb_fnc_core_bluVehicleSpawnA;
[] spawn neb_fnc_core_bluVehicleSpawnB;
[] spawn neb_fnc_core_bluVehicleSpawnC;
[] spawn neb_fnc_core_bluSpawnTruck;
[] spawn neb_fnc_core_redVehicleSpawnA;
[] spawn neb_fnc_core_redVehicleSpawnB;
[] spawn neb_fnc_core_redVehicleSpawnC;
[] spawn neb_fnc_core_redSpawnTruck;
[] spawn neb_fnc_core_randomVehicleSpawnA;
[] spawn neb_fnc_core_randomVehicleSpawnB;
[] spawn neb_fnc_core_randomVehicleSpawnC;
[] spawn neb_fnc_core_randomVehicleSpawnD;
};

// Add Player Icons over friendly Heads
neb_fnc_core_addPlayerIcons = {
	onEachFrame

	{

		private["_vis","_pos"];

		{

			if(player distance _x < 1000 && side _x == playerSide && _x != player) then

			{

				_vis = lineIntersects [eyePos player, eyePos _x,player, _x];

				if(!_vis) then

				{

					_pos = visiblePosition _x;

					_pos set[2,(getPosATL _x select 2) + 2.1];
					switch (playerSide) do {
						case west: {
						drawIcon3D ["\A3\ui_f\data\map\markers\flags\nato_ca.paa",[1,1,1,1],_pos,.6,.6,0,name _x,0,0.03];
						};
						case east: {
						drawIcon3D ["\A3\ui_f\data\map\markers\flags\CSAT_ca.paa",[1,1,1,1],_pos,.6,.6,0,name _x,0,0.03];
						};
					
					};
				

				};

			};

		} foreach allUnits;

	};
};

/* Creep and Jungle Spawns */

//Spawn Jungle 
neb_fnc_core_terrorSpawn = {
	params[
		//Default name, start and end to an empty string if not given
		[ "_groupName", "" ],
		[ "_start", "" ],
		[ "_end", "" ],
		[ "_groupUnits",
			//default set of units if none are passed to the script
			[
				[ "I_C_Soldier_Bandit_3_F", "A" ],
				[ "I_C_Soldier_Bandit_4_F", "B" ],
				[ "I_C_Soldier_Bandit_7_F", "C" ],
				[ "I_C_Soldier_Bandit_8_F", "D" ],
				[ "I_C_Soldier_Bandit_2_F", "E" ]
			]
		],
		//Default skills if none passed to the script
		[ "_skills",
			[
				[ "aimingAccuracy", .5 ],
				[ "aimingShake", .5 ],
				[ "aimingSpeed", .7 ],
				[ "endurance", 1 ],
				[ "spotDistance", .7 ],
				[ "spotTime", .8 ],
				[ "courage", .8 ],
				[ "reloadSpeed", 1 ],
				[ "commanding", 1 ],
				[ "general", 1 ]
			]
		]
	];

	//Catch any errors and exit the script with a global error message
	//as we can not spawn a group without a name, start or end
	if ( _groupName isEqualTo "" ) exitWith {
		//Display error globally for connected clients
		"No groupName supplied for group spawn" remoteExec [ "BIS_fnc_error", 0 ];
	};
	if ( _start isEqualTo "" ) exitWith {
		//Display error globally for connected clients
		"No start position supplied for group spawn" remoteExec [ "BIS_fnc_error", 0 ];
	};
	if ( _end isEqualTo "" ) exitWith {
		//Display error globally for connected clients
		"No end position supplied for group spawn" remoteExec [ "BIS_fnc_error", 0 ];
	};

	//Work out what we have passed as positions
	{
		private[ "_pos" ];
		//What have we passed as _start and _end
		switch( typeName _x ) do {
			//Is it a STRING which means its a marker
			case ( typeName "" ) : {
				_pos = getMarkerPos _x
			};
			//Is it an object
			case ( "OBJECT" ) : {
				_pos = getPos _x;
			};
			//Is it a location
			case ( "LOCATION" ) : {
				_pos = locationPosition _x;
			};
		};
		
		//Put position in the right variable
		//_start
		if ( _forEachIndex isEqualTo 0 ) then {
			_start = _pos;
		}else{
			//_end
			_end = _pos;
		};
		
	}forEach [ _start, _end ];


	//********
	// SPAWN Reinforcement Group
	//********

	private[ "_group", "_wp" ];
	//Setup one time group with waypoint
	_group = createGroup resistance;
	_group setvariable ["cleanup",false];
	//Use end for WP position
	_wp = _group addWaypoint [ _end, 1 ];
	_wp setWaypointType "MOVE";
	_wp setWaypointSpeed "FULL";

	//Create global variable holding reference to the group
	//global variables like TerrorSquadA are held in an area called missionNamespace
	//so setting a variable there of the value of _groupName
	//gives us the same functionality as saying
	//TerrorSquadA = createGroup resistance;
	missionNamespace setVariable[ _groupName, _group ];

	while {true} do {
		
		//Spawn units
		{
			private[ "_unit" ];
			_x params [ "_unitType", "_nameSuffix" ];
			
			//Unit ARRAY command
			//Use _start as unit spawn position
			//format["group is null - %2",isnull _group] remoteexec ["hint",0];
			_unit = _group createUnit [ _unitType, _start, [], 0, "FORM" ];
			
			//Give unit a global var name
			//Although you would think you could use the same trick here as for the Group
			//by using missionNamespace, Object varaibles are slightly different
			//and require some extra setup
			//using BIS_fnc_objectVar is by far the easiest method to do this.
			//To make things easier on ourselfs lets use the group varname eg TerrorSquadA
			//as the prefix for the units name
			[ _unit, format[ "%1_%2", _groupName, _nameSuffix ] ] call BIS_fnc_objectVar;
			
			//Set unit skills
			{
				_x params[ "_skill", "_value" ];
				_unit setSkill [ _skill, _value ];
			}forEach _skills;
			
			//Pass unit to script
			[ _unit ] call neb_fnc_addBounty;
			
			_unit spawn tlq_killTicker;
			
			//Reset their current waypoint
			//( as if the previous group had already got here
			//any new units would think this waypoint has been completed ) 
			_group setCurrentWaypoint _wp;
			
		}forEach _groupUnits;
		
		//Wait unitl they are all dead
		waitUntil {{alive _x} count units _group == 0};
		
		//debug
		//format[ "group %1 is dead", _groupName ] remoteExec [ "systemchat", 0 ];
		
		sleep 30;
	};
};
// Spawn Blu Defense Creeps
neb_fnc_core_bluDefender = {
	params[
		//Default name, start and end to an empty string if not given
		[ "_groupName", "" ],
		[ "_start", "" ],
		[ "_end", "" ],
		[ "_groupUnits",
			//default set of units if none are passed to the script
			[
				[ "B_T_Soldier_F", "A" ],
				[ "B_T_Soldier_F", "B" ],
				[ "B_T_Soldier_F", "C" ],
				[ "B_T_Soldier_AA_F", "D" ],
				[ "B_T_Soldier_AT_F", "E" ],
				[ "B_T_Soldier_F", "F" ],
				[ "B_T_Soldier_F", "G" ]
			]
		],
		//Default skills if none passed to the script
		[ "_skills",
			[
				[ "aimingAccuracy", .5 ],
				[ "aimingShake", .5 ],
				[ "aimingSpeed", .5 ],
				[ "endurance", 1 ],
				[ "spotDistance", .2 ],
				[ "spotTime", .5 ],
				[ "courage", .3 ],
				[ "reloadSpeed", 1 ],
				[ "commanding", .1 ],
				[ "general", .5 ]
			]
		]
	];

	//Catch any errors and exit the script with a global error message
	//as we can not spawn a group without a name, start or end
	if ( _groupName isEqualTo "" ) exitWith {
		//Display error globally for connected clients
		"No groupName supplied for group spawn" remoteExec [ "BIS_fnc_error", 0 ];
	};
	if ( _start isEqualTo "" ) exitWith {
		//Display error globally for connected clients
		"No start position supplied for group spawn" remoteExec [ "BIS_fnc_error", 0 ];
	};
	if ( _end isEqualTo "" ) exitWith {
		//Display error globally for connected clients
		"No end position supplied for group spawn" remoteExec [ "BIS_fnc_error", 0 ];
	};

	//Work out what we have passed as positions
	{
		private[ "_pos" ];
		//What have we passed as _start and _end
		switch( typeName _x ) do {
			//Is it a STRING which means its a marker
			case ( typeName "" ) : {
				_pos = getMarkerPos _x
			};
			//Is it an object
			case ( "OBJECT" ) : {
				_pos = getPos _x;
			};
			//Is it a location
			case ( "LOCATION" ) : {
				_pos = locationPosition _x;
			};
		};
		
		//Put position in the right variable
		//_start
		if ( _forEachIndex isEqualTo 0 ) then {
			_start = _pos;
		}else{
			//_end
			_end = _pos;
		};
		
	}forEach [ _start, _end ];


	//********
	// SPAWN Reinforcement Group
	//********

	private[ "_group", "_wp1" ];

	//Setup one time group with waypoint
	_group = createGroup west;
	//Use end for WP position
	_wp1 = _group addWaypoint [ _end, 1 ];
	_wp1 setWaypointType "LOITER";
	_wp1 setWaypointSpeed "FULL";

	//Create global variable holding reference to the group
	//global variables like TerrorSquadA are held in an area called missionNamespace
	//so setting a variable there of the value of _groupName
	//gives us the same functionality as saying
	//TerrorSquadA = createGroup resistance;
	missionNamespace setVariable[ _groupName, _group ];

	while {true} do {
		
		//Spawn units
		{
			private[ "_unit" ];
			_x params [ "_unitType", "_nameSuffix" ];
			
			//Unit ARRAY command
			//Use _start as unit spawn position
			_unit = _group createUnit [ _unitType, _start, [], 0, "FORM" ];
			
			//Give unit a global var name
			//Although you would think you could use the same trick here as for the Group
			//by using missionNamespace, Object varaibles are slightly different
			//and require some extra setup
			//using BIS_fnc_objectVar is by far the easiest method to do this.
			//To make things easier on ourselfs lets use the group varname eg TerrorSquadA
			//as the prefix for the units name
			[ _unit, format[ "%1_%2", _groupName, _nameSuffix ] ] call BIS_fnc_objectVar;
			
			//Set unit skills
			{
				_x params[ "_skill", "_value" ];
				_unit setSkill [ _skill, _value ];
			}forEach _skills;
			
			//Pass unit to script
			[ _unit ] call neb_fnc_addBounty;
			_unit spawn tlq_killTicker;
			
			//Reset their current waypoint
			//( as if the previous group had already got here
			//any new units would think this waypoint has been completed ) 
			_group setCurrentWaypoint _wp1;
			
		}forEach _groupUnits;
		
		//Wait unitl they are all dead
		waitUntil {{alive _x} count units _group == 0};
		
		//debug
		//format[ "group %1 is dead", _groupName ] remoteExec [ "systemchat", 0 ];
		
		sleep 10;
	};	
};
// Spawn Red Defense Creeps
neb_fnc_core_redDefender = {
	params[
		//Default name, start and end to an empty string if not given
		[ "_groupName", "" ],
		[ "_start", "" ],
		[ "_end", "" ],
		[ "_groupUnits",
			//default set of units if none are passed to the script
			[
				[ "O_T_Soldier_F", "A" ],
				[ "O_T_Soldier_F", "B" ],
				[ "O_T_Soldier_F", "C" ],
				[ "O_T_Soldier_AA_F", "D" ],
				[ "O_T_Soldier_AT_F", "E" ],
				[ "O_T_Soldier_F", "F" ],
				[ "O_T_Soldier_F", "G" ]
			]
		],
		//Default skills if none passed to the script
		[ "_skills",
			[
				[ "aimingAccuracy", .5 ],
				[ "aimingShake", .5 ],
				[ "aimingSpeed", .5 ],
				[ "endurance", 1 ],
				[ "spotDistance", .3 ],
				[ "spotTime", .5 ],
				[ "courage", .2 ],
				[ "reloadSpeed", 1 ],
				[ "commanding", .1 ],
				[ "general", .5 ]
			]
		]
	];

	//Catch any errors and exit the script with a global error message
	//as we can not spawn a group without a name, start or end
	if ( _groupName isEqualTo "" ) exitWith {
		//Display error globally for connected clients
		"No groupName supplied for group spawn" remoteExec [ "BIS_fnc_error", 0 ];
	};
	if ( _start isEqualTo "" ) exitWith {
		//Display error globally for connected clients
		"No start position supplied for group spawn" remoteExec [ "BIS_fnc_error", 0 ];
	};
	if ( _end isEqualTo "" ) exitWith {
		//Display error globally for connected clients
		"No end position supplied for group spawn" remoteExec [ "BIS_fnc_error", 0 ];
	};

	//Work out what we have passed as positions
	{
		private[ "_pos" ];
		//What have we passed as _start and _end
		switch( typeName _x ) do {
			//Is it a STRING which means its a marker
			case ( typeName "" ) : {
				_pos = getMarkerPos _x
			};
			//Is it an object
			case ( "OBJECT" ) : {
				_pos = getPos _x;
			};
			//Is it a location
			case ( "LOCATION" ) : {
				_pos = locationPosition _x;
			};
		};
		
		//Put position in the right variable
		//_start
		if ( _forEachIndex isEqualTo 0 ) then {
			_start = _pos;
		}else{
			//_end
			_end = _pos;
		};
		
	}forEach [ _start, _end ];


	//********
	// SPAWN Reinforcement Group
	//********

	private[ "_group", "_wp1" ];

	//Setup one time group with waypoint
	_group = createGroup east;
	//Use end for WP position
	_wp1 = _group addWaypoint [ _end, 1 ];
	_wp1 setWaypointType "LOITER";
	_wp1 setWaypointSpeed "FULL";

	//Create global variable holding reference to the group
	//global variables like TerrorSquadA are held in an area called missionNamespace
	//so setting a variable there of the value of _groupName
	//gives us the same functionality as saying
	//TerrorSquadA = createGroup resistance;
	missionNamespace setVariable[ _groupName, _group ];

	while {true} do {
		
		//Spawn units
		{
			private[ "_unit" ];
			_x params [ "_unitType", "_nameSuffix" ];
			
			//Unit ARRAY command
			//Use _start as unit spawn position
			_unit = _group createUnit [ _unitType, _start, [], 0, "FORM" ];
			
			//Give unit a global var name
			//Although you would think you could use the same trick here as for the Group
			//by using missionNamespace, Object varaibles are slightly different
			//and require some extra setup
			//using BIS_fnc_objectVar is by far the easiest method to do this.
			//To make things easier on ourselfs lets use the group varname eg TerrorSquadA
			//as the prefix for the units name
			[ _unit, format[ "%1_%2", _groupName, _nameSuffix ] ] call BIS_fnc_objectVar;
			
			//Set unit skills
			{
				_x params[ "_skill", "_value" ];
				_unit setSkill [ _skill, _value ];
			}forEach _skills;
			
			//Pass unit to script
			[ _unit ] call neb_fnc_addBounty;
			_unit spawn tlq_killTicker;
			
			//Reset their current waypoint
			//( as if the previous group had already got here
			//any new units would think this waypoint has been completed ) 
			_group setCurrentWaypoint _wp1;
			
		}forEach _groupUnits;
		
		//Wait unitl they are all dead
		waitUntil {{alive _x} count units _group == 0};
		
		//debug
		//format[ "group %1 is dead", _groupName ] remoteExec [ "systemchat", 0 ];
		
		sleep 10;
	};
};

//Spawn Blu Attack Creeps
neb_fnc_core_bluCreeps = {
	params[
		//Default name, start and end to an empty string if not given
		[ "_groupName", "" ],
		[ "_start", "" ],
		[ "_end", "" ],
		[ "_groupUnits",
			//default set of units if none are passed to the script
			[
				[ "B_T_Soldier_F", "A" ],
				[ "B_T_Soldier_F", "B" ],
				[ "B_T_Soldier_F", "C" ],
				[ "B_T_Soldier_AA_F", "D" ],
				[ "B_T_Soldier_AT_F", "E" ]
			]
		],
		//Default skills if none passed to the script
		[ "_skills",
			[
				[ "aimingAccuracy", .5 ],
				[ "aimingShake", .5 ],
				[ "aimingSpeed", .5 ],
				[ "endurance", 1 ],
				[ "spotDistance", .7 ],
				[ "spotTime", .8 ],
				[ "courage", .8 ],
				[ "reloadSpeed", 1 ],
				[ "commanding", 1 ],
				[ "general", 1 ]
			]
		]
	];

	//Catch any errors and exit the script with a global error message
	//as we can not spawn a group without a name, start or end
	if ( _groupName isEqualTo "" ) exitWith {
		//Display error globally for connected clients
		"No groupName supplied for group spawn" remoteExec [ "BIS_fnc_error", 0 ];
	};
	if ( _start isEqualTo "" ) exitWith {
		//Display error globally for connected clients
		"No start position supplied for group spawn" remoteExec [ "BIS_fnc_error", 0 ];
	};
	if ( _end isEqualTo "" ) exitWith {
		//Display error globally for connected clients
		"No end position supplied for group spawn" remoteExec [ "BIS_fnc_error", 0 ];
	};

	//Work out what we have passed as positions
	{
		private[ "_pos" ];
		//What have we passed as _start and _end
		switch( typeName _x ) do {
			//Is it a STRING which means its a marker
			case ( typeName "" ) : {
				_pos = getMarkerPos _x
			};
			//Is it an object
			case ( "OBJECT" ) : {
				_pos = getPos _x;
			};
			//Is it a location
			case ( "LOCATION" ) : {
				_pos = locationPosition _x;
			};
		};
		
		//Put position in the right variable
		//_start
		if ( _forEachIndex isEqualTo 0 ) then {
			_start = _pos;
		}else{
			//_end
			_end = _pos;
		};
		
	}forEach [ _start, _end ];


	//********
	// SPAWN Reinforcement Group
	//********

	private[ "_group", "_wp1" ];

	//Setup one time group with waypoint
	_group = createGroup west;
	//Use end for WP position
	_wp1 = _group addWaypoint [ _end, 1 ];
	_wp1 setWaypointType "MOVE";
	_wp1 setWaypointSpeed "FULL";

	//Create global variable holding reference to the group
	//global variables like TerrorSquadA are held in an area called missionNamespace
	//so setting a variable there of the value of _groupName
	//gives us the same functionality as saying
	//TerrorSquadA = createGroup resistance;
	missionNamespace setVariable[ _groupName, _group ];

	while {true} do {
		
		//Spawn units
		{
			private[ "_unit" ];
			_x params [ "_unitType", "_nameSuffix" ];
			
			//Unit ARRAY command
			//Use _start as unit spawn position
			_unit = _group createUnit [ _unitType, _start, [], 0, "FORM" ];
			
			//Give unit a global var name
			//Although you would think you could use the same trick here as for the Group
			//by using missionNamespace, Object varaibles are slightly different
			//and require some extra setup
			//using BIS_fnc_objectVar is by far the easiest method to do this.
			//To make things easier on ourselfs lets use the group varname eg TerrorSquadA
			//as the prefix for the units name
			[ _unit, format[ "%1_%2", _groupName, _nameSuffix ] ] call BIS_fnc_objectVar;
			
			//Set unit skills
			{
				_x params[ "_skill", "_value" ];
				_unit setSkill [ _skill, _value ];
			}forEach _skills;
			
			//Pass unit to script
			[ _unit ] call neb_fnc_addBounty;
			_unit spawn tlq_killTicker;
			//Reset their current waypoint
			//( as if the previous group had already got here
			//any new units would think this waypoint has been completed ) 
			_group setCurrentWaypoint _wp1;
			
		}forEach _groupUnits;
		
		//Wait unitl they are all dead
		waitUntil {{alive _x} count units _group == 0};
		
		//debug
		//format[ "group %1 is dead", _groupName ] remoteExec [ "systemchat", 0 ];
		
		sleep 10;
	};
};

//Spawn Red attack Creeps
neb_fnc_core_redCreeps = {
	params[
		//Default name, start and end to an empty string if not given
		[ "_groupName", "" ],
		[ "_start", "" ],
		[ "_end", "" ],
		[ "_groupUnits",
			//default set of units if none are passed to the script
			[
				[ "O_T_Soldier_F", "A" ],
				[ "O_T_Soldier_F", "B" ],
				[ "O_T_Soldier_F", "C" ],
				[ "O_T_Soldier_AA_F", "D" ],
				[ "O_T_Soldier_AT_F", "E" ]
			]
		],
		//Default skills if none passed to the script
		[ "_skills",
			[
				[ "aimingAccuracy", .5 ],
				[ "aimingShake", .5 ],
				[ "aimingSpeed", .5 ],
				[ "endurance", 1 ],
				[ "spotDistance", .7 ],
				[ "spotTime", .8 ],
				[ "courage", .8 ],
				[ "reloadSpeed", 1 ],
				[ "commanding", 1 ],
				[ "general", 1 ]
			]
		]
	];

	//Catch any errors and exit the script with a global error message
	//as we can not spawn a group without a name, start or end
	if ( _groupName isEqualTo "" ) exitWith {
		//Display error globally for connected clients
		"No groupName supplied for group spawn" remoteExec [ "BIS_fnc_error", 0 ];
	};
	if ( _start isEqualTo "" ) exitWith {
		//Display error globally for connected clients
		"No start position supplied for group spawn" remoteExec [ "BIS_fnc_error", 0 ];
	};
	if ( _end isEqualTo "" ) exitWith {
		//Display error globally for connected clients
		"No end position supplied for group spawn" remoteExec [ "BIS_fnc_error", 0 ];
	};

	//Work out what we have passed as positions
	{
		private[ "_pos" ];
		//What have we passed as _start and _end
		switch( typeName _x ) do {
			//Is it a STRING which means its a marker
			case ( typeName "" ) : {
				_pos = getMarkerPos _x
			};
			//Is it an object
			case ( "OBJECT" ) : {
				_pos = getPos _x;
			};
			//Is it a location
			case ( "LOCATION" ) : {
				_pos = locationPosition _x;
			};
		};
		
		//Put position in the right variable
		//_start
		if ( _forEachIndex isEqualTo 0 ) then {
			_start = _pos;
		}else{
			//_end
			_end = _pos;
		};
		
	}forEach [ _start, _end ];


	//********
	// SPAWN Reinforcement Group
	//********

	private[ "_group", "_wp1" ];

	//Setup one time group with waypoint
	_group = createGroup east;
	//Use end for WP position
	_wp = _group addWaypoint [ _end, 1 ];
	_wp setWaypointType "MOVE";
	_wp setWaypointSpeed "FULL";

	//Create global variable holding reference to the group
	//global variables like TerrorSquadA are held in an area called missionNamespace
	//so setting a variable there of the value of _groupName
	//gives us the same functionality as saying
	//TerrorSquadA = createGroup resistance;
	missionNamespace setVariable[ _groupName, _group ];

	while {true} do {
		
		//Spawn units
		{
			private[ "_unit" ];
			_x params [ "_unitType", "_nameSuffix" ];
			
			//Unit ARRAY command
			//Use _start as unit spawn position
			_unit = _group createUnit [ _unitType, _start, [], 0, "FORM" ];
			
			//Give unit a global var name
			//Although you would think you could use the same trick here as for the Group
			//by using missionNamespace, Object varaibles are slightly different
			//and require some extra setup
			//using BIS_fnc_objectVar is by far the easiest method to do this.
			//To make things easier on ourselfs lets use the group varname eg TerrorSquadA
			//as the prefix for the units name
			[ _unit, format[ "%1_%2", _groupName, _nameSuffix ] ] call BIS_fnc_objectVar;
			
			//Set unit skills
			{
				_x params[ "_skill", "_value" ];
				_unit setSkill [ _skill, _value ];
			}forEach _skills;
			
			//Pass unit to script
			[ _unit ] call neb_fnc_addBounty;
			_unit spawn tlq_killTicker;
			
			//Reset their current waypoint
			//( as if the previous group had already got here
			//any new units would think this waypoint has been completed ) 
			_group setCurrentWaypoint _wp;
			
		}forEach _groupUnits;
		
		//Wait unitl they are all dead
		waitUntil {{alive _x} count units _group == 0};
		
		//debug
		//format[ "group %1 is dead", _groupName ] remoteExec [ "systemchat", 0 ];
		
		sleep 10;
	};
};

// Initiate AI Spawns
neb_fnc_core_creepSpawn = {
waitUntil { time > 0 }; //after briefing
[ "TerrorSquadA", "TerrorSpawnA", civiZoneA ] spawn neb_fnc_core_terrorSpawn;
[ "TerrorSquadB", "TerrorSpawnB", civiZoneB ] spawn neb_fnc_core_terrorSpawn;
sleep 5;
[ "BluSquadA", "BluSpawn", BluBase ] spawn neb_fnc_core_bluDefender;
[ "RedSquadA", "RedSpawn", RedBase ] spawn neb_fnc_core_redDefender;
sleep 60;
[ "BluSquadB", "BluSpawn", mercZone ] spawn neb_fnc_core_bluCreeps;
[ "RedSquadB", "RedSpawn", mercZone ] spawn neb_fnc_core_redCreeps;
sleep 10;
[ "BluSquadS", "BluSpawn", BluShop ] spawn neb_fnc_core_bluDefender;
[ "RedSquadS", "RedSpawn", RedShop ] spawn neb_fnc_core_redDefender;
/*
sleep 300;
[ "BluSquadC", "BluSpawn", mercZone ] spawn neb_fnc_core_bluCreeps;
[ "RedSquadC", "RedSpawn", mercZone ] spawn neb_fnc_core_redCreeps;
*/
sleep 300;
[ "BluSquadD", "BluSpawn", RedBase ] spawn neb_fnc_core_bluCreeps;
[ "RedSquadD", "RedSpawn", BluBase ] spawn neb_fnc_core_redCreeps;
};