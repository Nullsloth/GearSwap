function user_job_setup()
    state.OffenseMode:options("Normal")
    state.HybridMode:options("Tank", "MEVA", "DTLite", "Ongo", "Normal")
    state.WeaponskillMode:options("Normal", "Tank")
    state.CastingMode:options("Normal", "SIRD", "DT")
    state.PhysicalDefenseMode:options("PDT")
    state.MagicalDefenseMode:options("MDT")
    state.ResistDefenseMode:options("MEVA")
    state.IdleMode:options("Normal", "Tank", "Refresh")
    state.Weapons:options("Epeolatry", "Lionheart", "Lycurgos", "Hepatizon", "None")
    state.MaintainAftermath = M(false, "Maintain Aftermath")
    state.MaintainTenebrae = M(false, "Maintain Tenebrae")
    --state.ReEquip = M(false, 'ReEquip Mode') --Set this to false if you don't want to equip your current Weapon set when you aren't wearing any weapons.
    state.ExtraDefenseMode = M({ ["description"] = "Extra Defense Mode", "None" })
    silibs.enable_cancel_outranged_ws()
    silibs.enable_cancel_on_blocking_status()
    silibs.enable_weapon_rearm()
    silibs.enable_auto_lockstyle(3)
    silibs.enable_waltz_refiner()
    silibs.enable_premade_commands()
    silibs.enable_th()
    silibs.enable_ui()
    if player.sub_job == "BLU" then
        send_command('wait 5; aset spellset subblu') --set sublu to your azuresets spell list name
    end

    autows_list = {
        ["Epeolatry"] = "Dimidiation", autowstp = 2000,
        ["Lionheart"] = "Resolution",
        ["Lycurgos"] = "Steel Cyclone",
        ["Hepatizon"] = "Full Break", autowstp = 1250
    }

    gear.tank_back = { name = "Ogma's Cape",
        augments = { "HP+60", "Eva.+20 /Mag. Eva.+20", "Enmity+10", "Phys. dmg. taken-10%" }, }
    gear.fc_back = { name = "Ogma's Cape", augments = { "HP+60", '"Fast Cast"+10', "Phys. dmg. taken-10%" }, }
    gear.sird_back = { name = "Ogma's Cape",
        augments = { "HP+60", "Eva.+20 /Mag. Eva.+20", "HP+20", "Enmity+10", "Spell interruption rate down-10%" }, }
    gear.jse_da_back = { name = "Ogma's cape",
        augments = { "DEX+20", "Accuracy+20 Attack+20", '"Dbl.Atk."+10', "Phys. dmg. taken-10%" }, }
    gear.jse_wsd_back = { name = "Ogma's cape",
        augments = { "DEX+20", "Accuracy+20 Attack+20", "DEX+10", "Weapon skill damage +10%", "Phys. dmg. taken-10%" }, }
    gear.jse_str_back = { name = "Ogma's cape",
        augments = { "STR+20", "Accuracy+20 Attack+20", "STR+10", '"Dbl.Atk."+10', "Phys. dmg. taken-10%" }, }

    gear.jovian_fc_body = { name = "Adhemar Jacket +1", augments = { "HP+105", '"Fast Cast"+10', "Magic dmg. taken -4" }, }

    -- Additional local binds
    send_command("bind !` gs c SubJobEnmity")
    send_command("bind @` gs c cycle RuneElement")
    send_command("bind ^` gs c RuneElement")
    send_command("bind @pause gs c toggle AutoRuneMode")
    send_command("bind @f6 gs c toggle AutoTankFull;")
    send_command("bind @f7 gs c toggle AutoBuffMode")
    send_command("bind @f8 gs c toggle AutoTankMode")
    send_command("bind @f9 gs c toggle MaintainTenebrae")
    send_command("bind @f10 gs c set toggle weapons KajaChopper")
    send_command('bind ^\\\\ input /ma "Protect IV" <t>')
    send_command('bind @\\\\ input /ma "Shell V" <t>')
    send_command('bind !\\\\ input /ma "Crusade" <me>')
    send_command('bind ^backspace input /ja "Rayke" <t>')
    send_command('bind @backspace input /ja "Gambit" <t>')
    send_command('bind !backspace input /ja "Lunge" <t>')

    select_default_macro_book()
end

