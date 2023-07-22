function onCreate()
    luaDebugMode = true

    makeLuaSprite('barTop','hud/deimos/barTop',-45,565)
    scaleObject('barTop',0.666504618376276,0.666504618376276)
    setObjectCamera('barTop','camHUD')
    screenCenter('barTop','x')
    setProperty('barTop.flipY',downscroll)
    addLuaSprite('barTop')

    makeLuaSprite('barDown','hud/deimos/barDown',-47,-155)
    scaleObject('barDown',0.666666666666667,0.666666666666667)
    setObjectCamera('barDown','camHUD')
    screenCenter('barDown','x')
    setProperty('barDown.flipY',downscroll)
    addLuaSprite('barDown')

    makeAnimatedLuaSprite('healthBarDei','hud/deimos/bar-down',880,30)
    addAnimationByPrefix('healthBarDei','health','health',24,false)
    addAnimationByIndices('healthBarDei','dead','load','6,5,4,3,2,1,0',24)
    addAnimationByPrefix('healthBarDei','load','load',24,false)
    scaleObject('healthBarDei',0.665551839464883,0.665551839464883)
    setObjectCamera('healthBarDei','camHUD')
    addLuaSprite('healthBarDei',true)

    makeAnimatedLuaSprite('gfDialogue','hud/deimos/gfText',70,10)
	addAnimationByPrefix('gfDialogue','dial','GF TEXT',24,false)
	scaleObject('gfDialogue',0.666288308740068,0.666288308740068)
	setProperty('gfDialogue.alpha',0.01)
	setObjectCamera('gfDialogue','camHUD')
	addLuaSprite('gfDialogue')

    makeLuaText('scoreImpact','0',1280,0,625)
    setTextFont('scoreImpact','impact.ttf')
    setTextAlignment('scoreImpact','center')
    setTextSize('scoreImpact',40)
    setTextColor('scoreImpact','f40033')
    setTextBorder('scoreImpact',0,'000000')
    addLuaText('scoreImpact')
    runHaxeCode([[
        game.initLuaShader('textGlitch');
        txtGlitch = game.createRuntimeShader('textGlitch');
        game.getLuaObject('scoreImpact',true).shader = txtGlitch;
    ]])
    setProperty('grpNoteSplashes.visible',false)
end
local hudObjects = {'healthBarBG','healthBar','scoreTxt','timeBarBG','timeBar','timeTxt','iconP1','iconP2'}
function onCreatePost()
    runHaxeCode([[
        strumHUD = new FlxCamera();
		strumHUD.bgColor = 0x00000000;
        FlxG.cameras.add(strumHUD,false);  
        game.variables.set('strumHUD', strumHUD);
        for (i in 0...8) game.strumLineNotes.members[i].cameras = [strumHUD];
        for (splash in game.grpNoteSplashes) splash.cameras = [strumHUD];
        for (note in game.unspawnNotes) 
        {
            note.cameras = [strumHUD];
            if (note.isSustainNote) note.cameras = [game.camHUD];
        };
    ]])
    for i = 0,3 do
        setPropertyFromGroup('playerStrums',i,'texture','dedmosNotes')
        setPropertyFromGroup('opponentStrums',i,'texture','deimosNotes')
    end
    for n = 0,getProperty('unspawnNotes.length')-1 do
        if getPropertyFromGroup('unspawnNotes',n,'isSustainNote') then
            setPropertyFromGroup('unspawnNotes',n,'copyAlpha',false)
            setPropertyFromGroup('unspawnNotes',n,'alpha',1)
        end
        if getPropertyFromGroup('unspawnNotes',n,'noteType') == 'bulletMC' then
        else
            if getPropertyFromGroup('unspawnNotes',n,'mustPress') then
                setPropertyFromGroup('unspawnNotes',n,'texture','dedmosNotes')
            else
                setPropertyFromGroup('unspawnNotes',n,'texture','deimosNotes')
            end
        end
    end
    for o = 1,#hudObjects do setProperty(hudObjects[o]..'.visible',false)end
