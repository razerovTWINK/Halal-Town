/obj/item/gun/syringe
	name = "шприцемет"
	desc = ""
	icon_state = "syringegun"
	item_state = "syringegun"
	w_class = WEIGHT_CLASS_NORMAL
	throw_speed = 1
	throw_range = 7
	force = 4
	custom_materials = list(/datum/material/iron=2000)
	clumsy_check = 0
	fire_sound = 'sound/blank.ogg'
	var/list/syringes = list()
	var/max_syringes = 1

/obj/item/gun/syringe/Initialize()
	. = ..()
	chambered = new /obj/item/ammo_casing/syringegun(src)

/obj/item/gun/syringe/handle_atom_del(atom/A)
	. = ..()
	if(A in syringes)
		syringes.Remove(A)

/obj/item/gun/syringe/recharge_newshot()
	if(!syringes.len)
		return
	chambered.newshot()

/obj/item/gun/syringe/can_shoot()
	return syringes.len

/obj/item/gun/syringe/process_chamber()
	if(chambered && !chambered.BB) //we just fired
		recharge_newshot()

/obj/item/gun/syringe/examine(mob/user)
	. = ..()
	. += "Вместимость: [max_syringes] шприцев. Осталось: [syringes.len]."

/obj/item/gun/syringe/attack_self(mob/living/user)
	if(!syringes.len)
		to_chat(user, "<span class='warning'>[src] пуст!</span>")
		return 0

	var/obj/item/reagent_containers/syringe/S = syringes[syringes.len]

	if(!S)
		return 0
	user.put_in_hands(S)

	syringes.Remove(S)
	to_chat(user, "<span class='notice'>Ты извлекаешь [S] из [src].</span>")

	return 1

/obj/item/gun/syringe/attackby(obj/item/A, mob/user, params, show_msg = TRUE)
	if(istype(A, /obj/item/reagent_containers/syringe))
		if(syringes.len < max_syringes)
			if(!user.transferItemToLoc(A, src))
				return FALSE
			to_chat(user, "<span class='notice'>Ты заряжаешь [A] в [src].</span>")
			syringes += A
			recharge_newshot()
			return TRUE
		else
			to_chat(user, "<span class='warning'>В [src] больше не помещается шприцев!</span>")
	return FALSE

/obj/item/gun/syringe/rapidsyringe
	name = "скорострельный шприцемет"
	desc = ""
	icon_state = "rapidsyringegun"
	max_syringes = 6

/obj/item/gun/syringe/syndicate
	name = "дротикометный пистолет"
	desc = ""
	icon_state = "syringe_pistol"
	item_state = "gun" //Smaller inhand
	w_class = WEIGHT_CLASS_SMALL
	force = 2 //Also very weak because it's smaller
	suppressed = TRUE //Softer fire sound
	can_unsuppress = FALSE //Permanently silenced

/obj/item/gun/syringe/dna
	name = "модифицированный шприцемет"
	desc = ""

/obj/item/gun/syringe/dna/Initialize()
	. = ..()
	chambered = new /obj/item/ammo_casing/dnainjector(src)

/obj/item/gun/syringe/dna/attackby(obj/item/A, mob/user, params, show_msg = TRUE)
	if(istype(A, /obj/item/dnainjector))
		var/obj/item/dnainjector/D = A
		if(D.used)
			to_chat(user, "<span class='warning'>Этот инжектор уже израсходован!</span>")
			return
		if(syringes.len < max_syringes)
			if(!user.transferItemToLoc(D, src))
				return FALSE
			to_chat(user, "<span class='notice'>Ты заряжаешь [D] в [src].</span>")
			syringes += D
			recharge_newshot()
			return TRUE
		else
			to_chat(user, "<span class='warning'>В [src] больше не помещается шприцев!</span>")
	return FALSE

/obj/item/gun/syringe/blowgun
	name = "духовая трубка"
	desc = ""
	icon_state = "blowgun"
	item_state = "blowgun"
	fire_sound = 'sound/blank.ogg'

/obj/item/gun/syringe/blowgun/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
	visible_message("<span class='danger'>[user] начинает целиться из духовой трубки!</span>")
	if(do_after(user, 25, target = src))
		user.adjustStaminaLoss(20)
		user.adjustOxyLoss(20)
		..()
