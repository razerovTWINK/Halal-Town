
//Current rate: 135000 research points in 90 minutes

//Base Nodes
/datum/techweb_node/base
	id = "base"
	starting_node = TRUE
	display_name = "Базовые технологии"
	description = "Основы научных и ремесленных разработок."
	// Default research tech, prevents bricking
	design_ids = list("basic_matter_bin", "basic_cell", "basic_scanning", "basic_capacitor", "basic_micro_laser", "micro_mani", "desttagger", "handlabel", "packagewrap",
	"destructive_analyzer", "circuit_imprinter", "experimentor", "rdconsole", "design_disk", "tech_disk", "rdserver", "rdservercontrol", "mechfab", "paystand",
	"space_heater", "beaker", "large_beaker", "bucket", "xlarge_beaker", "sec_rshot", "sec_beanbag_slug", "sec_bshot", "sec_slug", "sec_Islug", "sec_dart", "sec_38",
	"rglass","plasteel","plastitanium","plasmaglass","plasmareinforcedglass","titaniumglass","plastitaniumglass","plumbing_rcd","plastic_knife","plastic_fork","plastic_spoon")

/datum/techweb_node/mmi
	id = "mmi"
	starting_node = TRUE
	display_name = "Интерфейс «мозг-машина»"
	description = "Устройство, позволяющее мозгу взаимодействовать с программными интерфейсами."
	design_ids = list("mmi")

/datum/techweb_node/cyborg
	id = "cyborg"
	starting_node = TRUE
	display_name = "Киборгизация"
	description = "Разумные роботы с набором модулей и программируемыми законами."
	design_ids = list("robocontrol", "sflash", "borg_suit", "borg_head", "borg_chest", "borg_r_arm", "borg_l_arm", "borg_r_leg", "borg_l_leg", "borgupload",
	"cyborgrecharger", "borg_upgrade_restart", "borg_upgrade_rename")

/datum/techweb_node/mech
	id = "mecha"
	starting_node = TRUE
	display_name = "Экзоскелеты"
	description = "Механизированные экзоскелеты, значительно превосходящие возможности человека."
	design_ids = list("mecha_tracking", "mechacontrol", "mechapower", "mech_recharger", "ripley_chassis", "firefighter_chassis", "ripley_torso", "ripley_left_arm", "ripley_right_arm", "ripley_left_leg", "ripley_right_leg",
	"ripley_main", "ripley_peri", "ripleyupgrade", "mech_hydraulic_clamp")

/datum/techweb_node/mech_tools
	id = "mech_tools"
	starting_node = TRUE
	display_name = "Базовое снаряжение экзоскелетов"
	description = "Инструменты для базовых экзоскелетов."
	design_ids = list("mech_drill", "mech_mscanner", "mech_extinguisher")

/datum/techweb_node/basic_tools
	id = "basic_tools"
	starting_node = TRUE
	display_name = "Базовые инструменты"
	description = "Основные механические, электронные, хирургические и ботанические инструменты."
	design_ids = list("screwdriver", "wrench", "wirecutters", "crowbar", "multitool", "welding_tool", "tscanner", "analyzer", "cable_coil", "pipe_painter", "airlock_painter", "scalpel", "circular_saw", "surgicaldrill", "retractor", "cautery", "hemostat", "surgical_drapes", "syringe", "cultivator", "plant_analyzer", "shovel", "spade", "hatchet",  "mop", "plunger")

/////////////////////////Biotech/////////////////////////
/datum/techweb_node/biotech
	id = "biotech"
	display_name = "Биотехнологии"
	description = "Технологии познания и улучшения живых организмов."	//the MC, silly!
	prereq_ids = list("base")
	design_ids = list("chem_heater", "chem_master", "chem_dispenser", "pandemic", "defibrillator", "defibmount", "operating", "soda_dispenser", "beer_dispenser", "healthanalyzer", "medigel","genescanner", "med_spray_bottle", "chem_pack", "blood_pack", "medical_kiosk")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 5000

/datum/techweb_node/adv_biotech
	id = "adv_biotech"
	display_name = "Передовые биотехнологии"
	description = "Продвинутые методы работы с биологическими системами."
	prereq_ids = list("biotech")
	design_ids = list("piercesyringe", "crewpinpointer", "smoke_machine", "plasmarefiller", "limbgrower", "meta_beaker", "healthanalyzer_advanced", "harvester", "holobarrier_med", "detective_scanner", "defibrillator_compact")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 5000

/datum/techweb_node/bio_process
	id = "bio_process"
	display_name = "Биопереработка"
	description = "От слизней до кулинарной обработки биоматериала."
	prereq_ids = list("biotech")
	design_ids = list("smartfridge", "gibber", "deepfryer", "monkey_recycler", "processor", "gibber", "microwave", "reagentgrinder", "dish_drive", "fat_sucker")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 5000

/////////////////////////Advanced Surgery/////////////////////////
/datum/techweb_node/imp_wt_surgery
	id = "imp_wt_surgery"
	display_name = "Улучшенная обработка ран"
	description = "Более аккуратная работа гемостатом снижает страдания пациента."
	prereq_ids = list("biotech")
	design_ids = list("surgery_heal_brute_upgrade","surgery_heal_burn_upgrade")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 1000)
	export_price = 1000


/datum/techweb_node/adv_surgery
	id = "adv_surgery"
	display_name = "Передовая хирургия"
	description = "Когда простых медикаментов уже недостаточно."
	prereq_ids = list("imp_wt_surgery")
	design_ids = list("surgery_lobotomy", "surgery_heal_brute_upgrade_femto", "surgery_heal_burn_upgrade_femto","surgery_heal_combo", "surgery_revival","surgery_adv_dissection")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 1500)
	export_price = 4000

/datum/techweb_node/exp_surgery
	id = "exp_surgery"
	display_name = "Экспериментальная хирургия"
	description = "Когда естественная эволюция протекает слишком медленно."
	prereq_ids = list("adv_surgery")
	design_ids = list("surgery_pacify","surgery_vein_thread","surgery_muscled_veins","surgery_nerve_splice","surgery_nerve_ground","surgery_ligament_hook","surgery_ligament_reinforcement","surgery_viral_bond", "surgery_heal_combo_upgrade", "surgery_exp_dissection")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 5000)
	export_price = 5000

