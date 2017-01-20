function ItemUsageThink()

    local npcBot = GetBot();

    CheckAndUseFlask(npcBot);
    checkAndUseFairieFire(npcBot);

end

function CheckAndUseFlask(npcBot)
    for i = 0,5 do
        local item = npcBot:GetItemInSlot(i);

        if ( item ) and item:GetName() == "item_flask" then
            if ( item:IsFullyCastable() ) then
                -- Add a logical condition here for when the bot should use the flask.
                if ( npcBot:GetHealthDeficit() >= 350 and npcBot:GetHealthRegen() <= 25 ) then
                    npcBot:Action_UseAbilityOnEntity(item, npcBot);
                end
            end
        end
    end
end

function checkAndUseFairieFire(npcBot)
    for i = 0,5 do
        local item = npcBot:GetItemInSlot(i);
        if ( item ) and item:GetName() == "item_faerie_fire" then
            if ( item:IsFullyCastable() ) then
                -- TODO: We need to use this to bait. So, we use this at the absolute last second. We need to use this when the enemies attack is supposed to kill you. But, as of now, we will just use it before dying.

                if npcBot:GetHealth() <= 200 then
                    npcBot:Action_UseAbility(item);
                end
            end
        end
    end
end