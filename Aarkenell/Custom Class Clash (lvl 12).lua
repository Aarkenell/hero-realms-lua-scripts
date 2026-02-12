require "herorealms"
require "decks"
require "stdlib"
require "stdcards"
require "hardai"
require "mediumai"
require "easyai"

--[[ Updated 25.09.2024 by Aarkenell
Now Ancestry compatible - also accounts for Fighter Pauldron first turn buff -- still needs Barbarian armour reheal
Quickstart (cards move direct to sacrificePloc)
Succubus self-sac fixed
Demonic Leech rework - now explodes once at 6 health]]

--[[
Updates19.04.2025 - art and cardframe decapitalisation post WWG patch
]]

-- Game start --
local function chooseStart()
    return cardChoiceSelectorEffect({
        id = "SoG_Choice",
        name = "First choice",
        trigger = startOfTurnTrigger,

        upperTitle  = "Welcome! How would you like to proceed?",
        lowerTitle  = "",
-- 1.1 choice
        effectFirst= pushChoiceEffectWithTitle(
                                {
								
                                    choices = {  
								-- 1.1a choice - choose custom						
										{
                                           effect = moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc)).union(selectLoc(loc(currentPid, deckPloc)).union(selectLoc(loc(currentPid, skillsPloc)).union(selectLoc(loc(currentPid, reservePloc))
			.union(selectLoc(loc(currentPid, buffsPloc)).where(isCardType(ogreType).Or(isCardType(orcType)).Or(isCardType(elfType).Or(isCardType(dwarfType).Or(isCardType(smallfolkType)).Or(isCardType(halfDemonType)).Or(isCardType(magicArmorType)).Or(isCardName("smallfolk_hide_buff"))))))))))
			.seq(gainCombatEffect(-1))
			.seq(setPlayerNameEffect("Unknown", currentPid))
			.seq(setPlayerAvatarEffect("assassin", currentPid))
			.seq(gainMaxHealthEffect(currentPid, const(50).add(getPlayerMaxHealth(currentPid).negate())))
			.seq(gainHealthEffect(50))
			--[[.seq(createCardEffect(choose_S_and_R_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(choose_paladin_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(choose_witch_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(choose_shaman_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(choose_king_midas_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(choose_brewmaster_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(choose_thandarlorian_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(choose_terramancer_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(choose_apothecary_carddef(), loc(currentPid, asidePloc)))]]
			.seq(createCardEffect(choose_demonologist_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(choose_pyromancer_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(choose_cryomancer_carddef(), loc(currentPid, asidePloc)))
						.seq(moveTarget(handPloc).apply(selectLoc(loc(currentPid, asidePloc))))
			.seq(waitForClickEffect("Please play the card corresponding to the class you wish to play.", ""))
			.seq(waitForClickEffect("Please note: Cryomancer abilities are still in development.", ""))
			.seq(waitForClickEffect("If both players choose Cryomancer AND the same abilities and activate them at the same time the game will crash.", "")),
        
            layout = createLayout({
            name = "Pick a custom class",
            art = "art/t_storm_siregar",
            xmlText=[[<vlayout>
<hlayout flexiblewidth="1">
<text text="Choose 1 of 3
level 12 Custom Characters to play." fontsize="26"/>
</hlayout>
</vlayout>
			
			]]
			}),
                                            tags = {}
                                        },
								-- 1.1b choice - choose standard
										{
                                           effect = pushChoiceEffectWithTitle(
                                {
                                    choices = {                                
										{
                                           effect = moveTarget(tradeDeckLoc).apply(selectLoc(centerRowLoc))
													.seq(shuffleTradeDeckEffect())
													.seq(refillMarketEffect(const(0)).seq(refillMarketEffect(const(1))).seq(refillMarketEffect(const(2))).seq(refillMarketEffect(const(3))).seq(refillMarketEffect(const(4))))
													.seq(addEffect(endTurnEffect())),
                                            condition = getHeroLevel(currentPid).lte(13).And(getHeroLevel(currentPid).gte(10)),
											layout = createLayout(
                {
                    name = "Yes",
                    art = "art/treasures/t_cleric_elixir_green",
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
					upperTitle = "Confirm your choice. Do you want to use your standard Hero?",
					lowerTitle = ""
					}),
                                            layout = createLayout({
            name = "Selected class",
            art = "art/t_all_heroes",
            xmlText=[[
			<vlayout>
<hlayout flexiblewidth="1">
<text text="Play as the character you selected when setting up the game." fontsize="26"/>
</hlayout>
</vlayout>
			]] }),
                                            tags = {}
                                        }
                                    },
					
        upperTitle  = "Make your choice.",
        lowerTitle  = "Do you want to play as a custom class, or use the character you picked when starting the game?",

					}),
-- 1.2 choice		
		effectSecond = pushChoiceEffectWithTitle(
                                {
								
                                    choices = {  
								-- 1.2a choice - Updates to this mod					
										{
                                           effect = nullEffect(),
        
            layout = createLayout({
            name = "Updates to this mod",
            art = "art/t_fighter_sharpening_stone",
            xmlText=[[<vlayout>
<hlayout flexiblewidth="1">
<text text="
06.03.25 - Cryomancer added


" fontsize="16"/>
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
            art = "art/treasures/t_spyglass",
            xmlText=[[
			<vlayout>
<hlayout flexiblewidth="1">
<text text="New mods by community members:

&lt;size=100%&gt;Dual Class &lt;size=70%&gt;- by Aarkenell
&lt;size=100%&gt;Splintered Thandar &lt;size=70%&gt;- by Aarkenell
&lt;size=100%&gt;Industrialisation &lt;size=70%&gt;- by Userkaffe
&lt;size=100%&gt;Mythic Mercenaries &lt;size=70%&gt;- by Aarkenell
&lt;size=100%&gt;Sudden Death &lt;size=70%&gt;- by WardenSlayer

&lt;size=90%&gt;Look out for these games in the custom lobby, or join the RealmsRising Discord to request custom challenges." fontsize="14"/>
</hlayout>
</vlayout>
			]] }),
                                            tags = {}
                                        },
										  
								-- 1.2c choice - Community news
										{
                                           effect = storyTellEffectWithPortrait("ogre_fighter_male_02", "Hi! I’m Rob d’Ogrety, CEO of ‘Why’s Wizard Games?’")
				 .seq(leftStoryTellEffectWithPortrait("dwarf_fighter_male_02", "And I’m Dwarfin Kastle – creator of the award-winning deckbuilding game about growing trees in space – Star Elms."))
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
            art = "art/t_borg_ogre_mercenary",
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

-- 1.1 layout
        layoutFirst = createLayout({
            name = "To Battle!",
            art = "art/t_unify_apsara",
            xmlText=[[<vlayout>
<hlayout flexiblewidth="1">
<text text="Choose your class and start the game." fontsize="26"/>
</hlayout>
</vlayout>
			
			]]
			}),

-- 1.2 layout
        layoutSecond = createLayout({
            name = "Updates & Info",
            art = "art/treasures/t_magic_scroll_souveraine",
            xmlText=[[
			<vlayout>
<hlayout flexiblewidth="1">
<text text="Learn about:
Updates to this mod
Other mods to try
Community news"
fontsize="26"/>
</hlayout>
</vlayout>
			]] }) ,

        turn = 1
    })
end


-- Custom Class Selection cards
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

--Confirm--			
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
                    art = "art/treasures/t_cleric_elixir_green",
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
					upperTitle = "Confirm your choice. Do you want to use the Demonologist?",
					lowerTitle = ""
					}))

--Level 12 card choice--
.seq(pushChoiceEffectWithTitle({
                                    choices = {
                                        {
                                            effect = gainMaxHealthEffect(currentPid, const(55).add(getPlayerMaxHealth(currentPid).negate()))
												.seq(gainHealthEffect(55)),
                                            layout = createLayout(
                {
                    name = "Additional Health",
                    art = "avatars/ruinos_zealot",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
<vlayout>
    <box flexibleheight="9">
        <tmpro text="{health_+5}" fontsize="70"/>
    </box>
 </vlayout>
]]
				}
            )
            ,
                                            tags = {}
                                        },
                                        
										{
                                            effect = createCardEffect(demonologist_summon_demon_ability_carddef(), currentSkillsLoc),
                                            layout = createLayout(
                {
                    name = "Summon Demon Minion",
                    art = "icons/the_summoning",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
    <hlayout flexibleheight="2">
        <box flexiblewidth="1">
            <tmpro text="{scrap}" fontsize="35"/>
        </box>
        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="Randomly summon 1 of 3 demon tokens into play." fontsize="20" />
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
            ),
                                            tags = {}
                                        },
										
                                    },
					upperTitle = "Level 12: Choose an upgrade.",
					lowerTitle = "Gain max health, or gain a level 1 Ability."
					}))

--Level 11 card choice--
.seq(pushChoiceEffectWithTitle({
                                    choices = {
                                        {
                                            effect = sacrificeTarget().apply(selectLoc(loc(currentPid, deckPloc)).where(isCardName("demonologist_shadow_gem")))
				.seq(createCardEffect(demonologist_flawless_shadow_gem_carddef(), currentDeckLoc)),
                                            layout = createLayout(
                {
                    name = "Flawless Shadow Gem",
                    art = "art/treasures/thief_brillant_ruby",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
<vlayout>
    <box flexibleheight="2">
        <tmpro text="{gold_2}" fontsize="42"/>
    </box>
    <box flexibleheight="3">
        <tmpro text="{health_-1} Give one minion +2{shield} until your next turn." fontsize="24" />
    </box>
</vlayout>
]]
				}
            )
            ,
                                            tags = {}
                                        },
                                        
										{
                                            effect = createCardEffect(demonologist_butcherclaw_carddef(), currentDeckLoc),
                                            layout = createLayout(
                {
                    name = "Butcherclaw",
                    art = "icons/slaughterclaw",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    health = 2,
                    isGuard = false,
					xmlText=[[
					<vlayout>
    <hlayout flexibleheight="0.2">
            <tmpro text="{expend}" fontsize="40" flexiblewidth="2"/>
            <icon text="{combat_2}" fontsize="40" flexiblewidth="10" />
    </hlayout>
<divider/>
    <hlayout flexibleheight="7">
            <tmpro text="Once per turn, you may sacrifice a champion in your discard pile to sprout a spike equal to its cost." fontsize="20" flexiblewidth="10" />
    </hlayout> 
</vlayout>
					]]
				}
            ),
					
                                            tags = {}
                                        },
										
                                    },
					upperTitle = "Level 11: Choose a card to add to your deck.",
					lowerTitle = "Replace Shadow Gem or add Butcherclaw to your deck."
					}))
			
--Level 10 Ability choice--
			.seq(pushChoiceEffectWithTitle(
                                {
                                    choices = {
                                        {
                                            effect = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("demonologist_summon_incubus_ability").Or(isCardName("demonologist_summon_keeper_of_the_void_ability"))))
				.seq(createCardEffect(demonologist_summon_karamight_carddef(), currentSkillsLoc)),
                                            layout = createLayout(
                {
                    name = "Summon Karamight",
					art = "art/epicart/raxxa_s_enforcer",
					frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{scrap}" fontsize="40"/>
        </box>
        <box flexiblewidth="7">
            <tmpro text="Put Karamight
into play.
&lt;size=70%&gt;
(It has {combat_6} and 5{guard} and
'Once per turn you may stun 1 demon minion you own to gain +2{guard} until next turn'.)" fontsize="24" flexiblewidth="10" />
</box>
</hlayout>
</vlayout>
					]]
                }
            ),
                                            tags = {}
                                        },
                                        
										{
                                            effect = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("demonologist_summon_incubus_ability").Or(isCardName("demonologist_summon_keeper_of_the_void_ability"))))
				.seq(createCardEffect(demonologist_summon_laughing_shade_carddef(), currentSkillsLoc)),
                                            layout = createLayout(
                {
                    name = "Summon Laughing Shade",
					art = "art/epicart/dark_prince",
					frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{scrap}" fontsize="40"/>
        </box>
        <box flexiblewidth="7">
            <tmpro text="Put Laughing Shade
into play.
&lt;size=70%&gt;
(It has {combat_4} and 5{shield} and 'Sacrifice a card in the market. If it is an Action, +{combat_2} this turn. If it is a Champion, +{health_3}'.)" fontsize="24" flexiblewidth="10" />
</box>
</hlayout>
</vlayout>
					]]
                }
            ),
                                            tags = {}
                                        },
										
										{
                                            effect = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("demonologist_summon_incubus_ability").Or(isCardName("demonologist_summon_keeper_of_the_void_ability"))))
				.seq(createCardEffect(demonologist_summon_ingaitch_carddef(), currentSkillsLoc)),
                                            layout = createLayout(
                {
                    name = "Summon Ingaitch",
					art = "art/epicart/mythic_monster",
					frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{scrap}" fontsize="40"/>
        </box>
        <box flexiblewidth="7">
            <tmpro text="Put Ingaitch the Ravenous into play.
&lt;size=70%&gt;
(It has {combat_7} and 7{shield}. When expended choose: -1{shield} or {health_-3}.)

&lt;size=60%&gt;Usable from your 3rd turn." fontsize="24" flexiblewidth="10" />
</box>
</hlayout>
</vlayout>
					]]
                }
            ),
                                            tags = {}
                                        }
										
                                    },
					upperTitle = "Level 10: Choose which ability you would like to upgrade to.",
					lowerTitle = "Click your choice to proceed."
					}))
	
--Level 9 Armour choice--
.seq(pushChoiceEffectWithTitle({
                                    choices = {
                                        {
                                            effect = createCardEffect(demonologist_demonic_amulet_carddef(), currentSkillsLoc),
                                            layout = createLayout(
                {
                    name = "Demonic Amulet",
                    art = "art/t_wizard_silverskull_amulet",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{requiresHealth_35}" fontsize="72"/>
        </box>
        <box flexiblewidth="5">
            <tmpro text="If you have a demon minion token in play gain {health_2}." fontsize="28" />
        </box>
    </hlayout>
</vlayout>
					]]
				}
            ),
                                            tags = {}
                                        },
                                        
										{
                                            effect = createCardEffect(demonologist_summoner_s_robes_carddef(), currentSkillsLoc),
                                            layout = createLayout(
                {
                    name = "Summoner's Robes",
                    art = "art/t_wizard_runic_robes",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{requiresHealth_35}" fontsize="72"/>
        </box>
        <box flexiblewidth="5">
            <tmpro text="{health_-2}
&lt;size=70%&gt;Your skill costs 1{gold} less this turn." fontsize="40" />
        </box>
    </hlayout>
</vlayout>
					]]
				}
            ),
                                            tags = {}
                                        },
										
                                    },
					upperTitle = "Level 9: Choose your armour.",
					lowerTitle = ""
					}))


--Level 8 Ability choice--
			.seq(pushChoiceEffectWithTitle(
                                {
                                    choices = {
                                        {
                                            effect = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("demonologist_summon_demon_master_ability")))
				.seq(createCardEffect(demonologist_summon_keeper_of_the_void_carddef(), currentSkillsLoc)),
                                            layout = createLayout(
                {
                    name = "Summon Keeper of the Void",
					art = "art/epicart/spawning_demon",
					frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{scrap}" fontsize="40"/>
        </box>
        <box flexiblewidth="7">
            <tmpro text="Put the Keeper of the Void into play.
&lt;size=70%&gt;
(It has {combat_2} and 4{guard} and gains +1{guard} for every 2 other demon minions in play (round down) until the start of next turn.)" fontsize="24" flexiblewidth="10" />
</box>
</hlayout>
</vlayout>
					]]
                }
            ),
                                            tags = {}
                                        },
                                        
										{
                                            effect = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("demonologist_summon_demon_master_ability")))
				.seq(createCardEffect(demonologist_summon_incubus_carddef(), currentSkillsLoc)),
                                            layout = createLayout(
                {
					name = "Incubus",
                    art = "art/epicart/guilt_demon",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="2">
            <tmpro text="{scrap}" fontsize="50"/>
        </box>
        <box flexiblewidth="7">
            <tmpro text="Put the Incubus into play.
&lt;size=70%&gt;
(It has {combat_3} and 4{shield} and gains +{combat_1} permanently at the start of each turn.)" fontsize="24" flexiblewidth="10" />
</box>
</hlayout>
</vlayout>
					]]
                }
            ),
                                            tags = {}
                                        },
										
                                    },
					upperTitle = "Level 8: Choose which ability you would like to upgrade to.",
					lowerTitle = "Click your choice to proceed."
					}))
	
--Level 7 card choice--
.seq(pushChoiceEffectWithTitle({
                                    choices = {
                                        {
                                            effect = createCardEffect(demonologist_grimoire_carddef(), currentDeckLoc),
                                            layout = createLayout(
                {
                    name = "Grimoire",
                    art = "art/t_evangelize",
                    frame = "frames/wizard_cardframe",
                    xmlText=[[
<vlayout>
    <hlayout flexibleheight="2">
<vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="
Draw a card.

Gain {health_1} for each demon minion already in play." fontsize="24" />
            </box>
        </vlayout>
    </hlayout>

</vlayout>
]]
				}
            )
            ,
                                            tags = {}
                                        },
                                        
										{
                                            effect = createCardEffect(demonologist_scroll_of_summoning_carddef(), currentDeckLoc),
                                            layout = createLayout(
                {
                    name = "Scroll of Summoning",
                    art = "art/treasures/t_magic_scroll_souveraine",
                    frame = "frames/wizard_cardframe",
                    xmlText=[[
					<vlayout>
    <hlayout flexibleheight="2">
<vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="Choose 1 of the 3 basic (1{shield}) demon minion tokens to put into play.
Draw 1." fontsize="24" />
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
					upperTitle = "Level 7: Choose a card to add to your deck.",
					lowerTitle = ""
					}))
			

--Level 6 skill choice--
			.seq(pushChoiceEffectWithTitle(
                                {
                                    choices = {
                                        {
                                            effect = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("demonologist_dark_summon_skill").Or(isCardName("demonologist_fel_summon_skill")).Or(isCardName("demonologist_summon_demon_skill"))))
				.seq(createCardEffect(demonologist_infernal_summon_carddef(), currentSkillsLoc)),
                                            layout = createLayout(
                {
                    name = "Infernal Summon",
                    art = "art/epicart/abyss_summoner",
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
            <tmpro text="Summoned demons have
2{shield} and +{combat_1}." fontsize="20" />
        </box>
    </hlayout>
</vlayout>
					]]
                }
            ),
                                            tags = {}
                                        },
                                        
										{
                                            effect = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("demonologist_dark_summon_skill").Or(isCardName("demonologist_fel_summon_skill")).Or(isCardName("demonologist_summon_demon_skill"))))
				.seq(createCardEffect(demonologist_malevolent_summon_carddef(), currentSkillsLoc)),
                                            layout = createLayout(
                {
                    name = "Malevolent Summon",
                    art = "art/epicart/rift_summoner",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
    <hlayout flexibleheight="2">
        <box flexiblewidth="1">
            <tmpro text="{expend_2}" fontsize="62"/>
        </box>
        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="&lt;size=130%&gt;{health_-1} &lt;size=100%&gt;Draw 1.
Randomly summon 1 of 3 demon tokens into play." fontsize="20" />
            </box>
        </vlayout>
    </hlayout>
    <divider/>
    <hlayout flexibleheight="1">
        <box flexiblewidth="7">
            <tmpro text="Summoned demons have 2{shield}." fontsize="20" />
        </box>
    </hlayout>
</vlayout>
					]]
                }
            ),
                                            tags = {}
                                        },
										
										{
                                            effect = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("demonologist_dark_summon_skill").Or(isCardName("demonologist_fel_summon_skill")).Or(isCardName("demonologist_summon_demon_skill"))))
				.seq(createCardEffect(demonologist_sinister_summon_carddef(), currentSkillsLoc)),
                                            layout = createLayout(
                {
                    name = "Sinister Summon",
                    art = "art/epicart/infernal_gatekeeper",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
    <hlayout flexibleheight="2">
        <box flexiblewidth="1">
            <tmpro text="{expend_2}" fontsize="62"/>
        </box>
        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="&lt;size=130%&gt;{health_1} &lt;size=100%&gt;Draw 1.
Randomly summon 1 of 3 demon tokens into play." fontsize="20" />
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
            ),
                                            tags = {}
                                        },
										
                                    },
					upperTitle = "Level 6: Choose which skill you would like to upgrade to.",
					lowerTitle = "Click your choice to proceed."
					}))
	
--Level 5 card choice--
.seq(pushChoiceEffectWithTitle({
                                    choices = {
                                        {
                                            effect = sacrificeTarget().apply(selectLoc(loc(currentPid, deckPloc)).where(isCardName("demonologist_lesser_devourer")))
.seq(createCardEffect(demonologist_devourer_carddef(), currentDeckLoc)),
                                            layout = createLayout(
                {
                    name = "Devourer",
                    art = "art/epicart/thrasher_demon",
                    frame = "frames/wizard_cardframe",
                    xmlText = [[
<vlayout>
    <hlayout flexibleheight="3">
            <tmpro text="{expend}" fontsize="40" flexiblewidth="2"/>
            <tmpro text="{health_-1} {combat_1}
Devourer gains +1{shield} until it leaves play." fontsize="21" flexiblewidth="10" />
    </hlayout>
    <divider/>
    <hlayout flexibleheight="2">
            <tmpro text="If Devourer leaves play gain {health_2} at the start of your turn." fontsize="21" flexiblewidth="10" />
    </hlayout> 
</vlayout>
					]],
                    health = 2,
                    isGuard = true
                })
            ,
                                            tags = {}
                                        },
                                        
										{
                                            effect = sacrificeTarget().apply(selectLoc(loc(currentPid, deckPloc)).where(isCardName("demonologist_void_guard")))
.seq(createCardEffect(demonologist_void_sentinel_carddef(), currentDeckLoc)),
                                            layout = createLayout(
                {
                    name = "Void Sentinel",
                    art = "art/epicart/dark_knight",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
    <hlayout flexibleheight="1">
            <tmpro text="{expend}" fontsize="40" flexiblewidth="2"/>
            <text text="{combat_1}"
fontsize="40" flexiblewidth="10" />
    </hlayout>
    <divider/>
    <hlayout flexibleheight="3">
            <tmpro text="If you have 2 other demon minions in play, deal 3 damage to target opponent." fontsize="20" flexiblewidth="8" />
    </hlayout> 
</vlayout>
					]],
                    health = 2,
                    isGuard = true
                }
            ),
                                            tags = {}
                                        },
										
                                    },
					upperTitle = "Level 5: Choose which card you would like to upgrade to.",
					lowerTitle = "Replace Lesser Devourer or replace Void Guard."
					}))
			
--Level 4 skill choice--
			.seq(pushChoiceEffectWithTitle(
                                {
                                    choices = {
                                        {
                                            effect = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("demonologist_summon_demon_skill")))
				.seq(createCardEffect(demonologist_dark_summon_carddef(), currentSkillsLoc)),
                                            layout = createLayout(
                {
                    name = "Dark Summon",
                    art = "art/epicart/dark_leader",
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
            <tmpro text="Summoned demons have 2{shield}." fontsize="20" />
        </box>
    </hlayout>
</vlayout>
					]]
                }
            ),
                                            tags = {}
                                        },
                                        
										{
                                            effect = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("demonologist_summon_demon_skill")))
				.seq(createCardEffect(demonologist_fel_summon_carddef(), currentSkillsLoc)),
                                            layout = createLayout(
                {
					name = "Fel Summon",
                    art = "art/epicart/corpsemonger",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
    <hlayout flexibleheight="2">
        <box flexiblewidth="1">
            <tmpro text="{expend_2}" fontsize="62"/>
        </box>
        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="&lt;size=130%&gt;{health_-1} &lt;size=100%&gt;Draw 1.
Randomly summon 1 of 3 demon tokens into play." fontsize="20" />
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
            ),
                                            tags = {}
                                        },
										
                                    },
					upperTitle = "Level 4: Choose which skill you would like to upgrade to.",
					lowerTitle = "Click your choice to proceed."
					}))
	
            })
        },
        layout = createLayout({
            name = "Demonologist",
            art = "art/epicart/dirge_of_scara",
			frame = "frames/coop_campaign_cardframe",
            xmlText=[[
			<vlayout>
    <box flexibleheight="2">
        <tmpro text="Play as a level 12
Demonologist" fontsize="26"/>
    </box>
    <box flexibleheight="1">
        <tmpro text="
- Class by Aarkenell -" fontsize="22" fontstyle="italic"/>
    </box>

<box flexibleheight="1">
        <tmpro text="- Created 12.04.2024-" fontsize="14" fontstyle="italic"/>
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
                    art = "art/treasures/t_cleric_elixir_green",
                    frame = "frames/wizard_cardframe",
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
                    art = "art/treasures/t_cleric_elixir_blue_purple",
                    frame = "frames/wizard_cardframe",
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

--Level 12 card choice--
.seq(pushChoiceEffectWithTitle({
                                    choices = {
                                        {
                                            effect = gainMaxHealthEffect(currentPid, const(52).add(getPlayerMaxHealth(currentPid).negate()))
												.seq(gainHealthEffect(52)),
                                            layout = createLayout(
                {
                    name = "Additional Health",
                    art = "avatars/summoner",
                    frame = "frames/wizard_cardframe",
                    xmlText=[[
<vlayout>
    <box flexibleheight="9">
        <tmpro text="{health_+4}" fontsize="70"/>
    </box>
 </vlayout>
]]
				}
            )
            ,
                                            tags = {}
                                        },
                                        
										{
                                            effect = createCardEffect(pyromancer_play_with_fire_carddef(), currentSkillsLoc),
                                            layout = createLayout(
                {
                    name = "Play with fire",
                    art = "art/t_spreading_sparks",
                    frame = "frames/wizard_cardframe",
                    xmlText=[[
					<vlayout>
    <hlayout flexibleheight="2">
        <box flexiblewidth="1">
            <tmpro text="{scrap}" fontsize="60"/>
        </box>
        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="{combat_2}" fontsize="60" />
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
					upperTitle = "Level 12: Choose an upgrade.",
					lowerTitle = "Gain max health, or gain a level 1 Ability."
					}))

--Level 11 card choice--
.seq(pushChoiceEffectWithTitle({
                                    choices = {
                                        {
                                            effect = createCardEffect(pyromancer_patronage_carddef(), currentDeckLoc),
                                            layout = createLayout(
                {
                    name = "Patronage",
                    art = "art/treasures/thief_brillant_ruby",
                    frame = "frames/wizard_cardframe",
                    xmlText=[[
<vlayout>
    <box flexibleheight="9">
        <tmpro text="{gold_2}" fontsize="40"/>
    </box>
    <box flexibleheight="3">
        <tmpro text="" fontsize="24" />
    </box>
<divider/>
    <hlayout flexibleheight="14">
            <tmpro text="{scrap}" fontsize="40" flexiblewidth="1" />
            <tmpro text="Prepare your skill." fontsize="30" flexiblewidth="10" />
    </hlayout> </vlayout>
]]
				}
            )
            ,
                                            tags = {}
                                        },
                                        
										{
                                            effect = sacrificeTarget().apply(selectLoc(loc(currentPid, deckPloc)).where(isCardName("gold")).take(1))
											.seq(createCardEffect(pyromancer_volatile_chemicals_carddef(), currentDeckLoc)),
                                            layout = createLayout(
                {
                    name = "Volatile Chemicals",
                    art = "art/treasures/wizard_adept_s_components",
                    frame = "frames/wizard_cardframe",
                    xmlText=[[
					<vlayout>
<hlayout flexibleheight="1">
        <box flexiblewidth="7">
            <icon text="{gold_1} {combat_2}" fontsize="50"/>
</box>
</hlayout>
</vlayout>
					]]
				}
            ),
                                            tags = {}
                                        },
										
                                    },
					upperTitle = "Level 11: Choose an upgrade.",
					lowerTitle = "Add Patronage to your deck or replace a Gold with Volatile Chemicals."
					}))
			
--Level 10 Ability choice--
.seq(pushChoiceEffectWithTitle(
                                {
                                    choices = {
                                        {
                                            effect = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("conflagration_1p").Or(isCardName("conflagration_2p"))))
											.seq(ifElseEffect(getTurnsPlayed(oppPid).eq(1), resetCounterEffect("conflagration_1p"), resetCounterEffect("conflagration_2p")))
											.seq(ifElseEffect(getTurnsPlayed(oppPid).eq(1), createCardEffect(pyromancer_phoenix_fury_1p_carddef(), currentSkillsLoc), createCardEffect(pyromancer_phoenix_fury_2p_carddef(), currentSkillsLoc)))
                                            .seq(ifElseEffect(getTurnsPlayed(oppPid).eq(1), incrementCounterEffect("conflagration_1p", 9), incrementCounterEffect("conflagration_2p", 9))),
											layout = createLayout(
                {
                    name = "Phoenix Fury",
					art = "art/t_pillar_of_fire",
					frame = "frames/wizard_cardframe",
                    xmlText=[[
					<vlayout>
            <hlayout flexibleheight="2">
                <box flexiblewidth="0.2"/>
                <tmpro text="{scrap}" fontsize="40" flexiblewidth="1"/>
                <box flexiblewidth="0"/>
                <vlayout flexiblewidth="6">
                    <box flexibleheight="0.2"/>
                    <tmpro text="{combat}
&lt;size=65%&gt;Flip your skill to Afterburn.

&lt;size=50%&gt;{combat} gained starts at {combat_9}
and increases with each use of your skill." fontsize="32" flexibleheight="3"/>

                </vlayout>
            </hlayout>
        </vlayout>
					]]
                }
            ),
                                            tags = {}
                                        },
                                        
										{
                                            effect = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("conflagration_1p").Or(isCardName("conflagration_2p"))))
											.seq(ifElseEffect(getTurnsPlayed(oppPid).eq(1), resetCounterEffect("conflagration_1p"), resetCounterEffect("conflagration_2p")))
											.seq(ifElseEffect(getTurnsPlayed(oppPid).eq(1), createCardEffect(pyromancer_phoenix_flames_1p_carddef(), currentSkillsLoc), createCardEffect(pyromancer_phoenix_flames_2p_carddef(), currentSkillsLoc)))
                                            .seq(ifElseEffect(getTurnsPlayed(oppPid).eq(1), incrementCounterEffect("conflagration_1p", 7), incrementCounterEffect("conflagration_2p", 7))),
											
											layout = createLayout(
                {
                    name = "Phoenix Flames",
					art = "art/epicart/flames_of_furios",
					frame = "frames/wizard_cardframe",
                    xmlText=[[
					<vlayout>
            <hlayout flexibleheight="2">
                <box flexiblewidth="0.2"/>
                <tmpro text="{scrap}" fontsize="40" flexiblewidth="1"/>
                <box flexiblewidth="0"/>
                <vlayout flexiblewidth="6">
                    <box flexibleheight="0.2"/>
                    <tmpro text="{combat}{health_6}
&lt;size=65%&gt;Flip your skill to Afterburn.

&lt;size=50%&gt;{combat} gained starts at {combat_7}
and increases with each use of your skill." fontsize="32" flexibleheight="3"/>

                </vlayout>
            </hlayout>
        </vlayout>
					]]
                }
            ),
                                            tags = {}
                                        },
										
										{
                                            effect = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("conflagration_1p").Or(isCardName("conflagration_2p"))))
											.seq(ifElseEffect(getTurnsPlayed(oppPid).eq(1), resetCounterEffect("conflagration_1p"), resetCounterEffect("conflagration_2p")))
											.seq(ifElseEffect(getTurnsPlayed(oppPid).eq(1), createCardEffect(pyromancer_spirit_of_the_phoenix_1p_carddef(), currentSkillsLoc), createCardEffect(pyromancer_spirit_of_the_phoenix_2p_carddef(), currentSkillsLoc)))
                                            .seq(ifElseEffect(getTurnsPlayed(oppPid).eq(1), incrementCounterEffect("conflagration_1p", 5), incrementCounterEffect("conflagration_2p", 5))),
											
											layout = createLayout(
                {
                    name = "Spirit of the Phoenix",
					art = "art/t_darian_war_mage",
					frame = "frames/wizard_cardframe",
                    xmlText=[[
					<vlayout>
            <hlayout flexibleheight="2">
                <box flexiblewidth="0.2"/>
                <tmpro text="{scrap}" fontsize="40" flexiblewidth="1"/>
                <box flexiblewidth="0"/>
                <vlayout flexiblewidth="6">
                    <box flexibleheight="0.2"/>
                    <tmpro text="{combat}{health_11}
&lt;size=65%&gt;Flip your skill to Afterburn.

&lt;size=50%&gt;{combat} gained starts at {combat_5}
and increases with each use of your skill." fontsize="32" flexibleheight="3"/>

                </vlayout>
            </hlayout>
        </vlayout>
					]]
                }
            ),
                                            tags = {}
                                        }
										
                                    },
					upperTitle = "Level 10: Choose which ability you would like to upgrade to.",
					lowerTitle = "Click your choice to proceed."
					}))
	
--Level 9 Armour choice--
.seq(pushChoiceEffectWithTitle({
                                    choices = {
                                        {
                                            effect = createCardEffect(pyromancer_fire_gem_amulet_carddef(), currentSkillsLoc),
                                            layout = createLayout(
                {
                    name = "Fire Gem Amulet",
                    art = "art/t_fire_gem",
                    frame = "frames/wizard_cardframe",
                    xmlText=[[
					<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{requiresHealth_25}" fontsize="60"/>
        </box>
        <box flexiblewidth="5">
            <tmpro text="If you have a Fire Gem in play or in your discard pile put a Fire Bird token into play if there is none.
Otherwise give a Fire Bird +1{shield} until it leaves play." fontsize="19" />
        </box>
    </hlayout>
</vlayout>
					]]
				}
            ),
                                            tags = {}
                                        },
                                        
										{
                                            effect = ifElseEffect(getTurnsPlayed(oppPid).eq(1), createCardEffect(pyromancer1_flame_hood_carddef(), currentSkillsLoc), createCardEffect(pyromancer2_flame_hood_carddef(), currentSkillsLoc)),
                                            layout = createLayout(
                {
                    name = "Flame Hood",
                    art = "avatars/summoner",
                    frame = "frames/wizard_cardframe",
                    xmlText=[[
					<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{requiresHealth_25}" fontsize="60"/>
        </box>
        <box flexiblewidth="5">
            <tmpro text="Pay {gold_1}
Add {combat_2}
to your Ability.
&lt;size=80%&gt;
If you have used your Ability, gain {combat_2}." fontsize="24" />
        </box>
    </hlayout>
</vlayout>
					]]
				}
            ),
                                            tags = {}
                                        },
										
                                    },
					upperTitle = "Level 9: Choose your armour.",
					lowerTitle = ""
					}))

--Level 8 Ability  choice--
.seq(pushChoiceEffectWithTitle(
                                {
                                    choices = {
                                        {
                                            effect = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("conflagration_1p").Or(isCardName("conflagration_2p"))))											
											.seq(ifElseEffect(getTurnsPlayed(oppPid).eq(1), resetCounterEffect("conflagration_1p"), resetCounterEffect("conflagration_2p")))
											.seq(ifElseEffect(getTurnsPlayed(oppPid).eq(1), createCardEffect(pyromancer_phoenix_frenzy_1p_carddef(), currentSkillsLoc), createCardEffect(pyromancer_phoenix_frenzy_2p_carddef(), currentSkillsLoc)))
                                            .seq(ifElseEffect(getTurnsPlayed(oppPid).eq(1), incrementCounterEffect("conflagration_1p", 7), incrementCounterEffect("conflagration_2p", 7))),
											layout = createLayout(
                {
                    name = "Phoenix Frenzy",
					art = "art/epicart/fireball",
					frame = "frames/wizard_cardframe",
                    xmlText=[[
					<vlayout>
            <hlayout flexibleheight="2">
                <box flexiblewidth="0.2"/>
                <tmpro text="{scrap}" fontsize="40" flexiblewidth="1"/>
                <box flexiblewidth="0"/>
                <vlayout flexiblewidth="6">
                    <box flexibleheight="0.2"/>
                    <tmpro text="{combat}
&lt;size=65%&gt;Flip your skill to Afterburn.

&lt;size=50%&gt;{combat} gained starts at {combat_7}
and increases with each use of your skill." fontsize="32" flexibleheight="3"/>

                </vlayout>
            </hlayout>
        </vlayout>
					]]
                }
            ),
                                            tags = {}
                                        },
                                        
										{
                                            effect = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("conflagration_1p").Or(isCardName("conflagration_2p"))))
											.seq(ifElseEffect(getTurnsPlayed(oppPid).eq(1), createCardEffect(pyromancer_phoenix_flare_1p_carddef(), currentSkillsLoc), createCardEffect(pyromancer_phoenix_flare_2p_carddef(), currentSkillsLoc))),

											
											layout = createLayout(
                {
					name = "Phoenix Flare",
                    art = "art/epicart/ascendant_pyromancer",
                    frame = "frames/wizard_cardframe",
                    xmlText=[[
					<vlayout>
            <hlayout flexibleheight="2">
                <box flexiblewidth="0.2"/>
                <tmpro text="{scrap}" fontsize="40" flexiblewidth="1"/>
                <box flexiblewidth="0"/>
                <vlayout flexiblewidth="6">
                    <box flexibleheight="0.2"/>
                    <tmpro text="{combat}{health_6}
&lt;size=65%&gt;Flip your skill to Afterburn.

&lt;size=50%&gt;{combat} gained starts at {combat_5}
and increases with each use of your skill." fontsize="32" flexibleheight="3"/>

                </vlayout>
            </hlayout>
        </vlayout>
					]]
                }
            ),
                                            tags = {}
                                        },
										
                                    },
					upperTitle = "Level 8: Choose which ability you would like to upgrade to.",
					lowerTitle = "Click your choice to proceed."
					}))
	
