#include "baseDefines.hpp"
#include "Shop_IDs.hpp"
#include "..\shopData.data"

class NEB_Shop
{
	idd = NEB_SHOP_IDD;
	movingEnable = false;
	enableSimulation = true;
	onUnload = "[ 'SAVE' ] call NEB_fnc_shopCrate";

	class controlsBackground
	{
		class BckScreen: IGUIBack
		{
			idc = -1;
			x = 0 * safeZoneW + safeZoneX;
			y = 0 * safeZoneH + safeZoneY;
			w = 1 * safeZoneW;
			h = 1 * safeZoneH;

			colorBackground[] = {0.1,0.1,0.1,0.1};
		};
		class BckShop: BckScreen
		{
			x = 0.25 * safeZoneW + safeZoneX;
			y = 0.25 * safeZoneH + safeZoneY;
			w = 0.5 * safeZoneW;
			h = 0.5 * safeZoneH;
		};
		class BckHeader: BckScreen
		{
			x = 0.255 * safeZoneW + safeZoneX;
			y = 0.2575 * safeZoneH + safeZoneY;
			w = 0.49 * safeZoneW;
			h = 0.05 * safeZoneH;
		};
		class BckList: BckScreen
		{
			x = 0.255 * safeZoneW + safeZoneX;
			y = 0.3125 * safeZoneH + safeZoneY;
			w = 0.2425 * safeZoneW;
			h = 0.4275 * safeZoneH;
		};
		
		
	};

	class controls
	{
		
		class PicShop: RscPicture
		{
			idc = PIC_SHOP_IDC;
			style = 0x30 + 0x800; //Style picture + Keep aspect ratio
			x = 0.2575 * safeZoneW + safeZoneX;
			y = 0.26 * safeZoneH + safeZoneY;
			w = 0.05 * safeZoneW;
			h = 0.045* safeZoneH;

			colorBackground[] = {0,0,0,1};
			sizeEx = 0.1;

		};
		class STxtTitleText: RscStructuredText
		{
			idc = STXT_TITLE_IDC;
			x = 0.305 * safeZoneW + safeZoneX;
			y = 0.265 * safeZoneH + safeZoneY;
			w = 0.325 * safeZoneW;
			h = 0.04 * safeZoneH;

			colorText[] = {1,1,1,1};
			colorBackground[] = {0.1,0.1,0.1,0.1};
			shadow = 0.75;
			size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5)";

		};
		class BtnCrate: RscShortcutButton
		{
			idc = BTN_CRATE_IDC;
			x = 0.635 * safeZoneW + safeZoneX;
			y = 0.265 * safeZoneH + safeZoneY;
			w = 0.05* safeZoneW;
			h = 0.04 * safeZoneH;

			colorBackground[] = {0.4,0.4,0.4,1};
			colorBackground2[] = {0.4,0.4,0.4,1};
			colorBackgroundFocused[] = {0.4,0.4,0.4,1};
			
		text = "Cache";
			action = "[ 'OPEN' ] call NEB_fnc_shopCrate";

		};
		class CmbShopType: RscCombo
		{
			idc = CMB_SHOPTYPE_IDC;
			x = 0.690 * safeZoneW + safeZoneX;
			y = 0.265 * safeZoneH + safeZoneY;
			w = 0.05 * safeZoneW;
			h = 0.04 * safeZoneH;
		};
		

		class LBVehList: RscListBox
		{
			idc = LB_LIST_IDC;
			x = 0.26 * safeZoneW + safeZoneX;
			y = 0.3225 * safeZoneH + safeZoneY;
			w = 0.2325 * safeZoneW;
			h = 0.41 * safeZoneH;

			colorText[] = {1,1,1,1};
			colorDisabled[] = {1,1,1,0.25};
			colorScrollbar[] = {1,0,0,0};
			colorSelect[] = {1,1,1,1};
			colorSelect2[] = {1,1,1,1};
			colorSelectBackground[] = {0,0,0,0.5};
			colorSelectBackground2[] = {0.1,0.1,0.1,0.1};
			colorBackground[] = {0.1,0.1,0.1,0.1};
			shadow = 0.75;

			onLBSelChanged  = "[ 'INFO', _this ] call NEB_fnc_Shop;";
		};
		
		class OneButtons : RscControlsGroup
		{
			idc = GRP_BTN_ONE;
			x = 0.5025 * safeZoneW + safeZoneX;
			y = 0.3125 * safeZoneH + safeZoneY;
			w = 0.2425 * safeZoneW;
			h = 0.3825 * safeZoneH;

