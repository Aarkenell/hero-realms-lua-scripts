require 'herorealms'
require 'decks'
require 'stdlib'
require 'coopai'
require 'timeoutai'

-- need to fix combined health process

isCoop = true

local function share_card_2v2_skilldef()
    local card_name = "share_card_2v2"
	
    local cardLayout = createLayout({
        name = "Helping Hand",
        art = "art/epicart/arcane_research",
        frame = "frames/generic_cardframe",
        xmlText = 
		[[
<vlayout>
    <hlayout flexibleheight="1">
            <tmpro text="{expend_1}" fontsize="60" flexiblewidth="2"/>
            <tmpro text="Share a card with your Ally." fontsize="30" flexiblewidth="12" />
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
        description = "Defender (No Heroes) - 2v2 Competitive. Each player is teamed up with an AI bot. You must defend them whilst battling your opponent. Knock out either of your opponents to win. Created by Aarkenell 24/06/2025.",
        ai = createCoopAi(),
        timeoutAi = createTimeoutAi(),
        playerOrder = { plid1, plid2, plid3, plid4 },
        opponents = { { plid1, plid3 }, { plid2, plid4 }},
        players = {
            {
                id = plid1,
                isAi = false,
                syncHealth = flase,
				startDraw = 3,
				canAttackAllyOppChampions = true,
                name = "Player 1",
                avatar="wizard_01",
                health = 50,
                cards = {
					deck = { 
                        { qty=1, card=dagger_carddef() },
						{ qty=1, card=shortsword_carddef() },
                        { qty=7, card=gold_carddef() },
						{ qty=1, card=ruby_carddef() },
                    },
					skills = {
						--{ qty=1, card= share_card_2v2_skilldef() },
					},
                    buffs = {
                        drawCardsCountAtTurnEndDef(5),
                        discardCardsAtTurnStartDef(),
                    }
                }
            },
            {
                id = plid2,
				isAi = true,
                syncHealth = false,
				startDraw = 3,
				canAttackAllyOppChampions = true,
                name = "AI 1",
                avatar="journeys/veteran_squire",
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

                    }
                }
            },
                        {
                id = plid3,
				isAi = true,
                syncHealth = false,
				startDraw = 5,
				canAttackAllyOppChampions = true,
                name = "AI 2",
                avatar="profit",
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

                    }
                }
            },
			{
                id = plid4,
                isAi = false,
                syncHealth = false,
				startDraw = 5,
				canAttackAllyOppChampions = true,
                name = "Player 2",
                avatar="fighter_01",
                health = 50,
                cards = {
					deck = { 
                        { qty=1, card=dagger_carddef() },
						{ qty=1, card=shortsword_carddef() },
                        { qty=7, card=gold_carddef() },
						{ qty=1, card=ruby_carddef() },
                    },
					skills = {
						--{ qty=1, card= share_card_2v2_skilldef() },
					},
                    buffs = {
                        drawCardsCountAtTurnEndDef(5),
                        discardCardsAtTurnStartDef(),
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