--Level 7 card choice--
.seq(pushChoiceEffectWithTitle({
                                    choices = {
                                        {
                                            effect = createCardEffect(pyromancer_hearth_carddef(), currentDeckLoc),
                                            layout = createLayout(
                {
                    name = "Hearth",
                    art = "art/t_blistering_blaze",
                    frame = "frames/wizard_cardframe",
                    xmlText=[[
<vlayout>
<hlayout flexibleheight="1">
        <box flexiblewidth="7">
            <icon text="{health_3} &lt;size=70%&gt;or Draw 1." fontsize="50"/>
</box>
</hlayout>
</vlayout>
]]
				}
            )
            ,
                                            tags = {}
                                        },
                                        
										{
                                            effect = createCardEffect(pyromancer_fire_elemental_carddef(), currentDeckLoc),
                                            layout = createLayout(
                {
                    name = "Fire Elemental",
                    art = "art/epicart/fire_spirit",
                    frame = "frames/wizard_cardframe",
                    xmlText=[[
					<vlayout>
    <hlayout flexibleheight="3">
            <tmpro text="{expend}" fontsize="40" flexiblewidth="2"/>
            <tmpro text="{combat_2}" fontsize="50" flexiblewidth="12" />
    </hlayout>
    <divider/>
    <hlayout flexibleheight="2">
            <tmpro text="Just don't say 'Flame on' to it." fontsize="20" fontstyle="italic" flexiblewidth="10" />
    </hlayout> 
</vlayout>
					]],
                    health = 3,
                    isGuard = true
				}
            ),
                                            tags = {}
                                        },
										
                                    },
					upperTitle = "Level 7: Choose a card to add to your deck.",
					lowerTitle = ""
					}))
			
--Level 6 skill choice--
			.seq(pushChoiceEffectWithTitle(
                                {
                                    choices = {
                                        {
                                            effect = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("pyromancer_1p_compulsive_research_1_skill").Or(isCardName("pyromancer_2p_compulsive_research_1_skill")).Or(isCardName("pyromancer_1p_considered_research_1_skill")).Or(isCardName("pyromancer_2p_considered_research_1_skill"))))
											.seq(ifElseEffect(getTurnsPlayed(oppPid).eq(1), resetCounterEffect("fuel_1p"), resetCounterEffect("fuel_2p")))
											.seq(ifElseEffect(getTurnsPlayed(oppPid).eq(1), createCardEffect(pyromancer_1p_reckless_research_1carddef(), currentSkillsLoc), createCardEffect(pyromancer_2p_reckless_research_1carddef(), currentSkillsLoc)))
                                            .seq(ifElseEffect(getTurnsPlayed(oppPid).eq(1), incrementCounterEffect("fuel_1p", 3), incrementCounterEffect("fuel_2p", 3))),
											
											layout = createLayout(
                {
                    name = "Reckless Research",
                    art = "art/epicart/erratic_research",
                    frame = "frames/wizard_cardframe",
                    xmlText=[[
					<vlayout>
            <hlayout flexibleheight="0.7">
                <box flexiblewidth="0"/>
                <tmpro text="{expend_2}" fontsize="60" flexiblewidth="1"/>
                <box flexiblewidth="0"/>
                <vlayout flexiblewidth="6">
                    <box flexibleheight="0"/>
                    <tmpro text="{health_-1}
Add 3-7{combat} to your Ability. Increase the value of this skill by {combat_1} with each use." fontsize="19" flexibleheight="0.5"/>
                </vlayout>
            </hlayout>
<divider/>
<hlayout flexibleheight="0.2">
                     <tmpro text="Afterburn: {combat_3}{health_1}" fontsize="16" fontstyle="italic" flexiblewidth="8" />
    </hlayout>        </vlayout>
					]]
                }
            ),
                                            tags = {}
                                        },
                                        
										{
                                            effect = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("pyromancer_1p_compulsive_research_1_skill").Or(isCardName("pyromancer_2p_compulsive_research_1_skill")).Or(isCardName("pyromancer_1p_considered_research_1_skill")).Or(isCardName("pyromancer_2p_considered_research_1_skill"))))
											.seq(ifElseEffect(getTurnsPlayed(oppPid).eq(1), resetCounterEffect("fuel_1p"), resetCounterEffect("fuel_2p")))
											.seq(ifElseEffect(getTurnsPlayed(oppPid).eq(1), createCardEffect(pyromancer_1p_obsessive_research_1carddef(), currentSkillsLoc), createCardEffect(pyromancer_2p_obsessive_research_1carddef(), currentSkillsLoc)))
                                            .seq(ifElseEffect(getTurnsPlayed(oppPid).eq(1), incrementCounterEffect("fuel_1p", 2), incrementCounterEffect("fuel_2p", 2))),
											
											
											layout = createLayout(
                {
					name = "Obsessive Research",
                    art = "art/epicart/mystic_researcher",
                    frame = "frames/wizard_cardframe",
                    xmlText=[[
					<vlayout>
            <hlayout flexibleheight="0.7">
                <box flexiblewidth="0"/>
                <tmpro text="{expend_2}" fontsize="60" flexiblewidth="1"/>
                <box flexiblewidth="0"/>
                <vlayout flexiblewidth="6">
                    <box flexibleheight="0"/>
                    <tmpro text="Add 2-6{combat} to your Ability. Increase the value of this skill by {combat_1} with each use.
Draw 1. Put a card on the top of your deck." fontsize="19" flexibleheight="0.5"/>
                </vlayout>
            </hlayout>
<divider/>
<hlayout flexibleheight="0.2">
                     <tmpro text="Afterburn:
{combat_2}{health_1} Draw 1, put 1 on top of deck." fontsize="16" fontstyle="italic" flexiblewidth="8" />
    </hlayout>        </vlayout>
					]]
                }
            ),
                                            tags = {}
                                        },
										
										{
                                            effect = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("pyromancer_1p_compulsive_research_1_skill").Or(isCardName("pyromancer_2p_compulsive_research_1_skill")).Or(isCardName("pyromancer_1p_considered_research_1_skill")).Or(isCardName("pyromancer_2p_considered_research_1_skill"))))
											.seq(ifElseEffect(getTurnsPlayed(oppPid).eq(1), resetCounterEffect("fuel_1p"), resetCounterEffect("fuel_2p")))
											.seq(ifElseEffect(getTurnsPlayed(oppPid).eq(1), createCardEffect(pyromancer_1p_focussed_research_1carddef(), currentSkillsLoc), createCardEffect(pyromancer_2p_focussed_research_1carddef(), currentSkillsLoc)))
                                            .seq(ifElseEffect(getTurnsPlayed(oppPid).eq(1), incrementCounterEffect("fuel_1p", 1), incrementCounterEffect("fuel_2p", 1))),
											layout = createLayout(
                {
					name = "Focussed Research",
                    art = "art/epicart/lesson_learned",
                    frame = "frames/wizard_cardframe",
                    xmlText=[[
					<vlayout>
            <hlayout flexibleheight="0.7">
                <box flexiblewidth="0"/>
                <tmpro text="{expend_2}" fontsize="60" flexiblewidth="1"/>
                <box flexiblewidth="0"/>
                <vlayout flexiblewidth="6">
                    <box flexibleheight="0"/>
                    <tmpro text="Add 1-5{combat} to your Ability. Increase the value of this skill by {combat_1} with each use.
{health_2} Draw 1. Put a card on the top of your deck." fontsize="19" flexibleheight="0.5"/>
                </vlayout>
            </hlayout>
<divider/>
<hlayout flexibleheight="0.2">
                     <tmpro text="Afterburn:
{combat_1}{health_3} Draw 1, put 1 on top of deck." fontsize="16" fontstyle="italic" flexiblewidth="8" />
    </hlayout>        </vlayout>
					]]
                }
            ),
                                            tags = {}
                                        },
                                    },
					upperTitle = "Level 6: Choose which skill you would like to upgrade to.",
					lowerTitle = "Click your choice to proceed."
					}))
		
--Level 5 card choice--
.seq(pushChoiceEffectWithTitle({
                                    choices = {
                                        {
                                            effect = sacrificeTarget().apply(selectLoc(loc(currentPid, deckPloc)).where(isCardName("Pyromancer_Combust")))
.seq(createCardEffect(pyromancer_explode_carddef(), currentDeckLoc)),
                                            layout = createLayout(
                {
                    name = "Explode",
                    art = "art/epicart/zaltessa_s_fire",
                    frame = "frames/wizard_cardframe",
                    xmlText = [[
<vlayout>
    <box flexibleheight="1">
        <tmpro text="{combat_3}" fontsize="42"/>
    </box>
    <box flexibleheight="2">
        <tmpro text="+{combat_2} if you have a Fire Gem in play or in your discard pile." fontsize="24" />
    </box>
</vlayout>
					]],

                })
            ,
                                            tags = {}
                                        },
                                        
										{
                                            effect = sacrificeTarget().apply(selectLoc(loc(currentPid, deckPloc)).where(isCardName("pyromancer_scorch")))
.seq(createCardEffect(pyromancer_incinerate_carddef(), currentDeckLoc)),
                                            layout = createLayout(
                {
                    name = "Incinerate",
                    art = "art/epicart/flame_strike",
                    frame = "frames/wizard_cardframe",
                    xmlText=[[
					<vlayout>
    <box flexibleheight="1">
        <tmpro text="{combat_1}" fontsize="50"/>
    </box>
    <box flexibleheight="1">
        <tmpro text="Deal 2 damage to all opposing champions." fontsize="24" />
    </box>
</vlayout>
					]],

                }
            ),
                                            tags = {}
                                        },
										
                                    },
					upperTitle = "Level 5: Choose which card you would like to upgrade to.",
					lowerTitle = "Replace Combust or replace Scorch."
					}))

	
--Level 4 skill choice--
			.seq(pushChoiceEffectWithTitle(
                                {
                                    choices = {
                                        {
                                            effect = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("pyromancer_1p_fuel_1_skill").Or(isCardName("pyromancer_2p_fuel_1_skill"))))
											.seq(ifElseEffect(getTurnsPlayed(oppPid).eq(1), resetCounterEffect("fuel_1p"), resetCounterEffect("fuel_2p")))
											.seq(ifElseEffect(getTurnsPlayed(oppPid).eq(1), createCardEffect(pyromancer_1p_compulsive_research_1carddef(), currentSkillsLoc), createCardEffect(pyromancer_2p_compulsive_research_1carddef(), currentSkillsLoc)))
                                            .seq(ifElseEffect(getTurnsPlayed(oppPid).eq(1), incrementCounterEffect("fuel_1p", 2), incrementCounterEffect("fuel_2p", 2))),
											
											layout = createLayout(
                {
                    name = "Compulsive Research",
                    art = "art/epicart/frantic_digging",
                    frame = "frames/wizard_cardframe",
                    xmlText=[[
					<vlayout>
            <hlayout flexibleheight="1">
                <box flexiblewidth="0"/>
                <tmpro text="{expend_2}" fontsize="60" flexiblewidth="1"/>
                <box flexiblewidth="0"/>
                <vlayout flexiblewidth="6">
                    <box flexibleheight="0"/>
                    <tmpro text="Add 2-6{combat} to your Ability. Increase the value of this skill by {combat_1} with each use." fontsize="24" flexibleheight="1"/>
                </vlayout>
            </hlayout>
<divider/>
<hlayout flexibleheight="0.2">
                     <tmpro text="Afterburn: {combat_2}{health_1}" fontsize="18" fontstyle="italic" flexiblewidth="8" />
    </hlayout>        </vlayout>
					]]
                }
            ),
                                            tags = {}
                                        },
                                        
										{
                                            effect = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("pyromancer_1p_fuel_1_skill").Or(isCardName("pyromancer_2p_fuel_1_skill"))))
				.seq(ifElseEffect(getTurnsPlayed(oppPid).eq(1), createCardEffect(pyromancer_1p_considered_research_1carddef(), currentSkillsLoc), createCardEffect(pyromancer_2p_considered_research_1carddef(), currentSkillsLoc))),
                                            layout = createLayout(
                {
					name = "Considered Research",
                    art = "art/epicart/forbidden_research",
                    frame = "frames/wizard_cardframe",
                    xmlText=[[
					<vlayout>
            <hlayout flexibleheight="0.7">
                <box flexiblewidth="0"/>
                <tmpro text="{expend_2}" fontsize="60" flexiblewidth="1"/>
                <box flexiblewidth="0"/>
                <vlayout flexiblewidth="6">
                    <box flexibleheight="0"/>
                    <tmpro text="Add 1-5{combat} to your Ability. Increase the value of this skill by {combat_1} with each use.
Draw 1. Put a card on the top of your deck." fontsize="19" flexibleheight="0.5"/>
                </vlayout>
            </hlayout>
<divider/>
<hlayout flexibleheight="0.2">
                     <tmpro text="Afterburn:
{combat_1}{health_1}Draw 1, put 1 on top of deck." fontsize="16" fontstyle="italic" flexiblewidth="8" />
    </hlayout>        </vlayout>
					]]
                }
            ),
                                            tags = {}
                                        },
										
                                    },
					upperTitle = "Level 4: Choose which skill you would like to upgrade to.",
					lowerTitle = "Click your choice to proceed."
					}))
	
            })
        },
        layout = createLayout({
            name = "Pyromancer",
            art = "art/t_blistering_blaze",
			frame = "frames/coop_campaign_cardframe",
            xmlText=[[
<vlayout>
    <box flexibleheight="2">
        <tmpro text="Play as a level 12
Pyromancer" fontsize="26"/>
    </box>
    <box flexibleheight="1">
        <tmpro text="
- Class by Aarkenell -" fontsize="22" fontstyle="italic"/>
    </box>

<box flexibleheight="1">
        <tmpro text="- Created.25.2024-" fontsize="14" fontstyle="italic"/>
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
			.seq(moveTarget(sacrificePloc).apply(selectLoc(loc(currentPid, handPloc)))) --here--
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
			.seq(createCardEffect(cryomancer_ice_sickle_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(cryomancer_frostwulf_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(cryomancer_ice_gem_carddef(), loc(currentPid, asidePloc)))
			.seq(createCardEffect(cryomancer_freeze_carddef(), loc(currentPid, asidePloc)))

--Confirm--			
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
                    art = "art/treasures/t_cleric_elixir_green",
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
					upperTitle = "Confirm your choice. Do you want to use the cryomancer?",
					lowerTitle = ""
					}))

--Level 12 card choice--
.seq(pushChoiceEffectWithTitle({
                                    choices = {
                                        {
                                            effect = gainMaxHealthEffect(currentPid, const(58).add(getPlayerMaxHealth(currentPid).negate()))
												.seq(gainHealthEffect(58)),
                                            layout = createLayout(
                {
                    name = "Additional Health",
                    art = "avatars/rayla__endweaver_flipped",
                    frame = "frames/wizard_cardframe",
                    xmlText=[[
<vlayout>
    <box flexibleheight="9">
        <tmpro text="{health_+6}" fontsize="70"/>
    </box>
 </vlayout>
]]
				}
            )
            ,
                                            tags = {}
                                        },
                                        
										{
                                            effect = createCardEffect(cryomancer_fog_carddef(), currentSkillsLoc),
                                            layout = createLayout(
                {
                    name = "Fog",
                    art = "art/t_blow_away",
                    frame = "frames/wizard_cardframe",
                    xmlText=[[
					<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{scrap}" fontsize="40"/>
        </box>
        <box flexiblewidth="7">
            <tmpro text="Set aside a card of cost 2{gold} or less in your opponent's discard pile. The next time your opponent shuffles their deck, put that card on the bottom of their deck." fontsize="18" />
        </box>
    </hlayout>
</vlayout>
					]]
				}
            ),
                                            tags = {}
                                        },
										
                                    },
					upperTitle = "Level 12: Choose an upgrade.",
					lowerTitle = "Gain max health, or gain a level 1 Ability."
					}))

--Level 11 card choice--
.seq(pushChoiceEffectWithTitle({
                                    choices = {
                                        {
                                            effect = createCardEffect(cryomancer_eternal_frost_carddef(), currentDeckLoc),
                                            layout = createLayout(
                {
                    name = "External Frost",
                    art = "art/epicart/forced_exile",
                    frame = "frames/wizard_cardframe",
                    xmlText=[[
<vlayout>
    <box flexibleheight="7">
        <tmpro text="Draw 1

Add a frostbite card to opponent's discard." fontsize="24"/>
    </box>
</vlayout>
]]
				}
            )
            ,
                                            tags = {}
                                        },
                                        
										{
                                            effect = createCardEffect(cyromancer_cryonics_carddef(), currentDeckLoc),
                                            layout = createLayout(
                {
                    name = "Cryonics",
                    art = "art/epicart/transfigure",
                    frame = "frames/wizard_cardframe",
                    xmlText=[[
<vlayout>
    <box flexibleheight="1">
        <tmpro text="Put a champion from your discard pile to the bottom of your deck. It gets +3{shield} until it leaves play.

Draw 1." fontsize="22" />
    </box>
</vlayout>
					]]
				}
            ),
					
                                            tags = {}
                                        },
										
                                    },
					upperTitle = "Level 11: Choose a card to add to your deck.",
					lowerTitle = "Add Eternal Frost or Cryonics to your deck."
					}))
			
--Level 10 Ability choice--
			.seq(pushChoiceEffectWithTitle(
                                {
                                    choices = {
                                        {
                                            effect = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("cryomancer_hoarfrost").Or(isCardName("cryomancer_ice_floe_ab"))))
				.seq(createCardEffect(cryomancer_snow_squall_carddef(), currentSkillsLoc)),
                                            layout = createLayout(
                {
					name = "Snow Squall",
					art = "art/t_chaotic_gust",
					frame = "frames/wizard_cardframe",
					xmlText=[[
					<vlayout>
    <hlayout flexibleheight="2">
            <icon text="{scrap}" fontsize="32" flexiblewidth="0"/>
            <tmpro text="Put Frostbite card on top of opponent's deck.

Set aside a card of cost 8{gold} or less in your opponent's discard pile. The next time your opponent shuffles their deck, put that card on the bottom of their deck." fontsize="14" flexiblewidth="10" />
    </hlayout>
    <divider/>
    <hlayout flexibleheight="0.5">
            <tmpro text="Frostbite card: {scrap} {health_-1}" fontsize="14" flexiblewidth="10" />
    </hlayout> 
</vlayout>
					]]
                }
            ),
                                            tags = {}
                                        },
                                        
										{
                                            effect = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("cryomancer_hoarfrost").Or(isCardName("cryomancer_ice_floe_ab"))))
					.seq(createCardEffect(cryomancer_ice_sheet_ab_carddef(), currentSkillsLoc)),
                                            layout = createLayout(
                {
                    name = "Ice Sheet",
					art = "art/t_chaotic_gust",
					frame = "frames/wizard_cardframe",
					xmlText=[[
					<vlayout>
    <hlayout flexibleheight="2">
            <icon text="{scrap}" fontsize="32" flexiblewidth="0"/>
            <tmpro text="Set aside a card of cost 6{gold} or less in your opponent's discard pile. The next time your opponent shuffles their deck, put that card on the bottom of their deck.

Put an Ice Floe card on top of opponent's deck." fontsize="14" flexiblewidth="10" />
    </hlayout>
    <divider/>
    <hlayout flexibleheight="0.5">
            <tmpro text="Ice Floe card: Does nothing" fontsize="14" flexiblewidth="10" />
    </hlayout> 
</vlayout>
					]]
                }
            ),
                                            tags = {}
                                        },
										
										{
                                            effect = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("cryomancer_hoarfrost").Or(isCardName("cryomancer_ice_floe_ab"))))
											.seq(createCardEffect(cryomancer_permafrost_ab_carddef(), currentSkillsLoc)),
                                            layout = createLayout(
                {
                    name = "Permafrost",
					art = "art/t_chaotic_gust",
					frame = "frames/wizard_cardframe",
					xmlText=[[
					<vlayout>
    <hlayout flexibleheight="1">
            <icon text="{scrap}" fontsize="28" flexiblewidth="0"/>
            <tmpro text="Set aside a card of cost 4{gold} or less in your opponent's discard pile. The next time they shuffle their deck, put that card on the bottom of their deck.

Put Permafrost on top of their deck." fontsize="14" flexiblewidth="1" />
    </hlayout>
    <divider/>
    <hlayout flexibleheight="0.2">
            <tmpro text="Permafrost: Does nothing. Can't be sacrificed." fontsize="12" flexiblewidth="10" />
    </hlayout> 
</vlayout>
					]]
                }
            ),
                                            tags = {}
                                        }
										
                                    },
					upperTitle = "Level 10: Choose which ability you would like to upgrade to.",
					lowerTitle = "Click your choice to proceed."
					}))
	
--Level 9 Armour choice--
.seq(pushChoiceEffectWithTitle({
                                    choices = {
                                        {
                                            effect = createCardEffect(cryomancer_ice_mail_carddef(), currentSkillsLoc),
                                            layout = createLayout(
                {
                    name = "Ice Mail",
        art = "art/epicart/crystal_golem",
        frame = "frames/wizard_cardframe",
        xmlText=[[
					
<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{requiresHealth_40}" fontsize="60"/>
        </box>
        <box flexiblewidth="5">
            <tmpro text="Choose a card in the market. Your opponent can't buy it on their next turn. It will cost you {gold_1} less to buy on your next turn." fontsize="20" />
        </box>
    </hlayout>
</vlayout>
					]]
				}
            ),
                                            tags = {}
                                        },
                                        
										{
                                            effect = createCardEffect(cryomancer_ice_crown_carddef(), currentSkillsLoc),
                                            layout = createLayout(
                {
                    name = "Ice Crown",
        art = "art/classes/necromancer/rotting_crown",
        frame = "frames/wizard_cardframe",
        xmlText=[[
					
<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{requiresHealth_35}" fontsize="60"/>
        </box>
        <box flexiblewidth="5">
            <tmpro text="If you stunned a champion or played a champion this turn, draw 1." fontsize="20" />
        </box>
    </hlayout>
</vlayout>
					]]
				}
            ),
                                            tags = {}
                                        },
										
                                    },
					upperTitle = "Level 9: Choose your armour.",
					lowerTitle = ""
					}))

--Level 8 Ability choice--
			.seq(pushChoiceEffectWithTitle(
                                {
                                    choices = {
                                        {
                                            effect = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("cryomancer_freezing_fog")))
				.seq(createCardEffect(cryomancer_hoarfrost_carddef(), currentSkillsLoc)),
                                            layout = createLayout(
                {
                    name = "Hoarfrost",
					art = "art/t_chaotic_gust",
					frame = "frames/wizard_cardframe",
					xmlText=[[
					<vlayout>
    <hlayout flexibleheight="2">
            <icon text="{scrap}" fontsize="32" flexiblewidth="0"/>
            <tmpro text="Put Frostbite card on top of opponent's deck.

Set aside a card of cost 6{gold} or less in your opponent's discard pile. The next time your opponent shuffles their deck, put that card on the bottom of their deck." fontsize="14" flexiblewidth="10" />
    </hlayout>
    <divider/>
    <hlayout flexibleheight="0.5">
            <tmpro text="Frostbite card: {scrap} {health_-1}" fontsize="14" flexiblewidth="10" />
    </hlayout> 
</vlayout>
					]]
                }
            ),
                                            tags = {}
                                        },
                                        
										{
                                            effect = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("cryomancer_freezing_fog")))
				.seq(createCardEffect(cryomancer_ice_floe_ab_carddef(), currentSkillsLoc)),
                                            layout = createLayout(
                {
					name = "Ice Floe",
					art = "art/t_chaotic_gust",
					frame = "frames/wizard_cardframe",
					xmlText=[[
					<vlayout>
    <hlayout flexibleheight="2">
            <icon text="{scrap}" fontsize="32" flexiblewidth="0"/>
            <tmpro text="Set aside a card of cost 4{gold} or less in your opponent's discard pile. The next time your opponent shuffles their deck, put that card on the bottom of their deck.

Put an Ice Floe card on top of opponent's deck." fontsize="14" flexiblewidth="10" />
    </hlayout>
    <divider/>
    <hlayout flexibleheight="0.5">
            <tmpro text="Ice Floe card: Does nothing" fontsize="14" flexiblewidth="10" />
    </hlayout> 
</vlayout>
					]]
                }
            ),
                                            tags = {}
                                        },
										
                                    },
					upperTitle = "Level 8: Choose which ability you would like to upgrade to.",
					lowerTitle = "Click your choice to proceed."
					}))
	
--Level 7 card choice--
.seq(pushChoiceEffectWithTitle({
                                    choices = {
                                        {
                                            effect = createCardEffect(cryomancer_cold_snap_carddef(), currentDeckLoc),
                                            layout = createLayout(
                {
                    name = "Cold Snap",
                    art = "art/epicart/ice_drake",
                    frame = "frames/wizard_cardframe",
                    xmlText=[[
<vlayout>
    <box flexibleheight="1">
        <tmpro text="Draw 1.
Target opponent takes 1 damage for each Frostbite card in their hand/deck/discard pile." fontsize="24" />
    </box>
</vlayout>
]]
				}
            )
            ,
                                            tags = {}
                                        },
                                        
										{
                                            effect = createCardEffect(cyromancer_polarmour_carddef(), currentDeckLoc),
                                            layout = createLayout(
                {
                    name = "Polarmour",
                    art = "art/epicart/force_field",
                    frame = "frames/wizard_cardframe",
                    xmlText=[[
<vlayout>
    <box flexibleheight="1">
        <tmpro text="Draw 1.
Attach this to a friendly champion. It has +1{shield} and when stunned, target opponent takes 3 damage." fontsize="22" />
    </box>
</vlayout>
					]]
				}
            ),
                                            tags = {}
                                        },
										
                                    },
					upperTitle = "Level 7: Choose a card to add to your deck.",
					lowerTitle = ""
					}))
			

