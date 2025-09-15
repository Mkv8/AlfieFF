function onCreate()
	makeLuaSprite('fadeSquare', 'spotlight', -5000, -5000)
	makeLuaSprite('flashSquare', 'spotlight', -5000, -5000)
	makeLuaSprite('holdSquare', 'spotlight', -5000, -5000)
	makeLuaSprite('mixSquare', 'spotlight', -5000, -5000)
	luaSpriteMakeGraphic('fadeSquare', 15, 15, 'FFFFFF')
	luaSpriteMakeGraphic('flashSquare', 15, 15, 'FFFFFF')
	luaSpriteMakeGraphic('holdSquare', 15, 15, 'FFFFFF')
	luaSpriteMakeGraphic('mixSquare', 15, 15, 'FFFFFF')
	scaleObject('fadeSquare', 1000, 1000)
	scaleObject('flashSquare', 1000, 1000)
	scaleObject('holdSquare', 1000, 1000)
	scaleObject('mixSquare', 1000, 1000)
end
	
-- configs but please update text file accordingly
defaultTime = 1 -- number (default flash duration)
defaultType = 'flash' -- string (whether it's a flash, fade, staying square, or a mix by default)
defaultOpacity = 1 -- number (default flash transparency, 1 = opaque, 0 = transparent)
defaultColor = 'FFFFFF' -- string (default color in hex)
defaultCam = 'game' -- string (default camera to flash)

function createFade(color, opacity, fType, dur, cam)
	if dur == 0 then
		dur = 0.000001
	end
	tagName = fType .. 'Square'
	addLuaSprite(tagName, true)
	setLuaSpriteScrollFactor(tagName, 0, 0)
	setObjectCamera(tagName, cam)
	setProperty(tagName .. '.color', getColorFromHex(color))
	if fType ~= 'mix' then
		if fType ~= 'fade' then
			setProperty(tostring(tagName .. '.alpha'), opacity)
			if fType ~= 'hold' then
				fadeAlpha = 0
			else
				fadeAlpha = opacity
			end
		else
			setProperty(tostring(tagName .. '.alpha'), 0)
			fadeAlpha = opacity
		end
		doTweenAlpha(fType, tagName, fadeAlpha, dur, 'linear')
	else
		setProperty(tostring(tagName .. '.alpha'), 0)
		doTweenAlpha('mix1', tagName, opacity, dur, 'linear')
	end
end

function onEvent(name, val1, val2)
	if name == "FlashingStuff" then
		fadeColor = splitStrval1(val1, ',')[1] or defaultColor
		fadeOpacity = tonumber(splitStrval1(val1, ',')[2]) or defaultOpacity
		fadeType = splitStrval1(val1, ',')[3] or defaultType
		fadeDur = tonumber(splitStrval2(val2, ',')[1]) or stepBullshit(splitStrval2(val2, ',')[1])
		if fadeDur == nil then
			fadeDur = defaultTime
		end
		fadeCam = splitStrval2(val2, ',')[2] or defaultCam
		if stepBullshit(fadeCam) == nil and fadeType == 'mix' then
			colorHold = fadeDur
			fadeDur = defaultTime
			fadeOut = defaultTime
		elseif fadeType == 'mix' and stepBullshit(fadeCam) ~= nil then
			colorHold = tonumber(splitStrval2(val2, ',')[2]) or stepBullshit(fadeCam)
			fadeOut = tonumber(splitStrval2(val2, ',')[3]) or stepBullshit(splitStrval2(val2, ',')[3])
			if fadeOut == nil then
				fadeOut = fadeDur
			end
			fadeCam = splitStrval2(val2, ',')[4] or defaultCam
		end
		createFade(fadeColor, fadeOpacity, fadeType, fadeDur, fadeCam)
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
			dur = nil
		end
	else
		dur = nil
	end
	return dur
end

function onTweenCompleted(namey)
	if namey == 'hold' or namey == 'fade' or namey == 'flash' or namey == 'mix' then
		setProperty(tostring(namey .. 'Square.alpha'), 0)
	elseif namey == 'mix1' then
		if colorHold == 0 then
			colorHold = 0.000001
		end
		doTweenAlpha('mix2', 'mixSquare', fadeOpacity, colorHold, 'linear')
	elseif namey == 'mix2' then
		if fadeOut == 0 then
			fadeOut = 0.000001
		end
		doTweenAlpha('mix', 'mixSquare', 0, fadeOut, 'linear')
	end
end
		
--string splitters
function splitStrval1(inputstr, sep)
    if not sep then
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