			class VScrollbar
			{
				color[] = {1,1,1,0.25};
				width = 0;
				autoScrollEnabled = 1;
			};
			class HScrollbar
			{
				color[] = {1,1,1,1};
				height = 0;
			};
			class ScrollBar
			{
				color[] = {1,1,1,0.6};
				colorActive[] = {1,1,1,1};
				colorDisabled[] = {1,1,1,0.3};
				thumb = "#(argb,8,8,3)color(1,1,1,1)";
				arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
				arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
				border = "#(argb,8,8,3)color(1,1,1,0)";
			};
			
			class controls
			{
				class BtnZero: RscShortcutButton
				{
					idc = BTN_ZERO_IDC;
					x = 0;
					y = 0;
					w = 0.2420 * safeZoneW;
					h = 0.0375 * safeZoneH;

					colorBackground[] = {0.4,0.4,0.4,1};
					colorBackground2[] = {0.4,0.4,0.4,1};
					colorBackgroundFocused[] = {0.4,0.4,0.4,1};

					onButtonClick  = "[ 'MODE', 0 ] call NEB_fnc_Shop";

				};
				
				class BckInfo: IGUIBack
				{
					idc = -1;
					x = 0;
					y = 0.0425 * safeZoneH;
					w = 0.2425 * safeZoneW;
					h = 0.34 * safeZoneH;
				};
				class InfoCtrlGrp : RscControlsGroup
				{
					x = 0.0055 * safeZoneW;
					y = 0.0525 * safeZoneH;
					w = 0.2325 * safeZoneW;
					h = 0.32 * safeZoneH;

					class VScrollbar
					{
						color[] = {1,1,1,0.25};
						width = 0.005;
						autoScrollEnabled = 1;
					};
					class HScrollbar
					{
						color[] = {1,1,1,1};
						height = 0;
					};
					class ScrollBar
					{
						color[] = {1,1,1,0.6};
						colorActive[] = {1,1,1,1};
						colorDisabled[] = {1,1,1,0.3};
						thumb = "#(argb,8,8,3)color(1,1,1,1)";
						arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
						arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
						border = "#(argb,8,8,3)color(1,1,1,0)";
					};

					class controls
					{
						class STxtItemInfo: RscStructuredText
						{
							idc = STXT_INFO_IDC;
							x = 0;
							y = 0;
							w = 0.23 * safeZoneW;
							h = 0.5 * safeZoneH;

							colorText[] = {1,1,1,1};
							colorBackground[] = {0.1,0.1,0.1,0.1};
							shadow = 0.75;
							size = 0.037;
							text = "";
						};
					};
				};
			};
		};

		class TwoButtons : RscControlsGroup
		{
			idc = GRP_BTN_TWO;
			x = 0.5025 * safeZoneW + safeZoneX;
			y = 0.3125 * safeZoneH + safeZoneY;
			w = 0.2425 * safeZoneW;
			h = 0.3825 * safeZoneH;

			class VScrollbar
			{
				color[] = {1,1,1,0.25};
				width = 0;
				autoScrollEnabled = 1;
			};
			class HScrollbar
			{
				color[] = {1,1,1,1};
				height = 0;
			};
			class ScrollBar
			{
				color[] = {1,1,1,0.6};
				colorActive[] = {1,1,1,1};
				colorDisabled[] = {1,1,1,0.3};
				thumb = "#(argb,8,8,3)color(1,1,1,1)";
				arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
				arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
				border = "#(argb,8,8,3)color(1,1,1,0)";
			};
			
			class controls
			{
				class BtnZero: RscShortcutButton
				{
					idc = BTN_ZERO_IDC;
					x = 0;
					y = 0;
					w = 0.1205 * safeZoneW;
					h = 0.0375 * safeZoneH;

					colorBackground[] = {0.4,0.4,0.4,1};
					colorBackground2[] = {0.4,0.4,0.4,1};
					colorBackgroundFocused[] = {0.4,0.4,0.4,1};

					onButtonClick  = "[ 'MODE', 0 ] call NEB_fnc_Shop";

				};
				class BtnOne: BtnZero
				{
					idc = BTN_ONE_IDC;
					x = 0.1215 * safeZoneW;
					y = 0;
					w = 0.1205 * safeZoneW;
					h = 0.0375 * safeZoneH;