--Level 6 skill choice--
			.seq(pushChoiceEffectWithTitle(
                                {
                                    choices = {
                                        {
                                            effect = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("cryomancer_rapid_frostbiteskill").Or(isCardName("cryomancer_deep_frostbiteskill"))))
				.seq(createCardEffect(cryomancer_instant_frostbiteskill_carddef(), currentSkillsLoc)),
                                            layout = createLayout(
                {
                    name = "Instant Frostbite",
        art = "art/epicart/frost_giant",
        frame = "frames/wizard_cardframe",
        xmlText = 
		[[
		<vlayout>
    <hlayout flexibleheight="2">
            <icon text="{expend_1}" fontsize="72" flexiblewidth="0"/>
            <tmpro text="Add a frostbite card to the top of opponent's deck." fontsize="20" flexiblewidth="10" />
    </hlayout>
    <divider/>
    <hlayout flexibleheight="2">
            <tmpro text="Frostbite card: {scrap} {health_-1}" fontsize="20" flexiblewidth="10" />
    </hlayout> 
</vlayout>
					]]
                }
            ),
                                            tags = {}
                                        },
                                        
										{
                                            effect = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("cryomancer_rapid_frostbiteskill").Or(isCardName("cryomancer_deep_frostbiteskill"))))
				.seq(createCardEffect(cryomancer_severe_frostbiteskill_carddef(), currentSkillsLoc)),
                                            layout = createLayout(
                {
                    name = "Severe Frostbite",
        art = "art/epicart/frost_giant",
        frame = "frames/wizard_cardframe",
        xmlText = 
		[[
		<vlayout>
    <hlayout flexibleheight="2">
            <icon text="{expend_2}" fontsize="72" flexiblewidth="0"/>
            <tmpro text="Add 1 frostbite card to opponent's discard and another to the top of their deck." fontsize="20" flexiblewidth="10" />
    </hlayout>
    <divider/>
    <hlayout flexibleheight="2">
            <tmpro text="Frostbite card: {scrap} {health_-1}" fontsize="20" flexiblewidth="10" />
    </hlayout> 
</vlayout>
					]]
                }
            ),
                                            tags = {}
                                        },
										
										{
                                            effect = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("cryomancer_rapid_frostbiteskill").Or(isCardName("cryomancer_deep_frostbiteskill"))))
				.seq(createCardEffect(cryomancer_extreme_frostbiteskill_carddef(), currentSkillsLoc)),
                                            layout = createLayout(
                {
                    name = "Extreme Frostbite",
        art = "art/epicart/frost_giant",
        frame = "frames/wizard_cardframe",
        xmlText = 
		[[
		<vlayout>
    <hlayout flexibleheight="2">
            <icon text="{expend_2}" fontsize="72" flexiblewidth="0"/>
            <tmpro text="{combat_2}
&lt;size=65%&gt;Add 2 frostbite cards to opponent's discard." fontsize="30" flexiblewidth="10" />
    </hlayout>
    <divider/>
    <hlayout flexibleheight="2">
            <tmpro text="Frostbite card: {scrap} {health_-1}" fontsize="20" flexiblewidth="10" />
    </hlayout> 
</vlayout>
					]]
                }
            ),
                                            tags = {}
                                        },
										
                                    },
					upperTitle = "Level 6: Choose which skill you would like to upgrade to.",
					lowerTitle = "Click your choice to proceed."
					}))
	
--Level 5 card choice--
.seq(pushChoiceEffectWithTitle({
                                    choices = {
                                        {
                                            effect = sacrificeTarget().apply(selectLoc(loc(currentPid, deckPloc)).where(isCardName("cryomancer_freeze")))
.seq(createCardEffect(cryomancer_deep_freeze_carddef(), currentDeckLoc)),
                                            layout = createLayout(
                {
                    name = "Deep Freeze",
                    art = "art/epicart/polar_shock",
                    frame = "frames/wizard_cardframe",
                    xmlText=[[
<vlayout>
    <box flexibleheight="2">
        <tmpro text="{combat_1}" fontsize="50"/>
    </box>
	<box flexibleheight="2">
        <tmpro text="Expend and deal 1 damage to all of opponent's  champions." fontsize="22" />
    </box>
</vlayout>
					]],
                    
                })
            ,
                                            tags = {}
                                        },
                                        
										{
                                            effect = sacrificeTarget().apply(selectLoc(loc(currentPid, deckPloc)).where(isCardName("cryomancer_ice_sickle")))
.seq(createCardEffect(cryomancer_ice_sickles_carddef(), currentDeckLoc)),
                                            layout = createLayout(
                {
                    name = "Ice Sickles",
                    art = "art/epicart/shock_trooper",
                    frame = "frames/wizard_cardframe",
                    xmlText=[[
<vlayout>
    <box flexibleheight="7">
        <tmpro text="{combat_2}" fontsize="42"/>
    </box>

<box flexibleheight="7">
        <tmpro text="+{combat_1} for each champion you have in play" fontsize="22"/>
    </box>
<divider/>
    <box flexibleheight="3">
        <tmpro text="Welcome to the harvest." fontsize="18" fontstyle="italic"/>
    </box>
</vlayout>
					]],
                }
            ),
                                            tags = {}
                                        },
										
                                    },
					upperTitle = "Level 5: Choose which card you would like to upgrade to.",
					lowerTitle = "Replace Freeze or Ice Sickle."
					}))
			
--Level 4 skill choice--
			.seq(pushChoiceEffectWithTitle(
                                {
                                    choices = {
                                        {
                                            effect = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("cryomancer_frostbiteskill_skill")))
				.seq(createCardEffect(cryomancer_rapid_frostbiteskill_carddef(), currentSkillsLoc)),
                                            layout = createLayout(
                {
                    name = "Rapid Frostbite",
        art = "art/epicart/frost_giant",
        frame = "frames/wizard_cardframe",
        xmlText = 
		[[
		<vlayout>
    <hlayout flexibleheight="2">
            <icon text="{expend_2}" fontsize="72" flexiblewidth="0"/>
            <tmpro text="Add a frostbite card to the top of opponent's deck." fontsize="20" flexiblewidth="10" />
    </hlayout>
    <divider/>
    <hlayout flexibleheight="2">
            <tmpro text="Frostbite card: {scrap} {health_-1}" fontsize="20" flexiblewidth="10" />
    </hlayout> 
</vlayout>
					]]
                }
            ),
                                            tags = {}
                                        },
                                        
										{
                                            effect = sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("cryomancer_frostbiteskill_skill")))
				.seq(createCardEffect(cryomancer_deep_frostbiteskill_carddef(), currentSkillsLoc)),
                                            layout = createLayout(
                {
					name = "Deep Frostbite",
        art = "art/epicart/frost_giant",
        frame = "frames/wizard_cardframe",
        xmlText = 
		[[
		<vlayout>
    <hlayout flexibleheight="2">
            <icon text="{expend_2}" fontsize="72" flexiblewidth="0"/>
            <tmpro text="Add 2 frostbite cards to opponent's discard." fontsize="20" flexiblewidth="10" />
    </hlayout>
    <divider/>
    <hlayout flexibleheight="2">
            <tmpro text="Frostbite card: {scrap} {health_-1}" fontsize="20" flexiblewidth="10" />
    </hlayout> 
</vlayout>
					]]
                }
            ),
                                            tags = {}
                                        },
										
                                    },
					upperTitle = "Level 4: Choose which skill you would like to upgrade to.",
					lowerTitle = "Click your choice to proceed."
					}))
	
            })
        },
        layout = createLayout({
            name = "Cryomancer",
            art = "avatars/rayla__endweaver_flipped",
			frame = "frames/coop_campaign_cardframe",
            xmlText=[[
			<vlayout>
    <box flexibleheight="2">
        <tmpro text="Play as a level 12
Cryomancer" fontsize="26"/>
    </box>
    <box flexibleheight="1">
        <tmpro text="
- Class by Aarkenell -" fontsize="22" fontstyle="italic"/>
    </box>

<box flexibleheight="1">
        <tmpro text="- Created 06.03.2025-" fontsize="14" fontstyle="italic"/>
    </box>
</vlayout>

			]]
			}),
        })
	end


-- Demonologist cards  -----------------------------------------------------------------------------------------------------------------------
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
                    art = "art/t_midnight_knight",
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
                    art = "art/t_demon",
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
        art = "icons/the_summoning",
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
        layoutPath = "icons/the_summoning",
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
                    art = "art/t_wurm",
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
                    art = "art/epicart/succubus",
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
                    art = "icons/the_summoning",
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
                    art = "art/t_wurm",
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
                    art = "art/epicart/succubus",
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
        art = "art/t_angry_skeleton",
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
        layoutPath = "art/t_angry_skeleton",
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
                    art = "art/t_angry_skeleton",
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
            art = "art/t_angry_skeleton",
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

function demonologist_summon_incubus_carddef()
    local cardLayout = createLayout({
        name = "Summon Incubus",
            art = "art/epicart/guilt_demon",
            frame = "frames/necromancer_frames/necromancer_item_cardframe",
		xmlText=[[
<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="2">
            <tmpro text="{scrap}" fontsize="50"/>
        </box>
        <box flexiblewidth="7">
            <tmpro text="Put the Incubus into play.
&lt;size=70%&gt;
(It has {combat_3} and 4{shield} and gains +{combat_1} permanently at the start of each turn.)" fontsize="24" flexiblewidth="10" />
</box>
</hlayout>
</vlayout>
		]]
    })

    return createSkillDef({
        id = "demonologist_summon_incubus_ability",
        name = "Summon Incubus",
        types = { skillType },
        layout = cardLayout,
        layoutPath = "art/epicart/guilt_demon",
        abilities = {
            createAbility({
                id = "demonologist_summon_incubus_ab",
                trigger = uiTrigger,
                activations = singleActivation,
                layout = cardLayout,
                promptType = showPrompt,
                effect = createCardEffect(demonologist_incubus_carddef(), currentInPlayLoc),
				cost = sacrificeSelfCost,
			}),
        },
		layout = createLayout(
                {
                    name = "Summon Incubus",
                    art = "art/epicart/guilt_demon",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="2">
            <tmpro text="{scrap}" fontsize="50"/>
        </box>
        <box flexiblewidth="7">
            <tmpro text="Put the Incubus into play.
&lt;size=70%&gt;
(It has {combat_3} and 4{shield} and gains +{combat_1} permanently at the start of each turn.)" fontsize="24" flexiblewidth="10" />
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

function demonologist_summon_keeper_of_the_void_carddef()
    local cardLayout = createLayout({
        name = "Summon Keeper of the Void",
            art = "art/epicart/spawning_demon",
            frame = "frames/necromancer_frames/necromancer_item_cardframe",
		xmlText=[[
<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{scrap}" fontsize="40"/>
        </box>
        <box flexiblewidth="7">
            <tmpro text="Put the Keeper of the Void into play.
&lt;size=70%&gt;
(It has {combat_2} and 4{guard} and gains +1{guard} for every 2 other demon minions in play (round down) until the start of next turn.)" fontsize="24" flexiblewidth="10" />
</box>
</hlayout>
</vlayout>
		]]
    })

    return createSkillDef({
        id = "demonologist_summon_keeper_of_the_void_ability",
        name = "Summon Keeper of the Void",
        types = { skillType },
        layout = cardLayout,
        layoutPath = "art/epicart/spawning_demon",
        abilities = {
            createAbility({
                id = "demonologist_summon_keeper_of_the_void_ab",
                trigger = uiTrigger,
                activations = singleActivation,
                layout = cardLayout,
                promptType = showPrompt,
                effect = createCardEffect(demonologist_keeper_of_the_void_carddef(), currentInPlayLoc),
				cost = sacrificeSelfCost,
			}),
        },
		layout = createLayout(
                {
                    name = "Summon Keeper of the Void",
                    art = "art/epicart/spawning_demon",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{scrap}" fontsize="40"/>
        </box>
        <box flexiblewidth="7">
            <tmpro text="Put the Keeper of the Void into play.
&lt;size=70%&gt;
(It has {combat_2} and 4{guard} and gains +1{guard} for every 2 other demon minions in play (round down) until the start of next turn.)" fontsize="24" flexiblewidth="10" />
</box>
</hlayout>
</vlayout>
					]]
                }
            )
        
    })
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

function demonologist_summon_karamight_carddef()
    local cardLayout = createLayout({
        name = "Summon Karamight",
            art = "art/epicart/raxxa_s_enforcer",
            frame = "frames/necromancer_frames/necromancer_item_cardframe",
		xmlText=[[
<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{scrap}" fontsize="40"/>
        </box>
        <box flexiblewidth="7">
            <tmpro text="Put Karamight
into play.
&lt;size=70%&gt;
(It has {combat_6} and 5{guard} and
'Once per turn you may stun 1 demon minion you own to gain +2{guard} until next turn'.)" fontsize="24" flexiblewidth="10" />
</box>
</hlayout>
</vlayout>
		]]
    })

    return createSkillDef({
        id = "demonologist_summon_karamight_ability",
        name = "Summon Karamight",
        types = { skillType },
        layout = cardLayout,
        layoutPath = "art/epicart/raxxa_s_enforcer",
        abilities = {
            createAbility({
                id = "demonologist_summon_karamight_ab",
                trigger = uiTrigger,
                activations = singleActivation,
                layout = cardLayout,
                promptType = showPrompt,
                effect = createCardEffect(demonologist_karamight_carddef(), currentInPlayLoc),
				cost = sacrificeSelfCost,
			}),
        },
		layout = createLayout(
                {
                    name = "Summon Karamight",
                    art = "art/epicart/raxxa_s_enforcer",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
    <hlayout flexibleheight="3">
            <tmpro text="{expend}" fontsize="40" flexiblewidth="2"/>
            <icon text="{combat_6}" fontsize="40" flexiblewidth="10" />
    </hlayout>
<divider/>
    <hlayout flexibleheight="7">
            <tmpro text="You may stun a demon token you own to gain +2{guard} until next turn." fontsize="20" flexiblewidth="10" />
    </hlayout> 
</vlayout>
					]]
                }
            )
        
    })
end

function demonologist_karamight_carddef()
    return createChampionDef(
        {
            id = "demonologist_karamight",
            name = "Karamight",
			types = {championType, demonType, minionType, nostealType},
            acquireCost = 0,
            health = 5,
            isGuard = true,
            abilities = {
                createAbility(
                    {
                        id = "demonologist_karamight_main",
                        trigger = autoTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = gainCombatEffect(6),
                    }
                ),
				
			createAbility(
                    {
                        id = "demonologist_karamight_stun",
                        trigger = uiTrigger,
                        cost = noCost,
                        activations = singleActivations,
                        effect = grantHealthTarget(2, { SlotExpireEnum.startOfOwnerTurn }, nullEffect(), "Karamight").apply(selectSource())
						.seq(pushTargetedEffect({
                    desc = "Stun a demon minion you own to gain +2 <sprite name=\"guard\"> until your next turn.",
                    validTargets = selectLoc(currentInPlayLoc).where(isCardType(minionType)),
                    min = 1,
                    max = 1,
                    targetEffect = stunTarget(),
					
            })),
			check = selectLoc(currentInPlayLoc).where(isCardType(minionType)).count().gte(1)
                    }
                ),
				
			createAbility(
                    {
                        id = "demonologist_karamight_sac",
                        trigger = onLeavePlayTrigger,
                        cost = sacrificeSelfCost,
                        activations = multipleActivations,
                        effect = nullEffect()
					}	
                    
                )
            },
            layout = createLayout({
            name = "Karamight",
            art = "art/epicart/raxxa_s_enforcer",
            frame = "frames/necromancer_frames/necromancer_item_cardframe",
            xmlText = [[
			<vlayout>
    <hlayout flexibleheight="3">
            <tmpro text="{expend}" fontsize="40" flexiblewidth="2"/>
            <icon text="{combat_6}" fontsize="40" flexiblewidth="10" />
    </hlayout>
<divider/>
    <hlayout flexibleheight="7">
            <tmpro text="You may stun a demon token you own to gain +2{guard} until next turn." fontsize="20" flexiblewidth="10" />
    </hlayout> 
</vlayout>
]],
					health = 5,
                    isGuard = true
        })
        }
    )
end

function demonologist_summon_laughing_shade_carddef()
    local cardLayout = createLayout({
        name = "Summon Laughing Shade",
            art = "art/epicart/dark_prince",
            frame = "frames/necromancer_frames/necromancer_item_cardframe",
		xmlText=[[
<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{scrap}" fontsize="40"/>
        </box>
        <box flexiblewidth="7">
            <tmpro text="Put Laughing Shade
into play.
&lt;size=70%&gt;
(It has {combat_4} and 5{shield} and 'Sacrifice a card in the market. If it is an Action, +{combat_2} this turn. If it is a Champion, +{health_3}'.)" fontsize="24" flexiblewidth="10" />
</box>
</hlayout>
</vlayout>
		]]
    })

    return createSkillDef({
        id = "demonologist_summon_laughing_shade_ability",
        name = "Summon Laughing Shade",
        types = { skillType },
        layout = cardLayout,
        layoutPath = "art/epicart/dark_prince",
        abilities = {
            createAbility({
                id = "demonologist_summon_laughing_shade_ab",
                trigger = uiTrigger,
                activations = singleActivation,
                layout = cardLayout,
                promptType = showPrompt,
                effect = createCardEffect(demonologist_laughing_shade_carddef(), currentInPlayLoc),
				cost = sacrificeSelfCost,
			}),
        },
		layout = createLayout(
                {
                    name = "Summon Laughing Shade",
                    art = "art/epicart/dark_prince",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{scrap}" fontsize="40"/>
        </box>
        <box flexiblewidth="7">
            <tmpro text="Put Laughing Shade
into play.
&lt;size=70%&gt;
(It has {combat_4} and 5{shield} and 'Sacrifice a card in the market. If it is an Action, +{combat_2} this turn. If it is a Champion, +{health_3}'.)" fontsize="24" flexiblewidth="10" />
</box>
</hlayout>
</vlayout>
					]]
                }
            )
        
    })
end

function demonologist_laughing_shade_carddef()
    return createChampionDef(
        {
            id = "demonologist_laughing_shade",
            name = "Laughing Shade",
			types = {championType, demonType, minionType, nostealType},
            acquireCost = 0,
            health = 5,
            isGuard = false,
            abilities = {
                createAbility(
                    {
                        id = "demonologist_laughing_shade_main",
                        trigger = uiTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = gainCombatEffect(4)
						.seq(pushChoiceEffect(
                                {
                                    choices = {
                                        {
                                            effect = pushTargetedEffect({
												desc = "Sacrifice a Action from the market. <sprite name=\"combat_2\">",
												validTargets = selectLoc(centerRowLoc).where(isCardType(actionType)),
												min = 0,
												max = 1,
												targetEffect = sacrificeTarget().seq(gainCombatEffect(2)),
												}),
                                            layout = layoutCard(
                                                {
                                                    title = "Laughing Shade",
													art = "art/epicart/dark_prince",
                                                    xmlText=[[
													<vlayout>
    <hlayout flexibleheight="6">
            <tmpro text="&lt;size=70%&gt;Sacrifice an Action from the market. 
&lt;size=100%&gt;{combat_2}" fontsize="40" flexiblewidth="10" />
    </hlayout> 
</vlayout>
													]]
                                                }
                                            ),
                                            tags = {gainCombatTag}
                                        },
                                        {
                                            effect = pushTargetedEffect({
												desc = "Sacrifice a Champion from the market. <sprite name=\"health_3\">",
												validTargets = selectLoc(centerRowLoc).where(isCardType(championType)),
												min = 0,
												max = 1,
												targetEffect = sacrificeTarget().seq(gainHealthEffect(3)),
												}),
                                            layout = layoutCard(
                                                {
                                                    title = "Laughing Shade",
													art = "art/epicart/dark_prince",
                                                    xmlText=[[
<vlayout>
    <hlayout flexibleheight="6">
            <tmpro text="&lt;size=70%&gt;Sacrifice a Champion from the market. 
&lt;size=100%&gt;{health_3}" fontsize="40" flexiblewidth="10" />
    </hlayout> 
</vlayout>
													]]
                                                }
                                            ),
                                                                                    }
                                    }
                                }
                        )),
					
                    }
                ),
				
			createAbility(
                    {
                        id = "demonologist_laughing_shade_sac",
                        trigger = onLeavePlayTrigger,
                        cost = sacrificeSelfCost,
                        activations = multipleActivations,
                        effect = nullEffect()
					}	
                    
                )
            },
            layout = createLayout({
            name = "Laughing Shade",
            art = "art/epicart/dark_prince",
            frame = "frames/necromancer_frames/necromancer_item_cardframe",
            xmlText = [[
			<vlayout>
    <hlayout flexibleheight="4">
            <tmpro text="{expend}" fontsize="40" flexiblewidth="2"/>
            <icon text="{combat_4}" fontsize="40" flexiblewidth="10" />
    </hlayout>
    <hlayout flexibleheight="6">
            <tmpro text="Sacrifice a card in the market. If it is an Action, +{combat_2} this turn. If it is a Champion, +{health_3}." fontsize="20" flexiblewidth="10" />
    </hlayout> 
</vlayout>
]],
					health = 5,
                    isGuard = false
        })
        }
    )
end

function demonologist_summon_ingaitch_carddef()
    local cardLayout = createLayout({
        name = "Summon Ingaitch the Ravenous",
            art = "art/epicart/mythic_monster",
            frame = "frames/necromancer_frames/necromancer_item_cardframe",
		xmlText=[[
<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{scrap}" fontsize="40"/>
        </box>
        <box flexiblewidth="7">
            <tmpro text="Put Ingaitch the Ravenous into play.
&lt;size=70%&gt;
(It has {combat_7} and 7{shield}. When expended choose: -1{shield} or {health_-3}.)

&lt;size=60%&gt;Usable from your 3rd turn." fontsize="24" flexiblewidth="10" />
</box>
</hlayout>
</vlayout>
		]]
    })

    return createSkillDef({
        id = "demonologist_summon_ingaitch_ability",
        name = "Summon Ingaitch the Ravenous",
        types = { skillType },
        layout = cardLayout,
        layoutPath = "art/epicart/mythic_monster",
        abilities = {
            createAbility({
                id = "demonologist_summon_ingaitch_ab",
                trigger = uiTrigger,
                activations = singleActivation,
                layout = cardLayout,
                promptType = showPrompt,
                effect = createCardEffect(demonologist_ingaitch_carddef(), currentInPlayLoc),
				check = getTurnsPlayed(currentPid).gte(3),
				cost = sacrificeSelfCost,
			}),
        },
		
		layout = createLayout(
                {
                    name = "Summon Ingaitch the Ravenous",
                    art = "art/epicart/mythic_monster",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{scrap}" fontsize="40"/>
        </box>
        <box flexiblewidth="7">
            <tmpro text="Put Ingaitch the Ravenous into play.
&lt;size=70%&gt;
(It has {combat_7} and 7{shield}. When expended choose: -1{shield} or {health_-3}.)

&lt;size=60%&gt;Usable from your 3rd turn." fontsize="24" flexiblewidth="10" />
</box>
</hlayout>
</vlayout>
					]]
                }
            )
        
    })
end

function demonologist_ingaitch_carddef()
    return createChampionDef(
        {
            id = "demonologist_ingaitch",
            name = "Ingaitch the Ravenous",
			types = {championType, demonType, minionType, nostealType},
            acquireCost = 0,
            health = 7,
            isGuard = false,
            abilities = {
				createAbility(
                    {
                        id = "demonologist_ingaitch_main",
                        trigger = uiTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = gainCombatEffect(7)
						}
                ),
				
				createAbility(
                    {
                        id = "demonologist_ingaitch_choice",
                        trigger = onExpendTrigger,
                        cost = noCost,
                        activations = singleActivations,
                        effect = gainCombatEffect(4)
						.seq(pushChoiceEffect(
                                {
                                    choices = {
                                        {
                                            effect = gainHealthEffect(-3),
                                            layout = layoutCard(
                                                {
                                                    title = "Ingaitch the Ravenous",
													art = "art/epicart/mythic_monster",
                                                    xmlText=[[
													<vlayout>
    <hlayout flexibleheight="6">
            <tmpro text="{health_-3}" fontsize="70" flexiblewidth="10" />
    </hlayout> 
</vlayout>
													]]
                                                }
                                            ),
                                            tags = {gainCombatTag}
                                        },
                                        {
                                            effect = grantHealthTarget(-1, { SlotExpireEnum.LeavesPlay }, nullEffect(), "Ingaitch").apply(selectSource()),
                                            layout = layoutCard(
                                                {
                                                    title = "Ingaitch the Ravenous",
													art = "art/epicart/mythic_monster",
                                                    xmlText=[[
<vlayout>
    <hlayout flexibleheight="6">
            <tmpro text="-1{shield}" fontsize="70" flexiblewidth="10" />
    </hlayout> 
</vlayout>
													]]
                                                }
                                            ),
                                                                                    }
                                    }
                                }
                        )),
					
                    }
                ),
				
			createAbility(
                    {
                        id = "demonologist_ingaitch_sac",
                        trigger = onLeavePlayTrigger,
                        cost = sacrificeSelfCost,
                        activations = multipleActivations,
                        effect = nullEffect()
					}	
                    
                )
            },
            layout = createLayout({
            name = "Ingaitch the Ravenous",
            art = "art/epicart/mythic_monster",
            frame = "frames/necromancer_frames/necromancer_item_cardframe",
            xmlText = [[
			<vlayout>
    <hlayout flexibleheight="3">
            <tmpro text="{expend}" fontsize="40" flexiblewidth="2"/>
            <icon text="{combat_7}" fontsize="40" flexiblewidth="10" />
    </hlayout>
<divider/>
    <hlayout flexibleheight="7">
            <tmpro text="When expended either:
-1{shield} or {health_-3}" fontsize="20" flexiblewidth="10" />
    </hlayout> 
</vlayout>
]],
					health = 7,
                    isGuard = false
        })
        }
    )
end


-- START Dark Summon SKILL
function demonologist_dark_summon_carddef()
    local cardLayout = createLayout({
        name = "Dark Summon",
        art = "art/epicart/dark_leader",
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
            <tmpro text="Summoned demons have 2{shield}." fontsize="20" />
        </box>
    </hlayout>
</vlayout>
		]]
    })

 return createSkillDef({
        id = "demonologist_dark_summon_skill",
        name = "Dark Summon",
        types = { skillType },
        layout = cardLayout,
        layoutPath = "art/epicart/dark_leader",
        abilities = {
            createAbility({
                id = "demonologist_dark_summon_ab",
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
					valueItem(1, createCardEffect(demonologist_giant_demonic_leech_carddef(), currentInPlayLoc)),
					valueItem(1, createCardEffect(demonologist_dark_succubus_carddef(), currentInPlayLoc)),
					valueItem(1, createCardEffect(demonologist_raging_fel_hound_carddef(), currentInPlayLoc))
})).seq(noUndoEffect()),
                                            layout = createLayout(
                {
                    name = "Giant Demonic Leech",
                    art = "art/t_wurm",
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
					health = 2,
                    isGuard = false
                }
            ),
                                            tags = {gainCombatTag}
                                        },
                                        
										{
                                           effect = hitSelfEffect(1).seq(randomEffect({
					valueItem(1, createCardEffect(demonologist_giant_demonic_leech_carddef(), currentInPlayLoc)),
					valueItem(1, createCardEffect(demonologist_dark_succubus_carddef(), currentInPlayLoc)),
					valueItem(1, createCardEffect(demonologist_raging_fel_hound_carddef(), currentInPlayLoc))
})).seq(noUndoEffect()),
                                            layout = createLayout(
                {
                    name = "Raging Fel Hound",
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
                    health = 2,
                    isGuard = false
                }
            ),
                                            tags = {gainCombatTag}
                                        },
										
										{
                                            effect = hitSelfEffect(1).seq(randomEffect({
					valueItem(1, createCardEffect(demonologist_giant_demonic_leech_carddef(), currentInPlayLoc)),
					valueItem(1, createCardEffect(demonologist_dark_succubus_carddef(), currentInPlayLoc)),
					valueItem(1, createCardEffect(demonologist_raging_fel_hound_carddef(), currentInPlayLoc))
})).seq(noUndoEffect()),
                                            layout = createLayout(
                {
                    name = "Dark Succubus",
                    art = "art/epicart/succubus",
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
                    health = 2,
                    isGuard = false
                }
            ),
                                                                                    }
                                    },
					upperTitle = "Randomly summon one of these 3 demon tokens into play.",
					lowerTitle = "Click any card to proceed."
					}),
				cost = goldCost(2),
			}),
        },
		layout = createLayout(
                {
                    name = "Dark Summon",
                    art = "art/epicart/dark_leader",
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
            <tmpro text="Summoned demons have 2{shield}." fontsize="20" />
        </box>
    </hlayout>
</vlayout>
					]]
                }
            )
        
    })
end
-- END Summon Demon Skill

function demonologist_giant_demonic_leech_carddef()
    return createChampionDef(
        {
            id = "demonologist_giant_demonic_leech",
            name = "Demonic leech",
			types = {minionType, championType, demonType, nostealType, tokenType},
            acquireCost = 0,
            health = 2,
            isGuard = false,
            abilities = {
                createAbility(
                    {
                        id = "giant_demonic_leech_main",
                        trigger = autoTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = hitOpponentEffect(1)
								.seq((grantHealthTarget(1, { SlotExpireEnum.LeavesPlay }, nullEffect(), "shadow")).apply(selectSource()))
                    }
                ),
				createAbility(
                    {
                        id = "giant_demonic_leech_explode",
                        trigger = startOfTurnTrigger,
                        cost = noCost,
                        activations = singleActivations,
                        effect = ifElseEffect(selectLoc(currentInPlayLoc).where(isCardSelf().And(getCardHealth().gte(6))).count().gte(1), 
							hitOpponentEffect(5).seq(sacrificeTarget().apply(selectSource())),
							nullEffect()), 
                    }),
					
				createAbility(
                    {
                        id = "giant_demonic_leech_sac",
                        trigger = onLeavePlayTrigger,
                        cost = sacrificeSelfCost,
                        activations = singleActivations,
                        effect = nullEffect()
					}	
                    
                )
            },
            layout = createLayout(
                {
                    name = "Giant Demonic Leech",
                    art = "art/epicart/sand_wurm",
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
					health = 2,
                    isGuard = false
                }
            )
        }
    )
end

function demonologist_raging_fel_hound_carddef()
--This is a token champion, that self-sacrifices when it leaves play
    return createChampionDef(
        {
            id = "demonologist_raging_fel_hound",
            name = "Raging Fel Hound",
			types = {minionType, championType, demonType, nostealType, tokenType},
            acquireCost = 0,
            health = 2,
            isGuard = false,
            abilities = {
			--base ability
                createAbility(
                    {
                        id = "raging_fel_hound_main",
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
                        id = "raging_fel_hound_sac",
                        trigger = onLeavePlayTrigger,
                        cost = sacrificeSelfCost,
                        activations = singleActivations,
                        effect = nullEffect()
					}	
                    
                )},
            layout = createLayout(
                {
                    name = "Raging Fel Hound",
                    art = "art/epicart/trihorror",
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
                    health = 2,
                    isGuard = false
                }
            )
        }
    )
end

function demonologist_dark_succubus_carddef()
    return createChampionDef(
        {
            id = "demonologist_dark_succubus",
            name = "Dark Succubus",
			types = {minionType, championType, demonType, nostealType, tokenType},
            acquireCost = 0,
            health = 2,
            isGuard = false,
            abilities = {
                createAbility(
                    {
                        id = "dark_succubus_main",
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
                        id = "dark_succubus_sac",
                        trigger = onLeavePlayTrigger,
                        cost = sacrificeSelfCost,
                        activations = singleActivations,
                        effect = nullEffect()
					}	
                    
                )},
            layout = createLayout(
                {
                    name = "Dark Succubus",
                    art = "art/epicart/mirage_wielder",
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
                    health = 2,
                    isGuard = false
                }
            )
        }
    )
end

