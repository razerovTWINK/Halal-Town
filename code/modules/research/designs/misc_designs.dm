
/////////////////////////////////////////
/////////////////HUDs////////////////////
/////////////////////////////////////////

/datum/design/health_hud
	name = "Медицинский визор (HUD)"
	desc = ""
	id = "health_hud"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 500, /datum/material/glass = 500)
	build_path = /obj/item/clothing/glasses/hud/health
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL

/datum/design/health_hud_night
	name = "Медицинский визор ночного видения (HUD)"
	desc = ""
	id = "health_hud_night"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 600, /datum/material/glass = 600, /datum/material/uranium = 1000, /datum/material/silver = 350)
	build_path = /obj/item/clothing/glasses/hud/health/night
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL

/datum/design/security_hud
	name = "Охранный визор (HUD)"
	desc = ""
	id = "security_hud"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 500, /datum/material/glass = 500)
	build_path = /obj/item/clothing/glasses/hud/security
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/security_hud_night
	name = "Охранный визор ночного видения (HUD)"
	desc = ""
	id = "security_hud_night"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 600, /datum/material/glass = 600, /datum/material/uranium = 1000, /datum/material/gold = 350)
	build_path = /obj/item/clothing/glasses/hud/security/night
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/diagnostic_hud
	name = "Диагностический визор (HUD)"
	desc = ""
	id = "diagnostic_hud"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 500, /datum/material/glass = 500)
	build_path = /obj/item/clothing/glasses/hud/diagnostic
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/diagnostic_hud_night
	name = "Диагностический визор ночного видения (HUD)"
	desc = ""
	id = "diagnostic_hud_night"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 600, /datum/material/glass = 600, /datum/material/uranium = 1000, /datum/material/plasma = 300)
	build_path = /obj/item/clothing/glasses/hud/diagnostic/night
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/////////////////////////////////////////
//////////////////Misc///////////////////
/////////////////////////////////////////

/datum/design/welding_goggles
	name = "Сварочные очки"
	desc = ""
	id = "welding_goggles"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 500, /datum/material/glass = 500)
	build_path = /obj/item/clothing/glasses/welding
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/welding_mask
	name = "Сварочный противогаз"
	desc = ""
	id = "weldingmask"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 3000, /datum/material/glass = 1000)
	build_path = /obj/item/clothing/mask/gas/welding
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/portaseeder
	name = "Портативный экстрактор семян"
	desc = ""
	id = "portaseeder"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 1000, /datum/material/glass = 400)
	build_path = /obj/item/storage/bag/plants/portaseeder
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SERVICE

/datum/design/air_horn
	name = "Пневмогудок"
	desc = ""
	id = "air_horn"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 4000, /datum/material/bananium = 1000)
	build_path = /obj/item/bikehorn/airhorn
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_ALL			//HONK!

/datum/design/mesons
	name = "Мязонные очки"
	desc = ""
	id = "mesons"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 500, /datum/material/glass = 500)
	build_path = /obj/item/clothing/glasses/meson
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_CARGO | DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/engine_goggles
	name = "Инженерные сканирующие очки"
	desc = ""
	id = "engine_goggles"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 500, /datum/material/glass = 500, /datum/material/plasma = 100)
	build_path = /obj/item/clothing/glasses/meson/engine
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/tray_goggles
	name = "Т-лучевые очки"
	desc = ""
	id = "tray_goggles"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 500, /datum/material/glass = 500)
	build_path = /obj/item/clothing/glasses/meson/engine/tray
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/nvgmesons
	name = "Мязонные очки ночного видения"
	desc = ""
	id = "nvgmesons"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 600, /datum/material/glass = 600, /datum/material/plasma = 350, /datum/material/uranium = 1000)
	build_path = /obj/item/clothing/glasses/meson/night
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_CARGO

/datum/design/night_vision_goggles
	name = "Очки ночного видения"
	desc = ""
	id = "night_visision_goggles"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 600, /datum/material/glass = 600, /datum/material/plasma = 350, /datum/material/uranium = 1000)
	build_path = /obj/item/clothing/glasses/night
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_SECURITY

