/datum/surgery/embedded_removal
	name = "извлечение застрявших предметов"
	steps = list(/datum/surgery_step/incise, /datum/surgery_step/remove_object)
	possible_locs = list(BODY_ZONE_R_ARM,BODY_ZONE_L_ARM,BODY_ZONE_R_LEG,BODY_ZONE_L_LEG,BODY_ZONE_CHEST,BODY_ZONE_HEAD)


/datum/surgery_step/remove_object
	name = "извлечь застрявшие предметы"
	time = 32
	accept_hand = 1
	var/obj/item/bodypart/L = null


/datum/surgery_step/remove_object/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	L = surgery.operated_bodypart
	if(L)
		user.visible_message("<span class='notice'>[user] ищет застрявшие предметы в [parse_zone(user.zone_selected)] [target].</span>", "<span class='notice'>Ты ищешь застрявшие предметы в [parse_zone(user.zone_selected)] [target]...</span>")
		display_results(user, target, "<span class='notice'>Ты ищешь застрявшие предметы в [parse_zone(user.zone_selected)] [target]...</span>",
			"<span class='notice'>[user] ищет застрявшие предметы в [parse_zone(user.zone_selected)] [target].</span>",
			"<span class='notice'>[user] ищет что-то в [parse_zone(user.zone_selected)] [target].</span>")
	else
		user.visible_message("<span class='notice'>[user] осматривает [parse_zone(user.zone_selected)] [target].</span>", "<span class='notice'>Ты осматриваешь [parse_zone(user.zone_selected)] [target]...</span>")


/datum/surgery_step/remove_object/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(L)
		if(ishuman(target))
			var/mob/living/carbon/human/H = target
			var/objects = 0
			for(var/obj/item/I in L.embedded_objects)
				objects++
				I.forceMove(get_turf(H))
				L.embedded_objects -= I
			if(!H.has_embedded_objects())
				H.clear_alert("embeddedobject")
				SEND_SIGNAL(H, COMSIG_CLEAR_MOOD_EVENT, "embedded")

			if(objects > 0)
				display_results(user, target, "<span class='notice'>Ты успешно извлекаешь застрявшие предметы ([objects] шт.) из [L.name] [H].</span>",
					"<span class='notice'>[user] успешно извлекает застрявшие предметы ([objects] шт.) из [L] [H]!</span>",
					"<span class='notice'>[user] успешно извлекает застрявшие предметы ([objects] шт.) из [L] [H]!</span>")
			else
				to_chat(user, "<span class='warning'>В [L] [H] не найдено застрявших предметов!</span>")

	else
		to_chat(user, "<span class='warning'>Не удаётся найти [parse_zone(user.zone_selected)] [target], не говоря уже о застрявших предметах!</span>")

	return 1
