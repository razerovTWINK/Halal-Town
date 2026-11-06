/obj/item/gun/grenadelauncher
	name = "ручной гранатомет"
	desc = ""
	icon = 'icons/obj/guns/projectile.dmi'
	icon_state = "riotgun"
	item_state = "riotgun"
	w_class = WEIGHT_CLASS_BULKY
	throw_speed = 2
	throw_range = 7
	force = 5
	var/list/grenades = new/list()
	var/max_grenades = 3
	custom_materials = list(/datum/material/iron=2000)

/obj/item/gun/grenadelauncher/examine(mob/user)
	. = ..()
	. += "Заряжено гранат: [grenades.len] / [max_grenades]."

/obj/item/gun/grenadelauncher/attackby(obj/item/I, mob/user, params)

	if((istype(I, /obj/item/grenade)))
		if(grenades.len < max_grenades)
			if(!user.transferItemToLoc(I, src))
				return
			grenades += I
			to_chat(user, "<span class='notice'>Ты заряжаешь гранату в гранатомет.</span>")
			to_chat(user, "<span class='notice'>Гранат: [grenades.len] / [max_grenades].</span>")
		else
			to_chat(usr, "<span class='warning'>В гранатомет больше не помещается гранат!</span>")

/obj/item/gun/grenadelauncher/can_shoot()
	return grenades.len

/obj/item/gun/grenadelauncher/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
	user.visible_message("<span class='danger'>[user] стреляет гранатой!</span>", \
						"<span class='danger'>Ты стреляешь из гранатомета!</span>")
	var/obj/item/grenade/F = grenades[1] //Now with less copypasta!
	grenades -= F
	F.forceMove(user.loc)
	F.throw_at(target, 30, 2, user)
	message_admins("[ADMIN_LOOKUPFLW(user)] fired a grenade ([F.name]) from a grenade launcher ([src]) from [AREACOORD(user)] at [target] [AREACOORD(target)].")
	log_game("[key_name(user)] fired a grenade ([F.name]) with a grenade launcher ([src]) from [AREACOORD(user)] at [target] [AREACOORD(target)].")
	F.active = 1
	F.icon_state = initial(F.icon_state) + "_active"
	playsound(user.loc, 'sound/blank.ogg', 75, TRUE, -3)
	addtimer(CALLBACK(F, /obj/item/grenade.proc/prime), 15)
