class playerInfo {

	idd = 20000;
	duration = 1e10;
	fadein = 0;
	fadeout = 0;
	onLoad = "uiNamespace setVariable [ 'UIplayerInfo', _this select 0 ]; [] call fnc_updateStats;";

	class controls {

		class infoBackground: RscBackground
		{
			idc = -1;
			x = 0.2 * safezoneW + safezoneX;
			y = 0.919845 * safezoneH + safezoneY;
			w = 0.6 * safezoneW;
			h = 0.0329884 * safezoneH;

			ColorBackground[] = {0, 0, 0, 0};
		};

		class infoFrame: RscFrame
		{
			idc = -1;
			x = 0.2 * safezoneW + safezoneX;
			y = 0.919845 * safezoneH + safezoneY;
			w = 0.6 * safezoneW;
			h = 0.0329884 * safezoneH;

			ColorText[] = {0, 0, 0, 0};
		};

		class level: RscText
		{
			idc = 1000;
			sizeEx = 0.055;
			x = "SafeZoneX + (1800 / 1920) * SafeZoneW";
			y = "SafeZoneY + (1005 / 1080) * SafeZoneH";
			w = "(120 / 1920) * SafeZoneW";
			h = "(29.9999999999997 / 1080) * SafeZoneH";
			ColorText[] = {0.9, 0.9, 0.9, 0.9};
			style = "0x02";
		};

		class progressBar: RscProgress
		{
			idc = 1002;
			x = "SafeZoneX + (1800 / 1920) * SafeZoneW";
			y = "SafeZoneY + (1035 / 1080) * SafeZoneH";
			w = "(120 / 1920) * SafeZoneW";
			h = "(14.9999999999995 / 1080) * SafeZoneH";

			colorBar[] = {0.9,0.9,0.63,0.8};
			texture = "#(argb,8,8,3)color(0.75,0.75,0.75,0.75)";
		};
		
		class progress: RscText
		{
			idc = 1001;
			sizeEx = 0.02;
			x = "SafeZoneX + (1800 / 1920) * SafeZoneW";
			y = "SafeZoneY + (1035 / 1080) * SafeZoneH";
			w = "(120 / 1920) * SafeZoneW";
			h = "(14.9999999999995 / 1080) * SafeZoneH";
			ColorText[] = {1, 1, 1, 1};
			style = "0x02";
		};
		

		class cash: RscText
		{
			idc = 1003;
			sizeEx = 0.042;
			x = "SafeZoneX + (1800 / 1920) * SafeZoneW";
			y = "SafeZoneY + (990 / 1080) * SafeZoneH";
			w = "(120 / 1920) * SafeZoneW";
			h = "(14.9999999999999 / 1080) * SafeZoneH";
			
			ColorText[] = {0.36, 0.8, 0.3, 0.85};
			style = "0x02";
		};

		class kills: RscText
		{
			idc = 1004;
			x = "SafeZoneX + (1395 / 1920) * SafeZoneW";
			y = "SafeZoneY + (0 / 1080) * SafeZoneH";
			w = "(89.9999999999999 / 1920) * SafeZoneW";
			h = "(15 / 1080) * SafeZoneH";
			ColorText[] = {0.9, 0.9, 0.9, 0.9};
			style = "0x02";
		};
		
		class redScore: RscText
		{
			idc = 1005;
			x = "SafeZoneX + (1320 / 1920) * SafeZoneW";
			y = "SafeZoneY + (0 / 1080) * SafeZoneH";
			w = "(59.9999999999999 / 1920) * SafeZoneW";
			h = "(15 / 1080) * SafeZoneH";
			colorBackground[] = {1, 0.1, 0.1, 0.7};
			ColorText[] = {0.9, 0.9, 0.9, 0.9};
			style = "0x02";
		};
		
		class bluScore: RscText
		{
			idc = 1006;
			x = "SafeZoneX + (480 / 1920) * SafeZoneW";
			y = "SafeZoneY + (0 / 1080) * SafeZoneH";
			w = "(60 / 1920) * SafeZoneW";
			h = "(15 / 1080) * SafeZoneH";
			colorBackground[] = {0.1, 0.1, 1, 0.7};
			ColorText[] = {0.9, 0.9, 0.9, 0.9};
			style = "0x02";
		};
		
		class bluBar: RscProgress
		{
			idc = 1007;
			y = "SafeZoneY + (0 / 1080) * SafeZoneH";
			x = "SafeZoneX + (540 / 1920) * SafeZoneW";
			w = "(360 / 1920) * SafeZoneW";
			h = "(15 / 1080) * SafeZoneH";

			colorBar[] = {0.1, 0.1, 1, 0.8};
			texture = "#(argb,8,8,3)color(0.75,0.75,0.75,0.75)";
		};
		
		class redBar: RscProgress
		{
			idc = 1008;
			x = "SafeZoneX + (960 / 1920) * SafeZoneW";
			y = "SafeZoneY + (0 / 1080) * SafeZoneH";
			w = "(360 / 1920) * SafeZoneW";
			h = "(15 / 1080) * SafeZoneH";

			colorBar[] = {1, 0.1, 0.1, 0.8};
			texture = "#(argb,8,8,3)color(0.75,0.75,0.75,0.75)";
		};
		
		class endScore: RscText
		{
			idc = 1009;
			x = "SafeZoneX + (900 / 1920) * SafeZoneW";
			y = "SafeZoneY + (1.24344978758018E-14 / 1080) * SafeZoneH";
			w = "(60 / 1920) * SafeZoneW";
			h = "(15 / 1080) * SafeZoneH";
			ColorText[] = {0.9, 0.9, 0.9, 0.9};
			style = "0x02";
		};
		
		class healthBar: RscProgress
		{
			idc = 1010;
			x = "SafeZoneX + (1800 / 1920) * SafeZoneW";
			y = "SafeZoneY + (1050 / 1080) * SafeZoneH";
			w = "(120 / 1920) * SafeZoneW";
			h = "(30.0000000000002 / 1080) * SafeZoneH";

			colorBar[] = {1, 0.1, 0.1, 0.7};
			texture = "#(argb,8,8,3)color(0.75,0.75,0.75,0.75)";
		};
		
		class healthIcon: RscText
		{
			
			idc = 1011;
			type = CT_STATIC;
			style = 48;//ST_PICTURE
			text = "\A3\ui_f\data\igui\cfg\actions\heal_ca.paa";
			x = "SafeZoneX + (1845 / 1920) * SafeZoneW";
			y = "SafeZoneY + (1050 / 1080) * SafeZoneH";
			w = "(30 / 1920) * SafeZoneW";
			h = "(30.0000000000002 / 1080) * SafeZoneH";
			ColorText[] = {0.9, 0.9, 0.9, 0.7};
		};
		
		class displayFPS: RscText
		{
			idc = 1012;
			text = "FPS : 0"; //--- ToDo: Localize;
			x = "SafeZoneX + (1485 / 1920) * SafeZoneW";
			y = "SafeZoneY + (0 / 1080) * SafeZoneH";
			w = "(89.9999999999999 / 1920) * SafeZoneW";
			h = "(15 / 1080) * SafeZoneH";
			ColorText[] = {0.9, 0.9, 0.9, 0.9};
			style = "0x02";
		};

	};
};