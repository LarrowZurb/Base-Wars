#include "..\..\shopMacros.hpp"

params[ "_className", "_cost", "_ammo" ];

//Add money
[ _cost ] call NEB_fnc_updateStats;

[ "CACHE", [ "REM", [ _className, 1, _ammo ] ] ] call NEB_fnc_shopCrate;

_listbox = UICTRL( LB_LIST_IDC );
_index = lbCurSel _listbox;
[ "RESETDATA", _index ] call NEB_fnc_shop;