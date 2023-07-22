local deimosEvents = {
    [202] = function()
        setProperty('grunt1.alpha',1)
		playAnim('grunt1','intro',true)
    end,
    [245] = function()
		setObjectOrder('grunt1',getObjectOrder('bg6')+1)
		playAnim('grunt1','fall',true)
		doTweenY('gruntFall','grunt1',600,4)
    end,
	[544] = function()
		setProperty('defaultCamZoom',0.83)
    end,
	[560] = function()
		setProperty('defaultCamZoom',0.569999999999997)
    end,
	[808] = function()
		doTweenZoom('camGameZoom','camGame',0.83,0.5)
	end,
    [918] = function()
        setProperty('mira.alpha',1)
		playAnim('mira','lock',true)
		playSound('mira',0.9)
    end,
    [944] = function()
        setProperty('camZooming',false)
		doTweenZoom('camGameZoom','camGame',0.86,3)
		playAnim('healthBarDei','dead',true)
		setProperty('gf.skipDance',true)
		setProperty('boyfriend.skipDance',true)
    end,
    [946] = function()
        setProperty('chains.alpha',1)
		playAnim('chains','cut',true)
    end,
    [951] = function()
        setProperty('chains.alpha',0.001)
		setProperty('piedra.alpha',1)
		setProperty('polvo.alpha',1)
		playAnim('piedra','in',true)
		playAnim('polvo','smoke',true)
    end,
    [966] = function()
        playAnim('healthBarDei','load',true)
		playAnim('piedra','out',true)
    end,
    [1606] = function()
		setProperty('defaultCamZoom',0.73)
        deimosAct('doit')
		runTimer('deimosAct',1.3)
    end,
	[1624] = function()
		setProperty('defaultCamZoom',0.569999999999997)
    end,
    [1898] = function()
        playSound('final',1)
		setProperty('gf.skipDance',true)
		doTweenX('introCameraXF','camFollow',200,2,'quadOut')
		doTweenY('introCameraYF','camFollow',240,2,'quadOut')
    end,
}
function onStepHit() if deimosEvents[curStep] then deimosEvents[curStep]() end end

function deimosAct(anim)
	playAnim('deimosAction',anim,true)
	setProperty('dad.alpha',0.001)
	setProperty('deimosAction.alpha',1)
	runTimer('deimosAct',0.4)
	if anim:find('shot') then
		if anim:find('shot1') then playAnim('boyfriend','dodge',true) end
		cameraShake('camGame',0.04,0.15,true)
		setProperty('whiteOverlay.alpha',0.2)
		setProperty('whiteOverlay.color',getColorFromHex('ECCF16'))
		doTweenAlpha('whiteoverlayFlash','whiteOverlay',0.001,0.12)
		playSound('deimosShot',1)
	end
end