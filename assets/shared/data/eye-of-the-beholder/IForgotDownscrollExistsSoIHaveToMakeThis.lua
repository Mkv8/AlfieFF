function onCreatePost()
	if getPropertyFromClass('backend.ClientPrefs', 'data.downScroll') == true then
		downscroll = true
	else
		downscroll = false
	end
end

function onStepHit()
	debugPrint(getProperty('camHUD.y'))
	if curStep == 914 then
		if downscroll == false then
			triggerEvent('Tween Variable', 'camHUD.y', '-600, 0, sineOut')
		else
			triggerEvent('Tween Variable', 'camHUD.y', '600, 0, sineOut')
		end
	elseif curStep == 1198 then
		yPosition = -40
		yTweenDuration = 18 * stepCrochet / 1000
		yTweenEasing = 'expoOut'
		callMovement(yPosition, yTweenDuration, yTweenEasing)
	elseif curStep == 1728 then
		yPosition = -30
		yTweenDuration = 18 * stepCrochet / 1000
		yTweenEasing = 'expoOut'
		callMovement(yPosition, yTweenDuration, yTweenEasing)
	elseif curStep == 1744 then
		yPosition = -70
		yTweenDuration = 448 * stepCrochet / 1000
		yTweenEasing = 'sineInOut'
		callMovement(yPosition, yTweenDuration, yTweenEasing)
	-- this next thing with the hud going down a bit on step 2240 (glass break) is probably intentional but on downscroll it makes your misscount and stuff invisible (at least for me)
	--elseif curStep == 2240 and downscroll ~= false then
		--triggerEvent('Tween Variable', 'camHUD.y', '0, 16s, expoOut')
	elseif curStep == 2496 then
		yPosition = -40
		yTweenDuration = 18 * stepCrochet / 1000
		yTweenEasing = 'expoOut'
		callMovement(yPosition, yTweenDuration, yTweenEasing)
	elseif curStep == 3136 then
		yPosition = -30
		yTweenDuration = 18 * stepCrochet / 1000
		yTweenEasing = 'expoOut'
		callMovement(yPosition, yTweenDuration, yTweenEasing)
	end
end

function callMovement(yValue, duration, easing)
	if downscroll == true then
		yValue = yValue * -1
	end
	doTweenY('HUDmoveTween', 'camHUD', yValue, duration, easing)
end