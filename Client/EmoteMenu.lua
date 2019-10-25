_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("", "dp Emotes", "", "", "shopui_title_sm_hangar", "shopui_title_sm_hangar")
_menuPool:Add(mainMenu)

function ShowNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end


local EmoteTable = {}
local FavEmoteTable = {}
local DanceTable = {}
local WalkTable = {}
local FavoriteEmote = ""

Citizen.CreateThread(function()
  while true do
    if Config.FavKeybindEnabled then
      if IsControlPressed(0, Config.FavKeybind) then
        if not IsPedSittingInAnyVehicle(PlayerPedId()) then
          if FavoriteEmote ~= "" then
            EmoteMenuStart(FavoriteEmote, "emotes")
            Wait(3000)
          end
        end
      end
    end
    Citizen.Wait(1)
  end
end)

function AddWalkMenu(menu)
    local submenu = _menuPool:AddSubMenu(menu, "Walking Styles", "", "", "shopui_title_sm_hangar", "shopui_title_sm_hangar")

    walkreset = NativeUI.CreateItem("Reset to default", "Reset to default")
    submenu:AddItem(walkreset)
    table.insert(WalkTable, "Reset to default")

    WalkInjured = NativeUI.CreateItem("Injured", "")
    submenu:AddItem(WalkInjured)
    table.insert(WalkTable, "move_m@injured")

    for a,b in pairsByKeys(DP.Walks) do
      x = table.unpack(b)
      walkitem = NativeUI.CreateItem(a, "")
      submenu:AddItem(walkitem)
      table.insert(WalkTable, x)
    end

    submenu.OnItemSelect = function(sender, item, index)
      WalkMenuStart(WalkTable[index])
    end
end

function AddEmoteMenu(menu)
    local submenu = _menuPool:AddSubMenu(menu, "Emotes", "", "", "shopui_title_sm_hangar", "shopui_title_sm_hangar")
    local dancemenu = _menuPool:AddSubMenu(submenu, "🕺 Dances", "", "", "shopui_title_sm_hangar", "shopui_title_sm_hangar")
    local favmenu = _menuPool:AddSubMenu(submenu, "🌟 Keybind", "Select an emote here to set it as your bound emote.", "", "shopui_title_sm_hangar", "shopui_title_sm_hangar")
    unbinditem = NativeUI.CreateItem("Reset keybind", "Reset keybind")
    favmenu:AddItem(unbinditem)
    table.insert(FavEmoteTable, "Reset keybind")
    table.insert(EmoteTable, "🕺 Dances")
    table.insert(EmoteTable, "🌟 Keybind")

    for a,b in pairsByKeys(DP.Emotes) do
      x,y,z = table.unpack(b)
      emoteitem = NativeUI.CreateItem(z, "/e ("..a..")")
      favemoteitem = NativeUI.CreateItem(z, "Set ("..z..") to be your bound emote?")
      submenu:AddItem(emoteitem)
      favmenu:AddItem(favemoteitem)
      table.insert(EmoteTable, a)
      table.insert(FavEmoteTable, a)
    end

    for a,b in pairsByKeys(DP.Dances) do
      x,y,z = table.unpack(b)
      danceitem = NativeUI.CreateItem(z, "/e ("..a..")")
      dancemenu:AddItem(danceitem)
      table.insert(DanceTable, a)
    end

    favmenu.OnItemSelect = function(sender, item, index)
      if FavEmoteTable[index] == "Reset keybind" then
        FavoriteEmote = ""
        ShowNotification("Reset keybind :)", 2000)
      return end 

      if Config.FavKeybindEnabled then
        FavoriteEmote = FavEmoteTable[index]
        ShowNotification("~o~"..firstToUpper(FavoriteEmote).."~w~ is now your bound emote, press ~g~CapsLock~w~ to use it.")
      end
    end

    dancemenu.OnItemSelect = function(sender, item, index)
      EmoteMenuStart(DanceTable[index], "dances")
    end

    submenu.OnItemSelect = function(sender, item, index)
     if EmoteTable[index] ~= "🌟 Keybind" then
      EmoteMenuStart(EmoteTable[index], "emotes")
    end
  end
end

function AddEmoteSettingsMenu(menu)
    local newitem = NativeUI.CreateItem("Cancel Emote ", "~r~X~w~ Cancels the currently playing emote")
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

