function onCreate()
	setPropertyFromClass('GameOverSubstate', 'characterName', 'gardenRuv');
	setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'ruv_die'); 
	setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'SubRosa');
	setPropertyFromClass('GameOverSubstate', 'endSoundName', 'gameOverEnd');

	setProperty('gf.visible', false)
end

local allowCountdown = false
function onStartCountdown()
	if not allowCountdown and isStoryMode and not seenCutscene then --Block the first countdown
		startVideo('sticky-and-kikyo');
		allowCountdown = true;
		return Function_Stop;
	end
	return Function_Continue;
end