/datum/techweb_node/alien_surgery
	id = "alien_surgery"
	display_name = "Инопланетная хирургия"
	description = "Хирургические методики внеземных цивилизаций."
	prereq_ids = list("exp_surgery", "alientech")
	design_ids = list("surgery_brainwashing","surgery_zombie","surgery_heal_combo_upgrade_femto", "surgery_ext_dissection")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 10000)
	export_price = 5000

/////////////////////////data theory tech/////////////////////////
/datum/techweb_node/datatheory //Computer science
	id = "datatheory"
	display_name = "Теория данных"
	description = "Обработка и анализ больших объёмов данных."
	prereq_ids = list("base")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 5000


/////////////////////////engineering tech/////////////////////////
/datum/techweb_node/engineering
	id = "engineering"
	display_name = "Инженерное дело"
	description = "Основы современных технологий конструирования и ремонта."
	prereq_ids = list("base")
	design_ids = list("solarcontrol", "recharger", "powermonitor", "rped", "pacman", "adv_capacitor", "adv_scanning", "emitter", "high_cell", "adv_matter_bin", "scanner_gate",
	"atmosalerts", "atmos_control", "recycler", "autolathe", "high_micro_laser", "nano_mani", "mesons", "welding_goggles", "thermomachine", "rad_collector", "tesla_coil", "grounding_rod",
	"apc_control", "cell_charger", "power control", "airlock_board", "firelock_board", "airalarm_electronics", "firealarm_electronics", "cell_charger", "stack_console", "stack_machine",
	"oxygen_tank", "plasma_tank", "emergency_oxygen", "emergency_oxygen_engi", "plasmaman_tank_belt")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 7500)
	export_price = 5000

/datum/techweb_node/adv_engi
	id = "adv_engi"
	display_name = "Передовая инженерия"
	description = "Расширение границ физики и прикладных механизмов."
	prereq_ids = list("engineering", "emp_basic")
	design_ids = list("engine_goggles", "magboots", "forcefield_projector", "weldingmask", "rcd_loaded")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 5000

/datum/techweb_node/anomaly
	id = "anomaly_research"
	display_name = "Исследование аномалий"
	description = "Раскрытие потенциала таинственных космических аномалий."
	prereq_ids = list("adv_engi", "practical_bluespace")
	design_ids = list("reactive_armour", "anomaly_neutralizer")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 5000)
	export_price = 5000

/datum/techweb_node/high_efficiency
	id = "high_efficiency"
	display_name = "Высокоэффективные детали"
	description = "Высокоточная обработка деталей с микроскопическими допусками."
	prereq_ids = list("engineering", "datatheory")
	design_ids = list("pico_mani", "super_matter_bin")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 7500)
	export_price = 5000

/datum/techweb_node/adv_power
	id = "adv_power"
	display_name = "Передовая энергетика"
	description = "Методы накопления и распределения колоссальных объёмов энергии."
	prereq_ids = list("engineering")
	design_ids = list("smes", "super_cell", "hyper_cell", "super_capacitor", "superpacman", "mrspacman", "power_turbine", "power_turbine_console", "power_compressor", "circulator", "teg")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 5000

/////////////////////////Bluespace tech/////////////////////////
/datum/techweb_node/bluespace_basic //Bluespace-memery
	id = "bluespace_basic"
	display_name = "Основы блюспейса"
	description = "Базовые исследования загадочного подпространственного измерения."
	prereq_ids = list("base")
	design_ids = list("beacon", "xenobioconsole", "telesci_gps", "bluespace_crystal")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 5000

/datum/techweb_node/bluespace_travel
	id = "bluespace_travel"
	display_name = "Блюспейс-перемещение"
	description = "Применение блюспейса для статической телепортации."
	prereq_ids = list("practical_bluespace")
	design_ids = list("tele_station", "tele_hub", "teleconsole", "quantumpad", "launchpad", "launchpad_console", "bluespace_pod")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 5000)
	export_price = 5000

/datum/techweb_node/micro_bluespace
	id = "micro_bluespace"
	display_name = "Миниатюризация блюспейса"
	description = "Уменьшение блюспейс-двигателей для создания портативных устройств."
	prereq_ids = list("bluespace_travel", "practical_bluespace", "high_efficiency")
	design_ids = list("bluespace_matter_bin", "femto_mani", "bluespacebodybag", "triphasic_scanning", "quantum_keycard", "wormholeprojector", "swapper")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 10000)
	export_price = 5000

/datum/techweb_node/advanced_bluespace
	id = "bluespace_storage"
	display_name = "Блюспейс-хранилища"
	description = "Использование подпространственных карманов для вместительных хранилищ."
	prereq_ids = list("micro_bluespace", "janitor")
	design_ids = list("bag_holding")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 5000)
	export_price = 3000

/datum/techweb_node/practical_bluespace
	id = "practical_bluespace"
	display_name = "Прикладной блюспейс"
	description = "Использование подпространства для ускорения и оптимизации процессов."
	prereq_ids = list("bluespace_basic", "engineering")
	design_ids = list("bs_rped","minerbag_holding", "bluespacebeaker", "bluespacesyringe", "phasic_scanning", "roastingstick", "ore_silo")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 5000)
	export_price = 5000

/datum/techweb_node/bluespace_power
	id = "bluespace_power"
	display_name = "Блюспейс-энергетика"
	description = "Извлечение и применение сверхмощных энергий подпространства."
	prereq_ids = list("adv_power", "practical_bluespace")
	design_ids = list("bluespace_cell", "quadratic_capacitor")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 5000

/datum/techweb_node/regulated_bluespace
	id = "regulated_bluespace"
	display_name = "Контролируемый блюспейс"
	description = "Стабильные и безопасные технологии блюспейса, одобренные протоколами."
	prereq_ids = list("base")
	design_ids = list("spaceship_navigation_beacon")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 2500

/datum/techweb_node/unregulated_bluespace
	id = "unregulated_bluespace"
	display_name = "Неконтролируемый блюспейс"
	description = "Нестабильные методы искривления подпространства, несущие скрытую угрозу."
	prereq_ids = list("bluespace_travel", "syndicate_basic")
	design_ids = list("desynchronizer")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 2500


