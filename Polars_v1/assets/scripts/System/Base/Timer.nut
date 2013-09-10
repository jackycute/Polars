class Timer {
	total_interval = 0;
	tick_interval = 0;
	total_ticks = 0;
	current_ticks = 0;
	//range = 0;
	
	Valid = false;
	Running = false;
	Pausing = false;
	Finished = false;
	starttime = 0;
	currenttime = 0;
	pausetime = 0;
	constructor(_total_interval, _tick_interval) {
		total_interval = _total_interval;
		tick_interval = _tick_interval;
		//range = _range;
		if(total_interval < tick_interval) {
			print("ERROR: total_interval must bigger or equal tick_interval")
			Valid = false;
			return null;
		} else Valid = true;
		total_ticks = floor(total_interval/tick_interval);
		current_ticks = 0;
	}
	function start() {
		if(!Pausing) {
			starttime = runtime.uptime();
			current_ticks = 0;
			Finished = false;
		} else {
			pausetime += (runtime.uptime() - pausetime);
		}
		Running = true;
		Pausing = false;
		this.onStart();
	}
	function pause() {
		Running = false;
		Pausing = true;
		pausetime = runtime.uptime();
	}
	function stop() {
		Running = false;
		Pausing = false;
	}
	function getRunning() {
		return Running;
	}
	function getPausing() {
		return Pausing;
	}
	function getStop() {
		if(Running == false && Pausing == false) return true;
		else false;
	}
	function getFinished() {
		return Finished;
	}
	function getElapsedTime() {
		return (currenttime - starttime - pausetime);
	}
	function getTick() {
		return floor((currenttime - starttime)/tick_interval);
	}
	function onUpTime() {
		if(Valid && Running) {
			currenttime = runtime.uptime();
			local time_diff = (currenttime - starttime - pausetime);
			/*if(this.getTick()<(total_interval/tick_interval) && (currenttime - starttime)%tick_interval <= range)
				if((currenttime-starttime) > this.getTick()*tick_interval)
					this.onTick(current_ticks);*/
			if(time_diff >= total_interval) {
				this.onFinish();
				Finished = true;
			} else if(time_diff >= current_ticks*tick_interval) {
				this.onTick(current_ticks);
				current_ticks++;
			}
			/*if((currenttime - starttime) >= total_interval) {
				this.onFinish();
				//this.stop();
			} else if((currenttime - starttime)%tick_interval <= range) {
				this.onTick((currenttime - starttime)/tick_interval);
			}*/
		} else if(!Valid) return null;
		if((currenttime - starttime - pausetime) >= total_interval) this.stop();
	}
	function remove() {
		return null;
	}
	function onStart() {
		print("onStart()");
	}
	function onTick(ticks) {
		print("onTick(" + ticks + ")");
	}
	function onFinish() {
		print("onFinish()");
	}
}