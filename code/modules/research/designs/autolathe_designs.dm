///////////////////////////////////
//////////Autolathe Designs ///////
///////////////////////////////////

/datum/design/bucket
	name = "Ведро"
	id = "bucket"
	build_type = AUTOLATHE | PROTOLATHE
	materials = list(/datum/material/iron = 200)
	build_path = /obj/item/reagent_containers/glass/bucket
	category = list("initial","Tools","Tool Designs")
	departmental_flags = DEPARTMENTAL_FLAG_SERVICE

/datum/design/mop
	name = "Швабра"
	id = "mop"
	build_type = AUTOLATHE | PROTOLATHE
	materials = list(/datum/material/iron = 1000)
	build_path = /obj/item/mop
	category = list("initial","Tools","Tool Designs")
	departmental_flags = DEPARTMENTAL_FLAG_SERVICE

/datum/design/crowbar
	name = "Карманный лом"
	id = "crowbar"
	build_type = AUTOLATHE | PROTOLATHE
	materials = list(/datum/material/iron = 50)
	build_path = /obj/item/crowbar
	category = list("initial","Tools","Tool Designs")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/flashlight
	name = "Фонарик"
	id = "flashlight"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 50, /datum/material/glass = 20)
	build_path = /obj/item/flashlight
	category = list("initial","Tools")

/datum/design/extinguisher
	name = "Огнетушитель"
	id = "extinguisher"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 90)
	build_path = /obj/item/extinguisher
	category = list("initial","Tools")

/datum/design/pocketfireextinguisher
	name = "Карманный огнетушитель"
	id = "pocketfireextinguisher"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 50, /datum/material/glass = 40)
	build_path = /obj/item/extinguisher/mini
	category = list("initial","Tools")

/datum/design/multitool
	name = "Мультитул"
	id = "multitool"
	build_type = AUTOLATHE | PROTOLATHE
	materials = list(/datum/material/iron = 50, /datum/material/glass = 20)
	build_path = /obj/item/multitool
	category = list("initial","Tools","Tool Designs")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/analyzer
	name = "Газоанализатор"
	id = "analyzer"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 30, /datum/material/glass = 20)
	build_path = /obj/item/analyzer
	category = list("initial","Tools","Tool Designs")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/tscanner
	name = "Т-лучевой сканер"
	id = "tscanner"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 150)
	build_path = /obj/item/t_scanner
	category = list("initial","Tools","Tool Designs")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/weldingtool
	name = "Сварочный аппарат"
	id = "welding_tool"
	build_type = AUTOLATHE | PROTOLATHE
	materials = list(/datum/material/iron = 70, /datum/material/glass = 20)
	build_path = /obj/item/weldingtool
	category = list("initial","Tools","Tool Designs")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/mini_weldingtool
	name = "Аварийный сварочный аппарат"
	id = "mini_welding_tool"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 30, /datum/material/glass = 10)
	build_path = /obj/item/weldingtool/mini
	category = list("initial","Tools")

/datum/design/screwdriver
	name = "Отвёртка"
	id = "screwdriver"
	build_type = AUTOLATHE | PROTOLATHE
	materials = list(/datum/material/iron = 75)
	build_path = /obj/item/screwdriver
	category = list("initial","Tools","Tool Designs")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/wirecutters
	name = "Кусачки"
	id = "wirecutters"
	build_type = AUTOLATHE | PROTOLATHE
	materials = list(/datum/material/iron = 80)
	build_path = /obj/item/wirecutters
	category = list("initial","Tools","Tool Designs")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/wrench
	name = "Гаечный ключ"
	id = "wrench"
	build_type = AUTOLATHE | PROTOLATHE
	materials = list(/datum/material/iron = 150)
	build_path = /obj/item/wrench
	category = list("initial","Tools","Tool Designs")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/plunger
	name = "Вантуз"
	id = "plunger"
	build_type = AUTOLATHE | PROTOLATHE
	materials = list(/datum/material/iron = 150)
	build_path = /obj/item/plunger
	category = list("initial","Tools","Tool Designs")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_MEDICAL

