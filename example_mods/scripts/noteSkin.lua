local noteskinMap = {
	["gf-90s"] = "NOTE_assets",
	["90salfie"] = "ALFIENOTE_assets",
	["90skisston"] = "KISSNOTE_assets",
	default = "NOTE_assets"
}

function onCreatePost()
	local def = getPropertyFromClass("PlayState", "SONG.arrowSkin")
	if def == nil or #def < 1  or def == "SONG.arrowSkin" then
   	 def = "NOTE_assets"
	end
	noteskinMap["default"] = def

	setCharSkin("opponentStrums", getProperty("dad.curCharacter"))
	setCharSkin("playerStrums", getProperty("boyfriend.curCharacter"))

	for i = 0, getProperty("eventNotes.length")-1 do
		if getPropertyFromGroup("eventNotes", i, "event") == "Change Character" then
			local val2 = getPropertyFromGroup("eventNotes", i, "value2")
			precacheImage(getNoteSkin(val2))
		end
	end
end

function onCountdownStarted()
	setCharSkin("opponentStrums", getProperty("dad.curCharacter"))
        setCharSkin("playerStrums", getProperty("boyfriend.curCharacter"))
end

function onEvent(ev, val1, val2)
	if ev == "Change Character" then
		setCharSkin("opponentStrums", getProperty("dad.curCharacter"))
		setCharSkin("playerStrums", getProperty("boyfriend.curCharacter"))
	end
end

function getNoteSkin(_char)
	if noteskinMap[_char] ~= nil then
		return noteskinMap[_char]
	end
	return noteskinMap["default"]
end

function noteReskin(noteGroup, skin, mustPressCheck)
	for i = 0, getProperty(noteGroup..".length")-1 do
		if getPropertyFromGroup(noteGroup, i, "mustPress") == mustPressCheck then
			if getPropertyFromGroup(noteGroup, i, "noteType") == "" then
				setPropertyFromGroup(noteGroup, i, "texture", skin)
			end
		end
	end
end

function setCharSkin(strums, _char)
	local skin = getNoteSkin(_char)

	print("Note Skin Used for ".._char .. " is "..skin)

	for i = 0, getProperty(strums..".length")-1 do
		setPropertyFromGroup(strums, i, "texture", skin)
	end

	local mustPressCheck = false
	if strums == "playerStrums" then
		mustPressCheck = true
	end

	noteReskin("notes", skin, mustPressCheck)
	noteReskin("unspawnNotes", skin, mustPressCheck)
end