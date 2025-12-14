function onCreate()
	makeLuaSprite('flash', '', 0, 0);
	setObjectCamera('flash', 'other');
	setProperty('flash.scale.x',2)
	setProperty('flash.scale.y',2)
	setProperty('flash.alpha', 0)
	addLuaSprite('flash', true);
end

function onEvent(n,v1,v2)
	if n == 'Camera Flash HUD' then
		if v2 == '' then
			makeGraphic('flash', 1, 1, 'ffffff')
		else
			makeGraphic('flash', 1, 1, v2)
		end
		scaleObject('flash', 1280, 720, false)

		if flashingLights or v2 == '000000' then
			setProperty('flash.alpha', 1)
		else
			setProperty('flash.alpha', 0.5)
		end
		doTweenAlpha('flash','flash', 0, v1, 'cubeOut')
	end
end