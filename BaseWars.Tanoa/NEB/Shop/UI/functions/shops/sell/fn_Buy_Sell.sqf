#include "..\..\shopMacros.hpp"

params[ "_className", "_cost", "_ammo" ];

//Add money
[ _cost ] call fnc_updateStats;

_crateContents = [ "CARGO", "ALL" ] call NEB_fnc_shopCrate;

_itemType = _className call BIS_fnc_itemType;

switch ( toUpper( _itemType select 0 ) ) do {
	case "MINE";
	case "MAGAZINE" : {
		_contents = _crateContents select 0;
		{
			_x params[ "_mag", "_ammoCount" ];
			
			if ( _mag == _className && _ammoCount isEqualTo _ammo ) exitWith {
				_contents set [ _forEachIndex, objNull ];
			};
		}forEach _contents;
		_contents = _contents - [ objNull ];
		_crateContents set [ 0, _contents ];
	};
	case "WEAPON";
	case "ITEM";
	case "EQUIPMENT" : {
		_contents = _crateContents select [ 1, 3 ];
		{
			_contentType = _x;
			{
				_x params[ "_item", "_itemCount" ];
				if ( _item == _className ) exitWith {
					if ( _itemCount - 1 > 0 ) then {
						_contentType set [ _forEachIndex, [ _item, _itemCount - 1 ] ];
					}else{
						_contentType set [ _forEachIndex, objNull ];
					};
				};
			}forEach _contentType;
			_contentType = _contentType - [ objNull ];
			_contents set [ _forEachIndex, _contentType ];
		}forEach _contents;
		_crateContents = [ _crateContents select 0, _contents select 0, _contents select 1, _contents select 2 ];
	};
};

profileNamespace setVariable [ "NEB_telecache", _crateContents ];
[ "LOAD" ] call NEB_fnc_shopCrate;

_listbox = UICTRL( LB_LIST_IDC );
_index = lbCurSel _listbox;
[ "RESETDATA", _index ] call NEB_fnc_shop;