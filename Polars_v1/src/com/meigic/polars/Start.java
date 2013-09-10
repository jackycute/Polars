package com.meigic.polars;

import android.os.Bundle;
import android.os.PowerManager;
import android.os.PowerManager.WakeLock;
import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.pm.ActivityInfo;
import android.view.Menu;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.ImageButton;

public class Start extends Activity{
	//¨¾¤î¿Ã¹õ¥ð¯v
	private PowerManager mPowerManager;
	private WakeLock mWakeLock;
	
	ImageButton btn_back;
	Button btn_ch1,btn_ch2,btn_ch3,btn_ch4;
	

	@Override
	protected void onCreate(Bundle savedInstanceState) 
	{
		super.onCreate(savedInstanceState);
		
		requestWindowFeature(Window.FEATURE_NO_TITLE);
        getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN,
        WindowManager.LayoutParams.FLAG_FULLSCREEN);
        setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_LANDSCAPE);
		
		setContentView(R.layout.start);
		
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
        btn_back=(ImageButton) findViewById(R.id.start_back);
        btn_ch1=(Button) findViewById(R.id.start_ch1);
        btn_ch2=(Button) findViewById(R.id.start_ch2);
        btn_ch3=(Button) findViewById(R.id.start_ch3);
        btn_ch4=(Button) findViewById(R.id.start_ch4);
        
        
        btn_back.setOnClickListener(new Button.OnClickListener() {
			
			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				
				Start.this.finish();
				overridePendingTransition(R.anim.enteralpha,R.anim.exitalpha);
				
			}
		});
        
        btn_ch1.setOnClickListener(new Button.OnClickListener() {
			
			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				
				Intent intent_start_ch1 = new Intent();
				intent_start_ch1.setClass(Start.this, Chapter1.class);
			    startActivity(intent_start_ch1);
			    overridePendingTransition(R.anim.enteralpha,R.anim.exitalpha);
			}
		});
        
        btn_ch2.setOnClickListener(new Button.OnClickListener() {
			
			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				
				Intent intent_start_ch2 = new Intent();
				intent_start_ch2.setClass(Start.this, Chapter2.class);
			    startActivity(intent_start_ch2);
			    overridePendingTransition(R.anim.enteralpha,R.anim.exitalpha);
			}
		});
        
        btn_ch3.setOnClickListener(new Button.OnClickListener() {
			
			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				
				Intent intent_start_ch3 = new Intent();
				intent_start_ch3.setClass(Start.this, Chapter3.class);
			    startActivity(intent_start_ch3);
			    overridePendingTransition(R.anim.enteralpha,R.anim.exitalpha);
			}
		});
        
        btn_ch4.setOnClickListener(new Button.OnClickListener() {
			
			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				
				Intent intent_start_ch4 = new Intent();
				intent_start_ch4.setClass(Start.this, Chapter4.class);
			    startActivity(intent_start_ch4);
			    overridePendingTransition(R.anim.enteralpha,R.anim.exitalpha);
			}
		});
        
        
        
        
        
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.start, menu);
		return true;
	}

}
