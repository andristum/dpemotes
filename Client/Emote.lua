-- You probably shouldnt touch these.
local AnimationDuration = -1
local ChosenAnimation = ""
local ChosenDict = ""
local IsInAnimation = false
local MostRecentChosenAnimation = ""
local MostRecentChosenDict = ""
local MovementType = 0
local PlayerGender = "male"
local PlayerHasProp = false
local PlayerProps = {}
local SecondPropEmote = false

Citizen.CreateThread(function()
  while true do

    if Config.MenuKeybindEnabled then
      if IsControlPressed(0, Config.MenuKeybind) then
        OpenEmoteMenu()
      end
    end

    if Config.EnableXtoCancel then
      if IsControlPressed(0, 73) then
        EmoteCancel()
      end
    end

    Citizen.Wait(1)
  end
end)

-----------------------------------------------------------------------------------------------------
-- Commands / Events --------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------

RegisterCommand('e', function(source, args, raw)
  EmoteCommandStart(source, args, raw)
end)

RegisterCommand('emote', function(source, args, raw)
  EmoteCommandStart(source, args, raw)
end)

RegisterCommand('emotes', function(source, args, raw)
  EmotesOnCommand() -- If anyone has a better solution for this please let me know, copied a the pairsByKeys func from stackoverflow and it wokrs a little bit better
end)

RegisterCommand('emotemenu', function(source, args, raw)
  OpenEmoteMenu()
end)

RegisterCommand('walk', function(source, args, raw)
  WalkCommandStart(source, args, raw)
end)

RegisterCommand('walks', function(source, args, raw)
  WalksOnCommand()
end)

AddEventHandler('onResourceStop', function(resource)
  if resource == GetCurrentResourceName() then
    DestroyAllProps()
    ClearPedTasksImmediately(GetPlayerPed(-1))
    ResetPedMovementClipset(PlayerPedId())
  end
end)

-----------------------------------------------------------------------------------------------------
------ Functions and stuff --------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------

function EmoteCancel()

  if ChosenDict == "MaleScenario" and IsInAnimation then
    ClearPedTasksImmediately(PlayerPedId())
    IsInAnimation = false
    DebugPrint("Forced scenario exit")
  elseif ChosenDict == "Scenario" and IsInAnimation then
    ClearPedTasksImmediately(PlayerPedId())
    IsInAnimation = false
    DebugPrint("Forced scenario exit")
  end

  if IsInAnimation then
    ClearPedTasks(GetPlayerPed(-1))
    DestroyAllProps()
    IsInAnimation = false
  end
end

function EmoteChatMessage(args)
  if args == display then
    TriggerEvent("chatMessage", "^5Help^0", {0,0,0}, string.format(""))
  else
    TriggerEvent("chatMessage", "^5Help^0", {0,0,0}, string.format(""..args..""))
  end
end

function DebugPrint(args)
  if Config.DebugDisplay then
    print(args)
  end
end


function EmotesOnCommand(source, args, raw)
  local EmotesCommand = ""
  for a in pairsByKeys(DP.Emotes) do
    EmotesCommand = EmotesCommand .. ""..a..", "
  end
  EmoteChatMessage(EmotesCommand)
  EmoteChatMessage("Do /emotemenu for a menu")
end

function pairsByKeys (t, f)
    local a = {}
    for n in pairs(t) do
        table.insert(a, n)
    end
    table.sort(a, f)
    local i = 0      -- iterator variable
    local iter = function ()   -- iterator function
        i = i + 1
        if a[i] == nil then
            return nil
        else
            return a[i], t[a[i]]
        end
    end
    return iter
end

function EmoteMenuStart(args, hard)
    local name = args
    local etype = hard

    if etype == "dances" then
        if DP.Dances[name] ~= nil then
          if OnEmotePlay(DP.Dances[name]) then end
        else
          EmoteChatMessage("'"..name.."' is not a valid dance")
        end
    elseif etype == "props" then
        if DP.PropEmotes[name] ~= nil then
          if OnEmotePlay(DP.PropEmotes[name]) then end
        else
          EmoteChatMessage("'"..name.."' is not a valid emote")
        end
    elseif etype == "emotes" then
        if DP.Emotes[name] ~= nil then
          if OnEmotePlay(DP.Emotes[name]) then end
        else
          if name ~= "🕺 Dance Emotes" then
              EmoteChatMessage("'"..name.."' is not a valid emote")
          end
        end
    elseif etype == "expression" then
        if DP.Expressions[name] ~= nil then
          if OnEmotePlay(DP.Expressions[name]) then end
        end
    end
