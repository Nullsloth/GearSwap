function user_job_setup()

    state.OffenseMode:options('Normal')
    state.CastingMode:options('Normal', 'Resistant', 'Proc', 'DT')
    state.IdleMode:options('Normal', 'DT')
    state.HybridMode:options('Normal')
    state.Weapons:options('None', 'Musa', 'Khatvanga')
    state.AutoArts = M(false, 'AutoArts')
    state.AutoAPMode = M(true, 'AutoAPMode')
    state.AutoBuffMode = M { ['description'] = 'Auto Buff Mode', 'Off', 'Auto', 'Healing', 'Nuking' }
    state.AutoArts = M { ['description'] = 'Auto Arts Mode', 'Off', 'On', 'Light', 'Dark' }
    silibs.enable_cancel_outranged_ws()
    silibs.enable_cancel_on_blocking_status()
    silibs.enable_weapon_rearm()
    silibs.enable_auto_lockstyle(3)
    silibs.enable_waltz_refiner()
    silibs.enable_premade_commands()
    silibs.enable_th()
    silibs.enable_ui()

    gear.nuke_jse_back = { name = "Lugh's Cape", augments = { 'INT+20', 'Mag. Acc+20 /Mag. Dmg.+20', 'INT+10', '"Mag.Atk.Bns."+10', 'Phys. dmg. taken-10%', } }
    gear.obi_cure_back = "Solemnity Cape"
    gear.obi_cure_waist = "Porous Rope"
    gear.obi_low_nuke_waist = "Sacro Cord"
    gear.obi_high_nuke_waist = "Sacro Cord"

    -- Additional local binds
    send_command('bind ^` gs c cycle ElementalMode')
    send_command('bind !` gs c elemental nuke') -- change to buff up pro/shell?
    send_command('bind @` gs c set toggle MagicBurstMode Lock')
    send_command('bind @f10 gs c cycle RecoverMode')
    send_command('bind @f8 gs c toggle AutoNukeMode')
    send_command('bind !pause gs c toggle AutoSubMode') --Automatically uses sublimation and Myrkr.
    send_command('bind !scrolllock gs c toggle AutoArts')
    send_command('bind @f7 gs c set toggle CastingMode DT; gs c set toggle IdleMode DT')
    send_command('bind @f6 gs c set toggle AutoAPMode')
    send_command('bind !@^backspace input /ja "Enlightenment" <me>')
    send_command('bind @backspace gs c scholar cost')
    send_command('bind ^backspace gs c scholar aoe')
    send_command('bind !backspace gs c scholar duration')
    send_command('bind @= gs c scholar dark')
    send_command('bind != gs c scholar light')
    send_command('bind ^\\\\ input /ma "Protect V" <t>')
    send_command('bind @\\\\ input /ma "Shell V" <t>')
    send_command('bind !\\\\ input /ma "Reraise III" <me>')
    send_command('gs c set MagicBurstMode Lock')
    send_command('wait 15; hb disable cure; hb disable curaga; hb disable na;')

    select_default_macro_book()
end

