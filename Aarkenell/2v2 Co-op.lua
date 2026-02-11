require 'herorealms'
require 'decks'
require 'stdlib'
--require 'hardai'
require 'coopai'
require 'timeoutai'

-- need to fix combined health process

isCoop = true


--extra buffs


			
local function ef_tough1()

return createGlobalBuff({
        id="toughbuff1",
        name = "Tough Buff",
        abilities = {
            createAbility({
                id= "toughbuff1",
				trigger = startOfTurnTrigger,
				activations = singleActivations,
                effect = gainToughnessEffect(1),
				
				}),
        },
		buffDetails = createBuffDetails({
					name = "Tough",
                    art = "art/treasures/fighter_iron_shield",
					text = "<size=100%>Gain 1 Toughness each turn."
							})
    })
end


local function ef_tough2() 

return createGlobalBuff({
        id="toughbuff2",
        name = "Tough Buff",
        abilities = {
            createAbility({
                id= "toughbuff2",
				trigger = startOfTurnTrigger,
				activations = singleActivations,
                effect = gainToughnessEffect(2),
				
				}),
        },
		buffDetails = createBuffDetails({
					name = "Tough",
                    art = "art/treasures/fighter_iron_shield",
					text = "<size=100%>Gain 2 Toughness each turn."
							})

    })
end
	
local function ef_tough3() 

return createGlobalBuff({
        id="toughbuff3",
        name = "Tough Buff",
        abilities = {
            createAbility({
                id= "toughbuff3",
				trigger = startOfTurnTrigger,
				activations = singleActivations,
                effect = gainToughnessEffect(3),
				
				}),
        },
		buffDetails = createBuffDetails({
					name = "Tough",
                    art = "art/treasures/fighter_iron_shield",
					text = "<size=100%>Gain 3 Toughness each turn."
							})
    })
end

local ef_hp50 = gainMaxHealthEffect(oppPid, const(50)).seq(healPlayerEffect(oppPid, 50))

local ef_hp100 = gainMaxHealthEffect(oppPid, const(100)).seq(healPlayerEffect(oppPid, 100))
				.seq(createCardEffect(ef_tough1(), loc(oppPid, buffsPloc)))
				.seq(createCardEffect(ef_tough1(), loc(nextOppPid, buffsPloc)))

local ef_hp150 = gainMaxHealthEffect(oppPid, const(150)).seq(healPlayerEffect(oppPid, 150))
				.seq(createCardEffect(ef_tough2(), loc(oppPid, buffsPloc)))
				.seq(createCardEffect(ef_tough2(), loc(nextOppPid, buffsPloc)))
	


local function ef_combat3()

return createGlobalBuff({
        id="combatbuff3",
        name = "Combat Buff",
        abilities = {
            createAbility({
                id= "combatbuff3",
				trigger = startOfTurnTrigger,
                effect = gainCombatEffect(3),
				}),
        },
		buffDetails = createBuffDetails({
					name = "Hard Hitter",
                    art = "art/t_fighter_sweeping_blow",
					text = "<size=100%>Gain <sprite name=\"combat_3\"> each turn."
							})
    })
end

local function ef_combat5()

return createGlobalBuff({
        id="combatbuff5",
        name = "Combat Buff",
        abilities = {
            createAbility({
                id= "combatbuff5",
				trigger = startOfTurnTrigger,
                effect = gainCombatEffect(5),
				}),
        },
		buffDetails = createBuffDetails({
					name = "Hard Hitter",
                    art = "art/t_fighter_sweeping_blow",
					text = "<size=100%>Gain <sprite name=\"combat_5\"> each turn."
							})
    })
end

local function ef_combat8()

return createGlobalBuff({
        id="combatbuff8",
        name = "Combat Buff",
        abilities = {
            createAbility({
                id= "combatbuff1",
				trigger = startOfTurnTrigger,
                effect = gainCombatEffect(8),
				}),
        },
		buffDetails = createBuffDetails({
					name = "Hard Hitter",
                    art = "art/t_fighter_sweeping_blow",
					text = "<size=100%>Gain <sprite name=\"combat_8\"> each turn."
							})
    })
end

local function ef_econ1()

return createGlobalBuff({
        id="econbuff1",
        name = "Econ Buff",
        abilities = {
            createAbility({
                id= "econbuff1",
				trigger = startOfTurnTrigger,
                effect = gainGoldEffect(1),
				}),
        },
		buffDetails = createBuffDetails({
					name = "Money Bags",
                    art = "art/t_ruby",
					text = "<size=100%>Gain <sprite name=\"gold_1\"> each turn."
							})
    })
end

local function ef_econ2()

return createGlobalBuff({
        id="econbuff2",
        name = "Econ Buff",
        abilities = {
            createAbility({
                id= "econbuff2",
				trigger = startOfTurnTrigger,
                effect = gainGoldEffect(2),
				}),
        },
		buffDetails = createBuffDetails({
					name = "Money Bags",
                    art = "art/t_ruby",
					text = "<size=100%>Gain <sprite name=\"gold_2\"> each turn."
							})
    })
end

local function ef_econ3()

return createGlobalBuff({
        id="econbuff3",
        name = "Econ Buff",
        abilities = {
            createAbility({
                id= "econbuff2",
				trigger = startOfTurnTrigger,
                effect = gainGoldEffect(2).seq(drawCardsEffect(1)),
				}),
        },
		buffDetails = createBuffDetails({
					name = "Money Bags",
                    art = "art/t_ruby",
					text = "<size=100%>Gain <sprite name=\"gold_2\"> and draw 1 each turn."
							})
    })
end


local function ef_randombuff1()

return createGlobalBuff({
        id="randombuff1",
        name = "Unpredictable",
        abilities = {
            createAbility({
                id= "randombuff1",
				trigger = startOfTurnTrigger,
                effect = randomEffect({
					valueItem(1, gainCombatEffect(3)),
					valueItem(1, gainHealthEffect(5)),
					valueItem(1, gainGoldEffect(1)),
					valueItem(1, gainToughnessEffect(3)),

                    }),
				}),
        },
		
		buffDetails = createBuffDetails({
					name = "Unpredictable",
                    art = "art/epicart/disappearing_act",
					text = "<size=100%>Gain a small random bonus each turn."
							})
    })
	
end

local function ef_randombuff2()


	
return createGlobalBuff({
        id="randombuff2",
        name = "Unpredictable",
        abilities = {
            createAbility({
                id= "randombuff2",
				trigger = startOfTurnTrigger,
                effect = randomEffect({
					valueItem(1, gainCombatEffect(5)),
					valueItem(1, gainHealthEffect(10)),
					valueItem(1, gainGoldEffect(2)),
					valueItem(1, gainToughnessEffect(5)),
					valueItem(1, drawCardsEffect(1)),
					valueItem(1, ef_discard1),
                    }),
				}),
        },
		
		buffDetails = createBuffDetails({
					name = "Unpredictable",
                    art = "art/epicart/disappearing_act",
					text = "<size=100%>Gain a moderate random bonus each turn."
							})
    })
	
end

local function ef_randombuff3()

local ef_discard1 = oppDiscardEffect(1).seq(showSpeechBubbleEffect({
					playerExpression=currentPid,
					text="Drop it.",
					waitForClick= constBoolExpression(false)
				}))
				
return createGlobalBuff({
        id="randombuff3",
        name = "Unpredictable",
        abilities = {
            createAbility({
                id= "randombuff3",
				trigger = startOfTurnTrigger,
                effect = randomEffect({
					valueItem(1, gainCombatEffect(8)),
					valueItem(1, gainHealthEffect(15)),
					valueItem(1, gainGoldEffect(2).seq(drawCardsEffect(1))),
					valueItem(1, gainToughnessEffect(9)),
					valueItem(1, drawCardsEffect(2)),
					valueItem(1, ef_discard1.seq(hitOpponentEffect(4))),
                    }),
				}),
        },
		
		buffDetails = createBuffDetails({
					name = "Unpredictable",
                    art = "art/epicart/disappearing_act",
					text = "<size=100%>Gain a large random bonus each turn."
							})
    })
	
end

-- difficulty buffs
local function P1_difficultyBuffs()

aiPriority = toIntExpression(400)

    return cardChoiceSelectorEffect({
        id = "difficulty_options",
        name = "Choose one",
        trigger = startOfGameTrigger,
		aiPriority = toIntExpression(400),

        upperTitle  = "Play a standard game, or choose a modifier for a  greater challenge.",
        lowerTitle  = "",
 
 effectFirst = nullEffect(),
 aiPriority = toIntExpression(400)
		,


 effectSecond = pushChoiceEffectWithTitle(
                                {
                                    choices = {
									-- Choice 1: Small
                                        {
                                            aiPriority = toIntExpression(400),
											effect = pushChoiceEffectWithTitle(
                                {
                                    choices = {
									-- Choice 1.1: HP 1
                                        {
                                            aiPriority = toIntExpression(400),
											effect =  ef_hp50,

											layout = layoutCard(
                                                {
                                                    title = "Healthier",
                                                    art = "art/treasures/t_green_potions_large",
                                                    xmlText=[[
													
<vlayout>
    <hlayout flexibleheight="1.8">

        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="AI gets +50 {health} at the start of the game." fontsize="26" />
            </box>
        </vlayout>
    </hlayout>

</vlayout>
													]]
                                                }
                                            ),
                                            tags = {}
                                        },
										
										-- Choice 1.2: Combat 3
										{
                                            aiPriority = toIntExpression(400),
											effect =  createCardEffect(ef_combat3(), loc(oppPid, buffsPloc))
												.seq(createCardEffect(ef_combat3(), loc(nextOppPid, buffsPloc))),

											layout = layoutCard(
                                                {
                                                    title = "Hard Hitter",
                                                    art = "art/t_fighter_sweeping_blow",
                                                    xmlText=[[
													
<vlayout>
    <hlayout flexibleheight="1.8">

        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="AI gets {combat_3} each turn." fontsize="26" />
            </box>
        </vlayout>
    </hlayout>

</vlayout>
													]]
                                                }
                                            ),
                                            tags = {}
                                        },                                       
																					
									-- Choice 1.3: Econ 1
                                        {
                                            aiPriority = toIntExpression(400),
											effect =  createCardEffect(ef_econ1(), loc(oppPid, buffsPloc))
											.seq(createCardEffect(ef_econ1(), loc(nextOppPid, buffsPloc))),

											layout = layoutCard(
                                                {
                                                    title = "Money bags",
                                                    art = "art/t_ruby",
                                                    xmlText=[[
													
<vlayout>
    <hlayout flexibleheight="1.8">

        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="AI gets {gold_1} extra each turn." fontsize="26" />
            </box>
        </vlayout>
    </hlayout>

</vlayout>
													]]
                                                }
                                            ),
                                            tags = {}
                                        },
                                       
									-- Choice 1.4 - Small Random
                                        {
                                            aiPriority = toIntExpression(400),
											effect =  createCardEffect(ef_randombuff1(), loc(oppPid, buffsPloc))
											.seq(createCardEffect(ef_randombuff1(), loc(nextOppPid, buffsPloc))),

											layout = layoutCard(
                                                {
                                                    title = "Unpredictable",
                                                    art = "art/epicart/disappearing_act",
                                                    xmlText=[[
													
<vlayout>
    <hlayout flexibleheight="1.8">

        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="Each turn the AI will get one of these benefits:
{health_5}, {combat_3}, {gold_1},
or +3 Toughness" fontsize="24" />
            </box>
        </vlayout>
    </hlayout>

</vlayout>
													]]
                                                }
                                            ),
                                            tags = {}
                                        },
                                        										
                                    },
		upperTitle = "Choose wisely. You cannot undo your selection.",
		lowerTitle = "Or click outside the cards to go back to choose a different level of difficulty."
                                }
                        ),
                                            
											layout = layoutCard(
                                                {
                                                    title = "Slight challenge",
                                                    art = "art/treasures/t_cleric_elixir_green",
                                                    xmlText=[[
													
<vlayout>
    <hlayout flexibleheight="1.8">

        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="Give the AI
a small buff." fontsize="26" />
            </box>
        </vlayout>
    </hlayout>

</vlayout>
													]]
                                                }
                                            ),
                                            tags = {}
                                        },
										
										-- Choice 2: Moderate
                                        {
                                            aiPriority = toIntExpression(400),
											effect = pushChoiceEffectWithTitle(
                                {
                                    choices = {
									-- Choice 2.1: HP 2
                                        {
                                            aiPriority = toIntExpression(400),
											effect =  ef_hp100,

											layout = layoutCard(
                                                {
                                                    title = "Healthier",
                                                    art = "art/treasures/t_green_potions_large",
                                                    xmlText=[[
													
<vlayout>
    <hlayout flexibleheight="1.8">

        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="AI gets +100 {health} at the start of the game and +1 Toughness per turn." fontsize="26" />
            </box>
        </vlayout>
    </hlayout>

</vlayout>
													]]
                                                }
                                            ),
                                            tags = {}
                                        },
										
										-- Choice 2.2: Combat 5
										{
                                            aiPriority = toIntExpression(400),
											effect =  createCardEffect(ef_combat5(), loc(oppPid, buffsPloc))
												.seq(createCardEffect(ef_combat5(), loc(nextOppPid, buffsPloc))),

											layout = layoutCard(
                                                {
                                                    title = "Hard Hitter",
                                                    art = "art/t_fighter_sweeping_blow",
                                                    xmlText=[[
													
<vlayout>
    <hlayout flexibleheight="1.8">

        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="AI gets {combat_5} each turn." fontsize="26" />
            </box>
        </vlayout>
    </hlayout>

</vlayout>
													]]
                                                }
                                            ),
                                            tags = {}
                                        },                                       
																					
									-- Choice 2.3: Econ 2
                                        {
                                            aiPriority = toIntExpression(400),
											effect =  createCardEffect(ef_econ2(), loc(oppPid, buffsPloc))
											.seq(createCardEffect(ef_econ2(), loc(nextOppPid, buffsPloc))),

											layout = layoutCard(
                                                {
                                                    title = "Money bags",
                                                    art = "art/t_ruby",
                                                    xmlText=[[
													
<vlayout>
    <hlayout flexibleheight="1.8">

        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="AI gets {gold_2} extra each turn." fontsize="26" />
            </box>
        </vlayout>
    </hlayout>

</vlayout>
													]]
                                                }
                                            ),
                                            tags = {}
                                        },
                                       
									-- Choice 1.4 - Moderate Random
                                        {
                                            aiPriority = toIntExpression(400),
											effect =  createCardEffect(ef_randombuff2(), loc(oppPid, buffsPloc))
											.seq(createCardEffect(ef_randombuff2(), loc(nextOppPid, buffsPloc))),

											layout = layoutCard(
                                                {
                                                    title = "Unpredictable",
                                                    art = "art/epicart/disappearing_act",
                                                    xmlText=[[
													
<vlayout>
    <hlayout flexibleheight="1.8">

        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="Each turn the AI will get one of these benefits:
10{health}, {combat_5}, {gold_2},
Draw 1,
+5 Toughness" fontsize="24" />
            </box>
        </vlayout>
    </hlayout>

</vlayout>
													]]
                                                }
                                            ),
                                            tags = {}
                                        },
                                        										
                                    },
		upperTitle = "Choose wisely. You cannot undo your selection.",
		lowerTitle = "Or click outside the cards to go back to choose a different level of difficulty."
                                }
                        ),
                                            
											layout = layoutCard(
                                                {
                                                    title = "Moderate challenge",
                                                    art = "art/treasures/t_cleric_elixir_golden",
                                                    xmlText=[[
													
<vlayout>
    <hlayout flexibleheight="1.8">

        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="Give the AI
a moderate buff." fontsize="26" />
            </box>
        </vlayout>
    </hlayout>

</vlayout>
													]]
                                                }
                                            ),
                                            tags = {}
                                        },
																					
										-- Choice 3: Tough
                                        {
                                            aiPriority = toIntExpression(400),
											effect = pushChoiceEffectWithTitle(
                                {
                                    choices = {
									-- Choice 3.1: HP 3
                                        {
                                            aiPriority = toIntExpression(400),
											effect =  ef_hp150,

											layout = layoutCard(
                                                {
                                                    title = "Tougher",
                                                    art = "art/treasures/t_green_potions_large",
                                                    xmlText=[[
													
<vlayout>
    <hlayout flexibleheight="1.8">

        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="AI gets +150 {health} at the start of the game and +2 Toughness per turn." fontsize="26" />
            </box>
        </vlayout>
    </hlayout>

</vlayout>
													]]
                                                }
                                            ),
                                            tags = {}
                                        },
										
										-- Choice 3.2: Combat 8
										{
                                            aiPriority = toIntExpression(400),
											effect =  createCardEffect(ef_combat8(), loc(oppPid, buffsPloc))
												.seq(createCardEffect(ef_combat8(), loc(nextOppPid, buffsPloc))),

											layout = layoutCard(
                                                {
                                                    title = "Hard Hitter",
                                                    art = "art/t_fighter_sweeping_blow",
                                                    xmlText=[[
													
<vlayout>
    <hlayout flexibleheight="1.8">

        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="AI gets {combat_8} each turn." fontsize="26" />
            </box>
        </vlayout>
    </hlayout>

</vlayout>
													]]
                                                }
                                            ),
                                            tags = {}
                                        },                                       
																					
									-- Choice 3.3: Econ 2
                                        {
                                            aiPriority = toIntExpression(400),
											effect =  createCardEffect(ef_econ3(), loc(oppPid, buffsPloc))
											.seq(createCardEffect(ef_econ3(), loc(nextOppPid, buffsPloc))),

											layout = layoutCard(
                                                {
                                                    title = "Money bags",
                                                    art = "art/t_ruby",
                                                    xmlText=[[
													
<vlayout>
    <hlayout flexibleheight="1.8">

        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="AI gets {gold_2} extra each turn and draws a card at the start of each turn." fontsize="26" />
            </box>
        </vlayout>
    </hlayout>

</vlayout>
													]]
                                                }
                                            ),
                                            tags = {}
                                        },
                                       
						-- Choice 1.4 - Large Random
                                        {
                                            aiPriority = toIntExpression(400),
											effect =  createCardEffect(ef_randombuff3(), loc(oppPid, buffsPloc))
											.seq(createCardEffect(ef_randombuff3(), loc(nextOppPid, buffsPloc))),

											layout = layoutCard(
                                                {
                                                    title = "Unpredictable",
                                                    art = "art/epicart/disappearing_act",
                                                    xmlText=[[
													
<vlayout>
    <hlayout flexibleheight="1.8">

        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="Each turn the AI will get one of these benefits:
15{health}, {combat_8}, {gold_2} and Draw 1,
Draw 2, +9 Toughness,
Force 1 Discard and 4 deal 4 direct damage." fontsize="22" />
            </box>
        </vlayout>
    </hlayout>

</vlayout>
													]]
                                                }
                                            ),
                                            tags = {}
                                        },
                                        										
                                    },
		upperTitle = "Choose wisely. You cannot undo your selection.",
		lowerTitle = "Or click outside the cards to go back to choose a different level of difficulty."
                                }
                        ),
                                            
											layout = layoutCard(
                                                {
                                                    title = "Tough challenge",
                                                    art = "art/treasures/t_cleric_elixir_blue_purple",
                                                    xmlText=[[
													
<vlayout>
    <hlayout flexibleheight="1.8">

        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="Give the AI
a large buff." fontsize="26" />
            </box>
        </vlayout>
    </hlayout>

</vlayout>
													]]
                                                }
                                            ),
                                            tags = {}
                                        },																					
     -- Choice 4: Multiple
                                          {
                                            aiPriority = toIntExpression(400),
											effect = pushChoiceEffectWithTitle(
                                {
                                    choices = {
									-- Choice 4.1 - All small
                                        {
                                            aiPriority = toIntExpression(400),
											effect =  ef_hp50
											.seq(createCardEffect(ef_combat3(), loc(oppPid, buffsPloc)))
												.seq(createCardEffect(ef_combat3(), loc(nextOppPid, buffsPloc)))
											.seq(createCardEffect(ef_econ1(), loc(oppPid, buffsPloc)))
											.seq(createCardEffect(ef_econ1(), loc(nextOppPid, buffsPloc))),

											layout = layoutCard(
                                                {
                                                    title = "Tough stuff",
                                                    art = "art/epicart/village_protector",
                                                    xmlText=[[
													
<vlayout>
    <hlayout flexibleheight="1.8">

        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="AI starts with +50{health} and each turn gains 
&lt;size=150%&gt;{combat_3}  {gold_1}" fontsize="24" />
            </box>
        </vlayout>
    </hlayout>

</vlayout>
													]]
                                                }
                                            ),
                                            tags = {}
                                        },
										
									-- Choice 4.2 - All moderate
                                        {
                                            aiPriority = toIntExpression(400),
											effect =  ef_hp100
											.seq(createCardEffect(ef_combat5(), loc(oppPid, buffsPloc)))
												.seq(createCardEffect(ef_combat5(), loc(nextOppPid, buffsPloc)))
											.seq(createCardEffect(ef_econ2(), loc(oppPid, buffsPloc)))
											.seq(createCardEffect(ef_econ2(), loc(nextOppPid, buffsPloc))),

											layout = layoutCard(
                                                {
                                                    title = "Tougher stuff",
                                                    art = "art/epicart/village_protector",
                                                    xmlText=[[
													
<vlayout>
    <hlayout flexibleheight="1.8">

        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="AI starts with +100{health} and each turn gains
&lt;size=150%&gt;{combat_5}  {gold_2}
&lt;size=100%&gt;and +1 Toughness" fontsize="24" />
            </box>
        </vlayout>
    </hlayout>
</vlayout>
			
			
													]]
                                                }
                                            ),
                                            tags = {}
                                        },                                      
																					
									-- Choice 4.3 - All large
                                        {
                                            aiPriority = toIntExpression(400),
											effect =  ef_hp150
											.seq(createCardEffect(ef_combat8(), loc(oppPid, buffsPloc)))
												.seq(createCardEffect(ef_combat8(), loc(nextOppPid, buffsPloc)))
											.seq(createCardEffect(ef_econ3(), loc(oppPid, buffsPloc)))
											.seq(createCardEffect(ef_econ3(), loc(nextOppPid, buffsPloc))),

											layout = layoutCard(
                                                {
                                                    title = "Toughest stuff",
                                                    art = "art/epicart/village_protector",
                                                    xmlText=[[
													
<vlayout>
    <hlayout flexibleheight="1.8">
        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="AI starts with +150{health} and each turn gains
&lt;size=150%&gt;{combat_8}  {gold_2}
&lt;size=100%&gt; +2 Toughness,
and Draw 1." fontsize="24" />
            </box>
        </vlayout>
    </hlayout>
</vlayout>
			
			
			
													]]
                                                }
                                            ),
                                            tags = {}
                                        },
                                       
-------
                                        										
                                    },
		upperTitle = "Choose wisely. You cannot undo your selection.",
		lowerTitle = "Or click outside the cards to go back to choose a different level of difficulty."
                                }
                        ),
                                            
											layout = layoutCard(
                                                {
                                                    title = "Deadly challenge",
                                                    art = "art/treasures/t_thief_elixir_white",
                                                    xmlText=[[
													
<vlayout>
    <hlayout flexibleheight="1.8">

        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="Give the AI
multiple buffs." fontsize="26" />
            </box>
        </vlayout>
    </hlayout>

</vlayout>
													]]
                                                }
                                            ),
                                            tags = {}
                                        }                                                                    
									},
		upperTitle = "Choose a modifier for a more challenging experience. ",
		lowerTitle = "You will then get to choose the value of the modifier to apply."
                                }

                        )
		,

        layoutFirst = createLayout({
            name = "Standard",
            art = "art/epicart/ceasefire",
			frame = "frames/generic_CardFrame",
            xmlText=[[
			<vlayout>
<hlayout flexiblewidth="1">
<text text="Normal mode.

AI consists of 2 standard heroes with a shared Health pool." fontsize="26"/>
</hlayout>
</vlayout>
			]] }) ,

        layoutSecond = createLayout({
            name = "Play hard",
            art = "art/epicart/stealthy_predator",
			frame = "frames/generic_CardFrame",
            xmlText=[[<vlayout>
<hlayout flexiblewidth="1">
<text text="Grant the AI extra Health, Damage, Gold or other effects
each turn." fontsize="26"/>
</hlayout>
</vlayout>			
			]]
			}),

        turn = 1
    })
end




-- lgnkstwrt Speech Effects
function lgnkstwrt_winlose_buff_def()

	local ef_win = showSpeechBubbleEffect({
								playerExpression=ownerPid,
								text="Grazi! Merci! Hold the applause!",
								waitForClick= constBoolExpression(false)
							})

	local ef_lose = showSpeechBubbleEffect({
								playerExpression=ownerPid,
								text="Practice makes perfect, they say.",
								waitForClick= constBoolExpression(false)
							})
	
		
return createGlobalBuff({
        id="lgnkstwrt_winlose",
        name = "AI WinLose",
        abilities = {
            createAbility({
                id="lgnkstwrt_winlose",
                trigger = onZeroHealthTrigger,
                effect = ifElseEffect(getPlayerHealth(ownerPid).gte(1), ef_win, nullEffect())
						.seq(ifElseEffect(getPlayerHealth(ownerPid).lte(0), ef_lose, nullEffect())),
				cost = noCost
				
            })
        },

    })
end

function lgnkstwrt_speech1_buff_def()		
return createGlobalBuff({
        id="lgnkstwrt_speech1",
        name = "lgnkstwrt 1",
        abilities = {
            createAbility({
                id="lgnkstwrt_speech1",
                trigger = deckShuffledTrigger,
                effect = showSpeechBubbleEffect({
								playerExpression=ownerPid,
								text="You couldn't carry a tune in a bucket!",
								waitForClick= constBoolExpression(false)
							}),
				cost = sacrificeSelf
				
            })
        },

    })
end

function lgnkstwrt_speech2_buff_def()		
return createGlobalBuff({
        id="lgnkstwrt_speech2",
        name = "lgnkstwrt 2",
        abilities = {
            createAbility({
                id="lgnkstwrt_speech2",
                trigger = onDiscardTrigger,
				-- check = 
                effect = showSpeechBubbleEffect({
								playerExpression=ownerPid,
								text="Encore! Encore!",
								waitForClick= constBoolExpression(false)
							}),
				cost = sacrificeSelf
				
            })
        },

    })
end

function lgnkstwrt_speech3_buff_def()		
return createGlobalBuff({
        id="lgnkstwrt_speech3",
        name = "lgnkstwrt 3",
        abilities = {
            createAbility({
                id="lgnkstwrt_speech3",
                trigger = onSacrificeTrigger,
				-- check = skillSacrificePloc
                effect = showSpeechBubbleEffect({
								playerExpression=oppPid,
								text="Sacrebleu! What'd you do?",
								waitForClick= constBoolExpression(false)
							}),
				cost = sacrificeSelf
				
            })
        },

    })
