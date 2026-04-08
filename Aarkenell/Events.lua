require "herorealms"
require "decks"
require "stdlib"
require "stdcards"
require "hardai"
require "mediumai"
require "easyai"

--Fate cards don't sac after played.
--Need to create 'reshuffle fate deck' for when it runs out.

-- =========================================================
-- SCENARIO SETUP
-- =========================================================

local event_draw_Buff= createGlobalBuff({
    id="event_draw",
    name = "Twists of Fate",
    abilities = {
        createAbility({
            id="event_draw",
            trigger = startOfTurnTrigger,
            effect = randomTarget(const(2), moveTarget(currentRevealLoc)).apply(selectLoc(loc(nil, nullPloc)))
			.seq(promptSplit({
                    selector = selectLoc(currentRevealLoc),
                    take = const(1),
                    sort = const(1),
					minTake = const(1),
                    ef1 = moveTarget(nullPloc),
                    ef2 = moveTarget(loc(currentPid, castPloc)),
                    header = "Twists of Fate",
                    description = "Put 1 card in hand. The other will return to Fate. (Be sure to 'View Battleboard' to check if you have a buff from your opponent before choosing.)",
                    pile1Name = "Return to the Fate Deck.",
                    pile2Name = "Take.",
                    eff1Tags = {  },
                    eff2Tags = {  }
                })),
			aiPriority = toIntExpression(50),
        })
    },
    buffDetails = createBuffDetails({
        name = "Twists of Fate",
        art = "art/epicart/insurgency",
        text = "<size=80%><br>Each turn draw 2 cards from the Fate deck. Play one and return the other. If the Fate deck runs out, shuffle all Fate cards to form a new deck."
    })
})

function SetupBuffDef()
	local efSetup = 
					--fate deck
				createCardEffect(tof_fateful_exchange_carddef(), loc(nil, nullPloc))
				.seq(createCardEffect(tof_shared_insight_carddef(), loc(nil, nullPloc)))
				.seq(createCardEffect(tof_blood_for_power_carddef(), loc(nil, nullPloc)))
				.seq(createCardEffect(tof_mutual_aid_carddef(), loc(nil, nullPloc)))
				.seq(createCardEffect(tof_revitalise_carddef(), loc(nil, nullPloc)))
				.seq(createCardEffect(tof_wounded_momentum_carddef(), loc(nil, nullPloc)))
				.seq(createCardEffect(tof_fortune_s_favour_carddef(), loc(nil, nullPloc)))
				.seq(createCardEffect(tof_glimmers_of_gold_carddef(), loc(nil, nullPloc)))
				.seq(createCardEffect(tof_fatigue_carddef(), loc(nil, nullPloc)))
				.seq(createCardEffect(tof_signs_of_ursine_carddef(), loc(nil, nullPloc)))
				.seq(createCardEffect(tof_fluctuating_markets_carddef(), loc(nil, nullPloc)))
				.seq(createCardEffect(tof_famine_carddef(), loc(nil, nullPloc)))
				.seq(createCardEffect(tof_mutual_sacrifice_carddef(), loc(nil, nullPloc)))
--.seq(createCardEffect(tof_trade_winds_carddef(), loc(nil, nullPloc)))
--.seq(createCardEffect(tof_visions_of_the_future_carddef(), loc(nil, nullPloc)))

--.seq(createCardEffect(tof_retaliatory_blow_carddef(), loc(nil, nullPloc)))


    return createGlobalBuff({
        id="SetupBuff",
        name = "Setup",
        abilities = {
			createAbility({
                id="setup_effect",
                trigger = startOfGameTrigger,
				activations = singleActivations,
				aiPriority = toIntExpression(0),
                effect = ifElseEffect(getTurnsPlayed(ownerPid).eq(1), efSetup, nullEffect())
            }),
		
        }
    })
end

function ResetFate()
	local ResetFate = 
					--fate deck
				createCardEffect(tof_fateful_exchange_carddef(), loc(nil, nullPloc))
				.seq(createCardEffect(tof_shared_insight_carddef(), loc(nil, nullPloc)))
				.seq(createCardEffect(tof_blood_for_power_carddef(), loc(nil, nullPloc)))
				.seq(createCardEffect(tof_mutual_aid_carddef(), loc(nil, nullPloc)))
				.seq(createCardEffect(tof_revitalise_carddef(), loc(nil, nullPloc)))
				.seq(createCardEffect(tof_wounded_momentum_carddef(), loc(nil, nullPloc)))
				.seq(createCardEffect(tof_fortune_s_favour_carddef(), loc(nil, nullPloc)))
				.seq(createCardEffect(tof_glimmers_of_gold_carddef(), loc(nil, nullPloc)))
				.seq(createCardEffect(tof_fatigue_carddef(), loc(nil, nullPloc)))
				.seq(createCardEffect(tof_signs_of_ursine_carddef(), loc(nil, nullPloc)))
				.seq(createCardEffect(tof_fluctuating_markets_carddef(), loc(nil, nullPloc)))
				.seq(createCardEffect(tof_famine_carddef(), loc(nil, nullPloc)))
				.seq(createCardEffect(tof_mutual_sacrifice_carddef(), loc(nil, nullPloc)))
