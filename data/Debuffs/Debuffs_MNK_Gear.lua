function user_job_setup()
    state.OffenseMode:options('Normal')
    state.WeaponskillMode:options('Normal', 'Enmity', 'Tank')
    state.HybridMode:options('Normal', 'DT', 'SubtleBlow', 'Tank')
    state.PhysicalDefenseMode:options('PDT')
    state.MagicalDefenseMode:options('MDT')
    state.ResistDefenseMode:options('MEVA')
    state.IdleMode:options('Normal')
    state.Weapons:options('Verethragna', 'Godhands', 'Malignance', 'None')
    state.AutoJumpMode = M(false, 'Auto Jump Mode')
    state.MaintainAftermath = M(false, 'Maintain Aftermath')
    state.AutoZergMode:reset()
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


    autows = "Victory Smite"
    autows_list = {
        ['Tizbron'] = 'Expiacion',
        ['Tizalmace'] = 'Expiacion',
        ['Almace'] = 'Chant Du Cygne',
        ['MeleeClubs'] = 'Realmrazer',
        ['HybridWeapons'] = 'Sanguine Blade',
        ['Naegbron'] = 'Savage Blade',
        ['Naegmace'] = 'Savage Blade'
    }

    gear.jse_da_back = { name = "Segomo's Mantle", augments = { 'DEX+20', 'Accuracy+20 Attack+20', '"Dbl.Atk."+10', 'Accuracy+10', 'Phys. dmg. taken-10%', } }
    gear.jse_crit_back = { name = "Segomo's Mantle", augments = { 'STR+20', 'Accuracy+20 Attack+20', 'Crit.hit rate+10', 'STR+10', 'Phys. dmg. taken-10%', } }
    gear.jse_wsd_back = { name = "Segomo's Mantle", augments = { 'VIT+20', 'Accuracy+20 Attack+20', 'Weapon skill damage +10%', 'VIT+10', 'Phys. dmg. taken-10%', } }

    -- Additional local binds
    send_command('bind ^` input /ja "Boost" <me>')
    send_command('bind !` input /ja "Impetus" <me>')
    send_command('bind ^backspace input /ja "Mantra" <me>')
    send_command('bind @` input /ja "Perfect Counter" <me>')
    send_command('bind ^\\\\ input /ja "Provoke" <t>')

    select_default_macro_book()
end

