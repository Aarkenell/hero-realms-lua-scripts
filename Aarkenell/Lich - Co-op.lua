require 'herorealms'
require 'decks'
require 'stdlib'
require 'coopai'
require 'timeoutai'

isCoop = true




local function lich_extra_souljar_buff()

local ef_new_jar = showCardEffect(layoutCard({
                            name = "Soul Jar",
							art = "art/treasures/t_wizard_elixir_blue",
                            frame = "frames/ancestry_frames/smallfolk_ability_cardframe",
                            text = "A new soul is released."
                        }))
						
						
local ef_DI = ef_new_jar
				
				.seq(randomEffect({
					valueItem(0, createCardEffect(lich_SJ_DI_carddef(), loc(ownerPid, skillsPloc)).seq(sacrificeTarget().apply(selectLoc(loc(nextOppPid, skillsPloc)).where(isCardName("SJ_DI")))).seq(createCardEffect(lich_SJ_DI_carddef(), loc(nextOppPid, skillsPloc))).seq(gainMaxHealthEffect(ownerPid, const(35).add(getPlayerMaxHealth(ownerPid).negate()))).seq(healPlayerEffect(ownerPid, 35))),
					valueItem(1, createCardEffect(lich_SJ_HoE_carddef(), loc(ownerPid, skillsPloc)).seq(sacrificeTarget().apply(selectLoc(loc(nextOppPid, skillsPloc)).where(isCardName("SJ_DI")))).seq(createCardEffect(lich_SJ_HoE_carddef(), loc(nextOppPid, skillsPloc))).seq(gainMaxHealthEffect(ownerPid, const(30).add(getPlayerMaxHealth(ownerPid).negate()))).seq(healPlayerEffect(ownerPid, 30))),
					valueItem(1, createCardEffect(lich_SJ_UR_carddef(), loc(ownerPid, skillsPloc)).seq(sacrificeTarget().apply(selectLoc(loc(nextOppPid, skillsPloc)).where(isCardName("SJ_DI")))).seq(createCardEffect(lich_SJ_UR_carddef(), loc(nextOppPid, skillsPloc))).seq(gainMaxHealthEffect(ownerPid, const(55).add(getPlayerMaxHealth(ownerPid).negate()))).seq(healPlayerEffect(ownerPid, 55))),
					valueItem(1, createCardEffect(lich_SJ_M_carddef(), loc(ownerPid, skillsPloc)).seq(sacrificeTarget().apply(selectLoc(loc(nextOppPid, skillsPloc)).where(isCardName("SJ_DI")))).seq(createCardEffect(lich_SJ_M_carddef(), loc(nextOppPid, skillsPloc))).seq(gainMaxHealthEffect(ownerPid, const(45).add(getPlayerMaxHealth(ownerPid).negate()))).seq(healPlayerEffect(ownerPid, 45))),
					valueItem(1, createCardEffect(lich_SJ_V_carddef(), loc(ownerPid, skillsPloc)).seq(sacrificeTarget().apply(selectLoc(loc(nextOppPid, skillsPloc)).where(isCardName("SJ_DI")))).seq(createCardEffect(lich_SJ_V_carddef(), loc(nextOppPid, skillsPloc))).seq(gainMaxHealthEffect(ownerPid, const(50).add(getPlayerMaxHealth(ownerPid).negate()))).seq(healPlayerEffect(ownerPid, 50))),
					valueItem(1, createCardEffect(lich_SJ_IW_carddef(), loc(ownerPid, skillsPloc)).seq(sacrificeTarget().apply(selectLoc(loc(nextOppPid, skillsPloc)).where(isCardName("SJ_DI")))).seq(createCardEffect(lich_SJ_IW_carddef(), loc(nextOppPid, skillsPloc))).seq(gainMaxHealthEffect(ownerPid, const(40).add(getPlayerMaxHealth(ownerPid).negate()))).seq(healPlayerEffect(ownerPid, 40))),
					}))
					
					.seq(sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("SJ_DI"))))

local ef_HoE = ef_new_jar.seq(randomEffect({
					valueItem(1, createCardEffect(lich_SJ_DI_carddef(), loc(ownerPid, skillsPloc)).seq(sacrificeTarget().apply(selectLoc(loc(nextOppPid, skillsPloc)).where(isCardName("SJ_HoE")))).seq(createCardEffect(lich_SJ_DI_carddef(), loc(nextOppPid, skillsPloc))).seq(gainMaxHealthEffect(ownerPid, const(35).add(getPlayerMaxHealth(ownerPid).negate()))).seq(healPlayerEffect(ownerPid, 35))),
					valueItem(0, createCardEffect(lich_SJ_HoE_carddef(), loc(ownerPid, skillsPloc)).seq(sacrificeTarget().apply(selectLoc(loc(nextOppPid, skillsPloc)).where(isCardName("SJ_HoE")))).seq(createCardEffect(lich_SJ_HoE_carddef(), loc(nextOppPid, skillsPloc))).seq(gainMaxHealthEffect(ownerPid, const(30).add(getPlayerMaxHealth(ownerPid).negate()))).seq(healPlayerEffect(ownerPid, 30))),
					valueItem(1, createCardEffect(lich_SJ_UR_carddef(), loc(ownerPid, skillsPloc)).seq(sacrificeTarget().apply(selectLoc(loc(nextOppPid, skillsPloc)).where(isCardName("SJ_HoE")))).seq(createCardEffect(lich_SJ_UR_carddef(), loc(nextOppPid, skillsPloc))).seq(gainMaxHealthEffect(ownerPid, const(55).add(getPlayerMaxHealth(ownerPid).negate()))).seq(healPlayerEffect(ownerPid, 55))),
					valueItem(1, createCardEffect(lich_SJ_M_carddef(), loc(ownerPid, skillsPloc)).seq(sacrificeTarget().apply(selectLoc(loc(nextOppPid, skillsPloc)).where(isCardName("SJ_HoE")))).seq(createCardEffect(lich_SJ_M_carddef(), loc(nextOppPid, skillsPloc))).seq(gainMaxHealthEffect(ownerPid, const(45).add(getPlayerMaxHealth(ownerPid).negate()))).seq(healPlayerEffect(ownerPid, 45))),
					valueItem(1, createCardEffect(lich_SJ_V_carddef(), loc(ownerPid, skillsPloc)).seq(sacrificeTarget().apply(selectLoc(loc(nextOppPid, skillsPloc)).where(isCardName("SJ_HoE")))).seq(createCardEffect(lich_SJ_V_carddef(), loc(nextOppPid, skillsPloc))).seq(gainMaxHealthEffect(ownerPid, const(50).add(getPlayerMaxHealth(ownerPid).negate()))).seq(healPlayerEffect(ownerPid, 50))),
					valueItem(1, createCardEffect(lich_SJ_IW_carddef(), loc(ownerPid, skillsPloc)).seq(sacrificeTarget().apply(selectLoc(loc(nextOppPid, skillsPloc)).where(isCardName("SJ_HoE")))).seq(createCardEffect(lich_SJ_IW_carddef(), loc(nextOppPid, skillsPloc))).seq(gainMaxHealthEffect(ownerPid, const(40).add(getPlayerMaxHealth(ownerPid).negate()))).seq(healPlayerEffect(ownerPid, 40))),
					}))
					.seq(sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("SJ_HoE"))))
					
					
