/obj/item/ammo_box/magazine/m12g
	name = "дробовой магазин (12g картечь)"
	desc = ""
	icon_state = "m12gb"
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot
	caliber = "shotgun"
	max_ammo = 8

/obj/item/ammo_box/magazine/m12g/update_icon()
	..()
	icon_state = "[initial(icon_state)]-[CEILING(ammo_count(FALSE)/8, 1)*8]"

/obj/item/ammo_box/magazine/m12g/stun
	name = "дробовой магазин (12g тазерные)"
	icon_state = "m12gs"
	ammo_type = /obj/item/ammo_casing/shotgun/stunslug

/obj/item/ammo_box/magazine/m12g/slug
	name = "дробовой магазин (12g пули)"
	icon_state = "m12gb"    //this may need an unique sprite
	ammo_type = /obj/item/ammo_casing/shotgun

/obj/item/ammo_box/magazine/m12g/dragon
	name = "дробовой магазин (12g дыхание дракона)"
	icon_state = "m12gf"
	ammo_type = /obj/item/ammo_casing/shotgun/dragonsbreath

/obj/item/ammo_box/magazine/m12g/bioterror
	name = "дробовой магазин (12g биотеррор)"
	icon_state = "m12gt"
	ammo_type = /obj/item/ammo_casing/shotgun/dart/bioterror

/obj/item/ammo_box/magazine/m12g/meteor
	name = "дробовой магазин (12g метеорные)"
	icon_state = "m12gbc"
	ammo_type = /obj/item/ammo_casing/shotgun/meteorslug
