local eventsData  = {} 
function onCreatePost()
    local json = dofile('mods/'..currentModDirectory..'/scripts/JSONLIB.lua')
    local jsonTable = json.parse(getTextFromFile('data/'..songPath..'/'..songPath..'.json'))
    for _, note in ipairs(jsonTable.song.notes) do
        for _, event in ipairs(note.events) do
            local time = event.time
            local args = event.events[1].args
            local name = event.events[1].name
            local ev = {
                time = time,
                args = args,
                name = name
            } 
            table.insert(eventsData, ev)
        end
    end
end
local triggeredEvents = {}
inter = 0
val = 0
function onUpdate()
    local currentSongPosition = math.floor(getSongPosition())
    for _, event in ipairs(eventsData) do
        if not triggeredEvents[event.time] and currentSongPosition >= math.floor(event.time) then
            if event.name == 'Camera Zoom Bump' then
                triggerEvent('Add Camera Zoom',event.args[1],event.args[2])
            elseif event.name == 'Camera Zoom Interval' then
                inter = tonumber(event.args[1])
                val = tonumber(event.args[2])
            elseif event.name == 'Shot Deimos' then
                if tonumber(event.args[1]) == 0 then
                    setProperty('barricada_hank.alpha',0.01)
                    playAnim('barricada','appear',true)
                elseif tonumber(event.args[1]) == 1 then
                    cameraShake('camGame',0.04,0.15,true)
                    setProperty('whiteOverlay.alpha',0.25)
                    setProperty('whiteOverlay.color',getColorFromHex('ECCF16'))
                    doTweenAlpha('whiteoverlayFlash','whiteOverlay',0.01,0.15)
                    deimosAct((getRandomBool(50) and 'left' or 'right')..'m')
                    playAnim('barricada','shot',true)
                    playAnim('gf','dodge',true)
                    playSound('shoot',1)
                    setProperty('gf.skipDance',true)
                elseif tonumber(event.args[1]) == 2 then
                    deimosAct('shot2')
                    playAnim('barricada','death',true)
                    playSound('die',0.9)
                    playAnim('gf','dodge',true)
                    setProperty('gf.skipDance',true)
                    playSound('deimosShot2',1)
                end
            elseif event.name == 'Deimos Intro' then
                if tonumber(event.args[1]) == 0 then
                    runHaxeCode([[
                        game.camGame.setFilters([new ShaderFilter(ray),new ShaderFilter(TvG)]);
                        game.getLuaObject('sky').shader = bgDeim;
                    ]])
                elseif tonumber(event.args[1]) == 2 then
                    runHaxeCode([[
                        game.camGame.setFilters([new ShaderFilter(ray)]);
                        game.getLuaObject('sky').shader = null;
                    ]])
                end
            elseif event.name == 'Hank Easter Egg' then
                if tonumber(event.args[1]) == 1 then
                	setProperty('barricada_hank.alpha',1)
                    playAnim('barricada_hank','intro',true)
                elseif tonumber(event.args[1]) == 2 then
                    playAnim('barricada_hank','bye',true)
                end
            elseif event.name == 'Note' then
                setPropertyFromGroup('opponentStrums',tonumber(event.args[1]),'visible',true)
                setPropertyFromGroup('playerStrums',tonumber(event.args[1]),'visible',true)
            elseif event.name == 'Flash' then
                setProperty('redOverlay.alpha', (event.args[1]))
                doTweenAlpha('redOverlay', 'redOverlay', 0, 0.3)
            elseif event.name == 'Black Flicker' then
                if tonumber(event.args[2]) == 0.01 then
                    setProperty('flicker.alpha',0.01)
                elseif tonumber(event.args[2]) == 0.1 then
                    setProperty('flicker.alpha',1)
                end
                runHaxeCode([[
                    FlxFlicker.flicker(game.getLuaObject('flicker'), ]]..tonumber(event.args[1])..[[, ]]..tonumber(event.args[2])..[[, false, false);
                ]])
            end
            --[[
            debugPrint('An Event!: '..event.name..
            ' | value1: '..(event.args[1] or 'nil')..
            ' | value2: '..(event.args[2] or 'nil')
            )
            ]]-- balls
            triggeredEvents[event.time] = true
        end
    end
end

function onBeatHit()
    if curBeat % inter == 0 then
        setProperty('camZoomingMult',0)
        runHaxeCode([[
            game.camGame.zoom += ]]..val..[[*2;
            game.camHUD.zoom += ]]..val..[[;
        ]])
    end
end

function deimosAct(anim)
	playAnim('deimosAction',anim,true)
	setProperty('dad.alpha',0.001)
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
		doTweenAlpha('whiteoverlayFlash','whiteOverlay',0.001,0.15)
		playSound('deimosShot',1)
	end
end