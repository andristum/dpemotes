if Config.CheckForUpdates then
    Citizen.CreateThread( function()
        updatePath = "/andristum/dpemotes"
        resourceName = "dp Emotes ("..GetCurrentResourceName()..")"
        PerformHttpRequest("https://raw.githubusercontent.com"..updatePath.."/master/version", checkVersion, "GET")
    end)
end

function checkVersion(err,responseText, headers)
    curVersion = LoadResourceFile(GetCurrentResourceName(), "version")

    if curVersion ~= responseText and tonumber(curVersion) < tonumber(responseText) then
        print("\n------------------------------------------------")
        print("\n"..resourceName.." is outdated, latest version is:\n"..responseText.."yours:\n"..curVersion.."\nupdate from https://github.com"..updatePath.."")
        print("\n------------------------------------------------")
    elseif tonumber(curVersion) > tonumber(responseText) then
        print("You somehow skipped a few versions of "..resourceName.." or the git went offline, if it's still online i advise you to update ( or downgrade? )")
    else
        print("\n"..resourceName.." is up to date. ("..curVersion..")")
    end
end