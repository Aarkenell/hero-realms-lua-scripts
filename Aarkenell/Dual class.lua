require 'herorealms'
require 'decks'
require 'stdlib'
require 'timeoutai'
require 'hardai_2'
require 'aggressiveai'

--[[ This script offers full choice on all class upgrades  as well as full random feature
Updates:
19.04.2025 - art and frame assets - decapitalisation post WWG patch
]]
-- Game start --

   
	
function startOfGameBuffDef()

 local dual_class_buff = createGlobalBuff({
        id="dual_class_buff",
        name = "Dual Class Forest",
        abilities = {
            createAbility({
                id="dual_class_buff",
				trigger = startOfTurnTrigger,
                effect = nullEffect()
            })
        },
		buffDetails = createBuffDetails({
					name = "Dual Class",
                    art = "art/epicart/halt_",
					text = "<size=80%>You may only use 1 Skill and 1 Ability each turn."
							})
    })

    return createGlobalBuff({
        id="startOfGameBuff",
        name = "Start of Game Story",
        abilities = {
            createAbility({
                id="SoG_effect",
                trigger = startOfTurnTrigger,
                effect = waitForClickEffect("After years of competition and arguing between the various Guilds and Schools in Thandar...", "")
		.seq(waitForClickEffect("...the Emperor decreed that they should open their doors to each other...", ""))
		.seq(waitForClickEffect("...so that the Heroes of the Realm could learn new skills and diversify their battle tactics.", ""))
				.seq(leftStoryTellEffectWithPortrait("inquisition", "Remember, Hero: You may soon have 2 Skills and more than 1 Ability, but you can still only use one of each, each turn."))
				.seq(createCardEffect(dual_class_buff, loc(currentPid, buffsPloc)))
				.seq(sacrificeSelf())
			})
        }   
	})
end

local function chooseTheClass()

	local ef_learn_levels = leftStoryTellEffectWithPortrait("ambushers", "Because of this, it is recommended you play this mod with characters at level 5 or higher, as this is when the secondary skill is granted.")
	.seq(storyTellEffectWithPortrait("ambushers", "You may choose your dual-class yourself, or have it randomly selected by our highly trained AI Imp."))
	.seq(storyTellEffectWithPortrait("ambushers", "If you choose yourself, you have full choice over the upgrades at each level."))
		.seq(storyTellEffectWithPortrait("ambushers", "If you let the imp choose for you, both your class and all upgrades will be chosen randomly for you."))
		.seq(leftStoryTellEffectWithPortrait("ambushers", "Whatever level you choose to play at though, I hope you enjoy the chaos...err.. I mean fun, of the Dual-class experience."))
		.seq(leftStoryTellEffectWithPortrait("ambushers", "Just remember - you may have 2 Skills and more than 1 Ability, but you can still only use one of each, each turn."))
		.seq(pushChoiceEffect({
							choices = {
								{
                                effect = nullEffect(),
                                layout = createLayout({
									name = "Return to Select Dual-Class",
									art = "avatars/ambushers",
                                    frame = "frames/treasure_cardframe",
                                    xmlText = [[
<vlayout  forceheight="true">
<tmpro text="Select 'Undo' to return to top menu, then select 'Choose a Dual Class'." fontsize="28" />
</vlayout>
                                    ]],
                                }),
                            
                            },
							}}))

	local RandomWiz = randomEffect({
					valueItem(1, createCardEffect(random_choose_cleric_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_fighter_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_thief_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_ranger_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_bard_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_necromancer_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_druid_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_barbarian_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_alchemist_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_monk_carddef(), loc(currentPid, handPloc))),
				})

	local RandomThief = randomEffect({
					valueItem(1, createCardEffect(random_choose_cleric_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_wizard_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_fighter_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_ranger_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_bard_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_necromancer_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_druid_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_barbarian_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_alchemist_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_monk_carddef(), loc(currentPid, handPloc))),
				})

	local RandomRanger = randomEffect({
					valueItem(1, createCardEffect(random_choose_cleric_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_wizard_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_fighter_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_thief_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_bard_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_necromancer_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_druid_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_barbarian_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_alchemist_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_monk_carddef(), loc(currentPid, handPloc))),
				})

	local RandomFighter = randomEffect({
					valueItem(1, createCardEffect(random_choose_cleric_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_wizard_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_thief_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_ranger_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_bard_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_necromancer_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_druid_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_barbarian_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_alchemist_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_monk_carddef(), loc(currentPid, handPloc))),
				})

	local RandomCleric = randomEffect({
					valueItem(1, createCardEffect(random_choose_wizard_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_fighter_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_thief_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_ranger_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_bard_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_necromancer_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_druid_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_barbarian_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_alchemist_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_monk_carddef(), loc(currentPid, handPloc))),
				})

	local RandomBard = randomEffect({
					valueItem(1, createCardEffect(random_choose_cleric_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_wizard_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_fighter_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_thief_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_ranger_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_necromancer_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_druid_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_barbarian_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_alchemist_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_monk_carddef(), loc(currentPid, handPloc))),
				})

	local RandomBarb = randomEffect({
					valueItem(1, createCardEffect(random_choose_cleric_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_wizard_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_fighter_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_thief_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_ranger_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_bard_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_necromancer_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_druid_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_alchemist_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_monk_carddef(), loc(currentPid, handPloc))),
				})

	local RandomAlch = randomEffect({
					valueItem(1, createCardEffect(random_choose_cleric_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_wizard_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_fighter_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_thief_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_ranger_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_bard_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_necromancer_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_druid_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_barbarian_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_monk_carddef(), loc(currentPid, handPloc))),
				})

	local RandomMonk = randomEffect({
					valueItem(1, createCardEffect(random_choose_cleric_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_wizard_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_fighter_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_thief_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_ranger_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_bard_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_necromancer_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_druid_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_barbarian_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_alchemist_carddef(), loc(currentPid, handPloc))),
				})

	local RandomDruid = randomEffect({
					valueItem(1, createCardEffect(random_choose_cleric_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_wizard_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_fighter_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_thief_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_ranger_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_bard_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_necromancer_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_barbarian_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_alchemist_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_monk_carddef(), loc(currentPid, handPloc))),
				})

	local RandomNecro = randomEffect({
					valueItem(1, createCardEffect(random_choose_cleric_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_wizard_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_fighter_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_thief_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_ranger_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_bard_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_druid_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_barbarian_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_alchemist_carddef(), loc(currentPid, handPloc))),
					valueItem(1, createCardEffect(random_choose_monk_carddef(), loc(currentPid, handPloc))),
				})
				

    return cardChoiceSelectorEffect({
        id = "SoG_Choice",
        name = "First choice",
        trigger = startOfTurnTrigger,

        upperTitle  = "Welcome! How would you like to proceed?",
        lowerTitle  = "",
-- 1. choose and play
        effectFirst= expendTarget().apply(selectLoc(loc(currentPid, skillsPloc)))	
		.seq(pushChoiceEffectWithTitle(
                                {
								
                                    choices = {  
								-- Choice 1.1: Choose dual
                                        {
                                            effect =  moveTarget(asidePloc).apply(selectLoc(loc(currentPid, handPloc)))
		.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardType(clericType)).count().gte(1),nullEffect(),createCardEffect(choose_cleric_carddef(), loc(currentPid, handPloc))))
		.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardType(fighterType)).count().gte(1),nullEffect(),createCardEffect(choose_fighter_carddef(), loc(currentPid, handPloc))))
		.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardType(rangerType)).count().gte(1),nullEffect(),createCardEffect(choose_ranger_carddef(), loc(currentPid, handPloc))))
		.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardType(thiefType)).count().gte(1),nullEffect(),createCardEffect(choose_thief_carddef(), loc(currentPid, handPloc))))
        .seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardType(wizardType)).count().gte(1),nullEffect(),createCardEffect(choose_wizard_carddef(), loc(currentPid, handPloc))))
		.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardType(alchemistType)).count().gte(1),nullEffect(),createCardEffect(choose_alchemist_carddef(), loc(currentPid, handPloc))))
		.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardType(barbarianType)).count().gte(1),nullEffect(),createCardEffect(choose_barbarian_carddef(), loc(currentPid, handPloc))))
		.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardType(bardType)).count().gte(1),nullEffect(),createCardEffect(choose_bard_carddef(), loc(currentPid, handPloc))))
		.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardType(druidType)).count().gte(1),nullEffect(),createCardEffect(choose_druid_carddef(), loc(currentPid, handPloc))))
		.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardType(monkType)).count().gte(1),nullEffect(),createCardEffect(choose_monk_carddef(), loc(currentPid, handPloc))))
		.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardType(necromancerType)).count().gte(1),nullEffect(),createCardEffect(choose_necromancer_carddef(), loc(currentPid, handPloc)))),

											layout = layoutCard(
                                                {
                                                    title = "Dual Class",
													art = "art/t_storm_siregar",
                                                    xmlText=[[
													
<vlayout>
    <hlayout flexibleheight="1.8">

        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="Pick your
secondary class
and get playing." fontsize="26" />
            </box>
        </vlayout>
    </hlayout>

</vlayout>
													]]
                                                }
                                            ),
                                            tags = {}
                                        },
										
								-- Choice 1.2 - Random selection
                                        {
                                             effect =  storyTellEffectWithPortrait("journeys/fettered_imp", "Allow me to assist you.")
		.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardType(clericType)).count().gte(1),addEffect(RandomCleric),nullEffect()))
		.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardType(fighterType)).count().gte(1),addEffect(RandomFighter),nullEffect()))
		.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardType(rangerType)).count().gte(1),addEffect(RandomRanger),nullEffect()))
		.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardType(thiefType)).count().gte(1),addEffect(RandomThief),nullEffect()))
        .seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardType(wizardType)).count().gte(1),addEffect(RandomWiz),nullEffect()))
		.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardType(alchemistType)).count().gte(1),addEffect(RandomAlch),nullEffect()))
		.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardType(barbarianType)).count().gte(1),addEffect(RandomBarb),nullEffect()))
		.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardType(bardType)).count().gte(1),addEffect(RandomBard),nullEffect()))
		.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardType(druidType)).count().gte(1),addEffect(RandomDruid),nullEffect()))
		.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardType(monkType)).count().gte(1),addEffect(RandomMonk),nullEffect()))
		.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardType(necromancerType)).count().gte(1),addEffect(RandomNecro),nullEffect()))
		
		,
                                            layout = layoutCard(
                                                {
                                                    title = "Select Randomly",
													art = "avatars/journeys/fettered_imp",
                                                    xmlText=[[
<vlayout>
    <hlayout flexibleheight="1.8">

        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="Have your dual-class chosen by one of our highly-trained AI demons." fontsize="26" />
            </box>
        </vlayout>
    </hlayout>

</vlayout>
													]]
                                                }
                                            ),
                                                                                    },
										
                                    },
					
        upperTitle  = "Choose yourself or let our AI Imp decide.",
        lowerTitle  = "",

					})),

-- 1.2 choice		
		effectSecond = leftStoryTellEffectWithPortrait("ambushers", "Welcome to the Dual-class mod!")
 .seq(leftStoryTellEffectWithPortrait("ambushers", "This mod allows you to choose a second class to utilise alongside that of your hero."))
 .seq(leftStoryTellEffectWithPortrait("ambushers", "Selecting a secondary class will do a number of things."))
 .seq(leftStoryTellEffectWithPortrait("ambushers", "For most classes, one Gold in your starting deck will be replaced with an economy card from your new secondary class."))
  .seq(leftStoryTellEffectWithPortrait("ambushers", "And, for most classes, another card from your secondary class will be added to your deck."))
   .seq(leftStoryTellEffectWithPortrait("ambushers", "There are some exceptions, including some classes that get 2 cards added, on top of the change to a gold."))
    .seq(leftStoryTellEffectWithPortrait("ambushers", "The exact changes to each secondary class are listed on each of the cards for selecting that class as your Dual-class."))
	 .seq(leftStoryTellEffectWithPortrait("ambushers", "Lastly, new skills, abilities and cards will be added depending on your Hero Level."))
	 .seq(leftStoryTellEffectWithPortrait("ambushers", "These are not listed on the cards, but we'll show you them here."))
	 .seq(leftStoryTellEffectWithPortrait("ambushers", "Here's how upgrades work..."))
.seq(pushChoiceEffectWithTitle(
                                {
								
                                    choices = {  
								-- 1.2a Gold cahnge & add cards					
										{
                                           effect = ef_learn_levels,
        
            layout = createLayout({
            name = "Deck Changes",
            art = "art/epicart/arm",
            xmlText=[[
<vlayout>
<hlayout flexiblewidth="1">
<text text="
Dual-class selection:
-Replaces a Gold with a new economy card. E.g. Spell Components or Horn of Calling.
-Adds an extra card to your deck. This is the card that upgrades at level 15 (e.g. Cat Familiar).
" fontsize="18" alignment="left"/>
</hlayout>
</vlayout>		
			]]
			}),
                                            tags = {}
                                        },
										-- 1.2b Exceptions					
										{
                                           effect = ef_learn_levels,
        
            layout = createLayout({
            name = "Exceptions to Deck Changes",
            art = "art/epicart/arm",
            xmlText=[[
<vlayout>
<hlayout flexiblewidth="1">
<text text="
Exceptions:
Fighter: Gold is not replaced.
Monk: Replace 2 Gold with
	2 Spring Blossom.
Ranger: Add 2 cards - Hunting
	Bow and Black Arrow.
Thief: Add 2 Throwing Knives
" fontsize="18" alignment="left"/>
</hlayout>
</vlayout>	
			]]
			}),
                                            tags = {}
                                        },
								-- 1.2c Level prog 1
										{
                                           effect = ef_learn_levels,
                                            layout = createLayout({
            name = "Level Progression",
            art = "art/epicart/halt_",
            xmlText=[[
			<vlayout>
<hlayout flexiblewidth="1">
<text text="
Level 1: Ability, level 1.
Level 3: Ability, level 2. 
Level 5: Skill, level 1. 
Level 7: Ability, level 3. 
Level 9: Skill, level 2. 
Level 11: Add one of the two level
	7 cards to your deck.
Level 13: Ability, level 4.
" fontsize="18" alignment="left"/>
</hlayout>
</vlayout>	
			]] }),
                                            tags = {}
                                        },
										  		
								-- 1.2d Level prog 2
										{
                                           effect = ef_learn_levels,
                                            layout = createLayout({
            name = "Level Progression cont.",
            art = "art/epicart/halt_",
            xmlText=[[
			<vlayout>
<hlayout flexiblewidth="1">
<text text="
Level 15: Gain a level 9 Armour. 
Level 17: Add one of the two level
	11 cards to your deck. 
Level 19: Skill, level 3. 
Level 21: Ability, level 5. 
Level 23: Gain a level 15 upgrade
	e.g. Cat Familiar, Spiked
	Mace or Longsword. 
" fontsize="18" alignment="left"/>
</hlayout>
</vlayout>
			]] }),
                                            tags = {}
                                        }
                                    
                                    },
					
        upperTitle  = "When done, click any card to continue.",
        lowerTitle  = "",

					})),	 
	 

                            


-- 1.1 layout
         layoutFirst = createLayout({
            name = "Choose a Dual Class",
            art = "art/t_storm_siregar",
			frame = "frames/generic_cardframe",
            xmlText=[[
													
<vlayout>
    <hlayout flexibleheight="1.8">

        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="Pick your
secondary class
and get playing." fontsize="26" />
            </box>
        </vlayout>
    </hlayout>

</vlayout>
			]] }),

-- 1.2 layout
        layoutSecond = createLayout({
            name = "Learn about the mod",
            art = "art/treasures/t_magic_scroll_souveraine",
			frame = "frames/generic_cardframe",
            xmlText=[[<vlayout>
<hlayout flexiblewidth="1">
<text text="Learn how this mod changes the game and what upgrades you'll receive based on your Hero Level." fontsize="26"/>
</hlayout>
</vlayout>			
			]]
			}),

        turn = 1
    })
end


local function goFirstEffect()
-- this is a dirty hack to make player going first only draw three cards for their first turn. Feel free to replace it with a better implementation.
	return createGlobalBuff({
        id="draw_three_start_buff",
        name = "Go First",
        abilities = {
            createAbility({
                id="go_first_draw_effect",
                trigger = endOfTurnTrigger,
                effect = ifElseEffect(
					getTurnsPlayed(oppPid).eq(1),
					nullEffect(),
					drawCardsEffect(2)
				)
            })
        }
    })
end


local function disableAbilityBuff()

local ab = createAbility({
    id = "disable_ability_buff",
    effect = disableTarget({ endOfTurnExpiry }).apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardType(abilityType))),
    cost = noCost,
    trigger = onSacrificeTrigger,
    activations = singleActivation,
    tags = {  }
})

	return createGlobalBuff({
        id = "disable_ability_buff",
        name = "Disable Abilities",
        abilities = {
            createAbility({
                id = "disable_ability_buff",
                trigger = endOfTurnTrigger,
                effect = addSlotToTarget(createAbilitySlot({
														ability = ab,
														expiry = { neverExpiry },
														displayText = "",
													})).apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardType(abilityType)))
						.seq(sacrificeSelf())
            })
        }
    })
end

local function disableSkillBuff()

local ab = createAbility({
    id = "disable_skill_buff",
    effect = disableTarget({ endOfTurnExpiry }).apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardSkill().And(isCardType(magicArmorType).invert()))),
    cost = noCost,
    trigger = onExpendTrigger,
    activations = singleActivation,
    tags = {  }
})

	return createGlobalBuff({
        id = "disable_ability_buff",
        name = "Disable Abilities",
        abilities = {
            createAbility({
                id = "disable_ability_buff",
                trigger = endOfTurnTrigger,
                effect = addSlotToTarget(createAbilitySlot({
														ability = ab,
														expiry = { neverExpiry },
														displayText = "",
													})).apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardSkill().And(isCardType(magicArmorType).invert())))
						.seq(sacrificeSelf())
            })
        }
    })
end
--=======================================================================================================
function setupGame(g)
	registerCards(g, {
	})

    standardSetup(g, {
        description = "Dual-class Heroes by Aarkenell. Special thanks to WardenSlayer and Userkaffe in making this mod work. Updated 14.11.2024",
        playerOrder = { plid1, plid2 },
        ai = ai.CreateKillSwitchAi(createAggressiveAI(),  createHardAi2()),
        timeoutAi = createTimeoutAi(),
        opponents = { { plid1, plid2 } },
		centerRow = { "the_rot" },
        players = {
            {
                id = plid1,
                -- isAi = true,
                startDraw = 0,
				init = {
                    fromEnv = plid1
                },
                cards = {
					buffs = {
						startOfGameBuffDef(),
						chooseTheClass(),
						drawCardsCountAtTurnEndDef(3),
						disableAbilityBuff(),
						disableSkillBuff(),
						goFirstEffect(),
						discardCardsAtTurnStartDef(),
						fatigueCount(42, 1, "FatigueP1"),
					}
                }
            },
            {
                id = plid2,
                isAi = false,
                startDraw = 0,
				init = {
                    fromEnv = plid2
                },
                cards = {
					buffs = {
						startOfGameBuffDef(),
						chooseTheClass(),
						drawCardsCountAtTurnEndDef(5),
						disableAbilityBuff(),
						disableSkillBuff(),
						discardCardsAtTurnStartDef(),
						fatigueCount(42, 1, "FatigueP2"),
					}
                }
            },            
        }
    })
end

function endGame(g)
end


function setupMeta(meta)
    meta.name = "w"
    meta.minLevel = 0
    meta.maxLevel = 0
    meta.introbackground = ""
    meta.introheader = ""
    meta.introdescription = ""
    meta.path = ""
     meta.features = {
}

end



