#include "..\..\shopMacros.hpp"

//Shop Title
UICTRL( STXT_TITLE_IDC ) ctrlSetStructuredText parseText "<t align='center'>Attachment Shop</t>";
//Shop Icon
UICTRL( PIC_SHOP_IDC ) ctrlSetText "\a3\ui_f\data\IGUI\Cfg\Actions\gear_ca.paa";
//Shop Buttons
UICTRL( BTN_ZERO_IDC ) ctrlSetText "Optic";
UICTRL( BTN_ONE_IDC ) ctrlSetText "Pointer";
UICTRL( BTN_TWO_IDC ) ctrlSetText "Bipod";
UICTRL( BTN_THREE_IDC ) ctrlSetText "Silencer";

//Change buy to Buy
UICTRL( BTN_BUY_IDC ) ctrlSetText "Buy";