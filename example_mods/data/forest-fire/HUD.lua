-- Le settings --
-- NPS got deprecated cause doesnt work properly --

local pref = {
	HideTB = true,                 --Hides TimeBar
	HideTimeTxt = false,           --Hides TimeTxt
	Font = 'vcr.ttf', --Font that the HUD will use (default is vcr.ttf)
	ScoreX = 400,                  --X For ScoreTxt
	ScoreY = 125,                  --Y For ScoreTxt
	AccX = 585,                    --X For AccTxt
	AccY = 125,                    --Y For AccTxt
	MissX = 800,                   --X For MissTxt
	MissY = 125,                   --Y For MissTxt
	ShowWatermark = false,          --Shows a watermark that you can customize :)
	WatermarkTxt = 'Whateva', --Custom Watermark?!!
	WatermarkX = 2,               --X For watermark
	WatermarkY = 700,               --Y For watermark
	ScoreTextAlignment = 'center',   --Aligment for Score text
	AccTextAlignment = 'center',   --Aligment for Accuracy text
	MissTextAlignment = 'center',   --Aligment for Miss text
	ScaleBop = 1.0,					--Bounces the scorings when you hit a note (1.0 for disabled) (NEW)
	WatermarkTextAlignment = 'center', --Aligment for watermark text
	BotplayTxt = 'AUTOPLAY',       --Change Botplay Text?!!
	BotplayX = 410,                --X For Botplay
	BotplayY = 100,                --Y For Botplay
	timeTxtX = 1045,                --X For TimeTxt
	timeTxtY = 5,                --Y For TimeTxt
	LockToHB = true,              --Locks the scorings to HealthBar (Showing the vanilla ones)
	timeColor = 0x00FF00,          --Change the color for the timer
	timeTxtColor = 0x00FF00,       --Change the color for the timer
	scoreColor = 0x000000,         --Change the color for the score
	accColor = 0x000000,           --Change the color for the accuracy
	missColor = 0x000000,          --Change the color for the misses
	WatermarkColor = 0x000000      --Change the color for the watermark
}

function onCreatePost()
	setProperty('scoreTxt.visible', false)

	if (pref.HideTB) then
		setProperty('timeBarBG.visible', false)
		setProperty('timeBar.visible', false)
	end

	if (pref.HideTimeTxt) then
		setProperty('timeTxt.visible', false)
	end
	
	makeLuaText('Watermark', pref.WatermarkTxt, 0, 0, 15)
	setProperty('Watermark.x', pref.WatermarkX)
	setProperty('Watermark.y', pref.WatermarkY)
	setTextFont('Watermark', pref.Font)
	setTextAlignment('Watermark', pref.WatermarkTextAlignment)
	setTextColor('Watermark', pref.WatermarkColor)
	addLuaText('Watermark')
	
	if pref.ShowWatermark == false then
	setProperty('Watermark.visible', false)
	end

	setTextFont('timeTxt', pref.Font)
	setTextSize('timeTxt', 24)
	setTextFont('botplayTxt', pref.Font)
	setTextSize('botplayTxt', 22)
	setTextString('botplayTxt', pref.BotplayTxt)
	setProperty('botplayTxt.x', pref.BotplayX)
	setProperty('botplayTxt.y', pref.BotplayY)
	setProperty('timeTxt.x', pref.timeTxtX)
	setProperty('timeTxt.y', pref.timeTxtY)

	makeLuaText('micdupscore', 'Score: 0', 0, 40, 0)
	setProperty('micdupscore.x', pref.ScoreX)
	setProperty('micdupscore.y', pref.ScoreY)
	setTextSize('micdupscore', 21)
	addLuaText('micdupscore')
	setTextFont('micdupscore', pref.Font)
	setTextAlignment('micdupscore', pref.ScoreTextAlignment)
	setTextColor('micdupscore', pref.scoreColor)

	makeLuaText('micdupmiss', 'Misses: 0', 0, 40, 0)
	setProperty('micdupmiss.x', pref.MissX)
	setProperty('micdupmiss.y', pref.MissY)
	setTextSize('micdupmiss', 21)
	addLuaText('micdupmiss')
	setTextFont('micdupmiss', pref.Font)
	setTextAlignment('micdupmiss', pref.MissTextAlignmentTextAlignment)
	setTextColor('micdupmiss', pref.missColor)

	makeLuaText('micdupacc', 'Accuracy: 0%', 0, 40, 0)
	setProperty('micdupacc.x', pref.AccX)
	setProperty('micdupacc.y', pref.AccY)
	setTextSize('micdupacc', 21)
	addLuaText('micdupacc')
	setTextFont('micdupacc', pref.Font)
	setTextAlignment('micdupacc', pref.AccTextAlignment)
	setTextColor('micdupacc', pref.accColor)

	if (pref.LockToHB) then
		setProperty('scoreTxt.visible', true)
		setProperty('micdupscore.visible', false)
		setProperty('micdupacc.visible', false)
		setProperty('micdupmiss.visible', false)
	end

	if botPlay == true then
		setProperty('micdupscore.visible', false)
		setProperty('micdupacc.visible', false)
		setProperty('micdupmiss.visible', false)
	end
end

function onRecalculateRating()
	setTextString('micdupacc', 'Accuracy: ' .. round(rating * 100, 2) .. '%')
	setTextString('micdupmiss', 'Misses: ' .. misses)
	setTextString('micdupscore', 'Score: ' .. score)
	scaleObject('micdupscore', pref.ScaleBop, pref.ScaleBop, true)
	doTweenX('guhX', 'micdupscore.scale', 1, 0.5, 'quadOut')
	doTweenY('guhY', 'micdupscore.scale', 1, 0.5, 'quadOut')
	scaleObject('micdupacc', pref.ScaleBop, pref.ScaleBop, true)
	doTweenX('guh2X', 'micdupacc.scale', 1, 0.5, 'quadOut')
	doTweenY('guh2Y', 'micdupacc.scale', 1, 0.5, 'quadOut')
	scaleObject('micdupmiss', pref.ScaleBop, pref.ScaleBop, true)
	doTweenX('guh3X', 'micdupmiss.scale', 1, 0.5, 'quadOut')
	doTweenY('guh3Y', 'micdupmiss.scale', 1, 0.5, 'quadOut')
end

function round(x, n) --https://stackoverflow.com/questions/18313171/lua-rounding-numbers-and-then-truncate
	n = math.pow(10, n or 0)
	x = x * n
	if x >= 0 then x = math.floor(x + 0.5) else x = math.ceil(x - 0.5) end
	return x / n
end

function goodNoteHit(id, direction, noteType, isSustainNote)
	if not isSustainNote then
		Nps = Nps + 1
		NoteHit = false;
	end

	ezTimer('drain', 1, function()
		NoteHit = true;
	end)
end

timers = {}
function ezTimer(tag, timer, callback) -- Better
	table.insert(timers, { tag, callback })
	runTimer(tag, timer)
end

function onTimerCompleted(tag)
	for k, v in pairs(timers) do
		if v[1] == tag then
			v[2]()
		end
	end
end

function math.lerp(a, b, t)
	return (b - a) * t + a;
end

function math.remapToRange(value, start1, stop1, start2, stop2)
	return start2 + (stop2 - start2) * ((value - start1) / (stop1 - start1))
end
