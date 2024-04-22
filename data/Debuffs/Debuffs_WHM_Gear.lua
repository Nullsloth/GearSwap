function user_job_setup()

    state.OffenseMode:options('Normal')
    state.CastingMode:options('Normal', 'Resistant', 'DT')
    state.IdleMode:options('Normal', 'DT')
    state.PhysicalDefenseMode:options('PDT')
    state.MagicalDefenseMode:options('MDT')
    state.ResistDefenseMode:options('MEVA')
    state.Weapons:options('None', 'Yagrush', 'Tishtrya', 'Blue', 'DualWeapons')
    state.MiniQueue = M(false, 'MiniQueue')
    silibs.enable_cancel_outranged_ws()
    silibs.enable_cancel_on_blocking_status()
    silibs.enable_weapon_rearm()
    silibs.enable_auto_lockstyle(3)
    silibs.enable_waltz_refiner()
    silibs.enable_premade_commands()
    silibs.enable_th()
    silibs.enable_ui()

    autows_list = { ['DualWeapons'] = 'Realmrazer', ['MeleeWeapons'] = 'Realmrazer' }
    autowstp = 1250

    gear.jse_cure_back = { name = "Alaunus's Cape", augments = { 'MP+60', 'Mag. Acc+20 /Mag. Dmg.+20', '"Fast Cast"+10', 'Phys. dmg. taken-10%', } }

    gear.obi_cure_waist = "Porous Rope"
    gear.obi_cure_back = gear.jse_cure_back

    gear.obi_nuke_waist = "Porous Rope"
    gear.obi_high_nuke_waist = "Porous Rope"
    gear.obi_nuke_back = gear.jse_cure_back

    -- Additional local binds
    send_command('bind ^` input /ma "Arise" <t>')
    send_command('bind @` gs c buffup Rebuff')
    send_command('bind @f7 gs c set toggle CastingMode DT; gs c set toggle IdleMode DT')
    send_command('bind ^@!` gs c toggle AutoCaress')
    send_command('bind ^backspace input /ja "Sacrosanctity" <me>')
    send_command('bind @backspace input /ma "Aurora Storm" <me>')
    send_command('bind !backspace input /ja "Accession" <me>')
    send_command('bind != input /ja "Sublimation" <me>')
    send_command('bind ^\\\\ input /ma "Protectra V" <me>')
    send_command('bind @\\\\ input /ma "Shellra V" <me>')
    send_command('bind !\\\\ input /ma "Reraise IV" <me>')

end