-- START Void sentinel CARD
function demonologist_void_sentinel_carddef()
    return createChampionDef(
        {
            id = "demonologist_void_sentinel",
            name = "Void Sentinel",
			types = {minionType, championType, demonType, nosteaalType},
            acquireCost = 0,
            health = 2,
            isGuard = true,
            abilities = {
                createAbility(
                    {
                        id = "void_sentinel_main",
                        trigger = autoTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = gainCombatEffect(1)
						
                    }
                ),
				createAbility(
                    {
                        id = "void_sentinel_combo",
                        trigger = uiTrigger,
                        cost = noCost,
                        activations = singleActivations,
						check = selectLoc(loc(currentPid, inPlayPloc)).where(isCardType("minion")).count().gte(3),
                        effect = hitOpponentEffect(3)
						
                    }
                ),
            },
            layout = createLayout(
                {
                    name = "Void Sentinel",
                    art = "art/epicart/dark_knight",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
    <hlayout flexibleheight="1">
            <tmpro text="{expend}" fontsize="40" flexiblewidth="2"/>
            <text text="{combat_1}"
fontsize="40" flexiblewidth="10" />
    </hlayout>
    <divider/>
    <hlayout flexibleheight="3">
            <tmpro text="If you have 2 other demon minions in play, deal 3 damage to target opponent." fontsize="20" flexiblewidth="8" />
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
-- END Void sentinel CARD
	
-- START Devourer CARD
function demonologist_devourer_carddef()
    return createChampionDef(
        {
            id = "demonologist_devourer",
            name = "Devourer",
			types = {minionType, championType, demonType, nostealType},
            acquireCost = 0,
            health = 2,
            isGuard = true,
            abilities = {
                createAbility(
                    {
                        id = "devourer_main",
                        trigger = uiTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = gainCombatEffect(1).seq(hitSelfEffect(1).seq(grantHealthTarget(1, { SlotExpireEnum.LeavesPlay }, nullEffect(), "shadow").apply(selectSource()))),
                    }
                ),
				createAbility(
                    {
                        id = "devourer_leaveplay",
                        trigger = onLeavePlayTrigger,
						cost= noCost,
                        activations = singleActivations,
                        effect = gainHealthEffect(2),
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Devourer",
                    art = "art/epicart/thrasher_demon",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText = [[
<vlayout>
    <hlayout flexibleheight="3">
            <tmpro text="{expend}" fontsize="40" flexiblewidth="2"/>
            <tmpro text="{health_-1} {combat_1}
Devourer gains +1{shield} until it leaves play." fontsize="21" flexiblewidth="10" />
    </hlayout>
    <divider/>
    <hlayout flexibleheight="2">
            <tmpro text="If Devourer leaves play gain {health_2} at the start of your turn." fontsize="21" flexiblewidth="10" />
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
-- END Devourer CARD


-- START Fel Summon
function demonologist_fel_summon_carddef()
    local cardLayout = createLayout({
        name = "Fel Summon",
        art = "art/epicart/corpsemonger",
        frame = "frames/necromancer_frames/necromancer_item_cardframe",
		xmlText=[[
		<vlayout>
    <hlayout flexibleheight="2">
        <box flexiblewidth="1">
            <tmpro text="{expend_2}" fontsize="62"/>
        </box>
        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="&lt;size=130%&gt;{health_-1} &lt;size=100%&gt;Draw 1.
Randomly summon 1 of 3 demon tokens into play." fontsize="20" />
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
        id = "demonologist_fel_summon_skill",
        name = "Summon Demon",
        types = { skillType },
        layout = cardLayout,
        layoutPath = "art/epicart/corpsemonger",
        abilities = {
            createAbility({
                id = "demonologist_fel_summon_demon_ab",
                trigger = uiTrigger,
				check = minHealthCurrent(2),
                activations = singleActivation,
                layout = cardLayout,
                promptType = showPrompt,
                effect =pushChoiceEffectWithTitle(
                                {
                                    choices = {
                                        {
                                            effect = hitSelfEffect(1)
											.seq(randomEffect({
					valueItem(1, createCardEffect(demonologist_demonic_leech_carddef(), currentInPlayLoc)),
					valueItem(1, createCardEffect(demonologist_succubus_carddef(), currentInPlayLoc)),
					valueItem(1, createCardEffect(demonologist_fel_hound_carddef(), currentInPlayLoc))
})).seq(noUndoEffect()).seq(drawCardsEffect(1)),
                                            layout = createLayout(
                {
                    name = "Demonic leech",
                    art = "art/t_wurm",
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
                                           effect = hitSelfEffect(1)
										   .seq(randomEffect({
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
                                            effect = hitSelfEffect(1)
											.seq(randomEffect({
					valueItem(1, createCardEffect(demonologist_demonic_leech_carddef(), currentInPlayLoc)),
					valueItem(1, createCardEffect(demonologist_succubus_carddef(), currentInPlayLoc)),
					valueItem(1, createCardEffect(demonologist_fel_hound_carddef(), currentInPlayLoc))
})).seq(noUndoEffect()),
                                            layout = createLayout(
                {
                    name = "Succubus",
                    art = "art/epicart/succubus",
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
					upperTitle = "Summon one of these 3 demon tokens, randomly. Then draw a card.",
					lowerTitle = "Click any card to proceed."
					})
					.seq(drawCardsEffect(1)),
				cost = goldCost(2),
			}),
        },
		layout = createLayout(
                {
                    name = "Fel Summon",
                    art = "art/epicart/corpsemonger",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
    <hlayout flexibleheight="2">
        <box flexiblewidth="1">
            <tmpro text="{expend_2}" fontsize="62"/>
        </box>
        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="&lt;size=130%&gt;{health_-1} &lt;size=100%&gt;Draw 1.
Randomly summon 1 of 3 demon tokens into play." fontsize="20" />
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


-- START Infernal Summon SKILL
function demonologist_infernal_summon_carddef()
    local cardLayout = createLayout({
        name = "Infernal Summon",
        art = "art/epicart/abyss_summoner",
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
            <tmpro text="Summoned demons have
2{shield} and +{combat_1}." fontsize="20" />
        </box>
    </hlayout>
</vlayout>
		]]
    })

 return createSkillDef({
        id = "demonologist_infernal_summon_skill",
        name = "Infernal Summon",
        types = { skillType },
        layout = cardLayout,
        layoutPath = "art/epicart/abyss_summoner",
        abilities = {
            createAbility({
                id = "demonologist_infernal_summon_ab",
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
					valueItem(1, createCardEffect(demonologist_demonic_tyrant_leech_carddef(), currentInPlayLoc)),
					valueItem(1, createCardEffect(demonologist_succubus_queen_carddef(), currentInPlayLoc)),
					valueItem(1, createCardEffect(demonologist_flaming_fel_hound_carddef(), currentInPlayLoc))
})).seq(noUndoEffect()),
                                            layout = createLayout(
                {
                    name = "Demonic Tyrant Leech",
                    art = "art/epicart/rampaging_wurm",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
					xmlText = [[
<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{expend}" fontsize="40"/>
        </box>
        <box flexiblewidth="7">
            <tmpro text="&lt;size=130%&gt;{combat_1} &lt;size=100%&gt;Deal 1 damage to opponent. Demonic Leech gains 1{shield} until it leaves play. " fontsize="18"/>

</box>
</hlayout>

<divider/>
<hlayout flexibleheight="1">
        <box flexiblewidth="7">
            <tmpro text="Explode: If this card has 7{shield} or more at the start of a turn, immediately deal 5 damage to opponent and sacrifice this card. " fontsize="16"/>
</box>
</hlayout>
</vlayout>
					]],
					health = 2,
                    isGuard = false
                }
            ),
                                            tags = {gainCombatTag}
                                        },
                                        
										{
                                           effect = hitSelfEffect(1).seq(randomEffect({
					valueItem(1, createCardEffect(demonologist_demonic_tyrant_leech_carddef(), currentInPlayLoc)),
					valueItem(1, createCardEffect(demonologist_succubus_queen_carddef(), currentInPlayLoc)),
					valueItem(1, createCardEffect(demonologist_flaming_fel_hound_carddef(), currentInPlayLoc))
})).seq(noUndoEffect()),
                                            layout = createLayout(
                {
                    name = "Flaming Fel Hound",
                    art = "art/epicart/scarros__hound_of_draka",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{expend}" fontsize="40"/>
        </box>
        <box flexiblewidth="7">
            <icon text="{combat_3}" fontsize="60"/>
</box>
</hlayout>
</vlayout>
					]],
                    health = 3,
                    isGuard = false
                }
            ),
                                            tags = {gainCombatTag}
                                        },
										
										{
                                            effect = hitSelfEffect(1).seq(randomEffect({
					valueItem(1, createCardEffect(demonologist_demonic_tyrant_leech_carddef(), currentInPlayLoc)),
					valueItem(1, createCardEffect(demonologist_succubus_queen_carddef(), currentInPlayLoc)),
					valueItem(1, createCardEffect(demonologist_flaming_fel_hound_carddef(), currentInPlayLoc))
})).seq(noUndoEffect()),
                                            layout = createLayout(
                {
                    name = "Succubus Queen",
                    art = "art/epicart/drain_essence",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{expend}" fontsize="40"/>
        </box>
        <box flexiblewidth="7">
            <tmpro text="&lt;size=130%&gt;{combat_1}
&lt;size=100%&gt;Give target champion -1{shield} permanently.
&lt;size=50%&gt;
&lt;size=70%&gt;(Cannot reduce below 1{shield}.)" fontsize="25"/>
</box>
</hlayout>
<box flexiblewidth="7">
            <tmpro text="" fontsize="18"/>
</box>
</vlayout>
					]],
                    health = 2,
                    isGuard = false
                }
            ),
                                                                                    }
                                    },
					upperTitle = "Randomly summon one of these 3 demon tokens into play.",
					lowerTitle = "Click any card to proceed."
					}),
				cost = goldCost(2),
			}),
        },
		layout = createLayout(
                {
                    name = "Infernal Summon",
                    art = "art/epicart/abyss_summoner",
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
            <tmpro text="Summoned demons have
2{shield} and +{combat_1}." fontsize="20" />
        </box>
    </hlayout>
</vlayout>
					]]
                }
            )
        
    })
end

function demonologist_demonic_tyrant_leech_carddef()
    return createChampionDef(
        {
            id = "demonologist_demonic_tyrant_leech",
            name = "Demonic Tyrant Leech",
			types = {minionType, championType, demonType, nostealType, tokenType},
            acquireCost = 0,
            health = 2,
            isGuard = false,
            abilities = {
                createAbility(
                    {
                        id = "giant_demonic_leech_main",
                        trigger = autoTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = hitOpponentEffect(1).seq(gainCombatEffect(1))
								.seq((grantHealthTarget(1, { SlotExpireEnum.LeavesPlay }, nullEffect(), "shadow")).apply(selectSource()))
                    }
                ),
				createAbility(
                    {
                        id = "demonic_tyrant_leech_explode",
                        trigger = startOfTurnTrigger,
                        cost = noCost,
                        activations = singleActivations,
                        effect = ifElseEffect(selectLoc(currentInPlayLoc).where(isCardSelf().And(getCardHealth().gte(6))).count().gte(1), 
							hitOpponentEffect(5).seq(sacrificeTarget().apply(selectSource())),
							nullEffect()), 
                    }),
					
				createAbility(
                    {
                        id = "demonic_tyrant_leech_sac",
                        trigger = onLeavePlayTrigger,
                        cost = sacrificeSelfCost,
                        activations = singleActivations,
                        effect = nullEffect()
					}	
                    
                )
            },
            layout = createLayout(
                {
                    name = "Demonic Tyrant Leech",
                    art = "art/epicart/rampaging_wurm",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
					xmlText = [[
<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{expend}" fontsize="40"/>
        </box>
        <box flexiblewidth="7">
            <tmpro text="&lt;size=130%&gt;{combat_1} &lt;size=100%&gt;Deal 1 damage to opponent. Demonic Leech gains 1{shield} until it leaves play. " fontsize="18"/>

</box>
</hlayout>

<divider/>
<hlayout flexibleheight="1">
        <box flexiblewidth="7">
            <tmpro text="Explode: If this card has 7{shield} or more at the start of a turn, immediately deal 5 damage to opponent and sacrifice this card. " fontsize="16"/>
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

function demonologist_flaming_fel_hound_carddef()
--This is a token champion, that self-sacrifices when it leaves play
    return createChampionDef(
        {
            id = "demonologist_raging_fel_hound",
            name = "Raging Fel Hound",
			types = {minionType, championType, demonType, nostealType, tokenType},
            acquireCost = 0,
            health = 2,
            isGuard = false,
            abilities = {
			--base ability
                createAbility(
                    {
                        id = "flaming_fel_hound_main",
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
                        id = "flaming_fel_hound_sac",
                        trigger = onLeavePlayTrigger,
                        cost = sacrificeSelfCost,
                        activations = singleActivations,
                        effect = nullEffect()
					}	
                    
                )},
            layout = createLayout(
                {
                    name = "Flaming Fel Hound",
                    art = "art/epicart/scarros__hound_of_draka",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{expend}" fontsize="40"/>
        </box>
        <box flexiblewidth="7">
            <icon text="{combat_3}" fontsize="60"/>
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

function demonologist_succubus_queen_carddef()
    return createChampionDef(
        {
            id = "demonologist_succubus_queen",
            name = "Succubus Queen",
			types = {minionType, championType, demonType, nostealType, tokenType},
            acquireCost = 0,
            health = 2,
            isGuard = false,
            abilities = {
                createAbility(
                    {
                        id = "succubus_queen_main",
                        trigger = uiTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = gainCombatEffect(1).seq(pushTargetedEffect({
                                                desc = "Give target champion -1<sprite name=\"shield\"> permanently.",
                                                validTargets = oppStunnableSelector().where(isCardChampion().And(getCardHealth().gte(2))),
                                                min = 0,
                                                max = 1,
                                                targetEffect = (grantHealthTarget(-1, { SlotExpireEnum.never }, nullEffect(), "shadow")),
                                                })),
														
                    }
                )
            ,
			--self-sac ability
                createAbility(
                    {
                        id = "succubus_queen_sac",
                        trigger = onLeavePlayTrigger,
                        cost = sacrificeSelfCost,
                        activations = singleActivations,
                        effect = nullEffect()
					}	
                    
                )},
            layout = createLayout(
                {
                    name = "Succubus Quuen",
                    art = "art/epicart/drain_essence",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{expend}" fontsize="40"/>
        </box>
        <box flexiblewidth="7">
            <tmpro text="&lt;size=130%&gt;{combat_1}
&lt;size=100%&gt;Give target champion -1{shield} permanently.
&lt;size=50%&gt;
&lt;size=70%&gt;(Cannot reduce below 1{shield}.)" fontsize="25"/>
</box>
</hlayout>
<box flexiblewidth="7">
            <tmpro text="" fontsize="18"/>
</box>
</vlayout>
					]],
                    health = 2,
                    isGuard = false
                }
            )
        }
    )
end

-- START Malevolent Summon SKILL
function demonologist_malevolent_summon_carddef()
    local cardLayout = createLayout({
        name = "Malevolent Summon",
        art = "icons/the_summoning",
        frame = "frames/necromancer_frames/necromancer_item_cardframe",
		xmlText=[[
<vlayout>
    <hlayout flexibleheight="2">
        <box flexiblewidth="1">
            <tmpro text="{expend_2}" fontsize="62"/>
        </box>
        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="&lt;size=130%&gt;{health_-1} &lt;size=100%&gt;Draw 1.
Randomly summon 1 of 3 demon tokens into play." fontsize="20" />
            </box>
        </vlayout>
    </hlayout>
    <divider/>
    <hlayout flexibleheight="1">
        <box flexiblewidth="7">
            <tmpro text="Summoned demons have 2{shield}." fontsize="20" />
        </box>
    </hlayout>
</vlayout>
		]]
    })

 return createSkillDef({
        id = "demonologist_malevolent_summon_skill",
        name = "Malevolent Summon",
        types = { skillType },
        layout = cardLayout,
        layoutPath = "art/epicart/rift_summoner",
        abilities = {
            createAbility({
                id = "demonologist_malevolent_summon_ab",
                trigger = uiTrigger,
				check = minHealthCurrent(2),
                activations = singleActivation,
                layout = cardLayout,
                promptType = showPrompt,
                effect =pushChoiceEffectWithTitle(
                                {
                                    choices = {
                                        {
                                            effect = hitSelfEffect(1)
											.seq(randomEffect({
					valueItem(1, createCardEffect(demonologist_giant_demonic_leech_carddef(), currentInPlayLoc)),
					valueItem(1, createCardEffect(demonologist_dark_succubus_carddef(), currentInPlayLoc)),
					valueItem(1, createCardEffect(demonologist_raging_fel_hound_carddef(), currentInPlayLoc))
})).seq(noUndoEffect()),
                                            layout = createLayout(
                {
                    name = "Giant Demonic Leech",
                    art = "art/epicart/sand_wurm",
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
					health = 2,
                    isGuard = false
                }
            ),
                                            tags = {gainCombatTag}
                                        },
                                        
										{
                                           effect = hitSelfEffect(1)
										   .seq(randomEffect({
					valueItem(1, createCardEffect(demonologist_giant_demonic_leech_carddef(), currentInPlayLoc)),
					valueItem(1, createCardEffect(demonologist_dark_succubus_carddef(), currentInPlayLoc)),
					valueItem(1, createCardEffect(demonologist_raging_fel_hound_carddef(), currentInPlayLoc))
})).seq(noUndoEffect()),
                                            layout = createLayout(
                {
                    name = "Raging Fel Hound",
                    art = "art/epicart/trihorror",
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
                    health = 2,
                    isGuard = false
                }
            ),
                                            tags = {gainCombatTag}
                                        },
										
										{
                                            effect = hitSelfEffect(1)
											.seq(randomEffect({
					valueItem(1, createCardEffect(demonologist_giant_demonic_leech_carddef(), currentInPlayLoc)),
					valueItem(1, createCardEffect(demonologist_dark_succubus_carddef(), currentInPlayLoc)),
					valueItem(1, createCardEffect(demonologist_raging_fel_hound_carddef(), currentInPlayLoc))
})).seq(noUndoEffect()),
                                            layout = createLayout(
                {
                    name = "Dark Succubus",
                    art = "art/epicart/mirage_wielder",
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
                    health = 2,
                    isGuard = false
                }
            ),
                                                                                    }
                                    },
					upperTitle = "Randomly summon one of these 3 demon tokens into play.",
					lowerTitle = "Click any card to proceed."
					})
					.seq(drawCardsEffect(1))
					,
				cost = goldCost(2),
			}),
        },
		layout = createLayout(
                {
                    name = "Malevolent Summon",
                    art = "art/epicart/rift_summoner",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
    <hlayout flexibleheight="2">
        <box flexiblewidth="1">
            <tmpro text="{expend_2}" fontsize="62"/>
        </box>
        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="&lt;size=130%&gt;{health_-1} &lt;size=100%&gt;Draw 1.
Randomly summon 1 of 3 demon tokens into play." fontsize="20" />
            </box>
        </vlayout>
    </hlayout>
    <divider/>
    <hlayout flexibleheight="1">
        <box flexiblewidth="7">
            <tmpro text="Summoned demons have 2{shield}." fontsize="20" />
        </box>
    </hlayout>
</vlayout>
					]]
                }
            )
        
    })
end


-- START Sinister Summon
function demonologist_sinister_summon_carddef()
    local cardLayout = createLayout({
        name = "Sinister Summon",
        art = "icons/the_summoning",
        frame = "frames/necromancer_frames/necromancer_item_cardframe",
		xmlText=[[
		<vlayout>
    <hlayout flexibleheight="2">
        <box flexiblewidth="1">
            <tmpro text="{expend_2}" fontsize="62"/>
        </box>
        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="&lt;size=130%&gt;{health_1} &lt;size=100%&gt;Draw 1.
Randomly summon 1 of 3 demon tokens into play." fontsize="20" />
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
        id = "demonologist_sinister_summon_skill",
        name = "Summon Demon",
        types = { skillType },
        layout = cardLayout,
        layoutPath = "art/epicart/infernal_gatekeeper",
        abilities = {
            createAbility({
                id = "demonologist_sinister_summon_demon_ab",
                trigger = uiTrigger,
				check = minHealthCurrent(2),
                activations = singleActivation,
                layout = cardLayout,
                promptType = showPrompt,
                effect =pushChoiceEffectWithTitle(
                                {
                                    choices = {
                                        {
                                            effect = gainHealthEffect(1).seq(randomEffect({
					valueItem(1, createCardEffect(demonologist_demonic_leech_carddef(), currentInPlayLoc)),
					valueItem(1, createCardEffect(demonologist_succubus_carddef(), currentInPlayLoc)),
					valueItem(1, createCardEffect(demonologist_fel_hound_carddef(), currentInPlayLoc))
})).seq(noUndoEffect()),
                                            layout = createLayout(
                {
                    name = "Demonic leech",
                    art = "art/t_wurm",
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
                                           effect = gainHealthEffect(1).seq(randomEffect({
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
                                            effect = gainHealthEffect(1).seq(randomEffect({
					valueItem(1, createCardEffect(demonologist_demonic_leech_carddef(), currentInPlayLoc)),
					valueItem(1, createCardEffect(demonologist_succubus_carddef(), currentInPlayLoc)),
					valueItem(1, createCardEffect(demonologist_fel_hound_carddef(), currentInPlayLoc))
})).seq(noUndoEffect()),
                                            layout = createLayout(
                {
                    name = "Succubus",
                    art = "art/epicart/succubus",
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
					upperTitle = "Summon one of these 3 demon tokens, randomly. Then draw a card.",
					lowerTitle = "Click any card to proceed."
					})
					.seq(drawCardsEffect(1)),
				cost = goldCost(2),
			}),
        },
		layout = createLayout(
                {
                    name = "Sinister Summon",
                    art = "art/epicart/infernal_gatekeeper",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
    <hlayout flexibleheight="2">
        <box flexiblewidth="1">
            <tmpro text="{expend_2}" fontsize="62"/>
        </box>
        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="&lt;size=130%&gt;{health_1} &lt;size=100%&gt;Draw 1.
Randomly summon 1 of 3 demon tokens into play." fontsize="20" />
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


function demonologist_grimoire_carddef()
    return createDef(
        {
            id = "demonologist_grimoire",
            name = "Grimoire",
            types = {noStealType, itemType, noPlayType},
            acquireCost = 0,
            cardTypeLabel = "Item",
            playLocation = castPloc,
            abilities = {
                createAbility(
                    {
                        id = "demonologist_grimoire",
                        layout = cardLayout,
                        effect = gainHealthEffect((selectLoc(loc(currentPid, inPlayPloc)).where(isCardType("Minion"))).count()).seq(drawCardsEffect(1)),
                        trigger = autoTrigger,
                        tags = {}
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Grimoire",
                    art = "art/t_evangelize",
                    frame = "frames/wizard_cardframe",
                    xmlText=[[
					<vlayout>
    <hlayout flexibleheight="2">
<vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="
Draw a card.

Gain {health_1} for each demon minion already in play." fontsize="24" />
            </box>
        </vlayout>
    </hlayout>

</vlayout>
					]],
                }
            )
        }
    )
end

function demonologist_scroll_of_summoning_carddef()
    return createDef(
        {
            id = "demonologist_sos",
            name = "Scroll of Summoning",
            types = {noStealType, itemType, noPlayType},
            acquireCost = 0,
            cardTypeLabel = "Item",
            playLocation = castPloc,
            abilities = {
                createAbility(
                    {
                        id = "demonologist_sos",
                        layout = cardLayout,
                        effect = pushChoiceEffectWithTitle(
                                {
                                    choices = {
                                        {
                                            effect = createCardEffect(demonologist_demonic_leech_carddef(), currentInPlayLoc),
                                            layout = createLayout(
                {
                    name = "Demonic leech",
                    art = "art/t_wurm",
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
                                           effect = createCardEffect(demonologist_fel_hound_carddef(), currentInPlayLoc),
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
                                            effect = createCardEffect(demonologist_succubus_carddef(), currentInPlayLoc),
                                            layout = createLayout(
                {
                    name = "Succubus",
                    art = "art/epicart/succubus",
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
					upperTitle = "Choose one of these 3 demon tokens to summon.",
					lowerTitle = "Click the card you want to summon."
					})
					.seq(drawCardsEffect(1)),
                        trigger = autoTrigger,
                        tags = {}
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Scroll of Summoning",
                    art = "art/treasures/t_magic_scroll_souveraine",
                    frame = "frames/wizard_cardframe",
                    xmlText=[[
					<vlayout>
    <hlayout flexibleheight="2">
<vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="Choose 1 of the 3 basic (1{shield}) demon minion tokens to put into play.
Draw 1." fontsize="24" />
            </box>
        </vlayout>
    </hlayout>
</vlayout>
					]]
				}
            )
        }
    )
end

function demonologist_flawless_shadow_gem_carddef()
    return createDef(
        {
            id = "demonologist_flawless_shadow_gem",
            name = "Flawless Shadow Gem",
            types = {gemType, noStealType, itemType},
			            acquireCost = 0,
            cardTypeLabel = "Item",
            playLocation = castPloc,
            abilities = {
				createAbility(
                    {
                        id = "demonologist_flawless_shadow_gem_sac",
						cost = noCost,
						trigger = autoTrigger,
                        activations = singleActivations,
						                        effect = gainGoldEffect(2),
                        tags = {}
                    }
                ),
				
				createAbility(
                    {
                        id = "demonologist_flawless_shadow_gem_buff",
						cost = noCost,
						trigger = uiTrigger,
                        activations = singleActivations,
						                        effect = pushTargetedEffect({
												desc = "Give one minion +2 <sprite name=\"shield\"> until your next turn.",
												validTargets = selectLoc(currentInPlayLoc).where(isCardType(minionType)),
												min = 0,
												max = 1,
												targetEffect = grantHealthTarget(2, { SlotExpireEnum.startOfOwnerTurn }, nullEffect(), "shadow"),
												}),
                        tags = {}
                    }
                ),

            },
            layout = createLayout(
                {
                    name = "Flawless Shadow Gem",
                    art = "art/treasures/thief_brillant_ruby",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
    <box flexibleheight="2">
        <tmpro text="{gold_2}" fontsize="42"/>
    </box>
    <box flexibleheight="3">
        <tmpro text="{health_-1} Give one minion +2{shield} until your next turn." fontsize="24" />
    </box>
</vlayout>
					]]
                }
            )
        }
    )
end

function demonologist_butcherclaw_carddef()
    return createChampionDef(
        {
            id = "demonologist_butcherclaw",
            name = "Butcherclaw",
			types = {championType, demonType, minionType, nostealType},
            acquireCost = 0,
            health = 2,
            isGuard = false,
            abilities = {
            createAbility(
                    {
                        id = "demonologist_butcherclaw_main",
                        trigger = autoTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = gainCombatEffect(2),
                    }
                ),
   				
			createAbility(
                    {
                        id = "demonologist_butcherclaw_spike",
                        trigger = uiTrigger,
                        activations = singleActivations,
						prompt = showPrompt,
                        effect = pushTargetedEffect({
                    desc = "Sacrifice a champion in your discard pile. Sprout a spike equal to its cost.",
                    validTargets = selectLoc(loc(currentPid, discardPloc)).where(isCardChampion().And(getCardCost().gte(1))),
                    min = 1,
                    max = 1,
                    targetEffect = moveTarget(loc(currentPid, asidePloc))
					.seq(incrementCounterEffect("black_spike_guard", selectLoc(loc(currentPid, asidePloc)).take(1).sum(getCardCost())))
						.seq(sacrificeTarget().apply(selectLoc(loc(currentPid, asidePloc))))
                        .seq(createCardEffect(demonologist_spike_carddef(), revealLoc))
                        .seq(grantHealthTarget(getCounter("black_spike_guard")).apply(selectLoc(revealLoc)))
                        .seq(moveTarget(currentInPlayLoc).apply(selectLoc(revealLoc)))
                        .seq(resetCounterEffect("black_spike_guard"))
            })
					
						
						,
					check = selectLoc(loc(currentPid, discardPloc)).where(isCardChampion()).count().gte(1)	
					
                    }
                ),
				
            },
            layout = createLayout({
            name = "Butcherclaw",
            art = "icons/slaughterclaw",
            frame = "frames/necromancer_frames/necromancer_item_cardframe",
            xmlText = [[
			<vlayout>
    <hlayout flexibleheight="0.2">
            <tmpro text="{expend}" fontsize="40" flexiblewidth="2"/>
            <icon text="{combat_2}" fontsize="40" flexiblewidth="10" />
    </hlayout>
<divider/>
    <hlayout flexibleheight="7">
            <tmpro text="Once per turn, you may sacrifice a champion in your discard pile to sprout a spike equal to its cost." fontsize="20" flexiblewidth="10" />
    </hlayout> 
</vlayout>
]],
					health = 2,
                    isGuard = false
        })
        }
    )
end

function demonologist_spike_carddef()
    return createChampionDef(
        {
            id = "demonologist_spike",
            name = "Spike",
			types = {championType, demonType, nostealType, tokenType},
            acquireCost = 0,
            health = 0,
            isGuard = false,
            abilities = {
                createAbility(
                    {
                        id = "spike_main",
                        trigger = autoTrigger,
                        cost = expendCost,
                        activations = singleActivations,
                        effect = gainCombatEffect(selectSource().sum(getCardHealth()))
                    }
                ),
					
				createAbility(
                    {
                        id = "spike_sac",
                        trigger = onLeavePlayTrigger,
                        cost = sacrificeSelfCost,
                        activations = singleActivations,
                        effect = hitSelfEffect(2)
					}	
                    
                )
            },
            layout = createLayout(
                {
                    name = "Spike",
                    art = "features/warinthewild/slaughterclaw_spike",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
					xmlText = [[
<vlayout>
    <hlayout flexibleheight="3">
            <tmpro text="{expend}" fontsize="50" flexiblewidth="2"/>
            <tmpro text="Gain {combat} equal to this Spike’s {shield}" fontsize="22" flexiblewidth="12" />
    </hlayout>
    <divider/>
    <hlayout flexibleheight="2">
            <tmpro text="When this leaves play, deal 2 damage to opponent." fontsize="20" flexiblewidth="10" />
    </hlayout> 
</vlayout>
					]],
					health = 0,
                    isGuard = false
                }
            )
        }
    )
end

function demonologist_summon_demon_ability_carddef()
    local cardLayout = createLayout({
        name = "Summon Demon Minion",
        art = "icons/the_summoning",
        frame = "frames/necromancer_frames/necromancer_item_cardframe",
		xmlText=[[
		<vlayout>
    <hlayout flexibleheight="2">
        <box flexiblewidth="1">
            <tmpro text="{scrap}" fontsize="35"/>
        </box>
        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="Randomly summon 1 of 3 demon tokens into play." fontsize="20" />
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
        id = "demonologist_summon_demon_ability",
        name = "Summon Demon Minion",
        types = { abilityType },
        layout = cardLayout,
        layoutPath = "icons/the_summoning",
        abilities = {
            createAbility({
                id = "demonologist_summon_demon_minion_ab",
                trigger = uiTrigger,
                activations = singleActivation,
                layout = cardLayout,
                promptType = showPrompt,
                effect =pushChoiceEffectWithTitle(
                                {
                                    choices = {
                                        {
                                            effect = randomEffect({
					valueItem(1, createCardEffect(demonologist_demonic_leech_carddef(), currentInPlayLoc)),
					valueItem(1, createCardEffect(demonologist_succubus_carddef(), currentInPlayLoc)),
					valueItem(1, createCardEffect(demonologist_fel_hound_carddef(), currentInPlayLoc))
}).seq(noUndoEffect()),
                                            layout = createLayout(
                {
                    name = "Demonic leech",
                    art = "art/t_wurm",
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
                                           effect = randomEffect({
					valueItem(1, createCardEffect(demonologist_demonic_leech_carddef(), currentInPlayLoc)),
					valueItem(1, createCardEffect(demonologist_succubus_carddef(), currentInPlayLoc)),
					valueItem(1, createCardEffect(demonologist_fel_hound_carddef(), currentInPlayLoc))
}).seq(noUndoEffect()),
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
                                            effect = randomEffect({
					valueItem(1, createCardEffect(demonologist_demonic_leech_carddef(), currentInPlayLoc)),
					valueItem(1, createCardEffect(demonologist_succubus_carddef(), currentInPlayLoc)),
					valueItem(1, createCardEffect(demonologist_fel_hound_carddef(), currentInPlayLoc))
}).seq(noUndoEffect()),
                                            layout = createLayout(
                {
                    name = "Succubus",
                    art = "art/epicart/succubus",
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
				cost = sacrificeSelfCost,
			}),
        },
		layout = createLayout(
                {
                    name = "Summon Demon Minion",
                    art = "icons/the_summoning",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
					<vlayout>
    <hlayout flexibleheight="2">
        <box flexiblewidth="1">
            <tmpro text="{scrap}" fontsize="35"/>
        </box>
        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="Randomly summon 1 of 3 demon tokens into play." fontsize="20" />
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

function demonologist_demonic_amulet_carddef()

 local cardLayout = createLayout({
        name = "Demonic Amulet",
        art = "art/t_wizard_silverskull_amulet",
        frame = "frames/necromancer_frames/necromancer_item_cardframe",
        xmlText=[[
					
<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{requiresHealth_35}" fontsize="72"/>
        </box>
        <box flexiblewidth="5">
            <tmpro text="If you have a demon minion token in play gain {health_2}." fontsize="28" />
        </box>
    </hlayout>
</vlayout>
					]]
    })
	
    return createMagicArmorDef(
        {
            id = "demonologist_demonic_amulet",
            name = "Demonic Amulet",
            types = {magicArmorType, noStealType, itemType},
			            acquireCost = 0,
            cardTypeLabel = "Armour",
			layout = cardLayout,
			layoutPath  = "icons/wizard_pure_channel",
            playLocation = castPloc,
            abilities = {
				createAbility(
                    {
                        id = "demonologist_demonic_amulet",
						cost = expendCost,
						trigger = autoTrigger,
						promptType = showPrompt,
						layout = cardLayout,
                        activations = singleActivations,
						effect = gainHealthEffect(2),
						check= minHealthCurrent(35)
						.And(selectLoc(loc(currentPid, inPlayPloc)).where(isCardType(demonType).And(isCardType(tokenType))).count().gte(1)),
                        tags = {}
                    }
                ),
	
            },
            
			
        }
    )
end

function demonologist_summoner_s_robes_carddef()

 local cardLayout = createLayout({
        name = "Summoner's Robes",
        art = "art/t_wizard_runic_robes",
        frame = "frames/necromancer_frames/necromancer_item_cardframe",
        xmlText=[[
					<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{requiresHealth_35}" fontsize="72"/>
        </box>
        <box flexiblewidth="5">
            <tmpro text="{health_-2}
&lt;size=70%&gt;Your skill costs 1{gold} less this turn." fontsize="40" />
        </box>
    </hlayout>
</vlayout>
					]]
    })
	
    return createMagicArmorDef(
        {
            id = "demonologist_summoner_s_robes",
            name = "Demonic Amulet",
            types = {magicArmorType, noStealType, itemType},
			            acquireCost = 0,
            cardTypeLabel = "Armour",
			layout = cardLayout,
			layoutPath  = "icons/wizard_runic_robes",
            playLocation = castPloc,
            abilities = {
				createAbility(
                    {
                        id = "demonologist_summoner_s_robes",
						cost = expendCost,
						trigger = uiTrigger,
						promptType = showPrompt,
						layout = cardLayout,
                        activations = singleActivations,
						effect = gainHealthEffect(-2).seq(addSlotToPlayerEffect(controllerPid, createPlayerIntExpressionSlot(skillCostModKey, toIntExpression(-1), { endOfTurnExpiry }))),
						check= minHealthCurrent(25),
                        tags = {}
                    }
                ),
	
            },
            
			
        }
    )
end


-- Pyromancer cards  -----------------------------------------------------------------------------------------------------------------------
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
                    frame = "frames/wizard_cardframe",
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
                    frame = "frames/wizard_cardframe",
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
            id = "pyromancer_scorch",
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
                    frame = "frames/wizard_cardframe",
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
                                                    art = "art/treasures/thief_sharpened_ruby",
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
                                                    art = "art/treasures/thief_sharpened_ruby",
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
                    art = "art/treasures/thief_sharpened_ruby",
                    frame = "frames/wizard_cardframe",
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
                    <tmpro text={0}{combat} &lt;size=70%&gt;Flip your skill.

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

function pyromancer_explode_carddef()
    return createDef(
        {
            id = "Pyromancer_Explode",
            name = "explode",
            types = {noStealType, actionType},
            acquireCost = 0,
            cardTypeLabel = "Action",
            playLocation = castPloc,
            abilities = {
                createAbility({
                        id="Pyromancer_explode_combat",
						trigger= autoTrigger,
						effect = gainCombatEffect(3)
                    }),
			createAbility({
                id="Pyromancer_explode_FGsac",
                trigger= autoTrigger,
				activations = singleActivations,
				check = selectLoc(loc(currentPid, castPloc)).union(selectLoc(loc(currentPid, discardPloc))).where(isCardName("fire_gem")).count().gte(1),
                effect = gainCombatEffect(2)

            })
            },
            layout = createLayout(
                {
                    name = "Explode",
                    art = "art/epicart/zaltessa_s_fire",
                    frame = "frames/wizard_cardframe",
                    xmlText=[[
<vlayout>
    <box flexibleheight="1">
        <tmpro text="{combat_3}" fontsize="42"/>
    </box>
    <box flexibleheight="2">
        <tmpro text="+{combat_2} if you have a Fire Gem in play or in your discard pile." fontsize="24" />
    </box>
</vlayout>
					]],
                }
            )
        }
    )
end

function pyromancer_incinerate_carddef()
    return createDef(
        {
            id = "Pyromancer_incinerate",
            name = "Incinerate",
            types = {noStealType, actionType},
            acquireCost = 0,
            cardTypeLabel = "Action",
            playLocation = castPloc,
            abilities = {
                createAbility({
                        id = "Pyromancer_Incinerate",
                        layout = cardLayout,
                        effect = gainCombatEffect(1).seq(damageTarget(2).apply(selectLoc(loc(oppPid, inPlayPloc)))),
                        trigger = autoTrigger,
                        tags = {}
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Incinerate",
                    art = "art/epicart/flame_strike",
                    frame = "frames/wizard_cardframe",
                    xmlText=[[
<vlayout>
    <box flexibleheight="1">
        <tmpro text="{combat_1}" fontsize="50"/>
    </box>
    <box flexibleheight="1">
        <tmpro text="Deal 2 damage to all opposing champions." fontsize="24" />
    </box>
</vlayout>
					]],
                }
            )
        }
    )
end

function pyromancer_patronage_carddef()
    return createDef(
        {
            id = "pyromancer_patronage",
            name = "Patronage",
            types = {gemType, noStealType, itemType},
			            acquireCost = 0,
            cardTypeLabel = "Item",
            playLocation = castPloc,
            abilities = {
				createAbility(
                    {
                        id = "pyromancer_patronage",
						cost = noCost,
						trigger = autoTrigger,
                        activations = singleActivations,
						effect = gainGoldEffect(2),
                        tags = {}
                    }
                ),
				
				createAbility(
                    {
                        id = "pyromancer_patronage_sac",
						cost = sacrificeSelfCost,
						trigger = uiTrigger,
                        activations = singleActivations,
						effect = prepareTarget().apply(selectLoc(currentSkillsLoc)),
                        tags = {}
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Patronage",
                    art = "art/treasures/thief_brillant_ruby",
                    frame = "frames/wizard_cardframe",
                    xmlText=[[
					<vlayout>
    <box flexibleheight="9">
        <tmpro text="{gold_2}" fontsize="40"/>
    </box>
    <box flexibleheight="3">
        <tmpro text="" fontsize="24" />
    </box>
<divider/>
    <hlayout flexibleheight="14">
            <tmpro text="{scrap}" fontsize="40" flexiblewidth="1" />
            <tmpro text="Prepare your skill." fontsize="30" flexiblewidth="10" />
    </hlayout> </vlayout>
					]]
                }
            )
        }
    )
end

function pyromancer_fire_elemental_carddef()
    return createChampionDef(
        {
            id = "pyromancer_fire_elemental",
            name = "Fire Elemental",
			types = { championType, nosteaalType},
            acquireCost = 0,
            health = 3,
            isGuard = true,
            abilities = {
                createAbility(
                    {
                        id = "Fire_elemental_main",
                        trigger = autoTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = gainCombatEffect(2)
						
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Fire Elemental",
                    art = "art/epicart/fire_spirit",
                    frame = "frames/wizard_cardframe",
                    xmlText=[[
					<vlayout>
    <hlayout flexibleheight="3">
            <tmpro text="{expend}" fontsize="40" flexiblewidth="2"/>
            <tmpro text="{combat_2}" fontsize="50" flexiblewidth="12" />
    </hlayout>
    <divider/>
    <hlayout flexibleheight="2">
            <tmpro text="Just don't say 'Flame on' to it." fontsize="20" fontstyle="italic" flexiblewidth="10" />
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

function pyromancer_hearth_carddef()

    return createDef(
        {
            id = "pyromancer_hearth",
            name = "Hearth",
            types = {gemType, noStealType, itemType},
			            acquireCost = 0,
            cardTypeLabel = "Item",
            playLocation = castPloc,
            abilities = {
				createAbility(
                    {
                        id = "pyromancer_hearth",
						cost = noCost,
						trigger = autoTrigger,
                        activations = singleActivations,
						                        effect = pushChoiceEffect(
                                {
                                    choices = {
                                        {
                                            effect = gainHealthEffect(3),
                                            layout = layoutCard(
                                                {
                                                    title = "Hearth",
                                                    art = "art/t_blistering_blaze",
                                                    xmlText=[[
													<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="7">
            <icon text="{health_3}" fontsize="60"/>
</box>
</hlayout>
</vlayout>
													]]
                                                }
                                            ),
                                            tags = {gainCombatTag}
                                        },
                                        {
                                            effect = drawCardsEffect(1),
											layout = layoutCard(
                                                {
                                                    title = "Hearth",
                                                    art = "art/t_blistering_blaze",
                                                    xmlText=[[
<vlayout>
    <box flexibleheight="1">
        <tmpro text="Draw 1." fontsize="30" />
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
                    name = "Hearth",
                    art = "art/t_blistering_blaze",
                    frame = "frames/wizard_cardframe",
                    xmlText=[[
					<vlayout>
<hlayout flexibleheight="1">
        <box flexiblewidth="7">
            <icon text="{health_3} &lt;size=70%&gt;or Draw 1." fontsize="50"/>
</box>
</hlayout>
</vlayout>
					]]
                }
            )
        }
    )
end

function pyromancer_volatile_chemicals_carddef()

    return createDef(
        {
            id = "pyromancer_volatile_chemicals",
            name = "Volatile Chemicals",
            types = {gemType, noStealType, itemType},
			            acquireCost = 0,
            cardTypeLabel = "Item",
            playLocation = castPloc,
            abilities = {
				createAbility(
                    {
                        id = "pyromancer_volatile_chemicals",
						cost = noCost,
						trigger = autoTrigger,
                        activations = singleActivations,
						effect = gainGoldEffect(1).seq(gainCombatEffect(2)),
                        tags = {}
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Volatile Chemicals",
                    art = "art/treasures/wizard_adept_s_components",
                    frame = "frames/wizard_cardframe",
                    xmlText=[[
					<vlayout>
<hlayout flexibleheight="1">
        <box flexiblewidth="7">
            <icon text="{gold_1} {combat_2}" fontsize="50"/>
</box>
</hlayout>
</vlayout>
					]]
                }
            )
        }
    )
end

function pyromancer_fire_gem_amulet_carddef()

 local cardLayout = createLayout({
        name = "Fire Gem Amulet",
        art = "art/t_fire_gem",
        frame = "frames/wizard_cardframe",
        xmlText=[[
					
<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{requiresHealth_25}" fontsize="60"/>
        </box>
        <box flexiblewidth="5">
            <tmpro text="If you have a Fire Gem in play or in your discard pile put a Fire Bird token into play if there is none.
Otherwise give a Fire Bird +1{shield} until it leaves play." fontsize="19" />
        </box>
    </hlayout>
</vlayout>
					]]
    })
	
    return createMagicArmorDef(
        {
            id = "pyromancer_fire_gem_amulet",
            name = "Fire Gem Amulet",
            types = {magicArmorType, noStealType, itemType},
			            acquireCost = 0,
            cardTypeLabel = "Armour",
			layout = cardLayout,
			layoutPath  = "art/t_fire_gem",
            playLocation = castPloc,
            abilities = {
				createAbility(
                    {
                        id = "pyromancer_fire_gem_amulet",
						cost = expendCost,
						trigger = autoTrigger,
						layout = cardLayout,
                        activations = singleActivations,
						effect = createCardEffect(pyromancer_fire_bird_carddef(), currentInPlayLoc),
						check= minHealthCurrent(25)
						.And(selectLoc(loc(currentPid, castPloc)).union(selectLoc(loc(currentPid, discardPloc))).where(isCardName("fire_gem")).count().gte(1))
						.And(((selectLoc(loc(currentPid, inPlayPloc))).where(isCardName("pyromancer_fire_bird")).count().eq(0))),
                        tags = {}
                    }
                ),
				
				createAbility(
                    {
                        id = "pyromancer_fire_gem_amulet2",
						cost = expendCost,
						trigger = autoTrigger,
						layout = cardLayout,
                        activations = singleActivations,
						effect = grantHealthTarget(1, { SlotExpireEnum.LeavesPlay }, nullEffect(), "Fire Gem Amulet").apply(selectLoc(loc(currentPid, inPlayPloc)).where(isCardName("pyromancer_fire_bird"))),
						check= minHealthCurrent(25)
						.And(selectLoc(loc(currentPid, castPloc)).union(selectLoc(loc(currentPid, discardPloc))).where(isCardName("fire_gem")).count().gte(1))
						.And(((selectLoc(loc(currentPid, inPlayPloc))).where(isCardName("pyromancer_fire_bird")).count().eq(1))),
                        tags = {}
                    }
                ),
	
            },
            
			
        }
    )
end

function pyromancer_fire_bird_carddef()
--This is a token champion, that self-sacrifices when it leaves play
    return createChampionDef(
        {
            id = "pyromancer_fire_bird",
            name = "Fire Bird",
			types = {minionType, championType, demonType, nostealType, tokenType},
            acquireCost = 0,
            health = 1,
            isGuard = false,
            abilities = {
			--base ability
                createAbility(
                    {
                        id = "fire_bird_main",
                        trigger = uiTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = gainCombatEffect(selectSource().sum(getCardHealth()))
						
                    }
                )
            ,
			--self-sac ability
                createAbility(
                    {
                        id = "fire_bird_sac",
                        trigger = onLeavePlayTrigger,
                        cost = sacrificeSelfCost,
                        activations = singleActivations,
                        effect = nullEffect()
					}	
                    
                )},
            layout = createLayout(
                {
                    name = "Fire Bird",
                    art = "art/epicart/fire_shaman",
                    frame = "frames/wizard_cardframe",
                    xmlText=[[
					<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{expend}" fontsize="40"/>
        </box>
        <box flexiblewidth="7">
            <icon text="Gain {combat} equal to
this card's {shield}." fontsize="24"/>
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

function pyromancer1_flame_hood_carddef()

 local cardLayout = createLayout({
        name = "Flame Hood",
        art = "avatars/summoner",
        frame = "frames/wizard_cardframe",
        xmlText=[[
					
<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{requiresHealth_25}" fontsize="60"/>
        </box>
        <box flexiblewidth="5">
            <tmpro text="Pay {gold_1}
Add {combat_2}
to your Ability.
&lt;size=80%&gt;
If you have used your Ability, gain {combat_2}." fontsize="24" />
        </box>
    </hlayout>
</vlayout>
					]]
    })
	
    return createMagicArmorDef(
        {
            id = "pyromancer1_flame_hood",
            name = "Flame Hood",
            types = {magicArmorType, noStealType, itemType},
			            acquireCost = 0,
            cardTypeLabel = "Armour",
			layout = cardLayout,
			layoutPath  = "avatars/summoner",
            playLocation = castPloc,
            abilities = {
				createAbility(
                    {
                        id = "pyromancer1_flame_hood",
						cost = expendCost,
						trigger = uiTrigger,
						layout = cardLayout,
						promptType = showPrompt,
                        activations = singleActivations,
						effect = gainGoldEffect(-1).seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardType(abilityType)).count().eq(0),
						gainCombatEffect(2),
						incrementCounterEffect("conflagration_1p", (2)))),
						check = minHealthCurrent(25).And(getPlayerGold(ownerPid).gte(1)),

                        tags = {}
                    }
                ),
				
	
            },
            
			
        }
    )
end

function pyromancer2_flame_hood_carddef()

 local cardLayout = createLayout({
        name = "Flame Hood",
        art = "avatars/summoner",
        frame = "frames/wizard_cardframe",
        xmlText=[[
					
<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{requiresHealth_25}" fontsize="60"/>
        </box>
        <box flexiblewidth="5">
            <tmpro text="Pay {gold_1}
Add {combat_2}
to your Ability.
&lt;size=80%&gt;
If you have used your Ability, gain {combat_2}." fontsize="24" />
        </box>
    </hlayout>
</vlayout>
					]]
    })
	
    return createMagicArmorDef(
        {
            id = "pyromancer2_flame_hood",
            name = "Flame Hood",
            types = {magicArmorType, noStealType, itemType},
			            acquireCost = 0,
            cardTypeLabel = "Armour",
			layout = cardLayout,
			layoutPath  = "avatars/summoner",
            playLocation = castPloc,
            abilities = {
				createAbility(
                    {
                        id = "pyromancer2_flame_hood",
						cost = expendCost,
						trigger = uiTrigger,
						layout = cardLayout,
						promptType = showPrompt,
                        activations = singleActivations,
						effect = gainGoldEffect(-1).seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardType(abilityType)).count().eq(0),
						gainCombatEffect(2),
						incrementCounterEffect("conflagration_2p", (2)))),
						check = minHealthCurrent(25).And(getPlayerGold(ownerPid).gte(1)),

                        tags = {}
                    }
                ),
				
	
            },
            
			
        }
    )
end

--START skills - Research Phoenix Fire (for level 3 heroes) (Skill-1)
function pyromancer_1p_fuel_1carddef()
    local cardLayout = createLayout({
        name = "Research Phoenix Fire",
        art = "art/epicart/arcane_research",
        frame = "frames/wizard_cardframe",
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
                activations = multipleActivations,
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
        frame = "frames/wizard_cardframe",
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
                activations = multipleActivations,
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
        frame = "frames/wizard_cardframe",
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


-- START Compulsive Research (Skill-2a)
function pyromancer_1p_compulsive_research_1carddef()
    local cardLayout = createLayout({
        name = "Compulsive Research",
        art = "art/epicart/frantic_digging",
        frame = "frames/wizard_cardframe",
        xmlText = format([[<vlayout>
            <hlayout flexibleheight="0.2">
                <box flexiblewidth="0"/>
                <tmpro text="{expend_2}" fontsize="60" flexiblewidth="1"/>
                <box flexiblewidth="0"/>
                <vlayout flexiblewidth="6">
                    <box flexibleheight="0.2"/>
                    <tmpro text="Add {0}{combat} to your Conflagration ability. Increase the value of this skill by {combat_1} 
(to a maximum of 6)." fontsize="24" flexibleheight="3"/>

                </vlayout>
            </hlayout>
        </vlayout>]], 
		{ getCounter("fuel_1p") })
    })

    return createSkillDef({
        id = "pyromancer_1p_compulsive_research_1_skill",
        name = "Compulsive Research",
        types = { skillType },
        layout = cardLayout,
        layoutPath = "art/epicart/frantic_digging",
        abilities = {
            createAbility({
                id = "pyromancer_1p_compulsive_research_1_ab",
                trigger = uiTrigger,
				promptType = showPrompt,
                activations = multipleActivations,
                layout = cardLayout,
                effect = incrementCounterEffect("conflagration_1p", (getCounter("fuel_1p")))
				.seq(ifElseEffect((getCounter("fuel_1p").lte(5)),incrementCounterEffect("fuel_1p", 1),nullEffect())),
                cost = combineCosts({
                    expendCost,
                    goldCost(2)
                }),
            }),
        }
        
    })
end

function pyromancer_2p_compulsive_research_1carddef()
    local cardLayout = createLayout({
        name = "Compulsive Research",
        art = "art/epicart/frantic_digging",
        frame = "frames/wizard_cardframe",
        xmlText = format([[<vlayout>
            <hlayout flexibleheight="0.2">
                <box flexiblewidth="0"/>
                <tmpro text="{expend_2}" fontsize="60" flexiblewidth="1"/>
                <box flexiblewidth="0"/>
                <vlayout flexiblewidth="6">
                    <box flexibleheight="0.2"/>
                    <tmpro text="Add {0}{combat} to your Conflagration ability. Increase the value of this skill by {combat_1} 
(to a maximum of 6)." fontsize="24" flexibleheight="3"/>

                </vlayout>
            </hlayout>
        </vlayout>]], 
		{ getCounter("fuel_2p") })
    })

    return createSkillDef({
        id = "pyromancer_2p_compulsive_research_1_skill",
        name = "Compulsive Research",
        types = { skillType },
        layout = cardLayout,
        layoutPath = "art/epicart/frantic_digging",
        abilities = {
            createAbility({
                id = "pyromancer_2p_compulsive_research_1_ab",
                trigger = uiTrigger,
				promptType = showPrompt,
                activations = multipleActivations,
                layout = cardLayout,
                effect = incrementCounterEffect("conflagration_2p", (getCounter("fuel_2p")))
				.seq(ifElseEffect((getCounter("fuel_2p").lte(5)),incrementCounterEffect("fuel_2p", 1),nullEffect())),
                cost = combineCosts({
                    expendCost,
                    goldCost(2)
                }),
            }),
        }
        
    })
end

-- START Crazed Research (Skill-3a)
function pyromancer_1p_reckless_research_1carddef()
    local cardLayout = createLayout({
        name = "Reckless Research",
        art = "art/epicart/erratic_research",
        frame = "frames/wizard_cardframe",
        xmlText = format([[<vlayout>
            <hlayout flexibleheight="0.2">
                <box flexiblewidth="0"/>
                <tmpro text="{expend_2}" fontsize="60" flexiblewidth="1"/>
                <box flexiblewidth="0"/>
                <vlayout flexiblewidth="6">
                    <box flexibleheight="0.2"/>
                    <tmpro text="{health_-1}
&lt;size=70%&gt;Add {0}{combat} to your ability. Increase the value of this skill by {combat_1} 
(to a maximum of 7)." fontsize="30" flexibleheight="3"/>

                </vlayout>
            </hlayout>
        </vlayout>]], 
		{ getCounter("fuel_1p") })
    })

    return createSkillDef({
        id = "pyromancer_1p_reckless_research_1_skill",
        name = "Reckless Research",
        types = { skillType },
        layout = cardLayout,
        layoutPath = "art/epicart/erratic_research",
        abilities = {
            createAbility({
                id = "pyromancer_1p_reckless_research_1_ab",
                trigger = uiTrigger,
				check = minHealthCurrent(2),
				promptType = showPrompt,
                activations = multipleActivations,
                layout = cardLayout,
                effect = gainHealthEffect(-1).seq(incrementCounterEffect("conflagration_1p", (getCounter("fuel_1p"))))
				.seq(ifElseEffect((getCounter("fuel_1p").lte(6)),incrementCounterEffect("fuel_1p", 1),nullEffect())),
                cost = combineCosts({
                    expendCost,
                    goldCost(2)
                }),
            }),
        }
        
    })
end

function pyromancer_2p_reckless_research_1carddef()
    local cardLayout = createLayout({
        name = "Reckless Research",
        art = "art/epicart/erratic_research",
        frame = "frames/wizard_cardframe",
        xmlText = format([[<vlayout>
            <hlayout flexibleheight="0.2">
                <box flexiblewidth="0"/>
                <tmpro text="{expend_2}" fontsize="60" flexiblewidth="1"/>
                <box flexiblewidth="0"/>
                <vlayout flexiblewidth="6">
                    <box flexibleheight="0.2"/>
                    <tmpro text="{health_-1}
&lt;size=70%&gt;Add {0}{combat} to your ability. Increase the value of this skill by {combat_1} 
(to a maximum of 7)." fontsize="30" flexibleheight="3"/>

                </vlayout>
            </hlayout>
        </vlayout>]], 
		{ getCounter("fuel_2p") })
    })

    return createSkillDef({
        id = "pyromancer_2p_reckless_research_1_skill",
        name = "Reckless Research",
        types = { skillType },
        layout = cardLayout,
        layoutPath = "art/epicart/erratic_research",
        abilities = {
            createAbility({
                id = "pyromancer_2p_reckless_research_1_ab",
                trigger = uiTrigger,
				check = minHealthCurrent(2),
				promptType = showPrompt,
                activations = multipleActivations,
                layout = cardLayout,
                effect = gainHealthEffect(-1).seq(incrementCounterEffect("conflagration_2p", (getCounter("fuel_2p"))))
				.seq(ifElseEffect((getCounter("fuel_2p").lte(6)),incrementCounterEffect("fuel_2p", 1),nullEffect())),
                cost = combineCosts({
                    expendCost,
                    goldCost(2)
                }),
            }),
        }
        
    })
end

-- START Obsessive Research (Skill-3b)
function pyromancer_1p_obsessive_research_1carddef()
    local cardLayout = createLayout({
        name = "Obsessive Research",
        art = "art/epicart/mystic_researcher",
        frame = "frames/wizard_cardframe",
        xmlText = format([[<vlayout>
            <hlayout flexibleheight="0.2">
                <box flexiblewidth="0"/>
                <tmpro text="{expend_2}" fontsize="60" flexiblewidth="1"/>
                <box flexiblewidth="0"/>
                <vlayout flexiblewidth="6">
                    <box flexibleheight="0.2"/>
                    <tmpro text="Add {0}{combat} to your ability. Increase the value of this skill by {combat_1} (to a max of 6).
Draw 1. Put a card on the top of your deck." fontsize="20" flexibleheight="3"/>

                </vlayout>
            </hlayout>
        </vlayout>]], 
		{ getCounter("fuel_1p") })
    })

    return createSkillDef({
        id = "pyromancer_1p_obsessive_research_1_skill",
        name = "Obsessive Research",
        types = { skillType },
        layout = cardLayout,
        layoutPath = "art/epicart/mystic_researcher",
        abilities = {
            createAbility({
                id = "pyromancer_1p_obsessive_research_1_ab",
                trigger = uiTrigger,
				promptType = showPrompt,
                activations = multipleActivations,
                layout = cardLayout,
                effect = incrementCounterEffect("conflagration_1p", (getCounter("fuel_1p")))
				.seq(ifElseEffect((getCounter("fuel_1p").lte(5)),incrementCounterEffect("fuel_1p", 1),nullEffect()))
				.seq(drawCardsEffect(1))
				.seq(pushTargetedEffect({
												  desc="Put a card on the top of your deck.",
												  min=1,
												  max=1,
												  validTargets= selectLoc(loc(currentPid, handPloc)),
												  targetEffect= moveToTopDeckTarget(true),
												  tags = {}
												})),
                cost = combineCosts({
                    expendCost,
                    goldCost(2)
                }),
            }),
        }
        
    })
end

function pyromancer_2p_obsessive_research_1carddef()
    local cardLayout = createLayout({
        name = "Obsessive Research",
        art = "art/epicart/mystic_researcher",
        frame = "frames/wizard_cardframe",
        xmlText = format([[<vlayout>
            <hlayout flexibleheight="0.2">
                <box flexiblewidth="0"/>
                <tmpro text="{expend_2}" fontsize="60" flexiblewidth="1"/>
                <box flexiblewidth="0"/>
                <vlayout flexiblewidth="6">
                    <box flexibleheight="0.2"/>
                    <tmpro text="Add {0}{combat} to your ability. Increase the value of this skill by {combat_1} (to a max of 6).
Draw 1. Put a card on the top of your deck." fontsize="20" flexibleheight="3"/>

                </vlayout>
            </hlayout>
        </vlayout>]], 
		{ getCounter("fuel_2p") })
    })

    return createSkillDef({
        id = "pyromancer_2p_obsessive_research_1_skill",
        name = "Obsessive Research",
        types = { skillType },
        layout = cardLayout,
        layoutPath = "art/epicart/mystic_researcher",
        abilities = {
            createAbility({
                id = "pyromancer_2p_obsessive_research_1_ab",
                trigger = uiTrigger,
				promptType = showPrompt,
                activations = multipleActivations,
                layout = cardLayout,
                effect = incrementCounterEffect("conflagration_2p", (getCounter("fuel_2p")))
				.seq(ifElseEffect((getCounter("fuel_2p").lte(5)),incrementCounterEffect("fuel_2p", 1),nullEffect()))
				.seq(drawCardsEffect(1))
				.seq(pushTargetedEffect({
												  desc="Put a card on the top of your deck.",
												  min=1,
												  max=1,
												  validTargets= selectLoc(loc(currentPid, handPloc)),
												  targetEffect= moveToTopDeckTarget(true),
												  tags = {}
												})),
                cost = combineCosts({
                    expendCost,
                    goldCost(2)
                }),
            }),
        }
        
    })
end

-- START Considered Research (Skill-2b)
function pyromancer_1p_considered_research_1carddef()
    local cardLayout = createLayout({
        name = "Considered Research",
        art = "art/epicart/forbidden_research",
        frame = "frames/wizard_cardframe",
        xmlText = format([[<vlayout>
            <hlayout flexibleheight="0.2">
                <box flexiblewidth="0"/>
                <tmpro text="{expend_2}" fontsize="60" flexiblewidth="1"/>
                <box flexiblewidth="0"/>
                <vlayout flexiblewidth="6">
                    <box flexibleheight="0.2"/>
                    <tmpro text="Add {0}{combat} to your ability. Increase the value of this skill by {combat_1} (to a max of 5).
Draw 1. Put a card on the top of your deck." fontsize="20" flexibleheight="3"/>

                </vlayout>
            </hlayout>
        </vlayout>]], 
		{ getCounter("fuel_1p") })
    })

    return createSkillDef({
        id = "pyromancer_1p_considered_research_1_skill",
        name = "Considered Research",
        types = { skillType },
        layout = cardLayout,
        layoutPath = "art/epicart/forbidden_research",
        abilities = {
            createAbility({
                id = "pyromancer_1p_considered_research_1_ab",
                trigger = uiTrigger,
				promptType = showPrompt,
                activations = multipleActivations,
                layout = cardLayout,
                effect = incrementCounterEffect("conflagration_1p", (getCounter("fuel_1p")))
				.seq(ifElseEffect((getCounter("fuel_1p").lte(4)),incrementCounterEffect("fuel_1p", 1),nullEffect()))
				.seq(drawCardsEffect(1))
				.seq(pushTargetedEffect({
												  desc="Put a card on the top of your deck.",
												  min=1,
												  max=1,
												  validTargets= selectLoc(loc(currentPid, handPloc)),
												  targetEffect= moveToTopDeckTarget(true),
												  tags = {}
												})),
                cost = combineCosts({
                    expendCost,
                    goldCost(2)
                }),
            }),
        }
        
    })
end

function pyromancer_2p_considered_research_1carddef()
    local cardLayout = createLayout({
        name = "Considered Research",
        art = "art/epicart/forbidden_research",
        frame = "frames/wizard_cardframe",
        xmlText = format([[<vlayout>
            <hlayout flexibleheight="0.2">
                <box flexiblewidth="0"/>
                <tmpro text="{expend_2}" fontsize="60" flexiblewidth="1"/>
                <box flexiblewidth="0"/>
                <vlayout flexiblewidth="6">
                    <box flexibleheight="0.2"/>
                    <tmpro text="Add {0}{combat} to your ability. Increase the value of this skill by {combat_1} (to a max of 5).
Draw 1. Put a card on the top of your deck." fontsize="20" flexibleheight="3"/>

                </vlayout>
            </hlayout>
        </vlayout>]], 
		{ getCounter("fuel_2p") })
    })

    return createSkillDef({
        id = "pyromancer_2p_considered_research_1_skill",
        name = "Considered Research",
        types = { skillType },
        layout = cardLayout,
        layoutPath = "art/epicart/forbidden_research",
        abilities = {
            createAbility({
                id = "pyromancer_2p_considered_research_1_ab",
                trigger = uiTrigger,
				promptType = showPrompt,
                activations = multipleActivations,
                layout = cardLayout,
                effect = incrementCounterEffect("conflagration_2p", (getCounter("fuel_2p")))
				.seq(ifElseEffect((getCounter("fuel_2p").lte(4)),incrementCounterEffect("fuel_2p", 1),nullEffect()))
				.seq(drawCardsEffect(1))
				.seq(pushTargetedEffect({
												  desc="Put a card on the top of your deck.",
												  min=1,
												  max=1,
												  validTargets= selectLoc(loc(currentPid, handPloc)),
												  targetEffect= moveToTopDeckTarget(true),
												  tags = {}
												})),
                cost = combineCosts({
                    expendCost,
                    goldCost(2)
                }),
            }),
        }
        
    })
end

-- START Focussed Research (Skill-3c)
function pyromancer_1p_focussed_research_1carddef()
    local cardLayout = createLayout({
        name = "Focussed Research",
        art = "art/epicart/lesson_learned",
        frame = "frames/wizard_cardframe",
        xmlText = format([[<vlayout>
            <hlayout flexibleheight="0.2">
                <box flexiblewidth="0"/>
                <tmpro text="{expend_2}" fontsize="60" flexiblewidth="1"/>
                <box flexiblewidth="0"/>
                <vlayout flexiblewidth="6">
                    <box flexibleheight="0.2"/>
                    <tmpro text="Add {0}{combat} to your ability. Increase the value of this skill by {combat_1} (to a max of 5).
{health_2} Draw 1. Put a card on the top of your deck." fontsize="20" flexibleheight="3"/>

                </vlayout>
            </hlayout>
        </vlayout>]], 
		{ getCounter("fuel_1p") })
    })

    return createSkillDef({
        id = "pyromancer_1p_focussed_research_1_skill",
        name = "Focussed Research",
        types = { skillType },
        layout = cardLayout,
        layoutPath = "art/epicart/lesson_learned",
        abilities = {
            createAbility({
                id = "pyromancer_1p_focussed_research_1_ab",
                trigger = uiTrigger,
				promptType = showPrompt,
                activations = multipleActivations,
                layout = cardLayout,
                effect = incrementCounterEffect("conflagration_1p", (getCounter("fuel_1p")))
				.seq(ifElseEffect((getCounter("fuel_1p").lte(4)),incrementCounterEffect("fuel_1p", 1),nullEffect()))
				.seq(gainHealthEffect(2)).seq(drawCardsEffect(1))
				.seq(pushTargetedEffect({
												  desc="Put a card on the top of your deck.",
												  min=1,
												  max=1,
												  validTargets= selectLoc(loc(currentPid, handPloc)),
												  targetEffect= moveToTopDeckTarget(true),
												  tags = {}
												})),
                cost = combineCosts({
                    expendCost,
                    goldCost(2)
                }),
            }),
        }
        
    })
end

function pyromancer_2p_focussed_research_1carddef()
    local cardLayout = createLayout({
        name = "Focussed Research",
        art = "art/epicart/lesson_learned",
        frame = "frames/wizard_cardframe",
        xmlText = format([[<vlayout>
            <hlayout flexibleheight="0.2">
                <box flexiblewidth="0"/>
                <tmpro text="{expend_2}" fontsize="60" flexiblewidth="1"/>
                <box flexiblewidth="0"/>
                <vlayout flexiblewidth="6">
                    <box flexibleheight="0.2"/>
                    <tmpro text="Add {0}{combat} to your ability. Increase the value of this skill by {combat_1} (to a max of 5).
{health_2} Draw 1. Put a card on the top of your deck." fontsize="20" flexibleheight="3"/>

                </vlayout>
            </hlayout>
        </vlayout>]], 
		{ getCounter("fuel_2p") })
    })

    return createSkillDef({
        id = "pyromancer_2p_focussed_research_1_skill",
        name = "Focussed Research",
        types = { skillType },
        layout = cardLayout,
        layoutPath = "art/epicart/lesson_learned",
        abilities = {
            createAbility({
                id = "pyromancer_2p_focussed_research_1_ab",
                trigger = uiTrigger,
				promptType = showPrompt,
                activations = multipleActivations,
                layout = cardLayout,
                effect = incrementCounterEffect("conflagration_2p", (getCounter("fuel_2p")))
				.seq(ifElseEffect((getCounter("fuel_2p").lte(4)),incrementCounterEffect("fuel_2p", 1),nullEffect()))
				.seq(gainHealthEffect(2)).seq(drawCardsEffect(1))
				.seq(pushTargetedEffect({
												  desc="Put a card on the top of your deck.",
												  min=1,
												  max=1,
												  validTargets= selectLoc(loc(currentPid, handPloc)),
												  targetEffect= moveToTopDeckTarget(true),
												  tags = {}
												})),
                cost = combineCosts({
                    expendCost,
                    goldCost(2)
                }),
            }),
        }
        
    })
end

--START Afterburn upgrades
function pyromancer_after_burn_3a_carddef()
    local cardLayout = createLayout({
        name = "After Burn",
        art = "icons/growing_flame",
        frame = "frames/wizard_cardframe",
        xmlText = [[<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{expend_2}" fontsize="72"/>
        </box>
        <box flexiblewidth="7">
            <tmpro text="{combat_3} {health_1}" fontsize="52" />
        </box>
    </hlayout>
</vlayout>]]
    })

    return createSkillDef({
        id = "pyromancer_after_burn_3a_skill",
        name = "After Burn",
        types = { skillType },
        layout = cardLayout,
        layoutPath = "icons/growing_flame",
        abilities = {
            createAbility({
                id = "after_burn_3a",
                trigger = uiTrigger,
				promptType = showPrompt,
                activations = multipleActivations,
                layout = cardLayout,
                effect = gainCombatEffect(3).seq(gainHealthEffect(1)),
                cost = combineCosts({
                    expendCost,
                    goldCost(2)
                }),
            }),
        }
        
    })
end

function pyromancer_after_burn_3b_carddef()
    local cardLayout = createLayout({
        name = "After Burn",
        art = "icons/growing_flame",
        frame = "frames/wizard_cardframe",
        xmlText = [[<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{expend_2}" fontsize="72"/>
        </box>
        <box flexiblewidth="7">
            <tmpro text="{combat_2} {health_1}
&lt;size=45%&gt;Draw 1. Put a card on the top of your deck." fontsize="52" />
        </box>
    </hlayout>
</vlayout>]]
    })

    return createSkillDef({
        id = "pyromancer_after_burn_3b_skill",
        name = "After Burn",
        types = { skillType },
        layout = cardLayout,
        layoutPath = "icons/growing_flame",
        abilities = {
            createAbility({
                id = "after_burn_3b",
                trigger = uiTrigger,
				promptType = showPrompt,
                activations = multipleActivations,
                layout = cardLayout,
                effect = gainCombatEffect(3).seq(gainHealthEffect(1))
				.seq(drawCardsEffect(1))
				.seq(pushTargetedEffect({
												  desc="Put a card on the top of your deck.",
												  min=1,
												  max=1,
												  validTargets= selectLoc(loc(currentPid, handPloc)),
												  targetEffect= moveToTopDeckTarget(true),
												  tags = {}
												})),
                cost = combineCosts({
                    expendCost,
                    goldCost(2)
                }),
            }),
        }
        
    })
end

function pyromancer_after_burn_3c_carddef()
    local cardLayout = createLayout({
        name = "After Burn",
        art = "icons/growing_flame",
        frame = "frames/wizard_cardframe",
        xmlText = [[<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{expend_2}" fontsize="72"/>
        </box>
        <box flexiblewidth="7">
            <tmpro text="{combat_1} {health_3}
&lt;size=45%&gt;Draw 1. Put a card on the top of your deck." fontsize="52" />
        </box>
    </hlayout>
</vlayout>]]
    })

    return createSkillDef({
        id = "pyromancer_after_burn_3c_skill",
        name = "After Burn",
        types = { skillType },
        layout = cardLayout,
        layoutPath = "icons/growing_flame",
        abilities = {
            createAbility({
                id = "after_burn_3c",
                trigger = uiTrigger,
				promptType = showPrompt,
                activations = multipleActivations,
                layout = cardLayout,
                effect = gainCombatEffect(1).seq(gainHealthEffect(3))
				.seq(drawCardsEffect(1))
				.seq(pushTargetedEffect({
												  desc="Put a card on the top of your deck.",
												  min=1,
												  max=1,
												  validTargets= selectLoc(loc(currentPid, handPloc)),
												  targetEffect= moveToTopDeckTarget(true),
												  tags = {}
												})),
                cost = combineCosts({
                    expendCost,
                    goldCost(2)
                }),
            }),
        }
        
    })
end


-- START Ability upgrades 1p
--4a Phoenix Frenzy
function pyromancer_phoenix_frenzy_1p_carddef()
	return createHeroAbilityDef({
		id = "conflagration_1p",
		name = "Phoenix Frenzy",
		types = { heroAbilityType },
        abilities = {
			createAbility({
				id = "conflagration_1pActivate",
				trigger = uiTrigger,
				promptType = showPrompt,
				layout = createLayout({
            name = "Phoenix Frenzy",	
            art = "art/epicart/fireball",
            xmlText = format([[<vlayout>
            <hlayout flexibleheight="2">
                <box flexiblewidth="0.2"/>
                <tmpro text="{scrap}" fontsize="40" flexiblewidth="1"/>
                <box flexiblewidth="0"/>
                <vlayout flexiblewidth="6">
                    <box flexibleheight="0.2"/>
                    <tmpro text="{combat}
&lt;size=65%&gt;Flip your skill to Afterburn.

&lt;size=50%&gt;{combat} gained starts at {combat_7}
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
            name = "Phoenix Frenzy",	
            art = "art/epicart/fireball",
			frame = "frames/wizard_cardframe",
            xmlText = format([[<vlayout>
            <hlayout flexibleheight="2">
                <box flexiblewidth="0.2"/>
                <tmpro text="{scrap}" fontsize="40" flexiblewidth="1"/>
                <box flexiblewidth="0"/>
                <vlayout flexiblewidth="6">
                    <box flexibleheight="0.2"/>
                    <tmpro text="{0}{combat}
&lt;size=65%&gt;Flip your skill to Afterburn.

&lt;size=50%&gt;{combat} gained starts at {combat_7}
and increases with each use of your skill." fontsize="32" flexibleheight="3"/>

                </vlayout>
            </hlayout>
        </vlayout>]], 
		{ getCounter("conflagration_1p") })
        }),
		layout = createLayout({
            name = "Phoenix Frenzy",	
            art = "art/epicart/fireball",
			frame = "frames/wizard_cardframe",
            xmlText = format([[<vlayout>
            <hlayout flexibleheight="2">
                <box flexiblewidth="0.2"/>
                <tmpro text="{scrap}" fontsize="40" flexiblewidth="1"/>
                <box flexiblewidth="0"/>
                <vlayout flexiblewidth="6">
                    <box flexibleheight="0.2"/>
                    <tmpro text="{0}{combat}
&lt;size=65%&gt;Flip your skill to Afterburn.

&lt;size=50%&gt;{combat} gained starts at {combat_7}
and increases with each use of your skill." fontsize="32" flexibleheight="3"/>

                </vlayout>
            </hlayout>
        </vlayout>]], 
		{ getCounter("conflagration_1p") })
        }),
        layoutPath  = "art/epicart/fireball",
	})
end	

--5a Phoenix Fury
function pyromancer_phoenix_fury_1p_carddef()
	return createHeroAbilityDef({
		id = "conflagration_1p",
		name = "Phoenix Fury",
		types = { heroAbilityType },
        abilities = {
			createAbility({
				id = "conflagration_1pActivate",
				trigger = uiTrigger,
				promptType = showPrompt,
				layout = createLayout({
            name = "Phoenix Fury",	
            art = "art/t_pillar_of_fire",
            xmlText = format([[<vlayout>
            <hlayout flexibleheight="2">
                <box flexiblewidth="0.2"/>
                <tmpro text="{scrap}" fontsize="40" flexiblewidth="1"/>
                <box flexiblewidth="0"/>
                <vlayout flexiblewidth="6">
                    <box flexibleheight="0.2"/>
                    <tmpro text="{0}{combat}
&lt;size=65%&gt;Flip your skill to Afterburn.

&lt;size=50%&gt;{combat} gained starts at {combat_9}
and increases with each use of your skill." fontsize="32" flexibleheight="3"/>

                </vlayout>
            </hlayout>
        </vlayout>]], 
		{ getCounter("conflagration_1p") })
        }),
				effect = gainCombatEffect(getCounter("conflagration_1p"))
				.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardName("pyromancer_1p_reckless_research_1_skill")).count().gte(1),createCardEffect(pyromancer_after_burn_3a_carddef(), currentSkillsLoc), nullEffect()))
				.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardName("pyromancer_1p_reckless_research_1_skill")).count().gte(1),sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("pyromancer_1p_reckless_research_1_skill"))), nullEffect()))
				.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardName("pyromancer_1p_obsessive_research_1_skill")).count().gte(1),createCardEffect(pyromancer_after_burn_3b_carddef(), currentSkillsLoc), nullEffect()))
				.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardName("pyromancer_1p_obsessive_research_1_skill")).count().gte(1),sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("pyromancer_1p_obsessive_research_1_skill"))), nullEffect()))
				.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardName("pyromancer_1p_focussed_research_1_skill")).count().gte(1),createCardEffect(pyromancer_after_burn_3c_carddef(), currentSkillsLoc), nullEffect()))
				.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardName("pyromancer_1p_focussed_research_1_skill")).count().gte(1),sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("pyromancer_1p_focussed_research_1_skill"))), nullEffect())),

				cost = sacrificeSelfCost
			}),
		},
        layout = createLayout({
            name = "Phoenix Fury",	
            art = "art/t_pillar_of_fire",
			frame = "frames/wizard_cardframe",
            xmlText = format([[<vlayout>
            <hlayout flexibleheight="2">
                <box flexiblewidth="0.2"/>
                <tmpro text="{scrap}" fontsize="40" flexiblewidth="1"/>
                <box flexiblewidth="0"/>
                <vlayout flexiblewidth="6">
                    <box flexibleheight="0.2"/>
                    <tmpro text="{0}{combat}
&lt;size=65%&gt;Flip your skill to Afterburn.

&lt;size=50%&gt;{combat} gained starts at {combat_9}
and increases with each use of your skill." fontsize="32" flexibleheight="3"/>

                </vlayout>
            </hlayout>
        </vlayout>]], 
		{ getCounter("conflagration_1p") })
        }),
        layout = createLayout({
            name = "Phoenix Fury",	
            art = "art/t_pillar_of_fire",
			frame = "frames/wizard_cardframe",
            xmlText = format([[<vlayout>
            <hlayout flexibleheight="2">
                <box flexiblewidth="0.2"/>
                <tmpro text="{scrap}" fontsize="40" flexiblewidth="1"/>
                <box flexiblewidth="0"/>
                <vlayout flexiblewidth="6">
                    <box flexibleheight="0.2"/>
                    <tmpro text="{0}{combat}
&lt;size=65%&gt;Flip your skill to Afterburn.

&lt;size=50%&gt;{combat} gained starts at {combat_9}
and increases with each use of your skill." fontsize="32" flexibleheight="3"/>

                </vlayout>
            </hlayout>
        </vlayout>]], 
		{ getCounter("conflagration_1p") })
        }),
			
		layoutPath  = "art/t_pillar_of_fire",
	})
end	

--4b Phoenix Flare
function pyromancer_phoenix_flare_1p_carddef()
	return createHeroAbilityDef({
		id = "conflagration_1p",
		name = "Phoenix Flare",
		types = { heroAbilityType },
        abilities = {
			createAbility({
				id = "conflagration_1pActivate",
				trigger = uiTrigger,
				promptType = showPrompt,
				layout = createLayout({
            name = "Phoenix Flare",	
            art = "art/epicart/ascendant_pyromancer",
            xmlText = format([[<vlayout>
            <hlayout flexibleheight="2">
                <box flexiblewidth="0.2"/>
                <tmpro text="{scrap}" fontsize="40" flexiblewidth="1"/>
                <box flexiblewidth="0"/>
                <vlayout flexiblewidth="6">
                    <box flexibleheight="0.2"/>
                    <tmpro text="{combat}{health_6}
&lt;size=65%&gt;Flip your skill to Afterburn.

&lt;size=50%&gt;{combat} gained starts at {combat_5}
and increases with each use of your skill." fontsize="32" flexibleheight="3"/>

                </vlayout>
            </hlayout>
        </vlayout>]], 
		{ getCounter("conflagration_1p") })
        }),
				effect = gainCombatEffect(getCounter("conflagration_1p")).seq(gainHealthEffect(6))
				.seq(sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("pyromancer_1p_fuel_1_skill"))))
				.seq(createCardEffect(pyromancer_after_burn_carddef(), currentSkillsLoc)),
				cost = sacrificeSelfCost
			}),
		},
        layout = createLayout({
            name = "Phoenix Flare",	
            art = "art/epicart/ascendant_pyromancer",
			frame = "frames/wizard_cardframe",
            xmlText = format([[<vlayout>
            <hlayout flexibleheight="2">
                <box flexiblewidth="0.2"/>
                <tmpro text="{scrap}" fontsize="40" flexiblewidth="1"/>
                <box flexiblewidth="0"/>
                <vlayout flexiblewidth="6">
                    <box flexibleheight="0.2"/>
                    <tmpro text="{0}{combat}{health_6}
&lt;size=65%&gt;Flip your skill to Afterburn.

&lt;size=50%&gt;{combat} gained starts at {combat_5}
and increases with each use of your skill." fontsize="32" flexibleheight="3"/>

                </vlayout>
            </hlayout>
        </vlayout>]], 
		{ getCounter("conflagration_1p") })
        }),
        layout = createLayout({
            name = "Phoenix Flare",	
            art = "art/epicart/ascendant_pyromancer",
			frame = "frames/wizard_cardframe",
            xmlText = format([[<vlayout>
            <hlayout flexibleheight="2">
                <box flexiblewidth="0.2"/>
                <tmpro text="{scrap}" fontsize="40" flexiblewidth="1"/>
                <box flexiblewidth="0"/>
                <vlayout flexiblewidth="6">
                    <box flexibleheight="0.2"/>
                    <tmpro text="{0}{combat}{health_6}
&lt;size=65%&gt;Flip your skill to Afterburn.

&lt;size=50%&gt;{combat} gained starts at {combat_5}
and increases with each use of your skill." fontsize="32" flexibleheight="3"/>

                </vlayout>
            </hlayout>
        </vlayout>]], 
		{ getCounter("conflagration_1p") })
        }),
        
		layoutPath  = "art/epicart/ascendant_pyromancer",
	})
end	

--5b Phoenix Flames
function pyromancer_phoenix_flames_1p_carddef()
	return createHeroAbilityDef({
		id = "conflagration_1p",
		name = "Phoenix Flames",
		types = { heroAbilityType },
        abilities = {
			createAbility({
				id = "conflagration_1pActivate",
				trigger = uiTrigger,
				promptType = showPrompt,
				layout = createLayout({
            name = "Phoenix Flames",	
            art = "art/epicart/flames_of_furios",
            xmlText = format([[<vlayout>
            <hlayout flexibleheight="2">
                <box flexiblewidth="0.2"/>
                <tmpro text="{scrap}" fontsize="40" flexiblewidth="1"/>
                <box flexiblewidth="0"/>
                <vlayout flexiblewidth="6">
                    <box flexibleheight="0.2"/>
                    <tmpro text="{0}{combat}{health_6}
&lt;size=65%&gt;Flip your skill to Afterburn.

&lt;size=50%&gt;{combat} gained starts at {combat_7}
and increases with each use of your skill." fontsize="32" flexibleheight="3"/>

                </vlayout>
            </hlayout>
        </vlayout>]], 
		{ getCounter("conflagration_1p") })
        }),
				effect = gainCombatEffect(getCounter("conflagration_1p")).seq(gainHealthEffect(6))
				.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardName("pyromancer_1p_reckless_research_1_skill")).count().gte(1),createCardEffect(pyromancer_after_burn_3a_carddef(), currentSkillsLoc), nullEffect()))
				.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardName("pyromancer_1p_reckless_research_1_skill")).count().gte(1),sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("pyromancer_1p_reckless_research_1_skill"))), nullEffect()))
				.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardName("pyromancer_1p_obsessive_research_1_skill")).count().gte(1),createCardEffect(pyromancer_after_burn_3b_carddef(), currentSkillsLoc), nullEffect()))
				.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardName("pyromancer_1p_obsessive_research_1_skill")).count().gte(1),sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("pyromancer_1p_obsessive_research_1_skill"))), nullEffect()))
				.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardName("pyromancer_1p_focussed_research_1_skill")).count().gte(1),createCardEffect(pyromancer_after_burn_3c_carddef(), currentSkillsLoc), nullEffect()))
				.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardName("pyromancer_1p_focussed_research_1_skill")).count().gte(1),sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("pyromancer_1p_focussed_research_1_skill"))), nullEffect())),
				
				cost = sacrificeSelfCost
			}),
		},
        layout = createLayout({
            name = "Phoenix Flames",	
            art = "art/epicart/flames_of_furios",
			frame = "frames/wizard_cardframe",
            xmlText = format([[<vlayout>
            <hlayout flexibleheight="2">
                <box flexiblewidth="0.2"/>
                <tmpro text="{scrap}" fontsize="40" flexiblewidth="1"/>
                <box flexiblewidth="0"/>
                <vlayout flexiblewidth="6">
                    <box flexibleheight="0.2"/>
                    <tmpro text="{0}{combat}{health_6}
&lt;size=65%&gt;Flip your skill to Afterburn.

&lt;size=50%&gt;{combat} gained starts at {combat_7}
and increases with each use of your skill." fontsize="32" flexibleheight="3"/>

                </vlayout>
            </hlayout>
        </vlayout>]], 
		{ getCounter("conflagration_1p") })
        }),
        layoutPath  = "art/epicart/flames_of_furios",
	})
end	

--5c Spirit of the Phoenix
function pyromancer_spirit_of_the_phoenix_1p_carddef()
	return createHeroAbilityDef({
		id = "conflagration_1p",
		name = "Spirit of the Phoenix",
		types = { heroAbilityType },
        abilities = {
			createAbility({
				id = "conflagration_1pActivate",
				trigger = uiTrigger,
				promptType = showPrompt,
				layout = createLayout({
            name = "Spirit of the Phoenix",	
            art = "art/t_darian_war_mage",
            xmlText = format([[<vlayout>
            <hlayout flexibleheight="2">
                <box flexiblewidth="0.2"/>
                <tmpro text="{scrap}" fontsize="40" flexiblewidth="1"/>
                <box flexiblewidth="0"/>
                <vlayout flexiblewidth="6">
                    <box flexibleheight="0.2"/>
                    <tmpro text="{combat}{health_12}
&lt;size=65%&gt;Flip your skill to Afterburn.

&lt;size=50%&gt;{combat} gained starts at {combat_5}
and increases with each use of your skill." fontsize="32" flexibleheight="3"/>

                </vlayout>
            </hlayout>
        </vlayout>]], 
		{ getCounter("conflagration_1p") })
        }),
				effect = gainCombatEffect(getCounter("conflagration_1p")).seq(gainHealthEffect(11))
				.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardName("pyromancer_1p_reckless_research_1_skill")).count().gte(1),createCardEffect(pyromancer_after_burn_3a_carddef(), currentSkillsLoc), nullEffect()))
				.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardName("pyromancer_1p_reckless_research_1_skill")).count().gte(1),sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("pyromancer_1p_reckless_research_1_skill"))), nullEffect()))
				.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardName("pyromancer_1p_obsessive_research_1_skill")).count().gte(1),createCardEffect(pyromancer_after_burn_3b_carddef(), currentSkillsLoc), nullEffect()))
				.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardName("pyromancer_1p_obsessive_research_1_skill")).count().gte(1),sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("pyromancer_1p_obsessive_research_1_skill"))), nullEffect()))
				.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardName("pyromancer_1p_focussed_research_1_skill")).count().gte(1),createCardEffect(pyromancer_after_burn_3c_carddef(), currentSkillsLoc), nullEffect()))
				.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardName("pyromancer_1p_focussed_research_1_skill")).count().gte(1),sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("pyromancer_1p_focussed_research_1_skill"))), nullEffect())),

				cost = sacrificeSelfCost
			}),
		},
        layout = createLayout({
            name = "Spirit of the Phoenix",	
            art = "art/t_darian_war_mage",
			frame = "frames/wizard_cardframe",
            xmlText = format([[<vlayout>
            <hlayout flexibleheight="2">
                <box flexiblewidth="0.2"/>
                <tmpro text="{scrap}" fontsize="40" flexiblewidth="1"/>
                <box flexiblewidth="0"/>
                <vlayout flexiblewidth="6">
                    <box flexibleheight="0.2"/>
                    <tmpro text="{0}{combat}{health_11}
&lt;size=65%&gt;Flip your skill to Afterburn.

&lt;size=50%&gt;{combat} gained starts at {combat_9}
and increases with each use of your skill." fontsize="32" flexibleheight="3"/>

                </vlayout>
            </hlayout>
        </vlayout>]], 
		{ getCounter("conflagration_1p") })
        }),
        layoutPath  = "art/t_darian_war_mage",
	})
end	

-- START Ability upgrades 2p
--4a Phoenix Frenzy
function pyromancer_phoenix_frenzy_2p_carddef()
	return createHeroAbilityDef({
		id = "conflagration_2p",
		name = "Phoenix Frenzy",
		types = { heroAbilityType },
        abilities = {
			createAbility({
				id = "conflagration_2pActivate",
				trigger = uiTrigger,
				promptType = showPrompt,
				layout = createLayout({
            name = "Phoenix Frenzy",	
            art = "art/epicart/fireball",
            xmlText = format([[<vlayout>
            <hlayout flexibleheight="2">
                <box flexiblewidth="0.2"/>
                <tmpro text="{scrap}" fontsize="40" flexiblewidth="1"/>
                <box flexiblewidth="0"/>
                <vlayout flexiblewidth="6">
                    <box flexibleheight="0.2"/>
                    <tmpro text="{0}{combat}
&lt;size=65%&gt;Flip your skill to Afterburn.

&lt;size=50%&gt;{combat} gained starts at {combat_7}
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
            name = "Phoenix Frenzy",	
            art = "art/epicart/fireball",
			frame = "frames/wizard_cardframe",
            xmlText = format([[<vlayout>
            <hlayout flexibleheight="2">
                <box flexiblewidth="0.2"/>
                <tmpro text="{scrap}" fontsize="40" flexiblewidth="1"/>
                <box flexiblewidth="0"/>
                <vlayout flexiblewidth="6">
                    <box flexibleheight="0.2"/>
                    <tmpro text="{0}{combat}
&lt;size=65%&gt;Flip your skill to Afterburn.

&lt;size=50%&gt;{combat} gained starts at {combat_7}
and increases with each use of your skill." fontsize="32" flexibleheight="3"/>

                </vlayout>
            </hlayout>
        </vlayout>]], 
		{ getCounter("conflagration_2p") })
        }),
        layoutPath  = "art/epicart/fireball",
	})
end	

--5a Phoenix Fury
function pyromancer_phoenix_fury_2p_carddef()
	return createHeroAbilityDef({
		id = "conflagration_2p",
		name = "Phoenix Fury",
		types = { heroAbilityType },
        abilities = {
			createAbility({
				id = "conflagration_2pActivate",
				trigger = uiTrigger,
				promptType = showPrompt,
				layout = createLayout({
            name = "Phoenix Fury",	
            art = "art/t_pillar_of_fire",
            xmlText = format([[<vlayout>
            <hlayout flexibleheight="2">
                <box flexiblewidth="0.2"/>
                <tmpro text="{scrap}" fontsize="40" flexiblewidth="1"/>
                <box flexiblewidth="0"/>
                <vlayout flexiblewidth="6">
                    <box flexibleheight="0.2"/>
                    <tmpro text="{0}{combat}}
&lt;size=65%&gt;Flip your skill to Afterburn.

&lt;size=50%&gt;{combat} gained starts at {combat_9}
and increases with each use of your skill." fontsize="32" flexibleheight="3"/>

                </vlayout>
            </hlayout>
        </vlayout>]], 
		{ getCounter("conflagration_2p") })
        }),
				effect = gainCombatEffect(getCounter("conflagration_2p"))
				.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardName("pyromancer_2p_reckless_research_1_skill")).count().gte(1),createCardEffect(pyromancer_after_burn_3a_carddef(), currentSkillsLoc), nullEffect()))
				.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardName("pyromancer_2p_reckless_research_1_skill")).count().gte(1),sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("pyromancer_2p_reckless_research_1_skill"))), nullEffect()))
				.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardName("pyromancer_2p_obsessive_research_1_skill")).count().gte(1),createCardEffect(pyromancer_after_burn_3b_carddef(), currentSkillsLoc), nullEffect()))
				.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardName("pyromancer_2p_obsessive_research_1_skill")).count().gte(1),sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("pyromancer_2p_obsessive_research_1_skill"))), nullEffect()))
				.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardName("pyromancer_2p_focussed_research_1_skill")).count().gte(1),createCardEffect(pyromancer_after_burn_3c_carddef(), currentSkillsLoc), nullEffect()))
				.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardName("pyromancer_2p_focussed_research_1_skill")).count().gte(1),sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("pyromancer_2p_focussed_research_1_skill"))), nullEffect())),

				cost = sacrificeSelfCost
			}),
		},
        layout = createLayout({
            name = "Phoenix Fury",	
            art = "art/t_pillar_of_fire",
			frame = "frames/wizard_cardframe",
            xmlText = format([[<vlayout>
            <hlayout flexibleheight="2">
                <box flexiblewidth="0.2"/>
                <tmpro text="{scrap}" fontsize="40" flexiblewidth="1"/>
                <box flexiblewidth="0"/>
                <vlayout flexiblewidth="6">
                    <box flexibleheight="0.2"/>
                    <tmpro text="{0}{combat}
&lt;size=65%&gt;Flip your skill to Afterburn.

&lt;size=50%&gt;{combat} gained starts at {combat_9}
and increases with each use of your skill." fontsize="32" flexibleheight="3"/>

                </vlayout>
            </hlayout>
        </vlayout>]], 
		{ getCounter("conflagration_2p") })
        }),
        layoutPath  = "art/t_pillar_of_fire",
	})
