function user_job_setup()
    state.OffenseMode:options('Normal')
    state.HybridMode:options('DT', 'Normal')
    state.RangedMode:options('Normal')
    state.WeaponskillMode:options('Normal')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal')
    state.PhysicalDefenseMode:options('PDT')
    state.MagicalDefenseMode:options('MDT')
    state.ResistDefenseMode:options('MEVA')
    state.AutoZergMode:reset()
    state.Weapons:options('Kikoku', 'Heishi', 'Naegling', 'Tauret',
        'ProcKatana', 'ProcScythe', 'ProcDagger', 'ProcGreatKatana', 'ProcSword',
        'ProcStaff', 'ProcClub', 'ProcGreatSword', 'ProcPolearm', 'None')
    state.ExtraMeleeMode = M { ['description'] = 'Extra Melee Mode', 'None' }
    silibs.enable_cancel_outranged_ws()
    silibs.enable_cancel_on_blocking_status()
    silibs.enable_weapon_rearm()
    silibs.enable_auto_lockstyle(3)
    silibs.enable_waltz_refiner()
    silibs.enable_premade_commands()
    silibs.enable_th()
    silibs.enable_ui()
    silibs.enable_equip_loop()
    silibs.enable_custom_roll_text()
    silibs.enable_haste_info()
    has_obi = true     -- Change if you do or don't have Hachirin-no-Obi
    has_orpheus = true -- Change if you do or don't have Orpheus's Sash
    silibs.enable_elemental_belt_handling(has_obi, has_orpheus)
    silibs.enable_snapshot_auto_equip()
 

    autows = 'Blade: Metsu'
    autows_list = {
        ['Tizbron'] = 'Expiacion',
        ['Tizalmace'] = 'Expiacion',
        ['Almace'] = 'Chant Du Cygne',
        ['MeleeClubs'] = 'Realmrazer',
        ['HybridWeapons'] = 'Sanguine Blade',
        ['Naegbron'] = 'Savage Blade',
        ['Naegmace'] = 'Savage Blade'
    }


    gear.jse_dex_back = { name = "Andartia's Mantle", augments = { 'DEX+20', 'Accuracy+20 Attack+20', 'Weapon skill damage +10%', 'DEX+10', 'Phys. dmg. taken-10%', } }
    gear.jse_da_back = { name = "Andartia's Mantle", augments = { 'DEX+20', 'Accuracy+20 Attack+20', '"Store TP"+10', 'Accuracy+10', 'Phys. dmg. taken-10%', } }
    gear.jse_str_back = { name = "Andartia's Mantle", augments = { 'STR+20', 'Accuracy+20 Attack+20', 'Weapon skill damage +10%', 'STR+10', 'Phys. dmg. taken-10%', } }




    send_command('bind ^` input /ja "Innin" <me>')
    send_command('bind !` input /ja "Yonin" <me>')
    send_command('bind @f7 gs c toggle autoshadowmode')
    send_command('bind @f8 gs c toggle AutoTankMode')
    send_command('bind @\\\\ gs c set toggle weapons Kikoku')

    utsusemi_cancel_delay = .3
    utsusemi_ni_cancel_delay = .06

    select_default_macro_book()
end

