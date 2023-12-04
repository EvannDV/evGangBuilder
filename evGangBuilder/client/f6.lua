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



function evF7()
    for k, v in pairs(evGang) do
    local evF7M = RageUI.CreateMenu(v.label, "intéractions")

    RageUI.Visible(evF7M, not RageUI.Visible(evF7M))

    while evF7M do
        
        Citizen.Wait(0)

        RageUI.IsVisible(evF7M,true,true,true,function()

            RageUI.ButtonWithStyle("Fouiller", nil, {RightLabel = v.label}, true, function(Hovered, Active, Selected)
                if Selected then
                    print("test")
                end
            end)
            


            



        
        end, function()
        end)

        if not RageUI.Visible(evF7M) then
            evF7M=RMenu:DeleteType("Delete", true)
        end
    end

    end

end







local function getPlayerInvGang(player)
    Items = {}
    Armes = {}
    ArgentSale = {}
    
    ESX.TriggerServerCallback('getOtherPlayerData', function(data)
        for i=1, #data.accounts, 1 do
            if data.accounts[i].name == 'black_money' and data.accounts[i].money > 0 then
                table.insert(ArgentSale, {
                    label    = ESX.Math.Round(data.accounts[i].money),
                    value    = 'black_money',
                    itemType = 'item_account',
                    amount   = data.accounts[i].money
                })
    
                break
            end
        end

        for i=1, #data.weapons, 1 do
            table.insert(Armes, {
                label    = ESX.GetWeaponLabel(data.weapons[i].name),
                value    = data.weapons[i].name,
                right    = data.weapons[i].ammo,
                itemType = 'item_weapon',
                amount   = data.weapons[i].ammo
            })
        end
    
        for i=1, #data.inventory, 1 do
            if data.inventory[i].count > 0 then
                table.insert(Items, {
                    label    = data.inventory[i].label,
                    right    = data.inventory[i].count,
                    value    = data.inventory[i].name,
                    itemType = 'item_standard',
                    amount   = data.inventory[i].count
                })
            end
        end
    end, GetPlayerServerId(player))
end


local function MenuGangs(gang)
    local MenuGang = RageUI.CreateMenu(""..gang.label, "Interactions")
    local MenuGangSub = RageUI.CreateSubMenu(MenuGang, "Menu "..gang.label, "Interactions")
        RageUI.Visible(MenuGang, not RageUI.Visible(MenuGang))
            while MenuGang do
                Citizen.Wait(0)
                    RageUI.IsVisible(MenuGang, true, true, true, function()

                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

                    RageUI.ButtonWithStyle('Fouiller', nil, {RightLabel = "→"}, closestPlayer ~= -1 and closestDistance <= 3.0, function(_, a, s)
                        if a then
                            MarquerJoueur()
                            if s then
                            getPlayerInvGang(closestPlayer)
                        end
                    end
                    end, MenuGangSub)

                    RageUI.ButtonWithStyle("Recruter", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local ve1 = gang.label
                            local closestPlayer = ESX.Game.GetClosestPlayer()
                            TriggerServerEvent('recruter', ve1, closestPlayer)
                        end
                    end)

                    RageUI.ButtonWithStyle("Promouvoir", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local ve1 = gang.label
                            local closestPlayer = ESX.Game.GetClosestPlayer()
                            TriggerServerEvent('promouvoir', ve1, closestPlayer)
                        end
                    end)


                    RageUI.ButtonWithStyle("Rétrograder", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local ve1 = gang.label
                            local closestPlayer = ESX.Game.GetClosestPlayer()
                            TriggerServerEvent('descendre', ve1, closestPlayer)
                        end
                    end)

                    RageUI.ButtonWithStyle("Virer", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local ve1 = gang.label
                            local closestPlayer = ESX.Game.GetClosestPlayer()
                            TriggerServerEvent('virer', ve1, closestPlayer)
                        end
                    end)

        end, function()
        end)

        RageUI.IsVisible(MenuGangSub, true, true, true, function()

            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    
            RageUI.Separator("Vous fouiller : " ..GetPlayerName(closestPlayer))

            RageUI.Separator("↓ ~r~Argent non déclaré ~s~↓")
            for k,v  in pairs(ArgentSale) do
                RageUI.ButtonWithStyle("Argent non déclaré :", nil, {RightLabel = "~g~"..v.label.."$"}, true, function(_, _, s)
                    if s then
                        local combien = KeyboardInput("Combien ?", '' , '', 8)
                        if tonumber(combien) > v.amount then
                            RageUI.Popup({message = "~r~Quantité invalide"})
                        else
                            TriggerServerEvent('confiscatePlayerItem', GetPlayerServerId(closestPlayer), v.itemType, v.value, tonumber(combien))
                        end
                        RageUI.GoBack()
                    end
                end)
            end
    
            RageUI.Separator("↓ ~g~Objet(s) ~s~↓")

            for k,v  in pairs(Items) do
                RageUI.ButtonWithStyle(v.label, nil, {RightLabel = "~g~x"..v.right}, true, function(_, _, s)
                    if s then
                        local combien = KeyboardInput("Combien ?", '' , '', 8)
                        if tonumber(combien) > v.amount then
                            RageUI.Popup({message = "~r~Quantité invalide"})
                        else
                            TriggerServerEvent('confiscatePlayerItem', GetPlayerServerId(closestPlayer), v.itemType, v.value, tonumber(combien))
                        end
                        RageUI.GoBack()
                    end
                end)
            end

            RageUI.Separator("↓ ~g~Arme(s) ~s~↓")

			for k,v  in pairs(Armes) do
				RageUI.ButtonWithStyle(v.label, nil, {RightLabel = "avec ~g~"..v.right.. " ~s~balle(s)"}, true, function(_, _, s)
					if s then
						local combien = KeyboardInput("Combien ?", '' , '', 8)
						if tonumber(combien) > v.amount then
							RageUI.Popup({message = "~r~Quantité invalide"})
						else
							TriggerServerEvent('confiscatePlayerItem', GetPlayerServerId(closestPlayer), v.itemType, v.value, tonumber(combien))
						end
						RageUI.GoBack()
					end
				end)
			end
    
            end, function() 
            end)

            if not RageUI.Visible(MenuGang) 
            and not RageUI.Visible(MenuGangSub) then
            MenuGang = RMenu:DeleteType("Menu Fouille", true)
        end
    end
end





RegisterCommand('evGangBuilder', function()
    ESX.TriggerServerCallback('getAllGang', function(result)
        for k,v in pairs(result) do
            if ESX.PlayerData.job2 and ESX.PlayerData.job2.name == v.label then
                MenuGangs(v)
            end
        end
    end)
end)



RegisterKeyMapping('evGangBuilder', 'F7 Menu', 'keyboard', 'F7')