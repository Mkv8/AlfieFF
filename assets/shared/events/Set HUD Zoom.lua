function onCreate()
	makeLuaSprite('hudplaceholder', 'spotlight', 0, 0);
	defaultHUDzoom = 1
	tweenOngoing = false
	zooming = false
	zoomCheckingDefault = true -- false lowkey doesnt do its job just keep it at true
	fastZoomCheckingDefault = zoomCheckingDefault -- whether you want fast zooms (zooms faster than iDontCareValue) to use the new tween system
	-- (setting zoom checking in value2 overrides fastZoomCheckingDefault)
	iDontCareValue = 0.025
	zoomingDecay = getProperty('camZoomingDecay')
	setProperty('camZoomingDecay', 0)
	playRate = getProperty('playbackRate') or 1
end

function onUpdate(elapsed)
	if playRate ~= getProperty('playbackRate') and getProperty('playbackRate') ~= nil then
		playRate = getProperty('playbackRate')
	end
	if getProperty('camZoomingDecay') ~= 0 then
		zoomingDecay = getProperty('camZoomingDecay')
		setProperty('camZoomingDecay', 0)
	end
	if getProperty('camZooming') then
		setProperty('camHUD.zoom', customLerp(defaultHUDzoom, getProperty('camHUD.zoom'), math.exp(-elapsed * 3.125 * zoomingDecay * playRate)))
		setProperty('camGame.zoom', customLerp(getProperty('defaultCamZoom'), getProperty('camGame.zoom'), math.exp(-elapsed * 3.125 * zoomingDecay * playRate)))
	end
	if tweenOngoing == true and fastTween ~= true then
		longTime = elapsedTime + elapsed
		if defaultHUDzoom == prevZoom then
			cameraZoom = getProperty('hudplaceholder.x')
			if tweenStarter == true then
				zoomChecker()
				tweenStarter = false
			end
			if zoomChecking == false then
				if zooming == true and getProperty('camZooming') then
					if negativeZoom == true then
						if getProperty('camHUD.zoom') > cameraZoom then
							setProperty('camHUD.zoom', cameraZoom)
							zooming = false
							if zoomChecking == false then
								idkWhatToNameThis = false
							end
						end
					else
						if getProperty('camHUD.zoom') < cameraZoom then
							setProperty('camHUD.zoom', cameraZoom)
							zooming = false
							if zoomChecking == false then
								idkWhatToNameThis = false
							end
						end
					end
				else
					setProperty('camHUD.zoom', cameraZoom)
					idkWhatToNameThis = false
				end
			else
				zoomDifference = prevZoom - cameraZoom
				setProperty('camHUD.zoom', getProperty('camHUD.zoom') - zoomDifference)
			end
			defaultHUDzoom = cameraZoom
			prevZoom = defaultHUDzoom
		else
			tweenOngoing = false
			prevZoom = defaultHUDzoom
		end
	end
end

function onEvent(name,value1,value2)
	if name == "Set HUD Zoom" then
		camZoom = string.gsub(value1, "%a", "")
		if tweenOngoing == true then
			tweenOngoing = false
			if fastTween == true then
				fastTween = false
			end
		end
		if value2 == '' then
			defaultHUDzoom = camZoom
		else
			prevZoom = defaultHUDzoom
			if prevZoom - camZoom > 0 then 
				zoomOut = true
			else
				zoomOut = false
			end
			duration = tonumber(splitStr(value2, ',')[1]) or stepBullshit(splitStr(value2, ',')[1])
			duration = duration / playRate
			if duration == 0 then
				duration = 0.000001
			end
			easing = splitStr(value2, ',')[2] or 'sineInOut'
			zoomChecking = splitStr(value2, ',')[3]
			if zoomChecking == 'true' then
				zoomChecking = true
				fastZoomChecking = true
			elseif zoomChecking == 'false' then
				zoomChecking = false
				fastZoomChecking = false
				idkWhatToNameThis = true
			else
				zoomChecking = zoomCheckingDefault
				fastZoomChecking = fastZoomCheckingDefault
				if zoomChecking == false then
					idkWhatToNameThis = true
				end
			end
			if duration >= iDontCareValue or fastZoomChecking == true then
				if zoomChecking == true then
					startValue = defaultHUDzoom
				else
					startValue = getProperty('camHUD.zoom')
				end
				setProperty('hudplaceholder.x', startValue)
				doTweenX('hudidk', 'hudplaceholder', camZoom, duration, easing)
				tweenOngoing = true
				tweenStarter = true
				elapsedTime = 0
			else
				doTweenZoom('hudfast', 'camHUD', camZoom, duration, easing)
				cancelTween('hudidk')
				tweenOngoing = true
				fastTween = true
			end
		end
	elseif name == 'Set Property' then
		if value1 == 'camZoomingDecay' and value2 == '0' then
			zoomingDecay = 0
		end
	end
