function user_job_setup()

    state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Tank', 'DTLite', 'Normal')
    state.WeaponskillMode:options('Tank', 'Normal')
    state.CastingMode:options('SIRD', 'Normal')
    state.PhysicalDefenseMode:options('PDT')
    state.MagicalDefenseMode:options('MDT')
    state.ResistDefenseMode:options('MEVA')
    state.IdleMode:options('DT', 'Normal')
    state.Weapons:options('Ochain', 'Aegis', 'Srivatsa', 'None')
    state.ExtraDefenseMode = M { ['description'] = 'Extra Defense Mode', 'None' }
    state.MaintainAftermath = M(false, 'Maintain Aftermath')
    state.AutoEmblem = M(true, 'Auto Emblem')
    state.AutoTankFull = M(false, 'Auto Tank Full')
    state.UnlockWeapons = M(true, 'Unlock Weapons')
    silibs.enable_cancel_outranged_ws()
    silibs.enable_cancel_on_blocking_status()
    silibs.enable_weapon_rearm()
    silibs.enable_auto_lockstyle(3)
    silibs.enable_waltz_refiner()
    silibs.enable_premade_commands()
    silibs.enable_th()
    silibs.enable_ui()

    autows = 'Atonement'

    gear.tank_fc_back = { name = "Rudianos's Mantle", augments = { 'HP+60', 'Eva.+20 /Mag. Eva.+20', 'HP+20', '"Fast Cast"+10', 'Phys. dmg. taken-10%', }, priority = 80 }
    gear.tank_jse_back = { name = "Rudianos's Mantle", augments = { 'HP+60', 'Eva.+20 /Mag. Eva.+20', 'HP+20', 'Enmity+10', 'Phys. dmg. taken-10%', }, priority = 80 }
    gear.tank_cure_back = { name = "Rudianos's Mantle", augments = { 'HP+60', 'Eva.+20 /Mag. Eva.+20', 'HP+20', '"Cure" potency +10%', 'Phys. dmg. taken-10%', }, priority = 80 }
    gear.jse_wsd_back = { name = "Rudianos's Mantle", augments = { 'STR+20', 'Accuracy+20 Attack+20', 'STR+10', 'Weapon skill damage +10%', 'Phys. dmg. taken-10%', } }
    gear.phalanx_jse_back = { name = "Weard Mantle", augments = { 'VIT+4', 'DEX+1', 'Enmity+1', 'Phalanx +4', } }

    -- Additional local binds
    send_command('bind !` gs c SubJobEnmity')
    send_command('bind ^` gs c RuneElement')
    send_command('bind @` gs c cycle RuneElement')
    send_command('bind @pause gs c toggle AutoRuneMode')
    send_command('bind ^\\\\ input /ma "Protect V" <t>')
    send_command('bind @\\\\ input /ma "Shell IV" <t>')
    send_command('bind !\\\\ input /ma "Crusade" <me>')
    send_command('bind ^backspace input /ja "Shield Bash" <t>')
    send_command('bind @backspace input /ja "Cover" <stpt>')
    send_command('bind !f11 gs c cycle ExtraDefenseMode')
    send_command('bind ^pause gs c toggle AutoRuneMode')
    send_command('bind @f6 gs c toggle AutoTankFull;')
    send_command('bind @f7 gs c toggle AutoBuffMode;')
    send_command('bind @f8 gs c toggle AutoTankMode;')
    send_command('bind @f10 gs c toggle TankAutoDefense')
    send_command('hb mincure 4;')

    select_default_macro_book()

end

