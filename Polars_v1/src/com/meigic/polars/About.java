package com.meigic.polars;

import android.os.Bundle;
import android.os.PowerManager;
import android.os.PowerManager.WakeLock;
import android.app.Activity;
import android.content.Context;
import android.content.pm.ActivityInfo;
import android.view.Menu;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.ImageButton;

public class About extends Activity {	
	
		//¨¾¤î¿Ã¹õ¥ð¯v
		private PowerManager mPowerManager;
		private WakeLock mWakeLock;
		
		//«ö¶s«Å§i
		ImageButton btn_back;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		
		requestWindowFeature(Window.FEATURE_NO_TITLE);
        getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN,
        WindowManager.LayoutParams.FLAG_FULLSCREEN);
        setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_LANDSCAPE);
				
		setContentView(R.layout.about);
		
		//¹q·½±±¨î
        mPowerManager = (PowerManager) this.getSystemService(Context.POWER_SERVICE);
        mWakeLock = mPowerManager.newWakeLock(PowerManager.SCREEN_BRIGHT_WAKE_LOCK, "BackLight");
         
        if ((mWakeLock != null) &&        // we have a WakeLock
            (mWakeLock.isHeld() == false)) // but we don't hold it             
        {                 
        	// ­I´º«í«G                
        	mWakeLock.acquire();                
        	// ¨ú®ø­I´º«í«G                
        	//mWakeLock.release();            
        }
        
        /***findViewById***/
        btn_back=(ImageButton) findViewById(R.id.about_back);
        
        
        
        
        btn_back.setOnClickListener(new Button.OnClickListener() {
			
			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				
				About.this.finish();
				overridePendingTransition(R.anim.enteralpha,R.anim.exitalpha);
				
				
			}
		});
        
        
		
	}
	
	
	
	
	
	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.about, menu);
		return true;
	}

}