function init_gear_sets()
    if item_available("Bhikku Earring +2") then
        gear.empy_earring = "Bhikku Earring +2"
    elseif item_available("Bhikku Earring +1") then
        gear.empy_earring = "Bhikku Earring +1"
    else
        gear.empy_earring = "Bhikku Earring"
    end
    
    if item_available("Bhikku Cyclas +3") then
        gear.jse_empy_body = "Bhikku Cyclas +3"
    elseif item_available("Bhikku Cyclas +2") then
        gear.jse_empy_body = "Bhikku Cyclas +2"
    else
        gear.jse_empy_body = "Bhikku Cyclas +1"
    end
    
    if item_available("Bhikku Hose +3") then
        gear.jse_empy_legs = "Bhikku Hose +3"
    elseif item_available("Bhikku Hose +2") then
        gear.jse_empy_legs = "Bhikku Hose +2"
    else
        gear.jse_empy_legs = "Bhikku Hose +1"
    end
    
    -- Weapons sets
    sets.weapons.Verethragna = {main="Verethragna"}
    sets.weapons.Godhands = {main="Godhands"}
    sets.weapons.Malignance = {main="Malignance Pole"}
    
    -- Precast Sets
    sets.precast.JA['Hundred Fists'] = {legs="Hesychast's Hose +3"}
    sets.precast.JA['Boost'] = {}
    sets.precast.JA['Dodge'] = {feet="Anchorite's Gaiters +3"}
    sets.precast.JA['Focus'] = {head="Anchorite's Crown +2"}
    sets.precast.JA['Counterstance'] = {feet="Hes. Gaiters +3"}
    sets.precast.JA['Footwork'] = {feet="Shukuyu Sune-Ate"}
    sets.precast.JA['Formless Strikes'] = {}
    sets.precast.JA['Mantra'] = {feet="Hes. Gaiters +3"}
    
    sets.precast.JA['Chi Blast'] = {head="Hes. Crown +3"}
    
    sets.precast.JA['Chakra'] = {
        body="Anch. Cyclas +3",
        hands="Hes. Gloves +3",
    }
    
    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
    sets.precast.Waltz['Healing Waltz'] = {}
    sets.precast.Step = {}
    sets.precast.Flourish1 = {}
    
    -- Fast cast sets for spells
    
    sets.precast.FC = {
        ammo="Impatiens",
        neck="Baetyl Pendant",
        body="Adhemar Jacket +1",
        hands="Leyline Gloves",
        legs="Rawhide Trousers",
        left_ear="Loquacious Earring",
        left_ring=gear.weather_ring,
        right_ring="Medada's Ring",
    }
    
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads",body="Passion Jacket"})
    
     
    -- Weaponskill sets
    sets.precast.WS = {
        ammo="Knobkierrie",
        head="Mpaca's Cap",
        body="Nyame Mail",
        hands="Nyame Gauntlets",		
        legs="Nyame Flanchard",
        feet="Nyame Sollerets",
        neck="Mnk. Nodowa +2",
        waist=gear.mnk_tp_waist,
        left_ear="Sherida Earring",
        right_ear="Moonshade Earring",
        left_ring="Gere Ring",
        right_ring="Niqmaddu Ring",
        back=gear.jse_wsd_back,
    }
    
    sets.precast.WS.Multi = {
        ammo="Coiste Bodhar",
        head="Mpaca's Cap",
        body="Mpaca's Doublet",
        hands="Mpaca's Gloves",		
        legs="Mpaca's Hose",
        feet="Mpaca's Boots",
        neck="Mnk. Nodowa +2",
        waist=gear.mnk_tp_waist,
        left_ear="Sherida Earring",
        right_ear="Moonshade Earring",
        left_ring="Gere Ring",
        right_ring="Niqmaddu Ring",
        back=gear.jse_wsd_back,
    }
        
    sets.precast.WS.Enmity = set_combine(sets.precast.WS, {left_ear="Schere Earring"})
    sets.precast.WS.Tank = set_combine(sets.precast.WS, {})
    
    -- Specific weaponskill sets.
    
    sets.precast.WS["Victory Smite"]   = set_combine(sets.precast.WS.Multi, {back=gear.jse_crit_back,})
    
    sets.precast.WS['Raging Fists']    = set_combine(sets.precast.WS.Multi, {back=gear.jse_crit_back,})
    sets.precast.WS['Howling Fist']    = set_combine(sets.precast.WS.Multi, {})
    sets.precast.WS['Shijin Spiral']   = set_combine(sets.precast.WS.Multi,	{back=gear.jse_da_back,})
    sets.precast.WS['Asuran Fists']    = set_combine(sets.precast.WS.Multi, {back=gear.jse_da_back,})
    sets.precast.WS["Ascetic's Fury"]  = set_combine(sets.precast.WS.Multi, {})
    
    sets.precast.WS['Dragon Kick']     = set_combine(sets.precast.WS.Multi, {legs="Mpaca's Hose", feet="Anch. Gaiters +3"})
    sets.precast.WS['Tornado Kick']    = set_combine(sets.precast.WS.Multi, {legs="Mpaca's Hose", feet="Anch. Gaiters +3"})
    sets.precast.WS['Spinning Attack'] = set_combine(sets.precast.WS.Multi, {back=gear.jse_da_back,})
    sets.precast.WS['Shell Crusher']   = set_combine(sets.precast.WS.Multi, {
        ammo="Pemphredo Tathlum",
        neck="Sanctity Necklace",
        waist="Luminary Sash",
        left_ear="Digni. Earring",
        right_ear="Crep. Earring",
        left_ring="Medada's Ring",
        right_ring="Metamor. Ring +1",
        back=gear.jse_da_back,
    })
    
    
    -- Enmity
    sets.precast.WS["Raging Fists"].Enmity = set_combine(sets.precast.WS["Raging Fists"], {left_ear="Schere Earring"})
    sets.precast.WS["Howling Fist"].Enmity = set_combine(sets.precast.WS["Howling Fist"], {left_ear="Schere Earring"})
    sets.precast.WS["Asuran Fists"].Enmity = set_combine(sets.precast.WS["Asuran Fists"], {left_ear="Schere Earring"})
    sets.precast.WS["Ascetic's Fury"].Enmity = set_combine(sets.precast.WS["Ascetic's Fury"], {left_ear="Schere Earring"})
    sets.precast.WS["Victory Smite"].Enmity = set_combine(sets.precast.WS["Victory Smite"], {left_ear="Schere Earring"})
    sets.precast.WS["Shijin Spiral"].Enmity = set_combine(sets.precast.WS["Shijin Spiral"], {left_ear="Schere Earring"})
    sets.precast.WS["Dragon Kick"].Enmity = set_combine(sets.precast.WS["Dragon Kick"], {left_ear="Schere Earring"})
    sets.precast.WS["Tornado Kick"].Enmity = set_combine(sets.precast.WS["Tornado Kick"], {left_ear="Schere Earring"})
    sets.precast.WS["Shell Crusher"].Enmity = set_combine(sets.precast.WS["Shell Crusher"], {})
    
    -- Tank
    sets.precast.WS["Raging Fists"].Tank = set_combine(sets.precast.WS["Raging Fists"], sets.precast.WS.Tank)
    sets.precast.WS["Howling Fist"].Tank = set_combine(sets.precast.WS["Howling Fist"], sets.precast.WS.Tank)
    sets.precast.WS["Asuran Fists"].Tank = set_combine(sets.precast.WS["Asuran Fists"], sets.precast.WS.Tank)
    sets.precast.WS["Ascetic's Fury"].Tank = set_combine(sets.precast.WS["Ascetic's Fury"], sets.precast.WS.Tank)
    sets.precast.WS["Victory Smite"].Tank = set_combine(sets.precast.WS["Victory Smite"], sets.precast.WS.Tank)
    sets.precast.WS["Shijin Spiral"].Tank = set_combine(sets.precast.WS["Shijin Spiral"], sets.precast.WS.Tank)
    sets.precast.WS["Dragon Kick"].Tank = set_combine(sets.precast.WS["Dragon Kick"], sets.precast.WS.Tank)
    sets.precast.WS["Tornado Kick"].Tank = set_combine(sets.precast.WS["Tornado Kick"], sets.precast.WS.Tank)
    sets.precast.WS["Shell Crusher"].Tank = set_combine(sets.precast.WS["Shell Crusher"], {})
    
    -- Swap to these on Moonshade using WS if at 3000 TP
    sets.MaxTP = {ear1="Sherida Earring",ear2="Telos Earring",}
    sets.AccMaxTP = {ear1="Sherida Earring",ear2="Telos Earring"}
    
    -- Midcast Sets
    sets.midcast.FastRecast = sets.precast.FC
    sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {})
    
    -- Idle sets
    sets.idle = {
        ammo=gear.dt_ammo,
        head="Malignance Chapeau",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        legs="Malignance Tights",
        feet="Malignance Boots",
        neck="Sanctity Necklace",
        waist=gear.mnk_tp_waist,
        left_ear="Infused Earring",
        right_ear="Etiolation Earring",
        left_ring="Defending Ring",
        right_ring="Gelatinous Ring +1",
        back=gear.jse_da_back,
    }
    
    sets.resting = sets.idle
    sets.idle.Weak = sets.idle
        
    sets.idle.Town = {
        ammo="Coiste Bodhar",
        head="Mpaca's Cap",
        body="Mpaca's Doublet",
        hands="Mpaca's Gloves",		
        legs="Mpaca's Hose",
        feet="Mpaca's Boots",
        neck="Mnk. Nodowa +2",
        waist=gear.mnk_tp_waist,
        left_ear="Sherida Earring",
        right_ear="Telos Earring",
        left_ring="Gere Ring",
        right_ring="Niqmaddu Ring",
        back=gear.jse_da_back,
    }
    
    -- Defense sets
    sets.defense.PDT = {
        ammo=gear.dt_ammo,															-- 3
        head="Nyame Helm",																	-- 7
        body="Nyame Mail",																	-- 10
        hands="Nyame Gauntlets",
        legs="Nyame Flanchard",																
        feet="Nyame Sollerets",
        neck="Loricate Torque +1",
        waist=gear.mnk_tp_waist,															-- 6
        left_ear="Etiolation Earring",
        right_ear="Odnowa Earring +1",
        left_ring="Defending Ring",															-- 10
        right_ring="Gelatinous Ring +1",
        back=gear.jse_da_back,																-- 10
    }
        
    sets.defense.MDT = sets.defense.PDT
    sets.defense.MEVA = sets.defense.MDT
    
    sets.Kiting = {feet=gear.movement_gaiters_feet}
    
    -- Engaged sets
    
    -- MNK: 35 (Tier I)
    -- Tier I: 45
    -- Tier II: 30
    -- Total: 75 (75 Cap)
    sets.engaged = {
        ammo="Coiste Bodhar",
        head="Malignance Chapeau",
        body="Mpaca's Doublet",
        hands="Malignance Gloves",	
        legs=gear.jse_empy_legs,
        feet="Malignance Boots",
        neck="Mnk. Nodowa +2",
        waist=gear.mnk_tp_waist,					-- 15 II
        left_ear="Sherida Earring",					-- 5 II
        right_ear=gear.empy_earring,
        left_ring=gear.mnk_tp_ring,					-- 10
        right_ring="Niqmaddu Ring",					-- 5 II
        back=gear.jse_da_back,
    }
    
    sets.engaged.DT = {
        ammo=gear.dt_ammo,																	-- 3
        head="Malignance Chapeau",
        body="Malignance Tabard",
        hands="Malignance Gloves",															-- 5
        legs="Malignance Tights",
        feet="Malignance Boots",
        neck="Mnk. Nodowa +2",
        waist=gear.mnk_tp_waist,															-- 6
        left_ear="Sherida Earring",
        right_ear=gear.empy_earring,
        left_ring=gear.mnk_tp_ring,															-- 10
        right_ring="Niqmaddu Ring",
        back=gear.jse_da_back,																-- 10
    }
    
    sets.engaged.SubtleBlow = {
        ammo="Coiste Bodhar",
        head="Malignance Chapeau",
        body="Mpaca's Doublet",
        hands="Malignance Gloves",	
        legs="Mpaca's Hose",						-- 5
        feet="Malignance Boots",
        neck="Mnk. Nodowa +2",
        waist=gear.mnk_tp_waist,					-- 15 II
        left_ear="Sherida Earring",					-- 5 II
        right_ear=gear.empy_earring,
        left_ring=gear.mnk_tp_ring,					-- 10
        right_ring="Niqmaddu Ring",					-- 5 II
        back=gear.jse_da_back,
    }
    
    sets.engaged.Tank = {
        ammo=gear.dt_ammo,			
        head="Malignance Chapeau",
        body="Nyame Mail",
        hands="Malignance Gloves",
        legs="Nyame Flanchard",
        feet="Malignance Boots",
        neck="Mnk. Nodowa +2",
        waist=gear.mnk_tp_waist,
        left_ear="Sherida Earring",
        right_ear=gear.empy_earring,
        left_ring=gear.mnk_tp_ring,
        right_ring="Niqmaddu Ring",
        back=gear.jse_da_back,
    }
    
    sets.engaged.HF = set_combine(sets.engaged, {})
    
    sets.buff.Doom = set_combine(sets.buff.Doom, {})
    sets.buff.Impetus = {body=gear.jse_empy_body, feet="Nyame Sollerets", ammo=gear.dt_ammo}
    sets.buff.Footwork = {legs=gear.jse_empy_legs, feet="Anch. Gaiters +3"}
    sets.buff.Boost = {}
    
    sets.FootworkWS = {legs=gear.jse_empy_legs, feet="Anch. Gaiters +3"}
    sets.DayIdle = {}
    sets.NightIdle = {}
    sets.Knockback = {}
    sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
    sets.Skillchain = {}
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
