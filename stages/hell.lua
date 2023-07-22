
function onCreate()
	luaDebugMode = true
	addHaxeLibrary('FlxFlicker','flixel.effects')
	addHaxeLibrary("FileSystem", "sys")
    addHaxeLibrary("File", "sys.io")
	addHaxeLibrary("String")
	addHaxeLibrary("Sys")

	precacheStuff()
	shaderCoordFix()

--- graphic stuff
	makeLuaSprite('whiteOverlay',nil)
	makeGraphic('whiteOverlay',1280,720,'ffffff')
	setObjectCamera('whiteOverlay','camHUD')
	setProperty('whiteOverlay.alpha',0.01)
	addLuaSprite('whiteOverlay')

	makeLuaSprite('redOverlay',nil)
	makeGraphic('redOverlay',1280,720,'ff0000')
	setObjectCamera('redOverlay','camHUD')
	setProperty('redOverlay.alpha',0.01)
	addLuaSprite('redOverlay')

	makeLuaSprite('flicker',nil)
	makeGraphic('flicker',1280,720,'000000')
	setObjectCamera('flicker','camHUD')
	setProperty('flicker.alpha',0.01)
	addLuaSprite('flicker')
---

-- the the uhh stage i guess
	makeLuaSprite('sky','bgs/deimos/sky',-1482,-2323)
	setScrollFactor('sky',0.81, 0.9)
	addLuaSprite('sky')

	makeAnimatedLuaSprite('rayo','bgs/deimos/rayo',-624,-1371)
	addAnimationByPrefix('rayo','ray','ray',24,false)
	setProperty('rayo.flipX',getRandomBool(50))
	setProperty('rayo.alpha',0.01)
	addLuaSprite('rayo')

	makeLuaSprite('bg7','bgs/deimos/bg 7',-1461,-2970)
	setScrollFactor('bg7', 1, 1.5)
	addLuaSprite('bg7')

	makeAnimatedLuaSprite('grunt1','bgs/deimos/grunt',685,-1305)
	setScrollFactor('grunt1',1,0.91)
	addAnimationByPrefix('grunt1','intro','grunt normal',24,false)
	addAnimationByPrefix('grunt1','fall','grunt morido',24,true)
	playAnim('grunt1','fall',true)
	setProperty('grunt1.alpha',0.01)
	addLuaSprite('grunt1')

	makeLuaSprite('bg6','bgs/deimos/bg 6',-687,-1545.22)
	setScrollFactor('bg6', 1, 0.91)
	addLuaSprite('bg6')

	makeLuaSprite('bg5','bgs/deimos/bg 5',-1475,-985)
	setScrollFactor('bg5',1,0.98)
	addLuaSprite('bg5')

	makeAnimatedLuaSprite('agentAp','bgs/deimos/agent appear',150,-150)
	scaleObject('agentAp',0.9,0.9)
	addAnimationByPrefix('agentAp','idle','agent appear',24,false)
	setProperty('agentAp.alpha',0.01)
	addLuaSprite('agentAp')

	makeAnimatedLuaSprite('guntAp','bgs/deimos/gunt appear',-660,40)
	scaleObject('guntAp',0.85,0.85)
	addAnimationByPrefix('guntAp','idle','grunt appear',24,false)
	setProperty('guntAp.alpha',0.01)
	addLuaSprite('guntAp')

	makeAnimatedLuaSprite('soldatAp','bgs/deimos/soldat appear',-401,-60)
	scaleObject('soldatAp',0.85,0.85)
	addAnimationByPrefix('soldatAp','idle','soldat appear',24,false)
	setProperty('soldatAp.flipX',true)
	setProperty('soldatAp.alpha',0.01)
	addLuaSprite('soldatAp')

	makeAnimatedLuaSprite('barricada','bgs/deimos/barricada', 388,-44)
	scaleObject('barricada',0.81,0.81)
	addAnimationByPrefix('barricada','shot','barricada shot',24,false)
	addAnimationByPrefix('barricada','appear','barricada appears',24,false)
	addAnimationByIndices('barricada','what','barricada appears','0,0',24)
	addAnimationByPrefix('barricada','death','barricada death',24,false)
	addAnimationByPrefix('barricada','idle','barricada idle',24,true)
	playAnim('barricada','what',true)
	addLuaSprite('barricada')

	makeAnimatedLuaSprite('barricada_hank','bgs/deimos/barricada_hank', 225,-195)
	scaleObject('barricada_hank',0.81,0.81)
	addAnimationByPrefix('barricada_hank','intro','hank cameo intro',24,false)
	addAnimationByPrefix('barricada_hank','bye','hank chao',24,false)
	addAnimationByPrefix('barricada_hank','idle','hank idle',24,true)
	addAnimationByIndices('barricada_hank','what','hank cameo intro','0,0',24)
	playAnim('barricada_hank','what',true)
	addLuaSprite('barricada_hank')

	makeLuaSprite('bg1','bgs/deimos/bg 1',-1559,-210)
	setScrollFactor('bg1', 1,0.9)
	addLuaSprite('bg1')

	makeLuaSprite('bg2','bgs/deimos/bg2',-1575,30)
	setScrollFactor('bg2', 1, 0.78)
	addLuaSprite('bg2',true)

	makeAnimatedLuaSprite('chains','bgs/deimos/chains',-1734,-1835)
	addAnimationByPrefix('chains','cut','chains',24,false)
	setProperty('chains.alpha',0.01)
	addLuaSprite('chains',true)

	makeAnimatedLuaSprite('polvo','bgs/deimos/polvo',-421,123)
	addAnimationByPrefix('polvo','smoke','polvo',24,false)
	setProperty('polvo.alpha',0.01)
	addLuaSprite('polvo',true)

	makeAnimatedLuaSprite('piedra','bgs/deimos/piedra',61,-1151)
	addAnimationByPrefix('piedra','in','pilar in',24,false)
	addAnimationByPrefix('piedra','out','pilar out',24,false)
	setProperty('piedra.alpha',0.01)
	addLuaSprite('piedra',true)

	makeAnimatedLuaSprite('mira','bgs/deimos/mira',188,-345)
	addAnimationByPrefix('mira','lock','alert shoot',24,false)
	setProperty('mira.alpha',0.01)
	addLuaSprite('mira',true)

	makeAnimatedLuaSprite('finalChains','bgs/deimos/final',-1323,-644)
	addAnimationByPrefix('finalChains','chain','cadenas',24,false)
	setProperty('finalChains.alpha',0.01)
	addLuaSprite('finalChains',true)
	
