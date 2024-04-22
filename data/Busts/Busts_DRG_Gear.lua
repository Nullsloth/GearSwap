function user_job_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'SubtleBlow')
    state.HybridMode:options('DT', 'Normal')
    state.PhysicalDefenseMode:options('PDT')
    state.MagicalDefenseMode:options('MDT')
    state.ResistDefenseMode:options('MEVA')
    state.IdleMode:options('DT', 'Normal', 'Refresh', 'Reraise')
    state.ExtraMeleeMode = M { ['description'] = 'Extra Melee Mode', 'None' }
    state.Weapons:options('Trishula', 'ShiningOne', 'Malignance', 'Naegling', 'None')
    state.Passive = M { ['description'] = 'Passive Mode', 'None' }
    state.AutoBondMode = M(false, 'Auto Bond Mode')
    state.AutoZergMode = M(false, 'Auto Zerg Mode')
    state.AutoJumpMode = M(false, 'Auto Jump Mode')

    autows_list = { ['Tizbron'] = 'Expiacion', ['Tizalmace'] = 'Expiacion', ['Almace'] = 'Chant Du Cygne', ['MeleeClubs'] = 'Realmrazer',
                    ['HybridWeapons'] = 'Sanguine Blade', ['Naegbron'] = 'Savage Blade', ['Naegmace'] = 'Savage Blade' }

    gear.jse_da_back = { name = "Brigantia's Mantle", augments = { 'DEX+20', 'Accuracy+20 Attack+20', '"Dbl.Atk."+10', 'Accuracy+10', 'Phys. dmg. taken-10%', } }
    gear.jse_str_back = { name = "Brigantia's Mantle", augments = { 'STR+20', 'Accuracy+20 Attack+20', '"Dbl.Atk."+10', 'STR+10', 'Phys. dmg. taken-10%', } }
    gear.jse_wsd_back = { name = "Brigantia's Mantle", augments = { 'STR+20', 'Accuracy+20 Attack+20', 'Weapon skill damage +10%', 'STR+10', 'Phys. dmg. taken-10%', } }


    -- Additional local binds
    send_command('bind !` input /ja "Hasso" <me>')
    send_command('bind ^` input /ja "Seigan" <me>')
    send_command('bind ^backspace input /ja "Super Jump" <me>')
    send_command('bind !backspace input /ja "Steady Wing" <me>')
    send_command('bind ^f11 gs c cycle MagicalDefenseMode')
    send_command('bind @f7 gs c toggle AutoJumpMode')
    send_command('bind @f8 gs c toggle AutoBondMode')
    send_command('bind @f6 gs c toggle AutoZergMode')

    select_default_macro_book()
end

