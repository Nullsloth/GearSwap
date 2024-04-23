function user_job_setup()
    state.OffenseMode:options('Normal')
    state.HybridMode:options('DT', 'Normal')
    state.RangedMode:options('Normal')
    state.WeaponskillMode:options('Normal')
    state.IdleMode:options('Normal')
    state.AutoZergMode:reset()
    state.MaintainAftermath	= M(true, 'Maintain Aftermath')
    if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
        state.Weapons:options('DualGastra', 'DualArma', 'DualFoma', 'DualAnni', 'DualYoichi', 'DualFailNot', 'DualSavage',
            'DualAeolian', 'DualKCSavage', 'DualKCTrueFlight', 'None')
    else
        state.Weapons:options('Gastraphetes', 'Armageddon', 'Fomalhaut', 'Annihilator', 'Yoichinoyumi', 'FailNot',
            'Naegling', 'Tauret', 'None')
    end
    --state.Weapons:options('DualGastra','DualFoma','DualAnni','DualYoichi','DualFailNot','DualSavage','Gastraphetes','Fomalhaut','Annihilator','Yoichinoyumi','FailNot','Naegling','None')
    --state.Weapons:options('Fomalhaut','Annihilator','Gastraphetes','Yoichinoyumi','FailNot','Naegling','DualFoma','DualAnni','DualGastra','DualYoichi','DualFailNot','DualKCSavage','DualKCTrueFlight','None')

    WeaponType = {
        ['Fail-Not'] = "Bow",
        ['Yoichinoyumi'] = "Bow",
        ['Sparrowhawk +2'] = "Bow",
        ['Fomalhaut'] = "Gun",
        ['Armageddon'] = "Gun",
        ['Anarchy +2'] = "Gun",
        ['Annihilator'] = "Gun",
        ['Gastraphetes'] = "Crossbow",
    }

    DefaultAmmo = {
        ['Bow']      = {
            ['Default'] = "Yoichi's Arrow",
            ['WS'] = "Yoichi's Arrow",
            ['Acc'] = "Yoichi's Arrow",
            ['Magic'] = "Yoichi's Arrow",
            ['MagicAcc'] = "Yoichi's Arrow",
            ['Unlimited'] = "Yoichi's Arrow",
            ['MagicUnlimited'] = "Yoichi's Arrow",
            ['MagicAccUnlimited'] = "Yoichi's Arrow"
        },

        ['Gun']      = {
            ['Default'] = "Chrono Bullet",
            ['WS'] = "Chrono Bullet",
            ['Acc'] = "Chrono Bullet",
            ['Magic'] = "Chrono Bullet",
            ['MagicAcc'] = "Chrono Bullet",
            ['Unlimited'] = "Chrono Bullet",
            ['MagicUnlimited'] = "Chrono Bullet",
            ['MagicAccUnlimited'] = "Chrono Bullet"
        },

        ['Crossbow'] = {
            ['Default'] = "Quelling Bolt",
            ['WS'] = "Quelling Bolt",
            ['Acc'] = "Quelling Bolt",
            ['Magic'] = "Quelling Bolt",
            ['MagicAcc'] = "Quelling Bolt",
            ['Unlimited'] = "Quelling Bolt",
            ['MagicUnlimited'] = "Quelling Bolt",
            ['MagicAccUnlimited'] = "Quelling Bolt"
        }

    }

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
	

    gear.jse_agi_back = { name = "Belenus's Cape", augments = { 'AGI+20', 'Rng.Acc.+20 Rng.Atk.+20', 'AGI+10', 'Weapon skill damage +10%', 'Phys. dmg. taken-10%', } }
    gear.jse_mab_back = { name = "Belenus's Cape", augments = { 'AGI+20', 'Mag. Acc+20 /Mag. Dmg.+20', 'AGI+10', 'Weapon skill damage +10%', 'Phys. dmg. taken-10%', } }
    gear.jse_midshot_back = { name = "Belenus's Cape", augments = { 'AGI+20', 'Rng.Acc.+20 Rng.Atk.+20', 'Rng.Acc.+10', '"Store TP"+10', 'Phys. dmg. taken-10%', } }
    gear.jse_snapshot_back = { name = "Belenus's Cape", augments = { 'Snapshot +10', } }
    gear.jse_tp_back = { name = "Belenus's Cape", augments = { 'DEX+20', 'Accuracy+20 Attack+20', '"Dbl.Atk."+10', 'Accuracy+10', 'Phys. dmg. taken-10%', } }
    gear.jse_str_back = { name = "Belenus's Cape", augments = { 'STR+20', 'Accuracy+20 Attack+20', 'STR+10', 'Weapon skill damage +10%', 'Phys. dmg. taken-10%', } }
    gear.jse_crit_back = { name = "Belenus's Cape", augments = { 'AGI+20', 'Rng.Acc.+20 Rng.Atk.+20', 'Rng.Acc.+10', 'Crit.hit rate+10', 'Phys. dmg. taken-10%', } }

    -- Additional local binds
    send_command('bind !` input /ra <t>')
    send_command('bind !backspace input /ja "Bounty Shot" <t>')
    send_command('bind @f7 gs c toggle RngHelper')
    send_command('bind @` input /ja "Velocity Shot" <me>')
    send_command('lua l hovershot')
    ammostock = 198
    rangedautows = 'Last Stand'
    select_default_macro_book()
