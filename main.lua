ESX              = nil
local PlayerData = {}
local canNightvision = false
local isMale = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer   
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

Citizen.CreateThread(function()
  while true do
    if IsControlJustReleased(0, 58) then --replace 58 for different key (https://docs.fivem.net/docs/game-references/controls/) //// vyměňte za jinou klávesu (https://docs.fivem.net/docs/game-references/controls/)
      local gender = nil
      isNightvision = not isNightvision
      TriggerEvent('skinchanger:getSkin', function(skin)
        local helmet = skin.helmet_1

        if skin.sex == 0 then
          isMale = true
        else
          isMale = false
        end

        if helmet == 116 or helmet == 117 then
          canNightvision = true
        else
          canNightvision = false
        end
      end)

      if isMale then
        gender = 0
      else
        gender = 1
      end

      if canNightvision and isNightvision then
        TriggerEvent('skinchanger:loadSkin', {
          sex = gender,
          helmet_1 = 116
        })
        SetNightvision(true)
      elseif isNightvision == false then
        TriggerEvent('skinchanger:loadSkin', {
          sex = gender,
          helmet_1 = 117
        })
        SetNightvision(false)
      end

    end
    Citizen.Wait(5)
  end
end)