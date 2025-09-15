function onEvent(name,value1,value2)
	if name == "Tween Variable" then
		property = value1
		value = tonumber(splitStr(value2, ',')[1])
        tweenduration = tonumber(splitStr(value2, ',')[2]) or stepBullshit(splitStr(value2, ',')[2])
		tweeneasing = splitStr(value2, ',')[3] or 'linear'
		if tweenduration == 0 then
			tweenduration = 0.000001
		end
		varTween('vartween', property, value, tweenduration, tweeneasing)
	elseif name == "Set Property" then
		if value1 == property then
			cancelTween('vartween')
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
			dur = 1
		end
	else
		dur = 1
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

--the most fucked way to implement a variable tween	
function onCreate()
	makeLuaSprite('placeholder2', 'spotlight', 0, 0);
end

function varTween(tag, variable, endValue, duration, easing)
	if tweenOngoing == true then
		tweenOngoing = false
		setProperty(tweenvariable, finalValue)
	end
	finalValue = endValue
	tweenOngoing = true
	startValue = getProperty(variable)
	tweenvariable = tostring(variable)
	setProperty('placeholder2.x', startValue)
	doTweenX('idk2', 'placeholder2', endValue, duration, easing)
end

function onUpdate(elapsed)
	if tweenOngoing == true then
		local tweenValue = getProperty('placeholder2.x')
		setProperty(tweenvariable, tweenValue)
	end
end

function onTweenCompleted(name)
	if name == 'idk2' then
		tweenOngoing = false
		setProperty(tweenvariable, finalValue)
	end
end