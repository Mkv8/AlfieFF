defaultShakeMult = 1
defaultShakeDuration = 1
defaultShakeEasing = 'linear'
defaultFadeShakeRatio = 2

function onEvent(name,value1,value2)
	if name == "Fading Shake" then
		shakeMult = tonumber(splitStrval1(value1, ',')[1]) or defaultShakeMult
		fadingShakeRatio = tonumber(splitStrval1(value1, ',')[2]) or defaultFadeShakeRatio
		shakeDuration = tonumber(splitStr(value2, ',')[1]) or stepBullshit(splitStr(value2, ',')[1])
		shakeEasing = splitStr(value2, ',')[2] or defaultShakeEasing
		shakeOngoing = true
		shakeTween(shakeMult, shakeDuration, shakeEasing)
		currentMult = shakeMult*0.00075
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
			dur = defaultShakeDuration
		end
	else
		dur = defaultShakeDuration
	end
	return dur
end

--the most fucked way to implement a variable tween	
function onCreate()
	makeLuaSprite('placeholderShake', 'spotlight', 0, 0);
end

function shakeTween(shakeStartValue, duration, easing)
	setProperty('placeholderShake.x', shakeStartValue)
	doTweenX('idkShake', 'placeholderShake', 0, duration, easing)
end

function onUpdate(elapsed)
	if shakeOngoing == true then
		currentMult = getProperty('placeholderShake.x')*0.00075
		triggerEvent("Screen Shake",(1 .. ', ' .. currentMult), (1 .. ', ' .. currentMult*fadingShakeRatio))
	end
end

function onTweenCompleted(name)
	if name == 'idkShake' then
		shakeOngoing = false
		currentMult = 0
		triggerEvent("Screen Shake", '0,0', '0,0')
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

function splitStrval1(inputstring, separ)
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