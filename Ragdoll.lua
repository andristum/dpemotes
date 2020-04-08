local isInRagdoll = false

Citizen.CreateThread(function()
 while true do
    Citizen.Wait(10)
    if isInRagdoll then
      SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 0, 0, 0, 0)
    end
  end
end)

Citizen.CreateThread(function()
    while true do
    Citizen.Wait(0)
    if IsControlJustPressed(2, Config.RagdollKeybind) and Config.RagdollEnabled and IsPedOnFoot(PlayerPedId()) then
        if isInRagdoll then
            isInRagdoll = false
        else
            isInRagdoll = true
            Wait(500)
        end
    end
  end
end)

Citizen.CreateThread( function()

	while true do
		Citizen.Wait(5)
		if (IsControlJustPressed(0,Config.CrossArmsKeyBind) and Config.CrossArmsEnabled) then
			local player = PlayerPedId()
	
			if ( DoesEntityExist( player ) and not IsEntityDead( player ) ) then
	
				if IsEntityPlayingAnim(player, "missfbi_s4mop", "guard_idle_a", 3) then
					ClearPedSecondaryTask(player)
				else
					loadAnimDict( "missfbi_s4mop" )
					TaskPlayAnim(player, "missfbi_s4mop", "guard_idle_a", 2.0, 2.5, -1, 49, 0, 0, 0, 0 )
					RemoveAnimDict("missfbi_s4mop")
				end
			end
	  end	
	end
end)

function loadAnimDict(dict)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(500)
	end
end