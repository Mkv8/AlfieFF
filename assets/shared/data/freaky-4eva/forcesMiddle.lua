function onCreate()
	setProperty('iconP2.alpha',0)
	if  getPropertyFromClass('backend.ClientPrefs','data.middleScroll') == true then
		middlescrollisalreadyon = true
	else
		middlescrollisalreadyon = false
	end
	if middlescrollisalreadyon == false then
		setPropertyFromClass('backend.ClientPrefs','data.middleScroll',true)
	end
end

function onCreatePost()
	for i = 0,3 do
		setPropertyFromGroup('strumLineNotes',i,'x',-330)
    end
end

function onDestroy()
	if middlescrollisalreadyon == false then
		setPropertyFromClass('backend.ClientPrefs','data.middleScroll',false)
	end
end