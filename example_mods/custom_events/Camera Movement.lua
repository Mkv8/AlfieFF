function onEvent(name,value1,value2)
	if name == "Camera Movement" and value1 ~= '' then
		setChar = splitStr(value1, ',')[1]
		offsetX = splitStr(value1, ',')[2] or 0
		offsetY = splitStr(value1, ',')[3] or 0
		if tonumber(setChar) ~= nil and tonumber(offsetX) ~= nil then
			camPosX = tonumber(setChar)
			camPosY = tonumber(offsetX)
			offsetX = 0
			offsetY = 0
			setChar = 'static'
		end
		if offsetX == 0 and offsetY == 0 then
			offsetCamera = false
		else
			offsetCamera = true
		end
		if value2 ~= 'true' and value2 ~= '' then
			if oldPsych ~= true then
				setProperty('camFollow.x', getProperty('camGame.scroll.x') + screenWidth/2)
				setProperty('camFollow.y', getProperty('camGame.scroll.y') + screenHeight/2)
			else
				setProperty('camFollow.x', getProperty('camFollowPos.x'))
				setProperty('camFollow.y', getProperty('camFollowPos.y'))
			end
			tweenFinished = false
			camMoveTween = true
			tweenTimer = tonumber(splitStrval2(value2, ',')[1]) or stepBullshit(splitStrval2(value2, ',')[1])
			tweenEase = splitStrval2(value2, ',')[2] or 'linear'
			if tweenTimer == 0 then
				tweenTimer = 0.00001
			end
			setProperty('isCameraOnForcedPos', true)
		end
		if setChar == "boyfriend" or setChar == "bf" or setChar == "Boyfriend" or setChar == "BF" then
			curChar = 'boyfriend'
		end
		if setChar == "Dad" or setChar == "dad" then
			curChar = 'dad'
		end
		if setChar == "gf" or setChar == "girlfriend" or setChar == "Girlfriend" or setChar == "GF" then
			curChar = 'girlfriend'
		end
		if setChar == "middle" or setChar == "Middle" then
			curChar = 'middle'
		end
		if setChar == 'static' then
			curChar = 'static'
		end
		finalCamPos(curChar)
		setProperty('isCameraOnForcedPos', true)
		onMoveCamera(curChar)
	elseif name == "Camera Movement" and value1 == '' then
		triggerEvent('Camera Follow Pos','','')
	elseif name == "Camera Follow Pos" then
		if camMoveTween == true then
			camMoveTween = false
		end
		cancelTween('camMoveX')
		cancelTween('camMoveX2')
		cancelTween('camMoveY')
		cancelTween('camMoveY2')
		FocusHeld = false
		holdCam = false
		setChar = nil
		curChar = nil
		camChar = nil
		camCharacter = nil
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

function tweenCamPos(length, positionX, positionY, ease)
	doTweenX('camMoveX', 'camFollow', positionX, length, ease)
	doTweenY('camMoveY', 'camFollow', positionY, length, ease)
	if oldPsych ~= true then
		doTweenX('camMoveX2', 'camGame.scroll', positionX - screenWidth/2, length, ease)
		doTweenY('camMoveY2', 'camGame.scroll', positionY - screenHeight/2, length, ease)
	else
		doTweenX('camMoveX2', 'camFollowPos', positionX, length, ease)
		doTweenY('camMoveY2', 'camFollowPos', positionY, length, ease)
	end
end

function onTweenCompleted(tweenTag)
	if tweenTag == 'camMoveX' or tweenTag == 'camMoveY' and camMoveTween == true then
		camMoveTween = false
		tweenFinished = true
		finalCamPos(curChar)
	end
end

function onMoveCamera(focus)
	if tweenFinished == true and offsetCamera == true and getProperty('isCameraOnForcedPos') == true then
		if getProperty('camFollow.y') ~= offsetCamY then
			setProperty('camFollow.y', offsetCamY)
		end
		if getProperty('camFollow.x') ~= offsetCamX then
			setProperty('camFollow.x', offsetCamX)
		end
	end
	if focus ~= 'static' then
		if getProperty('isCameraOnForcedPos') ~= true then
			curChar = focus
		end
		if focus ~= 'middle' then
			if focus == 'girlfriend' then
				focus = 'gf'
			end
			charPosX = getProperty(focus .. '.x')
			charPosY = getProperty(focus .. '.y')
			if focus == 'gf' then
				focus = 'girlfriend'
			end
		else
			dadPosX = getProperty('dad.x')
			dadPosY = getProperty('dad.y')
			bfPosX = getProperty('boyfriend.x')
			bfPosY = getProperty('boyfriend.y')
			--gfPosX = getProperty('gf.x')
			--gfPosY = getProperty('gf.y')
		end
	end
