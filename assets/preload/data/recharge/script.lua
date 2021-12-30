local allowCountdown = false
function onEndSong()
	if not allowCountdown and VIDEOS_ALLOWED and isStoryMode then
		startVideo('CutsceneGrunt3');
		allowCountdown = true;
		return Function_Stop;
	end
	return Function_Continue;
end