function onCreate()
	setPropertyFromClass('GameOverSubstate', 'characterName', 'stickyInRuvSuit');
	setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'sticky_dies'); 
	setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'SubRosa');
	setPropertyFromClass('GameOverSubstate', 'endSoundName', 'gameOverEnd');

	setProperty('gf.visible', false)
end

function onGameOverStart() 
	setProperty('boyfriend.scale.x', 1.2)
	setProperty('boyfriend.scale.y', 1.2)
end