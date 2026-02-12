require 'herorealms'
require 'decks'
require 'stdlib'
require 'coopai'
require 'timeoutai'

isCoop = true

local function viking_boss_mead_carddef()
    local card_name = "viking_boss_mead"
	
    return createItemDef({
        id = "viking_boss_mead",
        name = "Mead",
        types = { itemType },
		aiPriority = toIntExpression(-1),
        acquireCost = 0,
        abilities = {
            createAbility({
                id = "viking_boss_mead",
                effect = gainHealthEffect(1),
                cost = noCost,
                trigger = onPlayTrigger,
                tags = {  },
				aiPriority = toIntExpression(-2)
            })
        },
        layout = createLayout(
                {
                    name = "Mead",
                    art = "art/treasures/T_Fighter_Elixir_Red",
                    frame = "frames/barbarian_frames/barbarian_item_cardframe",
                    xmlText=[[
					<vlayout>
    <box flexibleheight="3">
        <tmpro text="{health_1}" fontsize="60" fontstyle="italic"/>
    </box>
</vlayout>
					]]
                }
            )
    })
end


function vikingSetupBuffDef()

local ef_4 = gainMaxHealthEffect(currentPid, const(-20)).seq(healPlayerEffect(currentPid, -20))
				.seq(showSpeechBubbleEffect({
								playerExpression=currentPid,
								text="What a feeble lot of peasants.",
								waitForClick= constBoolExpression(false)
							}))

local ef_6 = showSpeechBubbleEffect({
								playerExpression=currentPid,
								text="Bring me mead.",
								waitForClick= constBoolExpression(false)
							})							

local ef_14 = 	gainMaxHealthEffect(currentPid, const(20)).seq(healPlayerEffect(currentPid, 20))
				.seq(showSpeechBubbleEffect({
								playerExpression=currentPid,
								text="I will carve my name in your shield with my axe!",
								waitForClick= constBoolExpression(false)
							}))


	local efvikingSetup = 	
					--level 1-4						
							ifElseEffect(getHeroLevel(oppPid).lte(4),
									ef_4, nullEffect())
						
					--level 1-6						
						.seq(ifElseEffect(getHeroLevel(oppPid).lte(6),
									ef_6, nullEffect()))
						.seq(ifElseEffect(getHeroLevel(oppPid).lte(6),
									createCardEffect(shields_a_buff_def(), loc(oppPid, buffsPloc)), nullEffect()))
						.seq(ifElseEffect(getHeroLevel(oppPid).lte(6),
									createCardEffect(shields_a_buff_def(), loc(nextOppPid, buffsPloc)), nullEffect()))
						.seq(ifElseEffect(getHeroLevel(oppPid).lte(6),
									createCardEffect(plunderstruck_0_skill_def(), loc(currentPid, skillsPloc)), nullEffect()))
						.seq(ifElseEffect(getHeroLevel(oppPid).lte(6),
									createCardEffect(plunderstruck_0_skill_def(), loc(nextAllyPid, skillsPloc)), nullEffect()))
						.seq(ifElseEffect(getHeroLevel(oppPid).lte(6),
									createCardEffect(plunderstruck_0_upgrade_BuffDef(), loc(currentPid, buffsPloc)), nullEffect()))
						.seq(ifElseEffect(getHeroLevel(oppPid).lte(6),
									createCardEffect(plunderstruck_0_upgrade_BuffDef(), loc(nextAllyPid, buffsPloc)), nullEffect()))									
							.seq(ifElseEffect(getHeroLevel(oppPid).lte(6),
									sacrificeTarget().apply(selectLoc(loc(currentPid, deckPloc)).where(isCardName("viking_boss_berserker_elite")).take(1)), nullEffect()))	--removes both
							.seq(ifElseEffect(getHeroLevel(oppPid).lte(6),
									sacrificeTarget().apply(selectLoc(loc(currentPid, deckPloc)).where(isCardName("viking_boss_bogmær")).take(1)), nullEffect()))
							.seq(ifElseEffect(getHeroLevel(oppPid).lte(6),
									sacrificeTarget().apply(selectLoc(loc(currentPid, deckPloc)).where(isCardName("viking_boss_axe_maker")).take(1)), nullEffect()))									
							.seq(ifElseEffect(getHeroLevel(oppPid).lte(6),
									sacrificeTarget().apply(selectLoc(loc(currentPid, deckPloc)).where(isCardName("viking_boss_karl")).take(1)), nullEffect()))					
							.seq(ifElseEffect(getHeroLevel(oppPid).lte(6),
									createCardEffect(viking_boss_mead_carddef(), loc(currentPid, deckPloc)), nullEffect()))
							.seq(ifElseEffect(getHeroLevel(oppPid).lte(6),
									createCardEffect(viking_boss_mead_carddef(), loc(currentPid, deckPloc)), nullEffect()))
							.seq(ifElseEffect(getHeroLevel(oppPid).lte(6),
									createCardEffect(viking_boss_mead_carddef(), loc(currentPid, deckPloc)), nullEffect()))
							.seq(ifElseEffect(getHeroLevel(oppPid).lte(6),
									createCardEffect(viking_boss_mead_carddef(), loc(currentPid, deckPloc)), nullEffect()))
							.seq(shuffleEffect(currentDeckLoc))
									
					--level 7+
					
							.seq(ifElseEffect(getHeroLevel(oppPid).gte(7),
									createCardEffect(shields_buff_def(), loc(oppPid, buffsPloc)), nullEffect()))
							.seq(ifElseEffect(getHeroLevel(oppPid).gte(7),
									createCardEffect(shields_buff_def(), loc(nextOppPid, buffsPloc)), nullEffect()))
							.seq(ifElseEffect(getHeroLevel(oppPid).gte(7),
									createCardEffect(plunderstruck_skill_def(), loc(currentPid, skillsPloc)), nullEffect()))
							.seq(ifElseEffect(getHeroLevel(oppPid).gte(7),
									createCardEffect(plunderstruck_skill_def(), loc(nextAllyPid, skillsPloc)), nullEffect()))
							.seq(ifElseEffect(getHeroLevel(oppPid).gte(7),
									createCardEffect(plunderstruck_upgrade_BuffDef(), loc(currentPid, buffsPloc)), nullEffect()))
							.seq(ifElseEffect(getHeroLevel(oppPid).gte(7),
									createCardEffect(plunderstruck_upgrade_BuffDef(), loc(nextAllyPid, buffsPloc)), nullEffect()))									

					--level 9+					
							.seq(ifElseEffect(getHeroLevel(oppPid).gte(9),
									createCardEffect(flamesword_BuffDef(), loc(currentPid, buffsPloc)), nullEffect()))
							.seq(ifElseEffect(getHeroLevel(oppPid).gte(9),
									createCardEffect(flamesword_BuffDef(), loc(nextAllyPid, buffsPloc)), nullEffect()))


					--level 12+								
							.seq(ifElseEffect(getHeroLevel(oppPid).gte(12),
									sacrificeTarget().apply(selectLoc(loc(currentPid, deckPloc)).where(isCardName("dagger"))), nullEffect()))
							.seq(ifElseEffect(getHeroLevel(oppPid).gte(12),
									sacrificeTarget().apply(selectLoc(loc(currentPid, deckPloc)).where(isCardName("dagger"))), nullEffect()))
							.seq(ifElseEffect(getHeroLevel(oppPid).gte(12),
									createCardEffect(shortsword_carddef(), loc(currentPid, deckPloc)), nullEffect()))
							.seq(ifElseEffect(getHeroLevel(oppPid).gte(12),
									createCardEffect(shortsword_carddef(), loc(currentPid, deckPloc)), nullEffect()))
							.seq(shuffleEffect(currentDeckLoc))

					--level 14+	
							.seq(ifElseEffect(getHeroLevel(oppPid).gte(14),
									ef_14, nullEffect()))		
							.seq(ifElseEffect(getHeroLevel(oppPid).gte(14),
									createCardEffect(summon_axe_maker_BuffDef(), loc(currentPid, buffsPloc)), nullEffect()))
							.seq(ifElseEffect(getHeroLevel(oppPid).gte(14),
									createCardEffect(summon_axe_maker_BuffDef(), loc(nextAllyPid, buffsPloc)), nullEffect()))

			
					--level 16+								
							.seq(ifElseEffect(getHeroLevel(oppPid).gte(16),
									createCardEffect(thors_blessing_BuffDef(), loc(currentPid, buffsPloc)), nullEffect()))
							.seq(ifElseEffect(getHeroLevel(oppPid).gte(16),
									createCardEffect(thors_blessing_BuffDef(), loc(nextAllyPid, buffsPloc)), nullEffect()))	
			
					--level 18+						
						.seq(ifElseEffect(getHeroLevel(oppPid).gte(18),
									createCardEffect(last_stand_BuffDef(), loc(currentPid, buffsPloc)), nullEffect()))
						.seq(ifElseEffect(getHeroLevel(oppPid).gte(18),
									createCardEffect(last_stand_BuffDef(), loc(nextAllyPid, buffsPloc)), nullEffect()))
				


    return createGlobalBuff({
        id="vikingSetupBuff",
        name = "Viking Setup",
        abilities = {
					
			createAbility({
                id="viking_setup_effect",
                trigger = startOfGameTrigger,
                effect = efvikingSetup
						
			
            })
        }
    })
