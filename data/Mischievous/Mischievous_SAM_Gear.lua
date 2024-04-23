function user_job_setup()
    state.OffenseMode:options('Normal')
    state.HybridMode:options('DT', 'Normal', 'SubtleBlow')
    state.WeaponskillMode:options('Normal', 'Enmity', 'SubtleBlow')
    state.RangedMode:options('Normal')
    state.PhysicalDefenseMode:options('PDT')
    state.MagicalDefenseMode:options('MDT')
    state.ResistDefenseMode:options('MEVA')
    state.IdleMode:options('Normal')
    state.Weapons:options('Masamune', 'Dojikiri', 'ShiningOne', 'MaficCudgel', 'Yoichinoyumi', 'Norifusa', 'None')
    state.AutoJumpMode = M(false, 'Auto Jump Mode')
    state.AutoZergMode:reset()
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
    

    autofood = 'Grape Daifuku'
    autows = "Tachi: Fudo"
    autows_list = {
        ['Aeneas'] = "Rudra's Storm",
        ['Aeolian'] = 'Aeolian Edge',
        ['Savage'] = 'Savage Blade',
        ['Throwing'] = "Rudra's Storm",
        ['SwordThrowing'] = 'Savage Blade',
        ['Evisceration'] = 'Evisceration',
        ['ProcWeapons'] = 'Wasp Sting',
        ['Bow'] = 'Empyreal Arrow'
    }

    gear.ws_jse_back = { name = "Smertrios's Mantle", augments = { 'STR+20', 'Accuracy+20 Attack+20', 'Weapon skill damage +10%', 'STR+5', } }
    gear.da_jse_back = { name = "Smertrios's Mantle", augments = { 'DEX+20', 'Accuracy+20 Attack+20', '"Dbl.Atk."+10', 'Accuracy+10', } }

    -- Additional local binds
    send_command('bind !` input /ja "Hasso" <me>')
    send_command('bind ^` input /ja "Seigan" <me>')
    send_command('bind ^backspace input /ja "Third Eye" <me>')
    send_command('bind !@^` gs c cycle Stance')
    send_command('bind ^\\\\ input /ja "Provoke" <t>')

    if player.sub_job == "DRG" then
        send_command('bind @f8 gs c toggle AutoJumpMode')
    else
        send_command('unbind @f8')
    end

    select_default_macro_book()
end