local ef_UR = ef_new_jar.seq(randomEffect({
					valueItem(1, createCardEffect(lich_SJ_DI_carddef(), loc(ownerPid, skillsPloc)).seq(sacrificeTarget().apply(selectLoc(loc(nextOppPid, skillsPloc)).where(isCardName("SJ_UR")))).seq(createCardEffect(lich_SJ_DI_carddef(), loc(nextOppPid, skillsPloc))).seq(gainMaxHealthEffect(ownerPid, const(35).add(getPlayerMaxHealth(ownerPid).negate()))).seq(healPlayerEffect(ownerPid, 35))),
					valueItem(1, createCardEffect(lich_SJ_HoE_carddef(), loc(ownerPid, skillsPloc)).seq(sacrificeTarget().apply(selectLoc(loc(nextOppPid, skillsPloc)).where(isCardName("SJ_UR")))).seq(createCardEffect(lich_SJ_HoE_carddef(), loc(nextOppPid, skillsPloc))).seq(gainMaxHealthEffect(ownerPid, const(30).add(getPlayerMaxHealth(ownerPid).negate()))).seq(healPlayerEffect(ownerPid, 30))),
					valueItem(0, createCardEffect(lich_SJ_UR_carddef(), loc(ownerPid, skillsPloc)).seq(sacrificeTarget().apply(selectLoc(loc(nextOppPid, skillsPloc)).where(isCardName("SJ_UR")))).seq(createCardEffect(lich_SJ_UR_carddef(), loc(nextOppPid, skillsPloc))).seq(gainMaxHealthEffect(ownerPid, const(55).add(getPlayerMaxHealth(ownerPid).negate()))).seq(healPlayerEffect(ownerPid, 55))),
					valueItem(1, createCardEffect(lich_SJ_M_carddef(), loc(ownerPid, skillsPloc)).seq(sacrificeTarget().apply(selectLoc(loc(nextOppPid, skillsPloc)).where(isCardName("SJ_UR")))).seq(createCardEffect(lich_SJ_M_carddef(), loc(nextOppPid, skillsPloc))).seq(gainMaxHealthEffect(ownerPid, const(45).add(getPlayerMaxHealth(ownerPid).negate()))).seq(healPlayerEffect(ownerPid, 45))),
					valueItem(1, createCardEffect(lich_SJ_V_carddef(), loc(ownerPid, skillsPloc)).seq(sacrificeTarget().apply(selectLoc(loc(nextOppPid, skillsPloc)).where(isCardName("SJ_UR")))).seq(createCardEffect(lich_SJ_V_carddef(), loc(nextOppPid, skillsPloc))).seq(gainMaxHealthEffect(ownerPid, const(50).add(getPlayerMaxHealth(ownerPid).negate()))).seq(healPlayerEffect(ownerPid, 50))),
					valueItem(1, createCardEffect(lich_SJ_IW_carddef(), loc(ownerPid, skillsPloc)).seq(sacrificeTarget().apply(selectLoc(loc(nextOppPid, skillsPloc)).where(isCardName("SJ_UR")))).seq(createCardEffect(lich_SJ_IW_carddef(), loc(nextOppPid, skillsPloc))).seq(gainMaxHealthEffect(ownerPid, const(40).add(getPlayerMaxHealth(ownerPid).negate()))).seq(healPlayerEffect(ownerPid, 40))),
					}))
					.seq(sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("SJ_UR"))))
					
local ef_M = ef_new_jar.seq(randomEffect({
					valueItem(1, createCardEffect(lich_SJ_DI_carddef(), loc(ownerPid, skillsPloc)).seq(sacrificeTarget().apply(selectLoc(loc(nextOppPid, skillsPloc)).where(isCardName("SJ_M")))).seq(createCardEffect(lich_SJ_DI_carddef(), loc(nextOppPid, skillsPloc))).seq(gainMaxHealthEffect(ownerPid, const(35).add(getPlayerMaxHealth(ownerPid).negate()))).seq(healPlayerEffect(ownerPid, 35))),
					valueItem(1, createCardEffect(lich_SJ_HoE_carddef(), loc(ownerPid, skillsPloc)).seq(sacrificeTarget().apply(selectLoc(loc(nextOppPid, skillsPloc)).where(isCardName("SJ_M")))).seq(createCardEffect(lich_SJ_HoE_carddef(), loc(nextOppPid, skillsPloc))).seq(gainMaxHealthEffect(ownerPid, const(30).add(getPlayerMaxHealth(ownerPid).negate()))).seq(healPlayerEffect(ownerPid, 30))),
					valueItem(1, createCardEffect(lich_SJ_UR_carddef(), loc(ownerPid, skillsPloc)).seq(sacrificeTarget().apply(selectLoc(loc(nextOppPid, skillsPloc)).where(isCardName("SJ_M")))).seq(createCardEffect(lich_SJ_UR_carddef(), loc(nextOppPid, skillsPloc))).seq(gainMaxHealthEffect(ownerPid, const(55).add(getPlayerMaxHealth(ownerPid).negate()))).seq(healPlayerEffect(ownerPid, 55))),
					valueItem(0, createCardEffect(lich_SJ_M_carddef(), loc(ownerPid, skillsPloc)).seq(sacrificeTarget().apply(selectLoc(loc(nextOppPid, skillsPloc)).where(isCardName("SJ_M")))).seq(createCardEffect(lich_SJ_M_carddef(), loc(nextOppPid, skillsPloc))).seq(gainMaxHealthEffect(ownerPid, const(45).add(getPlayerMaxHealth(ownerPid).negate()))).seq(healPlayerEffect(ownerPid, 45))),
					valueItem(1, createCardEffect(lich_SJ_V_carddef(), loc(ownerPid, skillsPloc)).seq(sacrificeTarget().apply(selectLoc(loc(nextOppPid, skillsPloc)).where(isCardName("SJ_M")))).seq(createCardEffect(lich_SJ_V_carddef(), loc(nextOppPid, skillsPloc))).seq(gainMaxHealthEffect(ownerPid, const(50).add(getPlayerMaxHealth(ownerPid).negate()))).seq(healPlayerEffect(ownerPid, 50))),
					valueItem(1, createCardEffect(lich_SJ_IW_carddef(), loc(ownerPid, skillsPloc)).seq(sacrificeTarget().apply(selectLoc(loc(nextOppPid, skillsPloc)).where(isCardName("SJ_M")))).seq(createCardEffect(lich_SJ_IW_carddef(), loc(nextOppPid, skillsPloc))).seq(gainMaxHealthEffect(ownerPid, const(40).add(getPlayerMaxHealth(ownerPid).negate()))).seq(healPlayerEffect(ownerPid, 40))),
					}))
					.seq(sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("SJ_M"))))
					