end

-- nudeltulpe Speech Effects
function nudeltulpe_winlose_buff_def()

	local ef_win = showSpeechBubbleEffect({
								playerExpression=ownerPid,
								text="Grrrr",
								waitForClick= constBoolExpression(false)
							})

	local ef_lose = showSpeechBubbleEffect({
								playerExpression=ownerPid,
								text="Grrrr",
								waitForClick= constBoolExpression(false)
							})
	
		
return createGlobalBuff({
        id="nudeltulpe_win",
        name = "AI Win",
        abilities = {
            createAbility({
                id="nudeltulpe_winlose",
                trigger = onZeroHealthTrigger,
                effect = ifElseEffect(getPlayerHealth(ownerPid).gte(1), ef_win, nullEffect())
						.seq(ifElseEffect(getPlayerHealth(ownerPid).lte(0), ef_lose, nullEffect())),
				cost = noCost
				
            })
        },

    })
end


--Jigmelingpa Speech
function jigmelingpa_winlose_buff_def()

	local ef_win = showSpeechBubbleEffect({
								playerExpression=ownerPid,
								text="Time to light up some Old Toby!",
								waitForClick= constBoolExpression(false)
							})

	local ef_lose = showSpeechBubbleEffect({
								playerExpression=ownerPid,
								text="PO-TA-TOES!",
								waitForClick= constBoolExpression(false)
							})
	
		
return createGlobalBuff({
        id="jigmelingpa_win",
        name = "AI Win",
        abilities = {
            createAbility({
                id="jigmelingpa_winlose",
                trigger = onZeroHealthTrigger,
				aiPriority = toIntExpression(-300),
                effect = ifElseEffect(getPlayerHealth(ownerPid).gte(1), ef_win, nullEffect())
						.seq(ifElseEffect(getPlayerHealth(ownerPid).lte(0), ef_lose, nullEffect())),
				cost = noCost
				
            })
        },

    })
end

--Scrapforce Speech
function scrapforce_winlose_buff_def()

	local ef_win = showSpeechBubbleEffect({
								playerExpression=ownerPid,
								text="Scrap it and tap it, baby!",
								waitForClick= constBoolExpression(false)
							})

	local ef_lose = showSpeechBubbleEffect({
								playerExpression=ownerPid,
								text="Oof! Right in the sackforce!",
								waitForClick= constBoolExpression(false)
							})
	
		
return createGlobalBuff({
        id="scrapforce_win",
        name = "AI Win",
        abilities = {
            createAbility({
                id="scrapforce_winlose",
                trigger = onZeroHealthTrigger,
                effect = ifElseEffect(getPlayerHealth(ownerPid).gte(1), ef_win, nullEffect())
						.seq(ifElseEffect(getPlayerHealth(ownerPid).lte(0), ef_lose, nullEffect())),
				cost = noCost
				
            })
        },

    })
end


--BTW Speech
function BTW_winlose_buff_def()

	local ef_win = showSpeechBubbleEffect({
								playerExpression=ownerPid,
								text="Like a true nature's child. We are Bjorn, Bjorn-Toby Wild.",
								waitForClick= constBoolExpression(false)
							})

	local ef_lose = showSpeechBubbleEffect({
								playerExpression=ownerPid,
								text="We can climb so high. I never wanna die.",
								waitForClick= constBoolExpression(false)
							})
	
		
return createGlobalBuff({
        id="BTW_win",
        name = "AI Win",
        abilities = {
            createAbility({
                id="BTW_winlose",
                trigger = onZeroHealthTrigger,
                effect = ifElseEffect(getPlayerHealth(ownerPid).gte(1), ef_win, nullEffect())
						.seq(ifElseEffect(getPlayerHealth(ownerPid).lte(0), ef_lose, nullEffect())),
				cost = noCost
				
            })
        },

    })
end

--Wombatman Speech
function Wombatman_winlose_buff_def()

	local ef_win = showSpeechBubbleEffect({
								playerExpression=ownerPid,
								text="This forest just showed you that it's full of critters ready to believe in good.",
								waitForClick= constBoolExpression(false)
							})

	local ef_lose = showSpeechBubbleEffect({
								playerExpression=ownerPid,
								text="Vengeance won't change the past. I have to become more.",
								waitForClick= constBoolExpression(false)
							})
	
		
return createGlobalBuff({
        id="Wombatman_win",
        name = "AI Win",
        abilities = {
            createAbility({
                id="Wombatman_winlose",
                trigger = onZeroHealthTrigger,
                effect = ifElseEffect(getPlayerHealth(ownerPid).gte(1), ef_win, nullEffect())
						.seq(ifElseEffect(getPlayerHealth(ownerPid).lte(0), ef_lose, nullEffect())),
				cost = noCost
				
            })
        },

    })
end

--Elfred Nobel Speech
function Elfred_Nobel_winlose_buff_def()

	local ef_win = showSpeechBubbleEffect({
								playerExpression=ownerPid,
								text="Contentment is the only real wealth.",
								waitForClick= constBoolExpression(false)
							})

	local ef_lose = showSpeechBubbleEffect({
								playerExpression=ownerPid,
								text="Good wishes alone will not ensure peace.",
								waitForClick= constBoolExpression(false)
							})
	
		
return createGlobalBuff({
        id="Elfred_Nobel_win",
        name = "AI Win",
        abilities = {
            createAbility({
                id="Elfred_Nobel_winlose",
                trigger = onZeroHealthTrigger,
                effect = ifElseEffect(getPlayerHealth(ownerPid).gte(1), ef_win, nullEffect())
						.seq(ifElseEffect(getPlayerHealth(ownerPid).lte(0), ef_lose, nullEffect())),
				cost = noCost
				
            })
        },

    })
end

--Doc_Orc Speech
function Doc_Orc_winlose_buff_def()

	local ef_win = showSpeechBubbleEffect({
								playerExpression=ownerPid,
								text="The power of the sun, in the palm of my hand.",
								waitForClick= constBoolExpression(false)
							})

	local ef_lose = showSpeechBubbleEffect({
								playerExpression=ownerPid,
								text="My dream is dead.",
								waitForClick= constBoolExpression(false)
							})
	
		
return createGlobalBuff({
        id="Doc_Orc_win",
        name = "AI Win",
        abilities = {
            createAbility({
                id="Doc_Orc_winlose",
                trigger = onZeroHealthTrigger,
                effect = ifElseEffect(getPlayerHealth(ownerPid).gte(1), ef_win, nullEffect())
						.seq(ifElseEffect(getPlayerHealth(ownerPid).lte(0), ef_lose, nullEffect())),
				cost = noCost
				
            })
        },

    })
end

--Boudicarnage Speech
function Boudicarnage_winlose_buff_def()

	local ef_win = showSpeechBubbleEffect({
								playerExpression=ownerPid,
								text="See your gods tremble and fall before the wrath of Boudica!",
								waitForClick= constBoolExpression(false)
							})

	local ef_lose = showSpeechBubbleEffect({
								playerExpression=ownerPid,
								text="…",
								waitForClick= constBoolExpression(false)
							})
	
		
return createGlobalBuff({
        id="Boudicarnage_win",
        name = "AI Win",
        abilities = {
            createAbility({
                id="Boudicarnage_winlose",
                trigger = onZeroHealthTrigger,
                effect = ifElseEffect(getPlayerHealth(ownerPid).gte(1), ef_win, nullEffect())
						.seq(ifElseEffect(getPlayerHealth(ownerPid).lte(0), ef_lose, nullEffect())),
				cost = noCost
				
            })
        },

    })
end


--generic speech

function cleric_winlose_buff_def()

	local ef_win = showSpeechBubbleEffect({
								playerExpression=ownerPid,
								text="Ah. God grant me time to rest.",
								waitForClick= constBoolExpression(false)
							})

	local ef_lose = showSpeechBubbleEffect({
								playerExpression=ownerPid,
								text="Where were you, O Lord?",
								waitForClick= constBoolExpression(false)
							})
	
	
return createGlobalBuff({
        id="cleric_winlose",
        name = "AI WinLose",
        abilities = {
            createAbility({
                id="cleric_winlose",
                trigger = onZeroHealthTrigger,
                effect = ifElseEffect(getPlayerHealth(ownerPid).gte(1), ef_win, nullEffect())
						.seq(ifElseEffect(getPlayerHealth(ownerPid).lte(0), ef_lose, nullEffect())),
				cost = noCost
				
            })
        },

    })
end

function rando1_winlose_buff_def()

	local ef_win = showSpeechBubbleEffect({
								playerExpression=ownerPid,
								text="Everything you've heard about me is true.",
								waitForClick= constBoolExpression(false)
							})

	local ef_lose = showSpeechBubbleEffect({
								playerExpression=ownerPid,
								text="Why you slimy, double-crossing, no-good swindler.",
								waitForClick= constBoolExpression(false)
							})
	
return createGlobalBuff({
        id="rando1_winlose",
        name = "AI WinLose",
        abilities = {
            createAbility({
                id="rando1_winlose",
                trigger = onZeroHealthTrigger,
				aiPriority = toIntExpression(-300),
                effect = ifElseEffect(getPlayerHealth(ownerPid).gte(1), ef_win, nullEffect())
						.seq(ifElseEffect(getPlayerHealth(ownerPid).lte(0), ef_lose, nullEffect())),
				cost = noCost
				
            })
        },

    })
end

function rando2_winlose_buff_def()

	local ef_win = showSpeechBubbleEffect({
								playerExpression=ownerPid,
								text="They drew first blood, not me.",
								waitForClick= constBoolExpression(false)
							})

	local ef_lose = showSpeechBubbleEffect({
								playerExpression=ownerPid,
								text="Nothing is over. Nothing.",
								waitForClick= constBoolExpression(false)
							})
	
return createGlobalBuff({
        id="rando2_winlose",
        name = "AI WinLose",
        abilities = {
            createAbility({
                id="rando2_winlose",
                trigger = onZeroHealthTrigger,
                effect = ifElseEffect(getPlayerHealth(ownerPid).gte(1), ef_win, nullEffect())
						.seq(ifElseEffect(getPlayerHealth(ownerPid).lte(0), ef_lose, nullEffect())),
				cost = noCost
				
            })
        },

    })
end

function morgana_winlose_buff_def()

	local ef_win = showSpeechBubbleEffect({
								playerExpression=ownerPid,
								text="Goodness, gracious! Great balls of fire!",
								waitForClick= constBoolExpression(false)
							})

	local ef_lose = showSpeechBubbleEffect({
								playerExpression=ownerPid,
								text="Fizzle sticks!",
								waitForClick= constBoolExpression(false)
							})
	
		
return createGlobalBuff({
        id="morgana_winlose",
        name = "AI WinLose",
        abilities = {
            createAbility({
                id="morgana_winlose",
                trigger = onZeroHealthTrigger,
                effect = ifElseEffect(getPlayerHealth(ownerPid).gte(1), ef_win, nullEffect())
						.seq(ifElseEffect(getPlayerHealth(ownerPid).lte(0), ef_lose, nullEffect())),
				cost = noCost
				
            })
        },

    })
end

function illegalas_winlose_buff_def()

	local ef_win = showSpeechBubbleEffect({
								playerExpression=ownerPid,
								text="The enemy is diminished.",
								waitForClick= constBoolExpression(false)
							})

	local ef_lose = showSpeechBubbleEffect({
								playerExpression=ownerPid,
								text="A red sun rises, blood has been spilled this night.",
								waitForClick= constBoolExpression(false)
							})
							.seq(showSpeechBubbleEffect({
								playerExpression=ownerPid,
								text="Oh, wait. It's my blood...",
								waitForClick= constBoolExpression(false)
							}))
	
		
return createGlobalBuff({
        id="illegalas_winlose",
        name = "AI WinLose",
        abilities = {
            createAbility({
                id="illegalas_winlose",
                trigger = onZeroHealthTrigger,
                effect = ifElseEffect(getPlayerHealth(ownerPid).gte(1), ef_win, nullEffect())
						.seq(ifElseEffect(getPlayerHealth(ownerPid).lte(0), ef_lose, nullEffect())),
				cost = noCost
				
            })
        },

    })
end

function drawback_winlose_buff_def()

	local ef_win = showSpeechBubbleEffect({
								playerExpression=ownerPid,
								text="Victory is mine!",
								waitForClick= constBoolExpression(false)
							})

	local ef_lose = showSpeechBubbleEffect({
								playerExpression=ownerPid,
								text="'Tis but a scratch.",
								waitForClick= constBoolExpression(false)
							})

		
return createGlobalBuff({
        id="drawback_winlose",
        name = "AI WinLose",
        abilities = {
            createAbility({
                id="drawback_winlose",
                trigger = onZeroHealthTrigger,
                effect = ifElseEffect(getPlayerHealth(ownerPid).gte(1), ef_win, nullEffect())
						.seq(ifElseEffect(getPlayerHealth(ownerPid).lte(0), ef_lose, nullEffect())),
				cost = noCost
				
            })
        },

    })
end


--custom monk tao lu Reset
    local dualmonktaoresetbuff = createGlobalBuff({
        id="dualmonktaoresetbuff",
        name = "Dual Monk Tao Reset",
        abilities = {
            createAbility({
                id="dualmonktaoresetbuff",
				trigger = endOfTurnTrigger,
                effect = gainCustomValueEffect(getCustomValue(currentPid).negate()),
				
            })
        }
    })

-- Ancestries Base
	local ef_orc = createCardEffect(orc_battle_rage_carddef(), loc(ownerPid, skillsPloc))
			.seq(createCardEffect(orc_bully_carddef(), loc(ownerPid, deckPloc)))
			.seq(createCardEffect(orc_ragged_blade_carddef(), loc(ownerPid, deckPloc)))
			.seq(gainMaxHealthEffect(ownerPid, const(4))).seq(healPlayerEffect(ownerPid,4))
			.seq(createCardEffect(orc_buff(), loc(ownerPid, buffsPloc)))

	local ef_elf = createCardEffect(elf_elven_wisdom_carddef(), loc(ownerPid, skillsPloc))
			.seq(createCardEffect(elf_sunstone_brooch_carddef(), loc(ownerPid, asidePloc)))
             .seq(createCardEffect(elf_elven_grace_carddef(), loc(ownerPid, asidePloc)))
             .seq(createCardEffect(elf_buff(), loc(ownerPid, buffsPloc)))
			 .seq(gainMaxHealthEffect(ownerPid, const(-8))).seq(healPlayerEffect(ownerPid,-8))

	local ef_smallfolk = createCardEffect(smallfolk_hide_carddef(), loc(ownerPid, skillsPloc))
			.seq(createCardEffect(smallfolk_friendly_banter_carddef(), loc(ownerPid, asidePloc)))
             .seq(createCardEffect(smallfolk_burgle_carddef(), loc(ownerPid, asidePloc)))
             .seq(createCardEffect(smallfolk_buff(), loc(ownerPid, buffsPloc)))
			 .seq(gainMaxHealthEffect(ownerPid, const(-15))).seq(healPlayerEffect(ownerPid,-15))

	local ef_dwarf = createCardEffect(dwarf_hammer_strike_carddef(), loc(ownerPid, skillsPloc))
			.seq(createCardEffect(dwarf_hammer_carddef(), loc(ownerPid, asidePloc)))
             .seq(createCardEffect(dwarf_pick_carddef(), loc(ownerPid, asidePloc)))
			 .seq(gainMaxHealthEffect(ownerPid, const(6))).seq(healPlayerEffect(ownerPid,6))

	local ef_ogre = createCardEffect(ogre_crush_you_carddef(), loc(ownerPid, skillsPloc))
			.seq(createCardEffect(ogre_shiny_rock_carddef(), loc(ownerPid, asidePloc)))
             .seq(createCardEffect(ogre_war_club_carddef(), loc(ownerPid, asidePloc)))
             .seq(createCardEffect(ogre_buff(), loc(ownerPid, buffsPloc)))
			 .seq(gainMaxHealthEffect(ownerPid, const(10))).seq(healPlayerEffect(ownerPid,10))
			 
local ef_halfdemon = createCardEffect(half_demon_hellfire_carddef(), loc(ownerPid, skillsPloc))
			.seq(createCardEffect(half_demon_demon_blood_carddef(), loc(ownerPid, asidePloc)))
             .seq(createCardEffect(half_demon_demonic_strength_carddef(), loc(ownerPid, asidePloc)))
             .seq(createCardEffect(half_demon_buff(), loc(ownerPid, buffsPloc)))
			 .seq(gainMaxHealthEffect(ownerPid, const(5))).seq(healPlayerEffect(ownerPid,5))
			 

--Rando Ancestries
	local ef_rando_smallfolk = ef_smallfolk
			.seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardType(clericType)).count().gte(1),setPlayerAvatarEffect("smallfolk_cleric_male_01", ownerPid),nullEffect()))
			.seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardType(fighterType)).count().gte(1),setPlayerAvatarEffect("smallfolk_fighter_male_01", ownerPid),nullEffect()))
			.seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardType(thiefType)).count().gte(1),setPlayerAvatarEffect("smallfolk_thief_male_01", ownerPid),nullEffect()))
			.seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardType(wizardType)).count().gte(1),setPlayerAvatarEffect("smallfolk_wizard_male_01", ownerPid),nullEffect()))
			.seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardType(rangerType)).count().gte(1),setPlayerAvatarEffect("smallfolk_ranger_male_01", ownerPid),nullEffect()))
			.seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardType(alchemistType)).count().gte(1),setPlayerAvatarEffect("smallfolk_alchemist_male_01", ownerPid),nullEffect()))
			.seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardType(barbarianType)).count().gte(1),setPlayerAvatarEffect("smallfolk_barbarian_male_01", ownerPid),nullEffect()))
			.seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardType(bardType)).count().gte(1),setPlayerAvatarEffect("assassin_flipped", ownerPid),nullEffect()))
			.seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardType(druidType)).count().gte(1),setPlayerAvatarEffect("assassin_flipped", ownerPid),nullEffect()))
			.seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardType(monkType)).count().gte(1),setPlayerAvatarEffect("assassin_flipped", ownerPid),nullEffect()))
			.seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardType(necromancerType)).count().gte(1),setPlayerAvatarEffect("assassin_flipped", ownerPid),nullEffect()))

	local ef_rando_ogre = ef_ogre
			.seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardType(clericType)).count().gte(1),setPlayerAvatarEffect("ogre_cleric_male_01", ownerPid),nullEffect()))
			.seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardType(fighterType)).count().gte(1),setPlayerAvatarEffect("ogre_fighter_male_01", ownerPid),nullEffect()))
			.seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardType(thiefType)).count().gte(1),setPlayerAvatarEffect("ogre_thief_male_01", ownerPid),nullEffect()))
			.seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardType(wizardType)).count().gte(1),setPlayerAvatarEffect("ogre_wizard_male_01", ownerPid),nullEffect()))
			.seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardType(rangerType)).count().gte(1),setPlayerAvatarEffect("ogre_ranger_male_01", ownerPid),nullEffect()))
			.seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardType(alchemistType)).count().gte(1),setPlayerAvatarEffect("ogre_alchemist_male_01", ownerPid),nullEffect()))
			.seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardType(barbarianType)).count().gte(1),setPlayerAvatarEffect("ogre_barbarian_male_01", ownerPid),nullEffect()))
			.seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardType(bardType)).count().gte(1),setPlayerAvatarEffect("assassin_flipped", ownerPid),nullEffect()))
			.seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardType(druidType)).count().gte(1),setPlayerAvatarEffect("assassin_flipped", ownerPid),nullEffect()))
			.seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardType(monkType)).count().gte(1),setPlayerAvatarEffect("assassin_flipped", ownerPid),nullEffect()))
			.seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardType(necromancerType)).count().gte(1),setPlayerAvatarEffect("assassin_flipped", ownerPid),nullEffect()))

local ef_rando_dwarf = ef_dwarf
			.seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardType(clericType)).count().gte(1),setPlayerAvatarEffect("dwarf_cleric_male_01", ownerPid),nullEffect()))
			.seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardType(fighterType)).count().gte(1),setPlayerAvatarEffect("dwarf_fighter_male_01", ownerPid),nullEffect()))
			.seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardType(thiefType)).count().gte(1),setPlayerAvatarEffect("dwarf_thief_male_01", ownerPid),nullEffect()))
			.seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardType(wizardType)).count().gte(1),setPlayerAvatarEffect("dwarf_wizard_male_01", ownerPid),nullEffect()))
			.seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardType(rangerType)).count().gte(1),setPlayerAvatarEffect("dwarf_ranger_male_01", ownerPid),nullEffect()))
			.seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardType(alchemistType)).count().gte(1),setPlayerAvatarEffect("dwarf_alchemist_male_01", ownerPid),nullEffect()))
			.seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardType(barbarianType)).count().gte(1),setPlayerAvatarEffect("dwarf_barbarian_male_01", ownerPid),nullEffect()))
			.seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardType(bardType)).count().gte(1),setPlayerAvatarEffect("assassin_flipped", ownerPid),nullEffect()))
			.seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardType(druidType)).count().gte(1),setPlayerAvatarEffect("assassin_flipped", ownerPid),nullEffect()))
			.seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardType(monkType)).count().gte(1),setPlayerAvatarEffect("assassin_flipped", ownerPid),nullEffect()))
			.seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardType(necromancerType)).count().gte(1),setPlayerAvatarEffect("assassin_flipped", ownerPid),nullEffect()))
			
local ef_rando_orc = ef_orc
			.seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardType(clericType)).count().gte(1),setPlayerAvatarEffect("orc_cleric_male_01", ownerPid),nullEffect()))
			.seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardType(fighterType)).count().gte(1),setPlayerAvatarEffect("orc_fighter_male_01", ownerPid),nullEffect()))
			.seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardType(thiefType)).count().gte(1),setPlayerAvatarEffect("orc_thief_male_01", ownerPid),nullEffect()))
			.seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardType(wizardType)).count().gte(1),setPlayerAvatarEffect("orc_wizard_male_01", ownerPid),nullEffect()))
			.seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardType(rangerType)).count().gte(1),setPlayerAvatarEffect("orc_ranger_male_01", ownerPid),nullEffect()))
			.seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardType(alchemistType)).count().gte(1),setPlayerAvatarEffect("orc_alchemist_male_01", ownerPid),nullEffect()))
			.seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardType(barbarianType)).count().gte(1),setPlayerAvatarEffect("orc_barbarian_male_01", ownerPid),nullEffect()))
			.seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardType(bardType)).count().gte(1),setPlayerAvatarEffect("assassin_flipped", ownerPid),nullEffect()))
			.seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardType(druidType)).count().gte(1),setPlayerAvatarEffect("assassin_flipped", ownerPid),nullEffect()))
			.seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardType(monkType)).count().gte(1),setPlayerAvatarEffect("assassin_flipped", ownerPid),nullEffect()))
			.seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardType(necromancerType)).count().gte(1),setPlayerAvatarEffect("assassin_flipped", ownerPid),nullEffect()))


local ef_rando_elf = ef_elf
			.seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardType(clericType)).count().gte(1),setPlayerAvatarEffect("elf_cleric_male_01", ownerPid),nullEffect()))
			.seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardType(fighterType)).count().gte(1),setPlayerAvatarEffect("elf_fighter_male_01", ownerPid),nullEffect()))
			.seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardType(thiefType)).count().gte(1),setPlayerAvatarEffect("elf_thief_male_01", ownerPid),nullEffect()))
			.seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardType(wizardType)).count().gte(1),setPlayerAvatarEffect("elf_wizard_male_01", ownerPid),nullEffect()))
			.seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardType(rangerType)).count().gte(1),setPlayerAvatarEffect("elf_ranger_male_01", ownerPid),nullEffect()))
			.seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardType(alchemistType)).count().gte(1),setPlayerAvatarEffect("elf_alchemist_male_01", ownerPid),nullEffect()))
			.seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardType(barbarianType)).count().gte(1),setPlayerAvatarEffect("elf_barbarian_male_01", ownerPid),nullEffect()))
			.seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardType(bardType)).count().gte(1),setPlayerAvatarEffect("assassin_flipped", ownerPid),nullEffect()))
			.seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardType(druidType)).count().gte(1),setPlayerAvatarEffect("assassin_flipped", ownerPid),nullEffect()))
			.seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardType(monkType)).count().gte(1),setPlayerAvatarEffect("assassin_flipped", ownerPid),nullEffect()))
			.seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardType(necromancerType)).count().gte(1),setPlayerAvatarEffect("assassin_flipped", ownerPid),nullEffect()))

	local ef_rando_halfdemon = ef_halfdemon
			.seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardType(clericType)).count().gte(1),setPlayerAvatarEffect("halfdemon_cleric_male_01", ownerPid),nullEffect()))
			.seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardType(fighterType)).count().gte(1),setPlayerAvatarEffect("halfdemon_fighter_male_01", ownerPid),nullEffect()))
			.seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardType(thiefType)).count().gte(1),setPlayerAvatarEffect("halfdemon_thief_male_01", ownerPid),nullEffect()))
			.seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardType(wizardType)).count().gte(1),setPlayerAvatarEffect("halfdemon_wizard_male_01", ownerPid),nullEffect()))
			.seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardType(rangerType)).count().gte(1),setPlayerAvatarEffect("halfdemon_ranger_male_01", ownerPid),nullEffect()))
			.seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardType(alchemistType)).count().gte(1),setPlayerAvatarEffect("halfdemon_alchemist_male_01", ownerPid),nullEffect()))
			.seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardType(barbarianType)).count().gte(1),setPlayerAvatarEffect("halfdemon_barbarian_male_01", ownerPid),nullEffect()))
			.seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardType(bardType)).count().gte(1),setPlayerAvatarEffect("assassin_flipped", ownerPid),nullEffect()))
			.seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardType(druidType)).count().gte(1),setPlayerAvatarEffect("assassin_flipped", ownerPid),nullEffect()))
			.seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardType(monkType)).count().gte(1),setPlayerAvatarEffect("assassin_flipped", ownerPid),nullEffect()))
			.seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardType(necromancerType)).count().gte(1),setPlayerAvatarEffect("assassin_flipped", ownerPid),nullEffect()))
			
local ef_rando_ancestry = randomEffect({
						valueItem(1, nullEffect()),
                        valueItem(1, ef_rando_orc),
						valueItem(1, ef_rando_elf),
						valueItem(1, ef_rando_ogre),
						valueItem(1, ef_rando_dwarf),
						valueItem(1, ef_rando_smallfolk),
						valueItem(1, ef_rando_halfdemon),
						})
	

