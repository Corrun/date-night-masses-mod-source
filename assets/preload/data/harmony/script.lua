function onCreate()
	setPropertyFromClass('GameOverSubstate', 'characterName', 'dateRuv');
	setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'ruv_dies_3'); 
	setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'SubRosa');
	setPropertyFromClass('GameOverSubstate', 'endSoundName', 'gameOverEnd');

	setProperty('gf.visible', false)

	setProperty('dad.x', getProperty('dad.x') - 30)
	setProperty('dad.y', getProperty('dad.y') - 200)

	if isStoryMode then --camera position is at different places in storymode and freeplay, for some reason
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

function onEndSong()
    if isStoryMode and not seenCutscene then
        startVideo('dnm-credits')
        seenCutscene = true
        return Function_Stop
    end
    return Function_Continue
end

function onUpdate()
	if getProperty('curStep') == 1080 then
		for i = 0, 3 do
			setPropertyFromGroup('opponentStrums', i, 'neverResetAnim',  true);
			setPropertyFromGroup('opponentStrums', i, 'alpha',  1);
		end
	end

	if getProperty('curStep') == 1100 then
		for i = 0, 3 do
			setPropertyFromGroup('playerStrums', i, 'neverResetAnim',  true);
			setPropertyFromGroup('playerStrums', i, 'alpha',  1);
		end
	end

	if getProperty('isStoryMode') then
		if getProperty('curStep') == 1855 then

			noteTweenX('note0TweenX',0,360,2.0,'linear')
			noteTweenY('note0TweenY',0,200,2.0,'linear')

			noteTweenX('note1TweenX',1,640,2.0,'linear')
			noteTweenY('note1TweenY',1,160,2.0,'linear')
	
			noteTweenX('note2TweenX',2,500,2.0,'linear')
			noteTweenY('note2TweenY',2,70,2.0,'linear')

			noteTweenX('note3TweenX',3,500,2.0,'linear')
			noteTweenY('note3TweenY',3,350,2.0,'linear')
			noteTweenAngle('note3Angle', 3, 135, 2.0, 'linear')

			noteTweenX('note4TweenX',4,760,2.0,'linear')
			noteTweenY('note4TweenY',4,350,2.0,'linear')
			noteTweenAngle('note4Angle', 4, 225, 2.0, 'linear')

			noteTweenX('note5TweenX',5,640,2.0,'linear')
			noteTweenY('note5TweenY',5,460,2.0,'linear')

			noteTweenX('note6TweenX',6,760,2.0,'linear')
			noteTweenY('note6TweenY',6,70,2.0,'linear')

			noteTweenX('note7TweenX',7,880,2.0,'linear')
			noteTweenY('note7TweenY',7,200,2.0,'linear')

			setProperty('iconP1.x', 780)
			setProperty('iconP1.y', 250)

			setProperty('iconP2.x', 420)
			setProperty('iconP2.y', 250)

			doTweenAlpha('iconP1TweenAlpha', 'iconP1', 1.0, 1.0, 'linear')
			doTweenAlpha('iconP2TweenAlpha', 'iconP2', 1.0, 1.0, 'linear')

			doTweenX('iconP1TweenX2', 'iconP1', 640, 2.0, 'linear')
			doTweenX('iconP2TweenY2', 'iconP2', 560, 2.0, 'linear')
		end

		if getProperty('curStep') == 1840 then
			setProperty('modCharting', true)
	
			doTweenAlpha('iconP1TweenAlpha', 'iconP1', 0, 1.5, 'linear')
			doTweenAlpha('iconP2TweenAlpha', 'iconP2', 0, 1.5, 'linear')

			doTweenAlpha('healthBarBGTweenAlpha', 'healthBarBG', 0, 1.5, 'linear')
			doTweenAlpha('healthBarTweenAlpha', 'healthBar', 0, 1.5, 'linear')

			doTweenAlpha('scoreTxtTweenAlpha', 'scoreTxt', 0, 1.5, 'linear')
		end


		if getProperty('curStep') == 1885 then
			setProperty('iconP1.animation.curAnim.curFrame', 2)
			setProperty('iconP2.animation.curAnim.curFrame', 2)
		end
	
		if getProperty('curStep') == 1895 then
			doTweenAngle('iconP1TweenAngle', 'iconP1', -10, 1.0, 'linear')
			doTweenAngle('iconP2TweenAngle', 'iconP2', 10, 1.0, 'linear')
		end

		if getProperty('curStep') == 1915 then
			noteTweenAlpha('note0TweenAlpha', 0, 0, 1.0, 'linear')
			noteTweenAlpha('note1TweenAlpha', 1, 0, 1.0, 'linear')
			noteTweenAlpha('note2TweenAlpha', 2, 0, 1.0, 'linear')
			noteTweenAlpha('note3TweenAlpha', 3, 0, 1.0, 'linear')
			noteTweenAlpha('note4TweenAlpha', 4, 0, 1.0, 'linear')
			noteTweenAlpha('note5TweenAlpha', 5, 0, 1.0, 'linear')
			noteTweenAlpha('note6TweenAlpha', 6, 0, 1.0, 'linear')
			noteTweenAlpha('note7TweenAlpha', 7, 0, 1.0, 'linear')

			doTweenAlpha('iconP1TweenAlpha', 'iconP1', 0, 2.0, 'linear')
			doTweenAlpha('iconP2TweenAlpha', 'iconP2', 0, 2.0, 'linear')
		end
	end
end