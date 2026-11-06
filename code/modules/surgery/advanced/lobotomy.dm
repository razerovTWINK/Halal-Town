/datum/surgery/advanced/lobotomy
	name = "Лоботомия"
	desc = ""
	steps = list(
	/datum/surgery_step/incise,
	/datum/surgery_step/retract_skin,
	/datum/surgery_step/saw,
	/datum/surgery_step/clamp_bleeders,
	/datum/surgery_step/lobotomize,
	/datum/surgery_step/close)

	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	possible_locs = list(BODY_ZONE_HEAD)
	requires_bodypart_type = 0

/datum/surgery/advanced/lobotomy/can_start(mob/user, mob/living/carbon/target)
	if(!..())
		return FALSE
	var/obj/item/organ/brain/B = target.getorganslot(ORGAN_SLOT_BRAIN)
	if(!B)
		return FALSE
	return TRUE

/datum/surgery_step/lobotomize
	name = "провести лоботомию"
	implements = list(TOOL_SCALPEL = 85, /obj/item/melee/transforming/energy/sword = 55, /obj/item/kitchen/knife = 35,
		/obj/item/shard = 25, /obj/item = 20)
	time = 100

/datum/surgery_step/lobotomize/tool_check(mob/user, obj/item/tool)
	if(implement_type == /obj/item && !tool.get_sharpness())
		return FALSE
	return TRUE

/datum/surgery_step/lobotomize/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>Ты начинаешь проводить лоботомию мозга [target]...</span>",
		"<span class='notice'>[user] начинает проводить лоботомию мозга [target].</span>",
		"<span class='notice'>[user] начинает оперировать мозг [target].</span>")

/datum/surgery_step/lobotomize/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>Тебе удаётся провести лоботомию [target].</span>",
			"<span class='notice'>[user] успешно проводит лоботомию [target]!</span>",
			"<span class='notice'>[user] завершает операцию на мозгу [target].</span>")
	target.cure_all_traumas(TRAUMA_RESILIENCE_LOBOTOMY)
	if(target.mind && target.mind.has_antag_datum(/datum/antagonist/brainwashed))
		target.mind.remove_antag_datum(/datum/antagonist/brainwashed)
	switch(rand(1,4))//Now let's see what hopefully-not-important part of the brain we cut off
		if(1)
			target.gain_trauma_type(BRAIN_TRAUMA_MILD, TRAUMA_RESILIENCE_MAGIC)
		if(2)
			target.gain_trauma_type(BRAIN_TRAUMA_SEVERE, TRAUMA_RESILIENCE_MAGIC)
		if(3)
			target.gain_trauma_type(BRAIN_TRAUMA_SPECIAL, TRAUMA_RESILIENCE_MAGIC)
	return TRUE

/datum/surgery_step/lobotomize/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	var/obj/item/organ/brain/B = target.getorganslot(ORGAN_SLOT_BRAIN)
	if(B)
		display_results(user, target, "<span class='warning'>Ты удаляешь не ту часть, нанося ещё больше повреждений!</span>",
			"<span class='notice'>[user] успешно проводит лоботомию [target]!</span>",
			"<span class='notice'>[user] завершает операцию на мозгу [target].</span>")
		B.applyOrganDamage(80)
		switch(rand(1,3))
			if(1)
				target.gain_trauma_type(BRAIN_TRAUMA_MILD, TRAUMA_RESILIENCE_MAGIC)
			if(2)
				target.gain_trauma_type(BRAIN_TRAUMA_SEVERE, TRAUMA_RESILIENCE_MAGIC)
			if(3)
				target.gain_trauma_type(BRAIN_TRAUMA_SPECIAL, TRAUMA_RESILIENCE_MAGIC)
	else
		user.visible_message("<span class='warning'>[user] вдруг замечает, что мозг, над которым шла операция, куда-то пропал.</span>", "<span class='warning'>Ты вдруг замечаешь, что оперируемый мозг куда-то пропал.</span>")
	return FALSE