------
function choose_wizard_carddef()

	local ef1_wizard = moveTarget(asidePloc).apply(selectLoc(loc(currentPid, handPloc)).union(selectLoc(loc(currentPid, deckPloc))))
				.seq(transformTarget("wizard_spell_components").apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("gold")).take(1)))
				.seq(createCardEffect(wizard_cat_familiar_carddef(), loc(currentPid, asidePloc)))
				.seq(createCardEffect(wizard_flame_burst_carddef(), loc(currentPid, skillsPloc)))
				
	
		--Level 3
	local ef3_wizard = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("wizard_flame_burst")))
				.seq(createCardEffect(wizard_fire_blast_carddef(), loc(currentPid, skillsPloc)))
			
	
		--Level 5
	local ef5_wizard = createCardEffect(wizard_channel_carddef(), loc(currentPid, skillsPloc))
				
	
	--Level 7
	local ef7_wizard = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("wizard_fire_blast")))
					.seq(createCardEffect(wizard_fireball_carddef(), loc(currentPid, skillsPloc)))  
	
    --Level 9
	local ef9_wizard = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("wizard_channel")))			
						.seq(pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(wizard_deep_channel_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutTexture("Textures/wizard_deep_channel"),
														},
														
														{
															effect = createCardEffect(wizard_calm_channel_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutTexture("Textures/wizard_calm_channel"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												})
							)
			

--Level 11 -- Lvl 7 card add
	local ef11_wizard = pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(wizard_arcane_wand_carddef(), loc(currentPid, asidePloc)),
															layout = loadLayoutTexture("Textures/wizard_arcane_wand"),
														},
														
														{
															effect = createCardEffect(wizard_silverskull_amulet_carddef(), loc(currentPid, asidePloc)),
															layout = loadLayoutTexture("Textures/wizard_silverskull_amulet"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												})
	
	--Level 13 -- Ab 4
	local ef13_wizard = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("wizard_fireball")))			
						.seq(pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(wizard_rolling_fireball_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutTexture("Textures/wizard_rolling_fireball"),
														},
														
														{
															effect = createCardEffect(wizard_scorching_fireball_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutTexture("Textures/wizard_scorching_fireball"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												})
							)
				
	--Level 15 -- Armour (9)
	local ef15_wizard = pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(wizard_runic_robes_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutTexture("Textures/wizard_runic_robes"),
														},
														
														{
															effect = createCardEffect(wizard_spellcaster_gloves_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutTexture("Textures/wizard_spellcaster_gloves"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												})

	--Level 17 -- Lvl 11 card add
	local ef17_wizard = pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(wizard_magic_mirror_carddef(), loc(currentPid, asidePloc)),
															layout = loadLayoutTexture("Textures/wizard_magic_mirror"),
														},
														
														{
															effect = createCardEffect(wizard_alchemist_s_stone_carddef(), loc(currentPid, asidePloc)),
															layout = loadLayoutTexture("Textures/wizard_alchemist_s_stone"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												})
												

	--Level 19 -- Skill 5
	local ef19_wizard = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("wizard_calm_channel").Or(isCardName("wizard_deep_channel"))))
							.seq(pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(wizard_soul_channel_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutTexture("Textures/wizard_soul_channel"),
														},
														
														{
															effect = createCardEffect(wizard_serene_channel_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutTexture("Textures/wizard_serene_channel"),
														},
														
														{
															effect = createCardEffect(wizard_pure_channel_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutTexture("Textures/wizard_pure_channel"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												}))
				
				
	--Level 21 -- Ab 5
	local ef21_wizard = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("wizard_rolling_fireball").Or(isCardName("wizard_scorching_fireball"))))
							.seq(pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(wizard_barreling_fireball_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutTexture("Textures/wizard_barreling_fireball"),
														},
														
														{
															effect = createCardEffect(wizard_searing_fireball_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutTexture("Textures/wizard_searing_fireball"),
														},
														
														{
															effect = createCardEffect(wizard_explosive_fireball_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutTexture("Textures/wizard_explosive_fireball"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												}))
						
				
	--Level 23
	local ef23_wizard = sacrificeTarget().apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("wizard_cat_familiar")))
						.seq(pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(wizard_wizened_familiar_carddef(), loc(currentPid, asidePloc)),
															layout = loadLayoutTexture("Textures/wizard_wizened_familiar"),
														},
														
														{
															effect = createCardEffect(wizard_content_familiar_carddef(), loc(currentPid, asidePloc)),
															layout = loadLayoutTexture("Textures/wizard_content_familiar"),
														}

														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												}))
				

	--Last
	local efShuffle = 
				pushChoiceEffectWithTitle(
                                {
                                    choices = {                                
										{
                                           effect = moveTarget(deckPloc).apply(selectLoc(loc(currentPid, asidePloc)))
													.seq(shuffleEffect(currentDeckLoc))
													.seq(moveTarget(tradeDeckLoc).apply(selectLoc(centerRowLoc)))
													.seq(shuffleTradeDeckEffect())
													.seq(refillMarketEffect(const(0)).seq(refillMarketEffect(const(1))).seq(refillMarketEffect(const(2))).seq(refillMarketEffect(const(3))).seq(refillMarketEffect(const(4))))
													.seq(addEffect(endTurnEffect())),
                                            layout = createLayout(
                {
                    name = "Yes",
                    art = "art/treasures/t_cleric_elixir_green",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
   <hlayout flexibleheight="3">
 <tmpro text="Accept choices.
Start playing." fontsize="30" flexiblewidth="1" />
</hlayout>
</vlayout>
					]],

                }
            ),
                                            tags = {}
                                        },
										
										{
                                           effect = nullEffect(),
                                            layout = createLayout(
                {
                    name = "No",
                    art = "art/treasures/t_cleric_elixir_blue_purple",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
   <hlayout flexibleheight="3">
 <tmpro text="Pick again.
&lt;size=65%&gt;(Click this card, then 'Undo'.)" fontsize="30" flexiblewidth="1" />
</hlayout>
</vlayout>
					]],

                }
            ),
                                            tags = {}
                                        }
                                    },
					upperTitle = "Confirm your choice.",
					lowerTitle = ""
					})
	--					

    return createDef(
        {
            id = "choose_wizard",
            name = "Dual-class Wizard",
			types = {itemType},
			cardTypeLabel = "Item",
			playLocation = castPloc,
            acquireCost = 0,
            abilities = {
                createAbility(
                    {
                        id = "choose_wizard",
                        trigger = onPlayTrigger,
						playAllType = noPlayPlayType,
						cost = noCost,
                        activations = singleActivations,
                        effect = sacrificeTarget().apply(selectSource())
						.seq(moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc))))
						.seq(ifElseEffect(getHeroLevel(currentPid).gte(1), ef1_wizard, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(3), ef3_wizard, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(5), ef5_wizard, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(7), ef7_wizard, nullEffect()))
-- pushChoiceEffects run in reverse order 
.seq(efShuffle) 
.seq(ifElseEffect(getHeroLevel(currentPid).gte(23), ef23_wizard, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(21), ef21_wizard, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(19), ef19_wizard, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(17), ef17_wizard, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(15), ef15_wizard, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(13), ef13_wizard, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(11), ef11_wizard, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(9), ef9_wizard, nullEffect())),
						
                    }
                ),
            },
            layout = createLayout(
                {
                    name = "Dual-class Wizard",
                    art = "avatars/wizard_01",
                    frame = "frames/generic_cardframe",
					cost = 0,
                    xmlText=[[
<vlayout>
<box flexibleheight="10">
<tmpro text="Replace a Gold
with Spell Components.

Add a Cat Familiar." fontsize="20"/>
</box>
<hlayout flexibleheight="1">
</hlayout>
</vlayout>
					]],

                }
            )
        }
    )
end

function choose_cleric_carddef()

	local ef1_cleric = moveTarget(asidePloc).apply(selectLoc(loc(currentPid, handPloc)).union(selectLoc(loc(currentPid, deckPloc))))
				.seq(transformTarget("cleric_spiked_mace").apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("gold")).take(1)))
				.seq(createCardEffect(cleric_follower_a_carddef(), loc(currentPid, asidePloc)))
				.seq(createCardEffect(cleric_minor_resurrect_carddef(), loc(currentPid, skillsPloc)))
				.seq(sacrificeSelf())
	
		--Level 3
	local ef3_cleric = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("cleric_minor_resurrect")))
				.seq(createCardEffect(cleric_lesser_resurrect_carddef(), loc(currentPid, skillsPloc)))
				.seq(sacrificeSelf())
	
		--Level 5
	local ef5_cleric = createCardEffect(cleric_bless_carddef(), loc(currentPid, skillsPloc))
				.seq(sacrificeSelf())
	
	--Level 7
	local ef7_cleric = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("cleric_lesser_resurrect")))
					.seq(createCardEffect(cleric_resurrect_carddef(), loc(currentPid, skillsPloc)))  
	
	
	
    --Level 9
	local ef9_cleric = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("cleric_bless")))			
						.seq(pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(cleric_bless_of_iron_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutTexture("Textures/cleric_bless_of_iron"),
														},
														
														{
															effect = createCardEffect(cleric_bless_of_heart_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutTexture("Textures/cleric_bless_of_heart"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												})
							)
				
--Level 11 -- Lvl 7 card add
	local ef11_cleric = pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(cleric_redeemed_ruinos_carddef(), loc(currentPid, asidePloc)),
															layout = loadLayoutTexture("Textures/cleric_redeemed_ruinos"),
														},
														
														{
															effect = createCardEffect(cleric_brightstar_shield_carddef(), loc(currentPid, asidePloc)),
															layout = loadLayoutTexture("Textures/cleric_brightstar_shield"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												})
	
	--Level 13 -- Ab 4
	local ef13_cleric = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("cleric_resurrect")))			
						.seq(pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(cleric_battle_resurrect_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutTexture("Textures/cleric_battle_resurrect"),
														},
														
														{
															effect = createCardEffect(cleric_holy_resurrect_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutTexture("Textures/cleric_holy_resurrect"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												})
							)
				
	--Level 15 -- Armour (9)
	local ef15_cleric = pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(cleric_phoenix_helm_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutTexture("Textures/cleric_phoenix_helm"),
														},
														
														{
															effect = createCardEffect(cleric_shining_breastplate_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutTexture("Textures/cleric_shining_breastplate"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												})

	--Level 17 -- Lvl 11 card add
	local ef17_cleric = pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(cleric_hammer_of_light_carddef(), loc(currentPid, asidePloc)),
															layout = loadLayoutTexture("Textures/cleric_hammer_of_light"),
														},
														
														{
															effect = createCardEffect(cleric_talisman_of_renewal_carddef(), loc(currentPid, asidePloc)),
															layout = loadLayoutTexture("Textures/cleric_talisman_of_renewal"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												})
												

	--Level 19 -- Skill 5
	local ef19_cleric = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("cleric_bless_of_iron").Or(isCardName("cleric_bless_of_heart"))))
							.seq(pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(cleric_bless_of_steel_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutTexture("Textures/cleric_bless_of_steel"),
														},
														
														{
															effect = createCardEffect(cleric_bless_the_flock_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutTexture("Textures/cleric_bless_the_flock"),
														},
														
														{
															effect = createCardEffect(cleric_bless_of_soul_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutTexture("Textures/cleric_bless_of_soul"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												}))
				
				
	--Level 21 -- Ab 5
	local ef21_cleric = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("cleric_battle_resurrect").Or(isCardName("cleric_holy_resurrect"))))
							.seq(pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(cleric_mass_resurrect_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutTexture("Textures/cleric_mass_resurrect"),
														},
														
														{
															effect = createCardEffect(cleric_righteous_resurrect_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutTexture("Textures/cleric_righteous_resurrect"),
														},
														
														{
															effect = createCardEffect(cleric_divine_resurrect_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutTexture("Textures/cleric_divine_resurrect"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												}))
						
				
	--Level 23
	local ef23_cleric = sacrificeTarget().apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("cleric_spiked_mace")))
						.seq(pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(cleric_spiked_mace_of_glory_carddef(), loc(currentPid, asidePloc)),
															layout = loadLayoutTexture("Textures/cleric_spiked_mace_of_glory"),
														},
														
														{
															effect = createCardEffect(cleric_spiked_mace_of_might_carddef(), loc(currentPid, asidePloc)),
															layout = loadLayoutTexture("Textures/cleric_spiked_mace_of_might"),
														}

														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												}))
				

	--Last
	local efShuffle = 
				pushChoiceEffectWithTitle(
                                {
                                    choices = {                                
										{
                                           effect = moveTarget(deckPloc).apply(selectLoc(loc(currentPid, asidePloc)))
													.seq(shuffleEffect(currentDeckLoc))
													.seq(moveTarget(tradeDeckLoc).apply(selectLoc(centerRowLoc)))
													.seq(shuffleTradeDeckEffect())
													.seq(refillMarketEffect(const(0)).seq(refillMarketEffect(const(1))).seq(refillMarketEffect(const(2))).seq(refillMarketEffect(const(3))).seq(refillMarketEffect(const(4))))
													
													.seq(addEffect(endTurnEffect())),
                                            layout = createLayout(
                {
                    name = "Yes",
                    art = "art/treasures/t_cleric_elixir_green",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
   <hlayout flexibleheight="3">
 <tmpro text="Accept choices.
Start playing." fontsize="30" flexiblewidth="1" />
</hlayout>
</vlayout>
					]],

                }
            ),
                                            tags = {}
                                        },
										
										{
                                           effect = nullEffect(),
                                            layout = createLayout(
                {
                    name = "No",
                    art = "art/treasures/t_cleric_elixir_blue_purple",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
   <hlayout flexibleheight="3">
 <tmpro text="Pick again.
&lt;size=65%&gt;(Click this card, then 'Undo'.)" fontsize="30" flexiblewidth="1" />
</hlayout>
</vlayout>
					]],

                }
            ),
                                            tags = {}
                                        }
                                    },
					upperTitle = "Confirm your choice.",
					lowerTitle = ""
					})
	--						

    return createDef(
        {
            id = "choose_cleric",
            name = "Dual-class Cleric",
			types = {itemType},
			cardTypeLabel = "Item",
			playLocation = castPloc,
            acquireCost = 0,
            abilities = {
                createAbility(
                    {
                        id = "choose_cleric",
                        trigger = onPlayTrigger,
						playAllType = noPlayPlayType,
                        cost = noCost,
                        activations = singleActivations,
                        effect = sacrificeTarget().apply(selectSource())
						.seq(moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc))))
						.seq(ifElseEffect(getHeroLevel(currentPid).gte(1), ef1_cleric, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(3), ef3_cleric, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(5), ef5_cleric, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(7), ef7_cleric, nullEffect()))
-- pushChoiceEffects run in reverse order 
.seq(efShuffle) 
.seq(ifElseEffect(getHeroLevel(currentPid).gte(23), ef23_cleric, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(21), ef21_cleric, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(19), ef19_cleric, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(17), ef17_cleric, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(15), ef15_cleric, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(13), ef13_cleric, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(11), ef11_cleric, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(9), ef9_cleric, nullEffect())),
						
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Dual-class Cleric",
                    art = "avatars/cleric_02",
                    frame = "frames/generic_cardframe",
					cost = 0,
                    xmlText=[[
<vlayout>
<box flexibleheight="10">
<tmpro text="Replace a Gold
with Spiked Mace.

Add a Follower." fontsize="20"/>
</box>
<hlayout flexibleheight="1">
</hlayout>
</vlayout>
					]],

                }
            )
        }
    )
end

function choose_fighter_carddef()

	local ef1_fighter = moveTarget(asidePloc).apply(selectLoc(loc(currentPid, handPloc)).union(selectLoc(loc(currentPid, deckPloc))))
				--no gold substitute for fighter
				.seq(createCardEffect(fighter_longsword_carddef(), loc(currentPid, asidePloc)))
				.seq(createCardEffect(fighter_precision_blow_carddef(), loc(currentPid, skillsPloc)))
				.seq(sacrificeSelf())
	
		--Level 3
	local ef3_fighter = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("fighter_precision_blow")))
				.seq(createCardEffect(fighter_powerful_blow_carddef(), loc(currentPid, skillsPloc)))
				.seq(sacrificeSelf())
	
		--Level 5
	local ef5_fighter = createCardEffect(fighter_shoulder_bash_carddef(), loc(currentPid, skillsPloc))
				.seq(sacrificeSelf())
	
	--Level 7
	local ef7_fighter = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("fighter_powerful_blow")))
						.seq(createCardEffect(fighter_crushing_blow_carddef(), loc(currentPid, skillsPloc)))  
	
	
	
    --Level 9
	local ef9_fighter = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("fighter_shoulder_bash")))			
						.seq(pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(fighter_knock_back_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutTexture("Textures/fighter_knock_back"),
														},
														
														{
															effect = createCardEffect(fighter_shoulder_smash_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutTexture("Textures/fighter_shoulder_smash"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												})
							)
				
--Level 11 -- Lvl 7 card add
	local ef11_fighter = pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(fighter_double_bladed_axe_carddef(), loc(currentPid, asidePloc)),
															layout = loadLayoutTexture("Textures/fighter_double_bladed_axe"),
														},
														
														{
															effect = createCardEffect(fighter_jagged_spear_carddef(), loc(currentPid, asidePloc)),
															layout = loadLayoutTexture("Textures/fighter_jagged_spear"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												})
	
	--Level 13 -- Ab 4
	local ef13_fighter = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("fighter_crushing_blow")))			
						.seq(pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(fighter_sweeping_blow_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutTexture("Textures/fighter_sweeping_blow"),
														},
														
														{
															effect = createCardEffect(fighter_smashing_blow_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutTexture("Textures/fighter_smashing_blow"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												})
							)
				
	--Level 15 -- Armour (9)
	local ef15_fighter = pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(fighter_helm_of_fury_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutTexture("Textures/fighter_helm_of_fury"),
														},
														
														{
															effect = createCardEffect(fighter_spiked_pauldrons_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutTexture("Textures/fighter_spiked_pauldrons"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												})

	--Level 17 -- Lvl 11 card add
	local ef17_fighter = pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(fighter_sharpening_stone_carddef(), loc(currentPid, asidePloc)),
															layout = loadLayoutTexture("Textures/fighter_sharpening_stone"),
														},
														
														{
															effect = createCardEffect(fighter_rallying_flag_carddef(), loc(currentPid, asidePloc)),
															layout = loadLayoutTexture("Textures/fighter_rallying_flag"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												})
												

	--Level 19 -- Skill 5
	local ef19_fighter = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("fighter_knock_back").Or(isCardName("fighter_shoulder_smash"))))
							.seq(pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(fighter_group_tackle_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutTexture("Textures/fighter_group_tackle"),
														},
														
														{
															effect = createCardEffect(fighter_knock_down_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutTexture("Textures/fighter_knock_down"),
														},
														
														{
															effect = createCardEffect(fighter_shoulder_crush_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutTexture("Textures/fighter_shoulder_crush"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												}))
				
				
	--Level 21 -- Ab 5
	local ef21_fighter = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("fighter_sweeping_blow").Or(isCardName("fighter_smashing_blow"))))
							.seq(pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(fighter_devastating_blow_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutTexture("Textures/fighter_devastating_blow"),
														},
														
														{
															effect = createCardEffect(fighter_mighty_blow_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutTexture("Textures/fighter_mighty_blow"),
														},
														
														{
															effect = createCardEffect(fighter_whirling_blow_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutTexture("Textures/fighter_whirling_blow"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												}))
						
				
	--Level 23
	local ef23_fighter = sacrificeTarget().apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("fighter_longsword")))
						.seq(pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(fighter_flaming_longsword_carddef(), loc(currentPid, asidePloc)),
															layout = loadLayoutTexture("Textures/fighter_flaming_longsword"),
														},
														
														{
															effect = createCardEffect(fighter_lightning_longsword_carddef(), loc(currentPid, asidePloc)),
															layout = loadLayoutTexture("Textures/fighter_lightning_longsword"),
														}

														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												}))
				

	--Last
	local efShuffle = 
				pushChoiceEffectWithTitle(
                                {
                                    choices = {                                
										{
                                           effect = moveTarget(deckPloc).apply(selectLoc(loc(currentPid, asidePloc)))
													.seq(shuffleEffect(currentDeckLoc))
													.seq(moveTarget(tradeDeckLoc).apply(selectLoc(centerRowLoc)))
													.seq(shuffleTradeDeckEffect())
													.seq(refillMarketEffect(const(0)).seq(refillMarketEffect(const(1))).seq(refillMarketEffect(const(2))).seq(refillMarketEffect(const(3))).seq(refillMarketEffect(const(4))))
													
													.seq(addEffect(endTurnEffect())),
                                            layout = createLayout(
                {
                    name = "Yes",
                    art = "art/treasures/t_cleric_elixir_green",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
   <hlayout flexibleheight="3">
 <tmpro text="Accept choices.
Start playing." fontsize="30" flexiblewidth="1" />
</hlayout>
</vlayout>
					]],

                }
            ),
                                            tags = {}
                                        },
										
										{
                                           effect = nullEffect(),
                                            layout = createLayout(
                {
                    name = "No",
                    art = "art/treasures/t_cleric_elixir_blue_purple",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
   <hlayout flexibleheight="3">
 <tmpro text="Pick again.
&lt;size=65%&gt;(Click this card, then 'Undo'.)" fontsize="30" flexiblewidth="1" />
</hlayout>
</vlayout>
					]],

                }
            ),
                                            tags = {}
                                        }
                                    },
					upperTitle = "Confirm your choice.",
					lowerTitle = ""
					})
	--					
			

    return createDef(
        {
            id = "choose_fighter",
            name = "Dual-class Fighter",
			types = {itemType},
			cardTypeLabel = "Item",
			playLocation = castPloc,
            acquireCost = 0,
            abilities = {
                createAbility(
                    {
                        id = "choose_fighter",
                        trigger = onPlayTrigger,
						playAllType = noPlayPlayType,
                        cost = noCost,
                        activations = singleActivations,
                        effect = sacrificeTarget().apply(selectSource())
						.seq(moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc))))
						.seq(ifElseEffect(getHeroLevel(currentPid).gte(1), ef1_fighter, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(3), ef3_fighter, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(5), ef5_fighter, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(7), ef7_fighter, nullEffect()))
-- pushChoiceEffects run in reverse order 
.seq(efShuffle) 
.seq(ifElseEffect(getHeroLevel(currentPid).gte(23), ef23_fighter, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(21), ef21_fighter, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(19), ef19_fighter, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(17), ef17_fighter, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(15), ef15_fighter, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(13), ef13_fighter, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(11), ef11_fighter, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(9), ef9_fighter, nullEffect())),
						
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Dual-class Fighter",
                    art = "avatars/fighter_01",
                    frame = "frames/generic_cardframe",
					cost = 0,
                    xmlText=[[
<vlayout>
<box flexibleheight="10">
<tmpro text="Add a Longsword." fontsize="20"/>
</box>
<hlayout flexibleheight="1">
</hlayout>
</vlayout>
					]],

                }
            )
        }
    )
