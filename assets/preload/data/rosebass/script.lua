function onCreate()
	setPropertyFromClass('GameOverSubstate', 'characterName', 'gardenRuv');
	setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'ruv_dies_4'); 
	setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'SubRosa');
	setPropertyFromClass('GameOverSubstate', 'endSoundName', 'gameOverEnd');

	setProperty('gf.visible', false)

	setProperty('camFollowPos.x', getProperty('camFollowPos.x') - 155)
	setProperty('camFollowPos.y', getProperty('camFollowPos.y') - 200)
	setProperty('camFollow.x', getProperty('camFollow.x') - 155)
	setProperty('camFollow.y', getProperty('camFollow.y') - 200)
end

function onGameOverStart() 
	setProperty('boyfriend.scale.x', 0.9)
	setProperty('boyfriend.scale.y', 0.9)

	setProperty('boyfriend.x', getProperty('boyfriend.x') - 150)
end