end

	local hitHardbuff = createGlobalBuff({
        id="hitHardbuff",
        name = "Hit Hard",
        abilities = {
            createAbility({
                id= "hitHardbuff",
				trigger = startOfGameTrigger,
                effect = nullEffect(),
				}),
        },
		buffDetails = createBuffDetails({
					name = "Hit Hard",
                    art = "art/classes/barbarian/terrifying_howl",
					text = "<size=100%>Doesn't like being hit too hard."
							})
    })




-- Additional cards

local function vikings_shield_token_carddef()
local card_name = "vikings_shield_token"

    return createChampionDef(
        {
            id = "vikings_shield_token",
            name = "Shields",
			types = {eliteMinionType, championType, tokenType},
            acquireCost = 0,
            health = 2,
            isGuard = true,
            abilities = {
                createAbility(
                    {
                        id = "shield_token_sac",
                        trigger = onLeavePlayTrigger,
                        cost = sacrificeSelfCost,
                        activations = singleActivations,
                        effect = nullEffect()
					}	
                    
                )},
            layout = createLayout(
                {
                    name = "Shield",
                    art = "art/epicart/white_knight",
                    frame = "frames/barbarian_frames/barbarian_champion_cardframe",
                    xmlText=[[
<vlayout>
    <hlayout flexibleheight="1">

        <box flexiblewidth="7">
            <tmpro text="If this token would leave play, put it back in the token pile." fontsize="24"/>
</box>
</hlayout>
</vlayout>
					]],
                    health = 2,
                    isGuard = true
                }
            )
        }
    )
end

local function viking_boss_berserker_token_carddef()
    local card_name = "viking_boss_berserker_token"
	
    return createChampionDef(
        {
            id = "viking_boss_berserker_token",
            name = "Berserker",
			types = {championType, noStealType, tokenType},
            acquireCost = 0,
            health = 4,
            isGuard = false,
            abilities = {
                createAbility(
                    {
                        id = "berserker_token_main",
                        trigger = autoTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = gainCombatEffect(2)
						
                    }
                ),
				
				--health ability
                createAbility(
                    {
                        id = "berserker_token_health",
                        trigger = endOfTurnTrigger,
                        cost = noCost,
                        activations = singleActivations,
                       effect = grantHealthTarget(-2, { SlotExpireEnum.LeavesPlay }, nullEffect(), "").apply(selectSource())
                    }
                ),
				
				--self sac ability
				createAbility(
                    {
                        id = "viking_boss_berserker_token_sac",
                        trigger = onLeavePlayTrigger,
                        cost = sacrificeSelfCost,
                        activations = singleActivations,
                        effect = nullEffect()
					}	
                    
                )
            },
			
            layout = createLayout(
                {
                    name = "Berserker token",
                    art = "art/epicart/scarred_berserker",
                    frame = "frames/barbarian_frames/barbarian_champion_cardframe",
                    xmlText=[[
<vlayout>
<hlayout flexibleheight="3">
            <tmpro text="{expend}" fontsize="40" flexiblewidth="2"/>
            <tmpro text="{combat_2}
&lt;size=50%&gt;-2{shield} at the end of turn." fontsize="44" flexiblewidth="16" />
    </hlayout>
<divider/>
       <hlayout flexibleheight="1">
            <tmpro text="If this token would leave play, put it back in the token pile." fontsize="16"  flexiblewidth="14" />
    </hlayout> </vlayout>
					]],
                    health = 4,
                    isGuard = false
                }
            )
        }
    )
