#include "..\..\shopMacros.hpp"

params[ "_className" ];

if !( isNil "_className" ) then {
	_buttonSell = UICTRL( BTN_BUY_IDC );
	_buttonSell ctrlEnable true;
};

