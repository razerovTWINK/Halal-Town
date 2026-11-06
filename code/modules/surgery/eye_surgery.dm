/datum/surgery/eye_surgery
	name = "операция на глазах"
	steps = list(/datum/surgery_step/incise, /datum/surgery_step/retract_skin, /datum/surgery_step/clamp_bleeders, /datum/surgery_step/fix_eyes, /datum/surgery_step/close)
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	possible_locs = list(BODY_ZONE_PRECISE_R_EYE)
	requires_bodypart_type = 0

//fix eyes
/datum/surgery_step/fix_eyes
	name = "восстановление глаз"
	implements = list(TOOL_HEMOSTAT = 100, TOOL_SCREWDRIVER = 45, /obj/item/pen = 25)
	time = 64

/datum/surgery/eye_surgery/can_start(mob/user, mob/living/carbon/target)
	var/obj/item/organ/eyes/E = target.getorganslot(ORGAN_SLOT_EYES)
	if(!E)
		to_chat(user, "<span class='warning'>Трудно оперировать глаза, когда у пациента их нет.</span>")
		return FALSE
	return TRUE

/datum/surgery_step/fix_eyes/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>Ты начинаешь восстанавливать глаза [target]...</span>",
		"<span class='notice'>[user] начинает восстанавливать глаза [target].</span>",
		"<span class='notice'>[user] проводит операцию на глазах [target].</span>")

/datum/surgery_step/fix_eyes/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	var/obj/item/organ/eyes/E = target.getorganslot(ORGAN_SLOT_EYES)
	user.visible_message("<span class='notice'>[user] успешно восстанавливает глаза [target]!</span>", "<span class='notice'>Ты успешно восстанавливаешь глаза [target].</span>")
	display_results(user, target, "<span class='notice'>Ты успешно восстанавливаешь глаза [target].</span>",
		"<span class='notice'>[user] успешно восстанавливает глаза [target]!</span>",
		"<span class='notice'>[user] завершает операцию на глазах [target].</span>")
	target.cure_blind(list(EYE_DAMAGE))
	target.set_blindness(0)
	target.cure_nearsighted(list(EYE_DAMAGE))
	target.blur_eyes(35)	//this will fix itself slowly.
	E.setOrganDamage(0)
	return TRUE

/datum/surgery_step/fix_eyes/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(target.getorgan(/obj/item/organ/brain))
		display_results(user, target, "<span class='warning'>Ты случайно протыкаешь мозг [target]!</span>",
			"<span class='warning'>[user] случайно протыкает мозг [target]!</span>",
			"<span class='warning'>[user] случайно протыкает мозг [target]!</span>")
		target.adjustOrganLoss(ORGAN_SLOT_BRAIN, 70)
	else
		display_results(user, target, "<span class='warning'>Ты случайно вонзаешь инструмент прямо туда, где должен быть мозг [target]! Но его там нет.</span>",
			"<span class='warning'>[user] случайно вонзает инструмент прямо туда, где должен быть мозг [target]! Но его там нет.</span>",
			"<span class='warning'>[user] случайно вонзает инструмент в голову [target]!</span>")
	return FALSE
