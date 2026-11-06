/datum/surgery/implant_removal
	name = "извлечение импланта"
	steps = list(/datum/surgery_step/incise, /datum/surgery_step/clamp_bleeders, /datum/surgery_step/retract_skin, /datum/surgery_step/extract_implant, /datum/surgery_step/close)
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	possible_locs = list(BODY_ZONE_CHEST)


//extract implant
/datum/surgery_step/extract_implant
	name = "извлечь имплант"
	implements = list(TOOL_HEMOSTAT = 100, TOOL_CROWBAR = 65)
	time = 64
	var/obj/item/implant/I = null

/datum/surgery_step/extract_implant/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	for(var/obj/item/O in target.implants)
		I = O
		break
	if(I)
		display_results(user, target, "<span class='notice'>Ты начинаешь извлекать [I] из [target_zone] [target]...</span>",
			"<span class='notice'>[user] начинает извлекать [I] из [target_zone] [target].</span>",
			"<span class='notice'>[user] начинает что-то извлекать из [target_zone] [target].</span>")
	else
		display_results(user, target, "<span class='notice'>Ты ищешь имплант в [target_zone] [target]...</span>",
			"<span class='notice'>[user] ищет имплант в [target_zone] [target].</span>",
			"<span class='notice'>[user] ищет что-то в [target_zone] [target].</span>")

/datum/surgery_step/extract_implant/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(I)
		display_results(user, target, "<span class='notice'>Ты успешно извлекаешь [I] из [target_zone] [target].</span>",
			"<span class='notice'>[user] успешно извлекает [I] из [target_zone] [target]!</span>",
			"<span class='notice'>[user] успешно извлекает что-то из [target_zone] [target]!</span>")
		I.removed(target)

		var/obj/item/implantcase/case
		for(var/obj/item/implantcase/ic in user.held_items)
			case = ic
			break
		if(!case)
			case = locate(/obj/item/implantcase) in get_turf(target)
		if(case && !case.imp)
			case.imp = I
			I.forceMove(case)
			case.update_icon()
			display_results(user, target, "<span class='notice'>Ты помещаешь [I] в [case].</span>",
				"<span class='notice'>[user] помещает [I] в [case]!</span>",
				"<span class='notice'>[user] помещает это в [case]!</span>")
		else
			qdel(I)

	else
		to_chat(user, "<span class='warning'>Не удаётся ничего найти в [target_zone] [target]!</span>")
	return 1

/datum/surgery/implant_removal/mechanic
	name = "извлечение импланта"
	requires_bodypart_type = BODYPART_ROBOTIC
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/open_hatch,
		/datum/surgery_step/mechanic_unwrench,
		/datum/surgery_step/extract_implant,
		/datum/surgery_step/mechanic_wrench,
		/datum/surgery_step/mechanic_close)