					onButtonClick  = "[ 'MODE', 1 ] call NEB_fnc_Shop";

				};
				
				class BckInfo: IGUIBack
				{
					idc = -1;
					x = 0;
					y = 0.0425 * safeZoneH;
					w = 0.2425 * safeZoneW;
					h = 0.34 * safeZoneH;
				};
				class InfoCtrlGrp : RscControlsGroup
				{
					x = 0.0055 * safeZoneW;
					y = 0.0525 * safeZoneH;
					w = 0.2325 * safeZoneW;
					h = 0.32 * safeZoneH;

					class VScrollbar
					{
						color[] = {1,1,1,0.25};
						width = 0.005;
						autoScrollEnabled = 1;
					};
					class HScrollbar
					{
						color[] = {1,1,1,1};
						height = 0;
					};
					class ScrollBar
					{
						color[] = {1,1,1,0.6};
						colorActive[] = {1,1,1,1};
						colorDisabled[] = {1,1,1,0.3};
						thumb = "#(argb,8,8,3)color(1,1,1,1)";
						arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
						arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
						border = "#(argb,8,8,3)color(1,1,1,0)";
					};

					class controls
					{
						class STxtItemInfo: RscStructuredText
						{
							idc = STXT_INFO_IDC;
							x = 0;
							y = 0;
							w = 0.23 * safeZoneW;
							h = 0.5 * safeZoneH;

							colorText[] = {1,1,1,1};
							colorBackground[] = {0.1,0.1,0.1,0.1};
							shadow = 0.75;
							size = 0.037;
							text = "";
						};
					};
				};
			};
		};
		
		class ThreeButtons : RscControlsGroup
		{
			idc = GRP_BTN_THREE;
			x = 0.5025 * safeZoneW + safeZoneX;
			y = 0.3125 * safeZoneH + safeZoneY;
			w = 0.2425 * safeZoneW;
			h = 0.3825 * safeZoneH;

			class VScrollbar
			{
				color[] = {1,1,1,0.25};
				width = 0;
				autoScrollEnabled = 1;
			};
			class HScrollbar
			{
				color[] = {1,1,1,1};
				height = 0;
			};
			class ScrollBar
			{
				color[] = {1,1,1,0.6};
				colorActive[] = {1,1,1,1};
				colorDisabled[] = {1,1,1,0.3};
				thumb = "#(argb,8,8,3)color(1,1,1,1)";
				arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
				arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
				border = "#(argb,8,8,3)color(1,1,1,0)";
			};
			
			class controls
			{
				class BtnZero: RscShortcutButton
				{
					idc = BTN_ZERO_IDC;
					x = 0;
					y = 0;
					w = 0.0800 * safeZoneW;
					h = 0.0375 * safeZoneH;

					colorBackground[] = {0.4,0.4,0.4,1};
					colorBackground2[] = {0.4,0.4,0.4,1};
					colorBackgroundFocused[] = {0.4,0.4,0.4,1};

					onButtonClick  = "[ 'MODE', 0 ] call NEB_fnc_Shop";

				};
				class BtnOne: BtnZero
				{
					idc = BTN_ONE_IDC;
					x = 0.081 * safeZoneW;
					y = 0;
					w = 0.0800 * safeZoneW;
					h = 0.0375 * safeZoneH;

					onButtonClick  = "[ 'MODE', 1 ] call NEB_fnc_Shop";

				};
				class BtnTwo: BtnZero
				{
					idc = BTN_TWO_IDC;
					x = 0.162 * safeZoneW;
					y = 0;
					w = 0.0800 * safeZoneW;
					h = 0.0375 * safeZoneH;

					onButtonClick  = "[ 'MODE', 2 ] call NEB_fnc_Shop";

				};
				
				class BckInfo: IGUIBack
				{
					idc = -1;
					x = 0;
					y = 0.0425 * safeZoneH;
					w = 0.2425 * safeZoneW;
					h = 0.34 * safeZoneH;
				};
				class InfoCtrlGrp : RscControlsGroup
				{
					x = 0.0055 * safeZoneW;
					y = 0.0525 * safeZoneH;
					w = 0.2325 * safeZoneW;
					h = 0.32 * safeZoneH;

