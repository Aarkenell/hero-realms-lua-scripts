require "herorealms"
require "decks"
require "stdlib"
require "stdcards"
require "hardai"
require "mediumai"
require "easyai"

--[[
Huge thanks to Jspeh and Azgalor for helping me work out how to make this system work.

This script will show you how to set up a simple mana system for Hero Realms.
The champion and 4-choice ritual/spell options are just one way to implement the system. They're not core to it, but allow you to see how it functions in-game if you run this as a test script.

]]
-- Setup a local buff for each player to show current mana (ritual)

    local setup_p1_ritual_buff = createGlobalBuff({
        id="setup_p1_ritual_buff",
        name = "Necros Rituals",
        abilities = {
            createAbility({
                id="setup_p1_ritual_buff",
				trigger = startOfGameTrigger,
                effect = nullEffect()
            })
        },
		buffDetails = createBuffDetails({
					name = "Necros Ritual Points",
							art = "icons/the_summoning",
							frame = "frames/necros_action_cardframe",
							text=format("<size=150%>{0}", { getCounter("p1_ritual")})
					})
    })
	
    local setup_p2_ritual_buff = createGlobalBuff({
        id="setup_p2_ritual_buff",
        name = "Necros Rituals",
        abilities = {
            createAbility({
                id="setup_p2_ritual_buff",
				trigger = startOfGameTrigger,
                effect = nullEffect()
            })
        },
		buffDetails = createBuffDetails({
					name = "Necros Ritual Points",
							art = "icons/the_summoning",
							frame = "frames/necros_action_cardframe",
							text=format("<size=150%>{0}", { getCounter("p2_ritual")})})
    })