/////////////////////////plasma tech/////////////////////////
/datum/techweb_node/basic_plasma
	id = "basic_plasma"
	display_name = "Основы изучения плазмы"
	description = "Исследование таинственного и крайне опасного вещества — плазмы."
	prereq_ids = list("engineering")
	design_ids = list("mech_generator")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 5000

/datum/techweb_node/adv_plasma
	id = "adv_plasma"
	display_name = "Передовое изучение плазмы"
	description = "Способы полного обуздания энергии плазмы."
	prereq_ids = list("basic_plasma")
	design_ids = list("mech_plasma_cutter")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 5000

/////////////////////////robotics tech/////////////////////////
/datum/techweb_node/robotics
	id = "robotics"
	display_name = "Базовая робототехника"
	description = "Программируемые механизмы, берущие на себя рутинный труд."
	prereq_ids = list("base")
	design_ids = list("paicard")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 5000

/datum/techweb_node/adv_robotics
	id = "adv_robotics"
	display_name = "Передовая робототехника"
	description = "Сложные автоматизированные системы и кибернетические узлы."
	prereq_ids = list("robotics")
	design_ids = list("borg_upgrade_diamonddrill", "borg_upgrade_trashofholding", "borg_upgrade_advancedmop")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 5000

/datum/techweb_node/neural_programming
	id = "neural_programming"
	display_name = "Нейропрограммирование"
	description = "Изучение вычислительных сетей, имитирующих работу живого мозга."
	prereq_ids = list("biotech", "datatheory")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 5000

/datum/techweb_node/posibrain
	id = "posibrain"
	display_name = "Позитронный мозг"
	description = "Искусственный интеллект на основе проводящих кубических матриц."
	prereq_ids = list("neural_programming")
	design_ids = list("mmi_posi")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 5000

/datum/techweb_node/cyborg_upg_util
	id = "cyborg_upg_util"
	display_name = "Улучшения киборгов: утилитарные"
	description = "Вспомогательные улучшения рабочих систем киборгов."
	prereq_ids = list("engineering")
	design_ids = list("borg_upgrade_holding", "borg_upgrade_lavaproof", "borg_upgrade_thrusters", "borg_upgrade_selfrepair", "borg_upgrade_expand")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2000)
	export_price = 5000

/datum/techweb_node/cyborg_upg_engi
	id = "cyborg_upg_engi"
	display_name = "Улучшения киборгов: инженерные"
	description = "Инженерные модули повышенной мощности для киборгов."
	prereq_ids = list("engineering")
	design_ids = list("borg_upgrade_rped", "borg_upgrade_circuitapp")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2000)
	export_price = 5000

/datum/techweb_node/cyborg_upg_med
	id = "cyborg_upg_med"
	display_name = "Улучшения киборгов: медицинские"
	description = "Медицинские и реанимационные комплекты для киборгов."
	prereq_ids = list("adv_biotech")
	design_ids = list("borg_upgrade_defibrillator", "borg_upgrade_piercinghypospray", "borg_upgrade_expandedsynthesiser", "borg_upgrade_pinpointer", "borg_upgrade_surgicalprocessor", "borg_upgrade_beakerapp")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2000)
	export_price = 5000

/datum/techweb_node/cyborg_upg_combat
	id = "cyborg_upg_combat"
	display_name = "Улучшения киборгов: боевые"
	description = "Военные боевые модули и системы защиты для киборгов."
	prereq_ids = list("adv_robotics", "adv_engi" , "weaponry")
	design_ids = list("borg_upgrade_disablercooler")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 5000)
	export_price = 5000

/datum/techweb_node/ai
	id = "ai"
	display_name = "Искусственный интеллект"
	description = "Создание и программирование центральных ядер ИИ."
	prereq_ids = list("robotics", "posibrain")
	design_ids = list("aifixer", "aicore", "safeguard_module", "onehuman_module", "protectstation_module", "quarantine_module", "oxygen_module", "freeform_module",
	"reset_module", "purge_module", "remove_module", "freeformcore_module", "asimov_module", "paladin_module", "tyrant_module", "overlord_module", "corporate_module",
	"default_module", "borg_ai_control", "mecha_tracking_ai_control", "aiupload", "intellicard")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 5000

/////////////////////////EMP tech/////////////////////////
/datum/techweb_node/emp_basic //EMP tech for some reason
	id = "emp_basic"
	display_name = "Электромагнитная теория"
	description = "Использование частот электромагнитного спектра."
	prereq_ids = list("base")
	design_ids = list("holosign", "holosignsec", "holosignengi", "holosignatmos", "inducer", "tray_goggles", "holopad")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 5000

/datum/techweb_node/emp_adv
	id = "emp_adv"
	display_name = "Передовая электромагнитная теория"
	description = "Тонкая настройка фаз и полярностей электромагнитных полей."
	prereq_ids = list("emp_basic")
	design_ids = list("ultra_micro_laser")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 3000)
	export_price = 5000

/datum/techweb_node/emp_super
	id = "emp_super"
	display_name = "Квантовые электромагнитные технологии"	//bs
	description = "Сверхточные электромагнитные манипуляции на квантовом уровне."
	prereq_ids = list("emp_adv")
	design_ids = list("quadultra_micro_laser")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 3000)
	export_price = 5000

/////////////////////////Clown tech/////////////////////////
/datum/techweb_node/clown
	id = "clown"
	display_name = "Клоунские технологии"
	description = "Хонк?!"
	prereq_ids = list("base")
	design_ids = list("air_horn", "honker_main", "honker_peri", "honker_targ", "honk_chassis", "honk_head", "honk_torso", "honk_left_arm", "honk_right_arm",
	"honk_left_leg", "honk_right_leg", "mech_banana_mortar", "mech_mousetrap_mortar", "mech_honker", "mech_punching_face", "implant_trombone", "borg_transform_clown")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 5000

////////////////////////Computer tech////////////////////////
/datum/techweb_node/comptech
	id = "comptech"
	display_name = "Компьютерные консоли"
	description = "Принципы сборки и программирования вычислительных терминалов."
	prereq_ids = list("datatheory")
	design_ids = list("cargo", "cargorequest", "libraryconsole", "mining", "crewconsole", "rdcamera", "comconsole", "idcard","idcardconsole", "seccamera")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2000)
	export_price = 5000