end

function init_gear_sets()
    --autows_list = {['Gastraphetes']='Trueflight',['Armageddon']='Wildfire',['Fomalhaut']='Last Stand',['Annihilator']='Last Stand',['Yoichinoyumi']='Namas Arrow',['FailNot']='Apex Arrow',['Naegling']='Savage Blade',['DualGastra']='Trueflight',['DualArma']='Wildfire',['DualFoma']='Last Stand',['DualAnni']='Last Stand',['DualYoichi']='Namas Arrow',['DualFailNot']='Apex Arrow',['DualSavage']='Savage Blade',}

if item_available("Amini Earring +2") then
	gear.empy_earring = "Amini Earring +2"
elseif item_available("Amini Earring +1") then
	gear.empy_earring = "Amini Earring +1"
elseif item_available("Amini Earring") then
	gear.empy_earring = "Amini Earring"
else
	gear.empy_earring = "Telos Earring"
end

if item_available("Amini Caban +3") then
	gear.jse_empy_body = "Amini Caban +3"
else
	gear.jse_empy_body = "Amini Caban +2"
end

if item_available("Amini Glove. +3") then
	gear.jse_empy_hands = "Amini Glove. +3"
else
	gear.jse_empy_hands = "Amini Glove. +2"
end

if item_available("Amini Bragues +3") then
	gear.jse_empy_legs = "Amini Bragues +3"
else
	gear.jse_empy_legs = "Amini Bragues +2"
end

-- Weapons sets
sets.weapons.Gastraphetes = {main="Tauret",sub="Nusku Shield",range="Gastraphetes",ammo="Quelling Bolt"}
sets.weapons.Armageddon = {main="Perun +1",sub="Nusku Shield",range="Armageddon",ammo="Chrono Bullet"}
sets.weapons.Fomalhaut = {main="Perun +1",sub="Nusku Shield",range="Fomalhaut",ammo="Chrono Bullet"}
sets.weapons.Annihilator = {main="Perun +1",sub="Nusku Shield",range="Annihilator",ammo="Chrono Bullet"}
sets.weapons.Yoichinoyumi = {main="Perun +1",sub="Nusku Shield",range="Yoichinoyumi",ammo="Chrono Arrow"}
sets.weapons.FailNot = {main="Perun +1",sub="Nusku Shield",range="Fail-Not",ammo="Chrono Arrow"}
sets.weapons.Naegling = {main="Naegling",sub="Nusku Shield",range="Sparrowhawk +2"}
sets.weapons.Tauret = {main="Tauret",sub="Nusku Shield",range="Sparrowhawk +2"}
-- K club
sets.weapons.DualKCSavage = {main="Naegling",sub="Kraken Club",range="Sparrowhawk +2"}
sets.weapons.DualKCTrueFlight = {main="Tauret",sub="Kraken Club",range="Gastraphetes",ammo="Quelling Bolt"}
-- DW
sets.weapons.DualGastra = {main="Tauret",sub="Gleti's Knife",range="Gastraphetes",ammo="Quelling Bolt"}
sets.weapons.DualArma = {main="Tauret",sub="Gleti's Knife",range="Armageddon",ammo="Chrono Bullet"}
sets.weapons.DualFoma = {main="Perun +1",sub="Kustawi +1",range="Fomalhaut",ammo="Chrono Bullet"}
sets.weapons.DualAnni = {main="Perun +1",sub="Kustawi +1",range="Annihilator",ammo="Chrono Bullet"}
sets.weapons.DualYoichi = {main="Perun +1",sub="Kustawi +1",range="Yoichinoyumi",ammo="Chrono Arrow"}
sets.weapons.DualFailNot = {main="Perun +1",sub="Kustawi +1",range="Fail-Not",ammo="Chrono Arrow"}
sets.weapons.DualSavage = {main="Naegling",sub="Gleti's Knife",range="Sparrowhawk +2"}
sets.weapons.DualAeolian = {main="Tauret",sub="Malevolence",range="Sparrowhawk +2"}

