///////////////////Computer Boards///////////////////////////////////

/datum/design/board
	name = "Проект компьютера (ПУСТАЯ ЗАПИСЬ)"
	desc = ""
	build_type = IMPRINTER
	materials = list(/datum/material/glass = 1000)

/datum/design/board/arcade_battle
	name = "Проект компьютера (боевой аркадный автомат)"
	desc = ""
	id = "arcade_battle"
	build_path = /obj/item/circuitboard/computer/arcade/battle
	category = list("Computer Boards")
	departmental_flags = DEPARTMENTAL_FLAG_ALL

/datum/design/board/orion_trail
	name = "Проект компьютера (аркадный автомат «Тропа Ориона»)"
	desc = ""
	id = "arcade_orion"
	build_path = /obj/item/circuitboard/computer/arcade/orion_trail
	category = list("Computer Boards")
	departmental_flags = DEPARTMENTAL_FLAG_ALL

/datum/design/board/seccamera
	name = "Проект компьютера (камеры наблюдения)"
	desc = ""
	id = "seccamera"
	build_path = /obj/item/circuitboard/computer/security
	category = list("Computer Boards")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/board/rdcamera
	name = "Проект компьютера (монитор исследований)"
	desc = ""
	id = "rdcamera"
	build_path = /obj/item/circuitboard/computer/research
	category = list("Computer Boards")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/xenobiocamera
	name = "Проект компьютера (консоль ксенобиологии)"
	desc = ""
	id = "xenobioconsole"
	build_path = /obj/item/circuitboard/computer/xenobiology
	category = list("Computer Boards")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/aiupload
	name = "Проект компьютера (загрузка законов ИИ)"
	desc = ""
	id = "aiupload"
	materials = list(/datum/material/glass = 1000, /datum/material/gold = 2000)
	build_path = /obj/item/circuitboard/computer/aiupload
	category = list("Computer Boards")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/borgupload
	name = "Проект компьютера (загрузка законов киборгов)"
	desc = ""
	id = "borgupload"
	materials = list(/datum/material/glass = 1000, /datum/material/gold = 2000)
	build_path = /obj/item/circuitboard/computer/borgupload
	category = list("Computer Boards")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/med_data
	name = "Проект компьютера (медицинские карты)"
	desc = ""
	id = "med_data"
	build_path = /obj/item/circuitboard/computer/med_data
	category = list("Computer Boards")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL

/datum/design/board/operating
	name = "Проект компьютера (операционный компьютер)"
	desc = ""
	id = "operating"
	build_path = /obj/item/circuitboard/computer/operating
	category = list("Computer Boards")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/pandemic
	name = "Проект компьютера (ПанД.Е.М.И.Я. 2200)"
	desc = ""
	id = "pandemic"
	build_path = /obj/item/circuitboard/computer/pandemic
	category = list("Computer Boards")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL

/datum/design/board/scan_console
	name = "Проект компьютера (модификатор ДНК)"
	desc = ""
	id = "scan_console"
	build_path = /obj/item/circuitboard/computer/scan_consolenew
	category = list("Computer Boards")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/comconsole
	name = "Проект компьютера (консоль связи)"
	desc = ""
	id = "comconsole"
	build_path = /obj/item/circuitboard/computer/communications
	category = list("Computer Boards")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SECURITY				//Honestly should have a bridge techfab for this sometime.

/datum/design/board/idcardconsole
	name = "Проект компьютера (консоль ID-карт)"
	desc = ""
	id = "idcardconsole"
	build_path = /obj/item/circuitboard/computer/card
	category = list("Computer Boards")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SECURITY				//Honestly should have a bridge techfab for this sometime.

/datum/design/board/crewconsole
	name = "Проект компьютера (мониторинг экипажа)"
	desc = ""
	id = "crewconsole"
	build_path = /obj/item/circuitboard/computer/crew
	category = list("Computer Boards")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY | DEPARTMENTAL_FLAG_MEDICAL

/datum/design/board/secdata
	name = "Проект компьютера (дела службы безопасности)"
	desc = ""
	id = "secdata"
	build_path = /obj/item/circuitboard/computer/secure_data
	category = list("Computer Boards")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/board/atmosalerts
	name = "Проект компьютера (атмосферная тревога)"
	desc = ""
	id = "atmosalerts"
	build_path = /obj/item/circuitboard/computer/atmos_alert
	category = list("Computer Boards")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/board/atmos_control
	name = "Проект компьютера (атмосферный монитор)"
	desc = ""
	id = "atmos_control"
	build_path = /obj/item/circuitboard/computer/atmos_control
	category = list("Computer Boards")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/board/robocontrol
	name = "Проект компьютера (управление робототехникой)"
	desc = ""
	id = "robocontrol"
	build_path = /obj/item/circuitboard/computer/robotics
	category = list("Computer Boards")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/slot_machine
	name = "Проект компьютера (игровой автомат)"
	desc = ""
	id = "slotmachine"
	build_path = /obj/item/circuitboard/computer/slot_machine
	category = list("Computer Boards")
	departmental_flags = DEPARTMENTAL_FLAG_ALL

