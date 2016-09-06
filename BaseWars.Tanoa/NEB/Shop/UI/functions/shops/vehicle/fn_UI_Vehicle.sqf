#include "..\..\shopMacros.hpp"

//Shop Title
UICTRL( STXT_TITLE_IDC ) ctrlSetStructuredText parseText "<t align='center'>Vehicle Shop</t>";
//Shop Icon
UICTRL( PIC_SHOP_IDC ) ctrlSetText "\a3\ui_f\data\GUI\Rsc\RscDisplayArsenal\spaceGarage_ca.paa";
//Shop Buttons
UICTRL( BTN_ZERO_IDC ) ctrlSetText "Land";
UICTRL( BTN_ONE_IDC ) ctrlSetText "Air";
UICTRL( BTN_TWO_IDC ) ctrlSetText "Sea";

//Change buy to Buy
UICTRL( BTN_BUY_IDC ) ctrlSetText "Buy";