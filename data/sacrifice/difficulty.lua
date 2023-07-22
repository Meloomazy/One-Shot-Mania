function onCreate()
    precacheSound('change')
    precacheSound('deimos_acept')
    setProperty('skipCountdown',true)
end
function onCreatePost()
    setProperty('isCameraOnForcedPos',true)
    setProperty('camFollow.x',200)
    setProperty('camFollow.y',240)
    setProperty('camFollowPos.x',200)
    setProperty('camFollowPos.y',240)
end
function onSongStart(t)
    openCustomSubstate('ChooseDifficultySubstate', true)
end
function onCustomSubstateCreate(n)
    if n == 'ChooseDifficultySubstate' then
        makeLuaSprite('backDiffi',nil)
        makeGraphic('backDiffi',1280, 720,'000000')
        setScrollFactor('backDiffi',0,0)
        screenCenter('backDiffi')
        setProperty('backDiffi.alpha',0.7)
        setObjectCamera('backDiffi','camHUD')
        addLuaSprite('backDiffi')
    
        makeAnimatedLuaSprite('choose','hud/deimos/choose',260,70)
        scaleObject('choose',0.6,0.6)
        addAnimationByPrefix('choose','chooseLoop','mensaje',24,true)
        setObjectCamera('choose','camHUD')
    
        makeAnimatedLuaSprite('diff','hud/deimos/diff',560,200)
        scaleObject('diff',0.5,0.5)
        addAnimationByPrefix('diff','standard','standard',24,false)
        addAnimationByPrefix('diff','madness','madness loop',24,true)
        setObjectCamera('diff','camHUD')
    
        makeAnimatedLuaSprite('exp','hud/deimos/exp',580,230)
        scaleObject('exp',0.57,0.57)
        addAnimationByPrefix('exp','standard','standard explanation',24,false)
        addAnimationByPrefix('exp','madness','madness explanation',24,false)
        setObjectCamera('exp','camHUD')
    
        makeAnimatedLuaSprite('gruntTuto','hud/deimos/grunt_tutorial',410,270)
        scaleObject('gruntTuto',0.57,0.57)
        addAnimationByPrefix('gruntTuto','standard','STANDARD MODE MISS0',24,true)
        addAnimationByPrefix('gruntTuto','madness','MADNESS MODE MISS0',24,true)
        setObjectCamera('gruntTuto','camHUD')
        addLuaSprite('gruntTuto')  
        
        
        runHaxeCode("CustomSubstate.instance.add(game.getLuaObject('choose'));")
        runHaxeCode("CustomSubstate.instance.add(game.getLuaObject('diff'));")
        runHaxeCode("CustomSubstate.instance.add(game.getLuaObject('exp'));")
        runHaxeCode("CustomSubstate.instance.add(game.getLuaObject('gruntTuto'));")
        setProperty('boyfriend.alpha',0.01)
        setProperty('gf.alpha',0.01)
        setProperty('dad.alpha',0.01)
    end
end
isStandard = false
accepted = false
stopKeyboard = false
h = 0
function onCustomSubstateUpdatePost(n,e)
    h = h + e * 1000
	if n == 'ChooseDifficultySubstate' then
        setProperty('bg6.y',-1545.22 + math.sin(h / 500) * 5)
        if not stopKeyboard then
            if keyboardJustPressed('D') or keyboardJustPressed('RIGHT') then
                if not isStandard then
                    isStandard = true
                    playSound('change',1)
                    playAnim('gruntTuto','madness',true)
                    playAnim('exp','madness',true)
                    playAnim('diff','madness',true)
                end
            end
            if keyboardJustPressed('A') or keyboardJustPressed('LEFT') then
                if isStandard then
                    isStandard = false
                    playSound('change',1)
                    playAnim('gruntTuto','standard',true)
                    playAnim('exp','standard',true)
                    playAnim('diff','standard',true)
                end
            end
        end
        if keyJustPressed('accept') and not accepted then
            accepted = true
            stopKeyboard = true
            setProperty('backDiffi.alpha',0.01)
            setProperty('exp.alpha',0.01)
            setProperty('diff.alpha',0.01)
            setProperty('choose.alpha',0.01)
            setProperty('gruntTuto.alpha',0.01)
    
            playSound('deimos_acept',1)
            cameraFlash('camHUD','ff0000',1)
            setProperty('camGame.zoom',0.72)
            runTimer('startSong',2.5)
            setProperty('camFollow.x',200)
            setProperty('camFollow.y',-2270)
            setProperty('camFollowPos.x',200)
            setProperty('camFollowPos.y',-2270)
            setProperty('boyfriend.alpha',1)
            setProperty('gf.alpha',1)
            setProperty('dad.alpha',1)
            if standard then
            else
                for n = 0,getProperty('unspawnNotes.length')-1 do
                    if getPropertyFromGroup('unspawnNotes',n,'noteType') == 'bulletMC' then
                        setPropertyFromGroup('unspawnNotes',n,'missHealth', 2)
                    end
                end
            end
        end
        if keyJustPressed('back') then
            closeCustomSubstate()
            exitSong()
        end
	end
end

function onCustomSubstateDestroy(n)
	if n == 'ChooseDifficultySubstate' then
    
	end
end
function onUpdate()
   
end

function onTimerCompleted(t)
    if t == 'startSong' then
        closeCustomSubstate()
        setProperty('flicker.alpha',0.01)
        runHaxeCode([[
            FlxFlicker.flicker(game.getLuaObject('titleIntro'), 1, 0.5, true, false, function(introDone:FlxFlicker)
                {
                    game.getLuaObject('titleIntro').animation.play('start',true);
                    FlxG.sound.play(Paths.sound('title'));
                });
        ]])
        setProperty('titleIntro.alpha',1)
    end
end