/datum/design/welding_helmet
	name = "Сварочный шлем"
	id = "welding_helmet"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 1750, /datum/material/glass = 400)
	build_path = /obj/item/clothing/head/welding
	category = list("initial","Tools")

/datum/design/cable_coil
	name = "Моток кабеля"
	id = "cable_coil"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 10, /datum/material/glass = 5)
	build_path = /obj/item/stack/cable_coil
	category = list("initial","Tools","Tool Designs")
	maxstack = MAXCOIL
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/toolbox
	name = "Ящик для инструментов"
	id = "tool_box"
	build_type = AUTOLATHE
	materials = list(MAT_CATEGORY_RIGID = 500)
	build_path = /obj/item/storage/toolbox
	category = list("initial","Tools")

/datum/design/apc_board
	name = "Модуль ЛКП"
	id = "power control"
	build_type = AUTOLATHE | PROTOLATHE
	materials = list(/datum/material/iron = 100, /datum/material/glass = 100)
	build_path = /obj/item/electronics/apc
	category = list("initial", "Electronics")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/airlock_board
	name = "Электроника шлюза"
	id = "airlock_board"
	build_type = AUTOLATHE | PROTOLATHE
	materials = list(/datum/material/iron = 50, /datum/material/glass = 50)
	build_path = /obj/item/electronics/airlock
	category = list("initial", "Electronics")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/firelock_board
	name = "Цепи противопожарного шлюза"
	id = "firelock_board"
	build_type = AUTOLATHE | PROTOLATHE
	materials = list(/datum/material/iron = 50, /datum/material/glass = 50)
	build_path = /obj/item/electronics/firelock
	category = list("initial", "Electronics")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/airalarm_electronics
	name = "Электроника воздушной сигнализации"
	id = "airalarm_electronics"
	build_type = AUTOLATHE | PROTOLATHE
	materials = list(/datum/material/iron = 50, /datum/material/glass = 50)
	build_path = /obj/item/electronics/airalarm
	category = list("initial", "Electronics")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/firealarm_electronics
	name = "Электроника пожарной сигнализации"
	id = "firealarm_electronics"
	build_type = AUTOLATHE | PROTOLATHE
	materials = list(/datum/material/iron = 50, /datum/material/glass = 50)
	build_path = /obj/item/electronics/firealarm
	category = list("initial", "Electronics")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/camera
	name = "Фотоаппарат"
	id = "camera"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 50, /datum/material/glass = 100)
	build_path = /obj/item/camera
	category = list("initial", "Misc")

/datum/design/camera_film
	name = "Картридж с фотоплёнкой"
	id = "camera_film"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 10, /datum/material/glass = 10)
	build_path = /obj/item/camera_film
	category = list("initial", "Misc")

/datum/design/earmuffs
	name = "Наушники"
	id = "earmuffs"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 500, /datum/material/glass = 500)
	build_path = /obj/item/clothing/ears/earmuffs
	category = list("initial", "Misc")

/datum/design/pipe_painter
	name = "Покрасчик труб"
	id = "pipe_painter"
	build_type = AUTOLATHE | PROTOLATHE
	materials = list(/datum/material/iron = 5000, /datum/material/glass = 2000)
	build_path = /obj/item/pipe_painter
	category = list("initial","Tools","Tool Designs")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/airlock_painter
	name = "Покрасчик шлюзов"
	id = "airlock_painter"
	build_type = AUTOLATHE | PROTOLATHE
	materials = list(/datum/material/iron = 50, /datum/material/glass = 50)
	build_path = /obj/item/airlock_painter
	category = list("initial","Tools","Tool Designs")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/emergency_oxygen
	name = "Аварийный баллон кислорода"
	id = "emergency_oxygen"
	build_type = AUTOLATHE | PROTOLATHE
	materials = list(/datum/material/iron = 500)
	build_path = /obj/item/tank/internals/emergency_oxygen/empty
	category = list("initial","Misc","Equipment")

