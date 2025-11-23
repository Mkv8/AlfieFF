function onCreate()
	deathBegun = false
	-- these 4 are my custom psych events! - Sire (@sirekirb)
	addLuaScript('events/Tween Variable.lua')
	addLuaScript('events/FlashingStuff.lua')
	addLuaScript('events/Set HUD Zoom.lua')
	addLuaScript('events/ScreenRot.lua')
	-- Raltyro's zCameraFix script. not super necessary just makes the rotations look better
	addLuaScript('events/zCameraFix.lua')
end

function onGameOver()
	if getProperty('playbackRate') ~= 0 then
		if deathBegun == false then
			deathBegun = true
			setProperty('healthGain', 0)
			tweenLength = tostring(5 * tonumber(getProperty('playbackRate')))
			--debugPrint(tweenLength)
			triggerEvent('Tween Variable', 'playbackRate', '0,' .. tweenLength)
			triggerEvent('Set HUD Zoom', '0.9', tweenLength .. ', sineIn')
			triggerEvent('ScreenRot', '2.5, both, sineIn', tweenLength)
			triggerEvent('Change Scroll Speed', '0', tweenLength)
			cameraZoom = getProperty('camGame.zoom') * 2
			if cameraZoom > 1.34 then
				cameraZoom = 1.34
			end
			doTweenZoom('zoomIn', 'camGame', cameraZoom, 5, 'sineIn')
			triggerEvent('FlashingStuff', '000000, 0.75, mix', tweenLength .. ', 999, 1, other')
			--debugPrint('hi')
			--debugPrint('0', .. 5 * getProperty('playbackRate'))
			runTimer('deathTimer', 5 * getProperty('playbackRate'))
		end
		return Function_Stop
	end
end

function onTimerCompleted(tag)
	if tag == 'deathTimer' then
		setProperty('health', -500)
		triggerEvent('ScreenRot', '0, both, sineIn', 0)
	end
end