local lesser_rituals = pushChoiceEffectWithTitle(

{
					upperTitle = "Cost is paid in Ritual points (not Gold).",
					lowerTitle = "All demons summoned are tokens, and are sacrificed when they leave play.",
choices = {
-- Choice 1a:
			{
				effect = pushTargetedEffect({
												desc = "Give a champion +2 <sprite name=\"shield\"> until your next turn.",
												validTargets = selectLoc(currentInPlayLoc),
												min = 0,
												max = 1,
												targetEffect = grantHealthTarget(2, { SlotExpireEnum.startOfOwnerTurn }, nullEffect(), "shadow")
											})
--This effect checks for the mana/ritual buff. It always checks for P1's buff and uses that to determine which player to grant mana/ritual to.
						.seq(ifElseEffect(selectLoc(loc(currentPid, buffsPloc)).where(isCardName("setup_p1_ritual_buff")).count().eq(1), incrementCounterEffect("p1_ritual", -1), incrementCounterEffect("p2_ritual", -1)))
						,

				cost = 1,

-- This condition is to ensure mana/ritual is deducted from the correct player's pool; and ensures the player has enough mana/ritual points to cast the spell.
-- It does this by checking whose turn it is by referencing p1 buff and then getting the relevant counter; then we set the .gte value for the cost of the spell/ritual we want to cast
				condition = ifInt(
        selectLoc(loc(currentPid, buffsPloc)).where(isCardName("setup_p1_ritual_buff")).count().eq(1),
        getCounter("p1_ritual"),
        getCounter("p2_ritual")
        ).gte(1),

				layout = createLayout({
					name = "Infernal Strength",
					art = "art/epicart/dark_leader",
					frame = "frames/necromancer_frames/necromancer_item_cardframe",
					cost = 1,
					xmlText=[[<vlayout>
<hlayout flexiblewidth="1">
<text text="Give a champion +2{shield} until your next turn." fontsize="26"/>	</hlayout>	</vlayout>
					]]
									}),
				
				tags = {}
			},

-- Choice 1b:

			{
				effect = ifElseEffect(selectLoc(loc(currentPid, buffsPloc)).where(isCardName("setup_p1_ritual_buff")).count().eq(1), incrementCounterEffect("p1_ritual", -2), incrementCounterEffect("p2_ritual", -2))
				.seq(createCardEffect(cult_priest_carddef(), currentInPlayLoc)),
            condition = ifInt(
        selectLoc(loc(currentPid, buffsPloc)).where(isCardName("setup_p1_ritual_buff")).count().eq(1),
        getCounter("p1_ritual"),
        getCounter("p2_ritual")
        ).gte(2),
		layout = createLayout(
                {
                    name = "Summon Demonic Leech",
                    art = "art/t_wurm",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
					cost = 2,
					xmlText = [[
<vlayout>
    <hlayout flexibleheight="0.5">
        <box flexiblewidth="1">
            <tmpro text="{expend}" fontsize="30"/>
        </box>
        <box flexiblewidth="7">
            <tmpro text="Deal 1 damage to opponent.
+1{shield} until this leaves play." fontsize="18"/>
</box>
</hlayout>
<divider/>
<hlayout flexibleheight="0.7">
        <box flexiblewidth="7">
            <tmpro text="Explode: If this has 5{shield} at the start of a turn, immediately deal 5 damage to opponent and sacrifice this card. " fontsize="20"/>
</box>
</hlayout>
</vlayout>
					]],
					health = 0,
                    isGuard = false
                }
            ),
				
				tags = {}
			},			
-- Choice 1c: 								
			{
				effect = ifElseEffect(selectLoc(loc(currentPid, buffsPloc)).where(isCardName("setup_p1_ritual_buff")).count().eq(1), incrementCounterEffect("p1_ritual", -3), incrementCounterEffect("p2_ritual", -3))
				.seq(createCardEffect(street_thug_carddef(), currentInPlayLoc)),
				condition = ifInt(
        selectLoc(loc(currentPid, buffsPloc)).where(isCardName("setup_p1_ritual_buff")).count().eq(1),
        getCounter("p1_ritual"),
        getCounter("p2_ritual")
        ).gte(3),
				layout = createLayout({
                    name = "Summon Void Guard",
                    art = "art/t_midnight_knight",
                    frame = "frames/necromancer_frames/necromancer_item_cardframe",
					cost = 3,
					condition = ifInt(
        selectLoc(loc(currentPid, buffsPloc)).where(isCardName("setup_p1_ritual_buff")).count().eq(1),
        getCounter("p1_ritual"),
        getCounter("p2_ritual")
        ).gte(2),
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
									}),
				
				tags = {}
			},	

-- Choice 1d
													{
				effect = gainMaxHealthEffect(currentPid, 1).seq(gainHealthEffect(4))
							.seq(ifElseEffect(selectLoc(loc(currentPid, buffsPloc)).where(isCardName("setup_p1_ritual_buff")).count().eq(1), incrementCounterEffect("p1_ritual", -4), incrementCounterEffect("p2_ritual", -4))),
				condition = ifInt(
        selectLoc(loc(currentPid, buffsPloc)).where(isCardName("setup_p1_ritual_buff")).count().eq(1),
        getCounter("p1_ritual"),
        getCounter("p2_ritual")
        ).gte(4),
				layout = createLayout({
					name = "Embrace Darkness",
					art = "art/epicart/dark_offering",
					frame = "frames/necromancer_frames/necromancer_item_cardframe",
					cost = 4,
					xmlText=[[<vlayout>
<hlayout flexiblewidth="1">
<text text="Increase your
max Health by 1.

&lt;size=150%&gt;{health_4}" fontsize="24"/>
	</hlayout>	</vlayout>
					]]
									}),
				
				tags = {}
			}									
}
}
)


