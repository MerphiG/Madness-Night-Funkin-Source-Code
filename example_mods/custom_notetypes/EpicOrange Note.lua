function onCreate()
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'EpicOrange Note' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'OrangeBone_assets');
			setPropertyFromGroup('unspawnNotes', i, 'missHealth', 0.2);
			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', false);
			end
		end
	end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
	if noteType == 'EpicOrange Note' then
	    curHealth = getProperty('health');
		damageValue = curHealth - -0.05;
		setProperty('health', damageValue);
	end
end