					class VScrollbar
					{
						color[] = {1,1,1,0.25};
						width = 0.005;
						autoScrollEnabled = 1;
					};
					class HScrollbar
					{
						color[] = {1,1,1,1};
						height = 0;
					};
					class ScrollBar
					{
						color[] = {1,1,1,0.6};
						colorActive[] = {1,1,1,1};
						colorDisabled[] = {1,1,1,0.3};
						thumb = "#(argb,8,8,3)color(1,1,1,1)";
						arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
						arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
						border = "#(argb,8,8,3)color(1,1,1,0)";
					};

					class controls
					{
						class STxtItemInfo: RscStructuredText
						{
							idc = STXT_INFO_IDC;
							x = 0;
							y = 0;
							w = 0.23 * safeZoneW;
							h = 0.5 * safeZoneH;

							colorText[] = {1,1,1,1};
							colorBackground[] = {0.1,0.1,0.1,0.1};
							shadow = 0.75;
							size = 0.037;
							text = "";
						};
					};
				};
			};
		};

		class FourButtons : RscControlsGroup
		{
			idc = GRP_BTN_FOUR;
			x = 0.5025 * safeZoneW + safeZoneX;
			y = 0.3125 * safeZoneH + safeZoneY;
			w = 0.2425 * safeZoneW;
			h = 0.3825 * safeZoneH;

			class VScrollbar
			{
				color[] = {1,1,1,0.25};
				width = 0;
				autoScrollEnabled = 1;
			};
			class HScrollbar
			{
				color[] = {1,1,1,1};
				height = 0;
			};
			class ScrollBar
			{
				color[] = {1,1,1,0.6};
				colorActive[] = {1,1,1,1};
				colorDisabled[] = {1,1,1,0.3};
				thumb = "#(argb,8,8,3)color(1,1,1,1)";
				arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
				arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
				border = "#(argb,8,8,3)color(1,1,1,0)";
			};
			
			class controls
			{
				class BtnZero: RscShortcutButton
				{
					idc = BTN_ZERO_IDC;
					x = 0;
					y = 0;
					w = 0.1205 * safeZoneW;
					h = 0.0375 * safeZoneH;

					colorBackground[] = {0.4,0.4,0.4,1};
					colorBackground2[] = {0.4,0.4,0.4,1};
					colorBackgroundFocused[] = {0.4,0.4,0.4,1};

					onButtonClick  = "[ 'MODE', 0 ] call NEB_fnc_Shop";

				};
				class BtnOne: BtnZero
				{
					idc = BTN_ONE_IDC;
					x = 0.1215 * safeZoneW;
					y = 0;
					w = 0.1205 * safeZoneW;
					h = 0.0375 * safeZoneH;

					onButtonClick  = "[ 'MODE', 1 ] call NEB_fnc_Shop";

				};
				
				class BtnTwo: RscShortcutButton
				{
					idc = BTN_TWO_IDC;
					x = 0;
					y = 0.0385 * safeZoneH;
					w = 0.1205 * safeZoneW;
					h = 0.0375 * safeZoneH;

					colorBackground[] = {0.4,0.4,0.4,1};
					colorBackground2[] = {0.4,0.4,0.4,1};
					colorBackgroundFocused[] = {0.4,0.4,0.4,1};

					onButtonClick  = "[ 'MODE', 2 ] call NEB_fnc_Shop";

				};
				class BtnThree: BtnZero
				{
					idc = BTN_THREE_IDC;
					x = 0.1215 * safeZoneW;
					y = 0.0385 * safeZoneH;
					w = 0.1205 * safeZoneW;
					h = 0.0375 * safeZoneH;

					onButtonClick  = "[ 'MODE', 3 ] call NEB_fnc_Shop";

				};
				
				class BckInfo: IGUIBack
				{
					idc = -1;
					x = 0;
					y = 0.081 * safeZoneH;
					w = 0.2425 * safeZoneW;
					h = 0.3015 * safeZoneH;
				};
				class InfoCtrlGrp : RscControlsGroup
				{
					x = 0.0055 * safeZoneW;
					y = 0.091 * safeZoneH;
					w = 0.2325 * safeZoneW;
					h = 0.2815 * safeZoneH;

					class VScrollbar
					{
						color[] = {1,1,1,0.25};
						width = 0.005;
						autoScrollEnabled = 1;
					};
					class HScrollbar
					{
						color[] = {1,1,1,1};
						height = 0;
					};
					class ScrollBar
					{
						color[] = {1,1,1,0.6};
						colorActive[] = {1,1,1,1};
						colorDisabled[] = {1,1,1,0.3};
						thumb = "#(argb,8,8,3)color(1,1,1,1)";
						arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
						arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
						border = "#(argb,8,8,3)color(1,1,1,0)";
					};

