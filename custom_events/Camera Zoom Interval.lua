inter = 2
val = 0.02
function onEvent(n,v1,v2)
    if n == 'Camera Zoom Interval' then
        inter = v1
        val = v2
    end
end

function onBeatHit()
    if curBeat % inter == 0 then
        runHaxeCode([[
            if (game.camZooming)
            {
                game.camGame.zoom += ]]..val..[[;
                game.camHUD.zoom += ]]..val..[[*2;
            }
        ]])
    end
end