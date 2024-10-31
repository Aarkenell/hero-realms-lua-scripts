require "herorealms"
require "decks"
require "stdlib"
require "stdcards"
require "hardai"
require "mediumai"
require "easyai"

--[[ Updated 30.10.2024 by Aarkenell
Terramancer & Pyromancer now have unique cards generated for each player, for cards that have custom counters. This enables mirror matches with these classes.
Dynamic text added to Pyro & Terra cards with counters.
]]

-- Game start --
local function chooseStart()
    return cardChoiceSelectorEffect({
        id = "SoG_Choice",
        name = "First choice",
        trigger = startOfTurnTrigger,

        upperTitle  = "Welcome! How would you like to proceed?",
        lowerTitle  = "",
-- 1.1 choose class
 effectFirst = pushChoiceEffect(
{
choices = {
-- Choice 1: Classes by Aarkenell
			{
				effect = moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc)).union(selectLoc(loc(currentPid, deckPloc)).union(selectLoc(loc(currentPid, skillsPloc)).union(selectLoc(loc(currentPid, reservePloc))
			.union(selectLoc(loc(currentPid, buffsPloc)).where(isCardType(ogreType).Or(isCardType(orcType)).Or(isCardType(elfType).Or(isCardType(dwarfType).Or(isCardType(smallfolkType)).Or(isCardType(halfDemonType)).Or(isCardType(magicArmorType)).Or(isCardName("smallfolk_hide_buff"))))))))))
			.seq(gainCombatEffect(-1))
			.seq(setPlayerNameEffect("Unknown", currentPid))
			.seq(setPlayerAvatarEffect("assassin", currentPid))
			.seq(gainMaxHealthEffect(currentPid, const(50).add(getPlayerMaxHealth(currentPid).negate())))
			.seq(gainHealthEffect(50))
					.seq(createCardEffect(choose_lich_carddef(), loc(currentPid, asidePloc)))
					.seq(createCardEffect(choose_brewmaster_carddef(), loc(currentPid, asidePloc)))
					.seq(createCardEffect(choose_thandarlorian_carddef(), loc(currentPid, asidePloc)))
					.seq(createCardEffect(choose_terramancer_carddef(), loc(currentPid, asidePloc)))
					.seq(createCardEffect(choose_pyromancer_carddef(), loc(currentPid, asidePloc)))
					.seq(createCardEffect(choose_cryomancer_carddef(), loc(currentPid, asidePloc)))
					.seq(createCardEffect(choose_apothecary_carddef(), loc(currentPid, asidePloc)))
					.seq(createCardEffect(choose_demonologist_carddef(), loc(currentPid, asidePloc)))
	
					.seq(moveTarget(handPloc).apply(selectLoc(loc(currentPid, asidePloc))))
					.seq(waitForClickEffect("Please play the card corresponding to the class you wish to play.", "")),

				layout = createLayout({
					name = "Classes by Aarkenell",
					art = "art/epicart/the_people_s_champion",
					xmlText=[[<vlayout>
					<hlayout flexiblewidth="1">
					<text text="Choose 1 of 8
					level 3 Custom Characters to play." fontsize="26"/>
					</hlayout>
					</vlayout>
					]]
									}),
				
				tags = {}
			},

-- Choice 2: Class by other Designers
{
				effect = moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc)).union(selectLoc(loc(currentPid, deckPloc)).union(selectLoc(loc(currentPid, skillsPloc)).union(selectLoc(loc(currentPid, reservePloc))
			.union(selectLoc(loc(currentPid, buffsPloc)).where(isCardType(ogreType).Or(isCardType(orcType)).Or(isCardType(elfType).Or(isCardType(dwarfType).Or(isCardType(smallfolkType)).Or(isCardType(halfDemonType)).Or(isCardType(magicArmorType)).Or(isCardName("smallfolk_hide_buff"))))))))))
			.seq(gainCombatEffect(-1))
			.seq(setPlayerNameEffect("Unknown", currentPid))
			.seq(setPlayerAvatarEffect("assassin", currentPid))
			.seq(gainMaxHealthEffect(currentPid, const(50).add(getPlayerMaxHealth(currentPid).negate())))
			.seq(gainHealthEffect(50))
					.seq(createCardEffect(choose_S_and_R_carddef(), loc(currentPid, asidePloc)))
					.seq(createCardEffect(choose_paladin_carddef(), loc(currentPid, asidePloc)))
					.seq(createCardEffect(choose_witch_carddef(), loc(currentPid, asidePloc)))
					.seq(createCardEffect(choose_shaman_carddef(), loc(currentPid, asidePloc)))
					.seq(createCardEffect(choose_king_midas_carddef(), loc(currentPid, asidePloc)))
	
					.seq(moveTarget(handPloc).apply(selectLoc(loc(currentPid, asidePloc))))
					.seq(waitForClickEffect("Please play the card corresponding to the class you wish to play.", "")),

				layout = createLayout({
					name = "Classes by Other Designers",
					art = "art/epicart/insurgency",
					xmlText=[[<vlayout>
					<hlayout flexiblewidth="1">
					<text text="Choose 1 of 5
					level 3 Custom Characters to play." fontsize="26"/>
					</hlayout>
					</vlayout>
					]]
									}) ,
				
				tags = {}
			},
			
-- Choice 3: Random										
{
                                           effect = moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc)).union(selectLoc(loc(currentPid, deckPloc)).union(selectLoc(loc(currentPid, skillsPloc)).union(selectLoc(loc(currentPid, reservePloc))
			.union(selectLoc(loc(currentPid, buffsPloc)).where(isCardType(ogreType).Or(isCardType(orcType)).Or(isCardType(elfType).Or(isCardType(dwarfType).Or(isCardType(smallfolkType)).Or(isCardType(halfDemonType)).Or(isCardType(magicArmorType)).Or(isCardName("smallfolk_hide_buff"))))))))))
													   .seq(sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc))))
			.seq(moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc)))) 
			.seq(randomEffect({
					valueItem(1, createCardEffect(choose_demonologist_carddef(), currentHandLoc)),
					valueItem(1, createCardEffect(choose_apothecary_carddef(), currentHandLoc)),
					valueItem(1, createCardEffect(choose_cryomancer_carddef(), currentHandLoc)),
					valueItem(1, createCardEffect(choose_pyromancer_carddef(), currentHandLoc)),
					valueItem(1, createCardEffect(choose_terramancer_carddef(), currentHandLoc)),
					valueItem(1, createCardEffect(choose_thandarlorian_carddef(), currentHandLoc)),
					valueItem(1, createCardEffect(choose_brewmaster_carddef(), currentHandLoc)),
					valueItem(1, createCardEffect(choose_paladin_carddef(), currentHandLoc)),
					valueItem(1, createCardEffect(choose_shaman_carddef(), currentHandLoc)),
					valueItem(1, createCardEffect(choose_king_midas_carddef(), currentHandLoc)),
					valueItem(1, createCardEffect(choose_witch_carddef(), currentHandLoc)),
					valueItem(1, createCardEffect(choose_S_and_R_carddef(), currentHandLoc)),
					valueItem(1, createCardEffect(choose_lich_carddef(), currentHandLoc))
				}))
			.seq(sacrificeTarget().apply(selectSource()))
			.seq(noUndoEffect()),
        
            layout = createLayout({
            name = "Random Class",
            art = "art/T_Confused_Apparition",
			xmlText=[[
<vlayout>
    <box flexibleheight="18">
        <tmpro text="Randomly choose a Custom Class.
&lt;size=65%&gt;(You cannot undo this choice.)" fontsize="26"/>
    </box>
<divider/>
    <box flexibleheight="8">
        <tmpro text="
Real Heroes dance with fate." fontsize="20" fontstyle="italic"/>
    </box>
</vlayout>
			]]
			}),
                                            tags = {}
                                        },	

-- Choice 4- choose standard
										{
                                           effect = pushChoiceEffectWithTitle(
                                {
                                    choices = {                                
										{
                                           effect = moveTarget(tradeDeckLoc).apply(selectLoc(centerRowLoc))
													.seq(shuffleTradeDeckEffect())
													.seq(refillMarketEffect(const(0)).seq(refillMarketEffect(const(1))).seq(refillMarketEffect(const(2))).seq(refillMarketEffect(const(3))).seq(refillMarketEffect(const(4))))
													.seq(addEffect(endTurnEffect())),
                                            layout = createLayout(
                {
                    name = "Yes",
                    art = "art/treasures/T_cleric_elixir_green",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
   <hlayout flexibleheight="3">
 <tmpro text="Accept choice.
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
                    art = "art/treasures/T_cleric_elixir_blue_purple",
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
					upperTitle = "Confirm your choice. Do you want to use your standard Hero?",
					lowerTitle = ""
					}),
					condition = getHeroLevel(currentPid).lte(4),
                                            layout = createLayout({
            name = "Selected class",
            art = "art/T_Storm_Siregar",
            xmlText=[[
			<vlayout>
<hlayout flexiblewidth="1">
<text text="Play as the character you selected when setting up the game." fontsize="26"/>
</hlayout>
</vlayout>
			]] }),
                                            tags = {}
                                        }										
}
}
),
-- 1.2 choice - learn about the mod		
		effectSecond = pushChoiceEffectWithTitle(
                                {
								
                                    choices = {  
								-- 1.2a choice - Updates to this mod					
										{
                                           effect = nullEffect(),
        
            layout = createLayout({
            name = "Updates to this mod",
            art = "art/T_fighter_sharpening_stone",
            xmlText=[[
<vlayout>
<hlayout flexiblewidth="1">
<text text="
30.10.24 - Lich class added
20.09.24 - Cryomancer Ability change
20.09.24 - Terramancer mirror fix
   Dynamic text on Pyro skill, Pyro
   ability and Terra skill shows current
   value of ability.
06.09.24 - Standard Heroes only
   playable at level 1-4.

   Art updates
" alignment="left" fontsize="16"/>
</hlayout>
</vlayout>			
			]]				
			
			}),
                                            tags = {}
                                        },
								-- 1.2b choice - Other mods to try
										{
                                           effect = nullEffect(),
                                            layout = createLayout({
            name = "Other mods to try",
            art = "art/treasures/T_spyglass",
            xmlText=[[
<vlayout>
<hlayout flexiblewidth="1">
<text text="New mods by community members:
&lt;size=100%&gt;Dual-class &lt;size=70%&gt;- by Aarkenell
&lt;size=100%&gt;Splintered Thandar &lt;size=70%&gt;- by Aarkenell
&lt;size=100%&gt;Industrialisation &lt;size=70%&gt;- by Userkaffe
&lt;size=100%&gt;Mythic Mercenaries &lt;size=70%&gt;- by Aarkenell
&lt;size=100%&gt;Sudden Death &lt;size=70%&gt;- by WardenSlayer


&lt;size=90%&gt;Look out for these games in the custom lobby, or join the RealmsRising Discord to request custom challenges." fontsize="16"/>
</hlayout>
</vlayout>
			]] }),
                                            tags = {}
                                        },
										  		
								-- 1.2c choice - Community news
										{
                                           effect = storyTellEffectWithPortrait("ogre_fighter_male_02", "Hi! I’m Rob d’Ogrety, CEO of ‘Why’s Wizard Games?’")
				 .seq(leftStoryTellEffectWithPortrait("inquisition", "And I’m Dwarfin Kastle – creator of the award-winning deckbuilding game about growing trees in space – Star Elms."))
				 .seq(storyTellEffectWithPortrait("ogre_fighter_male_02", "We just wanted to take a moment to say how much we love the community that has sprung up around Hero Realms…"))
				 .seq(leftStoryTellEffectWithPortrait("dwarf_fighter_male_02", "We love you!"))
				 .seq(storyTellEffectWithPortrait("ogre_fighter_male_02", " …and how much we love the experiments and new ideas being offered through custom lua scripting."))
				 .seq(leftStoryTellEffectWithPortrait("dwarf_fighter_male_02", "Yeah! We love lua!"))
				 .seq(leftStoryTellEffectWithPortrait("dwarf_fighter_male_02", "Lua, Lua! Oh baby! We gotta code! Aye-yi-yi-yi!"))
				 .seq(storyTellEffectWithPortrait("ogre_fighter_male_02", "<cough> Thanks DK."))
				 .seq(storyTellEffectWithPortrait("ogre_fighter_male_02", "Be sure to join the Realms Rising server on Discord to share your feedback on this mod and to discover new custom games to play."))
				 .seq(storyTellEffectWithPortrait("ogre_fighter_male_0", "And listen to the Sparks and Recreation podcast for information on Community events, meta-analysis, and everything Hero Realms."))
				 .seq(storyTellEffectWithPortrait("ogre_fighter_male_02", "Or jump over to RealmsRising.com for in-depth articles on strategy and gameplay."))
				 .seq(storyTellEffectWithPortrait("origins_flawless_track", "And if you have ideas for new custom classes or scenarios you’d like to see, drop me, Aarkenell, a message in the Realms Rising Discord."))
				 .seq(storyTellEffectWithPortrait("ogre_fighter_male_02", "Whether you join the Realms Rising community or not, we hope you keep enjoying the game and all the custom content from our great community."))
				 .seq(storyTellEffectWithPortrait("ogre_fighter_male_02", "Bye for now."))
				 .seq(leftStoryTellEffectWithPortrait("dwarf_fighter_male_02", "Lua, Lua! Oh baby! We gotta go. Bye-yi-yi-yi!"))
				 .seq(storyTellEffectWithPortrait("origins_flawless_track", "Please hit 'Undo' to return to the menu."))
				 ,
                                            layout = createLayout({
            name = "Community News",
            art = "art/T_borg_ogre_mercenary",
            xmlText=[[
			<vlayout>
<hlayout flexiblewidth="1">
<text text="A word from our sponsors" fontsize="26"/>
</hlayout>
</vlayout>
			]] }),
                                            tags = {}
                                        }
                                    
                                    },
					
        upperTitle  = "What do you want to learn about?",
        lowerTitle  = "Be sure to hit 'Undo' after your selection, to return to the selection menu.",

					}),

-- 1.1 layout - choose class
        layoutFirst = createLayout({
            name = "To Battle!",
            art = "art/T_Unify_Apsara",
            xmlText=[[<vlayout>
<hlayout flexiblewidth="1">
<text text="Choose your class and start the game." fontsize="26"/>
</hlayout>
</vlayout>
			
			]]
			}),

-- 1.2 layout - learn about the mod
        layoutSecond = createLayout({
            name = "Updates & Info",
            art = "art/treasures/T_Magic_Scroll_Souveraine",
            xmlText=[[
			<vlayout>
<hlayout flexiblewidth="1">
<text text="Learn about:
Updates to this mod
&lt;size=65%&gt;(Last updated 24.09.2024)
&lt;size=100%&gt;Other mods to try
Community news"
fontsize="26"/>
</hlayout>
</vlayout>
			]] }) ,

        turn = 1
    })
end


