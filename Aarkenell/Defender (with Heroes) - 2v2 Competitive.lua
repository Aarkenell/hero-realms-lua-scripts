require 'herorealms'
require 'decks'
require 'stdlib'
require 'coopai'
require 'timeoutai'

-- need to fix combined health process

isCoop = false

-- zembu levels

		local ef4_zembu = sacrificeTarget().apply(selectLoc(loc(nextAllyPid, skillsPloc)).where(isCardName("thief_pickpocket")))
				.seq(createCardEffect(thief_swipe_carddef(), loc(nextAllyPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef5_zembu = sacrificeTarget().apply(selectLoc(loc(nextAllyPid, asidePloc)).where(isCardName("thief_throwing_knife")).take(1))
				.seq(createCardEffect(thief_keen_throwing_knife_carddef(), locloc(nextAllyPid, deckPloc)))
				.seq(sacrificeSelf())

		local ef6_zembu = sacrificeTarget().apply(selectLoc(loc(nextAllyPid, skillsPloc)).where(isCardName("thief_swipe")))
				.seq(createCardEffect(thief_lift_carddef(), loc(nextAllyPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef7_zembu = createCardEffect(thief_knife_belt_carddef(), loc(currentPid, asidePloc))
				.seq(sacrificeSelf())

		local ef8_zembu = sacrificeTarget().apply(selectLoc(loc(nextAllyPid, skillsPloc)).where(isCardName("thief_heist")))
				.seq(createCardEffect(thief_skillful_heist_carddef(), loc(nextAllyPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef9_zembu = createCardEffect(thief_shadow_mask_carddef(), loc(nextAllyPid, skillsPloc))
				.seq(sacrificeSelf())

		local ef10_zembu = sacrificeTarget().apply(selectLoc(loc(nextAllyPid, skillsPloc)).where(isCardName("thief_skillful_heist")))
				.seq(createCardEffect(thief_smooth_heist_carddef(), loc(nextAllyPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef11_zembu = createCardEffect(thief_blackjack_carddef(), loc(currentPid, asidePloc))
				.seq(sacrificeSelf())

		local ef12_zembu = gainMaxHealthEffect(currentPid, const(6))
				.seq(gainHealthEffect(6))
				.seq(sacrificeSelf())	

		local ef13_zembu = createCardEffect(thief_trick_dice_carddef(), loc(currentPid, reservePloc))
				.seq(sacrificeSelf())
		
		local ef14_zembu = gainMaxHealthEffect(currentPid, const(6))
				.seq(gainHealthEffect(6))
				.seq(sacrificeSelf())	
		
		local ef15_zembu = sacrificeTarget().apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("thief_ruby")))
				.seq(createCardEffect(thief_sharpened_ruby_carddef(), loc(nextAllyPid, deckPloc)))
				.seq(sacrificeSelf())
		
		local ef16_zembu = gainMaxHealthEffect(currentPid, const(6))
				.seq(gainHealthEffect(6))
				.seq(sacrificeSelf())
		
		local ef17_zembu = createCardEffect(thief_blinding_powder_carddef(), loc(currentPid, reservePloc))
				.seq(sacrificeSelf())

		local ef18_zembu = gainMaxHealthEffect(currentPid, const(6))
				.seq(gainHealthEffect(6))
				.seq(sacrificeSelf())	
				

	local ef_zembu = 
			setPlayerNameEffect("Kachiko", currentPid)
			.seq(setPlayerAvatarEffect("thief_alt_01", currentPid))
			.seq(gainMaxHealthEffect(currentPid, const(52)))
				.seq(gainHealthEffect(52))
			.seq(createCardEffect(thief_pickpocket_carddef(), nextAllySkillsLoc))
			.seq(createCardEffect(thief_heist_carddef(), nextAllySLoc))
			.seq(createCardEffect(gold_carddef(), locloc(nextAllyPid, deckPloc))) --here--
			.seq(createCardEffect(gold_carddef(), locloc(nextAllyPid, deckPloc)))
			.seq(createCardEffect(gold_carddef(), locloc(nextAllyPid, deckPloc)))
			.seq(createCardEffect(gold_carddef(), locloc(nextAllyPid, deckPloc)))
			.seq(createCardEffect(gold_carddef(), locloc(nextAllyPid, deckPloc)))
			.seq(createCardEffect(ruby_carddef(), locloc(nextAllyPid, deckPloc)))
			.seq(createCardEffect(ruby_carddef(), locloc(nextAllyPid, deckPloc)))
			.seq(createCardEffect(thief_throwing_knife_carddef(), locloc(nextAllyPid, deckPloc)))
			.seq(createCardEffect(thief_throwing_knife_carddef(), locloc(nextAllyPid, deckPloc)))
			.seq(createCardEffect(thief_throwing_knife_carddef(), locloc(nextAllyPid, deckPloc)))
			--[[.seq(ifElseEffect(getHeroLevel(oppPid).gte(4), ef4_zembu, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(oppPid).gte(5), ef5_zembu, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(oppPid).gte(6), ef6_zembu, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(oppPid).gte(7), ef7_zembu, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(oppPid).gte(8), ef8_zembu, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(oppPid).gte(9), ef9_zembu, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(oppPid).gte(10), ef10_zembu, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(oppPid).gte(11), ef11_zembu, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(oppPid).gte(12), ef12_zembu, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(oppPid).gte(13), ef13_zembu, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(oppPid).gte(14), ef14_zembu, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(oppPid).gte(15), ef15_zembu, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(oppPid).gte(16), ef16_zembu, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(oppPid).gte(17), ef17_zembu, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(oppPid).gte(18), ef18_zembu, nullEffect()))]]
			.seq(moveTarget(selectLoc(loc(nextAllyPid, deckPloc))).apply(selectLoc(loc(currentPid, asidePloc))))
			.seq(shuffleEffect(selectLoc(locloc(nextAllyPid, deckPloc))))
	
local function AI_1_hero_select_BuffDef()
    local buff_name = "ai_1_hero_select_buff"

return createGlobalBuff({
        id="ai_selector",
        name = "AI Selector",
        abilities = {
            createAbility({
                id="ai_selector",
                trigger = startOfGameTrigger,
				aiPriority = toIntExpression(300),
                effect = randomEffect({
					--valueItem(1, ef_ranger),
					--valueItem(1, ef_illegalas),
					--valueItem(1, ef_wizard),
					--valueItem(1, ef_cleric),
					--valueItem(1, ef_wardenslayer),
					valueItem(1, ef_zembu),
					
					})
					.seq(ifElseEffect(selectLoc(loc(nextAllyPid, buffsPloc)).where(isCardType(elfType)).count().gte(1),
                                drawCardsEffect(1),
                                drawCardsEffect(3)))
					.seq(sacrificeSelf()),
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


    local team1buff = createGlobalBuff({
        id="team1buff",
        name = "Team 1",
        abilities = {
            createAbility({
                id="Team 1",
				trigger = startOfGameTrigger,
                effect = nullEffect(),
				
            })
        },
		buffDetails = createBuffDetails({
					name = "Team 1",
                    art = "art/epicart/angel_of_the_gate",
					text = "You are paired with an AI Bot. If either of you fall, you lose."
							})
    })

    local team2buff = createGlobalBuff({
        id="team2buff",
        name = "Team 2",
        abilities = {
            createAbility({
                id="Team 2",
				trigger = startOfGameTrigger,
                effect = nullEffect(),
				
            })
        },
		buffDetails = createBuffDetails({
					name = "Team 2",
                    art = "art/epicart/anguish_demon",
					text = "You are paired with an AI Bot. If either of you fall, you lose."
							})
    })

    local team1AIbuff = createGlobalBuff({
        id="team1AIbuff",
        name = "Team 1",
        abilities = {
            createAbility({
                id="Team 1",
				trigger = startOfGameTrigger,
                effect = nullEffect(),
				
            })
        },
		buffDetails = createBuffDetails({
					name = "Team 1",
                    art = "art/epicart/angel_of_the_gate",
					text = "You are paired with a Human. If either of you fall, you lose."
							})
    })

    local team2AIbuff = createGlobalBuff({
        id="team1buff",
        name = "Team 2",
        abilities = {
            createAbility({
                id="Team 2",
				trigger = startOfGameTrigger,
                effect = nullEffect(),
				
            })
        },
		buffDetails = createBuffDetails({
					name = "Team 2",
                    art = "art/epicart/anguish_demon",
					text = "You are paired with a Human. If either of you fall, you lose."
							})
    })
	
local function share_card_2v2_skilldef()
    local card_name = "share_card_2v2"
	
    local cardLayout = createLayout({
        name = "Helping Hand",
        art = "art/epicart/arcane_research",
        frame = "frames/generic_cardframe",
        xmlText = 
		[[
<vlayout>
    <hlayout flexibleheight="3">
            <tmpro text="{expend_1}" fontsize="60" flexiblewidth="2"/>
            <tmpro text="Share a card with your Ally." fontsize="30" flexiblewidth="12" />
    </hlayout>

    <hlayout flexibleheight="1">
<tmpro text="Not useable on your first turn." fontsize="16" flexiblewidth="12" />
    </hlayout>
</vlayout>
		]]
    })

	return createSkillDef({
		id = "share_card_skill_2v2_skill",
        name = "Helping Hand",
		cardTypeLabel = "Skill",
        types = { skillType },

        abilities = {
            createAbility({
                id = "share_card_skill_2v2_skill",
                trigger = uiTrigger,
				check = getTurnsPlayed(currentPid).gte(2),
                activations = singleActivation,
                layout = cardLayout,
				promptType = showPrompt,
                effect = pushChoiceEffect(
                                {
                                    choices = {
                                        {
                                            effect = pushTargetedEffect({
												  desc = "Move a card from your discard pile to your ally's discard pile.",
												  min=1,
												  max=1,
												  validTargets = selectLoc(loc(currentPid, discardPloc)).where(getCardCost().gte(1)),
												  targetEffect = moveTarget(loc(nextAllyPid, discardPloc))
												  }),
											condition = selectLoc(loc(currentPid, discardPloc)).where(getCardCost().gte(1)).count().gte(1),	
                                            layout = layoutCard(
                                                {
                                                    title = "Helping Hand",
                                                    art = "art/epicart/arcane_research",
                                                    xmlText=[[
<vlayout>
    <hlayout flexibleheight="1">
            <tmpro text="Move a card from your discard pile into your Ally's discard pile." fontsize="24" flexiblewidth="12" />
    </hlayout>
</vlayout>
]],

                                                }
                                            ),
                                            tags = {}
                                        },
                                        {
                                            effect = pushTargetedEffect({
												  desc = "Move a card from your discard pile to your ally's discard pile.",
												  min=1,
												  max=1,
												  validTargets = selectLoc(loc(nextAllyPid, discardPloc)).where(getCardCost().gte(1)),
												  targetEffect = moveTarget(loc(currentPid, discardPloc))
												  }),
											condition = selectLoc(loc(nextAllyPid, discardPloc)).where(getCardCost().gte(1)).count().gte(1),	
                                            layout = layoutCard(
                                                {
                                                    title = "Helping Hand",
                                                    art = "art/epicart/arcane_research",
                                                    xmlText=[[
<vlayout>
    <hlayout flexibleheight="1">
            <tmpro text="Move a card from your Ally's discard pile into your discard pile." fontsize="24" flexiblewidth="12" />
    </hlayout>
</vlayout>
]],

                                                }
                                            ),
                                            tags = {}
                                        }
                                    }
                        }),
				cost = goldCost(1),
            }),
        },
		
		cardEffectAbilities = {},
		layout = cardLayout,
		layoutPath= "art/epicart/arcane_research"
	})
end

---- game setup
function setupGame(g)

    standardSetup(g, {
        description = "Defender (No Heroes) - 2v2 Competitive. This is NOT a Co-op. Each player is teamed up with an AI bot. You must defend them whilst battling your opponent. Knock out either of your opponents to win. Created by Aarkenell 24/06/2025.",
        ai = createCoopAi(),
        timeoutAi = createTimeoutAi(),
        playerOrder = { plid1, plid4, plid2, plid3 },
        opponents = { { plid1, plid3 }, { plid4, plid2 }},
        players = {
            {
                id = plid1,
                init = { 
                    fromEnv = plid1
                },
                avatar = "",
				startDraw = 3,
				canAttackAllyOppChampions = true,
				--canAttackAllyOpp = true,
                cards = {
					deck = { 
                    },
					skills = {
					},
                    buffs = {
                        drawCardsCountAtTurnEndDef(5),
                        discardCardsAtTurnStartDef(),
						team1buff,
						AI_1_hero_select_BuffDef(),
                    }
                }
            },
            {
                id = plid2,
				isAi = false,
                syncHealth = false,                init = { 
                    fromEnv = plid2
                },
                avatar = "",
				startDraw = 5,
				canAttackAllyOppChampions = true,
				--canAttackAllyOpp = true,
                cards = {
                    deck = { 
                    },
					skills = {
					},
					buffs = {
                        drawCardsCountAtTurnEndDef(5),
                        discardCardsAtTurnStartDef(),
						team2buff,

                    }
                }
            },
                        {
                id = plid3, -- player 2 ally
				isAi = true,
                syncHealth = false,
				startDraw = 5,
				canAttackAllyOppChampions = true,
				--canAttackAllyOpp = true,
                name = "AI 2",
                avatar="WarInTheWild/slaughterclaw",
                health = 0,
                cards = {
                    deck = { 
                    },
					buffs = {
                        drawCardsCountAtTurnEndDef(5),
                        discardCardsAtTurnStartDef(),
						team2AIbuff,
						--AI_2_hero_select_BuffDef(),

                    }
                }
            },
			{
                id = plid4, -- player 1 ally
                isAi = true,
                syncHealth = false,
				startDraw = 3,
				canAttackAllyOppChampions = true,
				--canAttackAllyOpp = true,
                name = "AI 1",
                avatar="cristov_s_recruits",
                health = 0,
                cards = {
					deck = { 
                      },
					
                    buffs = {
                        drawCardsCountAtTurnEndDef(5),
                        discardCardsAtTurnStartDef(),
						team1AIbuff,

                    }
                }
            },
        }
    })
end

function endGame(g)
end








            function setupMeta(meta)
                meta.name = "Defender (with Heroes) - 2v2 Competitive"
                meta.minLevel = 0
                meta.maxLevel = 0
                meta.introbackground = ""
                meta.introheader = ""
                meta.introdescription = ""
                meta.path = "C:/Users/aaron/OneDrive/Documents/Aaron/Hero Realms/Lua/Defender (with Heroes) - 2v2 Competitive.lua"
                meta.features = {
}

            end