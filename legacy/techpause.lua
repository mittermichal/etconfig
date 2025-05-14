local modname = "techpause"
local version = "0.0"

local CV_SVS_PAUSE       = 16
local techPauseLength    = 999999 -- minimum pause length is 15s delay + 10s countdown, no matter the setting.
local defaultPauseLength = 30    -- minimum pause length is 15s delay + 10s countdown, no matter the setting.

function et_ClientCommand(clientNum, cmd)
	if cmd == "techpause" then	
		-- referees only
		if et.gentity_get(clientNum, "sess.referee") == 1 then
			local serverToggles = tonumber(et.trap_GetConfigstring(et.CS_SERVERTOGGLES))
			
			-- pausing
			if (serverToggles & CV_SVS_PAUSE) == 0 then
				et.trap_Cvar_Set("match_timeoutlength", techPauseLength)
				et.trap_SendConsoleCommand(et.EXEC_APPEND, "ref pause\n")
				et.G_Print("pausing.\n")
			-- unpausing 
			else
				et.trap_Cvar_Set("match_timeoutlength", defaultPauseLength)
				et.trap_SendConsoleCommand(et.EXEC_APPEND, "ref unpause\n")
				et.G_Print("unpausing.\n")
			end
			
		else
			et.G_Print("not ref")
		end
		return 1
	end
	
	return 0
end


function et_InitGame()
    et.RegisterModname(modname .. " " .. version)
    et.G_Print("tp\n")
end
