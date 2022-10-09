function onCreate()
	-- background shit
	makeLuaSprite('DAVE', 'DAVE', -500, -300);
	setLuaSpriteScrollFactor('DAVE', 0.9, 0.9);
	
	makeLuaSprite('DAVE', 'DAVE', -650, 600);
	setLuaSpriteScrollFactor('DAVE', 0.9, 0.9);
	scaleObject('DAVE', 3, 3);

	-- sprites that only load if Low Quality is turned off
	if not lowQuality then
		makeLuaSprite('no', 'no', -125, -100);
		setLuaSpriteScrollFactor('no', 0.9, 0.9);
		scaleObject('no', 1.1, 1.1);
		
		makeLuaSprite('no', 'no', 1225, -100);
		setLuaSpriteScrollFactor('no', 0.9, 0.9);
		scaleObject('no', 1.1, 1.1);
		setPropertyLuaSprite('no', 'flipX', true); --mirror sprite horizontally

		makeLuaSprite('no', 'no', -500, -300);
		setLuaSpriteScrollFactor('no', 1.3, 1.3);
		scaleObject('no', 0.9, 0.9);
	end

	addLuaSprite('DAVE', true);
	addLuaSprite('DAVE', true);
	addLuaSprite('no', false);
	addLuaSprite('no', false);
	addLuaSprite('no', false);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end