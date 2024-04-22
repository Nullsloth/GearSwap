function user_job_setup()
    state.OffenseMode:options("Normal")
    state.HybridMode:options("Normal")
    state.CastingMode:options("Normal", "Melee")
    state.IdleMode:options("DT", "Normal")
    state.WeaponskillMode:options("Normal", "SubtleBlow")
    state.Weapons:options("None", "DualSavage", "Carnwenhan", "Aeneas", "Naegling", "DualCarn", "DualTauret", "DualAeneas", "DualAeolian")
    state.UseCustomTimers = M(false, "Use Custom Timers") -- Set this to false if you don't want to use custom timers.
    state.UnlockWeapons = M(true, "Unlock Weapons")
    state.MaintainAftermath = M(false, "Maintain Aftermath")
    info.ExtraSongInstrument = "Daurdabla" -- Adjust this if using the Terpander (new +song instrument)
    info.ExtraSongs = 2 -- How many extra songs we can keep from Daurdabla/Terpander
    silibs.enable_cancel_outranged_ws()
    silibs.enable_cancel_on_blocking_status()
    silibs.enable_weapon_rearm()
    silibs.enable_auto_lockstyle(3)
    silibs.enable_waltz_refiner()
    silibs.enable_premade_commands()
    silibs.enable_th()
    silibs.enable_ui()

    autows_list = {
        ["DualSavage"] = "Savage Blade",
        ["Carnwenhan"] = "Mordant Rime",
        ["Aeneas"] = "Rudra's Storm",
        ["Naegling"] = "Savage Blade",
        ["DualCarn"] = "Mordant Rime",
        ["DualTauret"] = "Evisceration",
        ["DualAeneas"] = "Rudra's Storm",
        ["DualAeolian"] = "Aeolian Edge",

    }

    gear.jse_back = { name = "Intarabus's Cape", augments = { "CHR+20", "Mag. Acc+20 /Mag. Dmg.+20", '"Fast Cast"+10', }, }
    gear.tp_back = { name = "Intarabus's Cape", augments = { "DEX+20", "Accuracy+20 Attack+20", "DEX+8", '"Store TP"+10', }, }
    gear.wsd_back = { name = "Intarabus's Cape", augments = { "DEX+20", "Accuracy+20 Attack+20", "DEX+8", "Weapon skill damage +10%" }, }
    gear.wsd_str_back = { name = "Intarabus's Cape", augments = { "STR+20", "Accuracy+20 Attack+20", "STR+10", "Weapon skill damage +10%" }, }
    gear.wsd_mab_back = { name = "Intarabus's Cape", augments = { "INT+20", "Mag. Acc+20 /Mag. Dmg.+20", "INT+10", "Weapon skill damage +10%" }, }

    gear.tp_linos = { name = "Linos", augments = { "Accuracy+17", '"Dbl.Atk."+3', "Quadruple Attack +3" } }
    gear.fc_linos = { name = "Linos", augments = { "Accuracy+17", '"Dbl.Atk."+3', "Quadruple Attack +3" } }
    gear.dt_linos = ({ name = "Linos", augments = { "Accuracy+17", '"Dbl.Atk."+3', "Quadruple Attack +3" } })
    gear.wsd_linos = { name = "Linos", augments = { "Accuracy+18", "Weapon skill damage +3%", "DEX+8" } }
    gear.wsd_str_linos = { name = "Linos", augments = { "Accuracy+20", "Weapon skill damage +3%", "STR+8" } }

    -- Additional local binds

    send_command('bind ^` input /ja "Nightingale" <me>; wait 1.5; input /ja "Troubadour" <me>')
    send_command('bind @` input /ma "Chocobo Mazurka" <me>')
    send_command('bind ^Backspace input /ma "Puppet\'s Operetta" <me>; wait 5; input /ma "Scop\'s Operetta" <me>; wait 5; input /ma "Goblin Gavotte" <me>; wait 5; input /ma "Shining Fantasia" <me>;')
    send_command('bind !Backspace input /ma "Puppet\'s Operetta" <me>;')
    send_command('bind ^\\\\ input /ma "Dispelga" <t>;')
    send_command("wait 5; hb mincure 4")

    select_default_macro_book()