--.seq(createCardEffect(tof_trade_winds_carddef(), loc(nil, nullPloc)))
--.seq(createCardEffect(tof_visions_of_the_future_carddef(), loc(nil, nullPloc)))

--.seq(createCardEffect(tof_retaliatory_blow_carddef(), loc(nil, nullPloc)))


    return createGlobalBuff({
        id="SetupBuff",
        name = "Setup",
        abilities = {

			createAbility({
                id="restore_effect",
                trigger = endOfTurnTrigger,
				activations = singleActivations,
				check = selectLoc(loc(nil, nullPloc)).count().lte(1),
                effect = sacrificeTarget().apply(selectLoc(loc(nil, nullPloc)))
				.seq(ResetFate)
            }),
		
        }
    })
end

-------
local tof_fateful_exchange_Buff= createGlobalBuff({
    id="tof_fateful_exchange",
    name = "Fateful Exchange",
    abilities = {
        createAbility({
            id="tof_fateful_exchange",
            trigger = startOfTurnTrigger,
			activations = singleActivations,
			aiPriority = toIntExpression(100),
            effect = drawCardsEffect(1).seq(sacrificeSelf())
        })
    },
    buffDetails = createBuffDetails({
        name = "Fateful Exchange",
        art = "art/epicart/lesser_arms",
        text = "Draw 1."
    })
})

function tof_fateful_exchange_carddef()

    return createDef({
        id="tof_fateful_exchange",
        name="Fateful Exchange",
        types={ itemType},
		cardTypeLabel = "Event",
		playLocation = castPloc,
        acquireCost=0,
        abilities = {
            createAbility({
                id="tof_fateful_exchange",
                trigger= autoTrigger,
				activations = singleActivations,
                effect = drawCardsEffect(1).seq(forceDiscard(1))
		.seq(createCardEffect(tof_fateful_exchange_Buff, loc(oppPid, buffsPloc)))
.seq(sacrificeSelf())
            }),
        },
        layout = createLayout({
            name = "Fateful Exchange",
            art = "art/epicart/lesser_arms",
            frame = "frames/generic_cardframe",
            xmlText = [[
<vlayout forceheight="false" spacing="6">
<hlayout spacing="10">
<text text="You:
&lt;size=133%&gt;Draw 1. Discard 1" fontsize="18"/>
</hlayout>
<divider/>
<hlayout forcewidth="true" spacing="10">
<text text="Opponent:
&lt;size=133%&gt;Draw 1." fontsize="18"/>
</hlayout>
</vlayout>
]]
        })
    })
	end 

local tof_shared_insight_Buff= createGlobalBuff({
    id="tof_shared_insight",
    name = "Shared Insight",
    abilities = {
        createAbility({
            id="tof_shared_insight",
            trigger = startOfTurnTrigger,
			aiPriority = toIntExpression(100),
			activations = singleActivations,
            effect = drawCardsEffect(2).seq(forceDiscard(1))
        }),
		 createAbility({
            id="tof_shared_insight_sac",
            trigger = endOfTurnTrigger,
			activations = singleActivations,
            effect = sacrificeSelf()
        })
    },
    buffDetails = createBuffDetails({
        name = "Shared Insight",
        art = "art/epicart/forest_dweller",
        text = "Draw 2. Discard 1."
    })
})

function tof_shared_insight_carddef()

    return createDef({
        id="tof_shared_insight",
        name="Shared Insight",
        types={ itemType},
		cardTypeLabel = "Event",
		playLocation = castPloc,
        acquireCost=0,
        abilities = {
            createAbility({
                id="tof_shared_insight",
                trigger= autoTrigger,
				activations = singleActivations,
                effect = drawCardsEffect(1)
		.seq(createCardEffect(tof_shared_insight_Buff, loc(oppPid, buffsPloc)))
.seq(sacrificeSelf())
            }),
        },
        layout = createLayout({
            name = "Shared Insight",
            art = "art/epicart/forest_dweller",
            frame = "frames/generic_cardframe",
            xmlText = [[
<vlayout forceheight="false" spacing="6">
<hlayout spacing="10">
<text text="You:
&lt;size=133%&gt;Draw 1." fontsize="18"/>
</hlayout>
<divider/>
<hlayout forcewidth="true" spacing="10">
<text text="Opponent:
&lt;size=133%&gt;Draw 2. Discard 1." fontsize="18"/>
</hlayout>
</vlayout>
]]
        })
    })
	end 
	