/datum/design/emergency_oxygen_engi
	name = "Увеличенный аварийный баллон кислорода"
	id = "emergency_oxygen_engi"
	build_type = AUTOLATHE | PROTOLATHE
	materials = list(/datum/material/iron = 750)
	build_path = /obj/item/tank/internals/emergency_oxygen/engi/empty
	category = list("hacked","Misc","Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_CARGO

/datum/design/plasmaman_tank_belt
	name = "Поясной баллон плазмолюда"
	id = "plasmaman_tank_belt"
	build_type = AUTOLATHE | PROTOLATHE
	materials = list(/datum/material/iron = 800)
	build_path = /obj/item/tank/internals/plasmaman/belt/empty
	category = list("hacked","Misc","Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_CARGO

/datum/design/generic_gas_tank
	name = "Универсальный газовый баллон"
	id = "generic_tank"
	build_type = AUTOLATHE | PROTOLATHE
	materials = list(/datum/material/iron = 1000)
	build_path = /obj/item/tank/internals/generic
	category = list("initial","Misc","Equipment")

/datum/design/metal
	name = "Металл"
	id = "metal"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = MINERAL_MATERIAL_AMOUNT)
	build_path = /obj/item/stack/sheet/metal
	category = list("initial","Construction")
	maxstack = 50

/datum/design/glass
	name = "Стекло"
	id = "glass"
	build_type = AUTOLATHE
	materials = list(/datum/material/glass = MINERAL_MATERIAL_AMOUNT)
	build_path = /obj/item/stack/sheet/glass
	category = list("initial","Construction")
	maxstack = 50

/datum/design/rglass
	name = "Бронестекло"
	id = "rglass"
	build_type = AUTOLATHE | SMELTER | PROTOLATHE
	materials = list(/datum/material/iron = 1000, /datum/material/glass = MINERAL_MATERIAL_AMOUNT)
	build_path = /obj/item/stack/sheet/rglass
	category = list("initial","Construction","Stock Parts")
	maxstack = 50

/datum/design/rods
	name = "Металлический прут"
	id = "rods"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 1000)
	build_path = /obj/item/stack/rods
	category = list("initial","Construction")
	maxstack = 50

/datum/design/rcd_ammo
	name = "Картридж сжатой материи"
	id = "rcd_ammo"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 12000, /datum/material/glass = 8000)
	build_path = /obj/item/rcd_ammo
	category = list("initial","Construction")

/datum/design/kitchen_knife
	name = "Кухонный нож"
	id = "kitchen_knife"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 12000)
	build_path = /obj/item/kitchen/knife
	category = list("initial","Dinnerware")

/datum/design/plastic_knife
	name = "Пластиковый нож"
	id = "plastic_knife"
	build_type = AUTOLATHE | PROTOLATHE
	materials = list(/datum/material/plastic = 100)
	build_path = /obj/item/kitchen/knife/plastic
	category = list("initial", "Tool Designs","Dinnerware")

/datum/design/fork
	name = "Вилка"
	id = "fork"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 80)
	build_path = /obj/item/kitchen/fork
	category = list("initial","Dinnerware")

/datum/design/plastic_fork
	name = "Пластиковая вилка"
	id = "plastic_fork"
	build_type = AUTOLATHE | PROTOLATHE
	materials = list(/datum/material/plastic = 80)
	build_path = /obj/item/kitchen/fork/plastic
	category = list("initial", "Tool Designs", "Dinnerware")
	departmental_flags = DEPARTMENTAL_FLAG_SERVICE

/datum/design/plastic_spoon
	name = "Пластиковая ложка"
	id = "plastic_spoon"
	build_type = AUTOLATHE | PROTOLATHE
	materials = list(/datum/material/plastic = 120)
	build_path = /obj/item/kitchen/spoon/plastic
	category = list("initial", "Tool Designs", "Dinnerware")
	departmental_flags = DEPARTMENTAL_FLAG_SERVICE

