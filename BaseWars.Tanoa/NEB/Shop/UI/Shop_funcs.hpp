class NEB_Shop
{
	tag = "NEB";
	class Shop
	{
		file = "NEB\Shop\UI\functions";
		class shop {};
		class shopInit {};
		class shopCrate {};
	};
	
	class ShopTypes
	{
		file = "NEB\Shop\UI\functions\shops";
		class initAvailableShops { preInit = 1; }; //Open this file and add a reference to each shop you add
	};
	
	//Shops - add a new class for each shop you add, with an include to its functions library
	class ShopVehicle
	{
		#include "functions\shops\vehicle\vehicleFuncs.hpp"		
	};
	class ShopWeapon
	{
		#include "functions\shops\weapon\weaponFuncs.hpp"
	};
	class ShopAttach
	{
		#include "functions\shops\attach\attachFuncs.hpp"
	};
	class ShopGear
	{
		#include "functions\shops\gear\gearFuncs.hpp"
	};
	
	
	//Leave at bottom
	class ShopSell
	{
		#include "functions\shops\sell\SellFuncs.hpp"
	};
};