-- For testing purposes only - this card can both gain and spend mana/ritual
function acs_demonic_linguist_carddef()
    return createChampionDef(
        {
            id = "acs_demonic_linguist",
            name = "Demonic Linguist",
			types = {championType},
			factions = {necrosFaction},
            acquireCost = 4,
            health = 5,
            isGuard = false,
            abilities = {
			
				createAbility(
                    {
                        id = "demonic_linguist_healthbuff",
                        trigger = uiTrigger,
                        cost = expendCost,
                        activations = singleActivations,
                        effect = pushChoiceEffectWithTitle(

{
					upperTitle = "",
					lowerTitle = "",
choices = {
-- Choice 1: Gain Ritual
			{
				effect = ifElseEffect(selectLoc(loc(currentPid, buffsPloc)).where(isCardName("setup_p1_ritual_buff")).count().eq(1), incrementCounterEffect("p1_ritual", 1), incrementCounterEffect("p2_ritual", 1)),
				layout = createLayout({
									name = "Demonic Linguist",
									art = "art/epicart/abyss_summoner",
									frame = "frames/necros_action_cardframe",
                                    xmlText = [[
<vlayout>
    <hlayout flexibleheight="2">
        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="
&lt;size=75%&gt;1 Ritual" fontsize="36" />
            </box>
        </vlayout>
    </hlayout>
</vlayout>
                                    ]],
                                }),
				
				tags = {}
			},
			
-- Choice 2: Perform Ritual							
			{
				effect = lesser_rituals,
				layout = createLayout({
							name = "Demonic Linguist",
							art = "icons/the_summoning",
									frame = "frames/necros_action_cardframe",
                                    xmlText = [[
<vlayout>
    <hlayout flexibleheight="2">
        <vlayout flexiblewidth="7">
            <box flexibleheight="2">
                <tmpro text="{gold_2}
&lt;size=75%&gt;Perform a
level 1-2 Ritual." fontsize="36" />
            </box>
        </vlayout>
    </hlayout>
</vlayout>
                                    ]],
                                }),
				
				tags = {}
			},	
}
}
)
					}	  
                )
            },
            layout = createLayout(
                {
                    name = "Demonic Linguist",
                    art = "art/epicart/abyss_summoner",
                    frame = "frames/necros_champion_cardframe",
					cost = 4,
                    xmlText=[[
<vlayout>
    <hlayout flexibleheight="1">
            <tmpro text="{expend}" fontsize="40" flexiblewidth="2"/>
            <tmpro text="{gold_2}
 &lt;size=65%&gt;and 1 Ritual or Perform a 
level 1-2 Ritual" fontsize="40" flexiblewidth="12" />
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


function setupGame(g)
    registerCards(
        g,
        {

        }
    )

    standardSetup(
        g,
        {
            description = "AJA Mana System. Created by Aarkenell, Jspeh & Azgalor",
            playerOrder = {plid1, plid2},
            ai = ai.CreateKillSwitchAi(createAggressiveAI(), createHardAi2()),
            timeoutAi = createTimeoutAi(),
            opponents = {{plid1, plid2}},
            players = {
                {
                    id = plid1,
                    startDraw = 3,
                    name = "Demonologist",
                    avatar = "chanting_cultist",
                    health = 50,
                    cards = {
                        deck = {
                            {qty = 1, card = acs_demonic_linguist_carddef()},
                        },
                        skills = {
                        {qty = 1, card = ranger_track_carddef() },
                        {qty = 1, card = ranger_headshot_carddef()}
                        },
                        buffs = {
                            drawCardsCountAtTurnEndDef(5),
                            discardCardsAtTurnStartDef(),
                            fatigueCount(40, 1, "FatigueP1"),
							setup_p1_ritual_buff
                        }
                    }
                },
                {
                    id = plid2,
                    startDraw = 5,
                    name = "Demonologist",
                    avatar = "chanting_cultist",
                    health = 50,
                    cards = {
                        deck = {
                            {qty = 1, card = acs_demonic_linguist_carddef()},
                        },
                        skills = {
                        {qty = 1, card = ranger_track_carddef() },
                        {qty = 1, card = ranger_headshot_carddef()}
                        },
                        buffs = {
                            drawCardsCountAtTurnEndDef(5),
                            discardCardsAtTurnStartDef(),
                            fatigueCount(40, 1, "FatigueP1"),
							setup_p2_ritual_buff
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
                meta.name = "Mana system"
                meta.minLevel = 0
                meta.maxLevel = 0
                meta.introbackground = ""
                meta.introheader = ""
                meta.introdescription = ""
                meta.path = "C:/Users/aaron/OneDrive/Documents/Aaron/Hero Realms/Lua/Mana system.lua"
                meta.features = {
}

            end