// ARJAY LIB SETUP -------------------------------------------------------------------------------------------

// inlcude the arjay script library
#include "arjay\arjay_kickstart.sqf"


// EXAMPLE MISSION SETTINGS -------------------------------------------------------------------------------------------

// SIMPLE TASK SYSTEM EXAMPLES

[] spawn
{
	// wait 3 seconds on mission start to issue the first task
	sleep 3;
	
	// when the mission starts give the player a task to walk to the position of a marker
	// once the task is completed call back to a function called task1Complete
	// when the player is within 50 meters of the marker the task will be completed
	[player, "villagePositionMarker", "Go to Agios Ioannis", "Go to the village Agios Ioannis", "task1Complete", 50] call arjay_moveToTask;
};

task1Complete = 
{
	// create a new task to walk to the position of a target object (uncleBob)
	// once the task is completed call back to a function called task2Complete
	// when the player is within 2 meters of uncleBob the task will be completed
	[player, uncleBob, "Visit Uncle Bob", "Go and see your Uncle Bob in his house", "task2Complete", 2] call arjay_moveToTask;
};

task2Complete = 
{
	private ["_tablePosition", "_tableMaxWorldBounds"];

	// spawn the pistol on top of the table
	_tablePosition = getPosATL kitchenTable;
	_tableMaxWorldBounds = kitchenTable modelToWorld (boundingBox kitchenTable select 1);
	_tablePosition set [2, _tableMaxWorldBounds select 2];
	[_tablePosition, 180, "hgun_Rook40_F", "16Rnd_9x21_Mag"] call arjay_createWeapon;
	
	// create a new task to acquire an item
	// once the task is completed call back to a function called task3Complete
	// when the player has an item of class hgun_Rook40_F in their inventory the task will be completed
	[player, kitchenTable, "hgun_Rook40_F", "Get the pistol", "Uncle Bob wants you to grab his pistol", "task3Complete"] call arjay_requireItemTask;
};

task3Complete = 
{
	// create a new task to walk to the position of a target object (uncleBob)
	// once the task is completed call back to a function called task4Complete
	// when the player is within 2 meters of uncleBob the task will be completed
	[player, uncleBob, "See Uncle Bob", "Return to Uncle Bob", "task4Complete", 2] call arjay_moveToTask;
};

task4Complete = 
{
	// create a new task to elimate a target unit (theo)
	// once the task is completed call back to a function called task5Complete
	[player, theo, "Kill Theo", "Uncle Bob is tired of Theo, kill him", "task5Complete"] call arjay_eliminateTargetTask;
};

task5Complete = 
{
	// move uncle bob to his car
	uncleBob moveInCargo uncleBobsCar;
		
	// create a new task to be within a vehicle
	// once the task is completed call back to a function called task6Complete
	[player, uncleBobsCar, "Get to the car", "Escape with Uncle Bob in his car", "task6Complete"] call arjay_getInVehicleTask;
};

task6Complete = 
{
	// when the player is within 50 meters of the marker the task will be completed
	[player, "village2PositionMarker", "Escape", "Escape to the village Agios Cephas", "task7Complete", 50] call arjay_moveToTask;
};

task7Complete = 
{
	// mission complete
	["END1", true, 2] call BIS_fnc_endMission;
};


// disable AI on example units so they don't run away
[UncleBob] call arjay_disableAI;
[Theo] call arjay_disableAI;