end

function choose_thief_carddef()

	local ef1_thief = moveTarget(asidePloc).apply(selectLoc(loc(currentPid, handPloc)).union(selectLoc(loc(currentPid, deckPloc))))
				.seq(transformTarget("ruby").apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("gold")).take(1)))
				.seq(createCardEffect(thief_throwing_knife_carddef(), loc(currentPid, asidePloc)))
				--Extra gold-transform for thief/ranger/bard?
				.seq(createCardEffect(thief_throwing_knife_carddef(), loc(currentPid, asidePloc))).seq(sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("gold")).take(1)))
				.seq(createCardEffect(thief_pilfer_carddef(), loc(currentPid, skillsPloc)))
				.seq(sacrificeSelf())
	
		--Level 3
	local ef3_thief = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("thief_pilfer")))
				.seq(createCardEffect(thief_theft_carddef(), loc(currentPid, skillsPloc)))
				.seq(sacrificeSelf())
	
		--Level 5
	local ef5_thief = createCardEffect(thief_pickpocket_carddef(), loc(currentPid, skillsPloc))
				.seq(sacrificeSelf())
	
	--Level 7
	local ef7_thief = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("thief_theft")))
					.seq(createCardEffect(thief_heist_carddef(), loc(currentPid, skillsPloc)))  
	
	
	
    --Level 9
	local ef9_thief = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("thief_pickpocket")))			
						.seq(pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(thief_sleight_of_hand_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutTexture("Textures/thief_sleight_of_hand"),
														},
														
														{
															effect = createCardEffect(thief_swipe_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutTexture("Textures/thief_swipe"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												})
							)
				
--Level 11 -- Lvl 7 card add
	local ef11_thief = pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(thief_knife_belt_carddef(), loc(currentPid, asidePloc)),
															layout = loadLayoutTexture("Textures/thief_knife_belt"),
														},
														
														{
															effect = createCardEffect(thief_sacrificial_dagger_carddef(), loc(currentPid, asidePloc)),
															layout = loadLayoutTexture("Textures/thief_sacrificial_dagger"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												})
	
	--Level 13 -- Ab 4
	local ef13_thief = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("thief_heist")))			
						.seq(pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(thief_timely_heist_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutTexture("Textures/thief_timely_heist"),
														},
														
														{
															effect = createCardEffect(thief_skillful_heist_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutTexture("Textures/thief_skillful_heist"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												})
							)
				
	--Level 15 -- Armour (9)
	local ef15_thief = pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(thief_shadow_mask_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutTexture("Textures/thief_shadow_mask"),
														},
														
														{
															effect = createCardEffect(thief_silent_boots_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutTexture("Textures/thief_silent_boots"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												})

	--Level 17 -- Lvl 11 card add
	local ef17_thief = pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(thief_blackjack_carddef(), loc(currentPid, asidePloc)),
															layout = loadLayoutTexture("Textures/thief_blackjack"),
														},
														
														{
															effect = createCardEffect(thief_jewelers_loupe_carddef(), loc(currentPid, asidePloc)),
															layout = loadLayoutTexture("Textures/thief_jewelers_loupe"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												})
												

	--Level 19 -- Skill 5
	local ef19_thief = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("thief_sleight_of_hand").Or(isCardName("thief_swipe"))))
							.seq(pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(thief_misdirection_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutTexture("Textures/thief_misdirection"),
														},
														
														{
															effect = createCardEffect(thief_distracted_exchange_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutTexture("Textures/thief_distracted_exchange"),
														},
														
														{
															effect = createCardEffect(thief_lift_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutTexture("Textures/thief_lift"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												}))
				
				
	--Level 21 -- Ab 5
	local ef21_thief = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("thief_timely_heist").Or(isCardName("thief_skillful_heist"))))
							.seq(pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(thief_practiced_heist_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutTexture("Textures/thief_practiced_heist"),
														},
														
														{
															effect = createCardEffect(thief_smooth_heist_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutTexture("Textures/thief_smooth_heist"),
														},
														
														{
															effect = createCardEffect(thief_masterful_heist_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutTexture("Textures/thief_masterful_heist"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												}))
						
				
	--Level 23
	local ef23_thief = sacrificeTarget().apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("thief_ruby")))
						.seq(pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(thief_brilliant_ruby_carddef(), loc(currentPid, asidePloc)),
															layout = loadLayoutTexture("Textures/thief_brilliant_ruby"),
														},
														
														{
															effect = createCardEffect(thief_sharpened_ruby_carddef(), loc(currentPid, asidePloc)),
															layout = loadLayoutTexture("Textures/thief_sharpened_ruby"),
														}

														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												}))
				

	--Last
	local efShuffle = 
				pushChoiceEffectWithTitle(
                                {
                                    choices = {                                
										{
                                           effect = moveTarget(deckPloc).apply(selectLoc(loc(currentPid, asidePloc)))
													.seq(shuffleEffect(currentDeckLoc))
													.seq(moveTarget(tradeDeckLoc).apply(selectLoc(centerRowLoc)))
													.seq(shuffleTradeDeckEffect())
													.seq(refillMarketEffect(const(0)).seq(refillMarketEffect(const(1))).seq(refillMarketEffect(const(2))).seq(refillMarketEffect(const(3))).seq(refillMarketEffect(const(4))))
													
													.seq(addEffect(endTurnEffect())),
                                            layout = createLayout(
                {
                    name = "Yes",
                    art = "art/treasures/t_cleric_elixir_green",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
   <hlayout flexibleheight="3">
 <tmpro text="Accept choices.
Start playing." fontsize="30" flexiblewidth="1" />
</hlayout>
</vlayout>
					]],

                }
            ),
                                            tags = {}
                                        },
										
										{
                                           effect = nullEffect(),
                                            layout = createLayout(
                {
                    name = "No",
                    art = "art/treasures/t_cleric_elixir_blue_purple",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
   <hlayout flexibleheight="3">
 <tmpro text="Pick again.
&lt;size=65%&gt;(Click this card, then 'Undo'.)" fontsize="30" flexiblewidth="1" />
</hlayout>
</vlayout>
					]],

                }
            ),
                                            tags = {}
                                        }
                                    },
					upperTitle = "Confirm your choice.",
					lowerTitle = ""
					})
	--						
				

    return createDef(
        {
            id = "choose_thief",
            name = "Dual-class Thief",
			types = {itemType},
			cardTypeLabel = "Item",
			playLocation = castPloc,
            acquireCost = 0,
            abilities = {
                createAbility(
                    {
                        id = "choose_thief",
                        trigger = onPlayTrigger,
						playAllType = noPlayPlayType,
                        effect = sacrificeTarget().apply(selectSource())
						.seq(moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc))))
						.seq(ifElseEffect(getHeroLevel(currentPid).gte(1), ef1_thief, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(3), ef3_thief, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(5), ef5_thief, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(7), ef7_thief, nullEffect()))
-- pushChoiceEffects run in reverse order 
.seq(efShuffle) 
.seq(ifElseEffect(getHeroLevel(currentPid).gte(23), ef23_thief, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(21), ef21_thief, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(19), ef19_thief, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(17), ef17_thief, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(15), ef15_thief, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(13), ef13_thief, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(11), ef11_thief, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(9), ef9_thief, nullEffect())),
						
                    }
                ),
            },
            layout = createLayout(
                {
                    name = "Dual-class Thief",
                    art = "avatars/thief_01",
                    frame = "frames/generic_cardframe",
					cost = 0,
                    xmlText=[[
<vlayout>
<box flexibleheight="10">
<tmpro text="Replace a Gold
with a Ruby.

Add 2 Throwing Knives." fontsize="20"/>
</box>
<hlayout flexibleheight="1">
</hlayout>
</vlayout>
					]],

                }
            )
        }
    )
end

function choose_ranger_carddef()

	local ef1_ranger = moveTarget(asidePloc).apply(selectLoc(loc(currentPid, handPloc)).union(selectLoc(loc(currentPid, deckPloc))))
				.seq(transformTarget("ranger_horn_of_calling").apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("gold")).take(1)))
				.seq(createCardEffect(ranger_black_arrow_carddef(), loc(currentPid, asidePloc)))
				--Extra gold-transform for thief/ranger/bard?
				.seq(createCardEffect(ranger_hunting_bow_carddef(), loc(currentPid, asidePloc))).seq(sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("gold")).take(1)))
				.seq(createCardEffect(ranger_steady_shot_carddef(), loc(currentPid, skillsPloc)))
				.seq(sacrificeSelf())
	
		--Level 3
	local ef3_ranger = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("ranger_steady_shot")))
				.seq(createCardEffect(ranger_well_placed_shot_carddef(), loc(currentPid, skillsPloc)))
				.seq(sacrificeSelf())
	
		--Level 5
	local ef5_ranger = createCardEffect(ranger_track_carddef(), loc(currentPid, skillsPloc))
				.seq(sacrificeSelf())
	
	--Level 7
	local ef7_ranger = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("ranger_well_placed_shot")))
					.seq(createCardEffect(ranger_headshot_carddef(), loc(currentPid, skillsPloc)))  
	
	
	
    --Level 9
	local ef9_ranger = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("ranger_track")))			
						.seq(pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(ranger_fast_track_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutTexture("Textures/ranger_fast_track"),
														},
														
														{
															effect = createCardEffect(ranger_careful_track_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutTexture("Textures/ranger_careful_track"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												})
							)
				
--Level 11 -- Lvl 7 card add
	local ef11_ranger = pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(ranger_snake_pet_carddef(), loc(currentPid, asidePloc)),
															layout = loadLayoutTexture("Textures/ranger_snake_pet"),
														},
														
														{
															effect = createCardEffect(ranger_unending_quiver_carddef(), loc(currentPid, asidePloc)),
															layout = loadLayoutTexture("Textures/ranger_unending_quiver"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												})
	
	--Level 13 -- Ab 4
	local ef13_ranger = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("ranger_headshot")))			
						.seq(pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(ranger_quickshot_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutTexture("Textures/ranger_quickshot"),
														},
														
														{
															effect = createCardEffect(ranger_twin_shot_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutTexture("Textures/ranger_twin_shot"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												})
							)
				
	--Level 15 -- Armour (9)
	local ef15_ranger = pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(ranger_hunters_cloak_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutTexture("Textures/ranger_hunters_cloak"),
														},
														
														{
															effect = createCardEffect(ranger_sureshot_bracer_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutTexture("Textures/ranger_sureshot_bracer"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												})

	--Level 17 -- Lvl 11 card add
	local ef17_ranger = pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(ranger_pathfinder_compass_carddef(), loc(currentPid, asidePloc)),
															layout = loadLayoutTexture("Textures/ranger_pathfinder_compass"),
														},
														
														{
															effect = createCardEffect(ranger_flashfire_arrow_carddef(), loc(currentPid, asidePloc)),
															layout = loadLayoutTexture("Textures/ranger_flashfire_arrow"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												})
												

	--Level 19 -- Skill 5
	local ef19_ranger = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("ranger_fast_track").Or(isCardName("ranger_careful_track"))))
							.seq(pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(ranger_flawless_track_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutTexture("Textures/ranger_flawless_track"),
														},
														
														{
															effect = createCardEffect(ranger_instinctive_track_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutTexture("Textures/ranger_instinctive_track"),
														},
														
														{
															effect = createCardEffect(ranger_relentless_track_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutTexture("Textures/ranger_relentless_track"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												}))
				
				
	--Level 21 -- Ab 5
	local ef21_ranger = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("ranger_quickshot").Or(isCardName("ranger_twin_shot"))))
							.seq(pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(ranger_snapshot_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutTexture("Textures/ranger_snapshot"),
														},
														
														{
															effect = createCardEffect(ranger_longshot_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutTexture("Textures/ranger_longshot"),
														},
														
														{
															effect = createCardEffect(ranger_triple_shot_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutTexture("Textures/ranger_triple_shot"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												}))
						
				
	--Level 23
	local ef23_ranger = sacrificeTarget().apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("ranger_horn_of_calling")))
						.seq(pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(ranger_horn_of_need_carddef(), loc(currentPid, asidePloc)),
															layout = loadLayoutTexture("Textures/ranger_horn_of_need"),
														},
														
														{
															effect = createCardEffect(ranger_horn_of_command_carddef(), loc(currentPid, asidePloc)),
															layout = loadLayoutTexture("Textures/ranger_horn_of_command"),
														}

														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												}))
				

	--Last
	local efShuffle = 
				pushChoiceEffectWithTitle(
                                {
                                    choices = {                                
										{
                                           effect = moveTarget(deckPloc).apply(selectLoc(loc(currentPid, asidePloc)))
													.seq(shuffleEffect(currentDeckLoc))
													.seq(moveTarget(tradeDeckLoc).apply(selectLoc(centerRowLoc)))
													.seq(shuffleTradeDeckEffect())
													.seq(refillMarketEffect(const(0)).seq(refillMarketEffect(const(1))).seq(refillMarketEffect(const(2))).seq(refillMarketEffect(const(3))).seq(refillMarketEffect(const(4))))
													
													.seq(addEffect(endTurnEffect())),
                                            layout = createLayout(
                {
                    name = "Yes",
                    art = "art/treasures/t_cleric_elixir_green",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
   <hlayout flexibleheight="3">
 <tmpro text="Accept choices.
Start playing." fontsize="30" flexiblewidth="1" />
</hlayout>
</vlayout>
					]],

                }
            ),
                                            tags = {}
                                        },
										
										{
                                           effect = nullEffect(),
                                            layout = createLayout(
                {
                    name = "No",
                    art = "art/treasures/t_cleric_elixir_blue_purple",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
   <hlayout flexibleheight="3">
 <tmpro text="Pick again.
&lt;size=65%&gt;(Click this card, then 'Undo'.)" fontsize="30" flexiblewidth="1" />
</hlayout>
</vlayout>
					]],

                }
            ),
                                            tags = {}
                                        }
                                    },
					upperTitle = "Confirm your choice.",
					lowerTitle = ""
					})
	--					
				

    return createDef(
        {
            id = "choose_ranger",
            name = "Dual-class ranger",
			types = {itemType},
			cardTypeLabel = "Item",
			playLocation = castPloc,
            acquireCost = 0,
            abilities = {
                createAbility(
                    {
                        id = "choose_ranger",
                        trigger = onPlayTrigger,
						playAllType = noPlayPlayType,
                        cost = noCost,
                        activations = singleActivations,
                        effect = sacrificeTarget().apply(selectSource())
						.seq(moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc))))
						.seq(ifElseEffect(getHeroLevel(currentPid).gte(1), ef1_ranger, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(3), ef3_ranger, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(5), ef5_ranger, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(7), ef7_ranger, nullEffect()))
-- pushChoiceEffects run in reverse order 
.seq(efShuffle) 
.seq(ifElseEffect(getHeroLevel(currentPid).gte(23), ef23_ranger, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(21), ef21_ranger, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(19), ef19_ranger, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(17), ef17_ranger, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(15), ef15_ranger, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(13), ef13_ranger, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(11), ef11_ranger, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(9), ef9_ranger, nullEffect())),
						
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Dual-class Ranger",
                    art = "avatars/ranger_02",
                    frame = "frames/generic_cardframe",
					cost = 0,
                    xmlText=[[
<vlayout>
<box flexibleheight="10">
<tmpro text="Replace a Gold
with Horn of Calling.

Add a Hunting Bow
and a Black Arrow." fontsize="20"/>
</box>
<hlayout flexibleheight="1">
</hlayout>
</vlayout>
					]],

                }
            )
        }
    )
end

function choose_bard_carddef()

	local ef1_bard = moveTarget(asidePloc).apply(selectLoc(loc(currentPid, handPloc)).union(selectLoc(loc(currentPid, deckPloc))))
				.seq(transformTarget("bard_harp").apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("gold")).take(1)))
				.seq(randomEffect({
					valueItem(1, createCardEffect(bard_guild_tale_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(bard_song_of_the_wild_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(bard_imperial_anthem_carddef(), loc(currentPid, asidePloc)))
					}))
				.seq(createCardEffect(bard_brave_story_carddef(), loc(currentPid, skillsPloc)))
				.seq(sacrificeSelf())
	
		--Level 3
	local ef3_bard = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("bard_brave_story")))
				.seq(createCardEffect(bard_epic_poem_carddef(), loc(currentPid, skillsPloc)))
				.seq(sacrificeSelf())
	
		--Level 5
	local ef5_bard = createCardEffect(bard_moving_melody_carddef(), loc(currentPid, skillsPloc))
				.seq(sacrificeSelf())
	
	--Level 7
	local ef7_bard = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("bard_epic_poem")))
					.seq(createCardEffect(bard_valiant_verse_carddef(), loc(currentPid, skillsPloc)))  
	
	
	
    --Level 9
	local ef9_bard = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("bard_moving_melody")))			
						.seq(pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(bard_inspiring_tune_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/skills_abilities/bard/bard_inspiring_tune"),
														},
														
														{
															effect = createCardEffect(bard_rousing_ode_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/skills_abilities/bard/bard_rousing_ode"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												})
							)
				
--Level 11 -- Lvl 7 card add
	local ef11_bard = pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(bard_silencing_scepter_carddef(), loc(currentPid, asidePloc)),
															layout = loadLayoutData("layouts/bard/bard_silencing_scepter"),
														},
														
														{
															effect = createCardEffect(bard_summoning_drum_carddef(), loc(currentPid, asidePloc)),
															layout = loadLayoutData("layouts/bard/bard_summoning_drum"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												})
	
	--Level 13 -- Ab 4
	local ef13_bard = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("bard_valiant_verse")))			
						.seq(pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(bard_intrepid_tale_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/skills_abilities/bard/bard_intrepid_tale"),
														},
														
														{
															effect = createCardEffect(bard_heroic_fable_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/skills_abilities/bard/bard_heroic_fable"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												})
							)
				
	--Level 15 -- Armour (9)
	local ef15_bard = pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(bard_collecting_cap_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/bard/bard_collecting_cap"),
														},
														
														{
															effect = createCardEffect(bard_coat_of_encores_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/bard/bard_coat_of_encores"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												})

	--Level 17 -- Lvl 11 card add
	local ef17_bard = pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(bard_goblet_of_whimsy_carddef(), loc(currentPid, asidePloc)),
															layout = loadLayoutData("layouts/bard/bard_goblet_of_whimsy"),
														},
														
														{
															effect = createCardEffect(bard_lute_carddef(), loc(currentPid, asidePloc)),
															layout = loadLayoutData("layouts/bard/bard_lute"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												})
												

	--Level 19 -- Skill 5
	local ef19_bard = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("bard_inspiring_tune").Or(isCardName("bard_rousing_ode"))))
							.seq(pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(bard_battle_march_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/skills_abilities/bard/bard_battle_march"),
														},
														
														{
															effect = createCardEffect(bard_rally_hymn_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/skills_abilities/bard/bard_rally_hymn"),
														},
														
														{
															effect = createCardEffect(bard_stirring_song_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/skills_abilities/bard/bard_stirring_song"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												}))
				
				
	--Level 21 -- Ab 5
	local ef21_bard = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("bard_intrepid_tale").Or(isCardName("bard_heroic_fable"))))
							.seq(pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(bard_grand_legend_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/skills_abilities/bard/bard_grand_legend"),
														},
														
														{
															effect = createCardEffect(bard_bold_saga_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/skills_abilities/bard/bard_bold_saga"),
														},
														
														{
															effect = createCardEffect(bard_grand_legend_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/skills_abilities/bard/bard_grand_legend"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												}))
						
				
	--Level 23
	local ef23_bard = sacrificeTarget().apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("bard_harp")))
						.seq(pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(bard_golden_harp_carddef(), loc(currentPid, asidePloc)),
															layout = loadLayoutData("layouts/bard/bard_golden_harp"),
														},
														
														{
															effect = createCardEffect(bard_lullaby_harp_carddef(), loc(currentPid, asidePloc)),
															layout = loadLayoutData("layouts/bard/bard_lullaby_harp"),
														}

														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												}))
				

	--Last
	local efShuffle = 
				pushChoiceEffectWithTitle(
                                {
                                    choices = {                                
										{
                                           effect = moveTarget(deckPloc).apply(selectLoc(loc(currentPid, asidePloc)))
													.seq(shuffleEffect(currentDeckLoc))
													.seq(moveTarget(tradeDeckLoc).apply(selectLoc(centerRowLoc)))
													.seq(shuffleTradeDeckEffect())
													.seq(refillMarketEffect(const(0)).seq(refillMarketEffect(const(1))).seq(refillMarketEffect(const(2))).seq(refillMarketEffect(const(3))).seq(refillMarketEffect(const(4))))
													
													.seq(addEffect(endTurnEffect())),
                                            layout = createLayout(
                {
                    name = "Yes",
                    art = "art/treasures/t_cleric_elixir_green",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
   <hlayout flexibleheight="3">
 <tmpro text="Accept choices.
Start playing." fontsize="30" flexiblewidth="1" />
</hlayout>
</vlayout>
					]],

                }
            ),
                                            tags = {}
                                        },
										
										{
                                           effect = nullEffect(),
                                            layout = createLayout(
                {
                    name = "No",
                    art = "art/treasures/t_cleric_elixir_blue_purple",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
   <hlayout flexibleheight="3">
 <tmpro text="Pick again.
&lt;size=65%&gt;(Click this card, then 'Undo'.)" fontsize="30" flexiblewidth="1" />
</hlayout>
</vlayout>
					]],

                }
            ),
                                            tags = {}
                                        }
                                    },
					upperTitle = "Confirm your choice.",
					lowerTitle = ""
					})
	--						
				
				


	--						
				



    return createDef(
        {
            id = "choose_bard",
            name = "Dual-class Bard",
			types = {itemType},
			cardTypeLabel = "Item",
			playLocation = castPloc,
            acquireCost = 0,
            abilities = {
                createAbility(
                    {
                        id = "choose_bard",
                        trigger = onPlayTrigger,
						playAllType = noPlayPlayType,
                        effect = sacrificeTarget().apply(selectSource())
						.seq(moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc))))
						.seq(ifElseEffect(getHeroLevel(currentPid).gte(1), ef1_bard, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(3), ef3_bard, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(5), ef5_bard, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(7), ef7_bard, nullEffect()))
-- pushChoiceEffects run in reverse order
.seq(efShuffle) 
.seq(ifElseEffect(getHeroLevel(currentPid).gte(23), ef23_bard, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(21), ef21_bard, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(19), ef19_bard, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(17), ef17_bard, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(15), ef15_bard, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(13), ef13_bard, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(11), ef11_bard, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(9), ef9_bard, nullEffect())),
						
                    }
                ),
            },
            layout = createLayout(
                {
                    name = "Dual-class Bard",
                    art = "avatars/bard_01",
                    frame = "frames/generic_cardframe",
					cost = 0,
                    xmlText=[[
<vlayout>
<box flexibleheight="10">
<tmpro text="Replace a Gold with either
Song of the Wild, Guild Tale,
or Imperial Anthem.

Add a Harp." fontsize="20"/>
</box>
<hlayout flexibleheight="1">
</hlayout>
</vlayout>
					]],

                }
            )
        }
    )