-- Thelonious levels

		local ef4_Thelonious = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("monk_favored_technique")))
				.seq(createCardEffect(monk_practiced_technique_carddef(), loc(ownerPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef5_Thelonious = sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("ruby")).take(1))
				.seq(createCardEffect(monk_staff_of_meditation_carddef(), loc(ownerPid, asidePloc)))
				.seq(sacrificeSelf())

		local ef6_Thelonious = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("monk_practiced_technique")))
				.seq(createCardEffect(monk_masterful_technique_carddef(), loc(ownerPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef7_Thelonious = createCardEffect(monk_ring_of_1000_palms_carddef(), loc(ownerPid, asidePloc))
				.seq(sacrificeSelf())

		local ef8_Thelonious = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("monk_qi")))
				.seq(createCardEffect(monk_jing_carddef(), loc(ownerPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef9_Thelonious = createCardEffect(monk_slippers_of_the_crane_carddef(), loc(ownerPid, skillsPloc))
				.seq(sacrificeSelf())

		local ef10_Thelonious = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("monk_jing")))
				.seq(createCardEffect(monk_qigong_carddef(), loc(ownerPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef11_Thelonious = createCardEffect(monk_tonfas_of_balance_carddef(), loc(ownerPid, asidePloc))
				.seq(sacrificeSelf())

		local ef12_Thelonious = gainMaxHealthEffect(ownerPid, const(9))
				.seq(healPlayerEffect(ownerPid,9))				.seq(sacrificeSelf())

		local ef13_Thelonious = createCardEffect(monk_amulet_of_resolve_carddef(), loc(ownerPid, reservePloc))
				.seq(sacrificeSelf())
		
		local ef14_Thelonious = gainMaxHealthEffect(ownerPid, const(9))
				.seq(healPlayerEffect(ownerPid,9))				.seq(sacrificeSelf())
		
		local ef15_Thelonious = sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("monk_spring_blossom")).take(1))
				.seq(createCardEffect(monk_resplendent_blossom_carddef(), loc(ownerPid, asidePloc)))
				.seq(sacrificeSelf())
		
		local ef16_Thelonious = gainMaxHealthEffect(ownerPid, const(9)).seq(healPlayerEffect(ownerPid,9)).seq(sacrificeSelf())
		
		local ef17_Thelonious = createCardEffect(monk_tranquil_wind_carddef(), loc(ownerPid, reservePloc)).seq(sacrificeSelf())

		local ef18_Thelonious = gainMaxHealthEffect(ownerPid, const(9)).seq(healPlayerEffect(ownerPid,9)).seq(sacrificeSelf())	

local ef_thelonious_start = showSpeechBubbleEffect({playerExpression=ownerPid, text="Ohm… CawCaw!", waitForClick= constBoolExpression(false)})


	local ef_thelonious = 
			setPlayerNameEffect("Thelonious", ownerPid)
			.seq(setPlayerAvatarEffect("monk_01_2", ownerPid))
			.seq(gainMaxHealthEffect(ownerPid, const(59)))
				.seq(healPlayerEffect(ownerPid,59))
			.seq(createCardEffect(monk_favored_technique_carddef(), loc(ownerPid, skillsPloc)))
			.seq(createCardEffect(monk_qi_carddef(), loc(ownerPid, skillsPloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(ruby_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(monk_spring_blossom_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(monk_spring_blossom_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(monk_spring_blossom_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(monk_spring_blossom_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(monk_spring_blossom_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(monk_striking_cobra_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(monk_serene_wind_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(dualmonktaoresetbuff, loc(ownerPid, buffsPloc)))
			
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(4), ef4_Thelonious, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(5), ef5_Thelonious, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(6), ef6_Thelonious, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(7), ef7_Thelonious, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(8), ef8_Thelonious, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(9), ef9_Thelonious, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(10), ef10_Thelonious, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(11), ef11_Thelonious, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(12), ef12_Thelonious, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(13), ef13_Thelonious, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(14), ef14_Thelonious, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(15), ef15_Thelonious, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(16), ef16_Thelonious, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(17), ef17_Thelonious, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(18), ef18_Thelonious, nullEffect()))
			.seq(moveTarget(loc(ownerPid, deckPloc)).apply(selectLoc(loc(ownerPid, asidePloc))))
			.seq(shuffleEffect(loc(ownerPid, deckPloc)))
			--.seq(drawCardsEffect(3))
			.seq(ef_thelonious_start)
			--.seq(createCardEffect(thelonious_winlose_buff_def(), loc(ownerPid, buffsPloc)))
			

-- Boudicarnage levels

		local ef4_Boudicarnage  = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("barbarian_inner_rage")))
				.seq(createCardEffect(barbarian_flaring_rage_carddef(), loc(ownerPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef5_Boudicarnage  = sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("barbarian_headbutt")).take(1))
				.seq(createCardEffect(barbarian_serrated_hand_axe_carddef(), loc(ownerPid, asidePloc)))
				.seq(sacrificeSelf())

		local ef6_Boudicarnage  = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("barbarian_flaring_rage")))
				.seq(createCardEffect(barbarian_fiery_rage_carddef(), loc(ownerPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef7_Boudicarnage  = createCardEffect(barbarian_flail_carddef(), loc(ownerPid, asidePloc))
				.seq(sacrificeSelf())

		local ef8_Boudicarnage  = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("barbarian_roar")))
				.seq(createCardEffect(barbarian_battle_cry_carddef(), loc(ownerPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef9_Boudicarnage  = createCardEffect(barbarian_razor_bracers_carddef(), loc(ownerPid, skillsPloc))
				.seq(sacrificeSelf())

		local ef10_Boudicarnage  = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("barbarian_battle_cry")))
				.seq(createCardEffect(barbarian_battle_roar_carddef(), loc(ownerPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef11_Boudicarnage  = createCardEffect(barbarian_crushed_coin_carddef(), loc(ownerPid, asidePloc))
				.seq(sacrificeSelf())

		local ef12_Boudicarnage  = gainMaxHealthEffect(ownerPid, const(10))
				.seq(healPlayerEffect(ownerPid,10))				.seq(sacrificeSelf())

		local ef13_Boudicarnage  = createCardEffect(barbarian_earthshaker_carddef(), loc(ownerPid, reservePloc))
				.seq(sacrificeSelf())
		
		local ef14_Boudicarnage  = gainMaxHealthEffect(ownerPid, const(10))
				.seq(healPlayerEffect(ownerPid,10))				.seq(sacrificeSelf())
		
		local ef15_Boudicarnage  = sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("barbarian_headbutt")))
				.seq(createCardEffect(barbarian_shattering_headbutt_carddef(), loc(ownerPid, asidePloc)))
				.seq(sacrificeSelf())
		
		local ef16_Boudicarnage  = gainMaxHealthEffect(ownerPid, const(10)).seq(healPlayerEffect(ownerPid,10)).seq(sacrificeSelf())
		
		local ef17_Boudicarnage  = createCardEffect(barbarian_seething_spear_carddef(), loc(ownerPid, reservePloc)).seq(sacrificeSelf())

		local ef18_Boudicarnage  = gainMaxHealthEffect(ownerPid, const(10)).seq(healPlayerEffect(ownerPid,10)).seq(sacrificeSelf())	

local ef_Boudicarnage_start = showSpeechBubbleEffect({playerExpression=ownerPid, text="They are no match for our fierce hearts.", waitForClick= constBoolExpression(false)})

	local ef_Boudicarnage = 
			setPlayerNameEffect("Boudicarnage", ownerPid)
			.seq(setPlayerAvatarEffect("halfdemon_barbarian_female_01", ownerPid))
			.seq(gainMaxHealthEffect(ownerPid, const(62)))
			.seq(healPlayerEffect(ownerPid,62))
			.seq(createCardEffect(barbarian_inner_rage_carddef(), loc(ownerPid, skillsPloc)))
			.seq(createCardEffect(barbarian_roar_carddef(), loc(ownerPid, skillsPloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(ruby_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(barbarian_hand_axe_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(barbarian_hand_axe_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(barbarian_plunder_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(barbarian_headbutt_carddef(), loc(ownerPid, asidePloc)))
			.seq(ef_halfdemon)
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(4), ef4_Boudicarnage, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(5), ef5_Boudicarnage, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(6), ef6_Boudicarnage, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(7), ef7_Boudicarnage, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(8), ef8_Boudicarnage, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(9), ef9_Boudicarnage, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(10), ef10_Boudicarnage, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(11), ef11_Boudicarnage, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(12), ef12_Boudicarnage, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(13), ef13_Boudicarnage, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(14), ef14_Boudicarnage, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(15), ef15_Boudicarnage, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(16), ef16_Boudicarnage, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(17), ef17_Boudicarnage, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(18), ef18_Boudicarnage, nullEffect()))
			.seq(moveTarget(loc(ownerPid, deckPloc)).apply(selectLoc(loc(ownerPid, asidePloc))))
			.seq(shuffleEffect(loc(ownerPid, deckPloc)))
			--.seq(drawCardsEffect(3))
			.seq(ef_Boudicarnage_start)
			.seq(createCardEffect(Boudicarnage_winlose_buff_def(), loc(ownerPid, buffsPloc)))

-- Doc_Orc levels

		local ef4_Doc_Orc  = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("alchemist_reflect")))
				.seq(createCardEffect(alchemist_refraction_carddef(), loc(ownerPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef5_Doc_Orc  = sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("philosophers_stone")).take(1))
				.seq(createCardEffect(alchemist_fools_gold_carddef(), loc(ownerPid, asidePloc)))
				.seq(sacrificeSelf())

		local ef6_Doc_Orc  = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("alchemist_refraction")))
				.seq(createCardEffect(alchemist_prismatic_dispersion_carddef(), loc(ownerPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef7_Doc_Orc  = createCardEffect(alchemist_crucible_carddef(), loc(ownerPid, asidePloc))
				.seq(sacrificeSelf())

		local ef8_Doc_Orc  = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("alchemist_transmutation")))
				.seq(createCardEffect(alchemist_transmogrification_carddef(), loc(ownerPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef9_Doc_Orc  = createCardEffect(alchemist_spectrum_spectacles_carddef(), loc(ownerPid, skillsPloc))
				.seq(sacrificeSelf())

		local ef10_Doc_Orc  = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("alchemist_transmogrification")))
				.seq(createCardEffect(alchemist_major_transmogrification_carddef(), loc(ownerPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef11_Doc_Orc  = createCardEffect(alchemist_alchemy_powders_carddef(), loc(ownerPid, asidePloc))
				.seq(sacrificeSelf())

		local ef12_Doc_Orc  = gainMaxHealthEffect(ownerPid, const(6))
				.seq(healPlayerEffect(ownerPid,6))				.seq(sacrificeSelf())

		local ef13_Doc_Orc  = createCardEffect(alchemist_fireworks_carddef(), loc(ownerPid, reservePloc))
				.seq(sacrificeSelf())
		
		local ef14_Doc_Orc  = gainMaxHealthEffect(ownerPid, const(6))
				.seq(healPlayerEffect(ownerPid,6))				.seq(sacrificeSelf())
		
		local ef15_Doc_Orc  = sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("alchemist_philosophers_stone")))
				.seq(createCardEffect(alchemist_polished_philosophers_stone_carddef(), loc(ownerPid, asidePloc)))
				.seq(sacrificeSelf())
		
		local ef16_Doc_Orc  = gainMaxHealthEffect(ownerPid, const(6)).seq(healPlayerEffect(ownerPid,6)).seq(sacrificeSelf())
		
		local ef17_Doc_Orc  = createCardEffect(alchemist_kaleidoscope_carddef(), loc(ownerPid, reservePloc)).seq(sacrificeSelf())

		local ef18_Doc_Orc  = gainMaxHealthEffect(ownerPid, const(6)).seq(healPlayerEffect(ownerPid,6)).seq(sacrificeSelf())

	local ef_Doc_Orc_start = showSpeechBubbleEffect({playerExpression=ownerPid, text="The real crime would be not to finish what we started.", waitForClick= constBoolExpression(false)})

		

	local ef_Doc_Orc = 
			setPlayerNameEffect("Doc Orc", ownerPid)
			.seq(setPlayerAvatarEffect("orc_alchemist_male_01", ownerPid))
			.seq(gainMaxHealthEffect(ownerPid, const(53)))
				.seq(healPlayerEffect(ownerPid,53))
			.seq(createCardEffect(alchemist_reflect_carddef(), loc(ownerPid, skillsPloc)))
			.seq(createCardEffect(alchemist_transmutation_carddef(), loc(ownerPid, skillsPloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(ruby_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(alchemist_frothing_potion_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(alchemist_frothing_potion_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(alchemist_philosophers_stone_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(alchemist_philosophers_stone_carddef(), loc(ownerPid, asidePloc)))
			.seq(ef_elf)
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(4), ef4_Doc_Orc, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(5), ef5_Doc_Orc, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(6), ef6_Doc_Orc, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(7), ef7_Doc_Orc, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(8), ef8_Doc_Orc, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(9), ef9_Doc_Orc, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(10), ef10_Doc_Orc, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(11), ef11_Doc_Orc, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(12), ef12_Doc_Orc, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(13), ef13_Doc_Orc, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(14), ef14_Doc_Orc, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(15), ef15_Doc_Orc, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(16), ef16_Doc_Orc, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(17), ef17_Doc_Orc, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(18), ef18_Doc_Orc, nullEffect()))
			.seq(moveTarget(loc(ownerPid, deckPloc)).apply(selectLoc(loc(ownerPid, asidePloc))))
			.seq(shuffleEffect(loc(ownerPid, deckPloc)))
			--.seq(drawCardsEffect(3))
			.seq(ef_Doc_Orc_start)
			.seq(createCardEffect(Doc_Orc_winlose_buff_def(), loc(ownerPid, buffsPloc)))

-- BTW levels

		local ef4_BTW  = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("druid_forest_rage")))
				.seq(createCardEffect(druid_spirit_of_the_forest_carddef(), loc(ownerPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef5_BTW  = sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("animal_strength")).take(1))
				.seq(createCardEffect(druid_honeycomb_carddef(), loc(ownerPid, asidePloc)))
				.seq(sacrificeSelf())

		local ef6_BTW  = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("druid_spirit_of_the_forest")))
				.seq(createCardEffect(druid_way_of_the_forest_carddef(), loc(ownerPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef7_BTW  = createCardEffect(druid_heartwood_splinter_carddef(), loc(ownerPid, asidePloc))
				.seq(sacrificeSelf())

		local ef8_BTW  = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("druid_bear_form")))
				.seq(createCardEffect(druid_grizzly_form_carddef(), loc(ownerPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef9_BTW  = createCardEffect(druid_grass_weave_sash_carddef(), loc(ownerPid, skillsPloc))
				.seq(sacrificeSelf())

		local ef10_BTW  = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("druid_grizzly_form")))
				.seq(createCardEffect(druid_polar_bear_form_carddef(), loc(ownerPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef11_BTW  = createCardEffect(druid_rabbit_carddef(), loc(ownerPid, asidePloc)).seq(createCardEffect(druid_rabbit_carddef(), loc(ownerPid, asidePloc)))
				.seq(sacrificeSelf())

		local ef12_BTW  = gainMaxHealthEffect(ownerPid, const(7))
				.seq(healPlayerEffect(ownerPid,7))				.seq(sacrificeSelf())

		local ef13_BTW  = createCardEffect(druid_entangling_roots_carddef(), loc(ownerPid, reservePloc))
				.seq(sacrificeSelf())
		
		local ef14_BTW  = gainMaxHealthEffect(ownerPid, const(7))
				.seq(healPlayerEffect(ownerPid,7))				.seq(sacrificeSelf())
		
		local ef15_BTW  = sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("druid_animal_strength")))
				.seq(createCardEffect(druid_nimble_fox_carddef(), loc(ownerPid, asidePloc)))
				.seq(sacrificeSelf())
		
		local ef16_BTW  = gainMaxHealthEffect(ownerPid, const(7)).seq(healPlayerEffect(ownerPid,7)).seq(sacrificeSelf())
		
		local ef17_BTW  = createCardEffect(druid_sunbird_carddef(), loc(ownerPid, reservePloc)).seq(sacrificeSelf())

		local ef18_BTW  = gainMaxHealthEffect(ownerPid, const(7)).seq(healPlayerEffect(ownerPid,7)).seq(sacrificeSelf())	

local ef_BTW_start = showSpeechBubbleEffect({playerExpression=ownerPid, text="Get your grizzly running. Head out in the forest.", waitForClick= constBoolExpression(false)})


	local ef_BTW = 
			setPlayerNameEffect("Bjorn-Toby Wild", ownerPid)
			.seq(setPlayerAvatarEffect("druid_02", ownerPid))
			.seq(gainMaxHealthEffect(ownerPid, const(54)))
				.seq(healPlayerEffect(ownerPid,54))
			.seq(createCardEffect(druid_forest_rage_carddef(), loc(ownerPid, skillsPloc)))
			.seq(createCardEffect(druid_bear_form_carddef(), loc(ownerPid, skillsPloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(ruby_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(druid_gnarled_staff_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(druid_fox_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(druid_squirrel_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(druid_hedgehog_carddef(), loc(ownerPid, asidePloc)))
			.seq(ef_elf)
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(4), ef4_BTW, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(5), ef5_BTW, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(6), ef6_BTW, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(7), ef7_BTW, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(8), ef8_BTW, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(9), ef9_BTW, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(10), ef10_BTW, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(11), ef11_BTW, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(12), ef12_BTW, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(13), ef13_BTW, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(14), ef14_BTW, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(15), ef15_BTW, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(16), ef16_BTW, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(17), ef17_BTW, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(18), ef18_BTW, nullEffect()))
			.seq(moveTarget(loc(ownerPid, deckPloc)).apply(selectLoc(loc(ownerPid, asidePloc))))
			.seq(shuffleEffect(loc(ownerPid, deckPloc)))
			--.seq(drawCardsEffect(3))
			.seq(ef_BTW_start)
			.seq(createCardEffect(BTW_winlose_buff_def(), loc(ownerPid, buffsPloc)))


-- Wombatman levels

		local ef4_Wombatman  = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("druid_forest_rage")))
				.seq(createCardEffect(druid_spirit_of_the_forest_carddef(), loc(ownerPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef5_Wombatman  = sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("druid_gnarled_staff")).take(1))
				.seq(createCardEffect(druid_flourishing_staff_carddef(), loc(ownerPid, asidePloc)))
				.seq(sacrificeSelf())

		local ef6_Wombatman  = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("druid_spirit_of_the_forest")))
				.seq(createCardEffect(druid_way_of_the_forest_carddef(), loc(ownerPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef7_Wombatman  = createCardEffect(druid_owl_carddef(), loc(ownerPid, asidePloc))
				.seq(sacrificeSelf())

		local ef8_Wombatman  = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("druid_bear_form")))
				.seq(createCardEffect(druid_spirit_bear_form_carddef(), loc(ownerPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef9_Wombatman  = createCardEffect(druid_circlet_of_flowers_carddef(), loc(ownerPid, skillsPloc))
				.seq(sacrificeSelf())

		local ef10_Wombatman  = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("druid_spirit_bear_form")))
				.seq(createCardEffect(druid_pure_bear_form_carddef(), loc(ownerPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef11_Wombatman  = createCardEffect(druid_rabbit_carddef(), loc(ownerPid, asidePloc)).seq(createCardEffect(druid_rabbit_carddef(), loc(ownerPid, asidePloc)))
				.seq(sacrificeSelf())

		local ef12_Wombatman  = gainMaxHealthEffect(ownerPid, const(7))
				.seq(healPlayerEffect(ownerPid,7))				.seq(sacrificeSelf())

		local ef13_Wombatman  = createCardEffect(druid_panther_eye_ring_carddef(), loc(ownerPid, reservePloc))
				.seq(sacrificeSelf())
		
		local ef14_Wombatman  = gainMaxHealthEffect(ownerPid, const(7))
				.seq(healPlayerEffect(ownerPid,7))				.seq(sacrificeSelf())
		
		local ef15_Wombatman  = sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("druid_fox")))
				.seq(createCardEffect(druid_feral_fox_carddef(), loc(ownerPid, asidePloc)))
				.seq(sacrificeSelf())
		
		local ef16_Wombatman  = gainMaxHealthEffect(ownerPid, const(7)).seq(healPlayerEffect(ownerPid,7)).seq(sacrificeSelf())
		
		local ef17_Wombatman  = createCardEffect(druid_sunbird_carddef(), loc(ownerPid, reservePloc)).seq(sacrificeSelf())

		local ef18_Wombatman  = gainMaxHealthEffect(ownerPid, const(7)).seq(healPlayerEffect(ownerPid,7)).seq(sacrificeSelf())	

local ef_Wombatman_start = showSpeechBubbleEffect({playerExpression=ownerPid, text="I'm Wombatman.", waitForClick= constBoolExpression(false)})

	local ef_Wombatman = 
			setPlayerNameEffect("Wombatman", ownerPid)
			.seq(setPlayerAvatarEffect("druid_02", ownerPid))
			.seq(gainMaxHealthEffect(ownerPid, const(54)))
				.seq(healPlayerEffect(ownerPid,54))
			.seq(createCardEffect(druid_forest_rage_carddef(), loc(ownerPid, skillsPloc)))
			.seq(createCardEffect(druid_bear_form_carddef(), loc(ownerPid, skillsPloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(ruby_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(druid_gnarled_staff_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(druid_fox_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(druid_squirrel_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(druid_hedgehog_carddef(), loc(ownerPid, asidePloc)))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(4), ef4_Wombatman, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(5), ef5_Wombatman, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(6), ef6_Wombatman, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(7), ef7_Wombatman, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(8), ef8_Wombatman, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(9), ef9_Wombatman, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(10), ef10_Wombatman, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(11), ef11_Wombatman, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(12), ef12_Wombatman, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(13), ef13_Wombatman, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(14), ef14_Wombatman, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(15), ef15_Wombatman, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(16), ef16_Wombatman, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(17), ef17_Wombatman, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(18), ef18_Wombatman, nullEffect()))
			.seq(moveTarget(loc(ownerPid, deckPloc)).apply(selectLoc(loc(ownerPid, asidePloc))))
			.seq(shuffleEffect(loc(ownerPid, deckPloc)))
			--.seq(drawCardsEffect(3))
			.seq(ef_Wombatman_start)
			.seq(createCardEffect(Wombatman_winlose_buff_def(), loc(ownerPid, buffsPloc)))


-- Elfred Nobel levels

		local ef4_Elfred_Nobel  = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("alchemist_reflect")))
				.seq(createCardEffect(alchemist_refraction_carddef(), loc(ownerPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef5_Elfred_Nobel  = sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("philosophers_stone")).take(1))
				.seq(createCardEffect(alchemist_fools_gold_carddef(), loc(ownerPid, asidePloc)))
				.seq(sacrificeSelf())

		local ef6_Elfred_Nobel  = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("alchemist_refraction")))
				.seq(createCardEffect(alchemist_prismatic_dispersion_carddef(), loc(ownerPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef7_Elfred_Nobel  = createCardEffect(alchemist_crucible_carddef(), loc(ownerPid, asidePloc))
				.seq(sacrificeSelf())

		local ef8_Elfred_Nobel  = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("alchemist_transmutation")))
				.seq(createCardEffect(alchemist_transmogrification_carddef(), loc(ownerPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef9_Elfred_Nobel  = createCardEffect(alchemist_spectrum_spectacles_carddef(), loc(ownerPid, skillsPloc))
				.seq(sacrificeSelf())

		local ef10_Elfred_Nobel  = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("alchemist_transmogrification")))
				.seq(createCardEffect(alchemist_major_transmogrification_carddef(), loc(ownerPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef11_Elfred_Nobel  = createCardEffect(alchemist_alchemy_powders_carddef(), loc(ownerPid, asidePloc))
				.seq(sacrificeSelf())

		local ef12_Elfred_Nobel  = gainMaxHealthEffect(ownerPid, const(6))
				.seq(healPlayerEffect(ownerPid,6))				.seq(sacrificeSelf())

		local ef13_Elfred_Nobel  = createCardEffect(alchemist_fireworks_carddef(), loc(ownerPid, reservePloc))
				.seq(sacrificeSelf())
		
		local ef14_Elfred_Nobel  = gainMaxHealthEffect(ownerPid, const(6))
				.seq(healPlayerEffect(ownerPid,6))				.seq(sacrificeSelf())
		
		local ef15_Elfred_Nobel  = sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("alchemist_philosophers_stone")))
				.seq(createCardEffect(alchemist_polished_philosophers_stone_carddef(), loc(ownerPid, asidePloc)))
				.seq(sacrificeSelf())
		
		local ef16_Elfred_Nobel  = gainMaxHealthEffect(ownerPid, const(6)).seq(healPlayerEffect(ownerPid,6)).seq(sacrificeSelf())
		
		local ef17_Elfred_Nobel  = createCardEffect(alchemist_kaleidoscope_carddef(), loc(ownerPid, reservePloc)).seq(sacrificeSelf())

		local ef18_Elfred_Nobel  = gainMaxHealthEffect(ownerPid, const(6)).seq(healPlayerEffect(ownerPid,6)).seq(sacrificeSelf())	

local ef_Elfred_Nobel_start = showSpeechBubbleEffect({playerExpression=ownerPid, text="If I have a thousand ideas and only one turns out to be good, I am satisfied.", waitForClick= constBoolExpression(false)})

	local ef_Elfred_Nobel = 
			setPlayerNameEffect("Elfred Nobel", ownerPid)
			.seq(setPlayerAvatarEffect("elf_alchemist_male_01", ownerPid))
			.seq(gainMaxHealthEffect(ownerPid, const(53)))
				.seq(healPlayerEffect(ownerPid,53))
			.seq(createCardEffect(alchemist_reflect_carddef(), loc(ownerPid, skillsPloc)))
			.seq(createCardEffect(alchemist_transmutation_carddef(), loc(ownerPid, skillsPloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(ruby_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(alchemist_frothing_potion_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(alchemist_frothing_potion_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(alchemist_philosophers_stone_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(alchemist_philosophers_stone_carddef(), loc(ownerPid, asidePloc)))
			.seq(ef_elf)
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(4), ef4_Elfred_Nobel, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(5), ef5_Elfred_Nobel, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(6), ef6_Elfred_Nobel, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(7), ef7_Elfred_Nobel, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(8), ef8_Elfred_Nobel, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(9), ef9_Elfred_Nobel, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(10), ef10_Elfred_Nobel, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(11), ef11_Elfred_Nobel, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(12), ef12_Elfred_Nobel, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(13), ef13_Elfred_Nobel, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(14), ef14_Elfred_Nobel, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(15), ef15_Elfred_Nobel, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(16), ef16_Elfred_Nobel, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(17), ef17_Elfred_Nobel, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(18), ef18_Elfred_Nobel, nullEffect()))
			.seq(moveTarget(loc(ownerPid, deckPloc)).apply(selectLoc(loc(ownerPid, asidePloc))))
			.seq(shuffleEffect(loc(ownerPid, deckPloc)))
			
			--.seq(drawCardsEffect(3))
			.seq(ef_Elfred_Nobel_start)
			.seq(createCardEffect(Elfred_Nobel_winlose_buff_def(), loc(ownerPid, buffsPloc)))
	
-- Ranger levels

		local ef4_ranger = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("ranger_track")))
				.seq(createCardEffect(ranger_careful_track_carddef(), loc(ownerPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef5_ranger = sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("gold")).take(1))
				.seq(createCardEffect(ranger_light_crossbow_carddef(), loc(ownerPid, asidePloc)))
				.seq(sacrificeSelf())

		local ef6_ranger = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("ranger_careful_track")))
				.seq(createCardEffect(ranger_flawless_track_carddef(), loc(ownerPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef7_ranger = createCardEffect(ranger_unending_quiver_carddef(), loc(ownerPid, asidePloc))
				.seq(sacrificeSelf())

		local ef8_ranger = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("ranger_headshot")))
				.seq(createCardEffect(ranger_quickshot_carddef(), loc(ownerPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef9_ranger = createCardEffect(ranger_hunters_cloak_carddef(), loc(ownerPid, skillsPloc))
				.seq(sacrificeSelf())

		local ef10_ranger = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("ranger_quickshot")))
				.seq(createCardEffect(ranger_snapshot_carddef(), loc(ownerPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef11_ranger = createCardEffect(ranger_flashfire_arrow_carddef(), loc(ownerPid, asidePloc))
				.seq(sacrificeSelf())

		local ef12_ranger = gainMaxHealthEffect(ownerPid, const(8))
				.seq(healPlayerEffect(ownerPid,8))
				.seq(sacrificeSelf())

		local ef13_ranger = createCardEffect(ranger_spyglass_carddef(), loc(ownerPid, asidePloc))
				.seq(sacrificeSelf())
		
		local ef14_ranger = gainMaxHealthEffect(ownerPid, const(8))
				.seq(healPlayerEffect(ownerPid,8))
		
		local ef15_ranger = sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("ranger_horn_of_calling")).take(1))
				.seq(createCardEffect(ranger_horn_of_need_carddef(), loc(ownerPid, asidePloc)))
				.seq(sacrificeSelf())
		
		local ef16_ranger = gainMaxHealthEffect(ownerPid, const(8))
				.seq(healPlayerEffect(ownerPid,8))		
				.seq(sacrificeSelf())
		
		local ef17_ranger = createCardEffect(ranger_death_arrow_carddef(), loc(ownerPid, reservePloc))
				.seq(sacrificeSelf())

		local ef18_ranger = gainMaxHealthEffect(ownerPid, const(8))
				.seq(healPlayerEffect(ownerPid,8))
				.seq(sacrificeSelf())	
				
				
local ef_major_drawback_start = showSpeechBubbleEffect({playerExpression=ownerPid, text="Arrow there! 'Ow are you?", waitForClick= constBoolExpression(false)})

	local ef_ranger = 
			setPlayerNameEffect("Major Drawback", ownerPid)
			.seq(setPlayerAvatarEffect("ranger_alt_02", ownerPid))
			.seq(gainMaxHealthEffect(ownerPid, const(58)))
				.seq(healPlayerEffect(ownerPid,58))
			.seq(createCardEffect(ranger_track_carddef(), loc(ownerPid, skillsPloc)))
			.seq(createCardEffect(ranger_headshot_carddef(), loc(ownerPid, skillsPloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc))) --here--
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(ruby_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(ranger_horn_of_calling_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(ranger_black_arrow_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(ranger_black_arrow_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(ranger_hunting_bow_carddef(), loc(ownerPid, asidePloc)))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(4), ef4_ranger, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(5), ef5_ranger, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(6), ef6_ranger, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(7), ef7_ranger, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(8), ef8_ranger, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(9), ef9_ranger, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(10), ef10_ranger, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(11), ef11_ranger, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(12), ef12_ranger, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(13), ef13_ranger, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(14), ef14_ranger, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(15), ef15_ranger, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(16), ef16_ranger, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(17), ef17_ranger, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(18), ef18_ranger, nullEffect()))
			.seq(moveTarget(loc(ownerPid, deckPloc)).apply(selectLoc(loc(ownerPid, asidePloc))))
			.seq(shuffleEffect(loc(ownerPid, deckPloc)))
			--.seq(drawCardsEffect(3))
			.seq(ef_major_drawback_start)
			.seq(createCardEffect(drawback_winlose_buff_def(), loc(ownerPid, buffsPloc)))
			


-- Illegalas Ranger levels
		local ef4_illegalas = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("ranger_track")))
				.seq(createCardEffect(ranger_careful_track_carddef(), loc(ownerPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef5_illegalas = sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("gold")).take(1))
				.seq(createCardEffect(ranger_light_crossbow_carddef(), loc(ownerPid, asidePloc)))
				.seq(sacrificeSelf())

		local ef6_illegalas = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("ranger_careful_track")))
				.seq(createCardEffect(ranger_flawless_track_carddef(), loc(ownerPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef7_illegalas = createCardEffect(ranger_unending_quiver_carddef(), loc(ownerPid, asidePloc))
				.seq(sacrificeSelf())

		local ef8_illegalas = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("ranger_headshot")))
				.seq(createCardEffect(ranger_quickshot_carddef(), loc(ownerPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef9_illegalas = createCardEffect(ranger_sureshot_bracer_carddef(), loc(ownerPid, skillsPloc))
				.seq(sacrificeSelf())

		local ef10_illegalas = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("ranger_quickshot")))
				.seq(createCardEffect(ranger_snapshot_carddef(), loc(ownerPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef11_illegalas = createCardEffect(ranger_flashfire_arrow_carddef(), loc(ownerPid, asidePloc))
				.seq(sacrificeSelf())

		local ef12_illegalas = gainMaxHealthEffect(ownerPid, const(8))
				.seq(healPlayerEffect(ownerPid,8))
				.seq(sacrificeSelf())

		local ef13_illegalas = createCardEffect(ranger_parrot_carddef(), loc(ownerPid, reservePloc))
				.seq(sacrificeSelf())
		
		local ef14_illegalas = gainMaxHealthEffect(ownerPid, const(8))
				.seq(healPlayerEffect(ownerPid,8))
				.seq(sacrificeSelf())
		
		local ef15_illegalas = sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("ranger_horn_of_calling")))
				.seq(createCardEffect(ranger_horn_of_need_carddef(), loc(ownerPid, asidePloc)))
				.seq(sacrificeSelf())
		
		local ef16_illegalas = gainMaxHealthEffect(ownerPid, const(8))
				.seq(healPlayerEffect(ownerPid,8))
				.seq(sacrificeSelf())
		
		local ef17_illegalas = createCardEffect(ranger_death_arrow_carddef(), loc(ownerPid, reservePloc))
				.seq(sacrificeSelf())

		local ef18_illegalas = gainMaxHealthEffect(ownerPid, const(8))
				.seq(healPlayerEffect(ownerPid,8))
				.seq(sacrificeSelf())	


local ef_illegalas_start = showSpeechBubbleEffect({playerExpression=ownerPid, text="Bow to me. (Get it? 'Bow'!)", waitForClick= constBoolExpression(false)})

local ef_illegalas = 
			setPlayerNameEffect("Illegalas", ownerPid)
			.seq(setPlayerAvatarEffect("elf_ranger_male_01", ownerPid))
			.seq(gainMaxHealthEffect(ownerPid, const(50)))
				.seq(healPlayerEffect(ownerPid,50))
			.seq(createCardEffect(ranger_track_carddef(), loc(ownerPid, skillsPloc)))
			.seq(createCardEffect(ranger_headshot_carddef(), loc(ownerPid, skillsPloc)))
			.seq(ef_elf)
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(ruby_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(ranger_horn_of_calling_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(ranger_black_arrow_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(ranger_black_arrow_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(ranger_hunting_bow_carddef(), loc(ownerPid, asidePloc)))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(4), ef4_illegalas, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(5), ef5_illegalas, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(6), ef6_illegalas, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(7), ef7_illegalas, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(8), ef8_illegalas, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(9), ef9_illegalas, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(10), ef10_illegalas, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(11), ef11_illegalas, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(12), ef12_illegalas, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(13), ef13_illegalas, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(14), ef14_illegalas, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(15), ef15_illegalas, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(16), ef16_illegalas, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(17), ef17_illegalas, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(18), ef18_illegalas, nullEffect()))
			.seq(moveTarget(loc(ownerPid, deckPloc)).apply(selectLoc(loc(ownerPid, asidePloc))))
			.seq(shuffleEffect(loc(ownerPid, deckPloc)))
			.seq(ef_illegalas_start)
			.seq(createCardEffect(illegalas_winlose_buff_def(), loc(ownerPid, buffsPloc)))



-- Wizard levels

		local ef4_wizard = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("wizard_channel")))
				.seq(createCardEffect(wizard_calm_channel_carddef(), loc(ownerPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef5_wizard = sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("fire_staff")).take(1))
				.seq(createCardEffect(wizard_blazing_staff_carddef(), loc(ownerPid, asidePloc)))
				.seq(sacrificeSelf())

		local ef6_wizard = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("wizard_calm_channel")))
				.seq(createCardEffect(wizard_pure_channel_carddef(), loc(ownerPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef7_wizard = createCardEffect(wizard_arcane_wand_carddef(), loc(ownerPid, asidePloc))
				.seq(sacrificeSelf())

		local ef8_wizard = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("wizard_fireball")))
				.seq(createCardEffect(wizard_rolling_fireball_carddef(), loc(ownerPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef9_wizard = createCardEffect(wizard_runic_robes_carddef(), loc(ownerPid, skillsPloc))
				.seq(sacrificeSelf())

		local ef10_wizard = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("wizard_rolling_fireball")))
				.seq(createCardEffect(wizard_explosive_fireball_carddef(), loc(ownerPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef11_wizard = createCardEffect(wizard_magic_mirror_carddef(), loc(ownerPid, asidePloc))
				.seq(sacrificeSelf())

		local ef12_wizard = gainMaxHealthEffect(ownerPid, const(5))
				.seq(healPlayerEffect(ownerPid,5))
				.seq(sacrificeSelf())

		local ef13_wizard = createCardEffect(wizard_treasure_map_carddef(), loc(ownerPid, asidePloc))
				.seq(sacrificeSelf())
		
		local ef14_wizard = gainMaxHealthEffect(ownerPid, const(5))
				.seq(healPlayerEffect(ownerPid,5))
				.seq(sacrificeSelf())
		
		local ef15_wizard = sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("wizard_cat_familiar")))
				.seq(createCardEffect(wizard_wizened_familiar_carddef(), loc(ownerPid, asidePloc)))
				.seq(sacrificeSelf())
		
		local ef16_wizard = gainMaxHealthEffect(ownerPid, const(5))
				.seq(healPlayerEffect(ownerPid,5))
				.seq(sacrificeSelf())
		
		local ef17_wizard = createCardEffect(wizard_clock_of_ages_carddef(), loc(ownerPid, reservePloc))
				.seq(sacrificeSelf())

		local ef18_wizard = gainMaxHealthEffect(ownerPid, const(5))
				.seq(healPlayerEffect(ownerPid,5))
				.seq(sacrificeSelf())	
				
		local ef_morgana_start = showSpeechBubbleEffect({playerExpression=ownerPid, text="I can't seem to tune into the right channel.", waitForClick= constBoolExpression(false)})

	local ef_wizard = 
			setPlayerNameEffect("Morgana Le Fail", ownerPid)
			.seq(setPlayerAvatarEffect("wizard_alt_01", ownerPid))
			.seq(gainMaxHealthEffect(ownerPid, const(50)))
				.seq(healPlayerEffect(ownerPid,50))
			.seq(createCardEffect(wizard_channel_carddef(), loc(ownerPid, skillsPloc)))
			.seq(createCardEffect(wizard_fireball_carddef(), loc(ownerPid, skillsPloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc))) --here--
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(ruby_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(wizard_spell_components_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(wizard_cat_familiar_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(wizard_fire_staff_carddef(), loc(ownerPid, asidePloc)))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(4), ef4_wizard, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(5), ef5_wizard, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(6), ef6_wizard, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(7), ef7_wizard, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(8), ef8_wizard, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(9), ef9_wizard, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(10), ef10_wizard, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(11), ef11_wizard, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(12), ef12_wizard, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(13), ef13_wizard, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(14), ef14_wizard, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(15), ef15_wizard, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(16), ef16_wizard, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(17), ef17_wizard, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(18), ef18_wizard, nullEffect()))
			.seq(moveTarget(loc(ownerPid, deckPloc)).apply(selectLoc(loc(ownerPid, asidePloc))))
			.seq(shuffleEffect(loc(ownerPid, deckPloc)))
			--.seq(drawCardsEffect(3))
			.seq(ef_morgana_start)
			.seq(createCardEffect(morgana_winlose_buff_def(), loc(ownerPid, buffsPloc)))

-- Cleric levels

		local ef4_cleric = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("cleric_bless")))
				.seq(createCardEffect(cleric_bless_of_heart_carddef(), loc(ownerPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef5_cleric = sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("gold")).take(1))
				.seq(createCardEffect(cleric_everburning_candle_carddef(), loc(ownerPid, asidePloc)))
				.seq(sacrificeSelf())

		local ef6_cleric = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("cleric_bless_of_heart")))
				.seq(createCardEffect(cleric_bless_of_soul_carddef(), loc(ownerPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef7_cleric = createCardEffect(cleric_brightstar_shield_carddef(), loc(ownerPid, asidePloc))
				.seq(sacrificeSelf())

		local ef8_cleric = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("cleric_resurrect")))
				.seq(createCardEffect(cleric_holy_resurrect_carddef(), loc(ownerPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef9_cleric = createCardEffect(cleric_phoenix_helm_carddef(), loc(ownerPid, skillsPloc))
				.seq(sacrificeSelf())

		local ef10_cleric = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("cleric_holy_resurrect")))
				.seq(createCardEffect(cleric_divine_resurrect_carddef(), loc(ownerPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef11_cleric = createCardEffect(cleric_hammer_of_light_carddef(), loc(ownerPid, asidePloc))
				.seq(sacrificeSelf())

		local ef12_cleric = createCardEffect(cleric_minor_resurrect_carddef(), loc(ownerPid, skillsPloc))
				.seq(sacrificeSelf())

		local ef13_cleric = createCardEffect(cleric_ship_s_bell_carddef(), loc(ownerPid, asidePloc))
				.seq(sacrificeSelf())
		
		local ef14_cleric = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("cleric_minor_resurrect")))
				.seq(createCardEffect(cleric_lesser_resurrect_carddef(), loc(ownerPid, skillsPloc)))
				.seq(sacrificeSelf())
		
		local ef15_cleric = sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("cleric_spiked_mace")))
				.seq(createCardEffect(cleric_spiked_mace_of_glory_carddef(), loc(ownerPid, asidePloc)))
				.seq(sacrificeSelf())
		
		local ef16_cleric = gainMaxHealthEffect(ownerPid, const(7))
				.seq(healPlayerEffect(ownerPid,7))
				.seq(sacrificeSelf())
		
		local ef17_cleric = createCardEffect(cleric_holy_water_carddef(), loc(ownerPid, reservePloc))
				.seq(sacrificeSelf())

		local ef18_cleric = gainMaxHealthEffect(ownerPid, const(7))
				.seq(healPlayerEffect(ownerPid,7))
				.seq(sacrificeSelf())				
		
		local ef_cleric_start = showSpeechBubbleEffect({playerExpression=ownerPid, text="Do we really have to do this?", waitForClick= constBoolExpression(false)})

	local ef_cleric = 
			setPlayerNameEffect("Friar Tuckered-out", ownerPid)
			.seq(setPlayerAvatarEffect("cleric_alt_02", ownerPid))
			.seq(gainMaxHealthEffect(ownerPid, const(55)))
				.seq(healPlayerEffect(ownerPid,55))
			.seq(createCardEffect(cleric_bless_carddef(), loc(ownerPid, skillsPloc)))
			.seq(createCardEffect(cleric_resurrect_carddef(), loc(ownerPid, skillsPloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc))) --here--
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(cleric_spiked_mace_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(cleric_follower_a_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(cleric_follower_b_carddef(), loc(ownerPid, asidePloc)))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(4), ef4_cleric, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(5), ef5_cleric, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(6), ef6_cleric, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(7), ef7_cleric, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(8), ef8_cleric, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(9), ef9_cleric, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(10), ef10_cleric, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(11), ef11_cleric, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(12), ef12_cleric, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(13), ef13_cleric, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(14), ef14_cleric, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(15), ef15_cleric, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(16), ef16_cleric, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(17), ef17_cleric, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(18), ef18_cleric, nullEffect()))
			.seq(moveTarget(loc(ownerPid, deckPloc)).apply(selectLoc(loc(ownerPid, asidePloc))))
			.seq(shuffleEffect(loc(ownerPid, deckPloc)))
			.seq(ef_cleric_start)
			.seq(createCardEffect(cleric_winlose_buff_def(), loc(ownerPid, buffsPloc)))
			
-- zembu levels

		local ef4_zembu = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("thief_pickpocket")))
				.seq(createCardEffect(thief_swipe_carddef(), loc(ownerPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef5_zembu = sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("thief_throwing_knife")).take(1))
				.seq(createCardEffect(thief_keen_throwing_knife_carddef(), loc(ownerPid, asidePloc)))
				.seq(sacrificeSelf())

		local ef6_zembu = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("thief_swipe")))
				.seq(createCardEffect(thief_lift_carddef(), loc(ownerPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef7_zembu = createCardEffect(thief_knife_belt_carddef(), loc(ownerPid, asidePloc))
				.seq(sacrificeSelf())

		local ef8_zembu = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("thief_heist")))
				.seq(createCardEffect(thief_skillful_heist_carddef(), loc(ownerPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef9_zembu = createCardEffect(thief_shadow_mask_carddef(), loc(ownerPid, skillsPloc))
				.seq(sacrificeSelf())

		local ef10_zembu = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("thief_skillful_heist")))
				.seq(createCardEffect(thief_smooth_heist_carddef(), loc(ownerPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef11_zembu = createCardEffect(thief_blackjack_carddef(), loc(ownerPid, asidePloc))
				.seq(sacrificeSelf())

		local ef12_zembu = gainMaxHealthEffect(ownerPid, const(6))
				.seq(healPlayerEffect(ownerPid,6))
				.seq(sacrificeSelf())	

		local ef13_zembu = createCardEffect(thief_trick_dice_carddef(), loc(ownerPid, reservePloc))
				.seq(sacrificeSelf())
		
		local ef14_zembu = gainMaxHealthEffect(ownerPid, const(6))
				.seq(healPlayerEffect(ownerPid,6))
				.seq(sacrificeSelf())	
		
		local ef15_zembu = sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("thief_ruby")))
				.seq(createCardEffect(thief_sharpened_ruby_carddef(), loc(ownerPid, asidePloc)))
				.seq(sacrificeSelf())
		
		local ef16_zembu = gainMaxHealthEffect(ownerPid, const(6))
				.seq(healPlayerEffect(ownerPid,6))
				.seq(sacrificeSelf())
		
		local ef17_zembu = createCardEffect(thief_blinding_powder_carddef(), loc(ownerPid, reservePloc))
				.seq(sacrificeSelf())

		local ef18_zembu = gainMaxHealthEffect(ownerPid, const(6))
				.seq(healPlayerEffect(ownerPid,6))
				.seq(sacrificeSelf())	


local ef_zembu_start = showSpeechBubbleEffect({playerExpression=ownerPid, text="Shhh!", waitForClick= constBoolExpression(false)})
			
	local ef_zembu = 
			setPlayerNameEffect("Kachiko", ownerPid)
			.seq(setPlayerAvatarEffect("thief_alt_01", ownerPid))
			.seq(gainMaxHealthEffect(ownerPid, const(52)))
				.seq(healPlayerEffect(ownerPid,52))
			.seq(createCardEffect(thief_pickpocket_carddef(), loc(ownerPid, skillsPloc)))
			.seq(createCardEffect(thief_heist_carddef(), loc(ownerPid, skillsPloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc))) --here--
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(ruby_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(ruby_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(thief_throwing_knife_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(thief_throwing_knife_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(thief_throwing_knife_carddef(), loc(ownerPid, asidePloc)))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(4), ef4_zembu, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(5), ef5_zembu, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(6), ef6_zembu, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(7), ef7_zembu, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(8), ef8_zembu, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(9), ef9_zembu, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(10), ef10_zembu, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(11), ef11_zembu, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(12), ef12_zembu, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(13), ef13_zembu, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(14), ef14_zembu, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(15), ef15_zembu, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(16), ef16_zembu, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(17), ef17_zembu, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(18), ef18_zembu, nullEffect()))
			.seq(moveTarget(loc(ownerPid, deckPloc)).apply(selectLoc(loc(ownerPid, asidePloc))))
			.seq(shuffleEffect(loc(ownerPid, deckPloc)))
			.seq(ef_zembu_start)
	
				
-- wardenslayer levels

		local ef4_wardenslayer = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("fighter_shoulder_bash")))
				.seq(createCardEffect(fighter_shoulder_smash_carddef(), loc(ownerPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef5_wardenslayer = sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("gold")).take(1))
				.seq(createCardEffect(fighter_hand_scythe_carddef(), loc(ownerPid, asidePloc)))
				.seq(sacrificeSelf())

		local ef6_wardenslayer = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("fighter_shoulder_smash")))
				.seq(createCardEffect(fighter_shoulder_crush_carddef(), loc(ownerPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef7_wardenslayer = createCardEffect(fighter_jagged_spear_carddef(), loc(ownerPid, asidePloc))
				.seq(sacrificeSelf())

		local ef8_wardenslayer = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("fighter_crushing_blow")))
				.seq(createCardEffect(fighter_smashing_blow_carddef(), loc(ownerPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef9_wardenslayer = createCardEffect(fighter_spiked_pauldrons_carddef(), loc(ownerPid, skillsPloc))
				.seq(sacrificeSelf())

		local ef10_wardenslayer = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("fighter_smashing_blow")))
				.seq(createCardEffect(fighter_devastating_blow_carddef(), loc(ownerPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef11_wardenslayer = createCardEffect(fighter_sharpening_stone_carddef(), loc(ownerPid, asidePloc))
				.seq(sacrificeSelf())

		local ef12_wardenslayer = gainMaxHealthEffect(ownerPid, const(9))
				.seq(healPlayerEffect(ownerPid,9))
				.seq(sacrificeSelf())	

		local ef13_wardenslayer = createCardEffect(fighter_bottle_of_rum_carddef(), loc(ownerPid, reservePloc))
				.seq(sacrificeSelf())
		
		local ef14_wardenslayer = gainMaxHealthEffect(ownerPid, const(9))
				.seq(healPlayerEffect(ownerPid,9))
				.seq(sacrificeSelf())	
		
		local ef15_wardenslayer = sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("fighter_longsword")))
				.seq(createCardEffect(fighter_lightning_longsword_carddef(), loc(ownerPid, asidePloc)))
				.seq(sacrificeSelf())
		
		local ef16_wardenslayer = gainMaxHealthEffect(ownerPid, const(9))
				.seq(healPlayerEffect(ownerPid,9))
				.seq(sacrificeSelf())
		
		local ef17_wardenslayer = createCardEffect(fighter_chain_carddef(), loc(ownerPid, reservePloc))
				.seq(sacrificeSelf())

		local ef18_wardenslayer = gainMaxHealthEffect(ownerPid, const(9))
				.seq(healPlayerEffect(ownerPid,9))
				.seq(sacrificeSelf())	

local ef_wardenslayer_start = showSpeechBubbleEffect({playerExpression=ownerPid, text="I'm here to slay!", waitForClick= constBoolExpression(false)})

	local ef_wardenslayer = 
			setPlayerNameEffect("Warden Slayer", ownerPid)
			.seq(setPlayerAvatarEffect("orc_fighter_male_02", ownerPid))
			.seq(gainMaxHealthEffect(ownerPid, const(60)))
				.seq(healPlayerEffect(ownerPid,60))
			.seq(createCardEffect(fighter_shoulder_bash_carddef(), loc(ownerPid, skillsPloc)))
			.seq(createCardEffect(fighter_crushing_blow_carddef(), loc(ownerPid, skillsPloc)))
			.seq(ef_orc)
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(ruby_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(fighter_shield_bearer_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(fighter_throwing_axe_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(fighter_longsword_carddef(), loc(ownerPid, asidePloc)))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(4), ef4_wardenslayer, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(5), ef5_wardenslayer, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(6), ef6_wardenslayer, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(7), ef7_wardenslayer, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(8), ef8_wardenslayer, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(9), ef9_wardenslayer, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(10), ef10_wardenslayer, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(11), ef11_wardenslayer, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(12), ef12_wardenslayer, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(13), ef13_wardenslayer, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(14), ef14_wardenslayer, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(15), ef15_wardenslayer, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(16), ef16_wardenslayer, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(17), ef17_wardenslayer, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(18), ef18_wardenslayer, nullEffect()))
			.seq(moveTarget(loc(ownerPid, deckPloc)).apply(selectLoc(loc(ownerPid, asidePloc))))
			.seq(shuffleEffect(loc(ownerPid, deckPloc)))
			.seq(ef_wardenslayer_start)


-- lgnkstwrt levels

		local ef4_lgnkstwrt = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("bard_moving_melody")))
				.seq(createCardEffect(bard_rousing_ode_carddef(), loc(ownerPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef5_lgnkstwrt = sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("dagger")).take(1))
				.seq(createCardEffect(bard_dancing_blade_carddef(), loc(ownerPid, asidePloc)))
				.seq(sacrificeSelf())

		local ef6_lgnkstwrt = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("bard_rousing_ode")))
				.seq(createCardEffect(bard_rally_hymn_carddef(), loc(ownerPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef7_lgnkstwrt = createCardEffect(bard_summoning_drum_carddef(), loc(ownerPid, asidePloc))
				.seq(sacrificeSelf())

		local ef8_lgnkstwrt = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("bard_valiant_verse")))
				.seq(createCardEffect(bard_heroic_fable_carddef(), loc(ownerPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef9_lgnkstwrt = createCardEffect(bard_collecting_cap_carddef(), loc(ownerPid, skillsPloc))
				.seq(sacrificeSelf())

		local ef10_lgnkstwrt = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("bard_heroic_fable")))
				.seq(createCardEffect(bard_mythic_chronicle_carddef(), loc(ownerPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef11_lgnkstwrt = createCardEffect(bard_goblet_of_whimsy_carddef(), loc(ownerPid, asidePloc))
				.seq(sacrificeSelf())

		local ef12_lgnkstwrt = gainMaxHealthEffect(ownerPid, const(6))
				.seq(healPlayerEffect(ownerPid,6))				.seq(sacrificeSelf())

		local ef13_lgnkstwrt = createCardEffect(bard_musical_darts_carddef(), loc(ownerPid, reservePloc))
				.seq(sacrificeSelf())
		
		local ef14_lgnkstwrt = gainMaxHealthEffect(ownerPid, const(6))
				.seq(healPlayerEffect(ownerPid,6))				.seq(sacrificeSelf())
		
		local ef15_lgnkstwrt = sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("bard_harp")))
				.seq(createCardEffect(bard_lullaby_harp_carddef(), loc(ownerPid, asidePloc)))
				.seq(sacrificeSelf())
		
		local ef16_lgnkstwrt = gainMaxHealthEffect(ownerPid, const(6))
				.seq(healPlayerEffect(ownerPid,6)).seq(sacrificeSelf())
		
		local ef17_lgnkstwrt = createCardEffect(bard_muse_s_paper_carddef(), loc(ownerPid, reservePloc))
				.seq(sacrificeSelf())

		local ef18_lgnkstwrt = gainMaxHealthEffect(ownerPid, const(6))
				.seq(healPlayerEffect(ownerPid,6)).seq(sacrificeSelf())	
				
		local ef_lgnkstwrt_start = showSpeechBubbleEffect({playerExpression=ownerPid, text="How about a song? Any requests?", waitForClick= constBoolExpression(false)})

--Say 1 Trigger = After opponent shuffles their first deck

local ef_lgnkstwrt_2 = showSpeechBubbleEffect({playerExpression=ownerPid, text="Encore! Encore!", waitForClick= constBoolExpression(false)})
--Say 2 Trigger = After opponent shuffles their first deck

local ef_lgnkstwrt_3 = showSpeechBubbleEffect({playerExpression=ownerPid, text="Sacrebleu! What'd you do?", waitForClick= constBoolExpression(false)})
--Say 3 Trigger = After opponent shuffles their first deck

	local ef_lgnkstwrt = 
			setPlayerNameEffect("Lgnkstwrt", ownerPid)
			.seq(setPlayerAvatarEffect("bard_02", ownerPid))
			.seq(gainMaxHealthEffect(ownerPid, const(51)))
				.seq(healPlayerEffect(ownerPid,51))
			.seq(createCardEffect(bard_moving_melody_carddef(), loc(ownerPid, skillsPloc)))
			.seq(createCardEffect(bard_valiant_verse_carddef(), loc(ownerPid, skillsPloc)))

			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(dagger_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(ruby_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(bard_herald_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(bard_guild_tale_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(bard_song_of_the_wild_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(bard_imperial_anthem_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(bard_harp_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(bard_flute_carddef(), loc(ownerPid, asidePloc)))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(4), ef4_lgnkstwrt, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(5), ef5_lgnkstwrt, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(6), ef6_lgnkstwrt, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(7), ef7_lgnkstwrt, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(8), ef8_lgnkstwrt, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(9), ef9_lgnkstwrt, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(10), ef10_lgnkstwrt, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(11), ef11_lgnkstwrt, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(12), ef12_lgnkstwrt, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(13), ef13_lgnkstwrt, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(14), ef14_lgnkstwrt, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(15), ef15_lgnkstwrt, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(16), ef16_lgnkstwrt, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(17), ef17_lgnkstwrt, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(18), ef18_lgnkstwrt, nullEffect()))
			.seq(moveTarget(loc(ownerPid, deckPloc)).apply(selectLoc(loc(ownerPid, asidePloc))))
			.seq(shuffleEffect(loc(ownerPid, deckPloc)))
			.seq(ef_lgnkstwrt_start)
			.seq(createCardEffect(lgnkstwrt_winlose_buff_def(), loc(ownerPid, buffsPloc)))


-- Jigmelingpa levels

		local ef4_jigmelingpa = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("wizard_channel")))
				.seq(createCardEffect(wizard_calm_channel_carddef(), loc(ownerPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef5_jigmelingpa = sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("cat_familiar")).take(1))
				.seq(createCardEffect(wizard_blazing_staff_carddef(), loc(ownerPid, asidePloc)))
				.seq(sacrificeSelf())

		local ef6_jigmelingpa = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("wizard_calm_channel")))
				.seq(createCardEffect(wizard_serene_channel_carddef(), loc(ownerPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef7_jigmelingpa = createCardEffect(wizard_arcane_wand_carddef(), loc(ownerPid, asidePloc))
				.seq(sacrificeSelf())

		local ef8_jigmelingpa = gainMaxHealthEffect(ownerPid, const(5))
				.seq(healPlayerEffect(ownerPid,5))				.seq(sacrificeSelf())
				.seq(sacrificeSelf())

		local ef9_jigmelingpa = createCardEffect(wizard_runic_robes_carddef(), loc(ownerPid, skillsPloc))
				.seq(sacrificeSelf())

		local ef10_jigmelingpa = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("wizard_fireball")))
				.seq(createCardEffect(wizard_rolling_fireball_carddef(), loc(ownerPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef11_jigmelingpa = createCardEffect(wizard_alchemist_s_stone_carddef(), loc(ownerPid, asidePloc))
				.seq(sacrificeSelf())

		local ef12_jigmelingpa = gainMaxHealthEffect(ownerPid, const(5))
				.seq(healPlayerEffect(ownerPid,5))				.seq(sacrificeSelf())

		local ef13_jigmelingpa = createCardEffect(wizard_treasure_map_carddef(), loc(ownerPid, reservePloc))
				.seq(sacrificeSelf())
		
		local ef14_jigmelingpa = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("wizard_rolling_fireball")))
				.seq(createCardEffect(wizard_explosive_fireball_carddef(), loc(ownerPid, skillsPloc)))
				.seq(sacrificeSelf())
		
		local ef15_jigmelingpa = sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("wizard_cat_familiar")))
				.seq(createCardEffect(wizard_wizened_familiar_carddef(), loc(ownerPid, asidePloc)))
				.seq(sacrificeSelf())
		
		local ef16_jigmelingpa = gainMaxHealthEffect(ownerPid, const(5)).seq(healPlayerEffect(ownerPid,5)).seq(sacrificeSelf())
		
		local ef17_jigmelingpa = createCardEffect(wizard_clock_of_ages_carddef(), loc(ownerPid, reservePloc)).seq(sacrificeSelf())

		local ef18_jigmelingpa = gainMaxHealthEffect(ownerPid, const(5)).seq(healPlayerEffect(ownerPid,5)).seq(sacrificeSelf())	

	

local ef_jigmelingpa_start = showSpeechBubbleEffect({playerExpression=ownerPid, text="I'm going on an adventure!", waitForClick= constBoolExpression(false)})

local ef_say_1 = showSpeechBubbleEffect({playerExpression=ownerPid, text="Time for second breakfast!", waitForClick= constBoolExpression(false)})
--Say 1 Trigger = Turn 2

local ef_say_2 = showSpeechBubbleEffect({playerExpression=ownerPid, text="Don't judge a Small Folk by his size!", waitForClick= constBoolExpression(false)})
--Say 2 Trigger = Turn 2

local ef_say_3 = showSpeechBubbleEffect({playerExpression=ownerPid, text="Small Folk are full of surprises!", waitForClick= constBoolExpression(false)})
--Say 3 Trigger = Turn 2

	local ef_jigmelingpa = 
			setPlayerNameEffect("Shizzbo Baggins", ownerPid)
			.seq(setPlayerAvatarEffect("smallfolk_wizard_male_01", ownerPid))
			.seq(gainMaxHealthEffect(ownerPid, const(50)))
				.seq(healPlayerEffect(ownerPid,50))
			.seq(createCardEffect(wizard_channel_carddef(), loc(ownerPid, skillsPloc)))
			.seq(createCardEffect(wizard_fireball_carddef(), loc(ownerPid, skillsPloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc))) --here--
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(ruby_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(wizard_spell_components_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(wizard_cat_familiar_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(wizard_fire_staff_carddef(), loc(ownerPid, asidePloc)))
			.seq(ef_smallfolk)
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(4), ef4_jigmelingpa, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(5), ef5_jigmelingpa, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(6), ef6_jigmelingpa, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(7), ef7_jigmelingpa, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(8), ef8_jigmelingpa, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(9), ef9_jigmelingpa, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(10), ef10_jigmelingpa, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(11), ef11_jigmelingpa, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(12), ef12_jigmelingpa, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(13), ef13_jigmelingpa, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(14), ef14_jigmelingpa, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(15), ef15_jigmelingpa, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(16), ef16_jigmelingpa, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(17), ef17_jigmelingpa, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(18), ef18_jigmelingpa, nullEffect()))
			.seq(moveTarget(loc(ownerPid, deckPloc)).apply(selectLoc(loc(ownerPid, asidePloc))))
			.seq(shuffleEffect(loc(ownerPid, deckPloc)))
			.seq(ef_jigmelingpa_start)
			.seq(createCardEffect(jigmelingpa_winlose_buff_def(), loc(ownerPid, buffsPloc)))


-- Scrapforce levels

		local ef4_scrapforce = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("wizard_channel")))
				.seq(createCardEffect(wizard_calm_channel_carddef(), loc(ownerPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef5_scrapforce = sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("wizard_fire_staff")).take(1))
				.seq(createCardEffect(wizard_blazing_staff_carddef(), loc(ownerPid, asidePloc)))
				.seq(sacrificeSelf())

		local ef6_scrapforce = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("wizard_calm_channel")))
				.seq(createCardEffect(wizard_serene_channel_carddef(), loc(ownerPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef7_scrapforce = createCardEffect(wizard_magic_mirror_carddef(), loc(ownerPid, asidePloc))
				.seq(sacrificeSelf())

		local ef8_scrapforce = gainMaxHealthEffect(ownerPid, const(5))
				.seq(healPlayerEffect(ownerPid,5))				.seq(sacrificeSelf())

		local ef9_scrapforce = createCardEffect(wizard_spellcaster_gloves_carddef(), loc(ownerPid, skillsPloc))
				.seq(sacrificeSelf())

		local ef10_scrapforce = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("wizard_fireball")))
				.seq(createCardEffect(wizard_rolling_fireball_carddef(), loc(ownerPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef11_scrapforce = createCardEffect(wizard_alchemist_s_stone_carddef(), loc(ownerPid, asidePloc))
				.seq(sacrificeSelf())

		local ef12_scrapforce = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("wizard_rolling_fireball")))
				.seq(createCardEffect(wizard_explosive_fireball_carddef(), loc(ownerPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef13_scrapforce = createCardEffect(wizard_treasure_map_carddef(), loc(ownerPid, reservePloc))
				.seq(sacrificeSelf())
		
		local ef14_scrapforce = gainMaxHealthEffect(ownerPid, const(5))
				.seq(healPlayerEffect(ownerPid,5))				.seq(sacrificeSelf())
		
		local ef15_scrapforce = sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("wizard_cat_familiar")))
				.seq(createCardEffect(wizard_content_familiar_carddef(), loc(ownerPid, asidePloc)))
				.seq(sacrificeSelf())
		
		local ef16_scrapforce = gainMaxHealthEffect(ownerPid, const(5)).seq(healPlayerEffect(ownerPid,5)).seq(sacrificeSelf())
		
		local ef17_scrapforce = createCardEffect(wizard_clock_of_ages_carddef(), loc(ownerPid, reservePloc)).seq(sacrificeSelf())

		local ef18_scrapforce = gainMaxHealthEffect(ownerPid, const(5)).seq(healPlayerEffect(ownerPid,5)).seq(sacrificeSelf())	


local ef_scrapforce_start = showSpeechBubbleEffect({playerExpression=ownerPid, text="Time to scrap, suckers!", waitForClick= constBoolExpression(false)})

local ef_say_1 = showSpeechBubbleEffect({playerExpression=ownerPid, text="Oh you know how I like that!", waitForClick= constBoolExpression(false)})
--Say 1 Trigger = Scrap or trash a card 1

local ef_say_2 = showSpeechBubbleEffect({playerExpression=ownerPid, text="I'm full mast now, daddy!", waitForClick= constBoolExpression(false)})
--Say 2 Trigger = Scrap or trash a card 1

local ef_say_3 = showSpeechBubbleEffect({playerExpression=ownerPid, text="I just emptied my sackforce!!!", waitForClick= constBoolExpression(false)})
--Say 3 Trigger = Scrap or trash a card 1

	local ef_scrapforce = 
			setPlayerNameEffect("Hechicero", ownerPid)
			.seq(setPlayerAvatarEffect("smallfolk_wizard_male_02", ownerPid))
			.seq(gainMaxHealthEffect(ownerPid, const(50)))
				.seq(healPlayerEffect(ownerPid,50))
			.seq(createCardEffect(wizard_channel_carddef(), loc(ownerPid, skillsPloc)))
			.seq(createCardEffect(wizard_fireball_carddef(), loc(ownerPid, skillsPloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc))) --here--
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(ruby_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(wizard_spell_components_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(wizard_cat_familiar_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(wizard_fire_staff_carddef(), loc(ownerPid, asidePloc)))
			.seq(ef_smallfolk)
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(4), ef4_scrapforce, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(5), ef5_scrapforce, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(6), ef6_scrapforce, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(7), ef7_scrapforce, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(8), ef8_scrapforce, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(9), ef9_scrapforce, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(10), ef10_scrapforce, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(11), ef11_scrapforce, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(12), ef12_scrapforce, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(13), ef13_scrapforce, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(14), ef14_scrapforce, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(15), ef15_scrapforce, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(16), ef16_scrapforce, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(17), ef17_scrapforce, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(18), ef18_scrapforce, nullEffect()))
			.seq(moveTarget(loc(ownerPid, deckPloc)).apply(selectLoc(loc(ownerPid, asidePloc))))
			.seq(shuffleEffect(loc(ownerPid, deckPloc)))
			.seq(ef_scrapforce_start)
			.seq(createCardEffect(scrapforce_winlose_buff_def(), loc(ownerPid, buffsPloc)))


-- nudeltulpe levels

		local ef4_nudeltulpe = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("druid_forest_rage")))
				.seq(createCardEffect(druid_forest_fury_carddef(), loc(ownerPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef5_nudeltulpe = sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("druid_gnarled_staff")).take(1))
				.seq(createCardEffect(druid_flourishing_staff_carddef(), loc(ownerPid, asidePloc)))
				.seq(sacrificeSelf())

		local ef6_nudeltulpe = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("druid_forest_fury")))
				.seq(createCardEffect(druid_forest_vengeance_carddef(), loc(ownerPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef7_nudeltulpe = createCardEffect(druid_owl_carddef(), loc(ownerPid, asidePloc))
				.seq(sacrificeSelf())

		local ef8_nudeltulpe = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("druid_bear_form")))
				.seq(createCardEffect(druid_grizzly_form_carddef(), loc(ownerPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef9_nudeltulpe = createCardEffect(druid_circlet_of_flowers_carddef(), loc(ownerPid, skillsPloc))
				.seq(sacrificeSelf())

		local ef10_nudeltulpe = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("druid_grizzly_form")))
				.seq(createCardEffect(druid_polar_bear_form_carddef(), loc(ownerPid, skillsPloc)))
				.seq(sacrificeSelf())

		local ef11_nudeltulpe = createCardEffect(druid_ursine_rod_carddef(), loc(ownerPid, asidePloc))
				.seq(sacrificeSelf())

		local ef12_nudeltulpe = gainMaxHealthEffect(ownerPid, const(7))
				.seq(healPlayerEffect(ownerPid,7))				.seq(sacrificeSelf())

		local ef13_nudeltulpe = createCardEffect(druid_panther_eye_ring_carddef(), loc(ownerPid, reservePloc))
				.seq(sacrificeSelf())
		
		local ef14_nudeltulpe = gainMaxHealthEffect(ownerPid, const(7))
				.seq(healPlayerEffect(ownerPid,7))				.seq(sacrificeSelf())
		
		local ef15_nudeltulpe = sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("druid_fox")))
				.seq(createCardEffect(druid_feral_fox_carddef(), loc(ownerPid, asidePloc)))
				.seq(sacrificeSelf())
		
		local ef16_nudeltulpe = gainMaxHealthEffect(ownerPid, const(7)).seq(healPlayerEffect(ownerPid,7)).seq(sacrificeSelf())
		
		local ef17_nudeltulpe = createCardEffect(druid_sunbird_carddef(), loc(ownerPid, reservePloc)).seq(sacrificeSelf())

		local ef18_nudeltulpe = gainMaxHealthEffect(ownerPid, const(7)).seq(healPlayerEffect(ownerPid,7)).seq(sacrificeSelf())	

local ef_nudeltulpe_start = showSpeechBubbleEffect({playerExpression=ownerPid, text="Grrrr", waitForClick= constBoolExpression(false)})

--local ef_nudeltulpe_winlose = createCardEffect(nudeltulpe_win_buff_def(), loc(oppPid, buffsPloc))
--						.seq(createCardEffect(nudeltulpe_lose_buff_def(), loc(curentPid, buffsPloc)))

local ef_say_1 = showSpeechBubbleEffect({playerExpression=ownerPid, text="Grrrr", waitForClick= constBoolExpression(false)})
--Say 1 Trigger = On use of ability

local ef_say_2 = showSpeechBubbleEffect({playerExpression=ownerPid, text="Grrrr", waitForClick= constBoolExpression(false)})
--Say 2 Trigger = On use of ability

local ef_say_3 = showSpeechBubbleEffect({playerExpression=ownerPid, text="Grrrr", waitForClick= constBoolExpression(false)})
--Say 3 Trigger = On use of ability



	local ef_nudeltulpe = 
			setPlayerNameEffect("Cocaine Bear", ownerPid)
			.seq(setPlayerAvatarEffect("druid_02", ownerPid))
			.seq(gainMaxHealthEffect(ownerPid, const(54)))
				.seq(healPlayerEffect(ownerPid,54))
			.seq(createCardEffect(druid_forest_rage_carddef(), loc(ownerPid, skillsPloc)))
			.seq(createCardEffect(druid_bear_form_carddef(), loc(ownerPid, skillsPloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(ruby_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(druid_gnarled_staff_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(druid_fox_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(druid_squirrel_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(druid_hedgehog_carddef(), loc(ownerPid, asidePloc)))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(4), ef4_nudeltulpe, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(5), ef5_nudeltulpe, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(6), ef6_nudeltulpe, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(7), ef7_nudeltulpe, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(8), ef8_nudeltulpe, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(9), ef9_nudeltulpe, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(10), ef10_nudeltulpe, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(11), ef11_nudeltulpe, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(12), ef12_nudeltulpe, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(13), ef13_nudeltulpe, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(14), ef14_nudeltulpe, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(15), ef15_nudeltulpe, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(16), ef16_nudeltulpe, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(17), ef17_nudeltulpe, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(18), ef18_nudeltulpe, nullEffect()))
			.seq(moveTarget(loc(ownerPid, deckPloc)).apply(selectLoc(loc(ownerPid, asidePloc))))
			.seq(shuffleEffect(loc(ownerPid, deckPloc)))
			.seq(ef_nudeltulpe_start)
			--.seq(createCardEffect(nudeltulpe_winlose_buff_def(), loc(nextOppPid, buffsPloc)))

local ef_rando1_start = showSpeechBubbleEffect({playerExpression=ownerPid, text="This deal is getting worse all the time.", waitForClick= constBoolExpression(false)})
local ef_rando2_start = showSpeechBubbleEffect({playerExpression=ownerPid, text="You picked the wrong man to push.", waitForClick= constBoolExpression(false)})

		local ef4_random_ranger = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("ranger_track")))
				.seq(randomEffect({
                        valueItem(1, createCardEffect(ranger_fast_track_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(ranger_careful_track_carddef(), loc(ownerPid, skillsPloc))),
						}))
				.seq(sacrificeSelf())

		local ef5_random_ranger = randomEffect({
                        valueItem(1, sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("gold")).take(1)).seq(createCardEffect(ranger_light_crossbow_carddef(), loc(ownerPid, asidePloc)))),
						valueItem(1, sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("ranger_black_arrow")).take(1)).seq(createCardEffect(ranger_honed_black_arrow_carddef(), loc(ownerPid, asidePloc)))),
						})
				.seq(sacrificeSelf())

		local ef6_random_ranger = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("ranger_fast_track").Or(isCardName("ranger_careful_track"))))
				.seq(randomEffect({
                        valueItem(1, createCardEffect(ranger_instinctive_track_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(ranger_relentless_track_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(ranger_flawless_track_carddef(), loc(ownerPid, skillsPloc))),
						}))
				.seq(sacrificeSelf())

		local ef7_random_ranger = randomEffect({
                        valueItem(1, createCardEffect(ranger_unending_quiver_carddef(), loc(ownerPid, asidePloc))),
						valueItem(1, createCardEffect(ranger_snake_pet_carddef(), loc(ownerPid, asidePloc))),
						})
				.seq(sacrificeSelf())

		local ef8_random_ranger = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("ranger_headshot")))
				.seq(randomEffect({
                        valueItem(1, createCardEffect(ranger_quickshot_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(ranger_twin_shot_carddef(), loc(ownerPid, skillsPloc))),
						}))
				.seq(sacrificeSelf())

		local ef9_random_ranger = randomEffect({
                        valueItem(1, createCardEffect(ranger_sureshot_bracer_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(ranger_hunters_cloak_carddef(), loc(ownerPid, skillsPloc))),
						})
				.seq(sacrificeSelf())
		
		local ef10_random_ranger = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("ranger_quickshot").Or(isCardName("ranger_twin_shot"))))
				.seq(randomEffect({
                        valueItem(1, createCardEffect(ranger_snapshot_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(ranger_longshot_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(ranger_triple_shot_carddef(), loc(ownerPid, skillsPloc))),
						}))
				.seq(sacrificeSelf())

		local ef11_random_ranger = randomEffect({
                        valueItem(1, createCardEffect(ranger_flashfire_arrow_carddef(), loc(ownerPid, asidePloc))),
						valueItem(1, createCardEffect(ranger_pathfinder_compass_carddef(), loc(ownerPid, asidePloc))),
						})
				.seq(sacrificeSelf())

		local ef12_random_ranger = gainMaxHealthEffect(ownerPid, const(8))
				.seq(healPlayerEffect(ownerPid,8))
				.seq(sacrificeSelf())

		local ef13_random_ranger = randomEffect({
                        valueItem(1, createCardEffect(ranger_parrot_carddef(), loc(ownerPid, reservePloc))),
						valueItem(1, createCardEffect(ranger_spyglass_carddef(), loc(ownerPid, reservePloc))),
						})
				.seq(sacrificeSelf())
		
		local ef14_random_ranger = gainMaxHealthEffect(ownerPid, const(8))
				.seq(healPlayerEffect(ownerPid,8))
				.seq(sacrificeSelf())
		
		local ef15_random_ranger = sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("ranger_horn_of_calling")))
				.seq(randomEffect({
                        valueItem(1, createCardEffect(ranger_horn_of_command_carddef(), loc(ownerPid, asidePloc))),
						valueItem(1, createCardEffect(ranger_horn_of_need_carddef(), loc(ownerPid, asidePloc))),
						}))
				.seq(sacrificeSelf())
		
		local ef16_random_ranger = gainMaxHealthEffect(ownerPid, const(8))
				.seq(healPlayerEffect(ownerPid,8))
				.seq(sacrificeSelf())
		
		local ef17_random_ranger = randomEffect({
                        valueItem(1, createCardEffect(ranger_death_arrow_carddef(), loc(ownerPid, reservePloc))),
						valueItem(1, createCardEffect(ranger_veiled_trap_carddef(), loc(ownerPid, reservePloc))),
						})
				.seq(sacrificeSelf())

		local ef18_random_ranger = gainMaxHealthEffect(ownerPid, const(8))
				.seq(healPlayerEffect(ownerPid,8))
				.seq(sacrificeSelf())	
				
local ef_base_ranger =
			setPlayerAvatarEffect("ranger_02", ownerPid)
			.seq(gainMaxHealthEffect(ownerPid, const(50)))
				.seq(healPlayerEffect(ownerPid,50))
			.seq(createCardEffect(ranger_track_carddef(), loc(ownerPid, skillsPloc)))
			.seq(createCardEffect(ranger_headshot_carddef(), loc(ownerPid, skillsPloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(ruby_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(ranger_horn_of_calling_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(ranger_black_arrow_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(ranger_black_arrow_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(ranger_hunting_bow_carddef(), loc(ownerPid, asidePloc)))
		--levels	
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(4), ef4_random_ranger, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(5), ef5_random_ranger, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(6), ef6_random_ranger, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(7), ef7_random_ranger, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(8), ef8_random_ranger, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(9), ef9_random_ranger, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(10), ef10_random_ranger, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(11), ef11_random_ranger, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(12), ef12_random_ranger, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(13), ef13_random_ranger, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(14), ef14_random_ranger, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(15), ef15_random_ranger, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(16), ef16_random_ranger, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(17), ef17_random_ranger, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(18), ef18_random_ranger, nullEffect()))
	


		local ef4_random_fighter = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("fighter_shoulder_bash")))
				.seq(randomEffect({
                        valueItem(1, createCardEffect(fighter_knock_back_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(fighter_shoulder_smash_carddef(), loc(ownerPid, skillsPloc))),
						}))
				.seq(sacrificeSelf())

		local ef5_random_fighter = randomEffect({
                        valueItem(1, sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("gold")).take(1)).seq(createCardEffect(fighter_hand_scythe_carddef(), loc(ownerPid, asidePloc)))),
						valueItem(1, sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("fighter_shield_bearer")).take(1)).seq(createCardEffect(fighter_seasoned_shield_bearer_carddef(), loc(ownerPid, asidePloc)))),
						})
				.seq(sacrificeSelf())

		local ef6_random_fighter = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("fighter_knock_back").Or(isCardName("fighter_shoulder_smash"))))
				.seq(randomEffect({
                        valueItem(1, createCardEffect(fighter_group_tackle_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(fighter_knock_down_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(fighter_shoulder_crush_carddef(), loc(ownerPid, skillsPloc))),
						}))
				.seq(sacrificeSelf())

		local ef7_random_fighter = randomEffect({
                        valueItem(1, createCardEffect(fighter_double_bladed_axe_carddef(), loc(ownerPid, asidePloc))),
						valueItem(1, createCardEffect(fighter_jagged_spear_carddef(), loc(ownerPid, asidePloc))),
						})
				.seq(sacrificeSelf())

		local ef8_random_fighter = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("fighter_crushing_blow")))
				.seq(randomEffect({
                        valueItem(1, createCardEffect(fighter_sweeping_blow_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(fighter_smashing_blow_carddef(), loc(ownerPid, skillsPloc))),
						}))
				.seq(sacrificeSelf())

		local ef9_random_fighter = randomEffect({
                        valueItem(1, createCardEffect(fighter_helm_of_fury_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(fighter_spiked_pauldrons_carddef(), loc(ownerPid, skillsPloc))),
						})
				.seq(sacrificeSelf())
		
		local ef10_random_fighter = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("fighter_sweeping_blow").Or(isCardName("fighter_smashing_blow"))))
				.seq(randomEffect({
                        valueItem(1, createCardEffect(fighter_whirling_blow_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(fighter_mighty_blow_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(fighter_devastating_blow_carddef(), loc(ownerPid, skillsPloc))),
						}))
				.seq(sacrificeSelf())

		local ef11_random_fighter = randomEffect({
                        valueItem(1, sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("gold")).take(1)).seq(createCardEffect(fighter_rallying_flag_carddef(), loc(ownerPid, asidePloc)))),
						valueItem(1, createCardEffect(fighter_sharpening_stone_carddef(), loc(ownerPid, asidePloc))),
						})
				.seq(sacrificeSelf())

		local ef12_random_fighter = gainMaxHealthEffect(ownerPid, const(9))
				.seq(healPlayerEffect(ownerPid,9))
				.seq(sacrificeSelf())

		local ef13_random_fighter = randomEffect({
                        valueItem(1, createCardEffect(fighter_cutlass_carddef(), loc(ownerPid, reservePloc))),
						valueItem(1, createCardEffect(fighter_bottle_of_rum_carddef(), loc(ownerPid, reservePloc))),
						})
				.seq(sacrificeSelf())
		
		local ef14_random_fighter = gainMaxHealthEffect(ownerPid, const(9))
				.seq(healPlayerEffect(ownerPid,9))
				.seq(sacrificeSelf())
		
		local ef15_random_fighter = sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("fighter_longsword")))
				.seq(randomEffect({
                        valueItem(1, createCardEffect(fighter_flaming_longsword_carddef(), loc(ownerPid, asidePloc))),
						valueItem(1, createCardEffect(fighter_lightning_longsword_carddef(), loc(ownerPid, asidePloc))),
						}))
				.seq(sacrificeSelf())
		
		local ef16_random_fighter = gainMaxHealthEffect(ownerPid, const(9))
				.seq(healPlayerEffect(ownerPid,9))
				.seq(sacrificeSelf())
		
		local ef17_random_fighter = randomEffect({
                        valueItem(1, createCardEffect(fighter_chain_carddef(), loc(ownerPid, reservePloc))),
						valueItem(1, createCardEffect(fighter_javelin_carddef(), loc(ownerPid, reservePloc))),
						})
				.seq(sacrificeSelf())

		local ef18_random_fighter = gainMaxHealthEffect(ownerPid, const(9))
				.seq(healPlayerEffect(ownerPid,9))
				.seq(sacrificeSelf())	
				
local ef_base_fighter = 
setPlayerAvatarEffect("fighter_02", ownerPid)
			.seq(gainMaxHealthEffect(ownerPid, const(60)))
				.seq(healPlayerEffect(ownerPid,60))
			.seq(createCardEffect(fighter_shoulder_bash_carddef(), loc(ownerPid, skillsPloc)))
			.seq(createCardEffect(fighter_crushing_blow_carddef(), loc(ownerPid, skillsPloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(ruby_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(fighter_shield_bearer_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(fighter_throwing_axe_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(fighter_longsword_carddef(), loc(ownerPid, asidePloc)))
		--levels	
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(4), ef4_random_fighter, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(5), ef5_random_fighter, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(6), ef6_random_fighter, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(7), ef7_random_fighter, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(8), ef8_random_fighter, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(9), ef9_random_fighter, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(10), ef10_random_fighter, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(11), ef11_random_fighter, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(12), ef12_random_fighter, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(13), ef13_random_fighter, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(14), ef14_random_fighter, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(15), ef15_random_fighter, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(16), ef16_random_fighter, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(17), ef17_random_fighter, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(18), ef18_random_fighter, nullEffect()))

		local ef4_random_cleric = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("cleric_bless")))
				.seq(randomEffect({
                        valueItem(1, createCardEffect(cleric_bless_of_iron_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(cleric_bless_of_heart_carddef(), loc(ownerPid, skillsPloc))),
						}))
				.seq(sacrificeSelf())

		local ef5_random_cleric = randomEffect({
                        valueItem(1, sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("gold")).take(1)).seq(createCardEffect(cleric_everburning_candle_carddef(), loc(ownerPid, asidePloc)))),
						valueItem(1, sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("cleric_follower_a")).take(1)).seq(createCardEffect(cleric_veteran_follower_carddef(), loc(ownerPid, asidePloc)))),
						})
				.seq(sacrificeSelf())

		local ef6_random_cleric = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("cleric_bless_of_iron").Or(isCardName("cleric_bless_of_heart"))))
				.seq(randomEffect({
                        valueItem(1, createCardEffect(cleric_bless_of_steel_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(cleric_bless_the_flock_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(cleric_bless_of_soul_carddef(), loc(ownerPid, skillsPloc))),
						}))
				.seq(sacrificeSelf())

		local ef7_random_cleric = randomEffect({
                        valueItem(1, createCardEffect(cleric_brightstar_shield_carddef(), loc(ownerPid, asidePloc))),
						valueItem(1, createCardEffect(cleric_redeemed_ruinos_carddef(), loc(ownerPid, asidePloc))),
						})
				.seq(sacrificeSelf())

		local ef8_random_cleric = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("cleric_resurrect")))
				.seq(randomEffect({
                        valueItem(1, createCardEffect(cleric_battle_resurrect_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(cleric_holy_resurrect_carddef(), loc(ownerPid, skillsPloc))),
						}))
				.seq(sacrificeSelf())

		local ef9_random_cleric = randomEffect({
                        valueItem(1, createCardEffect(cleric_phoenix_helm_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(cleric_shining_breastplate_carddef(), loc(ownerPid, skillsPloc))),
						})
				.seq(sacrificeSelf())
		
		local ef10_random_cleric = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("cleric_battle_resurrect").Or(isCardName("cleric_holy_resurrect"))))
				.seq(randomEffect({
                        valueItem(1, createCardEffect(cleric_mass_resurrect_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(cleric_righteous_resurrect_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(cleric_divine_resurrect_carddef(), loc(ownerPid, skillsPloc))),
						}))
				.seq(sacrificeSelf())

		local ef11_random_cleric = randomEffect({
                        valueItem(1, createCardEffect(cleric_hammer_of_light_carddef(), loc(ownerPid, asidePloc))),
						valueItem(1, createCardEffect(cleric_talisman_of_renewal_carddef(), loc(ownerPid, asidePloc))),
						})
				.seq(sacrificeSelf())

		local ef12_random_cleric = gainMaxHealthEffect(ownerPid, const(7))
				.seq(healPlayerEffect(ownerPid,7))
				.seq(sacrificeSelf())

		local ef13_random_cleric = randomEffect({
                        valueItem(1, createCardEffect(cleric_ship_s_bell_carddef(), loc(ownerPid, reservePloc))),
						valueItem(1, createCardEffect(cleric_imperial_sailor_carddef(), loc(ownerPid, reservePloc))),
						})
				.seq(sacrificeSelf())
		
		local ef14_random_cleric = gainMaxHealthEffect(ownerPid, const(7))
				.seq(healPlayerEffect(ownerPid,7))
				.seq(sacrificeSelf())
		
		local ef15_random_cleric = sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("cleric_spiked_mace")))
				.seq(randomEffect({
                        valueItem(1, createCardEffect(cleric_spiked_mace_of_glory_carddef(), loc(ownerPid, asidePloc))),
						valueItem(1, createCardEffect(cleric_spiked_mace_of_might_carddef(), loc(ownerPid, asidePloc))),
						}))
				.seq(sacrificeSelf())
		
		local ef16_random_cleric = gainMaxHealthEffect(ownerPid, const(7))
				.seq(healPlayerEffect(ownerPid,7))
				.seq(sacrificeSelf())
		
		local ef17_random_cleric = randomEffect({
                        valueItem(1, createCardEffect(cleric_sacred_censer_carddef(), loc(ownerPid, reservePloc))),
						valueItem(1, createCardEffect(cleric_holy_water_carddef(), loc(ownerPid, reservePloc))),
						})
				.seq(sacrificeSelf())

		local ef18_random_cleric = gainMaxHealthEffect(ownerPid, const(7))
				.seq(healPlayerEffect(ownerPid,7))
				.seq(sacrificeSelf())

local ef_base_cleric = 
setPlayerAvatarEffect("cleric_02", ownerPid)
			.seq(gainMaxHealthEffect(ownerPid, const(55)))
				.seq(healPlayerEffect(ownerPid,55))
			.seq(createCardEffect(cleric_bless_carddef(), loc(ownerPid, skillsPloc)))
			.seq(createCardEffect(cleric_resurrect_carddef(), loc(ownerPid, skillsPloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(cleric_follower_a_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(cleric_follower_b_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(cleric_spiked_mace_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(cleric_prayer_beads_carddef(), loc(ownerPid, asidePloc)))
		--add in extras
		--levels	
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(4), ef4_random_cleric, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(5), ef5_random_cleric, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(6), ef6_random_cleric, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(7), ef7_random_cleric, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(8), ef8_random_cleric, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(9), ef9_random_cleric, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(10), ef10_random_cleric, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(11), ef11_random_cleric, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(12), ef12_random_cleric, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(13), ef13_random_cleric, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(14), ef14_random_cleric, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(15), ef15_random_cleric, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(16), ef16_random_cleric, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(17), ef17_random_cleric, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(18), ef18_random_cleric, nullEffect()))
			

		local ef4_random_thief = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("thief_pickpocket")))
				.seq(randomEffect({
                        valueItem(1, createCardEffect(thief_sleight_of_hand_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(thief_swipe_carddef(), loc(ownerPid, skillsPloc))),
						}))
				.seq(sacrificeSelf())

		local ef5_random_thief = randomEffect({
                        valueItem(1, sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("gold")).take(1)).seq(createCardEffect(thief_enchanted_garrote_carddef(), loc(ownerPid, asidePloc)))),
						valueItem(1, sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("thief_throwing_knife")).take(1)).seq(createCardEffect(thief_keen_throwing_knife_carddef(), loc(ownerPid, asidePloc)))),
						})
				.seq(sacrificeSelf())

		local ef6_random_thief = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("thief_sleight_of_hand").Or(isCardName("thief_swipe"))))
				.seq(randomEffect({
                        valueItem(1, createCardEffect(thief_misdirection_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(thief_distracted_exchange_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(thief_lift_carddef(), loc(ownerPid, skillsPloc))),
						}))
				.seq(sacrificeSelf())

		local ef7_random_thief = randomEffect({
                        valueItem(1, createCardEffect(thief_knife_belt_carddef(), loc(ownerPid, asidePloc))),
						valueItem(1, createCardEffect(thief_sacrificial_dagger_carddef(), loc(ownerPid, asidePloc))),
						})
				.seq(sacrificeSelf())

		local ef8_random_thief = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("thief_heist")))
				.seq(randomEffect({
                        valueItem(1, createCardEffect(thief_timely_heist_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(thief_skillful_heist_carddef(), loc(ownerPid, skillsPloc))),
						}))
				.seq(sacrificeSelf())

		local ef9_random_thief = randomEffect({
                        valueItem(1, createCardEffect(thief_shadow_mask_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(thief_silent_boots_carddef(), loc(ownerPid, skillsPloc))),
						})
				.seq(sacrificeSelf())
		
		local ef10_random_thief = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("thief_timely_heist").Or(isCardName("thief_skillful_heist"))))
				.seq(randomEffect({
                        valueItem(1, createCardEffect(thief_practiced_heist_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(thief_smooth_heist_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(thief_masterful_heist_carddef(), loc(ownerPid, skillsPloc))),
						}))
				.seq(sacrificeSelf())

		local ef11_random_thief = randomEffect({
                        valueItem(1, createCardEffect(thief_blackjack_carddef(), loc(ownerPid, asidePloc))),
						valueItem(1, createCardEffect(thief_jewelers_loupe_carddef(), loc(ownerPid, asidePloc))),
						})
				.seq(sacrificeSelf())

		local ef12_random_thief = gainMaxHealthEffect(ownerPid, const(6))
				.seq(healPlayerEffect(ownerPid,6))
				.seq(sacrificeSelf())

		local ef13_random_thief = randomEffect({
                        valueItem(1, createCardEffect(thief_hook_carddef(), loc(ownerPid, reservePloc))),
						valueItem(1, createCardEffect(thief_trick_dice_carddef(), loc(ownerPid, reservePloc))),
						})
				.seq(sacrificeSelf())
		
		local ef14_random_thief = gainMaxHealthEffect(ownerPid, const(6))
				.seq(healPlayerEffect(ownerPid,6))
				.seq(sacrificeSelf())
		
		local ef15_random_thief = sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("thief_ruby")))
				.seq(randomEffect({
                        valueItem(1, createCardEffect(thief_brilliant_ruby_carddef(), loc(ownerPid, asidePloc))),
						valueItem(1, createCardEffect(thief_sharpened_ruby_carddef(), loc(ownerPid, asidePloc))),
						}))
				.seq(sacrificeSelf())
		
		local ef16_random_thief = gainMaxHealthEffect(ownerPid, const(6))
				.seq(healPlayerEffect(ownerPid,6))
				.seq(sacrificeSelf())
		
		local ef17_random_thief = randomEffect({
                        valueItem(1, createCardEffect(thief_kunai_carddef(), loc(ownerPid, reservePloc))),
						valueItem(1, createCardEffect(thief_blinding_powder_carddef(), loc(ownerPid, reservePloc))),
						})
				.seq(sacrificeSelf())

		local ef18_random_thief = gainMaxHealthEffect(ownerPid, const(6))
				.seq(healPlayerEffect(ownerPid,6))
				.seq(sacrificeSelf())

local ef_base_thief = 
setPlayerAvatarEffect("thief_02", ownerPid)
			.seq(gainMaxHealthEffect(ownerPid, const(52)))
				.seq(healPlayerEffect(ownerPid,52))
			.seq(createCardEffect(thief_pickpocket_carddef(), loc(ownerPid, skillsPloc)))
			.seq(createCardEffect(thief_heist_carddef(), loc(ownerPid, skillsPloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(ruby_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(ruby_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(thief_throwing_knife_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(thief_throwing_knife_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(thief_throwing_knife_carddef(), loc(ownerPid, asidePloc)))
		--add in extras
		--levels	
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(4), ef4_random_thief, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(5), ef5_random_thief, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(6), ef6_random_thief, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(7), ef7_random_thief, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(8), ef8_random_thief, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(9), ef9_random_thief, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(10), ef10_random_thief, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(11), ef11_random_thief, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(12), ef12_random_thief, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(13), ef13_random_thief, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(14), ef14_random_thief, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(15), ef15_random_thief, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(16), ef16_random_thief, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(17), ef17_random_thief, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(18), ef18_random_thief, nullEffect()))
			
		local ef4_random_wizard = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("wizard_channel")))
				.seq(randomEffect({
                        valueItem(1, createCardEffect(wizard_deep_channel_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(wizard_calm_channel_carddef(), loc(ownerPid, skillsPloc))),
						}))
				.seq(sacrificeSelf())

		local ef5_random_wizard = randomEffect({
                        valueItem(1, sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("gold")).take(1)).seq(createCardEffect(wizard_serpentine_staff_carddef(), loc(ownerPid, asidePloc)))),
						valueItem(1, sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("wizard_fire_staff")).take(1)).seq(createCardEffect(wizard_blazing_staff_carddef(), loc(ownerPid, asidePloc)))),
						})
				.seq(sacrificeSelf())

		local ef6_random_wizard = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("wizard_deep_channel").Or(isCardName("wizard_calm_channel"))))
				.seq(randomEffect({
                        valueItem(1, createCardEffect(wizard_soul_channel_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(wizard_pure_channel_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(wizard_serene_channel_carddef(), loc(ownerPid, skillsPloc))),
						}))
				.seq(sacrificeSelf())

		local ef7_random_wizard = randomEffect({
                        valueItem(1, createCardEffect(wizard_arcane_wand_carddef(), loc(ownerPid, asidePloc))),
						valueItem(1, createCardEffect(wizard_silverskull_amulet_carddef(), loc(ownerPid, asidePloc))),
						})
				.seq(sacrificeSelf())

		local ef8_random_wizard = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("wizard_fireball")))
				.seq(randomEffect({
                        valueItem(1, createCardEffect(wizard_rolling_fireball_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(wizard_scorching_fireball_carddef(), loc(ownerPid, skillsPloc))),
						}))
				.seq(sacrificeSelf())

		local ef9_random_wizard = randomEffect({
                        valueItem(1, createCardEffect(wizard_runic_robes_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(wizard_spellcaster_gloves_carddef(), loc(ownerPid, skillsPloc))),
						})
				.seq(sacrificeSelf())
		
		local ef10_random_wizard = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("wizard_rolling_fireball").Or(isCardName("wizard_scorching_fireball"))))
				.seq(randomEffect({
                        valueItem(1, createCardEffect(wizard_barreling_fireball_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(wizard_explosive_fireball_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(wizard_searing_fireball_carddef(), loc(ownerPid, skillsPloc))),
						}))
				.seq(sacrificeSelf())

		local ef11_random_wizard = randomEffect({
                        valueItem(1, createCardEffect(wizard_alchemist_s_stone_carddef(), loc(ownerPid, asidePloc))),
						valueItem(1, createCardEffect(wizard_magic_mirror_carddef(), loc(ownerPid, asidePloc))),
						})
				.seq(sacrificeSelf())

		local ef12_random_wizard = gainMaxHealthEffect(ownerPid, const(5))
				.seq(healPlayerEffect(ownerPid,5))
				.seq(sacrificeSelf())

		local ef13_random_wizard = randomEffect({
                        valueItem(1, createCardEffect(wizard_ship_in_a_bottle_carddef(), loc(ownerPid, reservePloc))),
						valueItem(1, createCardEffect(wizard_treasure_map_carddef(), loc(ownerPid, reservePloc))),
						})
				.seq(sacrificeSelf())
		
		local ef14_random_wizard = gainMaxHealthEffect(ownerPid, const(5))
				.seq(healPlayerEffect(ownerPid,5))
				.seq(sacrificeSelf())
		
		local ef15_random_wizard = sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("wizard_cat_familiar")))
				.seq(randomEffect({
                        valueItem(1, createCardEffect(wizard_wizened_familiar_carddef(), loc(ownerPid, asidePloc))),
						valueItem(1, createCardEffect(wizard_content_familiar_carddef(), loc(ownerPid, asidePloc))),
						}))
				.seq(sacrificeSelf())
		
		local ef16_random_wizard = gainMaxHealthEffect(ownerPid, const(5))
				.seq(healPlayerEffect(ownerPid,5))
				.seq(sacrificeSelf())
		
		local ef17_random_wizard = randomEffect({
                        valueItem(1, createCardEffect(wizard_prestidigitation_charm_carddef(), loc(ownerPid, reservePloc))),
						valueItem(1, createCardEffect(wizard_clock_of_ages_carddef(), loc(ownerPid, reservePloc))),
						})
				.seq(sacrificeSelf())

		local ef18_random_wizard = gainMaxHealthEffect(ownerPid, const(5))
				.seq(healPlayerEffect(ownerPid,5))
				.seq(sacrificeSelf())

local ef_base_wizard = 
setPlayerAvatarEffect("wizard_02", ownerPid)
			.seq(gainMaxHealthEffect(ownerPid, const(50)))
				.seq(healPlayerEffect(ownerPid,50))
			.seq(createCardEffect(wizard_channel_carddef(), loc(ownerPid, skillsPloc)))
			.seq(createCardEffect(wizard_fireball_carddef(), loc(ownerPid, skillsPloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(ruby_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(wizard_ignite_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(wizard_ignite_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(wizard_cat_familiar_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(wizard_fire_staff_carddef(), loc(ownerPid, asidePloc)))
		--add in extras
		--levels	
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(4), ef4_random_wizard, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(5), ef5_random_wizard, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(6), ef6_random_wizard, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(7), ef7_random_wizard, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(8), ef8_random_wizard, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(9), ef9_random_wizard, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(10), ef10_random_wizard, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(11), ef11_random_wizard, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(12), ef12_random_wizard, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(13), ef13_random_wizard, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(14), ef14_random_wizard, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(15), ef15_random_wizard, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(16), ef16_random_wizard, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(17), ef17_random_wizard, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(18), ef18_random_wizard, nullEffect()))
			
		local ef4_random_alchemist = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("alchemist_reflect")))
				.seq(randomEffect({
                        valueItem(1, createCardEffect(alchemist_dispersion_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(alchemist_refraction_carddef(), loc(ownerPid, skillsPloc))),
						}))
				.seq(sacrificeSelf())

		local ef5_random_alchemist = randomEffect({
                        valueItem(1, sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("alchemist_frothing_potion")).take(1)).seq(createCardEffect(alchemist_sloshing_potion_carddef(), loc(ownerPid, asidePloc)))),
						valueItem(1, sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("gold")).take(1)).seq(createCardEffect(alchemist_fools_gold_carddef(), loc(ownerPid, asidePloc)))),
						})
				.seq(sacrificeSelf())

		local ef6_random_alchemist = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("alchemist_dispersion").Or(isCardName("alchemist_refraction"))))
				.seq(randomEffect({
                        valueItem(1, createCardEffect(alchemist_wide_diffusion_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(alchemist_prismatic_dispersion_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(alchemist_perfect_refraction_carddef(), loc(ownerPid, skillsPloc))),
						}))
				.seq(sacrificeSelf())

		local ef7_random_alchemist = randomEffect({
                        valueItem(1, createCardEffect(alchemist_crucible_carddef(), loc(ownerPid, asidePloc))),
						valueItem(1, createCardEffect(alchemist_bottled_tempest_carddef(), loc(ownerPid, asidePloc))),
						})
				.seq(sacrificeSelf())

		local ef8_random_alchemist = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("alchemist_transmutation")))
				.seq(randomEffect({
                        valueItem(1, createCardEffect(alchemist_rapid_transmutation_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(alchemist_transmogrification_carddef(), loc(ownerPid, skillsPloc))),
						}))
				.seq(sacrificeSelf())

		local ef9_random_alchemist = randomEffect({
                        valueItem(1, createCardEffect(alchemist_spectrum_spectacles_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(alchemist_auric_gloves_carddef(), loc(ownerPid, skillsPloc))),
						})
				.seq(sacrificeSelf())
		
		local ef10_random_alchemist = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("alchemist_rapid_transmutation").Or(isCardName("alchemist_transmogrification"))))
				.seq(randomEffect({
                        valueItem(1, createCardEffect(alchemist_instant_transmutation_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(alchemist_rapid_transmogrification_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(alchemist_major_transmogrification_carddef(), loc(ownerPid, skillsPloc))),
						}))
				.seq(sacrificeSelf())

		local ef11_random_alchemist = randomEffect({
                        valueItem(1, sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("gold")).take(1)).seq(createCardEffect(alchemist_alchemy_powders_carddef(), loc(ownerPid, asidePloc)))),
						valueItem(1, createCardEffect(alchemist_brittle_gas_carddef(), loc(ownerPid, asidePloc))),
						})
				.seq(sacrificeSelf())

		local ef12_random_alchemist = gainMaxHealthEffect(ownerPid, const(6))
				.seq(healPlayerEffect(ownerPid,6))
				.seq(sacrificeSelf())

		local ef13_random_alchemist = randomEffect({
                        valueItem(1, createCardEffect(alchemist_fireworks_carddef(), loc(ownerPid, reservePloc))),
						valueItem(1, createCardEffect(alchemist_recalibration_crystal_carddef(), loc(ownerPid, reservePloc))),
						})
				.seq(sacrificeSelf())
		
		local ef14_random_alchemist = gainMaxHealthEffect(ownerPid, const(6))
				.seq(healPlayerEffect(ownerPid,6))
				.seq(sacrificeSelf())
		
		local ef15_random_alchemist = sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("alchemist_philosophers_stone")))
				.seq(randomEffect({
                        valueItem(1, createCardEffect(alchemist_polished_philosophers_stone_carddef(), loc(ownerPid, asidePloc))),
						valueItem(1, createCardEffect(alchemist_swirling_philosophers_stone_carddef(), loc(ownerPid, asidePloc))),
						}))
				.seq(sacrificeSelf())
		
		local ef16_random_alchemist = gainMaxHealthEffect(ownerPid, const(6))
				.seq(healPlayerEffect(ownerPid,6))
				.seq(sacrificeSelf())
		
		local ef17_random_alchemist = randomEffect({
                        valueItem(1, createCardEffect(alchemist_kaleidoscope_carddef(), loc(ownerPid, reservePloc))),
						valueItem(1, createCardEffect(alchemist_vial_of_acid_carddef(), loc(ownerPid, reservePloc))),
						})
				.seq(sacrificeSelf())

		local ef18_random_alchemist = gainMaxHealthEffect(ownerPid, const(6))
				.seq(healPlayerEffect(ownerPid,6))
				.seq(sacrificeSelf())

local ef_base_alchemist = 
setPlayerAvatarEffect("alchemist_02", ownerPid)
			.seq(gainMaxHealthEffect(ownerPid, const(53)))
				.seq(healPlayerEffect(ownerPid,53))
			.seq(createCardEffect(alchemist_reflect_carddef(), loc(ownerPid, skillsPloc)))
			.seq(createCardEffect(alchemist_transmutation_carddef(), loc(ownerPid, skillsPloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(ruby_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(alchemist_frothing_potion_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(alchemist_frothing_potion_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(alchemist_philosophers_stone_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(alchemist_philosophers_stone_carddef(), loc(ownerPid, asidePloc)))
			
		--add in extras
		--levels	
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(4), ef4_random_alchemist, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(5), ef5_random_alchemist, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(6), ef6_random_alchemist, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(7), ef7_random_alchemist, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(8), ef8_random_alchemist, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(9), ef9_random_alchemist, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(10), ef10_random_alchemist, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(11), ef11_random_alchemist, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(12), ef12_random_alchemist, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(13), ef13_random_alchemist, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(14), ef14_random_alchemist, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(15), ef15_random_alchemist, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(16), ef16_random_alchemist, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(17), ef17_random_alchemist, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(18), ef18_random_alchemist, nullEffect()))
			
		local ef4_random_barbarian = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("barbarian_inner_rage")))
				.seq(randomEffect({
                        valueItem(1, createCardEffect(barbarian_smoldering_rage_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(barbarian_flaring_rage_carddef(), loc(ownerPid, skillsPloc))),
						}))
				.seq(sacrificeSelf())

		local ef5_random_barbarian = randomEffect({
                        valueItem(1, sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("barbarian_hand_axe")).take(1)).seq(createCardEffect(barbarian_serrated_hand_axe_carddef(), loc(ownerPid, asidePloc)))),
						valueItem(1, sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("gold")).take(1)).seq(createCardEffect(barbarian_amulet_of_stifled_pain_carddef(), loc(ownerPid, asidePloc)))),
						})
				.seq(sacrificeSelf())

		local ef6_random_barbarian = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("barbarian_smoldering_rage").Or(isCardName("barbarian_flaring_rage"))))
				.seq(randomEffect({
                        valueItem(1, createCardEffect(barbarian_eternal_rage_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(barbarian_fiery_rage_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(barbarian_explosive_rage_carddef(), loc(ownerPid, skillsPloc))),
						}))
				.seq(sacrificeSelf())

		local ef7_random_barbarian = randomEffect({
                        valueItem(1, createCardEffect(barbarian_wolf_companion_carddef(), loc(ownerPid, asidePloc))),
						valueItem(1, createCardEffect(barbarian_flail_carddef(), loc(ownerPid, asidePloc))),
						})
				.seq(sacrificeSelf())

		local ef8_random_barbarian = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("barbarian_roar")))
				.seq(randomEffect({
                        valueItem(1, createCardEffect(barbarian_terrifying_roar_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(barbarian_battle_cry_carddef(), loc(ownerPid, skillsPloc))),
						}))
				.seq(sacrificeSelf())

		local ef9_random_barbarian = randomEffect({
                        valueItem(1, createCardEffect(barbarian_stomping_boots_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(barbarian_razor_bracers_carddef(), loc(ownerPid, skillsPloc))),
						})
				.seq(sacrificeSelf())
		
		local ef10_random_barbarian = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("barbarian_terrifying_roar").Or(isCardName("barbarian_battle_cry"))))
				.seq(randomEffect({
                        valueItem(1, createCardEffect(barbarian_terrifying_howl_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(barbarian_battle_roar_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(barbarian_war_cry_carddef(), loc(ownerPid, skillsPloc))),
						}))
				.seq(sacrificeSelf())

		local ef11_random_barbarian = randomEffect({
                        valueItem(1, createCardEffect(barbarian_bone_axe_carddef(), loc(ownerPid, asidePloc))),
						valueItem(1, createCardEffect(barbarian_crushed_coin_carddef(), loc(ownerPid, asidePloc))),
						})
				.seq(sacrificeSelf())

		local ef12_random_barbarian = gainMaxHealthEffect(ownerPid, const(10))
				.seq(healPlayerEffect(ownerPid,10))
				.seq(sacrificeSelf())

		local ef13_random_barbarian = randomEffect({
                        valueItem(1, createCardEffect(barbarian_ring_of_rage_carddef(), loc(ownerPid, reservePloc))),
						valueItem(1, createCardEffect(barbarian_earthshaker_carddef(), loc(ownerPid, reservePloc))),
						})
				.seq(sacrificeSelf())
		
		local ef14_random_barbarian = gainMaxHealthEffect(ownerPid, const(10))
				.seq(healPlayerEffect(ownerPid,10))
				.seq(sacrificeSelf())
		
		local ef15_random_barbarian = sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("barbarian_headbutt")))
				.seq(randomEffect({
                        valueItem(1, createCardEffect(barbarian_disorienting_headbutt_carddef(), loc(ownerPid, asidePloc))),
						valueItem(1, createCardEffect(barbarian_shattering_headbutt_carddef(), loc(ownerPid, asidePloc))),
						}))
				.seq(sacrificeSelf())
		
		local ef16_random_barbarian = gainMaxHealthEffect(ownerPid, const(10))
				.seq(healPlayerEffect(ownerPid,10))
				.seq(sacrificeSelf())
		
		local ef17_random_barbarian = randomEffect({
                        valueItem(1, createCardEffect(barbarian_caltrops_carddef(), loc(ownerPid, reservePloc))),
						valueItem(1, createCardEffect(barbarian_seething_spear_carddef(), loc(ownerPid, reservePloc))),
						})
				.seq(sacrificeSelf())

		local ef18_random_barbarian = gainMaxHealthEffect(ownerPid, const(10))
				.seq(healPlayerEffect(ownerPid,10))
				.seq(sacrificeSelf())

local ef_base_barbarian = 
setPlayerAvatarEffect("barbarian_02", ownerPid)
			.seq(gainMaxHealthEffect(ownerPid, const(62)))
				.seq(healPlayerEffect(ownerPid,62))
			.seq(createCardEffect(barbarian_inner_rage_carddef(), loc(ownerPid, skillsPloc)))
			.seq(createCardEffect(barbarian_roar_carddef(), loc(ownerPid, skillsPloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(ruby_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(barbarian_hand_axe_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(barbarian_hand_axe_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(barbarian_plunder_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(barbarian_headbutt_carddef(), loc(ownerPid, asidePloc)))
		--add in extras
		--levels	
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(4), ef4_random_barbarian, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(5), ef5_random_barbarian, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(6), ef6_random_barbarian, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(7), ef7_random_barbarian, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(8), ef8_random_barbarian, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(9), ef9_random_barbarian, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(10), ef10_random_barbarian, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(11), ef11_random_barbarian, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(12), ef12_random_barbarian, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(13), ef13_random_barbarian, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(14), ef14_random_barbarian, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(15), ef15_random_barbarian, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(16), ef16_random_barbarian, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(17), ef17_random_barbarian, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(18), ef18_random_barbarian, nullEffect()))
			

		local ef4_random_bard = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("bard_moving_melody")))
				.seq(randomEffect({
                        valueItem(1, createCardEffect(bard_inspiring_tune_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(bard_rousing_ode_carddef(), loc(ownerPid, skillsPloc))),
						}))
				.seq(sacrificeSelf())

		local ef5_random_bard = randomEffect({
                        valueItem(1, sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("dagger")).take(1)).seq(createCardEffect(bard_dancing_blade_carddef(), loc(ownerPid, asidePloc)))),
						valueItem(1, sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("gold")).take(1)).seq(createCardEffect(bard_necros_dirge_carddef(), loc(ownerPid, asidePloc)))),
						})
				.seq(sacrificeSelf())

		local ef6_random_bard = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("bard_inspiring_tune").Or(isCardName("bard_rousing_ode"))))
				.seq(randomEffect({
                        valueItem(1, createCardEffect(bard_battle_march_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(bard_rally_hymn_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(bard_stirring_song_carddef(), loc(ownerPid, skillsPloc))),
						}))
				.seq(sacrificeSelf())

		local ef7_random_bard = randomEffect({
                        valueItem(1, createCardEffect(bard_summoning_drum_carddef(), loc(ownerPid, asidePloc))),
						valueItem(1, createCardEffect(bard_silencing_scepter_carddef(), loc(ownerPid, asidePloc))),
						})
				.seq(sacrificeSelf())

		local ef8_random_bard = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("bard_valiant_verse")))
				.seq(randomEffect({
                        valueItem(1, createCardEffect(bard_intrepid_tale_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(bard_heroic_fable_carddef(), loc(ownerPid, skillsPloc))),
						}))
				.seq(sacrificeSelf())

		local ef9_random_bard = randomEffect({
                        valueItem(1, createCardEffect(bard_coat_of_encores_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(bard_collecting_cap_carddef(), loc(ownerPid, skillsPloc))),
						})
				.seq(sacrificeSelf())
		
		local ef10_random_bard = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("bard_intrepid_tale").Or(isCardName("bard_heroic_fable"))))
				.seq(randomEffect({
                        valueItem(1, createCardEffect(bard_grand_legend_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(bard_bold_saga_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(bard_mythic_chronicle_carddef(), loc(ownerPid, skillsPloc))),
						}))
				.seq(sacrificeSelf())

		local ef11_random_bard = randomEffect({
                        valueItem(1, sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("gold")).take(1)).seq(createCardEffect(bard_goblet_of_whimsy_carddef(), loc(ownerPid, asidePloc)))),
						valueItem(1, createCardEffect(bard_lute_carddef(), loc(ownerPid, asidePloc))),
						})
				.seq(sacrificeSelf())

		local ef12_random_bard = gainMaxHealthEffect(ownerPid, const(6))
				.seq(healPlayerEffect(ownerPid,6))
				.seq(sacrificeSelf())

		local ef13_random_bard = randomEffect({
                        valueItem(1, createCardEffect(bard_songbook_carddef(), loc(ownerPid, reservePloc))),
						valueItem(1, createCardEffect(bard_musical_darts_carddef(), loc(ownerPid, reservePloc))),
						})
				.seq(sacrificeSelf())
		
		local ef14_random_bard = gainMaxHealthEffect(ownerPid, const(6))
				.seq(healPlayerEffect(ownerPid,6))
				.seq(sacrificeSelf())
		
		local ef15_random_bard = sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("bard_harp")))
				.seq(randomEffect({
                        valueItem(1, createCardEffect(bard_lullaby_harp_carddef(), loc(ownerPid, asidePloc))),
						valueItem(1, createCardEffect(bard_golden_harp_carddef(), loc(ownerPid, asidePloc))),
						}))
				.seq(sacrificeSelf())
		
		local ef16_random_bard = gainMaxHealthEffect(ownerPid, const(6))
				.seq(healPlayerEffect(ownerPid,6))
				.seq(sacrificeSelf())
		
		local ef17_random_bard = randomEffect({
                        valueItem(1, createCardEffect(bard_muse_s_paper_carddef(), loc(ownerPid, reservePloc))),
						valueItem(1, createCardEffect(bard_music_box_carddef(), loc(ownerPid, reservePloc))),
						})
				.seq(sacrificeSelf())

		local ef18_random_bard = gainMaxHealthEffect(ownerPid, const(6))
				.seq(healPlayerEffect(ownerPid,6))
				.seq(sacrificeSelf())