end

function onUpdate()
	--debugPrint('camFollow:' .. getProperty('camFollow.x') .. ', ' .. getProperty('camFollow.y'))
	--debugPrint('offsetCam:' .. offsetCamX .. ', ' .. offsetCamY)
	--debugPrint('offsets:' .. offsetX .. ', ' .. offsetY) 
	if curChar ~= 'static' then
		if curCharMoving == true then
			if curChar ~= 'middle' then
				if getProperty(curChar .. '.x') == charPosX and getProperty(curChar .. '.y') == charPosY then
					curCharMoving = false
				end
				finalCamPos(curChar)
			else
				if getProperty('dad.x') == dadPosX and getProperty('dad.y') == dadPosY and getProperty('boyfriend.x') == bfPosX and getProperty('boyfriend.y') == bfPosY --[[and getProperty('gf.x') == gfPosX and getProperty('gf.y') == gfPosY --]]then
					curCharMoving = false
				end
				finalCamPos(curChar)
			end
		elseif curCharMoving ~= true then
			if curChar ~= 'middle' then
				if getProperty(curChar .. '.x') ~= charPosX or getProperty(curChar .. '.y') ~= charPosY then
					curCharMoving = true
					finalCamPos(curChar)
				end
			else 
				if getProperty('dad.x') ~= dadPosX or getProperty('dad.y') ~= dadPosY or getProperty('boyfriend.x') ~= bfPosX or getProperty('boyfriend.y') ~= bfPosY --[[or getProperty('gf.x') ~= gfPosX or getProperty('gf.y') ~= gfPosY --]]then
					curCharMoving = true
					finalCamPos(curChar)
				end
			end
		end
	end
end

function findMiddlePoint(dir)
	if dir == 'x' then
		xx = getCameraPos('dad', 'x')
		xx2 = getCameraPos('boyfriend', 'x')
		dirValue = AverageTwoNumbers(xx, xx2)
	elseif dir == 'y' then
		yy = getCameraPos('dad', 'y')
		yy2 = getCameraPos('boyfriend', 'y')
		dirValue = AverageTwoNumbers(yy, yy2)
	end
	return dirValue
end

function getCameraPos(camCharacter, direction)
	idkValue = 100
	if camCharacter == 'boyfriend' then
		altName = 'boyfriend'
	elseif camCharacter == 'girlfriend' then
		camCharacter = 'gf'
		idkValue = 0
	elseif camCharacter == 'dad' then
		altName = 'opponent'
		if direction == 'x' then
			idkValue = -150
		end
	end
	charCamPosX = getProperty(camCharacter .. ".cameraPosition[0]")
	if camCharacter == 'boyfriend' then
		charCamPosX = -charCamPosX
	end
	if direction == 'x' then
		camPos = getMidpointX(camCharacter) - idkValue + getProperty(altName .. "CameraOffset[0]") + charCamPosX
	elseif direction == 'y' then
		camPos = getMidpointY(camCharacter) - idkValue + getProperty(altName .. "CameraOffset[1]") + getProperty(camCharacter .. ".cameraPosition[1]")
	end
	return camPos
end

function camSetTarget(camChar)
	curCamX = camGetTarget(camChar, 'x')
	curCamY = camGetTarget(camChar, 'y')
	if camMoveTween ~= true then
		setProperty('camFollow.x', curCamX)
		setProperty('camFollow.y', curCamY)
	else
		tweenCamPos(tweenTimer, curCamX, curCamY, tweenEase)
	end
end

function camGetTarget(camChara, targetvalue)
	if camChara == 'middle' then
		camX = findMiddlePoint('x')
		camY = findMiddlePoint('y')
		onMoveCamera('middle')
	elseif camChara == 'static' then
		camX = camPosX
		camY = camPosY
	else
		camX = getCameraPos(camChara, 'x')
		camY = getCameraPos(camChara, 'y')
	end
	if targetvalue == 'x' then
		return camX
	elseif targetvalue == 'y' then
		return camY
	end
end

function AverageTwoNumbers(num1, num2)
	sum = num1 + num2
	final = sum/2
	return final
end

function finalCamPos(char)
	if offsetCamera == true then
		offsetCamX = camGetTarget(char, 'x') + offsetX
		offsetCamY = camGetTarget(char, 'y') + offsetY
		if camMoveTween ~= true then
			setProperty('camFollow.x', offsetCamX)
			setProperty('camFollow.y', offsetCamY)
		else
			tweenCamPos(tweenTimer, offsetCamX, offsetCamY, tweenEase)
		end
	else
		camSetTarget(char)
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
	if getProperty('camFollowPos.x') ~= nil then
		oldPsych = true
	else
		oldPsych = false
	end
end