local tof_blood_for_power_Buff= createGlobalBuff({
    id="tof_blood_for_power",
    name = "Blood for Power",
    abilities = {
        createAbility({
            id="tof_blood_for_power",
            trigger = startOfTurnTrigger,
			aiPriority = toIntExpression(100),
			activations = singleActivations,
            effect = nullEffect()
        }),
		  createAbility({
            id="tof_blood_for_power_sac",
            trigger = endOfTurnTrigger,
			activations = singleActivations,
            effect = sacrificeSelf()
        })
    },
    buffDetails = createBuffDetails({
        name = "Blood for Power",
        art = "art/epicart/dark_offering",
        text = "Your opponent took 6 damage on their last turn."
    })
})

function tof_blood_for_power_carddef()

    return createDef({
        id="tof_blood_for_power",
        name="Blood for Power",
        types={ itemType},
		cardTypeLabel = "Event",
		playLocation = castPloc,
        acquireCost=0,
        abilities = {
            createAbility({
                id="tof_blood_for_power",
                trigger= autoTrigger,
				activations = singleActivations,
                effect = gainCombatEffect(4).seq(hitSelfEffect(6))
		.seq(createCardEffect(tof_blood_for_power_Buff, loc(oppPid, buffsPloc)))
.seq(sacrificeSelf())
            }),
        },
        layout = createLayout({
            name = "Blood for Power",
            art = "art/epicart/dark_offering",
            frame = "frames/generic_cardframe",
            xmlText = [[
<vlayout forceheight="false" spacing="6">
<hlayout spacing="10">
<text text="You:
&lt;size=133%&gt;{combat_4}
Lose {health_6}" fontsize="18"/>
</hlayout>
<divider/>
<hlayout forcewidth="true" spacing="10">
<text text="Opponent:
&lt;size=133%&gt;No effect" fontsize="18"/>
</hlayout>
</vlayout>
]]
        })
    })
	end 

local tof_mutual_aid_Buff= createGlobalBuff({
    id="tof_mutual_aid",
    name = "Mutual Aid",
    abilities = {
        createAbility({
            id="tof_mutual_aid",
            trigger = startOfTurnTrigger,
			aiPriority = toIntExpression(100),
			activations = singleActivations,
            effect = gainMaxHealthEffect(ownerPid, const(8)).seq(healPlayerEffect(ownerPid, 8)).seq(gainMaxHealthEffect(ownerPid, const(-8)))
			
        }),
		 createAbility({
            id="tof_mutual_aid_sac",
            trigger = endOfTurnTrigger,
			activations = singleActivations,
            effect = sacrificeSelf()
        })
    },
    buffDetails = createBuffDetails({
        name = "Mutual Aid",
        art = "art/epicart/arm",
        text = "Gain 8 health."
    })
})

function tof_mutual_aid_carddef()

    return createDef({
        id="tof_mutual_aid",
        name="Mutual Aid",
        types={ itemType},
		cardTypeLabel = "Event",
		playLocation = castPloc,
        acquireCost=0,
        abilities = {
            createAbility({
                id="tof_mutual_aid",
                trigger= autoTrigger,
				activations = singleActivations,
                effect = gainMaxHealthEffect(ownerPid, const(4)).seq(healPlayerEffect(ownerPid, 4)).seq(gainMaxHealthEffect(ownerPid, const(-4)))
		.seq(createCardEffect(tof_mutual_aid_Buff, loc(oppPid, buffsPloc)))
.seq(sacrificeSelf())
            }),
        },
        layout = createLayout({
            name = "Mutual Aid",
            art = "art/epicart/arm",
            frame = "frames/generic_cardframe",
            xmlText = [[
<vlayout forceheight="false" spacing="6">
<hlayout spacing="10">
<text text="You:
&lt;size=160%&gt;{health_4}
&lt;size=133%&gt;(Can heal above max.)" fontsize="18"/>
</hlayout>
<divider/>
<hlayout forcewidth="true" spacing="10">
<text text="Opponent:
&lt;size=160%&gt;{health_8}
&lt;size=133%&gt;(Can heal above max.)" fontsize="18"/>
</hlayout>
</vlayout>
]]
        })
    })
	end 
local tof_wounded_momentum_Buff= createGlobalBuff({
    id="tof_wounded_momentum",
    name = "Wounded Momentum",
    abilities = {
        createAbility({
            id="tof_wounded_momentum",
            trigger = startOfTurnTrigger,
			activations = singleActivations,
			aiPriority = toIntExpression(100),
            effect = gainCombatEffect(3)
        }),
		 createAbility({
            id="tof_wounded_momentum_sac",
            trigger = endOfTurnTrigger,
			activations = singleActivations,
            effect = sacrificeSelf()
        })
    },
    buffDetails = createBuffDetails({
        name = "Wounded Momentum",
        art = "art/epicart/hand_of_angeline",
        text = "Gain 3 combat at the start of your turn."
    })
})

