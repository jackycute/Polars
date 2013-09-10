package com.meigic.polars;

import android.app.Activity;
import android.content.ComponentName;
import android.content.Intent;
import android.os.Bundle;

public class Replay extends Activity {
	private static final String PACKAGE_NAME = "com.meigic.polars";
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
    	super.onCreate(savedInstanceState);
    	
    	Intent intent = new Intent(Intent.ACTION_MAIN);
		intent.setComponent(new ComponentName(PACKAGE_NAME, "com.emo_framework.EmoActivity"));
		intent.setFlags(Intent.FLAG_ACTIVITY_SINGLE_TOP);
		
		try {
			Thread.sleep(2000);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		startActivity(intent);
    	this.finish();
    }
}
