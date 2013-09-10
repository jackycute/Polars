DEFAULT_LEVEL_ID			<- 2;
Current_Level_Id			<- DEFAULT_LEVEL_ID;
Current_Level_Function		<- null;

LEVEL_INFO <- {
	[-1] = {	rawname = "LevelTemplate.nut",
				name = "Empty"					},
				
	[0] = {		rawname = "TestChamber.nut",
				name = "Test Chamber"			},
				
	[1] = {		rawname = "Level101.nut",
				name = "Level 101"				},
				
	[2] = {		rawname = "Test.nut",
				name = "Ice Forge"				}
}

function LoadScript(level_id) {
	// fade out current scene and move in next scene
	//local fadeIn = emo.AlphaModifier(0, 1, 1000, emo.easing.Linear);
	//local fadeOut = emo.AlphaModifier(1, 0, 1000, emo.easing.Linear);

	Current_Level_Id = level_id;
	runtime.import(LEVELS_PATH + LEVEL_INFO[level_id].rawname);
	
	print(format("Load Level: RawName = %s, Name = %s", LEVEL_INFO[level_id].rawname, LEVEL_INFO[level_id].name));
	local loader = Loader();
	stage.load(loader);
}