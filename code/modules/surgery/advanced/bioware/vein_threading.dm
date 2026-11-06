/datum/surgery/advanced/bioware/vein_threading
	name = "Армирование вен"
	desc = ""
	steps = list(/datum/surgery_step/incise,
				/datum/surgery_step/retract_skin,
				/datum/surgery_step/clamp_bleeders,
				/datum/surgery_step/incise,
				/datum/surgery_step/incise,
				/datum/surgery_step/thread_veins,
				/datum/surgery_step/close)
	possible_locs = list(BODY_ZONE_CHEST)
	bioware_target = BIOWARE_CIRCULATION

/datum/surgery_step/thread_veins
	name = "армировать вены"
	accept_hand = TRUE
	time = 125

/datum/surgery_step/thread_veins/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>Ты начинаешь укреплять сосуды [target].</span>",
		"<span class='notice'>[user] начинает укреплять сосуды [target].</span>",
		"<span class='notice'>[user] начинает манипуляции с кровеносной системой [target].</span>")

/datum/surgery_step/thread_veins/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>Ты сплетаешь сосуды [target] в прочную сетку!</span>",
		"<span class='notice'>[user] сплетает сосуды [target] в прочную сетку!</span>",
		"<span class='notice'>[user] заканчивает манипуляции с кровеносной системой [target].</span>")
	new /datum/bioware/threaded_veins(target)
	return TRUE

/datum/bioware/threaded_veins
	name = "Армированные вены"
	desc = ""
	mod_type = BIOWARE_CIRCULATION

/datum/bioware/threaded_veins/on_gain()
	..()
	owner.physiology.bleed_mod *= 0.25

/datum/bioware/threaded_veins/on_lose()
	..()
	owner.physiology.bleed_mod *= 4
