defaultManualZoomSizeMult = 1
defaultManualShakeIntensity = 1
defaultManualZoomRatio = 2
defaultManualShakeRatio = 2

function onEvent(name,value1,value2)
	if name == "Shake Zoom" then
		actualDecay = getProperty('camZoomingDecay')
		manualZoomSizeMult = tonumber(splitStr(value1, ',')[1]) or defaultManualZoomSizeMult
		manualZoomRatio = tonumber(splitStr(value1, ',')[2]) or defaultManualZoomRatio
		manualShakeIntensity = tonumber(splitStrval2(value2, ',')[1]) or defaultManualShakeIntensity
		manualShakeRatio = tonumber(splitStrval2(value2, ',')[2]) or defaultManualShakeRatio
		manualShakeLength = tonumber(splitStrval2(value2, ',')[3]) or stepBullshit(splitStrval2(value2, ',')[3])
		ShakeZoomThing()
	end
end

function stepBullshit(stepDur)
	stepLength = 60/(curBpm*4)
	if stepDur ~= nil then
		dur = string.gsub(stepDur, "%a", "")
		dur = tonumber(dur) or 'balls'
		if dur ~= 'balls' then
			dur = dur * stepLength
		else
			dur = 'decay'
		end
	else
		dur = 'decay'
	end
	return dur
end

function ShakeZoomThing()
	triggerEvent("Add Camera Zoom",0.015*manualZoomSizeMult,0.015*manualZoomSizeMult*manualZoomRatio)
	if getProperty('camGame.zoom') >= 1.35 then	
		setProperty('camGame.zoom',getProperty('camGame.zoom')+0.015*manualZoomSizeMult);
		setProperty('camHUD.zoom',getProperty('camHUD.zoom')+0.015*manualZoomSizeMult*manualZoomRatio);
	end
	if manualShakeIntensity > 0 then
		if tonumber(manualShakeLength) == nil then
			manualShakeLengthMult = actualDecay
			if 0.01 > manualShakeLengthMult then
				manualShakeLengthMult = 0.01
			end
			manualShakeLength = 0.15/manualShakeLengthMult
		end
		manualShakeMult = 0.00075*manualShakeIntensity
		triggerEvent("Screen Shake",(manualShakeLength .. ', ' .. manualShakeMult), (manualShakeLength .. ', ' .. manualShakeMult*manualShakeRatio))
	end
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