end	

--4b Phoenix Flare
function pyromancer_phoenix_flare_2p_carddef()
	return createHeroAbilityDef({
		id = "conflagration_2p",
		name = "Phoenix Flare",
		types = { heroAbilityType },
        abilities = {
			createAbility({
				id = "conflagration_2pActivate",
				trigger = uiTrigger,
				promptType = showPrompt,
				layout = createLayout({
            name = "Phoenix Flare",	
            art = "art/epicart/ascendant_pyromancer",
            xmlText = format([[<vlayout>
            <hlayout flexibleheight="2">
                <box flexiblewidth="0.2"/>
                <tmpro text="{scrap}" fontsize="40" flexiblewidth="1"/>
                <box flexiblewidth="0"/>
                <vlayout flexiblewidth="6">
                    <box flexibleheight="0.2"/>
                    <tmpro text="{0}{combat}{health_6}
&lt;size=65%&gt;Flip your skill to Afterburn.

&lt;size=50%&gt;{combat} gained starts at {combat_5}
and increases with each use of your skill." fontsize="32" flexibleheight="3"/>

                </vlayout>
            </hlayout>
        </vlayout>]], 
		{ getCounter("conflagration_2p") })
        }),
				effect = gainCombatEffect(getCounter("conflagration_2p")).seq(gainHealthEffect(6))
				.seq(sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("pyromancer_2p_fuel_1_skill"))))
				.seq(createCardEffect(pyromancer_after_burn_carddef(), currentSkillsLoc)),
				cost = sacrificeSelfCost
			}),
		},
        layout = createLayout({
            name = "Phoenix Flare",	
            art = "art/epicart/ascendant_pyromancer",
			frame = "frames/wizard_cardframe",
            xmlText = format([[<vlayout>
            <hlayout flexibleheight="2">
                <box flexiblewidth="0.2"/>
                <tmpro text="{scrap}" fontsize="40" flexiblewidth="1"/>
                <box flexiblewidth="0"/>
                <vlayout flexiblewidth="6">
                    <box flexibleheight="0.2"/>
                    <tmpro text="{0}{combat}{health_6}
&lt;size=65%&gt;Flip your skill to Afterburn.

&lt;size=50%&gt;{combat} gained starts at {combat_5}
and increases with each use of your skill." fontsize="32" flexibleheight="3"/>

                </vlayout>
            </hlayout>
        </vlayout>]], 
		{ getCounter("conflagration_2p") })
        }),
        layoutPath  = "art/epicart/ascendant_pyromancer",
	})
