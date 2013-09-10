class Loader {
	loading = null;//emo.FontSprite("loading", 50, "GOTHICB"); 
	progress = 0;
	
	stageWidth = stage.getWindowWidth();
	stageHeight = stage.getWindowHeight();
	function onLoad() {
        print("Loader::onLoad");
        
        //getMuteStatus();
        
        director.setGameState(GAME_STATE.LOADING);
		
		progress = 0;
		
		loading = emo.TextSprite("default_font_32x48.png",
        " !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~",
        32, 48, 0, 0);
		
		loading.setAsGui();
		loading.load();
		loading.move((stageWidth - loading.getWidth())/2, (stageHeight - loading.getHeight())/2);
		
        // Set OnDrawCallback interval (millisecond)
        event.enableOnDrawCallback(1000.0 / fps);
    }

    function onGainedFocus() {
        print("Loader::onGainedFocus");

		loading.show();
    }

    /*
     * Called when the app has lost focus
     */
    function onLostFocus() {
        print("Loader::onLostFocus"); 

		loading.hide();
    }

    /*
     * Called when the class ends
     */
    function onDispose() {
        print("Loader::onDispose");

		loading.remove();
    }
    function onDrawFrame(dt) {
		if(progress < 100) {
			//if(progress == 0) Current_Level_Function.onLoad();
			progress += 50;
			//loading.setParam(progress + "%");
			//loading.reload();
			loading.setText("Loading..." + progress + "%");
			loading.move((stageWidth - loading.getWidth())/2, (stageHeight - loading.getHeight())/2);
		} else {
			//event.disableOnDrawCallback();
			loading.remove();
			//local fadeIn = emo.AlphaModifier(0, 1, 1000, emo.easing.Linear);
			//local fadeOut = emo.AlphaModifier(1, 0, 1000, emo.easing.Linear);
			
            stage.load(Current_Level_Function);
		}
    }
}