#include "..\..\shopMacros.hpp"

//Shop Title
UICTRL( STXT_TITLE_IDC ) ctrlSetStructuredText parseText "<t align='center'>Gear Shop</t>";
//Shop Icon
UICTRL( PIC_SHOP_IDC ) ctrlSetText "\a3\ui_f\data\IGUI\Cfg\Actions\gear_ca.paa";
//Shop Buttons
UICTRL( BTN_ZERO_IDC ) ctrlSetText "Uniforms";
UICTRL( BTN_ONE_IDC ) ctrlSetText "Vests";
UICTRL( BTN_TWO_IDC ) ctrlSetText "Backpacks";
UICTRL( BTN_THREE_IDC ) ctrlSetText "Helmets";
UICTRL( BTN_FOUR_IDC ) ctrlSetText "Glasses";
UICTRL( BTN_FIVE_IDC ) ctrlSetText "NVGs";

//Change buy to Buy
UICTRL( BTN_BUY_IDC ) ctrlSetText "Buy";