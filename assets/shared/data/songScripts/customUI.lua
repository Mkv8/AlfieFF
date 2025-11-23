--Script by FerzyLatte << Awesome!!!!! check him out -mk 
local canCreate = false
local uiCreated = false
local comboSize = -1
local textShit = {
    ['sick'] = {name = 'SICK', color = 'ffe066', number = 15},
    ['good'] = {name = 'GOOD', color = '33cc33', number = 9},
    ['bad'] = {name = 'BAD', color = 'ff3300', number = 4},
    ['shit'] = {name = 'SHIT', color = '800000', number = 1},
    ['miss'] = {name = 'MISS', color = '505050'}
}

function onCreatePost()
    luaDebugMode = true
end

function onUpdate()
	debugPrint(Yoffset)
end

function onCountdownStarted()
	if getPropertyFromClass('backend.ClientPrefs', 'data.downScroll') == true then
		judgementYoffset = 525
	else
		judgementYoffset = 0
	end
    createText()
    canCreate = true
end

function createText()
    makeLuaText('score', '1', 200, screenWidth/2, 120 + judgementYoffset)
    setTextSize('score', 25)
    setTextFont('score', 'vcr.ttf')
    setTextAlignment('score', 'center')
    screenCenter('score', 'x')
    setObjectCamera('score', 'hud')

    makeLuaText('rating', 'SEX', 200, screenWidth/2, 55 + judgementYoffset)
    setTextSize('rating', 50)
    setTextFont('rating', 'vcr.ttf')
    setProperty('rating.antialiasing', false)
    setTextAlignment('rating', 'center')
    setTextBorder('rating', 2, '000000')
    screenCenter('rating', 'x')
    setObjectCamera('rating', 'hud')

    makeLuaText('combo', 'x1', 200, screenWidth/2, 97 + judgementYoffset)
    setTextSize('combo', 20)
    setTextFont('combo', 'vcr.ttf')
    setProperty('combo.antialiasing', false)
    setTextAlignment('combo', 'center')
    setTextBorder('combo', 1, '000000')
    screenCenter('combo', 'x')
    setObjectCamera('combo', 'hud')
    addLuaText('score')
    addLuaText('rating')
    addLuaText('combo')

    setProperty('score.visible', false)
    setProperty('rating.visible', false)
    setProperty('combo.visible', false)
    uiCreated = true
end

function onTimerCompleted(tag)
    if not uiCreated then return end
    if tag == 'customUIReaper' then
        runTimer('deleteScore', 0.1, string.len(getProperty('score.text')))
        runTimer('deleteRating', 0.15, string.len(getProperty('rating.text')))
        runTimer('deleteCombo', 0.15, string.len(getProperty('combo.text')))
        canCreate = true
    elseif string.sub(tag, 1, 6) == 'delete' then
        local obj = string.lower(string.sub(tag, 7))
        local text = getProperty(obj..'.text')
        local len = #text
        if len > 1 then
            local corrupt = string.sub(text, 1, len - 2) .. string.char(getRandomInt(32, 126))
            setProperty(obj..'.text', corrupt)
        elseif len == 1 then
            setProperty(obj..'.text', '')
        end
    end
end


function noteMiss()
    if not uiCreated then return end
    comboSize = math.max(comboSize * 0.3 - 1, -1)
    setTextSize('combo', 15 + comboSize)
end
function goodNoteHit(a,s,f,g)
    if not uiCreated then return end
    if not g then
        comboSize = math.min(comboSize + 0.05, 7)
        setTextSize('combo', 15 + comboSize)
    end
end

function onUpdateScore(miss)
    if not uiCreated then return end
    if canCreate and getSongPosition() > -100 then
        canCreate = false
        setProperty('score.visible', true)
        setProperty('rating.visible', true)
        setProperty('combo.visible', true)
    end
    cancelTimer('customUIReaper') cancelTimer('deleteRating') cancelTimer('deleteCombo') cancelTimer('deleteScore')
    runTimer('customUIReaper', 2.5)
    local num = getProperty('lastRating')
    if miss then num = 'miss' end
    setProperty('rating.text', textShit[num].name)
    setProperty('rating.color', getColorFromHex(textShit[num].color))
    setProperty('score.text', score)
    setProperty('combo.text', 'x'..combo)
    if not miss and getSongPosition() > -100 then
        cubeplosion(textShit[num].number, textShit[num].color)
        scaleObject('score', 1.1,1.1, false)
        startTween('score', 'score.scale', {x = 1, y = 1}, 0.5, {ease = 'cubeOut'})

        scaleObject('combo', 1.5,1.5, false)
        setProperty('combo.angle', getRandomFloat(-10,10))
        startTween('combo', 'combo', {['scale.x'] = 1, ['scale.y'] = 1, angle = 0}, 0.5, {ease = 'cubeOut'})

        scaleObject('rating', 1.2,0.9, false)
        startTween('rating', 'rating.scale', {x = 1, y = 1}, 0.5, {ease = 'backOut'})
    end
end




function cubeplosion(num, color)
    for i = 1, num do
       local SHIT = 'cube'..(getRandomInt(2,50)..getRandomInt(1999,3000) * i) 
       local x = getProperty('rating.x')+getProperty('rating.width')/2
       local y = getProperty('rating.y')+25
       local ox = getRandomFloat(-10,10)
       local oy = getRandomFloat(-5,5)
       local size = getRandomFloat(3, 9)
       makeLuaSprite(SHIT, '', x+ox ,y+oy)
       makeGraphic(SHIT, 1, 1, color)
       scaleObject(SHIT, size,size, false)
       local ang = math.rad(getRandomFloat(0,360))
       local spd = getRandomFloat(120, 320)
       setProperty(SHIT..'.velocity.x', math.cos(ang)*spd)
       setProperty(SHIT..'.velocity.y', math.sin(ang)*spd)
       setProperty(SHIT..'.angularVelocity', getRandomFloat(-250,250))
       local drag = getRandomInt(250, 450)
       setProperty(SHIT..'.drag.x', drag)
       setProperty(SHIT..'.drag.y', drag)
       doTweenAlpha(SHIT..'_fade', SHIT, 0, 0.3+size*0.05, 'quadOut')
       setObjectCamera(SHIT, 'hud')
       addLuaSprite(SHIT, true)
       local brightness = getRandomInt(-40, 120)
       setProperty(SHIT..'.colorTransform.redOffset', brightness)
       setProperty(SHIT..'.colorTransform.greenOffset', brightness*0.9)
       setProperty(SHIT..'.colorTransform.blueOffset', brightness*0.7)
    end
end

function onTweenCompleted(tag)
    if tag:find('_fade') then
        local sprite = tag:gsub('_fade', '')
        removeLuaSprite(sprite, false)
    end
end
