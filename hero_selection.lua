

----------------------------------------------------------------------------------------------------

function Think()

  -- Get the current Game Mode.
  
  local currentWorkingHero = "npc_dota_hero_sniper"
  
  local onePlayerSelected = false
  
  local gameMode = GetGameMode()
  
  if ( gameMode == GAMEMODE_1V1MID ) then
      local playerIds = GetTeamPlayers(GetTeam())
      for i, id in pairs(playerIds) do
        if ( IsPlayerBot(id) and (not onePlayerSelected ) ) then
          SelectHero( id, currentWorkingHero )
          onePlayerSelected = true
        end
      end
    return
  else
    print("The current Game Mode is : " , gameMode , " and the target gameMode was " , GAMEMODE_1V1MID , "\n")
    if ( GetTeam() == TEAM_RADIANT )
    then
      print( "selecting radiant" );
      SelectHero( 0, "npc_dota_hero_antimage" );
      SelectHero( 1, "npc_dota_hero_axe" );
      SelectHero( 2, "npc_dota_hero_bane" );
      SelectHero( 3, "npc_dota_hero_bloodseeker" );
      SelectHero( 4, "npc_dota_hero_crystal_maiden" );
    elseif ( GetTeam() == TEAM_DIRE )
    then
      print( "selecting dire" );
      SelectHero( 5, "npc_dota_hero_drow_ranger" );
      SelectHero( 6, "npc_dota_hero_earthshaker" );
      SelectHero( 7, "npc_dota_hero_juggernaut" );
      SelectHero( 8, "npc_dota_hero_mirana" );
      SelectHero( 9, "npc_dota_hero_nevermore" );
    end
    return
  end
  
end

function UpdateLaneAssignments()    
    if ( GetTeam() == TEAM_RADIANT )
    then
        return {
        [1] = LANE_MID,
        [2] = LANE_BOT,
        [3] = LANE_TOP,
        [4] = LANE_MID,
        [5] = LANE_BOT,
        };
    elseif ( GetTeam() == TEAM_DIRE )
    then
        return {
        [1] = LANE_MID,
        [2] = LANE_BOT,
        [3] = LANE_TOP,
        [4] = LANE_MID,
        [5] = LANE_BOT,
        };
    end
end

----------------------------------------------------------------------------------------------------