/datum/design/tray
	name = "Поднос"
	id = "tray"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 3000)
	build_path = /obj/item/storage/bag/tray
	category = list("initial","Dinnerware")

/datum/design/bowl
	name = "Миска"
	id = "bowl"
	build_type = AUTOLATHE
	materials = list(/datum/material/glass = 500)
	build_path = /obj/item/reagent_containers/glass/bowl
	category = list("initial","Dinnerware")

/datum/design/drinking_glass
	name = "Стакан"
	id = "drinking_glass"
	build_type = AUTOLATHE
	materials = list(/datum/material/glass = 500)
	build_path = /obj/item/reagent_containers/food/drinks/drinkingglass
	category = list("initial","Dinnerware")

/datum/design/shot_glass
	name = "Стопка"
	id = "shot_glass"
	build_type = AUTOLATHE
	materials = list(/datum/material/glass = 100)
	build_path = /obj/item/reagent_containers/food/drinks/drinkingglass/shotglass
	category = list("initial","Dinnerware")

/datum/design/shaker
	name = "Шейкер"
	id = "shaker"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 1500)
	build_path = /obj/item/reagent_containers/food/drinks/shaker
	category = list("initial","Dinnerware")

/datum/design/cultivator
	name = "Культиватор"
	id = "cultivator"
	build_type = AUTOLATHE | PROTOLATHE
	materials = list(/datum/material/iron=50)
	build_path = /obj/item/cultivator
	category = list("initial","Misc", "Tool Designs")
	departmental_flags = DEPARTMENTAL_FLAG_SERVICE

/datum/design/plant_analyzer
	name = "Анализатор растений"
	id = "plant_analyzer"
	build_type = AUTOLATHE | PROTOLATHE
	materials = list(/datum/material/iron = 30, /datum/material/glass = 20)
	build_path = /obj/item/plant_analyzer
	category = list("initial","Misc", "Tool Designs")
	departmental_flags = DEPARTMENTAL_FLAG_SERVICE

/datum/design/shovel
	name = "Лопата"
	id = "shovel"
	build_type = AUTOLATHE | PROTOLATHE
	materials = list(/datum/material/iron = 50)
	build_path = /obj/item/shovel
	category = list("initial","Misc", "Tool Designs")
	departmental_flags = DEPARTMENTAL_FLAG_SERVICE

/datum/design/spade
	name = "Совок"
	id = "spade"
	build_type = AUTOLATHE | PROTOLATHE
	materials = list(/datum/material/iron = 50)
	build_path = /obj/item/shovel/spade
	category = list("initial","Misc", "Tool Designs")
	departmental_flags = DEPARTMENTAL_FLAG_SERVICE

/datum/design/hatchet
	name = "Топорик"
	id = "hatchet"
	build_type = AUTOLATHE | PROTOLATHE
	materials = list(/datum/material/iron = 15000)
	build_path = /obj/item/hatchet
	category = list("initial","Misc", "Tool Designs")
	departmental_flags = DEPARTMENTAL_FLAG_SERVICE

/datum/design/foilhat
	name = "Шапочка из фольги"
	id = "tinfoil_hat"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 5500)
	build_path = /obj/item/clothing/head/foilhat
	category = list("hacked", "Misc")