/datum/techweb_node/computer_hardware_basic				//Modular computers are shitty and nearly useless so until someone makes them actually useful this can be easy to get.
	id = "computer_hardware_basic"
	display_name = "Компьютерное аппаратное обеспечение"
	description = "Производство плат и электронных компонентов."
	prereq_ids = list("comptech")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 1000)  //they are really shitty
	export_price = 2000
	design_ids = list("hdd_basic", "hdd_advanced", "hdd_super", "hdd_cluster", "ssd_small", "ssd_micro", "netcard_basic", "netcard_advanced", "netcard_wired",
	"portadrive_basic", "portadrive_advanced", "portadrive_super", "cardslot", "aislot", "miniprinter", "APClink", "bat_control", "bat_normal", "bat_advanced",
	"bat_super", "bat_micro", "bat_nano", "cpu_normal", "pcpu_normal", "cpu_small", "pcpu_small")

/datum/techweb_node/computer_board_gaming
	id = "computer_board_gaming"
	display_name = "Аркадные автоматы"
	description = "Развлекательные игровые платформы для экипажа."
	prereq_ids = list("comptech")
	design_ids = list("arcade_battle", "arcade_orion", "slotmachine")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 1000)
	export_price = 2000

/datum/techweb_node/comp_recordkeeping
	id = "comp_recordkeeping"
	display_name = "Электронный документооборот"
	description = "Организация баз данных личных дел и отчётности."
	prereq_ids = list("comptech")
	design_ids = list("secdata", "med_data", "prisonmanage", "vendor", "automated_announcement")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 1000)
	export_price = 2000

/datum/techweb_node/telecomms
	id = "telecomms"
	display_name = "Телекоммуникационные технологии"
	description = "Подпространственная связь для мгновенной передачи сигналов."
	prereq_ids = list("comptech", "bluespace_basic")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 5000
	design_ids = list("s-receiver", "s-bus", "s-broadcaster", "s-processor", "s-hub", "s-server", "s-relay", "comm_monitor", "comm_server",
	"s-ansible", "s-filter", "s-amplifier", "ntnet_relay", "s-treatment", "s-analyzer", "s-crystal", "s-transmitter", "s-messaging")

/datum/techweb_node/integrated_HUDs
	id = "integrated_HUDs"
	display_name = "Интегрированные интерфейсы (HUD)"
	description = "Проекция данных системы прямо на глазные линзы и визоры."
	prereq_ids = list("comp_recordkeeping", "emp_basic")
	design_ids = list("health_hud", "security_hud", "diagnostic_hud", "scigoggles")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 1500)
	export_price = 5000

/datum/techweb_node/NVGtech
	id = "NVGtech"
	display_name = "Технологии ночного видения"
	description = "Усиление слабого света для обзора в абсолютной темноте."
	prereq_ids = list("integrated_HUDs", "adv_engi", "emp_adv")
	design_ids = list("health_hud_night", "security_hud_night", "diagnostic_hud_night", "night_visision_goggles", "nvgmesons")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 5000)
	export_price = 5000

////////////////////////Medical////////////////////////
/datum/techweb_node/cloning
	id = "cloning"
	display_name = "Генная инженерная регенерация"
	description = "Технологии восстановления и модификации живых клеток."
	prereq_ids = list("biotech")
	design_ids = list("clonecontrol", "clonepod", "clonescanner", "scan_console", "cloning_disk")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 5000

/datum/techweb_node/cryotech
	id = "cryotech"
	display_name = "Криостазис"
	description = "Глубокая заморозка органики и материалов для длительного сохранения."
	prereq_ids = list("adv_engi", "biotech")
	design_ids = list("splitbeaker", "noreactsyringe", "cryotube", "cryo_Grenade", "stasis")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2000)
	export_price = 4000

/datum/techweb_node/subdermal_implants
	id = "subdermal_implants"
	display_name = "Подкожные импланты"
	description = "Микроэлектронные чипы, внедряемые под кожу."
	prereq_ids = list("biotech")
	design_ids = list("implanter", "implantcase", "implant_chem", "implant_tracking", "locator", "c38_trac")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 5000

/datum/techweb_node/cyber_organs
	id = "cyber_organs"
	display_name = "Кибернетические органы"
	description = "Искусственные протезы жизненно важных органов."
	prereq_ids = list("adv_biotech")
	design_ids = list("cybernetic_ears", "cybernetic_heart", "cybernetic_liver", "cybernetic_lungs")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 1000)
	export_price = 5000

/datum/techweb_node/cyber_organs_upgraded
	id = "cyber_organs_upgraded"
	display_name = "Улучшенные кибернетические органы"
	description = "Модернизированные протезы повышенной надёжности."
	prereq_ids = list("cyber_organs")
	design_ids = list("cybernetic_ears_u", "cybernetic_heart_u", "cybernetic_liver_u", "cybernetic_lungs_u")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 1500)
	export_price = 5000

/datum/techweb_node/cyber_implants
	id = "cyber_implants"
	display_name = "Кибернетические импланты"
	description = "Электронные модификации тела, усиливающие человеческие возможности."
	prereq_ids = list("adv_biotech", "datatheory")
	design_ids = list("ci-nutriment", "ci-breather", "ci-gloweyes", "ci-welding", "ci-medhud", "ci-sechud", "ci-diaghud")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 5000

/datum/techweb_node/adv_cyber_implants
	id = "adv_cyber_implants"
	display_name = "Передовые кибернетические импланты"
	description = "Улучшенные высокопроизводительные аугментации."
	prereq_ids = list("neural_programming", "cyber_implants","integrated_HUDs")
	design_ids = list("ci-toolset", "ci-surgery", "ci-reviver", "ci-nutrimentplus")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 5000

/datum/techweb_node/combat_cyber_implants
	id = "combat_cyber_implants"
	display_name = "Боевые киберимпланты"
	description = "Военные импланты для повышения выживаемости и боевых качеств."
	prereq_ids = list("adv_cyber_implants","weaponry","NVGtech","high_efficiency")
	design_ids = list("ci-xray", "ci-thermals", "ci-antidrop", "ci-antistun", "ci-thrusters")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 5000

////////////////////////Tools////////////////////////

