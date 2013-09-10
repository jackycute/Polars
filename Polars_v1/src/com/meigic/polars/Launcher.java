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
    
    //��Ʈw�ϥΦW�r
  	private static final String DBNAME = "emoruntime.db"; //��Ʈw�W��
  	private static final String FIELD01_NAME = "KEY";
  	private static final String FIELD02_NAME = "VALUE";

  	//�ŧi��ƪ�W��
  	private static final String TABLENAME = "preferences";
  		
  	//�ŧi��Ʈw
  	private SQLiteDatabase dataBase;
  	private android.database.Cursor cursor;	
  	
  	//�]�w�s���m
  	private static final String PACKAGE_NAME = "com.meigic.polars";
  	
  	//�إ߸�Ʈw�ݭn���r��
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
        	// �I����G                
        	mWakeLock.acquire();                
        	// �����I����G                
        	//mWakeLock.release();            
        }
        
       
        //�}�Ҹ�Ʈw
        dataBase = openOrCreateDatabase(DBNAME, MODE_WORLD_WRITEABLE, null);
        //�Ыظ�ƪ�     
        dataBase.execSQL(CREATE_SQL);    	 	
        cursor = dataBase.query(TABLENAME, null, null, null, null, null, null);
                       
		//�n�P�_�R����ƪ�O�_���ŭ� �M��i����Ʈw��l��
        if(cursor.getCount() != 25)		//�P�_��Ʈw�O�_����ơA�O�P�_�̭����X����ơA�p�G�S��Ʒ|�^��0
        {		    	
	    	
        	/*********ContentValues �C������******/
        	//cv_sa_0���bFIELD02_NAME�s�J0
        	//cv_sa_1���bFIELD02_NAME�s�J1
        	ContentValues cv_sa_1 = new ContentValues();
	    	cv_sa_1.put(FIELD02_NAME, 1);
	    	ContentValues cv_sa_0 = new ContentValues();
	    	cv_sa_0.put(FIELD02_NAME, 0);
	    	/*********ContentValues �C������******/
	    	
	    	/**********ContentValues �R��*******/
	    	//cv_0���bFIELD02_NAME�s�J0	    	
	    	ContentValues cv_0 = new ContentValues();
			cv_0.put(FIELD02_NAME, 0);
			/**********ContentValues �R��*******/		    	 
	    	
        	/******��l�ƹC������*******/
	    	
	    	
	    	/*  �Ĥ@���` ��1��                                  KEY=1     VALUE=1
				�Ĥ@���` ��2��~�Ĥ@���` ��8��   KEY=2~24  VALUE=0  
				  
				�ĤG���` ��1��                                  KEY=9     VALUE=1
				�ĤG���` ��2��~�ĤG���` ��8��   KEY=10~16 VALUE=0 
				 
				�ĤT���` ��1��                                  KEY=17    VALUE=1
				�ĤT���` ��2��~�ĤT���` ��8��   KEY=18~24 VALUE=0  
				
				���dVALUE=0�����  1���i��  2��(1��) 3��(2��) 4��(3��)  */
			
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
	    	/******��l�ƹC������*******/	    	
	    	
	    	/*******��l���R�� ********/ 
	    	/* KEY=25 VALUE=0�����`  1���R�� */				
	    	dataBase.insert(TABLENAME, null, cv_0);		    	
	    	cursor.requery();
	    	/*******��l���R�� ********/  
        }
        //������Ʈw
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