					class controls
					{
						class STxtItemInfo: RscStructuredText
						{
							idc = STXT_INFO_IDC;
							x = 0;
							y = 0;
							w = 0.23 * safeZoneW;
							h = 0.5 * safeZoneH;

							colorText[] = {1,1,1,1};
							colorBackground[] = {0.1,0.1,0.1,0.1};
							shadow = 0.75;
							size = 0.037;
							text = "";
						};
					};
				};
			};
		};
		
		class FiveButtons : RscControlsGroup
		{
			idc = GRP_BTN_FIVE;
			x = 0.5025 * safeZoneW + safeZoneX;
			y = 0.3125 * safeZoneH + safeZoneY;
			w = 0.2425 * safeZoneW;
			h = 0.3825 * safeZoneH;

			class VScrollbar
			{
				color[] = {1,1,1,0.25};
				width = 0;
				autoScrollEnabled = 1;
			};
			class HScrollbar
			{
				color[] = {1,1,1,1};
				height = 0;
			};
			class ScrollBar
			{
				color[] = {1,1,1,0.6};
				colorActive[] = {1,1,1,1};
				colorDisabled[] = {1,1,1,0.3};
				thumb = "#(argb,8,8,3)color(1,1,1,1)";
				arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
				arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
				border = "#(argb,8,8,3)color(1,1,1,0)";
			};
			
			class controls
			{
				class BtnZero: RscShortcutButton
				{
					idc = BTN_ZERO_IDC;
					x = 0;
					y = 0;
					w = 0.1205 * safeZoneW;
					h = 0.0375 * safeZoneH;

					colorBackground[] = {0.4,0.4,0.4,1};
					colorBackground2[] = {0.4,0.4,0.4,1};
					colorBackgroundFocused[] = {0.4,0.4,0.4,1};

					onButtonClick  = "[ 'MODE', 0 ] call NEB_fnc_Shop";

				};
				class BtnOne: BtnZero
				{
					idc = BTN_ONE_IDC;
					x = 0.1215 * safeZoneW;
					y = 0;
					w = 0.1205 * safeZoneW;
					h = 0.0375 * safeZoneH;

					onButtonClick  = "[ 'MODE', 1 ] call NEB_fnc_Shop";

				};
				
				class BtnTwo: RscShortcutButton
				{
					idc = BTN_TWO_IDC;
					x = 0;
					y = 0.0385 * safeZoneH;
					w = 0.0800 * safeZoneW;
					h = 0.0375 * safeZoneH;

					colorBackground[] = {0.4,0.4,0.4,1};
					colorBackground2[] = {0.4,0.4,0.4,1};
					colorBackgroundFocused[] = {0.4,0.4,0.4,1};

					onButtonClick  = "[ 'MODE', 2 ] call NEB_fnc_Shop";

				};
				class BtnThree: BtnZero
				{
					idc = BTN_THREE_IDC;
					x = 0.081 * safeZoneW;
					y = 0.0385 * safeZoneH;
					w = 0.0800 * safeZoneW;
					h = 0.0375 * safeZoneH;

					onButtonClick  = "[ 'MODE', 3 ] call NEB_fnc_Shop";

				};
				class BtnFour: BtnZero
				{
					idc = BTN_FOUR_IDC;
					x = 0.162 * safeZoneW;
					y = 0.0385 * safeZoneH;
					w = 0.0800 * safeZoneW;
					h = 0.0375 * safeZoneH;

					onButtonClick  = "[ 'MODE', 4 ] call NEB_fnc_Shop";

				};
				
				class BckInfo: IGUIBack
				{
					idc = -1;
					x = 0;
					y = 0.081 * safeZoneH;
					w = 0.2425 * safeZoneW;
					h = 0.3015 * safeZoneH;
				};
				class InfoCtrlGrp : RscControlsGroup
				{
					x = 0.0055 * safeZoneW;
					y = 0.091 * safeZoneH;
					w = 0.2325 * safeZoneW;
					h = 0.2815 * safeZoneH;