function init_gear_sets()


    sets.weapons.Musa = { main = "Musa", sub = "Khonsu" }
    sets.weapons.Khatvanga = { main = "Khatvanga", sub = "Khonsu" }

    -- Precast sets to enhance JAs
    sets.nukewaist = { waist = "Sacro Cord" }

    sets.precast.JA['Tabula Rasa'] = { legs = "Peda. Pants +3" }
    sets.precast.JA['Enlightenment'] = { body = "Peda. Gown +3" }

    -- Fast cast sets for spells
    -- RDM Sub: 15%
    -- 82% + 11% QC

    sets.precast.FC = {
        main = gear.sch_fc_weapon, -- 10
        sub = "Enki Strap",
        ammo = "Impatiens", -- QC
        head = gear.merlinic_fc_head, -- 15
        body = gear.merlinic_fc_body, -- 12
        hands = { name = "Gende. Gages +1", priority = 5 }, -- 7
        legs = { name = "Psycloth Lappas", priority = 5 }, -- 7
        feet = gear.merlinic_fc_feet, -- 11
        neck = "Voltsurge Torque", -- 4
        waist = "Embla Sash", -- 5
        left_ear = "Loquac. Earring", -- 2
        right_ear = "Malignance Earring", -- 4
        left_ring = "Weather. Ring +1", -- 5 QC
        right_ring = "Lebeche Ring", -- QC
        back = "Perimede Cape", -- QC
    }

    sets.precast.FC.DT = set_combine(sets.precast.FC, { left_ear = { name = "Odnowa Earring +1", priority = 1 }, back = { name = "Moonbeam Cape", priority = 1 }, })

    sets.precast.FC.Arts = set_combine { sets.precast.FC, {} }
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {})
    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, { right_ring = "Gelatinous Ring +1", back = gear.nuke_jse_back, })

    sets.precast.FC.Arts.DT = set_combine { sets.precast.FC.DT, {} }
    sets.precast.FC['Enhancing Magic'].DT = set_combine(sets.precast.FC.DT, {})
    sets.precast.FC['Elemental Magic'].DT = set_combine(sets.precast.FC.DT, { right_ring = "Gelatinous Ring +1", back = gear.nuke_jse_back, })

    -- FC:	41%
    -- CCT: 51%
    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
        feet = "Vanya Clogs",
        left_ear = "Mendi. Earring",
    })

    sets.precast.FC.Cure.DT = set_combine(sets.precast.FC.Cure, { back = { name = "Moonbeam Cape", priority = 1 }, })
    sets.precast.FC.LightDayCure = set_combine(sets.precast.FC.Cure, { back = { name = "Moonbeam Cape", priority = 1 }, })
    sets.precast.FC.LightWeatherCure = set_combine(sets.precast.FC.Cure, { back = { name = "Moonbeam Cape", priority = 1 }, })

    sets.precast.FC.Curaga = sets.precast.FC.Cure
    sets.precast.FC.Curaga.DT = sets.precast.FC.Cure.DT

    sets.precast.FC.Impact = set_combine(sets.precast.FC['Elemental Magic'], { head = empty, body = gear.impact_body })
    sets.precast.FC.Dispelga = set_combine(sets.precast.FC, { main = "Daybreak", sub = "Genmei Shield" })

    -- Weaponskill sets
    sets.precast.WS['Myrkr'] = {
        ammo = "Staunch Tathlum +1",
        head = "Nyame Helm",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets",
        neck = "Fotia Gorget",
        waist = "Fotia Belt",
        left_ear = "Ishvara Earring",
        right_ear = { name = "Moonshade Earring", augments = { 'Accuracy+4', 'TP Bonus +250', } },
        left_ring = "Vertigo Ring",
        right_ring = "Rufescent Ring",
        back = gear.nuke_jse_back,
    }

    -- Midcast Sets

    sets.TreasureHunter = set_combine(sets.TreasureHunter, {})

    -- Gear that converts elemental damage done to recover MP.
    sets.RecoverMP = { body = "Seidr Cotehardie" }

    -- Main MB Set
    sets.MagicBurst = {
        main = "Bunzi's Rod", -- 10
        sub = "Ammurapi Shield",
        ammo = "Pemphredo Tathlum",
        head = "Peda. M.Board +3", -- 4 II
        body = "Agwu's Robe", -- 10
        hands = "Amalric Gages +1", -- 6 II
        legs = "Nyame Flanchard", -- 6
        feet = "Jhakri Pigaches +2", -- 7
        neck = gear.sch_jse_neck, -- 10/7
        waist = "Sacro Cord",
        left_ear = "Regal Earring",
        right_ear = "Malignance Earring",
        left_ring = "Mujin Band", -- 5 II
        right_ring = "Freke Ring",
        back = gear.nuke_jse_back,
    }

    sets.midcast.FastRecast = sets.precast.FC
    sets.midcast.FastRecast.DT = sets.precast.FC.DT

    sets.element.Dark = { head = "Pixie Hairpin +1", ring2 = "Archon Ring" }

    sets.midcast.Cure = {
        main = "Bunzi's Rod", -- 30
        sub = "Ammurapi Shield",
        ammo = "Hydrocera",
        head = { name = "Vanya Hood", augments = { 'MP+50', '"Fast Cast"+10', 'Haste+2%', } }, -- 10
        body = { name = "Vedic Coat", priority = 1 },
        hands = { name = "Peda. Bracers +3", priority = 1 }, -- 4 II?
        legs = { name = "Vanya Slops", priority = 1 },
        feet = "Vanya Clogs", -- 10
        neck = "Incanter's Torque",
        waist = "Porous Rope",
        left_ear = "Regal Earring",
        right_ear = "Mendi. Earring", -- 5
        left_ring = "Vertigo Ring",
        right_ring = "Lebeche Ring",
        back = "Solemnity Cape", -- 7
    }

    sets.midcast.Cure.DT = set_combine(sets.midcast.Cure, {
        body = { name = "Nyame Mail", priority = 1 },
        legs = "Nyame Flanchard",
        neck = "Loricate Torque +1",
        left_ear = { name = "Odnowa Earring +1", priority = 1 },
        left_ring = "Defending Ring",
        right_ring = "Gelatinous Ring +1",
        back = { name = "Moonbeam Cape", priority = 1 },
    })

    sets.midcast.LightWeatherCure = set_combine(sets.midcast.Cure, { main = "Chatoyant Staff", sub = "Enki Strap", neck = "Nodens Gorget", waist = "Korin Obi", })
    sets.midcast.LightDayCure = set_combine(sets.midcast.Cure, { main = "Chatoyant Staff", sub = "Enki Strap", neck = "Nodens Gorget", waist = "Korin Obi", })

    sets.midcast.LightWeatherCure.DT = set_combine(sets.midcast.LightWeatherCure, { body = { name = "Nyame Mail", priority = 1 }, left_ear = { name = "Odnowa Earring +1", priority = 1 }, left_ring = "Defending Ring", back = { name = "Moonbeam Cape", priority = 1 }, })
    sets.midcast.LightDayCure.DT = set_combine(sets.midcast.LightWeatherCure, { body = { name = "Nyame Mail", priority = 1 }, left_ear = { name = "Odnowa Earring +1", priority = 1 }, left_ring = "Defending Ring", back = { name = "Moonbeam Cape", priority = 1 }, })

    --sets.midcast.CureWithLightWeather = set_combine(sets.midcast.Cure,{main="Chatoyant Staff", sub="Enki Strap", waist="Korin Obi",})

    sets.midcast.Curaga = sets.midcast.Cure
    sets.midcast.Curaga.DT = sets.midcast.Cure.DT

    sets.Self_Healing = { waist = "Gishdubar Sash" }
    sets.Cure_Received = { waist = "Gishdubar Sash" }
    sets.Self_Refresh = { waist = "Gishdubar Sash", feet = "Inspirited Boots" }

    sets.midcast.Cursna = set_combine(sets.midcast.FastRecast, {})
    sets.midcast.Cursna.DT = set_combine(sets.midcast.FastRecast.DT, {})

    sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {})
    sets.midcast.StatusRemoval.DT = set_combine(sets.midcast.FastRecast.DT, {})

    -- Duration gear
    -- 60%
    sets.midcast['Enhancing Magic'] = {
        main = gear.sch_enhancing_weapon, -- 20%
        sub = gear.sch_regen_sub,
        ammo = "Staunch Tathlum +1",
        head = gear.telchine_enhancing_head, -- 8%
        body = "Peda. Gown +3", -- 12%
        hands = gear.telchine_enhancing_hands, -- 10%
        legs = gear.telchine_enhancing_legs, -- 8%
        feet = gear.telchine_enhancing_feet, -- 10%
        neck = "Incanter's Torque",
        waist = "Embla Sash", -- 10%
        left_ear = "Andoaa Earring",
        right_ear = "Etiolation Earring",
        left_ring = "Defending Ring",
        right_ring = "Gelatinous Ring +1",
    }

    sets.midcast['Enhancing Magic'].DT = set_combine(sets.midcast['Enhancing Magic'], {
        ammo = "Staunch Tathlum +1",
        neck = "Loricate Torque +1",
        left_ear = { name = "Odnowa Earring +1", priority = 1 },
        right_ear = { name = "Tuisto Earring", priority = 1 },
        back = { name = "Moonbeam Cape", priority = 1 },
    })

    -- 25%
    -- +10
    -- Light Arts Combined: 83HP/Tick
    sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {
        main = gear.sch_regen_weapon,
        sub = gear.sch_regen_sub,
        head = "Arbatel Bonnet +1", -- 15%
        body = gear.telchine_enhancing_body,
        back = gear.regen_jse_back, -- +10
    })

    sets.midcast.Regen.DT = set_combine(sets.midcast['Enhancing Magic'].DT, {
        head = "Arbatel Bonnet +1", -- 15%
        body = gear.telchine_enhancing_body,
        back = gear.regen_jse_back, -- +10
    })

    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], { neck = "Nodens Gorget", waist = "Siegel Sash", })
    sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], { head = "Amalric Coif +1" })
    sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], { main = "Vadose Rod", sub = "Ammurapi Shield", head = "Amalric Coif +1", hands = "Regal Cuffs" })
    sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], {})
    sets.midcast.Storm = set_combine(sets.midcast['Enhancing Magic'], {}) -- feet="Peda. Loafers +1"
    sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {})
    sets.midcast.Protectra = sets.midcast.Protect
    sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {})
    sets.midcast.Shellra = sets.midcast.Shell

    --MEVA sets
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'].DT, { neck = "Nodens Gorget", waist = "Siegel Sash", })
    sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'].DT, { head = "Amalric Coif +1" })
    sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'].DT, { main = "Vadose Rod", sub = "Ammurapi Shield", head = "Amalric Coif +1", hands = "Regal Cuffs" })
    sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'].DT, {})
    sets.midcast.Storm = set_combine(sets.midcast['Enhancing Magic'].DT, {}) -- feet="Peda. Loafers +1"
    sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'].DT, {})
    sets.midcast.Protectra = sets.midcast.Protect
    sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'].DT, {})
    sets.midcast.Shellra = sets.midcast.Shell


    -- Custom spell classes
    sets.midcast['Enfeebling Magic'] = {
        main = "Daybreak",
        sub = "Ammurapi Shield",
        ammo = "Hydrocera",
        head = "C. Palug Crown",
        body = gear.sch_body_idle,
        hands = "Peda. Bracers +3",
        legs = "Psycloth Lappas",
        feet = "Nyame Sollerets",
        neck = gear.sch_jse_neck,
        waist = "Obstin. Sash",
        left_ear = "Regal Earring",
        right_ear = "Malignance Earring",
        left_ring = "Kishar Ring",
        right_ring = "Metamorph Ring +1",
        back = gear.nuke_jse_back,
    }

    sets.midcast['Enfeebling Magic'].Resistant = set_combine(sets.midcast['Enfeebling Magic'], {})

    sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'], {})
    sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

    sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], { main = "Bunzi's Rod", sub = "Ammurapi Shield", ammo = "Pemphredo Tathlum", body = "Agwu's Robe" })
    sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

    sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})
    sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

    sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
    sets.midcast.Diaga = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
    sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
    sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
    sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)

    sets.midcast['Divine Magic'] = set_combine(sets.midcast['Enfeebling Magic'], {})

    sets.midcast['Dark Magic'] = {
        main = "Bunzi's Rod",
        sub = "Ammurapi Shield",
        ammo = "Pemphredo Tathlum",
        head = "Amalric Coif +1",
        body = gear.sch_body_idle,
        hands = "Nyame Gauntlets",
        legs = "Peda. Pants +3",
        feet = "Jhakri Pigaches +2",
        neck = gear.sch_jse_neck,
        waist = "Obstin. Sash",
        left_ear = "Regal Earring",
        right_ear = "Malignance Earring",
        left_ring = "Vertigo Ring",
        right_ring = "Metamorph Ring +1",
        back = gear.nuke_jse_back,
    }

    sets.midcast.Kaustra = {
        main = "Bunzi's Rod",
        sub = "Ammurapi Shield",
        ammo = "Pemphredo Tathlum",
        head = "Pixie Hairpin +1",
        body = gear.sch_body_idle,
        hands = "Nyame Gauntlets",
        legs = "Peda. Pants +3",
        feet = "Jhakri Pigaches +2",
        neck = gear.sch_jse_neck,
        waist = "Luminary Sash",
        left_ear = "Regal Earring",
        right_ear = "Malignance Earring",
        left_ring = "Freke Ring",
        right_ring = "Archon Ring",
        back = gear.nuke_jse_back,
    }

    sets.midcast.Kaustra.Resistant = set_combine(sets.midcast.Kaustra, {})

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
        head = "Pixie Hairpin +1",
        legs = "Peda. Pants +3",
        neck = "Erra Pendant",
        waist = "Fucho-no-obi",
        left_ring = "Evanescence Ring",
        right_ring = "Archon Ring",
    })

    sets.midcast.Drain.Resistant = set_combine(sets.midcast.Drain, {})

    sets.midcast.Aspir = sets.midcast.Drain
    sets.midcast.Aspir.Resistant = sets.midcast.Drain.Resistant

    sets.midcast.Stun = sets.precast.FC
    sets.midcast.Stun.Resistant = sets.midcast['Enfeebling Magic'].Resistant


    -- Elemental Magic sets are default for handling low-tier nukes.
    sets.midcast['Elemental Magic'] = {
        main = "Bunzi's Rod",
        sub = "Ammurapi Shield",
        ammo = "Pemphredo Tathlum",
        head = "C. Palug Crown",
        body = "Agwu's Robe",
        hands = "Amalric Gages +1",
        legs = "Peda. Pants +3",
        feet = "Jhakri Pigaches +2",
        neck = gear.sch_jse_neck,
        waist = "Sacro Cord",
        left_ear = "Regal Earring",
        right_ear = "Malignance Earring",
        left_ring = "Metamor. Ring +1",
        right_ring = "Freke Ring",
        back = gear.nuke_jse_back,
    }

    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {})
    sets.midcast['Elemental Magic']['9k'] = set_combine(sets.midcast['Elemental Magic'], {})

    sets.midcast['Elemental Magic'].Proc = {
        main = empty,
        sub = empty,
        ammo = "Hydrocera",
        head = "Vanya Hood",
        body = gear.telchine_enhancing_body,
        hands = "Gende. Gages +1",
        legs = "Psycloth Lappas",
        feet = "Vanya Clogs",
        neck = "Voltsurge Torque",
        waist = "Witful Belt",
        left_ear = "Loquac. Earring",
        right_ear = "Etiolation Earring",
        left_ring = "Kishar Ring",
        right_ring = "Lebeche Ring",
        back = "Solemnity Cape",
    }

    sets.midcast['Elemental Magic'].OccultAcumen = {}

    -- Custom refinements for certain nuke tiers

    sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {})
    sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'].Resistant, {})

    -- Without burst
    sets.midcast.Helix = {
        main = "Bunzi's Rod",
        sub = "Ammurapi Shield",
        ammo = "Pemphredo Tathlum",
        head = "Peda. M.Board +3",
        body = "Agwu's Robe",
        hands = "Amalric Gages +1",
        legs = "Peda. Pants +3",
        feet = "Jhakri Pigaches +2",
        neck = gear.sch_jse_neck,
        waist = "Sacro Cord",
        left_ear = "Regal Earring",
        right_ear = "Malignance Earring",
        left_ring = "Metamor. Ring +1",
        right_ring = "Freke Ring",
        back = gear.nuke_jse_back,
    }

    sets.midcast.Helix.Resistant = set_combine(sets.midcast.Helix, {})
    sets.midcast.Helix.Proc = set_combine(sets.midcast.Helix, {})

    sets.midcast.Impact = set_combine(sets.midcast['Enfeebling Magic'].Resistant, { head = empty, body = gear.impact_body, })
    sets.midcast.Impact.OccultAcumen = set_combine(sets.midcast['Elemental Magic'].OccultAcumen, {})


    -- Resting sets
    sets.resting = {}

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

    sets.idle = {
        main = "Daybreak",
        sub = "Genmei Shield",
        ammo = "Homiliary",
        head = "Befouled Crown",
        body = gear.sch_body_idle,
        hands = { name = "Nyame Gauntlets", priority = 1 },
        legs = "Assid. Pants +1",
        feet = { name = "Nyame Sollerets", priority = 1 },
        neck = "Sanctity Necklace",
        waist = "Porous Rope",
        left_ear = "Infused Earring",
        right_ear = "Etiolation Earring",
        left_ring = "Defending Ring",
        right_ring = "Gelatinous Ring +1",
        back = gear.nuke_jse_back,
    }

    sets.idle.Town = set_combine(sets.idle, {
        main = gear.sch_town_idle_weapon,
        sub = gear.sch_town_idle_sub,
        head = "Nyame Helm",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets",
        neck = gear.sch_jse_neck,
    })

    sets.idle.Weak = sets.idle

    sets.idle.DT = {
        main = "Daybreak",
        sub = "Genmei Shield",
        ammo = "Staunch Tathlum +1",
        head = "Nyame Helm",
        body = "Agwu's Robe",
        hands = "Nyame Gauntlets",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets",
        neck = "Loricate Torque +1",
        waist = "Porous Rope",
        left_ear = "Odnowa Earring +1",
        right_ear = "Etiolation Earring",
        left_ring = "Defending Ring",
        right_ring = "Gelatinous Ring +1",
        back = gear.nuke_jse_back,
    }
    -- Defense sets

    sets.defense.PDT = {
        main = "Daybreak",
        sub = "Genmei Shield",
        ammo = "Staunch Tathlum +1",
        head = "Nyame Helm",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets",
        neck = "Loricate Torque +1",
        waist = "Porous Rope",
        left_ear = "Odnowa Earring +1",
        right_ear = "Etiolation Earring",
        left_ring = "Defending Ring",
        right_ring = "Gelatinous Ring +1",
        back = "Moonbeam Cape",
    }

    sets.defense.MDT = sets.defense.PDT
    sets.defense.MEVA = sets.defense.MDT

    sets.Kiting = { feet = "Herald's Gaiters" }
    sets.latent_refresh = { waist = "Fucho-no-obi" }
    sets.latent_refresh_grip = {}
    sets.TPEat = {}
    sets.DayIdle = {}
    sets.NightIdle = {}

    -- Engaged sets
    sets.engaged = {}


    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Ebullience'] = { head = "Arbatel Bonnet +1" }
    sets.buff['Rapture'] = { head = "Arbatel Bonnet +1" }
    sets.buff['Perpetuance'] = { hands = "Arbatel Bracers +1" }
    sets.buff['Immanence'] = { hands = "Arbatel Bracers +1" }
    sets.buff['Penury'] = {} -- legs="Savant's Pants +2"
    sets.buff['Parsimony'] = {} -- legs="Savant's Pants +2"
    sets.buff['Celerity'] = {} -- feet="Pedagogy Loafers"
    sets.buff['Alacrity'] = {} -- feet="Pedagogy Loafers"

    sets.buff['Klimaform'] = { feet = "Savant's Loafers +2" }

    sets.buff.Sublimation = { head = "Acad. Mortar. +3", body = "Peda. Gown +3", waist = "Embla Sash" }
    sets.buff.DTSublimation = { waist = "Embla Sash" }

end

-- Select default macro book on initial load or subjob change.
-- Default macro set/book
function select_default_macro_book()
    if player.sub_job == 'RDM' then
        set_macro_page(1, 18)
    elseif player.sub_job == 'BLM' then
        set_macro_page(1, 18)
    elseif player.sub_job == 'WHM' then
        set_macro_page(1, 18)
    else
        set_macro_page(1, 18)
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