/datum/design/magboots
	name = "Магнитные ботинки"
	desc = ""
	id = "magboots"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 4500, /datum/material/silver = 1500, /datum/material/gold = 2500)
	build_path = /obj/item/clothing/shoes/magboots
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/forcefield_projector
	name = "Проектор силового поля"
	desc = ""
	id = "forcefield_projector"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 2500, /datum/material/glass = 1000)
	build_path = /obj/item/forcefield_projector
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/sci_goggles
	name = "Научные очки"
	desc = ""
	id = "scigoggles"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 500, /datum/material/glass = 500)
	build_path = /obj/item/clothing/glasses/science
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/diskplantgene
	name = "Диск данных растений"
	desc = ""
	id = "diskplantgene"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron=200, /datum/material/glass = 100)
	build_path = /obj/item/disk/plantgene
	category = list("Electronics")
	departmental_flags = DEPARTMENTAL_FLAG_SERVICE

/datum/design/roastingstick
	name = "Улучшенный вертел для жарки"
	desc = ""
	id = "roastingstick"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron=1000, /datum/material/glass = 500, /datum/material/bluespace = 250)
	build_path = /obj/item/melee/roastingstick
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SERVICE

/datum/design/locator
	name = "Блюспейс-локатор"
	desc = ""
	id = "locator"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron=1000, /datum/material/glass = 500, /datum/material/silver = 500)
	build_path = /obj/item/locator
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/quantum_keycard
	name = "Квантовая ключ-карта"
	desc = ""
	id = "quantum_keycard"
	build_type = PROTOLATHE
	materials = list(/datum/material/glass = 500, /datum/material/iron = 500, /datum/material/silver = 500, /datum/material/bluespace = 1000)
	build_path = /obj/item/quantum_keycard
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/anomaly_neutralizer
	name = "Нейтрализатор аномалий"
	desc = ""
	id = "anomaly_neutralizer"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 2000, /datum/material/gold = 2000, /datum/material/plasma = 5000, /datum/material/uranium = 2000)
	build_path = /obj/item/anomaly_neutralizer
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/donksoft_refill
	name = "Пополнение автомата игрушек Donksoft"
	desc = ""
	id = "donksoft_refill"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 25000, /datum/material/glass = 15000, /datum/material/plasma = 20000, /datum/material/gold = 10000, /datum/material/silver = 10000)
	build_path = /obj/item/vending_refill/donksoft
	category = list("Equipment")

/datum/design/oxygen_tank
	name = "Кислородный баллон"
	desc = ""
	id = "oxygen_tank"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 2000)
	build_path = /obj/item/tank/internals/oxygen/empty
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/plasma_tank
	name = "Плазменный баллон"
	desc = ""
	id = "plasma_tank"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 2000)
	build_path = /obj/item/tank/internals/plasma/empty
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/id
	name = "ID-карта"
	desc = ""
	id = "idcard"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron=200, /datum/material/glass = 100)
	build_path = /obj/item/card/id
	category = list("Electronics")
	departmental_flags = DEPARTMENTAL_FLAG_SERVICE

/////////////////////////////////////////
////////////Janitor Designs//////////////
/////////////////////////////////////////

/datum/design/advmop
	name = "Улучшенная швабра"
	desc = ""
	id = "advmop"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 2500, /datum/material/glass = 200)
	build_path = /obj/item/mop/advanced
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SERVICE

/datum/design/blutrash
	name = "Бездонный мешок для мусора"
	desc = ""
	id = "blutrash"
	build_type = PROTOLATHE
	materials = list(/datum/material/gold = 1500, /datum/material/uranium = 250, /datum/material/plasma = 1500)
	build_path = /obj/item/storage/bag/trash/bluespace
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SERVICE

/datum/design/buffer
	name = "Насадка-полотер"
	desc = ""
	id = "buffer"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 3000, /datum/material/glass = 200)
	build_path = /obj/item/janiupgrade
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SERVICE

/datum/design/spraybottle
	name = "Пульверизатор"
	desc = ""
	id = "spraybottle"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 3000, /datum/material/glass = 200)
	build_path = /obj/item/reagent_containers/spray
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SERVICE

/datum/design/beartrap
	name = "Медвежий капкан"
	desc = ""
	id = "beartrap"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 5000, /datum/material/titanium = 1000)
	build_path = /obj/item/restraints/legcuffs/beartrap
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SERVICE

/////////////////////////////////////////
/////////////Holobarriers////////////////
/////////////////////////////////////////

/datum/design/holosign
	name = "Голографический проектор знаков"
	desc = ""
	id = "holosign"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 2000, /datum/material/glass = 1000)
	build_path = /obj/item/holosign_creator
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SERVICE

