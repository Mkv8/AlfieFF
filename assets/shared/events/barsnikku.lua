--This Script was made by Comical Chaos
--Event by GianMLG & FastZombie

function onCreate()
	makeLuaSprite('bartop','',0,-100);
	makeGraphic('bartop',1,1,'000000');
	scaleObject('bartop',1280,100);
	addLuaSprite('bartop',false);
	makeLuaSprite('barbot','',0,720);
	makeGraphic('barbot',1,1,'000000');
	scaleObject('barbot',1280,100);
	addLuaSprite('barbot',false);
	setScrollFactor('bartop',0,0);
	setScrollFactor('barbot',0,0);
	setObjectCamera('bartop','hud');
	setObjectCamera('barbot','hud');
end

function onEvent(n,v)
	if n == 'Cinematic Bars' then
		if v == '1' then
			doTweenY('enter1', 'bartop', -10, 1, 'expoOut')
			doTweenY('enter2', 'barbot', 630, 1, 'expoOut')
		elseif v == '' then
			doTweenY('exit1', 'bartop', -100, 1, 'expoOut')
			doTweenY('exit2', 'barbot', 720, 1, 'expoOut')
		end
	end
end