end


local function viking_boss_berserker_elite_carddef()
    local card_name = "viking_boss_berserker_elite"
	
    return createChampionDef(
        {
            id = "viking_boss_berserker_elite",
            name = "Berserker Elite",
			types = {championType, eliteMinionType, noStealType},
            acquireCost = 0,
            health = 6,
            isGuard = false,
            abilities = {
                createAbility(
                    {
                        id = "berserker_elite_main",
                        trigger = autoTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = gainCombatEffect(4)
						.seq(addSlotToPlayerEffect(currentPlayer(), createPlayerSlot({
								key = berserkSlotKey,
								expiry = { endOfTurnExpiry }
							})))
						
                    }
                ),
				
			--spawn ability
                createAbility(
                    {
                        id = "berserker_elite_spawn",
                        trigger = onPlayTrigger,
                        cost = noCost,
                        activations = singleActivations,
                        effect = createCardEffect(viking_boss_berserker_token_carddef(), loc(currentPid, inPlayPloc))
						.seq(createCardEffect(viking_boss_berserker_token_carddef(), loc(nextAllyPid, inPlayPloc)))

                    }
                ),

			--health ability
                createAbility(
                    {
                        id = "berserker_elite_health",
                        trigger = endOfTurnTrigger,
                        cost = noCost,
                        activations = singleActivations,
                        effect = grantHealthTarget(-2, { SlotExpireEnum.LeavesPlay }, nullEffect(), "").apply(selectSource())
                    }
                ),
			
            },
				
            layout = createLayout(
                {
                    name = "Berserker Elite",
                    art = "art/epicart/velden__frost_titan",
                    frame = "frames/barbarian_frames/barbarian_champion_cardframe",
                    xmlText=[[
<vlayout>
       <hlayout flexibleheight="1">       
<tmpro text="Elite" fontsize="16"  flexiblewidth="14" />
    </hlayout> 
       <hlayout flexibleheight="2">
        
<tmpro text="When played, put 2 Berserker tokens in play
(1 opposing each player)." fontsize="12"  flexiblewidth="14" />
    </hlayout> 
<divider/>
<hlayout flexibleheight="4">
            <tmpro text="{expend}" fontsize="40" flexiblewidth="2"/>
            <tmpro text="{combat_4}
&lt;size=40%&gt;You count as Berserk this turn.
-2{shield} at the end of turn." fontsize="40" flexiblewidth="12" />
    </hlayout>

</vlayout>
					]],
                    health = 6,
                    isGuard = false
                }
            )
        }
    )
end

local function viking_boss_huskarl_carddef()
    local card_name = "viking_boss_huskarl"
	
    return createChampionDef(
        {
            id = "viking_boss_huskarl",
            name = "Huskarl",
			types = {championType,  eliteMinionType, noStealType},
            acquireCost = 0,
            health = 3,
            isGuard = true,
			aiPriority = toIntExpression(5),
            abilities = {
                createAbility(
                    {
                        id = "huskarl_main",
                        trigger = autoTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = gainCombatEffect(3),
						aiPriority = toIntExpression(5)
						
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Huskarl",
                    art = "art/epicart/brand__rebel_fighter",
                    frame = "frames/barbarian_frames/barbarian_champion_cardframe",
                    xmlText=[[
<vlayout>
       <hlayout flexibleheight="1">       
<tmpro text="Elite" fontsize="16"  flexiblewidth="14" />
    </hlayout>
	<hlayout flexibleheight="3">
            <tmpro text="{expend}" fontsize="40" flexiblewidth="2"/>
            <tmpro text="{combat_3}" fontsize="50" flexiblewidth="12" />
    </hlayout>
</vlayout>
					]],
                    health = 3,
                    isGuard = true
                }
            )
        }
    )
end

local function viking_boss_karl_carddef()
    local card_name = "viking_boss_karl"
	
    return createChampionDef(
        {
            id = "viking_boss_karl",
            name = "Karl",
			types = {championType, eliteMinionType, noStealType},
            acquireCost = 0,
            health = 1,
            isGuard = false,
            abilities = {
                createAbility(
                    {
                        id = "karl_main",
                        trigger = autoTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = gainCombatEffect(1)
						
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Karl",
                    art = "art/classes/barbarian/growl",
                    frame = "frames/barbarian_frames/barbarian_champion_cardframe",
                    xmlText=[[
<vlayout>
       <hlayout flexibleheight="1">       
<tmpro text="Elite" fontsize="16"  flexiblewidth="14" />
    </hlayout>
	<hlayout flexibleheight="3">
            <tmpro text="{expend}" fontsize="40" flexiblewidth="2"/>
            <tmpro text="{combat_1}" fontsize="50" flexiblewidth="12" />
    </hlayout>
</vlayout>
					]],
                    health = 1,
                    isGuard = false
                }
            )
        }
    )
end

local function viking_boss_axe_maker_carddef()
    local card_name = "viking_boss_axe_maker"
	
    return createChampionDef(
        {
            id = "viking_boss_axe_maker",
            name = "Axe Maker",
			types = { championType, eliteMinionType, noStealType},
            acquireCost = 0,
            health = 2,
            isGuard = false,
            abilities = {
                createAbility(
                    {
                        id = "axe_maker_main",
                        trigger = autoTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = createCardEffect(fighter_throwing_axe_carddef(), loc(currentPid, deckPloc)).seq(moveToTopDeckTarget(true).apply(selectLoc(loc(currentPid, deckPloc)).where(isCardName("fighter_throwing_axe")).take(1)))
						
                    }
                ),
				
				
				--[[createAbility(
                    {
                        id = "axe_maker_protect",
						effect = addSlotToTarget(createNoAttackSlot({ startOfOwnerTurnExpiry, leavesPlayExpiry })).apply(selectSource()),
						cost = noCost,
						trigger = onPlayTrigger,
						aiPriority = toIntExpression(100)
						
                    }
                )
				]]
            },
            layout = createLayout(
                {
                    name = "Axe Maker",
                    art = "art/classes/barbarian/smoldering_rage_calm",
                    frame = "frames/barbarian_frames/barbarian_champion_cardframe",
                    xmlText=[[
<vlayout>
       <hlayout flexibleheight="1">       
<tmpro text="Elite" fontsize="16"  flexiblewidth="14" />
    </hlayout>
    <hlayout flexibleheight="3">

<tmpro text="{expend}" fontsize="50" flexiblewidth="2"/>
            <tmpro text="Put a Throwing Ax on top of your deck." fontsize="24" flexiblewidth="12" />
    </hlayout>
</vlayout>
					]],
                    health = 2,
                    isGuard = false
                }
            )
        }
    )
end


local function viking_boss_bogmær_carddef()
    local card_name = "viking_boss_bogmær"
	
    return createChampionDef(
        {
            id = "viking_boss_bogmær",
            name = "Bogmær",
			types = { championType, eliteMinionType, nostealType},
            acquireCost = 0,
            health = 2,
            isGuard = false,
            abilities = {
                createAbility(
                    {
                        id = "bogmær_main",
                        trigger = autoTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = hitOpponentEffect(2)
						
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Bogmær",
                    art = "art/epicart/keira__wolf_caller",
                    frame = "frames/barbarian_frames/barbarian_champion_cardframe",
                    xmlText=[[
<vlayout>
<hlayout flexibleheight="1">       
<tmpro text="Elite" fontsize="16"  flexiblewidth="14" />  </hlayout>
  <hlayout flexibleheight="3">
            <tmpro text="{expend}" fontsize="50" flexiblewidth="2"/>
            <tmpro text="Deal 2 damage to your opponent." fontsize="24" flexiblewidth="12" />
    </hlayout>
</vlayout>
					]],
                    health = 2,
                    isGuard = false
                }
            )
        }
    )
end


local function viking_boss_valkyrie1_token_carddef()
    local card_name = "viking_boss_valkyrie1_token"
	
    return createChampionDef(
        {
            id = "viking_boss_valkyrie1_token",
            name = "Valkyrie",
			types = {championType, eliteMinionType, noStealType, tokenType},
            acquireCost = 0,
            health = 4,
            isGuard = false,
            abilities = {
                createAbility(
                    {
                        id = "valkyrie1_token_main",
                        trigger = autoTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = gainCombatEffect(3)
						
                    }
                ),
					
				--self sac ability
				createAbility(
                    {
                        id = "viking_boss_valkyrie1_token_sac",
                        trigger = onLeavePlayTrigger,
                        cost = sacrificeSelfCost,
                        activations = singleActivations,
                        effect = nullEffect()
					}	
                    
                )
            },
			
            layout = createLayout(
                {
                    name = "Valkyrie",
                    art = "art/epicart/angel_of_mercy",
                    frame = "frames/barbarian_frames/barbarian_champion_cardframe",
                    xmlText=[[
<vlayout>
       <hlayout flexibleheight="1">       
<tmpro text="Elite" fontsize="16"  flexiblewidth="14" />
    </hlayout> 

<hlayout flexibleheight="4">
            <tmpro text="{expend}" fontsize="40" flexiblewidth="2"/>
            <tmpro text="{combat_3}" fontsize="40" flexiblewidth="12" />
    </hlayout>
</vlayout>
					]],
                    health = 4,
                    isGuard = false
                }
            )
        }
    )
end

local function viking_boss_valkyrie2_token_carddef()
    local card_name = "viking_boss_valkyrie2_token"
	
    return createChampionDef(
        {
            id = "viking_boss_valkyrie2_token",
            name = "Valkyrie",
			types = {championType, eliteMinionType, noStealType, tokenType},
            acquireCost = 0,
            health = 4,
            isGuard = true,
            abilities = {
                createAbility(
                    {
                        id = "valkyrie2_token_main",
                        trigger = autoTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = gainCombatEffect(3)
						
                    }
                ),
					
				--self sac ability
				createAbility(
                    {
                        id = "viking_boss_valkyrie2_token_sac",
                        trigger = onLeavePlayTrigger,
                        cost = sacrificeSelfCost,
                        activations = singleActivations,
                        effect = nullEffect()
					}	
                    
                )
            },
			
            layout = createLayout(
                {
                    name = "Valkyrie",
                    art = "art/epicart/angelic_protector",
                    frame = "frames/barbarian_frames/barbarian_champion_cardframe",
                    xmlText=[[
<vlayout>
       <hlayout flexibleheight="1">       
<tmpro text="Elite" fontsize="16"  flexiblewidth="14" />
    </hlayout> 

<hlayout flexibleheight="4">
            <tmpro text="{expend}" fontsize="40" flexiblewidth="2"/>
            <tmpro text="{combat_3}" fontsize="40" flexiblewidth="12" />
    </hlayout>
</vlayout>
					]],
                    health = 4,
                    isGuard = true
                }
            )
        }
    )
end


---- game setup
function setupGame(g)

    standardSetup(g, {
        description = "Vikings Co-op. Created by Aarkenell 09/06/2025. Updated 01/09/2025",
        ai = createCoopAi(),
        timeoutAi = createTimeoutAi(),
        playerOrder = { plid3, plid1, plid4, plid2 },
        opponents = { { plid1, plid3 }, { plid2, plid4 }},
        players = {
            {
                id = plid1,
                canAttackAllyOppChampions = true,
                init = { 
                    fromEnv = plid1
                },
                avatar = "cleric_01",
                cards = {
                    buffs = {
                        drawCardsCountAtTurnEndDef(5),
                        discardCardsAtTurnStartDef(),
						
                    }
                }
            },
            {
                id = plid2,
                canAttackAllyOppChampions = true,
                startDraw = 5,
                init = {
                    fromEnv = plid2
                },
                avatar = "fighter_01",
                cards = {
                    buffs = {
                        drawCardsCountAtTurnEndDef(5),
                        discardCardsAtTurnStartDef(),
						

                    }
                }
            },
            {
                id = plid3,
                isAi = true,
                name = "Vikings",
                syncHealth = true,
                startDraw = 3,
                avatar = "Barbarian_01",
                health = 100,
                cards = {
                    deck = {
							{qty = 2, card = dagger_carddef()},
							{qty = 2, card = shortsword_carddef()},
							{qty = 4, card = barbarian_hand_axe_carddef()},
							{qty = 2, card = viking_boss_huskarl_carddef()},
							
							{qty = 5, card = viking_boss_karl_carddef()},

							{qty = 2, card = viking_boss_berserker_elite_carddef()},
							{qty = 2, card = viking_boss_axe_maker_carddef()},
							{qty = 4, card = viking_boss_mead_carddef()},
							{qty = 2, card = viking_boss_bogmær_carddef()},

                    },
                    skills = {
                    },
                    buffs = {
                        bossMoveCardsAtTurnEndDef(),
                        shareDiscardsAtTurnStartDef(),
                        drawCardsCountAtTurnEndDef(5),
                        discardCardsAtTurnStartDef(),
                        aiTurnBuffDef(),
						vikingSetupBuffDef(),
						hitHardbuff
						

                    }
                }
            },
            {
                id = plid4,
                isAi = true,
                name = "Vikings",
                syncHealth = true,
                startDraw = 0,
                avatar="Barbarian_01",
                health = 100,
                cards = {
                    skills = {
                    },
                    buffs = {
                        bossMoveCardsAtTurnEndDef(),
                        shareDiscardsAtTurnStartDef(),
                        drawCardsCountAtTurnEndDef(5),
                        discardCardsAtTurnStartDef(),
                        aiTurnBuffDef(),
						hitHardbuff
						

                    }
                }
            }
        }
    })
end

-- buffs
function summon_axe_maker_BuffDef()

	
		local ef_Summon_AM = showSpeechBubbleEffect({
								playerExpression=currentPid,
								text="Get back here and hand me some axes!!",
								waitForClick= constBoolExpression(false)
							})
				.seq(moveTarget(inPlayPloc).apply(selectLoc(loc(ownerPid, discardPloc)).where(isCardName('viking_boss_axe_maker')).take(1)))
				.seq(addSlotToTarget(createNoAttackSlot({ startOfOwnerTurnExpiry, leavesPlayExpiry })).apply(selectLoc(loc(ownerPid, inPlayPloc)).where(isCardName('viking_boss_axe_maker'))))	
				.seq(createCardEffect(fighter_runic_throwing_axe_carddef(), loc(currentPid, handPloc)))
				.seq(createCardEffect(fighter_runic_throwing_axe_carddef(), loc(currentPid, deckPloc)))
				.seq(createCardEffect(fighter_runic_throwing_axe_carddef(), loc(currentPid, deckPloc)))
				.seq(shuffleEffect(currentDeckLoc))
				.seq(sacrificeTarget().apply(selectLoc(loc(nextAllyPid, buffsPloc)).where(isCardName("summon_axe_maker_buff"))))
				.seq(sacrificeTarget().apply(selectLoc(loc(currentPid, buffsPloc)).where(isCardName("summon_axe_maker_buff"))))
	
return createGlobalBuff({
        id="summon_axe_maker_buff",
        name = "Get Some Axes",
        abilities = {
            createAbility({
                id="summon_axe_maker_effect",
                trigger = startOfTurnTrigger,
				check = selectLoc(currentDiscardLoc).where(isCardName('viking_boss_axe_maker')).count().gte(1),
                effect = ifElseEffect(getPlayerHealth(currentPid).lte(65), ef_Summon_AM, nullEffect()),
				cost = noCost
				
            })
        },
		--[[buffDetails = createBuffDetails({
					name = "",
                    art = "",
					text = ""
							})
							]]
    })
end

function plunderstruck_0_skill_def()

	
	local cardLayout = createLayout({
		name = "Plunderstruck",
		art = "art/treasures/barbarian_pillage",
		xmlText = [[
			<hlayout>
				<vlayout>
					<icon text="Acquire a card of cost 3 or less for free." fontsize="20" flexibleheight="2"/>
					</vlayout>
			</hlayout>
		]]
	})

	return createSkillDef({
		id = "plunderstruck_0_custom",
		name = "Plunderstruck",
		cardTypeLabel = "Skill",
		types = { skillType },
        abilities = {
			createAbility({
				id = "godofplunderActivate",
				trigger = uiTrigger,
				activations = singleActivations,
				effect = pushTargetedEffect({
							desc = "Acquire a card of cost three or less for free.",
							validTargets = selectLoc(centerRowLoc).where(isCardAcquirable().And(getCardCost().lte(3))),
							min = 1,
							max = 1,
							targetEffect = moveTarget(loc(currentPid, discardPloc)),
							}),
				
				layout = layoutCard(
									{
									title = "Plunderstruck",
									art = "art/epicart/ceasefire",

									xmlText=[[

									<vlayout>
									<hlayout flexibleheight="1.8">

									<vlayout flexiblewidth="7">
									<box flexibleheight="2">
									<tmpro text="Acquire a card of cost 3 or less for free." fontsize="26" />
									</box>
									</vlayout>
									</hlayout>

									</vlayout>
									]]
									}
                                            ),
				promptType = showPrompt,
				cost = noCost
			})
		},
		cardEffectAbilities = {},
		layout = cardLayout,
		layoutPath= "art/treasures/barbarian_pillage"
	})
end

function plunderstruck_0_upgrade_skill_def()

	
	local cardLayout = createLayout({
		name = "Plunderstruck",
		art = "art/treasures/barbarian_pillage",
		xmlText = [[
			<hlayout>
				<vlayout>
					<icon text="Acquire a card of cost 6 or less for free." fontsize="20" flexibleheight="2"/>
					</vlayout>
			</hlayout>
		]]
	})

	return createSkillDef({
		id = "plunderstruck_0_upgrade_custom",
		name = "Plunderstruck",
		cardTypeLabel = "Skill",
		types = { skillType },
        abilities = {
			createAbility({
				id = "godofplunderActivate",
				trigger = uiTrigger,
				activations = singleActivations,
				effect = pushTargetedEffect({
							desc = "Acquire a card of cost six or less for free.",
							validTargets = selectLoc(centerRowLoc).where(isCardAcquirable().And(getCardCost().lte(6))),
							min = 1,
							max = 1,
							targetEffect = moveTarget(loc(currentPid, discardPloc)),
							}),
				
				layout = layoutCard(
									{
									title = "Splintered Thandar",
									art = "art/epicart/ceasefire",
									xmlText=[[

									<vlayout>
									<hlayout flexibleheight="1.8">

									<vlayout flexiblewidth="7">
									<box flexibleheight="2">
									<tmpro text="Acquire a card of cost 6 or less for free." fontsize="26" />
									</box>
									</vlayout>
									</hlayout>

									</vlayout>
									]]
									}
                                            ),
				promptType = showPrompt,
				cost = noCost
			})
		},
		cardEffectAbilities = {},
		layout = cardLayout,
		layoutPath= "art/treasures/barbarian_pillage"
	})
end

function plunderstruck_0_upgrade_BuffDef()


return createGlobalBuff({
        id="plunderstruck_0_upgrade_buff",
        name = "Plunderstruck Upgrade",
        abilities = {
            createAbility({
                id="plunderstruck_0_upgrade_effect",
                trigger = deckShuffledTrigger,
				check = getTurnsPlayed(currentPid).gte(5),
                effect = showSpeechBubbleEffect({
								playerExpression=currentPid,
								text="Plunder!",
								waitForClick=constBoolExpression(false)
							})
							.seq(showSpeechBubbleEffect({
								playerExpression=currentPid,
								text="Ah-aaah, ah-aaah, aaah-aaah! Plunder!",
								waitForClick=constBoolExpression(false)
							}))
							
				.seq(sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("plunderstruck_0_custom"))))
				.seq(createCardEffect(plunderstruck_0_upgrade_skill_def(), currentSkillsLoc))
				.seq(sacrificeTarget().apply(selectLoc(loc(nextAllyPid, skillsPloc)).where(isCardName("plunderstruck_0_custom"))))
				.seq(createCardEffect(plunderstruck_0_upgrade_skill_def(), loc(nextAllyPid, skillsPloc)))
				.seq(sacrificeTarget().apply(selectLoc(loc(currentPid, buffsPloc)).where(isCardName("plunderstruck_0_upgrade_buff"))))
				.seq(waitForClickEffect("The Vikings can now plunder one card up to cost six each turn.")),
				cost = sacrificeSelfCost
				
            })
        },

    })
end



function plunderstruck_skill_def()

	
	local cardLayout = createLayout({
		name = "Plunderstruck",
		art = "art/treasures/barbarian_pillage",
		xmlText = [[
			<hlayout>
				<vlayout>
					<icon text="Acquire a card of cost 4 or less for free." fontsize="20" flexibleheight="2"/>
					</vlayout>
			</hlayout>
		]]
	})

	return createSkillDef({
		id = "plunderstruck_custom",
		name = "Plunderstruck",
		cardTypeLabel = "Skill",
		types = { skillType },
        abilities = {
			createAbility({
				id = "godofplunderActivate",
				trigger = uiTrigger,
				activations = singleActivations,
				effect = pushTargetedEffect({
							desc = "Acquire a card of cost four or less for free.",
							validTargets = selectLoc(centerRowLoc).where(isCardAcquirable().And(getCardCost().lte(4))),
							min = 1,
							max = 1,
							targetEffect = moveTarget(loc(currentPid, discardPloc)),
							}),
				
				layout = layoutCard(
									{
									title = "Splintered Thandar",
									art = "art/epicart/ceasefire",
									--pillage = Acquire a card for free. If it cost 3 or less put it into your hand. Draw 1.
									xmlText=[[

									<vlayout>
									<hlayout flexibleheight="1.8">

									<vlayout flexiblewidth="7">
									<box flexibleheight="2">
									<tmpro text="Acquire a card of cost 4 or less for free." fontsize="26" />
									</box>
									</vlayout>
									</hlayout>

									</vlayout>
									]]
									}
                                            ),
				promptType = showPrompt,
				cost = noCost
			})
		},
		cardEffectAbilities = {},
		layout = cardLayout,
		layoutPath= "art/treasures/barbarian_pillage"
	})
end

function plunderstruck_upgrade_skill_def()
	
	local cardLayout = createLayout({
		name = "Plunderstruck",
		art = "art/treasures/barbarian_pillage",
		xmlText = [[
			<hlayout>
				<vlayout>
					<icon text="Acquire a card for free." fontsize="20" flexibleheight="2"/>
					</vlayout>
			</hlayout>
		]]
	})

	return createSkillDef({
		id = "plunderstruck_upgrade_custom",
		name = "Plunderstruck",
		cardTypeLabel = "Skill",
		types = { skillType },
        abilities = {
			createAbility({
				id = "godofplunderActivate",
				trigger = uiTrigger,
				activations = singleActivations,
				effect = acquireForFreeTarget().apply(selectLoc(centerRowLoc).where(isCardAcquirable()).order(getCardCost()).reverse().take(1)),
				
				layout = layoutCard(
									{
									title = "Splintered Thandar",
									art = "art/epicart/ceasefire",
									xmlText=[[

									<vlayout>
									<hlayout flexibleheight="1.8">

									<vlayout flexiblewidth="7">
									<box flexibleheight="2">
									<tmpro text="Acquire a card for free." fontsize="26" />
									</box>
									</vlayout>
									</hlayout>

									</vlayout>
									]]
									}
                                            ),
				promptType = showPrompt,
				cost = noCost
			})
		},
		cardEffectAbilities = {},
		layout = cardLayout,
		layoutPath= "art/treasures/barbarian_pillage"
	})
end

function plunderstruck_upgrade_BuffDef()


return createGlobalBuff({
        id="plunderstruck_upgrade_buff",
        name = "Plunderstruck Upgrade",
        abilities = {
            createAbility({
                id="plunderstruck_upgrade_effect",
                trigger = deckShuffledTrigger,
				check = getTurnsPlayed(currentPid).gte(4),
                effect = showSpeechBubbleEffect({
								playerExpression=currentPid,
								text="Plunder!",
								waitForClick=constBoolExpression(false)
							})
							.seq(showSpeechBubbleEffect({
								playerExpression=currentPid,
								text="Ah-ah, ah-ah, aaaaah! Plunder!",
								waitForClick=constBoolExpression(false)
							}))
							
				.seq(sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("plunderstruck_custom"))))
				.seq(createCardEffect(plunderstruck_upgrade_skill_def(), currentSkillsLoc))
				.seq(sacrificeTarget().apply(selectLoc(loc(nextAllyPid, skillsPloc)).where(isCardName("plunderstruck_custom"))))
				.seq(createCardEffect(plunderstruck_upgrade_skill_def(), loc(nextAllyPid, skillsPloc)))
				.seq(sacrificeTarget().apply(selectLoc(loc(nextAllyPid, buffsPloc)).where(isCardName("plunderstruck_upgrade_buff"))))
				.seq(waitForClickEffect("The Vikings can now plunder one card of any cost each turn.")),
				cost = sacrificeSelfCost
				
            })
        },

    })
