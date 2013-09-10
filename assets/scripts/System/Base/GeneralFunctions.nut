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

/*class NewTextSprite extends emo.TextSprite {//move have problem
	isGui = false;
	function setAsGui() {
		stage.setAsGui(childId);
		isGui = true;
	}
	/*function move(x, y, z = null) {
		local stageZoomWidth = stage.getWindowWidth() / stage.getZoomRatio();
        local stageZoomHeight = stage.getWindowHeight() / stage.getZoomRatio();
        
		if(isGui) stage.move(id, x, y, z);
		else if(!isGui) stage.move(childId, x + stageZoomWidth, y + stageZoomHeight, z);
	}
}*/