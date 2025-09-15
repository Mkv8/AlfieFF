-- uhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
textXOffset = 0
textYOffset = 0
icon1YOffset = 0
icon2YOffset = 0
icon1XOffsetMult = 1
icon2XOffsetMult = 1
icon1XOffset = 0
icon2XOffset = 0
invertYOffset = true
prevTextShow = true

function onCreate()
	if invertYOffset == true and getPropertyFromClass('backend.ClientPrefs', 'data.downScroll') == true or getPropertyFromClass('ClientPrefs', 'downScroll') == true then
		textYOffset = textYOffset * -1
	end
	baseTextX = 0 + textXOffset
	if getPropertyFromClass('backend.ClientPrefs', 'data.downScroll') == true or getPropertyFromClass('ClientPrefs', 'downScroll') == true then
		if invertYOffset == true then
			baseTextY = screenHeight/4 + textYOffset
		else
			baseTextY = screenHeight/4 - 40 + textYOffset
		end
	else
		baseTextY = screenHeight/4*3 - 20 + textYOffset
	end
	textWidth = screenWidth + textXOffset*2
	makeLuaText('dumbText', '', textWidth, baseTextX, baseTextY)
	setTextAlignment('dumbText', 'center')
	addLuaText('dumbText')
	setTextSize('dumbText', 30);
	setProperty('dumbText.alpha', 0)
	
	makeLuaText('dumbText2', '', textWidth, baseTextX, baseTextY)
	setTextAlignment('dumbText2', 'center')
	addLuaText('dumbText2')
	setTextSize('dumbText2', 30);
	setProperty('dumbText2.alpha', 0)
	
	makeLuaSprite('textIcon', 'icons/icon-face')
	setProperty('textIcon.alpha', 0)
	icon1Scale = 0.7
	setProperty('textIcon.scale.x', icon1Scale)
	setProperty('textIcon.scale.y', icon1Scale)
	setObjectCamera('textIcon', 'hud')
	addLuaSprite('textIcon')
	
	makeLuaSprite('textIcon2', 'icons/icon-face')
	setProperty('textIcon2.alpha', 0)
	setProperty('textIcon2.flipX', true)
	icon2Scale = 0.7
	setProperty('textIcon2.scale.x', icon2Scale)
	setProperty('textIcon2.scale.y', icon2Scale)
	setObjectCamera('textIcon2', 'hud')
	addLuaSprite('textIcon2')
end

