intro = true
function onCreatePost()
	if intro then
        setProperty('healthBarDei.alpha',0.01)
        setProperty('healthBarDei.y',655)
        setProperty('scoreImpact.y',(downscroll and 815 or -150))
        setProperty('barTop.y',(downscroll and 795 or -355))
        setProperty('barDown.y',(downscroll and -345 or 850))
        for i = 0,7 do
            setPropertyFromGroup('strumLineNotes',i,'visible',false)
        end
	end
end
function onTweenCompleted(t)
	if t == 'introLoadingFade' then
        setProperty('titleIntro.alpha',0.01)
		runHaxeCode([[
			FlxFlicker.flicker(game.getLuaObject('introLoading'), 5, 0.5, false, false);
		]])
	end
end
function onStepHit()
    if curStep == 175 and intro then
		doTweenY('introCameraY','camFollow',220,10,'sineOut')
        doTweenZoom('camGameIntro','camGame',0.569999999999997,9,'sineOut')
	end
    if curStep == 255 then
        doTweenY('healthBarDeiIntro','healthBarDei',(downscroll and 30 or 455),3.5,'quadInOut')
        doTweenY('scoreImpactIntro','scoreImpact',(downscroll and 625 or 50),3.5,'quadInOut')
        doTweenY('barTopIntro','barTop',(downscroll and 565 or -155),3.5,'quadInOut')
        doTweenY('barDownIntro','barDown',(downscroll and -155 or 500),3.5,'quadInOut')
    end
    if curStep == 288 then
        setProperty('healthBarDei.alpha',1)
        playAnim('healthBarDei','load',true)
        runHaxeCode([[
			FlxFlicker.flicker(game.getLuaObject('healthBarDei'), 1.3, 0.35, true, false);
		]])
    end
end