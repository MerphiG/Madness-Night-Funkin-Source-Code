--Last Edited 10/12/21 by SaturnSpades
--Tricky mod credits will be put here temporarily until in-game credits can be modified within Lua
--Tricky Mod Developers: Banbuds, Rosebud, KadeDev, CVal, YingYang48, JADS, Moro
--Special Thanks: Tom Fulp, Krinkels, GWebDev, Tsuraran
function onCreate()
	--Create Background sprites
	makeLuaSprite('bgtaburet', 'bgtaburet', -1200, -650);
	setLuaSpriteScrollFactor('bgtaburet', 0.9);

	makeLuaSprite('Energywall', 'Energywall', 1150, -400);

	makeLuaSprite('Spawnhole_Ground_BACK', 'Spawnhole_Ground_BACK', 203, 675);

	makeLuaSprite('Spawnhole_Ground_COVER', 'Spawnhole_Ground_COVER', 153, 700);
	
	makeLuaSprite('exback', 'exback', -650, -200);

	makeLuaSprite('exbackcover', 'exbackcover', 30, 725);
	--setLuaSpriteScrollFactor('exback', 0.9, 0.9);
	--scaleLuaSprite('expurgationback', 1.1, 1.1);

	-- sprites that only load if Low Quality is turned off
	if not lowQuality then
		--Low Quality mode not yet implemented
	end

	addLuaSprite('bgtaburet', false);
	addLuaSprite('Energywall', false);
	addLuaSprite('exback', false);
	addLuaSprite('exbackcover', true);
	addLuaSprite('Spawnhole_Ground_BACK', false);
	addLuaSprite('Spawnhole_Ground_COVER', true);
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end