function init_gear_sets()
    if item_available("Kasuga Earring +2") then
        gear.empy_earring = "Kasuga Earring +2"
        gear.empy_wsd_earring = "Kasuga Earring +2"
    elseif item_available("Kasuga Earring +1") then
        gear.empy_earring = "Kasuga Earring +1"
        gear.empy_wsd_earring = "Kasuga Earring +1"
    elseif item_available("Kasuga Earring") then
        gear.empy_earring = "Kasuga Earring"
        gear.empy_wsd_earring = "Thrud Earring"
    else
        gear.empy_earring = "Crep. Earring"
        gear.empy_wsd_earring = "Thrud Earring"
    end

    if item_available("Sacro Breastplate") then
        gear.idle_body = "Sacro Breastplate"
    else
        gear.idle_body = "Nyame Mail"
    end

    if item_available("Kasuga Kabuto +3") then
        gear.jse_empy_head = "Kasuga Kabuto +3"
    elseif item_available("Kasuga Kabuto +2") then
        gear.jse_empy_head = "Kasuga Kabuto +2"
    else
        gear.jse_empy_head = "Kasuga Kabuto +1"
    end

    if item_available("Kasuga Domaru +3") then
        gear.jse_empy_body = "Kasuga Domaru +3"
    elseif item_available("Kasuga Domaru +2") then
        gear.jse_empy_body = "Kasuga Domaru +2"
    else
        gear.jse_empy_body = "Kasuga Domaru +1"
    end

    if item_available("Kasuga Haidate +3") then
        gear.jse_empy_legs = "Kasuga Haidate +3"
    elseif item_available("Kasuga Haidate +2") then
        gear.jse_empy_legs = "Kasuga Haidate +2"
    else
        gear.jse_empy_legs = "Kasuga Haidate +1"
    end

    -- Weapons sets
    sets.weapons.Masamune = { main = "Masamune", sub = "Utu Grip" }
    sets.weapons.Dojikiri = { main = "Dojikiri Yasutsuna", sub = "Utu Grip" }
    sets.weapons.ShiningOne = { main = "Shining One", sub = "Utu Grip" }
    sets.weapons.Norifusa = { main = "Norifusa +1", sub == "Utu Grip" }
    sets.weapons.MaficCudgel = { main = "Mafic Cudgel", sub = empty }
    sets.weapons.Yoichinoyumi = { main = "Kustawi +1", sub = empty, range = "Yoichinoyumi", ammo = "Yoichi's Arrow" }

    -- Precast Sets
    sets.precast.JA.Meditate = { head = "Wakido Kabuto +3", hands = "Sakonji Kote +3", back = gear.da_jse_back }
    sets.precast.JA['Warding Circle'] = { head = "Wakido Kabuto +3" }
    sets.precast.JA['Blade Bash'] = { hands = "Sakonji Kote +3" }
    sets.precast.JA['Sekkanoki'] = {} --{hands="Kasuga Kote +1"}
    sets.precast.JA['Sengikori'] = {} --{feet="Kas. Sune-Ate +1"}

    -- Fast cast sets for spells
    sets.precast.FC = {
        ammo = "Sapience Orb",
        head = "Nyame Helm",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets",
        neck = "Baetyl Pendant",
        waist = gear.dt_waist,
        left_ear = "Loquac. Earring",
        right_ear = "Etiolation Earring",
        left_ring = "Defending Ring",
        right_ring = "Medada's Ring",
        back = gear.da_jse_back,
    }

    -- Ranged snapshot gear
    sets.precast.RA = {}

    sets.precast.Jump = {
        ammo = "Coiste Bodhar",
        head = "Mpaca's Cap",
        body = gear.jse_empy_body,
        hands = "Nyame Gauntlets",
        legs = gear.jse_empy_legs,
        feet = "Nyame Sollerets",
        neck = "Sam. Nodowa +2",
        waist = "Sailfi Belt +1",
        left_ear = { name = "Moonshade Earring", augments = { 'Accuracy+4', 'TP Bonus +250', } },
        right_ear = gear.empy_earring, -- 3
        left_ring = "Regal Ring",
        right_ring = "Niqmaddu Ring",
        back = gear.da_jse_back,
    }

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    -- 51%
    sets.precast.WS = {
        ammo = "Knobkierrie",     -- 6
        head = "Mpaca's Cap",
        body = "Sakonji Domaru +3", -- 10
        hands = "Nyame Gauntlets",
        legs = "Wakido Haidate +3", -- 10
        feet = "Nyame Sollerets",
        neck = "Sam. Nodowa +2",
        waist = "Sailfi Belt +1",
        left_ear = { name = "Moonshade Earring", augments = { 'Accuracy+4', 'TP Bonus +250', } },
        right_ear = gear.empy_wsd_earring, -- 3
        left_ring = "Regal Ring",
        right_ring = "Rufescent Ring",
        back = gear.ws_jse_back, -- 10
    }
    sets.precast.WS.Enmity = set_combine(sets.precast.WS, { left_ear = "Schere Earring" })
    sets.precast.WS.SubtleBlow = set_combine(sets.precast.WS, {
        right_ring = "Niqmaddu Ring",
    })
    sets.precast.WS.KI = set_combine(sets.precast.WS, { body = "Found. Breastplate" })
    sets.precast.WS.KI.SubtleBlow = set_combine(sets.precast.WS.SubtleBlow, { body = "Found. Breastplate" })

    sets.precast.WS['Tachi: Fudo'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Tachi: Fudo'].Enmity = set_combine(sets.precast.WS, { left_ear = "Schere Earring" })
    sets.precast.WS['Tachi: Fudo'].KI = set_combine(sets.precast.WS.KI, {})
    sets.precast.WS['Tachi: Fudo'].KI.SubtleBlow = set_combine(sets.precast.WS.KI.SubtleBlow, {})

    sets.precast.WS['Tachi: Shoha'] = {
        ammo = "Knobkierrie",
        head = "Mpaca's Cap",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets",
        neck = "Sam. Nodowa +2",
        waist = "Fotia Belt",
        left_ear = { name = "Moonshade Earring", augments = { 'Accuracy+4', 'TP Bonus +250', } },
        right_ear = gear.empy_wsd_earring, -- 3
        left_ring = "Regal Ring",
        right_ring = "Niqmaddu Ring",
        back = gear.ws_jse_back,
    }

    sets.precast.WS['Tachi: Shoha'].Enmity = set_combine(sets.precast.WS['Tachi: Shoha'], { left_ear = "Schere Earring" })

    sets.precast.WS['Tachi: Rana'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Tachi: Rana'].Enmity = set_combine(sets.precast.WS['Tachi: Rana'], { left_ear = "Schere Earring" })

    sets.precast.WS['Tachi: Kasha'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Tachi: Kasha'].Enmity = set_combine(sets.precast.WS['Tachi: Kasha'], { left_ear = "Schere Earring" })

    sets.precast.WS['Tachi: Jinpu'] = {
        ammo = "Knobkierrie",
        head = "Mpaca's Cap",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets",
        neck = "Sam. Nodowa +2",
        waist = "Fotia Belt",
        left_ear = "Lugra Earring +1",
        right_ear = { name = "Moonshade Earring", augments = { 'Accuracy+4', 'TP Bonus +250', } },
        left_ring = "Regal Ring",
        right_ring = "Niqmaddu Ring",
        back = gear.ws_jse_back,
    }
    sets.precast.WS['Tachi: Jinpu'].Enmity = set_combine(sets.precast.WS['Tachi: Jinpu'], { left_ear = "Schere Earring" })
    sets.precast.WS['Tachi: Jinpu'].SubtleBlow = set_combine(sets.precast.WS['Tachi: Jinpu'], {})
    sets.precast.WS['Tachi: Jinpu'].KI = set_combine(sets.precast.WS['Tachi: Jinpu'], { body = "Found. Breastplate" })
    sets.precast.WS['Tachi: Jinpu'].KI.SubtleBlow = set_combine(sets.precast.WS['Tachi: Jinpu'].KI, {})

    --Magical WS
    sets.precast.WS['Tachi: Kagero'] = {
        ammo = "Knobkierrie",
        head = "Mpaca's Cap",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets",
        neck = "Sam. Nodowa +2",
        waist = "Fotia Belt",
        left_ear = "Lugra Earring +1",
        right_ear = { name = "Moonshade Earring", augments = { 'Accuracy+4', 'TP Bonus +250', } },
        left_ring = "Regal Ring",
        right_ring = "Niqmaddu Ring",
        back = gear.mab_jse_back,
    }
    sets.precast.WS['Tachi: Kagero'].Enmity = set_combine(sets.precast.WS['Tachi: Kagero'], { left_ear = "Schere Earring" })
    sets.precast.WS['Tachi: Kagero'].SubtleBlow = set_combine(sets.precast.WS['Tachi: Kagero'], {})
    sets.precast.WS['Tachi: Kagero'].KI = set_combine(sets.precast.WS['Tachi: Kagero'], { body = "Found. Breastplate" })
    sets.precast.WS['Tachi: Kagero'].KI.SubtleBlow = set_combine(sets.precast.WS['Tachi: Kagero'].KI, {})

    sets.precast.WS['Tachi: Goten'] = set_combine(sets.precast.WS['Tachi: Kagero'], {})
    sets.precast.WS['Tachi: Goten'].Enmity = set_combine(sets.precast.WS['Tachi: Goten'], { left_ear = "Schere Earring" })
    sets.precast.WS['Tachi: Goten'].SubtleBlow = set_combine(sets.precast.WS['Tachi: Goten'], {})
    sets.precast.WS['Tachi: Goten'].KI = set_combine(sets.precast.WS['Tachi: Goten'], { body = "Found. Breastplate" })
    sets.precast.WS['Tachi: Goten'].KI.SubtleBlow = set_combine(sets.precast.WS['Tachi: Goten'].KI, {})

    sets.precast.WS['Tachi: Koki'] = set_combine(sets.precast.WS['Tachi: Kagero'], { right_ring = gear.weather_ring, })
    sets.precast.WS['Tachi: Koki'].Enmity = set_combine(sets.precast.WS['Tachi: Koki'], { left_ear = "Schere Earring" })
    sets.precast.WS['Tachi: Koki'].SubtleBlow = set_combine(sets.precast.WS['Tachi: Koki'], {})
    sets.precast.WS['Tachi: Koki'].KI = set_combine(sets.precast.WS['Tachi: Koki'], { body = "Found. Breastplate" })
    sets.precast.WS['Tachi: Koki'].KI.SubtleBlow = set_combine(sets.precast.WS['Tachi: Koki'].KI, {})

    sets.precast.WS['Tachi: Ageha'] = {
        ammo = "Pemphredo Tathlum",
        head = "Mpaca's Cap",
        body = "Mpaca's Doublet",
        hands = "Mpaca's Gloves",
        legs = "Mpaca's Hose",
        feet = "Mpaca's Boots",
        neck = "Sanctity Necklace",
        waist = "Eschan Stone",
        left_ear = { name = "Moonshade Earring", augments = { 'Accuracy+4', 'TP Bonus +250', } },
        right_ear = gear.empy_wsd_earring, -- 3
        left_ring = "Metamor. Ring +1",
        right_ring = gear.weather_ring,
        back = gear.ws_jse_back,
    }

    sets.precast.WS['Tachi: Ageha'].Enmity = set_combine(sets.precast.WS['Tachi: Ageha'], { left_ear = "Schere Earring" })

    sets.precast.WS['Tachi: Hobaku'] = set_combine(sets.precast.WS['Tachi: Ageha'], {})
    sets.precast.WS['Tachi: Hobaku'].Enmity = set_combine(sets.precast.WS['Tachi: Ageha'], { left_ear = "Schere Earring" })

    sets.precast.WS['Impulse Drive'] = set_combine(sets.precast.WS, { body = "Dagon Breast." })
    sets.precast.WS['Impulse Drive'].Enmity = set_combine(sets.precast.WS['Impulse Drive'], { left_ear = "Schere Earring" })
    sets.precast.WS['Impulse Drive'].SubtleBlow = set_combine(sets.precast.WS.SubtleBlow, { body = "Dagon Breast." })
    sets.precast.WS['Impulse Drive'].KI = set_combine(sets.precast.WS.KI, {})
    sets.precast.WS['Impulse Drive'].KI.SubtleBlow = set_combine(sets.precast.WS.KI.SubtleBlow, {})


    sets.precast.RA = {
        waist = "Yemaya Belt",
        left_ring = "Crepuscular Ring", -- 3
    }

    -- Swap to these on Moonshade using WS if at 3000 TP
    sets.MaxTP = { head = "Nyame Helm", ear1 = "Thrud Earring", ear2 = "Lugra Earring +1", }
    sets.AccMaxTP = { head = "Nyame Helm", ear1 = "Thrud Earring", ear2 = "Lugra Earring +1", }
    sets.AccDayMaxTPWSEars = { ear1 = "Thrud Earring", ear2 = "Lugra Earring +1" }
    sets.DayMaxTPWSEars = { ear1 = "Thrud Earring", ear2 = "Lugra Earring +1", }
    sets.AccDayWSEars = { ear1 = "Lugra Earring +1", ear2 = "Moonshade Earring" }
    sets.DayWSEars = { ear1 = "Lugra Earring +1", ear2 = "Moonshade Earring", }

    -- Midcast Sets
    sets.midcast.FastRecast = sets.precast.FC

    -- Specific spells
    sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {})

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
        back = gear.da_jse_back,
    }


    sets.Kiting = { feet = "Danzo Sune-ate" }
    sets.TreasureHunter = set_combine(sets.TreasureHunter, {})

    sets.idle = {
        ammo = gear.dt_ammo,
        head = "Wakido Kabuto +3",
        body = gear.idle_body,
        hands = "Nyame Gauntlets",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets",
        neck = "Sanctity Necklace",
        waist = gear.dt_waist,
        left_ear = "Infused Earring",
        right_ear = "Etiolation Earring",
        left_ring = "Defending Ring",
        right_ring = gear.tp_ring,
        back = gear.da_jse_back,
    }

    sets.idle.Town = {
        ammo = "Coiste Bodhar",
        head = "Nyame Helm",
        body = gear.jse_empy_body,
        hands = "Nyame Gauntlets",
        legs = gear.jse_empy_legs,
        feet = "Nyame Sollerets",
        neck = "Sam. Nodowa +2",
        waist = "Sailfi Belt +1",
        left_ear = "Telos Earring",
        right_ear = gear.empy_earring,
        left_ring = "Niqmaddu Ring",
        right_ring = gear.tp_ring,
        back = gear.da_jse_back,
    }

    sets.resting = sets.idle
    sets.idle.Weak = sets.idle
    sets.DayIdle = {}
    sets.NightIdle = {}

    -- Defense sets
    sets.defense.PDT = {
        ammo = gear.dt_ammo,
        head = "Nyame Helm",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets",
        neck = "Loricate Torque +1",
        waist = gear.dt_waist,
        left_ear = "Etiolation Earring",
        right_ear = "Odnowa Earring +1",
        left_ring = "Defending Ring",
        right_ring = "Gelatinous Ring +1",
        back = gear.dt_moon_back,
    }

    sets.defense.MDT = sets.defense.PDT
    sets.defense.MEVA = sets.defense.PDT

    -- Engaged sets
    sets.engaged = {
        ammo = "Coiste Bodhar",
        head = gear.jse_empy_head,
        body = gear.jse_empy_body,
        hands = "Mpaca's Gloves",
        legs = gear.jse_empy_legs,
        feet = "Mpaca's Boots",
        neck = "Sam. Nodowa +2",
        waist = "Ioskeha Belt +1",
        left_ear = "Telos Earring",
        right_ear = gear.empy_earring,
        left_ring = "Niqmaddu Ring",
        right_ring = gear.tp_ring,
        back = gear.da_jse_back,
    }

    -- 47% DT/PDT
    -- 501 MEVA
    sets.engaged.DT = {
        Ammo = "Coiste Bodhar",
        head = gear.jse_empy_head,
        body = gear.jse_empy_body,
        hands = "Nyame Gauntlets",
        legs = gear.jse_empy_legs,
        feet = "Nyame Sollerets",
        neck = "Sam. Nodowa +2",
        waist = "Ioskeha Belt +1",
        left_ear = "Telos Earring",
        right_ear = gear.empy_earring,
        left_ring = "Niqmaddu Ring",
        right_ring = gear.tp_ring,
        back = gear.da_jse_back,
    }

    --43 SB
    sets.engaged.SubtleBlow = {
        ammo = "Staunch Tathlum +1",
        head = "Nyame Helm",
        body = "Dagon Breast.", -- 10 II
        hands = "Wakido Kote +3",
        legs = "Mpaca's Hose", -- 5 II
        feet = "Nyame Sollerets",
        neck = "Sam. Nodowa +2",
        waist = "Sarissapho. Belt",   -- 5
        left_ear = "Digni. Earring",  -- 5
        right_ear = "Schere Earring", -- 3
        left_ring = "Niqmaddu Ring",  -- 5 II
        right_ring = "Chirich Ring +1", -- 10
        back = gear.da_jse_back,
    }

    -- Buff sets
    sets.Cure_Received = { waist = "Gishdubar Sash" }
    sets.buff.Doom = set_combine(sets.buff.Doom, {})
    sets.buff.Hasso = {}
    sets.buff.LastResort = { hands = "Mpaca's Gloves", right_ear = "Crep. Earring" }
    sets.buff['Third Eye'] = {}
    sets.buff.Sekkanoki = {} --{hands="Kasuga Kote +1"}
    sets.buff.Sengikori = {} --{feet="Kas. Sune-Ate +1"}
    sets.buff['Meikyo Shisui'] = {}
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