/datum/design/scalpel
	name = "Скальпель"
	id = "scalpel"
	build_type = AUTOLATHE | PROTOLATHE
	materials = list(/datum/material/iron = 4000, /datum/material/glass = 1000)
	build_path = /obj/item/scalpel
	category = list("initial", "Medical", "Tool Designs")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/circular_saw
	name = "Циркулярная пила"
	id = "circular_saw"
	build_type = AUTOLATHE | PROTOLATHE
	materials = list(/datum/material/iron = 10000, /datum/material/glass = 6000)
	build_path = /obj/item/circular_saw
	category = list("initial", "Medical", "Tool Designs")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/surgicaldrill
	name = "Хирургическая дрель"
	id = "surgicaldrill"
	build_type = AUTOLATHE | PROTOLATHE
	materials = list(/datum/material/iron = 10000, /datum/material/glass = 6000)
	build_path = /obj/item/surgicaldrill
	category = list("initial", "Medical", "Tool Designs")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/retractor
	name = "Расширитель"
	id = "retractor"
	build_type = AUTOLATHE | PROTOLATHE
	materials = list(/datum/material/iron = 6000, /datum/material/glass = 3000)
	build_path = /obj/item/retractor
	category = list("initial", "Medical", "Tool Designs")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/cautery
	name = "Прижигатель"
	id = "cautery"
	build_type = AUTOLATHE | PROTOLATHE
	materials = list(/datum/material/iron = 2500, /datum/material/glass = 750)
	build_path = /obj/item/cautery
	category = list("initial", "Medical", "Tool Designs")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/hemostat
	name = "Гемостат"
	id = "hemostat"
	build_type = AUTOLATHE | PROTOLATHE
	materials = list(/datum/material/iron = 5000, /datum/material/glass = 2500)
	build_path = /obj/item/hemostat
	category = list("initial", "Medical", "Tool Designs")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/beaker
	name = "Мензурка"
	id = "beaker"
	build_type = AUTOLATHE | PROTOLATHE
	materials = list(/datum/material/glass = 500)
	build_path = /obj/item/reagent_containers/glass/beaker
	category = list("initial", "Medical", "Medical Designs")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL | DEPARTMENTAL_FLAG_SERVICE

/datum/design/large_beaker
	name = "Большая мензурка"
	id = "large_beaker"
	build_type = AUTOLATHE | PROTOLATHE
	materials = list(/datum/material/glass = 2500)
	build_path = /obj/item/reagent_containers/glass/beaker/large
	category = list("initial", "Medical", "Medical Designs")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL | DEPARTMENTAL_FLAG_SERVICE

/datum/design/pillbottle
	name = "Баночка для таблеток"
	id = "pillbottle"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 20, /datum/material/glass = 100)
	build_path = /obj/item/storage/pill_bottle
	category = list("initial", "Medical", "Medical Designs")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL

/datum/design/beanbag_slug
	name = "Травматический патрон"
	id = "beanbag_slug"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 2000)
	build_path = /obj/item/ammo_casing/shotgun/beanbag
	category = list("initial", "Security")

/datum/design/rubbershot
	name = "Резиновая дробь"
	id = "rubber_shot"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 4000)
	build_path = /obj/item/ammo_casing/shotgun/rubbershot
	category = list("initial", "Security")

/datum/design/c38
	name = "Спидлоадер (.38)"
	id = "c38"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 20000)
	build_path = /obj/item/ammo_box/c38
	category = list("initial", "Security")

/datum/design/recorder
	name = "Универсальный диктофон"
	id = "recorder"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 60, /datum/material/glass = 30)
	build_path = /obj/item/taperecorder/empty
	category = list("initial", "Misc")

/datum/design/tape
	name = "Кассета"
	id = "tape"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 20, /datum/material/glass = 5)
	build_path = /obj/item/tape/random
	category = list("initial", "Misc")

/datum/design/igniter
	name = "Воспламенитель"
	id = "igniter"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 500, /datum/material/glass = 50)
	build_path = /obj/item/assembly/igniter
	category = list("initial", "Misc")

/datum/design/signaler
	name = "Дистанционный сигнализатор"
	id = "signaler"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 400, /datum/material/glass = 120)
	build_path = /obj/item/assembly/signaler
	category = list("initial", "T-Comm")

/datum/design/radio_headset
	name = "Радиогарнитура"
	id = "radio_headset"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 75)
	build_path = /obj/item/radio/headset
	category = list("initial", "T-Comm")

