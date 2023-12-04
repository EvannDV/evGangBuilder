ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)







RegisterNetEvent("ev:checkIdentif")

AddEventHandler("ev:checkIdentif", function()
    local _src = source
	local xPlayer = ESX.GetPlayerFromId(_src)
	local namePly = GetPlayerName(_src)
    MySQL.Async.fetchAll("SELECT * FROM users WHERE name = @n", {['n'] = namePly }, function(data)
		local finit = data[1].identifier
		print(finit)
		for k, v in pairs(evCheck) do
        if finit == v.hex then
            print("Autorisé")
			TriggerClientEvent('OpenMenuEv', _src)
        else
            print("No access")
        end
		end
    end)
end)






RegisterServerEvent("ev:Create")
AddEventHandler("ev:Create", function(evGang)
    local source = source
    local playerD = GetPlayerName(source)
	local labelServ = evGang.label
	local garageServ = json.encode(evGang.garage)
	local coffreServ = json.encode(evGang.coffre)
	local bossServ = json.encode(evGang.boss)
	local vehiServ = evGang.vehi
	local vehi2Serv = evGang.vehi2
	local vehi3Serv = evGang.vehi3
	TriggerEvent('esx_society:registerSociety', labelServ, labelServ, 'soceity_'..labelServ, 'soceity_'..labelServ, 'soceity_'..labelServ, {type = 'private'})
	print(garageServ)

	MySQL.Async.execute("INSERT INTO evgang (label,garage,coffre,boss,vehi,vehi2,vehi3) VALUES (@label,@garage,@coffre,@boss,@vehi,@vehi2,@vehi3)",
	 {
		['label'] = labelServ, 
		['garage'] = garageServ, 
		['coffre'] = coffreServ, 
		['boss'] = bossServ, 
		['vehi'] = vehiServ, 
		['vehi2'] = vehi2Serv, 
		['vehi3'] = vehi3Serv, 
	}, function(rowsChanged)
	end)
	MySQL.Async.execute("INSERT INTO job_grades (job_name, grade, name, label, salary, skin_male, skin_female) VALUES (@job_name, @grade, @name, @label, @salary, @skin_male, @skin_female)",
	 {
		['job_name'] = labelServ, 
		['grade'] = 0, 
		['name'] = "recrue", 
		['label'] = "recrue", 
		['salary'] = 10, 
		['skin_male'] = "{}", 
		['skin_female'] = "{}", 
	}, function(rowsChanged)
	end)
	MySQL.Async.execute("INSERT INTO job_grades (job_name, grade, name, label, salary, skin_male, skin_female) VALUES (@job_name, @grade, @name, @label, @salary, @skin_male, @skin_female)",
	 {
		['job_name'] = labelServ, 
		['grade'] = 1, 
		['name'] = "caid", 
		['label'] = "caid", 
		['salary'] = 25, 
		['skin_male'] = "{}", 
		['skin_female'] = "{}", 
	}, function(rowsChanged)
	end)
	MySQL.Async.execute("INSERT INTO job_grades (job_name, grade, name, label, salary, skin_male, skin_female) VALUES (@job_name, @grade, @name, @label, @salary, @skin_male, @skin_female)",
	 {
		['job_name'] = labelServ, 
		['grade'] = 2, 
		['name'] = "grand", 
		['label'] = "grand", 
		['salary'] = 50, 
		['skin_male'] = "{}", 
		['skin_female'] = "{}", 
	}, function(rowsChanged)
	end)
	MySQL.Async.execute("INSERT INTO job_grades (job_name, grade, name, label, salary, skin_male, skin_female) VALUES (@job_name, @grade, @name, @label, @salary, @skin_male, @skin_female)",
	 {
		['job_name'] = labelServ, 
		['grade'] = 3, 
		['name'] = "boss", 
		['label'] = "boss", 
		['salary'] = 75, 
		['skin_male'] = "{}", 
		['skin_female'] = "{}", 
	}, function(rowsChanged)
	end)
	MySQL.Async.execute("INSERT INTO addon_account (name, label, shared) VALUES (@name,@label,@shared)",
	 {
		['label'] = labelServ, 
		['name'] = "society_"..labelServ,
		['shared'] = 1,
	}, function(rowsChanged)
	end)
	MySQL.Async.execute("INSERT INTO addon_inventory (name, label, shared) VALUES (@name,@label,@shared)",
	 {
		['label'] = labelServ, 
		['name'] = "society_"..labelServ,
		['shared'] = 1,
	}, function(rowsChanged)
	end)
	MySQL.Async.execute("INSERT INTO datastore (name, label, shared) VALUES (@name,@label,@shared)",
	 {
		['label'] = labelServ, 
		['name'] = "society_"..labelServ,
		['shared'] = 1,
	}, function(rowsChanged)
	end)
	MySQL.Async.execute("INSERT INTO jobs (name,label) VALUES (@name,@label)",
	 {
		['label'] = labelServ, 
		['name'] = labelServ, 
	}, function(rowsChanged)
		TriggerClientEvent('esx:showNotification', source, "📌 | Gang Créé avec ~g~succès ~s~!")
	end)
	TriggerEvent("esx:refreshJobs")
	TriggerEvent("esx_addonaccount:refreshAccounts")
	TriggerEvent("esx_addoninventory:refreshAddonInventory")
	TriggerEvent("esx_datastore:refreshDatastore")
	TriggerEvent('ev:Refrs')
	print("All good")
end)