-- for something :)
	setScrollFactor('agentAp',1,0)
	setScrollFactor('guntAp',1,0)
	setScrollFactor('soldatAp',1,0)
	setScrollFactor('chains',1,0)
	setScrollFactor('polvo',1,0)
	setScrollFactor('piedra',0,0)
	setScrollFactor('mira',1,0)
	setScrollFactor('finalChains',1,0)
	setScrollFactor('deimosAction',1,0)

	runHaxeCode([[
		game.initLuaShader('BgDeimos');
		game.initLuaShader('TvGlitch');
		game.initLuaShader('amongus');

		bgDeim = game.createRuntimeShader('BgDeimos');
		TvG = game.createRuntimeShader('TvGlitch');
		ray = game.createRuntimeShader('amongus');
		ray.setFloat('FlashIntensity',1);

		deimosAction = new Character(-765,-5,'deimos-Action');
		deimosAction.alpha = 0.01;
		game.variables.set('deimosAction',deimosAction);
		game.addBehindDad(deimosAction);
	]])

end
introCompleted = false
endingMoment = false
hanked = false
function onStepHit()
	if curStep == 946 then bfMoment = true end
	if curStep == 216 then ray() end
end
it = 0
function onUpdate(e)
	it = it + e * 0.5
	runHaxeCode("bgDeim.setFloat('iTime',"..it..")")
	runHaxeCode("TvG.setFloat('iTime',"..it..")")

	setProperty('bg6.y',-1545.22 + math.sin(getSongPosition() / 500) * 5)

	if bfMoment then
		if getProperty('mira.animation.curAnim.name') == 'lock' and getProperty('mira.animation.curAnim.finished') then
			setProperty('mira.alpha',0.01)
		end
		if getProperty('polvo.animation.curAnim.name') == 'smoke' and getProperty('polvo.animation.curAnim.finished') then
			setProperty('polvo.alpha',0.01)
		end
		if getProperty('piedra.animation.curAnim.name') == 'out' and getProperty('piedra.animation.curAnim.finished') then
			setProperty('piedra.alpha',0.01)
		end
		if getProperty('gfDialogue.animation.curAnim.name') == 'dial' and getProperty('gfDialogue.animation.curAnim.finished') then
			setProperty('gfDialogue.alpha',0.01)
		end
		if getProperty('boyfriend.animation.curAnim.name') == 'hey' and getProperty('boyfriend.animation.curAnim.finished') and not introCompleted then
			bfMoment = false
			setProperty('camZooming',true)
		end
	end
	if getProperty('titleIntro.animation.curAnim.name') == 'start' and getProperty('titleIntro.animation.curAnim.finished') and not introCompleted then
		introCompleted = true
		doTweenAlpha('introLoadingFade','introLoading',1,1,'linear')
	end
	if getProperty('barricada_hank.animation.curAnim.name') == 'intro' and getProperty('barricada_hank.animation.curAnim.finished') then
		playAnim('barricada_hank','idle',true)
	end
	if getProperty('barricada_hank.animation.curAnim.name') == 'bye' and getProperty('barricada_hank.animation.curAnim.finished') then
		setProperty('barricada_hank.alpha',0.01)
	end
	if getProperty('barricada_hank.animation.curAnim.name') == 'intro' and getProperty('barricada_hank.animation.curAnim.curFrame') == 42 and not hanked then
		hanked = true
		playSound('die',0.8)
	end
	if getProperty('barricada.animation.curAnim.name') == 'shot' and getProperty('barricada.animation.curAnim.finished') or getProperty('barricada.animation.curAnim.name') == 'appear' and getProperty('barricada.animation.curAnim.finished') and not endingMoment then
		playAnim('barricada','idle',true)
	end
	if getProperty('rayo.animation.curAnim.name') == 'ray' and getProperty('rayo.animation.curAnim.finished') then
		setProperty('rayo.alpha',0.01)
	end
	
	if getProperty('gf.animation.curAnim.name') == 'reaction' and getProperty('gf.animation.curAnim.finished') then
		setProperty('gfDialogue.alpha',1)
		playAnim('gfDialogue','dial',true)
		playAnim('gf','angry',true)
		playSound('gfangry',0.95)
		playSound('gfTalk',0.9)
		runTimer('gfAngry',1.4)
		setProperty('gf.skipDance',true)
	end
	if getProperty('gf.animation.curAnim.name') == 'final' and getProperty('gf.animation.curAnim.finished') then
		playAnim('gf','laugh',true)
	end
	if getProperty('gf.animation.curAnim.name') == 'laugh' and getProperty('gf.animation.curAnim.curFrame') == 10 then
		ending()
		endingMoment = true
		playAnim('barricada','appear',true)
		playAnim('boyfriend','reaction',true)
	end	
	if getProperty('gf.animation.curAnim.name') == 'laugh' and getProperty('gf.animation.curAnim.curFrame') == 9 then
		deimosAct('final')
		runTimer('deimosAct',15)--lmao
	end	