end	

--5b Phoenix Flames
function pyromancer_phoenix_flames_2p_carddef()
	return createHeroAbilityDef({
		id = "conflagration_2p",
		name = "Phoenix Flames",
		types = { heroAbilityType },
        abilities = {
			createAbility({
				id = "conflagration_2pActivate",
				trigger = uiTrigger,
				promptType = showPrompt,
				layout = createLayout({
            name = "Phoenix Flames",	
            art = "art/epicart/flames_of_furios",
            xmlText = format([[<vlayout>
            <hlayout flexibleheight="2">
                <box flexiblewidth="0.2"/>
                <tmpro text="{scrap}" fontsize="40" flexiblewidth="1"/>
                <box flexiblewidth="0"/>
                <vlayout flexiblewidth="6">
                    <box flexibleheight="0.2"/>
                    <tmpro text="{0}{combat}{health_6}
&lt;size=65%&gt;Flip your skill to Afterburn.

&lt;size=50%&gt;{combat} gained starts at {combat_7}
and increases with each use of your skill." fontsize="32" flexibleheight="3"/>

                </vlayout>
            </hlayout>
        </vlayout>]], 
		{ getCounter("conflagration_2p") })
        }),
				effect = gainCombatEffect(getCounter("conflagration_2p")).seq(gainHealthEffect(6))
				.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardName("pyromancer_2p_reckless_research_1_skill")).count().gte(1),createCardEffect(pyromancer_after_burn_3a_carddef(), currentSkillsLoc), nullEffect()))
				.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardName("pyromancer_2p_reckless_research_1_skill")).count().gte(1),sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("pyromancer_2p_reckless_research_1_skill"))), nullEffect()))
				.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardName("pyromancer_2p_obsessive_research_1_skill")).count().gte(1),createCardEffect(pyromancer_after_burn_3b_carddef(), currentSkillsLoc), nullEffect()))
				.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardName("pyromancer_2p_obsessive_research_1_skill")).count().gte(1),sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("pyromancer_2p_obsessive_research_1_skill"))), nullEffect()))
				.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardName("pyromancer_2p_focussed_research_1_skill")).count().gte(1),createCardEffect(pyromancer_after_burn_3c_carddef(), currentSkillsLoc), nullEffect()))
				.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardName("pyromancer_2p_focussed_research_1_skill")).count().gte(1),sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("pyromancer_2p_focussed_research_1_skill"))), nullEffect())),
				
				cost = sacrificeSelfCost
			}),
		},
        layout = createLayout({
            name = "Phoenix Flames",	
            art = "art/epicart/flames_of_furios",
			frame = "frames/wizard_cardframe",
            xmlText = format([[<vlayout>
            <hlayout flexibleheight="2">
                <box flexiblewidth="0.2"/>
                <tmpro text="{scrap}" fontsize="40" flexiblewidth="1"/>
                <box flexiblewidth="0"/>
                <vlayout flexiblewidth="6">
                    <box flexibleheight="0.2"/>
                    <tmpro text="{0}{combat}{health_6}
&lt;size=65%&gt;Flip your skill to Afterburn.

&lt;size=50%&gt;{combat} gained starts at {combat_7}
and increases with each use of your skill." fontsize="32" flexibleheight="3"/>

                </vlayout>
            </hlayout>
        </vlayout>]], 
		{ getCounter("conflagration_2p") })
        }),
        layoutPath  = "art/epicart/flames_of_furios",
	})