ESX.RegisterServerCallback("getAllGang", function(source, cb)
    evGangs2 = {}
    MySQL.Async.fetchAll("SELECT * FROM evgang", {}, function(res)
        for k, v in pairs(res) do
            evGangs2[v.label] = {
				label = v.label,
				garage = v.garage,
				coffre = v.coffre,
				boss = v.boss,
				vehi = v.vehi,
				vehi2 = v.vehi2,
				vehi3 = v.vehi3,
				soci = "society_"..v.label
            }
        end
        cb(evGangs2)
    end)
end)


ESX.RegisterServerCallback("getTheGang", function(source, cb)
	local source = source
    evGangs3 = {}
	evVehic = {}
	local namePly = GetPlayerName(source)
    MySQL.Async.fetchAll("SELECT * FROM users WHERE name = @n", {['n'] = namePly }, function(data)
		jobPly = data[1].job2
		print(jobPly)
		MySQL.Async.fetchAll("SELECT * FROM evgang WHERE label = @l", {['l'] = jobPly }, function(result)
			if result[1] then
				print("okokev")
				for k, v in pairs(result) do
					evVehic[v.label] = {
						label = v.label,
						boss = v.boss,
						coffre = v.coffre,
						garage = v.garage,
						vehi = v.vehi,
						vehi2 = v.vehi2,
						vehi3 = v.vehi3
					}
				end
			else
				print("nonon ev")
			end
			cb(evVehic)
			
		end)

		
    end)
    
end)





ESX.RegisterServerCallback('getSocietyMoney', function(source, cb, societyName)
	if societyName then
		TriggerEvent('esx_addonaccount:getSharedAccount', societyName, function(account)
			cb(account.money)
		end)
	else
		cb(0)
	end
end)


RegisterServerEvent('withdrawMoney')
AddEventHandler('withdrawMoney', function(societyName, amount)
    local _src = source
	local xPlayer = ESX.GetPlayerFromId(_src)
	TriggerEvent('esx_addonaccount:getSharedAccount', "society_"..societyName, function(account)
		if amount > 0 and account.money >= amount then
			account.removeMoney(amount)
			xPlayer.addMoney(amount)
			TriggerClientEvent('esx:showNotification', _src, "Vous avez retiré ~r~$"..ESX.Math.GroupDigits(amount))
		else
			TriggerClientEvent('esx:showNotification', _src, "Montant invalide")
		end
	end)
end)



RegisterServerEvent('depositMoney')
AddEventHandler('depositMoney', function(societyName, amount)
    local _src = source
	local xPlayer = ESX.GetPlayerFromId(source)

		if amount > 0 and xPlayer.getMoney() >= amount then
			TriggerEvent('esx_addonaccount:getSharedAccount', "society_"..societyName, function(account)
				xPlayer.removeMoney(amount)
				TriggerClientEvent('esx:showNotification', _src, "Vous avez déposé ~g~$"..ESX.Math.GroupDigits(amount))
				account.addMoney(amount)
			end)
		else
			TriggerClientEvent('esx:showNotification', _src, "Montant invalide")
		end
end)




RegisterNetEvent('ev:Refrs')
AddEventHandler('ev:Refrs', function()
	StopResource("evGangBuilder")
	Wait(100)
	StartResource("evGangBuilder")
end)


RegisterNetEvent('ev:Set')
AddEventHandler('ev:Set', function(tape)
	local source = source
    local playerD = GetPlayerName(source)
    MySQL.Async.execute('UPDATE `users` SET `job2`=@job2  WHERE name=@a', {['@a'] = playerD, ['@job2'] = tape}, function(rowsChange)
    end)
	TriggerClientEvent('esx:showNotification', source, "That's work ! Wait a few second")

end)



------------- Test 




ESX.RegisterServerCallback('getStockItems', function(source, cb, society)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_'..society, function(inventory)
		cb(inventory.items)
	end)
end)

