function onEvent(name, value1, value2)
	if name == 'Set' then
	
		makeLuaSprite('Set', 'set', 260, 190); 
		setLuaSpriteScrollFactor('Set', 0, 0);
		scaleObject('Set', 1, 1);
		
		addLuaSprite('Set', true)
		
		doTweenAlpha('SetAlpha', 'Set', 0, 0.3, linear)
	end
end