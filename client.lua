if IsPlayerAceAllowed(source, "discordcheck.see") then
  TriggerEvent('chat:addSuggestion', '/discordcheck', 'Checks for targeted players discord information.', {
        {
            name = "action",
            help = "name or nick | name will prompt you their discord name & nick will prompt you their nickname."
        },
        {
            name = "playerID",
            help = "The player's server ID."
        }
    })
end