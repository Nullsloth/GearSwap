function user_job_setup()

    state.OffenseMode:options('Normal')
    state.HybridMode:options('DT', 'Normal')
    state.RangedMode:options('Normal')
    state.WeaponskillMode:options('Normal')
    state.IdleMode:options('Normal')
    state.PhysicalDefenseMode:options('PDT')
    state.MagicalDefenseMode:options('MDT')
    state.ResistDefenseMode:options('MEVA')
    state.Weapons:options('Aeneas', 'TH', 'Naegling', 'KajaKnuckles', 'None')
    state.ExtraMeleeMode = M { ['description'] = 'Extra Melee Mode', 'None' }
    state.AmbushMode = M(false, 'Ambush Mode')
    state.TreasureMode:options('Tag', 'Fulltime', 'None')
    silibs.enable_cancel_outranged_ws()
    silibs.enable_cancel_on_blocking_status()
    silibs.enable_weapon_rearm()
    silibs.enable_auto_lockstyle(3)
    silibs.enable_waltz_refiner()
    silibs.enable_premade_commands()
    silibs.enable_th()
    silibs.enable_ui()

    autows_list = {
        ['Aeneas'] = "Rudra's Storm",
        ['Aeolian'] = 'Aeolian Edge',
        ['Savage'] = 'Savage Blade',
        ['Throwing'] = "Rudra's Storm",
        ['SwordThrowing'] = 'Savage Blade',
        ['Evisceration'] = 'Evisceration',
        ['ProcWeapons'] = 'Wasp Sting',
        ['Bow'] = 'Empyreal Arrow' }

    -- Additional local binds
    send_command('bind ^` input /ja "Flee" <me>')
    send_command('bind ^= gs c cycle treasuremode')
    send_command('bind @` input /ja "Spectral Jig" <me>')
    send_command('bind @f10 gs c toggle AmbushMode')
    send_command('bind !backspace input /ja "Hide" <me>')
    send_command('bind ^backspace input /item "Thief\'s Tools" <t>')
    send_command('bind ^\\\\ input /ja "Despoil" <t>')
    send_command('bind !\\\\ input /ja "Mug" <t>')

    gear.jse_tp_back = { name = "Toutatis's Cape", augments = { 'DEX+20', 'Accuracy+20 Attack+20', '"Store TP"+10', 'Phys. dmg. taken-10%', } }
    gear.jse_wsd_back = { name = "Toutatis's Cape", augments = { 'DEX+20', 'Accuracy+20 Attack+20', 'Weapon skill damage +10%', 'Phys. dmg. taken-10%', } }

    select_default_macro_book()
end

