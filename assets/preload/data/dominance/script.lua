function onCreate()
	setPropertyFromClass('GameOverSubstate', 'characterName', 'stickyInRuvSuit');
	setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'sticky_dies'); 
	setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'SubRosa');
	setPropertyFromClass('GameOverSubstate', 'endSoundName', 'gameOverEnd');

	setProperty('gf.visible', false)

	setProperty('dad.x', getProperty('dad.x') - 160)
	setProperty('dad.y', getProperty('dad.y') + 150)

	setProperty('boyfriend.x', getProperty('boyfriend.x') + 25)
	setProperty('boyfriend.y', getProperty('boyfriend.y') - 120)
end