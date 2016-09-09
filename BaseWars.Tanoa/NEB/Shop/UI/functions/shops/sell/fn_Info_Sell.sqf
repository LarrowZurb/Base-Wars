#include "..\..\shopMacros.hpp"

params[ "_className", "_cost", "_ammo", "_count" ];

//progress bar for sell quantity

if !( isNil "_className" ) then {
	_buttonSell = UICTRL( BTN_BUY_IDC );
	_buttonSell ctrlEnable true;
};

