/datum/surgery/organ_manipulation
	name = "извлечение органов"
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	possible_locs = list(BODY_ZONE_CHEST, BODY_ZONE_HEAD)
	requires_real_bodypart = 1
	steps = list(
		/datum/surgery_step/incise,
		/datum/surgery_step/retract_skin,
		/datum/surgery_step/saw,
		/datum/surgery_step/clamp_bleeders,
		/datum/surgery_step/incise,
		/datum/surgery_step/manipulate_organs,
		//there should be bone fixing
		/datum/surgery_step/close
		)

/datum/surgery/organ_manipulation/soft
	possible_locs = list(BODY_ZONE_PRECISE_GROIN, BODY_ZONE_PRECISE_R_EYE, BODY_ZONE_PRECISE_MOUTH, BODY_ZONE_L_ARM, BODY_ZONE_R_ARM)
	steps = list(
		/datum/surgery_step/incise,
		/datum/surgery_step/retract_skin,
		/datum/surgery_step/clamp_bleeders,
		/datum/surgery_step/incise,
		/datum/surgery_step/manipulate_organs,
		/datum/surgery_step/close
		)

/datum/surgery/organ_manipulation/alien
	name = "извлечение органов ксеноморфа"
	possible_locs = list(BODY_ZONE_CHEST, BODY_ZONE_HEAD, BODY_ZONE_PRECISE_GROIN, BODY_ZONE_PRECISE_R_EYE, BODY_ZONE_PRECISE_MOUTH, BODY_ZONE_L_ARM, BODY_ZONE_R_ARM)
	target_mobtypes = list(/mob/living/carbon/alien/humanoid)
	steps = list(
		/datum/surgery_step/saw,
		/datum/surgery_step/incise,
		/datum/surgery_step/retract_skin,
		/datum/surgery_step/saw,
		/datum/surgery_step/manipulate_organs,
		/datum/surgery_step/close
		)

/datum/surgery/organ_manipulation/mechanic
	name = "манипуляции с органами протеза"
	possible_locs = list(BODY_ZONE_CHEST, BODY_ZONE_HEAD)
	requires_bodypart_type = BODYPART_ROBOTIC
	lying_required = FALSE
	self_operable = TRUE
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/open_hatch,
		/datum/surgery_step/mechanic_unwrench,
		/datum/surgery_step/prepare_electronics,
		/datum/surgery_step/manipulate_organs,
		/datum/surgery_step/mechanic_wrench,
		/datum/surgery_step/mechanic_close
		)

/datum/surgery/organ_manipulation/mechanic/soft
	possible_locs = list(BODY_ZONE_PRECISE_GROIN, BODY_ZONE_PRECISE_R_EYE, BODY_ZONE_PRECISE_MOUTH, BODY_ZONE_L_ARM, BODY_ZONE_R_ARM)
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/open_hatch,
		/datum/surgery_step/prepare_electronics,
		/datum/surgery_step/manipulate_organs,
		/datum/surgery_step/mechanic_close
		)

/datum/surgery_step/manipulate_organs
	time = 64
	name = "манипуляции с органами"
	repeatable = 1
	implements = list(/obj/item/organ = 100, /obj/item/reagent_containers/food/snacks/organ = 0, /obj/item/organ_storage = 100)
	var/implements_extract = list(TOOL_HEMOSTAT = 100, TOOL_CROWBAR = 55)
	var/current_type
	var/obj/item/organ/I = null

/datum/surgery_step/manipulate_organs/New()
	..()
	implements = implements + implements_extract

/datum/surgery_step/manipulate_organs/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	I = null
	if(istype(tool, /obj/item/organ_storage))
		if(!tool.contents.len)
			to_chat(user, "<span class='warning'>В [tool] ничего нет!</span>")
			return -1
		I = tool.contents[1]
		if(!isorgan(I))
			to_chat(user, "<span class='warning'>Нельзя поместить [I] в [parse_zone(target_zone)] [target]!</span>")
			return -1
		tool = I
	if(isorgan(tool))
		current_type = "insert"
		I = tool
		if(target_zone != I.zone || target.getorganslot(I.slot))
			to_chat(user, "<span class='warning'>В [parse_zone(target_zone)] [target] нет места для [I]!</span>")
			return -1

		display_results(user, target, "<span class='notice'>Ты начинаешь помещать [tool] в [parse_zone(target_zone)] [target]...</span>",
			"<span class='notice'>[user] начинает помещать [tool] в [parse_zone(target_zone)] [target].</span>",
			"<span class='notice'>[user] начинает что-то помещать в [parse_zone(target_zone)] [target].</span>")

	else if(implement_type in implements_extract)
		current_type = "extract"
		var/list/organs = target.getorganszone(target_zone)
		if(!organs.len)
			to_chat(user, "<span class='warning'>В [parse_zone(target_zone)] [target] нет органов, которые можно извлечь!</span>")
			return -1
		else
			for(var/obj/item/organ/O in organs)
				O.on_find(user)
				organs -= O
				organs[O.name] = O

			I = input("Какой орган извлечь?", "Хирургия", null, null) as null|anything in sortList(organs)
			if(I && user && target && user.Adjacent(target) && user.get_active_held_item() == tool)
				I = organs[I]
				if(!I)
					return -1
				display_results(user, target, "<span class='notice'>Ты начинаешь извлекать [I] из [parse_zone(target_zone)] [target]...</span>",
					"<span class='notice'>[user] начинает извлекать [I] из [parse_zone(target_zone)] [target].</span>",
					"<span class='notice'>[user] начинает что-то извлекать из [parse_zone(target_zone)] [target].</span>")
			else
				return -1

	else if(istype(tool, /obj/item/reagent_containers/food/snacks/organ))
		to_chat(user, "<span class='warning'>[tool] кто-то погрыз! Этот орган повреждён и не годится для пересадки!</span>")
		return -1

/datum/surgery_step/manipulate_organs/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(current_type == "insert")
		if(istype(tool, /obj/item/organ_storage))
			I = tool.contents[1]
			tool.icon_state = initial(tool.icon_state)
			tool.desc = initial(tool.desc)
			tool.cut_overlays()
			tool = I
		else
			I = tool
		user.temporarilyRemoveItemFromInventory(I, TRUE)
		I.Insert(target)
		display_results(user, target, "<span class='notice'>Ты помещаешь [tool] в [parse_zone(target_zone)] [target].</span>",
			"<span class='notice'>[user] помещает [tool] в [parse_zone(target_zone)] [target]!</span>",
			"<span class='notice'>[user] помещает что-то в [parse_zone(target_zone)] [target]!</span>")

	else if(current_type == "extract")
		if(I && I.owner == target)
			display_results(user, target, "<span class='notice'>Ты успешно извлекаешь [I] из [parse_zone(target_zone)] [target].</span>",
				"<span class='notice'>[user] успешно извлекает [I] из [parse_zone(target_zone)] [target]!</span>",
				"<span class='notice'>[user] успешно извлекает что-то из [parse_zone(target_zone)] [target]!</span>")
			log_combat(user, target, "surgically removed [I.name] from", addition="INTENT: [uppertext(user.a_intent)]")
			I.Remove(target)
			I.forceMove(get_turf(target))
		else
			display_results(user, target, "<span class='warning'>Не получается ничего извлечь из [parse_zone(target_zone)] [target]!</span>",
				"<span class='notice'>[user] не может ничего извлечь из [parse_zone(target_zone)] [target]!</span>",
				"<span class='notice'>[user] не может ничего извлечь из [parse_zone(target_zone)] [target]!</span>")
	return 0
