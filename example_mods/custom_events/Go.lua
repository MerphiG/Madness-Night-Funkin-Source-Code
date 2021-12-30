function onEvent(name, value1, value2)
	if name == 'Go' then
	
		makeLuaSprite('Go', 'go', 340, 150); 
		setLuaSpriteScrollFactor('Go', 0, 0);
		scaleObject('Go', 1, 1);
		
		addLuaSprite('Go', true)
		
		doTweenAlpha('GoAlpha', 'Go', 0, 0.3, linear)
	end
end