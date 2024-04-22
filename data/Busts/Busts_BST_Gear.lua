function user_job_setup()

    state.OffenseMode:options('Normal')
    state.HybridMode:options('DT', 'Normal', 'HybridPet')
    state.WeaponskillMode:options('Normal')
    state.CastingMode:options('Normal')
    state.IdleMode:options('Normal', 'Refresh', 'Reraise')
    state.RestingMode:options('Normal')
    state.PhysicalDefenseMode:options('PDT')
    state.MagicalDefenseMode:options('MDT')
    state.ResistDefenseMode:options('MEVA')
    state.Weapons:options('Agwu', 'Dolichenus', 'None')
    state.ExtraMeleeMode = M { ['description'] = 'Extra Melee Mode', 'None' }
    state.JugMode = M { ['description'] = 'Jug Mode', 'GenerousArthur', 'FatsoFargann', 'ScissorlegXerin', 'SweetCaroline' }
    state.CorrelationMode = M { ['description'] = 'Correlation Mode', 'Neutral', 'Favorable' }
    state.PetMode = M { ['description'] = 'Pet Mode', 'DD' }
    state.RewardMode = M { ['description'] = 'Reward Mode', 'Theta' }
    state.AutoFightMode = M(false, 'Auto Fight Mode')
    state.AutoReadyMode = M(true, 'Auto Ready Mode')
    state.AutoCallPet = M(false, 'Auto Call Pet')
    ready_moves.default.FatsoFargann = 'TP Drainkiss'
    ready_moves.default.GenerousArthur = 'Purulent Ooze'
    ready_moves.default.GenerousArthur = 'Corrosive Ooze'
    silibs.enable_cancel_outranged_ws()
    silibs.enable_cancel_on_blocking_status()
    silibs.enable_weapon_rearm()
    silibs.enable_auto_lockstyle(3)
    silibs.enable_waltz_refiner()
    silibs.enable_premade_commands()
    silibs.enable_th()
    silibs.enable_ui()

    autows_list = { ['PetPDTAxe'] = 'Ruinator', ['DualWeapons'] = 'Ruinator' }

    gear.jse_tp_back = { name = "Artio's Mantle", augments = { 'DEX+20', 'Accuracy+20 Attack+20', 'Accuracy+10', '"Dbl.Atk."+10', 'Phys. dmg. taken-10%', } }
    gear.jse_petmacc_back = { name = "Artio's Mantle", augments = { 'Pet: M.Acc.+20 Pet: M.Dmg.+20', 'Eva.+20 /Mag. Eva.+20', 'Pet: Mag. Acc.+10', 'Pet: "Regen"+10', 'System: 1 ID: 1246 Val: 4', } }

    send_command('bind ^\\\\ gs c cycle JugMode')
    send_command('bind @f6 gs c toggle AutoCallPet')
    send_command('bind @f7 gs c toggle AutoFightMode')
    send_command('bind @f8 gs c toggle AutoReadyMode')
    send_command('bind @\\\\ gs c cycle CorrelationMode')
    send_command('bind !\\\\ gs c cycle PetMode')
    send_command('bind ^backspace gs c ready default')
    send_command('bind !` input /pet "Fight" <t>;')
    send_command('bind ^` input /pet "Leave" <me>;')
    send_command('bind @` input /pet "Heel" <me>;')
    send_command('hb reload; wait 15')

    select_default_macro_book()
end