function init_gear_sets()
    -- Weapons sets
    sets.weapons.Epeolatry = { main = { name = "Aettir", priority = 500 }, sub = { name = "Utu Grip", priority = 20 } }
    sets.weapons.Lionheart = { main = "Lionheart", sub = "Utu Grip" }
    sets.weapons.Lycurgos = { main = "Lycurgos", sub = "Utu Grip" }
    sets.weapons.Hepatizon = { main = "Hepatizon Axe", sub = "Utu Grip" }

    -- 50 DT/PDT
    -- 62 + 23 Weapon = 85

    sets.Enmity = {
        ammo = "Staunch Tathlum +1", -- 3
        head = { name = "Halitus Helm", priority = 88 }, -- 			8
        body = { name = "Emet harness +1", priority = 136 }, -- 10
        hands = { name = "Kurys Gloves", priority = 25 }, -- 2	/	9
        legs = { name = "Erilaz Leg Guards +1", priority = 80 }, -- 7	/	11
        feet = { name = "Erilaz Greaves +1", priority = 18 }, -- 4	/	7
        neck = { name = "Futhark Torque +2", priority = 500 }, --		/	10
        waist = { name = "Kasiri Belt", priority = 500 }, --3
        left_ear = { name = "Cryptic Earring", priority = 40 }, --		/	4
        right_ear = { name = "Odnowa Earring +1", priority = 500 }, -- 3
        left_ring = { name = "Eihwaz Ring", priority = 500 }, --		/	5
        right_ring = { name = "Gelatinous Ring +1", priority = 500 }, -- 7
        back = gear.tank_back, -- 10	/	10
    }

    sets.Enmity.DT = sets.Enmity

    -- Merits: 	10%
    -- Gear:	94%
    -- Total: 	104%

    -- PDT/DT:  40 = 65%
    -- Enmity: 	25 + 23 Weapon = 48

    sets.Enmity.SIRD = { --SIRD	/	DT-PDT	/	Enmity
        ammo = "Staunch Tathlum +1", -- 11	/	3
        head = { name = "Agwu's Cap", priority = 38 }, -- 10				/
        body = { name = "Nyame Mail", priority = 136 }, --		/	9
        hands = { name = "Rawhide gloves", priority = 500 }, -- 10
        legs = { name = "Carmine Cuisses +1", priority = 50 }, -- 20
        feet = "Teaon Feet Augmented", --		/	7
        neck = "Moonlight necklace", -- 15				/	15
        waist = "Audumbla Sash", -- 10	/	4
        left_ear = "Cryptic Earring",
        right_ear = { name = "Odnowa Earring +1", priority = 500 }, -- 			3
        left_ring = { name = "Moonlight Ring", priority = 500 }, --		/	5
        right_ring = { name = "Gelatinous Ring +1", priority = 500 }, --			7
        back = gear.sird_back, -- 10	/			/	10
    }

    --------------------------------------
    -- Precast sets
    --------------------------------------

    -- Item sets.

    -- Precast sets to enhance JAs
    sets.precast.JA["Vallation"] = set_combine(sets.Enmity,
        { body = { name = "Runeist's Coat +3", priority = 218 }, legs = { name = "Futhark Trousers +3", priority = 107 }, })
    sets.precast.JA["Valiance"] = set_combine(sets.Enmity,
        { body = { name = "Runeist's Coat +3", priority = 218 }, legs = { name = "Futhark Trousers +3", priority = 107 }, })
    sets.precast.JA["Pflug"] = set_combine(sets.Enmity, { feet = { name = "Runeist's Boots +3", priority = 74 } })
    sets.precast.JA["Battuta"] = set_combine(sets.Enmity,
        { head = { name = "Futhark Bandeau +3", priority = 56 }, legs = { name = "Erilaz Leg Guards +1", priority = 80 },
            feet = { name = "Terms Leggings +1", priority = 76 }, back = gear.tank_back, })
    sets.precast.JA["Liement"] = set_combine(sets.Enmity,
        { body = "Futhark Coat +3", back = { name = gear.dt_moon_back, priority = 500 } })
    sets.precast.JA["Gambit"] = set_combine(sets.Enmity, { hands = { name = "Runeist's Mitons +2", priority = 85 } })
    sets.precast.JA["Rayke"] = set_combine(sets.Enmity, { feet = "Futhark Boots +1" })
    sets.precast.JA["Elemental Sforzo"] = set_combine(sets.Enmity,
        { body = { name = "Futhark Coat +3", priority = 119 } })
    sets.precast.JA["Swordplay"] = set_combine(sets.Enmity, { hands = { name = "Futhark Mitons +3", priority = 45 } })
    sets.precast.JA["Embolden"] = set_combine(sets.Enmity, {})
    sets.precast.JA["One For All"] = set_combine(sets.Enmity, {})
    sets.precast.JA["Last Resort"] = set_combine(sets.Enmity, {})

    sets.precast.JA["Lunge"] = {
        ammo = "Pemphredo Tathlum",
        head = { name = "Nyame Helm", priority = 91 },
        body = { name = "Nyame Mail", priority = 136 },
        hands = { name = "Nyame Gauntlets", priority = 91 },
        legs = { name = "Nyame Flanchard", priority = 114 },
        feet = { name = "Nyame Sollerets", priority = 68 },
        neck = "Baetyl Pendant",
        waist = "Kasiri Belt",
        left_ear = "Telos Earring",
        right_ear = { name = "Odnowa Earring +1", priority = 500 },
        left_ring = { name = "Moonlight Ring", priority = 500 },
        right_ring = { name = "Gelatinous Ring +1", priority = 500 },
        back = gear.tank_back,
    }
    sets.precast.JA["Swipe"] = sets.precast.JA["Lunge"]

    -- Pulse sets, different stats for different rune modes, stat aligned.
    sets.precast.JA["Vivacious Pulse"] = { head = { name = "Erilaz Galea +1", priority = 91 }, neck = "Incanter's Torque",
        legs = { name = "Rune. Trousers +3", priority = 80 }, }
    sets.precast.JA["Vivacious Pulse"]["Ignis"] = set_combine(sets.precast.JA["Vivacious Pulse"], {})
    sets.precast.JA["Vivacious Pulse"]["Gelus"] = set_combine(sets.precast.JA["Vivacious Pulse"], {})
    sets.precast.JA["Vivacious Pulse"]["Flabra"] = set_combine(sets.precast.JA["Vivacious Pulse"], {})
    sets.precast.JA["Vivacious Pulse"]["Tellus"] = set_combine(sets.precast.JA["Vivacious Pulse"], {})
    sets.precast.JA["Vivacious Pulse"]["Sulpor"] = set_combine(sets.precast.JA["Vivacious Pulse"], {})
    sets.precast.JA["Vivacious Pulse"]["Unda"] = set_combine(sets.precast.JA["Vivacious Pulse"], {})
    sets.precast.JA["Vivacious Pulse"]["Lux"] = set_combine(sets.precast.JA["Vivacious Pulse"], {})
    sets.precast.JA["Vivacious Pulse"]["Tenebrae"] = set_combine(sets.precast.JA["Vivacious Pulse"], {})

    -- Runes
    sets.precast.JA["Ignis"] = set_combine(sets.Enmity, {})
    sets.precast.JA["Gelus"] = set_combine(sets.Enmity, {})
    sets.precast.JA["Flabra"] = set_combine(sets.Enmity, {})
    sets.precast.JA["Tellus"] = set_combine(sets.Enmity, {})
    sets.precast.JA["Sulpor"] = set_combine(sets.Enmity, {})
    sets.precast.JA["Unda"] = set_combine(sets.Enmity, {})
    sets.precast.JA["Lux"] = set_combine(sets.Enmity, {})
    sets.precast.JA["Tenebrae"] = set_combine(sets.Enmity, {})

    -- Fast cast sets for spells
    -- Insipiration: 26% [2/5]
    -- FC: 67%
    sets.precast.FC = {
        ammo = "Sapience Orb", -- 2
        head = { name = "Runeist's Bandeau +2", priority = 109 }, -- 14
        body = gear.jovian_fc_body, -- 10
        hands = { name = "Leyline Gloves", priority = 25 }, -- 6-8
        legs = "Aya. Cosciales +2", -- 6
        feet = { name = "Carmine Greaves +1", priority = 95 }, -- 8
        neck = "Orunmila's Torque", -- 4
        waist = { name = "Kasiri Belt", priority = 500 },
        left_ear = { name = "Etiolation Earring", priority = 500 }, -- 1
        right_ear = { name = "Enchntr. Earring +1", priority = 500 },
        left_ring = { name = "Kishar Ring", priority = 500 }, -- 6
        right_ring = { name = "Gelatinous Ring +1", priority = 500 },
        back = gear.fc_back, -- 10
    }

    sets.precast.FC["Enhancing Magic"] = set_combine(sets.precast.FC, { legs = "Futhark Trousers +3" })
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {})
    sets.precast.FC.Cure = set_combine(sets.precast.FC, {})

    sets.precast.FC.ValianceVallation = set_combine(
        sets.precast.FC,
        { neck = { name = "Futhark Torque +2", priority = 500 } }
    )
    sets.precast.FC.ValianceVallationEnhancing = set_combine(
        sets.precast.FC,
        { legs = "Futhark Trousers +3", neck = { name = "Futhark Torque +2", priority = 500 } }
    )

    -- Weaponskill sets
    sets.precast.WS = {
        ammo = "Knobkierrie",
        head = { name = "Nyame Helm", priority = 91 },
        body = { name = "Nyame Mail", priority = 136 },
        hands = { name = "Nyame Gauntlets", priority = 91 },
        legs = { name = "Nyame Flanchard", priority = 114 },
        feet = { name = "Nyame Sollerets", priority = 68 },
        neck = "Fotia Gorget",
        waist = "Fotia Belt",
        left_ear = "Ishvara Earring",
        right_ear = { name = "Moonshade Earring", augments = { "Accuracy+4", "TP Bonus +250" } },
        left_ring = "Regal Ring",
        right_ring = "Rufescent Ring",
        back = gear.jse_wsd_back,
    }

    sets.precast.WS["Resolution"] = {
        ammo = "Knobkierrie",
        head = { name = "Nyame Helm", priority = 91 },
        body = { name = "Nyame Mail", priority = 136 },
        hands = "Nyame Gauntlets",
        legs = { name = "Nyame Flanchard", priority = 114 },
        feet = { name = "Nyame Sollerets", priority = 68 },
        neck = "Fotia Gorget",
        waist = "Fotia Belt",
        left_ear = "Sherida Earring",
        right_ear = { name = "Moonshade Earring", augments = { "Accuracy+4", "TP Bonus +250" } },
        left_ring = "Regal Ring",
        right_ring = "Niqmaddu Ring",
        back = gear.jse_str_back,
    }

    sets.precast.WS["Dimidiation"] = {
        ammo = "Knobkierrie",
        head = "Nyame Helm",
        body = { name = "Nyame Mail", priority = 136 },
        hands = "Nyame Gauntlets",
        legs = { name = "Nyame Flanchard", priority = 114 },
        feet = { name = "Nyame Sollerets", priority = 68 },
        neck = "Fotia Gorget",
        waist = "Fotia Belt",
        left_ear = "Sherida Earring",
        right_ear = "Moonshade Earring",
        left_ring = "Ilabrat Ring",
        right_ring = "Niqmaddu Ring",
        back = gear.jse_wsd_back,
    }

    -- 50 PDT/DT
    -- 3152 HP
    sets.precast.WS.Tank = {
        ammo = "Knobkierrie",
        head = { name = "Nyame Helm", priority = 91 },
        body = { name = "Nyame Mail", priority = 136 },
        hands = { name = "Regal Gauntlets", priority = 205 },
        legs = { name = "Nyame Flanchard", priority = 114 },
        feet = { name = "Nyame Sollerets", priority = 68 },
        neck = { name = "Futhark Torque +2", priority = 60 },
        waist = "Flume Belt +1",
        left_ear = "Sherida Earring",
        right_ear = { name = "Odnowa Earring +1", priority = 500 },
        left_ring = { name = "Moonlight Ring", priority = 500 },
        right_ring = { name = "Gelatinous Ring +1", priority = 500 },
        back = gear.jse_wsd_back,
    }

    sets.precast.WS["Resolution"].Tank = set_combine(sets.precast.WS.Tank, {})
    sets.precast.WS["Dimidiation"].Tank = set_combine(sets.precast.WS.Tank, {})

    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = sets.precast.FC
    sets.midcast.FastRecast.DT = sets.precast.FC

    -- Enhancing duration
    sets.midcast["Enhancing Magic"] = {
        ammo = "Staunch Tathlum +1",
        head = "Erilaz Galea +1", -- 15%
        body = { name = "Runeist's Coat +3", priority = 218 },
        hands = { name = "Regal Gauntlets", priority = 205 }, -- 20%
        legs = { name = "Futhark Trousers +3", priority = 107 }, -- 30%
        feet = { name = "Nyame Sollerets", priority = 500 },
        neck = "Incanter's Torque",
        waist = "Flume Belt +1",
        left_ear = "Andoaa Earring",
        right_ear = { name = "Odnowa Earring +1", priority = 500 },
        left_ring = "Defending Ring",
        right_ring = { name = "Gelatinous Ring +1", priority = 500 },
        back = gear.tank_back,
    }
    sets.midcast["Enhancing Magic"].SIRD = set_combine(sets.midcast["Enhancing Magic"], {})
    sets.midcast["Enhancing Magic"].DT = set_combine(sets.midcast["Enhancing Magic"], {})

    -- 455 Enhancing
    -- 39% PDT/DT
    sets.midcast["Phalanx"] = {
        ammo = "Staunch Tathlum +1",
        head = "Futhark Bandeau +3", -- Phalanx +7
        body = gear.taeon_phalanx_body, -- Phalanx +3
        hands = { name = "Regal Gauntlets", priority = 205 }, -- 20%
        legs = gear.taeon_phalanx_legs, -- Phalanx +3
        feet = gear.taeon_phalanx_feet, -- Phalanx +3
        neck = "Futhark Torque +2",
        waist = "Flume Belt +1",
        left_ear = "Andoaa Earring", -- 5
        right_ear = { name = "Odnowa Earring +1", priority = 500 },
        left_ring = { name = "Moonlight Ring", priority = 500 },
        right_ring = { name = "Gelatinous Ring +1", priority = 500 },
        back = { name = gear.dt_moon_back, priority = 500 },
    }

    sets.midcast["Phalanx"].DT = set_combine(sets.midcast["Phalanx"], {})

    -- 503 Skill
    sets.midcast["Temper"] = {
        ammo = "Staunch Tathlum +1",
        head = "Carmine Mask +1", -- 11
        body = { name = "Runeist's Coat +3", priority = 218 },
        hands = "Runeist's Mitons +3", -- 19
        legs = { name = "Carmine Cuisses +1", priority = 50 }, -- 18
        feet = { name = "Nyame Sollerets", priority = 68 },
        neck = "Incanter's Torque", -- 10
        waist = "Flume Belt +1",
        left_ear = "Andoaa Earring", -- 5
        right_ear = { name = "Odnowa Earring +1", priority = 500 },
        left_ring = "Defending Ring",
        right_ring = { name = "Gelatinous Ring +1", priority = 500 },
        back = { name = gear.dt_moon_back, priority = 500 },
    }
    sets.midcast["Temper"].SIRD = set_combine(sets.midcast["Temper"], {})
    sets.midcast["Temper"].DT = set_combine(sets.midcast["Temper"], {})

    -- 503 Skill
    sets.midcast.BarElement = sets.midcast["Temper"]
    sets.midcast.BarElement.SIRD = sets.midcast["Temper"]
    sets.midcast.BarElement.DT = sets.midcast["Temper"]

    sets.midcast["Regen"] = set_combine(
        sets.midcast["Enhancing Magic"],
        { head = "Runeist's Bandeau +3", neck = "Sacro Gorget" }
    )
    sets.midcast["Regen"].SIRD = set_combine(
        sets.midcast["Enhancing Magic"],
        { head = "Runeist's Bandeau +3", neck = "Sacro Gorget" }
    )
    sets.midcast["Regen"].DT = set_combine(
        sets.midcast["Enhancing Magic"],
        { head = "Runeist's Bandeau +3", neck = "Sacro Gorget" }
    )

    sets.midcast["Refresh"] = set_combine(sets.midcast["Enhancing Magic"], {})
    sets.midcast["Refresh"].SIRD = set_combine(sets.midcast["Enhancing Magic"], {})
    sets.midcast["Refresh"].DT = set_combine(sets.midcast["Enhancing Magic"], {})

    sets.midcast.Stoneskin = set_combine(sets.midcast["Enhancing Magic"], { waist = "Siegel Sash" })
    sets.midcast.Stoneskin.SIRD = set_combine(sets.midcast["Enhancing Magic"], { waist = "Siegel Sash" })
    sets.midcast.Stoneskin.DT = set_combine(sets.midcast["Enhancing Magic"], { waist = "Siegel Sash" })

    sets.midcast.Aquaveil = set_combine(sets.Enmity.SIRD, {})
    sets.midcast.Aquaveil.SIRD = set_combine(sets.Enmity.SIRD, {})
    sets.midcast.Aquaveil.DT = set_combine(sets.Enmity.SIRD, {})

    sets.midcast.Crusade = set_combine(sets.Enmity.SIRD, {})
    sets.midcast.Crusade.SIRD = set_combine(sets.Enmity.SIRD, {})
    sets.midcast.Crusade.DT = set_combine(sets.Enmity.SIRD, {})

    sets.midcast.Poisonga = set_combine(sets.Enmity, {})
    sets.midcast.Poisonga.SIRD = set_combine(sets.Enmity.SIRD, {})
    sets.midcast.Poisonga.DT = set_combine(sets.Enmity.SIRD, {})

    sets.midcast["Banish"] = set_combine(sets.Enmity.SIRD, {})
    sets.midcast["Banish"].SIRD = set_combine(sets.Enmity.SIRD, {})
    sets.midcast["Banish"].DT = set_combine(sets.Enmity.SIRD, {})

    sets.midcast["Banishga"] = set_combine(sets.Enmity.SIRD, {})
    sets.midcast["Banishga"].SIRD = set_combine(sets.Enmity.SIRD, {})
    sets.midcast["Banishga"].DT = set_combine(sets.Enmity.SIRD, {})

    sets.midcast.Flash = set_combine(sets.Enmity, {})
    sets.midcast.Flash.SIRD = set_combine(sets.Enmity, {})
    sets.midcast.Flash.DT = set_combine(sets.Enmity, {})

    sets.midcast.Stun = set_combine(sets.Enmity, {})
    sets.midcast.Stun.SIRD = set_combine(sets.Enmity, {})
    sets.midcast.Stun.DT = set_combine(sets.Enmity, {})

    sets.midcast.Foil = set_combine(sets.Enmity, {})
    sets.midcast.Foil.SIRD = set_combine(sets.Enmity.SIRD, {})
    sets.midcast.Foil.DT = set_combine(sets.Enmity, {})

    -- BLU spells
    sets.midcast["Blue Magic"] = set_combine(sets.Enmity, {})
    sets.midcast["Blue Magic"].SIRD = set_combine(sets.Enmity.SIRD, {})
    sets.midcast["Blue Magic"].DT = set_combine(sets.Enmity.SIRD, {})

    sets.midcast.Cocoon = sets.Enmity.SIRD
    sets.midcast.Cocoon.SIRD = sets.Enmity.SIRD
    sets.midcast.Cocoon.DT = sets.Enmity.SIRD

    sets.Self_Healing = {}
    sets.Cure_Received = {}
    sets.Self_Refresh = { waist = "Gishdubar Sash" }

    sets.midcast.Protect = set_combine(sets.midcast["Enhancing Magic"], {})
    sets.midcast.Protect.SIRD = set_combine(sets.midcast["Enhancing Magic"], {})
    sets.midcast.Protect.DT = set_combine(sets.midcast["Enhancing Magic"], {})

    sets.midcast.Shell = set_combine(sets.midcast["Enhancing Magic"], {})
    sets.midcast.Shell.SIRD = set_combine(sets.midcast["Enhancing Magic"], {})
    sets.midcast.Shell.DT = set_combine(sets.midcast["Enhancing Magic"], {})

    sets.midcast["Raise"] = set_combine(sets.Enmity.SIRD, {})
    sets.midcast["Raise"].SIRD = set_combine(sets.Enmity.SIRD, {})
    sets.midcast["Raise"].DT = set_combine(sets.Enmity.SIRD, {})

    sets.midcast["Healing Magic"] = set_combine(sets.Enmity.SIRD, {})
    sets.midcast["Healing Magic"].SIRD = set_combine(sets.Enmity.SIRD, {})
    sets.midcast["Healing Magic"].DT = set_combine(sets.Enmity.SIRD, {})
    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------

    sets.resting = {}

    sets.idle = {
        ammo = "Homiliary", -- 			/ 3 DT	/
        head = { name = "Nyame Helm", priority = 91 }, -- 			/		/
        body = { name = "Nyame Mail", priority = 218 },
        hands = { name = "Regal Gauntlets", priority = 205 },
        legs = { name = "Nyame Flanchard", priority = 114 }, -- 		 	/ 9 DT	/
        feet = { name = "Turms Leggings +1", priority = 500 },
        neck = { name = "Futhark Torque +2", priority = 60 }, -- 			/ 6 DT	/
        waist = "Flume Belt +1", -- 4 PDT 	/		/
        left_ear = { name = "Etiolation Earring", priority = 50 },
        right_ear = { name = "Odnowa Earring +1", priority = 500 }, --			/		/	2 MDT
        left_ring = "Defending Ring",
        right_ring = { name = "Gelatinous Ring +1", priority = 500 }, -- 7  PDT	/		/	-1 MDT
        back = gear.tank_back, -- 10 PDT	/		/
    }

    sets.idle.Tank = {
        ammo = "Staunch Tathlum +1", -- 			/ 3 DT	/
        head = { name = "Nyame Helm", priority = 91 }, -- 			/		/
        body = { name = "Nyame Mail", priority = 218 },
        hands = { name = "Nyame Gauntlets", priority = 205 },
        legs = { name = "Nyame Flanchard", priority = 114 }, -- 		 	/ 9 DT	/
        feet = { name = "Nyame Sollerets", priority = 500 },
        neck = { name = "Loricate Torque +1", priority = 60 }, -- 			/ 6 DT	/
        waist = "Flume Belt +1", -- 4 PDT 	/		/
        left_ear = { name = "Tuisto Earring", priority = 50 },
        right_ear = { name = "Odnowa Earring +1", priority = 500 }, --			/		/	2 MDT
        left_ring = "Moonlight Ring",
        right_ring = { name = "Gelatinous Ring +1", priority = 500 }, -- 7  PDT	/		/	-1 MDT
        back = gear.tank_back, -- 10 PDT	/		/
    }

    sets.idle.Refresh = set_combine(
        sets.idle,
        { head = "Rawhide Mask", legs = "Rawhide Trousers", feet = "Nyame Sollerets" }
    )
    sets.idle.Weak = sets.idle

    sets.Kiting = { ammo = "Staunch Tathlum +1", legs = "Carmine Cuisses +1" }

    sets.latent_refresh = { waist = "Fucho-no-obi" }
    sets.DayIdle = {}
    sets.NightIdle = {}

    -- Extra defense sets.  Apply these on top of melee or defense sets.
    sets.Knockback = {}
    sets.MP = {}
    sets.TreasureHunter = set_combine(sets.TreasureHunter, { hands = gear.herculean_treasure_hands })

    -- Defense Sets

    -- Set for Sleep/Stun/Petrify
    sets.defense.PDT = {
        ammo = "Staunch Tathlum +1",
        head = { name = "Nyame Helm", priority = 91 },
        body = { name = "Nyame Mail", priority = 110 },
        hands = { name = "Nyame Gauntlets", priority = 91 },
        legs = { name = "Nyame Flanchard", priority = 114 },
        feet = { name = "Nyame Sollerets", priority = 105 },
        neck = { name = "Futhark Torque +2", priority = 60 },
        waist = "Flume Belt +1",
        left_ear = { name = "Etiolation Earring", priority = 50 },
        right_ear = { name = "Odnowa Earring +1", priority = 500 },
        left_ring = { name = "Moonlight Ring", priority = 500 },
        right_ring = { name = "Gelatinous Ring +1", priority = 500 },
        back = { name = gear.dt_moon_back, priority = 500 },
    }

    sets.defense.MEVA = sets.defense.PDT
    sets.defense.MDT = sets.defense.MEVA

    -- Swap to these on Moonshade using WS if at 3000 TP
    sets.MaxTP = { ear1 = "Etiolation Earring" }
    sets.AccMaxTP = { ear1 = "Telos Earring" }

    --------------------------------------
    -- Engaged sets
    --------------------------------------

    -- 1297 Acc
    sets.engaged = {
        ammo = "Coiste Bodhar",
        head = "Adhemar Bonnet +1",
        body = "Adhemar Jacket +1",
        hands = "Adhemar Wrist. +1",
        legs = "Samnuha Tights",
        feet = "Nyame Sollerets",
        neck = "Anu Torque",
        waist = "Windbuffet Belt +1",
        left_ear = "Sherida Earring",
        right_ear = "Telos Earring",
        left_ring = "Chirich Ring +1",
        right_ring = "Niqmaddu Ring",
        back = gear.jse_da_back,
    }

    -- 1281 Acc
    -- 50 PDT/DT
    -- 3124 HP
    sets.engaged.DTLite = {
        ammo = "Yamarang",
        head = { name = "Nyame Helm", priority = 91 },
        body = { name = "Ashera Harness", priority = 500 },
        hands = { name = "Regal Gauntlets", priority = 500 },
        legs = "Nyame Flanchard",
        feet = { name = "Nyame Sollerets", priority = 68 },
        neck = "Combatant's Torque",
        waist = "Ioskeha Belt +1",
        left_ear = "Sherida Earring",
        right_ear = { name = "Odnowa Earring +1", priority = 500 },
        left_ring = { name = "Moonlight Ring", priority = 500 },
        right_ring = { name = "Gelatinous Ring +1", priority = 500 },
        back = gear.jse_da_back,
    }

    -- Special ONGO set
    sets.engaged.Ongo = set_combine(sets.engaged.DTLite, {
        hands = { name = "Nyame Gauntlets", priority = 500 },
        neck = { name = "Futhark Torque +2", priority = 60 },
    })

    --	PDT:	36
    --	PDT II:	5
    --	DT:		19
    --	MDT:	19
    --	Total:	55+5 [Overcap]
    --  MEVA: 665
    --  3452 HP

    sets.engaged.Tank = {
        ammo = "Staunch Tathlum +1", -- 			/ 3 DT	/
        head = { name = "Nyame Helm", priority = 91 }, -- 			/ 7 DT	/
        body = { name = "Ashera Harness", priority = 218 }, --
        hands = { name = "Turms Mittens +1", priority = 74 }, --
        legs = { name = "Nyame Flanchard", priority = 114 }, --   		/ 8 DT	/
        feet = { name = "Turms Leggings +1", priority = 76 }, --
        neck = { name = "Futhark Torque +2", priority = 60 }, -- 			/ 6 DT	/
        waist = "Flume Belt +1", -- 4 PDT 	/		/
        left_ear = { name = "Etiolation Earring", priority = 50 },
        right_ear = { name = "Odnowa Earring +1", priority = 500 }, --			/ 3 DT	/	2 MDT
        left_ring = { name = "Moonlight Ring", priority = 500 },
        right_ring = { name = "Gelatinous Ring +1", priority = 500 }, -- 7  PDT	/		/	-1 MDT
        back = gear.tank_back, -- 10 PDT	/		/
    }

    sets.engaged.MEVA = {
        ammo = "Staunch Tathlum +1", -- 			/ 3 DT	/
        head = { name = "Nyame Helm", priority = 91 }, -- 			/ 7 DT	/
        body = { name = "Runeist's Coat +3", priority = 218 }, --
        hands = { name = "Nyame Gauntlets", priority = 91 }, --
        legs = { name = "Nyame Flanchard", priority = 114 }, --   		/ 8 DT	/
        feet = { name = "Nyame Sollerets", priority = 68 }, --
        neck = { name = "Futhark Torque +2", priority = 60 }, -- 			/ 6 DT	/
        waist = "Carrier's Sash", -- 4 PDT 	/		/
        left_ear = { name = "Etiolation Earring", priority = 50 },
        right_ear = { name = "Odnowa Earring +1", priority = 500 }, --			/ 3 DT	/	2 MDT
        left_ring = { name = "Moonlight Ring", priority = 500 },
        right_ring = { name = "Gelatinous Ring +1", priority = 500 }, -- 7  PDT	/		/	-1 MDT
        back = gear.tank_back, -- 10 PDT	/		/
    }

    --------------------------------------
    -- Custom buff sets
    --------------------------------------
    sets.buff.Doom = set_combine(sets.buff.Doom, {})
    sets.buff.Battuta = {}
    sets.buff.Embolden = { back = gear.embolden_back }
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == "DNC" then
        set_macro_page(4, 19)
    elseif player.sub_job == "RDM" then
        set_macro_page(5, 19)
    elseif player.sub_job == "SCH" then
        set_macro_page(5, 19)
    elseif player.sub_job == "BLU" then
        set_macro_page(6, 19)
    elseif player.sub_job == "WAR" then
        set_macro_page(7, 19)
    elseif player.sub_job == "SAM" then
        set_macro_page(8, 19)
    elseif player.sub_job == "DRK" then
        set_macro_page(9, 19)
    elseif player.sub_job == "NIN" then
        set_macro_page(10, 19)
    else
        set_macro_page(5, 19)
    end
