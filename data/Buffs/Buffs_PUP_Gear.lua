function user_job_setup()

    state.OffenseMode:options('Normal')
    state.HybridMode:options('DT', 'HybridPET', 'PetTank', 'Normal')
    state.WeaponskillMode:options('Normal')
    state.PhysicalDefenseMode:options('PDT')
    state.IdleMode:options('Normal', 'Refresh')
    state.Weapons:options('Verethragna', 'Godhands', 'Sakpata', 'Midnights', 'DivinatorII', 'None')
    state.PetWSGear = M(true, 'Pet WS Gear')
    state.AutoBuffMode:options('auto')
    state.PetMode = M { ['description'] = 'Pet Mode', 'Tank', 'Melee', 'Ranged', 'Heal', 'Nuke' }
    state.AutoManeuvers = M { ['description'] = 'Auto Maneuver List', 'Tank', 'Melee', 'Ranged', 'Heal', 'Nuke' }
    silibs.enable_cancel_outranged_ws()
    silibs.enable_cancel_on_blocking_status()
    silibs.enable_weapon_rearm()
    silibs.enable_auto_lockstyle(3)
    silibs.enable_waltz_refiner()
    silibs.enable_premade_commands()
    silibs.enable_th()
    silibs.enable_ui()

    PetMode = "Tank"
    AutoManeuvers = "Tank"
    autows = "Victory Smite"

    -- Default/Automatic maneuvers for each pet mode.  Define at least 3.
    defaultManeuvers = {
        Tank = {
            { Name = 'Earth Maneuver', Amount = 0 },
            { Name = 'Fire Maneuver', Amount = 1 },
            { Name = 'Light Maneuver', Amount = 2 },
            { Name = 'Water Maneuver', Amount = 0 },
        },
        Melee = {
            { Name = 'Fire Maneuver', Amount = 0 },
            { Name = 'Wind Maneuver', Amount = 0 },
            { Name = 'Light Maneuver', Amount = 2 },
            { Name = 'Thunder Maneuver', Amount = 1 },
        },
        Ranged = {
            { Name = 'Wind Maneuver', Amount = 3 },
            { Name = 'Fire Maneuver', Amount = 0 },
            { Name = 'Light Maneuver', Amount = 0 },
            { Name = 'Thunder Maneuver', Amount = 0 },
        },
        Heal = {
            { Name = 'Light Maneuver', Amount = 2 },
            { Name = 'Dark Maneuver', Amount = 1 },
            { Name = 'Water Maneuver', Amount = 0 },
            { Name = 'Earth Maneuver', Amount = 0 },
        },
        Nuke = {
            { Name = 'Ice Maneuver', Amount = 2 },
            { Name = 'Dark Maneuver', Amount = 1 },
            { Name = 'Water Maneuver', Amount = 0 },
            { Name = 'Earth Maneuver', Amount = 0 },
        },
    }

    deactivatehpp = 85

    gear.jse_pet_tank_back = { name = "Visucius's Mantle", augments = { 'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20', 'Eva.+20 /Mag. Eva.+20', 'Pet: "Regen"+10', 'Pet: Damage taken -5%', } }
    gear.jse_da_back = { name = "Visucius's Mantle", augments = { 'DEX+20', 'Accuracy+20 Attack+20', '"Dbl.Atk."+10', 'Accuracy+10', 'Phys. dmg. taken-10%', } }
    gear.jse_wsd_back = { name = "Visucius's Mantle", augments = { 'VIT+20', 'Accuracy+20 Attack+20', 'VIT+10', 'Weapon skill damage +10%', 'Phys. dmg. taken-10%', } }

    select_default_macro_book()
end

send_command('bind ^` input /ja Deactivate <me>')
send_command('bind @backspace gs c toggle PetMode; gs c toggle AutoManeuvers')
send_command('bind !` input /ja Deploy <t>')
send_command('bind @` input /ja Retrieve <me>')
send_command('bind ^backspace input /ja "Deus Ex Automata" <me>')
send_command('bind !backspace input /ja Activate <me>')
send_command('bind @f8 gs c toggle AutoPuppetMode')
send_command('bind @f7 gs c toggle AutoRepairMode')
send_command('lua r autocontrol')