local ef_V = ef_new_jar.seq(randomEffect({
					valueItem(1, createCardEffect(lich_SJ_DI_carddef(), loc(ownerPid, skillsPloc)).seq(sacrificeTarget().apply(selectLoc(loc(nextOppPid, skillsPloc)).where(isCardName("SJ_V")))).seq(createCardEffect(lich_SJ_DI_carddef(), loc(nextOppPid, skillsPloc))).seq(gainMaxHealthEffect(ownerPid, const(35).add(getPlayerMaxHealth(ownerPid).negate()))).seq(healPlayerEffect(ownerPid, 35))),
					valueItem(1, createCardEffect(lich_SJ_HoE_carddef(), loc(ownerPid, skillsPloc)).seq(sacrificeTarget().apply(selectLoc(loc(nextOppPid, skillsPloc)).where(isCardName("SJ_V")))).seq(createCardEffect(lich_SJ_HoE_carddef(), loc(nextOppPid, skillsPloc))).seq(gainMaxHealthEffect(ownerPid, const(30).add(getPlayerMaxHealth(ownerPid).negate()))).seq(healPlayerEffect(ownerPid, 30))),
					valueItem(1, createCardEffect(lich_SJ_UR_carddef(), loc(ownerPid, skillsPloc)).seq(sacrificeTarget().apply(selectLoc(loc(nextOppPid, skillsPloc)).where(isCardName("SJ_V")))).seq(createCardEffect(lich_SJ_UR_carddef(), loc(nextOppPid, skillsPloc))).seq(gainMaxHealthEffect(ownerPid, const(55).add(getPlayerMaxHealth(ownerPid).negate()))).seq(healPlayerEffect(ownerPid, 55))),
					valueItem(1, createCardEffect(lich_SJ_M_carddef(), loc(ownerPid, skillsPloc)).seq(sacrificeTarget().apply(selectLoc(loc(nextOppPid, skillsPloc)).where(isCardName("SJ_V")))).seq(createCardEffect(lich_SJ_M_carddef(), loc(nextOppPid, skillsPloc))).seq(gainMaxHealthEffect(ownerPid, const(45).add(getPlayerMaxHealth(ownerPid).negate()))).seq(healPlayerEffect(ownerPid, 45))),
					valueItem(0, createCardEffect(lich_SJ_V_carddef(), loc(ownerPid, skillsPloc)).seq(sacrificeTarget().apply(selectLoc(loc(nextOppPid, skillsPloc)).where(isCardName("SJ_V")))).seq(createCardEffect(lich_SJ_V_carddef(), loc(nextOppPid, skillsPloc))).seq(gainMaxHealthEffect(ownerPid, const(50).add(getPlayerMaxHealth(ownerPid).negate()))).seq(healPlayerEffect(ownerPid, 50))),
					valueItem(1, createCardEffect(lich_SJ_IW_carddef(), loc(ownerPid, skillsPloc)).seq(sacrificeTarget().apply(selectLoc(loc(nextOppPid, skillsPloc)).where(isCardName("SJ_V")))).seq(createCardEffect(lich_SJ_IW_carddef(), loc(nextOppPid, skillsPloc))).seq(gainMaxHealthEffect(ownerPid, const(40).add(getPlayerMaxHealth(ownerPid).negate()))).seq(healPlayerEffect(ownerPid, 40))),
					}))
					.seq(sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("SJ_V"))))