end

function shields_a_buff_def()
  

	local ef_Shields1 = showSpeechBubbleEffect({
								playerExpression=oppPid,
								text="Shields!!",
								waitForClick= constBoolExpression(false)
							})
		.seq(createCardEffect(vikings_shield_token_carddef(), loc(oppPid, inPlayPloc)))

	local ef_Shields2 = showSpeechBubbleEffect({
								playerExpression=oppPid,
								text="Arrgh!!",
								waitForClick= constBoolExpression(false)
							})
		.seq(hitSelfEffect(2))
	
	local ef_Shields0 = randomEffect({
					valueItem(2, ef_Shields1),
					valueItem(1, ef_Shields2),
				})
		
					
return createGlobalBuff({
        id="shields_buff_buff",
        name = "Hit Hard",
        abilities = {
            createAbility({
                id="shields_buff_effect",
                trigger = endOfTurnTrigger,
                effect = ifElseEffect(getPlayerDamageReceivedThisTurn(oppPid).gte(10), ef_Shields0, nullEffect()),
				cost = noCost
				
            })
        },

    })
end

function shields_buff_def()
 

	local ef_Shields1 = showSpeechBubbleEffect({
								playerExpression=oppPid,
								text="Shields!!",
								waitForClick= constBoolExpression(false)
							})
		.seq(createCardEffect(vikings_shield_token_carddef(), loc(oppPid, inPlayPloc)))
		.seq(createCardEffect(vikings_shield_token_carddef(), loc(oppPid, inPlayPloc)))

	local ef_Shields2 = showSpeechBubbleEffect({
								playerExpression=oppPid,
								text="Arrgh!!",
								waitForClick= constBoolExpression(false)
							})
		.seq(hitSelfEffect(4))
	
	local ef_Shields0 = randomEffect({
					valueItem(2, ef_Shields1),
					valueItem(1, ef_Shields2),
				})
		
					
