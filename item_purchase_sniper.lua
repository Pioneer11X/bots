local tableItemsToBuy = {
  -- Apparently the fucking game could not figure out how to buy a wraithband. So, we need to specify each component of it.
  "item_faerie_fire",
  "item_branches",
  "item_slippers",
  "item_circlet",
  "item_recipe_wraith_band",
  "item_boots",
  "item_blades_of_attack",
  "item_blades_of_attack",
  "item_blight_stone"
}

local bkbComp = {
  "item_ogre_axe",
  "item_mithril_hammer",
  "item_recipe_black_king_bar"
}

local mkbComp = {
  "item_demon_edge",
  "item_javelin",
  "item_javelin"
}

local dragonLanceComp = {
  "item_ogre_axe",
  "item_boots_of_elves",
  "item_boots_of_elves"
}

local critComp = {
  "item_broadsword",
  "item_blades_of_attack",
  "item_recipe_lesser_crit"
}

local knownEvasionSkills = {
  "phantom_assassin_blur",
  "arc_warden_magnetic_field",
  "special_bonus_evasion_10",
  "special_bonus_evasion_12",
  "special_bonus_evasion_15",
  "special_bonus_evasion_20",
  "special_bonus_evasion_25"
}

local knownEvasionItems = {
  "item_talisman_of_evasion",
  "item_butterfly",
  "item_heavens_halberd",
  "item_solar_crest"
}

local buyingMKB = false
local buyingDragonLance = false
local buyingBKB= false
local buyingDesolator = false

function addItem( someItemComp )
  for _, v in pairs(someItemComp) do
    tableItemsToBuy[#tableItemsToBuy + 1] = v
  end
end  

function checkForItem( npcBot, item_name )
  local returnItem = nil
  local currentItem = nil
  for j = 0, 5, 1 do
    currentItem = npcBot:GetItemInSlot(j)
    if (currentItem ~= nil)
    then
      if ( currentItem:GetName() == item_name )
      then
        returnItem = currentItem
      else
        --print( currentItem:GetName() )
      end
    end
  end
  return returnItem
end

function checkForEvasion(npcBot)
  local hasEvasion = false
  for _,v in pairs(knownEvasionItems)
  do
    checkItem = checkForItem( npcBot, v )
    if checkItem ~= nil then
      hasEvasion = true
    end
  end
  return hasEvasion
end

function checkForSkill(npcBot, skill_name)
  local returnSkill = nil
  local currentSkill = nil
end

function ItemPurchaseThink()

	local npcBot = GetBot();
  
-- Add a condition here to check for the enemy item inventory and add MKB if necessary

-- Get all enemy players --
  local npcBot = GetBot()
  local npcTeam = GetTeam()
  local enemyTeam
  
  if ( npcTeam == TEAM_RADIANT ) then
    enemyTeam = TEAM_DIRE
  else
    enemyTeam = TEAM_RADIANT
  end
  
  -- Get all the enemy players in a loop.
  local currentEnemy
  for i = 1, 5, 1 do
    currentEnemy = GetTeamMember( enemyTeam, i )
    -- Check if the current Enemy has Butterfly or any evasion
    if currentEnemy ~= nil then
      if ( ( not buyingMKB ) and checkForEvasion(currentEnemy) ) then
        addItem( mkbComp )
        buyingMKB = true
      end
    end
    
    if currentEnemy ~= nil then
      -- Check if the enemy hero has evasion abilities.
--      print(currentEnemy.GetAbilityByName())
    end
  end
  
  if ( ( DotaTime() >= 15.00 ) and ( not buyingDragonLance ) ) then
    addItem(dragonLanceComp)
    buyingDragonLance = true
  end

	if ( #tableItemsToBuy == 0 )
	then
		npcBot:SetNextItemPurchaseValue( 0 );
		return;
	end

	local sNextItem = tableItemsToBuy[1];

	npcBot:SetNextItemPurchaseValue( GetItemCost( sNextItem ) );

	if ( npcBot:GetGold() >= GetItemCost( sNextItem ) )
	then
		npcBot:Action_PurchaseItem( sNextItem );
		table.remove( tableItemsToBuy, 1 );
	end

end