end

function extra_user_setup()
    silibs.user_setup_hook()
    ----------- Non-silibs content goes below this line -----------
end

function user_job_precast(spell, spellMap, eventArgs)
    -- Any non-silibs modifications should go in user_job_precast function
    silibs.precast_hook(spell, nil, spellMap, eventArgs)
end

function extra_user_post_precast(spell, spellMap, eventArgs)
    -- Any non-silibs modifications should go in user_job_post_precast function
    silibs.post_precast_hook(spell, nil, spellMap, eventArgs)
end

function user_job_midcast(spell, spellMap, eventArgs)
    -- Any non-silibs modifications should go in user_job_midcast function
    silibs.midcast_hook(spell, nil, spellMap, eventArgs)
end

function extra_user_post_midcast(spell, spellMap, eventArgs)
    -- Any non-silibs modifications should go in user_job_post_midcast function
    silibs.post_midcast_hook(spell, nil, spellMap, eventArgs)
end

function extra_user_job_aftercast(spell, action, spellMap, eventArgs)
    -- Any non-silibs modifications should go in user_job_aftercast function
    silibs.aftercast_hook(spell, action, spellMap, eventArgs)
end

function extra_user_job_post_aftercast(spell, action, spellMap, eventArgs)
    -- Any non-silibs modifications should go in user_job_post_aftercast function
    silibs.post_aftercast_hook(spell, action, spellMap, eventArgs)
