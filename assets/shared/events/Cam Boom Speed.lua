--Config
--startingBeatCount = 4 
defaultBeatCount = 0
defaultZoomSizeMult = 1
defaultShakeIntensity = 0
defaultRatio = 2

songStarted = false

function onCreatePost()
	zoomSizeMult = getProperty('camZoomingMult')
	setProperty('camZoomingMult', 0)
	defaultZooms = true
	if songStarted == false then
		startChecker = getProperty('camZooming')
		if startChecker ~= false then
			songStarted = true
		end
	end
end

function onUpdate()
	if songStarted == true and getProperty('camZooming') == false then
		songStarted = false
	end
end

function onEvent(name,value1,value2)
	if name == "Cam Boom Speed" then
		actualDecay = getProperty('camZoomingDecay')
		defaultZooms = false
		if value1 ~= 'default' then
			beatCount = tonumber(splitStr(value1, ',')[1]) or defaultBeatCount
			stepCount = beatCount * 4
			beatCountOffset = tonumber(splitStr(value1, ',')[2]) or 0
			stepCountOffset = beatCountOffset * 4
		else
			defaultZooms = true
		end
		zoomSizeMult = tonumber(splitStrval2(value2, ',')[1]) or defaultZoomSizeMult
		ratio = tonumber(splitStrval2(value2, ',')[2]) or defaultRatio
		shakeIntensity = tonumber(splitStrval2(value2, ',')[3]) or defaultShakeIntensity
		if curStep < 1 and stepCountOffset == 0 then
			autoZoom()
		end
	elseif name == "Set Property" then
		if value1 == 'camZoomingDecay' then
			actualDecay = tonumber(value2)
		end
	end
end

function onSectionHit()
	if defaultZooms == true then
		autoZoom()
	end
end

function onStepHit()
	offsetStep = curStep - stepCountOffset
	if songStarted == false then
		runTimer('zoomingCheck', 0.00011)
	end
	if offsetStep % stepCount == 0 and defaultZooms ~= true then
		autoZoom()
	end
end

function autoZoom()
	if songStarted ~= false then
		triggerEvent("Add Camera Zoom",0.015*zoomSizeMult,0.015*zoomSizeMult*ratio)
		if getProperty('camGame.zoom') >= 1.35 then	
			setProperty('camGame.zoom',getProperty('camGame.zoom')+0.015*zoomSizeMult);
			setProperty('camHUD.zoom',getProperty('camHUD.zoom')+0.015*zoomSizeMult*ratio);
		end
		if shakeIntensity > 0 then
			shakeLengthMult = actualDecay
			if 0.01 > shakeLengthMult then
				shakeLengthMult = 0.01
			end
			shakeLength = 0.15/shakeLengthMult
			shakeMult = 0.00075*shakeIntensity
			triggerEvent("Screen Shake",(shakeLength .. ', ' .. shakeMult), (shakeLength .. ', ' .. shakeMult*ratio))
		end
	end
end

function onEndSong()
	songStarted = false
	return Function_Continue;
end

function splitStr(inputstr, sep) -- the one and only, the string splitter
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

function splitStrval2(inputstring, separ)
    if not separ then
        separ = "%s"
    end
	
	inputstring = string.gsub(inputstring, "%s+", "")
    local tab = {}

    for stri in string.gmatch(inputstring, "([^" .. separ .. "]+)") do
        table.insert(tab, stri)
    end

    return tab
end

function onSongStart()
	runTimer('boomEventCheck', 0.0001)
end

function onTimerCompleted(tag)
	if tag == 'boomEventCheck' and stepCountOffset == nil then
		autoZoom()
		stepCountOffset = 0
	elseif tag == 'zoomingCheck' then
		startChecker = getProperty('camZooming')
		if startChecker ~= false then
			songStarted = true
			if offsetStep % stepCount == 0 then
				autoZoom()
			elseif stepCountOffset == 0 and curStep <= 1 then
				autoZoom()
			end
		end
	end
end
		
--pretend like this isnt here
--stepCount = startingBeatCount * 4
ratio = defaultRatio
shakeIntensity = defaultShakeIntensity