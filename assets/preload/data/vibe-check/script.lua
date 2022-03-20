function onCreate()
	setPropertyFromClass('GameOverSubstate', 'characterName', 'stickyInRuvSuit');
	setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'sticky_dies'); 
	setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'SubRosa');
	setPropertyFromClass('GameOverSubstate', 'endSoundName', 'gameOverEnd');

	setProperty('gf.visible', false)
	
	setProperty('camFollowPos.y', getProperty('camFollowPos.y') - 460)
	setProperty('camFollow.y', getProperty('camFollow.y') - 460)

	makeLuaSprite("table0", 'table', getProperty('dad.x') - 250, getProperty('dad.y') + 400)
	addLuaSprite("table0", false)

	setProperty('boyfriend.x', getProperty('boyfriend.x') + 80)
	setProperty('dad.y', getProperty('dad.y') - 540)
end

function onGameOverStart() 
	setProperty('boyfriend.scale.x', 1.2)
	setProperty('boyfriend.scale.y', 1.2)
end