/datum/design/bounced_radio
	name = "Станционная рация"
	id = "bounced_radio"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 75, /datum/material/glass = 25)
	build_path = /obj/item/radio/off
	category = list("initial", "T-Comm")

/datum/design/intercom_frame
	name = "Корпус интеркома"
	id = "intercom_frame"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 75, /datum/material/glass = 25)
	build_path = /obj/item/wallframe/intercom
	category = list("initial", "T-Comm")

/datum/design/infrared_emitter
	name = "Инфракрасный излучатель"
	id = "infrared_emitter"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 1000, /datum/material/glass = 500)
	build_path = /obj/item/assembly/infra
	category = list("initial", "Misc")

/datum/design/health_sensor
	name = "Датчик здоровья"
	id = "health_sensor"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 800, /datum/material/glass = 200)
	build_path = /obj/item/assembly/health
	category = list("initial", "Medical")

/datum/design/timer
	name = "Таймер"
	id = "timer"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 500, /datum/material/glass = 50)
	build_path = /obj/item/assembly/timer
	category = list("initial", "Misc")

/datum/design/voice_analyser
	name = "Анализатор голоса"
	id = "voice_analyser"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 500, /datum/material/glass = 50)
	build_path = /obj/item/assembly/voice
	category = list("initial", "Misc")

/datum/design/light_tube
	name = "Люминесцентная лампа"
	id = "light_tube"
	build_type = AUTOLATHE
	materials = list(/datum/material/glass = 100)
	build_path = /obj/item/light/tube
	category = list("initial", "Construction")

/datum/design/light_bulb
	name = "Лампа накаливания"
	id = "light_bulb"
	build_type = AUTOLATHE
	materials = list(/datum/material/glass = 100)
	build_path = /obj/item/light/bulb
	category = list("initial", "Construction")

/datum/design/camera_assembly
	name = "Корпус камеры"
	id = "camera_assembly"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 400, /datum/material/glass = 250)
	build_path = /obj/item/wallframe/camera
	category = list("initial", "Construction")

/datum/design/newscaster_frame
	name = "Корпус новостной ленты"
	id = "newscaster_frame"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 14000, /datum/material/glass = 8000)
	build_path = /obj/item/wallframe/newscaster
	category = list("initial", "Construction")

/datum/design/syringe
	name = "Шприц"
	id = "syringe"
	build_type = AUTOLATHE | PROTOLATHE
	materials = list(/datum/material/iron = 10, /datum/material/glass = 20)
	build_path = /obj/item/reagent_containers/syringe
	category = list("initial", "Medical", "Medical Designs")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL

/datum/design/prox_sensor
	name = "Датчик движения"
	id = "prox_sensor"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 800, /datum/material/glass = 200)
	build_path = /obj/item/assembly/prox_sensor
	category = list("initial", "Misc")

/datum/design/foam_dart
	name = "Коробка мягких дротиков"
	id = "foam_dart"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 500)
	build_path = /obj/item/ammo_box/foambox
	category = list("initial", "Misc")

//hacked autolathe recipes
/datum/design/flamethrower
	name = "Огнемёт"
	id = "flamethrower"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 500)
	build_path = /obj/item/flamethrower/full
	category = list("hacked", "Security")

/datum/design/rpd
	name = "Трубоукладчик (РПД)"
	id = "rpd"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 75000, /datum/material/glass = 37500)
	build_path = /obj/item/pipe_dispenser
	category = list("hacked", "Construction")

/datum/design/electropack
	name = "Электроранец"
	id = "electropack"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 10000, /datum/material/glass = 2500)
	build_path = /obj/item/electropack
	category = list("hacked", "Tools")

/datum/design/large_welding_tool
	name = "Промышленный сварочный аппарат"
	id = "large_welding_tool"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 70, /datum/material/glass = 60)
	build_path = /obj/item/weldingtool/largetank
	category = list("hacked", "Tools")

/datum/design/handcuffs
	name = "Наручники"
	id = "handcuffs"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 500)
	build_path = /obj/item/restraints/handcuffs
	category = list("hacked", "Security")

