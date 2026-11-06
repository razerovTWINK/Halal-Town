/datum/surgery/core_removal
	name = "извлечение ядра"
	steps = list(/datum/surgery_step/incise, /datum/surgery_step/extract_core)
	target_mobtypes = list(/mob/living/simple_animal/slime)
	possible_locs = list(BODY_ZONE_R_ARM,BODY_ZONE_L_ARM,BODY_ZONE_R_LEG,BODY_ZONE_L_LEG,BODY_ZONE_CHEST,BODY_ZONE_HEAD)
	lying_required = FALSE
	ignore_clothes = TRUE

/datum/surgery/core_removal/can_start(mob/user, mob/living/target)
	if(target.stat == DEAD)
		return 1
	return 0

//extract brain
/datum/surgery_step/extract_core
	name = "извлечь ядро"
	implements = list(TOOL_HEMOSTAT = 100, TOOL_CROWBAR = 100)
	time = 16

/datum/surgery_step/extract_core/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>Ты начинаешь извлекать ядро из [target]...</span>",
		"<span class='notice'>[user] начинает извлекать ядро из [target].</span>",
		"<span class='notice'>[user] начинает извлекать ядро из [target].</span>")

/datum/surgery_step/extract_core/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	var/mob/living/simple_animal/slime/slime = target
	if(slime.cores > 0)
		slime.cores--
		display_results(user, target, "<span class='notice'>Ты успешно извлекаешь ядро из [target]. Осталось ядер: [slime.cores].</span>",
			"<span class='notice'>[user] успешно извлекает ядро из [target]!</span>",
			"<span class='notice'>[user] успешно извлекает ядро из [target]!</span>")

		new slime.coretype(slime.loc)

		if(slime.cores <= 0)
			slime.icon_state = "[slime.colour] baby slime dead-nocore"
			return 1
		else
			return 0
	else
		to_chat(user, "<span class='warning'>В [target] больше не осталось ядер!</span>")
		return 1
