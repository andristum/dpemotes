_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("", "dp Emotes", "", "", "shopui_title_sm_hangar", "shopui_title_sm_hangar")
_menuPool:Add(mainMenu)

function ShowNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

local emotetable = {}
local dancetable = {}
local walktable = {}

function AddWalkMenu(menu)
    local submenu = _menuPool:AddSubMenu(menu, "Walking Styles", "", "", "shopui_title_sm_hangar", "shopui_title_sm_hangar")

    walkreset = NativeUI.CreateItem("Reset to default", "Reset to default")
    submenu:AddItem(walkreset)
    table.insert(walktable, "Reset to default")

    walkinjured = NativeUI.CreateItem("Injured", "")
    submenu:AddItem(walkinjured)
    table.insert(walktable, "move_m@injured")

    for a,b in pairsByKeys(DP.Walks) do
      x = table.unpack(b)
      walkitem = NativeUI.CreateItem(a, "")
      submenu:AddItem(walkitem)
      table.insert(walktable, x)
    end

    submenu.OnItemSelect = function(sender, item, index)
      WalkMenuStart(walktable[index])
    end
end

function AddEmoteMenu(menu)
    local submenu = _menuPool:AddSubMenu(menu, "Emotes", "", "", "shopui_title_sm_hangar", "shopui_title_sm_hangar")
    local dancemenu = _menuPool:AddSubMenu(submenu, "(Dances)", "", "", "shopui_title_sm_hangar", "shopui_title_sm_hangar")
    table.insert(emotetable, "(Dances)")

    for a,b in pairsByKeys(DP.Emotes) do
      x,y,z = table.unpack(b)
      emoteitem = NativeUI.CreateItem(z, "/e ("..a..")")
      submenu:AddItem(emoteitem)
      table.insert(emotetable, a)
    end

    for a,b in pairsByKeys(DP.Dances) do
      x,y,z = table.unpack(b)
      danceitem = NativeUI.CreateItem(z, "/e ("..a..")")
      dancemenu:AddItem(danceitem)
      table.insert(dancetable, a)
    end

    dancemenu.OnItemSelect = function(sender, item, index)
      EmoteMenuStart(dancetable[index], "dances")
    end

    submenu.OnItemSelect = function(sender, item, index)
      EmoteMenuStart(emotetable[index], "emotes")
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


function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

AddEmoteMenu(mainMenu)
AddEmoteSettingsMenu(mainMenu)
if Config.WalkingStylesEnabled then
  AddWalkMenu(mainMenu)
end
_menuPool:RefreshIndex()

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        _menuPool:ProcessMenus()
    end
end)