/datum/design/board/powermonitor
	name = "Проект компьютера (мониторинг электросети)"
	desc = ""
	id = "powermonitor"
	build_path = /obj/item/circuitboard/computer/powermonitor
	category = list("Computer Boards")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/board/solarcontrol
	name = "Проект компьютера (управление солнечными панелями)"
	desc = ""
	id = "solarcontrol"
	build_path = /obj/item/circuitboard/computer/solar_control
	category = list("Computer Boards")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/board/prisonmanage
	name = "Проект компьютера (управление заключёнными)"
	desc = ""
	id = "prisonmanage"
	build_path = /obj/item/circuitboard/computer/prisoner
	category = list("Computer Boards")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/board/mechacontrol
	name = "Проект компьютера (управление экзоскелетами)"
	desc = ""
	id = "mechacontrol"
	build_path = /obj/item/circuitboard/computer/mecha_control
	category = list("Computer Boards")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/mechapower
	name = "Проект компьютера (питание ангара экзоскелетов)"
	desc = ""
	id = "mechapower"
	build_path = /obj/item/circuitboard/computer/mech_bay_power_console
	category = list("Computer Boards")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/rdconsole
	name = "Проект компьютера (консоль исследований и разработок)"
	desc = ""
	id = "rdconsole"
	build_path = /obj/item/circuitboard/computer/rdconsole
	category = list("Computer Boards")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/cargo
	name = "Проект компьютера (консоль снабжения)"
	desc = ""
	id = "cargo"
	build_path = /obj/item/circuitboard/computer/cargo
	category = list("Computer Boards")
	departmental_flags = DEPARTMENTAL_FLAG_CARGO

/datum/design/board/cargorequest
	name = "Проект компьютера (запросы снабжения)"
	desc = ""
	id = "cargorequest"
	build_path = /obj/item/circuitboard/computer/cargo/request
	category = list("Computer Boards")
	departmental_flags = DEPARTMENTAL_FLAG_CARGO

/datum/design/board/bounty
	name = "Проект компьютера (консоль наград)"
	desc = ""
	id = "bounty"
	build_path = /obj/item/circuitboard/computer/bounty
	category = list("Computer Boards")
	departmental_flags = DEPARTMENTAL_FLAG_CARGO

/datum/design/board/mining
	name = "Проект компьютера (статус аванпоста)"
	desc = ""
	id = "mining"
	build_path = /obj/item/circuitboard/computer/mining
	category = list("Computer Boards")
	departmental_flags = DEPARTMENTAL_FLAG_CARGO | DEPARTMENTAL_FLAG_SECURITY

/datum/design/board/comm_monitor
	name = "Проект компьютера (мониторинг телекоммуникаций)"
	desc = ""
	id = "comm_monitor"
	build_path = /obj/item/circuitboard/computer/comm_monitor
	category = list("Computer Boards")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/board/comm_server
	name = "Проект компьютера (мониторинг серверов связи)"
	desc = ""
	id = "comm_server"
	build_path = /obj/item/circuitboard/computer/comm_server
	category = list("Computer Boards")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/board/message_monitor
	name = "Проект компьютера (мониторинг сообщений)"
	desc = ""
	id = "message_monitor"
	build_path = /obj/item/circuitboard/computer/message_monitor
	category = list("Computer Boards")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/board/aifixer
	name = "Проект компьютера (восстановитель целостности ИИ)"
	desc = ""
	id = "aifixer"
	build_path = /obj/item/circuitboard/computer/aifixer
	category = list("Computer Boards")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/libraryconsole
	name = "Проект компьютера (библиотечная консоль)"
	desc = ""
	id = "libraryconsole"
	build_path = /obj/item/circuitboard/computer/libraryconsole
	category = list("Computer Boards")
	departmental_flags = DEPARTMENTAL_FLAG_ALL

/datum/design/board/apc_control
	name = "Проект компьютера (управление ЛКП)"
	desc = ""
	id = "apc_control"
	build_path = /obj/item/circuitboard/computer/apc_control
	category = list("Computer Boards")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/board/nanite_chamber_control
	name = "Проект компьютера (управление нанитной камерой)"
	desc = ""
	id = "nanite_chamber_control"
	build_path = /obj/item/circuitboard/computer/nanite_chamber_control
	category = list("Computer Boards")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/nanite_cloud_control
	name = "Проект компьютера (облачное управление нанитами)"
	desc = ""
	id = "nanite_cloud_control"
	build_path = /obj/item/circuitboard/computer/nanite_cloud_controller
	category = list("Computer Boards")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/advanced_camera
	name = "Проект компьютера (улучшенная консоль камер)"
	desc = ""
	id = "advanced_camera"
	build_path = /obj/item/circuitboard/computer/advanced_camera
	category = list("Computer Boards")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY
