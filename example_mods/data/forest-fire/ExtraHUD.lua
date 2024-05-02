						--Settings--

local hideP2Notes = false; 
local sideHealthbar = false; 

-----------------------------------[[Settings Info]]---------------------------------------

--[[

hideP2Notes : Hide the opponent notes.
	 
sideHealthbar : Make the healthbar on the right side.
	 
Fullstat : Shows how many Sicks, Goods, Bads and Shits you have.
]]--
																															
--[[
			--Credits--
	
		     Form Moch/Mochaama
]]--
	

				--the thing lolollolololol--
--form bbpanzu
local dadsingL = 4
local bfsingL = 4
realAnimdad = 'idle'
realAnimbf = 'idle'
function getAnim(char,prop)
	prop = prop or 'name'
	return getProperty(char .. '.animation.curAnim.' .. prop)
end
----------------------
--form Plotsh
cmoffset = -4
cmy = 20
tnhx = -10
---------------------
function onCreate()
	if camfollow then
		addLuaScript('ExtraScript/folchar') -- preventing a crash happen
	end
	if playOpponent then
		addLuaScript('ExtraScript/Opponent')
	end
	if statSong then
		if downscroll then
			makeLuaText('sogn', songName, 0, 5, 695);
			makeLuaText('stor', '', 0,1146, 695);
		else
			makeLuaText('sogn', songName, 0, 5, 2);
			makeLuaText('stor', '', 0, 1146, 2);
		end
		setTextSize('sogn', 19);
		setTextSize('stor', 20);
		setTextAlignment('sogn', 'left');
		setTextAlignment('stor', 'right');
		setTextColor('sogn', 'E5E7E9');
		addLuaText('sogn');
		addLuaText('stor');
	
		if isStoryMode then
			setTextString('stor','(StoryMode)');
		else
			setTextString('stor','(FreePlay)');
		end
   
		if playOpponent then
			if difficulty == 0 then 
				setTextString('sogn',songName .. ' - Easy (Opponent)');
			elseif difficulty == 1 then
				setTextString('sogn',songName .. ' - Normal (Opponent)');
			elseif difficulty == 2 then
				setTextString('sogn',songName .. ' - Hard (Opponent)');
			elseif difficulty == 3 then
				setTextString('sogn',songName .. ' - Custom (Opponent)');
			end
		else
			if difficulty == 0 then 
				setTextString('sogn',songName .. ' - Easy');
			elseif difficulty == 1 then
				setTextString('sogn',songName .. ' - Normal');
			elseif difficulty == 2 then
				setTextString('sogn',songName .. ' - Hard');
			elseif difficulty == 3 then
				setTextString('sogn',songName .. ' - Custom');
			end
		end
	end
 

	--[[if sideHealthbar then
		makeLuaText("youv", '' ,  2090, 10, 300);
		makeLuaText("youe", '' ,  2200, 10, 365);

		setTextSize('youe', 40);
		addLuaText('youe');
		setTextSize('youv', 40);
		addLuaText('youv');
	end]]

	if Fullstat then
		makeLuaText("tnh", '', 250, tnhx, 259);
		makeLuaText("cm", '', 200, -getProperty('tnh.x') + cmoffset, getProperty('tnh.y') + cmy);
		makeLuaText("sick", 'Sicks!: 0', 200, getProperty('cm.x'), getProperty('cm.y') + 30);
		makeLuaText("good", 'Goods: 0', 200, getProperty('cm.x'), getProperty('sick.y') + 30);
		makeLuaText("bad", 'Bads: 0', 200, getProperty('cm.x'), getProperty('good.y') + 30);
		makeLuaText("shit", 'Shits: 0', 200, getProperty('cm.x'), getProperty('bad.y') + 30);

		addLuaText('tnh');
		setTextSize('sick', 20);
		addLuaText("sick");
		setTextAlignment('sick', 'left')
		setTextSize('good', 20);
		addLuaText("good");
		setTextAlignment('good', 'left')
		setTextSize('bad', 20);
		addLuaText("bad");
		setTextAlignment('bad', 'left')
		setTextSize('shit', 20);
		addLuaText("shit");
		setTextAlignment('shit', 'left')
	end

	if songBarr then
		makeLuaSprite('wot','extraimage/songbarAlt',420, -200);
		scaleObject('wot', 0.8, 0.65);
		setObjectCamera('wot','other');
		addLuaSprite('wot',true);
		makeLuaText('wtf2',"Playing:", 0, 10, getProperty('wot.y')+0);
		addLuaText('wtf2');
		setObjectCamera('wtf2','other');
		setTextSize('wtf2', 30);
		makeLuaText('wtf', songName .. " | " .. curBpm , 0, 20, getProperty('wot.y') + 0);
		setTextSize('wtf', 25);
		setObjectCamera('wtf','other');
		addLuaText('wtf');
		setTextAlignment('wtf', 'left')
		setProperty('wot.alpha', 1* 0)
		setProperty('tnh.alpha',0)
		setProperty('sogn.alpha',0)
	end

 	if statSong then
		if getPropertyFromClass('ClientPrefs', 'timeBarType') == 'Song Name' or getPropertyFromClass('ClientPrefs', 'timeBarType') == 'Disabled' or getPropertyFromClass('ClientPrefs', 'timeBarType') == 'Time Elapsed' then
			setTextSize('timeTxt', 30);
			setPropertyFromClass('ClientPrefs', 'timeBarType', 'Time Left')
		end
	end
end