function init_gear_sets()


    sets.TreasureHunter = set_combine(sets.TreasureHunterTHF, { hands = "Plunderer's Armlets +3", waist = "Chaac Belt", feet = "Skulker's Poulaines +1" })
    sets.Kiting = { feet = "Jute Boots +1" }

    sets.buff.Doom = set_combine(sets.buff.Doom, {})

    sets.buff['Sneak Attack'] = {}
    sets.buff['Trick Attack'] = {}

    -- Extra Melee sets.  Apply these on top of melee sets.
    sets.Knockback = {}
    sets.Ambush = {}

    -- Weapons sets
    sets.weapons.Aeneas = { main = "Aeneas", sub = "Gleti's Knife" }
    sets.weapons.TH = { main = "Aeneas", sub = "Taming Sari" }
    sets.weapons.Naegling = { main = "Naegling", sub = "Gleti's Knife" }
    sets.weapons.KajaKnuckles = { main = gear.thf_knuckles, sub = empty }

    -- Actions we want to use to tag TH.
    sets.precast.Step = sets.TreasureHunter
    sets.precast.JA['Violent Flourish'] = sets.TreasureHunter
    sets.precast.JA['Animated Flourish'] = sets.TreasureHunter
    sets.precast.JA.Provoke = sets.TreasureHunter

    --------------------------------------
    -- Precast sets
    --------------------------------------
    sets.precast.JA['Collaborator'] = {}
    sets.precast.JA['Accomplice'] = {}
    sets.precast.JA['Flee'] = {}
    sets.precast.JA['Hide'] = {}
    sets.precast.JA['Conspirator'] = {}
    sets.precast.JA['Steal'] = {}
    sets.precast.JA['Mug'] = {}
    sets.precast.JA['Despoil'] = { feet = "Skulker's Poulaines +1" }
    sets.precast.JA['Perfect Dodge'] = { hands = "Plunderer's Armlets +3" }
    sets.precast.JA['Feint'] = {}

    sets.precast.JA['Sneak Attack'] = sets.buff['Sneak Attack']
    sets.precast.JA['Trick Attack'] = sets.buff['Trick Attack']

    sets.precast.Waltz = {}
    sets.Self_Waltz = {}
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    sets.precast.FC = {
        ammo = "Sapience Orb",
        head = { name = "Nyame Helm", augments = { 'Path: B', } },
        body = "Adhemar Jacket +1",
        hands = { name = "Nyame Gauntlets", augments = { 'Path: B', } },
        legs = { name = "Rawhide Trousers", augments = { 'MP+50', '"Fast Cast"+5', '"Refresh"+1', } },
        feet = { name = "Nyame Sollerets", augments = { 'Path: B', } },
        neck = "Baetyl Pendant",
        waist = "Fotia Belt",
        left_ear = "Loquac. Earring",
        right_ear = "Etiolation Earring",
        left_ring = "Weather. Ring +1",
        right_ring = "Lebeche Ring",
        back = gear.jse_tp_back,
    }

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, { neck = "Magoraga Beads" })

    -- Weaponskill sets
    sets.precast.WS = {
        ammo = "C. Palug Stone",
        head = { name = "Nyame Helm", augments = { 'Path: B', } },
        body = { name = "Nyame Mail", augments = { 'Path: B', } },
        hands = { name = "Nyame Gauntlets", augments = { 'Path: B', } },
        legs = { name = "Nyame Flanchard", augments = { 'Path: B', } },
        feet = { name = "Nyame Sollerets", augments = { 'Path: B', } },
        neck = "Fotia Gorget",
        waist = "Fotia Belt",
        left_ear = "Ishvara Earring",
        right_ear = { name = "Moonshade Earring", augments = { 'Accuracy+4', 'TP Bonus +250', } },
        left_ring = "Regal Ring",
        right_ring = "Beithir Ring",
        back = gear.jse_wsd_back,
    }

    sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Aeolian Edge'].TH = set_combine(sets.precast.WS['Aeolian Edge'], sets.TreasureHunter)

    sets.precast.RA = {
        head = "Taeon Chapeau", -- 10
        feet = "Meghanada Jambeaux +2", -- 10
        waist = "Yemaya Belt",
        left_ring = "Crepuscular Ring", -- 3
    }

    -- Swap to these on Moonshade using WS if at 3000 TP
    sets.MaxTP = { ear1 = "Ishvara Earring", ear2 = "Telos Earring" }
    sets.AccMaxTP = { ear1 = "Ishvara Earring", ear2 = "Telos Earring" }

    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {})
    sets.midcast.Dia = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
    sets.midcast.Diaga = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
    sets.midcast['Dia II'] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
    sets.midcast.Bio = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
    sets.midcast['Bio II'] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)

    -- Ranged gear
    sets.midcast.RA = {
        head = "Malignance Chapeau",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        legs = "Malignance Tights",
        feet = "Malignance Boots",
        neck = "Iskur Gorget",
        waist = "Yemaya Belt",
        left_ear = "Telos Earring",
        right_ear = "Crep. Earring",
        left_ring = "Dingir Ring",
        right_ring = "Ilabrat Ring",
        back = gear.jse_tp_back,
    }

    --------------------------------------
    -- Idle/resting/defense sets
    --------------------------------------

    sets.idle = {
        ammo = gear.dt_ammo,
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
        back = gear.jse_tp_back,
    }

    sets.idle.Town = set_combine(sets.idle, {
        head = "Nyame Helm",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets",
    })

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
        left_ear = "Odnowa Earring +1",
        right_ear = "Etiolation Earring",
        left_ring = "Defending Ring",
        right_ring = "Gelatinous Ring +1",
        back = gear.dt_moon_back,
    }

    sets.defense.MDT = sets.defense.PDT
    sets.defense.MEVA = sets.defense.PDT

    sets.idle.Weak = sets.defense.PDT
    sets.resting = sets.idle
    --------------------------------------
    -- Melee sets
    --------------------------------------

    -- Normal melee group
    sets.engaged = {
        ammo = "Coiste Bodhar",
        head = "Malignance Chapeau",
        body = "Malignance Tabard",
        hands = "Adhemar Wrist. +1",
        legs = "Malignance Tights",
        feet = "Malignance Boots",
        neck = "Lissome Necklace",
        waist = "Reiki Yotai",
        left_ear = "Sherida Earring",
        right_ear = "Telos Earring",
        left_ring = "Petrov Ring",
        right_ring = "Gere Ring",
        back = gear.jse_tp_back,
    }

    sets.engaged.DT = {
        ammo = gear.dt_ammo,
        head = "Malignance Chapeau",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        legs = "Malignance Tights",
        feet = "Malignance Boots",
        neck = "Combatant's Torque",
        waist = "Reiki Yotai",
        left_ear = "Sherida Earring",
        right_ear = "Telos Earring",
        left_ring = "Defending Ring",
        right_ring = "Gere Ring",
        back = gear.jse_tp_back,
    }

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(8, 5)
    elseif player.sub_job == 'WAR' then
        set_macro_page(7, 5)
    elseif player.sub_job == 'NIN' then
        set_macro_page(10, 5)
    else
        set_macro_page(6, 5)
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
