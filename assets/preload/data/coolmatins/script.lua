function onCreate()
	setPropertyFromClass('GameOverSubstate', 'characterName', 'stickyInRuvSuit');
	setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'sticky_dies'); 
	setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'SubRosa');
	setPropertyFromClass('GameOverSubstate', 'endSoundName', 'gameOverEnd');

	setProperty('gf.visible', false)

	setProperty('boyfriend.x', getProperty('boyfriend.x') - 35)
	setProperty('boyfriend.y', getProperty('boyfriend.y') - 120)
end