/datum/techweb_node/basic_mining
	id = "basic_mining"
	display_name = "Технологии добычи руды"
	description = "Базовые буровые и геологоразведочные инструменты."
	prereq_ids = list("engineering", "basic_plasma")
	design_ids = list("drill", "superresonator", "triggermod", "damagemod", "cooldownmod", "rangemod", "ore_redemption", "mining_equipment_vendor", "cargoexpress", "plasmacutter")//e a r l y    g a  m e)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 5000

/datum/techweb_node/adv_mining
	id = "adv_mining"
	display_name = "Передовая добыча руды"
	description = "Сверхэффективные установки для глубокого бурения и добычи."	//dumb mc references
	prereq_ids = list("basic_mining", "adv_engi", "adv_power", "adv_plasma")
	design_ids = list("drill_diamond", "jackhammer", "hypermod", "plasmacutter_adv")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 5000

/datum/techweb_node/janitor
	id = "janitor"
	display_name = "Передовые санитарные технологии"
	description = "Очистка поверхностей быстрее, глубже и эффективнее."
	prereq_ids = list("adv_engi")
	design_ids = list("holobarrier_jani", "advmop", "buffer", "blutrash", "light_replacer", "spraybottle", "beartrap")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 5000

/datum/techweb_node/botany
	id = "botany"
	display_name = "Ботаническая инженерия"
	description = "Инструменты для культивации растений и селекции."
	prereq_ids = list("adv_engi", "biotech")
	design_ids = list("diskplantgene", "portaseeder", "plantgenes", "flora_gun", "hydro_tray", "biogenerator", "seed_extractor")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 5000

/datum/techweb_node/exp_tools
	id = "exp_tools"
	display_name = "Экспериментальные инструменты"
	description = "Высокотехнологичный инструментарий экспериментальной физики."
	design_ids = list("exwelder", "jawsoflife", "handdrill", "laserscalpel", "mechanicalpinches", "searingtool")
	prereq_ids = list("adv_engi")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 5000

/datum/techweb_node/sec_basic
	id = "sec_basic"
	display_name = "Базовое охранное снаряжение"
	description = "Стандартное оснащение службы безопасности."
	design_ids = list("seclite", "pepperspray", "bola_energy", "zipties", "evidencebag")
	prereq_ids = list("base")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 1000)
	export_price = 5000

/datum/techweb_node/rcd_upgrade
	id = "rcd_upgrade"
	display_name = "Улучшение чертежей РСД"
	description = "Открывает новые проекты для быстрого строительного устройства."
	design_ids = list("rcd_upgrade_frames", "rcd_upgrade_simple_circuits")
	prereq_ids = list("adv_engi")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 5000

/datum/techweb_node/adv_rcd_upgrade
	id = "adv_rcd_upgrade"
	display_name = "Передовое улучшение чертежей РСД"
	description = "Открывает расширенные проекты быстрого строительного устройства."
	design_ids = list("rcd_upgrade_silo_link")
	prereq_ids = list("rcd_upgrade", "bluespace_travel")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 25000)
	export_price = 5000

/////////////////////////weaponry tech/////////////////////////
/datum/techweb_node/weaponry
	id = "weaponry"
	display_name = "Разработка вооружения"
	description = "Методы создания наступательного и оборонительного оружия."
	prereq_ids = list("engineering")
	design_ids = list("pin_testing", "tele_shield")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 10000)
	export_price = 5000

/datum/techweb_node/adv_weaponry
	id = "adv_weaponry"
	display_name = "Передовая разработка вооружения"
	description = "Смертоносные оружейные технологии нового поколения."
	prereq_ids = list("adv_engi", "weaponry")
	design_ids = list("pin_loyalty")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 10000)
	export_price = 5000

/datum/techweb_node/electric_weapons
	id = "electronic_weapons"
	display_name = "Энергетическое оружие"
	description = "Оружие на основе направленных электрических разрядов."
	prereq_ids = list("weaponry", "adv_power"  , "emp_basic")
	design_ids = list("stunrevolver", "ioncarbine")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 5000

/datum/techweb_node/radioactive_weapons
	id = "radioactive_weapons"
	display_name = "Радиационное оружие"
	description = "Вооружение, использующее ионизирующее излучение."
	prereq_ids = list("adv_engi", "adv_weaponry")
	design_ids = list("nuclear_gun")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 5000

/datum/techweb_node/medical_weapons
	id = "medical_weapons"
	display_name = "Медицинское вооружение"
	description = "Инъекционные и седативные боевые системы."
	prereq_ids = list("adv_biotech", "weaponry")
	design_ids = list("rapidsyringe")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 5000

/datum/techweb_node/beam_weapons
	id = "beam_weapons"
	display_name = "Лучевое оружие"
	description = "Базовое лазерное вооружение."
	prereq_ids = list("adv_weaponry")
	design_ids = list("temp_gun", "xray_laser")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 5000

/datum/techweb_node/adv_beam_weapons
	id = "adv_beam_weapons"
	display_name = "Передовое лучевое оружие"
	description = "Мощные лазерные и плазменные излучатели."
	prereq_ids = list("beam_weapons")
	design_ids = list("beamrifle")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 5000

/datum/techweb_node/explosive_weapons
	id = "explosive_weapons"
	display_name = "Взрывчатое и пиротехническое оружие"
	description = "Тяжёлое вооружение разрушительного действия."
	prereq_ids = list("adv_weaponry")
	design_ids = list("large_Grenade", "pyro_Grenade", "adv_Grenade")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 5000

/datum/techweb_node/ballistic_weapons
	id = "ballistic_weapons"
	display_name = "Кинетическое оружие"
	description = "Огнестрельное оружие и пороховые боеприпасы."
	prereq_ids = list("weaponry")
	design_ids = list("mag_oldsmg", "mag_oldsmg_ap", "mag_oldsmg_ic")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 5000

/datum/techweb_node/exotic_ammo
	id = "exotic_ammo"
	display_name = "Особые боеприпасы"
	description = "Специализированные и нелетальные патроны."
	prereq_ids = list("adv_weaponry", "medical_weapons")
	design_ids = list("techshotshell", "c38_hotshot", "c38_iceblox", "shotgundartcryostasis")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 5000

