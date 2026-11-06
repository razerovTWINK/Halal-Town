/obj/item/gun/energy/e_gun
	name = "энергетический пистолет"
	desc = ""
	icon_state = "energy"
	item_state = null	//so the human update icon uses the icon_state instead.
	ammo_type = list(/obj/item/ammo_casing/energy/disabler, /obj/item/ammo_casing/energy/laser)
	modifystate = 1
	can_flashlight = TRUE
	ammo_x_offset = 3
	flight_x_offset = 15
	flight_y_offset = 10
	dual_wield_spread = 60

/obj/item/gun/energy/e_gun/mini
	name = "миниатюрный энергопистолет"
	desc = ""
	icon_state = "mini"
	item_state = "gun"
	w_class = WEIGHT_CLASS_SMALL
	cell_type = /obj/item/stock_parts/cell{charge = 600; maxcharge = 600}
	ammo_x_offset = 2
	charge_sections = 3
	can_flashlight = FALSE // Can't attach or detach the flashlight, and override it's icon update
	gunlight_state = "mini-light"
	flight_x_offset = 19
	flight_y_offset = 13

/obj/item/gun/energy/e_gun/mini/Initialize()
	gun_light = new /obj/item/flashlight/seclite(src)
	return ..()

/obj/item/gun/energy/e_gun/stun
	name = "тактический энергопистолет"
	desc = ""
	icon_state = "energytac"
	ammo_x_offset = 2
	ammo_type = list(/obj/item/ammo_casing/energy/electrode/spec, /obj/item/ammo_casing/energy/disabler, /obj/item/ammo_casing/energy/laser)

/obj/item/gun/energy/e_gun/old
	name = "прототип энергопистолета"
	desc = ""
	icon_state = "protolaser"
	ammo_x_offset = 2
	ammo_type = list(/obj/item/ammo_casing/energy/laser, /obj/item/ammo_casing/energy/electrode/old)

/obj/item/gun/energy/e_gun/mini/practice_phaser
	name = "тренировочный фазер"
	desc = ""
	ammo_type = list(/obj/item/ammo_casing/energy/disabler, /obj/item/ammo_casing/energy/laser/practice)
	icon_state = "decloner"

/obj/item/gun/energy/e_gun/hos
	name = "\improper многофазный энергопистолет X-01"
	desc = ""
	cell_type = /obj/item/stock_parts/cell{charge = 1200; maxcharge = 1200}
	icon_state = "hoslaser"
	force = 10
	ammo_type = list(/obj/item/ammo_casing/energy/disabler/hos, /obj/item/ammo_casing/energy/laser/hos, /obj/item/ammo_casing/energy/ion/hos)
	ammo_x_offset = 4
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

/obj/item/gun/energy/e_gun/dragnet
	name = "\improper энергосеть DRAGnet"
	desc = ""
	icon_state = "dragnet"
	item_state = "dragnet"
	lefthand_file = 'icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/guns_righthand.dmi'
	ammo_type = list(/obj/item/ammo_casing/energy/net, /obj/item/ammo_casing/energy/trap)
	can_flashlight = FALSE
	ammo_x_offset = 1

/obj/item/gun/energy/e_gun/dragnet/snare
	name = "метатель энергокапканов"
	desc = ""
	ammo_type = list(/obj/item/ammo_casing/energy/trap)

/obj/item/gun/energy/e_gun/turret
	name = "гибридное турельное орудие"
	desc = ""
	icon_state = "turretlaser"
	item_state = "turretlaser"
	slot_flags = null
	w_class = WEIGHT_CLASS_HUGE
	ammo_type = list(/obj/item/ammo_casing/energy/electrode, /obj/item/ammo_casing/energy/laser)
	weapon_weight = WEAPON_HEAVY
	can_flashlight = FALSE
	trigger_guard = TRIGGER_GUARD_NONE
	ammo_x_offset = 2

/obj/item/gun/energy/e_gun/nuclear
	name = "улучшенный энергопистолет"
	desc = ""
	icon_state = "nucgun"
	item_state = "nucgun"
	charge_delay = 5
	pin = null
	can_charge = FALSE
	ammo_x_offset = 1
	ammo_type = list(/obj/item/ammo_casing/energy/laser, /obj/item/ammo_casing/energy/disabler)
	selfcharge = 1
	var/reactor_overloaded
	var/fail_tick = 0
	var/fail_chance = 0

/obj/item/gun/energy/e_gun/nuclear/process()
	if(fail_tick > 0)
		fail_tick--
	..()

/obj/item/gun/energy/e_gun/nuclear/shoot_live_shot()
	failcheck()
	update_icon()
	..()

/obj/item/gun/energy/e_gun/nuclear/proc/failcheck()
	if(prob(fail_chance) && isliving(loc))
		var/mob/living/M = loc
		switch(fail_tick)
			if(0 to 200)
				fail_tick += (2*(fail_chance))
				M.rad_act(40)
				to_chat(M, "<span class='danger'>[name] нагревается.</span>")
			if(201 to INFINITY)
				SSobj.processing.Remove(src)
				M.rad_act(80)
				reactor_overloaded = TRUE
				to_chat(M, "<span class='danger'>Реактор [name] перегружен!</span>")

/obj/item/gun/energy/e_gun/nuclear/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	fail_chance = min(fail_chance + round(15/severity), 100)

/obj/item/gun/energy/e_gun/nuclear/update_icon()
	..()
	if(reactor_overloaded)
		add_overlay("[icon_state]_fail_3")
	else
		switch(fail_tick)
			if(0)
				add_overlay("[icon_state]_fail_0")
			if(1 to 150)
				add_overlay("[icon_state]_fail_1")
			if(151 to INFINITY)
				add_overlay("[icon_state]_fail_2")
