#include "..\..\shopMacros.hpp"

params[ [ "_quantity", 1 ] ];

_progress = UICTRL( PROG_QTY_IDC );
_edit = UICTRL( EDIT_QTY_IDC );

if ( _quantity > 1 ) then {
	[ "QTY", "SHOW" ] call NEB_fnc_shop;
	_progress progressSetPosition 1;
	_edit ctrlSetText format[ "%1", _count ];
	
}else{
	[ "QTY", "HIDE" ] call NEB_fnc_shop;
	_progress progressSetPosition 1;
	_edit ctrlSetText format[ "%1", 1 ];
};