return createGlobalBuff({
        id="shields_buff_buff",
        name = "Hit Hard",
        abilities = {
            createAbility({
                id="shields_buff_effect",
                trigger = endOfTurnTrigger,
                effect = ifElseEffect(getPlayerDamageReceivedThisTurn(oppPid).gte(10), ef_Shields0, nullEffect()),
				cost = noCost
				
            })
        },

    })
end

function thors_blessing_skill_def()

	
	local cardLayout = createLayout({
		name = "Thor's Blessing",
		art = "art/treasures/fighter_lightning_longsword",
		xmlText = [[
			<hlayout>
<vlayout>
	<icon text="Return your Lightning Sword to your hand at the end of each turn." fontsize="20" flexibleheight="2"/>
</vlayout>
</hlayout>
		]]
	})

	return createSkillDef({
		id = "thors_blessing_custom",
		name = "Thor's blessing",
		abilities = {
            createAbility({
                id="thors_blessing_skill",
                trigger = endOfTurnTrigger,
                effect = moveTarget(loc(nextAllyPid, handPloc)).apply(selectLoc(loc(currentPid, discardPloc)).where(isCardName("fighter_lightning_longsword"))),
				cost = noCost
				
            })
        },
		cardTypeLabel = "Skill",
		types = { skillType },

		layout = cardLayout,
		layoutPath= "art/treasures/fighter_lightning_longsword"
	})