end

function EmoteCommandStart(source, args, raw)
    if #args > 0 then
    local name = string.lower(args[1])
    if name == "c" then
        if IsInAnimation then
            EmoteCancel()
        else
            EmoteChatMessage("No emote to cancel")
        end
      return
    elseif name == "help" then
      EmotesOnCommand()
    return end

    if DP.Emotes[name] ~= nil then
      if OnEmotePlay(DP.Emotes[name]) then end return
    elseif DP.Dances[name] ~= nil then
      if OnEmotePlay(DP.Dances[name]) then end return
    elseif DP.PropEmotes[name] ~= nil then
      if OnEmotePlay(DP.PropEmotes[name]) then end return
    else
      EmoteChatMessage("'"..name.."' is not a valid emote")
    end
  end
end

LoadAnim = function(dict)
  while not HasAnimDictLoaded(dict) do
    RequestAnimDict(dict)
    Citizen.Wait(1)
  end
end

LoadPropDict = function(model)
  RequestModel(GetHashKey(model))
  while not HasModelLoaded(GetHashKey(model)) do
    Citizen.Wait(1)
  end
end

DestroyAllProps = function()
  for _,v in pairs(PlayerProps) do
    DeleteEntity(v)
  end
  PlayerHasProp = false
  DebugPrint("Destroyed Props")
end

AddPropToPlayer = function(prop1, bone, off1, off2, off3, rot1, rot2, rot3)
  local Player = PlayerPedId()
  local x,y,z = table.unpack(GetEntityCoords(Player))

  if not HasModelLoaded(prop1) then
    LoadPropDict(prop1)
  end

  prop = CreateObject(GetHashKey(prop1), x, y, z+0.2,  true,  true, true)
  AttachEntityToEntity(prop, Player, GetPedBoneIndex(Player, bone), off1, off2, off3, rot1, rot2, rot3, true, true, false, true, 1, true)
  table.insert(PlayerProps, prop)
  PlayerHasProp = true
end

-----------------------------------------------------------------------------------------------------
-- V -- This could be a whole lot better, i tried messing around with "IsPedMale(ped)"
-- V -- But i never really figured it out, if anyone has a better way of gender checking let me know.
-- V -- Since this way doesnt work for ped models.
-- V -- in most cases its better to replace the scenario with an animation bundled with prop instead.
-----------------------------------------------------------------------------------------------------

CheckGender = function()
  local hashSkinMale = GetHashKey("mp_m_freemode_01")
  local hashSkinFemale = GetHashKey("mp_f_freemode_01")

  if GetEntityModel(PlayerPedId()) == hashSkinMale then
    PlayerGender = "male"
  elseif GetEntityModel(PlayerPedId()) == hashSkinFemale then
    PlayerGender = "female"
  end
  DebugPrint("Set gender as = ("..PlayerGender..")")
end

-----------------------------------------------------------------------------------------------------
------ This is the major function for playing emotes! -----------------------------------------------
-----------------------------------------------------------------------------------------------------