					class VScrollbar
					{
						color[] = {1,1,1,0.25};
						width = 0.005;
						autoScrollEnabled = 1;
					};
					class HScrollbar
					{
						color[] = {1,1,1,1};
						height = 0;
					};
					class ScrollBar
					{
						color[] = {1,1,1,0.6};
						colorActive[] = {1,1,1,1};
						colorDisabled[] = {1,1,1,0.3};
						thumb = "#(argb,8,8,3)color(1,1,1,1)";
						arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
						arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
						border = "#(argb,8,8,3)color(1,1,1,0)";
					};

					class controls
					{
						class STxtItemInfo: RscStructuredText
						{
							idc = STXT_INFO_IDC;
							x = 0;
							y = 0;
							w = 0.23 * safeZoneW;
							h = 0.5 * safeZoneH;

							colorText[] = {1,1,1,1};
							colorBackground[] = {0.1,0.1,0.1,0.1};
							shadow = 0.75;
							size = 0.037;
							text = "";
						};
					};
				};
			};
		};
		
		class SixButtons : RscControlsGroup
		{
			idc = GRP_BTN_SIX;
			x = 0.5025 * safeZoneW + safeZoneX;
			y = 0.3125 * safeZoneH + safeZoneY;
			w = 0.2425 * safeZoneW;
			h = 0.3825 * safeZoneH;

			class VScrollbar
			{
				color[] = {1,1,1,0.25};
				width = 0;
				autoScrollEnabled = 1;
			};
			class HScrollbar
			{
				color[] = {1,1,1,1};
				height = 0;
			};
			class ScrollBar
			{
				color[] = {1,1,1,0.6};
				colorActive[] = {1,1,1,1};
				colorDisabled[] = {1,1,1,0.3};
				thumb = "#(argb,8,8,3)color(1,1,1,1)";
				arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
				arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
				border = "#(argb,8,8,3)color(1,1,1,0)";
			};
			
			class controls
			{
				class BtnZero: RscShortcutButton
				{
					idc = BTN_ZERO_IDC;
					x = 0;
					y = 0;
					w = 0.0800 * safeZoneW;
					h = 0.0375 * safeZoneH;

					colorBackground[] = {0.4,0.4,0.4,1};
					colorBackground2[] = {0.4,0.4,0.4,1};
					colorBackgroundFocused[] = {0.4,0.4,0.4,1};

					onButtonClick  = "[ 'MODE', 0 ] call NEB_fnc_Shop";

				};
				class BtnOne: BtnZero
				{
					idc = BTN_ONE_IDC;
					x = 0.081 * safeZoneW;
					y = 0;
					w = 0.0800 * safeZoneW;
					h = 0.0375 * safeZoneH;

					onButtonClick  = "[ 'MODE', 1 ] call NEB_fnc_Shop";

				};
				class BtnTwo: BtnZero
				{
					idc = BTN_TWO_IDC;
					x = 0.162 * safeZoneW;
					y = 0;
					w = 0.0800 * safeZoneW;
					h = 0.0375 * safeZoneH;

					onButtonClick  = "[ 'MODE', 2 ] call NEB_fnc_Shop";

				};
				
				class BtnThree: RscShortcutButton
				{
					idc = BTN_THREE_IDC;
					x = 0;
					y = 0.0385 * safeZoneH;
					w = 0.0800 * safeZoneW;
					h = 0.0375 * safeZoneH;

					colorBackground[] = {0.4,0.4,0.4,1};
					colorBackground2[] = {0.4,0.4,0.4,1};
					colorBackgroundFocused[] = {0.4,0.4,0.4,1};

					onButtonClick  = "[ 'MODE', 3 ] call NEB_fnc_Shop";

				};
				class BtnFour: BtnZero
				{
					idc = BTN_FOUR_IDC;
					x = 0.081 * safeZoneW;
					y = 0.0385 * safeZoneH;
					w = 0.0800 * safeZoneW;
					h = 0.0375 * safeZoneH;

					onButtonClick  = "[ 'MODE', 4 ] call NEB_fnc_Shop";

				};
				class BtnFive: BtnZero
				{
					idc = BTN_FIVE_IDC;
					x = 0.162 * safeZoneW;
					y = 0.0385 * safeZoneH;
					w = 0.0800 * safeZoneW;
					h = 0.0375 * safeZoneH;

					onButtonClick  = "[ 'MODE', 5 ] call NEB_fnc_Shop";

				};
				
