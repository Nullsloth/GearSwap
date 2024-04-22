function user_job_setup()

    state.OffenseMode:options('Normal')
    state.HybridMode:options('DT', 'Normal')
    state.WeaponskillMode:options('Normal')
    state.IdleMode:options('DT', 'Normal')
    state.PhysicalDefenseMode:options('PDT')
    state.MagicalDefenseMode:options('MDT')
    state.ResistDefenseMode:options('MEVA')
    state.Weapons:options('Terpsichore', 'Aeneas', 'Karambit', 'None')
    state.ExtraMeleeMode = M { ['description'] = 'Extra Melee Mode', 'None' }
    state.AutoJumpMode = M(false, 'Auto Jump Mode')
    state.MaintainAftermath = M(false, 'Maintain Aftermath')
    state.MainStep = M { ['description'] = 'Main Step', 'Box Step', 'Quickstep', 'Stutter Step', 'Feather Step' }
    state.AltStep = M { ['description'] = 'Alt Step', 'Quickstep', 'Box Step', 'Stutter Step', 'Feather Step' }
    state.UseAltStep = M(false, 'Use Alt Step')
    state.CurrentStep = M { ['description'] = 'Current Step', 'Main', 'Alt' }
    state.AutoSambaMode = M { ['description'] = 'Auto Samba Mode', 'Off', 'Haste' }
    state.AutoContradanceMode = M(true, 'Auto Contradance Mode')
    state.AutoPrestoMode = M(true, 'Auto Presto Mode')
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

    gear.jse_stp_back = { name = "Senuna's Mantle", augments = { 'DEX+20', 'Accuracy+20 Attack+20', 'Accuracy+10', '"Store TP"+10', 'Phys. dmg. taken-10%', } }
    gear.jse_wsd_back = { name = "Senuna's Mantle", augments = { 'DEX+20', 'Accuracy+20 Attack+20', 'DEX+10', 'Weapon skill damage +10%', 'Phys. dmg. taken-10%', } }
    gear.jse_str_back = { name = "Senuna's Mantle", augments = { 'STR+20', 'Accuracy+20 Attack+20', 'STR+10', '"Dbl.Atk."+10', 'Phys. dmg. taken-10%', } }
    gear.waltz_back = { name = "Toetapper Mantle", augments = { '"Store TP"+1', '"Dual Wield"+2', '"Rev. Flourish"+30', } }

    -- Additional local binds
    send_command('bind !` gs c step')
    send_command('bind ^!@` gs c toggle usealtstep')
    send_command('bind @` input /ja "Chocobo Jig II" <me>')
    send_command('bind ^` input /ja "Saber Dance" <me>')
    send_command('bind !` input /ja "Fan Dance" <me>')
    send_command('bind ^\\\\ gs c cycle mainstep')
    send_command('bind !\\\\ gs c cycle altstep')
    send_command('bind !backspace input /ja "Reverse Flourish" <me>')
    send_command('bind ^backspace input /ja "No Foot Rise" <me>')
    send_command('bind @f6 gs c toggle autoprestomode')
    send_command('bind @f7 gs c toggle autosambamode')
    send_command('bind @f8 gs c toggle autojumpmode')

    select_default_macro_book()
end

