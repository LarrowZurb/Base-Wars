#include "..\..\shopMacros.hpp"

params[ "_className" ];

_cfg = ( configFile >> "CfgWeapons" >> _className );
_cfgName = getText( configFile >> "CfgWeapons" >> _classname >> "displayName" );
_pic = str getText( _cfg >> "Picture");
_short = getText( configFile >> "CfgWeapons" >> _classname >> "descriptionShort" );
_mass = getNumber( configFile >> "CfgWeapons" >> _classname >> "ItemInfo" >> "mass" );
UICTRL( STXT_INFO_IDC ) ctrlSetStructuredText parseText format [
	"<t align='center'>%1</t><br/>
	<t align='center' size='6'><img image=%2/></t><br/>
	<t align='center'>Mass: %3</t><br/>
	<t align='center'>%5</t><br/>
	<t align='center'>%4</t><br/>",
	_cfgName,
	_pic,
	_mass,
	_short,			    	
	"---------------------------------------------------------------------------------"
];