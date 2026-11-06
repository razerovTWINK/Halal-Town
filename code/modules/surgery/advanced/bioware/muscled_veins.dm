/datum/surgery/advanced/bioware/muscled_veins
	name = "Мышечная оболочка вен"
	desc = ""
	steps = list(/datum/surgery_step/incise,
				/datum/surgery_step/retract_skin,
				/datum/surgery_step/clamp_bleeders,
				/datum/surgery_step/incise,
				/datum/surgery_step/incise,
				/datum/surgery_step/muscled_veins,
				/datum/surgery_step/close)
	possible_locs = list(BODY_ZONE_CHEST)
	bioware_target = BIOWARE_CIRCULATION

/datum/surgery_step/muscled_veins
	name = "сформировать мышцы вен"
	accept_hand = TRUE
	time = 125

/datum/surgery_step/muscled_veins/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>Ты начинаешь оборачивать мышцы вокруг кровеносных сосудов [target].</span>",
		"<span class='notice'>[user] начинает оборачивать мышцы вокруг кровеносных сосудов [target].</span>",
		"<span class='notice'>[user] начинает манипуляции с кровеносной системой [target].</span>")

/datum/surgery_step/muscled_veins/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>Ты перестраиваешь кровеносную систему [target], добавляя мышечную оболочку!</span>",
		"<span class='notice'>[user] перестраивает кровеносную систему [target], добавляя мышечную оболочку!</span>",
		"<span class='notice'>[user] заканчивает манипуляции с кровеносной системой [target].</span>")
	new /datum/bioware/muscled_veins(target)
	return TRUE

/datum/bioware/muscled_veins
	name = "Мускулистые вены"
	desc = ""
	mod_type = BIOWARE_CIRCULATION

/datum/bioware/muscled_veins/on_gain()
	..()
	ADD_TRAIT(owner, TRAIT_STABLEHEART, "muscled_veins")

/datum/bioware/muscled_veins/on_lose()
	..()
	REMOVE_TRAIT(owner, TRAIT_STABLEHEART, "muscled_veins")