function tof_wounded_momentum_carddef()

    return createDef({
        id="tof_wounded_momentum",
        name="Wounded Momentum",
        types={ itemType},
		cardTypeLabel = "Event",
		playLocation = castPloc,
        acquireCost=0,
        abilities = {
            createAbility({
                id="tof_wounded_momentum",
                trigger= autoTrigger,
				activations = singleActivations,
                effect = gainMaxHealthEffect(ownerPid, const(5)).seq(healPlayerEffect(ownerPid, 5)).seq(gainMaxHealthEffect(ownerPid, const(-5)))
		.seq(createCardEffect(tof_wounded_momentum_Buff, loc(oppPid, buffsPloc)))
.seq(sacrificeSelf())
            }),
        },
        layout = createLayout({
            name = "Wounded Momentum",
            art = "art/epicart/hand_of_angeline",
            frame = "frames/generic_cardframe",
            xmlText = [[
<vlayout forceheight="false" spacing="6">
<hlayout spacing="10">
<text text="You:
&lt;size=160%&gt;{health_5}
&lt;size=133%&gt;(Can heal above max.)" fontsize="18"/>
</hlayout>
<divider/>
<hlayout forcewidth="true" spacing="10">
<text text="Opponent:
&lt;size=133%&gt;{combat_3}" fontsize="18"/>
</hlayout>
</vlayout>
]]
        })
    })
	end 
local tof_mutual_sacrifice_Buff= createGlobalBuff({
    id="tof_mutual_sacrifice_buff",
    name = "Mutual Sacrifice",
    abilities = {
        createAbility({
            id="tof_mutual_sacrifice",
            trigger = startOfTurnTrigger,
			activations = singleActivations,
			aiPriority = toIntExpression(101),
            effect = pushTargetedEffect({
												  desc = "Sacrifice a card in your hand or discard pile.",
												  min=1,
												  max=1,
												  validTargets = selectLoc(loc(currentPid, discardPloc)).union(selectLoc(loc(currentPid, handPloc))),
												  targetEffect = sacrificeTarget()
												  })

        }),
		 createAbility({
            id="tof_mutual_sacrifice_sac",
            trigger = endOfTurnTrigger,
			activations = singleActivations,
            effect = sacrificeSelf()
        })
    },
    buffDetails = createBuffDetails({
        name = "Mutual Sacrifice",
        art = "art/epicart/dark_one_s_fury",
        text = "Sacrifice a card from hand or discard."
    })
})

function tof_mutual_sacrifice_carddef()

    return createDef({
        id="tof_mutual_sacrifice",
        name="Mutual Sacrifice",
        types={ itemType},
		cardTypeLabel = "Event",
		playLocation = castPloc,
        acquireCost=0,
        abilities = {
            createAbility({
                id="tof_mutual_sacrifice",
                trigger= autoTrigger,
				activations = singleActivations,
                effect = pushTargetedEffect({
												  desc = "Sacrifice a card in your hand.",
												  min=1,
												  max=1,
												  validTargets = selectLoc(loc(currentPid, handPloc)),
												  targetEffect = sacrificeTarget()
												  })
		.seq(createCardEffect(tof_mutual_sacrifice_Buff, loc(oppPid, buffsPloc)))
.seq(sacrificeSelf())
            }),
        },
        layout = createLayout({
            name = "Mutual Sacrifice",
            art = "art/epicart/dark_one_s_fury",
            frame = "frames/generic_cardframe",
            xmlText = [[
<vlayout forceheight="false" spacing="6">
<hlayout spacing="10">
<text text="You:
&lt;size=133%&gt;Sacrifice a card from hand." fontsize="18"/>
</hlayout>
<divider/>
<hlayout forcewidth="true" spacing="10">
<text text="Opponent:
&lt;size=133%&gt;Sacrifice a card from hand or discard." fontsize="18"/>
</hlayout>
</vlayout>
]]
        })
    })
	end 

function tof_mutual_sacrifice_opp_carddef()

    return createDef({
        id="tof_mutual_sacrifice_opp",
        name="Mutual Sacrifice",
        types={ itemType},
		cardTypeLabel = "Event",
		playLocation = castPloc,
        acquireCost=0,
        abilities = {
            createAbility({
                id="tof_mutual_sacrifice_opp",
                trigger= autoTrigger,
				activations = singleActivations,
                effect = pushTargetedEffect({
												  desc = "Sacrifice a card in your hand or discard.",
												  min=1,
												  max=1,
												  validTargets = selectLoc(loc(currentPid, discardPloc)).union(selectLoc(loc(currentPid, handPloc))),
												  targetEffect = sacrificeTarget()
												  })
.seq(sacrificeSelf())
            }),
        },
        layout = createLayout({
            name = "Mutual Sacrifice",
            art = "art/epicart/dark_one_s_fury",
            frame = "frames/generic_cardframe",
            xmlText = [[
<vlayout forceheight="false" spacing="6">

<hlayout forcewidth="true" spacing="10">
<text text="&lt;size=133%&gt;Sacrifice a card from hand or discard." fontsize="18"/>
</hlayout>
</vlayout>
]]
        })
    })
	end 
	
