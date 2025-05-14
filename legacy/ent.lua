local entnum

function et_SpawnEntitiesFromString()
    -- models/editorcamera/camera.md3
    entnum = et.G_CreateEntity( [[create { scriptname "camera" origin "-2198 194 20" model "*0" model2 "models/editorcamera/camera.md3" classname "script_mover" modelscale 1 health 5000 contents 33 mins "-10 -10 -10" maxs "10 10 10" clipmask 0]])
    et.gentity_set(entnum, "health", 5000)
end


function et_ClientCommand(clientId, cmdText)
    if (cmdText == "chair") then
        -- "s.origin" 
        -- field = et.trap_Argv(1)
        field = "ps.origin"
        val = et.gentity_get(clientId, field)
        -- val[1] = val[1] + 1
        -- val[2] = val[2] + 1
        val[3] = val[3] - 0
        -- et.G_Say(clientId, 0, et.gentity_get(clientId, "pers.netname"))
        et.G_Say(clientId, 0 , "moving chair to: " .. val[1] .. " " .. val[2] .. " " .. val[3])
        et.G_Say(clientId,0 , et.gentity_get(entnum, "takedamage"))
        et.gentity_set(entnum, "r.currentOrigin", val)
        et.gentity_set(entnum, "s.origin", val)
        et.gentity_set(entnum, "s.origin2", val)
        et.gentity_set(entnum, "r.contents", 1)
        et.gentity_set(entnum, "health", 5000)
        et.trap_LinkEntity( entnum )
        return 1
    end
    if (cmdText == "spawnval") then
        t = et.G_GetSpawnVar( tonumber(et.trap_Argv(1)), et.trap_Argv(2))
        et.G_Say(clientId, 0 , t )
    end
    if (cmdText == "spawnvalv") then
        t = et.G_GetSpawnVar( tonumber(et.trap_Argv(1)), et.trap_Argv(2))
        et.G_Say(clientId, 0 , t[1] .. " " .. t[2] .. " " .. t[3] )
    end
    if (cmdText == "pp") then
        et.trap_SendConsoleCommand(et.EXEC_APPEND, et.trap_Argv(1))
        return 1
    end
end

function et_Damage( target, attacker, damage, damageFlags, meansOfDeath)
    if (target == entnum) then
        text = "dmg: "..damage
        et.G_Say(attacker, 0, text)
        et.gentity_set(entnum, "health", 5000)
    end
end