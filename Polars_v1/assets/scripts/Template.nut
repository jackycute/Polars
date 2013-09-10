const FPS = 60.0;

local stage = emo.Stage;
local event = emo.Event;
local physics = emo.Physics;

class Main {
    function onLoad() {
        print("onLoad");
        
        event.registerSensors(SENSOR_TYPE_ACCELEROMETER);
        
        // Set OnDrawCallback interval (millisecond)
        event.enableOnDrawCallback(1000.0 / FPS);
    }

    function onGainedFocus() {
        print("onGainedFocus");
        event.enableSensor(SENSOR_TYPE_ACCELEROMETER, 100);
    }

    /*
     * Called when the app has lost focus
     */
    function onLostFocus() {
        print("onLostFocus"); 
        event.disableSensor(SENSOR_TYPE_ACCELEROMETER);
    }

    /*
     * Called when the class ends
     */
    function onDispose() {
        print("onDispose");

    }

    function onDrawFrame(dt) {

    }
    
    /*
     * sensor event
     */
    function onSensorEvent(sevent) {

    }
    
    /*
     * drop boxes at touch event.
     */
    function onMotionEvent(mevent) {

    }

    function onFps(fps) {
        print(format("FPS: %4.2f", fps));
    }
    
    function onLowMemory() {
        print("onLowMemory: too many sprites");

    }
}

function emo::onLoad() {
	emo.Stage.load(Main());
}