function onEvent(name, value1, value2)
	if name == 'TextStuff' then
		if value1 ~= '' then
			icon1 = splitStrval2(value2, ',')[1] or 'false'
			icon1 = removeSpaces(icon1) or 'false'
			icon1Width = getProperty('textIcon.width')
			icon1Height = getProperty('textIcon.height')
			icon1Count = icon1Width / icon1Height
			
			icon2 = splitStrval2(value2, ',')[2] or 'false'
			icon2 = removeSpaces(icon2) or 'false'
			icon2Width = getProperty('textIcon2.width')
			icon2Height = getProperty('textIcon2.height')
			icon2Count = icon2Width / icon2Height
			
			textSize = getTextSize('dumbText')
			textLength = string.len(value1)
			
			showPrevText = splitStrval2(value2, ',')[3]
			if showPrevText ~= nil then
				showPrevText = removeSpaces(showPrevText)
			end
			if showPrevText ~= 'false' then
				prevTextShow = true
			else
				prevTextShow = false
			end
			if icon1 ~= 'false' then
				loadGraphic('textIcon', 'icons/icon-' .. icon1)
				icon1Width = getProperty('textIcon.width')
				icon1Height = getProperty('textIcon.height')
				icon1Count = icon1Width / icon1Height
				loadGraphic('textIcon', 'icons/icon-' .. icon1, icon1Width / icon1Count, icon1Height)
				if getProperty('textIcon.alpha') ~= 1 then
					doTweenAlpha('iconVisible', 'textIcon', 1, 0.2)
				end
				--addAnimation('textIcon', 'idle', {0, 1}, 12, true)
				--playAnim('textIcon', 'idle')
			else
				if getProperty('textIcon.alpha') ~= 0 then
					doTweenAlpha('iconFade', 'textIcon', 0, 0.2)
				end
			end
			setProperty('textIcon.y', baseTextY - icon1Height / 2.5 + icon1YOffset --[[- 2 * textSize--]])
			iconOffset = icon1Width / icon1Count / 3 * icon1Scale + textLength * textSize/3
			setProperty('textIcon.x', textWidth/2 + icon1XOffset - icon1Width / icon1Count /2 - iconOffset * icon1XOffsetMult)
			
			if icon2 ~= 'false' then
				loadGraphic('textIcon2', 'icons/icon-' .. icon2)
				icon2Width = getProperty('textIcon2.width')
				icon2Height = getProperty('textIcon2.height')
				icon2Count = icon2Width / icon2Height
				loadGraphic('textIcon2', 'icons/icon-' .. icon2, icon2Width / icon2Count, icon2Height)
				if getProperty('textIcon2.alpha') ~= 1 then
					doTweenAlpha('icon2Visible', 'textIcon2', 1, 0.2)
				end
				--addAnimation('textIcon', 'idle', {0, 1}, 12, true)
				--playAnim('textIcon', 'idle')
			else
				if getProperty('textIcon2.alpha') ~= 0 then
					doTweenAlpha('icon2Fade', 'textIcon2', 0, 0.2)
				end
			end
			setProperty('textIcon2.y', baseTextY - icon2Height / 2.5 + icon2YOffset --[[- 2 * textSize--]])
			icon2Offset = icon2Width / icon2Count / 3 * icon2Scale + textLength * textSize/3
			setProperty('textIcon2.x', textWidth/2 + icon2XOffset - icon2Width / icon2Count /2 + icon2Offset * icon2XOffsetMult)
				
			if getProperty('dumbText.alpha') ~= 1 then
				if getProperty('dumbText.alpha') == 0 then
					setTextString('dumbText', value1)
					prevTextShow = false
				end
				doTweenAlpha('dumbVisible', 'dumbText', 1, 0.2)
			end
			if prevTextShow == true then
				setTextString('dumbText2', getTextString('dumbText'))
				setTextString('dumbText', value1)
				setProperty('dumbText2.y', baseTextY)
				setProperty('dumbText2.alpha', 0)
				doTweenY('prevTextMove', 'dumbText2', getProperty('dumbText2.y') + 1 * getTextSize('dumbText2'), 0.2, 'circOut')
				doTweenAlpha('prevTextFadeIn', 'dumbText2', 0.75, 0.2, 'circOut')
			else
				setTextString('dumbText', value1)
				--doTweenAlpha('prevTextFadeOut', 'dumbText2', 0, 0.2)
			end
		else
			doTweenAlpha('textFade', 'dumbText', 0, 0.2)
			doTweenAlpha('prevTextFadeOut', 'dumbText2', 0, 0.2)
			doTweenAlpha('iconFade', 'textIcon', 0, 0.2)
			doTweenAlpha('icon2Fade', 'textIcon2', 0, 0.2)
		end
	elseif name == "Text Settings" then
		if value2 == '' then
			value2 = nil
		end
		if value1 ~= '' then
		value1 = string.lower(value1)
			if value1 == "xoffset" or value1 == "offsetx" then
				textXOffset = value2 or 0
				baseTextX = 0 + textXOffset
				textWidth = screenWidth + textXOffset*2
				setProperty('dumbText.x', baseTextX)
				setProperty('dumbText2.x', baseTextX)
				setProperty('dumbText.width', textWidth)
				setProperty('dumbText2.width', textWidth)
			elseif value1 == "yoffset" or value1 == "offsety" then
				textYOffset = value2 or -20
				if invertYOffset == true and getPropertyFromClass('backend.ClientPrefs', 'data.downScroll') == true or getPropertyFromClass('ClientPrefs', 'downScroll') == true then
					textYOffset = textYOffset * -1
				end
				if getPropertyFromClass('backend.ClientPrefs', 'data.downScroll') == true or getPropertyFromClass('ClientPrefs', 'downScroll') == true then
					if invertYOffset == true then
						baseTextY = screenHeight/4 + textYOffset
					else
						baseTextY = screenHeight/4 - 40 + textYOffset
					end
				else
					baseTextY = screenHeight/4*3 - 20 + textYOffset
				end
				setProperty('dumbText.y', baseTextY)
			elseif value1 == "invertyoffset" then
				if value2 ~= nil and invertYOffset == true then
					if value2 ~= 'true' then
						textYOffset = textYOffset * -1
						invertYOffset = false
					end
				elseif value2 == nil or value2 == 'true' then
					if invertYOffset == false then
						textYOffset = textYOffset * -1
						invertYOffset = true
					end
				end
				if getPropertyFromClass('backend.ClientPrefs', 'data.downScroll') == true or getPropertyFromClass('ClientPrefs', 'downScroll') == true then
					if invertYOffset == true then
						baseTextY = screenHeight/4 + textYOffset
					else
						baseTextY = screenHeight/4 - 40 + textYOffset
					end
				else
					baseTextY = screenHeight/4*3 - 20 + textYOffset
				end
				setProperty('dumbText.y', baseTextY)
			elseif value1 == "font" then
				if value2 == nil then
					value2 = 'vcr.ttf'
				end
				setTextFont('dumbText', value2)
				setTextFont('dumbText2', value2)
			elseif value1 == "text1size" then
				if value2 == nil then
					value2 = 30
				end
				setTextSize('dumbText', value2)
			elseif value1 == "text2size" then
				if value2 == nil then
					value2 = 30
				end
				setTextSize('dumbText2', value2)
			elseif value1 == "textsize" then
				if value2 == nil then
					value2 = 30
				end
				setTextSize('dumbText', value2)
				setTextSize('dumbText2', value2)
			elseif value1 == "icon1scale" then
				debugPrint('work damnit')
				icon1Scale = value2 or 0.7
				setProperty('textIcon.scale.x', icon1Scale)
				setProperty('textIcon.scale.y', icon1Scale)
			elseif value1 == "icon2scale" then
				icon2Scale = value2 or 0.7
				setProperty('textIcon2.scale.x', icon2Scale)
				setProperty('textIcon2.scale.y', icon2Scale)
			elseif value1 == "iconscale" then
				icon1Scale = value2 or 0.7
				icon2Scale = value2 or 0.7
				setProperty('textIcon.scale.x', icon1Scale)
				setProperty('textIcon.scale.y', icon1Scale)
				setProperty('textIcon2.scale.x', icon2Scale)
				setProperty('textIcon2.scale.y', icon2Scale)
			elseif value1 == 'icon2flip' or value1 == 'flipicon2' then
				if value2 ~= nil and value2 ~= 'true' then
					value2 = false
				else
					value2 = true
				end
				setProperty('textIcon2.flipX', value2)
			elseif value1 == 'icon1flip' or value1 == 'flipicon1' then
				if value2 ~= nil and value2 ~= 'true' then
					value2 = false
				else
					value2 = true
				end
				setProperty('textIcon.flipX', value2)
			elseif value1 == "iconyoffset" then
				icon1YOffset = value2 or 0
				icon2YOffset = value2 or 0
			elseif value1 == "icon1yoffset" then
				icon1YOffset = value2 or 0
			elseif value1 == "icon2yoffset" then
				icon2YOffset = value2 or 0
			elseif value1 == 'textcolor' or value1 == 'color' then
				color = value2 or 'FFFFFF'
				setTextColor('dumbText', color)
				setTextColor('dumbText2', color)
			elseif value1 == 'text1color' then
				color = value2 or 'FFFFFF'
				setTextColor('dumbText', color)
			elseif value1 == 'text2color' then
				color = value2 or 'FFFFFF'
				setTextColor('dumbText2', color)
			elseif value1 == 'forcedypos' or value1 == 'forceypos' then
				if value2 ~= nil then
					baseTextY = value2
				else
					if getPropertyFromClass('backend.ClientPrefs', 'data.downScroll') == true or getPropertyFromClass('ClientPrefs', 'downScroll') == true then
						if invertYOffset == true then
							baseTextY = screenHeight/4 + textYOffset
						else
							baseTextY = screenHeight/4 - 40 + textYOffset
						end
					else
						baseTextY = screenHeight/4*3 - 20 + textYOffset
					end
				end
			elseif value1 == 'iconxoffset' then
				icon1XOffset = value2 * -1 or 0
				icon2XOffset = value2 or 0
			elseif value1 == 'icon1xoffset' then
				icon1XOffset = value2 or 0
			elseif value1 == 'icon2xoffset' then
				icon2XOffset = value2 or 0
			elseif value1 == 'iconxoffsetmult' then
				icon1XOffsetMult = value2 or 1
				icon2XOffsetMult = value2 or 1
			elseif value1 == 'icon1xoffsetmult' then
				icon1XOffsetMult = value2 or 1
			elseif value1 == 'icon2xoffsetmult' then
				icon2XOffsetMult = value2 or 1
			end
		end	
	end
end
			
function onTweenCompleted(tween)
	if tween == 'textFade' then
		setTextString('dumbText', '')
	elseif tween == 'textFade2' then
		setTextString('dumbText2', '')
	elseif tween == 'prevTextFadeIn' then
		doTweenAlpha('prevTextFadeOut', 'dumbText2', 0, 2.5, 'easeOut')
	end
end

function splitStrval2(inputstring, separ)
    if not separ then
        separ = "%s"
    end
	--inputstring = ' ' .. inputstring
	inputstring = string.gsub(inputstring, separ, " " .. separ)
	--inputstring = string.gsub(inputstring, "%s+", "")
    local tab = {}

    for stri in string.gmatch(inputstring, "([^" .. separ .. "]+)") do
        table.insert(tab, stri)
    end

    return tab
end

function removeSpaces(iString)
	iString = string.gsub(iString, "%s+", "")
	if iString ~= '' then
		return iString
	else
		return nil
	end
end