function onCreate()
	setPropertyFromClass('GameOverSubstate', 'characterName', 'dateRuv');
	setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'ruv_dies_3'); 
	setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'SubRosa');
	setPropertyFromClass('GameOverSubstate', 'endSoundName', 'gameOverEnd');

	setProperty('gf.visible', false)

	setProperty('dad.x', getProperty('dad.x') - 30)
	setProperty('dad.y', getProperty('dad.y') - 200)

	if getProperty('camFollowPos.x') ~= 451.5 then
		setProperty('camFollowPos.x', 451.5)
	end
	if getProperty('camFollowPos.y') ~= 384 then
		setProperty('camFollowPos.y', 384)
	end
	if getProperty('camFollow.x') ~= 451.5 then
		setProperty('camFollow.x', 451.5)
	end
	if getProperty('camFollow.y') ~= 384 then
		setProperty('camFollow.y', 384)
	end
end

local modChartPart0 = false
local modChartPart1 = false
local modChartPart2 = false
local modChartPart3 = false
local modChartPart4 = false
function onUpdate()

		if not modChartPart0 and getProperty('curStep') >= 1090 and getProperty('curStep') <= 1100 then
			for i = 0, 3 do
				setPropertyFromGroup('opponentStrums', i, 'neverResetAnim',  true);
				setPropertyFromGroup('playerStrums', i, 'neverResetAnim',  true);
				setPropertyFromGroup('opponentStrums', i, 'alpha',  1); --In case you're playing on middleScroll
			end
			modChartPart0 = true
		end

		if not modChartPart1 and getProperty('curStep') >= 1855 and getProperty('curStep') <= 1890 then

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

			modChartPart1 = true
		end

		if not modChartPart2 and getProperty('curStep') >= 1840 and getProperty('curStep') <= 1845 then
			setProperty('modCharting', true)
	
			doTweenAlpha('iconP1TweenAlpha', 'iconP1', 0, 1.5, 'linear')
			doTweenAlpha('iconP2TweenAlpha', 'iconP2', 0, 1.5, 'linear')

			doTweenAlpha('healthBarBGTweenAlpha', 'healthBarBG', 0, 1.5, 'linear')
			doTweenAlpha('healthBarTweenAlpha', 'healthBar', 0, 1.5, 'linear')

			doTweenAlpha('scoreTxtTweenAlpha', 'scoreTxt', 0, 1.5, 'linear')
			modChartPart2 = true
		end


		if not modChartPart3 and getProperty('curStep') >= 1885 and getProperty('curStep') <= 1890 then
			setProperty('iconP1.animation.curAnim.curFrame', 2)
			setProperty('iconP2.animation.curAnim.curFrame', 2)
			modChartPart3 = true
		end
	
		if not modChartPart4 and getProperty('curStep') >= 1895 and getProperty('curStep') <= 1900 then
			doTweenAngle('iconP1TweenAngle', 'iconP1', -10, 1.0, 'linear')
			doTweenAngle('iconP2TweenAngle', 'iconP2', 10, 1.0, 'linear')
			modChartPart4 = true
		end

		if not modChartPart5 and getProperty('curStep') >= 1915 and getProperty('curStep') <= 1920 then
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
			modChartPart5 = true
		end
end