end

--[[function thors_blessing_return_BuffDef()
    local buff_name = "thors_blessing_return_buff"
	
return createGlobalBuff({
        id="thors_blessing_return_buff",
        name = "Thor's Blessing Return",
        abilities = {
            createAbility({
                id="thors_blessing_return_effect",
                trigger = endOfTurnTrigger,
                effect = moveTarget(loc(nextAllyPid, handPloc)).apply(selectLoc(loc(currentPid, discardPloc)).where(isCardName("fighter_lightning_longsword"))),
				cost = noCost
				
            })
        },

    })
end]]

function thors_blessing_BuffDef()
	
return createGlobalBuff({
        id="thors_blessing_buff",
        name = "Thor's Blessing",
        abilities = {
            createAbility({
                id="thors_blessing_effect",
                trigger = startOfTurnTrigger,
				check = getPlayerHealth(currentPid).lte(40),
                effect = showSpeechBubbleEffect({
								playerExpression=currentPid,
								text="Thor watches over us!",
								waitForClick= constBoolExpression(false)
							})
				.seq(createCardEffect(fighter_lightning_longsword_carddef(), loc(currentPid, handPloc)))
				.seq(sacrificeTarget().apply(selectLoc(loc(nextAllyPid, skillsPloc)).where(isCardName("thors_blessing_buff"))))
				.seq(waitForClickEffect("Thor's Lightning Sword will return to the Viking's hand each turn."))
				.seq(createCardEffect(thors_blessing_skill_def(), loc(currentPid, skillsPloc)))
				.seq(createCardEffect(thors_blessing_skill_def(), loc(nextAllyPid, skillsPloc)))
				.seq(sacrificeTarget().apply(selectLoc(loc(nextAllyPid, buffsPloc)).where(isCardName("thors_blessing_buff")))),
				cost = sacrificeSelfCost
				
            })
        },
	--[[buffDetails = createBuffDetails({
					name = "Thor's Blessing",
                    art = "art/treasures/fighter_lightning_longsword",
					text = "Return your Lightning Sword to your hand at the end of each turn."
							})
		]]
    })
