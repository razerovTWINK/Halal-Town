/datum/surgery/advanced/bioware/nerve_grounding
	name = "Заземление нервов"
	desc = ""
	steps = list(/datum/surgery_step/incise,
				/datum/surgery_step/retract_skin,
				/datum/surgery_step/clamp_bleeders,
				/datum/surgery_step/incise,
				/datum/surgery_step/incise,
				/datum/surgery_step/ground_nerves,
				/datum/surgery_step/close)
	possible_locs = list(BODY_ZONE_CHEST)
	bioware_target = BIOWARE_NERVES

/datum/surgery_step/ground_nerves
	name = "заземлить нервы"
	accept_hand = TRUE
	time = 155

/datum/surgery_step/ground_nerves/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>Ты начинаешь перенаправлять нервы [target].</span>",
		"<span class='notice'>[user] начинает перенаправлять нервы [target].</span>",
		"<span class='notice'>[user] начинает манипуляции с нервной системой [target].</span>")

/datum/surgery_step/ground_nerves/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>Тебе удаётся перенаправить нервную систему [target]!</span>",
		"<span class='notice'>[user] успешно перенаправляет нервную систему [target]!</span>",
		"<span class='notice'>[user] заканчивает манипуляции с нервной системой [target].</span>")
	new /datum/bioware/grounded_nerves(target)
	return TRUE

/datum/bioware/grounded_nerves
	name = "Заземлённые нервы"
	desc = ""
	mod_type = BIOWARE_NERVES

/datum/bioware/grounded_nerves/on_gain()
	..()
	ADD_TRAIT(owner, TRAIT_SHOCKIMMUNE, "grounded_nerves")

/datum/bioware/grounded_nerves/on_lose()
	..()
	REMOVE_TRAIT(owner, TRAIT_SHOCKIMMUNE, "grounded_nerves")
