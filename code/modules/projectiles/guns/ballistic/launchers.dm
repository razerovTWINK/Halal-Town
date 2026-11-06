//KEEP IN MIND: These are different from gun/grenadelauncher. These are designed to shoot premade rocket and grenade projectiles, not flashbangs or chemistry casings etc.
//Put handheld rocket launchers here if someone ever decides to make something so hilarious ~Paprika

/obj/item/gun/ballistic/revolver/grenadelauncher//this is only used for underbarrel grenade launchers at the moment, but admins can still spawn it if they feel like being assholes
	desc = ""
	name = "гранатомет"
	icon_state = "dshotgun_sawn"
	item_state = "gun"
	mag_type = /obj/item/ammo_box/magazine/internal/grenadelauncher
	fire_sound = 'sound/blank.ogg'
	w_class = WEIGHT_CLASS_NORMAL
	pin = /obj/item/firing_pin/implant/pindicate
	bolt_type = BOLT_TYPE_NO_BOLT

/obj/item/gun/ballistic/revolver/grenadelauncher/unrestricted
	pin = /obj/item/firing_pin

/obj/item/gun/ballistic/revolver/grenadelauncher/attackby(obj/item/A, mob/user, params)
	..()
	if(istype(A, /obj/item/ammo_box) || istype(A, /obj/item/ammo_casing))
		chamber_round()

/obj/item/gun/ballistic/revolver/grenadelauncher/cyborg
	desc = ""
	name = "многозарядный гранатомет"
	icon = 'icons/mecha/mecha_equipment.dmi'
	icon_state = "mecha_grenadelnchr"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/grenademulti
	pin = /obj/item/firing_pin

/obj/item/gun/ballistic/revolver/grenadelauncher/cyborg/attack_self()
	return

/obj/item/gun/ballistic/automatic/gyropistol
	name = "гироджет-пистолет"
	desc = ""
	icon_state = "gyropistol"
	fire_sound = 'sound/blank.ogg'
	mag_type = /obj/item/ammo_box/magazine/m75
	burst_size = 1
	fire_delay = 0
	actions_types = list()
	casing_ejector = FALSE

/obj/item/gun/ballistic/rocketlauncher
	name = "\improper ракетница PML-9"
	desc = ""
	icon_state = "rocketlauncher"
	item_state = "rocketlauncher"
	mag_type = /obj/item/ammo_box/magazine/internal/rocketlauncher
	fire_sound = 'sound/blank.ogg'
	w_class = WEIGHT_CLASS_BULKY
	can_suppress = FALSE
	pin = /obj/item/firing_pin/implant/pindicate
	burst_size = 1
	fire_delay = 0
	casing_ejector = FALSE
	weapon_weight = WEAPON_HEAVY
	bolt_type = BOLT_TYPE_NO_BOLT
	internal_magazine = TRUE
	cartridge_wording = "rocket"
	empty_indicator = TRUE
	tac_reloads = FALSE

/obj/item/gun/ballistic/rocketlauncher/unrestricted
	pin = /obj/item/firing_pin

/obj/item/gun/ballistic/rocketlauncher/afterattack()
	. = ..()
	magazine.get_round(FALSE) //Hack to clear the mag after it's fired

/obj/item/gun/ballistic/rocketlauncher/attack_self_tk(mob/user)
	return //too difficult to remove the rocket with TK

/obj/item/gun/ballistic/rocketlauncher/suicide_act(mob/living/user)
	user.visible_message("<span class='warning'>[user] направляет [src] в землю! Кажется, [user.p_theyre()] собирается сделать крутой рокет-джамп!</span>", \
		"<span class='danger'>Ты направляешь [src] в землю, чтобы совершить сумасшедший рокет-джамп...</span>")
	if(can_shoot())
		user.notransform = TRUE
		playsound(src, 'sound/blank.ogg', 80, TRUE, 5)
		animate(user, pixel_z = 300, time = 30, easing = LINEAR_EASING)
		sleep(70)
		animate(user, pixel_z = 0, time = 5, easing = LINEAR_EASING)
		sleep(5)
		user.notransform = FALSE
		process_fire(user, user, TRUE)
		if(!QDELETED(user)) //if they weren't gibbed by the explosion, take care of them for good.
			user.gib()
		return MANUAL_SUICIDE
	else
		sleep(5)
		shoot_with_empty_chamber(user)
		sleep(20)
		user.visible_message("<span class='warning'>[user] оглядывает комнату и понимает, что [user.p_theyre()] всё ещё здесь. [user.p_they(TRUE)] заталкивает [src] себе в глотку и задыхается!</span>", \
			"<span class='danger'>Ты оглядываешься и понимаешь, что всё ещё здесь, а затем насмерть давишься [src]!</span>")
		sleep(20)
		return OXYLOSS





