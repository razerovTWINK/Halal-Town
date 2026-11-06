/obj/item/ammo_box/a357
	name = "спидлоадер (.357)"
	desc = ""
	icon_state = "357"
	ammo_type = /obj/item/ammo_casing/a357
	max_ammo = 7
	multiple_sprites = AMMO_BOX_PER_BULLET
	item_flags = NO_MAT_REDEMPTION

/obj/item/ammo_box/c38
	name = "спидлоадер (.38)"
	desc = ""
	icon_state = "38"
	ammo_type = /obj/item/ammo_casing/c38
	max_ammo = 6
	multiple_sprites = AMMO_BOX_PER_BULLET
	custom_materials = list(/datum/material/iron = 20000)

/obj/item/ammo_box/c38/trac
	name = "спидлоадер (.38 TRAC)"
	desc = ""
	ammo_type = /obj/item/ammo_casing/c38/trac

/obj/item/ammo_box/c38/hotshot
	name = "спидлоадер (.38 Hot Shot)"
	desc = ""
	ammo_type = /obj/item/ammo_casing/c38/hotshot

/obj/item/ammo_box/c38/iceblox
	name = "спидлоадер (.38 Iceblox)"
	desc = ""
	ammo_type = /obj/item/ammo_casing/c38/iceblox

/obj/item/ammo_box/c9mm
	name = "коробка патронов (9мм)"
	icon_state = "9mmbox"
	ammo_type = /obj/item/ammo_casing/c9mm
	max_ammo = 30

/obj/item/ammo_box/c10mm
	name = "коробка патронов (10мм)"
	icon_state = "10mmbox"
	ammo_type = /obj/item/ammo_casing/c10mm
	max_ammo = 20

/obj/item/ammo_box/c45
	name = "коробка патронов (.45)"
	icon_state = "45box"
	ammo_type = /obj/item/ammo_casing/c45
	max_ammo = 20

/obj/item/ammo_box/a40mm
	name = "коробка гранат (40мм)"
	icon_state = "40mm"
	ammo_type = /obj/item/ammo_casing/a40mm
	max_ammo = 4
	multiple_sprites = AMMO_BOX_PER_BULLET

/obj/item/ammo_box/a762
	name = "обойма (7.62мм)"
	desc = ""
	icon_state = "762"
	ammo_type = /obj/item/ammo_casing/a762
	max_ammo = 5
	multiple_sprites = AMMO_BOX_PER_BULLET

/obj/item/ammo_box/n762
	name = "коробка патронов (7.62x38ммR)"
	icon_state = "10mmbox"
	ammo_type = /obj/item/ammo_casing/n762
	max_ammo = 14

/obj/item/ammo_box/foambox
	name = "коробка мягких дротиков"
	icon = 'icons/obj/guns/toy.dmi'
	icon_state = "foambox"
	ammo_type = /obj/item/ammo_casing/caseless/foam_dart
	max_ammo = 40
	custom_materials = list(/datum/material/iron = 500)

/obj/item/ammo_box/foambox/riot
	icon_state = "foambox_riot"
	ammo_type = /obj/item/ammo_casing/caseless/foam_dart/riot
	custom_materials = list(/datum/material/iron = 50000)