local ef_IW = ef_new_jar.seq(randomEffect({
					valueItem(1, createCardEffect(lich_SJ_DI_carddef(), loc(ownerPid, skillsPloc)).seq(sacrificeTarget().apply(selectLoc(loc(nextOppPid, skillsPloc)).where(isCardName("SJ_IW")))).seq(createCardEffect(lich_SJ_DI_carddef(), loc(nextOppPid, skillsPloc))).seq(gainMaxHealthEffect(ownerPid, const(35).add(getPlayerMaxHealth(ownerPid).negate()))).seq(healPlayerEffect(ownerPid, 35))),
					valueItem(1, createCardEffect(lich_SJ_HoE_carddef(), loc(ownerPid, skillsPloc)).seq(sacrificeTarget().apply(selectLoc(loc(nextOppPid, skillsPloc)).where(isCardName("SJ_IW")))).seq(createCardEffect(lich_SJ_HoE_carddef(), loc(nextOppPid, skillsPloc))).seq(gainMaxHealthEffect(ownerPid, const(30).add(getPlayerMaxHealth(ownerPid).negate()))).seq(healPlayerEffect(ownerPid, 30))),
					valueItem(1, createCardEffect(lich_SJ_UR_carddef(), loc(ownerPid, skillsPloc)).seq(sacrificeTarget().apply(selectLoc(loc(nextOppPid, skillsPloc)).where(isCardName("SJ_IW")))).seq(createCardEffect(lich_SJ_UR_carddef(), loc(nextOppPid, skillsPloc))).seq(gainMaxHealthEffect(ownerPid, const(55).add(getPlayerMaxHealth(ownerPid).negate()))).seq(healPlayerEffect(ownerPid, 55))),
					valueItem(1, createCardEffect(lich_SJ_M_carddef(), loc(ownerPid, skillsPloc)).seq(sacrificeTarget().apply(selectLoc(loc(nextOppPid, skillsPloc)).where(isCardName("SJ_IW")))).seq(createCardEffect(lich_SJ_M_carddef(), loc(nextOppPid, skillsPloc))).seq(gainMaxHealthEffect(ownerPid, const(45).add(getPlayerMaxHealth(ownerPid).negate()))).seq(healPlayerEffect(ownerPid, 45))),
					valueItem(1, createCardEffect(lich_SJ_V_carddef(), loc(ownerPid, skillsPloc)).seq(sacrificeTarget().apply(selectLoc(loc(nextOppPid, skillsPloc)).where(isCardName("SJ_IW")))).seq(createCardEffect(lich_SJ_V_carddef(), loc(nextOppPid, skillsPloc))).seq(gainMaxHealthEffect(ownerPid, const(50).add(getPlayerMaxHealth(ownerPid).negate()))).seq(healPlayerEffect(ownerPid, 50))),
					valueItem(0, createCardEffect(lich_SJ_IW_carddef(), loc(ownerPid, skillsPloc)).seq(sacrificeTarget().apply(selectLoc(loc(nextOppPid, skillsPloc)).where(isCardName("SJ_IW")))).seq(createCardEffect(lich_SJ_IW_carddef(), loc(nextOppPid, skillsPloc))).seq(gainMaxHealthEffect(ownerPid, const(40).add(getPlayerMaxHealth(ownerPid).negate()))).seq(healPlayerEffect(ownerPid, 40))),
					}))
					.seq(sacrificeTarget().apply(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("SJ_IW"))))
					
    return createGlobalBuff({
        id = "lich_extra_souljar_buff",
        name = "Soul Jar",
        abilities = {
            createAbility({
                id = "lich_souljar_buff_ability",
                trigger = onZeroHealthTrigger,
                aiPriority = toIntExpression(300),
                activations = multipleActivations,
                effect = sacrificeTarget().apply(selectLoc(loc(nextAllyPid, skillsPloc)).where(isCardName("SJ_DI").Or(isCardName("SJ_HoE")).Or(isCardName("SJ_UR")).Or(isCardName("SJ_M")).Or(isCardName("SJ_V")).Or(isCardName("SJ_IW"))))
				
                        .seq(ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("SJ_DI")).count().gte(1), ef_DI, 
    ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("SJ_HoE")).count().gte(1), ef_HoE, 
        ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("SJ_UR")).count().gte(1), ef_UR, 
            ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("SJ_M")).count().gte(1), ef_M, 
                ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("SJ_V")).count().gte(1), ef_M, 
                    ifElseEffect(selectLoc(loc(ownerPid, skillsPloc)).where(isCardName("SJ_IW")).count().gte(1), ef_M, 
                        nullEffect()
                    )
                )
            )
        )
    )
))
						
                        .seq(addSlotToPlayerEffect(currentPid, createPlayerSlot({
                            key = undamageablePlayerSlot,
                            expiry = { startOfOwnerTurnExpiry }
                        })))
						.seq(sacrificeTarget().apply(selectLoc(loc(nextAllyPid, buffsPloc)).where(isCardName("lich_extra_souljar_buff"))))
                        .seq(sacrificeSelf()),
						
                check = getPlayerHealth(controllerPid).lte(0)
            })
        }
    })
end

local function lich_30_hp_buff()
			
    return createGlobalBuff({
        id = "lich_30_hp_buff",
        name = "Embrace death",
        abilities = {
            createAbility({
                id = "lich_30_hp_buff_ability",
                trigger = onZeroHealthTrigger,
                aiPriority = toIntExpression(1),
                activations = multipleActivations,
                effect = 
				gainMaxHealthEffect(ownerPid, const(25)).seq(healPlayerEffect(ownerPid, 25))
				.seq(sacrificeTarget().apply(selectLoc(loc(nextOppPid, buffsPloc)).where(isCardName("lich_30_hp_buff"))))
				.seq(sacrificeSelf())

            })
        }
    })
end

function lichSetupBuffDef()

local ef_low3 = grantHealthTarget(-1, { SlotExpireEnum.never }, nullEffect(), "Puny creature debuff").apply(selectLoc(loc(nil, nullPloc)).where(isCardName("lich_zombie_minion").invert()))
				.seq(showSpeechBubbleEffect({
								playerExpression=currentPid,
								text="Puny creature. I feel weak just looking at you.",
								waitForClick= constBoolExpression(false)
							}))
local ef_low8 = grantHealthTarget(-1, { SlotExpireEnum.never }, nullEffect(), "Puny creature debuff").apply(selectLoc(loc(nil, nullPloc)).where(isCardName("lich_zombie_minion").invert()))
				.seq(showSpeechBubbleEffect({
								playerExpression=currentPid,
								text="My minions may be weakened, but you're so tiny you won't stop them.",
								waitForClick= constBoolExpression(false)
							}))
				--.seq(sacrificeTarget().apply(selectLoc(loc(currentPid, deckPloc)).where(isCardName("lich_major_summoning"))))
				--.seq(createCardEffect(lich_minor_summoning_carddef(), loc(currentPid, asidePloc)))


local ef_12 = showSpeechBubbleEffect({
								playerExpression=currentPid,
								text="A worthy foe, at last.",
								waitForClick= constBoolExpression(false)
							})


local ef_18plus = gainMaxHealthEffect(currentPid, const(20)).seq(healPlayerEffect(currentPid, 20))
				.seq(showSpeechBubbleEffect({
								playerExpression=currentPid,
								text="Your strength feeds my power!",
								waitForClick= constBoolExpression(false)
								}))


