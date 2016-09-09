#include "..\..\shopMacros.hpp"

params[ "_className", "_cost", "_ammo", "_count" ];

//Add money
[ _cost * _count ] call NEB_fnc_updateStats;

if ( isClass( configFile >> "CfgMagazines" >> _className ) ) then {
	[ "CACHE", [ "REM", [ [ _className, _ammo ], _count ] ] ] call NEB_fnc_shopCrate;
}else{
	[ "CACHE", [ "REM", [ _className, _count ] ] ] call NEB_fnc_shopCrate;
};

_listbox = UICTRL( LB_LIST_IDC );
_index = lbCurSel _listbox;
[ "RESETDATA", _index ] call NEB_fnc_shop;