/obj/item/ammo_box/magazine/mm712x82
	name = "коробчатый магазин (7.12x82мм)"
	icon_state = "a762-50"
	ammo_type = /obj/item/ammo_casing/mm712x82
	caliber = "mm71282"
	max_ammo = 50

/obj/item/ammo_box/magazine/mm712x82/hollow
	name = "коробчатый магазин (экспансивные 7.12x82мм)"
	ammo_type = /obj/item/ammo_casing/mm712x82/hollow

/obj/item/ammo_box/magazine/mm712x82/ap
	name = "коробчатый магазин (бронебойные 7.12x82мм)"
	ammo_type = /obj/item/ammo_casing/mm712x82/ap

/obj/item/ammo_box/magazine/mm712x82/incen
	name = "коробчатый магазин (зажигательные 7.12x82мм)"
	ammo_type = /obj/item/ammo_casing/mm712x82/incen

/obj/item/ammo_box/magazine/mm712x82/update_icon()
	..()
	icon_state = "a762-[round(ammo_count(),10)]"
