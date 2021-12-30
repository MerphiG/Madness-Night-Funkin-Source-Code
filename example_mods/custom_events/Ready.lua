function onEvent(name, value1, value2)
	if name == 'Ready' then
	
		makeLuaSprite('Ready', 'ready', 260, 190); 
		setLuaSpriteScrollFactor('Ready', 0, 0);
		scaleObject('Ready', 1, 1);
		
		addLuaSprite('Ready', true)
		
		doTweenAlpha('ReadyAlpha', 'Ready', 0, 0.3, linear)
	end
end