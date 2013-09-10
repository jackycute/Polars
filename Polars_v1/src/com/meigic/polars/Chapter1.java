package com.meigic.polars;

import android.os.Bundle;
import android.os.PowerManager;
import android.os.PowerManager.WakeLock;
import android.app.Activity;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.pm.ActivityInfo;
import android.database.sqlite.SQLiteDatabase;
import android.view.Menu;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;
import android.view.animation.AlphaAnimation;
import android.widget.Button;
import android.widget.ImageButton;
import android.widget.ImageView;

public class Chapter1 extends Activity {
	
	//防止螢幕休眠
	private PowerManager mPowerManager;
	private WakeLock mWakeLock;
	
	//宣告按鈕
	ImageButton btn_back,btn_lv1,btn_lv2,btn_lv3,btn_lv4,btn_lv5,btn_lv6,btn_lv7,btn_lv8;
	ImageView fish1,fish2,fish3,fish4,fish5,fish6,fish7,fish8;	
	
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
        
		setContentView(R.layout.chapter1);
		
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
        
        /***findViewById***/
        btn_back=(ImageButton) findViewById(R.id.ch1_back);  
        btn_lv1=(ImageButton) findViewById(R.id.ch1_lv1);
        btn_lv2=(ImageButton) findViewById(R.id.ch1_lv2);
        btn_lv3=(ImageButton) findViewById(R.id.ch1_lv3);
        btn_lv4=(ImageButton) findViewById(R.id.ch1_lv4);
        btn_lv5=(ImageButton) findViewById(R.id.ch1_lv5);
        btn_lv6=(ImageButton) findViewById(R.id.ch1_lv6);
        btn_lv7=(ImageButton) findViewById(R.id.ch1_lv7);
        btn_lv8=(ImageButton) findViewById(R.id.ch1_lv8);
        fish1=(ImageView) findViewById(R.id.ch1_fish1);
        fish2=(ImageView) findViewById(R.id.ch1_fish2);
        fish3=(ImageView) findViewById(R.id.ch1_fish3);
        fish4=(ImageView) findViewById(R.id.ch1_fish4);
        fish5=(ImageView) findViewById(R.id.ch1_fish5);
        fish6=(ImageView) findViewById(R.id.ch1_fish6);
        fish7=(ImageView) findViewById(R.id.ch1_fish7);
        fish8=(ImageView) findViewById(R.id.ch1_fish8);
        /***findViewById***/  
        
        
        /***Button ClickListener***/
        btn_back.setOnClickListener(new Button.OnClickListener() {
			
			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				Chapter1.this.finish();
				overridePendingTransition(R.anim.enteralpha,R.anim.exitalpha);
				
			}
		});        
        
        btn_lv1.setOnClickListener(new Button.OnClickListener() {
			
			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				Intent intent = new Intent(Intent.ACTION_MAIN);
				intent.setComponent(new ComponentName(PACKAGE_NAME, "com.emo_framework.EmoActivity"));
				intent.setFlags(Intent.FLAG_ACTIVITY_SINGLE_TOP);
				startActivity(intent);
			//吳承翰 這裡你可以放第1關	
				
			}
		});        
        
        /***Button ClickListener***/
        
	}
	
	@Override
	protected void onResume() {
		// TODO Auto-generated method stub
		super.onResume();
		
		//宣告破關記錄，做以承接資料庫的資料
		int [] temp={0,0,0,0,0,0,0,0};
		
		//開啟資料庫
        dataBase = openOrCreateDatabase(DBNAME, MODE_WORLD_WRITEABLE, null);
        cursor = dataBase.query(TABLENAME, null, null, null, null, null, null);
		
        //key=1~8
        for(int i=0;i<8;i++)
        {
        	cursor.moveToPosition(i);
            temp[i]=cursor.getInt(1);
        }
        
        //關閉資料庫		
      	if(dataBase!=null)
      	{
      		cursor.close();
      	    dataBase.close();
      	}
      	
      	float alpha = 0.45f;
        AlphaAnimation alphaUp = new AlphaAnimation(alpha, alpha);
        alphaUp.setFillAfter(true);
        
        //fish1
        switch(temp[0])
        {
        	case 0:
        		btn_lv1.startAnimation(alphaUp);
        		fish1.setImageDrawable(getResources().getDrawable(R.drawable.fish0));        		
        		break;        	
        	case 1:
        		fish1.setImageDrawable(getResources().getDrawable(R.drawable.fish1));
        		break;            
        	case 2:
        		fish1.setImageDrawable(getResources().getDrawable(R.drawable.fish2));
        		break;        	
        	case 3:
        		fish1.setImageDrawable(getResources().getDrawable(R.drawable.fish3));
        		break;        	
        	case 4:
        		fish1.setImageDrawable(getResources().getDrawable(R.drawable.fish4));
        		break;            
        }
        
        //fish2
        switch(temp[1])
        {
        	case 0:
        		btn_lv2.startAnimation(alphaUp);
        		fish2.setImageDrawable(getResources().getDrawable(R.drawable.fish0));        		
        		break;        	
        	case 1:
        		//btn_lv2.getBackground().setAlpha(255);
        		fish2.setImageDrawable(getResources().getDrawable(R.drawable.fish1));
        		break;            
        	case 2:
        		fish2.setImageDrawable(getResources().getDrawable(R.drawable.fish2));
        		break;        	
        	case 3:
        		fish2.setImageDrawable(getResources().getDrawable(R.drawable.fish3));
        		break;        	
        	case 4:
        		fish2.setImageDrawable(getResources().getDrawable(R.drawable.fish4));
        		break;            
        }
        
        //fish3
        switch(temp[2])
        {
        	case 0:
        		btn_lv3.startAnimation(alphaUp);
        		fish3.setImageDrawable(getResources().getDrawable(R.drawable.fish0));        		
        		break;        	
        	case 1:
        		//btn_lv3.getBackground().setAlpha(255);
        		fish3.setImageDrawable(getResources().getDrawable(R.drawable.fish1));
        		break;            
        	case 2:
        		fish3.setImageDrawable(getResources().getDrawable(R.drawable.fish2));
        		break;        	
        	case 3:
        		fish3.setImageDrawable(getResources().getDrawable(R.drawable.fish3));
        		break;        	
        	case 4:
        		fish3.setImageDrawable(getResources().getDrawable(R.drawable.fish4));
        		break;            
        }
        
        //fish4
        switch(temp[3])
        {
        	case 0:
        		btn_lv4.startAnimation(alphaUp);
        		fish4.setImageDrawable(getResources().getDrawable(R.drawable.fish0));        		
        		break;        	
        	case 1:
        		//btn_lv4.getBackground().setAlpha(255);
        		fish4.setImageDrawable(getResources().getDrawable(R.drawable.fish1));
        		break;            
        	case 2:
        		fish4.setImageDrawable(getResources().getDrawable(R.drawable.fish2));
        		break;        	
        	case 3:
        		fish4.setImageDrawable(getResources().getDrawable(R.drawable.fish3));
        		break;        	
        	case 4:
        		fish4.setImageDrawable(getResources().getDrawable(R.drawable.fish4));
        		break;            
        }
        
        //fish5
        switch(temp[4])
        {
        	case 0:
        		btn_lv5.startAnimation(alphaUp);
        		fish5.setImageDrawable(getResources().getDrawable(R.drawable.fish0));        		
        		break;        	
        	case 1:
        		//btn_lv5.getBackground().setAlpha(255);
        		fish5.setImageDrawable(getResources().getDrawable(R.drawable.fish1));
        		break;            
        	case 2:
        		fish5.setImageDrawable(getResources().getDrawable(R.drawable.fish2));
        		break;        	
        	case 3:
        		fish5.setImageDrawable(getResources().getDrawable(R.drawable.fish3));
        		break;        	
        	case 4:
        		fish5.setImageDrawable(getResources().getDrawable(R.drawable.fish4));
        		break;            
        }
        
        //fish6
        switch(temp[5])
        {
        	case 0:
        		btn_lv6.startAnimation(alphaUp);
        		fish6.setImageDrawable(getResources().getDrawable(R.drawable.fish0));        		
        		break;        	
        	case 1:
        		//btn_lv6.getBackground().setAlpha(255);
        		fish6.setImageDrawable(getResources().getDrawable(R.drawable.fish1));
        		break;            
        	case 2:
        		fish6.setImageDrawable(getResources().getDrawable(R.drawable.fish2));
        		break;        	
        	case 3:
        		fish6.setImageDrawable(getResources().getDrawable(R.drawable.fish3));
        		break;        	
        	case 4:
        		fish6.setImageDrawable(getResources().getDrawable(R.drawable.fish4));
        		break;            
        }
        
        //fish7
        switch(temp[6])
        {
        	case 0:
        		btn_lv7.startAnimation(alphaUp);
        		fish7.setImageDrawable(getResources().getDrawable(R.drawable.fish0));        		
        		break;        	
        	case 1:
        		//btn_lv7.getBackground().setAlpha(255);
        		fish7.setImageDrawable(getResources().getDrawable(R.drawable.fish1));
        		break;            
        	case 2:
        		fish7.setImageDrawable(getResources().getDrawable(R.drawable.fish2));
        		break;        	
        	case 3:
        		fish7.setImageDrawable(getResources().getDrawable(R.drawable.fish3));
        		break;        	
        	case 4:
        		fish7.setImageDrawable(getResources().getDrawable(R.drawable.fish4));
        		break;            
        }
        
        //fish8
        switch(temp[7])
        {
        	case 0:
        		btn_lv8.startAnimation(alphaUp);
        		fish8.setImageDrawable(getResources().getDrawable(R.drawable.fish0));        		
        		break;        	
        	case 1:
        		//btn_lv8.getBackground().setAlpha(255);
        		fish8.setImageDrawable(getResources().getDrawable(R.drawable.fish1));
        		break;            
        	case 2:
        		fish8.setImageDrawable(getResources().getDrawable(R.drawable.fish2));
        		break;        	
        	case 3:
        		fish8.setImageDrawable(getResources().getDrawable(R.drawable.fish3));
        		break;        	
        	case 4:
        		fish8.setImageDrawable(getResources().getDrawable(R.drawable.fish4));
        		break;            
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
		
		
		
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.chapter1, menu);
		return true;
	}

}
