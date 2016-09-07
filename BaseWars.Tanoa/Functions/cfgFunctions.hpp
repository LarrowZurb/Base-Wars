class NEB_BaseWars
{
	tag = "NEB"; // Functions tag.  Functions will be called as [] call neb_fnc_addBounty
	class coreFunctions
	{
		// Since these are called from a file they'll be called by their names in the file, ie, neb_fnc_core_disableStamina
		class coreFunctions {file = "functions\coreFunctions.sqf"; description = "core functions, called on mission start."; preInit = 1;};
	};
	
	//********
	//Client
	//********
	class Client
	{
		file = "functions\Client";
		class playerEHs {};
	};
	
	class CashAndRewards
	{
		file = "functions\Client\CashAndRewards";
		class levelUpRewards {};
	};
	
	class StatsAndVars
	{
		file = "functions\Client\StatsAndVars";
		class clearStats {};
		class getPlayerVar {};
		class profileVars {};
		class updateStats {};
	};
	
	class SuitAndEffects
	{
		file = "functions\Client\SuitAndEffects";		
	};
	
	class UI
	{
		file = "functions\Client\UI";
		class initStatUI { postInit = 1 };
		class messageTicker { postInit = 1; };
		class showMessage {};
		class updateScores {};
	};
	
	
	
	//********
	//Server
	//********
	class Server
	{
		file = "functions\Server";
		class serverEhs {};
		class startScores {};
	};
	
	
	
	//Old
	class functions
	{
		file = "functions"; // Folder where individual function files are stored.
		class addBounty {}; 
		class payBounty {};

	};
};