function OnEmotePlay(EmoteName)
  if not DoesEntityExist(GetPlayerPed(-1)) then
    return false
  end

  if Config.DisarmPlayer then
    if IsPedArmed(GetPlayerPed(-1), 7) then
      SetCurrentPedWeapon(GetPlayerPed(-1), GetHashKey('WEAPON_UNARMED'), true)
    end
  end

  ChosenDict,ChosenAnimation,ename = table.unpack(EmoteName)
  AnimationDuration = -1

  if PlayerHasProp then
    DestroyAllProps()
  end

  if ChosenDict == "Expression" then
    SetFacialIdleAnimOverride(PlayerPedId(), ChosenAnimation, 0)
    return
  end

  if ChosenDict == "MaleScenario" or "Scenario" then
    CheckGender()
    if ChosenDict == "MaleScenario" then
      if PlayerGender == "male" then
        ClearPedTasks(GetPlayerPed(-1))
        TaskStartScenarioInPlace(GetPlayerPed(-1), ChosenAnimation, 0, true)
        DebugPrint("Playing scenario = ("..ChosenAnimation..")")
        IsInAnimation = true
      else
        EmoteChatMessage("This emote is male only, sorry!")
      end return
    elseif ChosenDict == "ScenarioObject" then
      BehindPlayer = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0 - 0.5, -0.5);
      ClearPedTasks(GetPlayerPed(-1))
      TaskStartScenarioAtPosition(GetPlayerPed(-1), ChosenAnimation, BehindPlayer['x'], BehindPlayer['y'], BehindPlayer['z'], GetEntityHeading(PlayerPedId()), 0, 1, false)
      DebugPrint("Playing scenario = ("..ChosenAnimation..")")
      IsInAnimation = true
      return
    elseif ChosenDict == "Scenario" then
      ClearPedTasks(GetPlayerPed(-1))
      TaskStartScenarioInPlace(GetPlayerPed(-1), ChosenAnimation, 0, true)
      DebugPrint("Playing scenario = ("..ChosenAnimation..")")
      IsInAnimation = true
    return end 
  end

    LoadAnim(ChosenDict)

    if EmoteName.AnimationOptions then
      if EmoteName.AnimationOptions.EmoteLoop then
        MovementType = 1
      if EmoteName.AnimationOptions.EmoteMoving then
        MovementType = 51
      end
  elseif EmoteName.AnimationOptions.EmoteMoving then
    MovementType = 51
  end
  else
    MovementType = 0
  end

  if EmoteName.AnimationOptions then
    if EmoteName.AnimationOptions.EmoteDuration == nil then 
      EmoteName.AnimationOptions.EmoteDuration = -1
    else
      AnimationDuration = EmoteName.AnimationOptions.EmoteDuration
    end

    if EmoteName.AnimationOptions.Prop then
      PropName = EmoteName.AnimationOptions.Prop
      PropBone = EmoteName.AnimationOptions.PropBone
      PropPl1, PropPl2, PropPl3, PropPl4, PropPl5, PropPl6 = table.unpack(EmoteName.AnimationOptions.PropPlacement)
      if EmoteName.AnimationOptions.SecondProp then
        SecondPropName = EmoteName.AnimationOptions.SecondProp
        SecondPropBone = EmoteName.AnimationOptions.SecondPropBone
        SecondPropPl1, SecondPropPl2, SecondPropPl3, SecondPropPl4, SecondPropPl5, SecondPropPl6 = table.unpack(EmoteName.AnimationOptions.SecondPropPlacement)
        SecondPropEmote = true
      else
        SecondPropEmote = false
      end

      AddPropToPlayer(PropName, PropBone, PropPl1, PropPl2, PropPl3, PropPl4, PropPl5, PropPl6)
      if SecondPropEmote then
        AddPropToPlayer(SecondPropName, SecondPropBone, SecondPropPl1, SecondPropPl2, SecondPropPl3, SecondPropPl4, SecondPropPl5, SecondPropPl6)
      end
    end
  else
      DebugPrint("AnimationOptions = False")
  end
  
  DebugPrint ("--- Main Animations")
  DebugPrint ("ChosenDict = " ..ChosenDict.. "")
  DebugPrint ("ChosenAnimation = " ..ChosenAnimation.. "")
  DebugPrint ("MovementType = " ..MovementType.. "")
  DebugPrint ("AnimationDuration = " ..AnimationDuration.. "")

  if EmoteName.AnimationOptions then
    DebugPrint ("--- AnimationOptions")
    DebugPrint ("AnimationOption.EmoteLoop = " ..tostring(EmoteName.AnimationOptions.EmoteLoop).. "")
    DebugPrint ("AnimationOption.EmoteMoving = " ..tostring(EmoteName.AnimationOptions.EmoteMoving).. "")
    DebugPrint ("AnimationOption.EmoteDuration = " ..tostring(EmoteName.AnimationOptions.EmoteDuration).. "")
  end

  TaskPlayAnim(GetPlayerPed(-1), ChosenDict, ChosenAnimation, 2.0, 2.0, AnimationDuration, MovementType, 0, false, false, false)
  IsInAnimation = true
  MostRecentDict = ChosenDict
  MostRecentAnimation = ChosenAnimation
  return true
end