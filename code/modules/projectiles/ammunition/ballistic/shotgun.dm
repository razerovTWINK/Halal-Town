// Shotgun

/obj/item/ammo_casing/shotgun
	name = "ружейная пуля"
	desc = ""
	icon_state = "blshell"
	caliber = "shotgun"
	custom_materials = list(/datum/material/iron=4000)
	projectile_type = /obj/projectile/bullet/shotgun_slug

/obj/item/ammo_casing/shotgun/beanbag
	name = "травматический патрон"
	desc = ""
	icon_state = "bshell"
	custom_materials = list(/datum/material/iron=250)
	projectile_type = /obj/projectile/bullet/shotgun_beanbag

/obj/item/ammo_casing/shotgun/incendiary
	name = "зажигательный патрон"
	desc = ""
	icon_state = "ishell"
	projectile_type = /obj/projectile/bullet/incendiary/shotgun

/obj/item/ammo_casing/shotgun/dragonsbreath
	name = "патрон «дыхание дракона»"
	desc = ""
	icon_state = "ishell2"
	projectile_type = /obj/projectile/bullet/incendiary/shotgun/dragonsbreath
	pellets = 4
	variance = 35

/obj/item/ammo_casing/shotgun/stunslug
	name = "тазерный патрон"
	desc = ""
	icon_state = "stunshell"
	projectile_type = /obj/projectile/bullet/shotgun_stunslug
	custom_materials = list(/datum/material/iron=250)

/obj/item/ammo_casing/shotgun/meteorslug
	name = "метеорный патрон"
	desc = ""
	icon_state = "mshell"
	projectile_type = /obj/projectile/bullet/shotgun_meteorslug

/obj/item/ammo_casing/shotgun/pulseslug
	name = "импульсный патрон"
	desc = "Хрупкое устройство, заряжаемое в дробовик. Капсюль служит спуском для мощного энергетического импульса. Одноразовое из-за перегрева, но позволяет поражать цели, неуязвимые для обычной дроби."
	icon_state = "pshell"
	projectile_type = /obj/projectile/beam/pulse/shotgun

/obj/item/ammo_casing/shotgun/frag12
	name = "осколочный патрон FRAG-12"
	desc = ""
	icon_state = "heshell"
	projectile_type = /obj/projectile/bullet/shotgun_frag12

/obj/item/ammo_casing/shotgun/buckshot
	name = "патрон с картечью"
	desc = ""
	icon_state = "gshell"
	projectile_type = /obj/projectile/bullet/pellet/shotgun_buckshot
	pellets = 6
	variance = 25

/obj/item/ammo_casing/shotgun/rubbershot
	name = "патрон с резиновой дробью"
	desc = ""
	icon_state = "bshell"
	projectile_type = /obj/projectile/bullet/pellet/shotgun_rubbershot
	pellets = 6
	variance = 25
	custom_materials = list(/datum/material/iron=4000)

/obj/item/ammo_casing/shotgun/incapacitate
	name = "усыпляющий патрон"
	desc = ""
	icon_state = "bountyshell"
	projectile_type = /obj/projectile/bullet/pellet/shotgun_incapacitate
	pellets = 12//double the pellets, but half the stun power of each, which makes this best for just dumping right in someone's face.
	variance = 25
	custom_materials = list(/datum/material/iron=4000)

/obj/item/ammo_casing/shotgun/improvised
	name = "самодельный патрон"
	desc = ""
	icon_state = "improvshell"
	projectile_type = /obj/projectile/bullet/pellet/shotgun_improvised
	custom_materials = list(/datum/material/iron=250)
	pellets = 10
	variance = 25

/obj/item/ammo_casing/shotgun/ion
	name = "ионный патрон"
	desc = "Продвинутый ружейный патрон с кристаллом ансибла. Расщепляет импульс на веер ослабленных ионных разрядов."
	icon_state = "ionshell"
	projectile_type = /obj/projectile/ion/weak
	pellets = 4
	variance = 35

/obj/item/ammo_casing/shotgun/laserslug
	name = "дробный лазерный патрон"
	desc = ""
	icon_state = "lshell"
	projectile_type = /obj/projectile/beam/weak
	pellets = 6
	variance = 35

/obj/item/ammo_casing/shotgun/techshell
	name = "незаряженный технологический патрон"
	desc = ""
	icon_state = "cshell"
	projectile_type = null

/obj/item/ammo_casing/shotgun/dart
	name = "ружейный дротик"
	desc = ""
	icon_state = "cshell"
	projectile_type = /obj/projectile/bullet/dart
	var/reagent_amount = 30

/obj/item/ammo_casing/shotgun/dart/Initialize()
	. = ..()
	create_reagents(reagent_amount, OPENCONTAINER)

/obj/item/ammo_casing/shotgun/dart/attackby()
	return

/obj/item/ammo_casing/shotgun/dart/noreact
	name = "криостазисный ружейный дротик"
	desc = ""
	icon_state = "cnrshell"
	reagent_amount = 10

/obj/item/ammo_casing/shotgun/dart/noreact/Initialize()
	. = ..()
	ENABLE_BITFIELD(reagents.flags, NO_REACT)

/obj/item/ammo_casing/shotgun/dart/bioterror
	desc = ""

/obj/item/ammo_casing/shotgun/dart/bioterror/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/consumable/ethanol/neurotoxin, 6)
	reagents.add_reagent(/datum/reagent/toxin/spore, 6)
	reagents.add_reagent(/datum/reagent/toxin/mutetoxin, 6) //;HELP OPS IN MAINT
	reagents.add_reagent(/datum/reagent/toxin/coniine, 6)
	reagents.add_reagent(/datum/reagent/toxin/sodium_thiopental, 6)
