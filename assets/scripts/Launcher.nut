EMO_PATH				<- "emo-framework/";

SYSTEM_PATH 			<- "System/";
TILEINFO_PATH			<- "TileInfo/";
OBJECTINFO_PATH			<- "ObjectInfo/";
ITEMINFO_PATH			<- "ItemInfo/";
LEVELS_PATH 			<- "Levels/";

BASE_PATH				<- "System/Base/";
CHARACTER_PATH			<- "System/Character/";
UI_PATH					<- "System/UI/";

Debug					<- true;

emo.Runtime.import(SYSTEM_PATH + "Common.nut");

emo.Runtime.setOptions(OPT_ORIENTATION_LANDSCAPE);
emo.Runtime.setOptions(OPT_WINDOW_FORCE_FULLSCREEN);
emo.Runtime.setOptions(OPT_ENABLE_PERSPECTIVE_NICEST);
emo.Runtime.setOptions(OPT_WINDOW_KEEP_SCREEN_ON);

function emo::onLoad() {
	director.LoadCurrentLevel();
}