local ef_base_bard = 
setPlayerAvatarEffect("bard_02", ownerPid)
			.seq(gainMaxHealthEffect(ownerPid, const(51)))
				.seq(healPlayerEffect(ownerPid,51))
			.seq(createCardEffect(bard_moving_melody_carddef(), loc(ownerPid, skillsPloc)))
			.seq(createCardEffect(bard_valiant_verse_carddef(), loc(ownerPid, skillsPloc)))
			.seq(createCardEffect(dagger_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(ruby_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(bard_flute_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(bard_harp_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(bard_herald_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(bard_imperial_anthem_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(bard_guild_tale_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(bard_song_of_the_wild_carddef(), loc(ownerPid, asidePloc)))
		--add in extras
		--levels	
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(4), ef4_random_bard, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(5), ef5_random_bard, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(6), ef6_random_bard, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(7), ef7_random_bard, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(8), ef8_random_bard, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(9), ef9_random_bard, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(10), ef10_random_bard, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(11), ef11_random_bard, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(12), ef12_random_bard, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(13), ef13_random_bard, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(14), ef14_random_bard, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(15), ef15_random_bard, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(16), ef16_random_bard, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(17), ef17_random_bard, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(18), ef18_random_bard, nullEffect()))
			
		local ef4_random_druid = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("druid_forest_rage")))
				.seq(randomEffect({
                        valueItem(1, createCardEffect(druid_forest_fury_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(druid_spirit_of_the_forest_carddef(), loc(ownerPid, skillsPloc))),
						}))
				.seq(sacrificeSelf())

		local ef5_random_druid = randomEffect({
                        valueItem(1, sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("druid_gnarled_staff")).take(1)).seq(createCardEffect(druid_flourishing_staff_carddef(), loc(ownerPid, asidePloc)))),
						valueItem(1, sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("gold")).take(1)).seq(createCardEffect(druid_honeycomb_carddef(), loc(ownerPid, asidePloc)))),
						})
				.seq(sacrificeSelf())

		local ef6_random_druid = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("druid_forest_fury").Or(isCardName("druid_spirit_of_the_forest"))))
				.seq(randomEffect({
                        valueItem(1, createCardEffect(druid_forest_vengeance_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(druid_way_of_the_forest_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(druid_soul_of_the_forest_carddef(), loc(ownerPid, skillsPloc))),
						}))
				.seq(sacrificeSelf())

		local ef7_random_druid = randomEffect({
                        valueItem(1, createCardEffect(druid_owl_carddef(), loc(ownerPid, asidePloc))),
						valueItem(1, createCardEffect(druid_heartwood_splinter_carddef(), loc(ownerPid, asidePloc))),
						})
				.seq(sacrificeSelf())

		local ef8_random_druid = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("druid_bear_form")))
				.seq(randomEffect({
                        valueItem(1, createCardEffect(druid_grizzly_form_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(druid_spirit_bear_form_carddef(), loc(ownerPid, skillsPloc))),
						}))
				.seq(sacrificeSelf())

		local ef9_random_druid = randomEffect({
                        valueItem(1, createCardEffect(druid_circlet_of_flowers_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(druid_grass_weave_sash_carddef(), loc(ownerPid, skillsPloc))),
						})
				.seq(sacrificeSelf())
		
		local ef10_random_druid = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("druid_grizzly_form").Or(isCardName("druid_spirit_bear_form"))))
				.seq(randomEffect({
                        valueItem(1, createCardEffect(druid_polar_bear_form_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(druid_spirit_grizzly_form_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(druid_pure_bear_form_carddef(), loc(ownerPid, skillsPloc))),
						}))
				.seq(sacrificeSelf())

		local ef11_random_druid = randomEffect({
                        valueItem(1, createCardEffect(druid_rabbit_carddef(), loc(ownerPid, asidePloc)).seq(createCardEffect(druid_rabbit_carddef(), loc(ownerPid, asidePloc)))),
						valueItem(1, createCardEffect(druid_ursine_rod_carddef(), loc(ownerPid, asidePloc))),
						})
				.seq(sacrificeSelf())

		local ef12_random_druid = gainMaxHealthEffect(ownerPid, const(7))
				.seq(healPlayerEffect(ownerPid,7))
				.seq(sacrificeSelf())

		local ef13_random_druid = randomEffect({
                        valueItem(1, createCardEffect(druid_panther_eye_ring_carddef(), loc(ownerPid, reservePloc))),
						valueItem(1, createCardEffect(druid_entangling_roots_carddef(), loc(ownerPid, reservePloc))),
						})
				.seq(sacrificeSelf())
		
		local ef14_random_druid = gainMaxHealthEffect(ownerPid, const(7))
				.seq(healPlayerEffect(ownerPid,7))
				.seq(sacrificeSelf())
		
		local ef15_random_druid = sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("druid_fox")))
				.seq(randomEffect({
                        valueItem(1, createCardEffect(druid_nimble_fox_carddef(), loc(ownerPid, asidePloc))),
						valueItem(1, createCardEffect(druid_feral_fox_carddef(), loc(ownerPid, asidePloc))),
						}))
				.seq(sacrificeSelf())
		
		local ef16_random_druid = gainMaxHealthEffect(ownerPid, const(7))
				.seq(healPlayerEffect(ownerPid,7))
				.seq(sacrificeSelf())
		
		local ef17_random_druid = randomEffect({
                        valueItem(1, createCardEffect(druid_wisdom_of_the_woods_carddef(), loc(ownerPid, reservePloc))),
						valueItem(1, createCardEffect(druid_sunbird_carddef(), loc(ownerPid, reservePloc))),
						})
				.seq(sacrificeSelf())

		local ef18_random_druid = gainMaxHealthEffect(ownerPid, const(7))
				.seq(healPlayerEffect(ownerPid,7))
				.seq(sacrificeSelf())

