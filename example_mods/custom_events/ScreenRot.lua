--ScreenStuff but not linked to tempo
function onEvent(name, value1, value2)
	if name == "ScreenRot" then
		angle = tonumber(splitStr(value1, ',')[1]) or 0
        yourcamera = splitStr(value1, ',')[2] 
		easing = splitStr(value1, ',')[3] or 'circOut'
		rotationtime = tonumber(value2) or stepBullshit(value2)
		if rotationtime == 0 then
			rotationtime = 0.000001
		end
		if angle == 0 and yourcamera == nil then
			yourcamera = 'all'
		end
		if yourcamera == 'both' or yourcamera == nil then
			doTweenAngle('turn', 'camGame', angle, rotationtime, easing)
			doTweenAngle('turn2', 'camHUD', angle, rotationtime, easing)
		elseif yourcamera == 'all' then
			doTweenAngle('turn', 'camGame', angle, rotationtime, easing)
			doTweenAngle('turn2', 'camHUD', angle, rotationtime, easing)
			doTweenAngle('turn3', 'camOther', angle, rotationtime, easing)
		else
			if yourcamera == 'camGame' then
				yourTurn = 'turn'
			elseif yourcamera == 'camHUD' then
				yourTurn = 'turn2'
			else 
				yourTurn = 'turn3'
			end
			doTweenAngle(yourTurn, yourcamera, angle, rotationtime, easing)
		end
	elseif name == "Set Property" then
		if value1 == 'camGame.angle' then
			cancelTween('turn')
		elseif value1 == 'camHUD.angle' then
			cancelTween('turn2')
		elseif value1 == 'camOther.angle' then
			cancelTween('turn3')
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
			dur = 0.005
		end
	else
		dur = 0.005
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