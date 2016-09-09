#include "..\Shop_IDs.hpp"

#define SHOPLAYOUTS [ -1, GRP_BTN_ONE, GRP_BTN_TWO, GRP_BTN_THREE, GRP_BTN_FOUR, GRP_BTN_FIVE, GRP_BTN_SIX ]
#define SHOPDISPLAY findDisplay NEB_SHOP_IDD
#define UICTRL( IDC ) if ( IDC >= 1000 ) then {\
		SHOPDISPLAY displayCtrl ( SHOPLAYOUTS select NEB_shopButtons ) controlsGroupCtrl IDC\
	}else{\
		SHOPDISPLAY displayCtrl IDC\
	}