end

function flamesword_BuffDef()
	
		local ef_flame_sword = showSpeechBubbleEffect({
								playerExpression=currentPid,
								text="What are these foul creatures?",
								waitForClick= constBoolExpression(false)
							})
				.seq(showSpeechBubbleEffect({
								playerExpression=currentPid,
								text="Let's see how they handle a flame.",
								waitForClick= constBoolExpression(false)
							}))
				.seq(transformTarget("fighter_flaming_longsword").apply(selectLoc(loc(currentPid, handPloc)).union(selectLoc(loc(currentPid, deckPloc))).union(selectLoc(loc(currentPid, discardPloc))).where(isCardName("shortsword"))))
				.seq(waitForClickEffect("All the Viking's swords are now Flaming Longswords."))
				.seq(sacrificeTarget().apply(selectLoc(loc(nextAllyPid, skillsPloc)).where(isCardName("flamesword_custom"))))
				.seq(sacrificeSelf())
	
return createGlobalBuff({
        id="flamesword_buff",
        name = "Flame Sword Buff",
        abilities = {
            createAbility({
                id="flamesword_effect",
                trigger = startOfTurnTrigger,
				effect = ifElseEffect(selectLoc(loc(oppPid, inPlayPloc)).where(isCardType(tokenType).Or(isCardType(woodlandType))).count().gte(3), ef_flame_sword, nullEffect()),
				cost = noCost
				
            })
        },

    })
end

function last_stand_BuffDef()
	
return createGlobalBuff({
        id="last_stand_buff",
        name = "Last stand",
        abilities = {
            createAbility({
                id="last_stand_effect",
                trigger = startOfTurnTrigger,
				check = getPlayerHealth(currentPid).lte(20),
                effect = showSpeechBubbleEffect({
								playerExpression=currentPid,
								text="Til Valhalla!",
								waitForClick= constBoolExpression(false)
							})
				.seq(createCardEffect(viking_boss_valkyrie1_token_carddef(), loc(currentPid, inPlayPloc)))
				.seq(createCardEffect(viking_boss_valkyrie2_token_carddef(), loc(currentPid, inPlayPloc))).seq(createCardEffect(viking_boss_berserker_token_carddef(), loc(currentPid, inPlayPloc)))
				.seq(addSlotToTarget(createNoAttackSlot({ startOfOwnerTurnExpiry, startOfTurnExpiry })).apply(selectLoc(loc(ownerPid, inPlayPloc)).where(isCardName('viking_boss_valkyrie1_token'))))
				.seq(addSlotToTarget(createNoAttackSlot({ startOfOwnerTurnExpiry, startOfTurnExpiry })).apply(selectLoc(loc(ownerPid, inPlayPloc)).where(isCardName('viking_boss_berserker_token'))))	
				.seq(sacrificeTarget().apply(selectLoc(loc(nextAllyPid, buffsPloc)).where(isCardName("last_stand_buff")))),
				cost = sacrificeSelfCost
				
            })
        },

    })
end

function last_stand2_BuffDef()
	
return createGlobalBuff({
        id="last_stand2_buff",
        name = "Last stand...again",
        abilities = {
            createAbility({
                id="last_stand2_effect",
                trigger = onZeroHealthTrigger,
                effect = showSpeechBubbleEffect({
								playerExpression=currentPid,
								text="Soon I will drink with Odin.",
								waitForClick= constBoolExpression(false)
							})
							.seq(showSpeechBubbleEffect({
								playerExpression=currentPid,
								text="But not yet... Not yet.",
								waitForClick= constBoolExpression(false)
							}))
							.seq(gainMaxHealthEffect(ownerPid, const(5).add(getPlayerMaxHealth(ownerPid).negate()))).seq(healPlayerEffect(ownerPid, 5))
							.gainToughnessEffect(10)
					
				.seq(sacrificeTarget().apply(selectLoc(loc(nextAllyPid, buffsPloc)).where(isCardName("last_stand2_buff")))),
				cost = sacrificeSelfCost
				
            })
        },

    })
end



function endGame(g)
end


            function setupMeta(meta)
                meta.name = "Vikings - Co-op"
                meta.minLevel = 0
                meta.maxLevel = 0
                meta.introbackground = ""
                meta.introheader = ""
                meta.introdescription = ""
                meta.path = "C:/Users/aaron/OneDrive/Documents/Aaron/Hero Realms/Lua/Vikings - Co-op.lua"
                meta.features = {
}

            end
			
			function setupCoopIntro(encounter)
        encounter.name = "Vikings - Co-op"
        encounter.description = "Created by Aarkenell"
        encounter.minlevel = 1
        encounter.maxlevel = 24
        encounter.avatar = "avatars/WarInTheWild/droga__guild_enforcer"
        encounter.heroname = "Vikings"
        encounter.backgroundPath = "scenariointrobackgrounds/smuggling_operation"
        encounter.features = {
            encounter.feature("avatars/warinthewild/droga__guild_enforcer", "I was caught, In the middle of a Thandarian track. (Plunder). I looked 'round, And I knew there was no turning back. (Plunder) My mind raced, And I thought, 'What could I do?' (Plunder)"),
            encounter.feature("avatars/smugglers", "And I knew, there was no help, no help from you. (Plunder) Sound of the drums. Beating in my heart. The plunder of gems. Tore me apart. You've been... Plunderstruck."),
            encounter.feature("avatars/cristov_s_recruits", "The Vikings are coming to Plunder the city. Repel them. But don't hit them too hard. And watch out for assistance from their gods and legendary Valkyrie.")
        }
end



