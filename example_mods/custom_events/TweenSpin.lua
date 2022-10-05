function onEvent(name, value1, value2)
	-- bf notespin
	noteTweenAngle('A',4 , value2 , value1, 'quintOut');
	noteTweenAngle('B',5 , value2 , value1, 'quintOut');
	noteTweenAngle('C',6 , value2 , value1, 'quintOut');
	noteTweenAngle('D',7 , value2 , value1, 'quintOut');
	
	-- oppt notespin
	noteTweenAngle('E',0 , value2 , value1, 'quintOut');
	noteTweenAngle('F',1 , value2 , value1, 'quintOut');
	noteTweenAngle('G',2 , value2 , value1, 'quintOut');
	noteTweenAngle('H',3 , value2 , value1, 'quintOut');
	
	
end