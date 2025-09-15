function onCreate()
	makeLuaSprite('letterboxBottom', 'spotlight', -screenWidth/2, screenHeight)
	makeLuaSprite('letterboxTop', 'spotlight', -screenWidth/2, -screenHeight*2)
	makeLuaSprite('pillarboxLeft', 'spotlight', -screenWidth*2, -screenHeight/2)
	makeLuaSprite('pillarboxRight', 'spotlight', screenWidth, -screenHeight/2)
	luaSpriteMakeGraphic('letterboxBottom', 1, 1, '000000')
	luaSpriteMakeGraphic('letterboxTop', 1, 1, '000000')
	luaSpriteMakeGraphic('pillarboxLeft', 1, 1, '000000')
	luaSpriteMakeGraphic('pillarboxRight', 1, 1, '000000')
	scaleObject('letterboxBottom', screenWidth*200, screenHeight*2)
	scaleObject('letterboxTop', screenWidth*200, screenHeight*2)
	scaleObject('pillarboxLeft', screenWidth*2, screenHeight*200)
	scaleObject('pillarboxRight', screenWidth*2, screenHeight*200)
	setLuaSpriteScrollFactor('letterboxBottom', 0, 0)
	setLuaSpriteScrollFactor('letterboxTop', 0, 0)
	setLuaSpriteScrollFactor('pillarboxLeft', 0, 0)
	setLuaSpriteScrollFactor('pillarboxRight', 0, 0)
	setObjectCamera('letterboxBottom', 'hud')
	setObjectCamera('letterboxTop', 'hud')
	setObjectCamera('pillarboxLeft', 'hud')
	setObjectCamera('pillarboxRight', 'hud')
	letterboxRemoved = true
	pillarboxRemoved = true
end

function onEvent(name, value1, value2)
	if name == "Camera Bars" then
		screenPercentage = tonumber(splitStrval1(value1, ',')[1]) or 0
		barType = splitStrval1(value1, ',')[2] or 'letter'
		duration = tonumber(splitStrval2(value2, ',')[1]) or stepBullshit(splitStrval2(value2, ',')[1])
		if duration == 0 then
			duration = 0.000001
		end
		easing = splitStrval2(value2, ',')[2] or 'sineInOut'
		makeBars(screenPercentage, barType, duration, easing)
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

function makeBars(percent, boxingType, easeDuration, ease)
	if boxingType == 'letter' or boxingType == 'letterbox' then
		moveBars('letter', percent, easeDuration, ease)
	elseif boxingType == 'pillar' or boxingType == 'pillarbox' then
		moveBars('pillar', percent, easeDuration, ease)
	elseif boxingType == 'all' then
		percent = 100 - percent
		percent = math.sqrt(percent)
		percent = 100 - (percent*10)
		moveBars('letter', percent, easeDuration, ease)
		moveBars('pillar', percent, easeDuration, ease)
	end
end

function onTweenCompleted(tag)
	if tag == 'letterBottom' then
		if removeLetterbox == true then
			removeLuaSprite('letterboxBottom', false)
			removeLuaSprite('letterboxTop', false)
			letterboxRemoved = true
			removeLetterbox = false
		end
	elseif tag == 'pillarLeft' then
		if removePillarbox == true then
			removeLuaSprite('pillarboxLeft', false)
			removeLuaSprite('pillarboxRight', false)
			pillarboxRemoved = true
			removePillarbox = false
		end
	end
end

function moveBars(moveSides, screenCover, easingDuration, easingType)
	if moveSides == 'letter' then
		if screenCover ~= 0 and letterboxRemoved == true then
			addLuaSprite('letterboxBottom')
			addLuaSprite('letterboxTop')
			letterboxRemoved = false
		elseif screenCover == 0 and letterboxRemoved == false then
			removeLetterbox = true
		end
		coverY = 360
		doTweenY('letterBottom', 'letterboxBottom', screenHeight - coverY*screenCover/100, easingDuration, easingType)
		doTweenY('letterTop', 'letterboxTop', -screenHeight*2 + coverY*screenCover/100, easingDuration, easingType)
	else
		if screenCover ~= 0 and pillarboxRemoved == true then
			addLuaSprite('pillarboxLeft')
			addLuaSprite('pillarboxRight')
			pillarboxRemoved = false
		elseif screenCover == 0 and pillarboxRemoved == false then
			removePillarbox = true
		end
		coverX = 640
		doTweenX('pillarLeft', 'pillarboxLeft', -screenWidth*2 + coverX*screenCover/100, easingDuration, easingType)
		doTweenX('pillarRight', 'pillarboxRight', screenWidth - coverX*screenCover/100, easingDuration, easingType)
	end
end

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