woosh = -69420
function onCreatePost()
	if hideP2Notes then
		for i = 0, getProperty('opponentStrums.length')-1 do
			setPropertyFromGroup('opponentStrums',i,'visible',false)
			setPropertyFromGroup('opponentStrums',i,'y', woosh)
			setPropertyFromGroup('opponentStrums',i,'x', woosh)
		end
	end
	if sideHealthbar then
		setProperty('scoreTxt.alpha', 1*1)
		setProperty('healthBar.angle', 1*90)
		setProperty('healthBar.x', 1* 930)
		setProperty('healthBar.y', 1* 350)
		setProperty('iconP1.alpha', 1* 0)
		setProperty('iconP2.alpha', 1* 0)
		setTextSize('scoreTxt', 26)	
		setProperty('timeTxt.x',1 * 760)
	end

	setProperty('timeBarBG.visible', false)
	setProperty('timeBar.visible', false)
	if downscroll then
		setProperty('scoreTxt.y', 1*690)
		setProperty('timeTxt.y', getProperty('iconP1.y')+ 5)
		setProperty('timeTxt.x', getProperty('scoreTxt.x')+ 440)
		screenCenter("timeTxt", "x")
	end
	if not downscroll then
		setProperty('scoreTxt.y', 1*20)
		setProperty('timeTxt.y', getProperty('iconP1.y')+ 100)
		screenCenter("timeTxt", "x")
	end
end

function onUpdate()
	if boyfriendName == 'bf' then
		if not isPixelStage then
			makeLuaSprite('wii', 'extraimage/bf-win', getProperty('iconP1.x'), getProperty('iconP1.y'))
			setObjectCamera('wii', 'hud')
			setObjectOrder('wii', getObjectOrder('iconP1') + 1)
			addLuaSprite('wii', true)
			setProperty('wii.flipX', true)
			setProperty('wii.visible', false)
			setProperty('wii.x', getProperty('iconP1.x'))
			setProperty('wii.angle', getProperty('iconP1.angle'))
			setProperty('wii.y', getProperty('iconP1.y'))
			setProperty('wii.scale.x', getProperty('iconP1.scale.x'))
			setProperty('wii.scale.y', getProperty('iconP1.scale.y'))
		end
	end


	if emote then
		if daemote == '' then
			if keyJustPressed('space') then
				triggerEvent('Hey!','BF', '0.6')
			end
		else
			if keyJustPressed('space') then
				triggerEvent('Play Animation',daemote, 'BF')
			end
		end
	end

	if botPlay then
		doTweenAlpha('tx','scoreTxt', 0, 0.3, 'linear')
	end

	if songBarr then
		setProperty('wtf.y', getProperty('wot.y') + 90)
		setProperty('wtf.x', getProperty('wot.x') + 70)
		setProperty('wtf2.y', getProperty('wot.y') + 10)
		setProperty('wtf2.x', getProperty('wot.x') + 60)
		setProperty('wtf.alpha', getProperty('wot.alpha'))
		setProperty('wtf2.alpha', getProperty('wot.alpha'))
		setProperty('stor.alpha', getProperty('sogn.alpha'))
	end

	if Fullstat then
		setTextString('sick', 'Sick!: ' .. getProperty('sicks'))
		setTextString('good', 'Goods: ' .. getProperty('goods'))
		setTextString('bad', 'Bads: ' .. getProperty('bads'))
		setTextString('shit', 'Shits: ' .. getProperty('shits'))
		setProperty('sick.alpha', getProperty('tnh.alpha'))
		setProperty('good.alpha', getProperty('tnh.alpha'))
		setProperty('bad.alpha', getProperty('tnh.alpha'))
		setProperty('shit.alpha', getProperty('tnh.alpha'))
	end

	if getProperty('health') > 1.6 then
		if boyfriendName == 'bf' then
			setProperty('iconP1.visible', false)
			setProperty('wii.visible', true)
		end
		setTextColor('scoreTxt', 'FFFFFF')
	elseif getProperty('health') < 0.4 then
		if boyfriendName == 'bf' then
			setProperty('iconP1.visible', true)
			setProperty('wii.visible', false)
		end
		setTextColor('scoreTxt', 'FF0000')
	else
		setTextColor('scoreTxt', 'FFFFFF')
		if boyfriendName == 'bf' then
			setProperty('iconP1.visible', true)
			setProperty('wii.visible', false)
		end
	end
end

local stepEv = 0

function onStepHit()
	if stepEv == 0 and curStep >= 1 then
		if songBarr then
			doTweenAlpha('wota', 'wot', 1 , 0.8, 'quadInOut')
			doTweenY('wote', 'wot', 0 , 0.8, 'quadInOut')
		end
		stepEv = stepEv + 1
	end

	if stepEv == 1 and curStep >= 10 then
		--if sideHealthbar then
		--	doTweenAlpha('youz', 'youe', 0, 2, 'linear')
		--	doTweenAlpha('youx', 'youv', 0, 2, 'linear')
		--end
		stepEv = stepEv + 1
	end

	if stepEv == 2 and curStep >= 25 then
		if songBarr then
			doTweenAlpha('wota', 'wot', 0 , 1, 'quadInOut')
			doTweenY('wote', 'wot', -200 , 0.8, 'quadInOut')
			doTweenAlpha('shog', 'sogn', 1 , 1, 'quadInOut')
			doTweenAlpha('shoge', 'tnh', 1 , 1, 'quadInOut')
		end
		stepEv = stepEv + 1
	end
end