function init_gear_sets()

    -- Weapons sets
    sets.weapons.Trishula = { main = "Trishula", sub = "Utu Grip" }
    sets.weapons.ShiningOne = { main = "Shining One", sub = "Utu Grip" }
    sets.weapons.Malignance = { main = "Malignance Pole", sub = "Utu Grip" }
    sets.weapons.Naegling = { main = "Naegling", sub = "Legion Scutum" }


    -- Precast Sets
    sets.precast.JA.Angon = { ammo = "Angon", hands = "Ptero. Fin. G. +3" }
    sets.precast.JA['Ancient Circle'] = { legs = "Vishap Brais +3" }

    sets.precast.Jump = {
        ammo = "Coiste Bodhar",
        head = "Flam. Zucchetto +2",
        body = "Ptero. Mail +3",
        hands = "Vis. Fng. Gaunt. +3",
        legs = "Ptero. Brais +3",
        feet = "Ostro Greaves",
        neck = "Dgn. Collar +2",
        waist = "Ioskeha Belt +1",
        left_ear = "Sherida Earring",
        right_ear = "Telos Earring",
        left_ring = "Petrov Ring",
        right_ring = "Niqmaddu Ring",
        back = gear.TPBack,
    }
    sets.precast.JA['High Jump'] = set_combine(sets.precast.Jump, {})
    sets.precast.JA['Spirit Jump'] = set_combine(sets.precast.Jump, {})
    sets.precast.JA['Soul Jump'] = set_combine(sets.precast.Jump, { body = "Vishap Mail +3" })

    sets.precast.JA['Super Jump'] = {}
    sets.precast.JA['Spirit Link'] = { head = "Vishap Armet +3", hands = "Pel. Vambraces +1", feet = "Ptero. Greaves +3" }
    sets.precast.JA['Call Wyvern'] = { body = "Ptero. Mail +3", neck = "Dgn. Collar +2", feet = "Gleti's Boots" }
    sets.precast.JA['Deep Breathing'] = {}
    sets.precast.JA['Spirit Surge'] = { body = "Ptero. Mail +3" }
    sets.precast.JA['Steady Wing'] = { legs = "Vishap Brais +3", feet = "Ptero. Greaves +3" }

    -- Breath sets
    sets.precast.JA['Restoring Breath'] = { head = "Ptero. Armet +3", legs = "Vishap Brais +3", feet = "Ptero. Greaves +3", neck = "Dgn. Collar +2", back = "Brigantia's Mantle" }
    sets.precast.JA['Smiting Breath'] = { back = "Brigantia's Mantle" }
    sets.HealingBreath = { back = "Brigantia's Mantle" }
    sets.SmitingBreath = { back = "Brigantia's Mantle" }

    -- Fast cast sets for spells

    sets.precast.FC = {
        ammo = "Impatiens",
        head = "Carmine Mask +1",
        neck = "Baetyl Pendant",
        ear2 = "Loquacious Earring",
        hands = "Leyline Gloves",
        ring1 = "Lebeche Ring",
        feet = "Carmine Greaves +1"
    }

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}

    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    sets.midcast.Cure = {}

    sets.Self_Healing = { waist = "Gishdubar Sash" }
    sets.Cure_Received = { waist = "Gishdubar Sash" }
    sets.Self_Refresh = { waist = "Gishdubar Sash" }

    -- Midcast Sets
    sets.midcast.FastRecast = sets.precast.FC

    -- Put HP+ gear and the AF head to make healing breath trigger more easily with this set.
    sets.midcast.HB_Trigger = set_combine(sets.midcast.FastRecast, { head = "Vishap Armet +3" })

    -- Weaponskill sets

    -- WS with WSD
    -- 52% WSD
    sets.precast.WS = {
        ammo = "Knobkierrie",
        head = "Nyame Helm",
        body = "Nyame Mail",
        hands = { name = "Ptero. Fin. G. +3", augments = { 'Enhances "Angon" effect', } },
        legs = "Vishap Brais +3",
        feet = "Nyame Sollerets",
        neck = "Dgn. Collar +2",
        waist = { name = "Sailfi Belt +1", augments = { 'Path: A', } },
        left_ear = "Thrud Earring",
        right_ear = { name = "Moonshade Earring", augments = { 'Accuracy+4', 'TP Bonus +250', } },
        left_ring = "Regal Ring",
        right_ring = "Beithir Ring",
        back = gear.jse_wsd_back,
    }

    sets.precast.WS.SubtleBlow = set_combine(sets.precast.WS, {
        left_ear = "Sherida Earring",
        right_ring = "Niqmaddu Ring",
    })
    sets.precast.WS.KI = set_combine(sets.precast.WS, { body = "Found. Breastplate" })
    sets.precast.WS.KI.SubtleBlow = set_combine(sets.precast.WS.SubtleBlow, { body = "Found. Breastplate" })

    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Savage Blade'].SubtleBlow = set_combine(sets.precast.WS.SubtleBlow, {})
    sets.precast.WS['Savage Blade'].KI = set_combine(sets.precast.WS.KI, {})
    sets.precast.WS['Savage Blade'].KI.SubtleBlow = set_combine(sets.precast.WS.KI.SubtleBlow, {})

    -- Stardiver - DA%
    sets.precast.WS['Stardiver'] = {
        ammo = "Knobkierrie",
        head = "Ptero. Armet +3",
        body = "Gleti's Cuirass",
        hands = "Gleti's Gauntlets",
        legs = "Gleti's Breeches",
        feet = "Nyame Sollerets",
        neck = "Dgn. Collar +2",
        waist = "Fotia Belt",
        left_ear = "Sherida Earring",
        right_ear = { name = "Moonshade Earring", augments = { 'Accuracy+4', 'TP Bonus +250', } },
        left_ring = "Regal Ring",
        right_ring = "Niqmaddu Ring",
        back = gear.jse_str_back,
    }

    sets.precast.WS['Sonic Thrust'] = set_combine(sets.precast.WS, {
        left_ring = "Regal Ring",
        right_ring = "Niqmaddu Ring",
    })


    -- Idle sets
    -- 40% DT/PDT
    sets.idle = {
        ammo = "Staunch Tathlum +1", -- 3%
        head = "Gleti's Mask",
        body = "Gleti's Cuirass",
        hands = "Gleti's Gauntlets",
        legs = "Gleti's Breeches",
        feet = "Gleti's Boots",
        neck = "Dgn. Collar +2",
        waist = "Flume Belt +1", -- 4%
        left_ear = "Infused Earring",
        right_ear = "Etiolation Earring",
        left_ring = "Defending Ring", -- 10%
        right_ring = "Gelatinous Ring +1",
        back = gear.jse_da_back, -- 10%
    }

    sets.idle.DT = set_combine(sets.idle, {
        head = "Nyame Helm",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        legs = "Nyame Flanchard",
    })

    sets.idle.Town = {
        ammo = "Coiste Bodhar",
        head = "Nyame Helm",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets",
        neck = "Dgn. Collar +2",
        waist = "Ioskeha Belt +1",
        left_ear = "Sherida Earring",
        right_ear = "Telos Earring",
        left_ring = "Regal Ring",
        right_ring = "Niqmaddu Ring",
        back = gear.jse_da_back,
    }

    sets.idle.Refresh = {}
    sets.idle.Reraise = set_combine(sets.idle, {})

    -- Defense sets
    sets.defense.PDT = {
        ammo = "Staunch Tathlum +1",
        head = "Nyame Helm",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets",
        neck = "Dgn. Collar +2",
        waist = "Flume Belt +1",
        left_ear = "Etiolation Earring",
        right_ear = "Odnowa Earring +1",
        left_ring = "Defending Ring",
        right_ring = "Gelatinous Ring +1",
        back = "Moonbeam Cape",
    }

    sets.defense.MDT = sets.defense.PDT
    sets.defense.MEVA = sets.defense.PDT

    sets.resting = sets.defense.PDT
    sets.idle.Weak = sets.defense.PDT

    sets.Kiting = { legs = "Carmine Cuisses +1" }
    sets.Reraise = {}
    sets.buff.Doom = set_combine(sets.buff.Doom, {})

    -- Extra defense sets.  Apply these on top of melee or defense sets.
    sets.TreasureHunter = set_combine(sets.TreasureHunter, {})

    -- Swap to these on Moonshade using WS if at 3000 TP
    sets.MaxTP = {}
    sets.AccMaxTP = {}
    sets.AccDayMaxTPWSEars = {}
    sets.DayMaxTPWSEars = {}
    sets.AccDayWSEars = {}
    sets.DayWSEars = {}

    -- Engaged sets

    --1282 ACC
    --40% DA
    --46% PDT/DT
    --379 MEVA
    sets.engaged = {
        ammo = "Coiste Bodhar",
        head = "Hjarrandi Helm",
        body = "Gleti's Cuirass",
        hands = "Sulev. Gauntlets +2",
        legs = "Ptero. Brais +3",
        feet = "Gleti's Boots",
        neck = "Dgn. Collar +2",
        waist = "Ioskeha Belt +1",
        left_ear = "Sherida Earring",
        right_ear = "Telos Earring",
        left_ring = "Chirich Ring +1",
        right_ring = "Niqmaddu Ring",
        back = gear.jse_da_back,
    }

    -- 1329 ACC
    sets.engaged.Acc = {
        ammo = "Coiste Bodhar",
        head = "Vishap Armet +3",
        body = "Hjarrandi Breast.",
        hands = "Vis. Fng. Gaunt. +3",
        legs = "Vishap Brais +3",
        feet = "Ptero. Greaves +3",
        neck = "Dgn. Collar +2",
        waist = "Ioskeha Belt +1",
        left_ear = "Sherida Earring",
        right_ear = "Telos Earring",
        left_ring = "Chirich Ring +1",
        right_ring = "Niqmaddu Ring",
        back = gear.jse_da_back,
    }

    -- Pet LV 1+ / -33 DT
    -- 49 DT/PDT
    -- 1264 ACC
    -- 599 MEVA
    sets.engaged.DT = {
        ammo = "Staunch Tathlum +1",
        head = "Nyame Helm",
        body = "Nyame Mail",
        hands = "Gleti's Gauntlets",
        legs = "Nyame Flanchard",
        feet = "Gleti's Boots",
        neck = "Dgn. Collar +2",
        waist = "Ioskeha Belt +1",
        left_ear = "Sherida Earring",
        right_ear = "Telos Earring",
        left_ring = "Chirich Ring +1",
        right_ring = "Niqmaddu Ring",
        back = gear.jse_da_back,
    }

    sets.engaged.DT.Acc = sets.engaged.DT

    sets.engaged.AM = sets.engaged
    sets.engaged.AM.Acc = sets.engaged.Acc

    sets.engaged.AM.DT = sets.engaged.DT
    sets.engaged.AM.Acc.DT = sets.engaged.DT

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(5, 13)
    elseif player.sub_job == 'SAM' then
        set_macro_page(3, 13)
    elseif player.sub_job == 'BLU' then
        set_macro_page(2, 13)
    else
        set_macro_page(5, 13)
    end
end
