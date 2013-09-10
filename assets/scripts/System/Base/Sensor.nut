SENSOR_TYPE_ACCELEROMETER_KEY 		<- "Accelerometer";
SENSOR_TYPE_MAGNETIC_FIELD_KEY     	<- "MagnecticField";
SENSOR_TYPE_GYROSCOPE_KEY          	<- "Gyroscope";
SENSOR_TYPE_LIGHT_KEY              	<- "Light";
SENSOR_TYPE_PROXIMITY_KEY          	<- "Proximity";
SENSOR_DEFAULT_UPDATE_INTERVAL		<- 100;

class SensorDetector {
	ListenerTable = {};
	constructor() {
		ListenerTable.clear();
	}
	function onSensorEvent(sevent) {
		switch(sevent.getType()) {
			case SENSOR_TYPE_ACCELEROMETER:
				if(ListenerTable.rawin(SENSOR_TYPE_ACCELEROMETER_KEY))
					for(local i=0; i<ListenerTable.Accelerometer.len(); i++)
						ListenerTable.Accelerometer[i].onCall(sevent);
			break;
			case SENSOR_TYPE_MAGNETIC_FIELD:
				if(ListenerTable.rawin(SENSOR_TYPE_MAGNETIC_FIELD_KEY))
					for(local i=0; i<ListenerTable.MagnecticField.len(); i++)
						ListenerTable.MagnecticField[i].onCall(sevent);
			break;
			case SENSOR_TYPE_GYROSCOPE:
				if(ListenerTable.rawin(SENSOR_TYPE_GYROSCOPE_KEY))
					for(local i=0; i<ListenerTable.Gyroscope.len(); i++)
						ListenerTable.Gyroscope[i].onCall(sevent);
			break;
			case SENSOR_TYPE_LIGHT:
				if(ListenerTable.rawin(SENSOR_TYPE_LIGHT_KEY))
					for(local i=0; i<ListenerTable.Light.len(); i++)
						ListenerTable.Light[i].onCall(sevent);
			break;
			case SENSOR_TYPE_PROXIMITY:
				if(ListenerTable.rawin(SENSOR_TYPE_PROXIMITY_KEY))
					for(local i=0; i<ListenerTable.Proximity.len(); i++)
						ListenerTable.Proximity[i].onCall(sevent);
			break;
		}
	}
	function registerSensors() {
		if (emo.Runtime.isSimulator()) {
            error("This program cannot run on the simulator.");
        } else {
        	if(ListenerTable.rawin(SENSOR_TYPE_ACCELEROMETER_KEY)) event.registerSensors(SENSOR_TYPE_ACCELEROMETER);
            if(ListenerTable.rawin(SENSOR_TYPE_MAGNETIC_FIELD_KEY)) event.registerSensors(SENSOR_TYPE_MAGNETIC_FIELD);
            if(ListenerTable.rawin(SENSOR_TYPE_GYROSCOPE_KEY)) event.registerSensors(SENSOR_TYPE_GYROSCOPE);
            if(ListenerTable.rawin(SENSOR_TYPE_LIGHT_KEY)) event.registerSensors(SENSOR_TYPE_LIGHT);
            if(ListenerTable.rawin(SENSOR_TYPE_PROXIMITY_KEY)) event.registerSensors(SENSOR_TYPE_PROXIMITY);
        }
	}
	function enableSensors(_interval = SENSOR_DEFAULT_UPDATE_INTERVAL) {
		if (!emo.Runtime.isSimulator()) {
			if(ListenerTable.rawin(SENSOR_TYPE_ACCELEROMETER_KEY)) event.enableSensor(SENSOR_TYPE_ACCELEROMETER, _interval);
            if(ListenerTable.rawin(SENSOR_TYPE_MAGNETIC_FIELD_KEY)) event.enableSensor(SENSOR_TYPE_MAGNETIC_FIELD, _interval);
            if(ListenerTable.rawin(SENSOR_TYPE_GYROSCOPE_KEY)) event.enableSensor(SENSOR_TYPE_GYROSCOPE, _interval);
            if(ListenerTable.rawin(SENSOR_TYPE_LIGHT_KEY)) event.enableSensor(SENSOR_TYPE_LIGHT, _interval);
            if(ListenerTable.rawin(SENSOR_TYPE_PROXIMITY_KEY)) event.enableSensor(SENSOR_TYPE_PROXIMITY, _interval);	
        }
	}
	function disableSensors() {
		if (!emo.Runtime.isSimulator()) {
			if(ListenerTable.rawin(SENSOR_TYPE_ACCELEROMETER_KEY)) event.disableSensor(SENSOR_TYPE_ACCELEROMETER);
            if(ListenerTable.rawin(SENSOR_TYPE_MAGNETIC_FIELD_KEY)) event.disableSensor(SENSOR_TYPE_MAGNETIC_FIELD);
            if(ListenerTable.rawin(SENSOR_TYPE_GYROSCOPE_KEY)) event.disableSensor(SENSOR_TYPE_GYROSCOPE);
            if(ListenerTable.rawin(SENSOR_TYPE_LIGHT_KEY)) event.disableSensor(SENSOR_TYPE_LIGHT);
            if(ListenerTable.rawin(SENSOR_TYPE_PROXIMITY_KEY)) event.disableSensor(SENSOR_TYPE_PROXIMITY);
        }
	}
	function addAccelerometerListener(listener) {
		if(ListenerTable.rawin(SENSOR_TYPE_ACCELEROMETER_KEY)) ListenerTable.Accelerometer.append(listener);
		else ListenerTable.rawset(SENSOR_TYPE_ACCELEROMETER_KEY, [listener]);
	}
	function addMagnecticFieldListener(listener) {
		if(ListenerTable.rawin(SENSOR_TYPE_MAGNETIC_FIELD_KEY)) ListenerTable.MagnecticField.append(listener);
		else ListenerTable.rawset(SENSOR_TYPE_MAGNETIC_FIELD_KEY, [listener]);
	}
	function addGyroscopeListener(listener) {
		if(ListenerTable.rawin(SENSOR_TYPE_GYROSCOPE_KEY)) ListenerTable.Gyroscope.append(listener);
		else ListenerTable.rawset(SENSOR_TYPE_GYROSCOPE_KEY, [listener]);	
	}
	function addLightListener(listener) {
		if(ListenerTable.rawin(SENSOR_TYPE_LIGHT_KEY)) ListenerTable.Light.append(listener);
		else ListenerTable.rawset(SENSOR_TYPE_LIGHT_KEY, [listener]);
	}
	function addProximityListener(listener) {
		if(ListenerTable.rawin(SENSOR_TYPE_PROXIMITY_KEY)) ListenerTable.Proximity.append(listener);
		else ListenerTable.rawset(SENSOR_TYPE_PROXIMITY_KEY, [listener]);
	}
	function removeAllListener() {
		if(ListenerTable.rawin(SENSOR_TYPE_ACCELEROMETER_KEY)) {
			for(local i=0; i<ListenerTable.Accelerometer.len(); i++)
				ListenerTable.Accelerometer[i] = ListenerTable.Accelerometer[i].remove();
			ListenerTable.Accelerometer.clear();
			ListenerTable.rawdelete(SENSOR_TYPE_ACCELEROMETER_KEY);
		}
		if(ListenerTable.rawin(SENSOR_TYPE_MAGNETIC_FIELD_KEY)) {
			for(local i=0; i<ListenerTable.MagnecticField.len(); i++)
				ListenerTable.MagnecticField[i] = ListenerTable.MagnecticField[i].remove();
			ListenerTable.MagnecticField.clear();
			ListenerTable.rawdelete(SENSOR_TYPE_MAGNETIC_FIELD_KEY);
		}
		if(ListenerTable.rawin(SENSOR_TYPE_GYROSCOPE_KEY)) {
			for(local i=0; i<ListenerTable.Gyroscope.len(); i++)
				ListenerTable.Gyroscope[i] = ListenerTable.Gyroscope[i].remove();
			ListenerTable.Gyroscope.clear();
			ListenerTable.rawdelete(SENSOR_TYPE_GYROSCOPE_KEY);
		}
		if(ListenerTable.rawin(SENSOR_TYPE_LIGHT_KEY)) {
			for(local i=0; i<ListenerTable.Light.len(); i++)
				ListenerTable.Light[i] = ListenerTable.Light[i].remove();
			ListenerTable.Light.clear();
			ListenerTable.rawdelete(SENSOR_TYPE_LIGHT_KEY);
		}
		if(ListenerTable.rawin(SENSOR_TYPE_PROXIMITY_KEY)) {
			for(local i=0; i<ListenerTable.Proximity.len(); i++)
				ListenerTable.Proximity[i] = ListenerTable.Proximity[i].remove();
			ListenerTable.Proximity.clear();
			ListenerTable.rawdelete(SENSOR_TYPE_PROXIMITY_KEY);
		}
	}
	function remove() {
		this.removeAllListener();
		return null;
	}
}