--------------------------------------
-- Precast sets
--------------------------------------

-- Precast sets to enhance JAs
sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
sets.precast.JA['Bounty Shot'] = set_combine(sets.TreasureHunter, {})	--{hands="Amini Glove. +1"}
sets.precast.JA['Camouflage'] = {}	--{body="Orion Jerkin +1"}
sets.precast.JA['Scavenge'] = {}	--{feet="Orion Socks +1"}
sets.precast.JA['Shadowbind'] = {hands="Orion Bracers +3"}
sets.precast.JA['Sharpshot'] = {legs="Orion Braccae +3"}
sets.precast.JA['Double Shot'] = {body="Arc. Jerkin +3", back=gear.jse_midshot_back}
sets.precast.JA['Velocity Shot'] = {body=gear.jse_empy_body}

-- Fast cast sets for spells
sets.precast.FC = {
	head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
	body="Adhemar Jacket +1",
	hands="Leyline Gloves",
	legs={ name="Rawhide Trousers", augments={'MP+50','"Fast Cast"+5','"Refresh"+1',}},
	feet={ name="Carmine Greaves +1", augments={'HP+80','MP+80','Phys. dmg. taken -4',}},
	neck="Baetyl Pendant",
	waist="Flume Belt +1",
	left_ear="Loquac. Earring",
	right_ear="Etiolation Earring",
	left_ring=gear.weather_ring,
	right_ring="Medada's Ring",
}

sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {body="Passion Jacket"})

-- Ranged sets (snapshot)

-- (10% Snapshot, 5% Rapid from Merits)
-- Snapshot: the cap is simply 70% and all sources count.
-- Flurry I = 15% snapshot	-- Flurry II = 30% snapshot
-- merit 10%
-- Rapid Shot no cap
-- Snapshot cap = 70%, 5/5 Snapshot merits = 10%, so:
	-- Flurry 2: need 30 snapshot
	-- Flurry 1: need 45 snapshot
	-- Flurry 0: need 60 snapshot 

-- 60% + 10% = 70%
sets.precast.RA = {
	head={ name="Taeon Chapeau", augments={'"Snapshot"+5','"Snapshot"+5',}},							-- 10
	body=gear.jse_empy_body,
	hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},	-- 8
	legs="Orion Braccae +3",																			-- 15
	feet="Meg. Jam. +2",																				-- 10
	neck="Scout's Gorget +2",																			-- 4
	waist="Yemaya Belt",
	left_ear="Odnowa Earring +1",
	right_ear="Etiolation Earring",
	left_ring="Defending Ring",
	right_ring="Crepuscular Ring",																		-- 3
	back=gear.jse_snapshot_back,																		-- 10
}
	
sets.precast.RA.Flurry = set_combine(sets.precast.RA, {})
sets.precast.RA.Flurry2 = set_combine(sets.precast.RA, {})


-- Weaponskill sets
-- Default set for any weaponskill that isn't any more specifically defined
-- 51% WSD
sets.precast.WS = {
	head="Nyame Helm",
	body="Nyame Mail",
	hands="Nyame Gauntlets",
	legs="Nyame Flanchard",						
	feet="Nyame Sollerets",
	neck="Fotia Gorget",
	waist="Fotia Belt",
	left_ear="Moonshade Earring",
	right_ear="Telos Earring",
	left_ring="Regal Ring",
	right_ring="Dingir Ring",																								
	back=gear.jse_agi_back,
}

-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

sets.precast.WS['Last Stand'] = {
	head="Nyame Helm",
	body=gear.jse_empy_body,
	hands="Nyame Gauntlets",
	legs="Nyame Flanchard",						
	feet="Nyame Sollerets",
	neck="Fotia Gorget",
	waist="Fotia Belt",
	left_ear="Moonshade Earring",
	right_ear=gear.empy_earring,
	left_ring="Regal Ring",
	right_ring="Dingir Ring",																								
	back=gear.jse_agi_back,
}

