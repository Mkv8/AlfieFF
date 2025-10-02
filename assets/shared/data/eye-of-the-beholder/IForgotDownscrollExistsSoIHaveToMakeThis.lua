function onCreatePost()
	if getPropertyFromClass('backend.ClientPrefs', 'data.downScroll') == true then
		downscroll = true
	else
		downscroll = false
	end
end

function onStepHit()
	if curStep == 914 then
		if downscroll == false then
			triggerEvent('Tween Variable', 'camHUD.y', '-600, 0, sineOut')
		else
			triggerEvent('Tween Variable', 'camHUD.y', '600, 0, sineOut')
		end
	elseif curStep == 1198 then
		if downscroll == false then
			triggerEvent('Tween Variable', 'camHUD.y', '-40, 18s, expoOut')
		else
			triggerEvent('Tween Variable', 'camHUD.y', '40, 18s, expoOut')
		end
	elseif curStep == 1728 then
		if downscroll == false then
			triggerEvent('Tween Variable', 'camHUD.y', '-30, 18s, expoOut')
		else
			triggerEvent('Tween Variable', 'camHUD.y', '30, 18s, expoOut')
		end
	elseif curStep == 1744 then
		if downscroll == false then
			triggerEvent('Tween Variable', 'camHUD.y', '-70, 448s, sineInOut')
		else
			triggerEvent('Tween Variable', 'camHUD.y', '70, 448s, sineInOut')
		end
	-- this next thing with the hud going down a bit on step 2240 (glass break) is probably intentional but on downscroll it makes your misscount and stuff invisible (at least for me)
	elseif curStep == 2240 and downscroll ~= false then
		triggerEvent('Tween Variable', 'camHUD.y', '0, 16s, expoOut')
	elseif curStep == 2496 then
		if downscroll == false then
			triggerEvent('Tween Variable', 'camHUD.y', '-40, 18s, expoOut')
		else
			triggerEvent('Tween Variable', 'camHUD.y', '40, 18s, expoOut')
		end
	elseif curStep == 3136 then
		if downscroll == false then
			triggerEvent('Tween Variable', 'camHUD.y', '-30, 18s, expoOut')
		else
			triggerEvent('Tween Variable', 'camHUD.y', '30, 18s, expoOut')
		end
	end
end