function init_gear_sets()

    update_defense_mode()

    sets.weapons.Ochain = { main = "Burtgang", sub = "Ochain" }
    sets.weapons.Aegis = { main = "Burtgang", sub = "Aegis" }
    sets.weapons.Srivatsa = { main = "Burtgang", sub = "Srivatsa" }
    --sets.weapons.DualWeapons = {main="Sequence",sub="Sakpata's Sword"}

    --------------------------------------
    -- Precast sets
    --------------------------------------
    -- 128 Enmity

    sets.Enmity = {
        ammo = "Staunch Tathlum +1",
        head = { name = "Souveran Schaller +1", priority = 280 }, -- 9
        body = { name = "Souveran Cuirass +1", priority = 171 }, -- 20
        hands = { name = "Souv. Handsch. +1", priority = 239 },
        legs = { name = "Souv. Diechlings +1", priority = 162 },
        feet = { name = "Souveran Schuhs +1", priority = 227 },
        neck = "Moonlight Necklace", -- 15
        waist = "Flume Belt +1",
        left_ear = { name = "Cryptic Earring", priority = 40 }, -- 4
        right_ear = { name = "Odnowa Earring +1", priority = 110 },
        left_ring = "Defending Ring",
        right_ring = { name = "Eihwaz Ring", priority = 70 }, -- 5
        back = gear.tank_jse_back, -- 10
    }

    -- Merits 10%
    -- 50%+ DT/PDT
    -- 106% SIRD
    -- 109 Enmity

    sets.Enmity.SIRD = { -- SIRD	/	PDT	/ Enmity
        ammo = "Staunch Tathlum +1", -- 11	/	3	/
        head = { name = "Souveran Schaller +1", priority = 280 }, -- 20			/	9
        body = { name = "Souveran Cuirass +1", priority = 171 }, --		/	10	/	20
        hands = { name = "Regal Gauntlets", priority = 205 }, -- 10
        legs = { name = "Founder's Hose", priority = 54 }, -- 30		5	/
        feet = { name = "Souveran Schuhs +1", priority = 227 }, --		/	5	/	9
        neck = "Moonlight Necklace", -- 15	/		/	15
        waist = "Audumbla Sash", -- 10	/	4
        left_ear = { name = "Cryptic Earring", priority = 40 }, --		/		/	4
        right_ear = { name = "Odnowa Earring +1", priority = 110 }, --		/	3
        left_ring = { name = "Moonlight Ring", priority = 110 }, --		/	5
        right_ring = { name = "Gelatinous Ring +1", priority = 125 }, -- 		/	7	/
        back = gear.tank_jse_back, --		/	10	/	10
    }

    -- Precast sets to enhance JAs
    sets.precast.JA['Invincible'] = set_combine(sets.Enmity, { legs = { name = "Cab. Breeches +1", priority = 52 }, left_ear = { name = "Tuisto Earring", priority = 150 }, })
    sets.precast.JA['Holy Circle'] = set_combine(sets.Enmity, {}) -- feet="Rev. Leggings +3"
    sets.precast.JA['Sentinel'] = set_combine(sets.Enmity, { feet = { name = "Cab. Leggings +3", priority = 63 }, left_ear = { name = "Tuisto Earring", priority = 150 }, })
    sets.precast.JA['Rampart'] = set_combine(sets.Enmity, { head = { name = "Cab. Coronet +1", priority = 96 }, left_ear = { name = "Tuisto Earring", priority = 150 }, })
    sets.precast.JA['Fealty'] = set_combine(sets.Enmity, { body = { name = "Cab. Surcoat +1", priority = 118 }, left_ear = { name = "Tuisto Earring", priority = 150 }, })
    sets.precast.JA['Divine Emblem'] = set_combine(sets.Enmity, { feet = { name = "Chev. Sabatons +1", priority = 22 }, left_ear = { name = "Tuisto Earring", priority = 150 }, })
    sets.precast.JA['Cover'] = set_combine(sets.Enmity, { body = { name = "Cab. Surcoat +1", priority = 118 }, left_ear = { name = "Tuisto Earring", priority = 150 }, }) -- head="Rev. Coronet +1",
    sets.precast.JA['Shield Bash'] = set_combine(sets.Enmity, { hands = { name = "Cab. Gauntlets +3", priority = 114 }, })
    sets.precast.JA['Palisade'] = set_combine(sets.Enmity, {})
    sets.precast.JA['Intervene'] = set_combine(sets.Enmity, {})

    -- add mnd for Chivalry
    sets.precast.JA['Chivalry'] = {
        ammo = "Hydrocera",
        head = { name = "Hjarrandi Helm", priority = 114 },
        body = { name = "Nyame Mail", priority = 136 },
        hands = { name = "Cab. Gauntlets +3", priority = 114 },
        legs = { name = "Nyame Flanchard", priority = 114 },
        feet = { name = "Nyame Sollerets", priority = 68 },
        neck = { name = "Unmoving Collar +1", priority = 200 }, -- For HP
        waist = "Luminary Sash",
        left_ear = "Nourish. Earring +1",
        right_ear = { name = "Odnowa Earring +1", priority = 110 },
        left_ring = { name = "Moonlight Ring", priority = 110 },
        right_ring = { name = "Gelatinous Ring +1", priority = 125 },
        back = { name = "Moonlight Cape", priority = 250 },
    }

    sets.precast.JA['Provoke'] = set_combine(sets.Enmity, {})
    sets.precast.JA['Warcry'] = set_combine(sets.Enmity, {})
    sets.precast.JA['Defender'] = set_combine(sets.Enmity, {})
    sets.precast.JA['Berserk'] = set_combine(sets.Enmity, {})
    sets.precast.JA['Aggressor'] = set_combine(sets.Enmity, {})
    sets.precast.JA['Chain Affinity'] = set_combine(sets.Enmity, {})
    sets.precast.JA['Burst Affinity'] = set_combine(sets.Enmity, {})

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
    sets.precast.Waltz['Healing Waltz'] = {}
    sets.precast.Step = {}
    sets.precast.JA['Violent Flourish'] = {}
    sets.precast.JA['Animated Flourish'] = set_combine(sets.Enmity, {})

    -- Fast cast sets for spells
    -- 59% FC
    -- 43% PDT
    sets.precast.FC = {
        ammo = "Sapience Orb", -- 2%
        head = { name = "Carmine Mask +1", priority = 38 }, -- 14%
        body = { name = "Rev. Surcoat +3", priority = 254 }, -- 10%
        hands = { name = "Souv. Handsch. +1", priority = 239 },
        legs = gear.odyssean_fc_legs, -- 6%
        feet = { name = "Carmine Greaves +1", priority = 95 }, -- 8%
        neck = "Baetyl Pendant", -- 4%
        waist = { name = "Silver Moogle Belt", priority = 500 },
        left_ear = { name = "Tuisto Earring", priority = 150 },
        right_ear = { name = "Odnowa Earring +1", priority = 110 },
        --left_ring={name="Moonlight Ring", priority=110},
        left_ring = "Weather. Ring +1", -- 5%
        right_ring = { name = "Gelatinous Ring +1", priority = 125 },
        back = gear.tank_fc_back, -- 10%
    }

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {})

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        ammo = "Ginsen",
        head = "Nyame Helm",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets",
        neck = "Fotia Gorget",
        waist = "Fotia Belt",
        left_ear = "Moonshade Earring",
        right_ear = "Thrud Earring",
        left_ring = "Regal Ring",
        right_ring = "Beithir Ring",
        back = gear.jse_wsd_back,
    }

    sets.precast.WS.Tank = {
        ammo = "Ginsen",
        head = { name = "Nyame Helm", priority = 91 },
        body = { name = "Nyame Mail", priority = 136 },
        hands = { name = "Regal Gauntlets", priority = 250 },
        legs = { name = "Nyame Flanchard", priority = 114 },
        feet = { name = "Nyame Sollerets", priority = 68 },
        neck = { name = "Unmoving Collar +1", priority = 200 },
        waist = { name = "Silver Moogle Belt", priority = 250 },
        left_ear = { name = "Tuisto Earring", priority = 150 },
        right_ear = { name = "Odnowa Earring +1", priority = 110 },
        left_ring = { name = "Moonlight Ring", priority = 110 },
        right_ring = { name = "Gelatinous Ring +1", priority = 125 },
        back = gear.jse_wsd_back,
    }

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Flat Blade'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS, {})

    sets.precast.WS['Requiescat'].Tank = set_combine(sets.precast.WS.Tank, {})
    sets.precast.WS['Chant du Cygne'].Tank = set_combine(sets.precast.WS.Tank, {})
    sets.precast.WS['Savage Blade'].Tank = set_combine(sets.precast.WS.Tank, {})
    sets.precast.WS['Flat Blade'].Tank = set_combine(sets.precast.WS.Tank, {})
    sets.precast.WS['Sanguine Blade'].Tank = set_combine(sets.precast.WS.Tank, {})

    sets.precast.WS['Atonement'] = {
        ammo = "Staunch Tathlum +1",
        head = { name = "Souveran Schaller +1", priority = 280 },
        body = { name = "Souveran Cuirass +1", priority = 171 },
        hands = { name = "Souv. Handsch. +1", priority = 239 },
        legs = { name = "Souv. Diechlings +1", priority = 162 },
        feet = { name = "Souveran Schuhs +1", priority = 227 },
        neck = "Moonlight Necklace",
        waist = "Fotia Belt",
        left_ear = "Moonshade Earring",
        right_ear = { name = "Odnowa Earring +1", priority = 110 },
        left_ring = "Defending Ring",
        right_ring = { name = "Eihwaz Ring", priority = 70 },
        back = gear.tank_jse_back,
    }

    sets.precast.WS['Atonement'].Tank = sets.precast.WS['Atonement']

    sets.precast.WS['Spirits Within'] = sets.precast.WS['Atonement']
    sets.precast.WS['Spirits Within'].Tank = sets.precast.WS['Atonement']

    -- Swap to these on Moonshade using WS if at 3000 TP

    sets.MaxTP = { ear1 = { name = "Tuisto Earring", priority = 150 }, ear2 = { name = "Odnowa Earring +1", priority = 110 }, }
    sets.AccMaxTP = { ear1 = { name = "Tuisto Earring", priority = 150 }, ear2 = { name = "Odnowa Earring +1", priority = 110 }, }
    sets.AccDayMaxTPWSEars = { ear1 = { name = "Tuisto Earring", priority = 150 }, ear2 = { name = "Odnowa Earring +1", priority = 110 }, }
    sets.DayMaxTPWSEars = { ear1 = { name = "Tuisto Earring", priority = 150 }, ear2 = { name = "Odnowa Earring +1", priority = 110 }, }
    sets.AccDayWSEars = { ear1 = { name = "Tuisto Earring", priority = 150 }, ear2 = { name = "Odnowa Earring +1", priority = 110 }, }
    sets.DayWSEars = { ear1 = { name = "Tuisto Earring", priority = 150 }, ear2 = { name = "Odnowa Earring +1", priority = 110 }, }


    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.Flash = set_combine(sets.Enmity, {})
    sets.midcast.Flash.SIRD = set_combine(sets.Enmity.SIRD, {})
    sets.midcast.Stun = set_combine(sets.Enmity, {})
    sets.midcast.Stun.SIRD = set_combine(sets.Enmity.SIRD, {})

    sets.midcast['Blue Magic'] = set_combine(sets.Enmity.SIRD, {})
    sets.midcast['Blue Magic'].SIRD = set_combine(sets.Enmity.SIRD, {})
    sets.midcast.Cocoon = set_combine(sets.Enmity.SIRD, {})

    -- 55% Cure potency
    -- 39% PDT/DT
    sets.midcast.Cure = {
        ammo = "Sapience Orb",
        head = { name = "Souveran Schaller +1", priority = 280 },
        body = { name = "Souveran Cuirass +1", priority = 171 }, -- 11%
        hands = { name = "Regal Gauntlets", priority = 205 },
        legs = { name = "Souv. Diechlings +1", priority = 162 },
        feet = gear.odyssean_cure_feet, -- 13%
        neck = { name = "Sacro Gorget", priority = 50 }, -- 10%
        waist = { name = "Carrier's Sash", priority = 20 },
        left_ear = "Nourish. Earring +1", -- 6%
        right_ear = "Mendi. Earring", -- 5%
        left_ring = { name = "Moonlight Ring", priority = 110 },
        right_ring = { name = "Eihwaz Ring", priority = 70 },
        back = gear.tank_cure_back, -- 10%
    }

    -- SIRD: 96% + 10% Merits = 106%
    -- Cure: 50% - missing neck
    -- 39% PDT/DT
    sets.midcast.Cure.SIRD = {
        ammo = "Staunch Tathlum +1", -- 11
        head = { name = "Souveran Schaller +1", priority = 280 }, -- 20
        body = { name = "Souveran Cuirass +1", priority = 171 }, --		/	11%
        hands = { name = "Souv. Handsch. +1", priority = 239 },
        legs = { name = "Founder's Hose", priority = 54 }, -- 30
        feet = gear.odyssean_cure_feet, -- 20	/	13%
        neck = { name = "Sacro Gorget", priority = 50 }, --		/	10%
        waist = "Audumbla Sash", -- 10
        left_ear = { name = "Tuisto Earring", priority = 150 },
        right_ear = "Nourish. Earring +1", -- 5	/	6%
        left_ring = { name = "Moonlight Ring", priority = 110 },
        right_ring = { name = "Gelatinous Ring +1", priority = 125 },
        back = gear.tank_cure_back, --		/ 	10%
    }

    sets.Self_Healing = set_combine(sets.midcast.Cure, {})
    sets.Self_Healing.SIRD = set_combine(sets.midcast.Cure.SIRD, {})

    sets.midcast.Reprisal = {
        ammo = "Staunch Tathlum +1",
        head = { name = "Carmine Mask +1", priority = 38 }, -- 14%
        body = { name = "Shab. Cuirass +1", priority = 5 },
        hands = { name = "Regal Gauntlets", priority = 5 },
        legs = { name = "Sakpata's Cuisses", priority = 114 },
        feet = { name = "Carmine Greaves +1", priority = 95 }, -- 8%
        neck = { name = "Unmoving Collar +1", priority = 200 },
        waist = "Sailfi Belt +1",
        left_ear = { name = "Tuisto Earring", priority = 150 },
        right_ear = { name = "Odnowa Earring +1", priority = 110 },
        left_ring = { name = "Moonlight Ring", priority = 110 },
        right_ring = { name = "Gelatinous Ring +1", priority = 125 },
        back = gear.tank_fc_back, -- 10%
    }

    sets.Cure_Received = {}
    sets.Self_Refresh = { waist = "Gishdubar Sash" }

    sets.midcast['Enhancing Magic'] = {
        ammo = "Staunch Tathlum +1", -- 11	/	3	/
        head = { name = "Souveran Schaller +1", priority = 280 }, -- 20			/	9
        body = { name = "Shab. Cuirass +1", priority = 115 }, --		/	10	/	20
        hands = { name = "Regal Gauntlets", priority = 205 }, -- 10
        legs = { name = "Founder's Hose", priority = 54 }, -- 30
        feet = { name = "Souveran Schuhs +1", priority = 500 }, -- 20
        neck = "Moonlight Necklace", -- 15	/		/	15
        waist = "Audumbla Sash", -- 10	/	4
        left_ear = { name = "Tuisto Earring", priority = 500 },
        right_ear = { name = "Odnowa Earring +1", priority = 500 }, --		/	3
        left_ring = "Defending Ring", --		/	5
        right_ring = { name = "Gelatinous Ring +1", priority = 500 }, -- 		/	7	/
        back = { name = "Moonlight Cape", priority = 500 },
    }

    sets.midcast['Enhancing Magic'].SIRD = set_combine(sets.midcast['Enhancing Magic'], {})

    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], { waist = "Siegel Sash" })
    sets.midcast.Stoneskin.SIRD = set_combine(sets.midcast['Enhancing Magic'], { waist = "Siegel Sash" })
    sets.midcast['Protect V'] = set_combine(sets.midcast['Enhancing Magic'], { main = "Burtgang", sub = "Srivatsa", neck = "Loricate Torque +1", feet = { name = "Odyssean Greaves", priority = 20 }, })
    sets.midcast['Protect V'].SIRD = set_combine(sets.midcast['Enhancing Magic'], { main = "Burtgang", sub = "Srivatsa", neck = "Loricate Torque +1", feet = { name = "Odyssean Greaves", priority = 20 }, })
    sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {})
    sets.midcast.Shell.SIRD = set_combine(sets.midcast['Enhancing Magic'], {})

    sets.midcast.Phalanx = {
        ammo = "Staunch Tathlum +1", -- 11	/	3	/
        head = { name = "Souveran Schaller +1", priority = 280 }, -- 20			/	9
        body = { name = "Shab. Cuirass +1", priority = 115 }, --		/	10	/	20
        hands = { name = "Souv. Handsch. +1", priority = 239 }, -- 10
        legs = { name = "Sakpata's Cuisses", priority = 114 },
        feet = { name = "Souveran Schuhs +1", priority = 227 },
        neck = "Incanter's Torque", -- 15	/		/	15
        waist = "Audumbla Sash", -- 10	/	4
        left_ear = { name = "Tuisto Earring", priority = 150 },
        right_ear = { name = "Odnowa Earring +1", priority = 110 }, --		/	3
        left_ring = "Defending Ring", --		/	5
        right_ring = { name = "Gelatinous Ring +1", priority = 125 }, -- 		/	7	/
        back = gear.phalanx_jse_back,
    }

    sets.midcast.Phalanx.SIRD = sets.midcast.Phalanx

    sets.midcast['Divine Magic'] = set_combine(sets.Enmity.SIRD, {})
    sets.midcast['Divine Magic'].SIRD = sets.midcast['Divine Magic']

    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------
    sets.idle = {
        ammo = "Homiliary", -- 1MP
        head = { name = "Sakpata's Helm", priority = 91 },
        body = { name = "Sakpata's Plate", priority = 136 },
        hands = { name = "Regal Gauntlets", priority = 205 }, -- 1MP
        legs = { name = "Sakpata's Cuisses", priority = 114 },
        feet = { name = "Sakpata's Leggings", priority = 68 },
        neck = { name = "Unmoving Collar +1", priority = 200 },
        waist = { name = "Carrier's Sash", priority = 20 },
        left_ear = { name = "Tuisto Earring", priority = 150 },
        right_ear = { name = "Odnowa Earring +1", priority = 110 },
        left_ring = { name = "Moonlight Ring", priority = 110 },
        right_ring = { name = "Gelatinous Ring +1", priority = 125 },
        back = gear.tank_jse_back,
    }

    sets.idle.Town = {
        ammo = "Homiliary",
        head = { name = "Sakpata's Helm", priority = 91 },
        body = { name = "Sakpata's Plate", priority = 136 },
        hands = { name = "Sakpata's Gauntlets", priority = 5 },
        legs = { name = "Sakpata's Cuisses", priority = 114 },
        feet = { name = "Sakpata's Leggings", priority = 68 },
        neck = { name = "Unmoving Collar +1", priority = 200 },
        waist = { name = "Carrier's Sash", priority = 20 },
        left_ear = { name = "Tuisto Earring", priority = 150 },
        right_ear = { name = "Odnowa Earring +1", priority = 110 },
        left_ring = { name = "Moonlight Ring", priority = 110 },
        right_ring = { name = "Gelatinous Ring +1", priority = 125 },
        back = gear.tank_jse_back,
    }

    sets.idle.DT = {
        ammo = "Staunch Tathlum +1",
        head = { name = "Sakpata's Helm", priority = 5 },
        body = { name = "Sakpata's Plate", priority = 300 },
        hands = { name = "Sakpata's Gauntlets", priority = 5 },
        legs = { name = "Sakpata's Cuisses", priority = 300 },
        feet = { name = "Sakpata's Leggings", priority = 5 },
        neck = { name = "Unmoving Collar +1", priority = 500 },
        waist = { name = "Carrier's Sash", priority = 5 },
        left_ear = { name = "Tuisto Earring", priority = 500 },
        right_ear = { name = "Odnowa Earring +1", priority = 500 },
        left_ring = { name = "Moonlight Ring", priority = 500 },
        right_ring = { name = "Gelatinous Ring +1", priority = 500 },
        back = gear.tank_jse_back,
    }

    sets.idle.Weak = sets.idle.Tank
    sets.resting = sets.idle
    sets.Kiting = { legs = "Carmine Cuisses +1" }

    sets.latent_refresh = { waist = "Fucho-no-obi" }
    sets.latent_refresh_grip = {}
    sets.latent_regen = {}
    sets.DayIdle = {}
    sets.NightIdle = {}

    --------------------------------------
    -- Defense sets
    --------------------------------------

    -- Extra defense sets.  Apply these on top of melee or defense sets.
    sets.Knockback = {}
    sets.MP = {}
    sets.passive.AbsorbMP = {}
    sets.MP_Knockback = {}
    sets.Twilight = {}
    sets.TreasureHunter = set_combine(sets.TreasureHunter, {})

    sets.defense.PDT = {
        ammo = "Staunch Tathlum +1",
        head = { name = "Sakpata's Helm", priority = 91 },
        body = { name = "Sakpata's Plate", priority = 136 },
        hands = { name = "Sakpata's Gauntlets", priority = 91 },
        legs = { name = "Sakpata's Cuisses", priority = 114 },
        feet = { name = "Sakpata's Leggings", priority = 68 },
        neck = { name = "Unmoving Collar +1", priority = 200 },
        waist = { name = "Carrier's Sash", priority = 20 },
        left_ear = { name = "Tuisto Earring", priority = 150 },
        right_ear = { name = "Odnowa Earring +1", priority = 110 },
        left_ring = { name = "Moonlight Ring", priority = 110 },
        right_ring = { name = "Gelatinous Ring +1", priority = 125 },
        back = { name = "Moonlight Cape", priority = 250 },
    }

    sets.defense.MEVA = sets.defense.PDT
    sets.defense.MDT = sets.defense.MEVA

    --------------------------------------
    -- Engaged sets
    --------------------------------------

    sets.engaged = {
        ammo = "Ginsen",
        head = { name = "Sakpata's Helm", priority = 91 },
        body = { name = "Sakpata's Plate", priority = 136 },
        hands = { name = "Sakpata's Gauntlets", priority = 91 },
        legs = { name = "Sakpata's Cuisses", priority = 114 },
        feet = { name = "Sakpata's Leggings", priority = 68 },
        neck = "Combatant's Torque",
        waist = "Windbuffet Belt +1",
        left_ear = "Telos Earring",
        right_ear = "Crep. Earring",
        left_ring = { name = "Moonlight Ring", priority = 110 },
        right_ring = "Petrov Ring",
        --back=tp cape
    }

    sets.engaged.Acc = set_combine(sets.engaged, {})

    sets.engaged.DW = set_combine(sets.engaged, { right_ear = "Suppanomimi" })
    sets.engaged.DW.Acc = set_combine(sets.engaged.Acc, { right_ear = "Suppanomimi" })

    sets.engaged.Tank = {
        ammo = "Staunch Tathlum +1",
        head = { name = "Sakpata's Helm", priority = 91 },
        body = { name = "Sakpata's Plate", priority = 136 },
        hands = { name = "Sakpata's Gauntlets", priority = 91 },
        legs = { name = "Sakpata's Cuisses", priority = 114 },
        feet = { name = "Sakpata's Leggings", priority = 68 },
        neck = { name = "Unmoving Collar +1", priority = 200 },
        waist = { name = "Carrier's Sash", priority = 20 },
        left_ear = { name = "Tuisto Earring", priority = 150 },
        right_ear = { name = "Odnowa Earring +1", priority = 110 },
        left_ring = { name = "Moonlight Ring", priority = 110 },
        right_ring = { name = "Gelatinous Ring +1", priority = 125 },
        back = gear.tank_jse_back,
    }

    sets.engaged.DTLite = {
        ammo = "Ginsen",
        head = { name = "Sakpata's Helm", priority = 91 },
        body = { name = "Sakpata's Plate", priority = 136 },
        hands = { name = "Sakpata's Gauntlets", priority = 91 },
        legs = { name = "Sakpata's Cuisses", priority = 114 },
        feet = { name = "Sakpata's Leggings", priority = 68 },
        neck = "Combatant's Torque",
        waist = "Sailfi Belt +1",
        left_ear = "Cessance Earring",
        right_ear = "Telos Earring",
        left_ring = "Moonlight Ring",
        right_ring = "Regal Ring",
        back = gear.tank_jse_back,
    }

    sets.engaged.Reraise = set_combine(sets.engaged.Tank, sets.Reraise)
    sets.engaged.Acc.Reraise = set_combine(sets.engaged.Acc.Tank, sets.Reraise)

    --------------------------------------
    -- Custom buff sets
    --------------------------------------
    sets.buff.Doom = set_combine(sets.buff.Doom, {})
    sets.buff.Sleep = {}
    sets.buff.Cover = { body = "Cab. Surcoat +1" }

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'NIN' then
        set_macro_page(2, 4)
    elseif player.sub_job == 'RUN' then
        set_macro_page(9, 4)
    elseif player.sub_job == 'RDM' then
        set_macro_page(6, 4)
    elseif player.sub_job == 'BLU' then
        set_macro_page(8, 4)
    elseif player.sub_job == 'DNC' then
        set_macro_page(4, 4)
    else
        set_macro_page(1, 4) --War/Etc
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
