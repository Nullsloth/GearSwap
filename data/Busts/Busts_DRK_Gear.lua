function user_job_setup()

    state.OffenseMode:options('Normal')
    state.WeaponskillMode:options('Normal', 'Enmity', 'SubtleBlow')
    state.HybridMode:options('DT', 'Normal', 'SubtleBlow')
    state.PhysicalDefenseMode:options('PDT')
    state.MagicalDefenseMode:options('MDT')
    state.ResistDefenseMode:options('MEVA')
    state.IdleMode:options('Normal')
    state.Weapons:options('Lycurgos', 'Caladbolg', 'Liberator', 'Apocalypse', 'Anguta', 'Loxotic', 'Naegling', 'None')
    state.ExtraMeleeMode = M { ['description'] = 'Extra Melee Mode', 'None' }
    state.Passive = M { ['description'] = 'Passive Mode', 'None' }
    state.DrainAbsSwapMode = M { '300', 'Always', 'Never' }
    state.AutoJumpMode = M(false, 'Auto Jump Mode')
    state.AutoTPReductionMode = M(false, 'Auto TP Reduction Mode')
    silibs.enable_cancel_outranged_ws()
    silibs.enable_cancel_on_blocking_status()
    silibs.enable_weapon_rearm()
    silibs.enable_auto_lockstyle(3)
    silibs.enable_waltz_refiner()
    silibs.enable_premade_commands()
    silibs.enable_th()
    silibs.enable_ui()


    autows_list = {
        ['Tizbron'] = 'Expiacion',
        ['Tizalmace'] = 'Expiacion',
        ['Almace'] = 'Chant Du Cygne',
        ['MeleeClubs'] = 'Realmrazer',
        ['HybridWeapons'] = 'Sanguine Blade',
        ['Naegbron'] = 'Savage Blade',
        ['Naegmace'] = 'Savage Blade'
    }

    autofood = 'Grape Daifuku'

    -- Additional local binds
    send_command('bind !` input /ja "Hasso" <me>')
    send_command('bind ^` input /ja "Seigan" <me>')
    send_command('bind @` input /ma "Stun" <t>')
    send_command('bind @f7 gs c toggle AutoTPReductionMode')
    send_command('bind ^backspace input /ja "Third Eye" <me>')
    send_command('bind !backspace gs c toggle DrainAbsSwapMode')
    send_command('bind ^\\\\ input /ja "Weapon Bash" <t>')
    send_command('bind @\\\\ gs c set toggle weapons KajaChopper')

    if player.sub_job == "DRG" then
        send_command('bind @f8 gs c toggle AutoJumpMode')
    else
        send_command('unbind @f8')
    end

    gear.jse_VIT_Back = { name = "Ankou's Mantle", augments = { 'VIT+20', 'Accuracy+20 Attack+20', 'VIT+10', 'Weapon skill damage +10%', 'Phys. dmg. taken-10%', } }
    gear.jse_STR_Back = { name = "Ankou's Mantle", augments = { 'STR+20', 'Accuracy+20 Attack+20', 'STR+10', 'Weapon skill damage +10%', 'Phys. dmg. taken-10%', } }
    gear.jse_FC_Back = { name = "Ankou's Mantle", augments = { 'INT+20', 'Mag. Acc+20 /Mag. Dmg.+20', 'Mag. Acc.+10', '"Fast Cast"+10', 'Phys. dmg. taken-10%', } }
    gear.jse_TP_Back = { name = "Ankou's Mantle", augments = { 'DEX+20', 'Accuracy+20 Attack+20', '"Dbl.Atk."+10', 'Accuracy+10', 'Phys. dmg. taken-10%', } }
    gear.Drain_back = { name = "Niht Mantle", augments = { 'Attack+7', 'Dark magic skill +7', '"Drain" and "Aspir" potency +25', } }

    select_default_macro_book()
end

