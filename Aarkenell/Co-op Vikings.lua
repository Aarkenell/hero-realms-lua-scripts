require "herorealms"
require "decks"
require "stdlib"
require "stdcards"
require "hardai"
require "mediumai"
require "easyai"

isCoop = true

broadsidesType = "Broadsides"
marauderType = "Marauder"

--add cards here


local function viking_boss_berserker_elite_carddef()
    local card_name = "viking_boss_berserker_elite"
	
    return createChampionDef(
        {
            id = "viking_boss_berserker_elite",
            name = "Berserker Elite",
			types = {championType, nosteaalType},
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
                        effect = createCardEffect(viking_boss_berserker_token_carddef(), loc(controllerPid, inPlayPloc))
						.seq(createCardEffect(viking_boss_berserker_token_carddef(), loc(controllerPid, inPlayPloc)))
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
            <tmpro text="When played, put 2 Berserkers tokens in play." fontsize="12"  flexiblewidth="14" />
    </hlayout> 
<divider/>
<hlayout flexibleheight="3">
            <tmpro text="{expend}" fontsize="40" flexiblewidth="2"/>
            <tmpro text="{combat_4}
&lt;size=40%&gt;You count as Berserk this turn.
-2{shield} at the end of turn." fontsize="44" flexiblewidth="12" />
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

function viking_boss_berserker_token_carddef()
    local card_name = "viking_boss_berserker_token"
	
    return createChampionDef(
        {
            id = "viking_boss_berserker_token",
            name = "Berserker",
			types = {championType, nosteaalType, tokenType},
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

local function viking_boss_huskarl_carddef()
    local card_name = "viking_boss_huskarl"
	
    return createChampionDef(
        {
            id = "viking_boss_huskarl",
            name = "Huskarl",
			types = {championType, nosteaalType},
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
    <hlayout flexibleheight="3">
            <tmpro text="{expend}" fontsize="50" flexiblewidth="2"/>
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
			types = {championType, nosteaalType},
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
    <hlayout flexibleheight="3">
            <tmpro text="{expend}" fontsize="50" flexiblewidth="2"/>
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
			types = { championType,nosteaalType},
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

local function summon_axe_maker_BuffDef()
    local buff_name = "summon_axe_maker_buff"
	
return createGlobalBuff({
        id="summon_axe_maker_buff",
        name = "Get Some Axes",
        abilities = {
            createAbility({
                id="summon_axe_maker_effect",
                trigger = startOfTurnTrigger,
				condition = selectLoc(currentDiscardLoc).where(isCardName('viking_boss_axe_maker')).count().gte(1),
				check = getPlayerHealth(currentPid).lte(30),
                effect = showSpeechBubbleEffect({
								playerExpression=currentPid,
								text="Get back here and hand me some axes!!",
								waitForClick= constBoolExpression(false)
							})
				.seq(moveTarget(inPlayPloc).apply(selectLoc(loc(ownerPid, discardPloc)).where(isCardName('viking_boss_axe_maker')).take(1)))
				.seq(addSlotToTarget(createNoAttackSlot({ startOfOwnerTurnExpiry, leavesPlayExpiry })).apply(selectLoc(loc(ownerPid, inPlayPloc)).where(isCardName('viking_boss_axe_maker'))))	
				.seq(createCardEffect(fighter_runic_throwing_axe_carddef(), loc(currentPid, handPloc))),
				cost = sacrificeSelfCost
				
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

local function viking_boss_bogmær_carddef()
    local card_name = "viking_boss_bogmær"
	
    return createChampionDef(
        {
            id = "viking_boss_bogmær",
            name = "Bogmær",
			types = { championType,nosteaalType},
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

local function god_of_plunder_skill_def()
    local card_name = "god_of_plunder_custom"
	
	local cardLayout = createLayout({
		name = "God of Plunder",
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
		id = "god_of_plunder_custom",
		name = "God of Plunder",
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

local function god_of_plunder_upgrade_skill_def()
    local card_name = "god_of_plunder_upgrade_custom"
	
	local cardLayout = createLayout({
		name = "God of Plunder",
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
		id = "god_of_plunder_upgrade_custom",
		name = "God of Plunder",
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

local function god_of_plunder_upgrade_BuffDef()
    local buff_name = "god_of_plunder_upgrade_buff"

return createGlobalBuff({
        id="god_of_plunder_upgrade_buff",
        name = "God of Plunder Upgrade",
        abilities = {
            createAbility({
                id="god_of_plunder_upgrade_effect",
                trigger = deckShuffledTrigger,
				--check = selectLoc(oppDiscardLoc).sum(getCardCost()).gte(16),
				condition = getTurnsPlayed(currentPid).gte(7),
                effect = showSpeechBubbleEffect({
								playerExpression=currentPid,
								text="Plunder!",
								waitForClick=constBoolExpression(false)
							})
							.seq(showSpeechBubbleEffect({
								playerExpression=currentPid,
								text="Nah nah nah nah nah nah nah nah nah.",
								waitForClick=constBoolExpression(false)
							}))
							.seq(showSpeechBubbleEffect({
								playerExpression=currentPid,
								text="Plunder!",
								waitForClick=constBoolExpression(false)
							}))							
				.seq(sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("god_of_plunder_custom"))))
				.seq(createCardEffect(god_of_plunder_upgrade_skill_def(), currentSkillsLoc))
				.seq(waitForClickEffect("The Vikings can now plunder one card of any cost each turn.")),
				cost = sacrificeSelfCost
				
            })
        },

    })
end

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

function setupGame(g)

    standardSetup(
        g,
        {
            description = "Vikings Co-op. Created by Aarkenell 18/04/2025.",
            ai = createCoopAi(),
			timeoutAi = createTimeoutAi(),
			playerOrder = { plid3, plid1, plid4, plid2 },
			opponents = { { plid1, plid3 }, { plid2, plid4 }},
            players = {
                {
                id = plid1,
				canAttackAllyOppChampions = true,
                startDraw = 5,
                init = {
                    fromEnv = plid1
                },
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
                health = 80,
                cards = {
                        reserve = {
						},
						hand = {
							--30 card deck
							{qty = 1, card = viking_boss_huskarl_carddef()},
							{qty = 1, card = viking_boss_berserker_elite_carddef()},
							{qty = 2, card = viking_boss_karl_carddef()},
							{qty = 1, card = viking_boss_mead_carddef()},
							
						},
						deck = {


					--[[30 card deck
							{qty = 4, card = shortsword_carddef()},
							{qty = 4, card = barbarian_hand_axe_carddef()},
							{qty = 2, card = viking_boss_huskarl_carddef()},
							
							{qty = 5, card = viking_boss_karl_carddef()},

							{qty = 2, card = viking_boss_berserker_elite_carddef()},
							{qty = 2, card = viking_boss_axe_maker_carddef()},
							{qty = 4, card = viking_boss_mead_carddef()},
							{qty = 2, card = viking_boss_bogmær_carddef()},
							]]
					
					--20 card deck
							{qty = 0, card = shortsword_carddef()},
							{qty = 3, card = barbarian_hand_axe_carddef()},
							{qty = 2, card = viking_boss_huskarl_carddef()},
							
							{qty = 4, card = viking_boss_karl_carddef()},

							{qty = 1, card = viking_boss_berserker_elite_carddef()},
							{qty = 1, card = viking_boss_axe_maker_carddef()},
							{qty = 3, card = viking_boss_mead_carddef()},
							{qty = 1, card = viking_boss_bogmær_carddef()},
							
                        },
                        skills = {
                        {qty = 1, card = god_of_plunder_skill_def()},
						
                        },
                        buffs = {
                            drawCardsCountAtTurnEndDef(5),
                            discardCardsAtTurnStartDef(),
							--summon_axe_maker_BuffDef(),
							--god_of_plunder_upgrade_BuffDef(),
							bossMoveCardsAtTurnEndDef(),
							shareDiscardsAtTurnStartDef(),
							aiTurnBuffDef(),
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
                health = 80,
                cards = {
                    skills =
						{qty = 1, card = god_of_plunder_skill_def()},
                    buffs = {
                        bossMoveCardsAtTurnEndDef(),
                        shareDiscardsAtTurnStartDef(),
                        drawCardsCountAtTurnEndDef(5),
                        discardCardsAtTurnStartDef(),
                        aiTurnBuffDef(),
						--summon_axe_maker_BuffDef(),
						--god_of_plunder_upgrade_BuffDef()
                    }
                }
            }
 
            }
        }
    )
end

function endGame(g)
end


            function setupMeta(meta)
                meta.name = "Co-op Vikings"
                meta.minLevel = 0
                meta.maxLevel = 0
                meta.introbackground = ""
                meta.introheader = ""
                meta.introdescription = ""
                meta.path = "C:/Users/aaron/OneDrive/Documents/Aaron/Hero Realms/Lua/Co-op Vikings.lua"
                meta.features = {
}

            end