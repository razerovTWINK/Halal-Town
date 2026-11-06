/obj/item/ammo_box/magazine/m10mm
	name = "пистолетный магазин (10мм)"
	desc = ""
	icon_state = "9x19p"
	ammo_type = /obj/item/ammo_casing/c10mm
	caliber = "10mm"
	max_ammo = 8
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/m10mm/fire
	name = "пистолетный магазин (10мм зажигательные)"
	icon_state = "9x19pI"
	desc = ""
	ammo_type = /obj/item/ammo_casing/c10mm/fire

/obj/item/ammo_box/magazine/m10mm/hp
	name = "пистолетный магазин (10мм экспансивные)"
	icon_state = "9x19pH"
	desc= "Оружейный магазин. Заряжен экспансивными патронами, крайне эффективными против незащищенных целей, но почти бесполезными против брони."
	ammo_type = /obj/item/ammo_casing/c10mm/hp

/obj/item/ammo_box/magazine/m10mm/ap
	name = "пистолетный магазин (10мм бронебойные)"
	icon_state = "9x19pA"
	desc= "Оружейный магазин. Заряжен патронами, пробивающими броню, но менее эффективными против обычных целей."
	ammo_type = /obj/item/ammo_casing/c10mm/ap

/obj/item/ammo_box/magazine/m45
	name = "пистолетный магазин (.45)"
	icon_state = "45-8"
	ammo_type = /obj/item/ammo_casing/c45
	caliber = ".45"
	max_ammo = 8

/obj/item/ammo_box/magazine/m45/update_icon()
	..()
	if (ammo_count() >= 8)
		icon_state = "45-8"
	else
		icon_state = "45-[ammo_count()]"

/obj/item/ammo_box/magazine/pistolm9mm
	name = "пистолетный магазин (9мм)"
	icon_state = "9x19p-8"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = "9mm"
	max_ammo = 15

/obj/item/ammo_box/magazine/pistolm9mm/update_icon()
	..()
	icon_state = "9x19p-[ammo_count() ? "8" : "0"]"

/obj/item/ammo_box/magazine/m50
	name = "пистолетный магазин (.50AE)"
	icon_state = "50ae"
	ammo_type = /obj/item/ammo_casing/a50AE
	caliber = ".50"
	max_ammo = 7
	multiple_sprites = AMMO_BOX_PER_BULLET
