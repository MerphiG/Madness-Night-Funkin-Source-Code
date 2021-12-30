function onCreate()
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Bullet Note' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'BULLETNOTE_assets');
			setPropertyFromGroup('unspawnNotes', i, 'missHealth', 50.0);
			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', false);
			end
		end
	end
end

dodgeAnimations = {'dodgeLEFT', 'dodgeDOWN', 'dodgeUP', 'dodgeRIGHT'}
function goodNoteHit(id, noteData, noteType, isSustainNote)
    if noteType == 'Bullet Note' then
        characterPlayAnim('boyfriend', 'dodge', true);
        characterPlayAnim('grunt_gun', 'Grunt_shot', true);

		local animToPlay = '';
		if noteData == 0 then
			animToPlay = 'shot';
		elseif noteData == 1 then
			animToPlay = 'shot';
		elseif noteData == 2 then
			animToPlay = 'shot';
		elseif noteData == 3 then
			animToPlay = 'shot';
		end
		characterPlayAnim('dad', animToPlay, true);
		setProperty('dad.specialAnim', true);
	end
end

local healthDrain = 0;
function noteMiss(id, direction, noteType, isSustainNote)
    if noteType == 'Bullet Note' then
        characterPlayAnim('grunt_gun', 'Grunt_shot', true);
	end
end