function init_gear_sets()
    -- Weapons sets
    sets.weapons.Yagrush = { main = "Yagrush", sub = "Genmei Shield" }
    sets.weapons.Tishtrya = { main = "Tishtrya", sub = "Genmei Shield" }
    sets.weapons.DualWeapons = { main = "Tishtrya", sub = "Daybreak" }
    sets.weapons.Blue = { main = gear.ambu_club, sub = "Genmei Shield" }

    -- Precast Sets
    -- 83%
    --
    sets.precast.FC = {
        main = "C. Palug Hammer", -- 7
        sub = "Chanter's Shield", -- 3
        ammo = "Impatiens", -- QC 2
        head = "Vanya Hood", -- 10
        body = { name = "Inyanga Jubbah +2", priority = 100 }, -- 14
        hands = "Gende. Gages +1", -- 7
        legs = "Ayanmo Cosciales +2", -- 6
        feet = "Regal Pumps +1", -- 6
        neck = "Cleric's Torque", -- 5
        waist = "Embla Sash", -- 5
        left_ear = "Loquac. Earring", -- 2
        right_ear = "Malignance Earring", -- 4
        left_ring = "Weather. Ring +1", -- 4
        right_ring = "Lebeche Ring", -- QC 2
        back = gear.jse_cure_back -- 10
    }

    sets.precast.FC.DT = set_combine(sets.precast.FC, { back = gear.whm_dt_back, })

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, { waist = "Siegel Sash" })
    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})
    sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, { main = gear.whm_aoe_weapon, legs = "Ebers Pantaloons +1" })
    sets.precast.FC.StatusRemoval = set_combine(sets.precast.FC['Healing Magic'], { main = gear.whm_aoe_weapon })

    -- MEVA
    sets.precast.FC['Enhancing Magic'].DT = set_combine(sets.precast.FC.DT, { waist = "Siegel Sash" })
    sets.precast.FC.Stoneskin.DT = set_combine(sets.precast.FC['Enhancing Magic'].DT, {})
    sets.precast.FC['Healing Magic'].DT = set_combine(sets.precast.FC.DT, { main = gear.whm_aoe_weapon, legs = "Ebers Pantaloons +1" })
    sets.precast.FC.StatusRemoval.DT = set_combine(sets.precast.FC['Healing Magic'].DT, { main = gear.whm_aoe_weapon })
    --sets.precast.FC['Reraise'].DT = set_combine(sets.precast.FC.DT, {})

    -- Combines FC Set + Healing/Cure casting time set.

    -- FC: 2 13 7 4 2 4 10 = 42%
    -- Cure/Healing: 56%
    -- Total: 98% + Merits / JP
    --
    sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'], {
        main = "Queller Rod", -- 7
        sub = "Genmei Shield",
        left_ear = "Mendi. Earring", -- 4
        right_ear = "Nourishing Earring +1", -- 5
        legs = "Ebers Pantaloons +1", -- 13
        feet = "Vanya Clogs", -- 15
    })

    sets.precast.FC.Curaga = sets.precast.FC.Cure
    sets.precast.FC.CureSolace = sets.precast.FC.Cure
    sets.precast.FC.Impact = set_combine(sets.precast.FC, { head = empty, body = gear.impact_body })

    -- MEVA
    sets.precast.FC.Cure.DT = set_combine(sets.precast.FC['Healing Magic'].DT, {
        main = "Queller Rod", -- 7
        sub = "Genmei Shield",
        left_ear = "Mendi. Earring", -- 4
        right_ear = "Nourishing Earring +1", -- 5
        legs = "Ebers Pantaloons +1", -- 13
        feet = "Vanya Clogs", -- 15
    })

    sets.precast.FC.Curaga.DT = sets.precast.FC.Cure.DT
    sets.precast.FC.CureSolace.DT = sets.precast.FC.Cure.DT
    sets.precast.FC.Impact.DT = set_combine(sets.precast.FC.DT, { head = empty, body = "Twilight Cloak" })

    -- Precast sets to enhance JAs
    sets.precast.JA.Benediction = { body = "Piety Bliaut +3" }
    sets.precast.JA.Devotion = {} --head="Piety Cap"
    sets.precast.JA.Sublimation = { waist = "Embla Sash" }

    --------------------------------
    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}

    -- Weaponskill sets

    sets.precast.WS = {
        ammo = "Crepuscular Pebble",
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
        back = gear.jse_cure_back,
    }

    sets.precast.WS.Dagan = {}

    sets.MaxTP = { ear1 = "Telos Earring", ear2 = "Cessance Earring" }
    sets.MaxTP.Dagan = { ear1 = "Etiolation Earring", ear2 = "Malignance Earring" }


    --sets.precast.WS['Flash Nova'] = {}

    --sets.precast.WS['Mystic Boon'] = {}

    -- Midcast Sets

    sets.Kiting = { feet = gear.whm_kiting_feet }
    sets.latent_refresh = { waist = "Fucho-no-obi" }
    sets.DayIdle = {}
    sets.NightIdle = {}
    sets.TreasureHunter = set_combine(sets.TreasureHunter, { feet = gear.chironic_treasure_feet })

    --Situational sets: Gear that is equipped on certain targets
    sets.Self_Healing = { waist = "Gishdubar Sash" }
    sets.Cure_Received = { waist = "Gishdubar Sash" }
    sets.Self_Refresh = { waist = "Gishdubar Sash", feet = "Inspirited Boots" }

    -- Conserve Mp set for spells that don't need anything else, for set_combine.

    sets.ConserveMP = {
        main = "Malignance Pole",
        sub = "Enki Strap",
        ammo = gear.whm_dt_ammo,
        head = "Vanya Hood", -- CMP 6
        body = "Vedic Coat", -- CMP 10
        hands = "Shrieker's Cuffs", -- CMP 7
        legs = "Vanya Slops", -- CMP 12
        feet = "Vanya Clogs", -- CMP 6
        neck = "Incanter's Torque",
        waist = "Luminary Sash", -- CMP 4
        left_ear = "Magnetic Earring", -- CMP 5
        right_ear = "Calamitous Earring", -- CMP 4
        left_ring = "Defending Ring",
        right_ring = "Gelatinous Ring +1",
        back = "Solemnity Cape", -- CMP 5
    }

    sets.midcast.Teleport = sets.ConserveMP
    sets.midcast['Arise'] = sets.ConserveMP
    sets.midcast['Arise'].DT = set_combine(sets.ConserveMP, {

    })

    -- Gear for Magic Burst mode.
    sets.MagicBurst = { neck = "Mizu. Kubikazari", ring1 = "Mujin Band" }

    sets.midcast.FastRecast = sets.precast.FC

    -- Cure sets

    sets.midcast['Full Cure'] = sets.midcast.FastRecast

    -- Cure sets

    -- CPI:		50
    -- CPII:	6

    sets.midcast.Cure = {
        main = { name = "Queller Rod", augments = { 'Healing magic skill +15', '"Cure" potency +10%', '"Cure" spellcasting time -7%', } }, -- 10 / 2
        sub = "Sors Shield", -- 3
        ammo = "Hydrocera",
        head = "Ebers Cap +1", -- 16
        body = "Theo. Bliaut +3",
        hands = "Theophany Mitts +3", -- 0  / 4
        legs = "Ebers Pantaloons +1",
        feet = { name = "Vanya Clogs", augments = { '"Cure" potency +5%', '"Cure" spellcasting time -15%', '"Conserve MP"+6', } }, -- 10
        neck = "Cleric's Torque", -- 6
        waist = "Porous Rope",
        left_ear = "Mendi. Earring", -- 0  / 2
        right_ear = "Glorious Earring", -- 5
        left_ring = "Metamorph Ring +1",
        right_ring = "Lebeche Ring", -- 3
        back = gear.jse_cure_back,
    }

    sets.midcast.CureSolace = set_combine(sets.midcast.Cure, { body = "Ebers Bliaut +1" })
    sets.midcast.Curaga = sets.midcast.Cure
    sets.midcast.LightWeatherCure = set_combine(sets.midcast.Cure, { main = gear.cure_weather_weapon, sub = "Enki Strap", waist = "Korin Obi" })
    sets.midcast.LightWeatherCureSolace = set_combine(sets.midcast.Cure, { main = gear.cure_weather_weapon, sub = "Enki Strap", body = "Ebers Bliaut +1", waist = "Korin Obi" })
    sets.midcast.LightDayCureSolace = set_combine(sets.midcast.Cure, { main = gear.cure_weather_weapon, sub = "Enki Strap", body = "Ebers Bliaut +1", waist = "Korin Obi" })
    sets.midcast.LightDayCure = set_combine(sets.midcast.Cure, { main = gear.cure_weather_weapon, sub = "Enki Strap", waist = "Korin Obi" })
    sets.midcast.LightWeatherCuraga = set_combine(sets.midcast.Cure, { main = gear.cure_weather_weapon, sub = "Enki Strap", waist = "Korin Obi" })
    sets.midcast.LightDayCuraga = set_combine(sets.midcast.Cure, { main = gear.cure_weather_weapon, sub = "Enki Strap", waist = "Korin Obi" })

    --	Cure:	50% + 9% II
    -- 	PDT/DT:	-50%
    sets.midcast.Cure.DT = { -- Cure 	/	PDT/DT
        main = "Bunzi's Rod", -- 30%
        sub = "Genmei Shield", -- 			/	10
        ammo = gear.whm_dt_ammo, --			/	3
        head = "Ebers Cap +1", -- 16%
        body = "Theo. Bliaut +3",
        hands = "Theophany Mitts +3", -- 4% II
        legs = "Ebers Pantaloons +1",
        feet = "Nyame Sollerets", --			/	7
        neck = "Cleric's Torque", -- 6%
        waist = "Korin Obi",
        left_ear = { name = "Odnowa Earring +1", priority = 1 }, --   			3
        right_ear = "Glorious Earring", -- 5% II
        left_ring = "Defending Ring", --				10
        right_ring = { name = "Gelatinous Ring +1", priority = 1 }, --				7
        back = gear.jse_cure_back, --				10
    }

    sets.midcast.CureSolace.DT = set_combine(sets.midcast.Cure.DT, { body = "Ebers Bliaut +1" })
    sets.midcast.Curaga.DT = sets.midcast.Cure.DT
    sets.midcast.LightWeatherCure.DT = sets.midcast.Cure.DT
    sets.midcast.LightWeatherCureSolace.DT = sets.midcast.Cure.DT
    sets.midcast.LightDayCureSolace.DT = sets.midcast.Cure.DT
    sets.midcast.LightDayCure.DT = sets.midcast.Cure.DT
    sets.midcast.LightWeatherCuraga.DT = sets.midcast.Cure.DT
    sets.midcast.LightDayCuraga.DT = sets.midcast.Cure.DT

    sets.midcast["Reraise"] = sets.midcast.Cure.DT
    sets.midcast["Reraise"].DT = sets.midcast.Cure.DT

    --Melee Curesets are used whenever your Weapons state is set to anything but None.
    sets.midcast.MeleeCure = sets.midcast.Cure
    sets.midcast.MeleeCureSolace = set_combine(sets.midcast.MeleeCure, { body = "Ebers Bliaut +1" })
    sets.midcast.MeleeLightWeatherCure = set_combine(sets.midcast.MeleeCure, { waist = "Korin Obi" })
    sets.midcast.MeleeLightWeatherCureSolace = set_combine(sets.midcast.MeleeCure, { body = "Ebers Bliaut +1", waist = "Korin Obi" })
    sets.midcast.MeleeLightDayCureSolace = set_combine(sets.midcast.MeleeCure, { body = "Ebers Bliaut +1", waist = "Korin Obi" })
    sets.midcast.MeleeLightDayCure = set_combine(sets.midcast.MeleeCure, { waist = "Korin Obi" })
    sets.midcast.MeleeCuraga = set_combine(sets.midcast.MeleeCure, {})
    sets.midcast.MeleeLightWeatherCuraga = set_combine(sets.midcast.MeleeCure, { waist = "Korin Obi" })
    sets.midcast.MeleeLightDayCuraga = set_combine(sets.midcast.MeleeCure, { waist = "Korin Obi" })

    sets.midcast.Cursna = {
        main = gear.whm_aoe_weapon,
        sub = "Genmei Shield",
        ammo = gear.whm_dt_ammo,
        head = "Nyame Helm",
        body = "Ebers Bliaut +1",
        hands = "Fanatic Gloves",
        legs = "Th. Pant. +3",
        feet = { name = "Vanya Clogs", augments = { '"Cure" potency +5%', '"Cure" spellcasting time -15%', '"Conserve MP"+6', } },
        neck = "Debilis Medallion",
        waist = "Porous Rope",
        left_ear = "Odnowa Earring +1",
        right_ear = "Genmei Earring",
        left_ring = "Haoma's Ring",
        right_ring = "Menelaus's Ring",
        back = gear.jse_cure_back,
    }

    sets.midcast.Cursna.DT = sets.midcast.Cursna

    sets.midcast.StatusRemoval = {
        main = gear.whm_aoe_weapon,
        sub = "Genmei Shield",
        ammo = gear.whm_dt_ammo,
        head = "Ebers Cap +1",
        body = gear.whm_body_idle,
        hands = "Ebers Mitts +1",
        legs = "Ebers Pantaloons +1",
        feet = "Nyame Sollerets",
        neck = "Cleric's Torque",
        waist = "Porous Rope",
        left_ear = "Odnowa Earring +1",
        right_ear = "Genmei Earring",
        left_ring = "Defending Ring",
        right_ring = "Gelatinous Ring +1",
        back = gear.jse_cure_back,
    }
    sets.midcast.StatusRemoval.DT = sets.midcast.StatusRemoval

    -- 110 total Enhancing Magic Skill; caps even without Light Arts
    -- Duration gear
    -- 70%
    sets.midcast['Enhancing Magic'] = {
        main = gear.gada_enhancing_club, -- 6%
        sub = "Ammurapi Shield", -- 10%
        ammo = "Hydrocera",
        head = gear.telchine_enhancing_head, -- 8%
        neck = "Incanter's Torque", -- 10 Skill
        body = gear.telchine_enhancing_body, -- 8%
        hands = gear.telchine_enhancing_hands, -- 10%
        legs = gear.telchine_enhancing_legs, -- 8%
        feet = gear.telchine_enhancing_feet, -- 10%
        waist = "Embla Sash", -- 10%
        left_ear = "Andoaa Earring", -- 5 Skill
        right_ear = "Etiolation Earring",
        left_ring = "Defending Ring",
        right_ring = "Gelatinous Ring +1",
    }

    sets.midcast['Enhancing Magic'].DT = set_combine(sets.midcast['Enhancing Magic'], {
        ammo = gear.whm_dt_ammo,
        neck = "Loricate Torque +1",
        left_ear = "Odnowa Earring +1",
        right_ear = "Genmei Earring",
        back = gear.whm_dt_back,
    })

    sets.midcast.BarElement = set_combine(sets.midcast['Enhancing Magic'], {
        main = "Beneficus",
        head = "Ebers Cap +1",
        body = "Ebers Bliaut +1",
        hands = "Ebers Mitts +1",
        legs = gear.whm_relic_legs,
        feet = "Ebers Duckbills +1",
        back = gear.whm_dt_back,
    })

    sets.midcast.BarElement.DT = set_combine(sets.midcast.BarElement, { left_ear = { name = "Odnowa Earring +1", priority = 1 }, })

    sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {
        main = "Bolelabunga",
        head = "Inyanga Tiara +2",
        body = "Piety Bliaut +3",
        hands = "Ebers Mitts +1",
        legs = "Th. Pant. +3",
        feet = "Bunzi's Sabots",
    })

    sets.midcast.Regen.DT = set_combine(sets.midcast.Regen, {
        ammo = gear.whm_dt_ammo,
        neck = "Loricate Torque +1",
        left_ear = "Odnowa Earring +1",
        right_ear = "Genmei Earring",
    })

    -- Buff for duration
    sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'], {})
    sets.midcast.Protectra.DT = set_combine(sets.midcast.Protectra, {
        ammo = gear.whm_dt_ammo,
        neck = "Loricate Torque +1",
        left_ear = "Odnowa Earring +1",
        right_ear = "Genmei Earring",
        back = gear.whm_dt_back,
    })
    sets.midcast.Protect = sets.midcast.Protectra
    sets.midcast.Protect.DT = set_combine(sets.midcast.Protect, {
        ammo = gear.whm_dt_ammo,
        neck = "Loricate Torque +1",
        left_ear = "Odnowa Earring +1",
        right_ear = "Genmei Earring",
        back = gear.whm_dt_back,
    })
    sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'], {})
    sets.midcast.Shellra.DT = set_combine(sets.midcast.Shellra, {
        ammo = gear.whm_dt_ammo,
        neck = "Loricate Torque +1",
        left_ear = "Odnowa Earring +1",
        right_ear = "Genmei Earring",
        back = gear.whm_dt_back,
    })
    sets.midcast.Shell = sets.midcast.Shellra
    sets.midcast.Shell.DT = set_combine(sets.midcast.Shell, {
        ammo = gear.whm_dt_ammo,
        neck = "Loricate Torque +1",
        left_ear = "Odnowa Earring +1",
        right_ear = "Genmei Earring",
        back = gear.whm_dt_back,
    })

    sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {})
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], { neck = "Nodens Gorget", waist = "Siegel Sash" })
    sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], { main = "Vadose Rod", head = "Chironic Hat" })
    sets.midcast.Auspice = set_combine(sets.midcast['Enhancing Magic'], { feet = "Ebers Duckbills +1" })

    sets.midcast.Refresh.DT = set_combine(sets.midcast['Enhancing Magic'].DT, {})
    sets.midcast.Stoneskin.DT = set_combine(sets.midcast['Enhancing Magic'].DT, { neck = "Nodens Gorget", waist = "Siegel Sash" })
    sets.midcast.Aquaveil.DT = set_combine(sets.midcast['Enhancing Magic'].DT, { main = "Vadose Rod", head = "Chironic Hat" })
    sets.midcast.Auspice.DT = set_combine(sets.midcast['Enhancing Magic'].DT, { feet = "Ebers Duckbills +1" })

    sets.midcast.Impact = {}

    --Elemental based magic
    sets.midcast['Elemental Magic'] = {}
    sets.midcast['Elemental Magic'].Resistant = sets.midcast['Elemental Magic']

    --Light based magic
    sets.midcast['Divine Magic'] = {}
    sets.midcast.Holy = {}

    --Dark based magic
    sets.midcast['Dark Magic'] = {
        main = "Bunzi's Rod",
        sub = "Ammurapi Shield",
        ammo = "Pemphredo Tathlum",
        head = "Pixie Hairpin +1",
        body = gear.whm_body_idle,
        hands = gear.whm_hands_enfeebling,
        legs = "Inyanga Shalwar +2",
        feet = "Inyanga Crackows +2",
        neck = "Erra Pendant",
        waist = "Fucho-no-obi",
        left_ear = "Regal Earring",
        right_ear = "Malignance Earring",
        left_ring = "Evanescence Ring",
        right_ring = "Archon Ring",
        back = gear.jse_cure_back,
    }

    sets.midcast.Drain = sets.midcast['Dark Magic']
    sets.midcast.Drain.Resistant = sets.midcast.Drain
    sets.midcast.Aspir = sets.midcast.Drain
    sets.midcast.Aspir.Resistant = sets.midcast.Drain.Resistant

    sets.midcast['Enfeebling Magic'] = {
        main = "Daybreak",
        sub = "Ammurapi Shield",
        ammo = "Hydrocera",
        head = "C. Palug Crown",
        body = "Theo. Bliaut +3",
        hands = gear.whm_hands_enfeebling,
        --legs="Th. Pant. +3",
        legs = gear.chironic_enfeeble_legs,
        feet = "Theo. Duckbills +3",
        neck = "Erra Pendant",
        waist = "Obstin. Sash",
        left_ear = "Regal Earring",
        right_ear = "Malignance Earring",
        left_ring = "Metamorph Ring +1",
        right_ring = "Kishar Ring",
        back = gear.jse_cure_back,
    }

    sets.midcast['Enfeebling Magic'].Resistant = set_combine(sets.midcast['Enfeebling Magic'], { hands = gear.whm_hands_enfeebling_resist, right_ring = "Weather. Ring +1" })
    sets.midcast['Enfeebling Magic'].DT = set_combine(sets.midcast['Enfeebling Magic'], {}) --{back=gear.whm_dt_back,})

    sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
    sets.midcast.Diaga = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
    sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
    sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
    sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)

    sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'], {})
    sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

    sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})
    sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

    sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})
    sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

    sets.midcast.Stun = sets.midcast['Enfeebling Magic']
    sets.midcast.Stun.Resistant = sets.midcast.Stun

    sets.midcast.Impact = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {
        main = "Bunzi's Rod",
        head = empty,
        body = gear.impact_body,
    })

    sets.midcast.Impact.DT = set_combine(sets.midcast.Impact, {})

    --MEVA
    sets.midcast.Dia.DT = set_combine(sets.midcast['Enfeebling Magic'].DT, sets.TreasureHunter)
    sets.midcast.Diaga.DT = set_combine(sets.midcast['Enfeebling Magic'].DT, sets.TreasureHunter)
    sets.midcast['Dia II'].DT = set_combine(sets.midcast['Enfeebling Magic'].DT, sets.TreasureHunter)
    sets.midcast.Bio.DT = set_combine(sets.midcast['Enfeebling Magic'].DT, sets.TreasureHunter)
    sets.midcast['Bio II'].DT = set_combine(sets.midcast['Enfeebling Magic'].DT, sets.TreasureHunter)

    sets.midcast.ElementalEnfeeble.DT = set_combine(sets.midcast['Enfeebling Magic'].DT, {})
    sets.midcast.IntEnfeebles.DT = set_combine(sets.midcast['Enfeebling Magic'].DT, {})
    sets.midcast.MndEnfeebles.DT = set_combine(sets.midcast['Enfeebling Magic'].DT, {})
    sets.midcast.Stun.DT = sets.midcast['Enfeebling Magic'].DT


    -- Idle sets
    --
    -- Refresh: 9 MP
    -- DT/PDT : -31
    --
    sets.idle = {
        main = "Daybreak", -- 			/		/	1 MP
        sub = "Genmei Shield", --	10 PDT 	/		/
        ammo = "Homiliary",
        head = gear.whm_idle_head, --			/		/	1 MP
        body = gear.whm_body_idle, --			/		/	3 MP
        hands = gear.whm_idle_hands, --			/		/	0.5 MP
        legs = gear.whm_idle_legs, --			/		/	1 MP
        feet = gear.whm_idle_feet, --			/		/	0.5 MP
        neck = "Loricate Torque +1", --			/ 6 DT	/
        waist = "Porous Rope",
        left_ear = "Infused Earring",
        right_ear = "Etiolation Earring",
        left_ring = "Defending Ring", --			/ 10 DT	/
        right_ring = "Inyanga Ring", --			/		/	1 MP
        back = gear.jse_cure_back, --			/ 5 DT	/
    }

    -- Resting sets
    sets.resting = sets.idle

    sets.idle.Town = set_combine(sets.idle, {
        main = gear.whm_aoe_weapon,
        head = "Nyame Helm",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets",
    })

    -- Defense sets
    -- PDT/DT: 		-50
    -- Refresh:		7 MP

    sets.idle.DT = {
        main = "Daybreak", -- 			/		/	1 MP
        sub = "Genmei Shield", -- 10 PDT	/		/
        ammo = gear.whm_dt_ammo, -- 			/ 3 DT	/
        head = "Inyanga Tiara +2", --			/		/	1 MP
        body = gear.whm_body_idle, --			/		/	3 MP
        hands = gear.whm_dt_hands, --			/ 3 DT	/
        legs = "Inyanga Shalwar +2", --			/ 5 DT	/
        feet = "Inyanga Crackows +2", -- 			/ 3 DT	/
        neck = "Loricate Torque +1", -- 			/ 6 DT	/
        waist = "Porous Rope",
        left_ear = "Odnowa Earring +1",
        right_ear = "Etiolation Earring",
        left_ring = "Defending Ring", -- 			/ 10 DT	/
        right_ring = gear.whm_dt_ring, -- 			/		/
        back = gear.jse_cure_back, -- 			/ 5 DT	/
    }
    sets.idle.Weak = sets.idle.DT

    -- Defense sets

    sets.defense.PDT = {
        main = "Daybreak",
        sub = "Genmei Shield",
        ammo = gear.whm_dt_ammo,
        head = "Nyame Helm",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets",
        neck = "Loricate Torque +1",
        waist = "Porous Rope",
        left_ear = "Etiolation Earring",
        right_ear = "Odnowa Earring +1",
        left_ring = "Defending Ring",
        right_ring = "Gelatinous Ring +1",
        back = gear.whm_dt_back,
    }

    sets.defense.MDT = sets.defense.PDT
    sets.defense.MEVA = sets.defense.MDT

    -- Gear for specific elemental nukes.
    sets.element.Wind = {}
    sets.element.Ice = {}
    sets.element.Earth = {}

    -- Engaged sets

    sets.engaged = {
        ammo = "Crepuscular Pebble",
        head = "Nyame Helm",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets",
        neck = "Combatant's Torque",
        waist = "Grunfeld Rope",
        left_ear = "Telos Earring",
        right_ear = "Crep. Earring",
        left_ring = "Petrov Ring",
        right_ring = "Ilabrat Ring",
        back = gear.jse_cure_back,
    }

    sets.engaged.DW = set_combine(sets.engaged, {
        right_ear = "Suppanomimi",
    })

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Divine Caress'] = { main = gear.whm_aoe_weapon, hands = "Ebers Mitts +1" }
    sets.HPDown = {}
    sets.HPCure = {}
    sets.buff.Doom = set_combine(sets.buff.Doom, {})

end

function select_default_macro_book()
    set_macro_page(3, 6)
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
