#include "..\..\shopMacros.hpp"

private[ "_cfg" ];
params[ "_className" ];

//Path to our selected items config
switch ( true ) do {
	//Backpack
	case ( isClass( configFile >> "CfgVehicles" >> _className ) ) : {
		_cfg = configFile >> "CfgVehicles" >> _className;
	};
	//Facewear
	case ( isClass( configFile >> "CfgGlasses" >> _className ) ) : {
		_cfg = configFile >> "CfgGlasses" >> _className;
	};
	//Everything else
	default {
		_cfg = configFile >> "CfgWeapons" >> _className;
	};
};
_dataCfg = missionConfigFile >> format[ "NEB_%1Data", NEB_currentShop ] >> _classname;

//Utility Functions

private _fnc_getProtectionStats = {
	
	//Set a section label and headings for area and armor
	_protectionValues = "";
	{
		
		//If it has an armor value
		if ( isNumber( _x >> "armor" ) ) then {
			
			//Get the class name( protected area ) 
			_area = configName _x;
			//Get the amount of protection it provides
			_protection = getNumber( _x >> "armor" );
			
			if !( _protection isEqualTo 0 ) then {
				//Add new line to our output text
				_protectionValues = _protectionValues + format[ "<t align='center'>%1 - %2</t><br/>", _area, _protection ];
			};
		};
		
		//foreach class under HitpointsProtectionInfo
	}forEach ( "true"configClasses( _cfg >> "itemInfo" >> "HitpointsProtectionInfo" ) );
	
	if ( _protectionValues != "" ) then {
		_protectionValues = "<t align='center' underline='true'>area - armor</t><br/>" + _protectionValues;
	};
	
	_protectionValues
};

private _fnc_getContainerLoad = {
	
	_contClass = getText( _cfg >> "ItemInfo" >> "containerClass" );
	_load = getNumber( configFile >> "CfgVehicles" >> _contClass >> "maximumLoad" );
	
	_load	
};