end

function choose_druid_carddef()

	local ef1_druid = moveTarget(asidePloc).apply(selectLoc(loc(currentPid, handPloc)).union(selectLoc(loc(currentPid, deckPloc))))
				.seq(transformTarget("druid_squirrel").apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("gold")).take(1)))
				.seq(createCardEffect(druid_fox_carddef(), loc(currentPid, asidePloc)))
				.seq(createCardEffect(druid_animal_strength_carddef(), loc(currentPid, skillsPloc)))
				.seq(sacrificeSelf())
	
		--Level 3
	local ef3_druid = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("druid_animal_strength")))
				.seq(createCardEffect(druid_bear_strength_carddef(), loc(currentPid, skillsPloc)))
				.seq(sacrificeSelf())
	
		--Level 5
	local ef5_druid = createCardEffect(druid_forest_rage_carddef(), loc(currentPid, skillsPloc))
				.seq(sacrificeSelf())
	
	--Level 7
	local ef7_druid = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("druid_bear_strength")))
					.seq(createCardEffect(druid_bear_form_carddef(), loc(currentPid, skillsPloc)))  

	
	
    --Level 9
	local ef9_druid = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("druid_forest_rage")))			
						.seq(pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(druid_forest_fury_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/skills_abilities/druid/druid_forest_fury"),
														},
														
														{
															effect = createCardEffect(druid_spirit_of_the_forest_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/skills_abilities/druid/druid_spirit_of_the_forest"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												})
							)
				
--Level 11 -- Lvl 7 card add
	local ef11_druid = pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(druid_owl_carddef(), loc(currentPid, asidePloc)),
															layout = loadLayoutData("layouts/druid/druid_owl"),
														},
														
														{
															effect = createCardEffect(druid_heartwood_splinter_carddef(), loc(currentPid, asidePloc)),
															layout = loadLayoutData("layouts/druid/druid_heartwood_splinter"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												})
	
	--Level 13 -- Ab 4
	local ef13_druid = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("druid_bear_form")))			
						.seq(pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(druid_grizzly_form_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/skills_abilities/druid/druid_grizzly_form"),
														},
														
														{
															effect = createCardEffect(druid_spirit_bear_form_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/skills_abilities/druid/druid_spirit_bear_form"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												})
							)
				
	--Level 15 -- Armour (9)
	local ef15_druid = pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(druid_circlet_of_flowers_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/druid/druid_circlet_of_flowers"),
														},
														
														{
															effect = createCardEffect(druid_grass_weave_sash_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/druid/druid_grass_weave_sash"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												})

	--Level 17 -- Lvl 11 card add
	local ef17_druid = pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(druid_rabbit_carddef(), loc(currentPid, asidePloc)),
															layout = loadLayoutData("layouts/druid/druid_rabbit"),
														},
														
														{
															effect = createCardEffect(druid_ursine_rod_carddef(), loc(currentPid, asidePloc)),
															layout = loadLayoutData("layouts/druid/druid_ursine_rod"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												})
												

	--Level 19 -- Skill 5
	local ef19_druid = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("druid_forest_fury").Or(isCardName("druid_spirit_of_the_forest"))))
							.seq(pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(druid_forest_vengeance_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/skills_abilities/druid/druid_forest_vengeance"),
														},
														
														{
															effect = createCardEffect(druid_way_of_the_forest_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/skills_abilities/druid/druid_way_of_the_forest"),
														},
														
														{
															effect = createCardEffect(druid_soul_of_the_forest_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/skills_abilities/druid/druid_soul_of_the_forest"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												}))
				
				
	--Level 21 -- Ab 5
	local ef21_druid = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("druid_grizzly_form").Or(isCardName("druid_spirit_bear_form"))))
							.seq(pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(druid_polar_bear_form_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/skills_abilities/druid/druid_polar_bear_form"),
														},
														
														{
															effect = createCardEffect(druid_spirit_grizzly_form_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/skills_abilities/druid/druid_spirit_grizzly_form"),
														},
														
														{
															effect = createCardEffect(druid_pure_bear_form_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/skills_abilities/druid/druid_pure_bear_form"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												}))
						
				
	--Level 23
	local ef23_druid = sacrificeTarget().apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("druid_fox")))
						.seq(pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(druid_feral_fox_carddef(), loc(currentPid, asidePloc)),
															layout = loadLayoutData("layouts/druid/druid_feral_fox"),
														},
														
														{
															effect = createCardEffect(druid_nimble_fox_carddef(), loc(currentPid, asidePloc)),
															layout = loadLayoutData("layouts/druid/druid_nimble_fox"),
														}

														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												}))
				

	--Last
	local efShuffle = 
				pushChoiceEffectWithTitle(
                                {
                                    choices = {                                
										{
                                           effect = moveTarget(deckPloc).apply(selectLoc(loc(currentPid, asidePloc)))
													.seq(shuffleEffect(currentDeckLoc))
													.seq(moveTarget(tradeDeckLoc).apply(selectLoc(centerRowLoc)))
													.seq(shuffleTradeDeckEffect())
													.seq(refillMarketEffect(const(0)).seq(refillMarketEffect(const(1))).seq(refillMarketEffect(const(2))).seq(refillMarketEffect(const(3))).seq(refillMarketEffect(const(4))))
													
													.seq(addEffect(endTurnEffect())),
                                            layout = createLayout(
                {
                    name = "Yes",
                    art = "art/treasures/t_cleric_elixir_green",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
   <hlayout flexibleheight="3">
 <tmpro text="Accept choices.
Start playing." fontsize="30" flexiblewidth="1" />
</hlayout>
</vlayout>
					]],

                }
            ),
                                            tags = {}
                                        },
										
										{
                                           effect = nullEffect(),
                                            layout = createLayout(
                {
                    name = "No",
                    art = "art/treasures/t_cleric_elixir_blue_purple",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
   <hlayout flexibleheight="3">
 <tmpro text="Pick again.
&lt;size=65%&gt;(Click this card, then 'Undo'.)" fontsize="30" flexiblewidth="1" />
</hlayout>
</vlayout>
					]],

                }
            ),
                                            tags = {}
                                        }
                                    },
					upperTitle = "Confirm your choice.",
					lowerTitle = ""
					})
	--					
					


    return createDef(
        {
            id = "choose_druid",
            name = "Dual-class Druid",
			types = {itemType},
			cardTypeLabel = "Item",
			playLocation = castPloc,
            acquireCost = 0,
            abilities = {
                createAbility(
                    {
                        id = "choose_druid",
                        trigger = onPlayTrigger,
						playAllType = noPlayPlayType,
                        effect = sacrificeTarget().apply(selectSource())
						.seq(moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc))))
						.seq(ifElseEffect(getHeroLevel(currentPid).gte(1), ef1_druid, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(3), ef3_druid, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(5), ef5_druid, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(7), ef7_druid, nullEffect()))
-- pushChoiceEffects run in reverse order 
.seq(efShuffle) 
.seq(ifElseEffect(getHeroLevel(currentPid).gte(23), ef23_druid, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(21), ef21_druid, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(19), ef19_druid, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(17), ef17_druid, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(15), ef15_druid, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(13), ef13_druid, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(11), ef11_druid, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(9), ef9_druid, nullEffect())),
						
                    }
                ),
            },
            layout = createLayout(
                {
                    name = "Dual-class druid",
                    art = "avatars/druid_01",
                    frame = "frames/generic_cardframe",
					cost = 0,
                    xmlText=[[
<vlayout>
<box flexibleheight="10">
<tmpro text="Replace a Gold
with a Squirrel.

Add a Fox." fontsize="20"/>
</box>
<hlayout flexibleheight="1">
</hlayout>
</vlayout>
					]],

                }
            )
        }
    )
end

function choose_barbarian_carddef()

	local ef1_barbarian = moveTarget(asidePloc).apply(selectLoc(loc(currentPid, handPloc)).union(selectLoc(loc(currentPid, deckPloc))))
				.seq(transformTarget("barbarian_plunder").apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("gold")).take(1)))
				.seq(createCardEffect(barbarian_headbutt_carddef(), loc(currentPid, asidePloc)))
				.seq(createCardEffect(barbarian_growl_carddef(), loc(currentPid, skillsPloc)))

	
		--Level 3 -- Ab 2
	local ef3_barbarian = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("barbarian_growl")))
				.seq(createCardEffect(barbarian_bellow_carddef(), loc(currentPid, skillsPloc)))

	
		--Level 5 -- Skill 3
	local ef5_barbarian = createCardEffect(barbarian_inner_rage_carddef(), loc(currentPid, skillsPloc))

	
	--Level 7 -- Ab 3
	local ef7_barbarian = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("barbarian_bellow")))
					.seq(createCardEffect(barbarian_roar_carddef(), loc(currentPid, skillsPloc)))  

	
	
    --Level 9
	local ef9_barbarian = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("barbarian_inner_rage")))			
						.seq(pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(barbarian_smoldering_rage_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/skills_abilities/barbarian/barbarian_smoldering_rage"),
														},
														
														{
															effect = createCardEffect(barbarian_flaring_rage_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/skills_abilities/barbarian/barbarian_flaring_rage"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												})
							)
				
--Level 11 -- Lvl 7 card add
	local ef11_barbarian = pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(barbarian_wolf_companion_carddef(), loc(currentPid, asidePloc)),
															layout = loadLayoutData("layouts/barbarian/barbarian_wolf_companion"),
														},
														
														{
															effect = createCardEffect(barbarian_flail_carddef(), loc(currentPid, asidePloc)),
															layout = loadLayoutData("layouts/barbarian/barbarian_flail"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												})
	
	--Level 13 -- Ab 4
	local ef13_barbarian = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("barbarian_roar")))			
						.seq(pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(barbarian_terrifying_roar_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/skills_abilities/barbarian/barbarian_terrifying_roar"),
														},
														
														{
															effect = createCardEffect(barbarian_battle_cry_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/skills_abilities/barbarian/barbarian_battle_cry"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												})
							)
				
	--Level 15 -- Armour (9)
	local ef15_barbarian = pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(barbarian_razor_bracers_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/barbarian/barbarian_razor_bracers"),
														},
														
														{
															effect = createCardEffect(barbarian_stomping_boots_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/barbarian/barbarian_stomping_boots"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												})

	--Level 17 -- Lvl 11 card add
	local ef17_barbarian = pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(barbarian_bone_axe_carddef(), loc(currentPid, asidePloc)),
															layout = loadLayoutData("layouts/barbarian/barbarian_bone_axe"),
														},
														
														{
															effect = createCardEffect(barbarian_crushed_coin_carddef(), loc(currentPid, asidePloc)),
															layout = loadLayoutData("layouts/barbarian/barbarian_crushed_coin"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												})
												

	--Level 19 -- Skill 5
	local ef19_barbarian = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("barbarian_smoldering_rage").Or(isCardName("barbarian_flaring_rage"))))
							.seq(pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(barbarian_eternal_rage_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/skills_abilities/barbarian/barbarian_eternal_rage"),
														},
														
														{
															effect = createCardEffect(barbarian_fiery_rage_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/skills_abilities/barbarian/barbarian_fiery_rage"),
														},
														
														{
															effect = createCardEffect(barbarian_explosive_rage_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/skills_abilities/barbarian/barbarian_explosive_rage"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												}))
				
				
	--Level 21 -- Ab 5
	local ef21_barbarian = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("barbarian_terrifying_roar").Or(isCardName("barbarian_battle_cry"))))
							.seq(pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(barbarian_terrifying_howl_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/skills_abilities/barbarian/barbarian_terrifying_howl"),
														},
														
														{
															effect = createCardEffect(barbarian_battle_roar_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/skills_abilities/barbarian/barbarian_battle_roar"),
														},
														
														{
															effect = createCardEffect(barbarian_war_cry_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/skills_abilities/barbarian/barbarian_war_cry"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												}))
						
				
	--Level 23
	local ef23_barbarian = sacrificeTarget().apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("barbarian_headbutt")))
						.seq(pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(barbarian_disorienting_headbutt_carddef(), loc(currentPid, asidePloc)),
															layout = loadLayoutData("layouts/barbarian/barbarian_disorienting_headbutt"),
														},
														
														{
															effect = createCardEffect(barbarian_shattering_headbutt_carddef(), loc(currentPid, asidePloc)),
															layout = loadLayoutData("layouts/barbarian/barbarian_shattering_headbutt"),
														}

														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												}))
				
	
			

	--Last
	local efShuffle = 
				pushChoiceEffectWithTitle(
                                {
                                    choices = {                                
										{
                                           effect = moveTarget(deckPloc).apply(selectLoc(loc(currentPid, asidePloc)))
													.seq(shuffleEffect(currentDeckLoc))
													.seq(moveTarget(tradeDeckLoc).apply(selectLoc(centerRowLoc)))
													.seq(shuffleTradeDeckEffect())
													.seq(refillMarketEffect(const(0)).seq(refillMarketEffect(const(1))).seq(refillMarketEffect(const(2))).seq(refillMarketEffect(const(3))).seq(refillMarketEffect(const(4))))
													
													.seq(addEffect(endTurnEffect())),
                                            layout = createLayout(
                {
                    name = "Yes",
                    art = "art/treasures/t_cleric_elixir_green",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
   <hlayout flexibleheight="3">
 <tmpro text="Accept choices.
Start playing." fontsize="30" flexiblewidth="1" />
</hlayout>
</vlayout>
					]],

                }
            ),
                                            tags = {}
                                        },
										
										{
                                           effect = nullEffect(),
                                            layout = createLayout(
                {
                    name = "No",
                    art = "art/treasures/t_cleric_elixir_blue_purple",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
   <hlayout flexibleheight="3">
 <tmpro text="Pick again.
&lt;size=65%&gt;(Click this card, then 'Undo'.)" fontsize="30" flexiblewidth="1" />
</hlayout>
</vlayout>
					]],

                }
            ),
                                            tags = {}
                                        }
                                    },
					upperTitle = "Confirm your choice.",
					lowerTitle = ""
					})
	--						
				
				


    return createDef(
        {
            id = "choose_barbarian",
            name = "Dual-class Barbarian",
			types = {itemType},
			cardTypeLabel = "Item",
			playLocation = castPloc,
            acquireCost = 0,
            abilities = {
                createAbility(
                    {
                        id = "choose_barbarian",
                        trigger = onPlayTrigger,
						playAllType = noPlayPlayType,
                        effect = sacrificeTarget().apply(selectSource())
						.seq(moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc))))
						.seq(ifElseEffect(getHeroLevel(currentPid).gte(1), ef1_barbarian, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(3), ef3_barbarian, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(5), ef5_barbarian, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(7), ef7_barbarian, nullEffect()))
-- pushChoiceEffects run in reverse order
.seq(efShuffle)
.seq(ifElseEffect(getHeroLevel(currentPid).gte(23), ef23_barbarian, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(21), ef21_barbarian, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(19), ef19_barbarian, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(17), ef17_barbarian, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(15), ef15_barbarian, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(13), ef13_barbarian, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(11), ef11_barbarian, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(9), ef9_barbarian, nullEffect())),
						
                    }
                ),
            },
            layout = createLayout(
                {
                    name = "Dual-class barbarian",
                    art = "avatars/barbarian_01",
                    frame = "frames/generic_cardframe",
					cost = 0,
                    xmlText=[[
<vlayout>
<box flexibleheight="10">
<tmpro text="Replace a Gold
with Plunder.

Add Headbutt." fontsize="20"/>
</box>
<hlayout flexibleheight="1">
</hlayout>
</vlayout>
					]],

                }
            )
        }
    )
end