function tof_fortune_s_favour_carddef()

    return createDef({
        id="tof_fortune_s_favour",
        name="Fortune's Favour",
        types={ itemType},
		cardTypeLabel = "Event",
		playLocation = castPloc,
        acquireCost=0,
        abilities = {
            createAbility({
                id="tof_fortune_s_favour",
                trigger= autoTrigger,
				activations = singleActivations,
                effect = createCardEffect(gold_carddef(), currentDiscardLoc)
		.seq(createCardEffect(ruby_carddef(), loc(oppPid, discardPloc)))
.seq(sacrificeSelf())
            }),
        },
        layout = createLayout({
            name = "Fortune's Favour",
            art = "art/epicart/djinn_of_the_sands",
            frame = "frames/generic_cardframe",
            xmlText = [[
<vlayout forceheight="false" spacing="6">
<hlayout spacing="10">
<text text="You:
&lt;size=133%&gt;Add a Gold card to your discard pile" fontsize="18"/>
</hlayout>
<divider/>
<hlayout forcewidth="true" spacing="10">
<text text="Opponent:
&lt;size=133%&gt;Add a Ruby to their discard pile." fontsize="18"/>
</hlayout>
</vlayout>
]]
        })
    })
	end 


function tof_glimmers_of_gold_carddef()

    return createDef({
        id="tof_glimmers_of_gold",
        name="Glimmers of Gold",
        types={ itemType},
		cardTypeLabel = "Event",
		playLocation = castPloc,
        acquireCost=0,
        abilities = {
            createAbility({
                id="tof_glimmers_of_gold",
                trigger= autoTrigger,
				activations = singleActivations,
                effect = createCardEffect(gold_carddef(), currentDiscardLoc).seq(createCardEffect(gold_carddef(), currentDiscardLoc))
		.seq(createCardEffect(gold_carddef(), loc(oppPid, discardPloc)))
.seq(sacrificeSelf())
            }),
        },
        layout = createLayout({
            name = "Glimmers of Gold",
            art = "art/epicart/high_king",
            frame = "frames/generic_cardframe",
            xmlText = [[
<vlayout forceheight="false" spacing="6">
<hlayout spacing="10">
<text text="You:
&lt;size=133%&gt;Add two Gold card to your discard pile" fontsize="18"/>
</hlayout>
<divider/>
<hlayout forcewidth="true" spacing="10">
<text text="Opponent:
&lt;size=133%&gt;Add a Gold card to their discard pile" fontsize="18"/>
</hlayout>
</vlayout>
]]
        })
    })
	end 
local tof_trade_winds_Buff= createGlobalBuff({
    id="tof_trade_winds",
    name = "Trade Winds",
    abilities = {
        createAbility({
            id="tof_trade_winds",
            trigger = startOfTurnTrigger,
			activations = singleActivations,
			aiPriority = toIntExpression(100),
            effect = gainGoldEffect(2)
                    .seq(addSlotToPlayerEffect(currentPlayer(),
                        createPlayerSlot({ key = "topdeckAcquire", expiry = { onceExpiry } }))).seq(sacrificeSelf())
        })
    },
    buffDetails = createBuffDetails({
        name = "Trade Winds",
        art = "art/epicart/erwin_architect_of_war",
        text = "Gain 2 gold. The next card they acquire pn their next turn is placed on top of their deck."
    })
})

function tof_trade_winds_carddef()

    return createDef({
        id="tof_trade_winds",
        name="Trade Winds",
        types={ itemType},
		cardTypeLabel = "Event",
		playLocation = castPloc,
        acquireCost=0,
        abilities = {
            createAbility({
                id="tof_trade_winds",
                trigger= autoTrigger,
				activations = singleActivations,
                effect = gainGoldEffect(1)
                    .seq(addSlotToPlayerEffect(currentPlayer(),
                        createPlayerSlot({ key = "topdeckAcquire", expiry = { onceExpiry } })))
		.seq(createCardEffect(tof_trade_winds_Buff, loc(oppPid, buffsPloc)))
.seq(sacrificeSelf())
            }),
        },
        layout = createLayout({
            name = "Trade Winds",
            art = "art/epicart/erwin_architect_of_war",
            frame = "frames/generic_cardframe",
            xmlText = [[
<vlayout forceheight="false" spacing="6">
<hlayout spacing="10">
<text text="You:
&lt;size=133%&gt;Gain {gold_1}. The next card you acquire this turn is placed on top of your deck." fontsize="18"/>
</hlayout>
<divider/>
<hlayout forcewidth="true" spacing="10">
<text text="Opponent:
&lt;size=133%&gt;Gain {gold_2}. The next card they acquire pn their next turn is placed on top of their deck." fontsize="18"/>
</hlayout>
</vlayout>
]]
        })
    })
	end 