local ef_20plus = grantHealthTarget(1, { SlotExpireEnum.never }, nullEffect(), "Heroic debuff").apply(selectLoc(loc(nil, nullPloc)))
				.seq(showSpeechBubbleEffect({
								playerExpression=currentPid,
								text="Mwuhahahaha!",
								waitForClick= constBoolExpression(false)
								}))
								
	local efLichSetup = 
					--grimoire minions
				createCardEffect(lich_abomination_minion_carddef(), loc(nil, nullPloc))
				.seq(createCardEffect(lich_banshee_minion_carddef(), loc(nil, nullPloc)))
				.seq(createCardEffect(lich_ghoul_minion_carddef(), loc(nil, nullPloc)))
				.seq(createCardEffect(lich_revenant_minion_carddef(), loc(nil, nullPloc)))
				.seq(createCardEffect(lich_skeleton_horde_minion_carddef(), loc(nil, nullPloc)))
				.seq(createCardEffect(lich_skeleton_horde_minion_carddef(), loc(nil, nullPloc)))
				.seq(createCardEffect(lich_skeleton_horde_minion_carddef(), loc(nil, nullPloc)))
				.seq(createCardEffect(lich_wall_of_bones_minion_carddef(), loc(nil, nullPloc)))
				.seq(createCardEffect(lich_wall_of_fire_minion_carddef(), loc(nil, nullPloc)))
				.seq(createCardEffect(lich_zombie_minion_carddef(), loc(nil, nullPloc)))
				
				
					-- First Soul Jar
				.seq(randomEffect({
					valueItem(1, createCardEffect(lich_SJ_DI_carddef(), loc(ownerPid, skillsPloc)).seq(createCardEffect(lich_SJ_DI_carddef(), loc(nextAllyPid, skillsPloc))).seq(gainMaxHealthEffect(ownerPid, const(35))).seq(healPlayerEffect(ownerPid, 35))),
					valueItem(1, createCardEffect(lich_SJ_HoE_carddef(), loc(ownerPid, skillsPloc)).seq(createCardEffect(lich_SJ_HoE_carddef(), loc(nextAllyPid, skillsPloc))).seq(gainMaxHealthEffect(ownerPid, const(30))).seq(healPlayerEffect(ownerPid, 30))),
					valueItem(1, createCardEffect(lich_SJ_UR_carddef(), loc(ownerPid, skillsPloc)).seq(createCardEffect(lich_SJ_UR_carddef(),loc(nextAllyPid, skillsPloc))).seq(gainMaxHealthEffect(ownerPid, const(55))).seq(healPlayerEffect(ownerPid, 55))),
					valueItem(1, createCardEffect(lich_SJ_M_carddef(), loc(ownerPid, skillsPloc)).seq(createCardEffect(lich_SJ_M_carddef(),loc(nextAllyPid, skillsPloc))).seq(gainMaxHealthEffect(ownerPid, const(45))).seq(healPlayerEffect(ownerPid, 45))),
					valueItem(1, createCardEffect(lich_SJ_V_carddef(), loc(ownerPid, skillsPloc)).seq(createCardEffect(lich_SJ_V_carddef(),loc(nextAllyPid, skillsPloc))).seq(gainMaxHealthEffect(ownerPid, const(50))).seq(healPlayerEffect(ownerPid, 50))),
					valueItem(1, createCardEffect(lich_SJ_IW_carddef(), loc(ownerPid, skillsPloc)).seq(createCardEffect(lich_SJ_IW_carddef(),loc(nextAllyPid, skillsPloc))).seq(gainMaxHealthEffect(ownerPid, const(40))).seq(healPlayerEffect(ownerPid, 40))),
					}))
					
				-- levels 1-3
							.seq(ifElseEffect(getHeroLevel(oppPid).lte(3),
									ef_low3, nullEffect()))
									
							-- levels 1-8
							.seq(ifElseEffect(getHeroLevel(oppPid).lte(8),
									ef_low8, nullEffect()))

							-- levels 6+
							.seq(ifElseEffect(getHeroLevel(oppPid).gte(6),
									createCardEffect(lich_extra_souljar_buff(), loc(currentPid, buffsPloc)), 
									nullEffect() ))
									
							.seq(ifElseEffect(getHeroLevel(oppPid).gte(6),
									createCardEffect(lich_extra_souljar_buff(), loc(nextAllyPid, buffsPloc)), 
									nullEffect() ))
							
							-- levels 12+
							.seq(ifElseEffect(getHeroLevel(oppPid).gte(12),
									createCardEffect(lich_30_hp_buff(), loc(currentPid, buffsPloc)), 
									nullEffect() ))
							.seq(ifElseEffect(getHeroLevel(oppPid).gte(12),
									createCardEffect(lich_30_hp_buff(), loc(nextAllyPid, buffsPloc)), 
									nullEffect() ))
							.seq(ifElseEffect(getHeroLevel(oppPid).gte(12),
									ef_12, 
									nullEffect() ))
							
							-- levels 18+
							.seq(ifElseEffect(getHeroLevel(oppPid).gte(18),
									ef_18plus, 
									nullEffect() ))
							
							-- levels 20+
							.seq(ifElseEffect(getHeroLevel(oppPid).gte(20),
									ef_20plus, 
									nullEffect() ))
	--				
	
    return createGlobalBuff({
        id="lichSetupBuff",
        name = "Setup",
        abilities = {
					
			createAbility({
                id="lich_setup_effect",
                trigger = startOfGameTrigger,
                effect = efLichSetup
						
			
            })
        }
    })
end



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
                    art = "art/t_rayla_endweaver",
					text = "<size=60%>You start with 10 cards (8 unique minions) in your Grimoire. Whenever you perform a Summoning, randomly take one card from your Grimoire and put it into play. When a minion is stunned it returns to your Grimoire."
							})
    })

	local souljarbuff = createGlobalBuff({
        id="souljarbuff",
        name = "Soul Jar",
        abilities = {
            createAbility({
                id= "souljarbuff",
				trigger = startOfGameTrigger,
                effect = nullEffect(),
				}),
        },
		buffDetails = createBuffDetails({
					name = "Soul Jar",
                    art = "art/treasures/t_wizard_elixir_blue",
					text = "<size=80%>Each game 1 of 6 Soul Jars are randomly chosen to determine the Lich's Health and Skill."
							})
    })

-- Additional cards
local function lich_corruption_carddef()
local card_name = "lich_corruption"

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

local function lich_control_carddef()
local card_name = "lich_control"

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
        name = "Control",
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

