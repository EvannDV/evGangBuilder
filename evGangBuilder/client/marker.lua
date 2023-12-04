myGang = {}


Citizen.CreateThread(function()
    ESX.TriggerServerCallback('getAllGang', function(result)
        myGang = result
     --   print(json.encode(myGang, {indent = true})) 
    end)


    while true do
        local Timer = 500
        for k,v in pairs(myGang) do
            if ESX.PlayerData.job2 and ESX.PlayerData.job2.name == v.label then
                local plyPos = GetEntityCoords(PlayerPedId())
                ---------------------------------------
                local Garage = vector3(json.decode(v.garage).x, json.decode(v.garage).y, json.decode(v.garage).z)
                local dist_Garage = #(plyPos-Garage)
                ---------------------------------------
                local Coffre = vector3(json.decode(v.coffre).x, json.decode(v.coffre).y, json.decode(v.coffre).z)
                local dist_Coffre = #(plyPos-Coffre)
                ---------------------------------------
                local Boss = vector3(json.decode(v.boss).x, json.decode(v.boss).y, json.decode(v.boss).z)
                local dist_Boss = #(plyPos-Boss)
                ---------------------------------------

                ------------------------------------------------------------------------------

                    if dist_Garage <= 20.0 then
                        Timer = 0
                        DrawMarker(6, json.decode(v.garage).x, json.decode(v.garage).y, json.decode(v.garage).z-0.99, 0.0, 0.0, 0.0, -90, 0.0, 0.0, 0.7, 0.7, 0.7, 255, 255, 255, 170, 0, 1, 2, 0, nil, nil, 0) 
                    end

                    if dist_Garage <= 3.0 then
                        Timer = 0
                        AddTextEntry("HELP", "Appuyez sur ~INPUT_CONTEXT~ ~s~pour ouvrir le garage")
                        DisplayHelpTextThisFrame("HELP", false)
                        if IsControlJustPressed(1,51) then
                            evVehi()

                        end
                    end


                ------------------------------------------------------------------------------

                if dist_Coffre <= 20.0 then
                    Timer = 0
                    DrawMarker(6, json.decode(v.coffre).x, json.decode(v.coffre).y, json.decode(v.coffre).z-0.99, 0.0, 0.0, 0.0, -90, 0.0, 0.0, 0.7, 0.7, 0.7, 255, 255, 255, 170, 0, 1, 2, 0, nil, nil, 0) 
                end

                if dist_Coffre <= 3.0 then
                    Timer = 0
                    AddTextEntry("HELP", "Appuyez sur ~INPUT_CONTEXT~ ~s~pour ouvrir le coffre")
                    DisplayHelpTextThisFrame("HELP", false)
                    if IsControlJustPressed(1,51) then
                        MenuCoffreGangs(v.label)
                    end
                end

                ------------------------------------------------------------------------------

                if dist_Boss <= 20.0 and ESX.PlayerData.job2.grade_name == 'boss' then
                    Timer = 0
                    DrawMarker(6, json.decode(v.boss).x, json.decode(v.boss).y, json.decode(v.boss).z-0.99, 0.0, 0.0, 0.0, -90, 0.0, 0.0, 0.7, 0.7, 0.7, 255, 255, 255, 170, 0, 1, 2, 0, nil, nil, 0) 
                end

                if dist_Boss <= 3.0 and ESX.PlayerData.job2.grade_name == 'boss' then
                    Timer = 0
                    AddTextEntry("HELP", "Appuyez sur ~INPUT_CONTEXT~ ~s~pour ouvrir les actions patrons")
                    DisplayHelpTextThisFrame("HELP", false)
                    if IsControlJustPressed(1,51) then
                        OpenMenuBossEvJob()
                    end
                end

            end
        end
        Citizen.Wait(Timer)
    end
end)