/datum/design/holobarrier_jani
	name = "Проектор санитарных голобарьеров"
	desc = ""
	id = "holobarrier_jani"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 2000, /datum/material/glass = 1000, /datum/material/silver = 1000)
	build_path = /obj/item/holosign_creator/janibarrier
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SERVICE


/datum/design/holosignsec
	name = "Проектор охранных голобарьеров"
	desc = ""
	id = "holosignsec"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 5000, /datum/material/glass = 1000, /datum/material/gold = 1000, /datum/material/silver = 1000)
	build_path = /obj/item/holosign_creator/security
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/holosignengi
	name = "Проектор инженерных голобарьеров"
	desc = ""
	id = "holosignengi"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 5000, /datum/material/glass = 1000, /datum/material/gold = 1000, /datum/material/silver = 1000)
	build_path = /obj/item/holosign_creator/engineering
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/holosignatmos
	name = "Проектор атмосферного головентилятора"
	desc = ""
	id = "holosignatmos"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 5000, /datum/material/glass = 1000, /datum/material/gold = 1000, /datum/material/silver = 1000)
	build_path = /obj/item/holosign_creator/atmos
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/holobarrier_med
	name = "Проектор голобарьеров PENLITE"
	desc = ""
	build_type = PROTOLATHE
	build_path = /obj/item/holosign_creator/medical
	materials = list(/datum/material/iron = 500, /datum/material/glass = 500, /datum/material/silver = 100) //a hint of silver since it can troll 2 antags (bad viros and sentient disease)
	id = "holobarrier_med"
	category = list("Medical Designs")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL

/////////////////////////////////////////
////////////////Armour///////////////////
/////////////////////////////////////////

/datum/design/reactive_armour
	name = "Основа реактивной брони"
	desc = ""
	id = "reactive_armour"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 10000, /datum/material/diamond = 5000, /datum/material/uranium = 8000, /datum/material/silver = 4500, /datum/material/gold = 5000)
	build_path = /obj/item/reactive_armour_shell
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/knight_armour
	name = "Рыцарские доспехи"
	desc = ""
	id = "knight_armour"
	build_type = AUTOLATHE
	materials = list(MAT_CATEGORY_RIGID = 10000)
	build_path = /obj/item/clothing/suit/armor/riot/knight/greyscale
	category = list("Imported")

/datum/design/knight_helmet
	name = "Рыцарский шлем"
	desc = ""
	id = "knight_helmet"
	build_type = AUTOLATHE
	materials = list(MAT_CATEGORY_RIGID = 5000)
	build_path = /obj/item/clothing/head/helmet/knight/greyscale
	category = list("Imported")



/////////////////////////////////////////
/////////////Security////////////////////
/////////////////////////////////////////

/datum/design/seclite
	name = "Охранный фонарик"
	desc = ""
	id = "seclite"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 2500)
	build_path = /obj/item/flashlight/seclite
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/detective_scanner
	name = "Криминалистический сканер"
	desc = ""
	id = "detective_scanner"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 5000, /datum/material/glass = 1000, /datum/material/gold = 2500, /datum/material/silver = 2000)
	build_path = /obj/item/detective_scanner
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/pepperspray
	name = "Перцовый баллончик"
	desc = ""
	id = "pepperspray"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 5000, /datum/material/glass = 1000)
	build_path = /obj/item/reagent_containers/spray/pepper/empty
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/bola_energy
	name = "Энергетическое боло"
	desc = ""
	id = "bola_energy"
	build_type = PROTOLATHE
	materials = list(/datum/material/silver = 500, /datum/material/plasma = 500, /datum/material/titanium = 500)
	build_path = /obj/item/restraints/legcuffs/bola/energy
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/zipties
	name = "Пластиковые стяжки"
	desc = ""
	id = "zipties"
	build_type = PROTOLATHE
	materials = list(/datum/material/plastic = 250)
	build_path = /obj/item/restraints/handcuffs/cable/zipties
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/evidencebag
	name = "Пакет для улик"
	desc = ""
	id = "evidencebag"
	build_type = PROTOLATHE
	materials = list(/datum/material/plastic = 100)
	build_path = /obj/item/evidencebag
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/plumbing_rcd
	name = "Сантехнический сборщик"
	id = "plumbing_rcd"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 75000, /datum/material/glass = 37500, /datum/material/plastic = 1000)
	build_path = /obj/item/construction/plumbing
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL
