function onCreate()
	setPropertyFromClass('GameOverSubstate', 'characterName', 'standingRuv');
	setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'ruv_dies_1'); 
	setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'SubRosa');
	setPropertyFromClass('GameOverSubstate', 'endSoundName', 'gameOverEnd');

	setProperty('gf.visible', false)

	setProperty('boyfriend.scale.x', 0.61)
	setProperty('boyfriend.scale.y', 0.61)
end
