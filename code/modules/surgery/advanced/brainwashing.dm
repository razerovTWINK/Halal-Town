/obj/item/disk/surgery/brainwashing
	name = "диск с операцией: промывание мозгов"
	desc = ""
	surgeries = list(/datum/surgery/advanced/brainwashing)

/datum/surgery/advanced/brainwashing
	name = "Промывание мозгов"
	desc = ""
	steps = list(
	/datum/surgery_step/incise,
	/datum/surgery_step/retract_skin,
	/datum/surgery_step/saw,
	/datum/surgery_step/clamp_bleeders,
	/datum/surgery_step/brainwash,
	/datum/surgery_step/close)

	target_mobtypes = list(/mob/living/carbon/human)
	possible_locs = list(BODY_ZONE_HEAD)

/datum/surgery/advanced/brainwashing/can_start(mob/user, mob/living/carbon/target)
	if(!..())
		return FALSE
	var/obj/item/organ/brain/B = target.getorganslot(ORGAN_SLOT_BRAIN)
	if(!B)
		return FALSE
	return TRUE

/datum/surgery_step/brainwash
	name = "промыть мозги"
	implements = list(TOOL_HEMOSTAT = 85, TOOL_WIRECUTTER = 50, /obj/item/stack/packageWrap = 35, /obj/item/stack/cable_coil = 15)
	time = 200
	var/objective

/datum/surgery_step/brainwash/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	objective = stripped_input(user, "Выбери цель, которую нужно запечатлеть в мозгу жертвы.", "Промывание мозгов", null, MAX_MESSAGE_LEN)
	if(!objective)
		return -1
	display_results(user, target, "<span class='notice'>Ты начинаешь промывать мозги [target]...</span>",
		"<span class='notice'>[user] начинает вправлять мозг [target].</span>",
		"<span class='notice'>[user] начинает оперировать мозг [target].</span>")

/datum/surgery_step/brainwash/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(!target.mind)
		to_chat(user, "<span class='warning'>[target] не поддаётся промыванию мозгов, словно у [target.p_them()] нет разума...</span>")
		return FALSE
	if(HAS_TRAIT(target, TRAIT_MINDSHIELD))
		to_chat(user, "<span class='warning'>Слышно слабое жужжание устройства в мозгу [target], внушение стирается.</span>")
		return FALSE
	display_results(user, target, "<span class='notice'>Тебе удаётся промыть мозги [target].</span>",
		"<span class='notice'>[user] успешно заканчивает исправление мозга [target]!</span>",
		"<span class='notice'>[user] завершает операцию на мозгу [target].</span>")
	to_chat(target, "<span class='danger'>Новое непреодолимое желание заполняет твой разум... ты чувствуешь, что обязан повиноваться ему!</span>")
	brainwash(target, objective)
	message_admins("[ADMIN_LOOKUPFLW(user)] surgically brainwashed [ADMIN_LOOKUPFLW(target)] with the objective '[objective]'.")
	log_game("[key_name(user)] surgically brainwashed [key_name(target)] with the objective '[objective]'.")
	return TRUE

/datum/surgery_step/brainwash/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(target.getorganslot(ORGAN_SLOT_BRAIN))
		display_results(user, target, "<span class='warning'>Ты ошибаешься, повреждая мозговые ткани!</span>",
			"<span class='warning'>[user] ошибается, повреждая мозг пациента!</span>",
			"<span class='notice'>[user] завершает операцию на мозгу [target].</span>")
		target.adjustOrganLoss(ORGAN_SLOT_BRAIN, 40)
	else
		user.visible_message("<span class='warning'>[user] вдруг замечает, что мозг, над которым шла операция, куда-то пропал.</span>", "<span class='warning'>Ты вдруг замечаешь, что оперируемый мозг куда-то пропал.</span>")
	return FALSE