sets.precast.WS['Coronach'] = {
	head="Nyame Helm",
	body=gear.jse_empy_body,
	hands="Nyame Gauntlets",
	legs="Nyame Flanchard",						
	feet="Nyame Sollerets",
	neck="Fotia Gorget",
	waist="Fotia Belt",
	left_ear="Moonshade Earring",
	right_ear=gear.empy_earring,
	left_ring="Regal Ring",
	right_ring="Dingir Ring",																								
	back=gear.jse_agi_back,
}
	
sets.precast.WS['Wildfire'] = {
	head="Nyame Helm",
	body="Nyame Mail",
	hands="Nyame Gauntlets",
	legs="Nyame Flanchard",
	feet="Nyame Sollerets",
	neck="Scout's Gorget +2",
	waist="Eschan Stone",
	left_ear="Moonshade Earring",
	right_ear="Friomisi Earring",
	left_ring="Medada's Ring",
	right_ring="Dingir Ring",
	back=gear.jse_mab_back,
}

sets.precast.WS['Hotshot'] = set_combine(sets.precast.WS['Wildfire'], {left_ear="Ishvara Earring",right_ring="Beithir Ring"})
sets.precast.WS['Trueflight'] = set_combine(sets.precast.WS['Wildfire'], {left_ring=gear.weather_ring,})

sets.precast.WS['Jishnu\'s Radiance'] = {
	head="Nyame Helm",
	body=gear.jse_empy_body,
	hands=gear.jse_empy_hands,
	legs="Nyame Flanchard",
	feet="Nyame Sollerets",
	neck="Fotia Gorget",
	waist="Fotia Belt",
	left_ear="Odr Earring",
	right_ear=gear.empy_earring,
	left_ring="Regal Ring",
	right_ring="Dingir Ring",
	back=gear.jse_agi_back,
}

sets.precast.WS['Namas Arrow'] = set_combine(sets.precast.WS['Jishnu\'s Radiance'], {left_ear="Ishvara Earring",right_ring="Beithir Ring"})
sets.precast.WS['Apex Arrow'] = set_combine(sets.precast.WS['Jishnu\'s Radiance'], {left_ear="Ishvara Earring",right_ring="Beithir Ring"})

sets.precast.WS['Flaming Arrow'] = {
	head="Nyame Helm",
	body="Nyame Mail",
	hands="Nyame Gauntlets",
	legs="Nyame Flanchard",
	feet="Nyame Sollerets",
	neck="Fotia Gorget",
	waist="Eschan Stone",
	left_ear="Moonshade Earring",
	right_ear=gear.empy_earring,
	left_ring="Medada's Ring",
	right_ring="Beithir Ring",
	back=gear.jse_mab_back,
}

sets.precast.WS['Savage Blade'] = {
	ammo="Hauksbok Arrow",
	head="Nyame Helm",
	body="Nyame Mail",
	hands="Nyame Gauntlets",
	legs="Nyame Flanchard",
	feet="Nyame Sollerets",
	neck="Fotia Gorget",
	waist="Sailfi Belt +1",
	left_ear="Moonshade Earring",
	right_ear=gear.empy_earring,
	left_ring="Regal Ring",
	right_ring="Beithir Ring",
	back=gear.jse_str_back,
}

sets.precast.WS['Aeolian Edge'] = {
	ammo="Hauksbok Arrow",
	head="Nyame Helm",
	body="Nyame Mail",
	hands="Nyame Gauntlets",
	legs="Nyame Flanchard",
	feet="Nyame Sollerets",
	neck="Baetyl Pendant",
	waist="Eschan Stone",
	left_ear="Moonshade Earring",
	right_ear="Friomisi Earring",
	left_ring="Dingir Ring",
	right_ring="Medada's Ring",
	back=gear.jse_mab_back,
}

-- Swap to these on Moonshade using WS if at 3000 TP
sets.MaxTP = {}
sets.AccMaxTP = {}

--------------------------------------
-- Midcast sets
--------------------------------------

-- Fast recast for spells
sets.midcast.FastRecast = sets.precast.FC
	
-- Ranged sets
sets.midcast.RA = {
	head={ name="Arcadian Beret +3", augments={'Enhances "Recycle" effect',}},
	body="Ikenga's Vest",
	hands=gear.jse_empy_hands,
	legs=gear.jse_empy_legs,
	feet="Ikenga's Clogs",
	neck="Scout's Gorget +2",
	waist="Yemaya Belt",
	left_ear="Crepuscular Earring",
	right_ear="Telos Earring",
	left_ring="Regal Ring",
	right_ring="Ilabrat Ring",
	back=gear.jse_midshot_back,
}