function init_gear_sets()

    -- Weapons sets
    sets.weapons.Verethragna = { main = "Verethragna", range = "Neo Animator", }
    sets.weapons.Godhands = { main = "Godhands", range = "Neo Animator", }
    sets.weapons.Sakpata = { main = "Sakpata's Fists", range = "Neo Animator", }
    sets.weapons.Midnights = { main = "Midnights", range = "Neo Animator", }
    sets.weapons.DivinatorII = { main = "Sakpata's Fists", range = "Divinator II", }


    -- Fast cast sets for spells
    sets.precast.FC = {
        head = "Malignance Chapeau",
        body = "Zendik Robe",
        hands = "Malignance Gloves",
        legs = "Rawhide Trousers",
        feet = "Regal Pumps +1",
        neck = "Baetyl Pendant",
        waist = gear.mnk_jse_waist,
        left_ear = "Loquac. Earring",
        right_ear = "Etiolation Earring",
        left_ring = "Defending Ring",
        right_ring = "Lebeche Ring",
        back = "Perimede Cape",
    }

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, { neck = "Magoraga Beads" })


    -- Precast sets to enhance JAs
    sets.precast.JA['Tactical Switch'] = {} --{feet="Cirque Scarpe +2"}
    sets.precast.JA['Repair'] = { ammo = "Automat. Oil +3" } --feet="Foire Babouches"
    sets.precast.JA['Maintenance'] = { ammo = "Automat. Oil +3" }

    sets.precast.JA.Maneuver = { main = "Midnights", back = gear.jse_pet_tank_back } --neck="Buffoon's Collar",hands="Foire Dastanas",body="Cirque Farsetto +2",

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
    sets.precast.Waltz['Healing Waltz'] = {}


    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head = "Nyame Helm",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets",
        neck = "Fotia Gorget",
        waist = gear.mnk_jse_waist,
        left_ear = "Ishvara Earring",
        right_ear = "Moonshade Earring",
        left_ring = "Regal Ring",
        right_ring = "Beithir Ring",
        back = gear.jse_wsd_back,
    }

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Victory Smite'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Stringing Pummel'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Shijin Spiral'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Asuran Fists'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Dragon Kick'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Tornado Kick'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Asuran Fists'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Raging Fists'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Howling Fist'] = set_combine(sets.precast.WS, {
        hands = "Mpaca's Gloves",
        legs = "Nyame Flanchard",
        feet = "Mpaca's Boots",
        neck = "Fotia Gorget",
        waist = "Fotia Belt",
        left_ring = "Gere Ring",
        right_ring = "Niqmaddu Ring",
    })
    sets.precast.WS['Backhand Blow'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Spinning Attack'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Shoulder Tackle'] = set_combine(sets.precast.WS, {})

    -- Midcast Sets

    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.Dia = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
    sets.midcast.Diaga = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
    sets.midcast['Dia II'] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
    sets.midcast.Bio = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
    sets.midcast['Bio II'] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)

    -- Midcast sets for pet actions
    sets.midcast.Pet.Cure = {}
    sets.midcast.Pet['Enfeebling Magic'] = { neck = "Adad Amulet", ear1 = "Enmerkar Earring", ring1 = "C. Palug Ring", ring2 = "Varar Ring +1", waist = "Incarnation Sash" }
    sets.midcast.Pet['Elemental Magic'] = { neck = "Adad Amulet", ear1 = "Enmerkar Earring", ring1 = "C. Palug Ring", ring2 = "Varar Ring +1", waist = "Incarnation Sash" }

    -- The following sets are predictive and are equipped before we even know the ability will happen, as a workaround due to
    -- the fact that start of ability packets are too late in the case of Pup abilities, WS, and certain spells.
    sets.midcast.Pet.PetEnmityGear = {}
    sets.midcast.Pet.PetWSGear = {
        head = "Nyame Helm",
        body = "Nyame Mail",
        hands = "Mpaca's Gloves",
        legs = "Nyame Flanchard",
        feet = "Mpaca's Boots",
        neck = "Shulmanu Collar",
        waist = "Incarnation Sash",
        left_ear = "Enmerkar Earring",
        right_ear = "Rimeice Earring",
        left_ring = "C. Palug Ring",
        right_ring = "Varar Ring +1",
        back = gear.jse_pet_tank_back,
    }

    sets.midcast.Pet.PetWSGear.Melee = set_combine(sets.midcast.Pet.PetWSGear, {})
    sets.midcast.Pet.PetWSGear.Ranged = set_combine(sets.midcast.Pet.PetWSGear, {})
    sets.midcast.Pet.PetWSGear.Tank = set_combine(sets.midcast.Pet.PetWSGear, {})
    sets.midcast.Pet.PetWSGear.Heal = set_combine(sets.midcast.Pet.PetWSGear, {})
    sets.midcast.Pet.PetWSGear.Nuke = set_combine(sets.midcast.Pet.PetWSGear, {})

    -- Currently broken, preserved in case of future functionality.
    --sets.midcast.Pet.WeaponSkill = {}

    -- Idle sets
    sets.idle = {
        head = "Malignance Chapeau",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        legs = "Malignance Tights",
        feet = "Malignance Boots",
        neck = "Sanctity Necklace",
        waist = gear.mnk_jse_waist,
        left_ear = "Infused Earring",
        right_ear = "Etiolation Earring",
        left_ring = "Defending Ring",
        right_ring = "Gelatinous Ring +1",
        back = gear.jse_pet_tank_back,
    }

    sets.resting = sets.idle

    sets.idle.Refresh = set_combine(sets.idle,
        {
            head = "Rawhide Mask",
            legs = "Rawhide Trousers"
        })

    -- Set for idle while pet is out (eg: pet regen gear)
    sets.idle.Pet = {
        head = "Rao Kabuto +1", -- 4
        body = "Rao Togi +1", -- 4
        hands = "Rao Kote +1", -- 4
        legs = "Rao Haidate +1", -- 4
        feet = "Rao Sune-Ate +1", -- 4
        neck = "Shepherd's Chain", -- 2
        waist = "Isa Belt", -- 3
        left_ear = "Enmerkar Earring", -- 3
        right_ear = "Rimeice Earring", -- 1
        left_ring = "Overbearing Ring",
        right_ring = "C. Palug Ring",
        back = gear.jse_pet_tank_back, -- 5
    }

    -- Idle sets to wear while pet is engaged
    sets.idle.Pet.Engaged = {
        head = "Nyame Helm",
        body = "Nyame Mail",
        hands = "Mpaca's Gloves",
        legs = "Nyame Flanchard",
        feet = "Mpaca's Boots",
        neck = "Shulmanu Collar",
        waist = "Incarnation Sash",
        left_ear = "Enmerkar Earring",
        right_ear = "Crep. Earring",
        left_ring = "Varar Ring +1",
        right_ring = "C. Palug Ring",
        back = gear.jse_pet_tank_back,
    }

    -- 34% DT/PDT + Weapon 4% = 38%
    sets.idle.Pet.Engaged.Tank = set_combine(sets.idle.Pet.Engaged,
        {
            head = "Rao Kabuto +1", -- 4
            body = "Rao Togi +1", -- 4
            hands = "Rao Kote +1", -- 4
            legs = "Rao Haidate +1", -- 4
            feet = "Rao Sune-Ate +1", -- 4
            neck = "Shepherd's Chain", -- 2
            waist = "Isa Belt", -- 3
            left_ear = "Enmerkar Earring", -- 3
            right_ear = "Rimeice Earring", -- 1
            left_ring = "Overbearing Ring",
            right_ring = "C. Palug Ring",
            back = gear.jse_pet_tank_back, -- 5
        })

    sets.idle.Pet.Engaged.Magic = {
        head = "Nyame Helm",
        body = "Nyame Mail",
        hands = "Mpaca's Gloves",
        legs = "Nyame Flanchard",
        feet = "Mpaca's Boots",
        neck = "Adad Amulet",
        waist = "Isa Belt",
        left_ear = "Enmerkar Earring",
        right_ear = "Crep. Earring",
        left_ring = "Varar Ring +1",
        right_ring = "C. Palug Ring",
        back = gear.jse_pet_tank_back,
    }

    sets.idle.Pet.Engaged.Tank = set_combine(sets.idle.Pet.Engaged.Tank, {})
    sets.idle.Pet.Engaged.Ranged = set_combine(sets.idle.Pet.Engaged, {})
    sets.idle.Pet.Engaged.Melee = set_combine(sets.idle.Pet.Engaged, {})
    sets.idle.Pet.Engaged.Heal = sets.idle.Pet.Engaged.Magic
    sets.idle.Pet.Engaged.Nuke = sets.idle.Pet.Engaged.Magic


    -- Defense sets
    sets.defense.PDT = {
        head = "Nyame Helm",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets",
        neck = "Loricate Torque +1",
        waist = gear.mnk_jse_waist,
        left_ear = "Etiolation Earring",
        right_ear = "Odnowa Earring +1",
        left_ring = "Defending Ring",
        right_ring = "Gelatinous Ring +1",
        back = gear.dt_moon_back,
    }

    sets.defense.MDT = sets.defense.PDT
    sets.defense.MEVA = sets.defense.MDT

    sets.Kiting = { feet = "Hermes' Sandals" }

    -- Engaged sets

    -- Normal melee group
    sets.engaged = {
        head = "Malignance Chapeau",
        hands = "Mpaca's Gloves",
        hands = "Malignance Gloves",
        legs = "Malignance Tights",
        feet = "Mpaca's Boots",
        neck = "Combatant's Torque",
        waist = gear.mnk_jse_waist,
        left_ear = "Telos Earring",
        right_ear = "Cessance Earring",
        left_ring = gear.tp_ring,
        right_ring = "Niqmaddu Ring",
        back = gear.jse_da_back,
    }

    sets.engaged.DT = {
        head = "Malignance Chapeau",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        legs = "Malignance Tights",
        feet = "Malignance Boots",
        neck = "Combatant's Torque",
        waist = gear.mnk_jse_waist,
        left_ear = "Telos Earring",
        right_ear = "Cessance Earring",
        left_ring = "Defending Ring",
        right_ring = "Niqmaddu Ring",
        back = gear.jse_da_back,
    }

    sets.engaged.HybridPET = {
        head = "Nyame Helm", -- 6
        body = "Nyame Mail", -- 9
        hands = "Mpaca's Gloves", -- 8
        legs = "Nyame Flanchard", -- 7
        feet = "Mpaca's Boots", -- 6
        neck = "Shulmanu Collar",
        waist = gear.mnk_jse_waist, -- 5
        left_ear = "Telos Earring",
        right_ear = "Enmerkar Earring",
        left_ring = "C. Palug Ring",
        right_ring = "Niqmaddu Ring",
        back = gear.jse_da_back, -- 10
    }

    sets.engaged.PetTank = {
        head = "Rao Kabuto +1", -- 4
        body = "Rao Togi +1", -- 4
        hands = "Rao Kote +1", -- 4
        legs = "Rao Haidate +1", -- 4
        feet = "Rao Sune-Ate +1", -- 4
        neck = "Shepherd's Chain", -- 2
        waist = "Isa Belt", -- 3
        left_ear = "Enmerkar Earring", -- 3
        right_ear = "Rimeice Earring", -- 1
        left_ring = "Overbearing Ring",
        right_ring = "C. Palug Ring",
        back = gear.jse_pet_tank_back, -- 5
    }

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(2, 20)
    elseif player.sub_job == 'NIN' then
        set_macro_page(2, 20)
    elseif player.sub_job == 'THF' then
        set_macro_page(2, 20)
    else
        set_macro_page(2, 20)
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
