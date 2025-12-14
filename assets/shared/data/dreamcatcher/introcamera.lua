function onCreatePost()
	triggerEvent('Camera Movement', 'dad, -350, -50', '0')
	triggerEvent('Set Cam Zoom', '1.55x', '0')
end

function onCountdownTick(counter)
	if counter == 0 then
		triggerEvent('Camera Movement', 'middle', '1.5, cubeInOut')
		triggerEvent('Set Cam Zoom', '1x', '1.5, cubeInOut')
	end
	-- counter = 0 -> "Three"
	-- counter = 1 -> "Two"
	-- counter = 2 -> "One"
	-- counter = 3 -> "Go!"
	-- counter = 4 -> Nothing happens lol, tho it is triggered at the same time as onSongStart i think
end