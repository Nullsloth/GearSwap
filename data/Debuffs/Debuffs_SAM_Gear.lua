function user_job_setup()

    state.OffenseMode:options('Normal')
    state.HybridMode:options('DT', 'Normal', 'SubtleBlow')
    state.WeaponskillMode:options('Normal', 'Enmity', 'SubtleBlow')
    state.RangedMode:options('Normal')
    state.PhysicalDefenseMode:options('PDT')
    state.MagicalDefenseMode:options('MDT')
    state.ResistDefenseMode:options('MEVA')
    state.IdleMode:options('Normal')
    state.Weapons:options('Masamune', 'Dojikiri', 'ShiningOne', 'MaficCudgel', 'Yoichinoyumi', 'None')
    state.AutoJumpMode = M(false, 'Auto Jump Mode')
    autofood = 'Grape Daifuku'
    silibs.enable_cancel_outranged_ws()
    silibs.enable_cancel_on_blocking_status()
    silibs.enable_weapon_rearm()
    silibs.enable_auto_lockstyle(3)
    silibs.enable_waltz_refiner()
    silibs.enable_premade_commands()
    silibs.enable_th()
    silibs.enable_ui()

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

    -- Weapons sets
    sets.weapons.Masamune = { main = "Masamune", sub = "Utu Grip" }
    sets.weapons.Dojikiri = { main = "Dojikiri Yasutsuna", sub = "Utu Grip" }
    sets.weapons.ShiningOne = { main = "Shining One", sub = "Utu Grip" }
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
        waist = "Flume Belt +1",
        left_ear = "Loquac. Earring",
        right_ear = "Etiolation Earring",
        left_ring = "Defending Ring",
        right_ring = "Lebeche Ring",
        back = gear.da_jse_back,
    }

    -- Ranged snapshot gear
    sets.precast.RA = {}

    sets.precast.Jump = {
        ammo = "Ginsen",
        head = "Mpaca's Cap",
        body = "Wakido Domaru +3",
        hands = "Nyame Gauntlets",
        legs = "Nyame Flanchard",
        feet = "Maenadic Gambieras",
        neck = "Sam. Nodowa +2",
        waist = "Sailfi Belt +1",
        left_ear = "Telos Earring",
        right_ear = { name = "Moonshade Earring", augments = { 'Accuracy+4', 'TP Bonus +250', } },
        left_ring = "Regal Ring",
        right_ring = "Niqmaddu Ring",
        back = gear.da_jse_back,
    }

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    -- 51%
    sets.precast.WS = {
        ammo = "Knobkierrie", -- 6
        head = "Mpaca's Cap",
        body = "Sakonji Domaru +3", -- 10
        hands = "Nyame Gauntlets",
        legs = "Wakido Haidate +3", -- 10
        feet = "Nyame Sollerets",
        neck = "Sam. Nodowa +2",
        waist = "Sailfi Belt +1",
        left_ear = "Thrud Earring", -- 3
        right_ear = { name = "Moonshade Earring", augments = { 'Accuracy+4', 'TP Bonus +250', } },
        left_ring = "Regal Ring",
        right_ring = "Niqmaddu Ring", -- 3
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
        left_ear = "Thrud Earring",
        right_ear = { name = "Moonshade Earring", augments = { 'Accuracy+4', 'TP Bonus +250', } },
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
        head = "Nyame Helm",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets",
        neck = "Sam. Nodowa +2",
        waist = "Orpheus's Sash",
        left_ear = "Friomisi Earring",
        right_ear = { name = "Moonshade Earring", augments = { 'Accuracy+4', 'TP Bonus +250', } },
        left_ring = "Regal Ring",
        right_ring = "Niqmaddu Ring",
        back = gear.ws_jse_back,
    }
    sets.precast.WS['Tachi: Jinpu'].Enmity = set_combine(sets.precast.WS['Tachi: Jinpu'], { left_ear = "Schere Earring" })
    sets.precast.WS['Tachi: Jinpu'].SubtleBlow = set_combine(sets.precast.WS['Tachi: Jinpu'], {})
    sets.precast.WS['Tachi: Jinpu'].KI = set_combine(sets.precast.WS['Tachi: Jinpu'], { body = "Found. Breastplate" })
    sets.precast.WS['Tachi: Jinpu'].KI.SubtleBlow = set_combine(sets.precast.WS['Tachi: Jinpu'].KI, {})

    sets.precast.WS['Tachi: Kagero'] = set_combine(sets.precast.WS['Tachi: Jinpu'], {})
    sets.precast.WS['Tachi: Kagero'].Enmity = set_combine(sets.precast.WS['Tachi: Kagero'], { left_ear = "Schere Earring" })
    sets.precast.WS['Tachi: Kagero'].SubtleBlow = set_combine(sets.precast.WS['Tachi: Kagero'], {})
    sets.precast.WS['Tachi: Kagero'].KI = set_combine(sets.precast.WS['Tachi: Kagero'], { body = "Found. Breastplate" })
    sets.precast.WS['Tachi: Kagero'].KI.SubtleBlow = set_combine(sets.precast.WS['Tachi: Kagero'].KI, {})

    sets.precast.WS['Tachi: Ageha'] = {
        ammo = "Pemphredo Tathlum",
        head = "Mpaca's Cap",
        body = "Mpaca's Doublet",
        hands = "Mpaca's Gloves",
        legs = "Mpaca's Hose",
        feet = "Mpaca's Boots",
        neck = "Sanctity Necklace",
        waist = "Eschan Stone",
        left_ear = "Digni. Earring",
        right_ear = { name = "Moonshade Earring", augments = { 'Accuracy+4', 'TP Bonus +250', } },
        left_ring = "Metamor. Ring +1",
        right_ring = "Weather. Ring +1",
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
        ammo = "Staunch Tathlum +1",
        head = "Wakido Kabuto +3",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets",
        neck = "Sanctity Necklace",
        waist = "Flume Belt +1",
        left_ear = "Infused Earring",
        right_ear = "Etiolation Earring",
        left_ring = "Defending Ring",
        right_ring = "Chirich Ring +1",
        back = gear.da_jse_back,
    }

    sets.idle.Town = {
        ammo = "Coiste Bodhar",
        head = "Nyame Helm",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets",
        neck = "Sam. Nodowa +2",
        waist = "Flume Belt +1",
        left_ear = "Telos Earring",
        right_ear = "Dedition Earring",
        left_ring = "Niqmaddu Ring",
        right_ring = "Chirich Ring +1",
        back = gear.da_jse_back,
    }

    sets.resting = sets.idle
    sets.idle.Weak = sets.idle
    sets.DayIdle = {}
    sets.NightIdle = {}

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
        ammo = "Aurgelmir Orb +1",
        head = "Flam. Zucchetto +2",
        body = "Tatena. Harama. +1",
        hands = "Wakido Kote +3",
        legs = "Tatena. Haidate +1",
        feet = "Tatena. Sune. +1",
        neck = "Sam. Nodowa +2",
        waist = "Sailfi Belt +1",
        left_ear = "Schere Earring",
        right_ear = "Telos Earring",
        left_ring = "Niqmaddu Ring",
        right_ring = "Chirich Ring +1",
        back = gear.da_jse_back,
    }

    -- 47% DT/PDT
    -- 501 MEVA
    sets.engaged.DT = {
        Ammo = "Aurgelmir Orb +1",
        head = "Nyame Helm",
        body = "Mpaca's Doublet",
        hands = "Mpaca's Gloves",
        legs = "Mpaca's Hose",
        feet = "Nyame Sollerets",
        neck = "Sam. Nodowa +2",
        waist = "Sailfi Belt +1",
        left_ear = "Telos Earring",
        right_ear = "Odnowa Earring +1",
        left_ring = "Niqmaddu Ring",
        right_ring = "Chirich Ring +1",
        back = gear.da_jse_back,
    }

    --43 SB
    sets.engaged.SubtleBlow = {
        ammo = "Aurgelmir Orb +1",
        head = "Ken. Jinpachi +1",
        body = "Dagon Breast.", -- 10 II
        hands = "Wakido Kote +3",
        legs = "Mpaca's Hose", -- 5 II
        feet = "Ryuo Sune-Ate +1",
        neck = "Bathy Choker +1",
        waist = "Sarissapho. Belt", -- 5
        left_ear = "Digni. Earring", -- 5
        right_ear = "Schere Earring",
        left_ring = "Niqmaddu Ring", -- 5 II
        right_ring = "Chirich Ring +1", -- 10
        back = gear.da_jse_back,
    }

    -- Buff sets
    sets.Cure_Received = { waist = "Gishdubar Sash" }
    sets.buff.Doom = set_combine(sets.buff.Doom, {})
    sets.buff.Hasso = { hands = "Wakido Kote +3" }
    sets.buff.LastResort = { hands = "Mpaca's Gloves", right_ear = "Crep. Earring" }
    sets.buff['Third Eye'] = {}
    sets.buff.Sekkanoki = {} --{hands="Kasuga Kote +1"}
    sets.buff.Sengikori = {} --{feet="Kas. Sune-Ate +1"}
    sets.buff['Meikyo Shisui'] = {}

end

function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(3, 1)
    elseif player.sub_job == 'WAR' then
        set_macro_page(1, 1)
    elseif player.sub_job == 'NIN' then
        set_macro_page(10, 1)
    elseif player.sub_job == 'THF' then
        set_macro_page(2, 1)
    else
        set_macro_page(1, 1)
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