--[[local tof_visions_of_the_future_Buff= createGlobalBuff({
    id="tof_visions_of_the_future",
    name = "Visions of the Future",
    abilities = {
        createAbility({
            id="tof_visions_of_the_future",
            trigger = startOfTurnTrigger,
            effect = moveTarget(myRevealPloc).apply(selectLoc(loc(currentPid, deckPloc)).take(2)).seq(noUndoEffect()).seq(promptSplit({
    selector = selectLoc(currentRevealLoc),
    take = const(1), -- number of cards to take for split
    sort = const(1), -- number of card.seq(sacrificeSelf())
        })
    },
    buffDetails = createBuffDetails({
        name = "Visions of the Future",
        art = "art/epicart/dark_eyes",
        text = "Look at the top 2 cards of your deck. You may put either or both back on top or on the bottom of your deck."
    })
})


function tof_visions_of_the_future_carddef()

    return createDef({
        id="tof_visions_of_the_future",
        name="Visions of the Future",
        types={ itemType},
		cardTypeLabel = "Event",
		playLocation = castPloc,
        acquireCost=0,
        abilities = {
            createAbility({
                id="tof_visions_of_the_future",
                trigger= autoTrigger,
                effect = moveTarget(myRevealPloc).apply(selectLoc(loc(currentPid, deckPloc)).take(1)).seq(noUndoEffect()).seq(promptSplit({
    selector = selectLoc(currentRevealLoc),
    take = const(1), -- number of cards to take for split
    sort = const(1), -- number of card
	--	.seq(createCardEffect(tof_visions_of_the_future_Buff, loc(oppPid, buffsPloc)))
--.seq(sacrificeSelf())
            }),
        },
        layout = createLayout({
            name = "Visions of the Future",
            art = "art/epicart/dark_eyes",
            frame = "frames/generic_cardframe",
            xmlText = [[
<vlayout forceheight="false" spacing="6">
<hlayout spacing="10">
<text text="You:
&lt;size=133%&gt;Look at the top card of your deck. You may put it back on top or on the bottom of your deck." fontsize="18"/>
</hlayout>
<divider/>
<hlayout forcewidth="true" spacing="10">
<text text="Opponent:
&lt;size=133%&gt;Look at the top 2 cards of your deck. You may put either or both back on top or on the bottom of your deck." fontsize="18"/>
</hlayout>
</vlayout>
]]
 --       })
 --   })
--	end 

local tof_revitalise_Buff= createGlobalBuff({
    id="tof_revitalise",
    name = "Revitalise",
    abilities = {
        createAbility({
            id="tof_revitalise",
            trigger = startOfTurnTrigger,
			aiPriority = toIntExpression(100),
			activations = singleActivations,
            effect = gainMaxHealthEffect(ownerPid, const(6)).seq(healPlayerEffect(ownerPid, 6))
        }),
		 createAbility({
            id="tof_revitalise_sac",
            trigger = endOfTurnTrigger,
			activations = singleActivations,
            effect = sacrificeSelf()
        })
    },
    buffDetails = createBuffDetails({
        name = "Revitalise",
        art = "art/epicart/breath_of_life",
        text = "Gain 6 health at the start of your turn."
    })
})

function tof_revitalise_carddef()

    return createDef({
        id="tof_revitalise",
        name="Revitalise",
        types={ itemType},
		cardTypeLabel = "Event",
		playLocation = castPloc,
        acquireCost=0,
        abilities = {
            createAbility({
                id="tof_revitalise",
                trigger= autoTrigger,
				activations = singleActivations,
                effect = gainMaxHealthEffect(ownerPid, const(4)).seq(healPlayerEffect(ownerPid, 4))
		.seq(createCardEffect(tof_revitalise_Buff, loc(oppPid, buffsPloc)))
.seq(sacrificeSelf())
            }),
        },
        layout = createLayout({
            name = "Revitalise",
            art = "art/epicart/breath_of_life",
            frame = "frames/generic_cardframe",
            xmlText = [[
<vlayout forceheight="false" spacing="6">
<hlayout spacing="10">
<text text="You:
&lt;size=120%&gt;Increase max health by 4.
&lt;size=160%&gt;{health_4}
" fontsize="18"/>
</hlayout>
<divider/>
<hlayout forcewidth="true" spacing="10">
<text text="Opponent:
&lt;size=120%&gt;Increase max health by 6.
&lt;size=160%&gt;{health_6}" fontsize="18"/>
</hlayout>
</vlayout>
]]
        })
    })
	end 

	
local tof_famine_Buff= createGlobalBuff({
    id="tof_famine",
    name = "Famine",
    abilities = {
        createAbility({
            id="tof_famine",
            trigger = startOfTurnTrigger,
			aiPriority = toIntExpression(100),
			activations = singleActivations,
            effect = gainGoldEffect(-1)
        }),
		 createAbility({
            id="tof_famine_sac",
            trigger = endOfTurnTrigger,
			activations = singleActivations,
            effect = sacrificeSelf()
        })
    },
    buffDetails = createBuffDetails({
        name = "Famine",
        art = "art/epicart/inheritance_of_the_meek",
        text = "You have 1 less gold this turn."
    })
})

function tof_famine_carddef()

  return createDef({
        id="tof_famine",
        name="Famine",
        types={ itemType},
		cardTypeLabel = "Event",
		playLocation = castPloc,
        acquireCost=0,
        abilities = {
            createAbility({
                id="tof_famine",
                trigger= autoTrigger,
				activations = singleActivations,
                effect = sacrificeTarget().apply(selectLoc(centerRowLoc))
		.seq(gainGoldEffect(-2))
		.seq(createCardEffect(tof_famine_Buff, loc(oppPid, buffsPloc)))
.seq(sacrificeSelf())
            }),
        },
        layout = createLayout({
            name = "Famine",
            art = "art/epicart/inheritance_of_the_meek",
            frame = "frames/generic_cardframe",
            xmlText = [[
<vlayout forceheight="false" spacing="6">
<hlayout spacing="10">
<text text="You:
&lt;size=133%&gt;Sacrifice all cards in the market.
You have {gold_2} less this turn." fontsize="16"/>
</hlayout>
<divider/>
<hlayout forcewidth="true" spacing="10">
<text text="Opponent:
&lt;size=133%&gt;{gold_1} less on their next turn." fontsize="16"/>
</hlayout>
</vlayout>
]]
        })
    })
	end 
	
local tof_fatigue_Buff= createGlobalBuff({
    id="tof_fatigue",
    name = "Fatigue",
    abilities = {
        createAbility({
            id="tof_fatigue",
            trigger = startOfTurnTrigger,
			aiPriority = toIntExpression(100),
			activations = singleActivations,
            effect = expendTarget().apply(selectLoc(loc(currentPid, skillsPloc)))
        }),
		 createAbility({
            id="tof_fatigue_sac",
            trigger = endOfTurnTrigger,
            effect = sacrificeSelf()
        })
    },
    buffDetails = createBuffDetails({
        name = "Fatigue",
        art = "art/epicart/imperial_commander",
        text = "Expend your skills this turn."
    })
})

function tof_fatigue_carddef()

    return createDef({
        id="tof_fatigue",
        name="Fatigue",
        types={ itemType},
		cardTypeLabel = "Event",
		playLocation = castPloc,
        acquireCost=0,
        abilities = {
            createAbility({
                id="tof_fatigue",
                trigger= autoTrigger,
				activations = singleActivations,
                effect = expendTarget().apply(selectLoc(loc(currentPid, skillsPloc)))
		.seq(createCardEffect(tof_fatigue_Buff, loc(oppPid, buffsPloc)))
.seq(sacrificeSelf())
            }),
        },
        layout = createLayout({
            name = "Fatigue",
            art = "art/epicart/imperial_commander",
            frame = "frames/generic_cardframe",
            xmlText = [[
<vlayout forceheight="false" spacing="6">
<hlayout spacing="10">
<text text="You:
&lt;size=133%&gt;Expend all skills." fontsize="18"/>
</hlayout>
<divider/>
<hlayout forcewidth="true" spacing="10">
<text text="Opponent:
&lt;size=133%&gt;Expend all skills." fontsize="18"/>
</hlayout>
</vlayout>
]]
        })
    })
	end 



function tof_signs_of_ursine_carddef()

    return createDef({
        id="tof_signs_of_ursine",
        name="Signs of Ursine",
        types={ itemType},
		cardTypeLabel = "Event",
		playLocation = castPloc,
        acquireCost=0,
        abilities = {
            createAbility({
                id="tof_signs_of_ursine",
                trigger= autoTrigger,
				aiPriority = toIntExpression(100),
				activations = singleActivations,
                effect = createCardEffect(druid_ursine_rod_carddef(), currentDeckLoc).seq(shuffleEffect(loc(currentPid, deckPloc)))
		.seq(createCardEffect(druid_ursine_rod_carddef(), loc(oppPid, deckPloc))).seq(shuffleEffect(loc(oppPid, deckPloc)))
.seq(sacrificeSelf())
            }),
        },
        layout = createLayout({
            name = "Signs of Ursine",
            art = "art/classes/druid/ursine_rod",
            frame = "frames/generic_cardframe",
            xmlText = [[
<vlayout forceheight="false" spacing="6">
<hlayout spacing="10">
<text text="Put an Ursine Rod in each player's deck.
Shuffle both decks." fontsize="24"/>
</hlayout>

</vlayout>
]]
        })
    })
	end 

local priceBuff = getCostDiscountBuff("tof_fluctuating_markets", 1, selectLoc(centerRowLoc).union(selectLoc(fireGemsLoc)))


local tof_fluctuating_markets_Buff= createGlobalBuff({
    id="tof_fluctuating_markets",
    name = "Fluctuating Markets",
    abilities = {
        createAbility({
            id="tof_fluctuating_markets",
            trigger = startOfTurnTrigger,
			aiPriority = toIntExpression(100),
			activations = singleActivations,
            effect = addSlotToTarget(createCostChangeSlot(1, { endOfTurnExpiry, endOfTurnExpiry })).apply(selectLoc(centerRowLoc))
        }),
		 createAbility({
            id="tof_fluctuating_markets_sac",
            trigger = endOfTurnTrigger,
			activations = singleActivations,
            effect = sacrificeSelf()
        })
    },
    buffDetails = createBuffDetails({
        name = "Fluctuating Markets",
        art = "art/epicart/imperial_commander",
        text = "Cards in the market cost 1 less on your next turn."
    })
})

function tof_fluctuating_markets_carddef()

    return createDef({
        id="tof_fluctuating_markets",
        name="Fluctuating Markets",
        types={ itemType},
		cardTypeLabel = "Event",
		playLocation = castPloc,
        acquireCost=0,
        abilities = {
            createAbility({
                id="tof_fluctuating_markets",
                trigger= autoTrigger,
				activations = singleActivations,
                effect = createCardEffect(priceBuff, loc(currentPid, buffsPloc)).seq(sacrificeSelf())
				.seq(createCardEffect(tof_fluctuating_markets_Buff, loc(oppPid, buffsPloc)))
.seq(sacrificeSelf())
            }),
        },
        layout = createLayout({
            name = "Fluctuating Markets",
            art = "art/epicart/imperial_commander",
            frame = "frames/generic_cardframe",
            xmlText = [[
<vlayout forceheight="false" spacing="6">
<hlayout spacing="10">
<text text="You:
&lt;size=133%&gt;Your first purchase costs {gold_1} less this turn." fontsize="17"/>
</hlayout>
<divider/>
<hlayout forcewidth="true" spacing="10">
<text text="Opponent:
&lt;size=133%&gt;All market cards cost {gold_1} less on their next turn." fontsize="17"/>
</hlayout>
</vlayout>
]]
        })
    })
	end 




-----
function setupGame(g)
    registerCards(
        g,
        {
tof_fateful_exchange_carddef(),
tof_blood_for_power_carddef(),
tof_fateful_exchange_carddef(),
tof_shared_insight_carddef(),
tof_blood_for_power_carddef(),
tof_mutual_aid_carddef(),
tof_wounded_momentum_carddef(),
tof_mutual_sacrifice_carddef(),
tof_mutual_sacrifice_opp_carddef(),
tof_fortune_s_favour_carddef(),
tof_glimmers_of_gold_carddef(),
tof_trade_winds_carddef(),
--tof_visions_of_the_future_carddef(),
tof_famine_carddef(),
tof_fatigue_carddef(),
tof_signs_of_ursine_carddef(),
tof_revitalise_carddef(),

        }
    )

    standardSetup(
        g,
        {
            description = "Twists of Fate. Created by Aarkenell (28/01/2026). Each turn, draw 2 Fate cards. Choose 1 to play. Both players will receive a positive or negative reward - but either way, your opponent always gets a better deal than you.",
            playerOrder = {plid1, plid2},
            ai = ai.CreateKillSwitchAi(createAggressiveAI(), createHardAi2()),
            timeoutAi = createTimeoutAi(),
            opponents = {{plid1, plid2}},
            players = {
                {
                    id = plid1,
					init = {
                    fromEnv = plid1
                },
                   cards = {
                    buffs = {
                            drawCardsCountAtTurnEndDef(5),
                            discardCardsAtTurnStartDef(),
                            fatigueCount(40, 1, "FatigueP1"),
							SetupBuffDef(),
							ResetFate(),
							event_draw_Buff
                        }
                    }
                },
                {
                    id = plid2,
				init = {
                    fromEnv = plid2
                },
                   cards = {
                    buffs= {
                            drawCardsCountAtTurnEndDef(5),
                            discardCardsAtTurnStartDef(),
                            fatigueCount(40, 1, "FatigueP1"),
							ResetFate(),
							event_draw_Buff
							
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
                meta.name = "Twists of Fate"
                meta.minLevel = 0
                meta.maxLevel = 0
                meta.introbackground = ""
                meta.introheader = ""
                meta.introdescription = ""
                meta.path = "C:/Users/aaron/OneDrive/Documents/Aaron/Hero Realms/Lua/Events.lua"
                meta.features = {
}

            end