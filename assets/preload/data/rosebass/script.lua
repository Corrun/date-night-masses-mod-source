function onCreate()
	setPropertyFromClass('GameOverSubstate', 'characterName', 'gardenRuv');
	setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'ruv_die'); 
	setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'SubRosa');
	setPropertyFromClass('GameOverSubstate', 'endSoundName', 'gameOverEnd');

	setProperty('gf.visible', false)

	setProperty('camFollowPos.x', getProperty('camFollowPos.x') - 150)
	setProperty('camFollowPos.y', getProperty('camFollowPos.y') - 200)
	setProperty('camFollow.x', getProperty('camFollow.x') - 150)
	setProperty('camFollow.y', getProperty('camFollow.y') - 200)
end