end

function onUpdatePost() -- add camera zoom detector
	zoomChecker()
end

function zoomChecker()
	if tweenOngoing == true then
		if getProperty('camHUD.zoom') ~= cameraZoom then
			zoomSize = getProperty('camHUD.zoom') - cameraZoom
			--debugPrint(zoomSize)
			if zoomChecking == true then
				zooming = true
				if zoomSize < 0 then
					negativeZoom = true
				else
					negativeZoom = false
				end
			elseif zoomChecking == false and idkWhatToNameThis == true then
				zooming = true
				if zoomSize < 0 then
					negativeZoom = true
					if zoomOut ~= true and fastTween == true then
						idkWhatToNameThis = false
					end
				else
					negativeZoom = false
					if zoomOut ~= false and fastTween == true then
						idkWhatToNameThis = false
					end
				end
				if idkWhatToNameThis == true then
					runTimer('hudfastDecay', 0.005)
				else
					triggerEvent('Add Camera Zoom', 0, -zoomSize)
				end
			elseif zoomChecking == false and idkWhatToNameThis ~= true then
				triggerEvent('Add Camera Zoom', 0, -zoomSize)
			end
		end
	end
end

function onTimerCompleted(timername)
	if timername == 'hudfastDecay' then
		triggerEvent('Add Camera Zoom', 0, -zoomSize/20)
		if zoomSize == 0 then
			cancelTimer('hudfastDecay')
		end
	end
end

function onTweenCompleted(name)
	if name == 'hudidk' then
		if tweenOngoing == true then
			if zoomChecking == true then
				cameraZoom = getProperty('hudplaceholder.x')
				zoomDifference = prevZoom - cameraZoom
				setProperty('camHUD.zoom', getProperty('camHUD.zoom') - zoomDifference)
			end
			defaultHUDzoom = getProperty('hudplaceholder.x')
			prevZoom = defaultHUDzoom
		end
		tweenOngoing = false
	elseif name == 'hudfast' then
		if tweenOngoing == true and fastTween == true then
			defaultHUDzoom = camZoom
			prevZoom = defaultHUDzoom
		end
		tweenOngoing = false
		fastTween = false
	end
end

function customLerp(val1, val2, ratio)
	if val1 - val2 < 0 then
		small = val1
		big = val2
	elseif val1 - val2 > 0 then
		small = val1
		big = val2
	else
		equal = true
		small = val1
		big = val2
	end
	result = (small + (big - small) * ratio)
	return result
end

function splitStr(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
	
	inputstr = string.gsub(inputstr, "%s+", "")

    local t = {}

    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        table.insert(t, str)
    end

    return t
end

function stepBullshit(stepDur)
	stepLength = 60/(curBpm*4)
	if stepDur ~= nil then
		dur = string.gsub(stepDur, "%a", "")
		dur = tonumber(dur) or 'balls'
		if dur ~= 'balls' then
			dur = dur * stepLength
		else
			dur = 0
		end
	else
		dur = 0
	end
	return dur
end