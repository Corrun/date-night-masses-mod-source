function onCreate()
	setPropertyFromClass('GameOverSubstate', 'characterName', 'dateRuv');
	setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'ruv_dies_3'); 
	setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'SubRosa');
	setPropertyFromClass('GameOverSubstate', 'endSoundName', 'gameOverEnd');

	setProperty('gf.visible', false)
	if isStoryMode then --camear position is at different places in storymode and freeplay, for some reason
		setProperty('camFollowPos.x', getProperty('camFollowPos.x') - 245)
		setProperty('camFollowPos.y', getProperty('camFollowPos.y') + 200)
		setProperty('camFollow.x', getProperty('camFollow.x') - 245)
		setProperty('camFollow.y', getProperty('camFollow.y') + 200)
	else
		setProperty('camFollowPos.x', getProperty('camFollowPos.x') - 300)
		setProperty('camFollowPos.y', getProperty('camFollowPos.y') - 70)
		setProperty('camFollow.x', getProperty('camFollow.x') - 300)
		setProperty('camFollow.y', getProperty('camFollow.y') - 70)
	end
end