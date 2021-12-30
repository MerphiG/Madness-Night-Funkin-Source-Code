function onCreate()
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'TikyMogus Note' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'TIKY_assets');
			setPropertyFromGroup('unspawnNotes', i, 'missHealth', 50.0);
			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', false);
			end
		end
	end
end

dodgeAnimations = {'dodgeLEFT', 'dodgeDOWN', 'dodgeUP', 'dodgeRIGHT'}
function goodNoteHit(id, noteData, noteType, isSustainNote)
    if noteType == 'TikyMogus Note' then
        characterPlayAnim('boyfriend', 'dodge', true);
        characterPlayAnim('tikymogus', 'knife', true);
		playSound('knife', 1)

		local animToPlay = '';
		if noteData == 0 then
			animToPlay = 'knife';
		elseif noteData == 1 then
			animToPlay = 'knife';
		elseif noteData == 2 then
			animToPlay = 'knife';
		elseif noteData == 3 then
			animToPlay = 'knife';
		end
		characterPlayAnim('dad', animToPlay, true);
		setProperty('dad.specialAnim', true);
	end
end

local healthDrain = 0;
function noteMiss(id, direction, noteType, isSustainNote)
    if noteType == 'TikyMogus Note' then
	    playSound('knife', 1)
        characterPlayAnim('tikymogus', 'knife', true);
	end
end