myGang2 = {}
function evVehi()
    local ped = GetPlayerPed(-1)
    ESX.TriggerServerCallback('getAllGang', function(result)
        myGang = result
     --   print(json.encode(myGang, {indent = true})) 
    end)

    ESX.TriggerServerCallback('getTheGang',function(result)
        myGang2 = result
        print(json.encode(myGang2, {indent = true}))
    end)
    
    local evGarage = RageUI.CreateMenu("Garage", "vehicules disponibles") 

    RageUI.Visible(evGarage, not RageUI.Visible(evGarage))

    while evGarage do
        
        Citizen.Wait(0)

        RageUI.IsVisible(evGarage,true,true,true,function()

            for k,v in pairs(myGang2) do


        
                RageUI.ButtonWithStyle("~b~→~s~ "..v.vehi,nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        local ped = PlayerPedId()
                        local model = GetHashKey(v.vehi)
                        RequestModel(model)
                        while not HasModelLoaded(model) do Citizen.Wait(10) end
                        local pos = GetEntityCoords(PlayerPedId())
                        local vehicle = CreateVehicle(model, pos.x, pos.y, pos.z, 230.0, true, false)
                        TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)  
                    end
                end)


                RageUI.ButtonWithStyle("~b~→~s~ "..v.vehi2,nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        local ped = PlayerPedId()
                        local model = GetHashKey(v.vehi2)
                        RequestModel(model)
                        while not HasModelLoaded(model) do Citizen.Wait(10) end
                        local pos = GetEntityCoords(PlayerPedId())
                        local vehicle = CreateVehicle(model, pos.x, pos.y, pos.z, 230.0, true, false)
                        TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)  
                    end
                end)

                RageUI.ButtonWithStyle("~b~→~s~ "..v.vehi3,nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        local ped = PlayerPedId()
                        local model = GetHashKey(v.vehi3)
                        RequestModel(model)
                        while not HasModelLoaded(model) do Citizen.Wait(10) end
                        local pos = GetEntityCoords(PlayerPedId())
                        local vehicle = CreateVehicle(model, pos.x, pos.y, pos.z, 230.0, true, false)
                        TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)  
                    end
                end)

            end

            RageUI.ButtonWithStyle("~r~→~s~ Ranger le véhicule", nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    local playerPed = PlayerPedId()
                    local Vehicle = GetVehiclePedIsUsing(PlayerPedId())
                    ESX.Game.DeleteVehicle(Vehicle)
                    ESX.ShowNotification('~g~Vehicule rangé') 
                end
            end)
             
            


        
        end, function()
        end)

        if not RageUI.Visible(evGarage) then
            evGarage=RMenu:DeleteType("evGarage", true)
        end

    end

    
end






function OpenMenuBossEvJob()


    ESX.TriggerServerCallback('getTheGang',function(result)
        myGang2 = result
        print(json.encode(myGang2, {indent = true}))
    end)

    for k, v in pairs(myGang2) do

    local menuBossSheriff = RageUI.CreateMenu(v.label,"boss gestion")

    RageUI.Visible(menuBossSheriff, not RageUI.Visible(menuBossSheriff))

    while menuBossSheriff do
        
        Citizen.Wait(0)

        RageUI.IsVisible(menuBossSheriff,true,true,true,function()
            FreezeEntityPosition(GetPlayerPed(-1), true)


            RageUI.Separator("↓ ~r~  Argent total de la sociétée ~s~↓")
            RefreshGangsMoney()

            if societyGangsmoney ~= nil then
                RageUI.ButtonWithStyle("Argent de societé :", nil, {RightLabel = "~b~$" .. societyGangsmoney}, true, function()
                end)
            end


            RageUI.Separator("↓     ~y~Gestion de l'entreprise     ~s~↓")
        
            
            RageUI.ButtonWithStyle("Deposer", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    local moneyDep = KeyboardInput("Combien ?", "", 20) 
                    moneyDep = tonumber(moneyDep)
                    if moneyDep == nil then
                        ESX.ShowNotification("Veuillez rentrer un nombre valide")
                    else
                        TriggerServerEvent('depositMoney', ESX.PlayerData.job2.name, moneyDep)
                        RefreshGangsMoney()
                    end   
                end
            end)
            RageUI.ButtonWithStyle("Retirer", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    local moneyRet = KeyboardInput("Combien ?", "", 20) 
                    moneyRet = tonumber(moneyRet)
                    if moneyRet == nil then
                        ESX.ShowNotification("Veuillez rentrer un nombre valide")
                    else
                        TriggerServerEvent('withdrawMoney', ESX.PlayerData.job2.name, moneyRet)
                        RefreshGangsMoney()
                    end  
                end
            end)

        
        end, function()
        end)

        if not RageUI.Visible(menuBossSheriff) then
            menuBossSheriff=RMenu:DeleteType("menuBossSheriff", true)
            FreezeEntityPosition(GetPlayerPed(-1), false)
        end

    end
end

end




function RefreshGangsMoney()
    if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.grade_name == 'boss' then
        ESX.TriggerServerCallback('getSocietyMoney', function(money)
            UpdateSocietyGangsMoney(money)
        end, "society_"..ESX.PlayerData.job2.name)
    end
end

function UpdateSocietyGangsMoney(money)
    societyGangsmoney = ESX.Math.GroupDigits(money)
end







