#include "..\..\shopMacros.hpp"

private[ "_ammoData", "_priCount", "_priIndex", "_secCount", "_secIndex" ];
params[ "_className" ];

_cfg = ( configFile >> "CfgWeapons" >> _className );
_dataCfg = missionConfigFile >> format[ "NEB_%1Data", NEB_currentShop ] >> _classname;

_modes = [];
{
	_nul = _modes pushBackUnique getText( _cfg >> _x >> "displayName" );
}forEach getArray( _cfg >> "modes" );

_fireModes = "";
{
	 _fireModes = format[ "%1%2, ", _fireModes, _x ];
}forEach _modes;

if ( isArray( missionConfigFile >> "NEB_weaponData" >> _classname >> "ammo" ) ) then {
	_ammoData = getArray( missionConfigFile >> "NEB_weaponData" >> _classname >> "ammo" );
	_priCount = _ammoData select 0 select 0;
	_priIndex = _ammoData select 0 select 1;
	if ( count getArray( _cfg >> "muzzles" ) > 1 ) then {
		_secCount = _ammoData select 1 select 0;
		_secIndex = _ammoData select 1 select 1;
	}; 
}else{
	_defaultAmmo = getArray( missionConfigFile >> "NEB_WeaponData" >> "NEB_defaultAmmo" ) select NEB_currentButton;
	_priCount = _defaultAmmo select 0 select 0;
	_priIndex = _defaultAmmo select 0 select 1;
	_secCount = _defaultAmmo select 1 select 0;
	_secIndex = _defaultAmmo select 1 select 1;
};

_suppliedAmmo = format[ "<t align='center'>%1:</t><t size='1.2' align='right'>%2 of <img image=%3 /></t><br/>",
	getText( configFile >> "CfgMagazines" >> ( getArray( _cfg >> "magazines") select _priIndex ) >> "displayName" ),
	_priCount,
	str getText( configFile >> "CfgMagazines" >> ( getArray( _cfg >> "magazines") select _priIndex ) >> "picture" )
];
if ( count getArray( _cfg >> "muzzles" ) > 1 ) then {
	_suppliedAmmo = format[ "%1<t align='center'>%2:</t><t size='1.2' align='right'>%3 of <img image=%4 /></t><br/>",
		_suppliedAmmo,
		getText ( configFile >> "CfgMagazines" >> ( getArray( _cfg >> ( getArray( _cfg >> "muzzles" ) select 1 ) >> "magazines" ) select _secIndex ) >> "displayName" ),
		_secCount,
		str getText ( configFile >> "CfgMagazines" >> ( getArray( _cfg >> ( getArray( _cfg >> "muzzles" ) select 1 ) >> "magazines" ) select _secIndex ) >> "picture" )
	];
};

UICTRL( STXT_INFO_IDC ) ctrlSetStructuredText parseText format [
	"<t align='center'>%1</t><br/>
	<t align='center' size='6' ><img image=%6 /></t><br/>
	<t align='left'>%5</t><br/>
	<t align='left'>Fire Modes:</t><br/>
	<t align='center'>%2</t><br/>
	<t align='left'>%5</t><br/>
	<t align='left'>Supplied Ammo:</t><br/>
	%3
	<t align='left'>%5</t><br/>
	<t align='left'>%4</t><br/>
	<t align='left'>%5</t><br/>
	",
	getText( _cfg >> "descriptionShort" ),
	_fireModes,
	_suppliedAmmo,			    	
	getText( configFile >> "CfgWeapons" >> [ _className ] call BIS_fnc_baseWeapon >> "Library" >> "libTextDesc" ),
	"---------------------------------------------------------------------------------",
	str getText( _cfg >> "Picture")
	
	
];