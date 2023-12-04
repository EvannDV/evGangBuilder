ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
     PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)  
	PlayerData.job = job  
	Citizen.Wait(5000) 
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
    end
    if ESX.IsPlayerLoaded() then

		ESX.PlayerData = ESX.GetPlayerData()

    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)


RegisterCommand('evGang', function()
    TriggerServerEvent('ev:checkIdentif')
end)


RegisterCommand('evSet', function()
    tape = KeyboardInput('Votre Setjob2', "", 20)
    Citizen.Wait(5000)
    TriggerServerEvent('ev:Set', tape)
end)



evGang = {
    label,
    garage,
    coffre,
    boss,
    vehi,
    vehi2,
    vehi3,
}


-------------Menu
function CreatorGang()
    local evCreatorGang = RageUI.CreateMenu("Gang Builder", "creator") 

    RageUI.Visible(evCreatorGang, not RageUI.Visible(evCreatorGang))

    while evCreatorGang do
        
        Citizen.Wait(0)

        RageUI.IsVisible(evCreatorGang,true,true,true,function()


        
            RageUI.ButtonWithStyle("Label",nil, {RightLabel = evGang.label}, true, function(Hovered, Active, Selected)
                if Selected then
                    evGang.label = KeyboardInput("Rentrer le nom du gang en Minuscule", "", 20)  
                end
            end)

            RageUI.ButtonWithStyle("Pos Garage",nil, {RightLabel = smile1}, true, function(Hovered, Active, Selected)
                if Selected then
                    local posPly = GetEntityCoords(GetPlayerPed(-1))
                    evGang.garage = posPly
                    smile1 = "✅"  
                end
            end)

            RageUI.ButtonWithStyle("Pos Coffre",nil, {RightLabel = smile2}, true, function(Hovered, Active, Selected)
                if Selected then
                    local posPly2 = GetEntityCoords(GetPlayerPed(-1))
                    evGang.coffre = posPly2
                    smile2 = "✅"  
                end
            end)

            RageUI.ButtonWithStyle("Pos Boss Action",nil, {RightLabel = smile3}, true, function(Hovered, Active, Selected)
                if Selected then
                    local posPly3 = GetEntityCoords(GetPlayerPed(-1))
                    evGang.boss = posPly3
                    smile3 = "✅"  
                end
            end)

            RageUI.Separator("↓ ~b~Trois vehicules à config~s~ ↓")
            
            RageUI.ButtonWithStyle("Vehicule 1",nil, {RightLabel = evGang.vehi}, true, function(Hovered, Active, Selected)
                if Selected then
                    evGang.vehi = KeyboardInput("Name du Véhicule", "", 20) 
                end
            end)

            RageUI.ButtonWithStyle("Vehicule 2",nil, {RightLabel = evGang.vehi2}, true, function(Hovered, Active, Selected)
                if Selected then
                    evGang.vehi2 = KeyboardInput("Name du Véhicule", "", 20) 
                end
            end)

            RageUI.ButtonWithStyle("Vehicule 3",nil, {RightLabel = evGang.vehi3}, true, function(Hovered, Active, Selected)
                if Selected then
                    evGang.vehi3 = KeyboardInput("Name du Véhicule", "", 20) 
                end
            end)

            
            RageUI.Separator("↓ ~p~Terminer~s~ ↓")

            RageUI.ButtonWithStyle("~g~Valider",nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    if evGang.vehi == nil or evGang.vehi2 == nil or evGang.vehi3 == nil or evGang.label == nil then
                        ESX.ShowNotification("Vous devez obligatoirement ajouter 3 vehicules")
                    else
                        TriggerServerEvent('ev:Create', evGang)
                        evRefresh()
                        RageUI.CloseAll()
                    end
                end
            end)


            RageUI.ButtonWithStyle("~r~Annuler",nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    evRefresh()
                    RageUI.CloseAll()
                end
            end)

             
            


        
        end, function()
        end)

        if not RageUI.Visible(evCreatorGang) then
            evCreatorGang=RMenu:DeleteType("evCreator", true)
        end

    end

end

RegisterNetEvent('OpenMenuEv')
AddEventHandler('OpenMenuEv', function()
    CreatorGang()
end)




---- Refresh by ev

function evRefresh()
    evGang.label = nil
    evGang.garage = nil
    evGang.coffre = nil
    evGang.boss = nil 
    evGang.vehi = nil
    evGang.vehi2 = nil
    evGang.vehi3 = nil
end










--- Fonction KeyboardInput

KeyboardInput = function(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry) 
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    blockinput = true

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Citizen.Wait(0)
    end
        
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult() 
        Citizen.Wait(500) 
        blockinput = false
        return result 
    else
        Citizen.Wait(500) 
        blockinput = false 
        return nil 
    end
end


