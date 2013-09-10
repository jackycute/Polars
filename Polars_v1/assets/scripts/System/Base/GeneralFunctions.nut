function GenerateFrameArray(startFrame, endFrame) {
	local FrameArray = [];
	if(startFrame < endFrame)
		for(local i=startFrame; i<=endFrame; i++)
			FrameArray.append(i);
	else if(startFrame > endFrame)
		for(local i=startFrame; i>=endFrame; i--)
			FrameArray.append(i);
	else if(startFrame == endFrame)
		FrameArray.append(startFrame);
	return FrameArray;
}

function GuiCollidesWith(gui, sprite) {
	//print(format("GUI: X: %d, Y: %d", gui.getX(), gui.getY()));
	//print(format("Sprite: X: %d, Y: %d", sprite.getX(), sprite.getY()));
	//print(format("Camera: X: %d, Y: %d", Camera_X, Camera_Y));
	local Gui_sprite = emo.Rectangle();
	Gui_sprite.setSize(gui.getWidth(), gui.getHeight());
	Gui_sprite.move(gui.getX() + Camera_X, gui.getY() + Camera_Y);
	return Gui_sprite.collidesWith(sprite);
}

function getMuteStatus() {
	if (preference.openOrCreate() == EMO_NO_ERROR) {

 	   // detabase are stored at the following directory:
       print(format("STORED AT: %s", database.getPath(DEFAULT_DATABASE_NAME)));
        
       // retrieve the latest position.
       local temp = preference.get("25");
       temp = temp.tointeger();
       print("Database MuteStatus: " + temp);

       if (temp == 0) Mute = false;
       else if (temp == 1) Mute = true;
       
       // we have to close the database after retrieving values.
       preference.close();
            
    } else {
       print("failed to get mute status");
       print(format("ERROR CODE:    %d", database.getLastError()));
       print(format("ERROR MESSAGE: %s", database.getLastErrorMessage()));
    }
}

function SaveGame(savelevel, rank, unlocklevel) {
 	if (preference.openOrCreate() == EMO_NO_ERROR) {
		local tempsavelevel = (savelevel/100 - 1)*10 + (savelevel%100);
   		local tempnextlevel = tempsavelevel + 1;
   		tempnextlevel = tempnextlevel.tostring();
   		tempsavelevel = tempsavelevel.tostring();
   		local tempunlocklevel = 0;
   		if (unlocklevel != 0) tempunlocklevel = (unlocklevel/100 - 1)*10 + (unlocklevel%100);
   		tempunlocklevel = tempunlocklevel.tostring();
   		local temprank = 0;
   		if (rank > 0) {
   			local prerank = preference.get(tempsavelevel);//取得之前本關卡的評價
   			prerank = prerank.tointeger();
   			prerank = prerank - 1;
   			if (rank > prerank) temprank = rank + 1;//如果現在評價比之前好，替換
   			else if (rank <= prerank) temprank = prerank + 1;//如果現在評價跟之前一樣或是更差，維持
   			temprank = temprank.tostring();
  			preference.set(tempsavelevel, temprank);
   			local nextrank = preference.get(tempnextlevel);//取得下一關卡評價
   			nextrank = nextrank.tointeger();
   			if (nextrank == 0 && unlocklevel != 0) preference.set(tempunlocklevel, "1");//如果下一關卡未解鎖，解鎖它
   		}
   		// we have to close the database after retrieving values.
        preference.close();
	} else {
    	print("failed to save game");
        print(format("ERROR CODE:    %d", database.getLastError()));
        print(format("ERROR MESSAGE: %s", database.getLastErrorMessage()));
    }
}