RegisterNetEvent('getStockItem')
AddEventHandler('getStockItem', function(itemName, count, society)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_'..society, function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		if count > 0 and inventoryItem.count >= count then
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				TriggerClientEvent('esx:showAdvancedNotification', _source, 'Coffre', '~o~Informations~s~', 'Vous avez retiré ~r~'..inventoryItem.label.." x"..count, 'CHAR_MP_FM_CONTACT', 8)
		else
			TriggerClientEvent('esx:showAdvancedNotification', _source, 'Coffre', '~o~Informations~s~', "Quantité ~r~invalide", 'CHAR_MP_FM_CONTACT', 9)
		end
	end)
end)

ESX.RegisterServerCallback('getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb({items = items})
end)

RegisterNetEvent('putStockItems')
AddEventHandler('putStockItems', function(itemName, count, society)
	local _src = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_'..society, function(inventory)
		local inventoryItem = inventory.getItem(itemName)
		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			TriggerClientEvent('esx:showAdvancedNotification', _src, 'Coffre', '~o~Informations~s~', 'Vous avez déposé ~g~'..inventoryItem.label.." x"..count, 'CHAR_MP_FM_CONTACT', 8)
		else
			TriggerClientEvent('esx:showAdvancedNotification', _src, 'Coffre', '~o~Informations~s~', "Quantité ~r~invalide", 'CHAR_MP_FM_CONTACT', 9)
		end
	end)
end)

ESX.RegisterServerCallback('getArmoryWeapons', function(source, cb, society)
	TriggerEvent('esx_datastore:getSharedDataStore', 'society_'..society, function(store)
		local weapons = store.get('weapons')
		if weapons == nil then weapons = {} end
		cb(weapons)
	end)
end)



ESX.RegisterServerCallback('removeArmoryWeapon', function(source, cb, weaponName, society)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addWeapon(weaponName, 500)
	TriggerEvent('esx_datastore:getSharedDataStore', 'society_'..society, function(store)
		local weapons = store.get('weapons') or {}
		local foundWeapon = false
		for i=1, #weapons, 1 do
			if weapons[i].name == weaponName then
				weapons[i].count = (weapons[i].count > 0 and weapons[i].count - 1 or 0)
				foundWeapon = true
				break
			end
		end
		if not foundWeapon then
			table.insert(weapons, {name = weaponName, count = 0}) 
		end
		store.set('weapons', weapons)
		cb()
	end)
end)

ESX.RegisterServerCallback('addArmoryWeapon', function(source, cb, weaponName, removeWeapon, society)
	local xPlayer = ESX.GetPlayerFromId(source)

	if removeWeapon then
		xPlayer.removeWeapon(weaponName)
	end
	TriggerEvent('esx_datastore:getSharedDataStore', 'society_'..society, function(store)
		local weapons = store.get('weapons') or {}
		local foundWeapon = false

		for i=1, #weapons, 1 do
			if weapons[i].name == weaponName then
				weapons[i].label = weaponLabel
				weapons[i].count = weapons[i].count + 1
				foundWeapon = true
				break
			end
		end
		if not foundWeapon then
			table.insert(weapons, {
				name  = weaponName,
				count = 1
			})
		end
		store.set('weapons', weapons)
		cb()
	end)
end)










RegisterServerEvent('recruter')
AddEventHandler('recruter', function(ve1, closestPlayer)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xTarget = ESX.GetPlayerFromId(closestPlayer)

	if xTarget == nil then
		TriggerClientEvent('esx:showNotification', source, "Personne à proximité")
	else
		if xPlayer.job2.grade_name == 'boss' then
			xTarget.setJob2(closestPlayer, 0)
			TriggerClientEvent('esx:showNotification', xPlayer.source, "Le joueur a été recruté")
			TriggerClientEvent('esx:showNotification', closestPlayer, "Bienvenue chez "..ve1.."!")
		  else
			TriggerClientEvent('esx:showNotification', xPlayer.source, "Vous n'êtes pas patron")
		end
	end

  	
end)

RegisterServerEvent('promouvoir')
AddEventHandler('promouvoir', function(ve1, closestPlayer)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xTarget = ESX.GetPlayerFromId(closestPlayer)
	if xTarget == nil then
		TriggerClientEvent('esx:showNotification', source, "Personne à proximité")
	else

  	if xPlayer.job2.grade_name == 'boss' and xPlayer.job2.name == xTarget.job2.name then
  		xTarget.setJob2(ve1, tonumber(xTarget.job2.grade) + 1)
  		TriggerClientEvent('esx:showNotification', xPlayer.source, "Le joueur a été promu")
  		TriggerClientEvent('esx:showNotification', closestPlayer, "Vous avez été promu "..ve1.."!")
  	else
		TriggerClientEvent('esx:showNotification', xPlayer.source, "Vous n'êtes pas patron ou le joueur ne peut pas être promu")
	end
end
end)

