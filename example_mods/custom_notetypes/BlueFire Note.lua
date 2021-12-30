function onCreate()
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'BlueFire Note' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'BLUEFIRENOTE_assets');
			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true);
			end
		end
	end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
	if noteType == 'BlueFire Note' then
	    curHealth = getProperty('health');
		damageValue = curHealth - 50.0;
		setProperty('health', damageValue);
	end
end