local function lich_soul_diamond_carddef()
local card_name = "lich_soul_diamond"

	return createItemDef({
		id = "lich_soul_diamond",
		name = "Lich Soul Diamond",
		playLocation = castPloc,
		acquireCost = 0,
		types = { itemType, currencyType, gemType, nostealType },
		layout = createLayout({
					name = "Soul Diamond",
					art = "art/treasures/necromancer_soul_cage",
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
										art = "art/treasures/necromancer_soul_cage",
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
				art = "art/treasures/necromancer_soul_cage",
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
		)
	})
end

local function lich_frozen_touch_carddef()
local card_name = "lich_frozen_touch"

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

local function lich_soul_crush_carddef()
local card_name = "lich_soul_crush"

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

local function lich_wake_dead_carddef()
    local card_name = "Wake dead"
	
    return createActionDef({
        id = "lich_wake_dead",
		name = "Wake Dead",
		types = { actionType, curseType, nostealType },
		aiPriority = toIntExpression(1),
		acquireCost = 0,
        abilities = {
			createAbility({
				id = "lich_minor_summoning",
				trigger = autoTrigger,
				cost = noCost,
				effect = createCardEffect(necromancer_skeleton_warrior_carddef(), currentInPlayLoc),
				check = selectLoc(loc(nil, nullPloc)).count().gte(1),
				tags = {  },
				aiPriority = toIntExpression(-2)
			}),
		},
        layout = createLayout(
                {
                    name = "Wake Dead",
			art = "art/epicart/the_risen",
			frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
<vlayout>
<hlayout flexibleheight="1">
<box flexiblewidth="7">
<tmpro text="Put a Skeleton Warrior into play." fontsize="24" />
</box>
</hlayout>
</vlayout>
					]]
                }
            )
    })
end

local function lich_minor_summoning_carddef()
    local card_name = "lich_minor_summoning"
	
    return createActionDef({
        id = "lich_minor_summoning",
		name = "Minor Summoning",
		types = { actionType, curseType, nostealType },
		aiPriority = toIntExpression(1),
		acquireCost = 0,
        abilities = {
			createAbility({
				id = "lich_minor_summoning",
				trigger = autoTrigger,
				cost = noCost,
				effect = randomTarget(const(1), moveTarget(inPlayPloc)).apply(selectLoc(loc(nil, nullPloc))).seq(noUndoEffect()),
				check = selectLoc(loc(nil, nullPloc)).count().gte(1),
				tags = {  },
				aiPriority = toIntExpression(-2)
			}),
		},
        layout = createLayout(
                {
                    name = "Minor Summoning",
			art = "art/epicart/necrovirus",
			frame = "frames/necromancer_frames/necromancer_item_cardframe",
                    xmlText=[[
<vlayout>
<hlayout flexibleheight="1">
<box flexiblewidth="7">
<tmpro text="Perform 1 Summoning." fontsize="24" />
</box>
</hlayout>
</vlayout>
					]]
                }
            )
    })
end