local ef_base_druid = 
setPlayerAvatarEffect("druid_02", ownerPid)
			.seq(gainMaxHealthEffect(ownerPid, const(54)))
				.seq(healPlayerEffect(ownerPid,54))
			.seq(createCardEffect(druid_forest_rage_carddef(), loc(ownerPid, skillsPloc)))
			.seq(createCardEffect(druid_bear_form_carddef(), loc(ownerPid, skillsPloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(ruby_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(druid_fox_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(druid_hedgehog_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(druid_squirrel_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(druid_gnarled_staff_carddef(), loc(ownerPid, asidePloc)))
		--add in extras
		--levels	
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(4), ef4_random_druid, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(5), ef5_random_druid, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(6), ef6_random_druid, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(7), ef7_random_druid, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(8), ef8_random_druid, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(9), ef9_random_druid, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(10), ef10_random_druid, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(11), ef11_random_druid, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(12), ef12_random_druid, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(13), ef13_random_druid, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(14), ef14_random_druid, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(15), ef15_random_druid, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(16), ef16_random_druid, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(17), ef17_random_druid, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(18), ef18_random_druid, nullEffect()))
			
		local ef4_random_monk = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("monk_favored_technique")))
				.seq(randomEffect({
                        valueItem(1, createCardEffect(monk_flowing_technique_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(monk_practiced_technique_carddef(), loc(ownerPid, skillsPloc))),
						}))
				.seq(sacrificeSelf())

		local ef5_random_monk = randomEffect({
                        valueItem(1, sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("ruby")).take(1)).seq(createCardEffect(monk_staff_of_meditation_carddef(), loc(ownerPid, asidePloc)))),
						valueItem(1, sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("monk_striking_cobra")).take(1)).seq(createCardEffect(monk_cobra_fang_carddef(), loc(ownerPid, asidePloc)))),
						})
				.seq(sacrificeSelf())

		local ef6_random_monk = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("monk_flowing_technique").Or(isCardName("monk_practiced_technique"))))
				.seq(randomEffect({
                        valueItem(1, createCardEffect(monk_fluid_technique_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(monk_precise_technique_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(monk_masterful_technique_carddef(), loc(ownerPid, skillsPloc))),
						}))
				.seq(sacrificeSelf())

		local ef7_random_monk = randomEffect({
                        valueItem(1, createCardEffect(monk_ring_of_1000_palms_carddef(), loc(ownerPid, asidePloc))),
						valueItem(1, createCardEffect(monk_stillness_of_water_carddef(), loc(ownerPid, asidePloc))),
						})
				.seq(sacrificeSelf())

		local ef8_random_monk = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("monk_qi")))
				.seq(randomEffect({
                        valueItem(1, createCardEffect(monk_jing_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(monk_focused_strike_carddef(), loc(ownerPid, skillsPloc))),
						}))
				.seq(sacrificeSelf())

		local ef9_random_monk = randomEffect({
                        valueItem(1, createCardEffect(monk_slippers_of_the_crane_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(monk_wraps_of_strength_carddef(), loc(ownerPid, skillsPloc))),
						})
				.seq(sacrificeSelf())
		
		local ef10_random_monk = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("monk_jing").Or(isCardName("monk_focused_strike"))))
				.seq(randomEffect({
                        valueItem(1, createCardEffect(monk_qigong_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(monk_yin_yang_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(monk_dim_mak_carddef(), loc(ownerPid, skillsPloc))),
						}))
				.seq(sacrificeSelf())

		local ef11_random_monk = randomEffect({
                        valueItem(1, createCardEffect(monk_tonfas_of_balance_carddef(), loc(ownerPid, asidePloc))),
						valueItem(1, sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("monk_spring_blossom")).take(1)).seq(createCardEffect(monk_resplendent_blossom_carddef(), loc(ownerPid, asidePloc)))),
						})
				.seq(sacrificeSelf())

		local ef12_random_monk = gainMaxHealthEffect(ownerPid, const(9))
				.seq(healPlayerEffect(ownerPid,9))
				.seq(sacrificeSelf())

		local ef13_random_monk = randomEffect({
                        valueItem(1, createCardEffect(monk_horn_of_ascendance_carddef(), loc(ownerPid, reservePloc))),
						valueItem(1, createCardEffect(monk_amulet_of_resolve_carddef(), loc(ownerPid, reservePloc))),
						})
				.seq(sacrificeSelf())
		
		local ef14_random_monk = gainMaxHealthEffect(ownerPid, const(9))
				.seq(healPlayerEffect(ownerPid,9))
				.seq(sacrificeSelf())
		
		local ef15_random_monk = sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("monk_spring_blossom")))
				.seq(randomEffect({
                        valueItem(1, createCardEffect(monk_resplendent_blossom_carddef(), loc(ownerPid, asidePloc))),
						valueItem(1, createCardEffect(monk_magnificent_blossom_carddef(), loc(ownerPid, asidePloc))),
						}))
				.seq(sacrificeSelf())
		
		local ef16_random_monk = gainMaxHealthEffect(ownerPid, const(9))
				.seq(healPlayerEffect(ownerPid,9))
				.seq(sacrificeSelf())
		
		local ef17_random_monk = randomEffect({
                        valueItem(1, createCardEffect(monk_dragon_staff_carddef(), loc(ownerPid, reservePloc))),
						valueItem(1, createCardEffect(monk_tranquil_wind_carddef(), loc(ownerPid, reservePloc))),
						})
				.seq(sacrificeSelf())

		local ef18_random_monk = gainMaxHealthEffect(ownerPid, const(9))
				.seq(healPlayerEffect(ownerPid,9))
				.seq(sacrificeSelf())

