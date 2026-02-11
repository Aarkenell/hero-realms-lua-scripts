require 'herorealms'
require 'decks'
require 'stdlib'
require 'coopai'
require 'timeoutai'

-- need to fix combined health process

isCoop = false

function startOfGameBuffDef()

 local defender_SoG_buff = createGlobalBuff({
        id="defender_SoG_buff",
        name = "Intro text",
        abilities = {
            createAbility({
                id="defender_SoG_buff",
				trigger = startOfGameTrigger,
                effect = nullEffect()
            })
        },
    })

    return createGlobalBuff({
        id="startOfGameBuff",
        name = "Start of Game Story",
        abilities = {
            createAbility({
                id="SoG_effect",
                trigger = startOfTurnTrigger,
                effect = waitForClickEffect("Alert! This is NOT a co-op.", "")
		.seq(waitForClickEffect("You are allied with an AI player.", ""))
		.seq(waitForClickEffect("You must defend it whilst eliminating your opponent.", ""))
		.seq(waitForClickEffect("If your AI ally's health reaches 0, you lose.", ""))
		.seq(waitForClickEffect("Enjoy!", ""))
				.seq(sacrificeSelf())
			})
        }   
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

local function ouch_AI1_buff_def()
    local card_name = "defenders_ouch_buff"

	local ef_ouch_1 = showSpeechBubbleEffect({
								playerExpression=oppPid,
								text="That hurt.",
								waitForClick= constBoolExpression(false)
							})

	local ef_ouch_2 = showSpeechBubbleEffect({
								playerExpression=oppPid,
								text="Haha! Tis but a flesh wound!",
								waitForClick= constBoolExpression(false)
							})
	
	local ef_ouch_0 = randomEffect({
					valueItem(2, ef_ouch_1),
					valueItem(1, ef_ouch_2),
				})
		
					
return createGlobalBuff({
        id="ouch_1_buff",
        name = "Hit Hard",
        abilities = {
            createAbility({
                id="ouch_1_buff_effect",
                trigger = endOfTurnTrigger,
                effect = ifElseEffect(getPlayerDamageReceivedThisTurn(oppPid).gte(10), ef_ouch_0, nullEffect()),
				cost = noCost
				
            }),
			createAbility({
                id="last_stand_effect",
                trigger = endOfTurnTrigger,
				check = getPlayerHealth(oppPid).lte(10),
                effect = showSpeechBubbleEffect({
								playerExpression=oppPid,
								text="I'm done for.",
								waitForClick= constBoolExpression(false)
							}),
				cost = sacrificeSelfCost
				
            })
        },

    })
end

local function ouch_AI2_buff_def()
    local card_name = "defenders_ouch_buff"

	local ef_ouch_1 = showSpeechBubbleEffect({
								playerExpression=oppPid,
								text="Grrrr!",
								waitForClick= constBoolExpression(false)
							})

	local ef_ouch_2 = showSpeechBubbleEffect({
								playerExpression=oppPid,
								text="Hiss!!",
								waitForClick= constBoolExpression(false)
							})
	
	local ef_ouch_0 = randomEffect({
					valueItem(2, ef_ouch_1),
					valueItem(1, ef_ouch_2),
				})
		
					
return createGlobalBuff({
        id="ouch_1_buff",
        name = "Hit Hard",
        abilities = {
            createAbility({
                id="ouch_1_buff_effect",
                trigger = endOfTurnTrigger,
                effect = ifElseEffect(getPlayerDamageReceivedThisTurn(oppPid).gte(10), ef_ouch_0, nullEffect()),
				cost = noCost
            }),
			createAbility({
                id="last_stand_effect",
                trigger = endOfTurnTrigger,
				check = getPlayerHealth(oppPid).lte(10),
                effect = showSpeechBubbleEffect({
								playerExpression=oppPid,
								text="Masssster! Heeelp!",
								waitForClick= constBoolExpression(false)
							}),
				cost = sacrificeSelfCost
				
            }),

        },

    })
end

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
            <tmpro text="If there are no champions opposite you, share a card with your Ally." fontsize="24" flexiblewidth="12" />
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
				check = selectLoc(loc(oppPid, inPlayPloc)).where(isCardChampion()).count().eq(0),
				cost = combineCosts({expendCost,goldCost(1)}),
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
                isAi = false,
                syncHealth = false,
				startDraw = 3,
				canAttackAllyOppChampions = true,
				--canAttackAllyOpp = true,
                name = "Player 1",
                avatar="cristov__the_just",
                health = 50,
                cards = {
					deck = { 
                        { qty=1, card=dagger_carddef() },
						{ qty=1, card=shortsword_carddef() },
                        { qty=7, card=gold_carddef() },
						{ qty=1, card=ruby_carddef() },
                    },
					skills = {
						{ qty=1, card= share_card_2v2_skilldef() },
					},
                    buffs = {
                        drawCardsCountAtTurnEndDef(5),
                        discardCardsAtTurnStartDef(),
						team1buff,
						startOfGameBuffDef(),
						ouch_AI2_buff_def()
                    }
                }
            },
            {
                id = plid2,
				isAi = false,
                syncHealth = false,
				startDraw = 5,
				canAttackAllyOppChampions = true,
				--canAttackAllyOpp = true,
                name = "Player 2",
                avatar="WarInTheWild/the_summoning",
                health = 50,
                cards = {
                    deck = { 
                        { qty=1, card=dagger_carddef() },
						{ qty=1, card=shortsword_carddef() },
                        { qty=7, card=gold_carddef() },
						{ qty=1, card=ruby_carddef() },
                    },
					skills = {
						{ qty=1, card= share_card_2v2_skilldef() },
					},
					buffs = {
                        drawCardsCountAtTurnEndDef(5),
                        discardCardsAtTurnStartDef(),
						team2buff,
						ouch_AI1_buff_def(),

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
                health = 50,
                cards = {
                    deck = { 
                        { qty=1, card=dagger_carddef() },
						{ qty=1, card=shortsword_carddef() },
                        { qty=7, card=gold_carddef() },
						{ qty=1, card=ruby_carddef() },
                    },
					buffs = {
                        drawCardsCountAtTurnEndDef(5),
                        discardCardsAtTurnStartDef(),
						team2AIbuff,

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
                health = 50,
                cards = {
					deck = { 
                        { qty=1, card=dagger_carddef() },
						{ qty=1, card=shortsword_carddef() },
                        { qty=7, card=gold_carddef() },
						{ qty=1, card=ruby_carddef() },
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
                meta.name = "2v2 Co-op"
                meta.minLevel = 0
                meta.maxLevel = 0
                meta.introbackground = ""
                meta.introheader = ""
                meta.introdescription = ""
                meta.path = "C:/Users/aaron/OneDrive/Documents/Aaron/Hero Realms/Lua/2v2 Co-op.lua"
                meta.features = {
}

            end

function setupCoopIntro(encounter)
        encounter.name = "Defender (No Heroes)"
        encounter.description = "This is NOT a Co-op. Each player teams up with an AI Bot in a 2vs2 match-up. Defend your AI Ally and knock out your opponent first. Created by Aarkenell 24.06.2025"
        encounter.minlevel = 1
        encounter.maxlevel = 24
        encounter.avatar = "avatars/chest"
        encounter.heroname = "Defender (No Heroes)"
        encounter.backgroundPath = "scenariointrobackgrounds/test_of_mettle"
        encounter.features = {
            encounter.feature("avatars/cristov__the_just", "This is NOT a co-op.  Each human player teams up with an AI Bot in a 2vs2 match-up. Defend your AI Ally and knock out your opponent first."),
            encounter.feature("avatars/cristov_s_recruits", "You may spend 1 gold each turn to move a card between your discard pile and your Ally's. Use this to your team's advantage."),
            encounter.feature("avatars/WarInTheWild/the_summoning", "Created by Aarkenell 24.06.2025")
        }
end