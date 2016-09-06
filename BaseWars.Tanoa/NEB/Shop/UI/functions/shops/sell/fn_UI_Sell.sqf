#include "..\..\shopMacros.hpp"

//Shop Title
UICTRL( STXT_TITLE_IDC ) ctrlSetStructuredText parseText "<t align='center'>Telecache</t>";
//Shop Icon
UICTRL( PIC_SHOP_IDC ) ctrlSetText "";
//Shop Buttons
UICTRL( BTN_ZERO_IDC ) ctrlSetText "Weapons";
UICTRL( BTN_ONE_IDC ) ctrlSetText "Attachments";
UICTRL( BTN_TWO_IDC ) ctrlSetText "Gear";
UICTRL( BTN_THREE_IDC ) ctrlSetText "Magazines";

//Change buy to Sell
UICTRL( BTN_BUY_IDC ) ctrlSetText "Sell";
