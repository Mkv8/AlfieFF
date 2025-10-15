function onCreate()
	makeLuaSprite('placeholder', 'spotlight', 0, 0);
	brokenCameraZoom = false
	camZoom = getProperty('defaultCamZoom')
	stageZoom = camZoom
	tweenOngoing = false
	zooming = false
	zoomCheckingDefault = true -- user customizable but please also change the txt file accordingly if you change it
	fastZoomCheckingDefault = zoomCheckingDefault -- whether you want fast zooms (zooms faster than iDontCareValue) to use the new tween system 
	-- (setting zoom checking in value2 overrides fastZoomCheckingDefault)
	iDontCareValue = 0.025 -- the point right before where short zooms get fucky
end

function onUpdate(elapsed)
	if botPlay == true and keyboardJustPressed('F2') then
		if brokenCameraZoom ~= true then
			if getProperty('camZooming') ~= true then
				setProperty('camGame.zoom', 0.2)
			end
			setProperty('defaultCamZoom', 0.2)
			brokenCameraZoom = true
		else
			if getProperty('camZooming') ~= true then
				setProperty('camGame.zoom', camZoom)
			end
			setProperty('defaultCamZoom', camZoom)
			brokenCameraZoom = false
		end
	elseif tweenOngoing == true and brokenCameraZoom == false and fastTween ~= true then
		longTime = elapsedTime + elapsed
		if getProperty('defaultCamZoom') == ogZoom then
			if tweenStarter == true then
				zoomChecker()
				tweenStarter = false
			end
			cameraZoom = getProperty('placeholder.x')
			if zoomChecking == false then
				if zooming == true and getProperty('camZooming') then
					if negativeZoom == true then
						if getProperty('camGame.zoom') > cameraZoom then
							setProperty('camGame.zoom', cameraZoom)
							zooming = false
							if zoomChecking == false then
								idkWhatToNameThis = false
							end
						end
					else
						if getProperty('camGame.zoom') < cameraZoom then
							setProperty('camGame.zoom', cameraZoom)
							zooming = false
							if zoomChecking == false then
								idkWhatToNameThis = false
							end
						end
					end
				else
					setProperty('camGame.zoom', cameraZoom)
					idkWhatToNameThis = false
				end
			else
				zoomDifference = ogZoom - cameraZoom
				setProperty('camGame.zoom', getProperty('camGame.zoom') - zoomDifference)
			end
			setProperty('defaultCamZoom', cameraZoom)
			ogZoom = getProperty('defaultCamZoom')
		else
			tweenOngoing = false
			ogZoom = getProperty('defaultCamZoom')
		end
	end
end

function multBullshit(zoomMult)
	if zoomMult ~= nil then
		finalZoom = string.gsub(zoomMult, "%a", "")
		finalZoom = tonumber(finalZoom) or 'balls'
		if finalZoom ~= 'balls' then
			finalZoom = finalZoom * stageZoom
		else
			finalZoom = stageZoom
		end
	else
		finalZoom = stageZoom
	end
	return finalZoom
end

function onEvent(name,value1,value2)
	if name == "Set Cam Zoom" then
		camZoom = tonumber(value1) or multBullshit(value1)
		if tweenOngoing == true then
			tweenOngoing = false
			if fastTween == true then
				fastTween = false
			end
		end
		if brokenCameraZoom == false then
			if value2 == '' then
				setProperty('defaultCamZoom', camZoom)
			else
				ogZoom = getProperty('defaultCamZoom')
				if ogZoom - camZoom > 0 then 
					zoomOut = true
				else
					zoomOut = false
				end
				duration = tonumber(splitStr(value2, ',')[1]) or stepBullshit(splitStr(value2, ',')[1])
				playRate = getProperty('playbackRate') or 1
				if playRate == 0 then
					playRate = 1
				end
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
						startValue = getProperty('defaultCamZoom')
					else
						startValue = getProperty('camGame.zoom')
					end
					setProperty('placeholder.x', startValue)
					cameraZoom = startValue
					doTweenX('idk', 'placeholder', camZoom, duration, easing)
					tweenOngoing = true
					tweenStarter = true
					elapsedTime = 0
				else
					doTweenZoom('fast', 'camGame', camZoom, duration, easing)
					cancelTween('idk')
					tweenOngoing = true
					fastTween = true
				end
			end
		end
	elseif name == "Set Property" then
		if value1 == 'defaultCamZoom' then
			camZoom = value2
		end
	end
end

function onUpdatePost() -- add camera zoom detector
	zoomChecker()
end

function zoomChecker()
	if tweenOngoing == true then
		if getProperty('camGame.zoom') ~= cameraZoom then
			zoomSize = getProperty('camGame.zoom') - cameraZoom
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
					runTimer('fastDecay', 0.005)
				else
					triggerEvent('Add Camera Zoom', -zoomSize, 0)
				end
			elseif zoomChecking == false and idkWhatToNameThis ~= true then
				triggerEvent('Add Camera Zoom', -zoomSize, 0)
			end
		end
	end
end

function onTimerCompleted(timername)
	if timername == 'fastDecay' then
		triggerEvent('Add Camera Zoom', -zoomSize/20, 0)
		if zoomSize == 0 then
			cancelTimer('fastDecay')
		end
	end
end

function onTweenCompleted(name)
	if name == 'idk' then
		if tweenOngoing == true and brokenCameraZoom == false then
			if zoomChecking == true then
				cameraZoom = getProperty('placeholder.x')
				zoomDifference = ogZoom - cameraZoom
				setProperty('camGame.zoom', getProperty('camGame.zoom') - zoomDifference)
			end
			setProperty('defaultCamZoom', getProperty('placeholder.x'))
			ogZoom = getProperty('defaultCamZoom')
		end
		tweenOngoing = false
	elseif name == 'fast' then
		if tweenOngoing == true and brokenCameraZoom == false and fastTween == true then
			setProperty('defaultCamZoom', camZoom)
			ogZoom = getProperty('defaultCamZoom')
		end
		tweenOngoing = false
		fastTween = false
	end
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