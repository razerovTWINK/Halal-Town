/datum/surgery/brain_surgery
	name = "операция на мозге"
	steps = list(
	/datum/surgery_step/incise,
	/datum/surgery_step/retract_skin,
	/datum/surgery_step/saw,
	/datum/surgery_step/clamp_bleeders,
	/datum/surgery_step/fix_brain,
	/datum/surgery_step/close)

	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	possible_locs = list(BODY_ZONE_HEAD)
	requires_bodypart_type = 0

/datum/surgery_step/fix_brain
	name = "восстановление мозга"
	implements = list(TOOL_HEMOSTAT = 85, TOOL_SCREWDRIVER = 35, /obj/item/pen = 15) //don't worry, pouring some alcohol on their open brain will get that chance to 100
	time = 120 //long and complicated

/datum/surgery/brain_surgery/can_start(mob/user, mob/living/carbon/target)
	var/obj/item/organ/brain/B = target.getorganslot(ORGAN_SLOT_BRAIN)
	if(!B)
		return FALSE
	return TRUE

/datum/surgery_step/fix_brain/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>Ты начинаешь восстанавливать мозг [target]...</span>",
		"<span class='notice'>[user] начинает восстанавливать мозг [target].</span>",
		"<span class='notice'>[user] проводит операцию на мозге [target].</span>")

/datum/surgery_step/fix_brain/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>Ты успешно восстанавливаешь мозг [target].</span>",
		"<span class='notice'>[user] успешно восстанавливает мозг [target]!</span>",
		"<span class='notice'>[user] завершает операцию на мозге [target].</span>")
	if(target.mind && target.mind.has_antag_datum(/datum/antagonist/brainwashed))
		target.mind.remove_antag_datum(/datum/antagonist/brainwashed)
	target.setOrganLoss(ORGAN_SLOT_BRAIN, target.getOrganLoss(ORGAN_SLOT_BRAIN) - 60)	//we set damage in this case in order to clear the "failing" flag
	target.cure_all_traumas(TRAUMA_RESILIENCE_SURGERY)
	return TRUE

/datum/surgery_step/fix_brain/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(target.getorganslot(ORGAN_SLOT_BRAIN))
		display_results(user, target, "<span class='warning'>Ты совершаешь ошибку, нанося ещё больше повреждений!</span>",
			"<span class='warning'>[user] совершает ошибку, нанося повреждения мозгу!</span>",
			"<span class='notice'>[user] завершает операцию на мозге [target].</span>")
		target.adjustOrganLoss(ORGAN_SLOT_BRAIN, 60)
		target.gain_trauma_type(BRAIN_TRAUMA_SEVERE, TRAUMA_RESILIENCE_LOBOTOMY)
	else
		user.visible_message("<span class='warning'>[user] вдруг замечает, что оперируемого мозга больше нет на месте.</span>", "<span class='warning'>Ты вдруг замечаешь, что оперируемого мозга больше нет на месте.</span>")
	return FALSE
