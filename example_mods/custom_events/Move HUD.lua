function onEvent(name, value1, value2)
	if name == "Move HUD" then
		value1Data = splitStr(value1, ',')
		value2Data = splitStrval2(value2, ',')
		placementX = value1Data[1] or 0
		placementY = value1Data[2] or 0
		duration = tonumber(value2Data[1]) or stepBullshit(value2Data[1])
		playRate = getProperty('playbackRate') or 1
		if playRate == 0 then
			playRate = 1
		end
		duration = duration / playRate
		easing = value2Data[2] or 'linear'
		if value2 == '' or duration == 0 then
			cancelTween('elucardMoveX')
			cancelTween('elucardMoveY')
			setProperty('camHUD.x', placementX)
			setProperty('camHUD.y', placementY)
		else
			doTweenX('hudMoveX', 'camHUD', placementX, duration, easing)
			doTweenY('hudMoveY', 'camHUD', placementY, duration, easing)
		end
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
			dur = 0
		end
	else
		dur = 0
	end
	return dur
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