end

function init_gear_sets()
    -- Weapons sets


    sets.weapons.Aeneas = { main = "Aeneas", sub = "Genmei Shield" }
    sets.weapons.Carnwenhan = { main = "Carnwenhan", sub = "Genmei Shield" }
    sets.weapons.Naegling = { main = "Naegling", sub = "Genmei Shield" }
    sets.weapons.DualAeneas = { main = "Aeneas", sub = "Blurred Knife +1" }
    sets.weapons.DualCarn = { main = "Carnwenhan", sub = "Blurred Knife +1" }
    sets.weapons.DualSavage = { main = "Naegling", sub = "Fusetto +2" }
    sets.weapons.DualTauret = { main = "Aeneas", sub = "Blurred Knife +1" }
    sets.weapons.DualAeneas = { main = "Aeneas", sub = "Blurred Knife +1" }
    sets.weapons.DualAeolian = { main = "Malevolence", sub = "Levante Dagger" }



    -- Precast Sets

    -- 78%
    -- Fast cast sets for spells
    sets.precast.FC = {
        range = gear.fc_linos, --Linos FC Aug
        head = "Bunzi's Hat", -- 10
        body = "Inyanga Jubbah +2", -- 14
        hands = "Gende. Gages +1", -- 7 Leyline Gloves Gupgrade
        legs = "Aya. Cosciales +2", -- 6
        feet = "Telchine Pigaches", -- 5
        neck = "Voltsurge Torque", -- 4
        waist = "Witful Belt ", -- 5
        left_ear = "Loquacious Earring", -- 2
        right_ear = "Enchntr. Earring +1", -- 2
        left_ring = "Kishar Ring", -- 4
        right_ring = "Lebeche Ring",
        back = gear.jse_back, -- 10
    }

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {})
    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC, {})
    sets.precast.FC["Enhancing Magic"] = set_combine(sets.precast.FC, { waist = "Siegel Sash" })

    -- 86% Song + FC combined
    sets.precast.FC.BardSong = set_combine(sets.precast.FC, {
        head = "Fili Calot +1", -- 14
        body = " Brioso Justau. +2", -- 15
    })

    sets.precast.FC.Daurdabla = set_combine(sets.precast.FC.BardSong, { range = info.ExtraSongInstrument })
    sets.precast.FC["Honor March"] = set_combine(sets.precast.FC.BardSong, { range = "Marsyas" })

    sets.precast.FC.Daurdabla.Melee = set_combine(sets.precast.FC.BardSong, { range = info.ExtraSongInstrument })
    sets.precast.FC["Honor March"].Melee = set_combine(sets.precast.FC.BardSong, { range = "Marsyas" })

    -- Precast sets to enhance JAs

    sets.precast.JA["Nightingale"] = { feet = "Bihu Slippers +3" }
    sets.precast.JA["Troubadour"] = { body = "Bihu Justaucorps +3" }
    sets.precast.JA["Soul Voice"] = { legs = "Bihu Cannions +2" }

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}

    sets.precast.FC["Dispelga"] = set_combine(sets.precast.FC, { main = "Daybreak" })

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        range = gear.wsd_linos, -- 3
        head = "Nyame Helm",
        body = "Bihu Justaucorps +3", -- 10%
        hands = "Nyame Gauntlets",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets",
        neck = "Bard's Charm +2",
        waist = "Fotia Belt",
        left_ear = "Ishvara Earring", -- 2%
        right_ear = "Moonshade Earring",
        left_ring = "Ilabrat Ring",
        right_ring = "Rufescent Ring", -- 3%
        back = gear.wsd_back, -- 10%
    }

    -- 20 SB
    sets.precast.WS.SubtleBlow = set_combine(sets.precast.WS, {
        waist = "Sarissapho. Belt",
        left_ear = "Digni. Earring",
        right_ring = "Chirich Ring +1",
    })

    sets.precast.WS["Rudra's Storm"] = {
        range = gear.wsd_linos,
        head = "Nyame Helm",
        body = "Bihu Justaucorps +3",
        hands = "Nyame Gauntlets",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets",
        neck = "Bard's Charm +2",
        waist = "Fotia Belt",
        left_ear = "Ishvara Earring",
        right_ear = "Moonshade Earring",
        left_ring = "Ilabrat Ring",
        right_ring = "Rufescent Ring",
        back = gear.wsd_back,
    }

    -- 20 SB
    sets.precast.WS["Rudra's Storm"].SubtleBlow = set_combine(sets.precast.WS["Rudra's Storm"], {
        waist = "Sarissapho. Belt",
        left_ear = "Digni. Earring",
        right_ring = "Chirich Ring +1",
    })

    sets.precast.WS["Savage Blade"] = {
        range = gear.wsd_str_linos,
        head = "Bihu Roundlet +3",
        body = "Bihu Justaucorps +3",
        hands = "Bihu Cuffs +3",
        legs = "Bihu Cannions +3",
        feet = "Bihu Slippers +3",
        neck = "Bard's Charm +2",
        waist = "Sailfi Belt +1",
        left_ear = "Ishvara Earring",
        right_ear = "Moonshade Earring",
        left_ring = "Metamor. Ring +1",
        right_ring = "Ifrit Ring +1",
        back = gear.wsd_str_back,
    }

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

    sets.precast.WS["Evisceration"] = set_combine(sets.precast.WS)
    sets.precast.WS["Mordant Rime"] = set_combine(sets.precast.WS)

    sets.precast.WS["Aeolian Edge"] = {
        range = gear.wsd_linos,
        head = "Nyame Helm",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets",
        neck = "Sanctity Necklace",
        waist = "Eschan Stone",
        left_ear = "Regal Earring",
        right_ear = { name = "Moonshade Earring", augments = { "Accuracy+4", "TP Bonus +250" }, priority = 1 },
        left_ring = { name = "Metamor. Ring +1", augments = { "Path: A" } },
        right_ring = "Rufescent Ring",
        back = gear.wsd_mab_back,
    }

    -- Midcast Sets

    -- General set for recast times.
    sets.midcast.FastRecast = sets.precast.FC

    -- dummy songs:
    sets.DummySong = {
        range = info.ExtraSongInstrument,
        head = "Bunzi's Hat",
        body = "Bunzi's Robe",
        hands = "Bunzi's Gloves",
        legs = "Bunzi's Pants",
        feet = "Bunzi's Sabots ",
    }

    sets.midcast["Puppet's Operetta"] = sets.DummySong
    sets.midcast["Scop's Operetta"] = sets.DummySong
    sets.midcast["Goblin Gavotte"] = sets.DummySong
    sets.midcast["Shining Fantasia"] = sets.DummySong

    -- For song buffs (duration and AF3 set bonus)
    sets.midcast.SongEffect = {
        main = { name = "Kali", bag = "Wardrobe 1" },
        sub = { name = "Kali", bag = "Wardrobe 2" },
        range = "Gjallarhorn",
        head = "Fili Calot +1",
        body = "Fili Hongreline +1",
        hands = "Fili Manchettes +1",
        legs = "Inyanga Shalwar +2",
        feet = "Brioso Slippers +3",
        neck = "Mnbw. Whistle +1",
        waist = "Flume Belt +1", -- 4
        left_ear = "Odnowa Earring +1", -- 3
        right_ear = "Genmei Earring", -- 2
        left_ring = "Defending Ring", -- 10
        right_ring = "Gelatinous Ring +1", -- 7
        back = gear.jse_back, -- 10
    }

    sets.midcast.SongEffect.Melee = {
        main = { name = "Kali", bag = "Wardrobe 1" },
        sub = { name = "Kali", bag = "Wardrobe 2" },
        range = "Gjallarhorn",
        head = "Fili Calot +1",
        body = "Fili Hongreline +1",
        hands = "Fili Manchettes +1",
        legs = "Inyanga Shalwar +2",
        feet = "Brioso Slippers +3",
        neck = "Mnbw. Whistle +1",
        waist = "Flume Belt +1", -- 4
        left_ear = "Odnowa Earring +1", -- 3
        right_ear = "Genmei Earring", -- 2
        left_ring = "Defending Ring", -- 10
        right_ring = "Gelatinous Ring +1", -- 7
        back = gear.jse_back, -- 10
    }

    -- Gear to enhance certain classes of songs.  No instruments added here since Gjallarhorn is being used.
    sets.midcast.Ballad = set_combine(sets.midcast.SongEffect, {}) --{legs="Fili Rhingrave +1"})
    sets.midcast.Madrigal = set_combine(sets.midcast.SongEffect, { head = "Fili Calot +1" })
    sets.midcast.March = set_combine(sets.midcast.SongEffect, { hands = "Fili Manchettes +1" })
    sets.midcast.Minuet = set_combine(sets.midcast.SongEffect, { body = "Fili Hongreline +1" })
    sets.midcast.Minne = set_combine(sets.midcast.SongEffect, { legs = "Mousai Seraweels +1" })
    sets.midcast.Etude = set_combine(sets.midcast.SongEffect, { head = "Mousai Turban +1", feet = "Fili Cothurnes +1" })
    sets.midcast.Paeon = set_combine(sets.midcast.SongEffect, { head = "Brioso Roundlet +3" })
    sets.midcast.Carol = set_combine(sets.midcast.SongEffect, { head = "Fili Calot +1", hands = "Mousai Gages +1" })
    sets.midcast["Sentinel's Scherzo"] = set_combine(sets.midcast.SongEffect, { feet = "Fili Cothurnes +1" })
    sets.midcast.Mazurka = { range = info.ExtraSongInstrument }
    sets.midcast["Honor March"] = set_combine(sets.midcast.SongEffect, { range = "Marsyas" })

    sets.midcast.Ballad.Melee = set_combine(sets.midcast.SongEffect.Melee, {}) --{legs="Fili Rhingrave +1"})
    sets.midcast.Madrigal.Melee = set_combine(sets.midcast.SongEffect.Melee, { head = "Fili Calot +1" })
    sets.midcast.March.Melee = set_combine(sets.midcast.SongEffect.Melee, { hands = "Fili Manchettes +1" })
    sets.midcast.Minuet.Melee = set_combine(sets.midcast.SongEffect.Melee, { body = "Fili Hongreline +1" })
    sets.midcast.Minne.Melee = set_combine(sets.midcast.SongEffect.Melee, { legs = "Mousai Seraweels +1" })
    sets.midcast.Etude.Melee = set_combine(
        sets.midcast.SongEffect.Melee,
        { head = "Mousai Turban +1", feet = "Fili Cothurnes +1" }
    )
    sets.midcast.Paeon.Melee = set_combine(sets.midcast.SongEffect.Melee, { head = "Brioso Roundlet +3" })
    sets.midcast.Carol.Melee = set_combine(
        sets.midcast.SongEffect.Melee,
        { head = "Fili Calot +1", hands = "Mousai Gages +1" }
    )
    sets.midcast["Sentinel's Scherzo"].Melee = set_combine(
        sets.midcast.SongEffect.Melee,
        { feet = "Fili Cothurnes +1" }
    )
    sets.midcast.Mazurka.Melee = { range = info.ExtraSongInstrument }
    sets.midcast["Honor March"].Melee = set_combine(sets.midcast.SongEffect.Melee, { range = "Marsyas" })

    -- For song defbuffs (duration primary, accuracy secondary)
    sets.midcast.SongDebuff = {
        main = { name = "Kali", bag = "Wardrobe 1" },
        sub = "Ammurapi Shield",
        range = "Gjallarhorn",
        head = "Brioso Roundlet +2",
        body = "Brioso Justaucorps +2",
        hands = "Inyan. Dastanas +2",
        legs = "Brioso Cannions +2",
        feet = "Brioso Slippers +3",
        neck = "Mnbw. Whistle +1",
        waist = "Acuity Belt +1",
        left_ear = "Dignitary's Earring",
        right_ear = "Regal Earring",
        left_ring = "Stikini Ring +1",
        right_ring = "Stikini Ring +1",
        back = gear.jse_back,
    }

    sets.midcast.Lullaby = set_combine(sets.midcast.SongDebuff, {
        range = info.ExtraSongInstrument,
        hands = "Brioso Cuffs +3",
    })

    sets.midcast.Threnody = set_combine(sets.midcast.SongDebuff, {
        body = "Mousai Manteel +1",
    })

    sets.midcast.SongDebuff.Melee = {
        main = { name = "Kali", bag = "Wardrobe 1" },
        range = "Gjallarhorn",
        head = "Brioso Roundlet +2",
        body = "Brioso Justaucorps +2",
        hands = "Inyan. Dastanas +2",
        legs = "Brioso Cannions +2",
        feet = "Brioso Slippers +3",
        neck = "Mnbw. Whistle +1",
        waist = "Acuity Belt +1",
        left_ear = "Dignitary's Earring",
        right_ear = "Regal Earring",
        left_ring = "Stikini Ring +1",
        right_ring = "Stikini Ring +1",
        back = gear.jse_back,
    }

    sets.midcast.Lullaby.Melee = set_combine(sets.midcast.SongDebuff.Melee, {
        range = info.ExtraSongInstrument,
        hands = "Brioso Cuffs +3",
    })

    sets.midcast.Threnody.Melee = set_combine(sets.midcast.SongDebuff.Melee, {
        body = "Mousai Manteel +1",
    })

    -- Song-specific recast reduction
    sets.midcast.SongRecast = {}

    -- Cast spell with normal gear, except using Daurdabla instead
    sets.midcast.Daurdabla = { range = info.ExtraSongInstrument }

    -- Dummy song with Daurdabla; minimize duration to make it easy to overwrite.
    sets.midcast.DaurdablaDummy = sets.DummySong

    -- Other general spells and classes.
    sets.midcast["Dispelga"] = set_combine(sets.midcast.SongDebuff, { main = "Daybreak" })

    -- Duration gear
    -- 70%
    sets.midcast["Enhancing Magic"] = {
        main = gear.gada_enhancing_club, -- 6%
        sub = "Ammurapi Shield", -- 10%
        head = gear.telchine_enhancing_head, -- 8%
        body = gear.telchine_enhancing_body, -- 8%
        hands = gear.telchine_enhancing_hands, -- 10%
        legs = gear.telchine_enhancing_legs, -- 8%
        feet = gear.telchine_enhancing_feet, -- 10%
        waist = "Embla Sash", -- 10%
        left_ear = "Genmei Earring",
        right_ear = "Etiolation Earring",
        left_ring = "Defending Ring",
        right_ring = "Gelatinous Ring +1",
    }

    sets.midcast["Enhancing Magic"].Melee = {
        head = gear.telchine_enhancing_head, -- 8%
        body = gear.telchine_enhancing_body, -- 8%
        hands = gear.telchine_enhancing_hands, -- 10%
        legs = gear.telchine_enhancing_legs, -- 8%
        feet = gear.telchine_enhancing_feet, -- 10%
        waist = "Embla Sash", -- 10%
        left_ear = "Genmei Earring",
        right_ear = "Etiolation Earring",
        left_ring = "Defending Ring",
        right_ring = "Gelatinous Ring +1",
    }

    sets.midcast["Enfeebling Magic"] = {
        main = { name = "Kali", bag = "Wardrobe 1" },
        sub = "Ammurapi Shield",
        range = "Gjallarhorn",
        head = "Brioso Roundlet +3",
        body = "Brioso Justaucorps +3",
        hands = "Brioso Cuffs +3",
        legs = "Brioso Cannions +3",
        feet = "Brioso Slippers +3",
        neck = "Mnbw. Whistle +1",
        waist = "Obstin. Sash",
        left_ear = "Dignitary's Earring",
        right_ear = "Regal Earring",
        left_ring = "Vertigo Ring",
        right_ring = "Metamorph Ring +1",
        back = gear.jse_back,
    }

    sets.midcast["Enfeebling Magic"].Melee = {
        range = "Gjallarhorn",
        head = "Brioso Roundlet +3",
        body = "Brioso Justaucorps +3",
        hands = "Brioso Cuffs +3",
        legs = "Brioso Cannions +3",
        feet = "Brioso Slippers +3",
        neck = "Mnbw. Whistle +1",
        waist = "Obstin. Sash",
        left_ear = "Dignitary's Earring",
        right_ear = "Regal Earring",
        left_ring = "Vertigo Ring",
        right_ring = "Metamorph Ring +1",
        back = gear.jse_back,
    }

    -- 53% Cure Potency
    -- +20 Skill
    sets.midcast.Cure = {
        main = "Daybreak", -- 30%
        sub = "Ammurapi Shield",
        head = "Vanya Hood", -- 10%
        body = "Nyame Mail",
        hands = "Inyan. Dastanas +2", -- 20 Skill
        legs = "Nyame Flanchard",
        feet = "Vanya Clogs", -- 10% + Skill
        neck = "Loricate Torque +1",
        waist = "Flume Belt +1",
        left_ear = "Mendi. Earring", -- 5%
        right_ear = "Regal Earring",
        left_ring = "Defending Ring",
        right_ring = "Lebeche Ring", -- 3%
        back = gear.jse_back,
    }

    sets.midcast.Cure.Melee = {
        head = "Vanya Hood", -- 10%
        body = "Annoint. Kalasiris", -- 10%
        hands = "Inyan. Dastanas +2", -- 20 Skill
        legs = "Nyame Flanchard",
        feet = "Vanya Clogs", -- 10% + Skill
        neck = "Nodens Gorget", -- 5%
        waist = "Flume Belt +1",
        left_ear = "Mendi. Earring", -- 5%
        right_ear = "Regal Earring",
        left_ring = "Defending Ring",
        right_ring = "Lebeche Ring", -- 3%
        back = "Solemnity Cape", -- 7%
    }

    sets.midcast.Curaga = sets.midcast.Cure
    sets.midcast.Curaga.Melee = sets.midcast.Cure.Melee

    sets.midcast.Stoneskin = set_combine(sets.midcast["Enhancing Magic"], {})
    sets.midcast.Stoneskin.Melee = set_combine(sets.midcast["Enhancing Magic"].Melee, {})

    sets.midcast.Cursna = set_combine(sets.midcast.Cure, {
        neck = "Debilis Medallion",
        ring1 = "Haoma's Ring",
    })

    sets.midcast.Cursna.Melee = set_combine(sets.midcast.Cure.Melee, {
        neck = "Debilis Medallion",
        ring1 = "Haoma's Ring",
    })

    -- Idle sets
    -- 11 MP Refresh
    sets.idle = {
        main = "Daybreak", -- 1
        sub = "Genmei Shield", --10 PDT
        range = gear.dt_linos,
        head = "Bunzi's Hat", -- DT 7
        body = "Bunzi's Robe", -- DT 10
        hands = "Bunzi's Gloves", -- 8
        legs = "Bunzi's Pants", -- 9
        feet = "Bunzi's Sabots", -- 6
        neck = "Warder's Charm +1",
        waist = "Carrier's Sash",
        left_ear = "Tuisto Earring ",
        right_ear = "Etiolation Earring",
        left_ring = "Defending Ring",
        right_ring = "Shadow Ring",
        back = gear.jse_back,
    }

    sets.idle.Refresh = {
        main = "Daybreak", -- 1
        sub = "Genmei Shield",
        range = gear.dt_linos,
        head = gear.chironic_refresh_head, -- 2
        body = "Annoint. Kalasiris", -- 2
        hands = gear.chironic_refresh_hands, -- 2
        legs = gear.chironic_refresh_legs, -- 2
        feet = gear.chironic_refresh_feet, -- 2
        neck = "Sanctity Necklace",
        waist = "Flume Belt +1",
        left_ear = "Infused Earring",
        right_ear = "Etiolation Earring",
        left_ring = "Defending Ring",
        right_ring = "Gelatinous Ring +1",
        back = gear.tp_back,
    }

    sets.idle.Town = {
        main = "Daybreak", -- 1
        sub = "Genmei Shield", --10 PDT
        range = gear.dt_linos,
        head = "Bunzi's Hat", -- DT 7
        body = "Bunzi's Robe", -- DT 10
        hands = "Bunzi's Gloves", -- 8
        legs = "Bunzi's Pants", -- 9
        feet = "Bunzi's Sabots", -- 6
        neck = "Warder's Charm +1",
        waist = "Carrier's Sash",
        left_ear = "Tuisto Earring ",
        right_ear = "Etiolation Earring",
        left_ring = "Defending Ring",
        right_ring = "Shadow Ring",
        back = gear.jse_back,
    }

    -- 6 MP Refresh
    -- 707 MEVA
    -- 50 PDT/DT
    sets.idle.DT = {
        main = "Daybreak", -- 1
        sub = "Genmei Shield", --10 PDT
        range = gear.dt_linos,
        head = "Bunzi's Hat", -- DT 7
        body = "Bunzi's Robe", -- DT 10
        hands = "Bunzi's Gloves", -- 8
        legs = "Bunzi's Pants", -- 9
        feet = "Bunzi's Sabots", -- 6
        neck = "Warder's Charm +1",
        waist = "Carrier's Sash",
        left_ear = "Tuisto Earring ",
        right_ear = "Etiolation Earring",
        left_ring = "Moonlight Ring",
        right_ring = "Shadow Ring",
        back = gear.jse_back,
    }

    -- Defense sets
    sets.defense.PDT = {
        ammo = "Staunch Tathlum +1",
        head = "Nyame Helm",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets",
        neck = "Loricate Torque +1",
        waist = "Flume Belt +1",
        left_ear = "Infused Earring",
        right_ear = "Etiolation Earring",
        left_ring = "Defending Ring",
        right_ring = "Gelatinous Ring +1",
        back = gear.dt_moon_back,
    }

    sets.defense.MDT = sets.defense.PDT
    sets.defense.MEVA = sets.defense.PDT

    sets.resting = sets.idle
    sets.idle.Weak = sets.idle.DT

    sets.Kiting = { feet = "Fili Cothurnes +1" }
    sets.latent_refresh = { waist = "Fucho-no-obi" }

    -- Engaged sets
    sets.engaged = {
        range = gear.tp_linos,
        head = "Bunzi's Hat",
        body = "Ayanmo Corazza +2",
        hands = "Bunzi's Gloves",
        legs = "Aya. Cosciales +2",
        feet = "Aya. Gambieras +2",
        neck = "Bard's Charm +2",
        waist = "Reiki Yotai",
        left_ear = "Crep. Earring",
        right_ear = "Telos Earring",
        left_ring = "Chirich Ring +1",
        right_ring = "Chirich Ring +1",
        back = gear.tp_back,
    }

    -- Set if dual-wielding
    sets.engaged.DW = set_combine(sets.engaged, { right_ear = "Suppanomimi" }) -- waist="Reiki Yotai",
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(10, 10)
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
