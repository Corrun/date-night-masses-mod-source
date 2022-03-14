function onCreate()
	setPropertyFromClass('GameOverSubstate', 'characterName', 'gardenRuv');
	setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'ruv_dies_2'); 
	setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'SubRosa');
	setPropertyFromClass('GameOverSubstate', 'endSoundName', 'gameOverEnd');

	setProperty('gf.visible', false)

	setProperty('dad.scale.x', 1.5)
	setProperty('dad.scale.y', 1.5)

	setProperty('camFollowPos.x', getProperty('camFollowPos.x') - 70)
	setProperty('camFollowPos.y', getProperty('camFollowPos.y') - 270)
	setProperty('camFollow.x', getProperty('camFollow.x') - 70)
	setProperty('camFollow.y', getProperty('camFollow.y') - 270)
end