package com.meigic.polars;

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
import android.view.Window;
import android.view.WindowManager;

public class Launcher extends Activity {
	
	private PowerManager mPowerManager;
    private WakeLock mWakeLock;	
    
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
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);        
        
        requestWindowFeature(Window.FEATURE_NO_TITLE);
        getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN,
        WindowManager.LayoutParams.FLAG_FULLSCREEN);
        setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_LANDSCAPE);
        mPowerManager = (PowerManager) this.getSystemService(Context.POWER_SERVICE);
        mWakeLock = mPowerManager.newWakeLock(PowerManager.SCREEN_BRIGHT_WAKE_LOCK, "BackLight");
        
        setContentView(R.layout.launcher);
        
        if ((mWakeLock != null) &&        // we have a WakeLock
            (mWakeLock.isHeld() == false)) // but we don't hold it
        {                 
        	// 背景恆亮                
        	mWakeLock.acquire();                
        	// 取消背景恆亮                
        	//mWakeLock.release();            
        }
        
       
        //開啟資料庫
        dataBase = openOrCreateDatabase(DBNAME, MODE_WORLD_WRITEABLE, null);
        //創建資料表     
        dataBase.execSQL(CREATE_SQL);    	 	
        cursor = dataBase.query(TABLENAME, null, null, null, null, null, null);
                       
		//要判斷靜音資料表是否為空值 然後進興資料庫初始化
        if(cursor.getCount() != 25)		//判斷資料庫是否有資料，是判斷裡面有幾筆資料，如果沒資料會回傳0
        {		    	
	    	
        	/*********ContentValues 遊戲紀錄******/
        	//cv_sa_0為在FIELD02_NAME存入0
        	//cv_sa_1為在FIELD02_NAME存入1
        	ContentValues cv_sa_1 = new ContentValues();
	    	cv_sa_1.put(FIELD02_NAME, 1);
	    	ContentValues cv_sa_0 = new ContentValues();
	    	cv_sa_0.put(FIELD02_NAME, 0);
	    	/*********ContentValues 遊戲紀錄******/
	    	
	    	/**********ContentValues 靜音*******/
	    	//cv_0為在FIELD02_NAME存入0	    	
	    	ContentValues cv_0 = new ContentValues();
			cv_0.put(FIELD02_NAME, 0);
			/**********ContentValues 靜音*******/		    	 
	    	
        	/******初始化遊戲紀錄*******/
	    	
	    	
	    	/*  第一章節 第1關                                  KEY=1     VALUE=1
				第一章節 第2關~第一章節 第8關   KEY=2~24  VALUE=0  
				  
				第二章節 第1關                                  KEY=9     VALUE=1
				第二章節 第2關~第二章節 第8關   KEY=10~16 VALUE=0 
				 
				第三章節 第1關                                  KEY=17    VALUE=1
				第三章節 第2關~第三章節 第8關   KEY=18~24 VALUE=0  
				
				關卡VALUE=0為鎖住  1為可玩  2為(1魚) 3為(2魚) 4為(3魚)  */
			
	    	for(int j=0;j<3;j++)
	    	{
	    		dataBase.insert(TABLENAME, null, cv_sa_1);	
		    	cursor.requery();
		    	for(int i=0;i<7;i++)
		    	{
			    	dataBase.insert(TABLENAME, null, cv_sa_0);	
			    	cursor.requery();  
		    	}
	    	}	    	
	    	/******初始化遊戲紀錄*******/	    	
	    	
	    	/*******初始化靜音 ********/ 
	    	/* KEY=25 VALUE=0為正常  1為靜音 */				
	    	dataBase.insert(TABLENAME, null, cv_0);		    	
	    	cursor.requery();
	    	/*******初始化靜音 ********/  
        }
        //關閉資料庫
        if(dataBase!=null)
		{
			cursor.close();
	        dataBase.close();
		}	
        
    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu) 
    {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.launcher, menu);
        return true;
        
    }
    
    
    @Override
    protected void onResume() 
    {
    	// TODO Auto-generated method stub
    	super.onResume();
    	if(1==1)
    	{
    		Intent intent_title_main = new Intent();
	        intent_title_main.setClass(Launcher.this, Main.class);
		    startActivity(intent_title_main);
		    Launcher.this.finish();
    	}
    	
    	
    	
    }
    
}