function init_gear_sets()
    if item_available("Hattori Earring +2") then
        gear.empy_earring = "Hattori Earring +2"
    elseif item_available("Hattori Earring +1") then
        gear.empy_earring = "Hattori Earring +1"
    elseif item_available("Hattori Earring") then
        gear.empy_earring = "Hattori Earring"
    else
        gear.empy_earring = "Crep. Earring"
    end

    if item_available("Hattori Kyahan +3") then
        gear.jse_empy_feet = "Hattori Kyahan +3"
    elseif item_available("Hattori Kyahan +2") then
        gear.jse_empy_feet = "Hattori Kyahan +2"
    else
        gear.jse_empy_feet = "Hattori Kyahan +1"
    end


    -- Weapons sets
    sets.weapons.Kikoku = { main = "Kikoku", sub = "Kunimitsu" }
    sets.weapons.Heishi = { main = "Heishi Shorinken", sub = "Kunimitsu" }
    sets.weapons.Naegling = { main = "Naegling", sub = "Kunimitsu" }
    sets.weapons.Tauret = { main = "Tauret", sub = "Kunimitsu" }

    -- Proc sets
    sets.weapons.ProcKatana = { main = "Trainee Burin", sub = "Qutrub Knife" }
    sets.weapons.ProcGreatKatana = { main = "Mutsunokami +1", sub = empty }
    sets.weapons.ProcDagger = { main = "Qutrub Knife", sub = "Trainee Burin" }
    sets.weapons.ProcSword = { main = "Nihility", sub = "Qutrub Knife" }
    sets.weapons.ProcClub = { main = "Kyuka Uchiwa +1", sub = "Qutrub Knife" }
    sets.weapons.ProcGreatSword = { main = "Lament", sub = empty }
    sets.weapons.ProcScythe = { main = "Lost Sickle", sub = empty }
    sets.weapons.ProcPolearm = { main = "Hotengeki", sub = empty }
    sets.weapons.ProcStaff = { main = "Sophistry", sub = empty }

    --------------------------------------
    -- Precast sets
    --------------------------------------

    sets.Enmity = {
        ammo = "Date Shuriken",
        head = { name = "Nyame Helm", augments = { 'Path: B', } },
        body = { name = "Nyame Mail", augments = { 'Path: B', } },
        hands = { name = "Nyame Gauntlets", augments = { 'Path: B', } },
        legs = { name = "Nyame Flanchard", augments = { 'Path: B', } },
        feet = { name = "Nyame Sollerets", augments = { 'Path: B', } },
        neck = { name = "Loricate Torque +1", augments = { 'Path: A', } },
        waist = gear.dt_waist,
        left_ear = "Friomisi Earring",
        right_ear = "Suppanomimi",
        left_ring = "Petrov Ring",
        right_ring = "Begrudging Ring",
        back = gear.jse_da_back,
    }

    -- Precast sets to enhance JAs
    sets.precast.JA['Mijin Gakure'] = {}
    sets.precast.JA['Futae'] = {}
    sets.precast.JA['Sange'] = { body = "Mochi. Chainmail +3" }
    sets.precast.JA['Provoke'] = sets.Enmity
    sets.precast.JA['Warcry'] = sets.Enmity

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}

    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Set for acc on steps, since Yonin drops acc a fair bit
    sets.precast.Step = {}
    sets.precast.Flourish1 = {}

    -- Fast cast sets for spells
    sets.precast.FC = {
        ammo = "Impatiens",
        head = { name = "Nyame Helm", augments = { 'Path: B', } },
        body = "Adhemar Jacket +1",
        hands = { name = "Nyame Gauntlets", augments = { 'Path: B', } },
        legs = { name = "Rawhide Trousers", augments = { 'MP+50', '"Fast Cast"+5', '"Refresh"+1', } },
        feet = { name = "Nyame Sollerets", augments = { 'Path: B', } },
        neck = "Baetyl Pendant",
        waist = gear.dt_waist,
        left_ear = "Loquac. Earring",
        right_ear = "Etiolation Earring",
        left_ring = gear.weather_ring,
        right_ring = "Medada's Ring",
        back = gear.jse_da_back,
    }

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC,
        { neck = "Magoraga Beads", body = "Mochi. Chainmail +3", feet = gear.jse_empy_feet })
    sets.precast.FC.Shadows = set_combine(sets.precast.FC.Utsusemi, {})

    -- Snapshot for ranged
    sets.precast.RA = {}

    -- Weaponskill sets

    sets.precast.WS = {
        ammo = "Oshasha's Treatise",
        head = "Mpaca's Cap",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets",
        neck = gear.nin_jse_neck,
        waist = "Sailfi Belt +1",
        left_ear = "Lugra Earring +1",
        right_ear = { name = "Moonshade Earring", augments = { 'Accuracy+4', 'TP Bonus +250', } },
        left_ring = "Regal Ring",
        right_ring = "Beithir Ring",
        back = gear.jse_str_back,
    }

    sets.precast.WS.Proc = {
        ammo = "Date Shuriken",
        head = "Rawhide Mask",
        body = "Adhemar Jacket +1",
        hands = "Adhemar Wrist. +1",
        legs = "Rawhide Trousers",
        feet = "Hachi. Kyahan +1",
        neck = "Combatant's Torque",
        waist = "Gishdubar Sash",
        left_ear = "Infused Earring",
        right_ear = "Telos Earring",
        left_ring = "Defending Ring",
        right_ring = "Gelatinous Ring +1",
        back = gear.dt_moon_back,
    }

    sets.precast.WS['Freezebite'] = set_combine(sets.precast.WS.Proc, {})
    sets.precast.WS['Raiden Thrust'] = set_combine(sets.precast.WS.Proc, {})
    sets.precast.WS['Energy Drain'] = set_combine(sets.precast.WS.Proc, {})
    sets.precast.WS['Cyclone'] = set_combine(sets.precast.WS.Proc, {})
    sets.precast.WS['Tachi: Koki'] = set_combine(sets.precast.WS.Proc, {})
    sets.precast.WS['Tachi: Jinpu'] = set_combine(sets.precast.WS.Proc, {})
    sets.precast.WS['Seraph Blade'] = set_combine(sets.precast.WS.Proc, {})
    sets.precast.WS['Red Lotus Blade'] = set_combine(sets.precast.WS.Proc, {})
    sets.precast.WS['Shadow of Death'] = set_combine(sets.precast.WS.Proc, {})
    sets.precast.WS['Blade: Ei'] = set_combine(sets.precast.WS.Proc, {})
    sets.precast.WS['Seraph Strike'] = set_combine(sets.precast.WS.Proc, {})
    sets.precast.WS['Sunburst'] = set_combine(sets.precast.WS.Proc, {})
    sets.precast.WS['Earth Crusher'] = set_combine(sets.precast.WS.Proc, {})

    sets.precast.WS['Blade: Metsu'] = set_combine(sets.precast.WS, { waist = "Fotia Belt", back = gear.jse_dex_back, })
    sets.precast.WS['Blade: Shun'] = set_combine(sets.precast.WS, { waist = "Fotia Belt", back = gear.jse_dex_back, })
    sets.precast.WS['Blade: Ten'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {})

    sets.precast.WS['Blade: Chi'] = {
        ammo = "Oshasha's Treatise",
        head = "Nyame Helm",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets",
        neck = gear.nin_jse_neck,
        waist = "Sailfi Belt +1",
        left_ear = "Lugra Earring +1",
        right_ear = "Moonshade Earring",
        left_ring = { name = "Medada's Ring", priority = 250 },
        right_ring = { name = "Beithir Ring", priority = 500 },
        back = gear.jse_str_back,
    }
    sets.precast.WS['Blade: To'] = set_combine(sets.precast.WS['Blade: Chi'], {})

    -- Swap to these on Moonshade using WS if at 3000 TP
    sets.MaxTP = { head = "Nyame Helm", ear1 = "Lugra Earring +1", ear2 = "Crep. Earring" }
    sets.AccMaxTP = { head = "Nyame Helm", ear1 = "Lugra Earring +1", ear2 = "Crep. Earring" }
    sets.AccDayMaxTPWSEars = { ear1 = "Lugra Earring +1", ear2 = "Crep. Earring" }
    sets.DayMaxTPWSEars = { ear1 = "Lugra Earring +1", ear2 = "Crep. Earring" }
    sets.AccDayWSEars = { ear1 = "Lugra Earring +1", ear2 = "Moonshade Earring" }
    sets.DayWSEars = { ear1 = "Lugra Earring +1", ear2 = "Moonshade Earring" }

    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.ElementalNinjutsu = {
        ammo = "Pemphredo Tathlum",
        head = { name = "Nyame Helm", augments = { 'Path: B', } },
        body = { name = "Nyame Mail", augments = { 'Path: B', } },
        hands = { name = "Nyame Gauntlets", augments = { 'Path: B', } },
        legs = { name = "Nyame Flanchard", augments = { 'Path: B', } },
        feet = { name = "Nyame Sollerets", augments = { 'Path: B', } },
        neck = "Baetyl Pendant",
        waist = "Eschan Stone",
        left_ear = "Friomisi Earring",
        right_ear = "Crep. Earring",
        left_ring = { name = "Metamor. Ring +1", augments = { 'Path: A', } },
        right_ring = "Medada's Ring",
        --back="",
    }

    sets.midcast.ElementalNinjutsu.Resistant = set_combine(sets.midcast.ElementalNinjutsu, {})

    sets.midcast.NinjutsuDebuff = {
        ammo = "Yamarang",
        head = "Malignance Chapeau",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        legs = "Malignance Tights",
        feet = "Malignance Boots",
        neck = "Incanter's Torque",
        waist = "Eschan Stone",
        left_ear = "Digni. Earring",
        right_ear = "Crep. Earring",
        left_ring = { name = "Metamor. Ring +1", augments = { 'Path: A', } },
        right_ring = "Medada's Ring",
        --back
    }

    sets.midcast.NinjutsuBuff = set_combine(sets.midcast.FastRecast, {})
    sets.midcast.Utsusemi = set_combine(sets.midcast.NinjutsuBuff, { back = "Andartia's Mantle", }) --feet="Hattori Kyahan +1"

    sets.midcast.RA = {
        head = "Malignance Chapeau",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        legs = "Malignance Tights",
        feet = "Malignance Boots",
        neck = gear.nin_jse_neck,
        waist = "Yemaya Belt",
        left_ear = "Telos Earring",
        right_ear = "Crep. Earring",
        left_ring = "Dingir Ring",
        right_ring = "Crepuscular Ring",
        back = gear.jse_da_back,
    }

    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------

    sets.idle = {
        ammo = "Date Shuriken",
        head = "Malignance Chapeau",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        legs = "Malignance Tights",
        feet = "Malignance Boots",
        neck = "Sanctity Necklace",
        waist = gear.dt_waist,
        left_ear = "Infused Earring",
        right_ear = "Etiolation Earring",
        left_ring = "Defending Ring",
        right_ring = "Gelatinous Ring +1",
        back = gear.jse_da_back,
    }

    sets.idle.Town = {
        ammo = "Date Shuriken",
        head = "Nyame Helm",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets",
        neck = gear.nin_jse_neck,
        waist = "Windbuffet Belt +1",
        left_ear = "Telos Earring",
        right_ear = "Crep. Earring",
        left_ring = { name = "Petrov Ring", priority = 500 },
        right_ring = { name = "Gere Ring", priority = 250 },
        back = gear.jse_da_back,
    }

    sets.defense.PDT = {
        ammo = gear.dt_ammo,
        head = "Nyame Helm",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets",
        neck = "Loricate Torque +1",
        waist = gear.dt_waist,
        left_ear = "Odnowa Earring +1",
        right_ear = "Etiolation Earring",
        left_ring = "Defending Ring",
        right_ring = "Gelatinous Ring +1",
        back = gear.dt_moon_back,
    }

    sets.defense.MDT = sets.defense.PDT
    sets.defense.MEVA = sets.defense.PDT


    sets.resting = sets.idle
    sets.idle.Weak = sets.defense.PDT

    sets.Kiting = { feet = "Danzo Sune-Ate" }
    sets.DuskKiting = { feet = "Hachi. Kyahan +1" }
    sets.DuskIdle = {}
    sets.DayIdle = {}
    sets.NightIdle = {}


    --------------------------------------
    -- Engaged sets
    --------------------------------------

    sets.engaged = {
        ammo = "Date Shuriken",
        head = "Malignance Chapeau",
        body = "Mpaca's Doublet",
        hands = "Malignance Gloves",
        legs = "Mpaca's Hose",
        feet = "Malignance Boots",
        neck = gear.nin_jse_neck,
        waist = "Windbuffet Belt +1",
        left_ear = "Telos Earring",
        right_ear = gear.empy_earring,
        left_ring = { name = "Chirich Ring +1", priority = 500 },
        right_ring = { name = "Gere Ring", priority = 250 },
        back = gear.jse_da_back,
    }

    sets.engaged.DT = {
        ammo = "Date Shuriken",
        head = "Malignance Chapeau",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        legs = "Malignance Tights",
        feet = "Malignance Boots",
        neck = gear.nin_jse_neck,
        waist = "Windbuffet Belt +1",
        left_ear = "Telos Earring",
        right_ear = gear.empy_earring,
        left_ring = { name = "Defending Ring", priority = 500 },
        right_ring = { name = "Gere Ring", priority = 250 },
        back = gear.jse_da_back,
    }

    sets.engaged.Proc = set_combine(sets.engaged.DT, { ammo = gear.dt_ammo, })

    --------------------------------------
    -- Custom buff sets
    --------------------------------------

    sets.buff.Migawari = {} --body="Hattori Ningi +1"
    sets.buff.Doom = set_combine(sets.buff.Doom, {})
    sets.buff.Yonin = {}    --legs="Hattori Hakama +1"
    sets.buff.Innin = {}    --head="Hattori Zukin +1"

    -- Extra Melee sets.  Apply these on top of melee sets.
    sets.Knockback = {}
    sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
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
