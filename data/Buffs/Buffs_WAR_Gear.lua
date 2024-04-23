function user_job_setup()
    state.OffenseMode:options('Normal')
    state.WeaponskillMode:options('Normal', 'Enmity', 'SubtleBlow')
    state.HybridMode:options('DT', 'Normal', 'SubtleBlow', 'Enmity')
    state.PhysicalDefenseMode:options('PDT')
    state.MagicalDefenseMode:options('MDT')
    state.ResistDefenseMode:options('MEVA')
    state.IdleMode:options('Normal', 'Reraise')
    state.ExtraMeleeMode = M { ['description'] = 'Extra Melee Mode', 'None' }
    state.Passive = M { ['description'] = 'Passive Mode', 'None' }
    state.AutoTomahawkMode = M(false, 'AutoTomahawkMode')
    state.AutoTPReductionMode = M(false, 'Auto TP Reduction Mode')
    state.AutoZergMode:reset()
    state.AutoJumpMode = M(false, 'Auto Jump Mode')
    state.Weapons:options('Chango', 'ShiningOne', 'Nandaka', 'Drepanum', 'Kinship', 'Laphria', 'Helheim', 'Dolichenus',
        'Naegling', 'Loxotic',
        'ProcKatana', 'ProcScythe', 'ProcDagger', 'ProcGreatKatana', 'ProcSword', 'ProcStaff', 'ProcClub',
        'ProcGreatSword', 'ProcPolearm', 'None')
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
    has_obi = true         -- Change if you do or don't have Hachirin-no-Obi
    has_orpheus = true     -- Change if you do or don't have Orpheus's Sash
    silibs.enable_elemental_belt_handling(has_obi, has_orpheus)
    silibs.enable_snapshot_auto_equip()
   

    autows = "Upheaval"
    autows_list = {
        ["Chango"] = "Upheaval",
        ["ShiningOne"] = "Impulse Drive",
        ["Montante"] = "Resolution",
        ["Naegling"] = "Savage Blade",
        ["Loxotic"] = "Judgment",
        ["Kinship"] = "Fell Cleave",
    }

    gear.jse_str_back = { name = "Cichol's Mantle", augments = { 'STR+20', 'Accuracy+20 Attack+20', 'Weapon skill damage +10%', } }
    gear.jse_da_back = { name = "Cichol's Mantle", augments = { 'DEX+20', 'Accuracy+20 Attack+20', '"Dbl.Atk."+10', } }
    gear.jse_vit_back = { name = "Cichol's Mantle", augments = { 'DEX+20', 'Accuracy+20 Attack+20', '"Dbl.Atk."+10', } }


    send_command('bind !` input /ja "Hasso" <me>')
    send_command('bind ^` input /ja "Seigan" <me>')
    send_command('bind @f7 gs c toggle AutoTPReductionMode')
    send_command('bind ^backspace input /ja "Third Eye" <me>')
    send_command('bind !@^` gs c cycle Stance')
    send_command('bind @\\\\ gs c set toggle weapons Chango')
    send_command('bind @f6 gs c toggle AutoZergMode')
    if player.sub_job == "DRG" then
        send_command('bind @f8 gs c toggle AutoJumpMode')
    else
        send_command('unbind @f8')
    end
    select_default_macro_book()
end