-- Custom Class Selection cards
function choose_lich_carddef()

	local ef_Corruption = createCardEffect(lich_corruption_carddef(), loc(currentPid, skillsPloc))
				.seq(sacrificeSelf())

	local corruption20buff = createGlobalBuff({
        id="corruption20buff",
        name = "Corruption",
        abilities = {
            createAbility({
                id= "corruption20buff",
				trigger = deckShuffledTrigger,
                effect = ifElseEffect(selectLoc(loc(currentPid, handPloc)).union(selectLoc(loc(currentPid, inPlayPloc))).union(selectLoc(loc(currentPid, deckPloc))).where(isCardType(minionType).invert()).count().gte(20), ef_Corruption, nullEffect()),
            }),
        },
		buffDetails = createBuffDetails({
					name = "Corruption",
                    art = "art/T_charing_guardian",
					text = "<size=70%>When you shuffle your deck, if you have 20 or more cards in your deck, hand and in play (not including minions), gain the Corruption skill."
							})
    })


	local Grimoirebuff = createGlobalBuff({
        id="Grimoirebuff",
        name = "Grimoire",
        abilities = {
            createAbility({
                id= "Grimoirebuff",
				trigger = startOfTurnTrigger,
                effect = nullEffect(),
				}),
        },
		buffDetails = createBuffDetails({
					name = "Grimoire",
                    art = "art/T_rayla_endweaver",
					text = "<size=60%>You start with 10 cards (8 unique minions) in your Grimoire. Whenever you perform a Summoning, randomly take one card from your Grimoire and put it into play. When a minion is stunned it returns to your Grimoire."
							})
    })

	local souljarbuff = createGlobalBuff({
        id="souljarbuff",
        name = "Soul Jar",
        abilities = {
            createAbility({
                id= "souljarbuff",
				trigger = startOfTurnTrigger,
                effect = nullEffect(),
				}),
        },
		buffDetails = createBuffDetails({
					name = "Soul Jar",
                    art = "art/treasures/t_wizard_elixir_blue",
					text = "<size=80%>Each game 1 of 6 Soul Jars are randomly chosen to determine the Lich's Health and Skill."
							})
    })
	

	--[[local ef_Control = transformTarget("control_skill").apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("corruption_skill")).take(1))
				.seq(sacrificeSelf())

	local control30buff = createGlobalBuff({
        id="control30buff",
        name = "Control",
        abilities = {
            createAbility({
                id= "control30buff",
				trigger = deckShuffledTrigger,
                effect = ifElseEffect(selectLoc(loc(currentPid, handPloc)).union(selectLoc(loc(currentPid, inPlayPloc))).union(selectLoc(loc(currentPid, deckPloc))).where(isCardType(minionType).invert()).count().gte(30), ef_Control, nullEffect()),
            }),
        },
		buffDetails = createBuffDetails({
					name = "Control",
                    art = "art/T_charing_guardian",
					text = "<size=70%>When you shuffle your deck, if you have 30 or more cards in your deck, hand and in play (not including minions), replace Corruption skill with the Control skill."
							})
							 })
]]
    return createDef({
        id="choose_lich",
        name="Choose the Lich",
        types={noStealType, itemType},
		cardTypeLabel = "Item",
		playLocation = castPloc,
        acquireCost=0,
        abilities = {
            createAbility({
                id="choose_lich",
                trigger= onPlayTrigger,
				playAllType = noPlayPlayType,
                effect = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)))
			.seq(moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc))))
			.seq(setPlayerNameEffect("Lich", currentPid))
			.seq(setPlayerAvatarEffect("WarInTheWild/krythos_master_vampire", currentPid))
			--buffs
			.seq(createCardEffect(corruption20buff, loc(currentPid, buffsPloc)))
			.seq(createCardEffect(Grimoirebuff, loc(currentPid, buffsPloc)))
			.seq(createCardEffect(souljarbuff, loc(currentPid, buffsPloc)))
			--.seq(createCardEffect(control30buff, loc(currentPid, buffsPloc)))
			
			--soul jar skill
			.seq(randomEffect({
					valueItem(1, createCardEffect(lich_SJ_DI_carddef(), loc(currentPid, skillsPloc)).seq(gainMaxHealthEffect(currentPid, const(35).add(getPlayerMaxHealth(currentPid).negate()))).seq(gainHealthEffect(35))),
					valueItem(1, createCardEffect(lich_SJ_HoE_carddef(), loc(currentPid, skillsPloc)).seq(gainMaxHealthEffect(currentPid, const(30).add(getPlayerMaxHealth(currentPid).negate()))).seq(gainHealthEffect(30))),
					valueItem(1, createCardEffect(lich_SJ_UR_carddef(), loc(currentPid, skillsPloc)).seq(gainMaxHealthEffect(currentPid, const(55).add(getPlayerMaxHealth(currentPid).negate()))).seq(gainHealthEffect(55))),
					valueItem(1, createCardEffect(lich_SJ_M_carddef(), loc(currentPid, skillsPloc)).seq(gainMaxHealthEffect(currentPid, const(45).add(getPlayerMaxHealth(currentPid).negate()))).seq(gainHealthEffect(45))),
					valueItem(1, createCardEffect(lich_SJ_V_carddef(), loc(currentPid, skillsPloc)).seq(gainMaxHealthEffect(currentPid, const(50).add(getPlayerMaxHealth(currentPid).negate()))).seq(gainHealthEffect(50))),
					valueItem(1, createCardEffect(lich_SJ_IW_carddef(), loc(currentPid, skillsPloc)).seq(gainMaxHealthEffect(currentPid, const(40).add(getPlayerMaxHealth(currentPid).negate()))).seq(gainHealthEffect(40))),
					}))

			--deck
			.seq(createCardEffect(lich_soul_diamond_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(lich_soul_diamond_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(ruby_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(ruby_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(lich_frozen_touch_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(lich_soul_crush_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(lich_minor_summoning_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(lich_major_summoning_carddef(), loc(currentPid, asidePloc)))
			.seq(moveTarget(deckPloc).apply(selectLoc(loc(currentPid, asidePloc))))
			--grimoire minions
				.seq(createCardEffect(lich_abomination_minion_carddef(), loc(nil, nullPloc)))
				.seq(createCardEffect(lich_banshee_minion_carddef(), loc(nil, nullPloc)))
				.seq(createCardEffect(lich_ghoul_minion_carddef(), loc(nil, nullPloc)))
				.seq(createCardEffect(lich_revenant_minion_carddef(), loc(nil, nullPloc)))
				.seq(createCardEffect(lich_skeleton_horde_minion_carddef(), loc(nil, nullPloc)))
				.seq(createCardEffect(lich_skeleton_horde_minion_carddef(), loc(nil, nullPloc)))
				.seq(createCardEffect(lich_skeleton_horde_minion_carddef(), loc(nil, nullPloc)))
				.seq(createCardEffect(lich_wall_of_bones_minion_carddef(), loc(nil, nullPloc)))
				.seq(createCardEffect(lich_wall_of_fire_minion_carddef(), loc(nil, nullPloc)))
				.seq(createCardEffect(lich_zombie_minion_carddef(), loc(nil, nullPloc)))
			--setup
			.seq(shuffleEffect(currentDeckLoc))
			.seq(sacrificeTarget().apply(selectSource()))
			.seq(pushChoiceEffectWithTitle(
                                {
                                    choices = {                                
										{
                                           effect = moveTarget(tradeDeckLoc).apply(selectLoc(centerRowLoc))
													.seq(shuffleTradeDeckEffect())
													.seq(refillMarketEffect(const(0)).seq(refillMarketEffect(const(1))).seq(refillMarketEffect(const(2))).seq(refillMarketEffect(const(3))).seq(refillMarketEffect(const(4))))
													.seq(addEffect(endTurnEffect())),
                                            layout = createLayout(
                {
                    name = "Yes",
                    art = "art/treasures/T_cleric_elixir_green",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
   <hlayout flexibleheight="3">
 <tmpro text="Accept choice.
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
                    art = "art/treasures/T_cleric_elixir_blue_purple",
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
					upperTitle = "Confirm your choice. Do you want to use the lich?",
					lowerTitle = ""
					}))
            })
        },
        layout = createLayout({
            name = "Lich",
            art = "art/T_charing_guardian",
			frame = "frames/Coop_Campaign_CardFrame",
            xmlText=[[
			<vlayout>
<box flexibleheight="2">
<tmpro text="Play as the Lich" fontsize="26"/>
</box>
<box flexibleheight="2">
<tmpro text="
- by Aarkenell -" fontsize="22" fontstyle="italic"/>
</box>

<box flexibleheight="2">
<tmpro text="- Adapted from WWG's Lich Boss Deck -
- Added 30.10.2024-" fontsize="14" fontstyle="italic"/>
</box>
</vlayout>

			]]
			}),
        })
end

function choose_demonologist_carddef()
    return createDef({
        id="choose_demonologist",
        name="Choose the Demonologist",
        types={noStealType, itemType},
		cardTypeLabel = "Item",
		playLocation = castPloc,
        acquireCost=0,
        abilities = {
            createAbility({
                id="choose_demonologist",
                trigger= onPlayTrigger,
				playAllType = noPlayPlayType,
                effect = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)))
			.seq(moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc)))) --here--
			.seq(setPlayerNameEffect("Demonologist", currentPid))
			.seq(setPlayerAvatarEffect("ruinos_zealot", currentPid))
			.seq(gainMaxHealthEffect(currentPid, const(50).add(getPlayerMaxHealth(currentPid).negate())))
			.seq(gainHealthEffect(50))
			.seq(createCardEffect(demonologist_summon_demon_carddef(), currentSkillsLoc))
			.seq(createCardEffect(demonologist_summon_demon_master_carddef(), currentSkillsLoc))
			.seq(createCardEffect(gold_carddef(), loc(currentPid, asidePloc))) --here--
			.seq(createCardEffect(gold_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(demonologist_shadow_feeder_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(demonologist_void_guard_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(demonologist_lesser_devourer_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(demonologist_shadow_gem_carddef(), loc(currentPid, asidePloc)))
			.seq(moveTarget(deckPloc).apply(selectLoc(loc(currentPid, asidePloc))))
			.seq(shuffleEffect(currentDeckLoc))
			.seq(sacrificeTarget().apply(selectSource()))
			.seq(pushChoiceEffectWithTitle(
                                {
                                    choices = {                                
										{
                                           effect = moveTarget(tradeDeckLoc).apply(selectLoc(centerRowLoc))
													.seq(shuffleTradeDeckEffect())
													.seq(refillMarketEffect(const(0)).seq(refillMarketEffect(const(1))).seq(refillMarketEffect(const(2))).seq(refillMarketEffect(const(3))).seq(refillMarketEffect(const(4))))
													.seq(addEffect(endTurnEffect())),
                                            layout = createLayout(
                {
                    name = "Yes",
                    art = "art/treasures/T_cleric_elixir_green",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
   <hlayout flexibleheight="3">
 <tmpro text="Accept choice.
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
                    art = "art/treasures/T_cleric_elixir_blue_purple",
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
					upperTitle = "Confirm your choice. Do you want to use the Demonologist?",
					lowerTitle = ""
					}))
            })
        },
        layout = createLayout({
            name = "Demonologist",
            art = "art/epicart/dirge_of_scara",
			frame = "frames/Coop_Campaign_CardFrame",
            xmlText=[[
			<vlayout>
    <box flexibleheight="2">
        <tmpro text="Play as a level 3
Demonologist" fontsize="26"/>
    </box>
    <box flexibleheight="1">
        <tmpro text="
- Class by Aarkenell -" fontsize="22" fontstyle="italic"/>
    </box>

<box flexibleheight="1">
        <tmpro text="- Updated 01.09.2024-" fontsize="14" fontstyle="italic"/>
    </box>
</vlayout>

			]]
			}),
        })
	end

function choose_apothecary_carddef()
    return createDef({
        id="choose_apothecary",
        name="Choose the Apothecary",
        types={noStealType, itemType},
		cardTypeLabel = "Item",
		playLocation = castPloc,
        acquireCost=0,
        abilities = {
            createAbility({
                id="choose_apothecary",
                trigger= onPlayTrigger,
				playAllType = noPlayPlayType,
                effect = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)))
			.seq(moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc)))) 
			.seq(setPlayerNameEffect("Apothecary", currentPid))
			.seq(setPlayerAvatarEffect("alchemist_01", currentPid))
			.seq(gainMaxHealthEffect(currentPid, const(52).add(getPlayerMaxHealth(currentPid).negate())))
			.seq(gainHealthEffect(52))
			.seq(createCardEffect(apothecary_restorative_draught_carddef(), currentSkillsLoc))
			.seq(createCardEffect(apothecary_custom_brew_carddef(), currentSkillsLoc))
			.seq(createCardEffect(gold_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(apothecary_mezzaluna_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(apothecary_apprentice_potion_maker_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(apothecary_yellow_potion_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(apothecary_red_potion_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(apothecary_green_potion_carddef(), loc(currentPid, asidePloc)))
			.seq(moveTarget(deckPloc).apply(selectLoc(loc(currentPid, asidePloc))))
			.seq(shuffleEffect(currentDeckLoc))
			.seq(sacrificeTarget().apply(selectSource()))
			.seq(moveTarget(deckPloc).apply(selectLoc(loc(currentPid, asidePloc))))
			.seq(shuffleEffect(currentDeckLoc))
			.seq(sacrificeTarget().apply(selectSource()))
			.seq(pushChoiceEffectWithTitle(
                                {
                                    choices = {                                
										{
                                           effect = moveTarget(tradeDeckLoc).apply(selectLoc(centerRowLoc))
													.seq(shuffleTradeDeckEffect())
													.seq(refillMarketEffect(const(0)).seq(refillMarketEffect(const(1))).seq(refillMarketEffect(const(2))).seq(refillMarketEffect(const(3))).seq(refillMarketEffect(const(4))))
													.seq(addEffect(endTurnEffect())),
                                            layout = createLayout(
                {
                    name = "Yes",
                    art = "art/treasures/T_cleric_elixir_green",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
   <hlayout flexibleheight="3">
 <tmpro text="Accept choice.
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
                    art = "art/treasures/T_cleric_elixir_blue_purple",
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
					upperTitle = "Confirm your choice. Do you want to use the Apothecary?",
					lowerTitle = ""
					}))
            })
        },
        layout = createLayout({
            name = "Apothecary",
            art = "art/treasures/T_Green_Potions_Medium",
			frame = "frames/Coop_Campaign_CardFrame",
            xmlText=[[
<vlayout>
    <box flexibleheight="2">
        <tmpro text="Play as a level 3 Apothecary" fontsize="26"/>
    </box>
    <box flexibleheight="1">
        <tmpro text="- Class by Aarkenell -" fontsize="22" fontstyle="italic"/>
    </box>
</vlayout>
			]]
			}),
        })
	end

function choose_cryomancer_carddef()
    return createDef({
        id="choose_cryomancer",
        name="Choose the Cryomancer",
        types={noStealType, itemType},
		cardTypeLabel = "Item",
		playLocation = castPloc,
        acquireCost=0,
        abilities = {
            createAbility({
                id="choose_cryomancer",
                trigger= onPlayTrigger,
				playAllType = noPlayPlayType,
                effect = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)))
			.seq(moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc)))) 
			.seq(setPlayerNameEffect("Cryomancer", currentPid))
			.seq(setPlayerAvatarEffect("rayla__endweaver_flipped", currentPid))
			.seq(gainMaxHealthEffect(currentPid, const(52).add(getPlayerMaxHealth(currentPid).negate())))
			.seq(gainHealthEffect(52))
			.seq(createCardEffect(cryomancer_frostbiteskill_carddef(), currentSkillsLoc))
			.seq(createCardEffect(cryomancer_freezing_fog_carddef(), currentSkillsLoc))
			.seq(createCardEffect(gold_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(cryomancer_ice_burst_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(cryomancer_ice_shield_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(cryomancer_ice_gem_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(cryomancer_freeze_carddef(), loc(currentPid, asidePloc)))
			.seq(moveTarget(deckPloc).apply(selectLoc(loc(currentPid, asidePloc))))
			.seq(shuffleEffect(currentDeckLoc))
			.seq(sacrificeTarget().apply(selectSource()))
			.seq(moveTarget(deckPloc).apply(selectLoc(loc(currentPid, asidePloc))))
			.seq(shuffleEffect(currentDeckLoc))
			.seq(sacrificeTarget().apply(selectSource()))
			.seq(pushChoiceEffectWithTitle(
                                {
                                    choices = {                                
										{
                                           effect = moveTarget(tradeDeckLoc).apply(selectLoc(centerRowLoc))
													.seq(shuffleTradeDeckEffect())
													.seq(refillMarketEffect(const(0)).seq(refillMarketEffect(const(1))).seq(refillMarketEffect(const(2))).seq(refillMarketEffect(const(3))).seq(refillMarketEffect(const(4))))
													.seq(addEffect(endTurnEffect())),
                                            layout = createLayout(
                {
                    name = "Yes",
                    art = "art/treasures/T_cleric_elixir_green",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
   <hlayout flexibleheight="3">
 <tmpro text="Accept choice.
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
                    art = "art/treasures/T_cleric_elixir_blue_purple",
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
					upperTitle = "Confirm your choice. Do you want to use the Cryomancer?",
					lowerTitle = ""
					}))
            })
        },
        layout = createLayout({
            name = "Cryomancer",
            art = "art/T_Heavy_Gust",
			frame = "frames/Coop_Campaign_CardFrame",
            xmlText=[[
<vlayout>
    <box flexibleheight="2">
        <tmpro text="Play as a level 3
Cryomancer" fontsize="26"/>
    </box>
    <box flexibleheight="1">
        <tmpro text="
- Class by Aarkenell -" fontsize="22" fontstyle="italic"/>
    </box>

<box flexibleheight="1">
        <tmpro text="- Updated 20.09.2024-" fontsize="14" fontstyle="italic"/>
    </box>
</vlayout>
			]]
			}),
        })
	end

function choose_pyromancer_carddef()
    return createDef({
        id="choose_pyromancer",
        name="Choose the Pryomancer",
        types={noStealType, itemType},
		cardTypeLabel = "Item",
		playLocation = castPloc,
        acquireCost=0,
        abilities = {
            createAbility({
                id="choose_pyromancer",
                trigger= onPlayTrigger,
				playAllType = noPlayPlayType,
                effect = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)))
			.seq(moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc)))) 
			.seq(setPlayerNameEffect("Pyromancer", currentPid))
			.seq(setPlayerAvatarEffect("summoner", currentPid))
			.seq(gainMaxHealthEffect(currentPid, const(48).add(getPlayerMaxHealth(currentPid).negate())))
			.seq(gainHealthEffect(48))
			.seq(ifElseEffect(getTurnsPlayed(oppPid).eq(1), createCardEffect(pyromancer_1p_fuel_1carddef(), currentSkillsLoc), createCardEffect(pyromancer_2p_fuel_1carddef(), currentSkillsLoc)))
			.seq(ifElseEffect(getTurnsPlayed(oppPid).eq(1), createCardEffect(pyromancer_conflagration_1p_carddef(), currentSkillsLoc), createCardEffect(pyromancer_conflagration_2p_carddef(), currentSkillsLoc)))
			.seq(ifElseEffect(getTurnsPlayed(oppPid).eq(1), incrementCounterEffect("fuel_1p", 1), incrementCounterEffect("fuel_2p", 1)))
			.seq(ifElseEffect(getTurnsPlayed(oppPid).eq(1), incrementCounterEffect("conflagration_1p", 5), incrementCounterEffect("conflagration_2p", 5)))
			.seq(createCardEffect(gold_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(ruby_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(pyromancer_sear_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(pyromancer_scorch_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(pyromancer_fire_shard_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(pyromancer_combust_carddef(), loc(currentPid, asidePloc)))
			.seq(moveTarget(deckPloc).apply(selectLoc(loc(currentPid, asidePloc))))
			.seq(shuffleEffect(currentDeckLoc))
			.seq(sacrificeTarget().apply(selectSource()))
			.seq(moveTarget(deckPloc).apply(selectLoc(loc(currentPid, asidePloc))))
			.seq(shuffleEffect(currentDeckLoc))
			.seq(sacrificeTarget().apply(selectSource()))
			.seq(pushChoiceEffectWithTitle(
                                {
                                    choices = {                                
										{
                                           effect = moveTarget(tradeDeckLoc).apply(selectLoc(centerRowLoc))
													.seq(shuffleTradeDeckEffect())
													.seq(refillMarketEffect(const(0)).seq(refillMarketEffect(const(1))).seq(refillMarketEffect(const(2))).seq(refillMarketEffect(const(3))).seq(refillMarketEffect(const(4))))
													.seq(addEffect(endTurnEffect())),
                                            layout = createLayout(
                {
                    name = "Yes",
                    art = "art/treasures/T_cleric_elixir_green",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
   <hlayout flexibleheight="3">
 <tmpro text="Accept choice.
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
                    art = "art/treasures/T_cleric_elixir_blue_purple",
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
					upperTitle = "Confirm your choice. Do you want to use the Pyromancer?",
					}))
            })
        },
        layout = createLayout({
            name = "Pyromancer",
            art = "art/T_Blistering_Blaze",
			frame = "frames/Coop_Campaign_CardFrame",
            xmlText=[[
<vlayout>
    <box flexibleheight="2">
        <tmpro text="Play as a level 3
Pyromancer" fontsize="26"/>
    </box>
    <box flexibleheight="1">
        <tmpro text="
- Class by Aarkenell -" fontsize="22" fontstyle="italic"/>
    </box>

<box flexibleheight="1">
        <tmpro text="- Updated 20.09.2024-" fontsize="14" fontstyle="italic"/>
    </box>
</vlayout>
			]]
			}),
        })
	end

function choose_terramancer_carddef()
    return createDef({
        id="choose_terramancer",
        name="Choose the Terramancer",
        types={noStealType, itemType},
		cardTypeLabel = "Item",
		playLocation = castPloc,
        acquireCost=0,
        abilities = {
            createAbility({
                id="choose_terramancer",
                trigger= onPlayTrigger,
				playAllType = noPlayPlayType,
                effect = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)))
			.seq(moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc)))) 
			.seq(setPlayerNameEffect("Terramancer", currentPid))
			.seq(setPlayerAvatarEffect("broelyn", currentPid))
			.seq(gainMaxHealthEffect(currentPid, const(53).add(getPlayerMaxHealth(currentPid).negate())))
			.seq(gainHealthEffect(53))
			.seq(ifElseEffect(getTurnsPlayed(oppPid).eq(1), createCardEffect(terramancer_move_earth1_carddef(), currentSkillsLoc), createCardEffect(terramancer_move_earth2_carddef(), currentSkillsLoc)))
			.seq(createCardEffect(terramancer_swallowed_by_the_earth_def(), currentSkillsLoc))
			.seq(createCardEffect(gold_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(ruby_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(ruby_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(terramancer_earth_gem_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(terramancer_hurl_boulder_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(terramancer_tremor_carddef(), loc(currentPid, asidePloc)))
			.seq(ifElseEffect(getTurnsPlayed(oppPid).eq(1), createCardEffect(terramancer_clay_golem1_carddef(), loc(currentPid, asidePloc)), createCardEffect(terramancer_clay_golem2_carddef(), loc(currentPid, asidePloc))))
			.seq(moveTarget(deckPloc).apply(selectLoc(loc(currentPid, asidePloc))))
			.seq(shuffleEffect(currentDeckLoc))
			.seq(sacrificeTarget().apply(selectSource()))
			.seq(moveTarget(deckPloc).apply(selectLoc(loc(currentPid, asidePloc))))
			.seq(shuffleEffect(currentDeckLoc))
			.seq(sacrificeTarget().apply(selectSource()))
			.seq(pushChoiceEffectWithTitle(
                                {
                                    choices = {                                
										{
                                           effect = moveTarget(tradeDeckLoc).apply(selectLoc(centerRowLoc))
													.seq(shuffleTradeDeckEffect())
													.seq(refillMarketEffect(const(0)).seq(refillMarketEffect(const(1))).seq(refillMarketEffect(const(2))).seq(refillMarketEffect(const(3))).seq(refillMarketEffect(const(4))))
													.seq(addEffect(endTurnEffect())),
                                            layout = createLayout(
                {
                    name = "Yes",
                    art = "art/treasures/T_cleric_elixir_green",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
   <hlayout flexibleheight="3">
 <tmpro text="Accept choice.
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
                    art = "art/treasures/T_cleric_elixir_blue_purple",
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
					upperTitle = "Confirm your choice. Do you want to use the Terramancer?",
					
					}))
            })
        },
        layout = createLayout({
            name = "Terramancer",
            art = "art/T_Broelyn_Loreweaver_Old",
			frame = "frames/Coop_Campaign_CardFrame",
            xmlText=[[
<vlayout>
    <box flexibleheight="2">
        <tmpro text="Play as a level 3
Terramancer" fontsize="26"/>
    </box>
    <box flexibleheight="1">
        <tmpro text="
- Class by Aarkenell -" fontsize="22" fontstyle="italic"/>
    </box>

<box flexibleheight="1">
        <tmpro text="- Updated 20.09.2024-" fontsize="14" fontstyle="italic"/>
    </box>
</vlayout>

			]]
			}),
        })
	end

function choose_thandarlorian_carddef()
    return createDef({
        id="choose_thandarlorian",
        name="Choose the Thandarlorian",
        types={noStealType, itemType},
		cardTypeLabel = "Item",
		playLocation = castPloc,
        acquireCost=0,
        abilities = {
            createAbility({
                id="choose_thandarlorian",
                trigger= onPlayTrigger,
				playAllType = noPlayPlayType,
                effect = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)))
			.seq(moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc)))) 
			.seq(setPlayerNameEffect("Thandarlorian", currentPid))
			.seq(setPlayerAvatarEffect("cristov__the_just", currentPid))
			.seq(gainMaxHealthEffect(currentPid, const(36).add(getPlayerMaxHealth(currentPid).negate())))
			.seq(gainHealthEffect(const(36).add(getPlayerMaxHealth(currentPid).negate())))
			.seq(createCardEffect(thandarlorian_dragon_shard_armour_carddef(), currentSkillsLoc))
			.seq(createCardEffect(thandarlorian_bracer_blades_carddef(), currentSkillsLoc))
			.seq(createCardEffect(thandarlorian_whipcord_carddef(), currentSkillsLoc))
			.seq(createCardEffect(gold_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(ruby_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(ruby_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(thandarlorian_coordinated_attack_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(thandarlorian_combat_shield_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(thandarlorian_hand_ballista_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(thandarlorian_bounty_hunters_stone_of_seeking_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(shortsword_carddef(), loc(currentPid, asidePloc)))
			.seq(moveTarget(deckPloc).apply(selectLoc(loc(currentPid, asidePloc))))
			.seq(shuffleEffect(currentDeckLoc))
			.seq(sacrificeTarget().apply(selectSource()))
			.seq(moveTarget(deckPloc).apply(selectLoc(loc(currentPid, asidePloc))))
			.seq(shuffleEffect(currentDeckLoc))
			.seq(sacrificeTarget().apply(selectSource()))
			.seq(pushChoiceEffectWithTitle(
                                {
                                    choices = {                                
										{
                                           effect = moveTarget(tradeDeckLoc).apply(selectLoc(centerRowLoc))
													.seq(shuffleTradeDeckEffect())
													.seq(refillMarketEffect(const(0)).seq(refillMarketEffect(const(1))).seq(refillMarketEffect(const(2))).seq(refillMarketEffect(const(3))).seq(refillMarketEffect(const(4))))
													.seq(addEffect(endTurnEffect())),
                                            layout = createLayout(
                {
                    name = "Yes",
                    art = "art/treasures/T_cleric_elixir_green",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
   <hlayout flexibleheight="3">
 <tmpro text="Accept choice.
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
                    art = "art/treasures/T_cleric_elixir_blue_purple",
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
					upperTitle = "Confirm your choice. Do you want to use the Thandarlorian?",
					lowerTitle = ""
					}))
            })
        },
        layout = createLayout({
            name = "The Thandarlorian",
            art = "art/T_Domination",
            frame = "frames/Coop_Campaign_CardFrame",
            xmlText=[[
<vlayout>
    <box flexibleheight="2">
        <tmpro text="Play as a level 3
Thandarlorian" fontsize="26"/>
    </box>
    <box flexibleheight="1">
        <tmpro text="
- Class by Aarkenell -" fontsize="22" fontstyle="italic"/>
    </box>

<box flexibleheight="1">
        <tmpro text="- Art updated 06.09.2024-" fontsize="14" fontstyle="italic"/>
    </box>
</vlayout>
			]]
        })
    })
	end

function choose_paladin_carddef()
    return createDef({
        id="choose_paladin",
        name="Choose the Paladin",
        types={noStealType, itemType},
		cardTypeLabel = "Item",
		playLocation = castPloc,
        acquireCost=0,
        abilities = {
            createAbility({
                id="choose_paladin",
                trigger= onPlayTrigger,
				playAllType = noPlayPlayType,
                effect = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)))
			.seq(moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc)))) 
			.seq(setPlayerNameEffect("Paladin", currentPid))
			.seq(setPlayerAvatarEffect("cristov__the_just", currentPid))
			.seq(gainMaxHealthEffect(currentPid, const(58).add(getPlayerMaxHealth(currentPid).negate())))
			.seq(gainHealthEffect(58))
			.seq(createCardEffect(paladin_prayer_carddef(), currentSkillsLoc))
			.seq(createCardEffect(paladin_sacred_oath_carddef(), currentSkillsLoc))
			.seq(createCardEffect(gold_carddef(),loc(currentPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(ruby_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(paladin_warhammer_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(paladin_crusader_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(cleric_spiked_mace_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(fighter_longsword_carddef(), loc(currentPid, asidePloc)))
			.seq(moveTarget(deckPloc).apply(selectLoc(loc(currentPid, asidePloc))))
			.seq(shuffleEffect(currentDeckLoc))
			.seq(sacrificeTarget().apply(selectSource()))
			.seq(moveTarget(deckPloc).apply(selectLoc(loc(currentPid, asidePloc))))
			.seq(shuffleEffect(currentDeckLoc))
			.seq(sacrificeTarget().apply(selectSource()))
			.seq(pushChoiceEffectWithTitle(
                                {
                                    choices = {                                
										{
                                           effect = moveTarget(tradeDeckLoc).apply(selectLoc(centerRowLoc))
													.seq(shuffleTradeDeckEffect())
													.seq(refillMarketEffect(const(0)).seq(refillMarketEffect(const(1))).seq(refillMarketEffect(const(2))).seq(refillMarketEffect(const(3))).seq(refillMarketEffect(const(4))))
													.seq(addEffect(endTurnEffect())),
                                            layout = createLayout(
                {
                    name = "Yes",
                    art = "art/treasures/T_cleric_elixir_green",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
   <hlayout flexibleheight="3">
 <tmpro text="Accept choice.
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
                    art = "art/treasures/T_cleric_elixir_blue_purple",
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
					upperTitle = "Confirm your choice. Do you want to use the Paladin?",
					lowerTitle = ""
					}))
            })
        },
        layout = createLayout({
            name = "Paladin",
            art = "art/T_Cristov_The_Just",
			frame = "frames/Coop_Campaign_CardFrame",
            xmlText=[[
<vlayout>
    <box flexibleheight="2">
        <tmpro text="Play as a level 3 Paladin" fontsize="26"/>
    </box>
    <box flexibleheight="1">
        <tmpro text="- Class by agentC13 -" fontsize="22" fontstyle="italic"/>
    </box>
</vlayout>
			]]
			}),
        })
	end

function choose_witch_carddef()
    return createDef({
        id="choose_witch",
        name="Choose the Witch",
        types={noStealType, itemType},
		cardTypeLabel = "Item",
		playLocation = castPloc,
        acquireCost=0,
        abilities = {
            createAbility({
                id="choose_witch",
                trigger= onPlayTrigger,
				playAllType = noPlayPlayType,
                effect = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)))
			.seq(moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc)))) 
			.seq(setPlayerNameEffect("Witch", currentPid))
			.seq(setPlayerAvatarEffect("chanting_cultist", currentPid))
			.seq(gainMaxHealthEffect(currentPid, const(51).add(getPlayerMaxHealth(currentPid).negate())))
			.seq(gainHealthEffect(51))
			.seq(createCardEffect(siphon_life_def(), currentSkillsLoc))
			.seq(createCardEffect(piercing_screech_def(), currentSkillsLoc))
			.seq(createCardEffect(gold_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(witch_flash_freeze_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(witch_flash_freeze_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(cleric_everburning_candle_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(witch_cauldron_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(wizard_cat_familiar_carddef(), loc(currentPid, asidePloc)))
			.seq(moveTarget(deckPloc).apply(selectLoc(loc(currentPid, asidePloc))))
			.seq(shuffleEffect(currentDeckLoc))
			.seq(sacrificeTarget().apply(selectSource()))
			.seq(moveTarget(deckPloc).apply(selectLoc(loc(currentPid, asidePloc))))
			.seq(shuffleEffect(currentDeckLoc))
			.seq(sacrificeTarget().apply(selectSource()))
			.seq(pushChoiceEffectWithTitle(
                                {
                                    choices = {                                
										{
                                           effect = moveTarget(tradeDeckLoc).apply(selectLoc(centerRowLoc))
													.seq(shuffleTradeDeckEffect())
													.seq(refillMarketEffect(const(0)).seq(refillMarketEffect(const(1))).seq(refillMarketEffect(const(2))).seq(refillMarketEffect(const(3))).seq(refillMarketEffect(const(4))))
													.seq(addEffect(endTurnEffect())),
                                            layout = createLayout(
                {
                    name = "Yes",
                    art = "art/treasures/T_cleric_elixir_green",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
   <hlayout flexibleheight="3">
 <tmpro text="Accept choice.
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
                    art = "art/treasures/T_cleric_elixir_blue_purple",
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
					upperTitle = "Confirm your choice. Do you want to use the Witch?",
					lowerTitle = ""
					}))
            })
        },
        layout = createLayout({
            name = "Witch",
            art = "avatars/chanting_cultist",
			frame = "frames/Coop_Campaign_CardFrame",
            xmlText=[[
<vlayout>
    <box flexibleheight="2">
        <tmpro text="Play as a level 3 Witch" fontsize="26"/>
    </box>
    <box flexibleheight="1">
        <tmpro text="- Class by Userkaffe -" fontsize="22" fontstyle="italic"/>
    </box>
</vlayout>
			]]
			}),
        })
	end

function choose_shaman_carddef()
    return createDef({
        id="choose_shaman",
        name="Choose the Shaman",
        types={noStealType, itemType},
		cardTypeLabel = "Item",
		playLocation = castPloc,
        acquireCost=0,
        abilities = {
            createAbility({
                id="choose_shaman",
                trigger= onPlayTrigger,
				playAllType = noPlayPlayType,
                effect = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)))
			.seq(moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc)))) 
			.seq(setPlayerNameEffect("Shaman", currentPid))
			.seq(setPlayerAvatarEffect("wolf_shaman", currentPid))
			.seq(gainMaxHealthEffect(currentPid, const(50).add(getPlayerMaxHealth(currentPid).negate())))
			.seq(gainHealthEffect(const(50).add(getPlayerMaxHealth(currentPid).negate())))
			.seq(createCardEffect(gift_of_the_elements_carddef(), currentSkillsLoc))
			.seq(createCardEffect(elemental_surge_def(), currentSkillsLoc))
			.seq(createCardEffect(gold_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(gold_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(ruby_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(natures_blessing_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(flame_burst_carddef(), loc(currentPid, asidePloc)))
            .seq(createCardEffect(flame_burst_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(call_lightning_carddef(), loc(currentPid, asidePloc)))
			.seq(moveTarget(deckPloc).apply(selectLoc(loc(currentPid, asidePloc))))
			.seq(shuffleEffect(currentDeckLoc))
			.seq(sacrificeTarget().apply(selectSource()))
			.seq(moveTarget(deckPloc).apply(selectLoc(loc(currentPid, asidePloc))))
			.seq(shuffleEffect(currentDeckLoc))
			.seq(sacrificeTarget().apply(selectSource()))
			.seq(pushChoiceEffectWithTitle(
                                {
                                    choices = {                                
										{
                                           effect = moveTarget(tradeDeckLoc).apply(selectLoc(centerRowLoc))
													.seq(shuffleTradeDeckEffect())
													.seq(refillMarketEffect(const(0)).seq(refillMarketEffect(const(1))).seq(refillMarketEffect(const(2))).seq(refillMarketEffect(const(3))).seq(refillMarketEffect(const(4))))
													.seq(addEffect(endTurnEffect())),
                                            layout = createLayout(
                {
                    name = "Yes",
                    art = "art/treasures/T_cleric_elixir_green",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
   <hlayout flexibleheight="3">
 <tmpro text="Accept choice.
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
                    art = "art/treasures/T_cleric_elixir_blue_purple",
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
					upperTitle = "Confirm your choice. Do you want to use the Shaman?",
					lowerTitle = ""
					}))
            })
        },
        layout = createLayout({
            name = "Shaman",
            art = "avatars/wolf_shaman",
			frame = "frames/Coop_Campaign_CardFrame",
            xmlText=[[
			<vlayout>
    <box flexibleheight="2">
        <tmpro text="Play as a level 3 Shaman" fontsize="26"/>
    </box>
    <box flexibleheight="1">
        <tmpro text="- Class by Filtrophobe -" fontsize="22" fontstyle="italic"/>
    </box>
</vlayout>

			]]
			}),
        })
	end

function choose_king_midas_carddef()
    return createDef({
        id="choose_king_midas",
        name="Choose King Midas",
        types={noStealType, itemType},
		cardTypeLabel = "Item",
		playLocation = castPloc,
        acquireCost=0,
        abilities = {
            createAbility({
                id="choose_king_midas",
                trigger= onPlayTrigger,
				playAllType = noPlayPlayType,
                effect = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)))
			.seq(moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc)))) 
			.seq(setPlayerNameEffect("King Midas", currentPid))
			.seq(setPlayerAvatarEffect("profit", currentPid))
			.seq(gainMaxHealthEffect(currentPid, const(42).add(getPlayerMaxHealth(currentPid).negate())))
			.seq(gainHealthEffect(42))
			.seq(createCardEffect(greed_is_good_skilldef(), currentSkillsLoc))
			.seq(createCardEffect(golden_touch_abilitydef(), currentSkillsLoc))
			.seq(createCardEffect(midas_kings_adviser_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(midas_kings_adviser_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(midas_kings_adviser_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(midas_kings_adviser_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(midas_gold_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(midas_gold_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(midas_gold_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(midas_gold_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(midas_liquid_gold_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(midas_liquid_gold_carddef(), loc(currentPid, asidePloc)))
			.seq(moveTarget(deckPloc).apply(selectLoc(loc(currentPid, asidePloc))))
			.seq(shuffleEffect(currentDeckLoc))
			.seq(sacrificeTarget().apply(selectSource()))
			.seq(moveTarget(deckPloc).apply(selectLoc(loc(currentPid, asidePloc))))
			.seq(shuffleEffect(currentDeckLoc))
			.seq(sacrificeTarget().apply(selectSource()))
			.seq(pushChoiceEffectWithTitle(
                                {
                                    choices = {                                
										{
                                           effect = moveTarget(tradeDeckLoc).apply(selectLoc(centerRowLoc))
													.seq(shuffleTradeDeckEffect())
													.seq(refillMarketEffect(const(0)).seq(refillMarketEffect(const(1))).seq(refillMarketEffect(const(2))).seq(refillMarketEffect(const(3))).seq(refillMarketEffect(const(4))))
													.seq(addEffect(endTurnEffect())),
                                            layout = createLayout(
                {
                    name = "Yes",
                    art = "art/treasures/T_cleric_elixir_green",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
   <hlayout flexibleheight="3">
 <tmpro text="Accept choice.
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
                    art = "art/treasures/T_cleric_elixir_blue_purple",
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
					upperTitle = "Confirm your choice. Do you want to use King Midas?",
					lowerTitle = ""
					}))
            })
        },
        layout = createLayout({
            name = "King Midas",
            art = "art/T_Bribe",
			frame = "frames/Coop_Campaign_CardFrame",
            xmlText=[[
			<vlayout>
    <box flexibleheight="2">
        <tmpro text="Play as a level 3 King Midas" fontsize="26"/>
    </box>
    <box flexibleheight="1">
        <tmpro text="- Class by Zabuza -" fontsize="22" fontstyle="italic"/>
    </box>
</vlayout>

			]]
			}),
        })
	end

function choose_brewmaster_carddef()
    return createDef({
        id="choose_brewmaster",
        name="Choose the Brewmaster",
        types={noStealType, itemType},
		cardTypeLabel = "Item",
		playLocation = castPloc,
        acquireCost=0,
        abilities = {
            createAbility({
                id="choose_brewmaster",
                trigger= onPlayTrigger,
				playAllType = noPlayPlayType,
                effect = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)))
			.seq(moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc)))) 
			.seq(setPlayerNameEffect("Brewmaster", currentPid))
			.seq(setPlayerAvatarEffect("lord_callum", currentPid))
			.seq(gainMaxHealthEffect(currentPid, const(55).add(getPlayerMaxHealth(currentPid).negate())))
			.seq(gainHealthEffect(55))
			.seq(createCardEffect(brewmaster_a_round_on_the_house_def(), currentSkillsLoc))
			.seq(createCardEffect(brewmaster_get_out_of_my_bar_carddef(), currentSkillsLoc))
			.seq(createCardEffect(brewmaster_mead_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(brewmaster_mead_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(brewmaster_mead_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(brewmaster_mead_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(brewmaster_spilled_drink_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(brewmaster_tap_a_keg_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(brewmaster_serve_the_strong_stuff_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(brewmaster_regular_regulars_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(brewmaster_irregular_regulars_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(brewmaster_zaboozer_carddef(), loc(currentPid, asidePloc)))
			.seq(moveTarget(deckPloc).apply(selectLoc(loc(currentPid, asidePloc))))
			.seq(shuffleEffect(currentDeckLoc))
						.seq(sacrificeTarget().apply(selectSource()))
			.seq(moveTarget(deckPloc).apply(selectLoc(loc(currentPid, asidePloc))))
			.seq(shuffleEffect(currentDeckLoc))
			.seq(sacrificeTarget().apply(selectSource()))
			.seq(pushChoiceEffectWithTitle(
                                {
                                    choices = {                                
										{
                                           effect = moveTarget(tradeDeckLoc).apply(selectLoc(centerRowLoc))
													.seq(shuffleTradeDeckEffect())
													.seq(refillMarketEffect(const(0)).seq(refillMarketEffect(const(1))).seq(refillMarketEffect(const(2))).seq(refillMarketEffect(const(3))).seq(refillMarketEffect(const(4))))
													.seq(addEffect(endTurnEffect())),
                                            layout = createLayout(
                {
                    name = "Yes",
                    art = "art/treasures/T_cleric_elixir_green",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
   <hlayout flexibleheight="3">
 <tmpro text="Accept choice.
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
                    art = "art/treasures/T_cleric_elixir_blue_purple",
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
					upperTitle = "Confirm your choice. Do you want to use the Brewmaster?",
					lowerTitle = ""
					}))
            })
        },
        layout = createLayout({
            name = "Brewmaster",
            art = "art/treasures/T_Fighter_Elixir_Red",
			frame = "frames/Coop_Campaign_CardFrame",
            xmlText=[[
			<vlayout>
    <box flexibleheight="2">
        <tmpro text="Play as a level 3 Brewmaster" fontsize="26"/>
    </box>
    <box flexibleheight="1">
        <tmpro text="- Class by Aarkenell -" fontsize="22" fontstyle="italic"/>
    </box>

<box flexibleheight="1">
        <tmpro text="- Updated 07.04.2024 -" fontsize="14" fontstyle="italic"/>
    </box>
</vlayout>
			]]
			}),
        })
	end

function choose_S_and_R_carddef()
    return createDef({
        id="choose_S&R",
        name="Choose Sparks & Rec Enjoyer",
        types={noStealType, itemType},
		cardTypeLabel = "Item",
		playLocation = castPloc,
        acquireCost=0,
        abilities = {
            createAbility({
                id="choose_S&R",
                trigger= onPlayTrigger,
				playAllType = noPlayPlayType,
                effect = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)))
			.seq(moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc)))) 
			.seq(setPlayerNameEffect("Sparks & Rec Enjoyer", currentPid))
			.seq(setPlayerAvatarEffect("ambushers", currentPid))
			.seq(gainMaxHealthEffect(currentPid, const(54).add(getPlayerMaxHealth(currentPid).negate())))
			.seq(gainHealthEffect(54))
			.seq(createCardEffect(bird_dog_def(), currentSkillsLoc))
			.seq(createCardEffect(patron_shoutout_def(), currentSkillsLoc))
			.seq(createCardEffect(situational_card_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(situational_card_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(situational_card_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(situational_card_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(situational_card_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(hero_dash_helper_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(wwyd_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(nostra_dbl_damus_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(blank_to_my_blank_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(congrats_youre_a_nerd_carddef(), loc(currentPid, asidePloc)))
			.seq(moveTarget(deckPloc).apply(selectLoc(loc(currentPid, asidePloc))))
			.seq(shuffleEffect(currentDeckLoc))
						.seq(sacrificeTarget().apply(selectSource()))
			.seq(moveTarget(deckPloc).apply(selectLoc(loc(currentPid, asidePloc))))
			.seq(shuffleEffect(currentDeckLoc))
			.seq(sacrificeTarget().apply(selectSource()))
			.seq(pushChoiceEffectWithTitle(
                                {
                                    choices = {                                
										{
                                           effect = moveTarget(tradeDeckLoc).apply(selectLoc(centerRowLoc))
													.seq(shuffleTradeDeckEffect())
													.seq(refillMarketEffect(const(0)).seq(refillMarketEffect(const(1))).seq(refillMarketEffect(const(2))).seq(refillMarketEffect(const(3))).seq(refillMarketEffect(const(4))))
													.seq(addEffect(endTurnEffect())),
                                            layout = createLayout(
                {
                    name = "Yes",
                    art = "art/treasures/T_cleric_elixir_green",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
   <hlayout flexibleheight="3">
 <tmpro text="Accept choice.
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
                    art = "art/treasures/T_cleric_elixir_blue_purple",
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
					upperTitle = "Confirm your choice. Do you want to use the Sparks & Recreations Enjoyer?",
					lowerTitle = ""
					}))
            })
        },
        layout = createLayout({
            name = "S&R Enjoyer",
            art = "avatars/ambushers",
			frame = "frames/Coop_Campaign_CardFrame",
            xmlText=[[
			<vlayout>
    <box flexibleheight="2">
        <tmpro text="Play as a level 3
Sparks and Recreations Enjoyer" fontsize="24"/>
    </box>
    <box flexibleheight="1">
        <tmpro text="
- Class by WardenSlayer -" fontsize="22" fontstyle="italic"/>
    </box>

<box flexibleheight="1">
        <tmpro text="- Added 04.04.2024-" fontsize="14" fontstyle="italic"/>
    </box>
</vlayout>
			]]
			}),
        })
	end


--Lich cards
function lich_corruption_carddef()
    local cardLayout = createLayout({
        name = "Corruption",
        art = "art/epicart/necromancer_apprentice",
        frame = "frames/necromancer_frames/necromancer_item_cardframe",
        xmlText = 
		[[
<vlayout>
<box flexibleheight="4">
<tmpro text="{combat_1}
&lt;size=50%&gt;Perform 1 Summoning." fontsize="48" />
</box>
<divider/>
<box flexibleheight="3">
<tmpro text="You begin corrupting the city.
The citizens begin to do your bidding." fontstyle="italic" fontsize="16" />
</box>	</vlayout>

		]]
    })

    return createSkillDef({
        id = "corruption_skill",
        name = "Corruption",
        types = { skillType },
        layout = cardLayout,
        layoutPath = "art/epicart/necromancer_apprentice",
        abilities = {
            createAbility({
                id="corruption20buff_combat",
				trigger = uiTrigger,
				activations = singleActivation,
                layout = cardLayout,
				promptType = showPrompt,
                effect = gainCombatEffect(1)
					.seq(randomTarget(const(1), moveTarget(inPlayPloc)).apply(selectLoc(loc(nil, nullPloc))))
					.seq(noUndoEffect()),
				check = selectLoc(loc(nil, nullPloc)).count().gte(1),
				cost = expendCost,
            }),

        }
        
    })
end

function lich_control_carddef()
    local cardLayout = createLayout({
        name = "Control",
        art = "art/epicart/necromancer_lord",
        frame = "frames/necromancer_frames/necromancer_item_cardframe",
        xmlText = 
		[[
<vlayout>
<box flexibleheight="4">
<tmpro text="{combat_2}
&lt;size=50%&gt;Perform 2 Summonings." fontsize="48" />
</box>
<divider/>
<box flexibleheight="2">
<tmpro text="You have corrupted the entire city.
It is under your command!" fontstyle="italic" fontsize="16" />
</box>	</vlayout>

		]]
    })

    return createSkillDef({
        id = "control_skill",
        name = "Coontrol",
        types = { skillType },
        layout = cardLayout,
        layoutPath = "art/epicart/necromancer_lord",
        abilities = {
            createAbility({
                id="control30buff_combat",
				trigger = uiTrigger,
				activations = singleActivation,
                layout = cardLayout,
				promptType = showPrompt,
                effect = gainCombatEffect(2)
					.seq(randomTarget(const(2), moveTarget(inPlayPloc)).apply(selectLoc(loc(nil, nullPloc))))
					.seq(noUndoEffect()),
				check = selectLoc(loc(nil, nullPloc)).count().gte(2),
				cost = expendCost,
            }),

        }
        
    })
end


function lich_soul_diamond_carddef()
	return createItemDef({
		id = "lich_soul_diamond",
		name = "Lich Soul Diamond",
		playLocation = castPloc,
		acquireCost = 0,
		isGuard = false,
		types = { itemType, currencyType, gemType, nostealType },
		layout = createLayout({
					name = "Soul Diamond",
					art = "art/classes/necromancer/soul_cage",
					frame = "frames/necromancer_frames/necromancer_item_cardframe",
					cost = 0,
					xmlText=
					[[
<vlayout>
<hlayout forcewidth="true" spacing="10">
<tmpro text="&lt;br&gt;" fontsize="14.5" flexiblewidth="20"/>
</hlayout>
<hlayout flexibleheight="1">
<box flexiblewidth="7">
<tmpro text="{gold_1}" fontsize="40" flexiblewidth="10"/>
</box>
</hlayout>
<divider/>
<hlayout flexibleheight="1.2">
<box flexiblewidth="1">
<tmpro text="&lt;cspace=-0.2em&gt;{scrap}" fontsize="36"/>
</box>
<box flexiblewidth="7">
<tmpro text="&lt;space=1em/&gt;Stun all champions target player controls." fontsize="13" flexiblewidth="10"/>
</box>
</hlayout>
</vlayout>
					]]
				}),
		abilities = {
			createAbility({
				id = "lich_soul_diamond_item_main",
				trigger = autoTrigger,
				cost = noCost,
				effect = ifElseEffect(isPlayerAi(oppPid),gainGoldEffect(3),gainGoldEffect(1)),
			}),
			
			createAbility({
				id = "lich_soul_diamond_item_stun",
				trigger = uiTrigger,
				
				activations = singleActivation,
				effect = pushChoiceEffectWithTitle(
					{
						
						choices = 
						{
								{
									effect = stunTarget().apply(selectLoc(loc(oppPid, inPlayPloc))),
									check = selectLoc(loc(oppPid, inPlayPloc)).where(isCardStunnable()),
									layout = createLayout({
										name = "Soul Diamond",
										art = "art/treasures/necromancer/Soul_cage",
										frame = "frames/necromancer_frames/necromancer_item_cardframe",
										cost = 0,
										xmlText=
										[[
											<vlayout>
												<hlayout flexibleheight="1.2">
													<box flexiblewidth="1">
														<tmpro text="&lt;cspace=-0.2em&gt;{scrap}" fontsize="36"/>
													</box>
													<box flexiblewidth="7">
														<tmpro text="&lt;space=1em/&gt;Stun all champions target player controls." fontsize="13" flexiblewidth="10"/>
													</box>
												</hlayout>
											</vlayout>
										]],
									}),
								},
							
						},
						
					}
				),
				cost = sacrificeSelfCost,
				
			}),
		},
		
		layout = createLayout(
			{
				name = "Soul Diamond",
				art = "art/treasures/necromancer/Soul_cage",
				frame = "frames/necromancer_frames/necromancer_item_cardframe",
				xmlText = 
				[[
					
<vlayout>
<hlayout flexibleheight="1">
<box flexiblewidth="7">
<tmpro text="{gold_1}" fontsize="50" />
</box>
</hlayout>
<divider/>
<hlayout flexibleheight="1">
<box flexiblewidth="1">
<tmpro text="{scrap}" fontsize="36"/>
</box>
<box flexiblewidth="7">
<tmpro text="Stun all of your opponent's champions." fontsize="20" />
</box>
</hlayout>
</vlayout>
				]]
			}
		),
		layoutPath = "art/T_Gold",
	})
end

function lich_frozen_touch_carddef()
    return createActionDef({
            id = "lich_frozen_touch",
            name = "Frozen Touch",
			types = {actionType, nostealType},
			cardTypeLabel = "Action",
			playLocation = castPloc,
            acquireCost = 0,
            abilities = {
                createAbility(
                    {
                        id = "frozen_touch_main",
                        trigger = autoTrigger,
                        cost = noCost,
                        activations = singleActivations,
                        effect = gainCombatEffect(1),
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Frozen Touch",
                    art = "art/epicart/zannos__corpse_lord",
					frame = "frames/necromancer_frames/necromancer_item_cardframe",
					cost = 0,
                    xmlText=[[
<vlayout>
<hlayout flexibleheight="1">
<box flexiblewidth="7">
<tmpro text="{combat_1}" fontsize="60" />
</box>
</hlayout>
</vlayout>
					]],

                }
            )
        }
    )
end


function lich_soul_crush_carddef()
	return createActionDef({
		id = "lich_soul_crush_curse",
		name = "Lich Soul Crush Curse",
		acquireCost = 0,

		types = { actionType, curseType, nostealType },
		layout = createLayout({
					name = "Soul Crush",
					art = "art/epicart/consume",
					frame = "frames/necromancer_frames/necromancer_item_cardframe",
					cost = 0,
					xmlText=
					[[
<vlayout>
<hlayout flexibleheight="1">
<box flexiblewidth="7">
<tmpro text="{combat_3}
&lt;size=40%&gt;or
Stun target champion." fontsize="60" />
</box>

</hlayout>
</vlayout>
					]]
				}),
		abilities = {
			createAbility({
				id = "lich_soul_crush_curse_main",
				trigger = autoTrigger,
				cost = noCost,
				effect = pushChoiceEffect
				(
					{
						choices =
						{
							
							-- Gain 3 combat
							{
								effect = gainCombatEffect(3),
								layout = layoutCard(
									{
										title = "Soul Crush",
										art = "art/epicart/scara_s_will",
										frame = "frames/necromancer_frames/necromancer_item_cardframe",
										xmlText = 
										[[
<vlayout>
<hlayout flexibleheight="1">
<box flexiblewidth="7">
<text text="{combat_3}" fontsize="60"/>
</box>
</hlayout>
</vlayout>
										]]
									}
								),
							},
							-- Stun an opposing champion
							{
								effect = pushTargetedEffect({
									desc = "Stun target champion.",
									validTargets = oppStunnableSelector(),
									min = 0,
									max = 1,
									targetEffect = stunTarget(),
									}),
								condition = selectLoc(loc(oppPid, inPlayPloc)).where(isCardChampion()).count().gte(1),
								layout = layoutCard(
									{
										title = "Soul Crush",
										art = "art/epicart/scara_s_will",
										frame = "frames/necromancer_frames/necromancer_item_cardframe",
										xmlText = 
										[[
<vlayout>
<hlayout flexibleheight="1">
<box flexiblewidth="7">
<text text="Stun target champion." fontsize="24"/>
</box>
</hlayout>
</vlayout>

										]]
									}
								),
							},
							
						}
					}
				)
			})
		
		},
	})
end

function lich_minor_summoning_carddef()
	return createActionDef({
		id = "lich_minor_summoning_curse",
		name = "Minor Summoning",
		playLocation = castPloc,
		acquireCost = 0,
		types = { actionType, curseType, nostealType },
		layout = createLayout({
					name = "Minor Summoning",
					art = "art/epicart_necrovirus",
					frame = "frames/necromancer_frames/necromancer_item_cardframe",
					cost = 0,
					xmlText=
					[[
<vlayout>
<hlayout flexibleheight="1">
<box flexiblewidth="7">
<tmpro text="Put a Skeleton Warrior into play." fontsize="24" />
</box>

</hlayout>
</vlayout>
					]]
				}),
		abilities = {
			createAbility({
				id = "lich_minor_summoning",
				trigger = autoTrigger,
				cost = expendCost,
				effect = createCardEffect(necromancer_skeleton_warrior_carddef(), currentInPlayLoc),
			}),
		},
	})
end

function lich_major_summoning_carddef()
	return createActionDef({
		id = "lich_major_summoning",
		name = "Major Summoning",
		playLocation = castPloc,
		acquireCost = 0,
		types = { actionType, curseType, nostealType },
		layout = createLayout({
					name = "Major Summoning",
					art = "art/epicart_abyss_summoner",
					frame = "frames/necromancer_frames/necromancer_item_cardframe",
					cost = 0,
					xmlText=
					[[
<vlayout>
<hlayout flexibleheight="1">
<box flexiblewidth="7">
<tmpro text="Perform 1 Summoning." fontsize="24" />
</box>

</hlayout>
</vlayout>
					]]
				}),
		abilities = {
			createAbility({
				id = "lich_major_summoning",
				trigger = autoTrigger,
				cost = expendCost,
				effect = randomTarget(const(1), moveTarget(inPlayPloc)).apply(selectLoc(loc(nil, nullPloc))).seq(noUndoEffect()),
				check = selectLoc(loc(nil, nullPloc)).count().gte(1),
			}),
		},
	})
end

--Lich minions
function lich_abomination_minion_carddef()
	return createChampionDef({
		id = "lich_abomination_minion",
		name = "Lich Abomination Minion",
		acquireCost = 0,
		health = 6,
		isGuard = true,
		types = { minionType, undeadType, constructType },
		layout = createLayout({
					name = "Abomination",
					art = "art/epicart/scrap_golem_token",
					frame = "frames/necromancer_frames/necromancer_item_cardframe",
					cost = 0,
					health = 6,
					isGuard = true,
					xmlText=
					[[
						<vlayout forceheight="false" spacing="6">
							<hlayout forcewidth="true" spacing="10">         <icon text="{expend}" fontsize="55"/>
								<hlayout spacing="10">
									<text text="{combat_4}" fontsize="85"/>
								</hlayout>          
								<icon text=" " fontsize="22"/>
							</hlayout>
						<divider/>
							<hlayout flexibleheight="7">
								<vlayout flexiblewidth="8">
									<tmpro text="&lt;space=1em/&gt;It feels neither pain nor fear." fontsize="13" flexiblewidth="10" fontstyle="italic" flexibleheight="1"/>
									<tmpro text="&lt;space=1em/&gt;But you will..." fontsize="13" flexiblewidth="10" fontstyle="italic" flexibleheight="0.3"/>
								</vlayout>
							</hlayout>
						</vlayout>
					]]
				}),
		abilities = {
			createAbility({
				id = "lich_abomination_minion_main",
				trigger = autoTrigger,
				cost = expendCost,
				activations = multipleActivations,
				effect = gainCombatEffect(4),
			}),
			
			createAbility({
				id = "lich_abomination_minion_sac",
				trigger = onLeavePlayTrigger,
				cost = noCost,
				activations = singleActivations,
				effect = moveTarget(nullPloc).apply(selectSource())
			})
		},
	})
end

function lich_banshee_minion_carddef()
	return createChampionDef({
		id = "lich_banshee_minion",
		name = "Lich Banshee Minion",
		acquireCost = 0,
		health = 3,
		isGuard = false,
		types = { minionType, undeadType },
		layout = createLayout({
					name = "Banshee",
					art = "art/T_Banshee",
					frame = "frames/necromancer_frames/necromancer_item_cardframe",
					cost = 0,
					health = 3,
					isGuard = false,
					xmlText=
					[[
<vlayout>
    <hlayout flexibleheight="3">
        <box flexiblewidth="1">
            <tmpro text="{expend}" fontsize="42"/>
        </box>
        <vlayout flexiblewidth="7">

            <box flexibleheight="2">
                <tmpro text="Deal 2 damage to each opposing champion and 6 damage to your opponent." fontsize="22" />
            </box>
<box flexibleheight="0.5">
 <tmpro text="(Guards do not prevent this.)" fontstyle="italic" fontsize="18" />
</box>
        </vlayout>
    </hlayout>

</vlayout>
					]]
				}),
		abilities = {
			createAbility({
				id = "lich_banshee_minion_main",
				trigger = autoTrigger,
				cost = expendCost,
				activations = multipleActivations,
				effect = hitOpponentEffect(6).seq(damageTarget(2).apply(selectLoc(loc(oppPid, inPlayPloc))))
			}),
			
			createAbility({
				id = "lich_banshee_minion_sac",
				trigger = onLeavePlayTrigger,
				cost = noCost,
				activations = singleActivations,
				effect = moveTarget(nullPloc).apply(selectSource())
			})
		},
	})
end

function lich_ghoul_minion_carddef()
	return createChampionDef({
		id = "lich_ghoul_minion",
		name = "Lich Ghoul Minion",
		acquireCost = 0,
		health = 5,
		isGuard = true,
		types = { minionType, undeadType },
		layout = createLayout({
					name = "Ghoul",
					art = "art/epicart/carrion_demon",
					frame = "frames/necromancer_frames/necromancer_item_cardframe",
					cost = 0,
					health = 5,
					isGuard = true,
					xmlText=
					[[
	<vlayout>
    <hlayout flexibleheight="3">
            <tmpro text="{expend}" fontsize="50" flexiblewidth="2"/>
            <tmpro text="{combat_3}
&lt;size=50%&gt;+{combat_1} for each champion in your discard pile." fontsize="50
" flexiblewidth="12" />
    </hlayout>
    
</vlayout>
					]]
				}),
		abilities = {
			createAbility({
				id = "lich_ghoul_minion_main",
				trigger = uiTrigger,
				promptType = showPrompt,
				layout = layoutCard(
                                                {
                                                    name = "Ghoul",
													art = "art/epicart/carrion_demon",
													frame = "frames/necromancer_frames/necromancer_item_cardframe",
													xmlText=[[
														<vlayout>
    <hlayout flexibleheight="3">
            <tmpro text="{expend}" fontsize="50" flexiblewidth="2"/>
            <tmpro text="{combat_3}
&lt;size=50%&gt;+{combat_1} for each champion in your discard pile." fontsize="50
" flexiblewidth="12" />
    </hlayout>
    
</vlayout>
													]]
                                                }
                                            ),
				cost = expendCost,
				activations = multipleActivations,
				effect = gainCombatEffect(3).seq(gainCombatEffect(selectLoc(currentDiscardLoc).where(isCardChampion()).count())),
				--ifElseEffect(selectLoc(currentInPlayLoc).where(isCardType(demonType)).count().gte(1),gainCombatEffect(3),gainCombatEffect(1))
			}),
			
			createAbility({
				id = "lich_ghoul_minion_sac",
				trigger = onLeavePlayTrigger,
				cost = noCost,
				activations = singleActivations,
				effect = moveTarget(nullPloc).apply(selectSource())
			})
		},
	})
end

function lich_revenant_minion_carddef() 
	return createChampionDef({
		id = "lich_revenant_minion",
		name = "Lich Revenant Minion",
		acquireCost = 0,
		health = 5,
		isGuard = false,
		types = { minionType, undeadType },
		layout = createLayout({
					name = "Revenant",
					art = "art/epicart/scara_s_will",
					frame = "frames/necromancer_frames/necromancer_item_cardframe",
					cost = 0,
					health = 5,
					isGuard = false,
					xmlText=
					[[
<vlayout>
<hlayout flexibleheight="7.7">
            <tmpro text="{expend}" fontsize="50" flexiblewidth="1"/>
            <vlayout flexiblewidth="6">
                                <icon text="{health_5}" fontsize="40" alignment="Center" flexibleheight="1"/>
                                <tmpro text="&lt;size=80%&gt;or
&lt;size=100%&gt;Stun an opposing champion." fontsize="26" alignment="Center" flexibleheight="6.6"/>          
            </vlayout>
    </hlayout>
</vlayout>
					]]
				}),
		abilities = {
			createAbility({
				id = "lich_revenant_minion_main",
				trigger = uiTrigger,
				cost = expendCost,
				activations = multipleActivations,
				effect = pushChoiceEffect
				(
					{
						choices =
						{
							
							-- Gain 5 health
							{
								effect = gainHealthEffect(5),
								layout = layoutCard(
									{
										title = "Revenant",
										art = "art/epicart/scara_s_will",
										frame = "frames/necromancer_frames/necromancer_item_cardframe",
										xmlText = 
										[[
											<vlayout>
												<hlayout flexibleheight="1">
													<box flexiblewidth="7">
														<text text="{health_5}" fontsize="60"/>
													</box>
												</hlayout>
											</vlayout>
										]]
									}
								),
							},
							-- Stun an opposing champion
							{
								effect = pushTargetedEffect({
									desc = "Stun an opposing champion.",
									validTargets = oppStunnableSelector(),
									min = 0,
									max = 1,
									targetEffect = stunTarget(),
									}),
								condition = selectLoc(loc(oppPid, inPlayPloc)).where(isCardChampion()).count().gte(1),	
								layout = layoutCard(
									{
										title = "Revenant",
										art = "art/epicart/scara_s_will",
										frame = "frames/necromancer_frames/necromancer_item_cardframe",
										xmlText = 
										[[
											<vlayout>
												<hlayout flexibleheight="1">
													<box flexiblewidth="7">
														<text text="Stun an opposing champion." fontsize="25"/>
													</box>
												</hlayout>
											</vlayout>
										]]
									}
								),
							},
							
						}
					}
				)
			}),
			
			createAbility({
				id = "lich_revenant_minion_sac",
				trigger = onLeavePlayTrigger,
				cost = noCost,
				activations = singleActivations,
				effect = moveTarget(nullPloc).apply(selectSource())
			})		
		},
	})
end

function lich_skeleton_horde_minion_carddef() 
	return createChampionDef({
		id = "lich_skeleton_horde_minion",
		name = "Lich Skeleton Horde Minion",
		acquireCost = 0,
		health = 4,
		isGuard = false,
		types = { minionType, undeadType },
		layout = createLayout({
					name = "Skeleton Horde",
					art = "art/T_Angry_Skeleton",
					frame = "frames/necromancer_frames/necromancer_item_cardframe",
					cost = 0,
					health = 4,
					isGuard = false,
					xmlText=
					[[
<vlayout>
<hlayout flexibleheight="7.7">
            <tmpro text="{expend}" fontsize="50" flexiblewidth="1"/>
            <vlayout flexiblewidth="6">
                                <icon text="{combat_3}" fontsize="60" alignment="Center" flexibleheight="1"/>
                                     
            </vlayout>
    </hlayout>
</vlayout>
					]]
				}),
		abilities = {
			createAbility({
				id = "lich_skeleton_horde_minion_main",
				trigger = autoTrigger,
				cost = expendCost,
				activations = multipleActivations,
				effect = gainCombatEffect(3),
			}),
			
			createAbility({
				id = "lich_skeleton_horde_minion_sac",
				trigger = onLeavePlayTrigger,
				cost = noCost,
				activations = singleActivations,
				effect = moveTarget(nullPloc).apply(selectSource())
			})
		},
	})
end

function lich_wall_of_bones_minion_carddef() 
	return createChampionDef({
		id = "lich_wall_of_bones_minion",
		name = "Lich Wall of Bones Minion",
		acquireCost = 0,
		health = 8,
		isGuard = true,
		types = { minionType, undeadType, constructType },
		layout = createLayout({
					name = "Wall of Bones",
					art = "art/T_skeleton",
					frame = "frames/necromancer_frames/necromancer_item_cardframe",
					cost = 0,
					health = 8,
					isGuard = true,
					xmlText=
					[[
						<vlayout forceheight="false" spacing="6">
							<hlayout flexibleheight="7">
								<vlayout flexiblewidth="8">
									<tmpro text="&lt;space=1em/&gt;''Pray you don't become a part of it.''" fontsize="14.5" flexiblewidth="10" fontstyle="italic" flexibleheight="1"/>
								</vlayout>
							</hlayout>
						</vlayout>
					]]
				}),
		abilities = {
			createAbility({
				id = "lich_wall_of_bones_minion_main",
				trigger = autoTrigger,
				--cost = expendCost,
				effect = nullEffect()
			}),
			
			createAbility({
				id = "lich_wall_of_bones_minion_sac",
				trigger = onLeavePlayTrigger,
				cost = noCost,
				activations = singleActivations,
				effect = moveTarget(nullPloc).apply(selectSource())
			})
		},
	})
end

function lich_wall_of_fire_minion_carddef()
	return createChampionDef({
		id = "lich_wall_of_fire_minion",
		name = "Lich Wall of Fire Minion",
		acquireCost = 0,
		health = 7,
		isGuard = false,
		types = { minionType, magicType, constructType },
		layout = createLayout({
					name = "Wall of Fire",
					art = "art/T_charing_guardian",
					frame = "frames/necromancer_frames/necromancer_item_cardframe",
					cost = 0,
					health = 7,
					isGuard = false,
					xmlText=
					[[
						<vlayout>
							<hlayout flexibleheight="1">
								<tmpro text="{expend}" fontsize="55" flexiblewidth="1"/>
									<tmpro text="Deal 6 damage to your opponent." fontsize="22" flexiblewidth="4"/>
							</hlayout>
						</vlayout>
					]]
				}),
		abilities = {
			createAbility({
				id = "lich_wall_of_fire_minion_main",
				trigger = autoTrigger,
				cost = expendCost,
				activations = multipleActivations,
				effect = hitOpponentEffect(6),
			}),
			
			createAbility({
				id = "lich_wall_of_bones_minion_sac",
				trigger = onLeavePlayTrigger,
				cost = noCost,
				activations = singleActivations,
				effect = moveTarget(nullPloc).apply(selectSource())
			})
		},
	})
end

function lich_zombie_minion_carddef() 
	return createChampionDef({
		id = "lich_zombie_minion",
		name = "Lich Zombie Minion",
		acquireCost = 0,
		health = 1,
		isGuard = false,
		cardTypeLabel = "undeadType",
		types = { minionType, undeadType },
		layout = createLayout({
					name = "Zombie",
					art = "art/sets/promos1art/zombie",
					frame = "frames/necromancer_frames/necromancer_item_cardframe",
					cost = 0,
					health = 1,
					isGuard = false,
					xmlText=
					[[
<vlayout forceheight="false" spacing="6">
<hlayout forcewidth="true" spacing="10">
<icon text="{expend}" fontsize="40"/>
<hlayout spacing="10">
<text text="{combat_2}" fontsize="60"/>
</hlayout>          
<icon text=" " fontsize="22"/>
</hlayout>
	<divider/>
<hlayout flexibleheight="2">
	<tmpro text="&lt;space=1em/&gt;Where the Lich walks, the dead rise." fontsize="13" flexiblewidth="10" fontstyle="italic"/>
</hlayout>
</vlayout>
					]]
				}),
		abilities = {
			createAbility({
				id = "lich_zombie_minion_main",
				trigger = autoTrigger,
				cost = expendCost,
				activations = multipleActivations,
				effect = gainCombatEffect(2)
			}),
			
			createAbility({
				id = "lich_zombie_minion_sac",
				trigger = onLeavePlayTrigger,
				cost = noCost,
				activations = singleActivations,
				effect = moveTarget(nullPloc).apply(selectSource())
			})
		
		},
	})
end

--Lich Soul jars (Skills)

function lich_SJ_HoE_carddef()
    local cardLayout = createLayout({
        name = "Heart of Evil",
        art = "art/t_elixir_of_concentration",
        frame = "frames/necromancer_frames/necromancer_item_cardframe",
        xmlText = 
		[[
		<vlayout>
    <hlayout flexibleheight="2">
            <icon text="{expend}" fontsize="40" flexiblewidth="0"/>>
            <tmpro text="Perform a summoning." fontsize="34" flexiblewidth="10" />
    </hlayout>
</vlayout>
		]]
    })

    return createSkillDef({
        id = "cryptskill_skill",
        name = "Heart of Evil",
        types = { skillType },
        layout = cardLayout,
        layoutPath = "art/t_elixir_of_concentration",
        abilities = {
            createAbility({
                id = "lich_SJ_HoE_ab",
                trigger = uiTrigger,
                activations = singleActivation,
                layout = cardLayout,
				promptType = showPrompt,
				effect = randomTarget(const(1), moveTarget(inPlayPloc)).apply(selectLoc(loc(nil, nullPloc))).seq(noUndoEffect()),
				check = selectLoc(loc(nil, nullPloc)).count().gte(1),
				cost = expendCost,
            }),
			
        }
        
    })
end

function lich_SJ_DI_carddef()
    local cardLayout = createLayout({
        name = "Deep Insight",
        art = "art/t_elixir_of_wisdom",
        frame = "frames/necromancer_frames/necromancer_item_cardframe",
        xmlText = 
		[[
<vlayout>
<hlayout flexibleheight="2">
<icon text="{expend}" fontsize="40" flexiblewidth="0"/>>
<tmpro text="Draw a card,
then discard a card." fontsize="24" flexiblewidth="10" />
</hlayout>
</vlayout>
		]]
    })

    return createSkillDef({
        id = "cryptskill_skill",
        name = "Deep Insight",
        types = { skillType },
        layout = cardLayout,
        layoutPath = "art/t_elixir_of_wisdom",
        abilities = {
            createAbility({
                id = "lich_SJ_DI_ab",
                trigger = uiTrigger,
                activations = singleActivation,
                layout = cardLayout,
				promptType = showPrompt,
				effect = drawCardsEffect(1).seq(forceDiscard(1)),
				cost = expendCost,
            }),
			
        }
        
    })
end

function lich_SJ_IW_carddef()
    local cardLayout = createLayout({
        name = "Infernal Wealth",
        art = "art/t_elixir_of_endurance",
        frame = "frames/necromancer_frames/necromancer_item_cardframe",
        xmlText = 
		[[
<vlayout>
<hlayout flexibleheight="7.7">
            <tmpro text="{expend}" fontsize="50" flexiblewidth="1"/>
            <vlayout flexiblewidth="6">
                                <icon text="{gold_2}" fontsize="40" alignment="Center" flexibleheight="1"/>
                                <tmpro text="&lt;size=80%&gt;or
&lt;size=100%&gt;Stun an opposing champion." fontsize="26" alignment="Center" flexibleheight="6.6"/>          
            </vlayout>
    </hlayout>
</vlayout>
		]]
    })

    return createSkillDef({
        id = "cryptskill_skill",
        name = "Infernal Wealth",
        types = { skillType },
        layout = cardLayout,
        layoutPath = "art/t_elixir_of_endurance",
        abilities = {
            createAbility({
                id = "lich_SJ_IW_ab",
                trigger = uiTrigger,
                activations = singleActivation,
                layout = cardLayout,
				promptType = showPrompt,
				effect = pushChoiceEffect
				(
					{
						choices =
						{
							
							{
								effect = gainGoldEffect(2),
								layout = layoutCard(
									{
										title = "Infernal Wealth",
										art = "art/t_elixir_of_endurance",
										frame = "frames/necromancer_frames/necromancer_item_cardframe",
										xmlText = 
										[[
<vlayout>
<hlayout flexibleheight="1">
<box flexiblewidth="7">
<text text="{gold_2}" fontsize="60"/>
</box>
</hlayout>
</vlayout>
										]]
									}
								),
							},

							{
								effect = pushTargetedEffect({
									desc = "Stun target champion.",
									validTargets = oppStunnableSelector(),
									min = 0,
									max = 1,
									targetEffect = stunTarget(),
									}),
								condition = selectLoc(loc(oppPid, inPlayPloc)).where(isCardChampion()).count().gte(1),
								layout = layoutCard(
									{
										title = "Infernal Wealth",
										art = "art/t_elixir_of_endurance",
										frame = "frames/necromancer_frames/necromancer_item_cardframe",
										xmlText = 
										[[
<vlayout>
<hlayout flexibleheight="1">
<box flexiblewidth="7">
<text text="Stun target champion." fontsize="24"/>
</box>
</hlayout>
</vlayout>

										]]
									}
								),
							},
							
						}
					}
				),
				cost = expendCost,
            }),
			
        }
        
    })
end

function lich_SJ_UR_carddef()
    local cardLayout = createLayout({
        name = "Unending Rage",
        art = "art/treasures/t_wizard_elixir_orange",
        frame = "frames/necromancer_frames/necromancer_item_cardframe",
        xmlText = 
		[[
<vlayout>
<hlayout flexibleheight="2">
<icon text="{expend}" fontsize="40" flexiblewidth="0"/>>
<tmpro text="{combat_7}" fontsize="60" flexiblewidth="10" />
</hlayout>
</vlayout>
		]]
    })

    return createSkillDef({
        id = "cryptskill_skill",
        name = "Unending Rage",
        types = { skillType },
        layout = cardLayout,
        layoutPath = "art/treasures/t_wizard_elixir_orange",
        abilities = {
            createAbility({
                id = "lich_SJ_UR_ab",
                trigger = uiTrigger,
                activations = singleActivation,
                layout = cardLayout,
				promptType = showPrompt,
				effect = gainCombatEffect(7),
				cost = expendCost,
            }),
			
        }
        
    })
end

function lich_SJ_V_carddef()
    local cardLayout = createLayout({
        name = "Void",
        art = "art/treasures/t_wizard_elixir_silver",
        frame = "frames/necromancer_frames/necromancer_item_cardframe",
        xmlText = 
		[[
<vlayout>
<hlayout flexibleheight="2">
<icon text="{expend}" fontsize="40" flexiblewidth="0"/>>
<tmpro text="Deal 3 damage
to opponent." fontsize="24" flexiblewidth="10" />
</hlayout>
</vlayout>
		]]
    })

    return createSkillDef({
        id = "cryptskill_skill",
        name = "Void",
        types = { skillType },
        layout = cardLayout,
        layoutPath = "art/treasures/t_wizard_elixir_silver",
        abilities = {
            createAbility({
                id = "lich_SJ_V_ab",
                trigger = uiTrigger,
                activations = singleActivation,
                layout = cardLayout,
				promptType = showPrompt,
				effect = hitOpponentEffect(3),
				cost = expendCost,
            }),
			
        }
        
    })
end

function lich_SJ_M_carddef()
    local cardLayout = createLayout({
        name = "Manipulation",
        art = "art/treasures/t_wizard_elixir_orange",
        frame = "frames/necromancer_frames/necromancer_item_cardframe",
        xmlText = 
		[[
<vlayout>
<hlayout flexibleheight="2">
<icon text="{expend}" fontsize="40" flexiblewidth="0"/>>
<tmpro text="Acquire a card of cost four or less for free." fontsize="26" flexiblewidth="10" />
</hlayout>
</vlayout>
		]]
    })

    return createSkillDef({
        id = "cryptskill_skill",
        name = "Manipulation",
        types = { skillType },
        layout = cardLayout,
        layoutPath = "art/treasures/t_wizard_elixir_orange",
        abilities = {
            createAbility({
                id = "lich_SJ_M_ab",
                trigger = uiTrigger,
                activations = singleActivation,
                layout = cardLayout,
				promptType = showPrompt,
				effect = pushTargetedEffect({
				desc = "Acquire a card of cost four or less for free.",
				validTargets = selectLoc(centerRowLoc).union(selectLoc(fireGemsLoc)).where(isCardAcquirable().And(getCardCost().lte(4))),
				min = 0,
				max = 1,
				targetEffect = moveTarget(loc(currentPid, discardPloc)),
				}),
				cost = expendCost,
            }),
			
        }
        
    })
end



-- Demonologist cards
function demonologist_shadow_gem_carddef()
    return createDef(
        {
            id = "demonologist_shadow_gem",
            name = "Shadow Gem",
            types = {gemType, noStealType, itemType},
			            acquireCost = 0,
            cardTypeLabel = "Item",
            playLocation = castPloc,
            abilities = {
				createAbility(
                    {
                        id = "demonologist_shadow_gem_sac",
                        PlayAllType = noPlayPlayType,
						cost = noCost,
						trigger = autoTrigger,
                        activations = singleActivations,
						                        effect = pushChoiceEffect(
                                {
                                    choices = {
                                        {
                                            effect = gainGoldEffect(2),
                                            layout = layoutCard(
                                                {
                                                    title = "Shadow Gem",
                                                    art = "art/treasures/thief_brillant_ruby",
                                                    xmlText=[[
													<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="7">
            <icon text="{gold_2}" fontsize="60"/>
</box>
</hlayout>
</vlayout>
													]]
                                                }
                                            ),
                                            tags = {gainCombatTag}
                                        },
                                        {
                                            effect = pushTargetedEffect({
												desc = "Lose <sprite name=\"health_1\"> to give one minion +2 <sprite name=\"shield\"> until your next turn.",
												validTargets = selectLoc(currentInPlayLoc).where(isCardType(minionType)),
												min = 0,
												max = 1,
												check = minHealthCurrent(2),
												targetEffect = grantHealthTarget(2, { SlotExpireEnum.startOfOwnerTurn }, nullEffect(), "shadow").seq(hitSelfEffect(1)),
												}),
                                            layout = layoutCard(
                                                {
                                                    title = "Shadow Gem",
                                                    art = "art/treasures/thief_brillant_ruby",
                                                    xmlText=[[
<vlayout>
    <box flexibleheight="1">
        <tmpro text="{health_-1}" fontsize="42"/>
    </box>
    <box flexibleheight="1">
        <tmpro text="Give one minion +2{shield} until your next turn." fontsize="24" />
    </box>
</vlayout>
													]]
                                                }
                                            ),
                                                                                    }
                                    }
                                }
                        ),
                        tags = {}
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Shadow Gem",
                    art = "art/treasures/thief_brillant_ruby",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
    <box flexibleheight="2">
        <tmpro text="{gold_2}" fontsize="42"/>
    </box>
    <box flexibleheight="3">
        <tmpro text="OR
{health_-1} Give one minion +2{shield} until your next turn." fontsize="24" />
    </box>
</vlayout>
					]]
                }
            )
        }
    )
end

function demonologist_shadow_feeder_carddef()
    return createChampionDef(
        {
            id = "demonologist_shadow_feeder",
            name = "Shadow Feeder",
			types = {minionType, demonType, championType, nosteaalType},
            acquireCost = 0,
            health = 1,
            isGuard = false,
            abilities = {
                createAbility(
                    {
                        id = "Shadow_feeder_main",
                        trigger = uiTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = ifElseEffect(selectLoc(currentInPlayLoc).where(isCardType(demonType)).count().gte(2),gainCombatEffect(3),gainCombatEffect(1))
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Shadow Feeder",
                    art = "art/epicart/deathbringer",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
<hlayout flexibleheight="7.7">
            <tmpro text="{expend}" fontsize="40" flexiblewidth="1"/>
            <vlayout flexiblewidth="6">
                                <icon text="{combat_1}" fontsize="40" alignment="Center" flexibleheight="1"/>
                                <tmpro text="+{combat_2}  if you have another Demon in play." fontsize="26" alignment="Center" flexibleheight="6.6"/>          
            </vlayout>
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

function demonologist_void_guard_carddef()
    return createChampionDef(
        {
            id = "demonologist_void_guard",
            name = "Void guard",
			types = {minionType, championType, demonType, nosteaalType},
            acquireCost = 0,
            health = 2,
            isGuard = true,
            abilities = {
                createAbility(
                    {
                        id = "void_guard_main",
                        trigger = autoTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = gainCombatEffect(1)
						
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Void guard",
                    art = "art/T_Midnight_Knight",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
    <hlayout flexibleheight="3">
            <tmpro text="{expend}" fontsize="50" flexiblewidth="2"/>
            <tmpro text="{combat_1}" fontsize="50" flexiblewidth="12" />
    </hlayout>
    <divider/>
    <hlayout flexibleheight="2">
            <tmpro text="You can't a-void him." fontsize="20" fontstyle="italic" flexiblewidth="10" />
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

function demonologist_lesser_devourer_carddef()
    return createChampionDef(
        {
            id = "demonologist_lesser_devourer",
            name = "Lesser Devourer",
			types = {minionType, championType, demonType, nosteaalType},
            acquireCost = 0,
            health = 2,
            isGuard = true,
            abilities = {
                createAbility(
                    {
                        id = "lesser_devourer_main",
                        trigger = uiTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = hitSelfEffect(1).seq(grantHealthTarget(1, { SlotExpireEnum.LeavesPlay }, nullEffect(), "shadow").apply(selectSource())),
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Lesser Devourer",
                    art = "art/T_Demon",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText = [[
<vlayout>
<hlayout flexibleheight="7.7">
            <tmpro text="{expend}" fontsize="40" flexiblewidth="1"/>
            <vlayout flexiblewidth="6">
                                <icon text="{health_-1}" fontsize="40" alignment="Center" flexibleheight="1"/>
                                <tmpro text="Lesser Devourer gains +1{shield} until it leaves play." fontsize="26" alignment="Center" flexibleheight="6.6"/>          
            </vlayout>
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

function demonologist_summon_demon_carddef()
    local cardLayout = createLayout({
        name = "Summon",
        art = "icons/The_Summoning",
        frame = "frames/necromancer_frames/necromancer_item_cardframe",
		xmlText=[[
		<vlayout>
    <hlayout flexibleheight="2">
        <box flexiblewidth="1">
            <tmpro text="{expend_2}" fontsize="62"/>
        </box>
        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="&lt;size=130%&gt;{health_-1}
&lt;size=100%&gt;Randomly summon 1 of 3 demon tokens into play." fontsize="20" />
            </box>
        </vlayout>
    </hlayout>
    <divider/>
    <hlayout flexibleheight="1">
        <box flexiblewidth="7">
            <tmpro text="Summoned demons have 1{shield}." fontsize="20" />
        </box>
    </hlayout>
</vlayout>
		]]
    })

 return createSkillDef({
        id = "demonologist_summon_demon_skill",
        name = "Summon Demon",
        types = { skillType },
        layout = cardLayout,
        layoutPath = "icons/The_Summoning",
        abilities = {
            createAbility({
                id = "demonologist_summon_demon_ab",
                trigger = uiTrigger,
				check = minHealthCurrent(2),
                activations = singleActivation,
                layout = cardLayout,
                promptType = showPrompt,
                effect =pushChoiceEffectWithTitle(
                                {
                                    choices = {
                                        {
                                            effect = hitSelfEffect(1).seq(randomEffect({
					valueItem(1, createCardEffect(demonologist_demonic_leech_carddef(), currentInPlayLoc)),
					valueItem(1, createCardEffect(demonologist_succubus_carddef(), currentInPlayLoc)),
					valueItem(1, createCardEffect(demonologist_fel_hound_carddef(), currentInPlayLoc))
})).seq(noUndoEffect()),
                                            layout = createLayout(
                {
                    name = "Demonic leech",
                    art = "art/T_wurm",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
					xmlText = [[
<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{expend}" fontsize="40"/>
        </box>
        <box flexiblewidth="7">
            <tmpro text="Deal 1 damage to opponent. 
Demonic Leech gains 1{shield} until it leaves play. " fontsize="18"/>

</box>
</hlayout>

<divider/>
<hlayout flexibleheight="1">
        <box flexiblewidth="7">
            <tmpro text="Explode: If this card has 6{shield} or more at the start of a turn, immediately deal 5 damage to opponent and sacrifice this card. " fontsize="16"/>
</box>
</hlayout>
</vlayout>
					]],
					health = 1,
                    isGuard = false
                }
            ),
                                            tags = {gainCombatTag}
                                        },
                                        
										{
                                           effect = hitSelfEffect(1).seq(randomEffect({
					valueItem(1, createCardEffect(demonologist_demonic_leech_carddef(), currentInPlayLoc)),
					valueItem(1, createCardEffect(demonologist_succubus_carddef(), currentInPlayLoc)),
					valueItem(1, createCardEffect(demonologist_fel_hound_carddef(), currentInPlayLoc))
})).seq(noUndoEffect()),
                                            layout = createLayout(
                {
                    name = "Fel hound",
                    art = "art/epicart/demon_token",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{expend}" fontsize="40"/>
        </box>
        <box flexiblewidth="7">
            <icon text="{combat_2}" fontsize="60"/>
</box>
</hlayout>
</vlayout>
					]],
                    health = 1,
                    isGuard = false
                }
            ),
                                            tags = {gainCombatTag}
                                        },
										
										{
                                            effect = hitSelfEffect(1).seq(randomEffect({
					valueItem(1, createCardEffect(demonologist_demonic_leech_carddef(), currentInPlayLoc)),
					valueItem(1, createCardEffect(demonologist_succubus_carddef(), currentInPlayLoc)),
					valueItem(1, createCardEffect(demonologist_fel_hound_carddef(), currentInPlayLoc))
})).seq(noUndoEffect()),
                                            layout = createLayout(
                {
                    name = "Succubus",
                    art = "art/epicart/Succubus",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{expend}" fontsize="40"/>
        </box>
        <box flexiblewidth="7">
            <tmpro text="Give target champion -1{shield} permanently.
&lt;size=50%&gt;
&lt;size=70%&gt;(Cannot reduce below 1{shield}.)" fontsize="25"/>
</box>
</hlayout>
<box flexiblewidth="7">
            <tmpro text="" fontsize="18"/>
</box>
</vlayout>
					]],
                    health = 1,
                    isGuard = false
                }
            ),
                                                                                    }
                                    },
					upperTitle = "Summon one of these 3 demon tokens, randomly.",
					lowerTitle = "Click any card to proceed."
					}),
				cost = goldCost(2),
			}),
        },
		layout = createLayout(
                {
                    name = "Summon Demon",
                    art = "icons/The_Summoning",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
    <hlayout flexibleheight="2">
        <box flexiblewidth="1">
            <tmpro text="{expend_2}" fontsize="62"/>
        </box>
        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="&lt;size=130%&gt;{health_-1}
&lt;size=100%&gt;Randomly summon 1 of 3 demon tokens into play." fontsize="20" />
            </box>
        </vlayout>
    </hlayout>
    <divider/>
    <hlayout flexibleheight="1">
        <box flexiblewidth="7">
            <tmpro text="Summoned demons have 1{shield}." fontsize="20" />
        </box>
    </hlayout>
</vlayout>
					]]
                }
            )
        
    })
end

function demonologist_demonic_leech_carddef()
    return createChampionDef(
        {
            id = "demonologist_demonic_leech",
            name = "Demonic leech",
			types = {minionType, championType, demonType, nostealType, tokenType},
            acquireCost = 0,
            health = 1,
            isGuard = false,
            abilities = {
                createAbility(
                    {
                        id = "demonic_leech_main",
                        trigger = autoTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = hitOpponentEffect(1)
								.seq((grantHealthTarget(1, { SlotExpireEnum.LeavesPlay }, nullEffect(), "shadow")).apply(selectSource()))
                    }
                ),
				createAbility(
                    {
                        id = "demonic_leech_explode",
                        trigger = startOfTurnTrigger,
                        cost = noCost,
                        activations = singleActivations,
                        effect = ifElseEffect(selectLoc(currentInPlayLoc).where(isCardSelf().And(getCardHealth().gte(5))).count().gte(1), 
							hitOpponentEffect(5).seq(sacrificeTarget().apply(selectSource())),
							nullEffect()), 
                    }),
					
				createAbility(
                    {
                        id = "demonic_leech_sac",
                        trigger = onLeavePlayTrigger,
                        cost = sacrificeSelfCost,
                        activations = singleActivations,
                        effect = nullEffect()
					}	
                    
                )
            },
            layout = createLayout(
                {
                    name = "Demonic leech",
                    art = "art/T_wurm",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
					xmlText = [[
<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{expend}" fontsize="40"/>
        </box>
        <box flexiblewidth="7">
            <tmpro text="Deal 1 damage to opponent. 
Demonic Leech gains 1{shield} until it leaves play. " fontsize="18"/>

</box>
</hlayout>

<divider/>
<hlayout flexibleheight="1">
        <box flexiblewidth="7">
            <tmpro text="Explode: If this card has 6{shield} or more at the start of a turn, immediately deal 5 damage to opponent and sacrifice this card. " fontsize="16"/>
</box>
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

function demonologist_fel_hound_carddef()
--This is a token champion, that self-sacrifices when it leaves play
    return createChampionDef(
        {
            id = "demonologist_fel_hound",
            name = "Fel hound",
			types = {minionType, championType, demonType, nostealType, tokenType},
            acquireCost = 0,
            health = 1,
            isGuard = false,
            abilities = {
			--base ability
                createAbility(
                    {
                        id = "fel_hound_main",
                        trigger = autoTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = gainCombatEffect(2)
						
                    }
                )
            ,
			--self-sac ability
                createAbility(
                    {
                        id = "fel_hound_sac",
                        trigger = onLeavePlayTrigger,
                        cost = sacrificeSelfCost,
                        activations = singleActivations,
                        effect = nullEffect()
					}	
                    
                )},
            layout = createLayout(
                {
                    name = "Fel hound",
                    art = "art/epicart/demon_token",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{expend}" fontsize="40"/>
        </box>
        <box flexiblewidth="7">
            <icon text="{combat_2}" fontsize="60"/>
</box>
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

function demonologist_succubus_carddef()
    return createChampionDef(
        {
            id = "demonologist_succubus",
            name = "Succubus",
			types = {minionType, championType, demonType, nostealType, tokenType},
            acquireCost = 0,
            health = 1,
            isGuard = false,
            abilities = {
                createAbility(
                    {
                        id = "succubus_main",
                        trigger = uiTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = pushTargetedEffect({
                                                desc = "Give target champion -1<sprite name=\"shield\"> permanently.",
                                                validTargets = oppStunnableSelector().where(isCardChampion().And(getCardHealth().gte(2))),
                                                min = 0,
                                                max = 1,
                                                targetEffect = (grantHealthTarget(-1, { SlotExpireEnum.never }, nullEffect(), "shadow")),
                                                }),
														
                    }
                )
            ,
			--self-sac ability
                createAbility(
                    {
                        id = "fel_hound_sac",
                        trigger = onLeavePlayTrigger,
                        cost = sacrificeSelfCost,
                        activations = singleActivations,
                        effect = nullEffect()
					}	
                    
                )},
            layout = createLayout(
                {
                    name = "Succubus",
                    art = "art/epicart/Succubus",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{expend}" fontsize="40"/>
        </box>
        <box flexiblewidth="7">
            <tmpro text="Give target champion -1{shield} permanently.
&lt;size=50%&gt;
&lt;size=70%&gt;(Cannot reduce below 1{shield}.)" fontsize="25"/>
</box>
</hlayout>
<box flexiblewidth="7">
            <tmpro text="" fontsize="18"/>
</box>
</vlayout>
					]],
                    health = 1,
                    isGuard = false
                }
            )
        }
    )
end

function demonologist_summon_demon_master_carddef()
    local cardLayout = createLayout({
        name = "Summon Demon Master",
        art = "art/T_Angry_Skeleton",
        frame = "frames/necromancer_frames/necromancer_item_cardframe",
		xmlText=[[
<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="2">
            <tmpro text="{scrap}" fontsize="50"/>
        </box>
        <box flexiblewidth="7">
            <tmpro text="Put the Demon
Master into play.
&lt;size=70%&gt;
(It has {combat_1} and 4{shield} and can prepare up to 2 other demon minions.)" fontsize="24" flexiblewidth="10" />
</box>
</hlayout>
</vlayout>
		]]
    })

    return createSkillDef({
        id = "demonologist_summon_demon_master_ability",
        name = "Summon Demon Master",
        types = { skillType },
        layout = cardLayout,
        layoutPath = "art/T_Angry_Skeleton",
        abilities = {
            createAbility({
                id = "demonologist_summon_demon_master_ab",
                trigger = uiTrigger,
                activations = singleActivation,
                layout = cardLayout,
                promptType = showPrompt,
                effect = createCardEffect(demonologist_demon_master_carddef(), currentInPlayLoc),
				cost = sacrificeSelfCost,
			}),
        },
		layout = createLayout(
                {
                    name = "Summon Demon Master",
                    art = "art/T_Angry_Skeleton",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="2">
            <tmpro text="{scrap}" fontsize="50"/>
        </box>
        <box flexiblewidth="7">
            <tmpro text="Put the Demon
Master into play.
&lt;size=70%&gt;
(It has {combat_1} and 4{shield} and can prepare up to 2 other demon minions.)" fontsize="24" flexiblewidth="10" />
</box>
</hlayout>
</vlayout>
					]]
                }
            )
        
    })
end

function demonologist_incubus_carddef()
    return createChampionDef(
        {
            id = "demonologist_incubus",
            name = "Incubus",
			types = {championType, demonType, minionType, nostealType},
            acquireCost = 0,
            health = 4,
            isGuard = false,
            abilities = {
                createAbility(
                    {
                        id = "demonologist_incubus_main",
                        trigger = uiTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = gainCombatEffect(3).seq(gainCombatEffect(getCounter("incubus")))
                    }
                ),
				
				createAbility(
                    {
                        id = "demonologist_incubus_main",
                        trigger = startOfTurnTrigger,
                        cost = noCost,
                        activations = multipleActivations,
                        effect = incrementCounterEffect("incubus", 1)
                    }
                ),
			
			createAbility(
                    {
                        id = "demonologist_incubus_sac",
                        trigger = onLeavePlayTrigger,
                        cost = sacrificeSelfCost,
                        activations = multipleActivations,
                        effect = nullEffect()
					}	
                    
                )
            },
            layout = createLayout({
            name = "Incubus",
            art = "art/epicart/guilt_demon",
            frame = "frames/necromancer_frames/necromancer_item_cardframe",
            xmlText = [[
			<vlayout>
    <hlayout flexibleheight="1">
            <tmpro text="{expend}" fontsize="50" flexiblewidth="2"/>
            <icon text="{combat_3}" fontsize="50" flexiblewidth="10" />
    </hlayout>
    <divider/>
    <hlayout flexibleheight="3">
            <tmpro text="Incubus gains {combat_1} (permanently) at the start of each turn." fontsize="20" flexiblewidth="10" />
    </hlayout> 
</vlayout>
]],
					health = 4,
                    isGuard = false
        })
        }
    )
end

function demonologist_keeper_of_the_void_carddef()
    return createChampionDef(
        {
            id = "demonologist_keeper_of_the_void",
            name = "Keeper of the Void",
			types = {championType, demonType, minionType, nostealType},
            acquireCost = 0,
            health = 4,
            isGuard = true,
            abilities = {
                createAbility(
                    {
                        id = "demonologist_keeper_of_the_void_main",
                        trigger = uiTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = gainCombatEffect(2)
						.seq(grantHealthTarget(divide(getCounter(selectLoc(loc(currentPid, inPlayPloc)).where(isCardType("minion").And(isCardName("demonologist_keeper_of_the_void").invert())).count()), 2), { SlotExpireEnum.startOfOwnerTurn }, nullEffect(), "Void Keeper").apply(selectSource())),
                    }
                ),
				
			createAbility(
                    {
                        id = "demonologist_keeper_of_the_void_sac",
                        trigger = onLeavePlayTrigger,
                        cost = sacrificeSelfCost,
                        activations = multipleActivations,
                        effect = nullEffect()
					}	
                    
                )
            },
            layout = createLayout({
            name = "Keeper of the Void",
            art = "art/epicart/spawning_demon",
            frame = "frames/necromancer_frames/necromancer_item_cardframe",
            xmlText = [[
			<vlayout>
    <hlayout flexibleheight="1">
            <tmpro text="{expend}" fontsize="40" flexiblewidth="2"/>
            <icon text="{combat_2}" fontsize="40" flexiblewidth="10" />
    </hlayout>
    <hlayout flexibleheight="7">
            <tmpro text="Keeper of the Void gains +1{shield} for every 2 other demon minions in play (round down) until your next turn." fontsize="20" flexiblewidth="10" />
    </hlayout> 
</vlayout>
]],
					health = 4,
                    isGuard = true
        })
        }
    )
end

function demonologist_demon_master_carddef()
    return createChampionDef(
        {
            id = "demonologist_demon_master",
            name = "Demon Master",
			types = {championType, demonType, minionType, nostealType},
            acquireCost = 0,
            health = 4,
            isGuard = false,
            abilities = {
                createAbility(
                    {
                        id = "demonologist_demon_master_main",
                        trigger = uiTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = gainCombatEffect(1).seq(pushTargetedEffect({
                    desc = "Prepare up to 2 other demon minions in play.",
                    validTargets = selectLoc(currentInPlayLoc).where(isCardType(minionType).And(isCardName("demonologist_demon_master").invert())),
                    min = 0,
                    max = 2,
                    targetEffect = prepareTarget()
				
            }))
                    }
                ),
							createAbility(
                    {
                        id = "demonologist_demon_master_sac",
                        trigger = onLeavePlayTrigger,
                        cost = sacrificeSelfCost,
                        activations = multipleActivations,
                        effect = nullEffect()
					}	
                    
                )
            },
            layout = createLayout({
            name = "Demon Master",
            art = "art/T_Angry_Skeleton",
            frame = "frames/necromancer_frames/necromancer_item_cardframe",
            xmlText = [[
			<vlayout>
    <hlayout flexibleheight="1">
            <tmpro text="{expend}" fontsize="50" flexiblewidth="2"/>
            <icon text="{combat_1}" fontsize="50" flexiblewidth="10" />
    </hlayout>
      <hlayout flexibleheight="3">
            <tmpro text="Prepare up to 2 other demon minions." fontsize="20" flexiblewidth="10" />
    </hlayout> 
</vlayout>
]],
					health = 4,
                    isGuard = false
        })
        }
    )
end

-- Apothecary cards
function apothecary_mezzaluna_carddef()
    return createDef(
        {
            id = "apothecary_mezzaluna",
            name = "Mezzaluna",
            types = {noStealType, itemType},
            acquireCost = 0,
            cardTypeLabel = "Item",
            playLocation = castPloc,
            abilities = {
                createAbility({
                        id = "apothecary_mezzaluna",
                        layout = cardLayout,
                        effect = gainCombatEffect(2),
                        trigger = autoTrigger,
                        tags = {}
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Mezzaluna",
                    art = "art/T_Spell_Components",
                    frame = "frames/Wizard_CardFrame",
                    xmlText=[[
					<vlayout forceheight="false" spacing="6">
    <hlayout spacing="10">
       <icon text="{combat_2}" fontsize="50"/>
    </hlayout>    
</vlayout>
					]],
                }
            )
        }
    )
end

function apothecary_apprentice_potion_maker_carddef()
    return createChampionDef(
        {
            id = "apothecary_apprentice_potion_maker",
            name = "Apprentice Potion Maker",
			types = {championType, nostealType},
            acquireCost = 0,
            health = 1,
            isGuard = false,
            abilities = {
                createAbility(
                    {
                        id = "apprentice_potion_maker_main",
                        trigger = uiTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = pushChoiceEffect(
                                {
                                    choices = {
                                        {
                                            effect = gainGoldEffect(1),
                                            layout = layoutCard(
                                                {
                                                    title = "Apprentice Potion Maker",
                                                    art = "art/T_Thief_Shadow_Mask",
                                                    xmlText=[[
													<vlayout forceheight="false" spacing="6">
    <hlayout spacing="10">
       <icon text="{gold_1}" fontsize="50"/>
    </hlayout>    
</vlayout>
													]]
                                                }
                                            ),
                                            tags = {gainGold1Tag}
                                        },
                                        {
                                            effect = pushTargetedEffect({
												  desc="Move a potion from your discard to the top of your deck.",
												  min=0,
												  max=1,
												  validTargets= selectLoc(loc(currentPid, discardPloc)).where(isCardType("Elixir")),
												  targetEffect= moveTarget(currentDeckLoc),
												  tags = {}
}),
											
                                            layout = layoutCard(
                                                {
                                                    title = "Apprentice Potion Maker",
                                                    art = "art/T_Thief_Shadow_Mask",
                                                    xmlText=[[
													<vlayout forceheight="false" spacing="6">
    <hlayout spacing="10">
       <text text="Move a potion from  your discard to the top of your deck." fontsize="24"/>
    </hlayout>    
</vlayout>
													]]
                                                }
                                            ),
                                                                                    }
                                    }
                                }
                        )
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Apprentice Potion Maker",
                    art = "art/T_Thief_Shadow_Mask",
                    frame = "frames/Wizard_CardFrame",
                    xmlText=[[
					<vlayout>
    <box flexibleheight="2">
        <tmpro text="{gold_1}" fontsize="42"/>
    </box>
    <box flexibleheight="3">
        <tmpro text="OR
Move a potion from  your discard to the top of your deck." fontsize="22" />
    </box>
</vlayout>
]],
                    health = 1,
                    isGuard = false
                }
            )
        }
    )
end

function apothecary_red_potion_carddef()
    return createDef({
        id="apothecary_red_potion",
        name="Red Potion",
        types={noStealType, itemType, elixirType},
        acquireCost=0,
		cardTypeLabel = "Item",
		playLocation = castPloc,
        abilities = {
            createAbility({
                id="apothecary_red_potion",
                trigger= autoTrigger,
                effect = gainCombatEffect(2)
            }),
			createAbility({
                id="apothecary_red_potion_combo",
                trigger= autoTrigger,
				prompt = showPrompt,
				cost = noCost,
				activations = singleActivations,
				check = selectLoc(loc(currentPid, castPloc)).where(isCardName("apothecary_yellow_potion")).count().gte(1),
                effect = oppDiscardEffect(1),
            })
        },
        layout = createLayout({
            name = "Red potion",
            art = "art/T_Elixir_of_strength",
            frame = "frames/Wizard_CardFrame",
            xmlText=[[
			<vlayout>
    <box flexibleheight="4">
        <tmpro text="{combat_2}" fontsize="42"/>
    </box>
    <box flexibleheight="3">
        <tmpro text="If you have yellow potion in play, opponent discards a card." fontsize="22" />
    </box>
</vlayout>
			]]
        })
    })
	end

function apothecary_green_potion_carddef()
    return createDef({
        id="apothecary_green_potion",
        name="Green Potion",
        types={noStealType, itemType, elixirType},
		cardTypeLabel = "Item",
		playLocation = castPloc,
        acquireCost=0,
        abilities = {
            createAbility({
                id="apothecary_green_potion",
                trigger= autoTrigger,
                effect = gainHealthEffect(2)
            }),
			createAbility({
                id="apothecary_green_potion_combo",
				cost = noCost,
                trigger= uiTrigger,
				promptType = showPrompt,
					layout = createLayout({
					name = "Green Potion",
					art = "art/treasures/T_Green_Potions_Medium",
					frame = "frames/Wizard_CardFrame",
					xmlText=[[
					<vlayout>
    <box flexibleheight="4">
        <tmpro text="{health_2}" fontsize="42"/>
    </box>
    <box flexibleheight="3">
        <tmpro text="If you have a red potion in play, draw a card." fontsize="22" />
    </box>
</vlayout>
]]
					}),
				activations = singleActivations,
				check = selectLoc(loc(currentPid, castPloc)).where(isCardName("apothecary_red_potion")).count().gte(1),
                effect = drawCardsEffect(1),
            })
        },
        layout = createLayout({
            name = "Green Potion",
            art = "art/treasures/T_Green_Potions_Medium",
            frame = "frames/Wizard_CardFrame",
            xmlText=[[
			<vlayout>
    <box flexibleheight="4">
        <tmpro text="{health_2}" fontsize="42"/>
    </box>
    <box flexibleheight="3">
        <tmpro text="If you have a red potion in play, draw a card." fontsize="22" />
    </box>
</vlayout>
			]]
        })
    })
	end

function apothecary_yellow_potion_carddef()
    return createDef({
        id="apothecary_yellow_potion",
        name="Yellow Potion",
        types={noStealType, itemType, elixirType},
        acquireCost=0,
		cardTypeLabel = "Item",
		playLocation = castPloc,
        abilities = {
            createAbility({
                id="apothecary_yellow_potion",
                trigger= autoTrigger,
                effect = gainGoldEffect(2)
            }),
			createAbility({
                id="apothecary_yellow_potion_combo",
                trigger= autoTrigger,
				prompt = showPrompt,
				layout = layoutCard({
					name = "yellow Potion",
					art = "art/T_Elixir_of_fortune",
					frame = "frames/Wizard_CardFrame",
					xmlText=[[
					<vlayout>
    <box flexibleheight="4">
        <tmpro text="{gold_2}" fontsize="42"/>
    </box>
    <box flexibleheight="4">
        <tmpro text="If you have a green potion in play, gain 2 Toughness." fontsize="22" />
    </box>
</vlayout>
]]
							}),
				cost = noCost,
				activations = singleActivations,
				check = selectLoc(loc(currentPid, castPloc)).where(isCardName("apothecary_green_potion")).count().gte(1),
                effect = gainToughnessEffect(2),

            })
        },
        layout = createLayout({
            name = "yellow Potion",
            art = "art/T_Elixir_of_fortune",
            frame = "frames/Wizard_CardFrame",
            xmlText=[[
					<vlayout>
    <box flexibleheight="4">
        <tmpro text="{gold_2}" fontsize="42"/>
    </box>
    <box flexibleheight="4">
        <tmpro text="If you have a green potion in play, gain 2 Toughness." fontsize="22" />
    </box>
</vlayout>
]]
        })
    })
	end

function apothecary_custom_brew_carddef()
	return createHeroAbilityDef({
		id = "custom_brew",
		name = "Custom Brew",
		types = { heroAbilityType },
        abilities = {
			createAbility({
				id = "custom_brewActivate",
				trigger = uiTrigger,
				promptType = showPrompt,
				layout = createLayout({
					name = "Custom Brew",
					art = "art/T_Elixir_of_concentration",
					frame = "frames/Wizard_CardFrame",
					xmlText = [[	
<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{scrap}" fontsize="36"/>
        </box>
        <box flexiblewidth="7">
            <tmpro text="{combat_5}&lt;size=60%&gt; OR &lt;/size&gt;{health_6}&lt;size=60%&gt;
OR
Draw 1 and opponent discards 1." fontsize="40" />
        </box>
    </hlayout>
</vlayout>
					]]					
				}),
				effect =
				pushChoiceEffect(
                                {
                                    choices = {
                                        {
                                            effect = gainCombatEffect(5),
                                            layout = layoutCard(
                                                {
                                                    title = "Custom Brew",
                                                    art = "art/T_Elixir_of_concentration",
													frame = "frames/Wizard_CardFrame",
                                                    xmlText = [[
													<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="7">
            <tmpro text="{combat_5}&lt;size=60%&gt;" fontsize="46" />
        </box>
    </hlayout>
</vlayout>
]]
                                                }
                                            ),
                                            tags = {gainCombat6Tag}
                                        },
										{
                                            effect = gainHealthEffect(6),
                                            layout = layoutCard(
                                                {
                                                    title = "Custom Brew",
                                                    art = "art/T_Elixir_of_concentration",
													frame = "frames/Wizard_CardFrame",
                                                    xmlText = [[
													<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="7">
            <tmpro text="{health_6}&lt;size=60%&gt;" fontsize="46" />
        </box>
    </hlayout>
</vlayout>
]]
                                                }
                                            ),
                                            tags = {gainHealthTag}
                                        },
                                        {
                                            effect = drawCardsEffect(1).seq(oppDiscardEffect(1)),
                                            layout = layoutCard(
                                                {
                                                    title = "Custom Brew",
                                                    art = "art/T_Elixir_of_concentration",
													frame = "frames/Wizard_CardFrame",
                                                    xmlText = [[
													<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="7">
            <tmpro text="Draw 1.
Opponent discards 1." fontsize="28" />
        </box>
    </hlayout>
</vlayout>
]]
                                                }
                                            ),
                                                                                    }
                                    }
                                }
                        ),
				cost = sacrificeSelfCost
			})
		},
        layout = createLayout({
            name = "Custom Brew",	
            art = "art/T_Elixir_of_concentration",
			frame = "frames/Wizard_CardFrame",
            text = "<sprite name=\"combat_5\"> or <sprite name=\"health_6\">  or Draw 1 and opponent discards 1."
        }),
        layoutPath  = "art/T_Elixir_of_concentration",
	})
end	

function apothecary_restorative_draught_carddef()
    local cardLayout = createLayout({
        name = "Restorative Draught",
        art = "art/treasures/T_ranger_elixir_yellow",
        frame = "frames/Wizard_CardFrame",
		xmlText = [[
		<vlayout>
			<hlayout flexibleheight="1">
				<box flexiblewidth="1">
					<tmpro text="{expend_2}" fontsize="72"/>
				</box>
				<box flexiblewidth="7">
					<tmpro text="Put a champion or action of cost {gold_3} or less from your discard on top of your deck." fontsize="22" />
				</box>
			</hlayout>
		</vlayout>
		]]
    })

    return createSkillDef({
        id = "apothecary_restorative_draught_skill",
        name = "Restorative Draught",
        types = { skillType },
        layout = cardLayout,
        layoutPath = "art/treasures/T_ranger_elixir_yellow",
        abilities = {
            createAbility({
                id = "apothecary_restorative_draught_ab",
                trigger = uiTrigger,
                activations = singleActivation,
                layout = cardLayout,
				promptType = showPrompt,
                effect = pushTargetedEffect({
												  desc="Put a champion or action of cost 3g or less from your discard on top of your deck.",
												  min=0,
												  max=1,
												  validTargets= selectLoc(loc(currentPid, discardPloc)).where((isCardAction().Or(isCardChampion())).And(getCardCost().lte(3))),
												  targetEffect= moveTarget(currentDeckLoc),
												  tags = {}
												}),
                cost = goldCost(2),
            }),
        }
        
    })
end


-- Cryomancer cards
function cryomancer_ice_burst_carddef()
    return createDef(
        {
            id = "cryomancer_ice_burst",
            name = "Ice Burst",
            types = {noStealType, actionType},
            acquireCost = 0,
            cardTypeLabel = "Action",
            playLocation = castPloc,
            abilities = {
                createAbility({
                        id = "cryomancer_ice_burst",
                        layout = cardLayout,
                        effect = gainCombatEffect(2),
                        trigger = autoTrigger,
                        tags = {}
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Ice Burst",
                    art = "art/epicart/force_lance",
                    frame = "frames/Wizard_CardFrame",
                    xmlText=[[
<vlayout>
    <box flexibleheight="7">
        <tmpro text="{combat_2}" fontsize="42"/>
    </box>
<divider/>
    <box flexibleheight="3">
        <tmpro text="'Have an ice day.'" fontsize="20" fontstyle="italic"/>
    </box>
</vlayout>
					]],
                }
            )
        }
    )
end

function cryomancer_ice_shield_carddef()
    return createDef(
        {
            id = "cryomancer_ice_shield",
            name = "Ice Shield",
            types = {noStealType, actionType},
            acquireCost = 0,
            cardTypeLabel = "Action",
            playLocation = castPloc,
            abilities = {
                createAbility({
                        id = "cryomancer_ice_shield",
                        layout = cardLayout,
                        effect = ifElseEffect(selectLoc(loc(currentPid, castPloc)).where(isCardAction()).count().gte(3), gainToughnessEffect(2).seq(gainCombatEffect(2)), gainToughnessEffect(2)),
                        trigger = autoTrigger,
                        tags = {}
                    }
                ),
				
            },
            layout = createLayout(
                {
                    name = "Ice Shield",
                    art = "art/epicart/force_field",
                    frame = "frames/Wizard_CardFrame",
                    xmlText = [[
<vlayout forceheight="false" spacing="6">
<hlayout spacing="10">
<text text="Gain 2 Toughness." fontsize="28"/>   
</hlayout>    
<hlayout spacing="10">
<text text="If you have 2 other actions in play, also gain {combat_2}." fontsize="22"/>    
</hlayout>
</vlayout>]],
                }
            )
        }
    )
end

function cryomancer_ice_gem_carddef()
    return createDef(
        {
            id = "cryomancer_ice_gem",
            name = "Ice Gem",
            types = {gemType, noStealType, itemType},
            acquireCost = 0,
            cardTypeLabel = "Item",
            playLocation = castPloc,
            abilities = {
                createAbility(
                    {
                        id = "cryomancer_ice_gem",
                        layout = cardLayout,
                        effect =
                        pushChoiceEffect(
                                {
                                    choices = {
                                        {
                                            effect = gainGoldEffect(2),
                                            layout = layoutCard(
                                                {
                                                    title = "Ice Gem",
                                                    art = "art/T_Wizard_Alchemist_S_Stone",
                                                    xmlText=[[
													<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="7">
            <tmpro text="{gold_2}&lt;size=60%&gt;" fontsize="46" />
        </box>
    </hlayout>
</vlayout>
]]
                                                }
                                            ),
                                            tags = {gainGold2Tag}
                                        },
                                        {
                                            effect = oppDiscardEffect(1),
                                            layout = layoutCard(
                                                {
                                                    title = "Ice Gem",
                                                    art = "art/T_Wizard_Alchemist_S_Stone",
                                                    xmlText=[[
													<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="7">
            <tmpro text="Opponent discards a card." fontsize="26" />
        </box>
    </hlayout>
</vlayout>
													]]
                                                }
                                            ),
                                                                                    }
                                    }
                                }
                        ),
                        trigger = autoTrigger,
                        tags = {}
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Ice Gem",
                    art = "art/T_Wizard_Alchemist_S_Stone",
                    frame = "frames/Wizard_CardFrame",
                    xmlText=[[
<vlayout>
    <box flexibleheight="1">
        <tmpro text="{gold_2}" fontsize="42"/>
    </box>
    <box flexibleheight="1">
        <tmpro text="OR
Opponent discards a card." fontsize="22" />
    </box>
</vlayout>
					]],
                }
            )
        }
    )
end

function cryomancer_freeze_carddef()
    return createDef(
        {
            id = "cryomancer_freeze",
            name = "Freeze",
            types = {noStealType, actionType},
            acquireCost = 0,
            cardTypeLabel = "Action",
            playLocation = castPloc,
            abilities = {
                createAbility({
                        id = "cryomancer_freeze",
                        layout = cardLayout,
                        effect = pushTargetedEffect({
												desc = "Brrr. It's cold in here. (Expend a champion.)",
												validTargets = oppStunnableSelector(),
												min = 0,
												max = 1,
												targetEffect = expendTarget().seq(gainCombatEffect(1)),
												}),
                        trigger = autoTrigger,
                        tags = {}
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Freeze",
                    art = "art/epicart/polar_shock",
                    frame = "frames/Wizard_CardFrame",
                    xmlText=[[
<vlayout>
    <box flexibleheight="2">
        <tmpro text="{combat_1}" fontsize="50"/>
    </box>
    <box flexibleheight="1">
        <tmpro text="Expend a champion." fontsize="22" />
    </box>
</vlayout>
					]],
                }
            )
        }
    )
end

function cryomancer_frostbiteskill_carddef()
    local cardLayout = createLayout({
        name = "Frostbite",
        art = "art/epicart/frost_giant",
        frame = "frames/Wizard_CardFrame",
        xmlText = 
		[[
		<vlayout>
    <hlayout flexibleheight="2">
            <icon text="{expend_2}" fontsize="72" flexiblewidth="0"/>
            <tmpro text="Add a frostbite card to opponent's discard." fontsize="20" flexiblewidth="10" />
    </hlayout>
    <divider/>
    <hlayout flexibleheight="2">
            <tmpro text="Frostbite card: {scrap} {health_-1}" fontsize="20" flexiblewidth="10" />
    </hlayout> 
</vlayout>
		]]
    })

    return createSkillDef({
        id = "cryomancer_frostbiteskill_skill",
        name = "Frostbite",
        types = { skillType },
        layout = cardLayout,
        layoutPath = "art/epicart/frost_giant",
        abilities = {
            createAbility({
                id = "cryomancer_frostbiteskill_ab",
                trigger = uiTrigger,
                activations = singleActivation,
                layout = cardLayout,
				promptType = showPrompt,
                effect = createCardEffect(cryomancer_frostbite_carddef(), loc(oppPid, discardPloc)),
				cost = goldCost(2),
            }),
        }
        
    })
end

function cryomancer_frostbite_carddef()
-- Frostbite CARD v1.03
    return createDef(
        {
            id = "cryomancer_frostbite",
            name = "Frostbite",
            types = {noStealType, actionType},
            acquireCost = 0,
            cardTypeLabel = "Action",
			playLocation = castPloc,
            abilities = {
                createAbility({
                        id = "cryomancer_frostbite",
                        layout = cardLayout,
                        effect = hitSelfEffect(1),
						cost = sacrificeSelfCost,
                        trigger = autoTrigger,
						playAllType = noPlayPlayType,
                        tags = {}
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Frostbite",
                    art = "art/epicart/frost_giant",
                    frame = "frames/Wizard_CardFrame",
                    xmlText = [[
<vlayout forceheight="false" spacing="6">
<hlayout spacing="10">
<icon text="{scrap}" fontsize="60"/>
<icon text="{health_-1}" fontsize="60"/>
</hlayout>
</vlayout>
]],
                }
            )
        }
    )
end
 
function cryomancer_blizzard_carddef()
	return createHeroAbilityDef({
		id = "blizzard",
		name = "Blizzard",
		types = { heroAbilityType },
        abilities = {
			createAbility({
				id = "blizzardActivate",
				trigger = uiTrigger,
				promptType = showPrompt,
				layout = createLayout({
					name = "Blizzard",
					art = "art/T_heavy_gust",
					frame = "frames/Wizard_CardFrame",
					xmlText = [[
					<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="2">
            <tmpro text="{scrap}" fontsize="40"/>
        </box>
        <box flexiblewidth="7">
            <tmpro text="Draw 2. 
Deal 3 damage to ALL champions, including your own.
(Your champions will not heal at the end of this turn.)" fontsize="20"/> 
</box>
</hlayout>
</vlayout>
]]
				}),
				effect = drawCardsEffect(2).seq(damageTarget(3).apply(selectLoc(loc(currentPid, inPlayPloc)).union(selectLoc(loc(oppPid, inPlayPloc))).where(isCardType(tokenType).And(isCardType(demonType))))),
				cost = sacrificeSelfCost
			})
		},
        layout = createLayout({
            name = "Blizzard",	
            art = "art/T_heavy_gust",
            xmlText = [[
			<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="2">
            <tmpro text="{scrap}" fontsize="40"/>
        </box>
        <box flexiblewidth="7">
            <tmpro text="Draw 2. 
Deal 3 damage to ALL champions, including your own.
(Your champions will not heal at the end of this turn.)" fontsize="20"/> 
</box>
</hlayout>
</vlayout>
			]]
        }),
        layoutPath  = "icons/wizard_serene_channel",
	})
end	

function cryomancer_permafrost_carddef()
    return createDef(
        {
            id = "permafrost",
            name = "Permafrost",
			types = {itemType},
			cardTypeLabel = "item",
			playLocation = castPloc,
            acquireCost = 0,
            abilities = {
                createAbility(
                    {
                        id = "permafrost_main",
                        trigger = autoTrigger,
                        cost = noCost,
                        activations = singleActivations,
                        effect = nullEffect()
						
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Permafrost",
                    art = "art/T_Heavy_Gust",
                    frame = "frames/Wizard_CardFrame",
					cost = 0,
                    xmlText=[[
<vlayout>
    <box flexibleheight="10">
        <tmpro text="Brrr...
It's cold out here." fontstyle="italic" fontsize="20"/>
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

    local CryoFrFogBuff = createGlobalBuff({
        id="cryomancer_freezing_fog_ability",
        name = "Freezing Fog",
        abilities = {
            createAbility({
                id="cryomancer_freezing_fog_ability",
                trigger = deckShuffledTrigger,
                effect = moveToBottomDeckTarget(false, 0).apply(selectSavedTargets("Freezing Fog")).seq(sacrificeSelf())
            })
        },
		buffDetails = createBuffDetails({
					name = "Freezing Fog",
                    art = "art/T_Chaotic_Gust",
					text = "One of your cards has been set aside. It will be placed on the bottom of your deck when you next shuffle."
							})
    })

function cryomancer_freezing_fog_carddef()
	return createHeroAbilityDef({
		id = "Freezing_fog_buff",
		name = "Freezing Fog",
		types = { heroAbilityType },
        abilities = {
			createAbility({
				id = "Freezing_fog_Activate",
				trigger = uiTrigger,
				promptType = showPrompt,
				layout = createLayout({
					name = "Freezing Fog",
					art = "art/T_Chaotic_Gust",
					frame = "frames/Generic_CardFrame",
					xmlText=[[
					<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{scrap}" fontsize="40"/>
        </box>
        <box flexiblewidth="7">
            <tmpro text="Set aside a card of cost 5{gold} or less in your opponent's discard pile. The next time your opponent shuffles their deck, put that card on the bottom of their deck." fontsize="18" />
        </box>
    </hlayout>
</vlayout>
					]]
				}),
				effect = pushTargetedEffect({
												  desc = "Set aside a champion of cost 5 or less from opponent's discard pile.",
												  min=0,
												  max=1,
												  validTargets = selectLoc(loc(oppPid, discardPloc)).where(getCardCost().lte(5)),
												  targetEffect = saveTarget("Freezing Fog").seq(moveTarget(sacrificePloc))
																.seq(createCardEffect(CryoFrFogBuff, loc(oppPid, buffsPloc)))
												  }),
				cost = sacrificeSelfCost
			})
		},
        layout = createLayout({
            name = "Freezing Fog",	
            art = "art/T_Chaotic_Gust",
			frame = "frames/Wizard_CardFrame",
            xmlText=[[
<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{scrap}" fontsize="40"/>
        </box>
        <box flexiblewidth="7">
            <tmpro text="Set aside a card of cost 5{gold} or less in your opponent's discard pile. The next time your opponent shuffles their deck, put that card on the bottom of their deck." fontsize="18" />
        </box>
    </hlayout>
</vlayout>
			]]
        }),
        layoutPath  = "art/T_Chaotic_Gust",
	})
end	


function Cryomancer_Permafrost_Ab_carddef()
local cardLayout = createLayout({
        name = "Permafrost",
        art = "art/T_Heavy_Gust",
        frame = "frames/Wizard_CardFrame",
        xmlText = [[<vlayout>
            <hlayout flexibleheight="0.2">
                <box flexiblewidth="0"/>
                <tmpro text="{scrap}" fontsize="40" flexiblewidth="1"/>
                <box flexiblewidth="0"/>
                <vlayout flexiblewidth="6">
                    <box flexibleheight="0.2"/>
                    <tmpro text="Put a Permafrost card on the top of target opponent's deck." fontsize="19" flexibleheight="3"/>
                </vlayout>
            </hlayout>
        </vlayout>]]
--Add later: That opponent reveals their hand and discards all champions and actions of cost 2{gold} or less.   
   })

local permafrostBuff = createGlobalBuff({
        id="permafrost_buff",
        name = "Permafrost",
        abilities = {
            createAbility({
                id="permafrost_effect",
                trigger = startOfTurnTrigger,
                effect = moveToTopDeckTarget(true).apply(selectLoc(loc(currentPid, deckPloc)).where(isCardName("permafrost"))).seq(sacrificeSelf())
				
            })
        },
		buffDetails = createBuffDetails({
					name = "Permafrost",
                    art = "art/T_Heavy_Gust",
					text = "Winter is... here. (Puts Permafrost on top of your deck.)"
							})
    })

    return createHeroAbilityDef({
        
            id = "Permafrost_Ab",
            name = "Permafrost",
			types = {skillType},
			layout = cardLayout,
			layoutPath = "art/T_Heavy_Gust",
            abilities = {
                createAbility(
                    {
                        id = "Permafrost_Ab_main",
                        trigger = uiTrigger,
						promptType = showPrompt,
						layout = cardLayout,
                        effect = createCardEffect(cryomancer_permafrost_carddef(), loc(oppPid, deckPloc)).seq(createCardEffect(permafrostBuff, loc(oppPid, buffsPloc)))
						--[[.seq(moveTarget(loc(oppPid, discardPloc)).apply(selectLoc(loc(oppPid, handPloc)).where(isCardChampion().And(getCardCost().lte(2)))))]],
						cost = sacrificeSelfCost
                    }
                )
            },
            
        }
    )
end

-- Pyromancer cards
function pyromancer_combust_carddef()
    return createDef(
        {
            id = "Pyromancer_Combust",
            name = "combust",
            types = {noStealType, actionType},
            acquireCost = 0,
            cardTypeLabel = "Action",
            playLocation = castPloc,
            abilities = {
                createAbility({
                        id="Pyromancer_Combust_combat",
						trigger= autoTrigger,
						effect = gainCombatEffect(1)
                    }),
			createAbility({
                id="Pyromancer_Combust_FGsac",
                trigger= autoTrigger,
				activations = singleActivations,
				check = selectLoc(loc(currentPid, castPloc)).union(selectLoc(loc(currentPid, discardPloc))).where(isCardName("fire_gem")).count().gte(1),
                effect = gainCombatEffect(2)

            })
            },
            layout = createLayout(
                {
                    name = "Combust",
                    art = "art/epicart/zaltessa_s_fire",
                    frame = "frames/Wizard_CardFrame",
                    xmlText=[[
<vlayout>
    <box flexibleheight="1">
        <tmpro text="{combat_1}" fontsize="42"/>
    </box>
    <box flexibleheight="1">
        <tmpro text="+{combat_2} if you have a Fire Gem in play or in your discard pile." fontsize="24" />
    </box>
</vlayout>
					]],
                }
            )
        }
    )
end

function pyromancer_sear_carddef()
    return createDef(
        {
            id = "Pyromancer_Sear",
            name = "sear",
            types = {noStealType, actionType},
            acquireCost = 0,
            cardTypeLabel = "Action",
            playLocation = castPloc,
            abilities = {
                createAbility({
                        id = "Pyromancer_Sear",
                        layout = cardLayout,
                        effect = gainCombatEffect(2),
                        trigger = autoTrigger,
                        tags = {}
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Sear",
                    art = "art/epicart/flame_spike",
                    frame = "frames/Wizard_CardFrame",
                    xmlText=[[
<vlayout>
<hlayout flexiblewidth="1">
<icon text="{combat_2}" fontsize="70"/>
</hlayout>
</vlayout>
					]],
                }
            )
        }
    )
end

function pyromancer_scorch_carddef()
    return createDef(
        {
            id = "Pyromancer_Scorch",
            name = "Scorch",
            types = {noStealType, actionType},
            acquireCost = 0,
            cardTypeLabel = "Action",
            playLocation = castPloc,
            abilities = {
                createAbility({
                        id = "Pyromancer_Scorch",
                        layout = cardLayout,
                        effect = gainCombatEffect(1).seq(damageTarget(1).apply(selectLoc(loc(oppPid, inPlayPloc)))),
                        trigger = autoTrigger,
                        tags = {}
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Scorch",
                    art = "art/epicart/flame_strike",
                    frame = "frames/Wizard_CardFrame",
                    xmlText=[[
<vlayout>
    <box flexibleheight="1">
        <tmpro text="{combat_1}" fontsize="50"/>
    </box>
    <box flexibleheight="1">
        <tmpro text="Deal 1 damage to all opposing champions." fontsize="24" />
    </box>
</vlayout>
					]],
                }
            )
        }
    )
end

function pyromancer_fire_shard_carddef()
    return createDef(
        {
            id = "pyromancer_fire_shard",
            name = "Fire Shard",
            types = {gemType, noStealType, itemType},
            acquireCost = 0,
            cardTypeLabel = "Item",
            playLocation = castPloc,
            abilities = {
                createAbility(
                    {
                        id = "pyromancer_fire_shard",
                        layout = cardLayout,
                        effect =
                        pushChoiceEffect(
                                {
                                    choices = {
                                        {
                                            effect = gainGoldEffect(1),
                                            layout = layoutCard(
                                                {
                                                    title = "Fire Shard",
                                                    art = "art/treasures/Thief_Sharpened_ruby",
                                                    xmlText=[[
<vlayout>
<hlayout flexiblewidth="1">
<icon text="{gold_1}" fontsize="70"/>
</hlayout>
</vlayout>
													]]
                                                }
                                            ),
                                            tags = {gainGold1Tag}
                                        },
                                        {
                                            effect = createCardEffect(fire_gem_carddef(), currentDiscardLoc),
                                            layout = layoutCard(
                                                {
                                                    title = "Fire Shard",
                                                    art = "art/treasures/Thief_Sharpened_ruby",
                                                    xmlText=[[
<vlayout>
<hlayout flexiblewidth="1">
<text text="Acquire a Fire Gem for free." fontsize="30"/>
</hlayout>
</vlayout>
													]]
                                                }
                                            ),
                                                                                    }
                                    }
                                }
                        ),
                        trigger = autoTrigger,
                        tags = {}
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Fire Shard",
                    art = "art/treasures/Thief_Sharpened_ruby",
                    frame = "frames/Wizard_CardFrame",
                    xmlText=[[
<vlayout>
    <box flexibleheight="1">
        <tmpro text="{gold_1}" fontsize="50"/>
    </box>
    <box flexibleheight="1">
        <tmpro text="OR
Acquire a Fire Gem for free." fontsize="26" />
    </box>
</vlayout>
					]],
                }
            )
        }
    )
end

function pyromancer_conflagration_1p_carddef()
	return createHeroAbilityDef({
		id = "conflagration_1p",
		name = "Phoenix Fire",
		types = { heroAbilityType },
        abilities = {
			createAbility({
				id = "conflagration_1pActivate",
				trigger = uiTrigger,
				promptType = showPrompt,
				layout = createLayout({
            name = "Phoenix Fire",	
            art = "art/epicart/fiery_demise",
            xmlText = format([[<vlayout>
            <hlayout flexibleheight="2">
                <box flexiblewidth="0.2"/>
                <tmpro text="{scrap}" fontsize="40" flexiblewidth="1"/>
                <box flexiblewidth="0"/>
                <vlayout flexiblewidth="6">
                    <box flexibleheight="0.2"/>
                    <tmpro text="{0}{combat} &lt;size=70%&gt;Flip your skill.

&lt;size=50%&gt;{combat} gained starts at {combat_5}
and increases with each use of your skill." fontsize="32" flexibleheight="3"/>

                </vlayout>
            </hlayout>
        </vlayout>]], 
		{ getCounter("conflagration_1p") })
        }),
				effect = gainCombatEffect(getCounter("conflagration_1p"))
				.seq(sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("pyromancer_1p_fuel_1_skill"))))
				.seq(createCardEffect(pyromancer_after_burn_carddef(), currentSkillsLoc)),
				cost = sacrificeSelfCost
			}),
		},
        layout = createLayout({
            name = "Phoenix Fire",	
            art = "art/epicart/fiery_demise",
            xmlText = format([[<vlayout>
            <hlayout flexibleheight="2">
                <box flexiblewidth="0.2"/>
                <tmpro text="{scrap}" fontsize="40" flexiblewidth="1"/>
                <box flexiblewidth="0"/>
                <vlayout flexiblewidth="6">
                    <box flexibleheight="0.2"/>
                    <tmpro text="{0}{combat} &lt;size=70%&gt;Flip your skill.

&lt;size=50%&gt;{combat} gained starts at {combat_5}
and increases with each use of your skill." fontsize="32" flexibleheight="3"/>

                </vlayout>
            </hlayout>
        </vlayout>]], 
		{ getCounter("conflagration_1p") })
        }),
        layoutPath  = "art/epicart/fiery_demise",
	})
end	
 
function pyromancer_conflagration_2p_carddef()
	return createHeroAbilityDef({
		id = "conflagration_2p",
		name = "Phoenix Fire",
		types = { heroAbilityType },
        abilities = {
			createAbility({
				id = "conflagration_2pActivate",
				trigger = uiTrigger,
				promptType = showPrompt,
				layout = createLayout({
            name = "Phoenix Fire",	
            art = "art/epicart/fiery_demise",
            xmlText = format([[<vlayout>
            <hlayout flexibleheight="2">
                <box flexiblewidth="0.2"/>
                <tmpro text="{scrap}" fontsize="40" flexiblewidth="1"/>
                <box flexiblewidth="0"/>
                <vlayout flexiblewidth="6">
                    <box flexibleheight="0.2"/>
                    <tmpro text="{0}{combat} &lt;size=70%&gt;Flip your skill.

&lt;size=50%&gt;{combat} gained starts at {combat_5}
and increases with each use of your skill." fontsize="32" flexibleheight="3"/>

                </vlayout>
            </hlayout>
        </vlayout>]], 
		{ getCounter("conflagration_2p") })
        }),
				effect = gainCombatEffect(getCounter("conflagration_2p"))
				.seq(sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("pyromancer_2p_fuel_1_skill"))))
				.seq(createCardEffect(pyromancer_after_burn_carddef(), currentSkillsLoc)),
				cost = sacrificeSelfCost
			}),
		},
        layout = createLayout({
            name = "Phoenix Fire",	
            art = "art/epicart/fiery_demise",
            xmlText = format([[<vlayout>
            <hlayout flexibleheight="2">
                <box flexiblewidth="0.2"/>
                <tmpro text="{scrap}" fontsize="40" flexiblewidth="1"/>
                <box flexiblewidth="0"/>
                <vlayout flexiblewidth="6">
                    <box flexibleheight="0.2"/>
                    <tmpro text="{0}{combat} &lt;size=70%&gt;Flip your skill.

&lt;size=50%&gt;{combat} gained starts at {combat_5}
and increases with each use of your skill." fontsize="32" flexibleheight="3"/>

                </vlayout>
            </hlayout>
        </vlayout>]], 
		{ getCounter("conflagration_2p") })
        }),
        layoutPath  = "art/epicart/fiery_demise",
	})
end	

function pyromancer_1p_fuel_1carddef()
    local cardLayout = createLayout({
        name = "Research Phoenix Fire",
        art = "art/epicart/arcane_research",
        frame = "frames/Wizard_CardFrame",
        xmlText = format([[<vlayout>
            <hlayout flexibleheight="0.2">
                <box flexiblewidth="0"/>
                <tmpro text="{expend_2}" fontsize="60" flexiblewidth="1"/>
                <box flexiblewidth="0"/>
                <vlayout flexiblewidth="6">
                    <box flexibleheight="0.2"/>
                    <tmpro text="Add {0}{combat} to your Conflagration ability. Increase the value of this skill by {combat_1} 
(to a maximum of 5)." fontsize="24" flexibleheight="3"/>

                </vlayout>
            </hlayout>
        </vlayout>]], 
		{ getCounter("fuel_1p") })
    })

    return createSkillDef({
        id = "pyromancer_1p_fuel_1_skill",
        name = "Research Phoenix Fire",
        types = { skillType },
        layout = cardLayout,
        layoutPath = "art/epicart/arcane_research",
        abilities = {
            createAbility({
                id = "pyromancer_1p_fuel_1_ab",
                trigger = uiTrigger,
				promptType = showPrompt,
                activations = singleActivation,
                layout = cardLayout,
                effect = incrementCounterEffect("conflagration_1p", (getCounter("fuel_1p")))
				.seq(ifElseEffect((getCounter("fuel_1p").lte(4)),incrementCounterEffect("fuel_1p", 1),nullEffect())),
                cost = combineCosts({
                    expendCost,
                    goldCost(2)
                }),
            }),
        }
        
    })
end

function pyromancer_2p_fuel_1carddef()
    local cardLayout = createLayout({
        name = "Research Phoenix Fire",
        art = "art/epicart/arcane_research",
        frame = "frames/Wizard_CardFrame",
        xmlText = format([[<vlayout>
            <hlayout flexibleheight="0.2">
                <box flexiblewidth="0"/>
                <tmpro text="{expend_2}" fontsize="60" flexiblewidth="1"/>
                <box flexiblewidth="0"/>
                <vlayout flexiblewidth="6">
                    <box flexibleheight="0.2"/>
                    <tmpro text="Add {0}{combat} to your Conflagration ability. Increase the value of this skill by {combat_1} 
(to a maximum of 5)." fontsize="24" flexibleheight="3"/>

                </vlayout>
            </hlayout>
        </vlayout>]], 
		{ getCounter("fuel_2p") })
    })

    return createSkillDef({
        id = "pyromancer_2p_fuel_1_skill",
        name = "Research Phoenix Fire",
        types = { skillType },
        layout = cardLayout,
        layoutPath = "art/epicart/arcane_research",
        abilities = {
            createAbility({
                id = "pyromancer_2p_fuel_1_ab",
                trigger = uiTrigger,
				promptType = showPrompt,
                activations = singleActivation,
                layout = cardLayout,
                effect = incrementCounterEffect("conflagration_2p", (getCounter("fuel_2p")))
				.seq(ifElseEffect((getCounter("fuel_2p").lte(4)),incrementCounterEffect("fuel_2p", 1),nullEffect())),
                cost = combineCosts({
                    expendCost,
                    goldCost(2)
                }),
            }),
        }
        
    })
end

function pyromancer_after_burn_carddef()
    local cardLayout = createLayout({
        name = "After Burn",
        art = "icons/growing_flame",
        frame = "frames/Wizard_CardFrame",
        xmlText = [[<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{expend_2}" fontsize="72"/>
        </box>
        <box flexiblewidth="7">
            <tmpro text="{combat_1} {health_1}" fontsize="52" />
        </box>
    </hlayout>
</vlayout>]]
    })

    return createSkillDef({
        id = "pyromancer_after_burn_skill",
        name = "After Burn",
        types = { skillType },
        layout = cardLayout,
        layoutPath = "icons/growing_flame",
        abilities = {
            createAbility({
                id = "after_burn_ab",
                trigger = uiTrigger,
				promptType = showPrompt,
                activations = singleActivation,
                layout = cardLayout,
                effect = gainCombatEffect(1).seq(gainHealthEffect(1)),
                cost = goldCost(2)
            }),
        }
        
    })
end


-- Terramancer cards

function terramancer_earth_gem_carddef()

    return createDef(
        {
            id = "terramancer_earth_gem",
            name = "Earth Gem",
            types = {gemType, noStealType, itemType},
			            acquireCost = 0,
            cardTypeLabel = "Item",
            playLocation = castPloc,
            abilities = {
				createAbility(
                    {
                        id = "terramancer_earth_gem_sac",
						cost = noCost,
						trigger = autoTrigger,
                        activations = singleActivations,
						                        effect = pushChoiceEffect(
                                {
                                    choices = {
                                        {
                                            effect = gainGoldEffect(1),
                                            layout = layoutCard(
                                                {
                                                    title = "Earth Gem",
                                                    art = "art/ancestry/shiny_rock",
                                                    xmlText=[[
													<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="7">
            <icon text="{gold_1}" fontsize="60"/>
</box>
</hlayout>
</vlayout>
													]]
                                                }
                                            ),
                                            tags = {gainCombatTag}
                                        },
                                        {
                                            effect = addSlotToPlayerEffect(controllerPid, createPlayerIntExpressionSlot(skillCostModKey, toIntExpression(-2), { endOfTurnExpiry })),
											layout = layoutCard(
                                                {
                                                    title = "Earth Gem",
                                                    art = "art/ancestry/shiny_rock",
                                                    xmlText=[[
<vlayout>
    <box flexibleheight="1">
        <tmpro text="Your class skill costs 2{gold} less
this turn." fontsize="30" />
    </box>
</vlayout>
													]]
                                                }
                                            ),
                                                                                    }
                                    }
                                }
                        ),
                        tags = {}
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Earth Gem",
                    art = "art/ancestry/shiny_rock",
                    frame = "frames/druid_frames/druid_item_cardframe",
                    xmlText=[[
					<vlayout>
    <box flexibleheight="2">
        <tmpro text="{gold_1}" fontsize="42"/>
    </box>
    <box flexibleheight="3">
        <tmpro text="OR
Your class skill costs 
2{gold} less this turn." fontsize="24" />
    </box>
</vlayout>
					]]
                }
            )
        }
    )
end

function terramancer_hurl_boulder_carddef()
    return createDef(
        {
            id = "terramancer_hurl_boulder",
            name = "Hurl Boulder",
            types = {noStealType, actionType},
            acquireCost = 0,
            cardTypeLabel = "Action",
            playLocation = castPloc,
            abilities = {
                createAbility({
                        id = "terramancer_hurl_boulder",
                        layout = cardLayout,
                        effect = ifElseEffect(selectLoc(currentSkillsLoc).where(isCardName("terramancer_move_earth1_skill").Or(isCardName("terramancer_move_earth2_skill")).And(isCardExpended())).count().gte(1),gainCombatEffect(4),gainCombatEffect(2)),
                        trigger = autoTrigger,
                        tags = {}
                    }
                )
            },
			
            layout = createLayout(
                {
                    name = "Hurl Boulder",
                    art = "art/epicart/apocalypse",
                    frame = "frames/druid_frames/druid_action_cardframe",
                    xmlText=[[
<vlayout>
    <hlayout flexibleheight="7">
            <tmpro text="{combat_2} &lt;size=70%&gt;Or
 &lt;size=70%&gt; If you have used your class skill this turn gain &lt;size=100%&gt;+{combat_2}. " fontsize="28" flexiblewidth="1" />
    </hlayout>
    <divider/>
    <hlayout flexibleheight="2">
                     <tmpro text="It's terra terror." fontsize="18" fontstyle="italic" flexiblewidth="8" />
    </hlayout>
</vlayout>
					]],
                }
            )
        }
    )
end

function terramancer_tremor_carddef()

    local tremorBuff = createGlobalBuff({
        id="tremor_buff",
        name = "Tremor",
        abilities = {
            createAbility({
                id="tremor_effect",
                trigger = startOfTurnTrigger,
                effect = pushTargetedEffect({
												  desc = "Put a card back in your deck, then shuffle your deck.",
												  min=1,
												  max=1,
												  validTargets = selectLoc(loc(currentPid, handPloc)),
												  targetEffect = moveTarget(loc(currentPid, deckPloc)).seq(shuffleEffect(loc(currentPid, deckPloc))).seq(sacrificeSelf())
												  })
				
            })
        },
		buffDetails = createBuffDetails({
					name = "Tremor",
                    art = "icons/wizard_channel",
					text = "Return a card to deck and shuffle."
							})
    })

    return createDef(
        {
            id = "terramancer_tremor",
            name = "Tremor",
            types = {noStealType, actionType},
            acquireCost = 0,
            cardTypeLabel = "Action",
            playLocation = castPloc,
            abilities = {
                createAbility({
                        id = "terramancer_tremor",
                        layout = cardLayout,
                        effect = gainCombatEffect(1).seq(createCardEffect(tremorBuff, loc(oppPid, buffsPloc))),
                        trigger = autoTrigger,
                        tags = {}
                    }
                )
            },
			
            layout = createLayout(
                {
                    name = "Tremor",
                    art = "icons/wizard_channel",
                    frame = "frames/druid_frames/druid_action_cardframe",
                    xmlText=[[
<vlayout>
    <box flexibleheight="2">
        <tmpro text="{combat_1}
&lt;size=70%&gt;Opponent must return 1 card to their deck, then shuffles their deck." fontsize="30"/>
    </box>
</vlayout>
					]],
                }
            )
        }
    )
end

function terramancer_clay_golem1_carddef()
    return createChampionDef(
        {
            id = "terramancer_clay_golem1",
            name = "Clay Golem",
			types = {championType, nostealType},
            acquireCost = 0,
            health = 1,
            isGuard = false,
            abilities = {
                createAbility(
                    {
                        id = "clay_golem1_main",
                        trigger = autoTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = gainCombatEffect(1)
						
                    }
					
                ),
				createAbility(
                    {
                        id = "clay_golem1_healthbuff",
                        trigger = onPlayTrigger,
                        cost = noCost,
                        activations = singleActivations,
                        effect = pushChoiceEffect(
                                {
                                    choices = {
                                        {
                                            effect = nullEffect(),
                                            layout = layoutCard(
                                                {
                                                    title = "Clay Golem",
                                                    art = "art/T_stone_golem",
                                                    xmlText=[[
<vlayout>
    <hlayout flexibleheight="1">
            <tmpro text="{expend}" fontsize="40" flexiblewidth="2"/>
            <tmpro text="{combat_1}" fontsize="50" flexiblewidth="12" />
    </hlayout>
</vlayout>
]],
										health = 1,
										isGuard = false
                                                }
                                            ),
                                            tags = {}
                                        },
                                        {
                                            effect = grantHealthTarget(2, { SlotExpireEnum.LeavesPlay }, nullEffect(), "Golem. Golem.").apply(selectSource())
											.seq(incrementCounterEffect("wallofEarth1Counter", -2)),
                                            condition = getCounter("wallofEarth1Counter").gte(2),
											layout = layoutCard(
                                                {
                                                    title = "Clay Golem",
                                                    art = "art/T_stone_golem",
                                                    xmlText=[[
<vlayout>
  <hlayout flexibleheight="1">
            <tmpro text="Remove 2 counters
from your class skill." fontsize="20"  flexiblewidth="10" />
    </hlayout> 
    <divider/>
   <hlayout flexibleheight="1">
            <tmpro text="{expend}" fontsize="30" flexiblewidth="2"/>
            <tmpro text="{combat_1}" fontsize="40" flexiblewidth="12" />
    </hlayout>
</vlayout>
													]],
										health = 3,
										isGuard = false
                                                }
                                            ),
                                                                                    }
                                    }
                                }
                        )
						
					}	
                    
                )
            },
            layout = createLayout(
                {
                    name = "Clay Golem",
                    art = "art/T_stone_golem",
                    frame = "frames/druid_frames/druid_action_cardframe",
                    xmlText=[[
					<vlayout>
    <hlayout flexibleheight="1">
            <tmpro text="{expend}" fontsize="30" flexiblewidth="2"/>
            <tmpro text="{combat_1}" fontsize="40" flexiblewidth="12" />
    </hlayout>
    <divider/>
    <hlayout flexibleheight="2">
            <tmpro text="When played you may remove 2 counters from your class skill to give Clay Golem +2{shield} until it leaves play." fontsize="20"  flexiblewidth="10" />
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

function terramancer_clay_golem2_carddef()
    return createChampionDef(
        {
            id = "terramancer_clay_golem2",
            name = "Clay Golem",
			types = {championType, nostealType},
            acquireCost = 0,
            health = 1,
            isGuard = false,
            abilities = {
                createAbility(
                    {
                        id = "clay_golem2_main",
                        trigger = autoTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = gainCombatEffect(1)
						
                    }
					
                ),
				createAbility(
                    {
                        id = "clay_golem2_healthbuff",
                        trigger = onPlayTrigger,
                        cost = noCost,
                        activations = singleActivations,
                        effect = pushChoiceEffect(
                                {
                                    choices = {
                                        {
                                            effect = nullEffect(),
                                            layout = layoutCard(
                                                {
                                                    title = "Clay Golem",
                                                    art = "art/T_stone_golem",
                                                    xmlText=[[
<vlayout>
    <hlayout flexibleheight="1">
            <tmpro text="{expend}" fontsize="40" flexiblewidth="2"/>
            <tmpro text="{combat_1}" fontsize="50" flexiblewidth="12" />
    </hlayout>
</vlayout>
]],
										health = 1,
										isGuard = false
                                                }
                                            ),
                                            tags = {}
                                        },
                                        {
                                            effect = grantHealthTarget(2, { SlotExpireEnum.LeavesPlay }, nullEffect(), "Golem. Golem.").apply(selectSource())
											.seq(incrementCounterEffect("wallofEarth2Counter", -2)),
                                            condition = getCounter("wallofEarth2Counter").gte(2),
											layout = layoutCard(
                                                {
                                                    title = "Clay Golem",
                                                    art = "art/T_stone_golem",
                                                    xmlText=[[
<vlayout>
  <hlayout flexibleheight="1">
            <tmpro text="Remove 2 counters
from your class skill." fontsize="20"  flexiblewidth="10" />
    </hlayout> 
    <divider/>
   <hlayout flexibleheight="1">
            <tmpro text="{expend}" fontsize="30" flexiblewidth="2"/>
            <tmpro text="{combat_1}" fontsize="40" flexiblewidth="12" />
    </hlayout>
</vlayout>
													]],
										health = 3,
										isGuard = false
                                                }
                                            ),
                                                                                    }
                                    }
                                }
                        )
						
					}	
                    
                )
            },
            layout = createLayout(
                {
                    name = "Clay Golem",
                    art = "art/T_stone_golem",
                    frame = "frames/druid_frames/druid_action_cardframe",
                    xmlText=[[
					<vlayout>
    <hlayout flexibleheight="1">
            <tmpro text="{expend}" fontsize="30" flexiblewidth="2"/>
            <tmpro text="{combat_1}" fontsize="40" flexiblewidth="12" />
    </hlayout>
    <divider/>
    <hlayout flexibleheight="2">
            <tmpro text="When played you may remove 2 counters from your class skill to give Clay Golem +2{shield} until it leaves play." fontsize="20"  flexiblewidth="10" />
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

function terramancer_move_earth1_carddef()
    local cardLayout = createLayout({
        name = "Move Earth",
        art = "art/T_Fissure",
        frame = "frames/druid_frames/druid_item_cardframe",
        xmlText = format([[<vlayout>
            <hlayout flexibleheight="1">
                <box flexiblewidth="0.2"/>
                <tmpro text="{expend_2}" fontsize="50"/>
                <box flexiblewidth="0.2"/>
                <vlayout flexiblewidth="6">
                    <box flexibleheight="0.2"/>
                    <tmpro text="Add 2 counters to this card. Or:" fontsize="17" flexibleheight="1"/>
                    <box flexibleheight="1.5"/>
                    <tmpro text="Remove all counters. Put a Wall token into play with {guard} equal to the number of counters removed, then  
{health} for half that number." fontsize="17" flexibleheight="2"/>
                    <box flexibleheight="1.5"/>
                    <tmpro text="(Currently has {0} counters = {1}{guard} {2}{health})" fontsize="12" fontstyle="Italic" flexibleheight="0.2"/>

                </vlayout>
            </hlayout>
        </vlayout>]],
		{ getCounter("wallofEarth1Counter"), getCounter("wallofEarth1Counter"), divide(getCounter("wallofEarth1Counter"), 2) }
		)
    })

    return createSkillDef({
        id = "terramancer_move_earth1_skill",
        name = "move_earth",
        types = { skillType },
        layout = cardLayout,
        layoutPath = "icons/wizard_serene_channel",
        abilities = {
            createAbility({
                id = "move_earth1_ab",
                trigger = uiTrigger,
				promptType = showPrompt,
                activations = singleActivation,
                layout = cardLayout,
                effect = pushChoiceEffect(
                                {
                                    choices = {
                                        {
                                            effect = incrementCounterEffect("wallofEarth1Counter", 2),
                                            layout = layoutCard(
                                                {
                                                    title = "Wall of Earth",
                                                    art = "art/T_Fissure",
                                                    xmlText=[[
													<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="7">
            <tmpro text="Add 2 counters
to this card." fontsize="30"/>
</box>
</hlayout>
</vlayout>
													]]
                                                }
                                            ),
                                            tags = {}
                                        },
                                        {
                         --here --
						 effect = createCardEffect(terramancer_wall_of_earth_carddef(), currentInPlayLoc)
						 .seq(grantHealthTarget((getCounter("wallofEarth1Counter")), { SlotExpireEnum.LeavesPlay }, nullEffect(), "Wall of earth").apply(selectLoc(loc(currentPid, inPlayPloc)).where(isCardChampion().And(isCardName("terramancer_wall_of_earth")))))
						 .seq(gainHealthEffect(divide(getCounter("wallofEarth1Counter"), 2)))
						 .seq(resetCounterEffect("wallofEarth1Counter")),
						 condition = getCounter("wallofEarth1Counter").gte(2),
                                            layout = layoutCard(
                                                {
                                                    title = "Wall of Earth",
                                                    art = "art/T_Fissure",
                                                    xmlText=[[
<vlayout>
    <box flexibleheight="1">
        <tmpro text="Remove all counters.

Put a Wall token into play with {guard} equal to the number of counters removed.
Gain {health} equal to half that number." fontsize="20" />

    </box>
</vlayout>
													]]
                                                }
                                            ),
                                                                                    }
                                    }
                                }
                        ),
                cost = combineCosts({
                    expendCost,
                    goldCost(2)
                })
            }),
        }
        
    })
end

function terramancer_move_earth2_carddef()
    local cardLayout = createLayout({
        name = "Move Earth",
        art = "art/T_Fissure",
        frame = "frames/druid_frames/druid_item_cardframe",
        xmlText = format([[<vlayout>
            <hlayout flexibleheight="1">
                <box flexiblewidth="0.2"/>
                <tmpro text="{expend_2}" fontsize="50"/>
                <box flexiblewidth="0.2"/>
                <vlayout flexiblewidth="6">
                    <box flexibleheight="0.2"/>
                    <tmpro text="Add 2 counters to this card. Or:" fontsize="17" flexibleheight="1"/>
                    <box flexibleheight="1.5"/>
                    <tmpro text="Remove all counters. Put a Wall token into play with {guard} equal to the number of counters removed, then  
{health} for half that number." fontsize="17" flexibleheight="2"/>
                    <box flexibleheight="1.5"/>
                    <tmpro text="(Currently has {0} counters = {1}{guard} {2}{health})" fontsize="12" fontstyle="Italic" flexibleheight="0.2"/>

                </vlayout>
            </hlayout>
        </vlayout>]],
		{ getCounter("wallofEarth2Counter"), getCounter("wallofEarth2Counter"), divide(getCounter("wallofEarth2Counter"), 2) }
		)
    })

    return createSkillDef({
        id = "terramancer_move_earth2_skill",
        name = "move_earth",
        types = { skillType },
        layout = cardLayout,
        layoutPath = "icons/wizard_serene_channel",
        abilities = {
            createAbility({
                id = "move_earth2_ab",
                trigger = uiTrigger,
				promptType = showPrompt,
                activations = singleActivation,
                layout = cardLayout,
                effect = pushChoiceEffect(
                                {
                                    choices = {
                                        {
                                            effect = incrementCounterEffect("wallofEarth2Counter", 2),
                                            layout = layoutCard(
                                                {
                                                    title = "Wall of Earth",
                                                    art = "art/T_Fissure",
                                                    xmlText=[[
													<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="7">
            <tmpro text="Add 2 counters
to this card." fontsize="30"/>
</box>
</hlayout>
</vlayout>
													]]
                                                }
                                            ),
                                            tags = {}
                                        },
                                        {
                         --here --
						 effect = createCardEffect(terramancer_wall_of_earth_carddef(), currentInPlayLoc)
						 .seq(grantHealthTarget((getCounter("wallofEarth2Counter")), { SlotExpireEnum.LeavesPlay }, nullEffect(), "Wall of earth").apply(selectLoc(loc(currentPid, inPlayPloc)).where(isCardChampion().And(isCardName("terramancer_wall_of_earth")))))
						 .seq(gainHealthEffect(divide(getCounter("wallofEarth2Counter"), 2)))
						 .seq(resetCounterEffect("wallofEarth2Counter")),
						 condition = getCounter("wallofEarth2Counter").gte(2),
                                            layout = layoutCard(
                                                {
                                                    title = "Wall of Earth",
                                                    art = "art/T_Fissure",
                                                    xmlText=[[
<vlayout>
    <box flexibleheight="1">
        <tmpro text="Remove all counters.

Put a Wall token into play with {guard} equal to the number of counters removed.
Gain {health} equal to half that number." fontsize="20" />

    </box>
</vlayout>
													]]
                                                }
                                            ),
                                                                                    }
                                    }
                                }
                        ),
                cost = combineCosts({
                    expendCost,
                    goldCost(2)
                })
            }),
        }
        
    })
end

function terramancer_wall_of_earth_carddef()

   --[[ local wallOfEarthBuff = createGlobalBuff({
        id="wallOfEarth_buff",
        name = "Wall of Earth",
        abilities = {
            createAbility({
                id="wallOfEarth_effect",
                trigger = autoTrigger,
                effect = addSlotToTarget(createNoAttackSlot({ key = "WallOfEarthInPlay", expiry = { startOfOwnerTurnExpiry } })).apply(selectLoc(loc(currentPid, inPlayPloc)).where(isCardChampion().And(isCardName("terramancer_wall").invert())))
            })
        },
		buffDetails = createBuffDetails({
					name = "Wall of Earth",
                    art = "art/T_Fissure",
					text = "Champions cannot be targeted while Wall of Earth is in play."
							})
    })
]]
    return createChampionDef(
        {
            id = "terramancer_wall_of_earth",
            name = "Wall of Earth",
			types = {championType, nostealType},
            acquireCost = 0,
            health = 0,
            isGuard = true,
            abilities = {
                createAbility(
                    {
                        id = "wall_of_earth_main",
                        trigger = onPlayTrigger,
                        cost = noCost,
                        activations = singleActivations,
                        effect = nullEffect()
						
                    }
					
                ),
				createAbility(
                    {
                        id = "wall_of_earth_sac",
                        trigger = onLeavePlayTrigger,
                        cost = sacrificeSelfCost,
                        activations = singleActivations,
                        effect = nullEffect()
						}	
                    
                )
            },
            layout = createLayout(
                {
                    name = "Wall of Earth",
                    art = "art/T_Fissure",
                    frame = "frames/druid_frames/druid_action_cardframe",
                    xmlText=[[
					<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="We can't go over it.
We can't go under it.
Oh no! We'll have to go through it." fontstyle="italic" fontsize="22"/>
</box>

    </hlayout>
</vlayout>
					]],
                    health = 0,
                    isGuard = true
                }
            )
        }
    )
end

function terramancer_swallowed_by_the_earth_def()

	 local abilityLayout = createLayout({
        name = "Swallowed by the Earth",
        art = "art/sets/Dungeons/dragged_below",
        frame = "frames/druid_frames/druid_item_cardframe",
		xmlText=[[
    <vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{scrap}" fontsize="40"/>
        </box>
        <box flexiblewidth="7">
            <tmpro text="Sacrifice one champion target opponent has in play that costs {gold_4} or less. &lt;size=90%&gt;(Usable from your 5th turn.)
&lt;size=100%&gt;OR
{health_6} and Draw 1." fontsize="20" flexiblewidth="10" />
</box>
</hlayout>
</vlayout>
		]]
    })
    return createHeroAbilityDef({
		id = "sbte",
		name = "Swallowed by the Earth",
		acquireCost = 0,
		cardTypeLabel = "Ability",
		playLocation = skillsPloc,
		types = { abilityType },
        abilities = {
			createAbility({
				id = "sbte",
				trigger = uiTrigger,
				promptType = showPrompt,
				layout = abilityLayout,
				effect = pushChoiceEffect(
                                {
                                    choices = {
                                        {
                                            effect = pushTargetedEffect({
												  desc = "Sacrifice one champion of cost 4 gold or less that your opponent has in play.",
												  min=1,
												  max=1,
												  validTargets = selectLoc(loc(oppPid, inPlayPloc)).where((isCardChampion()).And(getCardCost().lte(4))),
												  targetEffect = sacrificeTarget()
												  }),
											condition = getTurnsPlayed(currentPid).gte(5),
                                            layout = layoutCard(
                                                {
                                                    title = "Swallowed by the Earth",
													art = "art/sets/Dungeons/dragged_below",
                                                    xmlText=[[
													<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{scrap}" fontsize="40"/>
        </box>
        <box flexiblewidth="7">
            <tmpro text="Sacrifice one champion target opponent has in play that costs {gold_4} or less. &lt;size=80%&gt;(Usable from your 5th turn.)
" fontsize="23" flexiblewidth="10" />
</box>
</hlayout>
</vlayout>
													]]
                                                }
                                            ),
                                            tags = {gainCombatTag}
                                        },
                                        {
                                            effect = gainHealthEffect(6).seq(drawCardsEffect(1)),
                                            layout = layoutCard(
                                                {
                                                    title = "Swallowed by the Earth",
													art = "art/sets/Dungeons/dragged_below",
                                                    xmlText=[[
<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{scrap}" fontsize="40"/>
        </box>
        <box flexiblewidth="7">
            <tmpro text="{health_6}
&lt;size=80%&gt;Draw 1" fontsize="40" flexiblewidth="10" />
</box>
</hlayout>
</vlayout>
													]]
                                                }
                                            ),
                                                                                    }
                                    }
                                }
                        ),
						
				cost = sacrificeSelfCost
			})
		},
		layout = abilityLayout,
		layoutPath= "art/sets/Dungeons/dragged_below"
	})
end

-- Thandalorian cards
function thandarlorian_combat_shield_carddef()
    return createDef({
        id="thandarlorian_combat_shield",
        name="Combat Shield",
        types={noStealType, itemType},
		cardTypeLabel = "Item",
		playLocation = castPloc,
        acquireCost=0,
        abilities = {
            createAbility({
                id="thandarlorian_combat_shield",
                trigger= autoTrigger,
                effect = gainToughnessEffect(2)
            }),
			createAbility({
                id="thandarlorian_combat_shield_combo",
				cost = noCost,
                trigger= uiTrigger,
				promptType = showPrompt,
					layout = createLayout({
					name = "Combat Shield",
					art = "art/epicart/angeline_s_favor",
					frame = "frames/Coop_Campaign_CardFrame",
					xmlText = [[
<vlayout>
    <box flexibleheight="1">
        <tmpro text="Gain 2 Toughness" fontsize="26"/>
    </box>
    <box flexibleheight="1">
        <tmpro text="If you have a champion in play, draw 1." fontsize="24" />
    </box>
</vlayout>]]
					}),
				activations = singleActivations,
				check = selectLoc(loc(currentPid, inPlayPloc)).where(isCardChampion()).count().gte(1),
                effect = drawCardsEffect(1),
            })
        },
        layout = createLayout({
            name = "Combat Shield",
            art = "art/epicart/angeline_s_favor",
            frame = "frames/Coop_Campaign_CardFrame",
            xmlText = [[<vlayout>
    <box flexibleheight="1">
        <tmpro text="Gain 2 Toughness" fontsize="26"/>
    </box>
    <box flexibleheight="1">
        <tmpro text="If you have a champion in play, draw 1." fontsize="24" />
    </box>
</vlayout>]]
        })
    })
	end

function thandarlorian_coordinated_attack_carddef()
-- START Coordinated Attack CARD - v1.00
    return createDef({
        id="thandarlorian_coordinated_attack",
        name="Coordinated Attack",
        types={noStealType, itemType},
		cardTypeLabel = "Action",
		playLocation = castPloc,
        acquireCost=0,
        abilities = {
            createAbility({
                id="thandarlorian_coordinated_attack",
                trigger= autoTrigger,
                effect = gainCombatEffect(2)
            }),
			createAbility({
                id="thandarlorian_coordinated_attack_combo",
				cost = noCost,
                trigger= autoTrigger,
				promptType = showPrompt,
					layout = createLayout({
					name = "Coordinated Attack",
					art = "art/epicart/insurgency",
					frame = "frames/Coop_Campaign_CardFrame",
					xmlText = [[<vlayout>
    <box flexibleheight="1">
        <tmpro text="{combat_2}" fontsize="50"/>
    </box>
    <box flexibleheight="1">
        <tmpro text="If you have 2 champions in play, gain {combat_2} more and 1 Toughness." fontsize="24" />
    </box>
</vlayout>]]
					}),
				activations = singleActivations,
				check = selectLoc(loc(currentPid, inPlayPloc)).where(isCardChampion()).count().gte(2),
                effect = gainCombatEffect(2).seq(gainToughnessEffect(1)),
            })
        },
        layout = createLayout({
            name = "Coordinated Attack",
            art = "art/epicart/insurgency",
            frame = "frames/Coop_Campaign_CardFrame",
            xmlText = [[<vlayout>
    <box flexibleheight="1">
        <tmpro text="{combat_2}" fontsize="50"/>
    </box>
    <box flexibleheight="1">
        <tmpro text="If you have 2 champions in play, gain {combat_2} more and 1 Toughness." fontsize="24" />
    </box>
</vlayout>
							]]
        })
    })
	end

function thandarlorian_hand_ballista_carddef()
-- START Hand Ballista CARD - v1.00
    return createDef({
        id="thandarlorian_hand_ballista",
        name="Hand Ballista",
        types={noStealType, itemType, bowType, weaponType},
		cardTypeLabel = "Item",
		playLocation = castPloc,
        acquireCost=0,
        abilities = {
            createAbility({
                id="thandarlorian_hand_ballista",
                trigger= autoTrigger,
                effect = gainCombatEffect(1)
            })
        },
        layout = createLayout({
            name = "Hand Ballista",
            art = "art/T_Light_Crossbow",
            frame = "frames/Coop_Campaign_CardFrame",
            xmlText = [[
<vlayout forceheight="false" spacing="6">
<hlayout spacing="10">
<icon text="{combat_1}" fontsize="50"/>
</hlayout>
<divider/>
<hlayout forcewidth="true" spacing="10">
<text text="Ballista. Not blaster." fontsize="22" fontstyle="italic"/>
</hlayout>
</vlayout>
]]
        })
    })
	end

function thandarlorian_bounty_hunters_stone_of_seeking_carddef()
--[[ START Bounty Hunter's Stone of Seeking CARD - v1.00
]]
    return createDef({
        id="thandarlorian_bounty_hunters_stone_of_seeking",
        name="Bounty Hunter's Stone of Seeking",
        types={noStealType, itemType},
		cardTypeLabel = "Item",
		playLocation = castPloc,
        acquireCost=0,
        abilities = {
            createAbility({
                id="thandarlorian_bounty_hunters_stone_of_seeking",
                trigger= autoTrigger,
                effect = gainGoldEffect(1)
            }),
			createAbility({
                id="thandarlorian_bounty_hunters_stone_of_seeking_combo",
				cost = noCost,
                trigger= onStunGlobalTrigger,
				activations = singleActivations,
                effect = gainGoldEffect(1),
				layout = createLayout({
					name = "Bounty Hunter's Stone of Seeking",
					art = "art/T_Wizard_Alchemist_S_Stone",
					frame = "frames/Coop_Campaign_CardFrame",
					Text = [[
<vlayout>
    <box flexibleheight="1">
        <tmpro text="{gold_1}" fontsize="50"/>
    </box>
    <box flexibleheight="1">
        <tmpro text="If you stun a champion this turn, gain {gold_1} more." fontsize="24" />
    </box>
</vlayout>
]]
					}),
            })
        },
        layout = createLayout({
            name = "Bounty Hunter's Stone of Seeking",
            art = "art/T_Wizard_Alchemist_S_Stone",
            frame = "frames/Coop_Campaign_CardFrame",
            xmlText = [[
			<vlayout>
    <box flexibleheight="1">
        <tmpro text="{gold_1}" fontsize="50"/>
    </box>
    <box flexibleheight="1">
        <tmpro text="If you stun a champion this turn, gain {gold_1} more." fontsize="24" />
    </box>
</vlayout>
							]]
        })
    })
	end

function thandarlorian_bracer_blades_carddef()
	return createHeroAbilityDef({
		id = "bracer_blades",
		name = "Bracer Blades",
		types = { heroAbilityType },
        abilities = {
			createAbility({
				id = "bracer_bladesActivate",
				trigger = uiTrigger,
				promptType = showPrompt,
				layout = createLayout({
					name = "Bracer Blades",
					art = "art/treasures/T_Bracers_Of_Brawn",
					xmlText = [[
<vlayout forceheight="false" spacing="6">
<hlayout forcewidth="true" spacing="10">
<text text="{scrap}" fontsize="40"/>
<vlayout  forceheight="false">
<icon text="{combat_2}" fontsize="40"/>
<text text="OR Hit a champion for 3 damage.
Make this choice 3 times." fontsize="24"/>
</vlayout>
</hlayout>
</vlayout>
					]]					
				}),
				effect =
				pushChoiceEffect(
                                {
                                    choices = {
                                        {
                                            effect = pushTargetedEffect({
                                                desc = "Deal 3 damage to target champion.",
                                                validTargets = oppStunnableSelector(),
                                                min = 0,
                                                max = 1,
                                                targetEffect = damageTarget(3),
                                                }),
                                            layout = layoutCard(
                                                {
                                                    title = "Bracer Blades",
                                                    art = "art/treasures/T_Bracers_Of_Brawn",
                                                    text = "Deal 3 damage to target champion."
                                                }
                                            ),
                                            tags = {gainCombat6Tag}
                                        },
										{
                                            effect = gainCombatEffect(2),
                                            layout = layoutCard(
                                                {
                                                    title = "Bracer Blades",
                                                    art = "art/treasures/T_Bracers_Of_Brawn",
                                                    xmlText=[[
<vlayout>
<hlayout flexiblewidth="1">
<icon text="{combat_2}" fontsize="70"/>
</hlayout>
</vlayout>
					]]
                                                }
                                            ),
                                                                                    }
                                    }
                                }
                        )
						.seq(pushChoiceEffect(
                                {
                                    choices = {
                                        {
                                            effect = pushTargetedEffect({
                                                desc = "Deal 3 damage to target champion.",
                                                validTargets = oppStunnableSelector(),
                                                min = 0,
                                                max = 1,
                                                targetEffect = damageTarget(3),
                                                }),
                                            layout = layoutCard(
                                                {
                                                    title = "Bracer Blades",
                                                    art = "art/treasures/T_Bracers_Of_Brawn",
                                                    text = "Deal 3 damage to target champion."
                                                }
                                            ),
                                            tags = {gainCombat6Tag}
                                        },
										{
                                            effect = gainCombatEffect(2),
                                            layout = layoutCard(
                                                {
                                                    title = "Bracer Blades",
                                                    art = "art/treasures/T_Bracers_Of_Brawn",
                                                    xmlText=[[
<vlayout>
<hlayout flexiblewidth="1">
<icon text="{combat_2}" fontsize="70"/>
</hlayout>
</vlayout>
					]]
                                                }
                                            ),
                                                                                    }
                                    }
                                }
                        ))
						.seq(pushChoiceEffect(
                                {
                                    choices = {
                                        {
                                            effect = pushTargetedEffect({
                                                desc = "Deal 3 damage to target champion.",
                                                validTargets = oppStunnableSelector(),
                                                min = 0,
                                                max = 1,
                                                targetEffect = damageTarget(3),
                                                }),
                                            layout = layoutCard(
                                                {
                                                    title = "Bracer Blades",
                                                    art = "art/treasures/T_Bracers_Of_Brawn",
                                                    text = "Deal 3 damage to target champion."
                                                }
                                            ),
                                            tags = {gainCombat6Tag}
                                        },
										{
                                            effect = gainCombatEffect(2),
                                            layout = layoutCard(
                                                {
                                                    title = "Bracer Blades",
                                                    art = "art/treasures/T_Bracers_Of_Brawn",
                                                    xmlText=[[
<vlayout>
<hlayout flexiblewidth="1">
<icon text="{combat_2}" fontsize="70"/>
</hlayout>
</vlayout>
					]]
                                                }
                                            ),
                                                                                    }
                                    }
                                }
                        )),
				cost = sacrificeSelfCost
			})
		},
        layout = createLayout({
            name = "Bracer Blades",	
            art = "art/treasures/T_Bracers_Of_Brawn",
            xmlText = [[
					<vlayout forceheight="false" spacing="6">
<hlayout forcewidth="true" spacing="10">
<text text="{scrap}" fontsize="40"/>
<vlayout  forceheight="false">
<icon text="{combat_2}" fontsize="40"/>
<text text="OR Hit a champion for 3 damage.
Make this choice 3 times." fontsize="24"/>
</vlayout>
</hlayout>
</vlayout>
					]]	
        }),
        layoutPath  = "art/treasures/T_Bracers_Of_Brawn",
	})
end	

function thandarlorian_whipcord_carddef()
    local cardLayout = createLayout({
        name = "Whipcord",
        art = "art/treasures/barbarian_whip",
        frame = "frames/Coop_Campaign_CardFrame",
		xmlText = [[
<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{expend_2}" fontsize="72"/>
        </box>
        <box flexiblewidth="7">
            <tmpro text="Move a champion of cost {gold_4} or less into your play area until end of turn. Champions moved this way will arrive in your play area expended. If you target an opponent's champion, return it to opponent's play area at end of turn and prepare it. If you target a champion from the market, return it to the top of the market deck at end of turn." fontsize="14"/>
</box>
</hlayout>
</vlayout>
		]]
    })

    return createSkillDef({
        id = "thandarlorian_whipcord_skill",
        name = "Whipcord",
        types = { skillType },
        layout = cardLayout,
        layoutPath = "art/treasures/barbarian_whip",
        abilities = {
            createAbility({
                id = "thandarlorian_whipcord_ab",
                trigger = uiTrigger,
                activations = singleActivation,
                layout = cardLayout,
				promptType = showPrompt,
                effect = pushChoiceEffect(
                                {
                                    choices = {
										{
                                            effect = pushTargetedEffect({
												desc = "Expend target opponent's champion of cost 4 gold or less, then drag it into your play area. At end of turn, return it to opponent's play area. Prepare it..",
												validTargets = oppStunnableSelector().where(isCardChampion().And(getCardCost().lte(4))),
												min = 0,
												max = 1,
												targetEffect = addSlotToTarget(createAbilitySlot({
														ability = createAbility({
															id = "thandarlorian_whipcord_ability",
															effect = moveTargetWithLocAndPlayer(inPlayPloc, ownerPid).apply(selectSource()),
															trigger = oppStartOfTurnTrigger
														}),
														expiry = { startOfOwnerTurnExpiry }
													}))
													.seq(expendTarget()).seq(moveTarget(loc(currentPid, inPlayPloc))),
												}),
                                            layout = layoutCard(
                                                {
                                                    title = "Whipcord",
                                                    art = "art/treasures/barbarian_whip",
                                                    xmlText = [[<vlayout>
																<hlayout flexibleheight="1">
																	<box flexiblewidth="1">
																		<tmpro text="Expend target opponent's champion of cost {gold_4} or less, then drag it into your play area. At end of turn, return it to opponent's play area. Prepare it." fontsize="18"/>
																	</box>
																</hlayout>
															</vlayout>]]
                                                }
                                            ),
                                            tags = {}
                                        },
                                        {
                                            effect = pushTargetedEffect({
												desc = "Drag champion of cost 4g or less from the Market into your play area. It will arrive expended. At end of turn, return it to the Market Deck. (Shuffle the deck.)",
												validTargets = selectLoc(centerRowLoc).where(isCardChampion().And(getCardCost().lte(4))),
												min = 0,
												max = 1,
												targetEffect = addSlotToTarget(createAbilitySlot({
														ability = createAbility({
															id = "thandarlorian_whipcord_ability",
															effect = moveTarget(tradeDeckLoc).apply(selectSource()),
															trigger = oppStartOfTurnTrigger
														}),
														expiry = { startOfOwnerTurnExpiry }
													}))
													.seq(expendTarget()).seq(moveTarget(loc(currentPid, inPlayPloc))),
												}),
                                            layout = layoutCard(
                                                {
                                                    title = "Whipcord",
                                                    art = "art/treasures/barbarian_whip",
													xmlText = [[<vlayout>
																<hlayout flexibleheight="1">
																	<box flexiblewidth="1">
																		<tmpro text="Drag champion of cost {gold_4} or less from the Market into your play area. It will arrive expended. At end of turn, return it to the Market Deck." fontsize="18"/>
																	</box>
																</hlayout>
															</vlayout>]]
												}
                                            ),
                                                                                    }
                                    }
                                }
                        ),
                cost = goldCost(2),
            }),
        }
        
    })
end

function thandarlorian_dragon_shard_armour_carddef()
    local cardLayout = createLayout({
        name = "Dragon Shard Armour",
        art = "art/epicart/lesser_angel",
        frame = "frames/Coop_Campaign_CardFrame",
		xmlText = [[
		<vlayout>
			<hlayout flexibleheight="1">
				<box flexiblewidth="1">
					<tmpro text="Each turn gain 2 Toughness" fontsize="22"/>
				</box>
			</hlayout>
		</vlayout>
		]]
    })

    return createSkillDef({
        id = "thandarlorian_dragon_shard_armour_skill",
        name = "Dragon Shard Armour",
        types = { skillType },
        layout = cardLayout,
        layoutPath = "art/epicart/lesser_angel",
        abilities = {
            createAbility({
                id = "thandarlorian_dragon_shard_armour_ab",
                trigger = startOfTurnTrigger,
                activations = singleActivation,
                layout = cardLayout,
				promptType = noPrompt,
                effect = gainToughnessEffect(2),
                cost = noCost,
            }),
        }
        
    })
end


-- Paladin cards
function paladin_warhammer_carddef()
    return createDef(
        {
            id = "paladin_warhammer",
            name = "Warhammer",
            types = {weaponType, noStealType, paladinType, itemType, meleeWeaponType, hammerType},
            acquireCost = 0,
            cardTypeLabel = "Item",
            playLocation = castPloc,
            abilities = {
                createAbility(
                    {
                        id = "paladin_warhammer",
                        layout = cardLayout,
                        effect = ifElseEffect(selectLoc(currentCastLoc).where(isCardType(weaponType)).count().gte(2),
                        gainCombatEffect(2).seq(gainHealthEffect(2)),
                        pushChoiceEffect(
                                {
                                    choices = {
                                        {
                                            effect = gainCombatEffect(2),
                                            layout = layoutCard(
                                                {
                                                    title = "Warhammer",
                                                    art = "art/T_Flesh_Ripper",
                                                    text = "Gain <sprite name=\"combat_2\">"
                                                }
                                            ),
                                            tags = {gainCombat2Tag}
                                        },
                                        {
                                            effect = gainHealthEffect(2),
                                            layout = layoutCard(
                                                {
                                                    title = "Warhammer",
                                                    art = "art/T_Flesh_Ripper",
                                                    text = "Gain <sprite name=\"health_2\">"
                                                }
                                            ),
                                            tags = {gainHealth2Tag}
                                        }
                                    }
                                }
                        )),
                        trigger = autoTrigger,
                        tags = {}
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Warhammer",
                    art = "art/T_Flesh_Ripper",
                    frame = "frames/Cleric_CardFrame",
                    text = "Gain <sprite name=\"combat_2\"> or Gain <sprite name=\"health_2\"> \n <size=50%>If you have played a weapon this turn, gain both.</size>",
                }
            )
        }
    )
end

function paladin_crusader_carddef()
    return createChampionDef(
        {
            id = "paladin_Crusader",
            name = "Crusader",
            acquireCost = 0,
            health = 2,
            isGuard = true,
            abilities = {
                createAbility(
                    {
                        id = "Crusader_main",
                        trigger = uiTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = pushChoiceEffect(
                            {
                                choices = {
                                    {
                                        effect = gainGoldEffect(1),
                                        layout = layoutCard(
                                            {
                                                title = "Crusader",
                                                art = "avatars/man_at_arms",
                                                text = ("{1 gold}")
                                            }
                                        ),
                                        tags = {gainGoldTag}
                                    },
                                    {
                                        effect = gainHealthEffect(1),
                                        layout = layoutCard(
                                            {
                                                title = "Crusader",
                                                art = "avatars/man_at_arms",
                                                text = ("{1 health}")
                                            }
                                        ),
                                        tags = {gainHealthTag}
                                    }
                                }
                            }
                        )
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Crusader",
                    art = "avatars/man_at_arms",
                    frame = "frames/Cleric_CardFrame",
                    text = "<size=250%><pos=-5%><sprite name=\"expend\"></pos></size><size=175%><pos=25%><voffset=.2em><sprite name=\"gold_1\"> or <sprite name=\"health_1\"></size></voffset>",
                    health = 2,
                    isGuard = true
                }
            )
        }
    )
end

function paladin_prayer_carddef()
    local cardLayout = createLayout({
        name = "Prayer",
        art = "icons/wind_storm",
        frame = "frames/Cleric_CardFrame",
        text = "<size=400%><line-height=0%><voffset=-.25em> <pos=-75%><sprite name=\"expend_2\"></size><line-height=135%> \n <voffset=2em><size=120%><pos=10%>Gain <sprite name=\"health_3\">\n   Gain  <sprite name=\"combat_1\">"
    })

    return createSkillDef({
        id = "paladin_prayer_skill",
        name = "Prayer",
        types = { paladinType, skillType },
        layout = cardLayout,
        layoutPath = "icons/wind_storm",
        abilities = {
            createAbility({
                id = "paladin_prayer_ab",
                trigger = uiTrigger,
                activations = singleActivation,
                layout = cardLayout,
                promptType = showPrompt,
                effect = gainHealthEffect(3).seq(gainCombatEffect(1)),
                cost = goldCost(2),
            }),
        }
        
    })
end

function paladin_sacred_oath_carddef()
	return createHeroAbilityDef({
		id = "sacred_oath",
		name = "Sacred Oath",
		types = { heroAbilityType },
        abilities = {
            createAbility( {
                id = "sacred_oath_ab",
                trigger = uiTrigger,
                activations = singleActivation,
                promptType = showPrompt,
                layout = createLayout ({
                    name = "Sacred Oath",
                    art = "art/T_Devotion",
                    frame = "frames/Cleric_CardFrame",
                    text = "<voffset=1em><space=-.5em><voffset=-1.3em><size=200%><sprite name=\"scrap\"></size></voffset><pos=30%> <voffset=1.0em><line-height=40><space=-3.0em><space=1.5em>Prepare up to\n<space=1.5em>3 champions\n<space=1.5em>in play.</voffset></voffset>"
                    }),
                effect = pushTargetedEffect({
                    desc = "Choose up to 3 champions in play. Prepare those champions",
                    validTargets = s.CurrentPlayer(CardLocEnum.InPlay).where(isCardChampion()),
                    min = 1,
                    max = 3,
                    targetEffect = prepareTarget(),
			    }),
                cost = sacrificeSelfCost,
            }),
        },
        layout = createLayout({
            name = "Sacred Oath",
            art = "art/T_Devotion",
            text = "<voffset=1em><space=-.5em><voffset=-1.3em><size=200%><sprite name=\"scrap\"></size></voffset><pos=30%> <voffset=1.0em><line-height=40><space=-3.0em><space=1.5em>Prepare up to\n<space=1.5em>3 champions\n<space=1.5em>in play.</voffset></voffset>"
        }),
        layoutPath  = "art/T_Devotion",
	})
end	


-- Witch cards
function siphon_life_def()
	return createSkillDef({
		id = "siphon_life",
		name = "Siphon Life",
		cardTypeLabel = "Skill",
		types = { skillType },
        abilities = {
			createAbility({
				id = "siphonLifeActivate",
				trigger = uiTrigger,
				promptType = showPrompt,
				layout = createLayout({
					name = "Siphon Life",
					art = "art/T_Life_Force",
					frame = "frames/Wizard_CardFrame",
					xmlText = [[<hlayout>
							<icon text="{expend_2}" fontsize="80" flexibleheight="2"/>
							<vlayout>
								<icon text="Steal 1 current and maximum {health} from your opponent." fontsize="20" flexibleheight="2"/>
							</vlayout>
						</hlayout>]]
				}),
				effect = gainMaxHealthEffect(currentPid, 1).seq(gainHealthEffect(1)).seq(hitOpponentEffect(1)).seq(gainMaxHealthEffect(oppPid, -1)),
				cost = goldCost(2)
			})
		},
		layout = createLayout({
			name = "Siphon Life",
			art = "art/T_Life_Force",
			frame = "frames/Wizard_CardFrame",
			xmlText = [[<hlayout>
					<icon text="{expend_2}" fontsize="80" flexibleheight="2"/>
					<vlayout>
						<icon text="Steal 1 current and maximum {health} from your opponent." fontsize="20" flexibleheight="2"/>
					</vlayout>
				</hlayout>]]
		}),
		layoutPath = "art/T_Life_Force"
	})
end		

function piercing_screech_def()
	return createDef({
		id = "piercing_screech",
		name = "Piercing Screech",
		acquireCost = 0,
		cardTypeLabel = "Ability",
		playLocation = skillsPloc,
		types = { heroAbilityType },
        abilities = {
			createAbility({
				id = "piercingScreechActivate",
				trigger = uiTrigger,
				promptType = showPrompt,
				layout = createLayout({
					name = "Piercing Screech",
					art = "art/T_Banshee",
					xmlText = [[
						<hlayout>
							<icon text="{scrap}" fontsize="60" flexibleheight="2"/>
							<vlayout>
								<icon text="Target opponent discards two cards." fontsize="24" flexibleheight="2"/>
							</vlayout>
						</hlayout>
					]]
			}),
				effect = oppDiscardEffect(2),
				cost = sacrificeSelfCost
			})
		},
		layout = createLayout({
			name = "Piercing Screech",
			art = "art/T_Banshee",
			xmlText = [[
				<hlayout>
					<icon text="{scrap}" fontsize="60" flexibleheight="2"/>
					<vlayout>
						<icon text="Target opponent discards two cards." fontsize="24" flexibleheight="2"/>
					</vlayout>
				</hlayout>
			]]
		}),
		layoutPath= "art/T_Banshee"
	})
end	

function witch_flash_freeze_carddef()
	local cardLayout = createLayout({
		name = "Flash Freeze",
		art = "icons/ranger_fast_track",
		frame = "frames/Wizard_CardFrame",
		text = "<size=180%><sprite name=\"combat_1\"><size=100%><br>Expend target champion."
	})
	
	return createActionDef({
		id = "witch_flash_freeze",
		name = "Flash Freeze",
		layout = cardLayout,
		abilities = {
			createAbility({
				id = "flashFreezeMain",
				trigger = autoTrigger,
				effect = gainCombatEffect(1).seq(pushTargetedEffect({
					desc = "Expend target Champion",
					min = 1,
					max = 1,
					validTargets = selectLoc(loc(oppPid, inPlayPloc)).where(isCardStunnable()).where(isCardExpended().invert()),
					targetEffect = expendTarget()
				}))
			})
		}
	})
end

	function witch_cauldron_carddef()
	local cardLayout = createLayout({
		name = "Witch's Cauldron",
		art = "art/T_Confused_Apparition",
		frame = "frames/Coop_Campaign_CardFrame",
		cardTypeLabel = "Item",
		xmlText = [[<vlayout>
				<icon text="{gold_1} {health_3}" fontsize="40" flexibleheight="2"/>
				<divider/>
				<icon text="You may stun a friendly champion. If you do, draw a card." fontsize="20" flexibleheight="2"/>
			</vlayout>]]
	})
	
	return createDef({
		id = "witch_cauldron",
		name = "Witch's Cauldron",
		acquireCost = 0,
		cardTypeLabel = "Item",
		types = { itemType },
		layout = cardLayout,
		playLocation = castPloc,
		abilities = {
			createAbility({
				id = "cauldronMain",
				trigger = autoTrigger,
				effect = gainGoldEffect(1).seq(gainHealthEffect(3))
			}),
			createAbility({
				id = "cauldronStun",
				trigger = uiTrigger,
				promptType = showPrompt,
				layout = cardLayout,
				effect = pushTargetedEffect({
					desc = "Stun a friendly champion.",
					min = 1,
					max = 1,
					validTargets = selectLoc(loc(currentPid, inPlayPloc)),
					targetEffect = stunTarget().seq(drawCardsEffect(1))
				}),
				check = selectLoc(currentInPlayLoc).count().gte(1)
			})
		}
	})
end


-- Shaman cards
function flame_burst_carddef()
    return createActionDef({
        id="flame_burst",
        name="Flame Burst",
        types={noStealType,actionType},
        acquireCost=0,
        abilities = {
            createAbility({
                id="flame_burst_auto",
                trigger= autoTrigger,
                effect = gainCombatEffect(2)
            })
        },
        layout = createLayout({
            name = "Flame Burst",
            art = "art/T_Spreading_Sparks",
            frame = "frames/Generic_CardFrame",
            xmlText = [[
                <vlayout>
                    <hlayout flexibleheight="1">
                        <box flexiblewidth="8">
                            <tmpro text="{combat_2}" fontsize="100"/>
                        </box>
                    </hlayout>
                </vlayout>
            ]]
        })
    })
end

function call_lightning_carddef()
    return createActionDef({
        id="call_lightning",
        name="Call Lightning",
        types={noStealType,actionType},
        acquireCost=0,
        playAllType={noPlayPlayType,blockPlayType},
        abilities = {
            createAbility(
                {
                    id="call_lightning_auto",
                    trigger= autoTrigger,
                    effect = gainCombatEffect(selectLoc(currentCastLoc).where(isCardAction()).count())
                }
            )
        },
        layout = createLayout({
            name = "Call Lightning",
            art = "icons/wizard_soul_channel",
            frame = "frames/Generic_CardFrame",
            xmlText = [[
                <vlayout>
                    <hlayout flexibleheight="1">
                        <box flexiblewidth="8">
                            <tmpro text="Gain {combat_1} for every action in play" fontsize="40" />
                        </box>
                    </hlayout>
                </vlayout>
            ]]
        })
    })
end

function natures_blessing_carddef()

    return createActionDef({
        id="natures_blessing",
        name="Natures Blessing",
        types={noStealType,actionType},
        acquireCost=0,
        abilities = {
            createAbility(
                {
                    id="natures_blessing_auto",
                    trigger= autoTrigger,
                    effect = gainGoldEffect(1).seq(healPlayerEffect(currentPid,1))
                }
            )
        },
        layout = createLayout({
            name = "Natures Blessing",
            art = "art/T_Nature_S_Bounty",
            frame = "frames/Generic_CardFrame",
            xmlText = [[
                <vlayout>
                    <hlayout flexibleheight="1">
                        <box flexiblewidth="8">
                            <tmpro text="{gold_1} {health_1}" fontsize="80" />
                        </box>
                    </hlayout>
                </vlayout>
            ]]
        })
    })
end

function gift_of_the_elements_carddef()

    local protectionLayout = layoutCard({
        name = "Protection",
        art = "art/T_Splashing_Wave",
        xmlText = [[
            <vlayout>
                <hlayout flexibleheight="1">
                    <box flexiblewidth="8">
                        <tmpro text="Gain {health}" fontsize="50" />
                    </box>
                </hlayout>
            </vlayout>
        ]]
    })

    local destructionLayout = layoutCard({
        name = "Destruction",
        art = "art/T_Spreading_Blaze",
        xmlText = [[
            <vlayout>
                <hlayout flexibleheight="1">
                    <box flexiblewidth="8">
                        <tmpro text="Gain {combat}" fontsize="50" />
                    </box>
                </hlayout>
            </vlayout>
        ]]
    })

    return createSkillDef({
        id="gift_of_the_elements",
        name="icons/wind_storm",
        cardTypeLabel = "Skill",
		types = { skillType },
        acquireCost = 2,
        abilities  = {
            createAbility({
                trigger = uiTrigger,
                id="gift_of_the_elements_trigger",
                cost = goldCost(2),
                effect = pushChoiceEffect({
					choices = {
						{
                            layout = destructionLayout,
                            effect= gainCombatEffect(selectLoc(currentCastLoc).where(isCardAction()).count()),
                            tags = {}
                        },
                        {
                            layout = protectionLayout,
                            effect = healPlayerEffect(currentPid, selectLoc(currentCastLoc).where(isCardAction()).count()),
                            tags = {}
                        }
                    }    
                })
            })
                
        },
        layout = createLayout({
            name = "Gift of the Elements",
            art = "icons/wind_storm",
            frame = "frames/Generic_CardFrame",
            xmlText = [[
                <vlayout>
                    <hlayout flexibleheight="1">
                        <box flexiblewidth="1">
                            <tmpro text="{expend_2}" fontsize="72" />
                        </box>
                        <box flexiblewidth="7">
                            <tmpro text="Gain {combat_1} or {health_1} for every action in play" fontsize="32" />
                        </box>
                    </hlayout>
                </vlayout>
            ]]
        }),
        layoutPath = "icons/wind_storm"
    })
end

function elemental_surge_def()
	return createDef({
		id = "elemental_surge_def",
		name = "Elemental Surge",
		acquireCost = 0,
		cardTypeLabel = "Ability",
		playLocation = skillsPloc,
		types = { heroAbilityType },
        abilities = {
			createAbility({
				id = "elemental_surge_active",
				trigger = uiTrigger,
				promptType = showPrompt,
				layout = createLayout({
					name = "Elemental Surge",
					art = "icons/growing_flame",
					xmlText = [[
                        <vlayout>
                            <hlayout flexibleheight="1">
                                <box flexiblewidth="8">
                                    <tmpro text="Gain {combat_1}, {health_1}, and {gold_1} for every action you have in play" fontsize="30" />
                                </box>
                            </hlayout>
                        </vlayout>
                    ]]
                }),
				effect = gainCombatEffect(selectLoc(currentCastLoc).where(isCardAction()).count()).seq(healPlayerEffect(currentPid, selectLoc(currentCastLoc).where(isCardAction()).count())).seq(gainGoldEffect(selectLoc(currentCastLoc).where(isCardAction()).count())),
				cost = sacrificeSelfCost
			})
		},
		layout = createLayout({
			name = "Elemental Surge",
			art = "icons/growing_flame",
			xmlText = [[
                <vlayout>
                    <hlayout flexibleheight="1">
                        <box flexiblewidth="8">
                            <tmpro text="Gain {combat_1}, {health_1}, and {gold_1} for every action you have in play" fontsize="30" />
                        </box>
                    </hlayout>
                </vlayout>
            ]]
        }),
		layoutPath= "icons/growing_flame"
	})
end	


-- King Midas cards
function midas_kings_adviser_carddef()
	return createChampionDef({
        id="midas_kings_adviser",
        name="Kings adviser",
        types={championType, priestType},
        acquireCost=1,
        health = 1,
        isGuard = false,
        abilities = {
			createAbility({
				id = "kingsAdviserMain",
				trigger = autoTrigger,
				effect = gainGoldEffect(1),
				cost = expendCost,
				activations = multipleActivations
			})
		},
        layout = createLayout({
			name = "Kings adviser",
			art = "art/T_Tithe_Priest",
			frame = "frames/Treasure_CardFrame",
			text = "<i>Lean into the power of “No” to fend off the distractions of shiny new objects.</i>",
			xmlText = [[<vlayout forceheight="false" spacing="6">
    <hlayout spacing="10">
       <icon text="{expend}" fontsize="50"/>
<icon text="{gold_1}" fontsize="50"/>
    </hlayout>    
    <divider/>
    <hlayout forcewidth="true" spacing="10">
        <vlayout  forceheight="false">
<text fontstyle="italic" text="Lean into the power of 'No' to fend off the distractions of shiny new objects." fontsize="16"/>
        </vlayout>
    </hlayout>
</vlayout>]],
			health = 1,
			cost = 1,
			isGuard = false
        })
    })
end


function midas_gold_carddef()
	return createItemDef({
        id = "midas_gold",
        name = "Gold",
        types = { itemType, currencyType, coinType },
        acquireCost = 0,
        abilities = {
            createAbility({
                id = "midasGoldMain",
                effect = gainGoldEffect(1),
                cost = noCost,
                trigger = autoTrigger
            })
        },
        layout = createLayout({
			name = "Gold",
			art = "art/gold_male_pale",
			frame = "frames/Treasure_CardFrame",
			xmlText = [[<vlayout forceheight="false" spacing="6">
    <hlayout spacing="10">

<icon text="{gold_1}" fontsize="50"/>

</hlayout>
    <divider/>
    <hlayout forcewidth="true" spacing="10">
        <vlayout  forceheight="false">
<text fontstyle="italic" text="Gold is forever. It is beautiful, useful, and never wears out." fontsize="16"/>
        </vlayout>
    </hlayout>
</vlayout>]],
        })
    })
end

function midas_liquid_gold_carddef()
	return createItemDef({
        id = "midas_liquid_gold",
        name = "Liquid gold",
        types = { itemType, currencyType, coinType },
        acquireCost = 0,
        abilities = {
            createAbility({
                id = "midasLiquidGoldMain",
                effect = gainGoldEffect(2),
                cost = noCost,
                trigger = autoTrigger
            })
        },
        layout = createLayout({
			name = "Liquid gold",
			art = "art/treasures/T_Cleric_Elixir_Golden",
			frame = "frames/Treasure_CardFrame",
			xmlText = [[<vlayout forceheight="false" spacing="6">
    <hlayout spacing="10">

<icon text="{gold_2}" fontsize="50"/>

</hlayout>
    <divider/>
    <hlayout forcewidth="true" spacing="10">
        <vlayout  forceheight="false">
<text fontstyle="italic" text="Wine has never tasted better." fontsize="16"/>
        </vlayout>
    </hlayout>
</vlayout>]],
        })
    })
end

function greed_is_good_skilldef()
	return createSkillDef({
		id = "greed_is_good",
		name = "Greed is Good",
		cardTypeLabel = "Skill",
		types = { skillType },
        abilities = {
			createAbility({
				id = "GreedIsGoodActivate",
				trigger = uiTrigger,
				promptType = showPrompt,
				layout = createLayout({
					name = "Greed is good",
					art = "art/T_Bribe",
					frame = "frames/Treasure_CardFrame",
					text = "",
					xmlText = [[<vlayout forceheight="false" spacing="6">
									<hlayout spacing="5">
									   <icon text="{expend}" fontsize="55"/>
									   <text text="-{health_1} permanent health to convert all gold you have in play into damage." fontsize="18"/>
									</hlayout> 
									<divider/>
									<hlayout forcewidth="true" spacing="10">
										<vlayout  forceheight="false">
											 <text fontstyle="italic" text="Where Gold speaks, every tongue is silent." fontsize="14"/>
										</vlayout>
									</hlayout>
								</vlayout>]]
				}),
				effect = gainCombatEffect(getPlayerGold(currentPid)).seq(gainGoldEffect(getPlayerGold(currentPid).multiply(-1))).seq(gainHealthEffect(-1)).seq(gainMaxHealthEffect(currentPid, -1)) ,
				cost = expendCost
			})
		},
		layout = createLayout({
			name = "Greed is good",
			art = "art/T_Bribe",
			frame = "frames/Treasure_CardFrame",
			text = "",
			xmlText = [[<vlayout forceheight="false" spacing="6">
							<hlayout spacing="5">
							   <icon text="{expend}" fontsize="55"/>
							   <text text="-{health_1} permanent health to convert all gold you have in play into damage." fontsize="18"/>
							</hlayout> 
							<divider/>
							<hlayout forcewidth="true" spacing="10">
								<vlayout  forceheight="false">
									 <text fontstyle="italic" text="Where Gold speaks, every tongue is silent." fontsize="14"/>
								</vlayout>
							</hlayout>
						</vlayout>]]
		}),
		layoutPath= "art/T_Bribe"
	})
end	

function golden_touch_abilitydef()
	return createDef({
		id = "golden_touch",
		name = "Golden touch",
		acquireCost = 0,
		cardTypeLabel = "Ability",
		playLocation = skillsPloc,
		types = { heroAbilityType },
        abilities = {
			createAbility({
				id = "goldenTouchActivate",
				trigger = uiTrigger,
				promptType = showPrompt,
				layout = createLayout({
					name = "Golden touch",
					art = "art/T_Strength_In_Numbers",
					frame = "frames/Treasure_CardFrame",
					text = "",
					xmlText = [[
						<vlayout forceheight="false" spacing="6">
							<hlayout spacing="5">
								<icon text="{scrap}" fontsize="65"/>
								<text text="Sacrifice all champions you have in play and convert them back into gold." fontsize="20"/>
							</hlayout> 
						</vlayout>
					]]
				}),
				effect = gainGoldEffect(selectCurrentChampions().sum(getCardCost())).seq(sacrificeTarget().apply(selectCurrentChampions())),
				-- effect = sacrificeTarget().apply(selectCurrentChampions()),
				-- effect = sacrificeTarget().apply(selectLoc(loc(currentPid, inPlayPloc)).where(isCardChampion())),
				cost = sacrificeSelfCost
			})
		},
		layout = createLayout({
			name = "Golden touch",
			art = "art/T_Strength_In_Numbers",
			frame = "frames/Treasure_CardFrame",
			text = "",
			xmlText = [[
				<vlayout forceheight="false" spacing="6">
					<hlayout spacing="5">
						<icon text="{scrap}" fontsize="65"/>
						<text text="Sacrifice all champions you have in play and convert them back into gold." fontsize="20"/>
					</hlayout> 
				</vlayout>
			]]
		}),
		layoutPath= "art/T_Strength_In_Numbers"
	})
end	


-- Brewmaster cards
function brewmaster_mead_carddef()
    return createDef(
        {
            id = "brewmaster_mead",
            name = "Mead",
            types = {elixirType, noStealType, itemType},
			acquireCost = 0,
            cardTypeLabel = "Item",
            playLocation = castPloc,
            abilities = {
				createAbility(
                    {
                        id = "brewmaster_mead",
                        PlayAllType = noPlayPlayType,
						cost = noCost,
						trigger = autoTrigger,
                        activations = singleActivations,
						effect = nullEffect(),
                        tags = {}
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Mead",
                    art = "art/treasures/T_Fighter_Elixir_Red",
                    frame = "frames/Generic_CardFrame",
                    xmlText=[[
					<vlayout>
    <box flexibleheight="3">
        <tmpro text="Drink up!" fontsize="20" fontstyle="italic"/>
    </box>
</vlayout>
					]]
                }
            )
        }
    )
end 

function brewmaster_spilled_drink_carddef()
    return createDef(
        {
            id = "brewmaster_spilled_drink",
            name = "Spilled Drink",
            types = {elixirType, noStealType, itemType},
			acquireCost = 0,
            cardTypeLabel = "Item",
            playLocation = castPloc,
            abilities = {
				createAbility(
                    {
                        id = "brewmaster_spilled_drink",
                        PlayAllType = blockPlayType,
						cost = noCost,
						trigger = autoTrigger,
                        activations = singleActivations,
						effect = gainGoldEffect(1).seq(pushChoiceEffect(
                                {
                                    choices = {
                                        {
                                            effect = nullEffect(),
                                            layout = layoutCard(
                                                {
                                                    name = "Spilled Drink",	
													art = "art/treasures/T_Ranger_Elixir_Yellow",
													frame = "frames/Generic_CardFrame",
                                                    xmlText=[[
													<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="7">
            <text text="Do nothing." fontsize="24"/>
</box>
</hlayout>
</vlayout>
													]]
                                                }
                                            ),
                                            tags = {gainCombatTag}
                                        },
                                        {
                                            effect = forceDiscard(1).seq(drawCardsEffect(1)),
                                            layout = createLayout({
													name = "Spilled Drink",	
													art = "art/treasures/T_Ranger_Elixir_Yellow",
													frame = "frames/Generic_CardFrame",
													xmlText=[[
<vlayout>
    <hlayout flexibleheight="1">

        <box flexiblewidth="7">
            <tmpro text="Discard a card,
then draw a card." fontsize="24" />
        </box>
    </hlayout>
</vlayout>
			]]
        }),
                                                                                    }
                                    }
                                }
                        )),
                        tags = {}
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Spilled Drink",
                    art = "art/treasures/T_Ranger_Elixir_Yellow",
                    frame = "frames/Generic_CardFrame",
                    xmlText=[[
					<vlayout>
    <box flexibleheight="3">
        <tmpro text="{gold_1}" fontsize="50"/>
    </box>
<box flexibleheight="3">
        <tmpro text="You may discard a card. If you do, draw a card." fontsize="24"/>
    </box></vlayout>
					]]
                }
            )
        }
    )
end 

function brewmaster_tap_a_keg_carddef()
    return createDef(
        {
            id = "brewmaster_tap_a_keg",
            name = "Tap a Keg",
            types = {actionType, noStealType, brewmasterType},
            acquireCost = 0,
            cardTypeLabel = "Action",
            playLocation = castPloc,
            abilities = {
                createAbility(
                    {
                        id = "brewmaster_tap_a_keg_main",
                        layout = cardLayout,
                        effect = gainGoldEffect(1),
                        trigger = autoTrigger,
						playAllType = blockPlayType,
                        tags = {}
                    }
                ),
				createAbility(
                    {
                        id = "brewmaster_tap_a_keg_1",
                        layout = cardLayout,
                        effect = ifElseEffect(selectLoc(currentDiscardLoc).where(isCardName("brewmaster_mead")).count().gte(1),gainGoldEffect(1),nullEffect()),
                        trigger = autoTrigger,
						playAllType = blockPlayType,
                        tags = {}
                    }),
				createAbility(
                    {
                        id = "brewmaster_tap_a_keg_2",
                        layout = cardLayout,
                        effect = ifElseEffect(selectLoc(currentDiscardLoc).where(isCardName("brewmaster_mead")).count().gte(3),gainGoldEffect(1),nullEffect()),
                        trigger = autoTrigger,
						playAllType = blockPlayType,
                        tags = {}
                    })
                
            },
            layout = createLayout(
                {
                    name = "Tap a Keg",
                    art = "art/treasures/T_Ranger_Elixir_Orange",
                    frame = "frames/Generic_CardFrame",
                    xmlText=[[
					<vlayout>
    <box flexibleheight="3">
        <tmpro text="{gold_1}" fontsize="30"/>
    </box>
    <box flexibleheight="3">
        <tmpro text="+{gold_1} if you have a Mead card in your discard pile.
+{gold_1} more if you have 3+ Mead cards in your discard pile." fontsize="20" />
    </box>
</vlayout>
					]],
                }
            )
        }
    )
end

function brewmaster_serve_the_strong_stuff_carddef()

    local priceBuff = getCostDiscountBuff("brewmaster_serve_the_strong_stuff_buff", -1, selectLoc(centerRowLoc).union(selectLoc(fireGemsLoc)))
    local buffCreator = createGlobalBuff({
        id="brewmaster_serve_the_strong_stuff_buff",
        name = "Serve the strong stuff",
        abilities = {
            createAbility({
                id="brewmaster_serve_the_strong_stuff_effect",
                trigger = endOfTurnTrigger,
                effect = createCardEffect(priceBuff, loc(oppPid, buffsPloc)).seq(sacrificeSelf())
            })
        },
		
    })
    return createDef(
        {
            id = "brewmaster_serve_the_strong_stuff",
            name = "Serve the strong stuff",
            types = {noStealType, itemType},
            acquireCost = 0,
            cardTypeLabel = "Action",
            playLocation = castPloc,
            abilities = {
                createAbility(
                    {
                        id = "brewmaster_serve_the_strong_stuff",
                        layout = cardLayout,
                        effect = pushTargetedEffect({
							desc = "Prepare a champion.",
							validTargets = s.CurrentPlayer(CardLocEnum.InPlay).where(isCardChampion()),
							min = 0,
							max = 1,
							targetEffect = prepareTarget(),
			    }),
                        trigger = uiTrigger,
                        tags = {}
                    }
					
                ),
				createAbility(
                    {
                        id = "brewmaster_serve_the_strong_buff",
                        layout = cardLayout,
                        effect = createCardEffect(buffCreator, loc(currentPid, buffsPloc)),
                        trigger = autoTrigger,
                        tags = {}
                    }
					
                )
            },
            
			createBuffDetails({
					art = "art/treasures/T_Bottle_Of_Rum",
					name = "Serve the strong stuff",
					text = "Your first purchase this turn costs +1 gold."
							}),
		
		layout = createLayout(
                {
                    name = "Serve the strong stuff",
                    art = "art/treasures/T_Bottle_Of_Rum",
                    frame = "frames/Generic_CardFrame",
                    xmlText=[[
<vlayout>
    <box flexibleheight="1">
        <tmpro text="Opponent must pay +{gold_1} for their first purchase next turn.

Prepare a champion." fontsize="20"/>
</box>
</vlayout>
					]],
                }
            )
        }
    )
end

function brewmaster_regular_regulars_carddef()
    return createChampionDef(
        {
            id = "brewmaster_regular_regulars",
            name = "Regular Regulars",
			types = {championType, nostealType},
            acquireCost = 0,
            health = 1,
            isGuard = false,
            abilities = {
                createAbility(
                    {
                        id = "regular_regulars_main",
                        trigger = autoTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
						playAllType = blockPlayType,
                        effect = ifElseEffect(selectLoc(loc(currentPid, castPloc)).where(isCardName("brewmaster_mead")).count().gte(1), gainGoldEffect(2), gainGoldEffect(1)),
                    }
                ),
            },
            layout = createLayout(
                {
                    name = "Regular Regulars",
                    art = "avatars/cristov_s_recruits",
                    frame = "frames/Generic_CardFrame",
                    xmlText=[[
<vlayout>
    <hlayout flexibleheight="3">
        <box flexiblewidth="1">
            <tmpro text="{expend}" fontsize="40"/>
        </box>
        <vlayout flexiblewidth="4">
            <box flexibleheight="1">
                <tmpro text="{gold_1}" fontsize="40" />
            </box>
            <box flexibleheight="1">
                <tmpro text="+{gold_1} if you already have Mead in play." fontsize="24" />
            </box>
        </vlayout>
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

function brewmaster_irregular_regulars_carddef()
    return createChampionDef(
        {
            id = "brewmaster_irregular_regulars",
            name = "Irregular Regulars",
			types = {championType, nostealType},
            acquireCost = 0,
            health = 2,
            isGuard = false,
            abilities = {
                createAbility(
                    {
                        id = "irregular_regulars_main",
                        trigger = autoTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
						playAllType = blockPlayType,
                        effect = ifElseEffect(selectLoc(loc(currentPid, castPloc)).where(isCardName("brewmaster_mead")).count().gte(1), gainGoldEffect(1).seq(gainCombatEffect(2)), gainGoldEffect(1)),
                    }
                ),
            },
            layout = createLayout(
                {
                    name = "Iregular Regulars",
                    art = "art/T_Orc_Riot",
                    frame = "frames/Generic_CardFrame",
                    xmlText=[[

<vlayout>
    <hlayout flexibleheight="3">
        <box flexiblewidth="1">
            <tmpro text="{expend}" fontsize="40"/>
        </box>
        <vlayout flexiblewidth="4">
            <box flexibleheight="1">
                <tmpro text="{gold_1}" fontsize="40" />
            </box>
            <box flexibleheight="1">
                <tmpro text="+{combat_2} if you already have Mead in play." fontsize="24" />
            </box>
        </vlayout>
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

function brewmaster_zaboozer_carddef()
    return createChampionDef(
        {
            id = "brewmaster_zaboozer",
            name = "Zaboozer, Heroic Regular",
			types = {championType, nostealType},
            acquireCost = 0,
            health = 2,
            isGuard = true,
            abilities = {
               	createAbility(
                    {
                        id = "zaboozer_mead",
                        trigger = autoTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
						playAllType = blockPlayType,
                        effect = ifElseEffect(selectLoc(loc(currentPid, castPloc)).where(isCardName("brewmaster_mead")).count().gte(1), gainCombatEffect(1).seq(addSlotToTarget(createGuardSwitchSlot(false, { endOfTurnExpiry })).apply(selectSource())), gainCombatEffect(3)),
                    }
                ),
            },
            layout = createLayout(
                {
                    name = "Zaboozer, Heroic Regular",
                    art = "art/T_Maurader",
                    frame = "frames/Generic_CardFrame",
                    xmlText=[[
					<vlayout>
    <hlayout flexibleheight="3">
        <box flexiblewidth="1">
            <tmpro text="{expend}" fontsize="40"/>
        </box>
        <vlayout flexiblewidth="4">
            <box flexibleheight="1">
                <tmpro text="{combat_3} if no Mead in play." fontsize="20" />
            </box>
            <box flexibleheight="2">
                <tmpro text="If Mead is in play, only gain {combat_1} and lose Guard." fontsize="20" />
            </box>
        </vlayout>
    </hlayout>

<divider/>
            <box flexibleheight="1">
                <tmpro text="'Where's my drink?!'" fontsize="14" fontstyle="bold, italic"/>
            </box>
</vlayout>
]],
                    health = 2,
                    isGuard = true
                }
            )
        }
    )
end

function brewmaster_a_round_on_the_house_def()

    local cardLayout = createLayout({
        name = "A round on the House",
        art = "art/T_Unify_Apsara",
        frame = "frames/Generic_CardFrame",
        xmlText=[[
        <vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <icon text="{expend_2}" fontsize="72"/>
        </box>
        <box flexiblewidth="7">
            <tmpro text="+{combat_1} for every champion you have in play.

Then, ALL champions (yours and opponent's) get -1{shield} until they leave play." fontsize="18" />
        </box>
    </hlayout>
</vlayout>
        ]]
    })

    return createSkillDef({
        id = "brewmaster_a_round_on_the_house_skill",
        name = "A round on the House",
        types = { skillType },
        layout = cardLayout,
        layoutPath = "art/T_Unify_Apsara",
        abilities = {
            createAbility({
                id = "a_round_on_the_house_ab",
                trigger = uiTrigger,
				promptType = showPrompt,
                activations = singleActivation,
                layout = cardLayout,
                effect =  gainCombatEffect(selectLoc(currentInPlayLoc).where(isCardChampion()).count())
					.seq((grantHealthTarget(-1, { SlotExpireEnum.leavesPlay }, nullEffect(), "shadow")).apply(selectLoc(loc(currentPid, inPlayPloc)).where(isCardChampion())))
					.seq((grantHealthTarget(-1, { SlotExpireEnum.leavesPlay }, nullEffect(), "shadow")).apply(selectLoc(loc(oppPid, inPlayPloc)).where(isCardChampion()))),
                cost = goldCost(2)
            }),
        }
        
    })
end

    local thrownOutBarBuff = createGlobalBuff({
        id="brewmaster_serve_the_strong_stuff_buff",
        name = "Get out of my bar",
        abilities = {
            createAbility({
                id="brewmaster_get_out_of_my_bar_effect",
                trigger = deckShuffledTrigger,
                effect = moveToBottomDeckTarget(false, 0).apply(selectSavedTargets("Thrown out bar")).seq(sacrificeSelf())
            })
        }
    })

function brewmaster_get_out_of_my_bar_carddef()
	return createHeroAbilityDef({
		id = "get_out_of_my_bar_buff",
		name = "Get out of my bar",
		types = { heroAbilityType },
        abilities = {
			createAbility({
				id = "get_out_of_my_barActivate",
				trigger = uiTrigger,
				promptType = showPrompt,
				layout = createLayout({
					name = "Get out of my bar",
					art = "art/T_orc",
					frame = "frames/Generic_CardFrame",
					xmlText=[[
					<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{scrap}" fontsize="40"/>
        </box>
        <box flexiblewidth="7">
            <tmpro text="Set aside a champion you stunned this turn. The next time your opponent shuffles their deck, put that champion on the bottom of their deck.

Or draw a card." fontsize="18" />
        </box>
    </hlayout>
</vlayout>
					]]
				}),
				effect = pushChoiceEffect(
                                {
                                    choices = {
                                        {
                                            effect = drawCardsEffect(1),
                                            layout = layoutCard(
                                                {
                                                    name = "Get out of my bar",	
													art = "art/T_orc",
													frame = "frames/Generic_CardFrame",
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
                                            tags = {gainCombatTag}
                                        },
                                        {
                                            effect = pushTargetedEffect({
												  desc = "Sacrifice a champion from opponent's discard pile. Only useable on champions stunned this turn.",
												  min=0,
												  max=1,
												  validTargets = selectLoc(loc(oppPid, discardPloc)).where(isCardChampion()).where(isCardStunned()),
												  targetEffect = saveTarget("Thrown out bar").seq(moveTarget(sacrificePloc))
																.seq(createCardEffect(thrownOutBarBuff, loc(oppPid, buffsPloc)))
												  }),
                                            layout = createLayout({
													name = "Get out of my bar",	
													art = "art/T_orc",
													frame = "frames/Generic_CardFrame",
													xmlText=[[
<vlayout>
    <hlayout flexibleheight="1">

        <box flexiblewidth="7">
            <tmpro text="Set aside a champion you stunned this turn. The next time your opponent shuffles their deck, put that champion on the bottom of their deck." fontsize="18" />
        </box>
    </hlayout>
</vlayout>
			]]
        }),
                                                                                    }
                                    }
                                }
                        ),
				cost = sacrificeSelfCost
			})
		},
        layout = createLayout({
            name = "Get out of my bar",	
            art = "art/T_orc",
			frame = "frames/Generic_CardFrame",
            xmlText=[[
<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{scrap}" fontsize="40"/>
        </box>
        <box flexiblewidth="7">
            <tmpro text="Set aside a champion you stunned this turn. The next time your opponent shuffles their deck, put that champion on the bottom of their deck.

Or draw a card." fontsize="18" />
        </box>
    </hlayout>
</vlayout>
			]]
        }),
        layoutPath  = "art/T_orc",
	})
end	


-- S&R Enjoyer cards
function bird_dog_def()
	local layout = createLayout({
					name = "BirdWalking",
					art = "art/T_Spark",
					xmlText = [[<vlayout>
									<hlayout flexibleheight="1">
										<box flexiblewidth="1">
											<tmpro text="{expend_2}" fontsize="72"/>
										</box>
										<box flexiblewidth="7">
											<tmpro text="Draw a card and keep talking for 10 more minutes." fontsize="22" />
										</box>
									</hlayout>
								</vlayout>]]
				})
	return createSkillDef({
		id = "bird_dog",
		name = "BirdWalking",
		cardTypeLabel = "Skill",
		types = { skillType },
        abilities = {
			createAbility({
				id = "birdDogActivate",
				trigger = uiTrigger,
				promptType = showPrompt,
				layout = layout,
                effect = drawCardsEffect(1),
				cost = goldCost(2)
			})
		},
		layout = layout,
		layoutPath= "art/T_Spark"
	})
end

function patron_shoutout_def()
	local layout = createLayout({
					name = "Shoutout to the Patrons",
					art = "art/T_Command",
					xmlText = [[{gold_3}]]
				})
    local promptLayout = createLayout({
        name = "Shoutout to the Patrons",
        art = "art/T_Command",
        text = format("Gain {0} gold.", { 3 }),
    })

	return createHeroAbilityDef({
		id = "patron_shoutout",
		name = "Shoutout to the Patrons",
		acquireCost = 0,
		cardTypeLabel = "Ability",
		playLocation = skillsPloc,
		types = { abilityType },
        abilities = {
			createAbility({
				id = "piercingScreechActivate",
				trigger = uiTrigger,
				promptType = showPrompt,
				layout = promptLayout,
				effect = gainGoldEffect(3),
				cost = sacrificeSelfCost
			})
		},
		layout = layout,
		layoutPath= "art/T_Command"
	})
end

function hero_dash_helper_carddef()
	local cardLayout = createLayout({
		name = "Hero-Helper Plug",
		art = "art/T_Stone_Guardian",
		frame = "frames/Warrior_CardFrame",
		cardTypeLabel = "Champion",
		types = { championType, noStealType },
		text = "<size=160%><pos=-40%><sprite name=\"expend\"></size><size=180%><voffset=12><space=1.36em><sprite name=\"combat_2\"></voffset></size><line-height=40%><br>_________________</line-height><br><size=75%><voffset=-3>Visit: Hero-Helper.com</voffset></size>"
	})
	return createChampionDef({
		id = "hero_helper",
		name = "Hero-Helper",
		acquireCost = 0,
		health = 2,
		isGuard = true,
		layout = cardLayout,
		factions = {},
		abilities = {
			createAbility({
				id = "hhMain",
				trigger = autoTrigger,
				activations = multipleActivations,
				cost = expendCost,
				effect = gainCombatEffect(2)
			})
		}
	})
end

function situational_card_carddef()
	local cardLayout = createLayout({
		name = "Situational Card",
		art = "art/T_Elixir_Of_Fortune",
		frame = "frames/Cleric_Frames/Cleric_Treasure_CardFrame",
		cardTypeLabel = "Item",
		text = "<size=150%><sprite name=\"gold_1\"><line-height=40%><br>_______________</line-height><br><size=75%><voffset=-3>I would buy this over<br> Tithe Priest.</voffset></size>"
	})
	
	return createItemDef({
		id = "situational_card",
		name = "Situational Card",
		acquireCost = 0,
		cardTypeLabel = "Item",
		types = { itemType, noStealType },
		layout = cardLayout,
		playLocation = castPloc,
		abilities = {
			createAbility({
				id = "situationMain",
				trigger = autoTrigger,
				effect = gainGoldEffect(1)
			}),
		}
	})
end

function wwyd_carddef()
	local cardLayout = createLayout({
		name = "WWYD?",
		art = "art/T_Edge_Of_The_Moat",
		frame = "frames/Ranger_CardFrame",
		cardTypeLabel = "Action",
		text = "<size=150%><sprite name=\"combat_3\"><size=80%>  or  <size=150%><sprite name=\"health_4\"><size=80%><br>If you have Street Thug in play, do both."
	})
	local faceLayout = layoutCard({
		title = "WWYD?",
		art = "art/T_Blazing_Fire",
		text = "<size=300%><sprite name=\"combat_3\">"
	})
	local removalLayout = layoutCard({
		title = "WWYD?",
		art = "art/T_Evangelize",
		text =  "<size=300%><sprite name=\"health_4\">"
	})
	
	return createActionDef({
		id = "wwyd_card",
		name = "WWYD?",
		acquireCost = 0,
		cardTypeLabel = "Action",
		types = { actionType, noStealType },
		layout = cardLayout,
		playLocation = castPloc,
		abilities = {
			createAbility({
				id = "noChampMain",
				trigger = autoTrigger,
				effect = ifElseEffect(selectLoc(currentInPlayLoc).where(isCardName("street_thug")).count().gte(1),
								gainCombatEffect(3).seq(gainHealthEffect(4)),
								pushChoiceEffect({
					choices = {
						{
							effect = gainCombatEffect(3),
							layout = faceLayout
						},
						{
							effect = gainHealthEffect(4),
							layout = removalLayout
						}
					}
				})
			)
			}),
		}
	})
end

function nostra_dbl_damus_carddef()
	local cardLayout = createLayout({
		name = "NostraDblDamus",
		art = "art/T_Channel",
		frame = "frames/Wizard_CardFrame",
		cardTypeLabel = "Champion",
		types = { championType, noStealType },
		text = "<size=140%><pos=-40%><sprite name=\"expend\"></size><size=160%><voffset=12><space=1.36em><sprite name=\"gold_1\"></voffset></size><br><size=50%>Reveal the top card of your<br> deck. Discard it or put it back<br> on the top of your deck.</voffset></size><line-height=30%><br>_________________</line-height><br><size=45%><voffset=-3>Visions of Thandar!</voffset></size>"
	})
	return createChampionDef({
		id = "nostra_dbl_damus",
		name = "NostraDblDamus",
		acquireCost = 0,
		health = 2,
		isGuard = false,
		layout = cardLayout,
		factions = {},
		abilities = {
			createAbility({
				id = "nddOnPlay",
				trigger = uiTrigger,
				activations = multipleActivations,
				cost = expendCost,
				effect = gainGoldEffect(1).seq(drawToLocationEffect(1, currentRevealLoc)
				.seq(promptSplit({
				   selector = selectLoc(currentRevealLoc),
				   take = const(4),
				   sort = const(2),
				   ef1 =moveToTopDeckTarget(true),
				   ef2 = discardTarget(),
				   header = "Visions of Thandar",
				   description = "Look at the top card of your deck. You may put it in your discard pile, or put it back on the top of your deck.",
				   pile1Name = "Top of Deck",
				   pile2Name = "Discard Pile",
				   eff1Tags = { buytopdeckTag },
				   eff2Tags = { cheapestTag }
			   }))
			)
			})
		}
	})
end

function blank_to_my_blank_carddef()
	local cardLayout = createLayout({
		name = "The _____ To My _____ ",
		art = "art/T_Paladin_Sword",
		frame = "frames/Warrior_CardFrame",
		cardTypeLabel = "Item",
		text = "<size=200%><sprite name=\"gold_1\"><space=0.7em><sprite name=\"combat_2\"></size>"
	})
	
	return createItemDef({
		id = "b2mb_card",
		name = "The Blank To My Blank",
		acquireCost = 0,
		cardTypeLabel = "Item",
		types = { itemType, noStealType },
		layout = cardLayout,
		playLocation = castPloc,
		abilities = {
			createAbility({
				id = "b2mbMain",
				trigger = autoTrigger,
				effect = gainGoldEffect(1).seq(gainCombatEffect(2)),
			}),
		}
	})
end

function congrats_youre_a_nerd_carddef()
	local cardLayout = createLayout({
		name = "Congrats, You're A Nerd",
		art = "art/treasures/wizard_wizened_familiar",
		frame = "frames/Wizard_CardFrame",
		cardTypeLabel = "Action",
		text = "<size=100%>Opponent discards 1.<line-height=40%><br>_______________</line-height><br><size=50%><voffset=-3>When this card goes into your discard pile, put it on the bottom of your deck.</voffset></size>"
	})
	
	return createActionDef({
		id = "congrats_youre_a_nerd_card",
		name = "Congrats, You're A Nerd",
		acquireCost = 0,
		cardTypeLabel = "Action",
		types = { actionType, noStealType },
		layout = cardLayout,
		playLocation = castPloc,
		abilities = {
			createAbility({
				id = "congratsMain",
				trigger = autoTrigger,
				effect = oppDiscardEffect(1),
			}),
			createAbility({
				id = "congratsBottomDeck",
				trigger = onDiscardTrigger,
				effect = moveToBottomDeckTarget(false).apply(selectSource()),
			}),
			createAbility({
				id = "congratsBottomDeck2",
				trigger = endOfTurnTrigger,
				effect = moveToBottomDeckTarget(false).apply(selectSource()),
			}),
		}
	})
end



-- Easter Egg cards


function ee_demon_hunter_carddef()
    return createChampionDef(
        {
            id = "demon_hunter",
            name = "Demon Hunter",
			types = {championType},
			factions = { imperialFaction },
            acquireCost = 5,
            health = 5,
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
									art = "art/T_Paladin_Sword",
                                    frame = "frames/Imperial_Champion_CardFrame",
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
									art = "art/T_Paladin_Sword",
                                    frame = "frames/Imperial_Champion_CardFrame",
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
									art = "art/T_Paladin_Sword",
                                    frame = "frames/Imperial_Champion_CardFrame",
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
				  cost = noCost,
				  activations = singleActivation,
				  effect = drawCardsEffect(1),
				  promptType = showPrompt,
					layout = layoutCard(
                                                {
                                                    name = "Demon Hunter",
													art = "art/T_Paladin_Sword",
													frame = "frames/Imperial_Champion_CardFrame",
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
				  allyFactions = {imperialFaction}
				}),
				
				createAbility({
				  id = "demon_hunter_2ally",
				  trigger = uiTrigger, 
				  effect = gainHealthEffect(selectLoc(loc(oppPid, discardPloc)).where(isCardStunned()).count().multiply(2)), 
				  promptType = showPrompt,
					layout = layoutCard(
                                                {
                                                    name = "Demon Hunter",
													art = "art/T_Paladin_Sword",
													frame = "frames/Imperial_Champion_CardFrame",
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
				  allyFactions = {imperialFaction, imperialFaction}
				}),
            },
            layout = createLayout(
                {
                    name = "Demon Hunter",
                    art = "art/epicart/white_knight",
                    frame = "frames/Imperial_Champion_CardFrame",
					cost = 5,
                    xmlText=[[
<vlayout>
<hlayout flexibleheight="2">
<box flexiblewidth="1">
<tmpro text="{expend}" fontsize="32"/>
</box>
<box flexiblewidth="7">
<tmpro text="{combat_4}&lt;size=80%&gt; or 2 damage
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
                    health = 5,
                    isGuard = true
                }
            )
        }
    )
end


function mythic_mercs_ee_scrapforks_carddef()
    return createChampionDef(
        {
            id = "scrapforks",
            name = "Scrapforks",
			types = {championType},
            acquireCost = 4,
            health = 5,
            isGuard = false,
            abilities = {
                createAbility(
                    {
                        id = "scrapforks_main",
                        trigger = uiTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = randomEffect({
					valueItem(4, gainCombatEffect(5)),
					valueItem(1, moveTarget(loc(currentPid, deckPloc)).apply(selectSource()).seq(shuffleEffect(loc(currentPid, deckPloc))))
                    }
                ).seq(noUndoEffect())
						
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Scrapforks",
                    art = "art/epicart/lord_of_the_arena",
                    frame = "frames/Treasure_CardFrame",
					cost = 4,
                    xmlText=[[
					<vlayout>
    <hlayout flexibleheight="3">
            <tmpro text="{expend}" fontsize="50" flexiblewidth="2"/>
            <tmpro text="80% chance: {combat_5}
20% chance to not show up: shuffle back into deck" fontsize="20
" flexiblewidth="12" />
    </hlayout>
    <divider/>
    <hlayout flexibleheight="2">
            <tmpro text="His pauldrons are made from old cutlery." fontsize="20" fontstyle="italic" flexiblewidth="10" />
    </hlayout> 
</vlayout>
					]],
                    health = 5,
                    isGuard = false
                }
            )
        }
    )
end


function mythic_mercs_ee_dblducks_carddef()
    return createChampionDef(
        {
            id = "dblducks",
            name = "Dbl Ducks",
			types = {championType},
            acquireCost = 4,
            health = 5,
            isGuard = true,
            abilities = {
                createAbility(
                    {
                        id = "dblducks",
                        trigger = uiTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = gainCombatEffect(4).seq(moveTarget(myRevealPloc).apply(selectLoc(loc(currentPid, deckPloc)).take(2)).seq(noUndoEffect()).seq(promptSplit({
    selector = selectLoc(currentRevealLoc),
    take = const(1), -- number of cards to take for split
    sort = const(1), -- number of cards to be sorted for ef2
	minTake = const(1), -- number of mandatory cards moved to ef2
    ef1 = moveToTopDeckTarget(true, 1), -- effect to be applied to cards left
    ef2 = moveToBottomDeckTarget(true, 1), -- effect to be applied to sorted cards
    header = "Gaze into the future", -- prompt header
    description = "Look at the top two cards of your deck. Put one on the top and one on the bottom of your deck.",
    rightPileDesc = "Right card on top.",
    pile1Name = "Top of Deck",
    pile2Name = "Bottom of Deck",
    eff1Tags = { buytopdeckTag },
    eff2Tags = { cheapestTag }
})))
						
                    }
                )
            },
            layout = createLayout(
                {
                    name = "DblDucks",
                    art = "art/epicart/banishment",
                    frame = "frames/Treasure_CardFrame",
					cost = 4,
                    xmlText=[[
					
<vlayout>
    <hlayout flexibleheight="1.8">
        <box flexiblewidth="1">
            <tmpro text="{expend}" fontsize="42"/>
        </box>
        <vlayout flexiblewidth="7">
            <box flexibleheight="1">
                <tmpro text="{combat_4}" fontsize="36" />
            </box>
            <box flexibleheight="2">
                <tmpro text="Gaze into the future:
Draw 2. Put one on top and one on bottom of your deck." fontsize="18" />
            </box>
        </vlayout>
    </hlayout>
    <divider/>
    <hlayout flexibleheight="1">
        
        <box flexiblewidth="7">
            <tmpro text="Beware the man with two mallards on his crest." fontsize="18" fontstyle="italic"/>
        </box>
    </hlayout>
</vlayout>
					]],
                    health = 5,
                    isGuard = true
                }
            )
        }
    )
end


function mythic_mercs_ee_parsons_carddef()
    return createChampionDef(
        {
            id = "parsons_merc",
            name = "Parsons the Insider",
			types = {championType},
            acquireCost = 5,
            health = 5,
            isGuard = false,
            abilities = {
                createAbility(
                    {
                        id = "parsons_main",
                        trigger = uiTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = gainGoldEffect(2)
						.seq(pushTargetedEffect({
												  desc="Move a card from your discard to the top of your deck.",
												  min=0,
												  max=1,
												  validTargets= selectLoc(loc(currentPid, discardPloc)),
												  targetEffect= moveToBottomDeckTarget(false, 0),
												  tags = {}
												}))
						
                    }
                ),
				createAbility({
                id = "parsons_faction",
                effect = pushChoiceEffect({
                        choices = {
                            {
                                effect = addSlotToTarget(createFactionsSlot({ imperialFaction }, { leavesPlayExpiry })).apply(selectSource()),
                                layout = createLayout({
                                    name = "Parons the Insider",
                                    art = "art/T_Thief_Male_Alternate",
                                    frame = "frames/Imperial_Champion_CardFrame",
                                    xmlText = [[
                                        <vlayout  forceheight="true">
                                            <icon text="{imperial}" fontsize="80" />
                                        </vlayout>
                                    ]],
                                }),
                                tags = { addFactionTag }
                            },
                            {
                                effect = addSlotToTarget(createFactionsSlot({ wildFaction }, { leavesPlayExpiry })).apply(selectSource()),
                                layout = createLayout({
                                    name = "Parons the Insider",
                                    art = "art/T_Thief_Male_Alternate",
                                    frame = "frames/Wild_Champion_CardFrame",
                                    xmlText = [[
                                        <vlayout  forceheight="true">
                                            <icon text="{wild}" fontsize="80" />
                                        </vlayout>
                                    ]],
                                }),
                                tags = { addFactionTag }
                            },
                            {
                                effect = addSlotToTarget(createFactionsSlot({ guildFaction }, { leavesPlayExpiry })).apply(selectSource()),
                                layout = createLayout({
                                    name = "Parons the Insider",
                                    art = "art/T_Thief_Male_Alternate",
                                    frame = "frames/Guild_Champion_CardFrame",
                                    xmlText = [[
                                        <vlayout  forceheight="true">
                                            <icon text="{guild}" fontsize="80" />
                                        </vlayout>
                                    ]],
                                }),
                                tags = { addFactionTag }
                            },
                            {
                                effect = addSlotToTarget(createFactionsSlot({ necrosFaction }, { leavesPlayExpiry })).apply(selectSource()),
                                layout = createLayout({
                                    name = "Parons the Insider",
                                    art = "art/T_Thief_Male_Alternate",
                                    frame = "frames/Necros_Champion_CardFrame",
                                    xmlText = [[
                                        <vlayout  forceheight="true">
                                            <icon text="{necro}" fontsize="80" />
                                        </vlayout>
                                    ]],
                                }),
                                tags = { addFactionTag }
                            }
                        }
                    }
                ),
                cost = noCost,
                trigger = onPlayTrigger,
                promptType = showPrompt,
                tags = { gainGoldTag }
            })
				
            },
            layout = createLayout(
                {
                    name = "Parsons the Insider",
                    art = "art/T_Thief_Male_Alternate",
                    frame = "frames/Treasure_CardFrame",
					cost = 5,
                    xmlText=[[
					<vlayout>
    <hlayout flexibleheight="2">
            <tmpro text="Choose a faction as you play this card. It has the chosen faction until it leaves play." fontsize="14" fontstyle="italic" flexiblewidth="4" />
    </hlayout>     
  <hlayout flexibleheight="3">
            <tmpro text="{expend}" fontsize="50" flexiblewidth="2"/>
            <tmpro text="{gold_2}
You may put a card from your discard pile onto the bottom of your deck" fontsize="20
" flexiblewidth="12" />
    </hlayout>


</vlayout>
					]],
                    health = 5,
                    isGuard = false
                }
            )
        }
    )
end

function mythic_mercs_ee_stigmalingpa_carddef()
    return createChampionDef(
        {
            id = "stigmalingpa",
            name = "Stigmalingpa",
			types = {championType},
            acquireCost = 4,
            health = 4,
            isGuard = true,
            abilities = {
                createAbility(
                    {
                        id = "stigmalingpa",
                        trigger = uiTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = gainHealthEffect(4)
						.seq(pushTargetedEffect({
								desc = "Transform a Gold in your discard pile into a Ruby.",
								validTargets = selectLoc(loc(currentPid, discardPloc)).where(isCardType(coinType)),
								min = 0,
								max = 1,
								targetEffect = transformTarget("ruby"),
									
								}))
						
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Stigmalingpa",
                    art = "art/epicart/reusable_knowledge",
                    frame = "frames/Treasure_CardFrame",
					cost = 4,
                    xmlText=[[
					
<vlayout>
    <hlayout flexibleheight="1.8">
        <box flexiblewidth="1">
            <tmpro text="{expend}" fontsize="42"/>
        </box>
        <vlayout flexiblewidth="7">
            <box flexibleheight="1">
                <tmpro text="{health_4}" fontsize="36" />
            </box>
            <box flexibleheight="2">
                <tmpro text="Transform a Gold in your discard pile into a Ruby." fontsize="20" />
            </box>
        </vlayout>
    </hlayout>
    <divider/>
    <hlayout flexibleheight="1">
        
        <box flexiblewidth="7">
            <tmpro text="I've been saying for a while now, 'It needs another Ruby.'" fontsize="18" fontstyle="italic"/>
        </box>
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

function mythic_mercs_ee_agent_th_carddef()
    return createChampionDef(
        {
            id = "agent_th",
            name = "Agent Teeth Hurting",
			types = {championType},
            acquireCost = 4,
            health = 5,
            isGuard = false,
            abilities = {
                createAbility(
                    {
                        id = "agent_th",
                        trigger = autoTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = randomEffect({
					valueItem(27, createCardEffect(cat_familiar_token_carddef(), currentInPlayLoc)),
					valueItem(27, createCardEffect(kit_cat_token_carddef(), currentInPlayLoc)),
					valueItem(27, createCardEffect(chunky_cat_token_carddef(), currentInPlayLoc)),
					valueItem(14, createCardEffect(big_bad_kitty_token_carddef(), currentInPlayLoc)),
					valueItem(5, createCardEffect(surprise_dragon_token_carddef(), currentInPlayLoc))
					
}).seq(noUndoEffect())
						
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Agent Teeth Hurting",
                    art = "art/epicart/psionic_assault",
                    frame = "frames/Treasure_CardFrame",
					cost = 4,
                    xmlText=[[
					
<vlayout>
    <hlayout flexibleheight="1.8">
        <box flexiblewidth="1">
            <tmpro text="{expend}" fontsize="42"/>
        </box>
        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="Put a random cat token into play." fontsize="24" />
            </box>
        </vlayout>
    </hlayout>
    <divider/>
    <hlayout flexibleheight="1">
        
        <box flexiblewidth="7">
            <tmpro text="The elves cursed him. Now he lives with eternal tooth ache." fontsize="20" fontstyle="italic"/>
        </box>
    </hlayout>
</vlayout>
					]],
                    health = 5,
                    isGuard = false
                }
            )
        }
    )
end


function cat_familiar_token_carddef()
--This is a token champion, that self-sacrifices when it leaves play
    return createChampionDef(
        {
            id = "familiar_cat_token",
            name = "Familiar Cat",
			types = {minionType, championType, nostealType, tokenType},
            acquireCost = 0,
            health = 2,
            isGuard = false,
            abilities = {
			--base ability
                createAbility(
                    {
                        id = "familiar_cat_main",
                        trigger = uiTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = pushChoiceEffect({
							choices = {
								{
                                effect = gainCombatEffect(1),
                                layout = createLayout({
									name = "Familiar Cat",
									art = "art/T_Cat_Familiar",
                                    frame = "frames/Treasure_CardFrame",
                                    xmlText = [[
                                        <vlayout  forceheight="true">
                                            <icon text="{combat_1}" fontsize="80" />
                                        </vlayout>
                                    ]],
                                }),
                            
                            },
							{
                                effect = gainGoldEffect(1),
                                layout = createLayout({
									name = "Familiar Cat",
									art = "art/T_Cat_Familiar",
                                    frame = "frames/Treasure_CardFrame",
                                    xmlText = [[
                                        <vlayout  forceheight="true">
                                            <icon text="{gold_1}" fontsize="80" />
                                        </vlayout>
                                    ]],
                                }),
                               
                            },
							{
                                effect = gainHealthEffect(1),
                                layout = createLayout({
									name = "Familiar Cat",
									art = "art/T_Cat_Familiar",
                                    frame = "frames/Treasure_CardFrame",
                                    xmlText = [[
                                        <vlayout  forceheight="true">
                                            <icon text="{health_1}" fontsize="80" />
                                        </vlayout>
                                    ]],
                                }),
                               
                            }
							
												}})
						
                    }
                )
            ,
			--self-sac ability
                createAbility(
                    {
                        id = "familiar_cat_sac",
                        trigger = onLeavePlayTrigger,
                        cost = sacrificeSelfCost,
                        activations = singleActivations,
                        effect = nullEffect()
					}	
                    
                )},
            layout = createLayout(
                {
                    name = "Familiar Cat",
                    art = "art/T_Cat_Familiar",
                    frame = "frames/Treasure_CardFrame",
                    xmlText=[[
					<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{expend}" fontsize="35"/>
        </box>
        <box flexiblewidth="7">
            <icon text="{combat_1}or{gold_1}or{health_1}" fontsize="40"/>
</box>
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


function kit_cat_token_carddef()
--This is a token champion, that self-sacrifices when it leaves play
    return createChampionDef(
        {
            id = "kit_cat_token",
            name = "Kit Cat",
			types = {minionType, championType, nostealType, tokenType},
            acquireCost = 0,
            health = 2,
            isGuard = false,
            abilities = {
			--base ability
                createAbility(
                    {
                        id = "kit_cat_main",
                        trigger = autoTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = hitOpponentEffect(2)
                    }
                )
            ,
			--self-sac ability
                createAbility(
                    {
                        id = "kit_cat_sac",
                        trigger = onLeavePlayTrigger,
                        cost = sacrificeSelfCost,
                        activations = singleActivations,
                        effect = nullEffect()
					}	
                    
                )},
            layout = createLayout(
                {
                    name = "Kit Cat",
                    art = "art/treasures/wizard_wizened_familiar",
                    frame = "frames/Treasure_CardFrame",
                    xmlText=[[
					<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{expend}" fontsize="40"/>
        </box>
        <box flexiblewidth="6">
            <icon text="Deal 2 damage to opponent." fontsize="30"/>
</box>
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

function chunky_cat_token_carddef()
--This is a token champion, that self-sacrifices when it leaves play
    return createChampionDef(
        {
            id = "chunky_cat_token",
            name = "Kit Cat Chunky",
			types = {minionType, championType, nostealType, tokenType},
            acquireCost = 0,
            health = 2,
            isGuard = true,
            abilities = {
			--base ability
                createAbility(
                    {
                        id = "chunky_cat_main",
                        trigger = uiTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = drawCardsEffect(1)
						
                    }
                )
            ,
			--self-sac ability
                createAbility(
                    {
                        id = "chunky_cat_sac",
                        trigger = onLeavePlayTrigger,
                        cost = sacrificeSelfCost,
                        activations = singleActivations,
                        effect = nullEffect()
					}	
                    
                )},
            layout = createLayout(
                {
                    name = "Kit Cat Chunky",
                    art = "art/treasures/wizard_content_familiar",
                    frame = "frames/Treasure_CardFrame",
                    xmlText=[[
					<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{expend}" fontsize="35"/>
        </box>
        <box flexiblewidth="7">
            <icon text="Draw 1" fontsize="40"/>
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

function big_bad_kitty_token_carddef()
--This is a token champion, that self-sacrifices when it leaves play
    return createChampionDef(
        {
            id = "big_bad_kitty_token",
            name = "Big Bad Kitty",
			types = {minionType, championType, nostealType, tokenType},
            acquireCost = 0,
            health = 3,
            isGuard = true,
            abilities = {
			--base ability
                createAbility(
                    {
                        id = "big_bad_kitty_main",
                        trigger = autoTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = gainCombatEffect(3)
						
                    }
                )
            ,
			--self-sac ability
                createAbility(
                    {
                        id = "big_bad_kitty_sac",
                        trigger = onLeavePlayTrigger,
                        cost = sacrificeSelfCost,
                        activations = singleActivations,
                        effect = nullEffect()
					}	
                    
                )},
            layout = createLayout(
                {
                    name = "Big Bad Kitty",
                    art = "art/T_Strength_of_the_wolf",
                    frame = "frames/Treasure_CardFrame",
                    xmlText=[[
					<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{expend}" fontsize="40"/>
        </box>
        <box flexiblewidth="6">
            <icon text="{combat_3}" fontsize="60"/>
</box>
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

function surprise_dragon_token_carddef()
--This is a token champion, that self-sacrifices when it leaves play
    return createChampionDef(
        {
            id = "surprise_dragon_token",
            name = "Surprise Dragon",
			types = {minionType, championType, nostealType, tokenType},
            acquireCost = 0,
            health = 5,
            isGuard = true,
            abilities = {
			--base ability
                createAbility(
                    {
                        id = "surprise_dragon_main",
                        trigger = autoTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = damageTarget(2).apply(selectLoc(loc(oppPid, inPlayPloc)))
						
                    }
                )
            ,
			--self-sac ability
                createAbility(
                    {
                        id = "surprise_dragon_sac",
                        trigger = onLeavePlayTrigger,
                        cost = sacrificeSelfCost,
                        activations = singleActivations,
                        effect = nullEffect()
					}	
                    
                )},
            layout = createLayout(
                {
                    name = "Surprise Dragon",
                    art = "art/epicart/dragonling",
                    frame = "frames/Treasure_CardFrame",
                    xmlText=[[
					<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{expend}" fontsize="42"/>
        </box>
        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="Deal 2 damage to each opposing champion." fontsize="22" />
            </box>
        </vlayout>
    </hlayout>
    <divider/>
    <hlayout flexibleheight="1">
        
        <box flexiblewidth="7">
            <tmpro text="Surprise!
Cats aren't the only critters he keeps around the house." fontsize="18" fontstyle="italic"/>
        </box>
    </hlayout>
</vlayout>
					]],
                    health = 5,
                    isGuard = true
                }
            )
        }
    )
end

-- Auxiliary effects
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

function setupGame(g)
    registerCards(
        g,
        {
	choose_lich_carddef(),
			lich_corruption_carddef(),
			lich_soul_diamond_carddef(),
			lich_minor_summoning_carddef(),
			lich_major_summoning_carddef(),
			lich_frozen_touch_carddef(),
			lich_soul_crush_carddef(),
			lich_abomination_minion_carddef(),
			lich_banshee_minion_carddef(),
			lich_ghoul_minion_carddef(),
			lich_revenant_minion_carddef(),
			lich_skeleton_horde_minion_carddef(),
			lich_wall_of_bones_minion_carddef(),
			lich_wall_of_fire_minion_carddef(),
			lich_zombie_minion_carddef(),
			lich_SJ_DI_carddef(),
			lich_SJ_HoE_carddef(),
			lich_SJ_IW_carddef(),
			lich_SJ_M_carddef(),
			lich_SJ_UR_carddef(),
			lich_SJ_V_carddef(),
	choose_demonologist_carddef(),
			demonologist_shadow_gem_carddef(),
			demonologist_shadow_feeder_carddef(),
			demonologist_void_guard_carddef(),
			demonologist_lesser_devourer_carddef(),
			demonologist_summon_demon_master_carddef(),
			demonologist_demonic_leech_carddef(),
			demonologist_succubus_carddef(),
			demonologist_fel_hound_carddef(),
			demonologist_incubus_carddef(),
			demonologist_keeper_of_the_void_carddef(),
			demonologist_demon_master_carddef(),
	choose_apothecary_carddef(),
			apothecary_apprentice_potion_maker_carddef(),
			apothecary_red_potion_carddef(),
			apothecary_green_potion_carddef(),
			apothecary_yellow_potion_carddef(),
			apothecary_mezzaluna_carddef(),
	choose_cryomancer_carddef(),
			cryomancer_ice_burst_carddef(),
			cryomancer_ice_shield_carddef(),
			cryomancer_ice_gem_carddef(),
			cryomancer_freeze_carddef(),
			cryomancer_frostbite_carddef(),
			cryomancer_permafrost_carddef(),
			cryomancer_freezing_fog_carddef(),
	choose_pyromancer_carddef(),
			pyromancer_sear_carddef(),
			pyromancer_scorch_carddef(),
			pyromancer_fire_shard_carddef(),
			pyromancer_combust_carddef(),
			pyromancer_1p_fuel_1carddef(),
			pyromancer_2p_fuel_1carddef(),
	choose_terramancer_carddef(),
			terramancer_earth_gem_carddef(),
			terramancer_hurl_boulder_carddef(),
			terramancer_tremor_carddef(),
			terramancer_clay_golem1_carddef(),
			terramancer_clay_golem2_carddef(),
			terramancer_move_earth1_carddef(),
			terramancer_move_earth2_carddef(),
			terramancer_swallowed_by_the_earth_def(),
	choose_thandarlorian_carddef(),
			thandarlorian_coordinated_attack_carddef(),
			thandarlorian_combat_shield_carddef(),
			thandarlorian_hand_ballista_carddef(),
			thandarlorian_bounty_hunters_stone_of_seeking_carddef(),
	choose_paladin_carddef(),
	        paladin_warhammer_carddef(),
            paladin_crusader_carddef(),
            paladin_prayer_carddef(),
            paladin_sacred_oath_carddef(),
	choose_witch_carddef(),
			witch_flash_freeze_carddef(),
			witch_cauldron_carddef(),
			siphon_life_def(),
			piercing_screech_def(),
	choose_shaman_carddef(),		
			flame_burst_carddef(),
			call_lightning_carddef(),
			gift_of_the_elements_carddef(),
			natures_blessing_carddef(),
	choose_king_midas_carddef(),		
			midas_kings_adviser_carddef(),
			greed_is_good_skilldef(),
			golden_touch_abilitydef(),
			midas_liquid_gold_carddef(),
			midas_gold_carddef(),
	choose_brewmaster_carddef(),		
			brewmaster_mead_carddef(),
			brewmaster_get_out_of_my_bar_carddef(),
			brewmaster_tap_a_keg_carddef(),
			brewmaster_regular_regulars_carddef(),
			brewmaster_irregular_regulars_carddef(),
			brewmaster_serve_the_strong_stuff_carddef(),
			brewmaster_zaboozer_carddef(),
			brewmaster_spilled_drink_carddef(),
	choose_S_and_R_carddef(),		
			hero_dash_helper_carddef(),
			situational_card_carddef(),
			bird_dog_def(),
			patron_shoutout_def(),
			wwyd_carddef(),
			nostra_dbl_damus_carddef(),
			blank_to_my_blank_carddef(),
			congrats_youre_a_nerd_carddef(),

	--Easter egg cards
			--[[mythic_mercs_ee_scrapforks_carddef(),
			mythic_mercs_ee_dblducks_carddef(),
			mythic_mercs_ee_stigmalingpa_carddef(),
			mythic_mercs_ee_agent_th_carddef(),
			cat_familiar_token_carddef(),
			kit_cat_token_carddef(),
			chunky_cat_token_carddef(),
			big_bad_kitty_token_carddef(),
			surprise_dragon_token_carddef(),]]
			mythic_mercs_ee_parsons_carddef(),
			ee_demon_hunter_carddef()
        }
    )

    standardSetup(
        g,
        {
            description = "Multi-class script by Aarkenell and Userkaffe. Classes by Aarkenell, Userkaffe, AgentC13, Filtrophobe, Zabuza & WardenSlayer. Updated 31.10.2024.",
             playerOrder = { plid1, plid2 },
        ai = ai.CreateKillSwitchAi(createAggressiveAI(),  createHardAi2()),
        timeoutAi = createTimeoutAi(),
        opponents = { { plid1, plid2 } },
		centerRow = { --[["demon_hunter"]] },
		tradeDeckExceptions = {
            -- here we set which cards populate market deck
           --[[ { qty=1, cardId="scrapforks" },
			{ qty=1, cardId="dblducks" },
			{ qty=1, cardId="stigmalingpa" },
			{ qty=1, cardId="agent_th" },]]
			{ qty=1, cardId="parsons_merc" },
			{ qty=1, cardId="demon_hunter" }
			
        },
        players = {
            {
                id = plid1,
                startDraw = 0,
                init = {
                    fromEnv = plid1
                },
                cards = {
                    buffs = {
						drawCardsCountAtTurnEndDef(3),
						goFirstEffect(),
                        discardCardsAtTurnStartDef(),
						chooseStart(),
						fatigueCount(42, 1, "FatigueP2")
                    }
                }
            },
            {
                id = plid2,
                startDraw = 0,
				init = {
                    fromEnv = plid2
                },
                cards = {
                    buffs = {
                        drawCardsCountAtTurnEndDef(5),
                        discardCardsAtTurnStartDef(),
						chooseStart(),
						fatigueCount(42, 1, "FatigueP2")
                    }
                }
            }            
        }
    })
end



function endGame(g)
end


function setupMeta(meta)
    meta.name = "tester 2"
    meta.minLevel = 1
    meta.maxLevel = 5
    meta.introbackground = ""
    meta.introheader = ""
    meta.introdescription = ""
    meta.path = "C:/Users/aaron/OneDrive/Documents/Aaron/Hero Realms/Lua/tester 2.lua"
     meta.features = {
}

end