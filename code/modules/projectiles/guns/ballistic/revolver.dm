/obj/item/gun/ballistic/revolver
	name = "\improper револьвер .357"
	desc = "" //usually used by syndicates
	icon_state = "revolver"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder
	fire_sound = 'sound/blank.ogg'
	load_sound = 'sound/blank.ogg'
	eject_sound = 'sound/blank.ogg'
	vary_fire_sound = FALSE
	fire_sound_volume = 90
	dry_fire_sound = 'sound/blank.ogg'
	casing_ejector = FALSE
	internal_magazine = TRUE
	bolt_type = BOLT_TYPE_NO_BOLT
	tac_reloads = FALSE
	var/spin_delay = 10
	var/recent_spin = 0

/obj/item/gun/ballistic/revolver/chamber_round(spin_cylinder = TRUE)
	if(spin_cylinder)
		chambered = magazine.get_round(TRUE)
	else
		chambered = magazine.stored_ammo[1]

/obj/item/gun/ballistic/revolver/shoot_with_empty_chamber(mob/living/user as mob|obj)
	..()
	chamber_round(TRUE)

/obj/item/gun/ballistic/revolver/AltClick(mob/user)
	..()
	spin()

/obj/item/gun/ballistic/revolver/verb/spin()
	set name = "Прокрутить барабан"
	set hidden = 1
	set desc = ""

	var/mob/M = usr

	if(M.stat || !in_range(M,src))
		return

	if (recent_spin > world.time)
		return
	recent_spin = world.time + spin_delay

	if(do_spin())
		playsound(usr, "revolver_spin", 30, FALSE)
		usr.visible_message("<span class='notice'>[usr] прокручивает барабан [src].</span>", "<span class='notice'>Ты прокручиваешь барабан [src].</span>")
	else
		verbs -= /obj/item/gun/ballistic/revolver/verb/spin

/obj/item/gun/ballistic/revolver/proc/do_spin()
	var/obj/item/ammo_box/magazine/internal/cylinder/C = magazine
	. = istype(C)
	if(.)
		C.spin()
		chamber_round(FALSE)

/obj/item/gun/ballistic/revolver/get_ammo(countchambered = FALSE, countempties = TRUE)
	var/boolets = 0 //mature var names for mature people
	if (chambered && countchambered)
		boolets++
	if (magazine)
		boolets += magazine.ammo_count(countempties)
	return boolets

/obj/item/gun/ballistic/revolver/examine(mob/user)
	. = ..()
//	var/live_ammo = get_ammo(FALSE, FALSE)
//	. += "[live_ammo ? live_ammo : "None"] of those are live rounds."
//	if (current_skin)
//		. += "It can be spun with <b>alt+click</b>"

/obj/item/gun/ballistic/revolver/detective
	name = "\improper револьвер Colt Detective Special"
	desc = ""
	fire_sound = 'sound/blank.ogg'
	icon_state = "detective"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/rev38
	obj_flags = UNIQUE_RENAME
	unique_reskin = list("Default" = "detective",
						"Fitz Special" = "detective_fitz",
						"Police Positive Special" = "detective_police",
						"Blued Steel" = "detective_blued",
						"Stainless Steel" = "detective_stainless",
						"Gold Trim" = "detective_gold",
						"Leopard Spots" = "detective_leopard",
						"The Peacemaker" = "detective_peacemaker",
						"Black Panther" = "detective_panther"
						)

/obj/item/gun/ballistic/revolver/detective/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
	if(magazine.caliber != initial(magazine.caliber))
		if(prob(70 - (magazine.ammo_count() * 10)))	//minimum probability of 10, maximum of 60
			playsound(user, fire_sound, fire_sound_volume, vary_fire_sound)
			to_chat(user, "<span class='danger'>[src] взрывается прямо у тебя в руках!</span>")
			user.take_bodypart_damage(0,20)
			user.dropItemToGround(src)
			return 0
	..()

/obj/item/gun/ballistic/revolver/detective/screwdriver_act(mob/living/user, obj/item/I)
	if(..())
		return TRUE
	if(magazine.caliber == "38")
		to_chat(user, "<span class='notice'>Ты начинаешь укреплять ствол [src]...</span>")
		if(magazine.ammo_count())
			afterattack(user, user)	//you know the drill
			user.visible_message("<span class='danger'>[src] выстреливает!</span>", "<span class='danger'>[src] выстреливает тебе прямо в лицо!</span>")
			return TRUE
		if(I.use_tool(src, user, 30))
			if(magazine.ammo_count())
				to_chat(user, "<span class='warning'>Ты не можешь это модифицировать!</span>")
				return TRUE
			magazine.caliber = "357"
			fire_sound = 'sound/blank.ogg'
			desc = ""
			to_chat(user, "<span class='notice'>Ты укрепляешь ствол [src]. Теперь он стреляет патронами .357.</span>")
	else
		to_chat(user, "<span class='notice'>Ты начинаешь снимать модификации с [src]...</span>")
		if(magazine.ammo_count())
			afterattack(user, user)	//and again
			user.visible_message("<span class='danger'>[src] выстреливает!</span>", "<span class='danger'>[src] выстреливает тебе прямо в лицо!</span>")
			return TRUE
		if(I.use_tool(src, user, 30))
			if(magazine.ammo_count())
				to_chat(user, "<span class='warning'>Ты не можешь это модифицировать!</span>")
				return
			magazine.caliber = "38"
			fire_sound = 'sound/blank.ogg'
			desc = initial(desc)
			to_chat(user, "<span class='notice'>Ты снимаешь модификации с [src]. Теперь он стреляет патронами .38.</span>")
	return TRUE


