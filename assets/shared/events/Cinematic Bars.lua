--This Script was made by Comical Chaos
--Event by GianMLG & FastZombie

function onCreate()
	makeLuaSprite('bartop','',0,-100);
	makeGraphic('bartop',1280,100,'000000');
	addLuaSprite('bartop',false);
	makeLuaSprite('barbot','',0,720);
	makeGraphic('barbot',1280,100,'000000');
	addLuaSprite('barbot',false);
	setScrollFactor('bartop',0,0);
	setScrollFactor('barbot',0,0);
	setObjectCamera('bartop','hud');
	setObjectCamera('barbot','hud');
end

function onEvent(n,v)
	if n == 'Cinematic Bars' then
		if v == '1' then
			doTweenY('enter1', 'bartop', 0, 1, 'expoOut')
			doTweenY('enter2', 'barbot', 620, 1, 'expoOut')
		elseif v == '' then
			doTweenY('exit1', 'bartop', -100, 1, 'expoOut')
			doTweenY('exit2', 'barbot', 720, 1, 'expoOut')
		end
	end
end