function OpenMenuBossEvJob2()

    for k, v in pairs(myGang) do

    local evBoss23 = RageUI.CreateMenu(v.label,"coffre")

    RageUI.Visible(evBoss23, not RageUI.Visible(evBoss23))

    while evBoss23 do
        
        Citizen.Wait(0)

        RageUI.IsVisible(evBoss23,true,true,true,function()
            FreezeEntityPosition(GetPlayerPed(-1), true)



            RageUI.Separator("↓     ~y~Options     ~s~↓")
        
            
            RageUI.ButtonWithStyle("Deposer", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent('ev:checkJob')
                end
            end)

            RageUI.ButtonWithStyle("Prendre", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent('prendreitems')
                end
            end)
            

        
        end, function()
        end)

        if not RageUI.Visible(evBoss23) then
            evBoss23=RMenu:DeleteType("evBoss23", true)
            FreezeEntityPosition(GetPlayerPed(-1), false)
        end

    end
end

end






























local CoffreIndex = 1
local CoffreIndexSale = 1

function MenuCoffreGangs(Label)
    local MenuCoffre = RageUI.CreateMenu("Stockage", "Coffre "..Label)
        RageUI.Visible(MenuCoffre, not RageUI.Visible(MenuCoffre))
            while MenuCoffre do
            Citizen.Wait(0)
            RageUI.IsVisible(MenuCoffre, true, true, true, function()

                RageUI.Separator("~b~"..Label)

                RageUI.ButtonWithStyle("→ Prendre objet(s)",nil, {}, true, function(Hovered, Active, Selected)
                    if Selected then
                        CoffreRetirer(Label)
                        RageUI.CloseAll()
                    end
                end)
                
                RageUI.ButtonWithStyle("→ Déposer objet(s)",nil, {}, true, function(Hovered, Active, Selected)
                    if Selected then
                        CoffreDeposer(Label)
                        RageUI.CloseAll()
                    end
                end)

                


                end, function()
                end)
            if not RageUI.Visible(MenuCoffre) then
            MenuCoffre = RMenu:DeleteType("MenuCoffre", true)
        end
    end
end




itemstock = {}

function CoffreRetirer(Label)
    local StockCoffre = RageUI.CreateMenu("Prendre", "Prendre objet(s) "..Label)
    ESX.TriggerServerCallback('getStockItems', function(items) 
    itemstock = items
    RageUI.Visible(StockCoffre, not RageUI.Visible(StockCoffre))
        while StockCoffre do
            Citizen.Wait(0)
                RageUI.IsVisible(StockCoffre, true, true, true, function()
                        for k,v in pairs(itemstock) do 
                            if v.count > 0 then
                            RageUI.ButtonWithStyle("~r~→~s~ "..v.label, nil, {RightLabel = "(x"..v.count..")"}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    local cbRetirer = KeyboardInput("Combien ?", "", 15)
                                    cbRetirer = tonumber(cbRetirer)
                                    if cbRetirer == nil then
                                        RageUI.Popup({message = "Montant invalide"})
                                    else
                                        TriggerServerEvent('getStockItem', v.name, tonumber(cbRetirer), Label)
                                    end
                                end
                            end)
                        end
                    end
                end, function()
                end)
            if not RageUI.Visible(StockCoffre) then
            StockCoffre = RMenu:DeleteType("Coffre", true)
        end
    end
    end, Label)

end

function CoffreDeposer(Label)
    local StockPlayer = RageUI.CreateMenu("Deposer", "Déposer objet(s) "..Label)
    ESX.TriggerServerCallback('getPlayerInventory', function(inventory)
        RageUI.Visible(StockPlayer, not RageUI.Visible(StockPlayer))
    while StockPlayer do
        Citizen.Wait(0)
            RageUI.IsVisible(StockPlayer, true, true, true, function()
                for i=1, #inventory.items, 1 do
                    if inventory ~= nil then
                    local item = inventory.items[i]
                        if item.count > 0 then
                            RageUI.ButtonWithStyle("~r~→~s~ "..item.label, nil, {RightLabel = "(x"..item.count..")"}, true, function(Hovered, Active, Selected)
                                if Selected then
                                local cbDeposer = KeyboardInput("Combien ?", '' , 15)
                                cbDeposer = tonumber(cbDeposer)
                                    if cbDeposer == nil then
                                        RageUI.Popup({message = "Montant invalide"})
                                    else
                                        TriggerServerEvent('putStockItems', item.name, tonumber(cbDeposer), Label)
                                    end
                                end
                            end)
                        end
                    end
                end
            end, function()
            end)
                if not RageUI.Visible(StockPlayer) then
                StockPlayer = RMenu:DeleteType("Coffre", true)
            end
        end
    end)
end