RegisterServerEvent('descendre')
AddEventHandler('descendre', function(ve1, closestPlayer)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xTarget = ESX.GetPlayerFromId(closestPlayer)
	if xTarget == nil then
		TriggerClientEvent('esx:showNotification', source, "Personne à proximité")
	else

  	if xPlayer.job2.grade_name == 'boss' and xPlayer.job2.name == xTarget.job2.name then
		xTarget.setJob2(ve1, tonumber(xTarget.job2.grade) - 1)
		TriggerClientEvent('esx:showNotification', xPlayer.source, "Le joueur a été rétrogradé")
		TriggerClientEvent('esx:showNotification', closestPlayer, "Vous avez été rétrogradé de "..ve1.."!")
	else
		TriggerClientEvent('esx:showNotification', xPlayer.source, "Vous n'êtes pas patron ou le joueur ne peut pas être rétrogradé")
	end
end
end)

RegisterServerEvent('virer')
AddEventHandler('virer', function(ve1, closestPlayer)
  local xPlayer = ESX.GetPlayerFromId(source)
  local xTarget = ESX.GetPlayerFromId(closestPlayer)
  if xTarget == nil then
	TriggerClientEvent('esx:showNotification', source, "Personne à proximité")
else

  	if xPlayer.job2.grade_name == 'boss' and xPlayer.job2.name == xTarget.job2.name then
  		xTarget.setJob2("unemployed2", 0)
  		TriggerClientEvent('esx:showNotification', xPlayer.source, "Le joueur a été viré")
  		TriggerClientEvent('esx:showNotification', closestPlayer, "Vous avez été viré de "..ve1.."!")
  	else
		TriggerClientEvent('esx:showNotification', xPlayer.source, "Vous n'êtes pas patron ou le joueur ne peut pas être viré")
	end
end
end)



------ Fouille


RegisterNetEvent('confiscatePlayerItem')
AddEventHandler('confiscatePlayerItem', function(target, itemType, itemName, amount)
    local _source = source
    local sourceXPlayer = ESX.GetPlayerFromId(_source)
    local targetXPlayer = ESX.GetPlayerFromId(target)

    if itemType == 'item_standard' then
        local targetItem = targetXPlayer.getInventoryItem(itemName)
		local sourceItem = sourceXPlayer.getInventoryItem(itemName)
		
		targetXPlayer.removeInventoryItem(itemName, amount)
		sourceXPlayer.addInventoryItem   (itemName, amount)
		TriggerClientEvent("esx:showNotification", source, "Vous avez confisqué ~b~"..amount..' '..sourceItem.label.."~s~.")
		TriggerClientEvent("esx:showNotification", target, "Quelqu'un vous a pris ~b~"..amount..' '..sourceItem.label.."~s~.")
	end
        
    if itemType == 'item_account' then
        targetXPlayer.removeAccountMoney(itemName, amount)
        sourceXPlayer.addAccountMoney   (itemName, amount)
        
        TriggerClientEvent("esx:showNotification", source, "Vous avez confisqué ~b~"..amount.."€ ~s~argent non déclaré~s~.")
        TriggerClientEvent("esx:showNotification", target, "Quelqu'un vous a pris ~b~"..amount.."€ ~s~argent non déclaré~s~.")
        
    end

	if itemType == 'item_weapon' then
        if amount == nil then amount = 0 end
        targetXPlayer.removeWeapon(itemName, amount)
        sourceXPlayer.addWeapon   (itemName, amount)

        TriggerClientEvent("esx:showNotification", source, "Vous avez confisqué ~b~"..ESX.GetWeaponLabel(itemName).."~s~ avec ~b~"..amount.."~s~ balle(s).")
        TriggerClientEvent("esx:showNotification", target, "Quelqu'un vous a confisqué ~b~"..ESX.GetWeaponLabel(itemName).."~s~ avec ~b~"..amount.."~s~ balle(s).")
    end
end)

ESX.RegisterServerCallback('getOtherPlayerData', function(source, cb, target, notify)
    local xPlayer = ESX.GetPlayerFromId(target)

    TriggerClientEvent("esx:showNotification", target, "~r~~Quelqu'un vous fouille")

    if xPlayer then
        local data = {
            name = xPlayer.getName(),
            job = xPlayer.job.label,
            grade = xPlayer.job.grade_label,
            inventory = xPlayer.getInventory(),
            accounts = xPlayer.getAccounts(),
            weapons = xPlayer.getLoadout()
        }

        cb(data)
    end
end)