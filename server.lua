prefix = '^3[^1BreezyDiscordCheck^3] ^3'

function GetDiscordName(user) 
    return exports.Badger_Discord_API:GetDiscordName(user);
end

function GetDiscordNickname(user) 
    return exports.Badger_Discord_API:GetDiscordNickname(user);
end

RegisterCommand('discordcheck', function(source, args, rawCommand) 
	-- /discordcheck nick <id>
    -- /discordcheck name <id> 
	if IsPlayerAceAllowed(source, 'discordcheck.see') then 
		if #args == 2 then 
			if GetPlayerIdentifiers(tonumber(args[2]))[2] ~= nil then
			local id = tonumber(args[2])
                if args[1] == "name" then
                    if GetDiscordName(id) ~= nil then
                        TriggerClientEvent('chatMessage', source, prefix .. '^3Player: ^5' .. GetPlayerName(id) .. ' ^3\nDiscord Name is: ^5' .. GetDiscordName(id))
                    else
                        TriggerClientEvent('chatMessage', source, prefix .. '^1ERROR: ^5' .. GetPlayerName(id) .. ' ^1does not have a discord linked.')
                    end

                elseif args[1] == "nick" then
                    if GetDiscordNickname(id) ~= nil then
                        TriggerClientEvent('chatMessage', source, prefix .. '^3Player: ^5' .. GetPlayerName(id) .. ' ^3\nDiscord Nickname is: ^5' .. GetDiscordNickname(id))
                    else
                        TriggerClientEvent('chatMessage', source, prefix .. '^1ERROR: ^5' .. GetPlayerName(id) .. ' ^1does not have a nickname set.')
                    end
                elseif args[1] ~= "nick" and args[1] ~= "name" then
                    TriggerClientEvent('chatMessage', source, prefix .. '^1ERROR: Wrong usage. /discordcheck <nick:name> <id>')
                end

			else 
				-- Not a valid player 
				TriggerClientEvent('chatMessage', source, prefix .. '^1ERROR: Not a valid player')
			end
		else 
			-- Wrong syntax, it's discordcheck <id> 
			TriggerClientEvent('chatMessage', source, prefix .. '^1ERROR: Wrong usage. /discordcheck <nick:name> <id>')
		end
	else 
		TriggerClientEvent('chatMessage', source, prefix .. 'You do not have permission to do this!')
	end
end)


expectedName = "BreezyDiscordCheck" -- This is the resource and is not suggested to be changed.
resource = GetCurrentResourceName()

-- check if resource is renamed
if resource ~= expectedName then
    print("^1[^4" .. expectedName .. "^1] WARNING^0")
    print("Change the resource name to ^4" .. expectedName .. " ^0or else it won't work!")
end


print("^0This resource is created by ^5Breezy#0001 ^0for support you can join the ^5discord: ^0https://discord.gg/zzUfkfRHzP")

-- check if resource version is up to date
PerformHttpRequest("https://raw.githubusercontent.com/DevBreezy/DiscordCheck/main/fxmanifest.lua", function(error, res, head)
    i, j = string.find(tostring(res), "version")
    res = string.sub(tostring(res), i, j + 6)
    res = string.gsub(res, "version ", "")

    res = string.gsub(res, '"', "")
    resp = tonumber(res)
    verFile = GetResourceMetadata(expectedName, "version", 0)
    if verFile then
        if tonumber(verFile) < resp then
            print("^1[^4" .. expectedName .. "^1] WARNING^0")
            print("^4" .. expectedName .. " ^0is outdated. Please update it from ^5https://github.com/DevBreezy/DiscordCheck^0| Current Version: ^1" .. verFile .. " ^0| New Version: ^2" .. resp .. " ^0|")
        elseif tonumber(verFile) > tonumber(resp) then
            print("^1[^4" .. expectedName .. "^1] WARNING^0")
            print("^4" .. expectedName .. "s ^0version number is higher than we expected. | Current Version: ^3" .. verFile .. " ^0| Expected Version: ^2" .. resp .. " ^0|")
        else
            print("^4" .. expectedName .. " ^0is up to date | Current Version: ^2" .. verFile .. " ^0|")
        end
    else
        print("^1[^4" .. expectedName .. "^1] WARNING^0")
        print("You may not have the latest version of ^4" .. expectedName .. "^0. A newer, improved version may be present at ^5https://github.com/DevBreezy/DiscordCheck^0")
    end
end)