/datum/design/receiver
	name = "Модульная ствольная коробка"
	id = "receiver"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 15000)
	build_path = /obj/item/weaponcrafting/receiver
	category = list("hacked", "Security")

/datum/design/shotgun_slug
	name = "Ружейная пуля"
	id = "shotgun_slug"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 4000)
	build_path = /obj/item/ammo_casing/shotgun
	category = list("hacked", "Security")

/datum/design/buckshot_shell
	name = "Картечь"
	id = "buckshot_shell"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 4000)
	build_path = /obj/item/ammo_casing/shotgun/buckshot
	category = list("hacked", "Security")

/datum/design/shotgun_dart
	name = "Ружейный дротик"
	id = "shotgun_dart"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 4000)
	build_path = /obj/item/ammo_casing/shotgun/dart
	category = list("hacked", "Security")

/datum/design/incendiary_slug
	name = "Зажигательная пуля для дробовика"
	id = "incendiary_slug"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 4000)
	build_path = /obj/item/ammo_casing/shotgun/incendiary
	category = list("hacked", "Security")

/datum/design/riot_dart
	name = "Мягкий полицейский дротик"
	id = "riot_dart"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 1000) //Discount for making individually - no box = less metal!
	build_path = /obj/item/ammo_casing/caseless/foam_dart/riot
	category = list("hacked", "Security")

/datum/design/riot_darts
	name = "Коробка мягких полицейских дротиков"
	id = "riot_darts"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 50000) //Comes with 40 darts
	build_path = /obj/item/ammo_box/foambox/riot
	category = list("hacked", "Security")

/datum/design/a357
	name = "Гильза .357"
	id = "a357"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 4000)
	build_path = /obj/item/ammo_casing/a357
	category = list("hacked", "Security")

/datum/design/c10mm
	name = "Коробка патронов (10 мм)"
	id = "c10mm"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 30000)
	build_path = /obj/item/ammo_box/c10mm
	category = list("hacked", "Security")

/datum/design/c45
	name = "Коробка патронов (.45)"
	id = "c45"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 30000)
	build_path = /obj/item/ammo_box/c45
	category = list("hacked", "Security")

/datum/design/c9mm
	name = "Коробка патронов (9 мм)"
	id = "c9mm"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 30000)
	build_path = /obj/item/ammo_box/c9mm
	category = list("hacked", "Security")

/datum/design/cleaver
	name = "Тесак мясника"
	id = "cleaver"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 18000)
	build_path = /obj/item/kitchen/knife/butcher
	category = list("hacked", "Dinnerware")

/datum/design/spraycan
	name = "Баллончик с краской"
	id = "spraycan"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 100, /datum/material/glass = 100)
	build_path = /obj/item/toy/crayon/spraycan
	category = list("initial", "Tools")

/datum/design/desttagger
	name = "Маркиратор посылок"
	id = "desttagger"
	build_type = AUTOLATHE | PROTOLATHE
	materials = list(/datum/material/iron = 250, /datum/material/glass = 125)
	build_path = /obj/item/destTagger
	category = list("initial", "Electronics")

/datum/design/handlabeler
	name = "Ручной этикетировщик"
	id = "handlabel"
	build_type = AUTOLATHE | PROTOLATHE
	materials = list(/datum/material/iron = 150, /datum/material/glass = 125)
	build_path = /obj/item/hand_labeler
	category = list("initial", "Electronics")

/datum/design/geiger
	name = "Счётчик Гейгера"
	id = "geigercounter"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 150, /datum/material/glass = 150)
	build_path = /obj/item/geiger_counter
	category = list("initial", "Tools")

/datum/design/turret_control_frame
	name = "Корпус управления турелью"
	id = "turret_control"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 12000)
	build_path = /obj/item/wallframe/turret_control
	category = list("initial", "Construction")

