function onCreate()
	setProperty('gf.visible', false)
end

local allowCountdown = false
function onStartCountdown()
	if not allowCountdown and isStoryMode and not seenCutscene then --Block the first countdown
		startVideo('dnm-prologue');
		allowCountdown = true;
		return Function_Stop;
	end
	return Function_Continue;
end