/datum/surgery/advanced/bioware/nerve_splicing
	name = "Сращивание нервов"
	desc = ""
	steps = list(/datum/surgery_step/incise,
				/datum/surgery_step/retract_skin,
				/datum/surgery_step/clamp_bleeders,
				/datum/surgery_step/incise,
				/datum/surgery_step/incise,
				/datum/surgery_step/splice_nerves,
				/datum/surgery_step/close)
	possible_locs = list(BODY_ZONE_CHEST)
	bioware_target = BIOWARE_NERVES

/datum/surgery_step/splice_nerves
	name = "срастить нервы"
	accept_hand = TRUE
	time = 155

/datum/surgery_step/splice_nerves/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>Ты начинаешь сращивать нервы [target].</span>",
		"<span class='notice'>[user] начинает сращивать нервы [target].</span>",
		"<span class='notice'>[user] начинает манипуляции с нервной системой [target].</span>")

/datum/surgery_step/splice_nerves/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>Тебе удаётся срастить нервную систему [target]!</span>",
		"<span class='notice'>[user] успешно сращивает нервную систему [target]!</span>",
		"<span class='notice'>[user] заканчивает манипуляции с нервной системой [target].</span>")
	new /datum/bioware/spliced_nerves(target)
	return TRUE

/datum/bioware/spliced_nerves
	name = "Срощенные нервы"
	desc = ""
	mod_type = BIOWARE_NERVES

/datum/bioware/spliced_nerves/on_gain()
	..()
	owner.physiology.stun_mod *= 0.5

/datum/bioware/spliced_nerves/on_lose()
	..()
	owner.physiology.stun_mod *= 2
