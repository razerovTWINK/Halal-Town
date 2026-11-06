/datum/surgery/advanced/pacify
	name = "Усмирение"
	desc = ""
	steps = list(/datum/surgery_step/incise,
				/datum/surgery_step/retract_skin,
				/datum/surgery_step/saw,
				/datum/surgery_step/clamp_bleeders,
				/datum/surgery_step/pacify,
				/datum/surgery_step/close)

	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	possible_locs = list(BODY_ZONE_HEAD)
	requires_bodypart_type = 0

/datum/surgery/advanced/pacify/can_start(mob/user, mob/living/carbon/target)
	. = ..()
	var/obj/item/organ/brain/B = target.getorganslot(ORGAN_SLOT_BRAIN)
	if(!B)
		return FALSE

/datum/surgery_step/pacify
	name = "перестроить нейронные пути"
	implements = list(TOOL_HEMOSTAT = 100, TOOL_SCREWDRIVER = 35, /obj/item/pen = 15)
	time = 40

/datum/surgery_step/pacify/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>Ты начинаешь усмирение [target]...</span>",
		"<span class='notice'>[user] начинает вправлять мозг [target].</span>",
		"<span class='notice'>[user] начинает оперировать мозг [target].</span>")

/datum/surgery_step/pacify/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>Тебе удаётся неврологически усмирить [target].</span>",
		"<span class='notice'>[user] успешно заканчивает исправление мозга [target]!</span>",
		"<span class='notice'>[user] завершает операцию на мозгу [target].</span>")
	target.gain_trauma(/datum/brain_trauma/severe/pacifism, TRAUMA_RESILIENCE_LOBOTOMY)
	return TRUE

/datum/surgery_step/pacify/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='warning'>Ты ошибаешься, соединив нейроны [target] задом наперёд...</span>",
			"<span class='warning'>[user] ошибается, повреждая мозг пациента!</span>",
			"<span class='notice'>[user] завершает операцию на мозгу [target].</span>")
	target.gain_trauma_type(BRAIN_TRAUMA_SEVERE, TRAUMA_RESILIENCE_LOBOTOMY)
	return FALSE
