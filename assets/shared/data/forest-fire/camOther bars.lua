function onCreate()
	makeLuaSprite('camOtherbarsletterboxBottom', 'spotlight', -screenWidth/2, screenHeight)
	makeLuaSprite('camOtherbarsletterboxTop', 'spotlight', -screenWidth/2, -screenHeight*4)
	luaSpriteMakeGraphic('camOtherbarsletterboxBottom', 1, 1, '000000')
	luaSpriteMakeGraphic('camOtherbarsletterboxTop', 1, 1, '000000')
	scaleObject('camOtherbarsletterboxBottom', screenWidth*200, screenHeight*4)
	scaleObject('camOtherbarsletterboxTop', screenWidth*200, screenHeight*4)
	setLuaSpriteScrollFactor('camOtherbarsletterboxBottom', 0, 0)
	setLuaSpriteScrollFactor('camOtherbarsletterboxTop', 0, 0)
	setObjectCamera('camOtherbarsletterboxBottom', 'other')
	setObjectCamera('camOtherbarsletterboxTop', 'other')
	letterboxRemoved = true
end

function onEvent(name, value1, value2)
	if name == "camOtherbars" then
		screenPercentage = tonumber(splitStrval1(value1, ',')[1]) or 0
		barPosRatio1 = splitStrval1(value1, ',')[2] or 0.5
		barPosRatio2 = splitStrval1(value1, ',')[3] or 0.5
		duration = tonumber(splitStrval2(value2, ',')[1]) or stepBullshit(splitStrval2(value2, ',')[1])
		playRate = getProperty('playbackRate') or 1
		if playRate == 0 then
			playRate = 1
		end
		duration = duration / playRate
		if duration == 0 then
			duration = 0.000001
		end
		easing = splitStrval2(value2, ',')[2] or 'sineInOut'
		makeBars(screenPercentage, duration, easing, barPosRatio1, barPosRatio2)
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

function makeBars(percent, easeDuration, ease, ratio1, ratio2)
	moveBars('letter', percent, easeDuration, ease, ratio1)
end

function onTweenCompleted(tag)
	if tag == 'letterBottom' then
		if removeLetterbox == true then
			removeLuaSprite('letterboxBottom', false)
			removeLuaSprite('letterboxTop', false)
			letterboxRemoved = true
			removeLetterbox = false
		end
	end
end

function moveBars(moveSides, screenCover, easingDuration, easingType, ratio)
	if moveSides == 'letter' then
		if screenCover ~= 0 then
			removeLetterbox = false
		end
		if screenCover ~= 0 and letterboxRemoved == true then
			addLuaSprite('camOtherbarsletterboxBottom')
			addLuaSprite('camOtherbarsletterboxTop')
			setObjectOrder('camOtherbarsletterboxBottom',0)
			setObjectOrder('camOtherbarsletterboxTop',0)
			letterboxRemoved = false
		elseif screenCover == 0 and letterboxRemoved == false then
			removeLetterbox = true
		end
		coverY = screenHeight/2
		topMult = ratio * 2
		bottomMult = (1 - ratio) * 2
		doTweenY('letterBottom', 'camOtherbarsletterboxBottom', screenHeight - coverY*screenCover/100*bottomMult, easingDuration, easingType)
		doTweenY('letterTop', 'camOtherbarsletterboxTop', -screenHeight*4 + coverY*screenCover/100*topMult, easingDuration, easingType)
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