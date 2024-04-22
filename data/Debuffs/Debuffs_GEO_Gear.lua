function user_job_setup()

    state.OffenseMode:options('Normal')
    state.CastingMode:options('Normal', 'Resistant', 'DT')
    state.IdleMode:options('Normal', 'DT')
    state.PhysicalDefenseMode:options('PDT', 'NukeLock', 'GeoLock', 'PetPDT')
    state.MagicalDefenseMode:options('MDT', 'NukeLock')
    state.ResistDefenseMode:options('MEVA')
    state.Weapons:options('None')
    state.AutoZergMode = M(false, 'Auto Zerg Mode')
    state.MaintainAftermath = M(false, 'Maintain Aftermath')
    silibs.enable_cancel_outranged_ws()
    silibs.enable_cancel_on_blocking_status()
    silibs.enable_weapon_rearm()
    silibs.enable_auto_lockstyle(3)
    silibs.enable_waltz_refiner()
    silibs.enable_premade_commands()
    silibs.enable_th()
    silibs.enable_ui()

    gear.obi_cure_waist = "Porous Rope"
    gear.obi_low_nuke_waist = "Eschan Stone"
    gear.obi_high_nuke_waist = "Eschan Stone"

    autogeotar = "None"
    autoindi = "Fury"
    autogeo = "Frailty"
    autoentrust = "None"
    autows = "Black Halo"

    -- Additional local binds
    send_command('bind ^` gs c cycle ElementalMode')
    send_command('bind !` input /ja "Full Circle" <me>')
    send_command('bind @f8 gs c toggle AutoNukeMode')
    send_command('bind @` gs c set toggle MagicBurstMode Lock')
    send_command('bind @f10 gs c cycle RecoverMode')
    send_command('bind @f7 gs c set toggle CastingMode DT; gs c set toggle IdleMode DT')
    send_command('bind ^backspace input /ja "Blaze of Glory" <me>')
    send_command('bind !backspace input /ja "Life Cycle" <me>')
    send_command('bind @backspace input /ma "Sleep II" <t>')
    send_command('bind ^delete input /ma "Aspir III" <t>')
    send_command('bind @delete input /ma "Sleep" <t>')
    send_command('bind @f6 gs c toggle AutoZergMode')

    indi_duration = 326

    if player.sub_job == "RDM" then
        send_command('wait 5; hb mincure 4')
    elseif player.sub_job == "WHM" then
        send_command('wait 5; hb mincure 3')
    else
        send_command('wait 5; hb mincure 4')
    end

    select_default_macro_book()

end