local function lich_major_summoning_carddef()
local card_name = "lich_major_summoning"

	return createActionDef({
		id = "lich_major_summoning",
		name = "Major Summoning",
		playLocation = castPloc,
		acquireCost = 0,
		types = { actionType, curseType, nostealType },
		layout = createLayout({
					name = "Major Summoning",
					art = "art/epicart/abyss_summoner",
					frame = "frames/necromancer_frames/necromancer_item_cardframe",
					cost = 0,
					xmlText=
					[[
<vlayout>
<hlayout flexibleheight="1">
<box flexiblewidth="7">
<tmpro text="Perform 2 Summonings." fontsize="24" />
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
				effect = randomTarget(const(2), moveTarget(inPlayPloc)).apply(selectLoc(loc(nil, nullPloc))).seq(noUndoEffect()),
				check = selectLoc(loc(nil, nullPloc)).count().gte(2),
			}),
		},
	})
end

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
<hlayout forcewidth="true" spacing="10">         <icon text="{expend}" fontsize="40"/>
<hlayout spacing="10">
<text text="{combat_4}" fontsize="55"/>
</hlayout>          
<icon text=" " fontsize="22"/>
</hlayout>
<divider/>
<hlayout flexibleheight="7">
<vlayout flexiblewidth="8">
<tmpro text="&lt;space=1em/&gt;It feels neither pain nor fear. But you will..." fontsize="13" flexiblewidth="10" fontstyle="italic" flexibleheight="0.3"/>
</vlayout>
</hlayout>
<divider/>
<hlayout flexibleheight="7">
<vlayout flexiblewidth="8">
<tmpro text="When this card leaves play return it to the Grimoire deck." fontsize="13" flexiblewidth="10"
 flexibleheight="0.3"/>
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
					art = "art/t_banshee",
					frame = "frames/necromancer_frames/necromancer_item_cardframe",
					cost = 0,
					health = 3,
					isGuard = false,
					xmlText=
					[[
<vlayout>
<hlayout flexibleheight="6">
<box flexiblewidth="1">
<tmpro text="{expend}" fontsize="42"/>
</box>
<vlayout flexiblewidth="7">

<box flexibleheight="2">
<tmpro text="Deal 2 damage to each opposing champion and your opponent." fontsize="22" />
</box>
<box flexibleheight="0.5">
<tmpro text="(Guards do not prevent this.)
 " fontstyle="italic" fontsize="18" />
</box>
</vlayout>
</hlayout>

<divider/>
<hlayout flexibleheight="2">
<vlayout flexiblewidth="8">
<tmpro text="When this card leaves play return it to the Grimoire deck." fontsize="13" flexiblewidth="10"
 flexibleheight="0.3"/>
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
				effect = hitOpponentEffect(2).seq(damageTarget(2).apply(selectLoc(loc(oppPid, inPlayPloc))))
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
<hlayout flexibleheight="6">
<tmpro text="{expend}" fontsize="40" flexiblewidth="2"/>
<tmpro text="{combat_3}
&lt;size=50%&gt;+{combat_1} for each champion in your discard pile." fontsize="45
" flexiblewidth="12" />
</hlayout>

<divider/>
<hlayout flexibleheight="2">
<vlayout flexiblewidth="8">
<tmpro text="When this card leaves play return it to the Grimoire deck." fontsize="13" flexiblewidth="10"
 flexibleheight="0.3"/>
</vlayout>
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

<tmpro text="&lt;size=120%&gt;{health_5}
&lt;size=80%&gt;or
&lt;size=100%&gt;Stun an opposing champion." fontsize="24" alignment="Center" flexibleheight="6.6"/>          
</vlayout>
</hlayout>
<divider/>
<hlayout flexibleheight="2">
<vlayout flexiblewidth="8">
<tmpro text="When this card leaves play return it to the Grimoire deck." fontsize="13" flexiblewidth="10"
flexibleheight="0.3"/>
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
					art = "art/t_angry_skeleton",
					frame = "frames/necromancer_frames/necromancer_item_cardframe",
					cost = 0,
					health = 4,
					isGuard = false,
					xmlText=
					[[
<vlayout>
<hlayout flexibleheight="2">
<tmpro text="{expend}" fontsize="50" flexiblewidth="1"/>
<vlayout flexiblewidth="6">
<icon text="{combat_3}" fontsize="60" alignment="Center" flexibleheight="1"/>

</vlayout>
</hlayout>

<divider/>
<hlayout flexibleheight="2">
<vlayout flexiblewidth="8">
<tmpro text="When this card leaves play return it to the Grimoire deck." fontsize="13" flexiblewidth="10"
flexibleheight="0.3"/>
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
					art = "art/t_skeleton",
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

<divider/>
<hlayout flexibleheight="2">
<vlayout flexiblewidth="8">
<tmpro text="When this card leaves play return it to the Grimoire deck." fontsize="13" flexiblewidth="10"
flexibleheight="0.3"/>
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
					art = "art/t_charing_guardian",
					frame = "frames/necromancer_frames/necromancer_item_cardframe",
					cost = 0,
					health = 7,
					isGuard = false,
					xmlText=
					[[
<vlayout>
<hlayout flexibleheight="6">
<tmpro text="{expend}" fontsize="55" flexiblewidth="1"/>
<tmpro text="Deal 2 damage to your opponent." fontsize="22" flexiblewidth="4"/>
</hlayout>
<divider/>
<hlayout flexibleheight="2">
<vlayout flexiblewidth="8">
<tmpro text="When this card leaves play return it to the Grimoire deck." fontsize="13" flexiblewidth="10"
flexibleheight="0.3"/>
</vlayout>
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
				effect = hitOpponentEffect(2),
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
					art = "art/epicart/zombie_token",
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

<divider/>
<hlayout flexibleheight="2">
<vlayout flexiblewidth="8">
<tmpro text="When this card leaves play return it to the Grimoire deck." fontsize="13" flexiblewidth="10"
flexibleheight="0.3"/>
</vlayout>
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
		tags = { "Soul Jar" },
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
        id = "SJ_HoE",
        name = "Heart of Evil",
		tags = { "Soul Jar" },
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
		tags = { "Soul Jar" },
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
        id = "SJ_DI",
        name = "Deep Insight",
		tags = { "Soul Jar" },
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
		tags = { "Soul Jar" },
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
        id = "SJ_IW",
        name = "Infernal Wealth",
		tags = { "Soul Jar" },
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
		tags = { "Soul Jar" },
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
        id = "SJ_UR",
        name = "Unending Rage",
		tags = { "Soul Jar" },
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
		tags = { "Soul Jar" },
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
        id = "SJ_V",
        name = "Void",
		tags = { "Soul Jar" },
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
		tags = { "Soul Jar" },
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
        id = "SJ_M",
        name = "Manipulation",
		tags = { "Soul Jar" },
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

-- buffs

function lich_taunt_skill_def()
	
	local cardLayout = createLayout({
		name = "Taunt",
		art = "art/epicart/second_wind",
		xmlText = [[
<vlayout>
<hlayout flexibleheight="4">
<tmpro text="{expend}" fontsize="40" flexiblewidth="2"/>
<tmpro text="If there are no champions opposite you, you may move 1-2 enemy champions
from your Ally's area
into your own area." fontsize="18" flexiblewidth="12" />
</hlayout>
</vlayout>
		]]
	})

	return createSkillDef({
		id = "lich_taunt_custom",
		name = "lich_taunt",
		types = { skillType },
		layout = cardLayout,
		layoutPath= "art/epicart/second_wind",
        abilities = {
			createAbility({
				id = "taunt",
				trigger = uiTrigger,
				activations = singleActivations,
				layout = cardLayout,
				promptType = showPrompt,
				effect = pushTargetedEffect({
							desc = "Move 1-2 enemy champions from your Ally's area into your area.",
							validTargets = selectLoc(loc(nextOppPid, inPlayPloc)).where(isCardChampion()),
							min = 1,
							max = 2,
							targetEffect = moveTarget(loc(oppPid, inPlayPloc)),
							}),
				check = selectLoc(loc(oppPid, inPlayPloc)).where(isCardChampion()).count().eq(0)
							.And(selectLoc(loc(nextOppPid, inPlayPloc)).where(isCardChampion()).count().gte(1)),
				cost = expendCost
			})
		},

	})
end

function lich_show_grimoire_skill_def()
	
	local cardLayout = createLayout({
		name = "Show Grimoire",
		art = "art/epicart/zealous_necromancer",
		xmlText = [[
<vlayout>
<hlayout flexibleheight="4">
<tmpro text="View cards currently in the Lich's Grimoire." fontsize="24" flexiblewidth="12" />
</hlayout>
</vlayout>
		]]
	})

	return createSkillDef({
		id = "lich_show_grimoire_custom",
		name = "Show Grimoire",
		types = { skillType },
		layout = cardLayout,
		layoutPath= "art/epicart/zealous_necromancer",
        abilities = {
			createAbility({
				id = "show_grimoire",
				trigger = uiTrigger,
				activations = multipleActivations,
				layout = cardLayout,
				promptType = showPrompt,
				effect = moveTarget(currentRevealLoc).apply(selectLoc(loc(nil, nullPloc)))
				.seq(waitForClickEffect("Cards currently in the Lich's Grimoire.", "Cards currently in the Lich's Grimoire."))
				
				.seq(pushTargetedEffect({
							desc = "Click one to resume play.",
							validTargets = selectLoc(currentRevealLoc),
							min = 1,
							max = 1,
							targetEffect = moveTarget(nullPloc).seq(moveTarget(nullPloc).apply(selectLoc(currentRevealLoc))),
			    })),
				
				cost = noCost
			})
		},

	})
end
-- Speech

local function ee_demon_hunter_carddef()
    local card_name = "Aarkenell, Demonsbane"
    return createChampionDef(
        {
            id = "demon_hunter",
            name = "Aarkenell, Demonsbane",
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
                    name = "Aarkenell, Demonsbane",
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
        description = "Lich class - based on WWG's Boss Deck. Script created for digital Co-op 26.06.2025. Updated 25.07.2025",
        ai = createCoopAi(),
        timeoutAi = createTimeoutAi(),
        playerOrder = { plid3, plid1, plid4, plid2 },
        opponents = { { plid1, plid3 }, { plid2, plid4 }},
		tradeDeckExceptions = {
		{ qty=1, cardId="demon_hunter" }
		},
        players = {
            {
                id = plid1,
                canAttackAllyOppChampions = true,
				startDraw = 5,
                init = { 
                    fromEnv = plid1
                },
                avatar = "",
                cards = {
                    skills = {
						{ qty=1, card= share_card_2v2_skilldef() },
						{ qty=1, card= lich_taunt_skill_def() },
						{ qty=1, card= lich_show_grimoire_skill_def() },
						
						
					},
					buffs = {
                        drawCardsCountAtTurnEndDef(5),
                        discardCardsAtTurnStartDef(),
						--lichSetup2BuffDef(),
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
                cards = {
                    skills = {
						{ qty=1, card= share_card_2v2_skilldef() },
						{ qty=1, card= lich_taunt_skill_def() },
						{ qty=1, card= lich_show_grimoire_skill_def() },
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
                name = "Lich",
                syncHealth = true,
                startDraw = 3,
				avatar = "WarInTheWild/krythos_master_vampire",
				health = 0,
                cards = {
                    deck = {
							{qty = 7, card = gold_carddef()}, 
							{qty = 0, card = lich_soul_diamond_carddef()},
							{qty = 3, card = ruby_carddef()},
							{qty = 2, card = lich_soul_crush_carddef()},
							{qty = 2, card = lich_frozen_touch_carddef()},
							{qty = 2, card = lich_minor_summoning_carddef()},
							{qty = 1, card = lich_major_summoning_carddef()},
							{qty = 1, card = lich_wake_dead_carddef()},
							

                    },
                    skills = {
						  
                    },
                    buffs = {
                        bossMoveCardsAtTurnEndDef(),
                        shareDiscardsAtTurnStartDef(),
                        drawCardsCountAtTurnEndDef(5),
                        discardCardsAtTurnStartDef(),
                        aiTurnBuffDef(),
						lichSetupBuffDef(),
						
						corruption20_BuffDef(),
						Grimoirebuff,
						souljarbuff,
						

                    }
                }
            },
            {
                id = plid4,
                isAi = true,
                name = "Lich",
                syncHealth = true,
                startDraw = 0,
                avatar="WarInTheWild/krythos_master_vampire",
                health = 0,
                cards = {
                    skills = {   					
                    },
                    buffs = {
                        bossMoveCardsAtTurnEndDef(),
                        shareDiscardsAtTurnStartDef(),
                        drawCardsCountAtTurnEndDef(5),
                        discardCardsAtTurnStartDef(),
                        aiTurnBuffDef(),
						
						corruption20_BuffDef(),
						Grimoirebuff,
						souljarbuff,
						

                    }
                }
            }
        }
    })
end


function corruption20_BuffDef()
	local ef_Corruption = 
	createCardEffect(lich_corruption_carddef(), loc(currentPid, skillsPloc))
	.seq(createCardEffect(lich_corruption_carddef(), loc(nextAllyPid, skillsPloc)))
	.seq(createCardEffect(corruption30_BuffDef(), loc(currentPid, buffsPloc)))		
	.seq(createCardEffect(corruption30_BuffDef(), loc(nextAllyPid, buffsPloc)))			
			.seq(sacrificeTarget().apply(selectLoc(loc(nextAllyPid, buffsPloc)).where(isCardName("corruption20buff"))))
			.seq(sacrificeSelf())

    return createGlobalBuff({
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
                    art = "art/t_charing_guardian",
					text = "<size=70%>When you shuffle your deck, if you have 20 or more cards in your deck, hand and in play (not including minions), gain the Corruption skill (which performs a Summoning)."
							})
    })
end

function corruption30_BuffDef()
	local ef_Corruption = 
	
	createCardEffect(lich_control_carddef(), loc(currentPid, skillsPloc))
	.seq(createCardEffect(lich_control_carddef(), loc(nextAllyPid, skillsPloc)))
	.seq(sacrificeTarget().apply(selectLoc(loc(currentPid, skillsPloc)).where(isCardName("corruption_skill"))))
	.seq(sacrificeTarget().apply(selectLoc(loc(nextAllyPid, skillsPloc)).where(isCardName("corruption_skill"))))
			.seq(sacrificeTarget().apply(selectLoc(loc(nextAllyPid, buffsPloc)).where(isCardName("corruption30buff"))))
			.seq(sacrificeSelf())

    return createGlobalBuff({
        id="corruption30buff",
        name = "Control",
        abilities = {
            createAbility({
                id= "corruption30buff",
				trigger = deckShuffledTrigger,
                effect = ifElseEffect(selectLoc(loc(currentPid, handPloc)).union(selectLoc(loc(currentPid, inPlayPloc))).union(selectLoc(loc(currentPid, deckPloc))).where(isCardType(minionType).invert()).count().gte(30), ef_Corruption, nullEffect()),
            }),
        },
		buffDetails = createBuffDetails({
					name = "Corruption",
                    art = "art/t_charing_guardian",
					text = "<size=70%>When you shuffle your deck, if you have 30 or more cards in your deck, hand and in play (not including minions), gain the Control skill (which performs 2 Summonings)."
							})
    })
end



function endGame(g)
end




            function setupMeta(meta)
                meta.name = "Lich Co-Op"
                meta.minLevel = 0
                meta.maxLevel = 0
                meta.introbackground = ""
                meta.introheader = ""
                meta.introdescription = ""
                meta.path = ""
                meta.features = {
}

            end


function setupCoopIntro(encounter)
        encounter.name = "Lich Co-Op"
        encounter.description = "Lich class - based on WWG's Boss Deck. Script created for digital Co-op 26.06.2025. Updated 25.07.2025"
        encounter.minlevel = 1
        encounter.maxlevel = 24
        encounter.avatar = "avatars/vampire_lord"
        encounter.heroname = "The Lich"
        encounter.backgroundPath = "scenariointrobackgrounds/warInthewild/krythos_master_vampire"
        encounter.features = {
            encounter.feature("avatars/journeys/abomination", "The Lich has arisen. It is corrupting the city through the power of its Grimoire and it's undead minions. Stop the Lich before the city falls."),
            encounter.feature("avatars/vampire_lord", "The Lich is made undead through the power of Soul Jars. Each Soul Jar grants the Lich a unique skill to use each turn and grants it a various amount of health."),
            encounter.feature("avatars/skeleton", " Each game, one of six Soul Jars is selected at random. At level 6 and above, the Lich will use a second Soul Jar when it's life is first reduced to 0. (Other effects change the difficulty for various levels. Recommended for level 12+.")
        }
end