				class BckInfo: IGUIBack
				{
					idc = -1;
					x = 0;
					y = 0.081 * safeZoneH;
					w = 0.2425 * safeZoneW;
					h = 0.3015 * safeZoneH;
				};
				class InfoCtrlGrp : RscControlsGroup
				{
					x = 0.0055 * safeZoneW;
					y = 0.091 * safeZoneH;
					w = 0.2325 * safeZoneW;
					h = 0.2815 * safeZoneH;

					class VScrollbar
					{
						color[] = {1,1,1,0.25};
						width = 0.005;
						autoScrollEnabled = 1;
					};
					class HScrollbar
					{
						color[] = {1,1,1,1};
						height = 0;
					};
					class ScrollBar
					{
						color[] = {1,1,1,0.6};
						colorActive[] = {1,1,1,1};
						colorDisabled[] = {1,1,1,0.3};
						thumb = "#(argb,8,8,3)color(1,1,1,1)";
						arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
						arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
						border = "#(argb,8,8,3)color(1,1,1,0)";
					};

					class controls
					{
						class STxtItemInfo: RscStructuredText
						{
							idc = STXT_INFO_IDC;
							x = 0;
							y = 0;
							w = 0.23 * safeZoneW;
							h = 0.5 * safeZoneH;

							colorText[] = {1,1,1,1};
							colorBackground[] = {0.1,0.1,0.1,0.1};
							shadow = 0.75;
							size = 0.037;
							text = "";
						};
					};
				};
			};
		};

		class BtnCancel: RscShortcutButton
		{
			idc = -1;
			x = 0.5025 * safeZoneW + safeZoneX;
			y = 0.7025 * safeZoneH + safeZoneY;
			w = 0.12 * safeZoneW;
			h = 0.0375 * safeZoneH;

			colorBackground[] = {0.5,0.5,0.5,0.5};
			colorBackground2[] = {0.1,0.1,0.1,0.1};
			colorBackgroundFocused[] = {0.1,0.1,0.1,1};
			text = "Cancel";

			onButtonClick  = "closeDialog 1;";

		};
		class BtnConfirm: BtnCancel
		{
			idc = BTN_BUY_IDC;
			x = 0.625 * safeZoneW + safeZoneX;
			y = 0.7025 * safeZoneH + safeZoneY;
			w = 0.12 * safeZoneW;
			h = 0.0375 * safeZoneH;

			colorDisabled[] = {	1, 0, 0, 0.5 };
			text = "Buy";

			onButtonClick  = "[ 'BUY' ] call NEB_fnc_Shop;";

		};
		
		
//		class Modal: RscControlsGroup
//		{
//			idc = GRP_MODAL;
//			x = safeZoneX;
//			y = safeZoneY;
//			w = safeZoneW;
//			h = safeZoneH;
//
//			class VScrollbar
//			{
//				color[] = {1,1,1,0.25};
//				width = 0;
//				autoScrollEnabled = 1;
//			};
//			class HScrollbar
//			{
//				color[] = {1,1,1,1};
//				height = 0;
//			};
//			class ScrollBar
//			{
//				color[] = {1,1,1,0.6};
//				colorActive[] = {1,1,1,1};
//				colorDisabled[] = {1,1,1,0.3};
//				thumb = "#(argb,8,8,3)color(1,1,1,1)";
//				arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
//				arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
//				border = "#(argb,8,8,3)color(1,1,1,0)";
//			};
//			
//			class controls
//			{
//				class BckFullScreen: IGUIBack
//				{
//					idc = -1;
//					x = safeZoneX;
//					y = safeZoneY;
//					w = safeZoneW;
//					h = safeZoneH;
//					
//					colorBackground[] = {0.1,0.1,0.1,0.4};
//				};
//				class BckModal: BckFullScreen
//				{
//					idc = -1;
//					x = 0.37;
//					y = 0.37;
//					w = 0.26 * safeZoneW;
//					h = 0.26 * safeZoneH;
//				};
//				class PicModal: RscPicture
//				{
//					idc = PIC_MODAL_IDC;
//					style = 0x30 + 0x800; //Style picture + Keep aspect ratio
//					x = 0.2575 * safeZoneW + safeZoneX;
//					y = 0.26 * safeZoneH + safeZoneY;
//					w = 0.05 * safeZoneW;
//					h = 0.045* safeZoneH;
//
//					colorBackground[] = {0,0,0,1};
//					sizeEx = 0.1;
//				};
//			};
//		};
	};

};