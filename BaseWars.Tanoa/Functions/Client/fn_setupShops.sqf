{
	_x params[ "_trig" ];
	_x call NEB_fnc_shopInit;
}forEach [ 
	[ [ east, west ], civ, "Gao Choy weapon", ["WEAPON","ATTACH","GEAR"], true ],
	[ [ east, west ], merc, "Luo Lin weapon", ["WEAPON","ATTACH","GEAR"], true ],
	[ [ east, west ], civB, "Shen Wong weapon", ["WEAPON","ATTACH","GEAR"], true ],
	[ [ east, west ], device, "Tele", "ALL", true ],
	[ [ east, west ], laptop, "Vehicle", "VEHICLE", true ],
	[ [ east, west ], deviceO, "Tele", "ALL", true ],
	[ [ east, west ], laptopB, "Vehicle", "VEHICLE", true ],
	[ [ east, west ], deviceCivA, "Tele", "ALL", true ],
	[ [ east, west ], deviceCivB, "Tele", "ALL", true ]
];