local ef_base_monk = 
setPlayerAvatarEffect("monk_02", ownerPid)
			.seq(gainMaxHealthEffect(ownerPid, const(59)))
				.seq(healPlayerEffect(ownerPid,59))
			.seq(createCardEffect(monk_favored_technique_carddef(), loc(ownerPid, skillsPloc)))
			.seq(createCardEffect(monk_qi_carddef(), loc(ownerPid, skillsPloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(ruby_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(monk_spring_blossom_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(monk_spring_blossom_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(monk_spring_blossom_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(monk_spring_blossom_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(monk_spring_blossom_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(monk_striking_cobra_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(monk_serene_wind_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(dualmonktaoresetbuff, loc(ownerPid, buffsPloc)))
		--add in extras
		--levels	
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(4), ef4_random_monk, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(5), ef5_random_monk, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(6), ef6_random_monk, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(7), ef7_random_monk, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(8), ef8_random_monk, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(9), ef9_random_monk, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(10), ef10_random_monk, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(11), ef11_random_monk, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(12), ef12_random_monk, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(13), ef13_random_monk, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(14), ef14_random_monk, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(15), ef15_random_monk, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(16), ef16_random_monk, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(17), ef17_random_monk, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(18), ef18_random_monk, nullEffect()))
			
	
	local ef4_random_necromancer = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("necromancer_bone_raising")))
				.seq(randomEffect({
                        valueItem(1, createCardEffect(necromancer_fresh_harvest_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(necromancer_raise_skeleton_carddef(), loc(ownerPid, skillsPloc))),
						}))
				.seq(sacrificeSelf())

		local ef5_random_necromancer = randomEffect({
                        valueItem(1, sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("gold")).take(1)).seq(createCardEffect(necromancer_bone_dance_carddef(), loc(ownerPid, asidePloc)))),
						valueItem(1, sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("gold")).take(1)).seq(createCardEffect(necromancer_bloodrose_carddef(), loc(ownerPid, asidePloc)))),
						})
				.seq(sacrificeSelf())

		local ef6_random_necromancer = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("necromancer_fresh_harvest").Or(isCardName("necromancer_raise_skeleton"))))
				.seq(randomEffect({
                        valueItem(1, createCardEffect(necromancer_skull_swarm_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(necromancer_corpse_horde_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(necromancer_strong_bones_carddef(), loc(ownerPid, skillsPloc))),
						}))
				.seq(sacrificeSelf())

		local ef7_random_necromancer = randomEffect({
                        valueItem(1, createCardEffect(necromancer_anguish_blade_carddef(), loc(ownerPid, asidePloc))),
						valueItem(1, createCardEffect(necromancer_puzzle_box_carddef(), loc(ownerPid, asidePloc))),
						})
				.seq(sacrificeSelf())

		local ef8_random_necromancer = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("necromancer_raise_dead")))
				.seq(randomEffect({
                        valueItem(1, createCardEffect(necromancer_animate_dead_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(necromancer_corpse_raising_carddef(), loc(ownerPid, skillsPloc))),
						}))
				.seq(sacrificeSelf())

		local ef9_random_necromancer = randomEffect({
                        valueItem(1, createCardEffect(necromancer_rotting_crown_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(necromancer_plague_belt_carddef(), loc(ownerPid, skillsPloc))),
						})
				.seq(sacrificeSelf())
		
		local ef10_random_necromancer = sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("necromancer_animate_dead").Or(isCardName("necromancer_corpse_raising"))))
				.seq(randomEffect({
                        valueItem(1, createCardEffect(necromancer_empty_graves_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(necromancer_grave_robbery_carddef(), loc(ownerPid, skillsPloc))),
						valueItem(1, createCardEffect(necromancer_reawaken_carddef(), loc(ownerPid, skillsPloc))),
						}))
				.seq(sacrificeSelf())

		local ef11_random_necromancer = randomEffect({
                        valueItem(1, createCardEffect(necromancer_voidstone_carddef(), loc(ownerPid, asidePloc))),
						valueItem(1, createCardEffect(necromancer_onyx_skull_carddef(), loc(ownerPid, asidePloc))),
						})
				.seq(sacrificeSelf())

		local ef12_random_necromancer = gainMaxHealthEffect(ownerPid, const(5))
				.seq(healPlayerEffect(ownerPid,5))
				.seq(sacrificeSelf())

		local ef13_random_necromancer = randomEffect({
                        valueItem(1, createCardEffect(necromancer_stitcher_s_kit_carddef(), loc(ownerPid, reservePloc))),
						valueItem(1, createCardEffect(necromancer_severing_scythe_carddef(), loc(ownerPid, reservePloc))),
						})
				.seq(sacrificeSelf())
		
		local ef14_random_necromancer = gainMaxHealthEffect(ownerPid, const(5))
				.seq(healPlayerEffect(ownerPid,5))
				.seq(sacrificeSelf())
		
		local ef15_random_necromancer = sacrificeTarget().apply(selectLoc(loc(ownerPid, asidePloc)).where(isCardName("necromancer_rod_of_unlife")))
				.seq(randomEffect({
                        valueItem(1, createCardEffect(necromancer_rod_of_spite_carddef(), loc(ownerPid, asidePloc))),
						valueItem(1, createCardEffect(necromancer_rod_of_reanimation_carddef(), loc(ownerPid, asidePloc))),
						}))
				.seq(sacrificeSelf())
		
		local ef16_random_necromancer = gainMaxHealthEffect(ownerPid, const(5))
				.seq(healPlayerEffect(ownerPid,5))
				.seq(sacrificeSelf())
		
		local ef17_random_necromancer = randomEffect({
                        valueItem(1, createCardEffect(necromancer_preserved_heart_carddef(), loc(ownerPid, reservePloc))),
						valueItem(1, createCardEffect(necromancer_dread_cauldron_carddef(), loc(ownerPid, reservePloc))),
						})
				.seq(sacrificeSelf())

		local ef18_random_necromancer = gainMaxHealthEffect(ownerPid, const(5))
				.seq(healPlayerEffect(ownerPid,5))
				.seq(sacrificeSelf())

local ef_base_necromancer = 
setPlayerAvatarEffect("necromancer_02", ownerPid)
			.seq(gainMaxHealthEffect(ownerPid, const(49)))
				.seq(healPlayerEffect(ownerPid,49))
			.seq(createCardEffect(necromancer_bone_raising_carddef(), loc(ownerPid, skillsPloc)))
			.seq(createCardEffect(necromancer_raise_dead_carddef(), loc(ownerPid, skillsPloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(ruby_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(dagger_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(necromancer_rod_of_unlife_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(necromancer_soul_prism_carddef(), loc(ownerPid, asidePloc)))
			.seq(createCardEffect(necromancer_collection_of_corpses_carddef(), loc(ownerPid, asidePloc)))
		--levels	
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(4), ef4_random_necromancer, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(5), ef5_random_necromancer, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(6), ef6_random_necromancer, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(7), ef7_random_necromancer, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(8), ef8_random_necromancer, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(9), ef9_random_necromancer, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(10), ef10_random_necromancer, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(11), ef11_random_necromancer, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(12), ef12_random_necromancer, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(13), ef13_random_necromancer, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(14), ef14_random_necromancer, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(15), ef15_random_necromancer, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(16), ef16_random_necromancer, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(17), ef17_random_necromancer, nullEffect()))
			.seq(ifElseEffect(getHeroLevel(currentPid).gte(18), ef18_random_necromancer, nullEffect()))
			
local ef_rando_calrissian = setPlayerNameEffect("Rando Calrissian", ownerPid).seq(ef_rando1_start)
			.seq(createCardEffect(rando1_winlose_buff_def(), loc(ownerPid, buffsPloc)))

local ef_john_rando = setPlayerNameEffect("John Rando", ownerPid).seq(ef_rando2_start)
			.seq(createCardEffect(rando2_winlose_buff_def(), loc(ownerPid, buffsPloc)))
			
local ef_rando = randomEffect({
                        valueItem(1, ef_base_ranger),
						valueItem(1, ef_base_fighter),
						valueItem(1, ef_base_cleric),
						valueItem(1, ef_base_wizard),
						valueItem(1, ef_base_thief),
						valueItem(1, ef_base_alchemist),
						valueItem(1, ef_base_bard),
						valueItem(1, ef_base_barbarian),
						valueItem(1, ef_base_druid),
						valueItem(1, ef_base_monk),
						valueItem(1, ef_base_necromancer),
						
						})
			.seq(ef_rando_ancestry)
			.seq(moveTarget(loc(ownerPid, deckPloc)).apply(selectLoc(loc(ownerPid, asidePloc))))
			.seq(shuffleEffect(loc(ownerPid, deckPloc)))
			.seq(ifElseEffect(getTurnsPlayed(nextAllyPid).eq(1), ef_john_rando, ef_rando_calrissian))
	
	
local ef_no_cleric = randomEffect({
					valueItem(1, ef_ranger),
					valueItem(1, ef_illegalas),
					valueItem(1, ef_wizard),
					valueItem(1, ef_jigmelingpa),
					valueItem(1, ef_scrapforce),
					valueItem(0, ef_cleric),
					valueItem(1, ef_wardenslayer),
					valueItem(1, ef_zembu),
					valueItem(1, ef_lgnkstwrt),
					valueItem(1, ef_nudeltulpe),
					valueItem(1, ef_Boudicarnage),
					valueItem(1, ef_Doc_Orc),
					valueItem(1, ef_Wombatman),
					valueItem(1, ef_BTW),
					valueItem(1, ef_thelonious),
					valueItem(1, ef_Elfred_Nobel),
					valueItem(5, ef_rando),
					})

local ef_no_ranger = randomEffect({
					valueItem(0, ef_ranger),
					valueItem(0, ef_illegalas),
					valueItem(1, ef_wizard),
					valueItem(1, ef_jigmelingpa),
					valueItem(1, ef_scrapforce),
					valueItem(1, ef_cleric),
					valueItem(1, ef_wardenslayer),
					valueItem(1, ef_zembu),
					valueItem(1, ef_lgnkstwrt),
					valueItem(1, ef_nudeltulpe),
					valueItem(1, ef_Boudicarnage),
					valueItem(1, ef_Doc_Orc),
					valueItem(1, ef_Wombatman),
					valueItem(1, ef_BTW),
					valueItem(1, ef_thelonious),
					valueItem(1, ef_Elfred_Nobel),
					valueItem(5, ef_rando),
					})

local ef_no_wizard = randomEffect({
					valueItem(1, ef_ranger),
					valueItem(1, ef_illegalas),
					valueItem(0, ef_wizard),
					valueItem(0, ef_jigmelingpa),
					valueItem(0, ef_scrapforce),
					valueItem(1, ef_cleric),
					valueItem(1, ef_wardenslayer),
					valueItem(1, ef_zembu),
					valueItem(1, ef_lgnkstwrt),
					valueItem(1, ef_nudeltulpe),
					valueItem(1, ef_Boudicarnage),
					valueItem(1, ef_Doc_Orc),
					valueItem(1, ef_Wombatman),
					valueItem(1, ef_BTW),
					valueItem(1, ef_thelonious),
					valueItem(1, ef_Elfred_Nobel),
					valueItem(5, ef_rando),
					})

local ef_no_fighter = randomEffect({
					valueItem(1, ef_ranger),
					valueItem(1, ef_illegalas),
					valueItem(1, ef_wizard),
					valueItem(1, ef_jigmelingpa),
					valueItem(1, ef_scrapforce),
					valueItem(1, ef_cleric),
					valueItem(0, ef_wardenslayer),
					valueItem(1, ef_zembu),
					valueItem(1, ef_lgnkstwrt),
					valueItem(1, ef_nudeltulpe),
					valueItem(1, ef_Boudicarnage),
					valueItem(1, ef_Doc_Orc),
					valueItem(1, ef_Wombatman),
					valueItem(1, ef_BTW),
					valueItem(1, ef_thelonious),
					valueItem(1, ef_Elfred_Nobel),
					valueItem(5, ef_rando),
					})

local ef_no_thief = randomEffect({
					valueItem(1, ef_ranger),
					valueItem(1, ef_illegalas),
					valueItem(1, ef_wizard),
					valueItem(1, ef_jigmelingpa),
					valueItem(1, ef_scrapforce),
					valueItem(1, ef_cleric),
					valueItem(1, ef_wardenslayer),
					valueItem(0, ef_zembu),
					valueItem(1, ef_lgnkstwrt),
					valueItem(1, ef_nudeltulpe),
					valueItem(1, ef_Boudicarnage),
					valueItem(1, ef_Doc_Orc),
					valueItem(1, ef_Wombatman),
					valueItem(1, ef_BTW),
					valueItem(1, ef_thelonious),
					valueItem(1, ef_Elfred_Nobel),
					valueItem(5, ef_rando),
					})

local ef_no_bard = randomEffect({
					valueItem(1, ef_ranger),
					valueItem(1, ef_illegalas),
					valueItem(1, ef_wizard),
					valueItem(1, ef_jigmelingpa),
					valueItem(1, ef_scrapforce),
					valueItem(1, ef_cleric),
					valueItem(1, ef_wardenslayer),
					valueItem(1, ef_zembu),
					valueItem(0, ef_lgnkstwrt),
					valueItem(1, ef_nudeltulpe),
					valueItem(1, ef_Boudicarnage),
					valueItem(1, ef_Doc_Orc),
					valueItem(1, ef_Wombatman),
					valueItem(1, ef_BTW),
					valueItem(1, ef_thelonious),
					valueItem(1, ef_Elfred_Nobel),
					valueItem(5, ef_rando),
					})
					
local ef_no_druid = randomEffect({
					valueItem(1, ef_ranger),
					valueItem(1, ef_illegalas),
					valueItem(1, ef_wizard),
					valueItem(1, ef_jigmelingpa),
					valueItem(1, ef_scrapforce),
					valueItem(1, ef_cleric),
					valueItem(1, ef_wardenslayer),
					valueItem(1, ef_zembu),
					valueItem(1, ef_lgnkstwrt),
					valueItem(0, ef_nudeltulpe),
					valueItem(1, ef_Boudicarnage),
					valueItem(1, ef_Doc_Orc),
					valueItem(0, ef_Wombatman),
					valueItem(0, ef_BTW),
					valueItem(1, ef_thelonious),
					valueItem(1, ef_Elfred_Nobel),
					valueItem(5, ef_rando),
					})

local ef_no_barbarian = randomEffect({
					valueItem(1, ef_ranger),
					valueItem(1, ef_illegalas),
					valueItem(1, ef_wizard),
					valueItem(1, ef_jigmelingpa),
					valueItem(1, ef_scrapforce),
					valueItem(1, ef_cleric),
					valueItem(1, ef_wardenslayer),
					valueItem(1, ef_zembu),
					valueItem(1, ef_lgnkstwrt),
					valueItem(1, ef_nudeltulpe),
					valueItem(0, ef_Boudicarnage),
					valueItem(1, ef_Doc_Orc),
					valueItem(1, ef_Wombatman),
					valueItem(1, ef_BTW),
					valueItem(1, ef_thelonious),
					valueItem(1, ef_Elfred_Nobel),
					valueItem(5, ef_rando),
					})

local ef_no_monk = randomEffect({
					valueItem(1, ef_ranger),
					valueItem(1, ef_illegalas),
					valueItem(1, ef_wizard),
					valueItem(1, ef_jigmelingpa),
					valueItem(1, ef_scrapforce),
					valueItem(1, ef_cleric),
					valueItem(1, ef_wardenslayer),
					valueItem(1, ef_zembu),
					valueItem(1, ef_lgnkstwrt),
					valueItem(1, ef_nudeltulpe),
					valueItem(1, ef_Boudicarnage),
					valueItem(1, ef_Doc_Orc),
					valueItem(1, ef_Wombatman),
					valueItem(1, ef_BTW),
					valueItem(0, ef_thelonious),
					valueItem(1, ef_Elfred_Nobel),
					valueItem(5, ef_rando),
					})
					
local ef_no_alchemist = randomEffect({
					valueItem(1, ef_ranger),
					valueItem(1, ef_illegalas),
					valueItem(1, ef_wizard),
					valueItem(1, ef_jigmelingpa),
					valueItem(1, ef_scrapforce),
					valueItem(1, ef_cleric),
					valueItem(1, ef_wardenslayer),
					valueItem(1, ef_zembu),
					valueItem(1, ef_lgnkstwrt),
					valueItem(1, ef_nudeltulpe),
					valueItem(1, ef_Boudicarnage),
					valueItem(0, ef_Doc_Orc),
					valueItem(1, ef_Wombatman),
					valueItem(1, ef_BTW),
					valueItem(1, ef_thelonious),
					valueItem(0, ef_Elfred_Nobel),
					valueItem(5, ef_rando),
					})
local ef_no_necromancer = randomEffect({
					valueItem(1, ef_ranger),
					valueItem(1, ef_illegalas),
					valueItem(1, ef_wizard),
					valueItem(1, ef_jigmelingpa),
					valueItem(1, ef_scrapforce),
					valueItem(1, ef_cleric),
					valueItem(1, ef_wardenslayer),
					valueItem(1, ef_zembu),
					valueItem(1, ef_lgnkstwrt),
					valueItem(1, ef_nudeltulpe),
					valueItem(1, ef_Boudicarnage),
					valueItem(1, ef_Doc_Orc),
					valueItem(1, ef_Wombatman),
					valueItem(1, ef_BTW),
					valueItem(1, ef_thelonious),
					valueItem(1, ef_Elfred_Nobel),
					valueItem(5, ef_rando),
					})
					
local ef_draw3 = moveTarget(loc(ownerPid, handPloc)).apply(selectLoc(loc(ownerPid, deckPloc)).take(3))
local ef_draw5 = moveTarget(loc(ownerPid, handPloc)).apply(selectLoc(loc(ownerPid, deckPloc)).take(5))
					
local function AI_1_hero_select_BuffDef()
    local buff_name = "ai_1_hero_select_buff"

return createGlobalBuff({
        id="ai_selector",
        name = "AI Selector",
        abilities = {
            createAbility({
                id="ai_selector",
                trigger = startOfGameTrigger,
				aiPriority = toIntExpression(200),
                effect = randomEffect({
					valueItem(1, ef_cleric),
					valueItem(1, ef_ranger),
					valueItem(1, ef_illegalas),
					valueItem(1, ef_wizard),
					valueItem(1, ef_wardenslayer),
					valueItem(1, ef_zembu),
					valueItem(1, ef_lgnkstwrt),
					valueItem(1, ef_nudeltulpe),
					valueItem(1, ef_jigmelingpa),
					valueItem(1, ef_scrapforce),
					valueItem(1, ef_Boudicarnage),
					valueItem(1, ef_Doc_Orc),
					valueItem(1, ef_Wombatman),
					valueItem(1, ef_BTW),
					valueItem(1, ef_thelonious),
					valueItem(1, ef_Elfred_Nobel),
					valueItem(8, ef_rando),
					
					})
					.seq(ifElseEffect(selectLoc(loc(currentPid, buffsPloc)).where(isCardType(elfType)).count().gte(1),
                                ef_draw3,
                                ef_draw5))
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

local function AI_2_hero_select_BuffDef()
    local buff_name = "ai_1_hero_select_buff"


return createGlobalBuff({
        id="ai_2_selector",
        name = "AI Selector",
        abilities = {
            createAbility({
                id="ai_selector",
                trigger = startOfGameTrigger,
				aiPriority = toIntExpression(300),
                effect = 
				
				ifElseEffect(selectLoc(loc(nextAllyPid, deckPloc)).where(isCardType(clericType)).count().gte(1), ef_no_cleric ,nullEffect())
				.seq(ifElseEffect(selectLoc(loc(nextAllyPid, deckPloc)).where(isCardType(rangerType)).count().gte(1), ef_no_ranger ,nullEffect()))
				.seq(ifElseEffect(selectLoc(loc(nextAllyPid, deckPloc)).where(isCardType(wizardType)).count().gte(1), ef_no_wizard ,nullEffect()))
				.seq(ifElseEffect(selectLoc(loc(nextAllyPid, deckPloc)).where(isCardType(thiefType)).count().gte(1), ef_no_thief ,nullEffect()))
				.seq(ifElseEffect(selectLoc(loc(nextAllyPid, deckPloc)).where(isCardType(fighterType)).count().gte(1), ef_no_fighter ,nullEffect()))
				.seq(ifElseEffect(selectLoc(loc(nextAllyPid, deckPloc)).where(isCardType(bardType)).count().gte(1), ef_no_bard ,nullEffect()))
				.seq(ifElseEffect(selectLoc(loc(nextAllyPid, deckPloc)).where(isCardType(druidType)).count().gte(1), ef_no_druid ,nullEffect()))
				.seq(ifElseEffect(selectLoc(loc(nextAllyPid, deckPloc)).where(isCardType(alchemistType)).count().gte(1), ef_no_cleric ,nullEffect()))
				.seq(ifElseEffect(selectLoc(loc(nextAllyPid, deckPloc)).where(isCardType(monkType)).count().gte(1), ef_no_monk ,nullEffect()))
				.seq(ifElseEffect(selectLoc(loc(nextAllyPid, deckPloc)).where(isCardType(necromancerType)).count().gte(1), ef_no_necromancer ,nullEffect()))
				.seq(ifElseEffect(selectLoc(loc(nextAllyPid, deckPloc)).where(isCardType(barbarianType)).count().gte(1), ef_no_barbarian ,nullEffect()))
				
					.seq(ifElseEffect(selectLoc(loc(currentPid, buffsPloc)).where(isCardType(elfType)).count().gte(1),
                                ef_draw3,
                                ef_draw5))
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

local function share_card_2v2_skilldef()


	local ef_speech1 = showSpeechBubbleEffect({
								playerExpression=ownerPid,
								text="Take this.",
								waitForClick= constBoolExpression(false)
							})

	local ef_speech2 = showSpeechBubbleEffect({
								playerExpression=ownerPid,
								text="Here, this may help.",
								waitForClick= constBoolExpression(false)
							})

	local ef_speech3 = showSpeechBubbleEffect({
								playerExpression=ownerPid,
								text="This is for you.",
								waitForClick= constBoolExpression(false)
							})

	local ef_speech4 = showSpeechBubbleEffect({
								playerExpression=ownerPid,
								text="You need this more than I do.",
								waitForClick= constBoolExpression(false)
							})
							
    local card_name = "share_card_2v2"
	
    local cardLayout = createLayout({
        name = "Helping Hand",
        art = "art/epicart/arcane_research",
        frame = "frames/generic_cardframe",
        xmlText = 
		[[
<vlayout>
    <hlayout flexibleheight="4">
            <tmpro text="{expend_1}" fontsize="60" flexiblewidth="2"/>
            <tmpro text="If there are no champions opposite you, move a card with a cost from your discard pile your Ally's discard pile." fontsize="20" flexiblewidth="12" />
    </hlayout>
<divider/>

    <hlayout flexibleheight="1">
            <tmpro text="Card may not appear to move.
Switch to Ally screen and back to check." fontsize="12" flexiblewidth="1"/>
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
				--check = getTurnsPlayed(currentPid).gte(0),
                activations = singleActivation,
                layout = cardLayout,
				promptType = showPrompt,
                effect =  pushTargetedEffect({
												  desc = "Move a card with a cost from your discard pile to your ally's discard pile.",
												  min=1,
												  max=1,
												  validTargets = selectLoc(loc(currentPid, discardPloc)).where(getCardCost().gte(1)),
												  targetEffect = moveTarget(loc(nil, nullPloc)).seq(moveTarget(loc(nextAllyPid, discardPloc)).apply(selectLoc(loc(nil, nullPloc))))
												  })
												  
												  .seq(randomEffect({
												  valueItem(1, ef_speech1),
												  valueItem(1, ef_speech2),
												  valueItem(1, ef_speech3),
												  valueItem(1, ef_speech4),
												  })),
											check = selectLoc(loc(currentPid, discardPloc)).where(getCardCost().gte(1)).count().gte(1),	
                                            layout = layoutCard(
                                                {
                                                    title = "Helping Hand",
                                                    art = "art/epicart/arcane_research",
                                                    xmlText=[[
<vlayout>
    <hlayout flexibleheight="1">
            <tmpro text="Move a card with a cost from your discard pile into your Ally's discard pile." fontsize="26" flexiblewidth="12" />
    </hlayout>
</vlayout>
]],

                                                }
                                            ),
                                            tags = {},
				check = selectLoc(loc(oppPid, inPlayPloc)).where(isCardChampion()).count().eq(0), --note -- double check?
				cost = combineCosts({expendCost,goldCost(1)}),
            }),
        },
		
		cardEffectAbilities = {},
		layout = cardLayout,
		layoutPath= "art/epicart/arcane_research"
	})
end


local function ee_demon_hunter_carddef()
    local card_name = "Demon Hunter"
    return createChampionDef(
        {
            id = "demon_hunter",
            name = "Demon Hunter",
			types = {championType},
			factions = { imperialFaction },
            acquireCost = 6,
            health = 6,
            isGuard = true,
            abilities = {
                createAbility(
                    {
                        id = "demon_hunter",
                        trigger = uiTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
						promptType = showPrompt,
						layout = createLayout({
									name = "Demon Hunter",
									art = "art/t_paladin_sword",
                                    frame = "frames/imperial_champion_cardframe",
                                    xmlText = [[
                                        <vlayout>
    <hlayout flexibleheight="2">
        <box flexiblewidth="1">
            <tmpro text="{expend}" fontsize="42"/>
        </box>
        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="{combat_4}" fontsize="46" />
            </box>
            <box flexibleheight="2">
                <tmpro text="or
Hit up to 3 champions for 2 damage each." fontsize="22" />
            </box>
        </vlayout>
    </hlayout>
    
</vlayout>
                                    ]],
                                }),
                        effect = pushChoiceEffect({
							choices = {
								{
                                effect = gainCombatEffect(4),
                                layout = createLayout({
									name = "Demon Hunter",
									art = "art/t_paladin_sword",
                                    frame = "frames/imperial_champion_cardframe",
                                    xmlText = [[
                                        <vlayout  forceheight="true">
                                            <icon text="{combat_4}" fontsize="80" />
                                        </vlayout>
                                    ]],
                                }),
                                tags = {  }
                            },
							{
							effect = pushTargetedEffect({
                    desc = "Hit up to 3 champions for 2 damage each.",
                    validTargets = oppStunnableSelector(),
                    min = 1,
                    max = 3,
                    targetEffect = damageTarget(2),
			    }),
                                layout = createLayout({
									name = "Demon Hunter",
									art = "art/t_paladin_sword",
                                    frame = "frames/imperial_champion_cardframe",
                                    xmlText = [[
                                        <vlayout  forceheight="true">
                                            <icon text="Hit up to 3 champions for 2 damage each." fontsize="24" />
                                        </vlayout>
                                    ]],
                                }),
                                tags = {  }
                            },
                            }
									})
												}),
												
				createAbility({
				  id = "demon_hunter_ally",
				  trigger = uiTrigger, 
				  effect = gainHealthEffect(selectLoc(loc(oppPid, discardPloc)).where(isCardStunned()).count().multiply(2)), 
				  promptType = showPrompt,
					layout = layoutCard(
                                                {
                                                    name = "Demon Hunter",
													art = "art/t_paladin_sword",
													frame = "frames/imperial_champion_cardframe",
                                                    xmlText=[[
													<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="7">
            <text text="Gain {health_2} for each champion you have stunned this turn." fontsize="24"/>
</box>
</hlayout>
</vlayout>
													]]
                                                }
                                            ),
				  cost = noCost,
				  activations = singleActivation,
				  check = constBoolExpression(true),
				  allyFactions = {imperialFaction}
				}),		
				
			createAbility({
				  id = "demon_hunter_ally2",
				  trigger = uiTrigger, 
				  cost = noCost,
				  activations = singleActivation,
				  effect = drawCardsEffect(1),
				  promptType = showPrompt,
					layout = layoutCard(
                                                {
                                                    name = "Demon Hunter",
													art = "art/t_paladin_sword",
													frame = "frames/imperial_champion_cardframe",
                                                    xmlText=[[
													<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="7">
            <text text="Draw a card." fontsize="24"/>
</box>
</hlayout>
</vlayout>
													]]
                                                }
                                            ),				  
				  allyFactions = {imperialFaction, imperialFaction}
				}),
				
            },
            layout = createLayout(
                {
                    name = "Demon Hunter",
                    art = "art/epicart/white_knight",
                    frame = "frames/imperial_champion_cardframe",
					cost = 6,
                    xmlText=[[
<vlayout>
<hlayout flexibleheight="2">
<box flexiblewidth="1">
<tmpro text="{expend}" fontsize="32"/>
</box>
<box flexiblewidth="7">
<tmpro text="{combat_4}&lt;size=80%&gt; or deal 2 damage
to each of 3 champions." fontsize="22" />
</box>
</hlayout>
<divider/>
<hlayout flexibleheight="2">
<box flexiblewidth="1">
<tmpro text="{imperial}" fontsize="32"/>
</box>
<box flexiblewidth="7">
<tmpro text="&lt;size=80%&gt;Gain &lt;size=100%&gt;{health_2}&lt;size=80%&gt; for each champion you stun this turn." fontsize="22" />
</box>
</hlayout>
<divider/>
<hlayout flexibleheight="1.5">
<box flexiblewidth="1">
<tmpro text="{imperial}" fontsize="32"/>
</box>
<box flexiblewidth="1">
<tmpro text="{imperial}" fontsize="32"/>
</box>
<box flexiblewidth="7">
<tmpro text="Draw 1" fontsize="20" />
</box>
</hlayout>
</vlayout>
					]],
                    health = 6,
                    isGuard = true
                }
            )
        }
    )
end

---- game setup
function setupGame(g)

registerCards(
        g,
        {
		ee_demon_hunter_carddef()
		})

    standardSetup(g, {
        description = "2v2 Co-op. Created by Aarkenell 22/06/2025. Updated 16/07/2025.",
        ai = createCoopAi(),
        timeoutAi = createTimeoutAi(),
        playerOrder = { plid1, plid4, plid2, plid3 },
		--ai = createHardAi(),
        opponents = { { plid1, plid3 }, { plid2, plid4 }},
		--centerRow = {	"taxation", "taxation", "taxation", "taxation" },
		tradeDeckExceptions = {
		{ qty=1, cardId="demon_hunter" }
		},
        players = {
            {
                id = plid1,
				startDraw = 3,
                canAttackAllyOppChampions = true,
                init = { 
                    fromEnv = plid1
                },
                avatar = "",
				--health = 10,
                cards = {
					skills = {
						{ qty=1, card= share_card_2v2_skilldef() },
					},
                    buffs = {
                        drawCardsCountAtTurnEndDef(5),
                        discardCardsAtTurnStartDef(),
						P1_difficultyBuffs()
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
                avatar = "",
				--health = 1,
                cards = {
                    skills = {
						{ qty=1, card= share_card_2v2_skilldef() },
					},
					buffs = {
                        drawCardsCountAtTurnEndDef(5),
                        discardCardsAtTurnStartDef(),

                    }
                }
            },
            {
                id = plid3,
				canAttackAllyOppChampions = true,
                isAi = true,
                name = "Unknown",
                syncHealth = true,
                startDraw = 0,
                avatar = "",
                health = 0,
                cards = {
                    deck = {
                    },
                    skills = {
                    },
                    buffs = {
                        drawCardsCountAtTurnEndDef(5),
                        discardCardsAtTurnStartDef(),
                        --aiTurnBuffDef(),
						AI_1_hero_select_BuffDef()
						
						

                    }
                }
            },
            {
                id = plid4,
				canAttackAllyOppChampions = true,
                isAi = true,
                name = "Unknown",
                syncHealth = true,
                startDraw = 0,
                avatar = "assassin",
                health = 0,
                cards = {
                    deck = {
                    },
                    skills = {
                    },
                    buffs = {
                        drawCardsCountAtTurnEndDef(5),
                        discardCardsAtTurnStartDef(),
                        --aiTurnBuffDef(),
						AI_2_hero_select_BuffDef(),
						
						

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
        encounter.name = "2v2 Co-op"
        encounter.description = "Battle it out against a pair of heroes based on our very own community members. Now with optional modifiers for a more challenging experience."
        encounter.minlevel = 1
        encounter.maxlevel = 18
        encounter.avatar = "avatars/WarInTheWild/the_call"
        encounter.heroname = "2v2 Co-op"
        encounter.backgroundPath = "scenariointrobackgrounds/journeys/command"
        encounter.features = {
            encounter.feature("avatars/dwarf_cleric_female_01", "Battle it out against a pair of heroes based on our very own community members. You and your ally will have your normal health. However your opponents share a combined health pool."),
            encounter.feature("avatars/halfdemon_fighter_male_02", "You may spend 1 gold each turn to move a card from your discard pile to your Ally's discard pile. Use this to your team's advantage."),
            encounter.feature("avatars/druid_02", "There are some bugs with skill & ability icons getting mixed up between players. Switching to Ally view and back may fix this. If not, skills will still work correctly. Created by Aarkenell 22.06.2025. Updated 16.07.2025. (And still in development.)")
        }
end