/datum/techweb_node/gravity_gun
	id = "gravity_gun"
	display_name = "Гравитационный манипулятор"
	description = "Устройство искривления гравитации и захвата предметов."
	prereq_ids = list("adv_weaponry", "bluespace_travel")
	design_ids = list("gravitygun", "mech_gravcatapult")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 5000

////////////////////////mech technology////////////////////////
/datum/techweb_node/adv_mecha
	id = "adv_mecha"
	display_name = "Передовые экзоскелеты"
	description = "Тяжёлые военные и исследовательские экзоскелеты."
	prereq_ids = list("adv_robotics")
	design_ids = list("mech_repair_droid")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 5000

/datum/techweb_node/odysseus
	id = "mecha_odysseus"
	display_name = "Экзоскелет: Одиссей"
	description = "Чертежи медицинского поисково-спасательного экзоскелета «Одиссей»."
	prereq_ids = list("base")
	design_ids = list("odysseus_chassis", "odysseus_torso", "odysseus_head", "odysseus_left_arm", "odysseus_right_arm" ,"odysseus_left_leg", "odysseus_right_leg",
	"odysseus_main", "odysseus_peri")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 5000

/datum/techweb_node/gygax
	id = "mech_gygax"
	display_name = "Экзоскелет: Гигакс"
	description = "Чертежи универсального боевого экзоскелета «Гигакс»."
	prereq_ids = list("adv_mecha", "weaponry")
	design_ids = list("gygax_chassis", "gygax_torso", "gygax_head", "gygax_left_arm", "gygax_right_arm", "gygax_left_leg", "gygax_right_leg", "gygax_main",
	"gygax_peri", "gygax_targ", "gygax_armor")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 5000

/datum/techweb_node/durand
	id = "mech_durand"
	display_name = "Экзоскелет: Дюранд"
	description = "Чертежи тяжёлого бронированного экзоскелета «Дюранд»."
	prereq_ids = list("adv_mecha", "adv_weaponry")
	design_ids = list("durand_chassis", "durand_torso", "durand_head", "durand_left_arm", "durand_right_arm", "durand_left_leg", "durand_right_leg", "durand_main",
	"durand_peri", "durand_targ", "durand_armor")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 5000

/datum/techweb_node/phazon
	id = "mecha_phazon"
	display_name = "Экзоскелет: Фазон"
	description = "Чертежи сверхтехнологичного экспериментального экзоскелета «Фазон»."
	prereq_ids = list("adv_mecha", "weaponry" , "micro_bluespace")
	design_ids = list("phazon_chassis", "phazon_torso", "phazon_head", "phazon_left_arm", "phazon_right_arm", "phazon_left_leg", "phazon_right_leg", "phazon_main",
	"phazon_peri", "phazon_targ", "phazon_armor")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 5000

/datum/techweb_node/adv_mecha_tools
	id = "adv_mecha_tools"
	display_name = "Передовое снаряжение экзоскелетов"
	description = "Инструменты высокой мощности для тяжёлых экзоскелетов."
	prereq_ids = list("adv_mecha")
	design_ids = list("mech_rcd", "mech_thrusters")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 5000

/datum/techweb_node/med_mech_tools
	id = "med_mech_tools"
	display_name = "Медицинское снаряжение экзоскелетов"
	description = "Специализированные медицинские приспособления для экзоскелетов."
	prereq_ids = list("adv_biotech")
	design_ids = list("mech_sleeper", "mech_syringe_gun", "mech_medi_beam")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 5000

/datum/techweb_node/mech_modules
	id = "adv_mecha_modules"
	display_name = "Модули экзоскелетов"
	description = "Вспомогательные модули для установки на экзоскелеты."
	prereq_ids = list("adv_mecha", "bluespace_power")
	design_ids = list("mech_energy_relay", "mech_ccw_armor", "mech_proj_armor", "mech_generator_nuclear")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 5000

/datum/techweb_node/mech_scattershot
	id = "mecha_tools"
	display_name = "Орудие экзоскелетов: LBX AC 10 «Картечь»"
	description = "Тяжёлое орудие ближнего боя для экзоскелетов."
	prereq_ids = list("ballistic_weapons")
	design_ids = list("mech_scattershot", "mech_scattershot_ammo")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 5000

/datum/techweb_node/mech_carbine
	id = "mech_carbine"
	display_name = "Орудие экзоскелетов: карабин FNX-99 «Аид»"
	description = "Скорострельный карабин для экзоскелетов."
	prereq_ids = list("ballistic_weapons")
	design_ids = list("mech_carbine", "mech_carbine_ammo")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 5000

/datum/techweb_node/mech_ion
	id = "mmech_ion"
	display_name = "Орудие экзоскелетов: тяжёлая ионная пушка MKIV"
	description = "Ионное орудие для вывода из строя электроники."
	prereq_ids = list("electronic_weapons", "emp_adv")
	design_ids = list("mech_ion")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 5000

/datum/techweb_node/mech_tesla
	id = "mech_tesla"
	display_name = "Орудие экзоскелетов: пушка Теслы MKI"
	description = "Орудие, генерирующее цепные электрические молнии."
	prereq_ids = list("electronic_weapons", "adv_power")
	design_ids = list("mech_tesla")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 5000

/datum/techweb_node/mech_laser
	id = "mech_laser"
	display_name = "Орудие экзоскелетов: лазер CH-PS «Испепелитель»"
	description = "Базовый лазерный излучатель для экзоскелетов."
	prereq_ids = list("beam_weapons")
	design_ids = list("mech_laser")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 5000

/datum/techweb_node/mech_laser_heavy
	id = "mech_laser_heavy"
	display_name = "Орудие экзоскелетов: лазерная пушка CH-LC «Солярис»"
	description = "Тяжёлое лазерное орудие высокой мощности."
	prereq_ids = list("adv_beam_weapons")
	design_ids = list("mech_laser_heavy")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 5000

/datum/techweb_node/mech_disabler
	id = "mech_disabler"
	display_name =  "Орудие экзоскелетов: глушитель CH-DS «Миротворец»"
	description = "Незримый парализатор для сдерживания целей."
	prereq_ids = list("beam_weapons")
	design_ids = list("mech_disabler")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 5000

