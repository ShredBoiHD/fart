function onCreate()
	-- background shit
	makeLuaSprite('gates', 'gates', -600, -300);
	setLuaSpriteScrollFactor('stageback', 2, 2);
	
	makeLuaSprite('grass', 'grass', -650, 600);
	setLuaSpriteScrollFactor('grass', 2, 2);
	scaleObject('grass', 2, 2);

	-- sprites that only load if Low Quality is turned off
	if not lowQuality then
		makeLuaSprite('hills', 'hills', -125, -100);
		setLuaSpriteScrollFactor('no', 0.9, 0.9);
		scaleObject('hills', 2, 2);
		
		makeLuaSprite('sky', 'sky', 1225, -100);
		setLuaSpriteScrollFactor('no', 0.9, 0.9);
		scaleObject('sky', 2.5, 2.8);
		setPropertyLuaSprite('no', 'flipX', true); --mirror sprite horizontally

		makeLuaSprite('no', 'no', -500, -300);
		setLuaSpriteScrollFactor('no', 1.3, 1.3);
		scaleObject('no', 0.9, 0.9);
	end

	addLuaSprite('gates', false);
	addLuaSprite('grass', false);
	addLuaSprite('hills', false);
	addLuaSprite('sky', false);
	addLuaSprite('no', false);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end