end
function onEvent(n,v1,v2)
	if n == 'barrierThing' then
		if v1 == 'parry' then
			deimosAct('parry')
			runTimer('deimosAct',0.6)
			playSound('parry',1)
		elseif v1 == 'shotParry' then
			playAnim('barricada','shot',true)
			playAnim('gf','dodge',true)
			playSound('shoot',1)
			setProperty('gf.skipDance',true)
			runTimer('barrierDied',0.5)
		elseif v1 == 'deathParry' then
			playAnim('barricada','death',true)
			playSound('die',0.9)
		end
	end
end
function onTimerCompleted(t)
	if t == 'rayCooldown' then
		ray()
	end
	if t == 'deimosAct' then
		setProperty('gf.skipDance',false)
		setProperty('dad.alpha',1)
		setProperty('deimosAction.alpha',0.01)
	end
	if t == 'gfAngry' then
		triggerEvent('Alt Idle Animation','gf','-alt')
		setProperty('gf.skipDance',false)
	end
	if t == 'skipBF' then
		for i = 0,getProperty('notes.length')-1 do
			if getPropertyFromGroup('notes',i,'mustPress') then
            	setPropertyFromGroup('notes',i,'noAnimation',false)
			end
        end
		setProperty('boyfriend.skipDance',false)
	end
