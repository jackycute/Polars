stage      			<- emo.Stage;
physics				<- emo.Physics;
event      			<- emo.Event;
runtime    			<- emo.Runtime;
database   			<- emo.Database;
preference 			<- emo.Preference;

const MAP_BLOCK_SIZE 				= 32;
const DESIGNED_RESOLUTION_HEIGHT 	= 480.0;
const DESIGNED_RESOLUTION_WIDTH 	= 800.0;

ScreenWidth 		<- stage.getWindowWidth();
ScreenHeight 		<- stage.getWindowHeight();

print(format("SCREEN WIDTH = %d, HEIGHT = %d", ScreenWidth, ScreenHeight));

enum GAME_STATE {
	NOTHING,
	LOADING,
	PLOTING,
	PLAYING,
	PAUSING,
	SUCCESS,
	FAILED,
	STOPING
}

runtime.import(EMO_PATH + "physics.nut");

runtime.import(BASE_PATH + "GeneralFunctions.nut");
runtime.import(BASE_PATH + "View.nut");
runtime.import(BASE_PATH + "Timer.nut");
runtime.import(BASE_PATH + "Sensor.nut");
runtime.import(BASE_PATH + "Gesture.nut");
runtime.import(BASE_PATH + "TextSprite.nut");
runtime.import(BASE_PATH + "TMXMapSprite.nut");
runtime.import(BASE_PATH + "SkinObject.nut");

runtime.import(CHARACTER_PATH + "Bear.nut");


runtime.import(UI_PATH + "Panel.nut");
runtime.import(UI_PATH + "Button.nut");
runtime.import(UI_PATH + "MenuBar.nut");
runtime.import(UI_PATH + "ItemMenu.nut");
runtime.import(UI_PATH + "UI.nut");

runtime.import(SYSTEM_PATH + "Manager.nut");
runtime.import(SYSTEM_PATH + "Layer.nut");

runtime.import(SYSTEM_PATH + "RecycleRobot.nut");
runtime.import(SYSTEM_PATH + "Event.nut");
runtime.import(SYSTEM_PATH + "TileSet.nut");
runtime.import(SYSTEM_PATH + "ObjectSet.nut");
runtime.import(SYSTEM_PATH + "ItemSet.nut");
runtime.import(SYSTEM_PATH + "ScriptList.nut");
runtime.import(SYSTEM_PATH + "Director.nut");
runtime.import(SYSTEM_PATH + "Loader.nut");