/obj/item/gun/ballistic/revolver/mateba
	name = "\improper автоматический револьвер Unica 6"
	desc = ""
	icon_state = "mateba"

/obj/item/gun/ballistic/revolver/golden
	name = "\improper золотой револьвер"
	desc = ""
	icon_state = "goldrevolver"
	fire_sound = 'sound/blank.ogg'
	recoil = 8
	pin = /obj/item/firing_pin

/obj/item/gun/ballistic/revolver/nagant
	name = "\improper револьвер Наган"
	desc = ""
	icon_state = "nagant"
	can_suppress = TRUE

	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/rev762


// A gun to play Russian Roulette!
// You can spin the chamber to randomize the position of the bullet.

/obj/item/gun/ballistic/revolver/russian
	name = "\improper гусарский револьвер"
	desc = ""
	icon_state = "russianrevolver"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/rus357
	var/spun = FALSE

/obj/item/gun/ballistic/revolver/russian/do_spin()
	. = ..()
	if(.)
		spun = TRUE

/obj/item/gun/ballistic/revolver/russian/attackby(obj/item/A, mob/user, params)
	..()
	if(get_ammo() > 0)
		spin()
	update_icon()
	A.update_icon()
	return

/obj/item/gun/ballistic/revolver/russian/attack_self(mob/user)
	if(!spun)
		spin()
		spun = TRUE
		return
	..()

/obj/item/gun/ballistic/revolver/russian/afterattack(atom/target, mob/living/user, flag, params)
	. = ..(null, user, flag, params)

	if(flag)
		if(!(target in user.contents) && ismob(target))
			if(user.used_intent.type == INTENT_HARM) // Flogging action
				return

	if(isliving(user))
		if(!can_trigger_gun(user))
			return
	if(target != user)
		if(ismob(target))
			to_chat(user, "<span class='warning'>Механизм не позволяет выстрелить ни в кого, кроме себя!</span>")
		return

	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(!spun)
			to_chat(user, "<span class='warning'>Сначала нужно прокрутить барабан [src]!</span>")
			return

		spun = FALSE

		if(chambered)
			var/obj/item/ammo_casing/AC = chambered
			if(AC.fire_casing(user, user))
				playsound(user, fire_sound, fire_sound_volume, vary_fire_sound)
				var/zone = check_zone(user.zone_selected)
				var/obj/item/bodypart/affecting = H.get_bodypart(zone)
				if(zone == BODY_ZONE_HEAD || zone == BODY_ZONE_PRECISE_R_EYE || zone == BODY_ZONE_PRECISE_MOUTH)
					shoot_self(user, affecting)
				else
					user.visible_message("<span class='danger'>[user.name] трусливо стреляет из [src] себе в [affecting.name]!</span>", "<span class='danger'>Ты трусливо стреляешь из [src] себе в [affecting.name]!</span>", "<span class='hear'>Слышен выстрел!</span>")
				chambered = null
				return

		user.visible_message("<span class='danger'>*щелк*</span>")
		playsound(src, dry_fire_sound, 30, TRUE)

/obj/item/gun/ballistic/revolver/russian/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
	add_fingerprint(user)
	playsound(src, dry_fire_sound, 30, TRUE)
	user.visible_message("<span class='danger'>[user.name] пытается выстрелить из [src], но лишь выставляет себя глупцом.</span>", "<span class='danger'>Защитный механизм [src] блокирует одновременный выстрел!</span>")

/obj/item/gun/ballistic/revolver/russian/proc/shoot_self(mob/living/carbon/human/user, affecting = BODY_ZONE_HEAD)
	user.apply_damage(300, BRUTE, affecting)
	user.visible_message("<span class='danger'>[user.name] стреляет из [src] себе в голову!</span>", "<span class='danger'>Ты стреляешь из [src] себе в голову!</span>", "<span class='hear'>Слышен выстрел!</span>")

/obj/item/gun/ballistic/revolver/russian/soul
	name = "проклятый русский револьвер"
	desc = ""

/obj/item/gun/ballistic/revolver/russian/soul/shoot_self(mob/living/user)
	..()
	var/obj/item/soulstone/anybody/revolver/SS = new /obj/item/soulstone/anybody/revolver(get_turf(src))
	if(!SS.transfer_soul("FORCE", user)) //Something went wrong
		qdel(SS)
		return
	user.visible_message("<span class='danger'>Душа [user.name] поглощена [src]!</span>", "<span class='danger'>Ты проиграл эту ставку! Твоя душа потеряна!</span>")

/obj/item/gun/ballistic/revolver/reverse //Fires directly at its user... unless the user is a clown, of course.
	clumsy_check = 0

/obj/item/gun/ballistic/revolver/reverse/can_trigger_gun(mob/living/user)
	if((HAS_TRAIT(user, TRAIT_CLUMSY)) || (user.mind && user.mind.assigned_role == "Clown"))
		return ..()
	if(process_fire(user, user, FALSE, null, BODY_ZONE_HEAD))
		user.visible_message("<span class='warning'>[user] умудряется выстрелить себе в лицо!</span>", "<span class='danger'>Ты умудряешься выстрелить себе прямо в лицо! Как такое вообще возможно?!</span>")
		user.emote("scream")
		user.drop_all_held_items()
		user.Paralyze(80)
