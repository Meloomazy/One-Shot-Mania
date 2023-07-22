intro = true
function onCreate()
    makeAnimatedLuaSprite('titleIntro','bgs/deimos/title',-370,-2400)
    scaleObject('titleIntro',0.8,0.8)
    addAnimationByPrefix('titleIntro','start','intro',24,false)
    addAnimationByIndices('titleIntro','tick','intro','0,0',24)
    playAnim('titleIntro','tick',true)
    addLuaSprite('titleIntro')
    setProperty('titleIntro.alpha',0.01)

    makeLuaSprite('introLoading','bgs/deimos/loading',20,-2320)
    scaleObject('introLoading',0.8,0.8)
    setProperty('introLoading.alpha',0.01)
    addLuaSprite('introLoading')
end
function onCreatePost()
	if intro then
        setProperty('healthBarDei.alpha',0.01)
        setProperty('healthBarDei.y',-200)
        setProperty('scoreImpact.y',795)
        setProperty('barTop.y',795)
        setProperty('barDown.y',-345)
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
    if curStep == 255 then
        doTweenY('healthBarDeiIntro','healthBarDei',(downscroll and 30 or 0),3.5,'quadInOut')
        doTweenY('scoreImpactIntro','scoreImpact',(downscroll and 625 or 0),3.5,'quadInOut')
        doTweenY('barTopIntro','barTop',(downscroll and 565 or 0),3.5,'quadInOut')
        doTweenY('barDownIntro','barDown',(downscroll and -155 or 0),3.5,'quadInOut')
    end
    if curStep == 288 then
        setProperty('healthBarDei.alpha',1)
        playAnim('healthBarDei','load',true)
        runHaxeCode([[
			FlxFlicker.flicker(game.getLuaObject('healthBarDei'), 1.3, 0.35, true, false);
		]])
    end
	if curStep == 175 and intro then
		doTweenY('introCameraY','camFollow',220,10,'sineOut')
        doTweenZoom('camGameIntro','camGame',0.569999999999997,9,'sineOut')
	end
end