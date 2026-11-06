/obj/item/gun/energy/taser
	name = "тазер"
	desc = ""
	icon_state = "taser"
	item_state = null	//so the human update icon uses the icon_state instead.
	ammo_type = list(/obj/item/ammo_casing/energy/electrode)
	ammo_x_offset = 3

/obj/item/gun/energy/tesla_revolver
	name = "тесла-пушка"
	desc = ""
	icon_state = "tesla"
	item_state = "tesla"
	ammo_type = list(/obj/item/ammo_casing/energy/tesla_revolver)
	can_flashlight = FALSE
	pin = null
	shaded_charge = 1

/obj/item/gun/energy/e_gun/advtaser
	name = "гибридный тазер"
	desc = ""
	icon_state = "advtaser"
	ammo_type = list(/obj/item/ammo_casing/energy/electrode, /obj/item/ammo_casing/energy/disabler)
	ammo_x_offset = 2

/obj/item/gun/energy/e_gun/advtaser/cyborg
	name = "тазер киборга"
	desc = ""
	can_flashlight = FALSE
	can_charge = FALSE
	use_cyborg_cell = TRUE

/obj/item/gun/energy/disabler
	name = "деактиватор"
	desc = ""
	icon_state = "disabler"
	item_state = null
	ammo_type = list(/obj/item/ammo_casing/energy/disabler)
	ammo_x_offset = 2
	can_flashlight = TRUE
	flight_x_offset = 15
	flight_y_offset = 10

/obj/item/gun/energy/disabler/cyborg
	name = "деактиватор киборга"
	desc = ""
	can_charge = FALSE
	use_cyborg_cell = TRUE