function init_gear_sets()

    -- Weapons sets
    sets.weapons.Aymur = { main = "Aymur", sub = "Adapa Shield" }
    sets.weapons.Guttler = { main = "Guttler", sub = "Adapa Shield" }
    sets.weapons.Agwu = { main = "Agwu's Axe", sub = "Adapa Shield" }
    sets.weapons.Dolichenus = { main = "Dolichenus", sub = "Adapa Shield" }

    -- PRECAST SETS
    sets.precast.JA['Killer Instinct'] = { head = "Ankusa Helm +1" }
    sets.precast.JA['Bestial Loyalty'] = { hands = "Ankusa Gloves +1", feet = "Gleti's Boots" }
    sets.precast.JA['Call Beast'] = sets.precast.JA['Bestial Loyalty']
    sets.precast.JA.Familiar = { legs = "Ankusa Trousers +3" }
    sets.precast.JA.Tame = {} -- head="Totemic Helm +1"
    sets.precast.JA.Spur = { back = "Artio's Mantle" } -- feet="Nukumi Ocreae +1"

    sets.precast.JA['Feral Howl'] = {}

    sets.precast.JA.Reward = {
        head = "Nyame Helm",
        body = "Tot. Jackcoat +3",
        hands = "Malignance Gloves",
        legs = "Ankusa Trousers +3",
        feet = "Ankusa Gaiters +3",
        neck = { name = "Loricate Torque +1", augments = { 'Path: A', } },
        waist = "Flume Belt +1",
        left_ear = "Odnowa Earring +1",
        right_ear = "Enmerkar Earring",
        left_ring = "Regal Ring",
        right_ring = { name = "Metamor. Ring +1", augments = { 'Path: A', } },
        back = gear.jse_tp_back,
    }

    sets.precast.JA.Reward.Theta = set_combine(sets.precast.JA.Reward, { ammo = "Pet Food Theta" })
    -- sets.precast.JA.Reward.Zeta = set_combine(sets.precast.JA.Reward, {ammo="Pet Food Zeta"})
    -- sets.precast.JA.Reward.Eta = set_combine(sets.precast.JA.Reward, {ammo="Pet Food Eta"})

    sets.RewardAxe = {}
    sets.RewardAxesDW = {}

    sets.precast.JA.Charm = {}

    -- DNC Sub
    sets.precast.Waltz = {}
    sets.precast.Waltz['Healing Waltz'] = {}
    sets.precast.Step = {}
    sets.precast.Flourish1 = {}
    sets.precast.Flourish1['Violent Flourish'] = {}

    sets.precast.FC = {
        ammo = "Impatiens", -- QC
        head = "Malignance Chapeau",
        body = "Malignance Tabard",
        hands = "Leyline Gloves", -- 6
        legs = "Malignance Tights",
        feet = "Malignance Boots",
        neck = "Baetyl Pendant", -- 4
        waist = "Flume Belt +1",
        left_ear = "Loquac. Earring", -- 2
        right_ear = "Etiolation Earring", -- 1
        left_ring = "Defending Ring",
        right_ring = "Lebeche Ring", -- QC
        back = gear.jse_tp_back,
    }

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, { neck = "Magoraga Beads" })

    -- MIDCAST SETS
    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {})

    sets.midcast.Cure = {
        head = "Nyame Helm",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets",
        neck = "Loricate Torque +1",
        waist = gear.dt_waist,
        left_ear = "Calamitous Earring",
        right_ear = "Mendi. Earring",
        left_ring = "Regal Ring",
        right_ring = { name = "Metamor. Ring +1", augments = { 'Path: A', } },
        back = "Solemnity Cape",
    }

    sets.midcast.Curaga = sets.midcast.Cure

    sets.Self_Healing = { waist = "Gishdubar Sash" }
    sets.Cure_Received = { waist = "Gishdubar Sash" }
    sets.Self_Refresh = { waist = "Gishdubar Sash" }

    sets.midcast.Stoneskin = sets.midcast.FastRecast
    sets.midcast.Cursna = set_combine(sets.midcast.FastRecast, {})
    sets.midcast.Protect = set_combine(sets.midcast.FastRecast, {})
    sets.midcast.Protectra = sets.midcast.Protect
    sets.midcast.Shell = set_combine(sets.midcast.FastRecast, {})
    sets.midcast.Shellra = sets.midcast.Shell

    sets.midcast['Enfeebling Magic'] = sets.midcast.FastRecast
    sets.midcast['Elemental Magic'] = sets.midcast.FastRecast
    sets.midcast.Helix = sets.midcast['Elemental Magic']
    sets.midcast.Helix.Resistant = sets.midcast['Elemental Magic']

    -- Default weaponskill sets.
    sets.precast.WS = {
        ammo = "Coiste Bodhar",
        head = "Nyame Helm",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets",
        neck = "Fotia Gorget",
        waist = "Fotia Belt",
        left_ear = "Sherida Earring",
        right_ear = "Moonshade Earring",
        left_ring = "Regal Ring",
        right_ring = "Beithir Ring",
        back = gear.jse_tp_back,
    }

    sets.precast.WS['Ruinator'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Onslaught'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Primal Rend'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Cloudsplitter'] = set_combine(sets.precast.WS['Primal Rend'], {})

    -- Swap to these on Moonshade using WS if at 3000 TP
    sets.MaxTP = { ear1 = "Thrud Earring", ear2 = "Lugra Earring +1", }
    sets.AccMaxTP = { ear1 = "Thrud Earring", ear2 = "Lugra Earring +1", }
    sets.AccDayMaxTPWSEars = { ear1 = "Thrud Earring", ear2 = "Lugra Earring +1" }
    sets.DayMaxTPWSEars = { ear1 = "Thrud Earring", ear2 = "Lugra Earring +1", }
    sets.AccDayWSEars = { ear1 = "Lugra Earring +1", ear2 = "Moonshade Earring" }
    sets.DayWSEars = { ear1 = "Lugra Earring +1", ear2 = "Moonshade Earring", }

    -- PET SIC & READY MOVES
    sets.midcast.Pet.WS = {
        ammo = "Hesperiidae",
        head = "Nyame Helm",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        legs = "Gleti's Breeches",
        feet = "Gleti's Boots",
        neck = "Adad Amulet",
        waist = "Incarnation Sash",
        left_ear = "Crep. Earring",
        right_ear = "Enmerkar Earring",
        left_ring = "Tali'Ah Ring",
        right_ring = "C. Palug Ring",
        back = gear.jse_petmacc_back,
    }

    sets.midcast.Pet.MagicReady = {
        ammo = "Hesperiidae",
        head = "Nyame Helm",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        legs = "Gleti's Breeches",
        feet = "Gleti's Boots",
        neck = "Adad Amulet",
        waist = "Incarnation Sash",
        left_ear = "Crep. Earring",
        right_ear = "Enmerkar Earring",
        left_ring = "Tali'Ah Ring",
        right_ring = "C. Palug Ring",
        back = gear.jse_petmacc_back,
    }

    sets.midcast.Pet.DebuffReady = set_combine(sets.midcast.Pet.MagicReady, {})
    sets.midcast.Pet.PhysicalDebuffReady = set_combine(sets.midcast.Pet.DebuffReady, {})

    sets.midcast.Pet.ReadyRecast = { legs = "Gleti's Breeches" }
    sets.midcast.Pet.ReadyRecastDW = sets.midcast.Pet.ReadyRecast
    sets.midcast.Pet.Neutral = {}
    sets.midcast.Pet.Favorable = {} --{head="Nukumi Cabasset"}
    sets.midcast.Pet.TPBonus = {} --{hands="Nukumi Manoplas +1"}

    -- RESTING
    sets.resting = {}

    sets.idle = {
        ammo = "Staunch Tathlum +1",
        head = "Malignance Chapeau",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        legs = "Malignance Tights",
        feet = "Malignance Boots",
        neck = "Sanctity Necklace",
        waist = "Flume Belt +1",
        left_ear = "Infused Earring",
        right_ear = "Etiolation Earring",
        left_ring = "Defending Ring",
        right_ring = "Gelatinous Ring +1",
        back = gear.jse_tp_back,
    }

    sets.idle.Town = {
        ammo = "Staunch Tathlum +1",
        head = "Nyame Helm",
        body = "Nyame Mail",
        hands = "Nyame Gauntlets",
        legs = "Nyame Flanchard",
        feet = "Nyame Sollerets",
        neck = "Loricate Torque +1",
        waist = "Flume Belt +1",
        left_ear = "Infused Earring",
        right_ear = "Etiolation Earring",
        left_ring = "Defending Ring",
        right_ring = "Beithir Ring",
        back = gear.jse_tp_back,
    }

    sets.idle.Refresh = set_combine(sets.idle, {})
    sets.idle.Reraise = set_combine(sets.idle, {})

    --Master 43
    --Pet 43
    sets.idle.Pet = { -- Master   -- Pet
        ammo = "Staunch Tathlum +1", -- 3
        head = "Nyame Helm", -- 7
        body = "Tot. Jackcoat +3", --          10
        hands = "Gleti's Gauntlets", -- 7        8
        legs = "Tali'ah Sera. +2", --          5
        feet = "Gleti's Boots", -- 5
        neck = "Loricate Torque +1", -- 6
        waist = "Isa Belt", --          3
        left_ear = "Handler's Earring +1", --          4
        right_ear = "Enmerkar Earring", --          3
        left_ring = "Defending Ring", -- 10
        right_ring = "C. Palug Ring", -- 5
        back = gear.jse_petmacc_back, --          10
    }

    sets.idle.Pet.Engaged = set_combine(sets.idle.Pet, {})
    sets.idle.Pet.Engaged.DW = set_combine(sets.idle.Pet.Engaged, {})

    -- DEFENSE SETS
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

    sets.Kiting = {}
    sets.DayIdle = {}
    sets.NightIdle = {}

    -- MELEE (SINGLE-WIELD) SETS
    sets.engaged = {
        ammo = "Coiste Bodhar",
        head = "Malignance Chapeau",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        legs = "Malignance Tights",
        feet = "Malignance Boots",
        neck = "Combatant's Torque",
        waist = "Windbuffet Belt +1",
        left_ear = "Sherida Earring",
        right_ear = "Telos Earring",
        left_ring = "Petrov Ring",
        right_ring = "Gere Ring",
        back = gear.jse_tp_back,
    }

    sets.engaged.Acc = set_combine(sets.engaged, {})

    -- MELEE (SINGLE-WIELD) HYBRID SETS
    sets.engaged.DT = {
        ammo = "Coiste Bodhar",
        head = "Malignance Chapeau",
        body = "Malignance Tabard",
        hands = "Malignance Gloves",
        legs = "Malignance Tights",
        feet = "Malignance Boots",
        neck = "Combatant's Torque",
        waist = "Windbuffet Belt +1",
        left_ear = "Sherida Earring",
        right_ear = "Telos Earring",
        left_ring = "Chirich Ring +1",
        right_ring = "Gere Ring",
        back = gear.jse_tp_back,
    }

    sets.engaged.Acc.DT = set_combine(sets.engaged.DT, {})

    -- MELEE (DUAL-WIELD) SETS FOR DNC AND NIN SUBJOB
    sets.engaged.DW = set_combine(sets.engaged, { waist = "Reiki Yotai", right_ear = "Suppanomimi", })
    sets.engaged.DW.Acc = set_combine(sets.engaged.Acc, { waist = "Reiki Yotai", right_ear = "Suppanomimi", })

    -- MELEE (DUAL-WIELD) HYBRID SETS
    sets.engaged.DW.DT = set_combine(sets.engaged.DT, { waist = "Reiki Yotai", right_ear = "Suppanomimi" })
    sets.engaged.DW.Acc.DT = set_combine(sets.engaged.Acc.DT, { waist = "Reiki Yotai", right_ear = "Suppanomimi" })

    -- GEARSETS FOR MASTER ENGAGED (SINGLE-WIELD) & PET TANKING
    sets.engaged.HybridPet = set_combine(sets.engaged, {})
    sets.engaged.HybridPet.Acc = set_combine(sets.engaged.Acc, {})

    -- GEARSETS FOR MASTER ENGAGED (DUAL-WIELD) & PET TANKING
    sets.engaged.DW.HybridPet = set_combine(sets.engaged.DW, {})
    sets.engaged.DW.HybridPet.Acc = set_combine(sets.engaged.DW.Acc, {})

    sets.buff['Killer Instinct'] = {} --{body="Nukumi Gausape +1"}
    sets.buff.Doom = set_combine(sets.buff.Doom, {})
    sets.TreasureHunter = set_combine(sets.TreasureHunter, {})


    -------------------------------------------------------------------------------------------------------------------
    -- Complete Lvl 76-99 Jug Pet Precast List +Funguar +Courier +Amigo
    -------------------------------------------------------------------------------------------------------------------

    sets.precast.JA['Bestial Loyalty'].FunguarFamiliar = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "Seedbed Soil" })
    sets.precast.JA['Bestial Loyalty'].CourierCarrie = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "Fish Oil Broth" })
    sets.precast.JA['Bestial Loyalty'].AmigoSabotender = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "Sun Water" })
    sets.precast.JA['Bestial Loyalty'].NurseryNazuna = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "D. Herbal Broth" })
    sets.precast.JA['Bestial Loyalty'].CraftyClyvonne = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "Cng. Brain Broth" })
    sets.precast.JA['Bestial Loyalty'].PrestoJulio = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "C. Grass. Broth" })
    sets.precast.JA['Bestial Loyalty'].SwiftSieghard = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "Mlw. Bird Broth" })
    sets.precast.JA['Bestial Loyalty'].MailbusterCetas = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "Gob. Bug Broth" })
    sets.precast.JA['Bestial Loyalty'].AudaciousAnna = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "B. Carrion Broth" })
    sets.precast.JA['Bestial Loyalty'].TurbidToloi = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "Auroral Broth" })
    sets.precast.JA['Bestial Loyalty'].LuckyLulush = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "L. Carrot Broth" })
    sets.precast.JA['Bestial Loyalty'].DipperYuly = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "Wool Grease" })
    sets.precast.JA['Bestial Loyalty'].FlowerpotMerle = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "Vermihumus" })
    sets.precast.JA['Bestial Loyalty'].DapperMac = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "Briny Broth" })
    sets.precast.JA['Bestial Loyalty'].DiscreetLouise = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "Deepbed Soil" })
    sets.precast.JA['Bestial Loyalty'].FatsoFargann = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "C. Plasma Broth" })
    sets.precast.JA['Bestial Loyalty'].FaithfulFalcorr = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "Lucky Broth" })
    sets.precast.JA['Bestial Loyalty'].BugeyedBroncha = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "Svg. Mole Broth" })
    sets.precast.JA['Bestial Loyalty'].BloodclawShasra = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "Rzr. Brain Broth" })
    sets.precast.JA['Bestial Loyalty'].GorefangHobs = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "B. Carrion Broth" })
    sets.precast.JA['Bestial Loyalty'].GooeyGerard = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "Cl. Wheat Broth" })
    sets.precast.JA['Bestial Loyalty'].CrudeRaphie = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "Shadowy Broth" })

    -------------------------------------------------------------------------------------------------------------------
    -- Complete iLvl Jug Pet Precast List
    -------------------------------------------------------------------------------------------------------------------

    sets.precast.JA['Bestial Loyalty'].DroopyDortwin = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "Swirling Broth" })
    sets.precast.JA['Bestial Loyalty'].PonderingPeter = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "Vis. Broth" })
    sets.precast.JA['Bestial Loyalty'].SunburstMalfik = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "Shimmering Broth" })
    sets.precast.JA['Bestial Loyalty'].AgedAngus = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "Ferm. Broth" })
    sets.precast.JA['Bestial Loyalty'].WarlikePatrick = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "Livid Broth" })
    sets.precast.JA['Bestial Loyalty'].ScissorlegXerin = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "Spicy Broth" })
    sets.precast.JA['Bestial Loyalty'].BouncingBertha = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "Bubbly Broth" })
    sets.precast.JA['Bestial Loyalty'].RhymingShizuna = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "Lyrical Broth" })
    sets.precast.JA['Bestial Loyalty'].AttentiveIbuki = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "Salubrious Broth" })
    sets.precast.JA['Bestial Loyalty'].SwoopingZhivago = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "Windy Greens" })
    sets.precast.JA['Bestial Loyalty'].AmiableRoche = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "Airy Broth" })
    sets.precast.JA['Bestial Loyalty'].HeraldHenry = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "Trans. Broth" })
    sets.precast.JA['Bestial Loyalty'].BrainyWaluis = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "Crumbly Soil" })
    sets.precast.JA['Bestial Loyalty'].HeadbreakerKen = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "Blackwater Broth" })
    sets.precast.JA['Bestial Loyalty'].SuspiciousAlice = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "Furious Broth" })
    sets.precast.JA['Bestial Loyalty'].AnklebiterJedd = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "Crackling Broth" })
    sets.precast.JA['Bestial Loyalty'].FleetReinhard = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "Rapid Broth" })
    sets.precast.JA['Bestial Loyalty'].CursedAnnabelle = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "Creepy Broth" })
    sets.precast.JA['Bestial Loyalty'].SurgingStorm = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "Insipid Broth" })
    sets.precast.JA['Bestial Loyalty'].SubmergedIyo = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "Deepwater Broth" })
    sets.precast.JA['Bestial Loyalty'].RedolentCandi = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "Electrified Broth" })
    sets.precast.JA['Bestial Loyalty'].AlluringHoney = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "Bug-Ridden Broth" })
    sets.precast.JA['Bestial Loyalty'].CaringKiyomaro = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "Fizzy Broth" })
    sets.precast.JA['Bestial Loyalty'].VivaciousVickie = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "Tant. Broth" })
    sets.precast.JA['Bestial Loyalty'].HurlerPercival = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "Pale Sap" })
    sets.precast.JA['Bestial Loyalty'].BlackbeardRandy = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "Meaty Broth" })
    sets.precast.JA['Bestial Loyalty'].GenerousArthur = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "Dire Broth" })
    sets.precast.JA['Bestial Loyalty'].ThreestarLynn = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "Muddy Broth" })
    sets.precast.JA['Bestial Loyalty'].MosquitoFamiliar = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "Wetlands Broth" })
    sets.precast.JA['Bestial Loyalty']['Left-HandedYoko'] = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "Heavenly Broth" })
    sets.precast.JA['Bestial Loyalty'].BraveHeroGlenn = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "Wispy Broth" })
    sets.precast.JA['Bestial Loyalty'].SharpwitHermes = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "Saline Broth" })
    sets.precast.JA['Bestial Loyalty'].ColibriFamiliar = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "Sugary Broth" })
    sets.precast.JA['Bestial Loyalty'].ChoralLeera = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "Glazed Broth" })
    sets.precast.JA['Bestial Loyalty'].SpiderFamiliar = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "Sticky Webbing" })
    sets.precast.JA['Bestial Loyalty'].GussyHachirobe = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "Slimy Webbing" })
    sets.precast.JA['Bestial Loyalty'].AcuexFamiliar = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "Poisonous Broth" })
    sets.precast.JA['Bestial Loyalty'].FluffyBredo = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "Venomous Broth" })
    sets.precast.JA['Bestial Loyalty'].WeevilFamiliar = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "Pristine Sap" })
    sets.precast.JA['Bestial Loyalty'].StalwartAngelina = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "T. Pristine Sap" })
    sets.precast.JA['Bestial Loyalty'].SweetCaroline = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "Aged Humus" })
    sets.precast.JA['Bestial Loyalty']['P.CrabFamiliar'] = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "Rancid Broth" })
    sets.precast.JA['Bestial Loyalty'].JovialEdwin = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "Pungent Broth" })
    sets.precast.JA['Bestial Loyalty']['Y.BeetleFamiliar'] = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "Zestful Sap" })
    sets.precast.JA['Bestial Loyalty'].EnergizedSefina = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "Gassy Sap" })
    sets.precast.JA['Bestial Loyalty'].LynxFamiliar = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "Frizzante Broth" })
    sets.precast.JA['Bestial Loyalty'].VivaciousGaston = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "Spumante Broth" })
    sets.precast.JA['Bestial Loyalty']['Hip.Familiar'] = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "Turpid Broth" })
    sets.precast.JA['Bestial Loyalty'].DaringRoland = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "Feculent Broth" })
    sets.precast.JA['Bestial Loyalty'].SlimeFamiliar = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "Decaying Broth" })
    sets.precast.JA['Bestial Loyalty'].SultryPatrice = set_combine(sets.precast.JA['Bestial Loyalty'], { ammo = "Putrescent Broth" })


end

function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(6, 16)
    elseif player.sub_job == 'NIN' then
        set_macro_page(4, 16)
    elseif player.sub_job == 'THF' then
        set_macro_page(6, 16)
    elseif player.sub_job == 'RUN' then
        set_macro_page(6, 16)
    else
        set_macro_page(6, 16)
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