end

function user_job_customize_idle_set(idleSet)
    -- Any non-silibs modifications should go in user_customize_idle_set function
    return silibs.customize_idle_set(idleSet)
end

function user_job_customize_melee_set(meleeSet)
    -- Any non-silibs modifications should go in user_customize_melee_set function
    return silibs.customize_melee_set(meleeSet)
end

function user_job_customize_defense_set(defenseSet)
    -- Any non-silibs modifications should go in user_customize_defense_set function
    return silibs.customize_defense_set(defenseSet)
end

function user_self_command(cmdParams, eventArgs)
    -- Any non-silibs modifications should go in user_job_self_command function
    silibs.self_command(cmdParams, eventArgs)
end

buff_spell_lists = {
    Auto = { --Options for When are: Always, Engaged, Idle, OutOfCombat, Combat
        --{Name='Crusade',	Buff='Enmity Boost',	SpellID=476,	When='Combat'},
        { Name = 'Temper', Buff = 'Multi Strikes', SpellID = 493, When = 'Engaged' },
        { Name = 'Phalanx', Buff = 'Phalanx', SpellID = 106, When = 'Always' },
        { Name = 'Refresh', Buff = 'Refresh', SpellID = 109, When = 'Always' },
        { Name = 'Cocoon', Buff = 'Defense Boost', SpellID = 547, When = 'Always' },
        { Name = 'Temper', Buff = 'Multi Strikes', SpellID = 493, Reapply = 'Always' },
    },

    Default = {
        { Name = 'Crusade', Buff = 'Enmity Boost', SpellID = 476, Reapply = false },
        { Name = 'Temper', Buff = 'Multi Strikes', SpellID = 493, Reapply = false },
        { Name = 'Haste', Buff = 'Haste', SpellID = 57, Reapply = false },
        { Name = 'Refresh', Buff = 'Refresh', SpellID = 109, Reapply = false },
        { Name = 'Aquaveil', Buff = 'Aquaveil', SpellID = 55, Reapply = false },
        { Name = 'Stoneskin', Buff = 'Stoneskin', SpellID = 54, Reapply = false },
        { Name = 'Blink', Buff = 'Blink', SpellID = 53, Reapply = false },
        { Name = 'Phalanx', Buff = 'Phalanx', SpellID = 106, Reapply = false },
        { Name = 'Regen IV', Buff = 'Regen', SpellID = 477, Reapply = false },
    },
}