end	

--5c Spirit of the Phoenix
function pyromancer_spirit_of_the_phoenix_2p_carddef()
	return createHeroAbilityDef({
		id = "conflagration_2p",
		name = "Spirit of the Phoenix",
		types = { heroAbilityType },
        abilities = {
			createAbility({
				id = "conflagration_2pActivate",
				trigger = uiTrigger,
				promptType = showPrompt,
				layout = createLayout({
            name = "Spirit of the Phoenix",	
            art = "art/t_darian_war_mage",
            xmlText = format([[<vlayout>
            <hlayout flexibleheight="2">
                <box flexiblewidth="0.2"/>
                <tmpro text="{scrap}" fontsize="40" flexiblewidth="1"/>
                <box flexiblewidth="0"/>
                <vlayout flexiblewidth="6">
                    <box flexibleheight="0.2"/>
                    <tmpro text="{0}{combat}{health_11}
&lt;size=65%&gt;Flip your skill to Afterburn.

&lt;size=50%&gt;{combat} gained starts at {combat_5}
and increases with each use of your skill." fontsize="32" flexibleheight="3"/>

                </vlayout>
            </hlayout>
        </vlayout>]], 
		{ getCounter("conflagration_2p") })
        }),
				effect = gainCombatEffect(getCounter("conflagration_2p")).seq(gainHealthEffect(11))
				.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardName("pyromancer_2p_reckless_research_1_skill")).count().gte(1),createCardEffect(pyromancer_after_burn_3a_carddef(), currentSkillsLoc), nullEffect()))
				.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardName("pyromancer_2p_reckless_research_1_skill")).count().gte(1),sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("pyromancer_2p_reckless_research_1_skill"))), nullEffect()))
				.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardName("pyromancer_2p_obsessive_research_1_skill")).count().gte(1),createCardEffect(pyromancer_after_burn_3b_carddef(), currentSkillsLoc), nullEffect()))
				.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardName("pyromancer_2p_obsessive_research_1_skill")).count().gte(1),sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("pyromancer_2p_obsessive_research_1_skill"))), nullEffect()))
				.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardName("pyromancer_2p_focussed_research_1_skill")).count().gte(1),createCardEffect(pyromancer_after_burn_3c_carddef(), currentSkillsLoc), nullEffect()))
				.seq(ifElseEffect(selectLoc(currentSkillsLoc).where(isCardName("pyromancer_2p_focussed_research_1_skill")).count().gte(1),sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("pyromancer_2p_focussed_research_1_skill"))), nullEffect())),
				
				cost = sacrificeSelfCost
			}),
		},
        layout = createLayout({
            name = "Spirit of the Phoenix",	
            art = "art/t_darian_war_mage",
			frame = "frames/wizard_cardframe",
            xmlText = format([[<vlayout>
            <hlayout flexibleheight="2">
                <box flexiblewidth="0.2"/>
                <tmpro text="{scrap}" fontsize="40" flexiblewidth="1"/>
                <box flexiblewidth="0"/>
                <vlayout flexiblewidth="6">
                    <box flexibleheight="0.2"/>
                    <tmpro text="{0}{combat}{health_11}
&lt;size=65%&gt;Flip your skill to Afterburn.

&lt;size=50%&gt;{combat} gained starts at {combat_9}
and increases with each use of your skill." fontsize="32" flexibleheight="3"/>

                </vlayout>
            </hlayout>
        </vlayout>]], 
		{ getCounter("conflagration_2p") })
        }),
        layoutPath  = "art/t_darian_war_mage",
	})
end	

function pyromancer_play_with_fire_carddef()
	return createHeroAbilityDef({
		id = "play_with_fire",
		name = "Play With Fire",
		types = { heroAbilityType },
        abilities = {
            createAbility( {
                id = "play_with_fire_ab",
                trigger = uiTrigger,
                activations = singleActivation,
                promptType = showPrompt,
                layout = createLayout({
            name = "Play With Fire",	
            art = "art/t_spreading_sparks",
            xmlText = [[<vlayout>
    <box flexibleheight="9">
        <tmpro text="{combat_2}" fontsize="70"/>
    </box>
 </vlayout>]]
		
        }),
                effect = gainCombatEffect(2),
                cost = sacrificeSelfCost,
            }),
        },
        layout = createLayout({
            name = "Play With Fire",
            art = "art/t_spreading_sparks",
			frame = "frames/wizard_cardframe",
            xmlText = [[<vlayout>
    <box flexibleheight="9">
        <tmpro text="{combat_2}" fontsize="70"/>
    </box>
 </vlayout>]]
 }),
        layoutPath  = "art/t_spreading_sparks",
	})
end	


-- End of Pyro Cards -----------------------------------------------------------------------------------------------------------------------