/datum/techweb_node/mech_grenade_launcher
	id = "mech_grenade_launcher"
	display_name = "Орудие экзоскелетов: гранатомёт SGL-6"
	description = "Многозарядный гранатомёт для экзоскелетов."
	prereq_ids = list("explosive_weapons")
	design_ids = list("mech_grenade_launcher", "mech_grenade_launcher_ammo")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 5000

/datum/techweb_node/mech_missile_rack
	id = "mech_missile_rack"
	display_name = "Орудие экзоскелетов: ракетная установка BRM-6"
	description = "Ракетный блок дальнего поражения."
	prereq_ids = list("explosive_weapons")
	design_ids = list("mech_missile_rack", "mech_missile_rack_ammo")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 5000

/datum/techweb_node/clusterbang_launcher
	id = "clusterbang_launcher"
	display_name = "Модуль экзоскелетов: кассетная установка SOB-3"
	description = "Пусковая установка светошумовых кассетных гранат."
	prereq_ids = list("explosive_weapons")
	design_ids = list("clusterbang_launcher", "clusterbang_launcher_ammo")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 5000

/datum/techweb_node/mech_teleporter
	id = "mech_teleporter"
	display_name = "Модуль экзоскелетов: телепортатор"
	description = "Устройство мгновенного перемещения экзоскелета."
	prereq_ids = list("micro_bluespace")
	design_ids = list("mech_teleporter")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 5000

/datum/techweb_node/mech_wormhole_gen
	id = "mech_wormhole_gen"
	display_name = "Модуль экзоскелетов: генератор червоточин"
	description = "Локальный генератор червоточин для пространственных манёвров."
	prereq_ids = list("bluespace_travel")
	design_ids = list("mech_wormhole_gen")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 5000

/datum/techweb_node/mech_lmg
	id = "mech_lmg"
	display_name = "Орудие экзоскелетов: пулемёт Ultra AC 2"
	description = "Автоматический крупнокалиберный пулемёт для экзоскелетов."
	prereq_ids = list("ballistic_weapons")
	design_ids = list("mech_lmg", "mech_lmg_ammo")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 5000

/datum/techweb_node/mech_diamond_drill
	id = "mech_diamond_drill"
	display_name =  "Алмазный бур экзоскелетов"
	description = "Сверхпрочный алмазный бур для проходки твёрдых пород."
	prereq_ids = list("adv_mining")
	design_ids = list("mech_diamond_drill")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 5000

/////////////////////////Nanites/////////////////////////
/datum/techweb_node/nanite_base
	id = "nanite_base"
	display_name = "Базовое нанопрограммирование"
	description = "Основы создания и управления наномашинами."
	prereq_ids = list("datatheory")
	design_ids = list("nanite_disk","nanite_remote","nanite_comm_remote","nanite_scanner",\
						"nanite_chamber","public_nanite_chamber","nanite_chamber_control","nanite_programmer","nanite_program_hub","nanite_cloud_control",\
						"relay_nanites", "monitoring_nanites", "research_nanites" ,"researchplus_nanites", "access_nanites", "repairing_nanites","sensor_nanite_volume", "repeater_nanites", "relay_repeater_nanites","red_diag_nanites")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 1000)
	export_price = 5000

/datum/techweb_node/nanite_smart
	id = "nanite_smart"
	display_name = "Интеллектуальное нанопрограммирование"
	description = "Нанопрограммы для сложных самостоятельных действий и поиска целей."
	prereq_ids = list("nanite_base","robotics")
	design_ids = list("purging_nanites", "metabolic_nanites", "stealth_nanites", "memleak_nanites","sensor_voice_nanites", "voice_nanites")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 500, TECHWEB_POINT_TYPE_NANITES = 500)
	export_price = 4000

/datum/techweb_node/nanite_mesh
	id = "nanite_mesh"
	display_name = "Каркасное нанопрограммирование"
	description = "Нанопрограммы для формирования статических мембран и защитных сеток."
	prereq_ids = list("nanite_base","engineering")
	design_ids = list("hardening_nanites", "dermal_button_nanites", "refractive_nanites", "cryo_nanites", "conductive_nanites", "shock_nanites", "emp_nanites", "temperature_nanites")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 500, TECHWEB_POINT_TYPE_NANITES = 500)
	export_price = 5000

/datum/techweb_node/nanite_bio
	id = "nanite_bio"
	display_name = "Биологическое нанопрограммирование"
	description = "Нанопрограммы для прямого взаимодействия с живыми тканями."
	prereq_ids = list("nanite_base","biotech")
	design_ids = list("regenerative_nanites", "bloodheal_nanites", "coagulating_nanites","poison_nanites","flesheating_nanites",\
					"sensor_crit_nanites","sensor_death_nanites", "sensor_health_nanites", "sensor_damage_nanites", "sensor_species_nanites")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 500, TECHWEB_POINT_TYPE_NANITES = 500)
	export_price = 5000

/datum/techweb_node/nanite_neural
	id = "nanite_neural"
	display_name = "Нейральное нанопрограммирование"
	description = "Нанопрограммы, влияющие на нервную систему и вещество мозга."
	prereq_ids = list("nanite_bio")
	design_ids = list("nervous_nanites", "brainheal_nanites", "paralyzing_nanites", "stun_nanites", "selfscan_nanites","good_mood_nanites","bad_mood_nanites")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 1000, TECHWEB_POINT_TYPE_NANITES = 1000)
	export_price = 5000

/datum/techweb_node/nanite_synaptic
	id = "nanite_synaptic"
	display_name = "Синаптическое нанопрограммирование"
	description = "Нанопрограммы для воздействия на восприятие и мыслительные процессы."
	prereq_ids = list("nanite_neural","neural_programming")
	design_ids = list("mindshield_nanites", "pacifying_nanites", "blinding_nanites", "sleep_nanites", "mute_nanites", "speech_nanites","hallucination_nanites")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 1000, TECHWEB_POINT_TYPE_NANITES = 1000)
	export_price = 5000

/datum/techweb_node/nanite_harmonic
	id = "nanite_harmonic"
	display_name = "Гармоническое нанопрограммирование"
	description = "Бесшовный симбиоз наномашин и биологического организма."
	prereq_ids = list("nanite_bio","nanite_smart","nanite_mesh")
	design_ids = list("fakedeath_nanites","aggressive_nanites","defib_nanites","regenerative_plus_nanites","brainheal_plus_nanites","purging_plus_nanites","adrenaline_nanites")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2000, TECHWEB_POINT_TYPE_NANITES = 2000)
	export_price = 8000