function choose_monk_carddef()

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

	local ef1_monk = moveTarget(asidePloc).apply(selectLoc(loc(currentPid, handPloc)).union(selectLoc(loc(currentPid, deckPloc))))
				.seq(transformTarget("monk_spring_blossom").apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("gold")).take(1)))
				.seq(transformTarget("monk_spring_blossom").apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("gold")).take(1)))
				.seq(randomEffect({
					valueItem(1, createCardEffect(monk_cobra_fang_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(monk_serene_wind_carddef(), loc(currentPid, asidePloc)))
				}))
				.seq(createCardEffect(monk_calm_carddef(), loc(currentPid, skillsPloc)))
				.seq(sacrificeSelf())
	
		--Level 3 -- Ab 2
	local ef3_monk = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("monk_calm")))
				.seq(createCardEffect(monk_focus_carddef(), loc(currentPid, skillsPloc)))
				.seq(sacrificeSelf())
	
		--Level 5 -- Skill 3
	local ef5_monk = createCardEffect(monk_favored_technique_carddef(), loc(currentPid, skillsPloc))
				.seq(sacrificeSelf())
	
	--Level 7 -- Ab 3
	local ef7_monk = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("monk_focus")))
					.seq(createCardEffect(monk_qi_carddef(), loc(currentPid, skillsPloc)))  
	
	
	
    --Level 9
	local ef9_monk = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("monk_favored_technique")))			
						.seq(pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(monk_flowing_technique_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/skills_abilities/monk/monk_flowing_technique"),
														},
														
														{
															effect = createCardEffect(monk_practiced_technique_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/skills_abilities/monk/monk_practiced_technique"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												})
							)
				
--Level 11 -- Lvl 7 card add
	local ef11_monk = pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(monk_ring_of_1000_palms_carddef(), loc(currentPid, asidePloc)),
															layout = loadLayoutData("layouts/monk/monk_ring_of_1000_palms"),
														},
														
														{
															effect = createCardEffect(monk_stillness_of_water_carddef(), loc(currentPid, asidePloc)),
															layout = loadLayoutData("layouts/monk/monk_stillness_of_water"),
															
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												})
	
	--Level 13 -- Ab 4
	local ef13_monk = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("monk_qi")))			
						.seq(pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(monk_jing_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/skills_abilities/monk/monk_jing"),
														},
														
														{
															effect = createCardEffect(monk_focused_strike_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/skills_abilities/monk/monk_focused_strike"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												})
							)
				
	--Level 15 -- Armour (9)
	local ef15_monk = pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(monk_slippers_of_the_crane_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/monk/monk_slippers_of_the_crane"),
															
														},
														
														{
															effect = createCardEffect(monk_wraps_of_strength_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/monk/monk_wraps_of_strength"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												})

	--Level 17 -- Lvl 11 card add
	local ef17_monk = pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(monk_tonfas_of_balance_carddef(), loc(currentPid, asidePloc)),
															layout = loadLayoutData("layouts/monk/monk_tonfas_of_balance"),
														},
														
														},
														
														upperTitle  = "You must take Tonfas of Balance. (We're all out of Spring Blossoms unfortunately.)",
														lowerTitle  = "",

												})
												

	--Level 19 -- Skill 5
	local ef19_monk = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("monk_flowing_technique").Or(isCardName("monk_practiced_technique"))))
							.seq(pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(monk_fluid_technique_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/skills_abilities/monk/monk_fluid_technique"),
														},
														
														{
															effect = createCardEffect(monk_precise_technique_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/skills_abilities/monk/monk_precise_technique"),
														},
														
														{
															effect = createCardEffect(monk_masterful_technique_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/skills_abilities/monk/monk_masterful_technique"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												}))
				
				
	--Level 21 -- Ab 5
	local ef21_monk = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("monk_jing").Or(isCardName("monk_focused_strike"))))
							.seq(pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(monk_qigong_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/skills_abilities/monk/monk_qigong"),
														},
														
														{
															effect = createCardEffect(monk_yin_yang_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/skills_abilities/monk/monk_yin_yang"),
														},
														
														{
															effect = createCardEffect(monk_dim_mak_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/skills_abilities/monk/monk_dim_mak"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												}))
						
				
	--Level 23
	local ef23_monk = sacrificeTarget().apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("monk_spring_blossom")))
						.seq(pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(monk_resplendent_blossom_carddef(), loc(currentPid, asidePloc)),
															layout = loadLayoutData("layouts/monk/monk_resplendent_blossom"),
														},
														
														{
															effect = createCardEffect(monk_magnificent_blossom_carddef(), loc(currentPid, asidePloc)),
															layout = loadLayoutData("layouts/monk/monk_magnificent_blossom"),
															--older card = radiant blossom
															--effect = createCardEffect(monk_radiant_blossom_carddef(), loc(currentPid, asidePloc)),
															--layout = loadLayoutData("layouts/monk/monk_radiant_blossom"),
															
														}

														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												}))
				

	--Last
	local efShuffle = 
				pushChoiceEffectWithTitle(
                                {
                                    choices = {                                
										{
                                           effect = moveTarget(deckPloc).apply(selectLoc(loc(currentPid, asidePloc)))
													.seq(shuffleEffect(currentDeckLoc))
													.seq(moveTarget(tradeDeckLoc).apply(selectLoc(centerRowLoc)))
													.seq(shuffleTradeDeckEffect())
													.seq(refillMarketEffect(const(0)).seq(refillMarketEffect(const(1))).seq(refillMarketEffect(const(2))).seq(refillMarketEffect(const(3))).seq(refillMarketEffect(const(4))))
													
													.seq(addEffect(endTurnEffect())),
                                            layout = createLayout(
                {
                    name = "Yes",
                    art = "art/treasures/t_cleric_elixir_green",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
   <hlayout flexibleheight="3">
 <tmpro text="Accept choices.
Start playing." fontsize="30" flexiblewidth="1" />
</hlayout>
</vlayout>
					]],

                }
            ),
                                            tags = {}
                                        },
										
										{
                                           effect = nullEffect(),
                                            layout = createLayout(
                {
                    name = "No",
                    art = "art/treasures/t_cleric_elixir_blue_purple",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
   <hlayout flexibleheight="3">
 <tmpro text="Pick again.
&lt;size=65%&gt;(Click this card, then 'Undo'.)" fontsize="30" flexiblewidth="1" />
</hlayout>
</vlayout>
					]],

                }
            ),
                                            tags = {}
                                        }
                                    },
					upperTitle = "Confirm your choice.",
					lowerTitle = ""
					})
	--					
					


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


    return createDef(
        {
            id = "choose_monk",
            name = "Dual-class Monk",
			types = {itemType},
			cardTypeLabel = "Item",
			playLocation = castPloc,
            acquireCost = 0,
            abilities = {
                createAbility(
                    {
                        id = "choose_monk",
                        trigger = onPlayTrigger,
						playAllType = noPlayPlayType,
                        effect = sacrificeTarget().apply(selectSource())
						.seq(createCardEffect(dualmonktaoresetbuff, loc(currentPid, buffsPloc)))
						.seq(moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc))))
						.seq(ifElseEffect(getHeroLevel(currentPid).gte(1), ef1_monk, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(3), ef3_monk, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(5), ef5_monk, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(7), ef7_monk, nullEffect()))
-- pushChoiceEffects run in reverse order 
.seq(efShuffle) 
.seq(ifElseEffect(getHeroLevel(currentPid).gte(23), ef23_monk, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(21), ef21_monk, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(19), ef19_monk, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(17), ef17_monk, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(15), ef15_monk, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(13), ef13_monk, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(11), ef11_monk, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(9), ef9_monk, nullEffect())),
                    }
                ),
            },
            layout = createLayout(
                {
                    name = "Dual-class Monk",
                    art = "avatars/monk_02",
                    frame = "frames/generic_cardframe",
					cost = 0,
                    xmlText=[[
<vlayout>
<box flexibleheight="10">
<tmpro text="Replace 2 gold
with 2 Spring Blossoms.

Add either
Cobra Fang or Serene Wind." fontsize="20"/>
</box>
<hlayout flexibleheight="1">
</hlayout>
</vlayout>
					]],

                }
            )
        }
    )
end

function choose_alchemist_carddef()

	local ef1_alchemist = moveTarget(asidePloc).apply(selectLoc(loc(currentPid, handPloc)).union(selectLoc(loc(currentPid, deckPloc))))
				.seq(transformTarget("alchemist_philosophers_stone").apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("gold")).take(1)))
				.seq(createCardEffect(alchemist_philosophers_stone_carddef(), loc(currentPid, asidePloc)))
				.seq(createCardEffect(alchemist_dissolve_carddef(), loc(currentPid, skillsPloc)))
				.seq(sacrificeSelf())
	
		--Level 3 -- Ab 2
	local ef3_alchemist = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("alchemist_dissolve")))
				.seq(createCardEffect(alchemist_minor_transmutation_carddef(), loc(currentPid, skillsPloc)))
				.seq(sacrificeSelf())
	
		--Level 5 -- Skill 3
	local ef5_alchemist = createCardEffect(alchemist_reflect_carddef(), loc(currentPid, skillsPloc))
				.seq(sacrificeSelf())
	
	--Level 7 -- Ab 3
	local ef7_alchemist = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("alchemist_minor_transmutation")))
					.seq(createCardEffect(alchemist_transmutation_carddef(), loc(currentPid, skillsPloc)))  
	
		
	
    --Level 9
	local ef9_alchemist = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("alchemist_reflect")))			
						.seq(pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(alchemist_dispersion_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/skills_abilities/alchemist/alchemist_dispersion"),
														},
														
														{
															effect = createCardEffect(alchemist_refraction_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/skills_abilities/alchemist/alchemist_refraction"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												})
							)
				
--Level 11 -- Lvl 7 card add
	local ef11_alchemist = pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(alchemist_bottled_tempest_carddef(), loc(currentPid, asidePloc)),
															layout = loadLayoutData("layouts/alchemist/alchemist_bottled_tempest"),
														},
														
														{
															effect = createCardEffect(alchemist_crucible_carddef(), loc(currentPid, asidePloc)),
															layout = loadLayoutData("layouts/alchemist/alchemist_crucible"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												})
	
	--Level 13 -- Ab 4
	local ef13_alchemist = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("alchemist_transmutation")))			
						.seq(pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(alchemist_rapid_transmutation_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/skills_abilities/alchemist/alchemist_rapid_transmutation"),
														},
														
														{
															effect = createCardEffect(alchemist_transmogrification_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/skills_abilities/alchemist/alchemist_transmogrification"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												})
							)
				
	--Level 15 -- Armour (9)
	local ef15_alchemist = pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(alchemist_spectrum_spectacles_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/alchemist/alchemist_spectrum_spectacles"),
														},
														
														{
															effect = createCardEffect(alchemist_auric_gloves_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/alchemist/alchemist_auric_gloves"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												})

	--Level 17 -- Lvl 11 card add
	local ef17_alchemist = pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(alchemist_brittle_gas_carddef(), loc(currentPid, asidePloc)),
															layout = loadLayoutData("layouts/alchemist/alchemist_brittle_gas"),
														},
														
														{
															effect = createCardEffect(alchemist_alchemy_powders_carddef(), loc(currentPid, asidePloc)),
															layout = loadLayoutData("layouts/alchemist/alchemist_alchemy_powders"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												})
												

	--Level 19 -- Skill 5
	local ef19_alchemist = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("alchemist_dispersion").Or(isCardName("alchemist_refraction"))))
							.seq(pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(alchemist_wide_diffusion_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/skills_abilities/alchemist/alchemist_wide_diffusion"),
														},
														
														{
															effect = createCardEffect(alchemist_prismatic_dispersion_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/skills_abilities/alchemist/alchemist_prismatic_dispersion"),
														},
														
														{
															effect = createCardEffect(alchemist_perfect_refraction_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/skills_abilities/alchemist/alchemist_perfect_refraction"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												}))
				
				
	--Level 21 -- Ab 5
	local ef21_alchemist = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("alchemist_rapid_transmutation").Or(isCardName("alchemist_transmogrification"))))
							.seq(pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(alchemist_instant_transmutation_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/skills_abilities/alchemist/alchemist_instant_transmutation"),
														},
														
														{
															effect = createCardEffect(alchemist_rapid_transmogrification_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/skills_abilities/alchemist/alchemist_rapid_transmogrification"),
														},
														
														{
															effect = createCardEffect(alchemist_major_transmogrification_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/skills_abilities/alchemist/alchemist_major_transmogrification"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												}))
						
				
	--Level 23
	local ef23_alchemist = sacrificeTarget().apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("alchemist_philosophers_stone")))
						.seq(pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(alchemist_swirling_philosophers_stone_carddef(), loc(currentPid, asidePloc)),
															layout = loadLayoutData("layouts/alchemist/alchemist_swirling_philosophers_stone"),
														},
														
														{
															effect = createCardEffect(alchemist_polished_philosophers_stone_carddef(), loc(currentPid, asidePloc)),
															layout = loadLayoutData("layouts/alchemist/alchemist_polished_philosophers_stone"),
														}

														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												}))
				

	--Last
	local efShuffle = 
				pushChoiceEffectWithTitle(
                                {
                                    choices = {                                
										{
                                           effect = moveTarget(deckPloc).apply(selectLoc(loc(currentPid, asidePloc)))
													.seq(shuffleEffect(currentDeckLoc))
													.seq(moveTarget(tradeDeckLoc).apply(selectLoc(centerRowLoc)))
													.seq(shuffleTradeDeckEffect())
													.seq(refillMarketEffect(const(0)).seq(refillMarketEffect(const(1))).seq(refillMarketEffect(const(2))).seq(refillMarketEffect(const(3))).seq(refillMarketEffect(const(4))))
													
													.seq(addEffect(endTurnEffect())),
                                            layout = createLayout(
                {
                    name = "Yes",
                    art = "art/treasures/t_cleric_elixir_green",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
   <hlayout flexibleheight="3">
 <tmpro text="Accept choices.
Start playing." fontsize="30" flexiblewidth="1" />
</hlayout>
</vlayout>
					]],

                }
            ),
                                            tags = {}
                                        },
										
										{
                                           effect = nullEffect(),
                                            layout = createLayout(
                {
                    name = "No",
                    art = "art/treasures/t_cleric_elixir_blue_purple",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
   <hlayout flexibleheight="3">
 <tmpro text="Pick again.
&lt;size=65%&gt;(Click this card, then 'Undo'.)" fontsize="30" flexiblewidth="1" />
</hlayout>
</vlayout>
					]],

                }
            ),
                                            tags = {}
                                        }
                                    },
					upperTitle = "Confirm your choice.",
					lowerTitle = ""
					})
	--			


    return createDef(
        {
            id = "choose_alchemist",
            name = "Dual-class Alchemist",
			types = {itemType},
			cardTypeLabel = "Item",
			playLocation = castPloc,
            acquireCost = 0,
            abilities = {
                createAbility(
                    {
                        id = "choose_alchemist",
                        trigger = onPlayTrigger,
						playAllType = noPlayPlayType,
                        effect = sacrificeTarget().apply(selectSource())
						.seq(moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc))))
						.seq(ifElseEffect(getHeroLevel(currentPid).gte(1), ef1_alchemist, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(3), ef3_alchemist, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(5), ef5_alchemist, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(7), ef7_alchemist, nullEffect()))
-- pushChoiceEffects run in reverse order 
.seq(efShuffle) 
.seq(ifElseEffect(getHeroLevel(currentPid).gte(23), ef23_alchemist, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(21), ef21_alchemist, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(19), ef19_alchemist, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(17), ef17_alchemist, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(15), ef15_alchemist, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(13), ef13_alchemist, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(11), ef11_alchemist, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(9), ef9_alchemist, nullEffect())),
                    }
                ),
            },
            layout = createLayout(
                {
                    name = "Dual-class Alchemist",
                    art = "avatars/alchemist_02",
                    frame = "frames/generic_cardframe",
					cost = 0,
                    xmlText=[[
<vlayout>
<box flexibleheight="10">
<tmpro text="Replace a Gold
with Philosopher's Stone.

Add another
Philosopher's Stone." fontsize="20"/>
</box>
<hlayout flexibleheight="1">
</hlayout>
</vlayout>					]],

                }
            )
        }
    )
end

function choose_necromancer_carddef()

	local ef1_necromancer = moveTarget(asidePloc).apply(selectLoc(loc(currentPid, handPloc)).union(selectLoc(loc(currentPid, deckPloc))))
				.seq(transformTarget("necromancer_soul_prism").apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("gold")).take(1)))
				.seq(createCardEffect(necromancer_rod_of_unlife_carddef(), loc(currentPid, asidePloc)))
				.seq(createCardEffect(necromancer_reanimate_carddef(), loc(currentPid, skillsPloc)))
				.seq(sacrificeSelf())
	
		--Level 3 -- Ab 2
	local ef3_necromancer = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("necromancer_reanimate")))
				.seq(createCardEffect(necromancer_final_return_carddef(), loc(currentPid, skillsPloc)))
				.seq(sacrificeSelf())
	
		--Level 5 -- Skill 3
	local ef5_necromancer = createCardEffect(necromancer_bone_raising_carddef(), loc(currentPid, skillsPloc))
				.seq(sacrificeSelf())
	
	--Level 7 -- Ab 3
	local ef7_necromancer = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("necromancer_final_return")))
					.seq(createCardEffect(necromancer_raise_dead_carddef(), loc(currentPid, skillsPloc)))  
	
		
	
    --Level 9
	local ef9_necromancer = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("necromancer_bone_raising")))			
						.seq(pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(necromancer_fresh_harvest_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/skills_abilities/necromancer/necromancer_fresh_harvest"),
														},
														
														{
															effect = createCardEffect(necromancer_raise_skeleton_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/skills_abilities/necromancer/necromancer_raise_skeleton"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												})
							)
				
--Level 11 -- Lvl 7 card add
	local ef11_necromancer = pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(necromancer_anguish_blade_carddef(), loc(currentPid, asidePloc)),
															layout = loadLayoutData("layouts/necromancer/necromancer_anguish_blade"),
														},
														
														{
															effect = createCardEffect(necromancer_puzzle_box_carddef(), loc(currentPid, asidePloc)),
															layout = loadLayoutData("layouts/necromancer/necromancer_puzzle_box"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												})
	
	--Level 13 -- Ab 4
	local ef13_necromancer = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("necromancer_raise_dead")))			
						.seq(pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(necromancer_animate_dead_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/skills_abilities/necromancer/necromancer_animate_dead"),
														},
														
														{
															effect = createCardEffect(necromancer_corpse_raising_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/skills_abilities/necromancer/necromancer_corpse_raising"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												})
							)
				
	--Level 15 -- Armour (9)
	local ef15_necromancer = pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(necromancer_rotting_crown_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/necromancer/necromancer_rotting_crown"),
														},
														
														{
															effect = createCardEffect(necromancer_plague_belt_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/necromancer/necromancer_plague_belt"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												})

	--Level 17 -- Lvl 11 card add
	local ef17_necromancer = pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(necromancer_voidstone_carddef(), loc(currentPid, asidePloc)),
															layout = loadLayoutData("layouts/necromancer/necromancer_voidstone"),
														},
														
														{
															effect = createCardEffect(necromancer_onyx_skull_carddef(), loc(currentPid, asidePloc)),
															layout = loadLayoutData("layouts/necromancer/necromancer_onyx_skull"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												})
												

	--Level 19 -- Skill 5
	local ef19_necromancer = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("necromancer_fresh_harvest").Or(isCardName("necromancer_raise_skeleton"))))
							.seq(pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(necromancer_skull_swarm_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/skills_abilities/necromancer/necromancer_skull_swarm"),
														},
														
														{
															effect = createCardEffect(necromancer_corpse_horde_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/skills_abilities/necromancer/necromancer_corpse_horde"),
														},
														
														{
															effect = createCardEffect(necromancer_strong_bones_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/skills_abilities/necromancer/necromancer_strong_bones"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												}))
				
				
	--Level 21 -- Ab 5
	local ef21_necromancer = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("necromancer_animate_dead").Or(isCardName("necromancer_corpse_raising"))))
							.seq(pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(necromancer_empty_graves_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/skills_abilities/necromancer/necromancer_empty_graves"),
														},
														
														{
															effect = createCardEffect(necromancer_grave_robbery_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/skills_abilities/necromancer/necromancer_grave_robbery"),
														},
														
														{
															effect = createCardEffect(necromancer_reawaken_carddef(), loc(currentPid, skillsPloc)),
															layout = loadLayoutData("layouts/skills_abilities/necromancer/necromancer_reawaken"),
														}
														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												}))
						
				
	--Level 23
	local ef23_necromancer = sacrificeTarget().apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("necromancer_rod_of_unlife")))
						.seq(pushChoiceEffectWithTitle({
														choices = {
														{
															effect = createCardEffect(necromancer_rod_of_spite_carddef(), loc(currentPid, asidePloc)),
															layout = loadLayoutData("layouts/necromancer/necromancer_rod_of_spite"),
														},
														
														{
															effect = createCardEffect(necromancer_rod_of_reanimation_carddef(), loc(currentPid, asidePloc)),
															layout = loadLayoutData("layouts/necromancer/necromancer_rod_of_reanimation"),
														}

														},
														
														upperTitle  = "Choose your upgrade",
														lowerTitle  = "",

												}))
				

	--Last
	local efShuffle = 
				pushChoiceEffectWithTitle(
                                {
                                    choices = {                                
										{
                                           effect = moveTarget(deckPloc).apply(selectLoc(loc(currentPid, asidePloc)))
													.seq(shuffleEffect(currentDeckLoc))
													.seq(moveTarget(tradeDeckLoc).apply(selectLoc(centerRowLoc)))
													.seq(shuffleTradeDeckEffect())
													.seq(refillMarketEffect(const(0)).seq(refillMarketEffect(const(1))).seq(refillMarketEffect(const(2))).seq(refillMarketEffect(const(3))).seq(refillMarketEffect(const(4))))
													
													.seq(addEffect(endTurnEffect())),
                                            layout = createLayout(
                {
                    name = "Yes",
                    art = "art/treasures/t_cleric_elixir_green",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
   <hlayout flexibleheight="3">
 <tmpro text="Accept choices.
Start playing." fontsize="30" flexiblewidth="1" />
</hlayout>
</vlayout>
					]],

                }
            ),
                                            tags = {}
                                        },
										
										{
                                           effect = nullEffect(),
                                            layout = createLayout(
                {
                    name = "No",
                    art = "art/treasures/t_cleric_elixir_blue_purple",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
   <hlayout flexibleheight="3">
 <tmpro text="Pick again.
&lt;size=65%&gt;(Click this card, then 'Undo'.)" fontsize="30" flexiblewidth="1" />
</hlayout>
</vlayout>
					]],

                }
            ),
                                            tags = {}
                                        }
                                    },
					upperTitle = "Confirm your choice.",
					lowerTitle = ""
					})
	--						



    return createDef(
        {
            id = "choose_necromancer",
            name = "Dual-class Necromancer",
			types = {itemType},
			cardTypeLabel = "Item",
			playLocation = castPloc,
            acquireCost = 0,
            abilities = {
                createAbility(
                    {
                        id = "choose_necromancer",
                        trigger = onPlayTrigger,
						playAllType = noPlayPlayType,
                        effect = sacrificeTarget().apply(selectSource())
						.seq(moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc))))
						.seq(ifElseEffect(getHeroLevel(currentPid).gte(1), ef1_necromancer, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(3), ef3_necromancer, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(5), ef5_necromancer, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(7), ef7_necromancer, nullEffect()))
-- pushChoiceEffects run in reverse order 
.seq(efShuffle) 
.seq(ifElseEffect(getHeroLevel(currentPid).gte(23), ef23_necromancer, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(21), ef21_necromancer, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(19), ef19_necromancer, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(17), ef17_necromancer, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(15), ef15_necromancer, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(13), ef13_necromancer, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(11), ef11_necromancer, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(9), ef9_necromancer, nullEffect())),
                    }
                ),
            },
            layout = createLayout(
                {
                    name = "Dual-class Necromancer",
                    art = "avatars/necromancer_01",
                    frame = "frames/generic_cardframe",
					cost = 0,
                    xmlText=[[
<vlayout>
<box flexibleheight="10">
<tmpro text="Replace a Gold
with Soul Prism.

Add Rod of Unlife." fontsize="20"/>
</box>
<hlayout flexibleheight="1">
</hlayout>
</vlayout>				]],

                }
            )
        }
    )