function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    autows_list = { ['Caladbolg'] = 'Torcleaver', ['Liberator'] = 'Insurgency', ['Apocalypse'] = 'Cross Reaper', ['Anguta'] = 'Shadow of Death', ['Loxotic'] = 'Judgment', ['KajaChopper'] = 'Armor Break', ['Naegling'] = 'Savage Blade' }

    -- Weapons sets
    sets.weapons.Caladbolg = { main = "Caladbolg", sub = "Utu Grip" }
    sets.weapons.Liberator = { main = "Liberator", sub = "Utu Grip" }
    sets.weapons.Apocalypse = { main = "Apocalypse", sub = "Utu Grip" }
    sets.weapons.Anguta = { main = "Anguta", sub = "Utu Grip" }
    sets.weapons.Lycurgos = { main = "Lycurgos", sub = "Khonsu" }
    sets.weapons.Loxotic = { main = "Loxotic Mace +1", sub = "Blurred Shield +1" }
    sets.weapons.Naegling = { main = "Naegling", sub = "Blurred Shield +1" }

    -- Precast Sets
    -- Precast sets to enhance JAs
    sets.precast.JA['Diabolic Eye'] = {}
    sets.precast.JA['Arcane Circle'] = {}
    sets.precast.JA['Souleater'] = {}
    sets.precast.JA['Weapon Bash'] = {}
    sets.precast.JA['Nether Void'] = {}
    sets.precast.JA['Blood Weapon'] = {}
    sets.precast.JA['Dark Seal'] = {}
    sets.precast.JA['Last Resort'] = { back = "Ankou's Mantle" }

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}

    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    sets.precast.Step = {}

    sets.precast.Flourish1 = {}

    -- Fast cast sets for spells

    sets.precast.FC = {
        ammo = "Sapience Orb", -- 2
        head = { name = "Carmine Mask +1", augments = { 'Accuracy+20', 'Mag. Acc.+12', '"Fast Cast"+4', } }, -- 14
        body = "Fall. Cuirass +3", -- 10
        hands = "Leyline Gloves", -- 7
        legs = gear.odyssean_fc_legs, -- 6
        feet = gear.odyssean_fc_feet, -- 10
        neck = "Baetyl Pendant", -- 4
        waist = "Flume Belt +1",
        left_ear = "Loquac. Earring", -- 2
        right_ear = "Malignance Earring", -- 4
        left_ring = "Weather. Ring +1", -- 5
        right_ring = "Kishar Ring", -- 4
        back = gear.jse_FC_Back, -- 10
    }

    sets.precast.FC['Dark Magic'] = set_combine(sets.precast.FC, {})

    sets.precast.FC.Impact = set_combine(sets.precast.FC, { head = empty, body = "Twilight Cloak" })

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        ammo = "Knobkierrie", -- 6
        head = "Nyame Helm",
        body = "Nyame Mail", -- 10
        hands = "Nyame Gauntlets", -- 5
        legs = "Nyame Flanchard", -- 9
        feet = "Nyame Sollerets", -- 7
        neck = gear.drk_jse_neck,
        waist = "Sailfi Belt +1",
        left_ear = "Thrud Earring", -- 3
        right_ear = { name = "Moonshade Earring", augments = { 'Accuracy+4', 'TP Bonus +250', } },
        left_ring = "Regal Ring",
        right_ring = "Beithir Ring", -- 3
        back = gear.jse_STR_Back, -- 10
    }

    sets.precast.WS.SubtleBlow = set_combine(sets.precast.WS, {
        hands = "Sakpata's Gauntlets",
        feet = "Sakpata's Leggings",
        right_ring = "Niqmaddu Ring",
    })

    sets.precast.WS.Enmity = set_combine(sets.precast.WS, { left_ear = "Schere Earring" })
    sets.precast.WS.KI = set_combine(sets.precast.WS, { body = "Found. Breastplate" })
    sets.precast.WS.KI.SubtleBlow = set_combine(sets.precast.WS.SubtleBlow, { body = "Found. Breastplate" })

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Torcleaver'] = set_combine(sets.precast.WS, {
        ammo = "Crepuscular Pebble", -- 3
        head = "Nyame Helm",
        body = "Nyame Mail", -- 10
        hands = "Nyame Gauntlets",
        legs = "Nyame Flanchard", -- 9
        feet = "Nyame Sollerets", -- 7
        neck = gear.drk_jse_neck,
        waist = "Fotia Belt",
        left_ear = { name = "Moonshade Earring", augments = { 'Accuracy+4', 'TP Bonus +250', } },
        right_ear = "Thrud Earring", -- 3
        left_ring = "Regal Ring",
        right_ring = "Niqmaddu Ring", -- 3
        back = gear.jse_VIT_Back, -- 10
    })
    sets.precast.WS['Torcleaver'].Enmity = set_combine(sets.precast.WS['Torcleaver'], { right_ear = "Schere Earring" })
    sets.precast.WS['Torcleaver'].SubtleBlow = set_combine(sets.precast.WS['Torcleaver'], {
        hands = "Sakpata's Gauntlets", -- 8
        feet = "Sakpata's Leggings", -- 13
        right_ring = "Niqmaddu Ring", -- 5
    })
    sets.precast.WS['Torcleaver'].KI = set_combine(sets.precast.WS['Torcleaver'], { body = "Found. Breastplate" })
    sets.precast.WS['Torcleaver'].KI.SubtleBlow = set_combine(sets.precast.WS['Torcleaver'].SubtleBlow, { body = "Found. Breastplate" })

    sets.precast.WS['Resolution'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Catastrophe'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Cross Reaper'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Entropy'] = set_combine(sets.precast.WS, {})

    sets.precast.WS['Insurgency'] = {
        ammo = "Knobkierrie",
        head = "Nyame Helm",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets",
        neck = gear.drk_jse_neck,
        waist = "Sailfi Belt +1",
        left_ear = "Thrud Earring",
        right_ear = { name = "Moonshade Earring", augments = { 'Accuracy+4', 'TP Bonus +250', } },
        left_ring = "Regal Ring",
        right_ring = "Niqmaddu Ring",
        back = gear.jse_STR_Back,
    }

    sets.precast.WS['Shadow of Death'] = {
        ammo = "Knobkierrie",
        head = "Pixie Hairpin +1",
        body = "Fall. Cuirass +3",
        hands = { name = "Fall. Fin. Gaunt. +3", augments = { 'Enhances "Diabolic Eye" effect', } },
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets",
        neck = gear.drk_jse_neck,
        waist = "Hachirin-no-Obi",
        left_ear = "Malignance Earring",
        right_ear = { name = "Moonshade Earring", augments = { 'Accuracy+4', 'TP Bonus +250', } },
        left_ring = "Regal Ring",
        right_ring = "Archon Ring",
        back = gear.jse_STR_Back,
    }

    sets.precast.WS['Armor Break'] = {
        ammo = "Pemphredo Tathlum",
        head = "Sakpata's Helm",
        body = "Sakpata's Plate",
        hands = "Sakpata's Gauntlets",
        legs = "Sakpata's Cuisses",
        feet = "Sakpata's Leggings",
        neck = "Erra Pendant",
        waist = "Eschan Stone",
        left_ear = "Malignance Earring",
        --right_ear="Digni. Earring",
        right_ear = { name = "Moonshade Earring", augments = { 'Accuracy+4', 'TP Bonus +250', } },
        left_ring = "Metamor. Ring +1",
        right_ring = "Weather. Ring +1",
        back = gear.jse_FC_Back,
    }

    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
        ammo = "Crepuscular Pebble", -- 3
        head = "Nyame Helm",
        body = "Nyame Mail", -- 10
        hands = "Nyame Gauntlets",
        legs = "Nyame Flanchard", -- 9
        feet = "Nyame Sollerets", -- 7
        neck = gear.drk_jse_neck,
        waist = "Sailfi Belt +1",
        left_ear = { name = "Moonshade Earring", augments = { 'Accuracy+4', 'TP Bonus +250', } },
        right_ear = "Thrud Earring", -- 3
        left_ring = "Regal Ring",
        right_ring = "Niqmaddu Ring", -- 3
        back = gear.jse_STR_Back, -- 10
    })
    sets.precast.WS['Savage Blade'].Enmity = set_combine(sets.precast.WS['Savage Blade'], { right_ear = "Schere Earring" })
    sets.precast.WS['Savage Blade'].SubtleBlow = set_combine(sets.precast.WS['Savage Blade'], {
        hands = "Sakpata's Gauntlets", -- 8
        feet = "Sakpata's Leggings", -- 13
        right_ring = "Niqmaddu Ring", -- 5
    })
    sets.precast.WS['Savage Blade'].KI = set_combine(sets.precast.WS['Savage Blade'], { body = "Found. Breastplate" })
    sets.precast.WS['Savage Blade'].KI.SubtleBlow = set_combine(sets.precast.WS['Savage Blade'].SubtleBlow, { body = "Found. Breastplate" })

    -- Midcast Sets
    sets.midcast.FastRecast = sets.precast.FC

    -- Specific spells

    sets.midcast['Dark Magic'] = {
        ammo = "Pemphredo Tathlum",
        head = { name = "Fall. Burgeonet +3", augments = { 'Enhances "Dark Seal" effect', } },
        body = "Fall. Cuirass +3",
        hands = { name = "Fall. Fin. Gaunt. +3", augments = { 'Enhances "Diabolic Eye" effect', } },
        legs = { name = "Fall. Flanchard +3", augments = { 'Enhances "Muted Soul" effect', } },
        feet = "Nyame Sollerets",
        neck = "Erra Pendant",
        waist = "Eschan Stone",
        left_ear = "Digni. Earring",
        right_ear = "Malignance Earring",
        left_ring = "Archon Ring",
        right_ring = "Evanescence Ring",
        back = gear.jse_FC_Back,
    }

    sets.midcast['Enfeebling Magic'] = {
        ammo = "Pemphredo Tathlum",
        head = "Hjarrandi Helm",
        body = "Fall. Cuirass +3",
        hands = { name = "Fall. Fin. Gaunt. +3", augments = { 'Enhances "Diabolic Eye" effect', } },
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets",
        neck = "Erra Pendant",
        waist = "Eschan Stone",
        left_ear = "Digni. Earring",
        right_ear = "Malignance Earring",
        left_ring = "Archon Ring",
        right_ring = "Evanescence Ring",
        back = gear.jse_FC_Back,
    }

    sets.midcast['Dread Spikes'] = set_combine(sets.midcast['Dark Magic'], {})
    sets.midcast.Absorb = set_combine(sets.midcast['Dark Magic'], { hands = "Heathen's Gauntlets +1", feet = "Ratri Sollerets +1", back = "Ankou's Mantle" })

    sets.midcast.Stun = {}

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], { ring1 = "Evanescence Ring", ring2 = "Archon Ring", back = gear.Drain_back }) -- feet="Ratri Sollerets +1",

    sets.DrainWeapon = { main = "Misanthropy", sub = "Utu Grip" }
    sets.AbsorbWeapon = { main = "Liberator", sub = "Utu Grip" }

    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Impact = set_combine(sets.midcast['Dark Magic'], { head = empty, body = "Twilight Cloak" })

    sets.midcast.Cure = {}

    sets.Self_Healing = { waist = "Gishdubar Sash" }
    sets.Cure_Received = { waist = "Gishdubar Sash" }
    sets.Self_Refresh = { waist = "Gishdubar Sash" }



    -- Swap to these on Moonshade using WS if at 3000 TP
    sets.MaxTP = { ear1 = "Thrud Earring", ear2 = "Lugra Earring +1", }
    sets.AccMaxTP = { ear1 = "Thrud Earring", ear2 = "Lugra Earring +1", }
    sets.AccDayMaxTPWSEars = { ear1 = "Thrud Earring", ear2 = "Lugra Earring +1" }
    sets.DayMaxTPWSEars = { ear1 = "Thrud Earring", ear2 = "Lugra Earring +1", }
    sets.AccDayWSEars = { ear1 = "Lugra Earring +1", ear2 = "Moonshade Earring" }
    sets.DayWSEars = { ear1 = "Lugra Earring +1", ear2 = "Moonshade Earring", }

    -- Idle sets

    sets.idle = {
        ammo = "Staunch Tathlum +1",
        head = "Sakpata's Helm",
        body = "Chozor. Coselete",
        hands = "Sakpata's Gauntlets",
        legs = "Sakpata's Cuisses",
        feet = "Sakpata's Leggings",
        neck = "Coatl Gorget +1",
        waist = "Flume Belt +1",
        left_ear = "Infused Earring",
        right_ear = "Etiolation Earring",
        left_ring = "Chirich Ring +1",
        right_ring = "Gelatinous Ring +1",
        back = gear.jse_TP_Back,
    }

    sets.idle.Reraise = set_combine(sets.idle, {})

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
        left_ear = "Odnowa Earring +1",
        right_ear = "Etiolation Earring",
        left_ring = "Defending Ring",
        right_ring = "Gelatinous Ring +1",
        back = gear.dt_moon_back,
    }

    sets.defense.MDT = sets.defense.PDT
    sets.defense.MEVA = sets.defense.PDT

    sets.idle.Weak = sets.defense.PDT
    sets.resting = sets.defense.PDT
    sets.Kiting = { legs = "Carmine Cuisses +1" }
    sets.passive.Reraise = {}
    sets.buff.Doom = set_combine(sets.buff.Doom, {})
    sets.buff['Dark Seal'] = { head = "Fall. Burgeonet +3" }

    --Extra Special Sets
    sets.buff.Souleater = {}
    sets.buff.ScarletDelirium = {
        ammo = "Coiste Bodhar",
        head = "Flam. Zucchetto +2",
        body = "Dagon Breast.",
        hands = "Fall. Fin. Gaunt. +3",
        legs = "Ig. Flanchard +3",
        feet = "Flam. Gambieras +2",
        neck = gear.drk_jse_neck,
        waist = "Ioskeha Belt +1",
        left_ear = "Crep. Earring",
        right_ear = "Telos Earring",
        left_ring = "Chirich Ring +1",
        right_ring = "Niqmaddu Ring",
        back = gear.jse_TP_Back,
    }
    sets.buff.ScarletDelirium.Mboze = {
        ammo = "Coiste Bodhar",
        head = empty,
        body = "Dagon Breast.", -- 10 II
        hands = empty,
        legs = empty,
        feet = "Sakpata's Leggings", -- 13
        neck = gear.drk_jse_neck,
        waist = "Sarissapho. Belt", -- 5
        left_ear = "Digni. Earring", -- 5
        right_ear = "Telos Earring",
        left_ring = "Chirich Ring +1", -- 10
        right_ring = "Niqmaddu Ring", -- 5 II
        back = gear.Drain_back,
    }
    sets.buff.Doom = set_combine(sets.buff.Doom, {})
    sets.TreasureHunter = set_combine(sets.TreasureHunter, {})

    -- Engaged sets
    sets.engaged = {
        ammo = "Coiste Bodhar",
        head = "Flam. Zucchetto +2",
        body = "Hjarrandi Breast.",
        hands = "Sakpata's Gauntlets",
        legs = "Ig. Flanchard +3",
        feet = "Flam. Gambieras +2",
        neck = gear.drk_jse_neck,
        waist = "Ioskeha Belt +1",
        left_ear = "Cessance Earring",
        right_ear = "Telos Earring",
        left_ring = "Chirich Ring +1",
        right_ring = "Niqmaddu Ring",
        back = gear.jse_TP_Back;
    }

    sets.engaged.DT = {
        ammo = "Coiste Bodhar", -- 3
        head = "Sakpata's Helm", -- 7
        body = "Sakpata's Plate", -- 10
        hands = "Sakpata's Gauntlets", -- 5
        legs = "Sakpata's Cuisses",
        feet = "Sakpata's Leggings",
        neck = gear.drk_jse_neck,
        waist = "Ioskeha Belt +1",
        left_ear = "Crep. Earring",
        right_ear = "Telos Earring",
        left_ring = "Chirich Ring +1", -- 10
        right_ring = "Niqmaddu Ring",
        back = gear.jse_TP_Back; -- 10
    }

    -- I - 41
    -- II - 15
    sets.engaged.SubtleBlow = {
        ammo = "Staunch Tathlum +1",
        head = "Sakpata's Helm",
        body = "Dagon Breast.", -- 10 II
        hands = { name = "Sakpata's Gauntlets", augments = { 'Path: A', } }, -- 8
        legs = "Sakpata's Cuisses",
        feet = "Sakpata's Leggings", -- 13
        neck = gear.drk_jse_neck,
        waist = "Sarissapho. Belt", -- 5
        left_ear = "Digni. Earring", -- 5
        right_ear = "Telos Earring",
        left_ring = "Chirich Ring +1", -- 10
        right_ring = "Niqmaddu Ring", -- 5 II
        back = gear.jse_TP_Back;
    }
    sets.engaged.SubtleBlow.Auspice = set_combine(sets.engaged.SubtleBlow, {
        waist = "Ioskeha Belt +1",
        left_ear = "Crep. Earring",
        right_ear = "Telos Earring",
    })

    sets.idle.Town = sets.engaged.DT

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(2, 15)
    elseif player.sub_job == 'SAM' then
        set_macro_page(3, 15)
    elseif player.sub_job == 'DNC' then
        set_macro_page(4, 15)
    elseif player.sub_job == 'THF' then
        set_macro_page(1, 15)
    else
        set_macro_page(5, 15)
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