function init_gear_sets()

    sets.TreasureHunter = set_combine(sets.TreasureHunter, {})

    -- Extra Melee sets.  Apply these on top of melee sets.

    -- Weapons sets
    sets.weapons.Aeneas = { main = "Aeneas", sub = "Gleti's Knife" }
    sets.weapons.Terpsichore = { main = "Terpsichore", sub = "Gleti's Knife" }
    sets.weapons.Karambit = { main = "Karambit", sub = empty }

    -- Precast Sets

    -- Precast sets to enhance JAs
    sets.precast.JA['No Foot Rise'] = { body = "Horos Casaque +3" }
    sets.precast.JA['Trance'] = { head = "Horos Tiara +3" }


    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        ammo = "Yamarang",
        head = { name = "Horos Tiara +3", augments = { 'Enhances "Trance" effect', } }, -- 15
        body = "Gleti's Cuirass", -- 10
        hands = "Maxixi Bangles +3",
        legs = "Dashing Subligar", -- 10
        feet = "Maxixi Toe Shoes +3", -- 15
        neck = "Etoile Gorget +2",
        waist = "Flume Belt +1",
        left_ear = "Odnowa Earring +1",
        right_ear = "Handler's Earring +1",
        left_ring = "Defending Ring",
        right_ring = { name = "Metamor. Ring +1", augments = { 'Path: A', } },
        back = gear.waltz_back,
    }

    sets.Self_Waltz = {} --body="Passion Jacket"

    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
    sets.precast.Samba = { head = "Maxixi Tiara +3", back = gear.jse_stp_back }
    sets.precast.Jig = { legs = "Horos Tights +3", feet = "Maxixi Toe Shoes +3" }

    sets.precast.Step = {
        ammo = "Yamarang",
        head = "Maxixi Tiara +3",
        body = "Malignance Tabard",
        hands = "Maxixi Bangles +3",
        legs = "Malignance Tights",
        feet = { name = "Horos T. Shoes +3", augments = { 'Enhances "Closed Position" effect', } },
        neck = "Etoile Gorget +2",
        waist = "Grunfeld Rope",
        left_ear = "Digni. Earring",
        right_ear = "Telos Earring",
        left_ring = "Regal Ring",
        right_ring = "Ilabrat Ring",
        back = gear.jse_stp_back,
    }

    sets.Enmity = {}

    sets.precast.JA.Provoke = sets.Enmity

    sets.precast.Flourish1 = {}
    sets.precast.Flourish1['Violent Flourish'] = {
        ammo = "Yamarang",
        head = "Malignance Chapeau",
        body = "Horos Casaque +3",
        hands = "Malignance Gloves",
        legs = "Malignance Tights",
        feet = "Malignance Boots",
        neck = "Etoile Gorget +2",
        waist = "Eschan Stone",
        left_ear = "Digni. Earring",
        right_ear = "Telos Earring",
        left_ring = "Regal Ring",
        right_ring = "Ilabrat Ring",
        back = gear.jse_stp_back,
    }

    sets.precast.Flourish1['Animated Flourish'] = sets.Enmity

    sets.precast.Flourish1['Desperate Flourish'] = {
        ammo = "Yamarang",
        head = "Malignance Chapeau",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        legs = "Malignance Tights",
        feet = "Malignance Boots",
        neck = "Etoile Gorget +2",
        waist = "Reiki Yotai",
        left_ear = "Digni. Earring",
        right_ear = "Telos Earring",
        left_ring = "Regal Ring",
        right_ring = "Ilabrat Ring",
        back = gear.jse_stp_back,
    }

    sets.precast.Flourish2 = {}
    sets.precast.Flourish2['Reverse Flourish'] = { back = gear.waltz_back }

    sets.precast.Flourish3 = {}
    sets.precast.Flourish3['Striking Flourish'] = {}
    sets.precast.Flourish3['Climactic Flourish'] = {
        ammo = "C. Palug Stone",
        head = "Maculele Tiara +1",
        body = "Nyame Mail",
        hands = "Maxixi Bangles +3",
        legs = { name = "Horos Tights +3", augments = { 'Enhances "Saber Dance" effect', } },
        feet = "Nyame Sollerets",
        neck = "Etoile Gorget +2",
        waist = "Fotia Belt",
        left_ear = "Moonshade Earring",
        right_ear = "Odr Earring",
        left_ring = "Regal Ring",
        right_ring = "Illbrat Ring",
        back = gear.jse_wsd_back,
    }

    -- Fast cast sets for spells

    sets.precast.FC = {
        ammo = "Sapience Orb",
        head = "Nyame Helm",
        body = "Adhemar Jacket +1",
        hands = { name = "Leyline Gloves", augments = { 'Accuracy+5', '"Mag.Atk.Bns."+7', '"Fast Cast"+1', } },
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets",
        neck = "Baetyl Pendant",
        waist = "Flume Belt +1",
        left_ear = "Loquac. Earring",
        right_ear = "Etiolation Earring",
        left_ring = "Weather. Ring +1",
        right_ring = "Lebeche Ring",
        back = gear.jse_stp_back,
    }

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {})


    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        ammo = "C. Palug Stone",
        head = "Nyame Helm",
        body = "Nyame Mail",
        hands = "Maxixi Bangles +3",
        legs = { name = "Horos Tights +3", augments = { 'Enhances "Saber Dance" effect', } },
        feet = "Nyame Sollerets",
        neck = "Etoile Gorget +2",
        waist = "Fotia Belt",
        left_ear = "Moonshade Earring",
        right_ear = "Ishvara Earring",
        left_ring = "Regal Ring",
        right_ring = "Beithir Ring",
        back = gear.jse_wsd_back,
    }

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS["Rudra's Storm"] = {
        ammo = "C. Palug Stone",
        head = "Nyame Helm",
        body = "Nyame Mail",
        hands = "Maxixi Bangles +3",
        legs = { name = "Horos Tights +3", augments = { 'Enhances "Saber Dance" effect', } },
        feet = "Nyame Sollerets",
        neck = "Etoile Gorget +2",
        waist = "Fotia Belt",
        left_ear = "Moonshade Earring",
        right_ear = "Odr Earring",
        left_ring = "Regal Ring",
        right_ring = "Illbrat Ring",
        back = gear.jse_wsd_back,
    }

    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Pyrrhic Kleos'] = {
        ammo = "Crepuscular Pebble",
        head = "Gleti's Mask",
        body = "Gleti's Cuirass",
        hands = "Gleti's Gauntlets",
        legs = "Gleti's Breeches",
        feet = "Gleti's Boots",
        neck = "Etoile Gorget +2",
        waist = "Fotia Belt",
        left_ear = "Sherida Earring",
        right_ear = "Cessance Earring",
        left_ring = "Regal Ring",
        right_ring = "Gere Ring",
        back = gear.jse_str_back,
    }

    -- Swap to these on Moonshade using WS if at 3000 TP
    sets.MaxTP = { ear1 = "Sherida Earring", ear2 = "Ishvara Earring" }
    sets.AccMaxTP = { ear1 = "Sherida Earring", ear2 = "Telos Earring" }
    sets.Skillchain = {}

    -- Midcast Sets
    sets.midcast.FastRecast = sets.precast.FC
    sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {})

    -- Sets to return to when not performing an action.

    -- Resting sets
    sets.resting = {}
    sets.ExtraRegen = {}

    -- Idle sets
    sets.idle = {
        ammo = "Staunch Tathlum +1", -- 3%
        head = "Gleti's Mask",
        body = "Gleti's Cuirass",
        hands = "Gleti's Gauntlets",
        legs = "Gleti's Breeches",
        feet = "Gleti's Boots",
        neck = "Sanctity Necklace",
        waist = "Flume Belt +1", -- 4%
        left_ear = "Infused Earring",
        right_ear = "Etiolation Earring",
        left_ring = "Defending Ring", -- 10%
        right_ring = "Gelatinous Ring +1",
        back = gear.jse_stp_back, -- 10%
    }

    sets.idle.DT = set_combine(sets.idle, {
        head = "Nyame Helm",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets",
    })

    sets.idle.Town = {
        ammo = "Coiste Bodhar",
        head = "Nyame Helm",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets",
        neck = "Etoile Gorget +2",
        waist = "Windbuffet Belt +1",
        left_ear = "Sherida Earring",
        right_ear = "Telos Earring",
        left_ring = "Gere Ring",
        right_ring = "Chirich Ring +1",
        back = gear.jse_stp_back,
    }

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
        back = "Moonbeam Cape",
    }

    sets.defense.MDT = sets.defense.PDT
    sets.defense.MEVA = sets.defense.PDT
    sets.Kiting = { feet = "Tandava Crackows" }

    -- Engaged sets

    sets.engaged = {
        ammo = "Coiste Bodhar",
        head = "Malignance Chapeau",
        body = "Horos Casaque +3",
        hands = { name = "Adhemar Wrist. +1", augments = { 'DEX+12', 'AGI+12', 'Accuracy+20', } },
        legs = "Malignance Tights",
        feet = "Horos T. Shoes +3",
        neck = "Etoile Gorget +2",
        waist = "Windbuffet Belt +1",
        left_ear = "Sherida Earring",
        right_ear = "Telos Earring",
        left_ring = "Gere Ring",
        right_ring = "Chirich Ring +1",
        back = gear.jse_stp_back,
    }

    sets.engaged.DT = {
        ammo = "Coiste Bodhar",
        head = "Malignance Chapeau",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        legs = "Malignance Tights",
        feet = "Malignance Boots",
        neck = "Etoile Gorget +2",
        waist = "Windbuffet Belt +1",
        left_ear = "Sherida Earring",
        right_ear = "Telos Earring",
        left_ring = "Defending Ring",
        right_ring = "Chirich Ring +1",
        back = gear.jse_stp_back,
    }

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Saber Dance'] = { legs = "Horos Tights +3" }
    sets.buff['Climactic Flourish'] = { head = "Maculele Tiara +1" } --ammo="Charis Feather",
    sets.buff.Doom = set_combine(sets.buff.Doom, {})

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(10, 9)
    elseif player.sub_job == 'NIN' then
        set_macro_page(1, 9)
    elseif player.sub_job == 'SAM' then
        set_macro_page(9, 9)
    elseif player.sub_job == 'THF' then
        set_macro_page(8, 9)
    else
        set_macro_page(10, 9)
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