end

--Random choices
function random_choose_wizard_carddef()

	local ef1_wizard = moveTarget(asidePloc).apply(selectLoc(loc(currentPid, handPloc)).union(selectLoc(loc(currentPid, deckPloc))))
				.seq(transformTarget("wizard_spell_components").apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("gold")).take(1)))
				.seq(createCardEffect(wizard_cat_familiar_carddef(), loc(currentPid, asidePloc)))
				.seq(createCardEffect(wizard_flame_burst_carddef(), loc(currentPid, skillsPloc)))
				.seq(sacrificeSelf())
	
		--Level 3
	local ef3_wizard = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("wizard_flame_burst")))
				.seq(createCardEffect(wizard_fire_blast_carddef(), loc(currentPid, skillsPloc)))
				.seq(sacrificeSelf())
	
		--Level 5
	local ef5_wizard = createCardEffect(wizard_channel_carddef(), loc(currentPid, skillsPloc))
				.seq(sacrificeSelf())
	
	--Level 7
	local ef7_wizard = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("wizard_fire_blast")))
					.seq(createCardEffect(wizard_fireball_carddef(), loc(currentPid, skillsPloc)))  
	
    --Level 9
	local ef9_wizard = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("wizard_channel")))
				.seq(randomEffect({
					valueItem(1, createCardEffect(wizard_calm_channel_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(wizard_deep_channel_carddef(), loc(currentPid, skillsPloc)))
				}))
				
--Level 11 -- Lvl 7 card add
	local ef11_wizard = randomEffect({
					valueItem(1, createCardEffect(wizard_arcane_wand_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(wizard_silverskull_amulet_carddef(), loc(currentPid, asidePloc)))
					})
				.seq(sacrificeSelf())
	--Level 13 -- Ab 4
	local ef13_wizard = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("wizard_fireball")))
				.seq(randomEffect({
					valueItem(1, createCardEffect(wizard_rolling_fireball_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(wizard_scorching_fireball_carddef(), loc(currentPid, skillsPloc)))
					}))
				.seq(sacrificeSelf())
				
	--Level 15 -- Armour (9)
	local ef15_wizard = randomEffect({
					valueItem(1, createCardEffect(wizard_runic_robes_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(wizard_spellcaster_gloves_carddef(), loc(currentPid, skillsPloc)))
					})
				.seq(sacrificeSelf())

	--Level 17 -- Lvl 11 card add
	local ef17_wizard = randomEffect({
					valueItem(1, createCardEffect(wizard_magic_mirror_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(wizard_alchemist_s_stone_carddef(), loc(currentPid, asidePloc)))
					})
				.seq(sacrificeSelf())

	--Level 19 -- Skill 5
	local ef19_wizard = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("wizard_calm_channel").Or(isCardName("wizard_deep_channel"))))
				.seq(randomEffect({
					valueItem(1, createCardEffect(wizard_soul_channel_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(wizard_serene_channel_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(wizard_pure_channel_carddef(), loc(currentPid, skillsPloc)))
					}))
				.seq(sacrificeSelf())
				
	--Level 21 -- Ab 5
	local ef21_wizard = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("wizard_rolling_fireball").Or(isCardName("wizard_scorching_fireball"))))
				.seq(randomEffect({
					valueItem(1, createCardEffect(wizard_barreling_fireball_carddef(), loc(currentPid, skillsPloc))),
					 valueItem(1, createCardEffect(wizard_searing_fireball_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(wizard_explosive_fireball_carddef(), loc(currentPid, skillsPloc)))
					}))	
				.seq(sacrificeSelf())
				
	--Level 23
	local ef23_wizard = sacrificeTarget().apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("wizard_cat_familiar")))
				.seq(randomEffect({
					valueItem(1, createCardEffect(wizard_wizened_familiar_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(wizard_content_familiar_carddef(), loc(currentPid, asidePloc)))
					}))

	--Last
	local efShuffle = moveTarget(deckPloc).apply(selectLoc(loc(currentPid, asidePloc)))
		.seq(shuffleEffect(currentDeckLoc))
		.seq(sacrificeSelf())
	--	

    return createDef(
        {
            id = "random_choose_wizard",
            name = "Dual-class Wizard",
			types = {itemType},
			cardTypeLabel = "Item",
			playLocation = castPloc,
            acquireCost = 0,
            abilities = {
                createAbility(
                    {
                        id = "random_choose_wizard",
                        trigger = onPlayTrigger,
						playAllType = noPlayPlayType,
						cost = noCost,
                        activations = singleActivations,
                        effect = sacrificeTarget().apply(selectSource())
						.seq(moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc))))
						.seq(ifElseEffect(getHeroLevel(currentPid).gte(1), ef1_wizard, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(3), ef3_wizard, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(5), ef5_wizard, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(7), ef7_wizard, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(9), ef9_wizard, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(11), ef11_wizard, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(13), ef13_wizard, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(15), ef15_wizard, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(17), ef17_wizard, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(19), ef19_wizard, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(21), ef21_wizard, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(23), ef23_wizard, nullEffect()))
.seq(efShuffle)
.seq(addEffect(endTurnEffect())),
						
                    }
                ),
            },
            layout = createLayout(
                {
                    name = "Dual-class Wizard",
                    art = "avatars/wizard_01",
                    frame = "frames/generic_cardframe",
					cost = 0,
                    xmlText=[[
<vlayout>
<box flexibleheight="10">
<tmpro text="Replace a Gold
with Spell Components.

Add a Cat Familiar." fontsize="20"/>
</box>
<hlayout flexibleheight="1">
</hlayout>
</vlayout>
					]],

                }
            )
        }
    )
end

function random_choose_cleric_carddef()

	local ef1_cleric = moveTarget(asidePloc).apply(selectLoc(loc(currentPid, handPloc)).union(selectLoc(loc(currentPid, deckPloc))))
				.seq(transformTarget("cleric_spiked_mace").apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("gold")).take(1)))
				.seq(createCardEffect(cleric_follower_a_carddef(), loc(currentPid, asidePloc)))
				.seq(createCardEffect(cleric_minor_resurrect_carddef(), loc(currentPid, skillsPloc)))
				.seq(sacrificeSelf())
	
		--Level 3
	local ef3_cleric = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("cleric_minor_resurrect")))
				.seq(createCardEffect(cleric_lesser_resurrect_carddef(), loc(currentPid, skillsPloc)))
				.seq(sacrificeSelf())
	
		--Level 5
	local ef5_cleric = createCardEffect(cleric_bless_carddef(), loc(currentPid, skillsPloc))
				.seq(sacrificeSelf())
	
	--Level 7
	local ef7_cleric = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("cleric_lesser_resurrect")))
					.seq(createCardEffect(cleric_resurrect_carddef(), loc(currentPid, skillsPloc)))  
	
    --Level 9
	local ef9_cleric = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("cleric_bless")))
				.seq(randomEffect({
					valueItem(1, createCardEffect(cleric_bless_of_iron_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(cleric_bless_of_heart_carddef(), loc(currentPid, skillsPloc)))
				}))
				
--Level 11 -- Lvl 7 card add
	local ef11_cleric = randomEffect({
					valueItem(1, createCardEffect(cleric_redeemed_ruinos_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(cleric_brightstar_shield_carddef(), loc(currentPid, asidePloc)))
					})
				.seq(sacrificeSelf())
	--Level 13 -- Ab 4
	local ef13_cleric = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("cleric_resurrect")))
				.seq(randomEffect({
					valueItem(1, createCardEffect(cleric_holy_resurrect_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(cleric_battle_resurrect_carddef(), loc(currentPid, skillsPloc)))
					}))
				.seq(sacrificeSelf())
				
	--Level 15 -- Armour (9)
	local ef15_cleric = randomEffect({
					valueItem(1, createCardEffect(cleric_phoenix_helm_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(cleric_shining_breastplate_carddef(), loc(currentPid, skillsPloc)))
					})
				.seq(sacrificeSelf())

	--Level 17 -- Lvl 11 card add
	local ef17_cleric = randomEffect({
					valueItem(1, createCardEffect(cleric_hammer_of_light_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(cleric_talisman_of_renewal_carddef(), loc(currentPid, asidePloc)))
					})
				.seq(sacrificeSelf())

	--Level 19 -- Skill 5
	local ef19_cleric = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("cleric_bless_of_iron").Or(isCardName("cleric_bless_of_heart"))))
				.seq(randomEffect({
					valueItem(1, createCardEffect(cleric_bless_the_flock_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(cleric_bless_of_soul_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(cleric_bless_of_steel_carddef(), loc(currentPid, skillsPloc)))
					}))
				.seq(sacrificeSelf())
				
	--Level 21 -- Ab 5
	local ef21_cleric = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("cleric_holy_resurrect").Or(isCardName("cleric_battle_resurrect"))))
				.seq(randomEffect({
					valueItem(1, createCardEffect(cleric_divine_resurrect_carddef(), loc(currentPid, skillsPloc))),
					 valueItem(1, createCardEffect(cleric_mass_resurrect_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(cleric_righteous_resurrect_carddef(), loc(currentPid, skillsPloc)))
					}))	
				.seq(sacrificeSelf())
				
	--Level 23
	local ef23_cleric = sacrificeTarget().apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("cleric_spiked_mace")))
				.seq(randomEffect({
					valueItem(1, createCardEffect(cleric_spiked_mace_of_glory_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(cleric_spiked_mace_of_might_carddef(), loc(currentPid, asidePloc)))
					}))

	--Last
	local efShuffle = moveTarget(deckPloc).apply(selectLoc(loc(currentPid, asidePloc)))
		.seq(shuffleEffect(currentDeckLoc))
		.seq(sacrificeSelf())
	--		

    return createDef(
        {
            id = "random_choose_cleric",
            name = "Dual-class Cleric",
			types = {itemType},
			cardTypeLabel = "Item",
			playLocation = castPloc,
            acquireCost = 0,
            abilities = {
                createAbility(
                    {
                        id = "random_choose_cleric",
                        trigger = onPlayTrigger,
						playAllType = noPlayPlayType,
                        cost = noCost,
                        activations = singleActivations,
                        effect = sacrificeTarget().apply(selectSource())
						.seq(moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc))))
						.seq(ifElseEffect(getHeroLevel(currentPid).gte(1), ef1_cleric, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(3), ef3_cleric, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(5), ef5_cleric, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(7), ef7_cleric, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(9), ef9_cleric, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(11), ef11_cleric, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(13), ef13_cleric, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(15), ef15_cleric, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(17), ef17_cleric, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(19), ef19_cleric, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(21), ef21_cleric, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(23), ef23_cleric, nullEffect()))
.seq(efShuffle)
.seq(addEffect(endTurnEffect())),
						
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Dual-class Cleric",
                    art = "avatars/cleric_02",
                    frame = "frames/generic_cardframe",
					cost = 0,
                    xmlText=[[
<vlayout>
<box flexibleheight="10">
<tmpro text="Replace a Gold
with Spiked Mace.

Add a Follower." fontsize="20"/>
</box>
<hlayout flexibleheight="1">
</hlayout>
</vlayout>
					]],

                }
            )
        }
    )
end

function random_choose_fighter_carddef()

	local ef1_fighter = moveTarget(asidePloc).apply(selectLoc(loc(currentPid, handPloc)).union(selectLoc(loc(currentPid, deckPloc))))
				--no gold substitute for fighter
				.seq(createCardEffect(fighter_longsword_carddef(), loc(currentPid, asidePloc)))
				.seq(createCardEffect(fighter_precision_blow_carddef(), loc(currentPid, skillsPloc)))
				.seq(sacrificeSelf())
	
		--Level 3
	local ef3_fighter = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("fighter_precision_blow")))
				.seq(createCardEffect(fighter_powerful_blow_carddef(), loc(currentPid, skillsPloc)))
				.seq(sacrificeSelf())
	
		--Level 5
	local ef5_fighter = createCardEffect(fighter_shoulder_bash_carddef(), loc(currentPid, skillsPloc))
				.seq(sacrificeSelf())
	
	--Level 7
	local ef7_fighter = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("fighter_powerful_blow")))
						.seq(createCardEffect(fighter_crushing_blow_carddef(), loc(currentPid, skillsPloc)))  
	
    --Level 9
	local ef9_fighter = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("fighter_shoulder_bash")))
				.seq(randomEffect({
					valueItem(1, createCardEffect(fighter_knock_back_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(fighter_shoulder_smash_carddef(), loc(currentPid, skillsPloc)))
				}))
				
--Level 11 -- Lvl 7 card add
	local ef11_fighter = randomEffect({
					valueItem(1, createCardEffect(fighter_double_bladed_axe_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(fighter_jagged_spear_carddef(), loc(currentPid, asidePloc)))
					})
				.seq(sacrificeSelf())
	--Level 13 -- Ab 4
	local ef13_fighter = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("fighter_crushing_blow")))
				.seq(randomEffect({
					valueItem(1, createCardEffect(fighter_smashing_blow_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(fighter_sweeping_blow_carddef(), loc(currentPid, skillsPloc)))
					}))
				.seq(sacrificeSelf())
				
	--Level 15 -- Armour (9)
	local ef15_fighter = randomEffect({
					valueItem(1, createCardEffect(fighter_helm_of_fury_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(fighter_spiked_pauldrons_carddef(), loc(currentPid, skillsPloc)))
					})
				.seq(sacrificeSelf())

	--Level 17 -- Lvl 11 card add
	local ef17_fighter = randomEffect({
					valueItem(1, createCardEffect(fighter_sharpening_stone_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(fighter_rallying_flag_carddef(), loc(currentPid, asidePloc)))
					})
				.seq(sacrificeSelf())

	--Level 19 -- Skill 5
	local ef19_fighter = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("fighter_knock_back").Or(isCardName("fighter_shoulder_smash"))))
				.seq(randomEffect({
					valueItem(1, createCardEffect(fighter_knock_down_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(fighter_group_tackle_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(fighter_shoulder_crush_carddef(), loc(currentPid, skillsPloc)))
					}))
				.seq(sacrificeSelf())
				
	--Level 21 -- Ab 5
	local ef21_fighter = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("fighter_smashing_blow").Or(isCardName("fighter_sweeping_blow"))))
				.seq(randomEffect({
					valueItem(1, createCardEffect(fighter_devastating_blow_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(fighter_mighty_blow_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(fighter_whirling_blow_carddef(), loc(currentPid, skillsPloc)))
					}))	
				.seq(sacrificeSelf())
				
	--Level 23
	local ef23_fighter = sacrificeTarget().apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("fighter_longsword")))
				.seq(randomEffect({
					valueItem(1, createCardEffect(fighter_flaming_longsword_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(fighter_lightning_longsword_carddef(), loc(currentPid, asidePloc)))
					}))

	--Last
	local efShuffle = moveTarget(deckPloc).apply(selectLoc(loc(currentPid, asidePloc)))
		.seq(shuffleEffect(currentDeckLoc))
		.seq(sacrificeSelf())

    return createDef(
        {
            id = "random_choose_fighter",
            name = "Dual-class Fighter",
			types = {itemType},
			cardTypeLabel = "Item",
			playLocation = castPloc,
            acquireCost = 0,
            abilities = {
                createAbility(
                    {
                        id = "random_choose_fighter",
                        trigger = onPlayTrigger,
						playAllType = noPlayPlayType,
                        cost = noCost,
                        activations = singleActivations,
                        effect = sacrificeTarget().apply(selectSource())
						.seq(moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc))))
						.seq(ifElseEffect(getHeroLevel(currentPid).gte(1), ef1_fighter, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(3), ef3_fighter, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(5), ef5_fighter, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(7), ef7_fighter, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(9), ef9_fighter, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(11), ef11_fighter, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(13), ef13_fighter, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(15), ef15_fighter, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(17), ef17_fighter, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(19), ef19_fighter, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(21), ef21_fighter, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(23), ef23_fighter, nullEffect()))
.seq(efShuffle)
.seq(addEffect(endTurnEffect())),
						
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Dual-class Fighter",
                    art = "avatars/fighter_01",
                    frame = "frames/generic_cardframe",
					cost = 0,
                    xmlText=[[
<vlayout>
<box flexibleheight="10">
<tmpro text="Add a Longsword." fontsize="20"/>
</box>
<hlayout flexibleheight="1">
</hlayout>
</vlayout>
					]],

                }
            )
        }
    )
end

function random_choose_thief_carddef()

	local ef1_thief = moveTarget(asidePloc).apply(selectLoc(loc(currentPid, handPloc)).union(selectLoc(loc(currentPid, deckPloc))))
				.seq(transformTarget("ruby").apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("gold")).take(1)))
				.seq(createCardEffect(thief_throwing_knife_carddef(), loc(currentPid, asidePloc)))
				--Extra gold-transform for thief/ranger/bard?
				.seq(createCardEffect(thief_throwing_knife_carddef(), loc(currentPid, asidePloc))).seq(sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("gold")).take(1)))
				.seq(createCardEffect(thief_pilfer_carddef(), loc(currentPid, skillsPloc)))
				.seq(sacrificeSelf())
	
		--Level 3
	local ef3_thief = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("thief_pilfer")))
				.seq(createCardEffect(thief_theft_carddef(), loc(currentPid, skillsPloc)))
				.seq(sacrificeSelf())
	
		--Level 5
	local ef5_thief = createCardEffect(thief_pickpocket_carddef(), loc(currentPid, skillsPloc))
				.seq(sacrificeSelf())
	
	--Level 7
	local ef7_thief = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("thief_theft")))
					.seq(createCardEffect(thief_heist_carddef(), loc(currentPid, skillsPloc)))  
	
    --Level 9
	local ef9_thief = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("thief_pickpocket")))
				.seq(randomEffect({
					valueItem(1, createCardEffect(thief_sleight_of_hand_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(thief_swipe_carddef(), loc(currentPid, skillsPloc)))
				}))
				
--Level 11 -- Lvl 7 card add
	local ef11_thief = randomEffect({
					valueItem(1, createCardEffect(thief_knife_belt_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(thief_sacrificial_dagger_carddef(), loc(currentPid, asidePloc)))
					})
				.seq(sacrificeSelf())
	--Level 13 -- Ab 4
	local ef13_thief = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("thief_heist")))
				.seq(randomEffect({
					valueItem(1, createCardEffect(thief_skillful_heist_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(thief_timely_heist_carddef(), loc(currentPid, skillsPloc)))
					}))
				.seq(sacrificeSelf())
				
	--Level 15 -- Armour (9)
	local ef15_thief = randomEffect({
					valueItem(1, createCardEffect(thief_shadow_mask_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(thief_silent_boots_carddef(), loc(currentPid, skillsPloc)))
					})
				.seq(sacrificeSelf())

	--Level 17 -- Lvl 11 card add
	local ef17_thief = randomEffect({
					valueItem(1, createCardEffect(thief_blackjack_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(thief_jewelers_loupe_carddef(), loc(currentPid, asidePloc)))
					})
				.seq(sacrificeSelf())

	--Level 19 -- Skill 5
	local ef19_thief = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("thief_sleight_of_hand").Or(isCardName("thief_swipe"))))
				.seq(randomEffect({
					valueItem(1, createCardEffect(thief_distracted_exchange_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(thief_misdirection_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(thief_lift_carddef(), loc(currentPid, skillsPloc)))
					}))
				.seq(sacrificeSelf())
				
	--Level 21 -- Ab 5
	local ef21_thief = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("thief_skillful_heist").Or(isCardName("thief_timely_heist"))))
				.seq(randomEffect({
					valueItem(1, createCardEffect(thief_masterful_heist_carddef(), loc(currentPid, skillsPloc))),
					 valueItem(1, createCardEffect(thief_practiced_heist_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(thief_smooth_heist_carddef(), loc(currentPid, skillsPloc)))
					}))	
				.seq(sacrificeSelf())
				
	--Level 23
	local ef23_thief = sacrificeTarget().apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("ruby")).take(1))
				.seq(randomEffect({
					valueItem(1, createCardEffect(thief_brilliant_ruby_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(thief_sharpened_ruby_carddef(), loc(currentPid, asidePloc)))
					}))

	--Last
	local efShuffle = moveTarget(deckPloc).apply(selectLoc(loc(currentPid, asidePloc)))
		.seq(shuffleEffect(currentDeckLoc))
		.seq(sacrificeSelf())

    return createDef(
        {
            id = "random_choose_thief",
            name = "Dual-class Thief",
			types = {itemType},
			cardTypeLabel = "Item",
			playLocation = castPloc,
            acquireCost = 0,
            abilities = {
                createAbility(
                    {
                        id = "random_choose_thief",
                        trigger = onPlayTrigger,
						playAllType = noPlayPlayType,
                        effect = sacrificeTarget().apply(selectSource())
						.seq(moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc))))
						.seq(ifElseEffect(getHeroLevel(currentPid).gte(1), ef1_thief, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(3), ef3_thief, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(5), ef5_thief, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(7), ef7_thief, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(9), ef9_thief, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(11), ef11_thief, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(13), ef13_thief, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(15), ef15_thief, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(17), ef17_thief, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(19), ef19_thief, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(21), ef21_thief, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(23), ef23_thief, nullEffect()))
.seq(efShuffle)
.seq(addEffect(endTurnEffect())),
						
                    }
                ),
            },
            layout = createLayout(
                {
                    name = "Dual-class Thief",
                    art = "avatars/thief_01",
                    frame = "frames/generic_cardframe",
					cost = 0,
                    xmlText=[[
<vlayout>
<box flexibleheight="10">
<tmpro text="Replace a Gold
with a Ruby.

Add 2 Throwing Knives." fontsize="20"/>
</box>
<hlayout flexibleheight="1">
</hlayout>
</vlayout>
					]],

                }
            )
        }
    )