switch ( NEB_currentButton ) do {
	
	//Uniform
	case ( 0 ) : {
		
		UICTRL( STXT_INFO_IDC ) ctrlSetStructuredText parseText format [
			"<t align='center' size='1.5'>%1</t><br/><br/>
			<t align='center' size='6' ><img image=%2 /></t><br/><br/>
			<t align='center'>Weight: %3    Max Load: %4</t><br/>
			<t align='center' size='1.5'>%5</t>",
			getText( _cfg >> "displayName" ),
			str getText( _cfg >> "Picture"),
			getNumber( _cfg >> "ItemInfo" >> "mass" ),
			[] call _fnc_getContainerLoad,
			getText( _dataCfg >> "note" )
			
		];

	};
	
	//Vest
	case ( 1 ) : {
		
		UICTRL( STXT_INFO_IDC ) ctrlSetStructuredText parseText format [
			"<t align='center' size='1.5'>%1</t><br/><br/>
			<t align='center' size='6' ><img image=%2 /></t><br/><br/>
			<t align='center'>Weight: %3    Max Load: %4</t><br/><br/>
			<t align='left'>%5</t><br/>
			<t align='left'>Protection:     %6</t><br/><br/>
			%7",
			getText( _cfg >> "displayName" ),
			str getText( _cfg >> "Picture"),
			getNumber( _cfg >> "ItemInfo" >> "mass" ),
			[] call _fnc_getContainerLoad,			    	
			"---------------------------------------------------------------------------------",
			getText( _cfg >> "descriptionShort" ),
			[] call _fnc_getProtectionStats
		];
	};
	
	//Backpack
	case ( 2 ) : {
		
		_supplies = "";
		{
			{
				_item = getText( _x >> "name" );
				_itemCount = getNumber( _x >> "count" );
				_pic = if ( isClass( configFile >> "CfgMagazines" >> _item ) ) then {
					getText( configFile >> "CfgMagazines" >> _item >> "picture" )
				}else{
					getText( configFile >> "CfgWeapons" >> _item >> "picture" )
				};
				_supplies = format[ "%1<t align='center'>%2:</t><t size='1.2' align='right'>%3 of <img image=%4 /></t><br/>", _supplies, _item, _itemCount, _pic ];
			}forEach ( "true"configClasses( _cfg >> _x ) );
		}forEach[
			"TransportItems",
			"TransportMagazines",
			"TransportWeapons"
		];
		
		if ( _supplies != "" ) then {
			_supplies = "<t align='left'>Supplied with:</t><br/>" + _supplies;
		};
		
		_assembleInfo = "";
		if ( isClass( _cfg >> "assembleInfo" ) ) then {
			_assem = getText( _cfg >> "assembleInfo" >> "assembleTo" );
			_assemName = getText( _cfg >> "assembleInfo" >> "displayName" );
			_pic = {
				if ( isClass( configFile >> _x >> _assem ) ) exitWith {
					getText( configFile >> _x >> _assem >> "picture" ) 
				};
			}forEach[ "CfgVehciles", "CfgWeapons" ];
			
			_assembleInfo = format[ "
				<t align='left'>Assembles to:</t><br/>
				<t align='center'>%1</t></br>
				<t size='2' align='center'><img image=%2 /></t><br/>",
				_assemName,
				str _pic
			];
		};
		
		UICTRL( STXT_INFO_IDC ) ctrlSetStructuredText parseText format [
			"<t align='center' size='1.5'>%1</t><br/><br/>
			<t align='center' size='6' ><img image=%2 /></t><br/><br/>
			<t align='center'>Weight: %3    Max Load: %4</t><br/>
			<t align='left'>%5</t><br/>
			<t align='left'>%6</t><br/>
			<t align='left'>%5</t><br/>
			<t align='left'>%7</t><br/>",
			getText( _cfg >> "displayName" ),
			str getText( _cfg >> "Picture"),
			getNumber( _cfg >> "mass" ),
			getNumber( _cfg >> "maximumLoad" ),
			"---------------------------------------------------------------------------------",
			_supplies,
			_assembleInfo
		];

	};
	
	//Helmet
	case ( 3 ) : {
		
		UICTRL( STXT_INFO_IDC ) ctrlSetStructuredText parseText format [
			"<t align='center' size='1.5'>%1</t><br/><br/>
			<t align='center' size='6' ><img image=%2 /></t><br/><br/>
			<t align='center'>Weight: %3</t><br/>
			<t align='left'>%4</t><br/>
			<t align='left'>Protection:     %5</t><br/><br/>
			%6",
			getText( _cfg >> "displayName" ),
			str getText( _cfg >> "Picture"),
			getNumber( _cfg >> "ItemInfo" >> "mass" ),		    	
			"---------------------------------------------------------------------------------",
			getText( _cfg >> "descriptionShort" ),
			[] call _fnc_getProtectionStats
		];
	};
	
	//Facewear
	case ( 4 ) : {
		
		UICTRL( STXT_INFO_IDC ) ctrlSetStructuredText parseText format [
			"<t align='center' size='1.5'>%1</t><br/>
			<t align='center' size='6' ><img image=%2 /></t><br/>
			<t align='center'>Weight: %3</t><br/>
			<t align='center'>%4</t><br/>",
			getText( _cfg >> "displayName" ),
			str getText( _cfg >> "Picture"),
			getNumber( _cfg >> "mass" ),
			getText( _dataCfg >> "note" )
		];
	};
	
	//NVG
	case ( 5 ) : {
		
		
		_visionModes = "";
		{
			_visionModes = format[ "%1%2, ", _visionModes, _x ];
		}forEach getArray( configFile >> "CfgWeapons" >> _classname >> "visionMode" );

		UICTRL( STXT_INFO_IDC ) ctrlSetStructuredText parseText format [
			"<t align='center' size='1.5'>%1</t><br/>
			<t align='center' size='6' ><img image=%2 /></t><br/>
			<t align='center'>Weight: %3</t><br/>
			<t align='left'>%4</t><br/>
			<t align='left'>Vision Modes:<t/><br/>
			<t align='center'>%5</t><br/>
			<t align='left'>%4</t><br/>
			<t align='center'>%6</t><br/>
			<t align='left'>%4</t><br/>",
			getText( _cfg >> "displayName" ),
			str getText( _cfg >> "Picture"),
			getNumber( _cfg >> "ItemInfo" >> "mass" ),
			"---------------------------------------------------------------------------------",
			_visionModes,
			getText( _cfg >> "Library" >> "libTextDesc" )
		];

	};
};