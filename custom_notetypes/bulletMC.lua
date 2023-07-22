function onCreate()
    for n = 0,getProperty('unspawnNotes.length')-1 do
        if getPropertyFromGroup('unspawnNotes',n,'noteType') == 'bulletMC' then
            setPropertyFromGroup('unspawnNotes',n,'texture','bullet')
            setPropertyFromGroup('unspawnNotes',n,'offset.x',100)
            setPropertyFromGroup('unspawnNotes',n,'offset.y',getPropertyFromGroup('unspawnNotes',n,'offset.y') + 30)

            setPropertyFromGroup('unspawnNotes',n,'noteSplashTexture','bullet')
        end
    end
end
