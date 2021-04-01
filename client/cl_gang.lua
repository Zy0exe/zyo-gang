ZyoCore = nil

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        if ZyoCore == nil then
            TriggerEvent('ZyoCore:GetObject', function(obj) ZyoCore = obj end)
            Citizen.Wait(200)
        end
    end
end)

isLoggedIn = false
local PlayerGang = {}


RegisterNetEvent('ZyoCore:Client:OnPlayerLoaded')
AddEventHandler('ZyoCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
    PlayerGang = ZyoCore.Functions.GetPlayerData().gang
end)

RegisterNetEvent('ZyoCore:Client:OnPlayerUnload')
AddEventHandler('ZyoCore:Client:OnPlayerUnload', function()
    isLoggedIn = false
end)

RegisterNetEvent('ZyoCore:Client:OnGangUpdate')
AddEventHandler('ZyoCore:Client:OnGangUpdate', function(GangInfo)
    PlayerGang = GangInfo
end)


RegisterNetEvent('zyo_gang:aim')
AddEventHandler('zyo_gang:aim', function()

local LocalPlayer = GetPlayerPed(-1)
	
-- Configured for qb-gangs --
if PlayerGang.name == 'bloods' or PlayerGang.name == 'mafia' or PlayerGang.name == 'cartel' or PlayerGang.name == 'groove' then

    if (DoesEntityExist(LocalPlayer) and not IsEntityDead(LocalPlayer)) then 
		if IsPedArmed(PlayerPedId(), 4) then
			Citizen.CreateThread(function()
				RequestAnimDict("combat@aim_variations@1h@gang")
					while (not HasAnimDictLoaded("combat@aim_variations@1h@gang")) do 
						Citizen.Wait(100)
					end

					if IsEntityPlayingAnim(LocalPlayer, "combat@aim_variations@1h@gang", "aim_variation_a", 3) then
							ClearPedSecondaryTask(LocalPlayer)
								SetEnableHandcuffs(LocalPlayer, false)
						else
							SetEnableHandcuffs(LocalPlayer, true)
								TaskPlayAnim(LocalPlayer, "combat@aim_variations@1h@gang", "aim_variation_a", 8.0, 2.5, -1, 49, 0, 0, 0, 0)
						end 
				end)
			end
		end	
	end	
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(1, 25) then 
            TriggerEvent( 'zyo_gang:aim', source )
        end
    end
end)