end
local lerpScore = 0
function onUpdate(elapsed)
    runHaxeCode("txtGlitch.setFloat('iTime',"..(getSongPosition() / 0.1)..")")
    lerpScore = math.floor(lerp(lerpScore,score,boundTo(elapsed * 12, 0, 1)))
    setTextString('scoreImpact',lerpScore)

    for i = 0,7 do
        setPropertyFromGroup('strumLineNotes',i,'y',lerp(getPropertyFromGroup('strumLineNotes',i,'y'),defaultOpponentStrumY0, boundTo(elapsed * 5, 0, 1)))
    end
end
function goodNoteHit(i,d,n,s)
    setPropertyFromGroup('playerStrums',d,'y',getPropertyFromGroup('playerStrums',d,'y') + (downscroll and 10 or -10))

    if not s then
        createSplashPL(d,n)
    end
end
function opponentNoteHit(i,d,n,s)
    if getPropertyFromGroup('notes', i, 'animation.curAnim.name'):find('hold') then
        runHaxeCode("game.opponentStrums.members["..d.."].playAnim('static', true)")
    end
    if not s then
        setPropertyFromGroup('opponentStrums',d,'y',getPropertyFromGroup('opponentStrums',d,'y') + (downscroll and 10 or -10))
        createSplashOP(d,n)
    end
end
function onEvent(n,v1,v2)
    if n == 'Flash' then
        setProperty('redOverlay.alpha',v1)
        doTweenAlpha('redOverlay','redOverlay',0,0.3)
    end
end

slP = 0
function createSplashPL(di,nt) -- kinda buggy but eh..
    slP = slP + 1
    local tag = 'CSplashesP'..slP
    local anims = {'purple','blue','green','red'}
    makeAnimatedLuaSprite(tag, (nt == 'bulletMC' and 'bullet' or 'bfSplash'), getPropertyFromGroup('playerStrums',di,'x') - 130, getPropertyFromGroup('playerStrums',di,'y') + (nt == 'bulletMC' and -130 or -150))
    addAnimationByPrefix(tag, anims[di+1], 'note splash '..anims[di+1]..' '..getRandomInt(1,2), 32, false)
    setObjectCamera(tag,'camHUD')
    runHaxeCode([[
        game.getLuaObject(']]..tag..[[').camera = strumHUD;
    ]])
    addLuaSprite(tag,true)
end
slO = 0
function createSplashOP(di,nt) -- kinda buggy but eh..
    slO = slO + 1
    local tag = 'CSplashesO'..slO
    local anims = {'purple','blue','green','red'}
    makeAnimatedLuaSprite(tag, (nt == 'bulletMC' and 'bullet' or 'deimosSplash'), getPropertyFromGroup('opponentStrums',di,'x') - 110, getPropertyFromGroup('opponentStrums',di,'y') + (nt == 'bulletMC' and -130 or -80))
    addAnimationByPrefix(tag, anims[di+1], 'note splash '..anims[di+1]..' '..getRandomInt(1,2), 32, false)
    runHaxeCode([[
        game.getLuaObject(']]..tag..[[').camera = strumHUD;
    ]])
    addLuaSprite(tag,true)
end
function onUpdatePost()
    setProperty('strumHUD.zoom',getProperty('camHUD.zoom'))
    for a = 1, slO do
        if getProperty('CSplashesO'..a..'.animation.curAnim.finished') then
            removeLuaSprite('CSplashesO'..a,false)
        end
    end     
    for b = 1, slP do
        if getProperty('CSplashesP'..b..'.animation.curAnim.finished') then
            removeLuaSprite('CSplashesP'..b,false)
        end
    end   
end


function lerp(a, b, t)
    return (1-t)*a + t*b
end
function boundTo(val, min, max)
    if val < min then
        return min
    elseif val > max then
        return max
    else
        return val
    end
end
