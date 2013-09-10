package com.meigic.polars;

import java.io.IOException;

import android.media.MediaPlayer;
import android.os.Bundle;
import android.os.PowerManager;
import android.os.PowerManager.WakeLock;
import android.app.Activity;
import android.content.ContentValues;
import android.content.Context;
import android.content.Intent;
import android.content.pm.ActivityInfo;
import android.database.sqlite.SQLiteDatabase;
import android.view.Menu;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.ImageButton;

public class Main extends Activity{
	
	//防止螢幕休眠
	private PowerManager mPowerManager;
	private WakeLock mWakeLock;
	
	//按鈕宣告
	
	ImageButton btn_mute,btn_about,btn_start,btn_exit;
	
	MediaPlayer mp;
	
	//資料庫使用名字
  	private static final String DBNAME = "emoruntime.db"; //資料庫名稱
  	private static final String FIELD01_NAME = "KEY";
  	private static final String FIELD02_NAME = "VALUE";

  	//宣告資料表名稱
  	private static final String TABLENAME = "preferences";
  		
  	//宣告資料庫
  	private SQLiteDatabase dataBase;
  	private android.database.Cursor cursor;	
  	
  	//設定存放位置
  	private static final String PACKAGE_NAME = "com.meigic.polars";
  	
  	//建立資料庫需要的字串
  	String CREATE_SQL = "create table if not exists "+TABLENAME+" ("+FIELD01_NAME+" integer primary key autoincrement, "+FIELD02_NAME+" varchar not null);";
	
	
	

	@Override
	protected void onCreate(Bundle savedInstanceState) 
	{
		super.onCreate(savedInstanceState);
		
		requestWindowFeature(Window.FEATURE_NO_TITLE);
        getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN,
        WindowManager.LayoutParams.FLAG_FULLSCREEN);
        setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_LANDSCAPE);
		
		setContentView(R.layout.main);
		
		//電源控制
        mPowerManager = (PowerManager) this.getSystemService(Context.POWER_SERVICE);
        mWakeLock = mPowerManager.newWakeLock(PowerManager.SCREEN_BRIGHT_WAKE_LOCK, "BackLight");
         
        
        if ((mWakeLock != null) &&        // we have a WakeLock
        	(mWakeLock.isHeld() == false)) // but we don't hold it 
        { 
        	// 背景恆亮
            mWakeLock.acquire();
            // 取消背景恆亮
            //mWakeLock.release();        	
        }
        
        
        mp = new MediaPlayer();
        mp = MediaPlayer.create(Main.this, R.raw.main_theme);
        mp.setLooping(true);
        
        
        /***findviewbyid***/
        btn_about=(ImageButton) findViewById(R.id.main_about);
        btn_start=(ImageButton) findViewById(R.id.main_start);
        btn_exit=(ImageButton) findViewById(R.id.main_exit);
        btn_mute=(ImageButton) findViewById(R.id.main_mute);
        
               
        
        btn_about.setOnClickListener(new Button.OnClickListener() {
			
			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				
				Intent intent_main_about = new Intent();
				intent_main_about.setClass(Main.this, About.class);
			    startActivity(intent_main_about);
			    overridePendingTransition(R.anim.enteralpha,R.anim.exitalpha);
				
			}
		});        
        
        btn_start.setOnClickListener(new Button.OnClickListener() {
			
			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				
				Intent intent_main_start = new Intent();
				//intent_main_start.setClass(Main.this, Start.class);
				intent_main_start.setClass(Main.this, Chapter1.class);
			    startActivity(intent_main_start);
			    overridePendingTransition(R.anim.enteralpha,R.anim.exitalpha);
				
			}
		});
        
        
        btn_exit.setOnClickListener(new Button.OnClickListener() {
			
			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				
				Main.this.finish();
				overridePendingTransition(R.anim.enteralpha,R.anim.exitalpha);
				
			}
		});
        
        
        //靜音按鈕
        btn_mute.setOnClickListener(new Button.OnClickListener() {
			
			@Override
			public void onClick(View arg0) {
				// TODO Auto-generated method stub
				
				
				//開啟資料庫
		        dataBase = openOrCreateDatabase(DBNAME, MODE_WORLD_WRITEABLE, null);
		        cursor = dataBase.query(TABLENAME, null, null, null, null, null, null);
				
		        //key=25
		        cursor.moveToPosition(24);
				if(cursor.getInt(1)==0) //0為正常
				{                   	
					ContentValues cv = new ContentValues();	
			    	cv.put(FIELD02_NAME, 1);	
			    	dataBase.update(TABLENAME, cv, FIELD01_NAME+" = "+ 25, null);//key=25	
			    	cursor.requery();
			    	
					btn_mute.setImageDrawable(getResources().getDrawable(R.drawable.mute02));					
					if(mp != null)
			        {
			        	mp.stop();	  	
			        }
					
				}
				else
				{
					ContentValues cv = new ContentValues();	
			    	cv.put(FIELD02_NAME, 0);	
			    	dataBase.update(TABLENAME, cv, FIELD01_NAME+" = "+ 25, null);//key=25	
			    	cursor.requery();
					
					btn_mute.setImageDrawable(getResources().getDrawable(R.drawable.mute01));		        	
		        	if(mp != null)
		            {
		            	mp.stop();	  	
		            }
		            try {
		            	mp.prepare();
		            	mp.start();
		            } catch (IllegalStateException e) {
		            	// TODO Auto-generated catch block
		            	e.printStackTrace();
		            } catch (IOException e) {
		            	// TODO Auto-generated catch block
		            	e.printStackTrace();
		            } 
				}
				//關閉資料庫		
				if(dataBase!=null)
				{
					cursor.close();
			        dataBase.close();
				}
				
				
			}
		});
             
        
	}
	
	@Override
	protected void onResume() {
		// TODO Auto-generated method stub
		super.onResume();
		
		//開啟資料庫
        dataBase = openOrCreateDatabase(DBNAME, MODE_WORLD_WRITEABLE, null);
        cursor = dataBase.query(TABLENAME, null, null, null, null, null, null);
		
        //key=25
        cursor.moveToPosition(24);
		if(cursor.getInt(1)==0) //0為正常
		{                   	
			btn_mute.setImageDrawable(getResources().getDrawable(R.drawable.mute01));
			if(mp != null)
        	{
        		mp.stop();	  	
        	}
        	try {
        		mp.prepare();
        		mp.start();
        	} catch (IllegalStateException e) {
        		// TODO Auto-generated catch block
        		e.printStackTrace();
        	} catch (IOException e) {
        		// TODO Auto-generated catch block
        		e.printStackTrace();
        	}        	         	
		}
		else
		{
			btn_mute.setImageDrawable(getResources().getDrawable(R.drawable.mute02));
		}
		//關閉資料庫		
		if(dataBase!=null)
		{
			cursor.close();
	        dataBase.close();
		}
		
		
		
	}
	
	@Override
	protected void onPause() {
		// TODO Auto-generated method stub
		super.onPause();
		//開啟資料庫
        dataBase = openOrCreateDatabase(DBNAME, MODE_WORLD_WRITEABLE, null);
        cursor = dataBase.query(TABLENAME, null, null, null, null, null, null);
		
        //key=25
        cursor.moveToPosition(24);
		if(cursor.getInt(1)==0) //0為正常
		{                   	
		   	if(mp != null)
        	{
        		mp.stop();	  	
        	}        	 	         	
		}
		//關閉資料庫		
		if(dataBase!=null)
		{
			cursor.close();
	        dataBase.close();
		}
		
		
	}
	

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.main, menu);
		return true;
	}

}
