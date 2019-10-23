_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("", "dp Emotes", "", "", "shopui_title_sm_hangar", "shopui_title_sm_hangar")
_menuPool:Add(mainMenu)

function ShowNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end


function AddEmoteMenu(menu)
    local submenu = _menuPool:AddSubMenu(menu, "dp Emotes", "", "", "shopui_title_sm_hangar", "shopui_title_sm_hangar")

    for a,b in pairsByKeys(DP.Emotes) do
      x,y,z = table.unpack(b)
      emoteitem = NativeUI.CreateItem(z, "/emote ("..a..") ")
      submenu:AddItem(emoteitem)  
    end 
end

function AddEmoteSettingsMenu(menu)
    local newitem = NativeUI.CreateItem("Cancel Emote", "/e (c) also works")
    menu:AddItem(newitem)
    menu.OnItemSelect = function(sender, item, checked_)
        if item == newitem then
          EmoteCancel()
          DestroyAllProps()
        end
    end
end

function OpenEmoteMenu()
    mainMenu:Visible(not mainMenu:Visible())
end

AddEmoteMenu(mainMenu)
AddEmoteSettingsMenu(mainMenu)
_menuPool:RefreshIndex()

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        _menuPool:ProcessMenus()
    end
end)