function init_gear_sets()
    if item_available("Chango") then
        gear.war_greataxe = "Chango"
    elseif item_available("Lycurgos") then
        gear.war_greataxe = "Lycurgos"
    end

    if item_available("Boii Earring +2") then
        gear.empy_earring = "Boii Earring +2"
    elseif item_available("Boii Earring +1") then
        gear.empy_earring = "Boii Earring +1"
    elseif item_available("Boii Earring") then
        gear.empy_earring = "Boii Earring"
    else
        gear.empy_earring = "Cessance Earring"
    end

    autows_list = {
        ['Chango'] = 'Upheaval',
        ['Nandaka'] = 'Resolution',
        ['ShiningOne'] = 'Impulse Drive',
        ['Drepanum'] =
        'Spiral Hell',
        ['Laphria'] = 'Disaster',
        ['Helheim'] = 'Fimbulvetr',
        ['Loxotic'] = 'Judgment',
        ['Dolichenus'] =
        'Decimation',
        ['Naegling'] = 'Savage Blade'
    }

    -- Precast Sets
    sets.Enmity = {}
    sets.Knockback = {}

    sets.weapons.Chango = { main = gear.war_greataxe, sub = "Utu Grip" }
    sets.weapons.Nandaka = { main = "Nandaka", sub = "Utu Grip" }
    sets.weapons.ShiningOne = { main = "Shining One", sub = "Utu Grip" }
    sets.weapons.Drepanum = { main = "Drepanum", sub = "Utu Grip" }
    sets.weapons.Laphria = { main = "Laphria", sub = "Utu Grip" }
    sets.weapons.Helheim = { main = "Helheim", sub = "Utu Grip" }
    sets.weapons.Dolichenus = { main = "Dolichenus", sub = "Blurred Shield +1" }
    sets.weapons.Naegling = { main = "Naegling", sub = "Blurred Shield +1" }
    sets.weapons.Loxotic = { main = "Loxotic Mace +1", sub = "Blurred Shield +1" }

    -- Proc sets
    sets.weapons.ProcKatana = { main = "Trainee Burin", sub = "Qutrub Knife" }
    sets.weapons.ProcGreatKatana = { main = "Mutsunokami +1", sub = "Utu Grip" }
    sets.weapons.ProcDagger = { main = "Qutrub Knife", sub = "Trainee Burin" }
    sets.weapons.ProcSword = { main = "Nihility", sub = "Qutrub Knife" }
    sets.weapons.ProcClub = { main = "Burrower's Wand", sub = "Qutrub Knife" }
    sets.weapons.ProcGreatSword = { main = "Lament", sub = "Utu Grip" }
    sets.weapons.ProcScythe = { main = "Lost Sickle", sub = "Utu Grip" }
    sets.weapons.ProcPolearm = { main = "Tzee Xicu's Blade", sub = "Utu Grip" }
    sets.weapons.ProcStaff = { main = "Sophistry", sub = "Utu Grip" }

    -- Precast sets to enhance JAs
    sets.precast.JA['Berserk'] = { back = "Cichol's Mantle", body = "Pummeler's Lorica +3", feet = "Agoge Calligae +3" }
    sets.precast.JA['Aggressor'] = { head = "Pumm. Mask +1", body = "Agoge Lorica +3" }
    sets.precast.JA['Warcry'] = { head = "Agoge Mask +3" }
    sets.precast.JA['Defender'] = {}
    sets.precast.JA['Mighty Strikes'] = {}
    sets.precast.JA["Warrior's Charge"] = {}
    sets.precast.JA['Tomahawk'] = { ammo = "Thr. Tomahawk", feet = "Agoge Calligae +3" }
    sets.precast.JA['Retaliation'] = {}
    sets.precast.JA['Restraint'] = {}
    sets.precast.JA['Blood Rage'] = {}
    sets.precast.JA['Brazen Rush'] = {}
    sets.precast.JA['Provoke'] = set_combine(sets.Enmity, {})

    sets.precast.Waltz = {}
    sets.precast.Waltz['Healing Waltz'] = {}
    sets.precast.Step = {}
    sets.precast.Flourish1 = {}

    -- Fast cast sets for spells
    sets.precast.FC = {}
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {})

    -- Weaponskill sets
    sets.precast.WS = {
        ammo = "Knobkierrie",
        head = "Nyame Helm",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets",
        neck = gear.war_jse_neck,
        waist = { name = "Sailfi Belt +1", augments = { 'Path: A', } },
        left_ear = "Thrud Earring",
        right_ear = { name = "Moonshade Earring", augments = { 'Accuracy+4', 'TP Bonus +250', } },
        left_ring = "Regal Ring",
        right_ring = "Beithir Ring",
        back = gear.jse_str_back,
    }

    sets.precast.WS.Enmity = set_combine(sets.precast.WS, { left_ear = "Schere Earring", })

    -- 31 SB
    sets.precast.WS.SubtleBlow = set_combine(sets.precast.WS, {
        --hands="Sakpata's Gauntlets",
        feet = "Sakpata's Leggings",
        left_ear = "Digni. Earring",
        right_ring = "Niqmaddu Ring",
    })

    sets.precast.WS.KI = set_combine(sets.precast.WS, { body = "Found. Breastplate" })
    sets.precast.WS.KI.SubtleBlow = set_combine(sets.precast.WS.SubtleBlow, { body = "Found. Breastplate" })

    sets.precast.WS.Proc = {
        ammo = "Staunch Tathlum +1",
        head = "Agoge Mask +3",
        body = "Dagon Breast.",
        hands = "Leyline Gloves",
        legs = "Sakpata's Cuisses",
        feet = "Agoge Calligae +3",
        neck = "Combatant's Torque",
        waist = "Gishdubar Sash",
        left_ear = "Infused Earring",
        right_ear = "Telos Earring",
        left_ring = "Defending Ring",
        right_ring = "Gelatinous Ring +1",
        back = gear.dt_moon_back,
    }

    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Savage Blade'].SubtleBlow = set_combine(sets.precast.WS.SubtleBlow, {})
    sets.precast.WS['Savage Blade'].KI = set_combine(sets.precast.WS.KI, {})
    sets.precast.WS['Savage Blade'].KI.SubtleBlow = set_combine(sets.precast.WS.KI.SubtleBlow, {})
    sets.precast.WS['Savage Blade'].Enmity = set_combine(sets.precast.WS.Enmity, {})

    sets.precast.WS['Impulse Drive'] = set_combine(sets.precast.WS, { body = "Dagon Breast." })
    sets.precast.WS['Impulse Drive'].SubtleBlow = set_combine(sets.precast.WS.SubtleBlow, { body = "Dagon Breast." })
    sets.precast.WS['Impulse Drive'].KI = set_combine(sets.precast.WS.KI, {})
    sets.precast.WS['Impulse Drive'].KI.SubtleBlow = set_combine(sets.precast.WS.KI.SubtleBlow, {})
    sets.precast.WS['Impulse Drive'].Enmity = set_combine(sets.precast.WS.Enmity, {})

    sets.precast.WS['Upheaval'] = set_combine(sets.precast.WS, {
        waist = "Fotia Belt",
        back = gear.jse_vit_back,
    })

    sets.precast.WS['Upheaval'].Enmity = set_combine(sets.precast.WS['Upheaval'], { left_ear = "Schere Earring", })

    sets.precast.WS['Judgment'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Judgment'].KI = set_combine(sets.precast.WS.KI, {})
    sets.precast.WS['Judgment'].Enmity = set_combine(sets.precast.WS.Enmity, {})

    -- Proc WS
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

    sets.precast.RA = {
        waist = "Yemaya Belt",
        left_ring = "Crepuscular Ring", -- 3
    }

    -- Swap to these on Moonshade using WS if at 3000 TP
    sets.MaxTP = { ear1 = "Thrud Earring", ear2 = "Lugra Earring +1", }
    sets.AccMaxTP = { ear1 = "Thrud Earring", ear2 = "Lugra Earring +1", }
    sets.AccDayMaxTPWSEars = { ear1 = "Thrud Earring", ear2 = "Lugra Earring +1" }
    sets.DayMaxTPWSEars = { ear1 = "Thrud Earring", ear2 = "Lugra Earring +1", }
    sets.AccDayWSEars = { ear1 = "Lugra Earring +1", ear2 = "Moonshade Earring" }
    sets.DayWSEars = { ear1 = "Lugra Earring +1", ear2 = "Moonshade Earring", }

    --Specialty WS set overwrites.
    sets.AccWSMightyCharge = {}
    sets.AccWSCharge = {}
    sets.AccWSMightyCharge = {}
    sets.WSMightyCharge = {}
    sets.WSCharge = {}
    sets.WSMighty = {}

    -- Midcast sets
    sets.midcast.FastRecast = sets.precast.FC
    sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {})
    sets.midcast.Cure = {}
    sets.midcast.RA = {}

    sets.Self_Healing = { waist = "Gishdubar Sash" }
    sets.Cure_Received = { waist = "Gishdubar Sash" }

    -- Ranged gear
    sets.midcast.RA = {
        head = "Nyame Helm",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets",
        neck = "Combatant's Torque",
        waist = "Yemaya Belt",
        left_ear = "Telos Earring",
        right_ear = "Crep. Earring",
        left_ring = "Regal Ring",
        right_ring = "Ilabrat Ring",
        back = gear.jse_str_back,
    }

    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------


    -- Idle sets
    sets.idle = {
        ammo = "Staunch Tathlum +1",
        head = "Sakpata's Helm",
        body = "Crepuscular Mail",
        hands = "Sakpata's Gauntlets",
        legs = "Sakpata's Cuisses",
        feet = "Sakpata's Leggings",
        neck = "Loricate Torque +1",
        waist = "Flume Belt +1",
        left_ear = "Infused Earring",
        right_ear = "Etiolation Earring",
        left_ring = "Defending Ring",
        right_ring = "Gelatinous Ring +1",
        back = gear.jse_da_back,
    }

    sets.resting = sets.idle
    sets.idle.Weak = set_combine(sets.idle, {})
    sets.idle.Reraise = set_combine(sets.idle, {})

    sets.defense.PDT = {
        ammo = "Staunch Tathlum +1",
        head = "Nyame Helm",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets",
        neck = "Loricate Torque +1",
        waist = "Flume Belt +1",
        left_ear = "Odnowa Earring +1",
        right_ear = "Etiolation Earring",
        left_ring = "Defending Ring",
        right_ring = "Gelatinous Ring +1",
        back = gear.dt_moon_back,
    }

    sets.defense.MDT = sets.defense.PDT
    sets.defense.MEVA = sets.defense.PDT

    sets.Kiting = { feet = "Hermes' Sandals" }
    sets.Reraise = {}
    sets.buff.Doom = set_combine(sets.buff.Doom, {})
    sets.buff.Retaliation = {}
    sets.buff.Restraint = {}
    sets.TreasureHunter = set_combine(sets.TreasureHunter, {})

    --------------------------------------
    -- Engaged sets
    --------------------------------------

    sets.engaged = {
        ammo = "Coiste Bodhar",
        head = "Hjarrandi Helm",
        body = "Sakpata's Plate",
        hands = "Sakpata's Gauntlets",
        legs = "Sakpata's Cuisses",
        feet = "Sakpata's Leggings",
        neck = gear.war_jse_neck,
        waist = "Ioskeha Belt +1",
        left_ear = "Telos Earring",
        right_ear = gear.empy_earring,
        left_ring = "Chirich Ring +1",
        right_ring = "Niqmaddu Ring",
        back = gear.jse_da_back,
    }

    sets.engaged.DT = {
        ammo = "Coiste Bodhar",
        head = "Sakpata's Helm",
        body = "Sakpata's Plate",
        hands = "Sakpata's Gauntlets",
        legs = "Sakpata's Cuisses",
        feet = "Sakpata's Leggings",
        neck = gear.war_jse_neck,
        waist = "Ioskeha Belt +1",
        left_ear = "Telos Earring",
        right_ear = gear.empy_earring,
        left_ring = "Chirich Ring +1",
        right_ring = "Niqmaddu Ring",
        back = gear.jse_da_back,
    }

    sets.engaged.SubtleBlow = {
        ammo = "Staunch Tathlum +1",
        head = "Sakpata's Helm",
        body = "Dagon Breast.",                                              -- 10 II
        hands = { name = "Sakpata's Gauntlets", augments = { 'Path: A', } }, -- 8
        legs = "Sakpata's Cuisses",
        feet = "Sakpata's Leggings",                                         -- 13
        neck = gear.war_jse_neck,
        waist = "Sarissapho. Belt",                                          -- 5
        left_ear = "Schere Earring",                                         -- 3
        right_ear = "Digni. Earring",                                        -- 5
        left_ring = "Chirich Ring +1",                                       -- 10
        right_ring = "Niqmaddu Ring",                                        -- 5 II
        back = gear.jse_da_back,
    }

    sets.engaged.SubtleBlow.Auspice = set_combine(sets.engaged.SubtleBlow, {
        waist = "Ioskeha Belt +1",
        left_ear = "Telos Earring",
        right_ear = "Cessance Earring",
    })

    sets.engaged.Enmity = set_combine(sets.engaged.DT, { right_ear = "Schere Earring" })
    sets.engaged.Proc = set_combine(sets.engaged.DT, { neck = "Combatant's Torque" })
    sets.idle.Town = sets.engaged.DT
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