/datum/techweb_node/nanite_combat
	id = "nanite_military"
	display_name = "Военное нанопрограммирование"
	description = "Боевые нанопрограммы армейского назначения."
	prereq_ids = list("nanite_harmonic", "syndicate_basic")
	design_ids = list("explosive_nanites","pyro_nanites","meltdown_nanites","viral_nanites","nanite_sting_nanites")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500, TECHWEB_POINT_TYPE_NANITES = 2500)
	export_price = 12500

/datum/techweb_node/nanite_hazard
	id = "nanite_hazard"
	display_name = "Особо опасные нанопрограммы"
	description = "Экстремальные программы нанитов с разрушительным потенциалом."
	prereq_ids = list("nanite_harmonic", "alientech")
	design_ids = list("spreading_nanites","mindcontrol_nanites","mitosis_nanites")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 3000, TECHWEB_POINT_TYPE_NANITES = 4000)
	export_price = 15000

////////////////////////Alien technology////////////////////////
/datum/techweb_node/alientech //AYYYYYYYYLMAOO tech
	id = "alientech"
	display_name = "Внеземные технологии"
	description = "Загадочные артефакты и механизмы чужих цивилизаций."
	prereq_ids = list("biotech","engineering")
	boost_item_paths = list(/obj/item/gun/energy/alien, /obj/item/scalpel/alien, /obj/item/hemostat/alien, /obj/item/retractor/alien, /obj/item/circular_saw/alien,
	/obj/item/cautery/alien, /obj/item/surgicaldrill/alien, /obj/item/screwdriver/abductor, /obj/item/wrench/abductor, /obj/item/crowbar/abductor, /obj/item/multitool/abductor,
	/obj/item/weldingtool/abductor, /obj/item/wirecutters/abductor, /obj/item/circuitboard/machine/abductor, /obj/item/abductor/baton, /obj/item/abductor, /obj/item/gun/energy/shrink_ray)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 5000)
	export_price = 20000
	hidden = TRUE
	design_ids = list("alienalloy")

/datum/techweb_node/alientech/on_research() //Unlocks the Zeta shuttle for purchase
		SSshuttle.shuttle_purchase_requirements_met |= SHUTTLE_UNLOCK_ALIENTECH

/datum/techweb_node/alien_bio
	id = "alien_bio"
	display_name = "Внеземные биотехнические инструменты"
	description = "Продвинутый биологический инструмент внеземного происхождения."
	prereq_ids = list("alientech", "adv_biotech")
	design_ids = list("alien_scalpel", "alien_hemostat", "alien_retractor", "alien_saw", "alien_drill", "alien_cautery")
	boost_item_paths = list(/obj/item/gun/energy/alien, /obj/item/scalpel/alien, /obj/item/hemostat/alien, /obj/item/retractor/alien, /obj/item/circular_saw/alien,
	/obj/item/cautery/alien, /obj/item/surgicaldrill/alien, /obj/item/screwdriver/abductor, /obj/item/wrench/abductor, /obj/item/crowbar/abductor, /obj/item/multitool/abductor,
	/obj/item/weldingtool/abductor, /obj/item/wirecutters/abductor, /obj/item/circuitboard/machine/abductor, /obj/item/abductor/baton, /obj/item/abductor, /obj/item/gun/energy/shrink_ray)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 20000
	hidden = TRUE

/datum/techweb_node/alien_engi
	id = "alien_engi"
	display_name = "Внеземная инженерия"
	description = "Инженерные приспособления инопланетных конструкторов."
	prereq_ids = list("alientech", "adv_engi")
	design_ids = list("alien_wrench", "alien_wirecutters", "alien_screwdriver", "alien_crowbar", "alien_welder", "alien_multitool")
	boost_item_paths = list(/obj/item/screwdriver/abductor, /obj/item/wrench/abductor, /obj/item/crowbar/abductor, /obj/item/multitool/abductor,
	/obj/item/weldingtool/abductor, /obj/item/wirecutters/abductor, /obj/item/circuitboard/machine/abductor, /obj/item/abductor/baton, /obj/item/abductor,
	/obj/item/gun/energy/shrink_ray)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 20000
	hidden = TRUE

/datum/techweb_node/syndicate_basic
	id = "syndicate_basic"
	display_name = "Нелегальные технологии"
	description = "Запрещённые исследования для создания опасных предметов."
	prereq_ids = list("adv_engi", "adv_weaponry", "explosive_weapons")
	design_ids = list("decloner", "borg_syndicate_module", "ai_cam_upgrade", "suppressor", "largecrossbow", "donksofttoyvendor", "donksoft_refill", "advanced_camera")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 10000)
	export_price = 5000
	hidden = TRUE

/datum/techweb_node/syndicate_basic/New()		//Crappy way of making syndicate gear decon supported until there's another way.
	. = ..()
	boost_item_paths = list()
	for(var/path in GLOB.uplink_items)
		var/datum/uplink_item/UI = new path
		if(!UI.item || !UI.illegal_tech)
			continue
		boost_item_paths |= UI.item	//allows deconning to unlock.

//Helpers for debugging/balancing the techweb in its entirety!
/proc/total_techweb_exports()
	var/list/datum/techweb_node/processing = list()
	for(var/i in subtypesof(/datum/techweb_node))
		processing += new i
	. = 0
	for(var/i in processing)
		var/datum/techweb_node/TN = i
		. += TN.export_price

/proc/total_techweb_points()
	var/list/datum/techweb_node/processing = list()
	for(var/i in subtypesof(/datum/techweb_node))
		processing += new i
	var/datum/techweb/TW = new
	TW.research_points = list()
	for(var/i in processing)
		var/datum/techweb_node/TN = i
		TW.add_point_list(TN.research_costs)
	return TW.research_points

/proc/total_techweb_points_printout()
	var/list/datum/techweb_node/processing = list()
	for(var/i in subtypesof(/datum/techweb_node))
		processing += new i
	var/datum/techweb/TW = new
	TW.research_points = list()
	for(var/i in processing)
		var/datum/techweb_node/TN = i
		TW.add_point_list(TN.research_costs)
	return TW.printout_points()