sets.midcast.RA.AM = {
	head="Meghanada Visor +2",
	body="Nisroch Jerkin",
	hands=gear.jse_empy_hands,
	legs=gear.jse_empy_legs,
	feet="Osh. Leggings +1",
	neck="Scout's Gorget +2",
	waist="K. Kachina Belt +1",
	left_ear="Odr Earring",
	right_ear=gear.empy_earring,
	left_ring="Regal Ring",
	right_ring="Ilabrat Ring",
	back=gear.jse_crit_back,
}

--These sets will overlay based on accuracy level, regardless of other options.
sets.buff.Camouflage = {}
sets.buff['Double Shot'] = {head="Arcadian Beret +3", body="Arc. Jerkin +3", hands="Oshosi Gloves +1", legs="Osh. Trousers +1", feet="Osh. Leggings +1", back=gear.jse_midshot_back,}
sets.buff.Barrage = {head="Ikenga's Hat", body="Ikenga's Vest",hands="Orion Bracers +3", legs="Ikenga's Trousers", feet="Ikenga's Clogs", waist="K. Kachina Belt +1", right_ear=gear.empy_earring}

sets.Self_Healing = {waist="Gishdubar Sash"}
sets.Cure_Received = {waist="Gishdubar Sash"}
sets.Self_Refresh = {waist="Gishdubar Sash"}

sets.midcast.Utsusemi = sets.midcast.FastRecast

--------------------------------------
-- Idle/resting/defense/etc sets
--------------------------------------

-- Idle sets
sets.idle = {
	head="Malignance Chapeau",
	body="Malignance Tabard",
	hands="Malignance Gloves",					
	legs="Malignance Tights",
	feet="Malignance Boots",					
	neck="Sanctity Necklace",
	waist="Flume Belt +1",
	left_ear="Infused Earring",
	right_ear="Etiolation Earring",
	left_ring="Defending Ring",					
	right_ring="Gelatinous Ring +1",
	back=gear.jse_midshot_back,				
}
sets.resting = sets.idle

sets.idle.Town = {
	head="Nyame Helm",
	body="Nisroch Jerkin",
	hands="Nyame Gauntlets",
	legs="Nyame Flanchard",
	feet="Nyame Sollerets",
	neck="Scout's Gorget +2",
	waist="Windbuffet Belt +1",
	left_ear="Crepuscular Earring",
	right_ear="Telos Earring",
	left_ring="Regal Ring",
	right_ring="Dingir Ring",
	back=gear.jse_midshot_back,
}

-- Defense sets
sets.defense.PDT = {
	head="Nyame Helm",
	body="Nyame Mail",
	hands="Nyame Gauntlets",
	legs="Nyame Flanchard",
	feet="Nyame Sollerets",
	neck="Loricate Torque +1",
	waist="Flume Belt +1",
	left_ear="Odnowa Earring +1",
	right_ear="Etiolation Earring",
	left_ring="Defending Ring",
	right_ring="Gelatinous Ring +1",
	back=gear.dt_moon_back,
}

sets.defense.MDT = sets.defense.PDT
sets.defense.MEVA = sets.defense.PDT

sets.Kiting = {legs="Carmine Cuisses +1"}
--------------------------------------
-- Engaged sets
--------------------------------------

sets.engaged = {
	head="Malignance Chapeau",
	body="Malignance Tabard",
	hands="Malignance Gloves",
	legs="Malignance Tights",
	feet="Malignance Boots",
	neck="Combatant's Torque",
	waist="Windbuffet Belt +1",
	left_ear="Sherida Earring",
	right_ear=gear.empy_earring,
	left_ring="Petrov Ring",
	right_ring="Chirich Ring +1",
	back=gear.jse_tp_back,
}

sets.engaged.DT = {
	head="Malignance Chapeau",
	body="Malignance Tabard",
	hands="Malignance Gloves",
	legs="Malignance Tights",
	feet="Malignance Boots",
	neck="Combatant's Torque",
	waist="Windbuffet Belt +1",
	left_ear="Sherida Earring",
	right_ear=gear.empy_earring,
	left_ring="Defending Ring",
	right_ring="Chirich Ring +1",
	back=gear.jse_tp_back,
}
	
sets.engaged.DW = set_combine(sets.engaged, {left_ear="Suppanomimi"})
sets.engaged.DW.DT = set_combine(sets.engaged.DT, {left_ear="Suppanomimi"})

--------------------------------------
-- Custom buff sets
--------------------------------------
sets.buff.Doom = set_combine(sets.buff.Doom, {})
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
