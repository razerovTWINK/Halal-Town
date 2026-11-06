////////////////////////////////////////
//////////////MISC Boards///////////////
////////////////////////////////////////

/datum/design/board/smes
	name = "Проект оборудования (плата СМЭС)"
	desc = ""
	id = "smes"
	build_path = /obj/item/circuitboard/machine/smes
	category = list ("Engineering Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/board/circulator
	name = "Проект оборудования (плата циркулятора)"
	desc = ""
	id = "circulator"
	build_path = /obj/item/circuitboard/machine/circulator
	category = list ("Engineering Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/board/teg
	name = "Проект оборудования (плата ТЭГ)"
	desc = ""
	id = "teg"
	build_path = /obj/item/circuitboard/machine/generator
	category = list ("Engineering Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/board/announcement_system
	name = "Проект оборудования (плата системы оповещений)"
	desc = ""
	id = "automated_announcement"
	build_path = /obj/item/circuitboard/machine/announcement_system
	category = list("Subspace Telecomms")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/board/turbine_computer
	name = "Проект компьютера (консоль силовой турбины)"
	desc = ""
	id = "power_turbine_console"
	build_path = /obj/item/circuitboard/computer/turbine_computer
	category = list ("Engineering Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/emitter
	name = "Проект оборудования (плата эмиттера)"
	desc = ""
	id = "emitter"
	build_path = /obj/item/circuitboard/machine/emitter
	category = list ("Engineering Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/board/power_compressor
	name = "Проект оборудования (плата компрессора)"
	desc = ""
	id = "power_compressor"
	build_path = /obj/item/circuitboard/machine/power_compressor
	category = list ("Engineering Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/power_turbine
	name = "Проект оборудования (плата турбины)"
	desc = ""
	id = "power_turbine"
	build_path = /obj/item/circuitboard/machine/power_turbine
	category = list ("Engineering Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/thermomachine
	name = "Проект оборудования (плата охладителя/нагревателя)"
	desc = ""
	id = "thermomachine"
	build_path = /obj/item/circuitboard/machine/thermomachine
	category = list ("Engineering Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/space_heater
	name = "Проект оборудования (плата обогревателя)"
	desc = ""
	id = "space_heater"
	build_path = /obj/item/circuitboard/machine/space_heater
	category = list ("Engineering Machinery")
	departmental_flags = ALL

/datum/design/board/teleport_station
	name = "Проект оборудования (плата станции телепортации)"
	desc = ""
	id = "tele_station"
	build_path = /obj/item/circuitboard/machine/teleporter_station
	category = list ("Teleportation Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/teleport_hub
	name = "Проект оборудования (плата узла телепортации)"
	desc = ""
	id = "tele_hub"
	build_path = /obj/item/circuitboard/machine/teleporter_hub
	category = list ("Teleportation Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/quantumpad
	name = "Проект оборудования (плата квантовой платформы)"
	desc = ""
	id = "quantumpad"
	build_path = /obj/item/circuitboard/machine/quantumpad
	category = list ("Teleportation Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/launchpad
	name = "Проект оборудования (плата блюспейс-катапульты)"
	desc = ""
	id = "launchpad"
	build_path = /obj/item/circuitboard/machine/launchpad
	category = list ("Teleportation Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/launchpad_console
	name = "Проект оборудования (консоль блюспейс-катапульты)"
	desc = ""
	id = "launchpad_console"
	build_path = /obj/item/circuitboard/computer/launchpad_console
	category = list ("Teleportation Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/teleconsole
	name = "Проект компьютера (консоль телепортатора)"
	desc = ""
	id = "teleconsole"
	build_path = /obj/item/circuitboard/computer/teleporter
	category = list("Teleportation Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/cryotube
	name = "Проект оборудования (плата криокапсулы)"
	desc = ""
	id = "cryotube"
	build_path = /obj/item/circuitboard/machine/cryo_tube
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_MEDICAL
	category = list ("Medical Machinery")

/datum/design/board/chem_dispenser
	name = "Проект оборудования (плата портативного химического раздатчика)"
	desc = ""
	id = "chem_dispenser"
	build_path = /obj/item/circuitboard/machine/chem_dispenser
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_MEDICAL
	category = list ("Medical Machinery")

/datum/design/board/chem_master
	name = "Проект оборудования (плата Мастер-Хим)"
	desc = ""
	id = "chem_master"
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_MEDICAL
	build_path = /obj/item/circuitboard/machine/chem_master
	category = list ("Medical Machinery")

/datum/design/board/chem_heater
	name = "Проект оборудования (плата химического нагревателя)"
	desc = ""
	id = "chem_heater"
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_MEDICAL
	build_path = /obj/item/circuitboard/machine/chem_heater
	category = list ("Medical Machinery")

/datum/design/board/smoke_machine
	name = "Проект оборудования (дымовая машина)"
	desc = ""
	id = "smoke_machine"
	build_path = /obj/item/circuitboard/machine/smoke_machine
	category = list ("Medical Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL

/datum/design/board/reagentgrinder
	name = "Проект оборудования (универсальный измельчитель)"
	desc = ""
	id = "reagentgrinder"
	build_path = /obj/item/circuitboard/machine/reagentgrinder
	category = list ("Medical Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_ALL

/datum/design/board/clonecontrol
	name = "Проект компьютера (консоль клонирования)"
	desc = ""
	id = "clonecontrol"
	build_path = /obj/item/circuitboard/computer/cloning
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL
	category = list("Medical Machinery")

/datum/design/board/clonepod
	name = "Проект оборудования (капсула клонирования)"
	desc = ""
	id = "clonepod"
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL
	build_path = /obj/item/circuitboard/machine/clonepod
	category = list("Medical Machinery")

/datum/design/board/clonescanner
	name = "Проект оборудования (сканер клонирования)"
	desc = ""
	id = "clonescanner"
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL
	build_path = /obj/item/circuitboard/machine/clonescanner
	category = list("Medical Machinery")

/datum/design/board/biogenerator
	name = "Проект оборудования (плата биогенератора)"
	desc = ""
	id = "biogenerator"
	build_path = /obj/item/circuitboard/machine/biogenerator
	category = list ("Hydroponics Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_SERVICE

/datum/design/board/hydroponics
	name = "Проект оборудования (плата гидропонной ванны)"
	desc = ""
	id = "hydro_tray"
	build_path = /obj/item/circuitboard/machine/hydroponics
	category = list ("Hydroponics Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_SERVICE

/datum/design/board/destructive_analyzer
	name = "Проект оборудования (плата деструктивного анализатора)"
	desc = ""
	id = "destructive_analyzer"
	build_path = /obj/item/circuitboard/machine/destructive_analyzer
	category = list("Research Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/experimentor
	name = "Проект оборудования (плата Э.К.С.П.Е.Р.И-МЕНТОР)"
	desc = ""
	id = "experimentor"
	build_path = /obj/item/circuitboard/machine/experimentor
	category = list("Research Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/protolathe
	name = "Проект оборудования (плата протолата)"
	desc = ""
	id = "protolathe"
	build_path = /obj/item/circuitboard/machine/protolathe
	category = list("Research Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/circuit_imprinter
	name = "Проект оборудования (плата принтера плат)"
	desc = ""
	id = "circuit_imprinter"
	build_path = /obj/item/circuitboard/machine/circuit_imprinter
	category = list("Research Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/rdservercontrol
	name = "Проект компьютера (консоль серверов исследований)"
	desc = ""
	id = "rdservercontrol"
	build_path = /obj/item/circuitboard/computer/rdservercontrol
	category = list("Research Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/rdserver
	name = "Проект оборудования (плата сервера исследований)"
	desc = ""
	id = "rdserver"
	build_path = /obj/item/circuitboard/machine/rdserver
	category = list("Research Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/mechfab
	name = "Проект оборудования (плата фабрикатора экзоскелетов)"
	desc = ""
	id = "mechfab"
	build_path = /obj/item/circuitboard/machine/mechfab
	category = list("Research Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/cyborgrecharger
	name = "Проект оборудования (плата станции зарядки киборгов)"
	desc = ""
	id = "cyborgrecharger"
	build_path = /obj/item/circuitboard/machine/cyborgrecharger
	category = list("Research Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/mech_recharger
	name = "Проект оборудования (плата зарядки экзоскелетов)"
	desc = ""
	id = "mech_recharger"
	build_path = /obj/item/circuitboard/machine/mech_recharger
	category = list("Research Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/nanite_chamber
	name = "Проект оборудования (плата нанитной камеры)"
	desc = ""
	id = "nanite_chamber"
	build_path = /obj/item/circuitboard/machine/nanite_chamber
	category = list("Research Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/public_nanite_chamber
	name = "Проект оборудования (плата общественной нанитной камеры)"
	desc = ""
	id = "public_nanite_chamber"
	build_path = /obj/item/circuitboard/machine/public_nanite_chamber
	category = list("Research Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/nanite_programmer
	name = "Проект оборудования (плата программатора нанитов)"
	desc = ""
	id = "nanite_programmer"
	build_path = /obj/item/circuitboard/machine/nanite_programmer
	category = list("Research Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/nanite_program_hub
	name = "Проект оборудования (плата хаба программ нанитов)"
	desc = ""
	id = "nanite_program_hub"
	build_path = /obj/item/circuitboard/machine/nanite_program_hub
	category = list("Research Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/microwave
	name = "Проект оборудования (плата микроволновки)"
	desc = ""
	id = "microwave"
	build_path = /obj/item/circuitboard/machine/microwave
	category = list ("Misc. Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_ALL

/datum/design/board/gibber
	name = "Проект оборудования (плата расчленителя)"
	desc = ""
	id = "gibber"
	build_path = /obj/item/circuitboard/machine/gibber
	category = list ("Misc. Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_SERVICE

/datum/design/board/smartfridge
	name = "Проект оборудования (плата смарт-холодильника)"
	desc = ""
	id = "smartfridge"
	build_path = /obj/item/circuitboard/machine/smartfridge
	category = list ("Misc. Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_ALL

/datum/design/board/monkey_recycler
	name = "Проект оборудования (плата утилизатора обезьян)"
	desc = ""
	id = "monkey_recycler"
	build_path = /obj/item/circuitboard/machine/monkey_recycler
	category = list ("Misc. Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_SERVICE

/datum/design/board/seed_extractor
	name = "Проект оборудования (плата экстрактора семян)"
	desc = ""
	id = "seed_extractor"
	build_path = /obj/item/circuitboard/machine/seed_extractor
	category = list ("Hydroponics Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_SERVICE

/datum/design/board/processor
	name = "Проект оборудования (плата процессора еды/слизи)"
	desc = ""
	id = "processor"
	build_path = /obj/item/circuitboard/machine/processor
	category = list ("Misc. Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_SERVICE

/datum/design/board/soda_dispenser
	name = "Проект оборудования (плата портативного раздатчика газировки)"
	desc = ""
	id = "soda_dispenser"
	build_path = /obj/item/circuitboard/machine/chem_dispenser/drinks
	departmental_flags = DEPARTMENTAL_FLAG_SERVICE
	category = list ("Misc. Machinery")

/datum/design/board/beer_dispenser
	name = "Проект оборудования (плата портативного раздатчика выпивки)"
	desc = ""
	id = "beer_dispenser"
	build_path = /obj/item/circuitboard/machine/chem_dispenser/drinks/beer
	departmental_flags = DEPARTMENTAL_FLAG_SERVICE
	category = list ("Misc. Machinery")

/datum/design/board/recycler
	name = "Проект оборудования (плата утилизатора)"
	desc = ""
	id = "recycler"
	build_path = /obj/item/circuitboard/machine/recycler
	category = list ("Misc. Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_ALL

/datum/design/board/scanner_gate
	name = "Проект оборудования (сканирующая рамка)"
	desc = ""
	id = "scanner_gate"
	build_path = /obj/item/circuitboard/machine/scanner_gate
	category = list ("Misc. Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_ALL

/datum/design/board/holopad
	name = "Проект оборудования (плата голографической платформы ИИ)"
	desc = ""
	id = "holopad"
	build_path = /obj/item/circuitboard/machine/holopad
	category = list ("Misc. Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_ALL

/datum/design/board/autolathe
	name = "Проект оборудования (плата автолата)"
	desc = ""
	id = "autolathe"
	build_path = /obj/item/circuitboard/machine/autolathe
	category = list ("Misc. Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_ALL		//Lets be honest here half the maps have public ones.

/datum/design/board/recharger
	name = "Проект оборудования (плата зарядника оружия)"
	desc = ""
	id = "recharger"
	materials = list(/datum/material/glass = 1000, /datum/material/gold = 2000)
	build_path = /obj/item/circuitboard/machine/recharger
	category = list("Misc. Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_ALL

/datum/design/board/vendor
	name = "Проект оборудования (плата торгового автомата)"
	desc = ""
	id = "vendor"
	build_path = /obj/item/circuitboard/machine/vendor
	category = list ("Misc. Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_ALL

/datum/design/board/ore_redemption
	name = "Проект оборудования (плата переработки руды)"
	desc = ""
	id = "ore_redemption"
	build_path = /obj/item/circuitboard/machine/ore_redemption
	category = list ("Misc. Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_CARGO | DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/board/mining_equipment_vendor
	name = "Проект оборудования (плата шахтёрских наград)"
	desc = ""
	id = "mining_equipment_vendor"
	build_path = /obj/item/circuitboard/machine/mining_equipment_vendor
	category = list ("Misc. Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_CARGO

/datum/design/board/tesla_coil
	name = "Проект оборудования (плата катушки Теслы)"
	desc = ""
	id = "tesla_coil"
	build_path = /obj/item/circuitboard/machine/tesla_coil
	category = list ("Misc. Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/rad_collector
	name = "Проект оборудования (плата коллектора радиации)"
	desc = ""
	id = "rad_collector"
	build_path = /obj/item/circuitboard/machine/rad_collector
	category = list ("Misc. Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/grounding_rod
	name = "Проект оборудования (плата заземлителя)"
	desc = ""
	id = "grounding_rod"
	build_path = /obj/item/circuitboard/machine/grounding_rod
	category = list ("Misc. Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/plantgenes
	name = "Проект оборудования (плата модификатора ДНК растений)"
	desc = ""
	id = "plantgenes"
	build_path = /obj/item/circuitboard/machine/plantgenes
	category = list ("Hydroponics Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_SERVICE

/datum/design/board/ntnet_relay
	name = "Проект оборудования (плата реле NTNet)"
	desc = ""
	id = "ntnet_relay"
	build_path = /obj/item/circuitboard/machine/ntnet_relay
	category = list("Subspace Telecomms")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/limbgrower
	name = "Проект оборудования (плата инкубатора конечностей)"
	desc = ""
	id = "limbgrower"
	build_path = /obj/item/circuitboard/machine/limbgrower
	category = list("Medical Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL

/datum/design/board/harvester
	name = "Проект оборудования (плата извлекателя органов)"
	desc = ""
	id = "harvester"
	build_path = /obj/item/circuitboard/machine/harvester
	category = list("Medical Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL

/datum/design/board/deepfryer
	name = "Проект оборудования (фритюрница)"
	desc = ""
	id = "deepfryer"
	build_path = /obj/item/circuitboard/machine/deep_fryer
	category = list ("Misc. Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_SERVICE

/datum/design/board/donksofttoyvendor
	name = "Проект оборудования (плата автомата Donksoft)"
	desc = ""
	id = "donksofttoyvendor"
	build_path = /obj/item/circuitboard/machine/vending/donksofttoyvendor
	category = list ("Misc. Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_ALL			//Toys!!

/datum/design/board/cell_charger
	name = "Проект оборудования (плата зарядника батарей)"
	desc = ""
	id = "cell_charger"
	build_path = /obj/item/circuitboard/machine/cell_charger
	category = list ("Misc. Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_ALL

/datum/design/board/dish_drive
	name = "Проект оборудования (посудоприёмник)"
	desc = ""
	id = "dish_drive"
	build_path = /obj/item/circuitboard/machine/dish_drive
	category = list ("Misc. Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_SERVICE

/datum/design/board/stacking_unit_console
	name = "Проект оборудования (консоль штабелёра)"
	desc = ""
	id = "stack_console"
	build_path = /obj/item/circuitboard/machine/stacking_unit_console
	category = list ("Misc. Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_CARGO | DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/board/stacking_machine
	name = "Проект оборудования (штабелёр)"
	desc = ""
	id = "stack_machine"
	build_path = /obj/item/circuitboard/machine/stacking_machine
	category = list ("Misc. Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_CARGO | DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/board/ore_silo
	name = "Проект оборудования (рудный силос)"
	desc = ""
	id = "ore_silo"
	build_path = /obj/item/circuitboard/machine/ore_silo
	category = list ("Research Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_CARGO

/datum/design/board/paystand
	name = "Проект оборудования (платёжная стойка)"
	desc = ""
	id = "paystand"
	build_path = /obj/item/circuitboard/machine/paystand
	category = list ("Misc. Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_ALL

/datum/design/board/fat_sucker
	name = "Проект оборудования (экстрактор липидов)"
	desc = ""
	id = "fat_sucker"
	build_path = /obj/item/circuitboard/machine/fat_sucker
	category = list ("Misc. Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_SERVICE

/datum/design/board/stasis
	name = "Проект оборудования (камера стазиса форм жизни)"
	desc = ""
	id = "stasis"
	build_path = /obj/item/circuitboard/machine/stasis
	category = list("Medical Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL

/datum/design/board/spaceship_navigation_beacon
	name = "Проект оборудования (блюспейс-гигамаяк навигации)"
	desc = ""
	id = "spaceship_navigation_beacon"
	build_path = /obj/item/circuitboard/machine/spaceship_navigation_beacon
	category = list ("Teleportation Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/medical_kiosk
	name = "Проект оборудования (медицинский киоск)"
	desc = ""
	id = "medical_kiosk"
	build_path = /obj/item/circuitboard/machine/medical_kiosk
	category = list ("Medical Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL
