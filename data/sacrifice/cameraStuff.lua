ofs = 25
function onSectionHit()
	if camMove then
		if mustHitSection then
			xx = 500
			yy = 280
		else
			xx = -200
			yy = 240
		end
	end
end
function goodNoteHit(i,d)
	if camMove and mustHitSection then
		if d == 0 then setProperty('camFollow.x',xx - ofs) setProperty('camFollow.y',yy) end
		if d == 1 then setProperty('camFollow.y',yy + ofs) setProperty('camFollow.x',xx) end
		if d == 2 then setProperty('camFollow.y',yy - ofs) setProperty('camFollow.x',xx) end
		if d == 3 then setProperty('camFollow.x',xx + ofs) setProperty('camFollow.y',yy) end
	end
end
function opponentNoteHit(i,d)
	if camMove and not mustHitSection then
		if d == 0 then setProperty('camFollow.x',xx - ofs) setProperty('camFollow.y',yy) end
		if d == 1 then setProperty('camFollow.y',yy + ofs) setProperty('camFollow.x',xx) end
		if d == 2 then setProperty('camFollow.y',yy - ofs) setProperty('camFollow.x',xx) end
		if d == 3 then setProperty('camFollow.x',xx + ofs) setProperty('camFollow.y',yy) end
	end
end
function onTweenCompleted(t)
	if t == 'introCameraY' then
		camMove = true
		xx = -200
		yy = 240
        -- fuck you lag spike
        setScrollFactor('chains',1,1)
        setScrollFactor('polvo',1,1)
        setScrollFactor('piedra',1,1)
        setScrollFactor('mira',1,1)
        setScrollFactor('finalChains',1,1)
        setScrollFactor('deimosAction',1,1)
        setScrollFactor('agentAp',1,1)
        setScrollFactor('guntAp',1,1)
        setScrollFactor('soldatAp',1,1)
	end
end