function init_gear_sets()

    --------------------------------------
    -- Precast sets
    --------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA.Bolster = { body = "Bagua Tunic" }
    sets.precast.JA['Life Cycle'] = { body = gear.geo_body_enfeebling, back = gear.jse_pet_back }
    sets.precast.JA['Radial Arcana'] = { feet = "Bagua Sandals +3" }
    sets.precast.JA['Mending Halation'] = { legs = gear.geo_relic_legs }
    sets.precast.JA['Full Circle'] = { head = "Azimuth Hood +1", hands = "Bagua Mitaines +3" }

    -- Indi Duration in slots that would normally have skill here to make entrust more efficient.

    -- Relic hat for Blaze of Glory HP increase.
    sets.buff['Blaze of Glory'] = {}

    -- Fast cast sets for spells
    -- RDM sub = %15
    --
    -- 89%

    sets.precast.FC = {
        main = "Solstice", -- 5
        sub = "Chanter's Shield", -- 3
        range = { name = "Dunna", augments = { 'MP+20', 'Mag. Acc.+10', '"Fast Cast"+3', } }, -- 3
        head = gear.merlinic_fc_head, -- 15
        body = "Shango Robe", -- 8
        hands = gear.merlinic_fc_hands, -- 6
        legs = "Geomancy Pants +3", -- 15
        feet = gear.merlinic_fc_feet, -- 11
        neck = "Baetyl Pendant", -- 4
        waist = "Embla Sash", -- 5
        left_ear = "Loquac. Earring", -- 2
        right_ear = "Etiolation Earring", -- 1
        left_ring = "Weather. Ring +1", -- 4
        right_ring = { name = "Gelatinous Ring +1", priority = 500 },
        back = gear.jse_skill_back, -- 7
    }

    sets.precast.FC.DT = set_combine(sets.precast.FC, { back = { name = gear.dt_moon_back, priority = 1 }, left_ear = { name = "Odnowa Earring +1", priority = 1 }, })

    sets.precast.FC.Geomancy = set_combine(sets.precast.FC, { neck = gear.geo_jse_neck })
    sets.precast.FC.Geomancy.Indi = sets.precast.FC.Geomancy
    sets.precast.FC.Cure = set_combine(sets.precast.FC, {})
    sets.precast.FC.Curaga = sets.precast.FC.Cure

    sets.precast.FC.Geomancy.DT = set_combine(sets.precast.FC.DT, { neck = gear.geo_jse_neck })
    sets.precast.FC.Geomancy.Indi.DT = sets.precast.FC.Geomancy.DT
    sets.precast.FC.Cure.DT = set_combine(sets.precast.FC.DT, {})
    sets.precast.FC.Curaga.DT = sets.precast.FC.Cure.DT

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, { right_ring = "Gelatinous Ring +1", })
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {})
    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})
    sets.precast.FC.Impact = set_combine(sets.precast.FC, { head = empty, body = gear.impact_body })

    sets.precast.FC['Elemental Magic'].DT = set_combine(sets.precast.FC.DT, { right_ring = "Gelatinous Ring +1", })
    sets.precast.FC['Enhancing Magic'].DT = set_combine(sets.precast.FC.DT, {})
    sets.precast.FC.Stoneskin.DT = set_combine(sets.precast.FC['Enhancing Magic'].DT, {})
    sets.precast.FC.Impact.DT = set_combine(sets.precast.FC.DT, { head = empty, body = gear.impact_body })

    sets.Self_Healing = {}
    sets.Cure_Received = {}
    sets.Self_Refresh = {}

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        range = { name = "Dunna", augments = { 'MP+20', 'Mag. Acc.+10', '"Fast Cast"+3', } },
        head = "Nyame Helm",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets",
        neck = "Fotia Gorget",
        waist = "Fotia Belt",
        left_ear = "Ishvara Earring",
        right_ear = "Moonshade Earring",
        left_ring = "Vertigo Ring",
        right_ring = "Rufescent Ring",
        back = gear.dt_moon_back,
    }

    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = sets.precast.FC

    -- Skill gear + MP not depleted + Conserve MP
    -- 850 Skill + 55
    -- 101% Conserve MP goal, GEO has 43%, need 57% to cap
    -- CMP: 59%
    sets.midcast.Geomancy = {
        main = "Idris",
        sub = "Genmei Shield",
        range = { name = "Dunna", augments = { 'MP+20', 'Mag. Acc.+10', '"Fast Cast"+3', } }, -- 				GEO +18
        head = "Vanya Hood", -- CMP 6
        body = "Vedic Coat", -- CMP 10
        hands = "Shrieker's Cuffs", -- CMP 7
        legs = "Vanya Slops", -- CMP 12
        feet = "Vanya Clogs", -- CMP 6
        neck = "Loricate Torque +1",
        waist = "Luminary Sash", -- CMP 4
        left_ear = "Magnetic Earring", -- CMP 5
        right_ear = "Calamitous Earring", -- CMP 4
        left_ring = "Defending Ring",
        right_ring = "Gelatinous Ring +1",
        --back="Solemnity Cape",															-- CMP 5
        back = { name = gear.dt_moon_back, priority = 500 },
    }

    sets.midcast.Geomancy.DT = set_combine(sets.midcast.Geomancy, {})
    -- Indi Duration gear + Skill + Conserve MP
    -- 180 Base + 40s JP + 35s + 20% = 324s

    sets.midcast.Geomancy.Indi = {
        main = "Idris",
        sub = "Genmei Shield",
        range = { name = "Dunna", augments = { 'MP+20', 'Mag. Acc.+10', '"Fast Cast"+3', } },
        head = "Nyame Helm",
        body = "Vedic Coat",
        hands = "Nyame Gauntlets",
        legs = gear.geo_relic_legs, -- 15s
        feet = "Azimuth Gaiters +1", -- 20s
        neck = "Incanter's Torque",
        waist = "Luminary Sash",
        left_ear = "Magnetic Earring",
        right_ear = "Calamitous Earring",
        left_ring = "Defending Ring",
        right_ring = "Gelatinous Ring +1",
        back = gear.jse_skill_back, -- 20%
    }

    sets.midcast.Geomancy.Indi.DT = set_combine(sets.midcast.Geomancy.Indi, {})

    sets.midcast.Entrust = set_combine(sets.midcast.Geomancy.Indi, { main = "Solstice" })
    sets.buff.Entrust = sets.midcast.Entrust

    -- Cure Potency: 48%
    sets.midcast.Cure = {
        main = "Bunzi's Rod", -- 30
        sub = "Ammurapi Shield",
        head = { name = "Vanya Hood", augments = { 'MP+50', '"Fast Cast"+10', 'Haste+2%', } }, -- 10
        body = "Vedic Coat",
        hands = gear.telchine_enhancing_hands, -- 10
        legs = "Vanya Slops",
        feet = { name = "Vanya Clogs", augments = { '"Cure" potency +5%', '"Cure" spellcasting time -15%', '"Conserve MP"+6', } }, -- 10
        neck = "Incanter's Torque",
        waist = "Porous Rope",
        left_ear = "Regal Earring",
        right_ear = "Mendi. Earring", -- 5
        left_ring = "Vertigo Ring",
        right_ring = "Lebeche Ring",
        back = gear.dt_moon_back, -- 7
    }

    sets.midcast.Cure.DT = set_combine(sets.midcast.Cure, {
        sub = "Genmei Shield",
        body = "Nyame Mail",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets",
        left_ring = "Defending Ring",
        back = { name = gear.dt_moon_back, priority = 500 },
    })

    sets.midcast.LightWeatherCure = { waist = "Korin Obi" }
    sets.midcast.LightDayCure = sets.midcast.LightWeatherCure
    sets.midcast.Curaga = sets.midcast.Cure
    sets.midcast.Cursna = set_combine(sets.midcast.Cure, { neck = "Debilis Medallion", ring1 = "Haoma's Ring", ring2 = "Menelaus's Ring" })
    sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {})

    --DT
    sets.midcast.LightWeatherCure.DT = { back = { name = gear.dt_moon_back, priority = 1 }, waist = "Korin Obi" }
    sets.midcast.LightDayCure.DT = sets.midcast.LightWeatherCure.DT
    sets.midcast.Curaga.DT = sets.midcast.Cure.DT
    sets.midcast.Cursna.DT = set_combine(sets.midcast.Cure.DT, { neck = "Debilis Medallion", ring1 = "Haoma's Ring", ring2 = "Menelaus's Ring" })
    sets.midcast.StatusRemoval.DT = set_combine(sets.midcast.FastRecast.DT, {})

    ---------------
    -- Elemental --
    ---------------
    sets.midcast['Elemental Magic'] = {
        main = "Bunzi's Rod", -- 7
        sub = "Ammurapi Shield",
        --range=empty,
        --ammo="Pemphredo Tathlum",
        head = "C. Palug Crown",
        body = "Jhakri Robe +2",
        hands = { name = "Amalric Gages +1", augments = { 'INT+12', 'Mag. Acc.+20', '"Mag.Atk.Bns."+20', } },
        legs = gear.geo_freenuke_legs,
        feet = "Jhakri Pigaches +2",
        neck = "Sanctity Necklace",
        waist = gear.ElementalObi,
        left_ear = "Regal Earring",
        right_ear = "Malignance Earring",
        left_ring = "Metamor. Ring +1",
        right_ring = "Freke Ring",
        back = gear.jse_mab_back,
    }

    sets.midcast['Elemental Magic'].Resistant = sets.midcast['Elemental Magic']
    sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {})
    sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'].Resistant, {})

    -- Gear for Magic Burst mode.
    sets.MagicBurst = {
        main = "Bunzi's Rod", -- 10
        sub = "Ammurapi Shield",
        --range=empty,
        --ammo="Pemphredo Tathlum",
        head = gear.BurstHead, -- 8
        body = gear.BurstBody,
        hands = { name = "Amalric Gages +1", augments = { 'INT+12', 'Mag. Acc.+20', '"Mag.Atk.Bns."+20', } },
        legs = gear.BurstLegs, -- 8
        feet = "Bagua Sandals +3",
        --feet="Jhakri Pigaches +2",																		-- 7
        neck = "Mizu. Kubikazari", -- 10
        waist = gear.ElementalObi,
        left_ear = "Regal Earring",
        right_ear = "Malignance Earring",
        left_ring = "Mujin Band",
        right_ring = "Freke Ring",
        back = gear.jse_mab_back,
    }

    sets.RecoverBurst = set_combine(sets.MagicBurst, { body = "Seidr Cotehardie" })

    -- Other magics sets

    sets.midcast['Dark Magic'] = {
        main = "Bunzi's Rod",
        sub = "Ammurapi Shield",
        range = "Dunna",
        head = "Pixie Hairpin +1",
        body = gear.geo_body_enfeebling,
        hands = "Geomancy Mitaines +3",
        legs = "Geomancy Pants +3",
        feet = "Geomancy Sandals +3",
        neck = "Erra Pendant",
        waist = "Fucho-no-obi",
        left_ear = "Regal Earring",
        right_ear = "Malignance Earring",
        left_ring = "Evanescence Ring",
        right_ring = "Archon Ring",
        back = gear.nuke_jse_back,
    }

    sets.midcast['Dark Magic'].DT = set_combine(sets.midcast['Dark Magic'], { back = { name = gear.dt_moon_back, priority = 1 }, })

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {})
    sets.midcast.Aspir = sets.midcast.Drain
    sets.midcast.Drain.DT = set_combine(sets.midcast['Dark Magic'].DT, {})
    sets.midcast.Aspir.DT = sets.midcast.Drain.DT

    sets.midcast['Enfeebling Magic'] = {
        main = "Daybreak",
        sub = "Ammurapi Shield",
        range = { name = "Dunna", augments = { 'MP+20', 'Mag. Acc.+10', '"Fast Cast"+3', } },
        head = "C. Palug Crown",
        body = gear.geo_body_enfeebling,
        hands = "Geo. Mitaines +3",
        legs = { name = "Geomancy Pants +3", priority = 1 },
        feet = "Geomancy Sandals +3",
        neck = gear.geo_jse_neck,
        waist = "Luminary Sash",
        left_ear = "Regal Earring",
        right_ear = "Malignance Earring",
        left_ring = "Kishar Ring",
        right_ring = "Metamorph Ring +1",
        back = gear.jse_mab_back,
    }

    sets.midcast['Enfeebling Magic'].DT = set_combine(sets.midcast['Enfeebling Magic'], { back = { name = gear.dt_moon_back, priority = 1 }, })

    sets.midcast['Enfeebling Magic'].Resistant = {
        main = "Daybreak",
        sub = "Ammurapi Shield",
        range = { name = "Dunna", augments = { 'MP+20', 'Mag. Acc.+10', '"Fast Cast"+3', } },
        head = "C. Palug Crown",
        body = gear.geo_body_enfeebling,
        hands = "Geo. Mitaines +3",
        legs = "Geomancy Pants +3",
        feet = "Geomancy Sandals +3",
        neck = gear.geo_jse_neck,
        waist = "Luminary Sash",
        left_ear = "Regal Earring",
        right_ear = "Malignance Earring",
        left_ring = "Vertigo Ring",
        right_ring = "Metamorph Ring +1",
        back = gear.jse_mab_back,
    }

    sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'], {})
    sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})
    sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})
    sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})
    sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})
    sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

    sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
    sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
    sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
    sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
    sets.midcast['Divine Magic'] = set_combine(sets.midcast['Enfeebling Magic'], {})

    sets.midcast.Impact = set_combine(sets.midcast['Enfeebling Magic'], {
        main = "Bunzi's Rod",
        head = empty,
        body = gear.impact_body,
    })

    sets.midcast.Stun = sets.midcast['Enfeebling Magic']
    sets.midcast.Stun.Resistant = sets.midcast['Enfeebling Magic'].Resistant
    sets.midcast.Stun.DT = sets.midcast.Stun
    sets.midcast.Stun.Resistant.DT = sets.midcast['Enfeebling Magic'].Resistant

    --DT
    sets.midcast.ElementalEnfeeble.DT = set_combine(sets.midcast['Enfeebling Magic'].DT, {})
    sets.midcast.IntEnfeebles.DT = set_combine(sets.midcast['Enfeebling Magic'].DT, {})
    sets.midcast.MndEnfeebles.DT = set_combine(sets.midcast['Enfeebling Magic'].DT, {})

    sets.midcast.Dia.DT = set_combine(sets.midcast['Enfeebling Magic'].DT, sets.TreasureHunter)
    sets.midcast['Dia II'].DT = set_combine(sets.midcast['Enfeebling Magic'].DT, sets.TreasureHunter)
    sets.midcast.Bio.DT = set_combine(sets.midcast['Enfeebling Magic'].DT, sets.TreasureHunter)
    sets.midcast['Bio II'].DT = set_combine(sets.midcast['Enfeebling Magic'].DT, sets.TreasureHunter)
    sets.midcast['Divine Magic'].DT = set_combine(sets.midcast['Enfeebling Magic'].DT, {})

    sets.midcast.Impact.DT = set_combine(sets.midcast['Enfeebling Magic'].DT, {
        main = "Bunzi's Rod",
        head = empty,
        body = gear.impact_body,
    })

    sets.midcast['Enhancing Magic'] = {
        main = gear.gada_enhancing_club, -- 5% 	-18 Skill
        sub = "Ammurapi Shield", -- 10%
        head = gear.telchine_enhancing_head, -- 8%
        body = gear.telchine_enhancing_body, -- 10% 	-12 Skill
        hands = gear.telchine_enhancing_hands, -- 8%
        legs = gear.telchine_enhancing_legs, -- 9%
        feet = gear.telchine_enhancing_feet, -- 9%
        neck = "Incanter's Torque", -- 		-10 Skill
        waist = "Embla Sash", -- 10%
        left_ear = "Andoaa Earring", --		-5 Skill
        right_ear = "Etiolation Earring",
        left_ring = "Defending Ring",
        right_ring = "Gelatinous Ring +1",
    }

    sets.midcast['Enhancing Magic'].DT = set_combine(sets.midcast['Enhancing Magic'], { neck = "Loricate Torque +1", left_ear = "Odnowa Earring +1", back = { name = gear.dt_moon_back, priority = 1 }, })

    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], { neck = "Nodens Gorget", waist = "Siegel Sash" })
    sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], { head = "Amalric Coif +1", feet = "Inspirited Boots", waist = "Gishdubar Sash" })
    sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], { main = "Vadose Rod", head = "Amalric Coif +1" })
    sets.midcast.BarElement = set_combine(sets.midcast['Enhancing Magic'], {})

    sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {})
    sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'], {})
    sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {})
    sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'], {})

    --DT
    sets.midcast.Stoneskin.DT = set_combine(sets.midcast['Enhancing Magic'].DT, { neck = "Nodens Gorget", waist = "Siegel Sash" })
    sets.midcast.Refresh.DT = set_combine(sets.midcast['Enhancing Magic'].DT, { head = "Amalric Coif +1", feet = "Inspirited Boots", waist = "Gishdubar Sash" })
    sets.midcast.Aquaveil.DT = set_combine(sets.midcast['Enhancing Magic'].DT, { main = "Vadose Rod", head = "Amalric Coif +1" })
    sets.midcast.BarElement.DT = set_combine(sets.midcast['Enhancing Magic'].DT, {})

    sets.midcast.Protect.DT = set_combine(sets.midcast['Enhancing Magic'].DT, {})
    sets.midcast.Protectra.DT = set_combine(sets.midcast['Enhancing Magic'].DT, {})
    sets.midcast.Shell.DT = set_combine(sets.midcast['Enhancing Magic'].DT, {})
    sets.midcast.Shellra.DT = set_combine(sets.midcast['Enhancing Magic'].DT, {})

    -- Gear for specific elemental nukes.
    sets.element.Wind = {}
    sets.element.Ice = {}
    sets.element.Earth = {}

    --------------------------------------
    -- Idle/resting/defense
    --------------------------------------

    -- Refresh: 7
    -- PDT: 47%
    sets.idle = {
        main = "Daybreak",
        sub = "Genmei Shield", -- 10%
        range = { name = "Dunna", augments = { 'MP+20', 'Mag. Acc.+10', '"Fast Cast"+3', } },
        head = gear.geo_head_idle,
        body = gear.geo_body_idle,
        hands = "Bagua Mitaines +3",
        legs = "Assid. Pants +1",
        feet = "Geomancy Sandals +3",
        neck = "Sanctity Necklace",
        waist = "Porous Rope",
        left_ear = "Infused Earring",
        right_ear = "Etiolation Earring",
        left_ring = "Defending Ring", -- 10%
        right_ring = "Gelatinous Ring +1", -- 7%
        back = gear.jse_pet_back,
    }

    sets.idle.DT = {
        main = "Daybreak",
        sub = "Genmei Shield", -- 10
        range = { name = "Dunna", augments = { 'MP+20', 'Mag. Acc.+10', '"Fast Cast"+3', } },
        head = gear.geo_head_idle,
        body = gear.geo_dt_body_idle,
        hands = "Nyame Gauntlets", -- 7
        legs = "Nyame Flanchard",
        feet = "Geomancy Sandals +3",
        neck = "Loricate Torque +1", -- 6
        waist = "Porous Rope",
        left_ear = { name = "Odnowa Earring +1", priority = 500 }, -- 3
        right_ear = { name = "Etiolation Earring", priority = 500 },
        left_ring = "Defending Ring", -- 10
        right_ring = { name = "Gelatinous Ring +1", priority = 500 }, -- 7
        back = gear.jse_pet_back,
    }

    sets.idle.Town = {
        main = "Idris",
        sub = "Genmei Shield", -- 10%
        range = { name = "Dunna", augments = { 'MP+20', 'Mag. Acc.+10', '"Fast Cast"+3', } },
        head = "Nyame Helm",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets",
        neck = "Sanctity Necklace",
        waist = "Porous Rope",
        left_ear = "Infused Earring",
        right_ear = "Etiolation Earring",
        left_ring = "Defending Ring", -- 10%
        right_ring = "Gelatinous Ring +1", -- 7%
        back = gear.jse_pet_back,
    }

    -- Pet sets are for when Luopan is present.
    -- Regen:	27
    -- PET DT:	36/37.5
    -- Self DT: 46
    sets.idle.Pet = { --Regen / Pet DT
        main = "Idris", -- 0 / 25
        sub = "Genmei Shield",
        range = { name = "Dunna", augments = { 'MP+20', 'Mag. Acc.+10', '"Fast Cast"+3', } }, -- 0 / 5
        head = "Azimuth Hood +1", -- 3
        body = gear.geo_body_idle,
        hands = "Geomancy Mitaines +3", -- 0 / 13
        legs = gear.telchine_pet_legs, -- 3
        feet = "Bagua Sandals +3", -- 5
        neck = gear.geo_jse_neck,
        waist = "Isa Belt", -- 1 / 3
        left_ear = "Odnowa Earring +1",
        right_ear = "Etiolation Earring",
        left_ring = "Defending Ring", -- 10%
        right_ring = "Gelatinous Ring +1", -- 7%
        back = gear.jse_pet_back, -- 15 / 0
    }

    sets.idle.DT.Pet = {
        main = "Idris",
        sub = "Genmei Shield", -- 10
        range = { name = "Dunna", augments = { 'MP+20', 'Mag. Acc.+10', '"Fast Cast"+3', } },
        head = "Nyame Helm",
        body = gear.geo_dt_body_idle,
        hands = "Geomancy Mitaines +3", -- 0 / 13
        legs = "Nyame Flanchard", -- 3 / 0
        feet = "Bagua Sandals +3", -- 5
        neck = gear.geo_jse_neck,
        waist = "Isa Belt", -- 1 / 0
        left_ear = { name = "Odnowa Earring +1", priority = 1 }, -- 3
        right_ear = { name = "Etiolation Earring", priority = 1 },
        left_ring = "Defending Ring", -- 10
        right_ring = "Gelatinous Ring +1", -- 7
        back = gear.jse_pet_back, -- 10 / 0
    }

    sets.idle.Indi = set_combine(sets.idle, {})
    sets.idle.Pet.Indi = set_combine(sets.idle.Pet, {})
    sets.idle.DT.Indi = set_combine(sets.idle.DT, {})
    sets.idle.DT.Pet.Indi = set_combine(sets.idle.DT.Pet, {})


    -- Defense sets
    -- 42% PDT/DT

    sets.defense.PDT = {
        main = "Daybreak",
        sub = "Genmei Shield",
        range = { name = "Dunna", augments = { 'MP+20', 'Mag. Acc.+10', '"Fast Cast"+3', } },
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
        back = gear.dt_moon_back,
    }

    sets.defense.MDT = sets.defense.PDT
    sets.defense.MEVA = sets.defense.PDT

    sets.idle.Weak = sets.idle.DT
    sets.resting = sets.idle

    sets.defense.PetPDT = sets.idle.DT.Pet
    sets.defense.NukeLock = sets.midcast['Elemental Magic']
    sets.defense.GeoLock = sets.midcast.Geomancy.Indi

    sets.Kiting = { feet = "Geomancy Sandals +3" }
    sets.latent_refresh = { waist = "Fucho-no-obi" }
    sets.DayIdle = {}
    sets.NightIdle = {}
    sets.TreasureHunter = set_combine(sets.TreasureHunter, {})

    --Removes HP
    sets.HPDown = {}
    sets.buff.Doom = set_combine(sets.buff.Doom, {})

    --------------------------------------
    -- Engaged sets
    --------------------------------------

    sets.engaged = {
        main = "Idris",
        sub = "Genmei Shield",
        range = { name = "Dunna", augments = { 'MP+20', 'Mag. Acc.+10', '"Fast Cast"+3', } },
        head = "Nyame Helm",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets",
        neck = "Combatant's Torque",
        waist = "Grunfeld Rope",
        left_ear = "Telos Earring",
        right_ear = "Cessance Earring",
        left_ring = "Petrov Ring",
        right_ring = "Begrudging Ring",
    }
    sets.engaged.DW = {}

    --------------------------------------
    -- Custom buff sets
    --------------------------------------

    -- Gear that converts elemental damage done to recover MP.
    sets.RecoverMP = {}

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(4, 10)
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