end

function random_choose_ranger_carddef()

	local ef1_ranger = moveTarget(asidePloc).apply(selectLoc(loc(currentPid, handPloc)).union(selectLoc(loc(currentPid, deckPloc))))
				.seq(transformTarget("ranger_horn_of_calling").apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("gold")).take(1)))
				.seq(createCardEffect(ranger_black_arrow_carddef(), loc(currentPid, asidePloc)))
				--Extra gold-transform for thief/ranger/bard?
				.seq(createCardEffect(ranger_hunting_bow_carddef(), loc(currentPid, asidePloc))).seq(sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("gold")).take(1)))
				.seq(createCardEffect(ranger_steady_shot_carddef(), loc(currentPid, skillsPloc)))
				.seq(sacrificeSelf())
	
		--Level 3
	local ef3_ranger = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("ranger_steady_shot")))
				.seq(createCardEffect(ranger_well_placed_shot_carddef(), loc(currentPid, skillsPloc)))
				.seq(sacrificeSelf())
	
		--Level 5
	local ef5_ranger = createCardEffect(ranger_track_carddef(), loc(currentPid, skillsPloc))
				.seq(sacrificeSelf())
	
	--Level 7
	local ef7_ranger = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("ranger_well_placed_shot")))
					.seq(createCardEffect(ranger_headshot_carddef(), loc(currentPid, skillsPloc)))  
	
    --Level 9
	local ef9_ranger = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("ranger_track")))
				.seq(randomEffect({
					valueItem(1, createCardEffect(ranger_fast_track_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(ranger_careful_track_carddef(), loc(currentPid, skillsPloc)))
				}))
				
--Level 11 -- Lvl 7 card add
	local ef11_ranger = randomEffect({
					valueItem(1, createCardEffect(ranger_snake_pet_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(ranger_unending_quiver_carddef(), loc(currentPid, asidePloc)))
					})
				.seq(sacrificeSelf())
	--Level 13 -- Ab 4
	local ef13_ranger = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("ranger_headshot")))
				.seq(randomEffect({
					valueItem(1, createCardEffect(ranger_twin_shot_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(ranger_quickshot_carddef(), loc(currentPid, skillsPloc)))
					}))
				.seq(sacrificeSelf())
				
	--Level 15 -- Armour (9)
	local ef15_ranger = randomEffect({
					valueItem(1, createCardEffect(ranger_hunters_cloak_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(ranger_sureshot_bracer_carddef(), loc(currentPid, skillsPloc)))
					})
				.seq(sacrificeSelf())

	--Level 17 -- Lvl 11 card add
	local ef17_ranger = randomEffect({
					valueItem(1, createCardEffect(ranger_pathfinder_compass_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(ranger_flashfire_arrow_carddef(), loc(currentPid, asidePloc)))
					})
				.seq(sacrificeSelf())

	--Level 19 -- Skill 5
	local ef19_ranger = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("ranger_fast_track").Or(isCardName("ranger_careful_track"))))
				.seq(randomEffect({
					valueItem(1, createCardEffect(ranger_flawless_track_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(ranger_instinctive_track_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(ranger_relentless_track_carddef(), loc(currentPid, skillsPloc)))
					}))
				.seq(sacrificeSelf())
				
	--Level 21 -- Ab 5
	local ef21_ranger = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("ranger_twin_shot").Or(isCardName("ranger_quickshot"))))
				.seq(randomEffect({
					valueItem(1, createCardEffect(ranger_longshot_carddef(), loc(currentPid, skillsPloc))),
					 valueItem(1, createCardEffect(ranger_snapshot_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(ranger_triple_shot_carddef(), loc(currentPid, skillsPloc)))
					}))	
				.seq(sacrificeSelf())
				
	--Level 23
	local ef23_ranger = sacrificeTarget().apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("ranger_horn_of_calling")))
				.seq(randomEffect({
					valueItem(1, createCardEffect(ranger_horn_of_need_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(ranger_horn_of_command_carddef(), loc(currentPid, asidePloc)))
					}))

	--Last
	local efShuffle = moveTarget(deckPloc).apply(selectLoc(loc(currentPid, asidePloc)))
		.seq(shuffleEffect(currentDeckLoc))
		.seq(sacrificeSelf())

    return createDef(
        {
            id = "random_choose_ranger",
            name = "Dual-class ranger",
			types = {itemType},
			cardTypeLabel = "Item",
			playLocation = castPloc,
            acquireCost = 0,
            abilities = {
                createAbility(
                    {
                        id = "random_choose_ranger",
                        trigger = onPlayTrigger,
						playAllType = noPlayPlayType,
                        cost = noCost,
                        activations = singleActivations,
                        effect = sacrificeTarget().apply(selectSource())
						.seq(moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc))))
						.seq(ifElseEffect(getHeroLevel(currentPid).gte(1), ef1_ranger, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(3), ef3_ranger, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(5), ef5_ranger, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(7), ef7_ranger, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(9), ef9_ranger, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(11), ef11_ranger, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(13), ef13_ranger, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(15), ef15_ranger, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(17), ef17_ranger, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(19), ef19_ranger, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(21), ef21_ranger, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(23), ef23_ranger, nullEffect()))
.seq(efShuffle)
.seq(addEffect(endTurnEffect())),
						
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Dual-class Ranger",
                    art = "avatars/ranger_02",
                    frame = "frames/generic_cardframe",
					cost = 0,
                    xmlText=[[
<vlayout>
<box flexibleheight="10">
<tmpro text="Replace a Gold
with Horn of Calling.

Add a Hunting Bow
and a Black Arrow." fontsize="20"/>
</box>
<hlayout flexibleheight="1">
</hlayout>
</vlayout>
					]],

                }
            )
        }
    )
end

function random_choose_bard_carddef()

	local ef1_bard = moveTarget(asidePloc).apply(selectLoc(loc(currentPid, handPloc)).union(selectLoc(loc(currentPid, deckPloc))))
				.seq(transformTarget("bard_harp").apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("gold")).take(1)))
				.seq(randomEffect({
					valueItem(1, createCardEffect(bard_guild_tale_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(bard_song_of_the_wild_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(bard_imperial_anthem_carddef(), loc(currentPid, asidePloc)))
					}))
				.seq(createCardEffect(bard_brave_story_carddef(), loc(currentPid, skillsPloc)))
				.seq(sacrificeSelf())
	
		--Level 3
	local ef3_bard = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("bard_brave_story")))
				.seq(createCardEffect(bard_epic_poem_carddef(), loc(currentPid, skillsPloc)))
				.seq(sacrificeSelf())
	
		--Level 5
	local ef5_bard = createCardEffect(bard_moving_melody_carddef(), loc(currentPid, skillsPloc))
				.seq(sacrificeSelf())
	
	--Level 7
	local ef7_bard = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("bard_epic_poem")))
					.seq(createCardEffect(bard_valiant_verse_carddef(), loc(currentPid, skillsPloc)))  
	
    --Level 9
	local ef9_bard = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("bard_moving_melody")))
				.seq(randomEffect({
					valueItem(1, createCardEffect(bard_rousing_ode_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(bard_inspiring_tune_carddef(), loc(currentPid, skillsPloc)))
				}))
				
--Level 11 -- Lvl 7 card add
	local ef11_bard = randomEffect({
					valueItem(1, createCardEffect(bard_silencing_scepter_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(bard_summoning_drum_carddef(), loc(currentPid, asidePloc)))
					})
				.seq(sacrificeSelf())
	--Level 13 -- Ab 4
	local ef13_bard = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("bard_valiant_verse")))
				.seq(randomEffect({
					valueItem(1, createCardEffect(bard_intrepid_tale_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(bard_heroic_fable_carddef(), loc(currentPid, skillsPloc)))
					}))
				.seq(sacrificeSelf())
				
	--Level 15 -- Armour (9)
	local ef15_bard = randomEffect({
					valueItem(1, createCardEffect(bard_collecting_cap_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(bard_coat_of_encores_carddef(), loc(currentPid, skillsPloc)))
					})
				.seq(sacrificeSelf())

	--Level 17 -- Lvl 11 card add
	local ef17_bard = randomEffect({
					valueItem(1, createCardEffect(bard_lute_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(bard_goblet_of_whimsy_carddef(), loc(currentPid, asidePloc)))
					})
				.seq(sacrificeSelf())

	--Level 19 -- Skill 5
	local ef19_bard = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("bard_rousing_ode").Or(isCardName("bard_inspiring_tune"))))
				.seq(randomEffect({
					valueItem(1, createCardEffect(bard_stirring_song_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(bard_rally_hymn_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(bard_battle_march_carddef(), loc(currentPid, skillsPloc)))
					}))
				.seq(sacrificeSelf())
				
	--Level 21 -- Ab 5
	local ef21_bard = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("bard_intrepid_tale").Or(isCardName("bard_heroic_fable"))))
				.seq(randomEffect({
					valueItem(1, createCardEffect(bard_mythic_chronicle_carddef(), loc(currentPid, skillsPloc))),
					 valueItem(1, createCardEffect(bard_grand_legend_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(bard_bold_saga_carddef(), loc(currentPid, skillsPloc)))
					}))	
				.seq(sacrificeSelf())
				
	--Level 23
	local ef23_bard = sacrificeTarget().apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("bard_harp")))
				.seq(randomEffect({
					valueItem(1, createCardEffect(bard_golden_harp_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(bard_lullaby_harp_carddef(), loc(currentPid, asidePloc)))
					}))

	--Last
	local efShuffle = moveTarget(deckPloc).apply(selectLoc(loc(currentPid, asidePloc)))
		.seq(shuffleEffect(currentDeckLoc))
		.seq(sacrificeSelf())

    return createDef(
        {
            id = "random_choose_bard",
            name = "Dual-class Bard",
			types = {itemType},
			cardTypeLabel = "Item",
			playLocation = castPloc,
            acquireCost = 0,
            abilities = {
                createAbility(
                    {
                        id = "random_choose_bard",
                        trigger = onPlayTrigger,
						playAllType = noPlayPlayType,
                        effect = sacrificeTarget().apply(selectSource())
						.seq(moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc))))
						.seq(ifElseEffect(getHeroLevel(currentPid).gte(1), ef1_bard, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(3), ef3_bard, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(5), ef5_bard, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(7), ef7_bard, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(9), ef9_bard, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(11), ef11_bard, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(13), ef13_bard, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(15), ef15_bard, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(17), ef17_bard, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(19), ef19_bard, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(21), ef21_bard, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(23), ef23_bard, nullEffect()))
.seq(efShuffle)
.seq(addEffect(endTurnEffect())),
						
                    }
                ),
            },
            layout = createLayout(
                {
                    name = "Dual-class Bard",
                    art = "avatars/bard_01",
                    frame = "frames/generic_cardframe",
					cost = 0,
                    xmlText=[[
<vlayout>
<box flexibleheight="10">
<tmpro text="Replace a Gold with either
Song of the Wild, Guild Tale,
or Imperial Anthem.

Add a Harp." fontsize="20"/>
</box>
<hlayout flexibleheight="1">
</hlayout>
</vlayout>
					]],

                }
            )
        }
    )
end

function random_choose_druid_carddef()

	local ef1_druid = moveTarget(asidePloc).apply(selectLoc(loc(currentPid, handPloc)).union(selectLoc(loc(currentPid, deckPloc))))
				.seq(transformTarget("druid_squirrel").apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("gold")).take(1)))
				.seq(createCardEffect(druid_fox_carddef(), loc(currentPid, asidePloc)))
				.seq(createCardEffect(druid_animal_strength_carddef(), loc(currentPid, skillsPloc)))
				.seq(sacrificeSelf())
	
		--Level 3
	local ef3_druid = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("druid_animal_strength")))
				.seq(createCardEffect(druid_bear_strength_carddef(), loc(currentPid, skillsPloc)))
				.seq(sacrificeSelf())
	
		--Level 5
	local ef5_druid = createCardEffect(druid_forest_rage_carddef(), loc(currentPid, skillsPloc))
				.seq(sacrificeSelf())
	
	--Level 7
	local ef7_druid = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("druid_bear_strength")))
					.seq(createCardEffect(druid_bear_form_carddef(), loc(currentPid, skillsPloc)))  
	
    --Level 9
	local ef9_druid = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("druid_forest_rage")))
				.seq(randomEffect({
					valueItem(1, createCardEffect(druid_spirit_of_the_forest_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(druid_forest_fury_carddef(), loc(currentPid, skillsPloc)))
				}))
				
--Level 11 -- Lvl 7 card add
	local ef11_druid = randomEffect({
					valueItem(1, createCardEffect(druid_owl_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(druid_heartwood_splinter_carddef(), loc(currentPid, asidePloc)))
					})
				.seq(sacrificeSelf())
	--Level 13 -- Ab 4
	local ef13_druid = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("druid_bear_form")))
				.seq(randomEffect({
					valueItem(1, createCardEffect(druid_spirit_bear_form_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(druid_grizzly_form_carddef(), loc(currentPid, skillsPloc)))
					}))
				.seq(sacrificeSelf())
				
	--Level 15 -- Armour (9)
	local ef15_druid = randomEffect({
					valueItem(1, createCardEffect(druid_circlet_of_flowers_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(druid_grass_weave_sash_carddef(), loc(currentPid, skillsPloc)))
					})
				.seq(sacrificeSelf())

	--Level 17 -- Lvl 11 card add
	local ef17_druid = randomEffect({
					valueItem(1, createCardEffect(druid_rabbit_carddef(), loc(currentPid, asidePloc)).seq(createCardEffect(druid_rabbit_carddef(), loc(currentPid, asidePloc)))),
					valueItem(1, createCardEffect(druid_ursine_rod_carddef(), loc(currentPid, asidePloc)))
					})
				.seq(sacrificeSelf())

	--Level 19 -- Skill 5
	local ef19_druid = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("druid_spirit_of_the_forest").Or(isCardName("druid_forest_fury"))))
				.seq(randomEffect({
					valueItem(1, createCardEffect(druid_forest_vengeance_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(druid_soul_of_the_forest_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(druid_way_of_the_forest_carddef(), loc(currentPid, skillsPloc)))
					}))
				.seq(sacrificeSelf())
				
	--Level 21 -- Ab 5
	local ef21_druid = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("druid_spirit_bear_form").Or(isCardName("druid_grizzly_form"))))
				.seq(randomEffect({
					valueItem(1, createCardEffect(druid_polar_bear_form_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(druid_spirit_grizzly_form_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(druid_pure_bear_form_carddef(), loc(currentPid, skillsPloc)))
					}))	
				.seq(sacrificeSelf())
				
	--Level 23
	local ef23_druid = sacrificeTarget().apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("druid_fox")))
				.seq(randomEffect({
					valueItem(1, createCardEffect(druid_feral_fox_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(druid_nimble_fox_carddef(), loc(currentPid, asidePloc)))
					}))

	--Last
	local efShuffle = moveTarget(deckPloc).apply(selectLoc(loc(currentPid, asidePloc)))
		.seq(shuffleEffect(currentDeckLoc))
		.seq(sacrificeSelf())

    return createDef(
        {
            id = "random_choose_druid",
            name = "Dual-class Druid",
			types = {itemType},
			cardTypeLabel = "Item",
			playLocation = castPloc,
            acquireCost = 0,
            abilities = {
                createAbility(
                    {
                        id = "random_choose_druid",
                        trigger = onPlayTrigger,
						playAllType = noPlayPlayType,
                        effect = sacrificeTarget().apply(selectSource())
						.seq(moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc))))
						.seq(ifElseEffect(getHeroLevel(currentPid).gte(1), ef1_druid, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(3), ef3_druid, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(5), ef5_druid, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(7), ef7_druid, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(9), ef9_druid, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(11), ef11_druid, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(13), ef13_druid, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(15), ef15_druid, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(17), ef17_druid, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(19), ef19_druid, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(21), ef21_druid, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(23), ef23_druid, nullEffect()))
.seq(efShuffle)
.seq(addEffect(endTurnEffect())),
						
                    }
                ),
            },
            layout = createLayout(
                {
                    name = "Dual-class druid",
                    art = "avatars/druid_01",
                    frame = "frames/generic_cardframe",
					cost = 0,
                    xmlText=[[
<vlayout>
<box flexibleheight="10">
<tmpro text="Replace a Gold
with a Squirrel.

Add a Fox." fontsize="20"/>
</box>
<hlayout flexibleheight="1">
</hlayout>
</vlayout>
					]],

                }
            )
        }
    )
end