class SensorListener {
	enable = false;
	sensorType = null;
	constructor(_type, _bool = true) {
		enable = _bool;
		sensorType = _type;
	}
	function setEnable(_bool) {
		enable = _bool;
	}
	function getEnable(_bool) {
		return enable;
	}
	function onCall(sevent) {
		if(sensorType == null) print("Must implement TypeListener!");
		else if(enable) this.onEvent(sevent);
	}
	function onEvent(sevent) {
		print("Must implement onEvent()!");
	}
	function remove() {
		return null;
	}
}

class AccelerometerListener extends SensorListener {
	constructor(_bool = true) {
		base.constructor(SENSOR_TYPE_ACCELEROMETER, _bool);
	}
}

class MagnecticFieldListener extends SensorListener {
	constructor(_bool = true) {
		base.constructor(SENSOR_TYPE_MAGNETIC_FIELD, _bool);
	}
}

class GyroscopeListener extends SensorListener {
	constructor(_bool = true) {
		base.constructor(SENSOR_TYPE_GYROSCOPE, _bool);
	}
}

class LightListener extends SensorListener {
	constructor(_bool = true) {
		base.constructor(SENSOR_TYPE_LIGHT, _bool);
	}
}

class ProximityListener extends SensorListener {
	constructor(_bool = true) {
		base.constructor(SENSOR_TYPE_PROXIMITY, _bool);
	}
}