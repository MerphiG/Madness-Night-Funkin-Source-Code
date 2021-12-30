function onEvent (name, value1, value2)
if name == 'Error' then

		makeAnimatedLuaSprite('Err', 'Err', -650, -360)
		scaleObject('Err', 2, 2);
		setLuaSpriteScrollFactor('Err', 0, 0);
		addAnimationByPrefix('Err', 'glitch', 'glitch', 24, true);
		addLuaSprite('Err', true)
		playSound('err', 1)
		
        runTimer('ErrorTimer', 1)
        doTweenAlpha('ErrorObj', 'Err', 1, 0.1, linear)
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
        if tag == 'ErrorTimer' then
                doTweenAlpha('ErrorObj', 'Err', 0, 0.1, linear)
        end 
end