-- START of Cryomancer Cards  ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function cryomancer_ice_sickle_carddef()
    return createDef(
        {
            id = "cryomancer_ice_sickle",
            name = "Ice Sickle",
            types = {noStealType, actionType},
            acquireCost = 0,
            cardTypeLabel = "Action",
            playLocation = castPloc,
            abilities = {
                createAbility({
                        id = "cryomancer_ice_sickle",
                        layout = cardLayout,
                        effect = gainCombatEffect(2),
                        trigger = autoTrigger,
                        tags = {}
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Ice Sickle",
                    art = "art/t_longsword",
                    frame = "frames/wizard_cardframe",
                    xmlText=[[
<vlayout>
    <box flexibleheight="7">
        <tmpro text="{combat_2}" fontsize="42"/>
    </box>
<divider/>
    <box flexibleheight="3">
        <tmpro text="Prepare for the winter harvest." fontsize="18" fontstyle="italic"/>
    </box>
</vlayout>
					]],
                }
            )
        }
    )
end

function cryomancer_frostwulf_carddef()
--This is a token champion, that self-sacrifices when it leaves play
    return createChampionDef(
        {
            id = "cryomancer_frostwulf",
            name = "Frostwulf",
			types = {championType, nostealType },
            acquireCost = 0,
            health = 1,
            isGuard = false,
            abilities = {
			--base ability
                createAbility(
                    {
                        id = "frostwulf_main",
                        trigger = autoTrigger,
                        cost = expendCost,
                        activations = multipleActivations,
                        effect = gainCombatEffect(2)
						
                    }
                )},
            layout = createLayout(
                {
                    name = "Frostwulf",
                    art = "art/epicart/den_mother",
                    frame = "frames/wizard_cardframe",
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
                                                    art = "art/t_wizard_alchemist_s_stone",
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
                                                    art = "art/t_wizard_alchemist_s_stone",
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
                    art = "art/t_wizard_alchemist_s_stone",
                    frame = "frames/wizard_cardframe",
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
                    frame = "frames/wizard_cardframe",
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


--Upgrade Cards
-- Level 5
function cryomancer_deep_freeze_carddef()
    return createDef(
        {
            id = "cryomancer_deep_freeze",
            name = "Deep Freeze",
            types = {noStealType, actionType},
            acquireCost = 0,
            cardTypeLabel = "Action",
            playLocation = castPloc,
            abilities = {
                createAbility({
                        id = "cryomancer_deep_freeze",
                        layout = cardLayout,
                        effect = expendTarget().apply(selectLoc(loc(oppPid, inPlayPloc))).seq(damageTarget(1).apply(selectLoc(loc(oppPid, inPlayPloc)))).seq(gainCombatEffect(1)),
                        trigger = autoTrigger,
                        tags = {}
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Deep Freeze",
                    art = "art/epicart/polar_shock",
                    frame = "frames/wizard_cardframe",
                    xmlText=[[
<vlayout>
    <box flexibleheight="2">
        <tmpro text="{combat_1}" fontsize="50"/>
    </box>
	<box flexibleheight="2">
        <tmpro text="Expend and deal 1 damage to all of opponent's  champions." fontsize="22" />
    </box>
</vlayout>
					]],
                }
            )
        }
    )
end


function cryomancer_ice_sickles_carddef()
    return createDef(
        {
            id = "cryomancer_ice_sickles",
            name = "Ice Sickles",
            types = {noStealType, actionType},
            acquireCost = 0,
            cardTypeLabel = "Action",
            playLocation = castPloc,
            abilities = {
                createAbility({
                        id = "cryomancer_ice_sickles",
                        layout = cardLayout,
                        effect = gainCombatEffect(2)
								.seq(gainCombatEffect(selectLoc(loc(currentPid, inPlayPloc)).count())),
                        trigger = autoTrigger,
                        tags = {}
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Ice Sickles",
                    art = "art/epicart/shock_trooper",
                    frame = "frames/wizard_cardframe",
                    xmlText=[[
<vlayout>
    <box flexibleheight="7">
        <tmpro text="{combat_2}" fontsize="42"/>
    </box>

<box flexibleheight="7">
        <tmpro text="+{combat_1} for each champion you have in play" fontsize="22"/>
    </box>
<divider/>
    <box flexibleheight="3">
        <tmpro text="Welcome to the harvest." fontsize="18" fontstyle="italic"/>
    </box>
</vlayout>
					]],
                }
            )
        }
    )
end


-- Level 7
function cryomancer_cold_snap_carddef()
    return createDef(
        {
            id = "cryomancer_cold_snap",
            name = "Cold Snap",
            types = {noStealType, actionType},
            acquireCost = 0,
            cardTypeLabel = "Action",
            playLocation = castPloc,
            abilities = {
                createAbility({
                        id = "cryomancer_cold_snap",
                        layout = cardLayout,
                        effect = drawCardsEffect(1)
						.seq(hitOpponentEffect(selectLoc(loc(oppPid, deckPloc)).union(selectLoc(loc(oppPid, discardPloc))).union(selectLoc(loc(oppPid, handPloc))).where(isCardName("cryomancer_frostbite")).count())),
                        trigger = autoTrigger,
                        tags = {}
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Cold Snap",
                    art = "art/epicart/ice_drake",
                    frame = "frames/wizard_cardframe",
                    xmlText=[[
<vlayout>
    <box flexibleheight="1">
        <tmpro text="Draw 1.
Target opponent takes 1 damage for each Frostbite card in their hand/deck/discard pile." fontsize="24" />
    </box>
</vlayout>
					]],
                }
            )
        }
    )
end

function cyromancer_polarmour_carddef()
    return createDef(
        {
            id = "cyromancer_polarmour",
            name = "Polarmour",
            types = {noStealType, actionType},
            acquireCost = 0,
            cardTypeLabel = "Action",
            playLocation = castPloc,
            abilities = {
			createAbility({
                id="cyromancer_polarmour",
                trigger= autoTrigger,
				activations = singleActivations,
                effect = drawCardsEffect(1)
					.seq(pushTargetedEffect({
												desc = "Select a champion",
												validTargets = selectLoc(currentInPlayLoc).where(isCardChampion()),
												min = 0,
												max = 1,
												targetEffect = grantHealthTarget(1, { leavesPlayExpiry }, moveTarget(loc(ownerPid, discardPloc)).apply(selectSource()).seq(hitSelfEffect(3)), "shield")			
												}))
					.seq(moveTarget(asidePloc).apply(selectSource())),

            })
            },
            layout = createLayout(
                {
                    name = "Polarmour",
                    art = "art/epicart/force_field",
                    frame = "frames/wizard_cardframe",
                    xmlText=[[
<vlayout>
    <box flexibleheight="1">
        <tmpro text="Draw 1.
Attach this to a friendly champion. It has +1{shield} and when stunned, target opponent takes 3 damage." fontsize="22" />
    </box>
</vlayout>
					]],
                }
            )
        }
    )
end


-- Level 11
function cryomancer_eternal_frost_carddef()
    return createDef(
        {
            id = "cryomancer_eternal_frost",
            name = "Eternal Frost",
            types = {noStealType, actionType},
            acquireCost = 0,
            cardTypeLabel = "Action",
            playLocation = castPloc,
            abilities = {
                createAbility({
                        id = "cryomancer_eternal_frost",
                        layout = cardLayout,
                        effect = drawCardsEffect(1)
						.seq(createCardEffect(cryomancer_frostbite_carddef(), loc(oppPid, discardPloc))),
                        trigger = autoTrigger,
                        tags = {}
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Eternal Frost",
                    art = "art/epicart/forced_exile",
                    frame = "frames/wizard_cardframe",
                    xmlText=[[
<vlayout>
    <box flexibleheight="7">
        <tmpro text="Draw 1

Add a frostbite card to opponent's discard." fontsize="24"/>
    </box>
</vlayout>
					]],
                }
            )
        }
    )
end

function cyromancer_cryonics_carddef()

    return createDef(
        {
            id = "cyromancer_cryonics",
            name = "Cryonics",
            types = {noStealType, actionType},
            acquireCost = 0,
            cardTypeLabel = "Action",
            playLocation = castPloc,
            abilities = {
			createAbility({
                id="cyromancer_cryonics",
                trigger= autoTrigger,
				activations = singleActivations,
				effect = pushTargetedEffect({
												  desc = "Put a champion from your discard pile to the bottom of your deck. It gets +3{shield} until it leaves play.",
												  min=0,
												  max=1,
												  validTargets = selectLoc(loc(currentPid, discardPloc)).where(isCardChampion()),
												  targetEffect = grantHealthTarget(3, { leavesPlayExpiry }, nullEffect(), "shield").seq(moveToBottomDeckTarget(false, 0)).seq(drawCardsEffect(1))
												  })
						

            })
            },
            layout = createLayout(
                {
                    name = "Cryonics",
                    art = "art/epicart/transfigure",
                    frame = "frames/wizard_cardframe",
                    xmlText=[[
<vlayout>
    <box flexibleheight="1">
        <tmpro text="Put a champion from your discard pile to the bottom of your deck. It gets +3{shield} until it leaves play.

Draw 1." fontsize="22" />
    </box>
</vlayout>
					]],
                }
            )
        }
    )
end


-- Armour

function cryomancer_ice_mail_carddef()

    local priceBuff = getCostDiscountBuff("brewmaster_serve_the_strong_stuff_buff", 1, selectSavedTargets("Frozen Asset"))
	
	    local discountCreator = createGlobalBuff({
        id="ice_mail_discount",
        name = "Ice Mail",
        abilities = {
            createAbility({
                id="ice_mail_buff",
                trigger = startOfTurnTrigger,
                effect = createCardEffect(priceBuff, loc(currentPid, buffsPloc)).seq(clearTargets("Frozen Asset")).seq(sacrificeSelf())
            })
        },
		buffDetails = createBuffDetails({
					name = "Ice Mail",
                    art = "art/epicart/crystal_golem",
					text = "<size=65%><sprite name=\"gold_1\"> discount for 1 card in the market marked as a Frozen Asset."
							})
		
    })
	
    local buffCreator = createGlobalBuff({
        id="ice_mail_buff",
        name = "Ice Mail",
        abilities = {
            createAbility({
                id="ice_mail_buff",
                trigger = startOfTurnTrigger,
                effect = addSlotToTarget(createSlot({ id = slotNoBuy, expiresArray = { endOfTurnExpiry } })).apply(selectSavedTargets("Frozen Asset")).seq(sacrificeSelf())
				
            })
        },
		buffDetails = createBuffDetails({
					name = "Ice Mail",
                    art = "art/epicart/crystal_golem",
					text = "<size=65%>One card has become a Frozen Asset. You cannot buy it this turn."
							})
		
    })

 local cardLayout = createLayout({
        name = "Ice Mail",
        art = "art/epicart/crystal_golem",
        frame = "frames/wizard_cardframe",
        xmlText=[[
					
<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{requiresHealth_40}" fontsize="60"/>
        </box>
        <box flexiblewidth="5">
            <tmpro text="Choose a card in the market. Your opponent can't buy it on their next turn. It will cost you {gold_1} less to buy on your next turn." fontsize="20" />
        </box>
    </hlayout>
</vlayout>
					]]
    })
	
    return createMagicArmorDef(
        {
            id = "cryomancer_ice_mail",
            name = "Ice Mail",
            types = {magicArmorType, noStealType, itemType},
			            acquireCost = 0,
            cardTypeLabel = "Armour",
			layout = cardLayout,
			layoutPath  = "art/epicart/crystal_golem",
            playLocation = castPloc,
            abilities = {
				createAbility(
                    {
                        id = "cryomancer_ice_mail",
						cost = expendCost,
						trigger = uiTrigger,
						promptType = showPrompt,
						layout = cardLayout,
                        activations = singleActivations,
						effect = pushTargetedEffect({
												  desc = "Freeze a card in the market. Your opponent can't buy it next turn. It will cost you 1 gold less to buy on your next turn.",
												  min=1,
												  max=1,
												  validTargets = selectLoc(centerRowLoc),
												  targetEffect = saveTarget("Frozen Asset")
																.seq(createCardEffect(buffCreator, loc(oppPid, buffsPloc)))
																.seq(createCardEffect(discountCreator, loc(currentPid, buffsPloc)))
																
																
						}),
				
						check= minHealthCurrent(40),
                        tags = {}
                    }
                ),
	
            },
            
			
        }
    )
end

function cryomancer_ice_crown_carddef()

 local cardLayout = createLayout({
        name = "Ice Crown",
        art = "art/classes/necromancer/rotting_crown",
        frame = "frames/wizard_cardframe",
        xmlText=[[
					
<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{requiresHealth_35}" fontsize="60"/>
        </box>
        <box flexiblewidth="5">
            <tmpro text="If you stunned a champion or played a champion this turn, draw 1." fontsize="20" />
        </box>
    </hlayout>
</vlayout>
					]]
    })
	
    return createMagicArmorDef(
        {
            id = "cryomancer_ice_crown",
            name = "Ice crown",
            types = {magicArmorType, noStealType, itemType},
			            acquireCost = 0,
            cardTypeLabel = "Armour",
			layout = cardLayout,
			layoutPath  = "art/classes/necromancer/rotting_crown",
            playLocation = castPloc,
            abilities = {
				createAbility(
                    {
                        id = "cryomancer_ice_crown",
						cost = expendCost,
						trigger = uiTrigger,
						promptType = showPrompt,
						layout = cardLayout,
                        activations = singleActivations,
						effect = drawCardsEffect(1),
						check= minHealthCurrent(35)
						.And(selectLoc(loc(oppPid, discardPloc)).where(isCardChampion()).where(isCardStunned()).count().gte(1))
						.Or(minHealthCurrent(35)
						.And(getChampionsPlayedThisTurn().gte(1))),
                        tags = {}
                    }
                ),
	
            },
            
			
        }
    )
end

-- Skills

--START skills - Frostbite (for level 3 heroes) (Skill-1)
function cryomancer_frostbiteskill_carddef()
    local cardLayout = createLayout({
        name = "Frostbite",
        art = "art/epicart/frost_giant",
        frame = "frames/wizard_cardframe",
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
                    frame = "frames/wizard_cardframe",
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
 
-- START Rapid Frostbite (Skill-2a)
function cryomancer_rapid_frostbiteskill_carddef()
    local cardLayout = createLayout({
        name = "Rapid Frostbite",
        art = "art/epicart/frost_giant",
        frame = "frames/wizard_cardframe",
        xmlText = 
		[[
		<vlayout>
    <hlayout flexibleheight="2">
            <icon text="{expend_2}" fontsize="72" flexiblewidth="0"/>
            <tmpro text="Add a frostbite card to the top of opponent's deck." fontsize="20" flexiblewidth="10" />
    </hlayout>
    <divider/>
    <hlayout flexibleheight="2">
            <tmpro text="Frostbite card: {scrap} {health_-1}" fontsize="20" flexiblewidth="10" />
    </hlayout> 
</vlayout>
		]]
    })

    return createSkillDef({
        id = "cryomancer_deep_frostbiteskill",
        name = "Rapid Frostbite",
        types = { skillType },
        layout = cardLayout,
        layoutPath = "art/epicart/frost_giant",
        abilities = {
            createAbility({
                id = "cryomancer_rapid_frostbiteskill_ab",
                trigger = uiTrigger,
                activations = singleActivation,
                layout = cardLayout,
				promptType = showPrompt,
                effect = createCardEffect(cryomancer_frostbite_carddef(), loc(oppPid, deckPloc)),
				cost = goldCost(2),
            }),
        }
        
    })
end

-- START Deep Frostbite (Skill-2b)
function cryomancer_deep_frostbiteskill_carddef()
    local cardLayout = createLayout({
        name = "Deep Frostbite",
        art = "art/epicart/frost_giant",
        frame = "frames/wizard_cardframe",
        xmlText = 
		[[
		<vlayout>
    <hlayout flexibleheight="2">
            <icon text="{expend_2}" fontsize="72" flexiblewidth="0"/>
            <tmpro text="Add 2 frostbite cards to opponent's discard." fontsize="20" flexiblewidth="10" />
    </hlayout>
    <divider/>
    <hlayout flexibleheight="2">
            <tmpro text="Frostbite card: {scrap} {health_-1}" fontsize="20" flexiblewidth="10" />
    </hlayout> 
</vlayout>
		]]
    })

    return createSkillDef({
        id = "cryomancer_deep_frostbiteskill",
        name = "Deep Frostbite",
        types = { skillType },
        layout = cardLayout,
        layoutPath = "art/epicart/frost_giant",
        abilities = {
            createAbility({
                id = "cryomancer_deep_frostbiteskill_ab",
                trigger = uiTrigger,
                activations = singleActivation,
                layout = cardLayout,
				promptType = showPrompt,
                effect = createCardEffect(cryomancer_frostbite_carddef(), loc(oppPid, discardPloc)).seq(createCardEffect(cryomancer_frostbite_carddef(), loc(oppPid, discardPloc))),
				cost = goldCost(2),
            }),
        }
        
    })
end



-- START Instant Frostbite (Skill-3a)
function cryomancer_instant_frostbiteskill_carddef()
    local cardLayout = createLayout({
        name = "Instant Frostbite",
        art = "art/epicart/frost_giant",
        frame = "frames/wizard_cardframe",
        xmlText = 
		[[
		<vlayout>
    <hlayout flexibleheight="2">
            <icon text="{expend_1}" fontsize="72" flexiblewidth="0"/>
            <tmpro text="Add a frostbite card to the top of opponent's deck." fontsize="20" flexiblewidth="10" />
    </hlayout>
    <divider/>
    <hlayout flexibleheight="2">
            <tmpro text="Frostbite card: {scrap} {health_-1}" fontsize="20" flexiblewidth="10" />
    </hlayout> 
</vlayout>
		]]
    })

    return createSkillDef({
        id = "cryomancer_instant_frostbiteskill",
        name = "Instant Frostbite",
        types = { skillType },
        layout = cardLayout,
        layoutPath = "art/epicart/frost_giant",
        abilities = {
            createAbility({
                id = "cryomancer_instant_frostbiteskill_ab",
                trigger = uiTrigger,
                activations = singleActivation,
                layout = cardLayout,
				promptType = showPrompt,
                effect = createCardEffect(cryomancer_frostbite_carddef(), loc(oppPid, castPloc)).seq(moveTargetWithLocAndPlayer(deckPloc, oppPid).apply(selectLoc(loc(oppPid, castPloc)).where(isCardName("cryomancer_frostbite")).take(1))),
				cost = goldCost(1),
            }),
        }
        
    })
end

-- START Severe Frostbite (Skill-3b)
function cryomancer_severe_frostbiteskill_carddef()
    local cardLayout = createLayout({
        name = "Severe Frostbite",
        art = "art/epicart/frost_giant",
        frame = "frames/wizard_cardframe",
        xmlText = 
		[[
		<vlayout>
    <hlayout flexibleheight="2">
            <icon text="{expend_2}" fontsize="72" flexiblewidth="0"/>
            <tmpro text="Add 1 frostbite card to opponent's discard and another to the top of their deck." fontsize="20" flexiblewidth="10" />
    </hlayout>
    <divider/>
    <hlayout flexibleheight="2">
            <tmpro text="Frostbite card: {scrap} {health_-1}" fontsize="20" flexiblewidth="10" />
    </hlayout> 
</vlayout>
		]]
    })

    return createSkillDef({
        id = "cryomancer_severe_frostbiteskill",
        name = "Severe Frostbite",
        types = { skillType },
        layout = cardLayout,
        layoutPath = "art/epicart/frost_giant",
        abilities = {
            createAbility({
                id = "cryomancer_severe_frostbiteskill_ab",
                trigger = uiTrigger,
                activations = singleActivation,
                layout = cardLayout,
				promptType = showPrompt,
                effect = createCardEffect(cryomancer_frostbite_carddef(), loc(oppPid, castPloc)).seq(moveTargetWithLocAndPlayer(deckPloc, oppPid).apply(selectLoc(loc(oppPid, castPloc)).where(isCardName("cryomancer_frostbite")).take(1)))
				.seq(createCardEffect(cryomancer_frostbite_carddef(), loc(oppPid, discardPloc))),
				cost = goldCost(2),
            }),
        }
        
    })
end

-- START Extreme Frostbite (Skill-3c)
function cryomancer_extreme_frostbiteskill_carddef()
    local cardLayout = createLayout({
        name = "Extreme Frostbite",
        art = "art/epicart/frost_giant",
        frame = "frames/wizard_cardframe",
        xmlText = 
		[[
		<vlayout>
    <hlayout flexibleheight="2">
            <icon text="{expend_2}" fontsize="72" flexiblewidth="0"/>
            <tmpro text="{combat_2}
&lt;size=65%&gt;Add 2 frostbite cards to opponent's discard." fontsize="30" flexiblewidth="10" />
    </hlayout>
    <divider/>
    <hlayout flexibleheight="2">
            <tmpro text="Frostbite card: {scrap} {health_-1}" fontsize="20" flexiblewidth="10" />
    </hlayout> 
</vlayout>
		]]
    })

    return createSkillDef({
        id = "cryomancer_extreme_frostbiteskill",
        name = "Extreme Frostbite",
        types = { skillType },
        layout = cardLayout,
        layoutPath = "art/epicart/frost_giant",
        abilities = {
            createAbility({
                id = "cryomancer_extreme_frostbiteskill_ab",
                trigger = uiTrigger,
                activations = singleActivation,
                layout = cardLayout,
				promptType = showPrompt,
                effect = createCardEffect(cryomancer_frostbite_carddef(), loc(oppPid, discardPloc)).seq(createCardEffect(cryomancer_frostbite_carddef(), loc(oppPid, discardPloc))).seq(gainCombatEffect(2)),
				cost = goldCost(2),
            }),
        }
        
    })
end


-- Abilities

local CryoFogBuff = createGlobalBuff({
        id="cryomancer_fog_ability",
        name = "Fog",
        abilities = {
            createAbility({
                id="cryomancer_fog_ability",
                trigger = deckShuffledTrigger,
                effect = moveToBottomDeckTarget(false, 0).apply(selectSavedTargets("Fog")).seq(clearTargets("Fog")).seq(sacrificeSelf())
            })
        },
		buffDetails = createBuffDetails({
					name = "Fog",
                    art = "art/t_blow_away",
					text = "One of your cards has been set aside. It will be placed on the bottom of your deck when you next shuffle."
							})
    })

local CryoHvFogBuff = createGlobalBuff({
        id="cryomancer_heavy_fog_ability",
        name = "Heavy Fog",
        abilities = {
            createAbility({
                id="cryomancer_heavy_fog_ability",
                trigger = deckShuffledTrigger,
                effect = moveToBottomDeckTarget(false, 0).apply(selectSavedTargets("Heavy Fog")).seq(clearTargets("Heavy Fog")).seq(sacrificeSelf())
            })
        },
		buffDetails = createBuffDetails({
					name = "Heavy Fog",
                    art = "art/t_blow_away",
					text = "One of your cards has been set aside. It will be placed on the bottom of your deck when you next shuffle."
							})
    })

local CryoFrFogBuff = createGlobalBuff({
        id="cryomancer_freezing_fog_ability",
        name = "Freezing Fog",
        abilities = {
            createAbility({
                id="cryomancer_freezing_fog_ability",
                trigger = deckShuffledTrigger,
                effect = moveToBottomDeckTarget(false, 0).apply(selectSavedTargets("Freezing Fog")).seq(clearTargets("Freezing Fog")).seq(sacrificeSelf())
            })
        },
		buffDetails = createBuffDetails({
					name = "Freezing Fog",
                    art = "art/t_chaotic_gust",
					text = "One of your cards has been set aside. It will be placed on the bottom of your deck when you next shuffle."
							})
    })

local CryoHFBuff = createGlobalBuff({
        id="cryomancer_hoarfrost_ability",
        name = "Hoarfrost",
        abilities = {
            createAbility({
                id="cryomancer_hoarfrost_ability",
                trigger = deckShuffledTrigger,
                effect = moveToBottomDeckTarget(false, 0).apply(selectSavedTargets("Hoarfrost")).seq(clearTargets("Hoarfrost")).seq(sacrificeSelf())
            })
        },
		buffDetails = createBuffDetails({
					name = "Hoarfrost",
                    art = "art/t_chaotic_gust",
					text = "One of your cards has been set aside. It will be placed on the bottom of your deck when you next shuffle."
							})
    })
	
local CryoSSBuff = createGlobalBuff({
        id="cryomancer_snow_sqall_ability",
        name = "Snow Squall",
        abilities = {
            createAbility({
                id="cryomancer_snow_sqall_ability",
                trigger = deckShuffledTrigger,
                effect = moveToBottomDeckTarget(false, 0).apply(selectSavedTargets("Snow Squall")).seq(clearTargets("Snow Squall")).seq(sacrificeSelf())
            })
        },
		buffDetails = createBuffDetails({
					name = "Snow Squall",
                    art = "art/t_chaotic_gust",
					text = "One of your cards has been set aside. It will be placed on the bottom of your deck when you next shuffle."
							})
    })
	
local CryoISBuff = createGlobalBuff({
        id="cryomancer_ice_sheet_ability",
        name = "Ice Sheet",
        abilities = {
            createAbility({
                id="cryomancer_ice_sheet_ability",
                trigger = deckShuffledTrigger,
                effect = moveToBottomDeckTarget(false, 0).apply(selectSavedTargets("Ice Sheet")).seq(clearTargets("Ice Sheet")).seq(sacrificeSelf())
            })
        },
		buffDetails = createBuffDetails({
					name = "Ice Sheet",
                    art = "art/t_chaotic_gust",
					text = "One of your cards has been set aside. It will be placed on the bottom of your deck when you next shuffle."
							})
    })
	
local CryoIFBuff = createGlobalBuff({
        id="cryomancer_ice_floe_ability",
        name = "Ice Floe",
        abilities = {
            createAbility({
                id="cryomancer_ice_floe_ability",
                trigger = deckShuffledTrigger,
                effect = moveToBottomDeckTarget(false, 0).apply(selectSavedTargets("Ice Floe")).seq(clearTargets("Ice Floe")).seq(sacrificeSelf())
            })
        },
		buffDetails = createBuffDetails({
					name = "Ice Floe",
                    art = "art/t_chaotic_gust",
					text = "One of your cards has been set aside. It will be placed on the bottom of your deck when you next shuffle."
							})
    })
	
local CryoPFBuff = createGlobalBuff({
        id="cryomancer_permafrost_ability",
        name = "Permafrost",
        abilities = {
            createAbility({
                id="cryomancer_permafrost_ability",
                trigger = deckShuffledTrigger,
                effect = moveToBottomDeckTarget(false, 0).apply(selectSavedTargets("Permafrost")).seq(clearTargets("Permafrost")).seq(sacrificeSelf())
            })
        },
		buffDetails = createBuffDetails({
					name = "Permafrost",
                    art = "art/t_chaotic_gust",
					text = "One of your cards has been set aside. It will be placed on the bottom of your deck when you next shuffle."
							})
    })
	
--1 Fog
function cryomancer_fog_carddef()
	return createHeroAbilityDef({
		id = "cryomancer_fog",
		name = "Fog",
		types = { heroAbilityType },
        abilities = {
			createAbility({
				id = "fog_Activate",
				trigger = uiTrigger,
				promptType = showPrompt,
				layout = createLayout({
					name = "Fog",
					art = "art/t_blow_away",
					frame = "frames/wizard_cardframe",
					xmlText=[[
					<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{scrap}" fontsize="40"/>
        </box>
        <box flexiblewidth="7">
            <tmpro text="Set aside a card of cost 2{gold} or less in your opponent's discard pile. The next time your opponent shuffles their deck, put that card on the bottom of their deck." fontsize="18" />
        </box>
    </hlayout>
</vlayout>
					]]
				}),
				effect = pushTargetedEffect({
												  desc = "Set aside a card of cost 2 or less from opponent's discard pile.",
												  min=0,
												  max=1,
												  validTargets = selectLoc(loc(oppPid, discardPloc)).where(getCardCost().lte(2)),
												  targetEffect = saveTarget("Fog").seq(moveTarget(sacrificePloc))
																.seq(createCardEffect(CryoFogBuff, loc(oppPid, buffsPloc)))
												  }),
				cost = sacrificeSelfCost
			})
		},
        layout = createLayout({
            name = "Fog",	
            art = "art/t_blow_away",
			frame = "frames/wizard_cardframe",
            xmlText=[[
<vlayout>
    <hlayout flexibleheight="1">
        <box flexiblewidth="1">
            <tmpro text="{scrap}" fontsize="40"/>
        </box>
        <box flexiblewidth="7">
            <tmpro text="Set aside a card of cost 2{gold} or less in your opponent's discard pile. The next time your opponent shuffles their deck, put that card on the bottom of their deck." fontsize="18" />
        </box>
    </hlayout>
</vlayout>
			]]
        }),
        layoutPath  = "art/t_blow_away",
	})
end	

--2 Heavy Fog
function cryomancer_heavy_fog_carddef()
	return createHeroAbilityDef({
		id = "cryomancer_heavy_fog",
		name = "Heavy Fog",
		types = { heroAbilityType },
        abilities = {
			createAbility({
				id = "heavy_fog_Activate",
				trigger = uiTrigger,
				promptType = showPrompt,
				layout = createLayout({
					name = "Heavy Fog",
					art = "art/t_blow_away",
					frame = "frames/wizard_cardframe",
					xmlText=[[
					<vlayout>
    <hlayout flexibleheight="2">
            <icon text="{scrap}" fontsize="32" flexiblewidth="0"/>
            <tmpro text="Put Frostbite card on top of opponent's deck.

Set aside a card of cost 2{gold} or less in your opponent's discard pile. The next time your opponent shuffles their deck, put that card on the bottom of their deck." fontsize="14" flexiblewidth="10" />
    </hlayout>
    <divider/>
    <hlayout flexibleheight="0.5">
            <tmpro text="Frostbite card: {scrap} {health_-1}" fontsize="14" flexiblewidth="10" />
    </hlayout> 
</vlayout>
					]]
				}),
				effect = pushTargetedEffect({
												  desc = "Set aside a card of cost 2 or less from opponent's discard pile.",
												  min=0,
												  max=1,
												  validTargets = selectLoc(loc(oppPid, discardPloc)).where(getCardCost().lte(2)),
												  targetEffect = saveTarget("Heavy Fog").seq(moveTarget(sacrificePloc))
																.seq(createCardEffect(CryoHvFogBuff, loc(oppPid, buffsPloc)))
																.seq(createCardEffect(cryomancer_frostbite_carddef(), loc(oppPid, castPloc))).seq(moveTargetWithLocAndPlayer(deckPloc, oppPid).apply(selectLoc(loc(oppPid, castPloc)).where(isCardName("cryomancer_frostbite")).take(1)))
												  }),
				cost = sacrificeSelfCost
			})
		},
        layout = createLayout({
            name = "Heavy Fog",	
            art = "art/t_blow_away",
			frame = "frames/wizard_cardframe",
            xmlText=[[
<vlayout>
    <hlayout flexibleheight="2">
            <icon text="{scrap}" fontsize="32" flexiblewidth="0"/>
            <tmpro text="Put Frostbite card on top of opponent's deck.

Set aside a card of cost 2{gold} or less in your opponent's discard pile. The next time your opponent shuffles their deck, put that card on the bottom of their deck." fontsize="14" flexiblewidth="10" />
    </hlayout>
    <divider/>
    <hlayout flexibleheight="0.5">
            <tmpro text="Frostbite card: {scrap} {health_-1}" fontsize="14" flexiblewidth="10" />
    </hlayout> 
</vlayout>
			]]
        }),
        layoutPath  = "art/t_blow_away",
	})
end	


--3 Freezing Fog

function cryomancer_freezing_fog_carddef()
	return createHeroAbilityDef({
		id = "cryomancer_freezing_fog",
		name = "Freezing Fog",
		types = { heroAbilityType },
        abilities = {
			createAbility({
				id = "Freezing_fog_Activate",
				trigger = uiTrigger,
				promptType = showPrompt,
				layout = createLayout({
					name = "Freezing Fog",
					art = "art/t_chaotic_gust",
					frame = "frames/wizard_cardframe",
					xmlText=[[
					<vlayout>
    <hlayout flexibleheight="2">
            <icon text="{scrap}" fontsize="32" flexiblewidth="0"/>
            <tmpro text="Put Frostbite card on top of opponent's deck.

Set aside a card of cost 4{gold} or less in your opponent's discard pile. The next time your opponent shuffles their deck, put that card on the bottom of their deck." fontsize="14" flexiblewidth="10" />
    </hlayout>
    <divider/>
    <hlayout flexibleheight="0.5">
            <tmpro text="Frostbite card: {scrap} {health_-1}" fontsize="14" flexiblewidth="10" />
    </hlayout> 
</vlayout>
					]]
				}),
				effect = pushTargetedEffect({
												  desc = "Set aside a card of cost 4 or less from opponent's discard pile.",
												  min=0,
												  max=1,
												  validTargets = selectLoc(loc(oppPid, discardPloc)).where(getCardCost().lte(4)),
												  targetEffect = saveTarget("Freezing Fog").seq(moveTarget(sacrificePloc))
																.seq(createCardEffect(CryoFrFogBuff, loc(oppPid, buffsPloc)))
																.seq(createCardEffect(cryomancer_frostbite_carddef(), loc(oppPid, castPloc))).seq(moveTargetWithLocAndPlayer(deckPloc, oppPid).apply(selectLoc(loc(oppPid, castPloc)).where(isCardName("cryomancer_frostbite")).take(1)))
												  }),
				cost = sacrificeSelfCost
			})
		},
        layout = createLayout({
            name = "Freezing Fog",	
            art = "art/t_chaotic_gust",
			frame = "frames/wizard_cardframe",
            xmlText=[[
<vlayout>
    <hlayout flexibleheight="2">
            <icon text="{scrap}" fontsize="32" flexiblewidth="0"/>
            <tmpro text="Put Frostbite card on top of opponent's deck.

Set aside a card of cost 4{gold} or less in your opponent's discard pile. The next time your opponent shuffles their deck, put that card on the bottom of their deck." fontsize="14" flexiblewidth="10" />
    </hlayout>
    <divider/>
    <hlayout flexibleheight="0.5">
            <tmpro text="Frostbite card: {scrap} {health_-1}" fontsize="14" flexiblewidth="10" />
    </hlayout> 
</vlayout>
			]]
        }),
        layoutPath  = "art/t_chaotic_gust",
	})
end	


-- START Ability upgrades

--4a Hoarfrost
function cryomancer_hoarfrost_carddef()
	return createHeroAbilityDef({
		id = "cryomancer_hoarfrost",
		name = "Hoarfrost",
		types = { heroAbilityType },
        abilities = {
			createAbility({
				id = "hoarfrost_Activate",
				trigger = uiTrigger,
				promptType = showPrompt,
				layout = createLayout({
					name = "Hoarfrost",
					art = "art/t_chaotic_gust",
					frame = "frames/wizard_cardframe",
					xmlText=[[
					<vlayout>
    <hlayout flexibleheight="2">
            <icon text="{scrap}" fontsize="32" flexiblewidth="0"/>
            <tmpro text="Put Frostbite card on top of opponent's deck.

Set aside a card of cost 6{gold} or less in your opponent's discard pile. The next time your opponent shuffles their deck, put that card on the bottom of their deck." fontsize="14" flexiblewidth="10" />
    </hlayout>
    <divider/>
    <hlayout flexibleheight="0.5">
            <tmpro text="Frostbite card: {scrap} {health_-1}" fontsize="14" flexiblewidth="10" />
    </hlayout> 
</vlayout>
					]]
				}),
				effect = pushTargetedEffect({
												  desc = "Set aside a card of cost 6 or less from opponent's discard pile.",
												  min=0,
												  max=1,
												  validTargets = selectLoc(loc(oppPid, discardPloc)).where(getCardCost().lte(6)),
												  targetEffect = saveTarget("Hoarfrost").seq(moveTarget(sacrificePloc))
																.seq(createCardEffect(CryoHFBuff, loc(oppPid, buffsPloc)))
																.seq(createCardEffect(cryomancer_frostbite_carddef(), loc(oppPid, castPloc))).seq(moveTargetWithLocAndPlayer(deckPloc, oppPid).apply(selectLoc(loc(oppPid, castPloc)).where(isCardName("cryomancer_frostbite")).take(1)))
												  }),
				cost = sacrificeSelfCost
			})
		},
        layout = createLayout({
            name = "Hoarfrost",	
            art = "art/t_chaotic_gust",
			frame = "frames/wizard_cardframe",
            xmlText=[[
<vlayout>
    <hlayout flexibleheight="2">
            <icon text="{scrap}" fontsize="32" flexiblewidth="0"/>
            <tmpro text="Put Frostbite card on top of opponent's deck.

Set aside a card of cost 6{gold} or less in your opponent's discard pile. The next time your opponent shuffles their deck, put that card on the bottom of their deck." fontsize="14" flexiblewidth="10" />
    </hlayout>
    <divider/>
    <hlayout flexibleheight="0.5">
            <tmpro text="Frostbite card: {scrap} {health_-1}" fontsize="14" flexiblewidth="10" />
    </hlayout> 
</vlayout>
			]]
        }),
        layoutPath  = "art/t_chaotic_gust",
	})
end	


--5a Snow squall
function cryomancer_snow_squall_carddef()
	return createHeroAbilityDef({
		id = "cryomancer_snow_squall",
		name = "Snow Squall",
		types = { heroAbilityType },
        abilities = {
			createAbility({
				id = "snow_squall_Activate",
				trigger = uiTrigger,
				promptType = showPrompt,
				layout = createLayout({
					name = "Snow Squall",
					art = "art/t_chaotic_gust",
					frame = "frames/wizard_cardframe",
					xmlText=[[
					<vlayout>
    <hlayout flexibleheight="2">
            <icon text="{scrap}" fontsize="32" flexiblewidth="0"/>
            <tmpro text="Put Frostbite card on top of opponent's deck.

Set aside a card of cost 8{gold} or less in your opponent's discard pile. The next time your opponent shuffles their deck, put that card on the bottom of their deck." fontsize="14" flexiblewidth="10" />
    </hlayout>
    <divider/>
    <hlayout flexibleheight="0.5">
            <tmpro text="Frostbite card: {scrap} {health_-1}" fontsize="14" flexiblewidth="10" />
    </hlayout> 
</vlayout>
					]]
				}),
				effect = pushTargetedEffect({
												  desc = "Set aside a card of cost 8 or less from opponent's discard pile.",
												  min=0,
												  max=1,
												  validTargets = selectLoc(loc(oppPid, discardPloc)).where(getCardCost().lte(8)),
												  targetEffect = saveTarget("Snow Squall").seq(moveTarget(sacrificePloc))
																.seq(createCardEffect(CryoSSBuff, loc(oppPid, buffsPloc)))
																.seq(createCardEffect(cryomancer_frostbite_carddef(), loc(oppPid, castPloc))).seq(moveTargetWithLocAndPlayer(deckPloc, oppPid).apply(selectLoc(loc(oppPid, castPloc)).where(isCardName("cryomancer_frostbite")).take(1)))
												  }),
				cost = sacrificeSelfCost
			})
		},
        layout = createLayout({
            name = "Snow Squall",	
            art = "art/t_chaotic_gust",
			frame = "frames/wizard_cardframe",
            xmlText=[[
<vlayout>
    <hlayout flexibleheight="2">
            <icon text="{scrap}" fontsize="32" flexiblewidth="0"/>
            <tmpro text="Put Frostbite card on top of opponent's deck.

Set aside a card of cost 8{gold} or less in your opponent's discard pile. The next time your opponent shuffles their deck, put that card on the bottom of their deck." fontsize="14" flexiblewidth="10" />
    </hlayout>
    <divider/>
    <hlayout flexibleheight="0.5">
            <tmpro text="Frostbite card: {scrap} {health_-1}" fontsize="14" flexiblewidth="10" />
    </hlayout> 
</vlayout>
			]]
        }),
        layoutPath  = "art/t_chaotic_gust",
	})
end	

--4b Ice Floe
function cryomancer_ice_floe_carddef()
    return createDef(
        {
            id = "cryomancer_ice_floe",
            name = "Ice Floe",
			types = {itemType, noSacrifice},
			cardTypeLabel = "item",
			playLocation = castPloc,
            acquireCost = 0,
            abilities = {
                createAbility(
                    {
                        id = "ice_floe_main",
                        trigger = autoTrigger,
                        cost = noCost,
                        activations = singleActivations,
                        effect = nullEffect()
						
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Ice Floe",
                    art = "art/t_heavy_gust",
                    frame = "frames/wizard_cardframe",
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

function cryomancer_ice_floe_ab_carddef()
	return createHeroAbilityDef({
		id = "cryomancer_ice_floe_ab",
		name = "Ice Floe",
		types = { heroAbilityType },
        abilities = {
			createAbility({
				id = "ice_floe_Activate",
				trigger = uiTrigger,
				promptType = showPrompt,
				layout = createLayout({
					name = "Ice Floe",
					art = "art/t_chaotic_gust",
					frame = "frames/wizard_cardframe",
					xmlText=[[
					<vlayout>
    <hlayout flexibleheight="2">
            <icon text="{scrap}" fontsize="32" flexiblewidth="0"/>
            <tmpro text="Set aside a card of cost 4{gold} or less in your opponent's discard pile. The next time your opponent shuffles their deck, put that card on the bottom of their deck.

Put an Ice Floe card on top of opponent's deck." fontsize="14" flexiblewidth="10" />
    </hlayout>
    <divider/>
    <hlayout flexibleheight="0.5">
            <tmpro text="Ice Floe card: Does nothing" fontsize="14" flexiblewidth="10" />
    </hlayout> 
</vlayout>
					]]
				}),
				effect = pushTargetedEffect({
												  desc = "Set aside a card of cost 4 or less from opponent's discard pile.",
												  min=0,
												  max=1,
												  validTargets = selectLoc(loc(oppPid, discardPloc)).where(getCardCost().lte(4)),
												  targetEffect = saveTarget("Ice Floe").seq(moveTarget(sacrificePloc))
																.seq(createCardEffect(CryoIFBuff, loc(oppPid, buffsPloc)))
												  })
							.seq(createCardEffect(cryomancer_ice_floe_carddef(), loc(oppPid, castPloc))).seq(moveTargetWithLocAndPlayer(deckPloc, oppPid).apply(selectLoc(loc(oppPid, castPloc)).where(isCardName("cryomancer_ice_floe")))),
	
				cost = sacrificeSelfCost
			})
		},
        layout = createLayout({
            name = "Ice Floe",	
            art = "art/t_chaotic_gust",
			frame = "frames/wizard_cardframe",
            xmlText=[[
<vlayout>
    <hlayout flexibleheight="2">
            <icon text="{scrap}" fontsize="32" flexiblewidth="0"/>
            <tmpro text="Set aside a card of cost 4{gold} or less in your opponent's discard pile. The next time your opponent shuffles their deck, put that card on the bottom of their deck.

Put an Ice Floe card on top of opponent's deck." fontsize="14" flexiblewidth="10" />
    </hlayout>
    <divider/>
    <hlayout flexibleheight="0.5">
            <tmpro text="Ice Floe card: Does nothing" fontsize="14" flexiblewidth="10" />
    </hlayout> 
</vlayout>
			]]
        }),
        layoutPath  = "art/t_chaotic_gust",
	})
end	

--5b Ice Sheet
function cryomancer_ice_sheet_ab_carddef()
	return createHeroAbilityDef({
		id = "cryomancer_ice_sheet",
		name = "Ice Sheet",
		types = { heroAbilityType },
        abilities = {
			createAbility({
				id = "ice_sheet_Activate",
				trigger = uiTrigger,
				promptType = showPrompt,
				layout = createLayout({
					name = "Ice Sheet",
					art = "art/t_chaotic_gust",
					frame = "frames/wizard_cardframe",
					xmlText=[[
					<vlayout>
    <hlayout flexibleheight="2">
            <icon text="{scrap}" fontsize="32" flexiblewidth="0"/>
            <tmpro text="Set aside a card of cost 6{gold} or less in your opponent's discard pile. The next time your opponent shuffles their deck, put that card on the bottom of their deck.

Put an Ice Floe card on top of opponent's deck." fontsize="14" flexiblewidth="10" />
    </hlayout>
    <divider/>
    <hlayout flexibleheight="0.5">
            <tmpro text="Ice Floe card: Does nothing" fontsize="14" flexiblewidth="10" />
    </hlayout> 
</vlayout>
					]]
				}),
				effect = pushTargetedEffect({
												  desc = "Set aside a card of cost 6 or less from opponent's discard pile.",
												  min=0,
												  max=1,
												  validTargets = selectLoc(loc(oppPid, discardPloc)).where(getCardCost().lte(6)),
												  targetEffect = saveTarget("Ice Sheet").seq(moveTarget(sacrificePloc))
																.seq(createCardEffect(CryoISBuff, loc(oppPid, buffsPloc)))
												  })
							.seq(createCardEffect(cryomancer_ice_floe_carddef(), loc(oppPid, castPloc))).seq(moveTargetWithLocAndPlayer(deckPloc, oppPid).apply(selectLoc(loc(oppPid, castPloc)).where(isCardName("cryomancer_ice_floe")))),
				cost = sacrificeSelfCost
			})
		},
        layout = createLayout({
            name = "Ice Sheet",	
            art = "art/t_chaotic_gust",
			frame = "frames/wizard_cardframe",
            xmlText=[[
<vlayout>
    <hlayout flexibleheight="2">
            <icon text="{scrap}" fontsize="32" flexiblewidth="0"/>
            <tmpro text="Set aside a card of cost 6{gold} or less in your opponent's discard pile. The next time your opponent shuffles their deck, put that card on the bottom of their deck.

Put an Ice Floe card on top of opponent's deck." fontsize="14" flexiblewidth="10" />
    </hlayout>
    <divider/>
    <hlayout flexibleheight="0.5">
            <tmpro text="Ice Floe card: Does nothing" fontsize="14" flexiblewidth="10" />
    </hlayout> 
</vlayout>
			]]
        }),
        layoutPath  = "art/t_chaotic_gust",
	})
end	

--5c Permafrost

function cryomancer_permafrost_carddef()

    return createDef(
        {
            id = "cyromancer_permafrost",
            name = "Permafrost",
			types = {itemType, noSacrifice},
			cardTypeLabel = "item",
			playLocation = castPloc,
            acquireCost = 0,
            abilities = {
                createAbility(
                    {
                        id = "permafrost_no_sac",
                        trigger = autoTrigger,
                        cost = noCost,
                        activations = singleActivations,
                        effect = addSlotToTarget(createSlot({ id = slotNoSacrifice, expiresArray = { neverExpiry } })).apply(selectSource())

						
                    }
                )
            },
            layout = createLayout(
                {
                    name = "Permafrost",
                    art = "art/t_heavy_gust",
                    frame = "frames/wizard_cardframe",
					cost = 0,
                    xmlText=[[
<vlayout>
    <box flexibleheight="7">
<tmpro text="This card cannot be sacrificed." fontsize="18"/>
    </box>
<box flexibleheight="1">
<tmpro text="
Winter is here." fontstyle="italic" fontsize="18"/>
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

function cryomancer_permafrost_ab_carddef()
	return createHeroAbilityDef({
		id = "cryomancer_permafrost_ab",
		name = "Permafrost",
		types = { heroAbilityType },
        abilities = {
			createAbility({
				id = "permafrost_Activate",
				trigger = uiTrigger,
				promptType = showPrompt,
				layout = createLayout({
					name = "Permafrost",
					art = "art/t_chaotic_gust",
					frame = "frames/wizard_cardframe",
					xmlText=[[
					<vlayout>
    <hlayout flexibleheight="1">
            <icon text="{scrap}" fontsize="28" flexiblewidth="0"/>
            <tmpro text="Set aside a card of cost 4{gold} or less in your opponent's discard pile. The next time they shuffle their deck, put that card on the bottom of their deck.

Put Permafrost on top of their deck." fontsize="14" flexiblewidth="1" />
    </hlayout>
    <divider/>
    <hlayout flexibleheight="0.2">
            <tmpro text="Permafrost: Does nothing. Can't be sacrificed." fontsize="12" flexiblewidth="10" />
    </hlayout> 
</vlayout>
					]]
				}),
				effect = pushTargetedEffect({
												  desc = "Set aside a card of cost 4 or less from opponent's discard pile.",
												  min=0,
												  max=1,
												  validTargets = selectLoc(loc(oppPid, discardPloc)).where(getCardCost().lte(4)),
												  targetEffect = saveTarget("Permafrost").seq(moveTarget(sacrificePloc))
																.seq(createCardEffect(CryoPFBuff, loc(oppPid, buffsPloc)))
												  })
							.seq(createCardEffect(cryomancer_permafrost_carddef(), loc(oppPid, castPloc))).seq(moveTargetWithLocAndPlayer(deckPloc, oppPid).apply(selectLoc(loc(oppPid, castPloc)).where(isCardName("cyromancer_permafrost")))),
	
				cost = sacrificeSelfCost
			})
		},
        layout = createLayout({
            name = "Permafrost",	
            art = "art/t_chaotic_gust",
			frame = "frames/wizard_cardframe",
            xmlText=[[
<vlayout>
    <hlayout flexibleheight="1">
            <icon text="{scrap}" fontsize="28" flexiblewidth="0"/>
            <tmpro text="Set aside a card of cost 4{gold} or less in your opponent's discard pile. The next time they shuffle their deck, put that card on the bottom of their deck.

Put Permafrost on top of their deck." fontsize="13.5" flexiblewidth="1" />
    </hlayout>
    <divider/>
    <hlayout flexibleheight="0.5">
            <tmpro text="Permafrost: When discarded, including end of turn, put on bottom of deck. Can't be sacrificed." fontsize="12" flexiblewidth="10" />
    </hlayout> 
</vlayout>
			]]
        }),
        layoutPath  = "art/t_chaotic_gust",
	})
end	

-- End of Cryomancer cards ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



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
			demonologist_dark_summon_carddef(),
			demonologist_fel_summon_carddef(),
			demonologist_dark_succubus_carddef(),
			demonologist_raging_fel_hound_carddef(),
			demonologist_giant_demonic_leech_carddef(),
			demonologist_void_sentinel_carddef(),
			demonologist_devourer_carddef(),
			demonologist_infernal_summon_carddef(),
			demonologist_demonic_tyrant_leech_carddef(),
			demonologist_succubus_queen_carddef(),
			demonologist_flaming_fel_hound_carddef(),
			demonologist_malevolent_summon_carddef(),
			demonologist_sinister_summon_carddef(),
			demonologist_grimoire_carddef(),
			demonologist_scroll_of_summoning_carddef(),
			demonologist_summon_karamight_carddef(),
			demonologist_karamight_carddef(),
			demonologist_summon_laughing_shade_carddef(),
			demonologist_laughing_shade_carddef(),
			demonologist_summon_ingaitch_carddef(),
			demonologist_ingaitch_carddef(),
			demonologist_flawless_shadow_gem_carddef(),
			demonologist_butcherclaw_carddef(),
			demonologist_spike_carddef(),
			demonologist_summon_demon_ability_carddef(),
			demonologist_demonic_amulet_carddef(),
			demonologist_summoner_s_robes_carddef(),

choose_pyromancer_carddef(),
            pyromancer_sear_carddef(),
			pyromancer_scorch_carddef(),
			pyromancer_fire_shard_carddef(),
			pyromancer_combust_carddef(),
			pyromancer_1p_fuel_1carddef(),
			pyromancer_2p_fuel_1carddef(),
			pyromancer_explode_carddef(),
			pyromancer_incinerate_carddef(),
			pyromancer_patronage_carddef(),
			pyromancer_fire_elemental_carddef(),
			pyromancer_hearth_carddef(),
			pyromancer_volatile_chemicals_carddef(),
			pyromancer_fire_bird_carddef(),
			pyromancer1_flame_hood_carddef(),
			pyromancer2_flame_hood_carddef(),
			pyromancer_after_burn_3a_carddef(),
			pyromancer_after_burn_3b_carddef(),
			pyromancer_after_burn_3c_carddef(),
			
choose_pyromancer_carddef(),
            cryomancer_ice_sickle_carddef(),
			cryomancer_frostwulf_carddef(),
			cryomancer_ice_gem_carddef(),
			cryomancer_freeze_carddef(),
			cryomancer_deep_freeze_carddef(),
			cryomancer_ice_sickles_carddef(),
			cryomancer_cold_snap_carddef(),
			cyromancer_polarmour_carddef(),
			cryomancer_eternal_frost_carddef(),
			cyromancer_cryonics_carddef(),
			cryomancer_frostbite_carddef(),
			cryomancer_rapid_frostbiteskill_carddef(),
			cryomancer_deep_frostbiteskill_carddef(),
			cryomancer_instant_frostbiteskill_carddef(),
			cryomancer_severe_frostbiteskill_carddef(),
			cryomancer_extreme_frostbiteskill_carddef(),
			cryomancer_freezing_fog_carddef(),
			cryomancer_hoarfrost_carddef(),
			cryomancer_snow_squall_carddef(),
			cryomancer_ice_floe_ab_carddef(),
			cryomancer_ice_floe_carddef(),
			cryomancer_ice_sheet_ab_carddef(),
			cryomancer_permafrost_carddef(),
			cryomancer_permafrost_ab_carddef(),
			cryomancer_ice_mail_carddef()

--[[
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
	choose_terramancer_carddef(),
			terramancer_earth_gem_carddef(),
			terramancer_hurl_boulder_carddef(),
			terramancer_tremor_carddef(),
			terramancer_clay_golem_carddef(),
			terramancer_move_earth_carddef(),
			terramancer_move_earth_free_carddef(),
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
			surprise_dragon_token_carddef(),
			mythic_mercs_ee_parsons_carddef(),
			ee_demon_hunter_carddef()]]
			
        }
    )

    standardSetup(
        g,
        {
            description = "Custom Class Clash (level 12) script and classes by Aarkenell. Created 12.04.2024. Updated 19.04.2025",
             playerOrder = { plid1, plid2 },
        ai = ai.CreateKillSwitchAi(createAggressiveAI(),  createHardAi2()),
        timeoutAi = createTimeoutAi(),
        opponents = { { plid1, plid2 } },
		tradeDeckExceptions = {
            -- here we set which cards populate market deck
           --[[ { qty=1, cardId="scrapforks" },
			{ qty=1, cardId="dblducks" },
			{ qty=1, cardId="stigmalingpa" },
			{ qty=1, cardId="agent_th" },
			{ qty=1, cardId="parsons_merc" },
			{ qty=1, cardId="demon_hunter" }
			]]
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
    meta.name = "Custom Class Clash (lvl 12)"
    meta.minLevel = 0
    meta.maxLevel = 0
    meta.introbackground = ""
    meta.introheader = ""
    meta.introdescription = ""
    meta.path = "C:/Users/aaron/OneDrive/Documents/Aaron/Hero Realms/Lua/Custom Class Clash (lvl 12).lua"
     meta.features = {
}

end