function random_choose_barbarian_carddef()

	local ef1_barbarian = moveTarget(asidePloc).apply(selectLoc(loc(currentPid, handPloc)).union(selectLoc(loc(currentPid, deckPloc))))
				.seq(transformTarget("barbarian_plunder").apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("gold")).take(1)))
				.seq(createCardEffect(barbarian_headbutt_carddef(), loc(currentPid, asidePloc)))
				.seq(createCardEffect(barbarian_growl_carddef(), loc(currentPid, skillsPloc)))
				.seq(sacrificeSelf())
	
		--Level 3 -- Ab 2
	local ef3_barbarian = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("barbarian_growl")))
				.seq(createCardEffect(barbarian_bellow_carddef(), loc(currentPid, skillsPloc)))
				.seq(sacrificeSelf())
	
		--Level 5 -- Skill 3
	local ef5_barbarian = createCardEffect(barbarian_inner_rage_carddef(), loc(currentPid, skillsPloc))
				.seq(sacrificeSelf())
	
	--Level 7 -- Ab 3
	local ef7_barbarian = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("barbarian_bellow")))
					.seq(createCardEffect(barbarian_roar_carddef(), loc(currentPid, skillsPloc)))  
	
    --Level 9 -- Skill 4
	local ef9_barbarian = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("barbarian_inner_rage")))
				.seq(randomEffect({
					valueItem(1, createCardEffect(barbarian_flaring_rage_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(barbarian_smoldering_rage_carddef(), loc(currentPid, skillsPloc)))
				}))
				
--Level 11 -- Lvl 7 card add
	local ef11_barbarian = randomEffect({
					valueItem(1, createCardEffect(barbarian_flail_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(barbarian_wolf_companion_carddef(), loc(currentPid, asidePloc)))
					})
				.seq(sacrificeSelf())
	--Level 13 -- Ab 4
	local ef13_barbarian = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("barbarian_roar")))
				.seq(randomEffect({
					valueItem(1, createCardEffect(barbarian_terrifying_roar_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(barbarian_battle_cry_carddef(), loc(currentPid, skillsPloc)))
					}))
				.seq(sacrificeSelf())
				
	--Level 15 -- Armour (9)
	local ef15_barbarian = randomEffect({
					valueItem(1, createCardEffect(barbarian_razor_bracers_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(barbarian_stomping_boots_carddef(), loc(currentPid, skillsPloc)))
					})
				.seq(sacrificeSelf())

	--Level 17 -- Lvl 11 card add
	local ef17_barbarian = randomEffect({
					valueItem(1, createCardEffect(barbarian_bone_axe_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(barbarian_crushed_coin_carddef(), loc(currentPid, asidePloc)))
					})
				.seq(sacrificeSelf())

	--Level 19 -- Skill 5
	local ef19_barbarian = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("barbarian_flaring_rage").Or(isCardName("barbarian_smoldering_rage"))))
				.seq(randomEffect({
					valueItem(1, createCardEffect(barbarian_fiery_rage_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(barbarian_explosive_rage_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(barbarian_eternal_rage_carddef(), loc(currentPid, skillsPloc)))
					}))
				.seq(sacrificeSelf())
				
	--Level 21 -- Ab 5
	local ef21_barbarian = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("barbarian_terrifying_roar").Or(isCardName("barbarian_battle_cry"))))
				.seq(randomEffect({
					valueItem(1, createCardEffect(barbarian_battle_roar_carddef(), loc(currentPid, skillsPloc))),
					 valueItem(1, createCardEffect(barbarian_terrifying_howl_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(barbarian_war_cry_carddef(), loc(currentPid, skillsPloc)))
					}))	
				.seq(sacrificeSelf())
				
	--Level 23
	local ef23_barbarian = sacrificeTarget().apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("barbarian_headbutt")))
				.seq(randomEffect({
					valueItem(1, createCardEffect(barbarian_disorienting_headbutt_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(barbarian_shattering_headbutt_carddef(), loc(currentPid, asidePloc)))
					}))

	--Last
	local efShuffle = moveTarget(deckPloc).apply(selectLoc(loc(currentPid, asidePloc)))
		.seq(shuffleEffect(currentDeckLoc))
		.seq(sacrificeSelf())

    return createDef(
        {
            id = "random_choose_barbarian",
            name = "Dual-class Barbarian",
			types = {itemType},
			cardTypeLabel = "Item",
			playLocation = castPloc,
            acquireCost = 0,
            abilities = {
                createAbility(
                    {
                        id = "random_choose_barbarian",
                        trigger = onPlayTrigger,
						playAllType = noPlayPlayType,
                        effect = sacrificeTarget().apply(selectSource())
						.seq(moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc))))
						.seq(ifElseEffect(getHeroLevel(currentPid).gte(1), ef1_barbarian, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(3), ef3_barbarian, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(5), ef5_barbarian, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(7), ef7_barbarian, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(9), ef9_barbarian, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(11), ef11_barbarian, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(13), ef13_barbarian, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(15), ef15_barbarian, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(17), ef17_barbarian, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(19), ef19_barbarian, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(21), ef21_barbarian, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(23), ef23_barbarian, nullEffect()))
.seq(efShuffle)
.seq(addEffect(endTurnEffect())),
						
                    }
                ),
            },
            layout = createLayout(
                {
                    name = "Dual-class barbarian",
                    art = "avatars/barbarian_01",
                    frame = "frames/generic_cardframe",
					cost = 0,
                    xmlText=[[
<vlayout>
<box flexibleheight="10">
<tmpro text="Replace a Gold
with Plunder.

Add Headbutt." fontsize="20"/>
</box>
<hlayout flexibleheight="1">
</hlayout>
</vlayout>
					]],

                }
            )
        }
    )
end

function random_choose_monk_carddef()

	local ef1_monk = moveTarget(asidePloc).apply(selectLoc(loc(currentPid, handPloc)).union(selectLoc(loc(currentPid, deckPloc))))
				.seq(transformTarget("monk_spring_blossom").apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("gold")).take(1)))
				.seq(transformTarget("monk_spring_blossom").apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("gold")).take(1)))
				.seq(randomEffect({
					valueItem(1, createCardEffect(monk_cobra_fang_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(monk_serene_wind_carddef(), loc(currentPid, asidePloc)))
				}))
				.seq(createCardEffect(monk_calm_carddef(), loc(currentPid, skillsPloc)))
				.seq(sacrificeSelf())
	
		--Level 3 -- Ab 2
	local ef3_monk = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("monk_calm")))
				.seq(createCardEffect(monk_focus_carddef(), loc(currentPid, skillsPloc)))
				.seq(sacrificeSelf())
	
		--Level 5 -- Skill 3
	local ef5_monk = createCardEffect(monk_flowing_technique_carddef(), loc(currentPid, skillsPloc))
				.seq(sacrificeSelf())
	
	--Level 7 -- Ab 3
	local ef7_monk = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("monk_focus")))
					.seq(createCardEffect(monk_qi_carddef(), loc(currentPid, skillsPloc)))  
	
    --Level 9 -- Skill 4
	local ef9_monk = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("monk_flowing_technique")))
				.seq(randomEffect({
					valueItem(1, createCardEffect(monk_flowing_technique_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(monk_practiced_technique_carddef(), loc(currentPid, skillsPloc)))
				}))
				
--Level 11 -- Lvl 7 card add
	local ef11_monk = randomEffect({
					valueItem(1, createCardEffect(monk_stillness_of_water_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(monk_ring_of_1000_palms_carddef(), loc(currentPid, asidePloc)))
					})
				.seq(sacrificeSelf())
	--Level 13 -- Ab 4
	local ef13_monk = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("monk_qi")))
				.seq(randomEffect({
					valueItem(1, createCardEffect(monk_jing_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(monk_focused_strike_carddef(), loc(currentPid, skillsPloc)))
					}))
				.seq(sacrificeSelf())
				
	--Level 15 -- Armour (9)
	local ef15_monk = randomEffect({
					valueItem(1, createCardEffect(monk_wraps_of_strength_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(monk_slippers_of_the_crane_carddef(), loc(currentPid, skillsPloc)))
					})
				.seq(sacrificeSelf())

	--Level 17 -- Lvl 11 card add
	local ef17_monk = createCardEffect(monk_tonfas_of_balance_carddef(), loc(currentPid, asidePloc))
				.seq(sacrificeSelf())

	--Level 19 -- Skill 5
	local ef19_monk = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("monk_flowing_technique").Or(isCardName("monk_practiced_technique"))))
				.seq(randomEffect({
					valueItem(1, createCardEffect(monk_fluid_technique_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(monk_masterful_technique_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(monk_precise_technique_carddef(), loc(currentPid, skillsPloc)))
					}))
				.seq(sacrificeSelf())
				
	--Level 21 -- Ab 5
	local ef21_monk = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("monk_jing").Or(isCardName("monk_focused_strike"))))
				.seq(randomEffect({
					valueItem(1, createCardEffect(monk_yin_yang_carddef(), loc(currentPid, skillsPloc))),
					 valueItem(1, createCardEffect(monk_qigong_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(monk_dim_mak_carddef(), loc(currentPid, skillsPloc)))
					}))	
				.seq(sacrificeSelf())
				
	--Level 23
	local ef23_monk = sacrificeTarget().apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("monk_spring_blossom")).take(1))
				.seq(randomEffect({
					valueItem(1, createCardEffect(monk_resplendent_blossom_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(monk_radiant_blossom_carddef(), loc(currentPid, asidePloc)))
					}))

	--Last
	local efShuffle = moveTarget(deckPloc).apply(selectLoc(loc(currentPid, asidePloc)))
		.seq(shuffleEffect(currentDeckLoc))
		.seq(sacrificeSelf())

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


    return createDef(
        {
            id = "random_choose_monk",
            name = "Dual-class Monk",
			types = {itemType},
			cardTypeLabel = "Item",
			playLocation = castPloc,
            acquireCost = 0,
            abilities = {
                createAbility(
                    {
                        id = "random_choose_monk",
                        trigger = onPlayTrigger,
						playAllType = noPlayPlayType,
                        effect = sacrificeTarget().apply(selectSource())
						.seq(moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc))))
						.seq(ifElseEffect(getHeroLevel(currentPid).gte(1), ef1_monk, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(3), ef3_monk, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(5), ef5_monk, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(7), ef7_monk, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(9), ef9_monk, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(11), ef11_monk, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(13), ef13_monk, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(15), ef15_monk, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(17), ef17_monk, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(19), ef19_monk, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(21), ef21_monk, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(23), ef23_monk, nullEffect()))
.seq(efShuffle)
.seq(addEffect(endTurnEffect())),
						
                    }
                ),
            },
            layout = createLayout(
                {
                    name = "Dual-class Monk",
                    art = "avatars/monk_02",
                    frame = "frames/generic_cardframe",
					cost = 0,
                    xmlText=[[
<vlayout>
<box flexibleheight="10">
<tmpro text="Replace 2 gold
with 2 Spring Blossoms.

Add either
Cobra Fang or Serene Wind." fontsize="20"/>
</box>
<hlayout flexibleheight="1">
</hlayout>
</vlayout>
					]],

                }
            )
        }
    )
end

function random_choose_necromancer_carddef()

	local ef1_necromancer = moveTarget(asidePloc).apply(selectLoc(loc(currentPid, handPloc)).union(selectLoc(loc(currentPid, deckPloc))))
				.seq(transformTarget("necromancer_soul_prism").apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("gold")).take(1)))
				.seq(createCardEffect(necromancer_rod_of_unlife_carddef(), loc(currentPid, asidePloc)))
				.seq(createCardEffect(necromancer_reanimate_carddef(), loc(currentPid, skillsPloc)))
				.seq(sacrificeSelf())
	
		--Level 3 -- Ab 2
	local ef3_necromancer = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("necromancer_reanimate")))
				.seq(createCardEffect(necromancer_final_return_carddef(), loc(currentPid, skillsPloc)))
				.seq(sacrificeSelf())
	
		--Level 5 -- Skill 3
	local ef5_necromancer = createCardEffect(necromancer_bone_raising_carddef(), loc(currentPid, skillsPloc))
				.seq(sacrificeSelf())
	
	--Level 7 -- Ab 3
	local ef7_necromancer = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("necromancer_final_return")))
					.seq(createCardEffect(necromancer_raise_dead_carddef(), loc(currentPid, skillsPloc)))  
	
    --Level 9 -- Skill 4
	local ef9_necromancer = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("necromancer_bone_raising")))
				.seq(randomEffect({
					valueItem(1, createCardEffect(necromancer_raise_skeleton_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(necromancer_fresh_harvest_carddef(), loc(currentPid, skillsPloc)))
				}))
				
--Level 11 -- Lvl 7 card add
	local ef11_necromancer = randomEffect({
					valueItem(1, createCardEffect(necromancer_puzzle_box_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(necromancer_anguish_blade_carddef(), loc(currentPid, asidePloc)))
					})
				.seq(sacrificeSelf())
	--Level 13 -- Ab 4
	local ef13_necromancer = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("necromancer_raise_dead")))
				.seq(randomEffect({
					valueItem(1, createCardEffect(necromancer_corpse_raising_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(necromancer_animate_dead_carddef(), loc(currentPid, skillsPloc)))
					}))
				.seq(sacrificeSelf())
				
	--Level 15 -- Armour (9)
	local ef15_necromancer = randomEffect({
					valueItem(1, createCardEffect(necromancer_rotting_crown_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(necromancer_plague_belt_carddef(), loc(currentPid, skillsPloc)))
					})
				.seq(sacrificeSelf())

	--Level 17 -- Lvl 11 card add
	local ef17_necromancer = randomEffect({
					valueItem(1, createCardEffect(necromancer_voidstone_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(necromancer_onyx_skull_carddef(), loc(currentPid, skillsPloc)))
					})
				.seq(sacrificeSelf())

	--Level 19 -- Skill 5
	local ef19_necromancer = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("necromancer_raise_skeleton").Or(isCardName("necromancer_fresh_harvest"))))
				.seq(randomEffect({
					valueItem(1, createCardEffect(necromancer_strong_bones_carddef(), loc(currentPid, skillsPloc))),
					 valueItem(1, createCardEffect(necromancer_skull_swarm_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(necromancer_corpse_horde_carddef(), loc(currentPid, skillsPloc)))
					}))
				.seq(sacrificeSelf())
				
	--Level 21 -- Ab 5
	local ef21_necromancer = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("necromancer_corpse_raising").Or(isCardName("necromancer_animate_dead"))))
				.seq(randomEffect({
					valueItem(1, createCardEffect(necromancer_empty_graves_carddef(), loc(currentPid, skillsPloc))),
					 valueItem(1, createCardEffect(necromancer_grave_robbery_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(necromancer_reawaken_carddef(), loc(currentPid, skillsPloc)))
					}))	
				.seq(sacrificeSelf())
				
	--Level 23
	local ef23_necromancer = sacrificeTarget().apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("necromancer_rod_of_unlife")))
				.seq(randomEffect({
					valueItem(1, createCardEffect(necromancer_rod_of_spite_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(necromancer_rod_of_reanimation_carddef(), loc(currentPid, asidePloc)))
					}))

	--Last
	local efShuffle = moveTarget(deckPloc).apply(selectLoc(loc(currentPid, asidePloc)))
		.seq(shuffleEffect(currentDeckLoc))
		.seq(sacrificeSelf())

    return createDef(
        {
            id = "random_choose_necromancer",
            name = "Dual-class Necromancer",
			types = {itemType},
			cardTypeLabel = "Item",
			playLocation = castPloc,
            acquireCost = 0,
            abilities = {
                createAbility(
                    {
                        id = "random_choose_necromancer",
                        trigger = onPlayTrigger,
						playAllType = noPlayPlayType,
                        effect = sacrificeTarget().apply(selectSource())
						.seq(moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc))))
						.seq(ifElseEffect(getHeroLevel(currentPid).gte(1), ef1_necromancer, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(3), ef3_necromancer, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(5), ef5_necromancer, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(7), ef7_necromancer, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(9), ef9_necromancer, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(11), ef11_necromancer, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(13), ef13_necromancer, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(15), ef15_necromancer, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(17), ef17_necromancer, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(19), ef19_necromancer, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(21), ef21_necromancer, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(23), ef23_necromancer, nullEffect()))
.seq(efShuffle)
.seq(addEffect(endTurnEffect())),
						
                    }
                ),
            },
            layout = createLayout(
                {
                    name = "Dual-class Necromancer",
                    art = "avatars/necromancer_01",
                    frame = "frames/generic_cardframe",
					cost = 0,
                    xmlText=[[
<vlayout>
<box flexibleheight="10">
<tmpro text="Replace a Gold
with Soul Prism.

Add Rod of Unlife." fontsize="20"/>
</box>
<hlayout flexibleheight="1">
</hlayout>
</vlayout>				]],

                }
            )
        }
    )
end

function random_choose_alchemist_carddef()

	local ef1_alchemist = moveTarget(asidePloc).apply(selectLoc(loc(currentPid, handPloc)).union(selectLoc(loc(currentPid, deckPloc))))
				.seq(transformTarget("alchemist_philosophers_stone").apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("gold")).take(1)))
				.seq(createCardEffect(alchemist_philosophers_stone_carddef(), loc(currentPid, asidePloc)))
				.seq(createCardEffect(alchemist_dissolve_carddef(), loc(currentPid, skillsPloc)))
				.seq(sacrificeSelf())
	
		--Level 3 -- Ab 2
	local ef3_alchemist = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("alchemist_dissolve")))
				.seq(createCardEffect(alchemist_minor_transmutation_carddef(), loc(currentPid, skillsPloc)))
				.seq(sacrificeSelf())
	
		--Level 5 -- Skill 3
	local ef5_alchemist = createCardEffect(alchemist_reflect_carddef(), loc(currentPid, skillsPloc))
				.seq(sacrificeSelf())
	
	--Level 7 -- Ab 3
	local ef7_alchemist = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("alchemist_minor_transmutation")))
					.seq(createCardEffect(alchemist_transmutation_carddef(), loc(currentPid, skillsPloc)))  
	
    --Level 9 -- Skill 4
	local ef9_alchemist = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("alchemist_reflect")))
				.seq(randomEffect({
					valueItem(1, createCardEffect(alchemist_refraction_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(alchemist_dispersion_carddef(), loc(currentPid, skillsPloc)))
				}))
				
--Level 11 -- Lvl 7 card add
	local ef11_alchemist = randomEffect({
					valueItem(1, createCardEffect(alchemist_crucible_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(alchemist_bottled_tempest_carddef(), loc(currentPid, asidePloc)))
					})
				.seq(sacrificeSelf())
	--Level 13 -- Ab 4
	local ef13_alchemist = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("alchemist_transmutation")))
				.seq(randomEffect({
					valueItem(1, createCardEffect(alchemist_rapid_transmogrification_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(alchemist_rapid_transmutation_carddef(), loc(currentPid, skillsPloc)))
					}))
				.seq(sacrificeSelf())
				
	--Level 15 -- Armour (9)
	local ef15_alchemist = randomEffect({
					valueItem(1, createCardEffect(alchemist_spectrum_spectacles_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(alchemist_auric_gloves_carddef(), loc(currentPid, skillsPloc)))
					})
				.seq(sacrificeSelf())

	--Level 17 -- Lvl 11 card add
	local ef17_alchemist = randomEffect({
					valueItem(1, createCardEffect(alchemist_brittle_gas_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(alchemist_alchemy_powders_carddef(), loc(currentPid, skillsPloc)))
					})
				.seq(sacrificeSelf())

	--Level 19 -- Skill 5
	local ef19_alchemist = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("alchemist_refraction").Or(isCardName("alchemist_dispersion"))))
				.seq(randomEffect({
					valueItem(1, createCardEffect(alchemist_wide_diffusion_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(alchemist_prismatic_dispersion_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(alchemist_perfect_refraction_carddef(), loc(currentPid, skillsPloc)))
					}))
				.seq(sacrificeSelf())
				
	--Level 21 -- Ab 5
	local ef21_alchemist = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("alchemist_rapid_transmogrification").Or(isCardName("alchemist_rapid_transmutation"))))
				.seq(randomEffect({
					valueItem(1, createCardEffect(alchemist_rapid_transmogrification_carddef(), loc(currentPid, skillsPloc))),
					 valueItem(1, createCardEffect(alchemist_major_transmogrification_carddef(), loc(currentPid, skillsPloc))),
					valueItem(1, createCardEffect(alchemist_instant_transmutation_carddef(), loc(currentPid, skillsPloc)))
					}))	
				.seq(sacrificeSelf())
				
	--Level 23
	local ef23_alchemist = sacrificeTarget().apply(selectLoc(loc(currentPid, asidePloc)).where(isCardName("alchemist_philosophers_stone")).take(1))
				.seq(randomEffect({
					valueItem(1, createCardEffect(alchemist_swirling_philosophers_stone_carddef(), loc(currentPid, asidePloc))),
					valueItem(1, createCardEffect(alchemist_polished_philosophers_stone_carddef(), loc(currentPid, asidePloc)))
					}))

	--Last
	local efShuffle = moveTarget(deckPloc).apply(selectLoc(loc(currentPid, asidePloc)))
		.seq(shuffleEffect(currentDeckLoc))
		.seq(ifElseEffect(getTurnsPlayed(oppPid).eq(2), drawCardsEffect(3), drawCardsEffect(5)))
		.seq(sacrificeSelf())
	--	

    return createDef(
        {
            id = "random_choose_alchemist",
            name = "Dual-class Alchemist - Random",
			types = {itemType},
			cardTypeLabel = "Item",
			playLocation = castPloc,
            acquireCost = 0,
            abilities = {
                createAbility(
                    {
                        id = "random_choose_alchemist",
                        trigger = onPlayTrigger,
						playAllType = noPlayPlayType,
                        effect = sacrificeTarget().apply(selectSource())
						.seq(moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc))))
						.seq(ifElseEffect(getHeroLevel(currentPid).gte(1), ef1_alchemist, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(3), ef3_alchemist, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(5), ef5_alchemist, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(7), ef7_alchemist, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(9), ef9_alchemist, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(11), ef11_alchemist, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(13), ef13_alchemist, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(15), ef15_alchemist, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(17), ef17_alchemist, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(19), ef19_alchemist, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(21), ef21_alchemist, nullEffect()))
.seq(ifElseEffect(getHeroLevel(currentPid).gte(23), ef23_alchemist, nullEffect()))
.seq(efShuffle)
.seq(addEffect(endTurnEffect())),
						
                    }
                ),
            },
            layout = createLayout(
                {
                    name = "Dual-class Alchemist",
                    art = "avatars/alchemist_02",
                    frame = "frames/generic_cardframe",
					cost = 0,
                    xmlText=[[
<vlayout>
<box flexibleheight="10">
<tmpro text="Replace a Gold
with Philosopher's Stone.
Add another
Philosopher's Stone.
Upgrades chosen randomly." fontsize="20"/>
</box>
<hlayout flexibleheight="1">
</hlayout>
</vlayout>					]],

                }
            )
        }
    )
end
