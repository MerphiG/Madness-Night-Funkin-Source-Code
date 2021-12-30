function onCreate()
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'EpicBlue Note' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'BlueBone_assets');
			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true);
			end
		end
	end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
	if noteType == 'EpicBlue Note' then
	    curHealth = getProperty('health');
		damageValue = curHealth - 0.2;
		setProperty('health', damageValue);
	end
end