/datum/design/conveyor_belt
	name = "Конвейерная лента"
	id = "conveyor_belt"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 5000)
	build_path = /obj/item/conveyor_construct
	category = list("initial", "Construction")

/datum/design/conveyor_switch
	name = "Переключатель конвейера"
	id = "conveyor_switch"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 450, /datum/material/glass = 190)
	build_path = /obj/item/conveyor_switch_construct
	category = list("initial", "Construction")

/datum/design/laptop
	name = "Корпус ноутбука"
	id = "laptop"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 10000, /datum/material/glass = 1000)
	build_path = /obj/item/modular_computer/laptop/buildable
	category = list("initial","Misc")

/datum/design/tablet
	name = "Корпус планшета"
	id = "tablet"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 2000, /datum/material/glass = 1000)
	build_path = /obj/item/modular_computer/tablet
	category = list("initial","Misc")

/datum/design/slime_scanner
	name = "Сканер слизи"
	id = "slime_scanner"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 300, /datum/material/glass = 200)
	build_path = /obj/item/slime_scanner
	category = list("initial", "Misc")

/datum/design/pet_carrier
	name = "Переноска для животных"
	id = "pet_carrier"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 7500, /datum/material/glass = 100)
	build_path = /obj/item/pet_carrier
	category = list("initial", "Misc")

/datum/design/miniature_power_cell
	name = "Батарея светильника"
	id = "miniature_power_cell"
	build_type = AUTOLATHE
	materials = list(/datum/material/glass = 20)
	build_path = /obj/item/stock_parts/cell/emergency_light
	category = list("initial", "Electronics")

/datum/design/packageWrap
	name = "Упаковочная бумага"
	id = "packagewrap"
	build_type = AUTOLATHE | PROTOLATHE
	materials = list(/datum/material/iron = 200, /datum/material/glass = 200)
	build_path = /obj/item/stack/packageWrap
	category = list("initial", "Misc", "Equipment")
	maxstack = 30

/datum/design/holodisk
	name = "Голодиск"
	id = "holodisk"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 100, /datum/material/glass = 100)
	build_path = /obj/item/disk/holodisk
	category = list("initial", "Misc")

/datum/design/circuit
	name = "Синяя микросхемная плитка"
	id = "circuit"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 500, /datum/material/glass = 500)
	build_path = /obj/item/stack/tile/circuit
	category = list("initial", "Misc")
	maxstack = 50

/datum/design/circuitgreen
	name = "Зелёная микросхемная плитка"
	id = "circuitgreen"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 500, /datum/material/glass = 500)
	build_path = /obj/item/stack/tile/circuit/green
	category = list("initial", "Misc")
	maxstack = 50

/datum/design/circuitred
	name = "Красная микросхемная плитка"
	id = "circuitred"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 500, /datum/material/glass = 500)
	build_path = /obj/item/stack/tile/circuit/red
	category = list("initial", "Misc")
	maxstack = 50

/datum/design/price_tagger
	name = "Ценник-маркер"
	id = "price_tagger"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 1500, /datum/material/glass = 500)
	build_path = /obj/item/price_tagger
	category = list("initial", "Misc")

/datum/design/custom_vendor_refill
	name = "Настраиваемое пополнение автомата"
	id = "custom_vendor_refill"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 5000, /datum/material/glass = 2000)
	build_path = /obj/item/vending_refill/custom
	category = list("initial", "Misc")

/datum/design/ducts
	name = "Трубопровод жидкостей"
	id = "fluid_ducts"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 500)
	build_path = /obj/item/stack/ducts
	category = list("initial", "Construction")
	maxstack = 50

/datum/design/toygun
	name = "Пистолет с пистонами"
	id = "toygun"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 100, /datum/material/glass = 50)
	build_path = /obj/item/toy/gun
	category = list("hacked", "Misc")

/datum/design/capbox
	name = "Коробка пистонов"
	id = "capbox"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 20, /datum/material/glass = 5)
	build_path = /obj/item/toy/ammo/gun
	category = list("hacked", "Misc")