end
function goodNoteHit(i,d,n)
	if n == 'bulletMC' then
		for i = 0,getProperty('notes.length')-1 do
			if getPropertyFromGroup('notes',i,'mustPress') then
            	setPropertyFromGroup('notes',i,'noAnimation',true)
			end
        end
		setProperty('boyfriend.skipDance',true)
		runTimer('skipBF',0.3)
		deimosAct('shot1')
	end
end
function opponentNoteHit(i,d,n)
	if n == 'bulletMC' then
		deimosAct('shot1')
	end
end
function deimosAct(anim)
	playAnim('deimosAction',anim,true)
	setProperty('dad.alpha',0.01)
	setProperty('deimosAction.alpha',1)
	runTimer('deimosAct',0.4)
	if anim:find('shot') then
		if anim:find('shot1') then
			playAnim('boyfriend','dodge',true)
		end
		setProperty('gf.skipDance',false)
		cameraShake('camGame',0.04,0.15,true)
		setProperty('whiteOverlay.alpha',0.25)
		setProperty('whiteOverlay.color',getColorFromHex('ECCF16'))
		doTweenAlpha('whiteoverlayFlash','whiteOverlay',0.01,0.15)
		playSound('deimosShot',1)
	end
end
function ending()
	setProperty('finalChains.alpha',1)
	setProperty('boyfriend.skipDance',true)
	setProperty('agentAp.alpha',1)
	setProperty('guntAp.alpha',1)
	setProperty('soldatAp.alpha',1)
	playAnim('agentAp','idle',true)
	playAnim('guntAp','idle',true)
	playAnim('soldatAp','idle',true)
	playAnim('finalChains','chain',true)
end
function ray()
	runHaxeCode([[
		var lightingRay:FlxTween;
		if (lightingRay != null) lightingRay.cancel();
		lightingRay = FlxTween.num(0, 1, 1, {ease: FlxEase.linear}, function(fuckyhou) { ray.setFloat('FlashIntensity',fuckyhou); });
	]])
	setProperty('rayo.alpha',1)
	runTimer('rayCooldown',getRandomInt(7,12))
	setProperty('rayo.flipX',getRandomBool(50))
	playAnim('rayo','ray',true)
	playSound('ray',1)
end

-- im so sad this kinda working
function precacheStuff() 
	local sounds = runHaxeCode([[return FileSystem.readDirectory("]]..runHaxeCode([[return Paths.modFolders("sounds")]])..[[")]])
	local images = {
		chara = runHaxeCode([[return FileSystem.readDirectory("]]..runHaxeCode([[return Paths.modFolders("images")]])..[[/characters")]]),
		hud = runHaxeCode([[return FileSystem.readDirectory("]]..runHaxeCode([[return Paths.modFolders("images")]])..[[/hud/deimos")]]),
		bgs = runHaxeCode([[return FileSystem.readDirectory("]]..runHaxeCode([[return Paths.modFolders("images")]])..[[/bgs/deimos")]])
	}
	local imagesNameData = {}
		imagesNameData.chara = images.chara
		imagesNameData.hud = images.hud
		imagesNameData.bgs = images.bgs
	
	for ty, val in pairs(imagesNameData) do
		for i = 1, #val do
			if stringEndsWith(val[i], '.png') then
				local t = string.sub(val[i], 0, #val[i] - 4)
				precacheImage(t) -- precacheImage literally does nothing :fire:
			end
		end
	end	
	for _, fn in pairs(sounds) do
		if stringEndsWith(fn, '.ogg') then
			local s = string.sub(fn, 0, #fn - 4)
			precacheSound(s)
		end
	end
	debugPrint('all stuff have been cached :)')
end

function shaderCoordFix()
    runHaxeCode([[
        resetCamCache = function(?spr) {
            if (spr == null || spr.filters == null) return;
            spr.__cacheBitmap = null;
            spr.__cacheBitmapData = null;
        }
        
        fixShaderCoordFix = function(?_) {
            resetCamCache(game.camGame.flashSprite);
            resetCamCache(game.camHUD.flashSprite);
            resetCamCache(game.camOther.flashSprite);
        }
    
        FlxG.signals.gameResized.add(fixShaderCoordFix);
        fixShaderCoordFix();
        return;
    ]])
    
    local temp = onDestroy
    function onDestroy()
        runHaxeCode([[
            FlxG.signals.gameResized.remove(fixShaderCoordFix);
            return;
        ]])
        if (temp) then temp() end
    end
end